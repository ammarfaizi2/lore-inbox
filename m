Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbUL0JhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbUL0JhV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 04:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUL0JhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 04:37:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:63956 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261365AbUL0JhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 04:37:04 -0500
Date: Mon, 27 Dec 2004 01:36:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bernard Blackham <bernard@blackham.com.au>
Cc: mingo@elte.hu, ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched-fix-scheduling-latencies-in-mttrc reenables
 interrupts
Message-Id: <20041227013653.67965d46.akpm@osdl.org>
In-Reply-To: <20041227062828.GE7415@blackham.com.au>
References: <20041227062828.GE7415@blackham.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernard Blackham <bernard@blackham.com.au> wrote:
>
> The patch sched-fix-scheduling-latencies-in-mttr in recent -mm
>  kernels has the bad side-effect of re-enabling interrupts even if
>  they were disabled. This caused bugs in Software Suspend 2 which
>  reenabled MTRRs whilst interrupts were already disabled.

OK.

>  Attached is a replacement patch which uses spin_lock_irqsave instead
>  of spin_lock_irq.

>  +static unsigned long sal_flags;
>   
>   static void prepare_set(void)
>   {
>  @@ -240,11 +241,14 @@ static void prepare_set(void)
>   	/*  Note that this is not ideal, since the cache is only flushed/disabled
>   	   for this CPU while the MTRRs are changed, but changing this requires
>   	   more invasive changes to the way the kernel boots  */
>  -	spin_lock(&set_atomicity_lock);
>  +	/*
>  +	 * Since we are disabling the cache dont allow any interrupts - they
>  +	 * would run extremely slow and would only increase the pain:
>  +	 */
>  +	spin_lock_irqsave(&set_atomicity_lock, sal_flags);

Not OK.  That global `sal_flags' is not protected by the spinlock because
spin_lock_irqsave() saves the flags before taking the lock.

How about this?


diff -puN arch/i386/kernel/cpu/mtrr/generic.c~sched-fix-scheduling-latencies-in-mttrc-reenables-interrupts arch/i386/kernel/cpu/mtrr/generic.c
--- 25/arch/i386/kernel/cpu/mtrr/generic.c~sched-fix-scheduling-latencies-in-mttrc-reenables-interrupts	2004-12-27 01:31:41.718983736 -0800
+++ 25-akpm/arch/i386/kernel/cpu/mtrr/generic.c	2004-12-27 01:34:15.180654016 -0800
@@ -233,6 +233,13 @@ static unsigned long cr4 = 0;
 static u32 deftype_lo, deftype_hi;
 static spinlock_t set_atomicity_lock = SPIN_LOCK_UNLOCKED;
 
+/*
+ * Since we are disabling the cache don't allow any interrupts - they
+ * would run extremely slow and would only increase the pain.  The caller must
+ * ensure that local interrupts are disabled and are reenabled after post_set()
+ * has been called.
+ */
+
 static void prepare_set(void)
 {
 	unsigned long cr0;
@@ -240,11 +247,8 @@ static void prepare_set(void)
 	/*  Note that this is not ideal, since the cache is only flushed/disabled
 	   for this CPU while the MTRRs are changed, but changing this requires
 	   more invasive changes to the way the kernel boots  */
-	/*
-	 * Since we are disabling the cache dont allow any interrupts - they
-	 * would run extremely slow and would only increase the pain:
-	 */
-	spin_lock_irq(&set_atomicity_lock);
+
+	spin_lock(&set_atomicity_lock);
 
 	/*  Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
 	cr0 = read_cr0() | 0x40000000;	/* set CD flag */
@@ -281,19 +285,22 @@ static void post_set(void)
 	/*  Restore value of CR4  */
 	if ( cpu_has_pge )
 		write_cr4(cr4);
-	spin_unlock_irq(&set_atomicity_lock);
+	spin_unlock(&set_atomicity_lock);
 }
 
 static void generic_set_all(void)
 {
 	unsigned long mask, count;
+	unsigned long flags;
 
+	local_irq_save(flags);
 	prepare_set();
 
 	/* Actually set the state */
 	mask = set_mtrr_state(deftype_lo,deftype_hi);
 
 	post_set();
+	local_irq_restore(flags);
 
 	/*  Use the atomic bitops to update the global mask  */
 	for (count = 0; count < sizeof mask * 8; ++count) {
@@ -316,6 +323,9 @@ static void generic_set_mtrr(unsigned in
     [RETURNS] Nothing.
 */
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
 	prepare_set();
 
 	if (size == 0) {
@@ -330,6 +340,7 @@ static void generic_set_mtrr(unsigned in
 	}
 
 	post_set();
+	local_irq_restore(flags);
 }
 
 int generic_validate_add_page(unsigned long base, unsigned long size, unsigned int type)
_

