Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVAUWC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVAUWC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVAUV7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:59:11 -0500
Received: from waste.org ([216.27.176.166]:30425 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262534AbVAUVlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:22 -0500
Date: Fri, 21 Jan 2005 15:41:08 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <10.314297600@selenic.com>
Message-Id: <11.314297600@selenic.com>
Subject: [PATCH 10/12] random pt4: Simplify and shrink syncookie code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify syncookie initialization
Refactor syncookie code with separate hash function

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd2/drivers/char/random.c
===================================================================
--- rnd2.orig/drivers/char/random.c	2005-01-20 10:12:26.633652402 -0800
+++ rnd2/drivers/char/random.c	2005-01-20 10:16:13.830687244 -0800
@@ -366,6 +366,10 @@
  * hash; hash collisions will occur no more often than chance.
  */
 
+#ifdef CONFIG_SYN_COOKIES
+static __u32 syncookie_secret[2][16-3+SHA_WORKSPACE_WORDS];
+#endif
+
 /*
  * Static global variables
  */
@@ -897,6 +901,9 @@
 	init_std_data(&input_pool);
 	init_std_data(&blocking_pool);
 	init_std_data(&nonblocking_pool);
+#ifdef CONFIG_SYN_COOKIES
+	get_random_bytes(syncookie_secret, sizeof(syncookie_secret));
+#endif
 	return 0;
 }
 module_init(rand_initialize);
@@ -1583,23 +1590,24 @@
 #define COOKIEBITS 24	/* Upper bits store count */
 #define COOKIEMASK (((__u32)1 << COOKIEBITS) - 1)
 
-static int syncookie_init;
-static __u32 syncookie_secret[2][16-3+SHA_DIGEST_WORDS];
-
-__u32 secure_tcp_syn_cookie(__u32 saddr, __u32 daddr, __u16 sport,
-		__u16 dport, __u32 sseq, __u32 count, __u32 data)
+static u32 cookie_hash(u32 saddr, u32 daddr, u32 sport, u32 dport,
+		       u32 count, int c)
 {
 	__u32 tmp[16 + 5 + SHA_WORKSPACE_WORDS];
-	__u32 seq;
 
-	/*
-	 * Pick two random secrets the first time we need a cookie.
-	 */
-	if (syncookie_init == 0) {
-		get_random_bytes(syncookie_secret, sizeof(syncookie_secret));
-		syncookie_init = 1;
-	}
+	memcpy(tmp + 3, syncookie_secret[c], sizeof(syncookie_secret[c]));
+	tmp[0] = saddr;
+	tmp[1] = daddr;
+	tmp[2] = (sport << 16) + dport;
+	tmp[3] = count;
+	sha_transform(tmp + 16, tmp);
 
+	return tmp[17];
+}
+
+__u32 secure_tcp_syn_cookie(__u32 saddr, __u32 daddr, __u16 sport,
+		__u16 dport, __u32 sseq, __u32 count, __u32 data)
+{
 	/*
 	 * Compute the secure sequence number.
 	 * The output should be:
@@ -1611,22 +1619,10 @@
 	 * MSS into the second hash value.
 	 */
 
-	memcpy(tmp + 3, syncookie_secret[0], sizeof(syncookie_secret[0]));
-	tmp[0]=saddr;
-	tmp[1]=daddr;
-	tmp[2]=(sport << 16) + dport;
-	sha_transform(tmp+16, (__u8 *)tmp, tmp + 16 + 5);
-	seq = tmp[17] + sseq + (count << COOKIEBITS);
-
-	memcpy(tmp + 3, syncookie_secret[1], sizeof(syncookie_secret[1]));
-	tmp[0]=saddr;
-	tmp[1]=daddr;
-	tmp[2]=(sport << 16) + dport;
-	tmp[3] = count;	/* minute counter */
-	sha_transform(tmp + 16, (__u8 *)tmp, tmp + 16 + 5);
-
-	/* Add in the second hash and the data */
-	return seq + ((tmp[17] + data) & COOKIEMASK);
+	return (cookie_hash(saddr, daddr, sport, dport, 0, 0) +
+		sseq + (count << COOKIEBITS) +
+		((cookie_hash(saddr, daddr, sport, dport, count, 1) + data)
+		 & COOKIEMASK));
 }
 
 /*
@@ -1641,33 +1637,19 @@
 __u32 check_tcp_syn_cookie(__u32 cookie, __u32 saddr, __u32 daddr, __u16 sport,
 		__u16 dport, __u32 sseq, __u32 count, __u32 maxdiff)
 {
-	__u32 tmp[16 + 5 + SHA_WORKSPACE_WORDS];
 	__u32 diff;
 
-	if (syncookie_init == 0)
-		return (__u32)-1; /* Well, duh! */
-
 	/* Strip away the layers from the cookie */
-	memcpy(tmp + 3, syncookie_secret[0], sizeof(syncookie_secret[0]));
-	tmp[0]=saddr;
-	tmp[1]=daddr;
-	tmp[2]=(sport << 16) + dport;
-	sha_transform(tmp + 16, (__u8 *)tmp, tmp + 16 + 5);
-	cookie -= tmp[17] + sseq;
-	/* Cookie is now reduced to (count * 2^24) ^ (hash % 2^24) */
+	cookie -= cookie_hash(saddr, daddr, sport, dport, 0, 0) + sseq;
 
+	/* Cookie is now reduced to (count * 2^24) ^ (hash % 2^24) */
 	diff = (count - (cookie >> COOKIEBITS)) & ((__u32)-1 >> COOKIEBITS);
 	if (diff >= maxdiff)
 		return (__u32)-1;
 
-	memcpy(tmp+3, syncookie_secret[1], sizeof(syncookie_secret[1]));
-	tmp[0] = saddr;
-	tmp[1] = daddr;
-	tmp[2] = (sport << 16) + dport;
-	tmp[3] = count - diff;	/* minute counter */
-	sha_transform(tmp + 16, tmp);
-
-	return (cookie - tmp[17]) & COOKIEMASK;	/* Leaving the data behind */
+	return (cookie -
+		cookie_hash(saddr, daddr, sport, dport, count - diff, 1))
+		& COOKIEMASK;	/* Leaving the data behind */
 }
 #endif
 #endif /* CONFIG_INET */
