Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWHSAfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWHSAfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 20:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWHSAfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 20:35:18 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:43950 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751600AbWHSAfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 20:35:17 -0400
Subject: [PATCH] rcu: Fix sign bug making rcu_random always return the same
	sequence
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Paul McKenney <paulmck@us.ibm.com>,
       Dipkanar Sarma <dipankar@in.ibm.com>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 17:35:17 -0700
Message-Id: <1155947717.5337.9.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_random uses a counter rrs_count to occasionally mix data from
get_random_bytes into the state of its pseudorandom generator.  However, the
rrs_counter gets declared as an unsigned long, and rcu_random checks for
--rrs_count < 0, so this code will never mix any real random data into the
state, and will thus always return the same sequence of random numbers.

Also, change the return value of rcu_random from long to unsigned long, to
avoid potential issues caused by the use of the % operator, which can return
negative values for negative left operands.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 kernel/rcutorture.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index 8b09c95..ef6a124 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -146,7 +146,7 @@ rcu_torture_free(struct rcu_torture *p)
 
 struct rcu_random_state {
 	unsigned long rrs_state;
-	unsigned long rrs_count;
+	long rrs_count;
 };
 
 #define RCU_RANDOM_MULT 39916801  /* prime */
@@ -159,7 +159,7 @@ #define DEFINE_RCU_RANDOM(name) struct r
  * Crude but fast random-number generator.  Uses a linear congruential
  * generator, with occasional help from get_random_bytes().
  */
-static long
+static unsigned long
 rcu_random(struct rcu_random_state *rrsp)
 {
 	long refresh;
-- 
1.4.1.1


