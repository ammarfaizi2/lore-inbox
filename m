Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbUL0G2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUL0G2i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 01:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUL0G2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 01:28:38 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:16818 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S261753AbUL0G2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 01:28:34 -0500
Date: Mon, 27 Dec 2004 14:28:29 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: mingo@elte.hu, akpm@osdl.org
Cc: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sched-fix-scheduling-latencies-in-mttrc reenables interrupts
Message-ID: <20041227062828.GE7415@blackham.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ingo & Andrew,

The patch sched-fix-scheduling-latencies-in-mttr in recent -mm
kernels has the bad side-effect of re-enabling interrupts even if
they were disabled. This caused bugs in Software Suspend 2 which
reenabled MTRRs whilst interrupts were already disabled.

Attached is a replacement patch which uses spin_lock_irqsave instead
of spin_lock_irq.

Kind regards,

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sched-fix-scheduling-latencies-in-mttrc-good.patch"

--- linux-2.6.10/arch/i386/kernel/cpu/mtrr/generic.c.orig	2004-10-19 05:54:32.000000000 +0800
+++ linux-2.6.10/arch/i386/kernel/cpu/mtrr/generic.c	2004-12-26 18:20:17.000000000 +0800
@@ -232,6 +232,7 @@ static unsigned long set_mtrr_state(u32 
 static unsigned long cr4 = 0;
 static u32 deftype_lo, deftype_hi;
 static spinlock_t set_atomicity_lock = SPIN_LOCK_UNLOCKED;
+static unsigned long sal_flags;
 
 static void prepare_set(void)
 {
@@ -240,11 +241,14 @@ static void prepare_set(void)
 	/*  Note that this is not ideal, since the cache is only flushed/disabled
 	   for this CPU while the MTRRs are changed, but changing this requires
 	   more invasive changes to the way the kernel boots  */
-	spin_lock(&set_atomicity_lock);
+	/*
+	 * Since we are disabling the cache dont allow any interrupts - they
+	 * would run extremely slow and would only increase the pain:
+	 */
+	spin_lock_irqsave(&set_atomicity_lock, sal_flags);
 
 	/*  Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
 	cr0 = read_cr0() | 0x40000000;	/* set CD flag */
-	wbinvd();
 	write_cr0(cr0);
 	wbinvd();
 
@@ -266,8 +270,7 @@ static void prepare_set(void)
 
 static void post_set(void)
 {
-	/*  Flush caches and TLBs  */
-	wbinvd();
+	/*  Flush TLBs (no need to flush caches - they are disabled)  */
 	__flush_tlb();
 
 	/* Intel (P6) standard MTRRs */
@@ -279,7 +282,7 @@ static void post_set(void)
 	/*  Restore value of CR4  */
 	if ( cpu_has_pge )
 		write_cr4(cr4);
-	spin_unlock(&set_atomicity_lock);
+	spin_unlock_irqrestore(&set_atomicity_lock, sal_flags);
 }
 
 static void generic_set_all(void)

--xHFwDpU9dbj6ez1V--
