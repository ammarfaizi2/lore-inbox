Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWGZTJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWGZTJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 15:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWGZTJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 15:09:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:22193 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751037AbWGZTJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 15:09:47 -0400
Subject: [PATCH] [rcu] Add lock annotations to
	rcu{,_bh}_torture_read_{lock,unlock}
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Paul McKenney <paulmck@us.ibm.com>,
       Dipkanar Sarma <dipankar@in.ibm.com>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 12:09:46 -0700
Message-Id: <1153940986.12517.66.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_torture_read_lock and rcu_bh_torture_read_lock acquire locks without
releasing them, and the matching functions rcu_torture_read_unlock and
rcu_bh_torture_read_unlock get called with the corresponding locks held and
release them.  Add lock annotations to these four functions so that sparse can
check callers for lock pairing, and so that sparse will not complain about
these functions since they intentionally use locks in this manner.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 kernel/rcutorture.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index 4d1c3d2..4f2c427 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -192,13 +192,13 @@ static struct rcu_torture_ops *cur_ops =
  * Definitions for rcu torture testing.
  */
 
-static int rcu_torture_read_lock(void)
+static int rcu_torture_read_lock(void) __acquires(RCU)
 {
 	rcu_read_lock();
 	return 0;
 }
 
-static void rcu_torture_read_unlock(int idx)
+static void rcu_torture_read_unlock(int idx) __releases(RCU)
 {
 	rcu_read_unlock();
 }
@@ -250,13 +250,13 @@ static struct rcu_torture_ops rcu_ops = 
  * Definitions for rcu_bh torture testing.
  */
 
-static int rcu_bh_torture_read_lock(void)
+static int rcu_bh_torture_read_lock(void) __acquires(RCU_BH)
 {
 	rcu_read_lock_bh();
 	return 0;
 }
 
-static void rcu_bh_torture_read_unlock(int idx)
+static void rcu_bh_torture_read_unlock(int idx) __releases(RCU_BH)
 {
 	rcu_read_unlock_bh();
 }


