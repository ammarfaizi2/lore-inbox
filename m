Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263499AbTDSXta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 19:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263501AbTDSXta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 19:49:30 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:60393 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263499AbTDSXt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 19:49:28 -0400
Date: Sun, 20 Apr 2003 01:00:51 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030420000051.GA20130@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com> <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net> <20030415154355.08ef6672.akpm@digeo.com> <20030416004556.GD29143@iucha.net> <1050493328.28591.42.camel@dhcp22.swansea.linux.org.uk> <20030416131536.GF29143@iucha.net> <20030416135819.GB18358@suse.de> <20030418152824.GJ29143@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030418152824.GJ29143@iucha.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 10:28:24AM -0500, Florin Iucha wrote:
 > 
 > With 2.5.67-bk8, agpgart and sis-agp compiled as modules and loaded:
 >    - X starts (I am using wdm as display manager)
 >    - direct rendering is enabled, according to /var/log/XFree86.0.log
 >    - start glxgears
 >    - framerate 130!!! It should be around 1900-2000 on my hardware
 >      (moons ago on XFree 4.2.1 + DRI snapshot)

Very strange. Does glxinfo output look sane too? Especially the
OpenGL renderer string. It sounds like it isn't doing hw rendering
even if your X log says it is..

 >    - after 15-20 seconds, the X session is restarted - back to wdm
 >      screen
 >    - I login, I logout and the machine freeze
 >    - the last words on serial console:
 >       [drm] Loading R200 Microcode
 >       double fault, gdt at c039df00 [255 bytes]
 >       double fault, tss at c0418800
 >       eip = c0143a00, esp = ececbf0c
 >       eax = ee37dc60, ebx = ee37dc40, ecx = 0000007b, edx = 00000000
 >       esi = ee37dc60, edi = edc0e0c0

Not good at all. 'bad shit happened'.

 > With 2.5.67-bk8, agpgart and sis-agp built in:
 >    - no lockups

It's essentially the same code though, which doesn't
make a lot of sense.

 >    - direct rendering is disabled

Again, puzzling. What reason is given for this in your
XFree86.log ?

 >    - X crashes sometimes with the following traces:
 > agpgart: Found an AGP 2.0 compliant device.
 > agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
 > agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
 > [drm] Loading R200 Microcode
 > agpgart: Found an AGP 2.0 compliant device.
 > agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
 > agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
 > [drm] Loading R200 Microcode

The fact that this lot appears twice is odd, or did you
restart the X server ?

 > Unable to handle kernel paging request at virtual address fffffff0
 >  printing eip:
 > c0146147
 > *pde = 00001067
 > *pte = 00000000
 > Oops: 0000 [#1]
 > CPU:    0
 > EIP:    0060:[<c0146147>]    Not tainted
 > EFLAGS: 00013286
 > EIP is at page_remove_rmap+0xb7/0x130
 > eax: ffffffff   ebx: c14acc48   ecx: 0000000f   edx: fffffff0
 > esi: dcd5ffc0   edi: ffffffff   ebp: fffffff0   esp: da333b60
 > ds: 007b   es: 007b   ss: 0068
 > Process XFree86 (pid: 657, threadinfo=da332000 task=de0ced00)
 > Stack: dcb72cc0 dcd5ffc0 da403a18 da403a18 0006e000 00100000 c14acc48 c0140495 
 >        c14acc48 da332000 da332000 00000000 1deb5045 dc8b5084 08618000 08318000 
 >        c0465758 c014053b c0465758 dc8b5080 08218000 00100000 08218000 dc8b5084 
 > Call Trace:
 >  [<c0140495>] zap_pte_range+0x155/0x1b0
 >  [<c014053b>] zap_pmd_range+0x4b/0x70
 >  [<c01405a3>] unmap_page_range+0x43/0x70
 >  [<c0140694>] unmap_vmas+0xc4/0x220
 >  [<c01444cb>] exit_mmap+0x7b/0x190
 >  [<c011bc44>] mmput+0x54/0xb0
 >  [<c0159203>] exec_mmap+0xb3/0x130
 >  [<c0159309>] flush_old_exec+0x19/0x850
 >  [<c0159140>] kernel_read+0x50/0x60
 >  [<c0175525>] load_elf_binary+0x2d5/0xb50
 >  [<c01651e2>] dput+0x22/0x1e0
 >  [<c021a187>] linvfs_readv+0x47/0x50
 >  [<c0175250>] load_elf_binary+0x0/0xb50
 >  [<c0159e7a>] search_binary_handler+0x8a/0x1d0
 >  [<c015a1d1>] do_execve+0x211/0x260
 >  [<c01093e0>] sys_execve+0x50/0x80
 >  [<c010ab77>] syscall_call+0x7/0xb

So X tried to load a module (likely the DRI part), and in doing so
something went awry.
Could be that something else caused memory corruption beforehand,
but that's speculation.  If this always happens the second time
the server starts, it could be a problem with reentrancy of the
r200 dri module maybe. *shrug*.

Frankly, from this backtrace, I've no idea.
There are a bunch of radeon fixes pending in the DRI tree,
so things could suddenly 'start working' again, so this could
be one to keep an eye on in bugzilla for now so we don't forget about it.

		Dave

		Dave

