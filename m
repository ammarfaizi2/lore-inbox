Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVAUVsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVAUVsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVAUVrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:47:02 -0500
Received: from waste.org ([216.27.176.166]:30937 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262536AbVAUVlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:23 -0500
Date: Fri, 21 Jan 2005 15:41:08 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11.314297600@selenic.com>
Message-Id: <12.314297600@selenic.com>
Subject: [PATCH 11/12] random pt4: Move syncookies to net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move syncookie code off to networking land.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd2/drivers/char/random.c
===================================================================
--- rnd2.orig/drivers/char/random.c	2005-01-20 10:16:13.830687244 -0800
+++ rnd2/drivers/char/random.c	2005-01-20 10:16:43.345924372 -0800
@@ -366,10 +366,6 @@
  * hash; hash collisions will occur no more often than chance.
  */
 
-#ifdef CONFIG_SYN_COOKIES
-static __u32 syncookie_secret[2][16-3+SHA_WORKSPACE_WORDS];
-#endif
-
 /*
  * Static global variables
  */
@@ -901,9 +897,6 @@
 	init_std_data(&input_pool);
 	init_std_data(&blocking_pool);
 	init_std_data(&nonblocking_pool);
-#ifdef CONFIG_SYN_COOKIES
-	get_random_bytes(syncookie_secret, sizeof(syncookie_secret));
-#endif
 	return 0;
 }
 module_init(rand_initialize);
@@ -1578,78 +1571,4 @@
 	return half_md4_transform(hash, keyptr->secret);
 }
 
-#ifdef CONFIG_SYN_COOKIES
-/*
- * Secure SYN cookie computation. This is the algorithm worked out by
- * Dan Bernstein and Eric Schenk.
- *
- * For linux I implement the 1 minute counter by looking at the jiffies clock.
- * The count is passed in as a parameter, so this code doesn't much care.
- */
-
-#define COOKIEBITS 24	/* Upper bits store count */
-#define COOKIEMASK (((__u32)1 << COOKIEBITS) - 1)
-
-static u32 cookie_hash(u32 saddr, u32 daddr, u32 sport, u32 dport,
-		       u32 count, int c)
-{
-	__u32 tmp[16 + 5 + SHA_WORKSPACE_WORDS];
-
-	memcpy(tmp + 3, syncookie_secret[c], sizeof(syncookie_secret[c]));
-	tmp[0] = saddr;
-	tmp[1] = daddr;
-	tmp[2] = (sport << 16) + dport;
-	tmp[3] = count;
-	sha_transform(tmp + 16, tmp);
-
-	return tmp[17];
-}
-
-__u32 secure_tcp_syn_cookie(__u32 saddr, __u32 daddr, __u16 sport,
-		__u16 dport, __u32 sseq, __u32 count, __u32 data)
-{
-	/*
-	 * Compute the secure sequence number.
-	 * The output should be:
-   	 *   HASH(sec1,saddr,sport,daddr,dport,sec1) + sseq + (count * 2^24)
-	 *      + (HASH(sec2,saddr,sport,daddr,dport,count,sec2) % 2^24).
-	 * Where sseq is their sequence number and count increases every
-	 * minute by 1.
-	 * As an extra hack, we add a small "data" value that encodes the
-	 * MSS into the second hash value.
-	 */
-
-	return (cookie_hash(saddr, daddr, sport, dport, 0, 0) +
-		sseq + (count << COOKIEBITS) +
-		((cookie_hash(saddr, daddr, sport, dport, count, 1) + data)
-		 & COOKIEMASK));
-}
-
-/*
- * This retrieves the small "data" value from the syncookie.
- * If the syncookie is bad, the data returned will be out of
- * range.  This must be checked by the caller.
- *
- * The count value used to generate the cookie must be within
- * "maxdiff" if the current (passed-in) "count".  The return value
- * is (__u32)-1 if this test fails.
- */
-__u32 check_tcp_syn_cookie(__u32 cookie, __u32 saddr, __u32 daddr, __u16 sport,
-		__u16 dport, __u32 sseq, __u32 count, __u32 maxdiff)
-{
-	__u32 diff;
-
-	/* Strip away the layers from the cookie */
-	cookie -= cookie_hash(saddr, daddr, sport, dport, 0, 0) + sseq;
-
-	/* Cookie is now reduced to (count * 2^24) ^ (hash % 2^24) */
-	diff = (count - (cookie >> COOKIEBITS)) & ((__u32)-1 >> COOKIEBITS);
-	if (diff >= maxdiff)
-		return (__u32)-1;
-
-	return (cookie -
-		cookie_hash(saddr, daddr, sport, dport, count - diff, 1))
-		& COOKIEMASK;	/* Leaving the data behind */
-}
-#endif
 #endif /* CONFIG_INET */
Index: rnd2/net/ipv4/syncookies.c
===================================================================
--- rnd2.orig/net/ipv4/syncookies.c	2005-01-20 10:15:30.628195094 -0800
+++ rnd2/net/ipv4/syncookies.c	2005-01-20 10:16:24.202364968 -0800
@@ -17,11 +17,88 @@
 #include <linux/tcp.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/cryptohash.h>
 #include <linux/kernel.h>
 #include <net/tcp.h>
 
 extern int sysctl_tcp_syncookies;
 
+static __u32 syncookie_secret[2][16-3+SHA_DIGEST_WORDS];
+
+static __init int init_syncookies(void)
+{
+	get_random_bytes(syncookie_secret, sizeof(syncookie_secret));
+	return 0;
+}
+module_init(init_syncookies);
+
+#define COOKIEBITS 24	/* Upper bits store count */
+#define COOKIEMASK (((__u32)1 << COOKIEBITS) - 1)
+
+static u32 cookie_hash(u32 saddr, u32 daddr, u32 sport, u32 dport,
+		       u32 count, int c)
+{
+	__u32 tmp[16 + 5 + SHA_WORKSPACE_WORDS];
+
+	memcpy(tmp + 3, syncookie_secret[c], sizeof(syncookie_secret[c]));
+	tmp[0] = saddr;
+	tmp[1] = daddr;
+	tmp[2] = (sport << 16) + dport;
+	tmp[3] = count;
+	sha_transform(tmp + 16, (__u8 *)tmp, tmp + 16 + 5);
+
+	return tmp[17];
+}
+
+static __u32 secure_tcp_syn_cookie(__u32 saddr, __u32 daddr, __u16 sport,
+				   __u16 dport, __u32 sseq, __u32 count,
+				   __u32 data)
+{
+	/*
+	 * Compute the secure sequence number.
+	 * The output should be:
+   	 *   HASH(sec1,saddr,sport,daddr,dport,sec1) + sseq + (count * 2^24)
+	 *      + (HASH(sec2,saddr,sport,daddr,dport,count,sec2) % 2^24).
+	 * Where sseq is their sequence number and count increases every
+	 * minute by 1.
+	 * As an extra hack, we add a small "data" value that encodes the
+	 * MSS into the second hash value.
+	 */
+
+	return (cookie_hash(saddr, daddr, sport, dport, 0, 0) +
+		sseq + (count << COOKIEBITS) +
+		((cookie_hash(saddr, daddr, sport, dport, count, 1) + data)
+		 & COOKIEMASK));
+}
+
+/*
+ * This retrieves the small "data" value from the syncookie.
+ * If the syncookie is bad, the data returned will be out of
+ * range.  This must be checked by the caller.
+ *
+ * The count value used to generate the cookie must be within
+ * "maxdiff" if the current (passed-in) "count".  The return value
+ * is (__u32)-1 if this test fails.
+ */
+static __u32 check_tcp_syn_cookie(__u32 cookie, __u32 saddr, __u32 daddr,
+				  __u16 sport, __u16 dport, __u32 sseq,
+				  __u32 count, __u32 maxdiff)
+{
+	__u32 diff;
+
+	/* Strip away the layers from the cookie */
+	cookie -= cookie_hash(saddr, daddr, sport, dport, 0, 0) + sseq;
+
+	/* Cookie is now reduced to (count * 2^24) ^ (hash % 2^24) */
+	diff = (count - (cookie >> COOKIEBITS)) & ((__u32) - 1 >> COOKIEBITS);
+	if (diff >= maxdiff)
+		return (__u32)-1;
+
+	return (cookie -
+		cookie_hash(saddr, daddr, sport, dport, count - diff, 1))
+		& COOKIEMASK;	/* Leaving the data behind */
+}
+
 /* 
  * This table has to be sorted and terminated with (__u16)-1.
  * XXX generate a better table.
Index: rnd2/include/linux/random.h
===================================================================
--- rnd2.orig/include/linux/random.h	2005-01-20 10:15:30.628195094 -0800
+++ rnd2/include/linux/random.h	2005-01-20 10:16:24.202364968 -0800
@@ -55,14 +55,6 @@
 extern u32 secure_tcp_port_ephemeral(__u32 saddr, __u32 daddr, __u16 dport);
 extern __u32 secure_tcp_sequence_number(__u32 saddr, __u32 daddr,
 					__u16 sport, __u16 dport);
-extern __u32 secure_tcp_syn_cookie(__u32 saddr, __u32 daddr,
-				   __u16 sport, __u16 dport,
-				   __u32 sseq, __u32 count,
-				   __u32 data);
-extern __u32 check_tcp_syn_cookie(__u32 cookie, __u32 saddr,
-				  __u32 daddr, __u16 sport,
-				  __u16 dport, __u32 sseq,
-				  __u32 count, __u32 maxdiff);
 extern __u32 secure_tcpv6_sequence_number(__u32 *saddr, __u32 *daddr,
 					  __u16 sport, __u16 dport);
 
