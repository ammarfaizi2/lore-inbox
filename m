Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265534AbUGMQvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265534AbUGMQvX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 12:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbUGMQvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 12:51:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:38628 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265500AbUGMQue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 12:50:34 -0400
Subject: Re: serious performance regression due to NX patch
From: Daniel McNeil <daniel@osdl.org>
To: Mark Haverkamp <markh@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, davidm@hpl.hp.com,
       Linus Torvalds <torvalds@osdl.org>, Jakub Jelinek <jakub@redhat.com>,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1089734729.1356.79.camel@markh1.pdx.osdl.net>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
	 <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
	 <20040711123803.GD21264@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0407121315170.1764@ppc970.osdl.org>
	 <16626.62318.880165.774044@napali.hpl.hp.com>
	 <Pine.LNX.4.58.0407122358570.13111@devserv.devel.redhat.com>
	 <1089734729.1356.79.camel@markh1.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1089737382.2600.60.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 09:49:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 09:05, Mark Haverkamp wrote:
> I think that there is  a problem with this piece of code in
> binfmt_elf.c:
> 
>         if (i == elf_ex.e_phnum)
>                 def_flags |= VM_EXEC | VM_MAYEXEC;
> 
> I've seen that if this code is executed that a mmap with PROT_NONE will
> have the x flag set on the page.  because of code in mmap.c for
> do_mmp_pgoff:
> 
> 	vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags) |
> 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
> 
> or possibly here in do_brk:
> 
> 	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
> 
> 
> the mm->def_flags have VM_EXEC and VM_MAYEXEC which means they are set all the time.
> 
> Mark.

This was my email to Andrew yesterday that did not seem
to make it to LKML (probably because I attached some elf
binaries -- I made them links now).  The below program shows
the old binaries without the PT_GNU_STACK do not get PROT_NONE
mmaps. See info below.

Daniel

On Fri, 2004-07-09 at 23:45, Andrew Morton wrote:

> #include <unistd.h>
> #include <errno.h>
> #include <sys/mman.h>
> 
> 
> main()
> {
>       char *p0 = 0;
>       char *p1 = (char *)-1;
>       char *p2;
>       int err;
> 
>       p2 = mmap(0, 4096, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
> 
>       printf("p2=%p\n", p2);
>       printf("pid=%d\n", getpid());
> 
>       getchar();
> 
>       errno = 0;
>       err = access(p0, R_OK);
>       printf("access 0 ptr %p return code %d errno %d\n", p0, err,
errno);
>       perror("access result:");
>       errno = 0;
>       err = access(p1, R_OK);
>       printf("access 1 ptr %p return code %d errno %d\n", p1, err,
errno);
>       perror("access result:");
>       errno = 0;
>       err = access(p2, R_OK);
>       printf("access 2 ptr %p return code %d errno %d\n", p2, err,
errno);
>       perror("access result:");
> }
> 
> vmm:/home/akpm> ./x
> p2=0x40000000
> pid=2038
> 
> access 0 ptr (nil) return code -1 errno 14
> access result:: Bad address
> access 1 ptr 0xffffffff return code -1 errno 14
> access result:: Bad address
> access 2 ptr 0x40000000 return code -1 errno 14
> access result:: Bad address
> 
> I get this result on both p4 xeon and p3 xeon.



It is the elf file that makes the difference. I was using
gcc 3.2.2 and ld (GNU ld version 2.13.90.0.18 20030206).
This produces elf binary without the PT_GNU_STACK program
section (from objdump -p x.gcc322)

Program Header:
    PHDR off    0x00000034 vaddr 0x08048034 paddr 0x08048034 align 2**2
         filesz 0x000000c0 memsz 0x000000c0 flags r-x
  INTERP off    0x000000f4 vaddr 0x080480f4 paddr 0x080480f4 align 2**0
         filesz 0x00000013 memsz 0x00000013 flags r--
    LOAD off    0x00000000 vaddr 0x08048000 paddr 0x08048000 align 2**12
         filesz 0x00000750 memsz 0x00000750 flags r-x
    LOAD off    0x00000750 vaddr 0x08049750 paddr 0x08049750 align 2**12
         filesz 0x00000118 memsz 0x0000011c flags rw-
 DYNAMIC off    0x0000075c vaddr 0x0804975c paddr 0x0804975c align 2**2
         filesz 0x000000c8 memsz 0x000000c8 flags rw-
    NOTE off    0x00000108 vaddr 0x08048108 paddr 0x08048108 align 2**2
         filesz 0x00000020 memsz 0x00000020 flags r--

With gcc 3.4.1 and GNU ld version 2.14.90.0.6 20030820 and
compile with cc -o x.rw -z noexecstack x.c produces a 
elf binary without execute permission on the stack.
(from objdump -p x.rw)

Program Header:
    PHDR off    0x00000034 vaddr 0x08048034 paddr 0x08048034 align 2**2
         filesz 0x000000e0 memsz 0x000000e0 flags r-x
  INTERP off    0x00000114 vaddr 0x08048114 paddr 0x08048114 align 2**0
         filesz 0x00000013 memsz 0x00000013 flags r--
    LOAD off    0x00000000 vaddr 0x08048000 paddr 0x08048000 align 2**12
         filesz 0x00000735 memsz 0x00000735 flags r-x
    LOAD off    0x00000738 vaddr 0x08049738 paddr 0x08049738 align 2**12
         filesz 0x0000011c memsz 0x00000120 flags rw-
 DYNAMIC off    0x00000748 vaddr 0x08049748 paddr 0x08049748 align 2**2
         filesz 0x000000c8 memsz 0x000000c8 flags rw-
    NOTE off    0x00000128 vaddr 0x08048128 paddr 0x08048128 align 2**2
         filesz 0x00000020 memsz 0x00000020 flags r--
   STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**2
         filesz 0x00000000 memsz 0x00000000 flags rw-

With gcc 3.4.1 and GNU ld version 2.14.90.0.6 20030820 and
compiled with cc -o x.rwx -z execstack x.c.  This produces
the same binary as with out the "-z execstack".

Program Header:
    PHDR off    0x00000034 vaddr 0x08048034 paddr 0x08048034 align 2**2
         filesz 0x000000e0 memsz 0x000000e0 flags r-x
  INTERP off    0x00000114 vaddr 0x08048114 paddr 0x08048114 align 2**0
         filesz 0x00000013 memsz 0x00000013 flags r--
    LOAD off    0x00000000 vaddr 0x08048000 paddr 0x08048000 align 2**12
         filesz 0x00000735 memsz 0x00000735 flags r-x
    LOAD off    0x00000738 vaddr 0x08049738 paddr 0x08049738 align 2**12
         filesz 0x0000011c memsz 0x00000120 flags rw-
 DYNAMIC off    0x00000748 vaddr 0x08049748 paddr 0x08049748 align 2**2
         filesz 0x000000c8 memsz 0x000000c8 flags rw-
    NOTE off    0x00000128 vaddr 0x08048128 paddr 0x08048128 align 2**2
         filesz 0x00000020 memsz 0x00000020 flags r--
0x6474e551 off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**2
         filesz 0x00000000 memsz 0x00000000 flags rwx

Here's the corresponding /proc/pid/maps output from the
3 different binaries:


x.gcc322:	40013000-40014000 --xp 40013000 00:00 0
x.rw:		40013000-40014000 ---p 40013000 00:00 0
x.rwx:		40013000-40014000 ---p 40013000 00:00 0


So binaries compiled with an old compiler are not being
handled correctly with the nx-update.patch changes.

In load_elf_binary()

        for (i = 0; i < elf_ex.e_phnum; i++, elf_ppnt++)
                if (elf_ppnt->p_type == PT_GNU_STACK) {
                        if (elf_ppnt->p_flags & PF_X)
                                executable_stack = EXSTACK_ENABLE_X;
                        else
                                executable_stack = EXSTACK_DISABLE_X;
                        break;
                }
        if (i == elf_ex.e_phnum)
                def_flags |= VM_EXEC | VM_MAYEXEC;

This setting of def_flags if the PT_GNU_STACK is NOT found
is causing the old binaries to get exec on PROT_NONE mmaps.

The 3 elf binaries can be found here:
http://developer.osdl.org/daniel/mmap.PROT_NONE.bug/

Daniel

