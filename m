Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbVG3UtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbVG3UtW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbVG3UtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:49:21 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:16660 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S263159AbVG3UrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:47:22 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050730160345.GA3584@elte.hu>
References: <20050730160345.GA3584@elte.hu>
Content-Type: multipart/mixed; boundary="=-tlYosl6SZq7imHjyLcoA"
Date: Sat, 30 Jul 2005 22:47:15 +0200
Message-Id: <1122756435.29704.2.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tlYosl6SZq7imHjyLcoA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ingo,

-02 needs the attached patch to compile with my config.

Regards,

Peter Zijlstra

--=-tlYosl6SZq7imHjyLcoA
Content-Disposition: attachment; filename=linux-2.6.13-rc4-RT-V0.7.52-02_compile-fix.diff
Content-Type: text/x-patch; name=linux-2.6.13-rc4-RT-V0.7.52-02_compile-fix.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.13-rc4-RT-V0.7.52-02/mm/swap.c.orig	2005-07-30 21:38:28.000000000 +0200
+++ linux-2.6.13-rc4-RT-V0.7.52-02/mm/swap.c	2005-07-30 21:40:11.000000000 +0200
@@ -422,14 +422,17 @@
 #ifdef CONFIG_HOTPLUG_CPU
 static void lru_drain_cache(unsigned int cpu)
 {
-	struct pagevec *pvec = &per_cpu(lru_add_pvecs, cpu);
+	struct pagevec *pvec = &get_cpu_var_locked(lru_add_pvecs, cpu);
 
 	/* CPU is dead, so no locking needed. */
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
-	pvec = &per_cpu(lru_add_active_pvecs, cpu);
+	put_cpu_var_locked(lru_add_pvecs, cpu);
+
+	pvec = &get_cpu_var_locked(lru_add_active_pvecs, cpu);
 	if (pagevec_count(pvec))
 		__pagevec_lru_add_active(pvec);
+	put_cpu_var_locked(lru_add_active_pvecs, cpu);
 }
 
 /* Drop the CPU's cached committed space back into the central pool. */
--- linux-2.6.13-rc4-RT-V0.7.52-02/drivers/message/i2o/exec-osm.c~	2005-07-30 20:46:19.000000000 +0200
+++ linux-2.6.13-rc4-RT-V0.7.52-02/drivers/message/i2o/exec-osm.c	2005-07-30 21:58:38.000000000 +0200
@@ -204,7 +204,7 @@
 {
 	struct i2o_exec_wait *wait, *tmp;
 	unsigned long flags;
-	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	static DEFINE_SPINLOCK(lock);
 	int rc = 1;
 
 	/*

--=-tlYosl6SZq7imHjyLcoA--

