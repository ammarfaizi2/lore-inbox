Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135852AbREDEGv>; Fri, 4 May 2001 00:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135855AbREDEGl>; Fri, 4 May 2001 00:06:41 -0400
Received: from juicer24.bigpond.com ([139.134.6.34]:14812 "EHLO
	mailin3.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S135852AbREDEGa>; Fri, 4 May 2001 00:06:30 -0400
Message-Id: <m14vWv7-001QLxC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] max_fds race in select().
Date: Fri, 04 May 2001 14:10:21 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can end up with the user getting more fds tban they asked for...

Unlikely, but possible,
Rusty.
--- linux-2.4.4-official/fs/select.c	Thu Feb 22 14:25:36 2001
+++ working-2.4.4-rcu/fs/select.c	Fri May  4 14:06:39 2001
@@ -260,7 +260,7 @@
 	fd_set_bits fds;
 	char *bits;
 	long timeout;
-	int ret, size;
+	int ret, size, max_fdset;
 
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (tvp) {
@@ -285,8 +285,10 @@
 	if (n < 0)
 		goto out_nofds;
 
-	if (n > current->files->max_fdset)
-		n = current->files->max_fdset;
+	/* max_fdset can increase, so grab it once to avoid race */
+	max_fdset = current->files->max_fdset;
+	if (n > max_fdset)
+		n = max_fdset;
 
 	/*
 	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),

--
Premature optmztion is rt of all evl. --DK
