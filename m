Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUHTE5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUHTE5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 00:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266339AbUHTE5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 00:57:16 -0400
Received: from thunk.org ([140.239.227.29]:13996 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266333AbUHTE5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 00:57:13 -0400
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org
Subject: [PATCH] [1/4] /dev/random: Fix latency in rekeying sequence number
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1By1Sh-0001TJ-1U@thunk.org>
Date: Fri, 20 Aug 2004 00:57:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Based on reports from Ingo's Latency Tracer that the TCP sequence number
rekey code is causing latency problems, I've moved the sequence number
rekey to be done out of a workqueue.

patch-random-1-rekey-workqueue

--- random.c	2004/08/19 22:48:42	1.1
+++ random.c	2004/08/19 22:49:20	1.2
@@ -2246,30 +2246,35 @@
 static spinlock_t ip_lock = SPIN_LOCK_UNLOCKED;
 static unsigned int ip_cnt;
 
-static struct keydata *__check_and_rekey(time_t time)
+static void rekey_seq_generator(void *private_)
 {
 	struct keydata *keyptr;
+	struct timeval 	tv;
+
+	do_gettimeofday(&tv);
+
 	spin_lock_bh(&ip_lock);
 	keyptr = &ip_keydata[ip_cnt&1];
-	if (!keyptr->rekey_time || (time - keyptr->rekey_time) > REKEY_INTERVAL) {
-		keyptr = &ip_keydata[1^(ip_cnt&1)];
-		keyptr->rekey_time = time;
-		get_random_bytes(keyptr->secret, sizeof(keyptr->secret));
-		keyptr->count = (ip_cnt&COUNT_MASK)<<HASH_BITS;
-		mb();
-		ip_cnt++;
-	}
+
+	keyptr = &ip_keydata[1^(ip_cnt&1)];
+	keyptr->rekey_time = tv.tv_sec;
+	get_random_bytes(keyptr->secret, sizeof(keyptr->secret));
+	keyptr->count = (ip_cnt&COUNT_MASK)<<HASH_BITS;
+	mb();
+	ip_cnt++;
+
 	spin_unlock_bh(&ip_lock);
-	return keyptr;
 }
 
+static DECLARE_WORK(rekey_work, rekey_seq_generator, NULL);
+
 static inline struct keydata *check_and_rekey(time_t time)
 {
 	struct keydata *keyptr = &ip_keydata[ip_cnt&1];
 
 	rmb();
 	if (!keyptr->rekey_time || (time - keyptr->rekey_time) > REKEY_INTERVAL) {
-		keyptr = __check_and_rekey(time);
+		schedule_work(&rekey_work);
 	}
 
 	return keyptr;
