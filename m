Return-Path: <linux-kernel-owner+w=401wt.eu-S1161008AbWLUMd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWLUMd4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 07:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWLUMd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 07:33:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47045 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161008AbWLUMdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 07:33:55 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: Jean Delvare <khali@linux-fr.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
References: <20061220141808.e4b8c0ea.khali@linux-fr.org>
	<m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
	<20061220214340.f6b037b1.khali@linux-fr.org>
	<m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com>
	<20061221101240.f7e8f107.khali@linux-fr.org>
	<20061221102232.5a10bece.khali@linux-fr.org>
	<m164c5pmim.fsf@ebiederm.dsl.xmission.com>
	<20061221010814.GA30299@in.ibm.com>
Date: Thu, 21 Dec 2006 05:32:56 -0700
In-Reply-To: <20061221010814.GA30299@in.ibm.com> (Vivek Goyal's message of
	"Thu, 21 Dec 2006 06:38:14 +0530")
Message-ID: <m1vek5o2dj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Thu, Dec 21, 2006 at 03:32:33AM -0700, Eric W. Biederman wrote:
>> Jean Delvare <khali@linux-fr.org> writes:
>> 
>> > On Thu, 21 Dec 2006 10:12:40 +0100, Jean Delvare wrote:
>> >> On Wed, 20 Dec 2006 15:22:20 -0700, Eric W. Biederman wrote:
>> >> > Ok.  Here is a small diff that inserts the infinite loops, between
>> >> > each section of code in head.S  Procedurally please trying booting
>> >> > this unmodified and see if it boots, then remove the infinite loop
>> >> > until you come to the one where the system reboots instead of hangs.
>> >> >
>> >> > That should at least give me a good idea of where to look.
>> >> > If 20 hangs and 21 still reboots we are into misc.c and the
>> >> > decompressor.  And I will have to ask something different.
>> >>
>> >> OK, I'll start the tests now, I'll let you know the outcome when I'm
>> >> done.
>> >
>> > Hm, that was quick... Even with your unmodified patch, the machine
>> > still reboots. Does that make any sense to you?
>> >
>> > I can try installing a more recent system on the same hardware if it
>> > helps.
>> 
>> Grr.  I guessed the problem was to late in the game it seems the problem
>> is in setup.S  Before we switch to 32bit mode.
>> 
>> Ok.  There is almost enough for inference but here is a patch of stops
>> for setup.S let's see if one of those will stop the reboots.
>> 
>> I have a strong feeling that we are going to find a tool chain issue,
>> but I'd like to find where we ware having problems before we declare
>> that to be the case.
>> 
>
> Looks like it might be a tool chain issue. I took Jean's config file and
> built my own kernel and I am able to boot the kernel. But I can't boot
> his bzImage. I observed the same behaviour as jean is experiencing. It jumps
> back to BIOS.
>
> I am using grub 0.97. So any dependency on lilo can be ruled out in this
> case.
>
> Following is my software environment.
>
> gcc version 4.1.1 20061130 (Red Hat 4.1.1-43)
> GNU ld version 2.17.50.0.6-2.el5 20061020
>
> I got Intel Xeon machine.
>
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 4
> model name      : Intel(R) Xeon(TM) CPU 3.40GHz
> stepping        : 3
> cpu MHz         : 3400.483
> cache size      : 2048 KB
> physical id     : 0
> siblings        : 2
> core id         : 0
> cpu cores       : 1
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 5
> wp              : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36
> clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc pni monitor
> ds_cpl est cid cx16 xtpr
> bogomips        : 6805.59
> clflush size    : 64

Take a look at the diff for commit 968de4f02621db35b8ae5239c8cfc6664fb872d8
of setup.S there are very few candidate instructions.

I suspect with a few minutes of review we should be able to see what the
assembler is doing wrong and decide if we want to blacklist that assembler
or work around it's bug.

diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
index 3aec453..9aa8b05 100644
--- a/arch/i386/boot/setup.S
+++ b/arch/i386/boot/setup.S
@@ -588,11 +588,6 @@ rmodeswtch_normal:
        call    default_switch
 
 rmodeswtch_end:
-# we get the code32 start address and modify the below 'jmpi'
-# (loader may have changed it)
-       movl    %cs:code32_start, %eax
-       movl    %eax, %cs:code32
-
 # Now we move the system to its rightful place ... but we check if we have a
 # big-kernel. In that case we *must* not move it ...
        testb   $LOADED_HIGH, %cs:loadflags
@@ -788,11 +783,12 @@ a20_err_msg:
 a20_done:
 
 #endif /* CONFIG_X86_VOYAGER */
-# set up gdt and idt
+# set up gdt and idt and 32bit start address
        lidt    idt_48                          # load idt with 0,0
        xorl    %eax, %eax                      # Compute gdt_base
        movw    %ds, %ax                        # (Convert %ds:gdt to a linear ptr)
        shll    $4, %eax
+       addl    %eax, code32
        addl    $gdt, %eax
        movl    %eax, (gdt_48+2)
        lgdt    gdt_48                          # load gdt with whatever is
@@ -851,9 +847,26 @@ flush_instr:
 #      Manual, Mixing 16-bit and 32-bit code, page 16-6)
 
        .byte 0x66, 0xea                        # prefix + jmpi-opcode
-code32:        .long   0x1000                          # will be set to 0x100000
-                                               # for big kernels
+code32:        .long   startup_32                      # will be set to %cs+startup_32
        .word   __BOOT_CS
+.code32
+startup_32:
+       movl $(__BOOT_DS), %eax
+       movl %eax, %ds
+       movl %eax, %es
+       movl %eax, %fs
+       movl %eax, %gs
+       movl %eax, %ss
+
+       xorl %eax, %eax
+1:     incl %eax                               # check that A20 really IS enabled
+       movl %eax, 0x00000000                   # loop forever if it isn't
+       cmpl %eax, 0x00100000
+       je 1b
+
+       # Jump to the 32bit entry point
+       jmpl *(code32_start - start + (DELTA_INITSEG << 4))(%esi)
+.code16
 
 # Here's a bunch of information about your current kernel..
 kernel_version:        .ascii  UTS_RELEASE

