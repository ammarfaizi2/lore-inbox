Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTHXD0G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 23:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTHXD0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 23:26:05 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:13518 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S263349AbTHXDZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 23:25:58 -0400
Date: Sun, 24 Aug 2003 12:27:53 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com, andrea@suse.de
Subject: Re: Race condition in 2.4 tasklet handling (cli() broken?)
Message-ID: <20030824032753.GC13292@atj.dyndns.org>
References: <20030823025448.GA32547@atj.dyndns.org> <20030823040931.GA3872@atj.dyndns.org> <20030823052633.GA4307@atj.dyndns.org> <20030823122813.0c90e241.skraw@ithnet.com> <20030823151315.GA6781@atj.dyndns.org> <20030823175604.1ddb119d.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20030823175604.1ddb119d.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Stephan.

 I'm attaching a patch which makes the following changes.

1. adds smp_mb() to irq_enter().
2. adds smp_mb() to synchronize_irq().
3. makes get_irq_lock() grab global_bh_lock before returning.
4. makes release_irq_lock() release global_bh_lock.

 As I now found out that test_and_set_bit() implies memory barrier,
smp_mb__after_test_and_set_bit() stuff is removed.

 This patch should fix the two relevant race conditions mentioned in
this and the other threads.  Please test this one.  It's against the
latest 2.4 bk tree but applying to 2.4.21 should be ok.

-- 
tejun

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.irqbh"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1102  -> 1.1103 
#	arch/i386/kernel/irq.c	1.7     -> 1.8    
#	include/asm-i386/hardirq.h	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/24	tj@atj.dyndns.org	1.1103
# - irq/bh race fixes.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Sun Aug 24 12:18:01 2003
+++ b/arch/i386/kernel/irq.c	Sun Aug 24 12:18:01 2003
@@ -272,8 +272,7 @@
 		 * already executing in one..
 		 */
 		if (!irqs_running())
-			if (local_bh_count(cpu) || !spin_is_locked(&global_bh_lock))
-				break;
+			break;
 
 		/* Duh, we have to loop. Release the lock to avoid deadlocks */
 		clear_bit(0,&global_irq_lock);
@@ -307,6 +306,7 @@
  */
 void synchronize_irq(void)
 {
+	smp_mb(); /* Sync with irq_enter() */
 	if (irqs_running()) {
 		/* Stupid approach */
 		cli();
@@ -332,6 +332,10 @@
 	 * in an interrupt context. 
 	 */
 	wait_on_irq(cpu);
+
+	/* bh is disallowed inside irqlock. */
+	if (!local_bh_count(cpu))
+		spin_lock(&global_bh_lock);
 
 	/*
 	 * Ok, finally..
diff -Nru a/include/asm-i386/hardirq.h b/include/asm-i386/hardirq.h
--- a/include/asm-i386/hardirq.h	Sun Aug 24 12:18:01 2003
+++ b/include/asm-i386/hardirq.h	Sun Aug 24 12:18:01 2003
@@ -54,10 +54,15 @@
 	return 0;
 }
 
+extern spinlock_t global_bh_lock; /* copied from linux/interrupt.h to break
+				     include loop :-( */
+
 static inline void release_irqlock(int cpu)
 {
 	/* if we didn't own the irq lock, just ignore.. */
 	if (global_irq_holder == (unsigned char) cpu) {
+		if (!local_bh_count(cpu))
+			spin_unlock(&global_bh_lock);
 		global_irq_holder = NO_PROC_ID;
 		clear_bit(0,&global_irq_lock);
 	}
@@ -66,6 +71,8 @@
 static inline void irq_enter(int cpu, int irq)
 {
 	++local_irq_count(cpu);
+
+	smp_mb(); /* sync with wait_on_irq() and synchronize_irq() */
 
 	while (test_bit(0,&global_irq_lock)) {
 		cpu_relax();

--r5Pyd7+fXNt84Ff3--
