Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbTICWqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTICWqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:46:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:52907 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264239AbTICWpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:45:30 -0400
Date: Wed, 3 Sep 2003 15:41:14 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Mathieu LESNIAK <maverick@eskuel.com>
cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       <ebrunet@quatramaran.ens.fr>, LKML <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
Subject: Re: Power Management Update
In-Reply-To: <3F55B738.4070200@eskuel.com>
Message-ID: <Pine.LNX.4.33.0309031522200.944-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've tested the patch you submitted for ide-io.c (I've tested it in 
> test4-mm5).
> It solves the ide-cd problem, and the suspend process get to next step. 
> It frees memory. However, just after that, the system get in a loop 
> displaying "Bad: scheduling while atomic". I'm not able to capture the 
> output of this, the laptop only responding to syrq.
> Hope it helps you.

Definitely. I take it you have preempt enabled, right? 

Below is a patch that should fix the problem. The problem was due to the
fact that I removed the kernel_fpu_end() call from
kernel/power/swsusp.c::swsusp_suspend(). kernel_fpu_end() disables
preempt, which causes any subsequent schedule() to trigger that BUG(). I
apologize for this regression.

The patch needs a bit more explanation, because I didn't simply replace 
the call. Doing so would be a layering violation of the structure of the 
code. kernel_fpu_end() is called by save_processor_state(), which is 
called by swsusp_arch_suspend(). We should be calling it from the same 
chain, and we shouldn't be calling a function from generic code that is 
defined on only two architectures. 

I modified swsusp_arch_suspend() to unconditionally call
restore_processor_state() when exiting, which provides the same layering. 
However, it is still too late WRT to the other things that 
swsusp_suspend() was doing (resuming drivers and writing the image). 

Since those are unrelated to snapshotting memory, I divorced them from the 
function. swsusp_save() now is the function that is responsible for 
snapshoting memory, while swsusp_write() is responsible for writing the 
image, only. 

The resulting code is cleaner and more streamlined. It behaves as
predicted locally. Please try it and report whether or not it works for 
you. 

Andrew, please apply this to -test4-mm5. I realize I said I would not
touch swsusp any more, and this patch may become irrelevant in the future. 
But, it fixes a real bug now. 

Thanks,


	Pat


===== arch/i386/power/swsusp.S 1.9 vs edited =====
--- 1.9/arch/i386/power/swsusp.S	Fri Aug 22 16:08:57 2003
+++ edited/arch/i386/power/swsusp.S	Wed Sep  3 15:23:20 2003
@@ -76,10 +76,10 @@
 	movl saved_context_edx, %edx
 	movl saved_context_esi, %esi
 	movl saved_context_edi, %edi
-	call restore_processor_state
 	pushl saved_context_eflags ; popfl
 	call swsusp_resume
 .L1449:
+	call restore_processor_state
 	popl %ebx
 	ret
 
===== kernel/power/disk.c 1.2 vs edited =====
--- 1.2/kernel/power/disk.c	Tue Aug 26 12:25:46 2003
+++ edited/kernel/power/disk.c	Wed Sep  3 15:20:10 2003
@@ -163,27 +163,27 @@
 
 	pr_debug("PM: snapshotting memory.\n");
 	in_suspend = 1;
-	local_irq_disable();
 	if ((error = swsusp_save()))
 		goto Done;
 
-	pr_debug("PM: writing image.\n");
+	if (in_suspend) {
+		pr_debug("PM: writing image.\n");
 
-	/* 
-	 * FIXME: Leftover from swsusp. Are they necessary? 
-	 */
-	mb();
-	barrier();
-
-	error = swsusp_write();
-	if (!error && in_suspend) {
-		error = power_down(pm_disk_mode);
-		pr_debug("PM: Power down failed.\n");
+		/* 
+		 * FIXME: Leftover from swsusp. Are they necessary? 
+		 */
+		mb();
+		barrier();
+
+		error = swsusp_write();
+		if (!error) {
+			error = power_down(pm_disk_mode);
+			pr_debug("PM: Power down failed.\n");
+		}
 	} else
 		pr_debug("PM: Image restored successfully.\n");
 	swsusp_free();
  Done:
-	local_irq_enable();
 	finish();
 	return error;
 }
@@ -217,7 +217,6 @@
 
 	barrier();
 	mb();
-	local_irq_disable();
 
 	/* FIXME: The following (comment and mdelay()) are from swsusp. 
 	 * Are they really necessary? 
@@ -231,7 +230,6 @@
 
 	pr_debug("PM: Restoring saved image.\n");
 	swsusp_restore();
-	local_irq_enable();
 	pr_debug("PM: Restore failed, recovering.n");
 	finish();
  Free:
===== kernel/power/swsusp.c 1.62 vs edited =====
--- 1.62/kernel/power/swsusp.c	Sat Aug 30 13:23:28 2003
+++ edited/kernel/power/swsusp.c	Wed Sep  3 15:23:35 2003
@@ -416,11 +416,12 @@
 }
 
 
-static int suspend_prepare_image(void)
+int swsusp_suspend(void)
 {
 	struct sysinfo i;
 	unsigned int nr_needed_pages = 0;
 
+	read_swapfiles();
 	drain_local_pages();
 
 	pagedir_nosave = NULL;
@@ -486,12 +487,10 @@
 static int suspend_save_image(void)
 {
 	int error;
-	local_irq_enable();
 	device_resume();
 	lock_swapdevices();
 	error = write_suspend_image();
 	lock_swapdevices();
-	local_irq_disable();
 	return error;
 }
 
@@ -515,35 +514,16 @@
 	if (!resume) {
 		save_processor_state();
 		SAVE_REGISTERS
-		swsusp_suspend();
-		return;
+		return swsusp_suspend();
 	}
 	GO_TO_SWAPPER_PAGE_TABLES
 	COPY_PAGES_BACK
 	RESTORE_REGISTERS
 	restore_processor_state();
-	swsusp_resume();
-
+	return swsusp_resume();
  */
 
 
-int swsusp_suspend(void)
-{
-	int error;
-	read_swapfiles();
-	error = suspend_prepare_image();
-	if (!error)
-		error = suspend_save_image();
-	if (error) {
-		printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", 
-		       name_suspend);
-		barrier();
-		mb();
-		mdelay(1000);
-	}
-	return error;
-}
-
 /* More restore stuff */
 
 /* FIXME: Why not memcpy(to, from, 1<<pagedir_order*PAGE_SIZE)? */
@@ -870,11 +850,19 @@
 
 int swsusp_save(void) 
 {
+	int error;
+
 #if defined (CONFIG_HIGHMEM) || defined (COFNIG_DISCONTIGMEM)
 	printk("swsusp is not supported with high- or discontig-mem.\n");
 	return -EPERM;
 #endif
-	return arch_prepare_suspend();
+	if ((error = arch_prepare_suspend()))
+		return error;
+	
+	local_irq_disable();
+	error = swsusp_arch_suspend(0);
+	local_irq_enable();
+	return error;
 }
 
 
@@ -890,7 +878,7 @@
 
 int swsusp_write(void)
 {
-	return swsusp_arch_suspend(0);
+	return suspend_save_image();
 }
 
 
@@ -933,7 +921,11 @@
 
 int __init swsusp_restore(void)
 {
-	return swsusp_arch_suspend(1);
+	int error;
+	local_irq_disable();
+	error = swsusp_arch_suspend(1);
+	local_irq_enable();
+	return error;
 }
 
 

