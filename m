Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265454AbUGMQMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbUGMQMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 12:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265446AbUGMQMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 12:12:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:27272 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S265431AbUGMQL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 12:11:58 -0400
Subject: Re: serious performance regression due to NX patch
From: Mark Haverkamp <markh@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@osdl.org>,
       Jakub Jelinek <jakub@redhat.com>, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0407122358570.13111@devserv.devel.redhat.com>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
	 <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
	 <20040711123803.GD21264@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0407121315170.1764@ppc970.osdl.org>
	 <16626.62318.880165.774044@napali.hpl.hp.com>
	 <Pine.LNX.4.58.0407122358570.13111@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1089734729.1356.79.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 09:05:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 21:23, Ingo Molnar wrote:
> On Mon, 12 Jul 2004, David Mosberger wrote:
> 
> > So I think it would be better to have a VM_STACK_EXEC_FLAGS macro in an
> > asm header file (with suitable default in asm-generic).
> 
> it's not just about the stack! It's a "is the value of the PROT_EXEC bit
> just an embelishment of /proc output or is it taken seriously" thing. My
> change enforces the X bit for _all_ applications and gives the X bit to
> almost all mappings created by legacy applications:
> 
>  005a1000-005b6000 r-xp 00000000 09:00 1786072  /lib/ld-2.3.3.so
>  005b6000-005b7000 r--p 00014000 09:00 1786072  /lib/ld-2.3.3.so
>  005b7000-005b8000 rwxp 00015000 09:00 1786072  /lib/ld-2.3.3.so
>  005be000-006d3000 r-xp 00000000 09:00 1786073  /lib/tls/libc-2.3.3.so
>  006d3000-006d5000 r--p 00115000 09:00 1786073  /lib/tls/libc-2.3.3.so
>  006d5000-006d7000 rwxp 00117000 09:00 1786073  /lib/tls/libc-2.3.3.so
>  006d7000-006d9000 rwxp 006d7000 00:00 0
>  00da2000-00da3000 r-xp 00da2000 00:00 0
>  01000000-01004000 r-xp 00000000 09:01 13356378 /home/mingo/cat-lowaddr
>  01004000-01005000 rwxp 00003000 09:01 13356378 /home/mingo/cat-lowaddr
>  08590000-085b1000 rwxp 08590000 00:00 0
>  f6e48000-f6e49000 r-xp 00e4b000 09:00 2439993  /usr/lib/locale/locale-archive
>  f6e49000-f6e7b000 r-xp 00dc3000 09:00 2439993  /usr/lib/locale/locale-archive
>  f6e7b000-f707b000 r-xp 00000000 09:00 2439993  /usr/lib/locale/locale-archive
>  f707b000-f707c000 rwxp f707b000 00:00 0
>  fef8a000-ff000000 rwxp fef8a000 00:00 0
>  ffffd000-ffffe000 ---p 00000000 00:00 0
> 
> this way you get what you see. An X mapping is executable, a !X one isnt.  
> No magic "this applications' mappings means this, that application's
> mappings mean that". This also streamlines the kernel side of any NX
> solution added to an arch where applications had executability
> expectations: you can just add the capability because the mappings done
> lie anymore and compatibility is done by following that old expectation
> for old binaries. No hackery with personalities, split decisions in the
> pte handling paths, etc.
> 
> So as you can see in the above maps file, the change impacts the default
> mappings for the stack, heap and mmap()s. The only narrow exeception is
> that if legacy userspace asks for !PROT_EXEC via mprotect() explicitly and
> then expects executability _that_ will be denied (fortunately we havent
> met such a case yet) - but all the other cases will result in executable
> mappings, to preserve compatibility. E.g. there are only two
> non-executable mappings in the above layout, both were created by glibc
> via mprotect() and are fully expected to be non-executable.
> 
> the process stack's executability itself is controlled via the value of
> PT_GNU_STACK - either X or !X. (subsequently any newly loaded shared
> library might also change the process' stack. So if you link against an
> older library without PT_GNU_STACK then the presumption will be the
> compatible one: to have an executable stack. This is not an issue in new
> distros, but might help with using third party libraries.)
> 
> all of this is needed to have a smooth sailing into the NX world.
> 
> 	Ingo

I think that there is  a problem with this piece of code in
binfmt_elf.c:

        if (i == elf_ex.e_phnum)
                def_flags |= VM_EXEC | VM_MAYEXEC;

I've seen that if this code is executed that a mmap with PROT_NONE will
have the x flag set on the page.  because of code in mmap.c for
do_mmp_pgoff:

	vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags) |
			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;

or possibly here in do_brk:

	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;


the mm->def_flags have VM_EXEC and VM_MAYEXEC which means they are set all the time.

Mark.

-- 
Mark Haverkamp <markh@osdl.org>

