Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVAOA7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVAOA7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVAOAuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:50:14 -0500
Received: from waste.org ([216.27.176.166]:9953 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262071AbVAOAtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:49:13 -0500
Date: Fri, 14 Jan 2005 18:49:07 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.563253706@selenic.com>
Message-Id: <6.563253706@selenic.com>
Subject: [PATCH 5/10] random pt2: simplify initialization
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the init code

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:28:02.593185340 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:28:03.909017586 -0800
@@ -1485,9 +1485,6 @@
 static void init_std_data(struct entropy_store *r)
 {
 	struct timeval tv;
-	__u32 words[2];
-	char *p;
-	int i;
 	unsigned long flags;
 
 	spin_lock_irqsave(&r->lock, flags);
@@ -1495,20 +1492,9 @@
 	spin_unlock_irqrestore(&r->lock, flags);
 
 	do_gettimeofday(&tv);
-	words[0] = tv.tv_sec;
-	words[1] = tv.tv_usec;
-	add_entropy_words(r, words, 2);
-
-	/*
-	 *	This doesn't lock system.utsname. However, we are generating
-	 *	entropy so a race with a name set here is fine.
-	 */
-	p = (char *) &system_utsname;
-	for (i = sizeof(system_utsname) / sizeof(words); i; i--) {
-		memcpy(words, p, sizeof(words));
-		add_entropy_words(r, words, sizeof(words)/4);
-		p += sizeof(words);
-	}
+	add_entropy_words(r, (__u32 *)&tv, sizeof(tv)/4);
+	add_entropy_words(r, (__u32 *)&system_utsname,
+			  sizeof(system_utsname)/4);
 }
 
 static int __init rand_initialize(void)
