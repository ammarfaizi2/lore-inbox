Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUIVIWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUIVIWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 04:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUIVIWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 04:22:10 -0400
Received: from aun.it.uu.se ([130.238.12.36]:65169 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262329AbUIVIWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 04:22:01 -0400
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16721.13786.899310.697686@alkaid.it.uu.se>
Date: Wed, 22 Sep 2004 10:20:42 +0200
To: akpm@asdl.org
Subject: [PATCH][2.6.9-rc2-mm1] virtual perfctr illegal sleep
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch fixes an illegal sleep issue in perfctr's
virtualised per-process counters: a spinlock is taken
around calls to perfctr_cpu_{reserve,release}() which
sleeps on a mutex. Change the spinlock to a mutex too.

The problem was reported by Sami Farin.

Strangely enough, DEBUG_SPINLOCK_SLEEP only triggers if I
also have PREEMPT enabled. Is it supposed to be like that?

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -rupN linux-2.6.9-rc2-mm1/drivers/perfctr/virtual.c linux-2.6.9-rc2-mm1.virtual-perfctr-illegal-sleep-fix/drivers/perfctr/virtual.c
--- linux-2.6.9-rc2-mm1/drivers/perfctr/virtual.c	2004-09-22 01:00:48.000000000 +0200
+++ linux-2.6.9-rc2-mm1.virtual-perfctr-illegal-sleep-fix/drivers/perfctr/virtual.c	2004-09-22 01:08:41.811834000 +0200
@@ -91,7 +91,7 @@ static inline void vperfctr_init_bad_cpu
  ****************************************************************/
 
 /* XXX: perhaps relax this to number of _live_ perfctrs */
-static spinlock_t nrctrs_lock = SPIN_LOCK_UNLOCKED;
+static DECLARE_MUTEX(nrctrs_mutex);
 static int nrctrs;
 static const char this_service[] = __FILE__;
 
@@ -100,13 +100,13 @@ static int inc_nrctrs(void)
 	const char *other;
 
 	other = NULL;
-	spin_lock(&nrctrs_lock);
+	down(&nrctrs_mutex);
 	if (++nrctrs == 1) {
 		other = perfctr_cpu_reserve(this_service);
 		if (other)
 			nrctrs = 0;
 	}
-	spin_unlock(&nrctrs_lock);
+	up(&nrctrs_mutex);
 	if (other) {
 		printk(KERN_ERR __FILE__
 		       ": cannot operate, perfctr hardware taken by '%s'\n",
@@ -119,10 +119,10 @@ static int inc_nrctrs(void)
 
 static void dec_nrctrs(void)
 {
-	spin_lock(&nrctrs_lock);
+	down(&nrctrs_mutex);
 	if (--nrctrs == 0)
 		perfctr_cpu_release(this_service);
-	spin_unlock(&nrctrs_lock);
+	up(&nrctrs_mutex);
 }
 
 /* Allocate a `struct vperfctr'. Claim and reserve
