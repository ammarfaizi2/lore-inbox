Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268544AbUJPScb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268544AbUJPScb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 14:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268681AbUJPScb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 14:32:31 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:36803 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268544AbUJPScW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 14:32:22 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.9-rc4: missing patches for swsusp
Date: Sat, 16 Oct 2004 20:34:00 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YmWcBhpU0s7BLF4"
Message-Id: <200410162034.00516.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_YmWcBhpU0s7BLF4
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

AFAICT, the two attached Pavel's patches are missing from 2.6.9-rc4.  Please 
consider including them into the final 2.6.9, especially 
x86-64-do-not-use-memory-in-copy-loop.patch which seems to be necessary to 
prevent random crashes on AMD64.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_YmWcBhpU0s7BLF4
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="x86-64-do-not-use-memory-in-copy-loop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="x86-64-do-not-use-memory-in-copy-loop.patch"

Hi!

In assembly code, there are some problems with "nosave" section
(linker was doing something stupid, like duplicating the section). We
attempted to fix it, but fix was worse then first problem. This fixes
is for good: We no longer use any memory in the copy loop. (Plus it
fixes indentation and uses meaningfull labels.)

Patch is against 2.6.9-rc3. -mm has sligtly different version, with
more text on ".section .data.nosave" line. Those lines should really
be removed.
								Pavel

--- clean/arch/x86_64/kernel/suspend_asm.S	2004-10-01 00:30:08.000000000 +0200
+++ linux/arch/x86_64/kernel/suspend_asm.S	2004-10-02 18:35:04.000000000 +0200
@@ -39,29 +39,28 @@
 	/* set up cr3 */	
 	leaq	init_level4_pgt(%rip),%rax
 	subq	$__START_KERNEL_map,%rax
-	movq %rax,%cr3
+	movq	%rax,%cr3
 
 	movq	mmu_cr4_features(%rip), %rax
 	movq	%rax, %rdx
-	
 	andq	$~(1<<7), %rdx	# PGE
-	movq %rdx, %cr4;  # turn off PGE     
-	movq %cr3, %rcx;  # flush TLB        
-	movq %rcx, %cr3;                     
-	movq %rax, %cr4;  # turn PGE back on 
+	movq	%rdx, %cr4;  # turn off PGE     
+	movq	%cr3, %rcx;  # flush TLB        
+	movq	%rcx, %cr3;                     
+	movq	%rax, %cr4;  # turn PGE back on 
 
 	movl	nr_copy_pages(%rip), %eax
 	xorl	%ecx, %ecx
-	movq	$0, loop(%rip)
+	movq	$0, %r10
 	testl	%eax, %eax
-	je	.L108
+	jz	done
 .L105:
 	xorl	%esi, %esi
-	movq	$0, loop2(%rip)
+	movq	$0, %r11
 	jmp	.L104
 	.p2align 4,,7
-.L111:
-	movq	loop(%rip), %rcx
+copy_one_page:
+	movq	%r10, %rcx
 .L104:
 	movq	pagedir_nosave(%rip), %rdx
 	movq	%rcx, %rax
@@ -71,27 +70,26 @@
 	movzbl	(%rsi,%rax), %eax
 	movb	%al, (%rsi,%rcx)
 
-	movq %cr3, %rax;  # flush TLB 
-	movq %rax, %cr3;              
+	movq	%cr3, %rax;  # flush TLB 
+	movq	%rax, %cr3;              
 
-	movq	loop2(%rip), %rax
+	movq	%r11, %rax
 	incq	%rax
 	cmpq	$4095, %rax
 	movq	%rax, %rsi
-	movq	%rax, loop2(%rip)
-	jbe	.L111
-	movq	loop(%rip), %rax
+	movq	%rax, %r11
+	jbe	copy_one_page
+	movq	%r10, %rax
 	incq	%rax
 	movq	%rax, %rcx
-	movq	%rax, loop(%rip)
+	movq	%rax, %r10
 	mov	nr_copy_pages(%rip), %eax
 	cmpq	%rax, %rcx
 	jb	.L105
-.L108:
-	.align 4
+done:
 	movl	$24, %eax
-
-	movl %eax, %ds
+	movl	%eax, %ds
+	
 	movq saved_context_esp(%rip), %rsp
 	movq saved_context_ebp(%rip), %rbp
 	movq saved_context_eax(%rip), %rax
@@ -111,10 +109,3 @@
 	pushq saved_context_eflags(%rip) ; popfq
 	call	swsusp_restore
 	ret
-
-	.section .data.nosave
-loop:
-	.quad 0
-loop2:	
-	.quad 0		
-	.previous


-- 

--Boundary-00=_YmWcBhpU0s7BLF4
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="fix-process-start-times-after-resume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix-process-start-times-after-resume.patch"

Hi!

Currently, process start times change after swsusp (because they are
derived from jiffies and current time, oops). This should fix
it. Please apply,

								Pavel

Index: linux/arch/i386/kernel/time.c
===================================================================
--- linux.orig/arch/i386/kernel/time.c	2004-10-01 12:24:26.000000000 +0200
+++ linux/arch/i386/kernel/time.c	2004-10-01 00:53:07.000000000 +0200
@@ -319,7 +319,7 @@
 	return retval;
 }
 
-static long clock_cmos_diff;
+static long clock_cmos_diff, sleep_start;
 
 static int time_suspend(struct sys_device *dev, u32 state)
 {
@@ -328,6 +328,7 @@
 	 */
 	clock_cmos_diff = -get_cmos_time();
 	clock_cmos_diff += get_seconds();
+	sleep_start = get_cmos_time();
 	return 0;
 }
 
@@ -335,10 +336,13 @@
 {
 	unsigned long flags;
 	unsigned long sec = get_cmos_time() + clock_cmos_diff;
+	unsigned long sleep_length = get_cmos_time() - sleep_start;
+
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
+	jiffies += sleep_length * HZ;
 	return 0;
 }
 
 
-- 

--Boundary-00=_YmWcBhpU0s7BLF4--
