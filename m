Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVFIAN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVFIAN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVFIAMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:12:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:25480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262244AbVFIAFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:05:16 -0400
Date: Wed, 8 Jun 2005 17:04:08 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de
Subject: [patch 04/09] x86_64: avoid SMP boot up race
Message-ID: <20050609000408.GK13152@shell0.pdx.osdl.net>
References: <20050608234637.GG13152@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608234637.GG13152@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keep interrupts disabled during smp bootup

This avoids a race that breaks SMP bootup on some machines.
The race is not fully plugged (that is only done with much
more changes in 2.6.12), but should be good enough
for most people.

Keeping the interrupts disabled here is ok because we
don't rely on the timer interrupt for local APIC
timer setup, but always read the timer registers
directly.

(originally from Rusty Russell iirc) 

Signed-off-by: ak@suse.de
Signed-off-by: Chris Wright <chrisw@osdl.org>

diff -u linux/arch/x86_64/kernel/apic.c-o linux/arch/x86_64/kernel/apic.c
--- linux/arch/x86_64/kernel/apic.c-o	2005-05-31 16:40:01.000000000 +0200
+++ linux/arch/x86_64/kernel/apic.c	2005-05-31 16:44:05.000000000 +0200
@@ -775,9 +775,7 @@
 
 void __init setup_secondary_APIC_clock(void)
 {
-	local_irq_disable(); /* FIXME: Do we need this? --RR */
 	setup_APIC_timer(calibration_result);
-	local_irq_enable();
 }
 
 void __init disable_APIC_timer(void)
diff -u linux/arch/x86_64/kernel/smpboot.c-o linux-2.6.11/arch/x86_64/kernel/smpboot.c
--- linux/arch/x86_64/kernel/smpboot.c-o	2005-03-21 14:04:11.000000000 +0100
+++ linux/arch/x86_64/kernel/smpboot.c	2005-05-31 16:44:07.000000000 +0200
@@ -309,8 +309,6 @@
 	Dprintk("CALLIN, before setup_local_APIC().\n");
 	setup_local_APIC();
 
-	local_irq_enable();
-
 	/*
 	 * Get our bogomips.
 	 */
@@ -324,8 +322,6 @@
 	 */
  	smp_store_cpu_info(cpuid);
 
-	local_irq_disable();
-
 	/*
 	 * Allow the master to continue.
 	 */

