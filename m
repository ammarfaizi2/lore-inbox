Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVAUV6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVAUV6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVAUV4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:56:33 -0500
Received: from waste.org ([216.27.176.166]:29657 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262531AbVAUVlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:21 -0500
Date: Fri, 21 Jan 2005 15:41:08 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <12.314297600@selenic.com>
Message-Id: <13.314297600@selenic.com>
Subject: [PATCH 12/12] random pt4: Move other tcp/ip bits to net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move remaining TCP bits from random.c to networking land.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd2/include/net/tcp.h
===================================================================
--- rnd2.orig/include/net/tcp.h	2005-01-20 10:15:06.896220663 -0800
+++ rnd2/include/net/tcp.h	2005-01-20 10:16:59.315888375 -0800
@@ -2056,4 +2056,12 @@
 
 	return (cwnd != 0);
 }
+
+/* from net/ipv4/random.c */
+
+extern u32 secure_tcp_port_ephemeral(__u32 saddr, __u32 daddr, __u16 dport);
+extern __u32 secure_tcp_sequence_number(__u32 saddr, __u32 daddr,
+					__u16 sport, __u16 dport);
+extern __u32 secure_tcpv6_sequence_number(__u32 *saddr, __u32 *daddr,
+					  __u16 sport, __u16 dport);
 #endif	/* _TCP_H */
Index: rnd2/net/ipv4/Makefile
===================================================================
--- rnd2.orig/net/ipv4/Makefile	2005-01-20 10:15:06.896220663 -0800
+++ rnd2/net/ipv4/Makefile	2005-01-20 10:16:59.315888375 -0800
@@ -2,7 +2,7 @@
 # Makefile for the Linux TCP/IP (INET) layer.
 #
 
-obj-y     := utils.o route.o inetpeer.o protocol.o \
+obj-y     := utils.o random.o route.o inetpeer.o protocol.o \
 	     ip_input.o ip_fragment.o ip_forward.o ip_options.o \
 	     ip_output.o ip_sockglue.o \
 	     tcp.o tcp_input.o tcp_output.o tcp_timer.o tcp_ipv4.o tcp_minisocks.o \
Index: rnd2/drivers/char/random.c
===================================================================
--- rnd2.orig/drivers/char/random.c	2005-01-20 10:16:43.345924372 -0800
+++ rnd2/drivers/char/random.c	2005-01-20 10:16:59.317888120 -0800
@@ -1287,288 +1287,3 @@
 	{ .ctl_name = 0 }
 };
 #endif 	/* CONFIG_SYSCTL */
-
-/********************************************************************
- *
- * Random funtions for networking
- *
- ********************************************************************/
-
-#ifdef CONFIG_INET
-/*
- * TCP initial sequence number picking.  This uses the random number
- * generator to pick an initial secret value.  This value is hashed
- * along with the TCP endpoint information to provide a unique
- * starting point for each pair of TCP endpoints.  This defeats
- * attacks which rely on guessing the initial TCP sequence number.
- * This algorithm was suggested by Steve Bellovin.
- *
- * Using a very strong hash was taking an appreciable amount of the total
- * TCP connection establishment time, so this is a weaker hash,
- * compensated for by changing the secret periodically.
- */
-
-/* F, G and H are basic MD4 functions: selection, majority, parity */
-#define F(x, y, z) ((z) ^ ((x) & ((y) ^ (z))))
-#define G(x, y, z) (((x) & (y)) + (((x) ^ (y)) & (z)))
-#define H(x, y, z) ((x) ^ (y) ^ (z))
-
-/*
- * The generic round function.  The application is so specific that
- * we don't bother protecting all the arguments with parens, as is generally
- * good macro practice, in favor of extra legibility.
- * Rotation is separate from addition to prevent recomputation
- */
-#define ROUND(f, a, b, c, d, x, s)	\
-	(a += f(b, c, d) + x, a = (a << s) | (a >> (32 - s)))
-#define K1 0
-#define K2 013240474631UL
-#define K3 015666365641UL
-
-#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-
-static __u32 twothirdsMD4Transform (__u32 const buf[4], __u32 const in[12])
-{
-	__u32 a = buf[0], b = buf[1], c = buf[2], d = buf[3];
-
-	/* Round 1 */
-	ROUND(F, a, b, c, d, in[ 0] + K1,  3);
-	ROUND(F, d, a, b, c, in[ 1] + K1,  7);
-	ROUND(F, c, d, a, b, in[ 2] + K1, 11);
-	ROUND(F, b, c, d, a, in[ 3] + K1, 19);
-	ROUND(F, a, b, c, d, in[ 4] + K1,  3);
-	ROUND(F, d, a, b, c, in[ 5] + K1,  7);
-	ROUND(F, c, d, a, b, in[ 6] + K1, 11);
-	ROUND(F, b, c, d, a, in[ 7] + K1, 19);
-	ROUND(F, a, b, c, d, in[ 8] + K1,  3);
-	ROUND(F, d, a, b, c, in[ 9] + K1,  7);
-	ROUND(F, c, d, a, b, in[10] + K1, 11);
-	ROUND(F, b, c, d, a, in[11] + K1, 19);
-
-	/* Round 2 */
-	ROUND(G, a, b, c, d, in[ 1] + K2,  3);
-	ROUND(G, d, a, b, c, in[ 3] + K2,  5);
-	ROUND(G, c, d, a, b, in[ 5] + K2,  9);
-	ROUND(G, b, c, d, a, in[ 7] + K2, 13);
-	ROUND(G, a, b, c, d, in[ 9] + K2,  3);
-	ROUND(G, d, a, b, c, in[11] + K2,  5);
-	ROUND(G, c, d, a, b, in[ 0] + K2,  9);
-	ROUND(G, b, c, d, a, in[ 2] + K2, 13);
-	ROUND(G, a, b, c, d, in[ 4] + K2,  3);
-	ROUND(G, d, a, b, c, in[ 6] + K2,  5);
-	ROUND(G, c, d, a, b, in[ 8] + K2,  9);
-	ROUND(G, b, c, d, a, in[10] + K2, 13);
-
-	/* Round 3 */
-	ROUND(H, a, b, c, d, in[ 3] + K3,  3);
-	ROUND(H, d, a, b, c, in[ 7] + K3,  9);
-	ROUND(H, c, d, a, b, in[11] + K3, 11);
-	ROUND(H, b, c, d, a, in[ 2] + K3, 15);
-	ROUND(H, a, b, c, d, in[ 6] + K3,  3);
-	ROUND(H, d, a, b, c, in[10] + K3,  9);
-	ROUND(H, c, d, a, b, in[ 1] + K3, 11);
-	ROUND(H, b, c, d, a, in[ 5] + K3, 15);
-	ROUND(H, a, b, c, d, in[ 9] + K3,  3);
-	ROUND(H, d, a, b, c, in[ 0] + K3,  9);
-	ROUND(H, c, d, a, b, in[ 4] + K3, 11);
-	ROUND(H, b, c, d, a, in[ 8] + K3, 15);
-
-	return buf[1] + b; /* "most hashed" word */
-	/* Alternative: return sum of all words? */
-}
-#endif
-
-#undef ROUND
-#undef F
-#undef G
-#undef H
-#undef K1
-#undef K2
-#undef K3
-
-/* This should not be decreased so low that ISNs wrap too fast. */
-#define REKEY_INTERVAL (300 * HZ)
-/*
- * Bit layout of the tcp sequence numbers (before adding current time):
- * bit 24-31: increased after every key exchange
- * bit 0-23: hash(source,dest)
- *
- * The implementation is similar to the algorithm described
- * in the Appendix of RFC 1185, except that
- * - it uses a 1 MHz clock instead of a 250 kHz clock
- * - it performs a rekey every 5 minutes, which is equivalent
- * 	to a (source,dest) tulple dependent forward jump of the
- * 	clock by 0..2^(HASH_BITS+1)
- *
- * Thus the average ISN wraparound time is 68 minutes instead of
- * 4.55 hours.
- *
- * SMP cleanup and lock avoidance with poor man's RCU.
- * 			Manfred Spraul <manfred@colorfullife.com>
- *
- */
-#define COUNT_BITS 8
-#define COUNT_MASK ((1 << COUNT_BITS) - 1)
-#define HASH_BITS 24
-#define HASH_MASK ((1 << HASH_BITS) - 1)
-
-static struct keydata {
-	__u32 count; /* already shifted to the final position */
-	__u32 secret[12];
-} ____cacheline_aligned ip_keydata[2];
-
-static unsigned int ip_cnt;
-
-static void rekey_seq_generator(void *private_);
-
-static DECLARE_WORK(rekey_work, rekey_seq_generator, NULL);
-
-/*
- * Lock avoidance:
- * The ISN generation runs lockless - it's just a hash over random data.
- * State changes happen every 5 minutes when the random key is replaced.
- * Synchronization is performed by having two copies of the hash function
- * state and rekey_seq_generator always updates the inactive copy.
- * The copy is then activated by updating ip_cnt.
- * The implementation breaks down if someone blocks the thread
- * that processes SYN requests for more than 5 minutes. Should never
- * happen, and even if that happens only a not perfectly compliant
- * ISN is generated, nothing fatal.
- */
-static void rekey_seq_generator(void *private_)
-{
-	struct keydata *keyptr = &ip_keydata[1 ^ (ip_cnt & 1)];
-
-	get_random_bytes(keyptr->secret, sizeof(keyptr->secret));
-	keyptr->count = (ip_cnt & COUNT_MASK) << HASH_BITS;
-	smp_wmb();
-	ip_cnt++;
-	schedule_delayed_work(&rekey_work, REKEY_INTERVAL);
-}
-
-static inline struct keydata *get_keyptr(void)
-{
-	struct keydata *keyptr = &ip_keydata[ip_cnt & 1];
-
-	smp_rmb();
-
-	return keyptr;
-}
-
-static __init int seqgen_init(void)
-{
-	rekey_seq_generator(NULL);
-	return 0;
-}
-late_initcall(seqgen_init);
-
-#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-__u32 secure_tcpv6_sequence_number(__u32 *saddr, __u32 *daddr,
-				   __u16 sport, __u16 dport)
-{
-	struct timeval tv;
-	__u32 seq;
-	__u32 hash[12];
-	struct keydata *keyptr = get_keyptr();
-
-	/* The procedure is the same as for IPv4, but addresses are longer.
-	 * Thus we must use twothirdsMD4Transform.
-	 */
-
-	memcpy(hash, saddr, 16);
-	hash[4]=(sport << 16) + dport;
-	memcpy(&hash[5],keyptr->secret,sizeof(__u32) * 7);
-
-	seq = twothirdsMD4Transform(daddr, hash) & HASH_MASK;
-	seq += keyptr->count;
-
-	do_gettimeofday(&tv);
-	seq += tv.tv_usec + tv.tv_sec * 1000000;
-
-	return seq;
-}
-EXPORT_SYMBOL(secure_tcpv6_sequence_number);
-#endif
-
-__u32 secure_tcp_sequence_number(__u32 saddr, __u32 daddr,
-				 __u16 sport, __u16 dport)
-{
-	struct timeval tv;
-	__u32 seq;
-	__u32 hash[4];
-	struct keydata *keyptr = get_keyptr();
-
-	/*
-	 *  Pick a unique starting offset for each TCP connection endpoints
-	 *  (saddr, daddr, sport, dport).
-	 *  Note that the words are placed into the starting vector, which is
-	 *  then mixed with a partial MD4 over random data.
-	 */
-	hash[0]=saddr;
-	hash[1]=daddr;
-	hash[2]=(sport << 16) + dport;
-	hash[3]=keyptr->secret[11];
-
-	seq = half_md4_transform(hash, keyptr->secret) & HASH_MASK;
-	seq += keyptr->count;
-	/*
-	 *	As close as possible to RFC 793, which
-	 *	suggests using a 250 kHz clock.
-	 *	Further reading shows this assumes 2 Mb/s networks.
-	 *	For 10 Mb/s Ethernet, a 1 MHz clock is appropriate.
-	 *	That's funny, Linux has one built in!  Use it!
-	 *	(Networks are faster now - should this be increased?)
-	 */
-	do_gettimeofday(&tv);
-	seq += tv.tv_usec + tv.tv_sec * 1000000;
-#if 0
-	printk("init_seq(%lx, %lx, %d, %d) = %d\n",
-	       saddr, daddr, sport, dport, seq);
-#endif
-	return seq;
-}
-
-EXPORT_SYMBOL(secure_tcp_sequence_number);
-
-/*  The code below is shamelessly stolen from secure_tcp_sequence_number().
- *  All blames to Andrey V. Savochkin <saw@msu.ru>.
- */
-__u32 secure_ip_id(__u32 daddr)
-{
-	struct keydata *keyptr;
-	__u32 hash[4];
-
-	keyptr = get_keyptr();
-
-	/*
-	 *  Pick a unique starting offset for each IP destination.
-	 *  The dest ip address is placed in the starting vector,
-	 *  which is then hashed with random data.
-	 */
-	hash[0] = daddr;
-	hash[1] = keyptr->secret[9];
-	hash[2] = keyptr->secret[10];
-	hash[3] = keyptr->secret[11];
-
-	return half_md4_transform(hash, keyptr->secret);
-}
-
-/* Generate secure starting point for ephemeral TCP port search */
-u32 secure_tcp_port_ephemeral(__u32 saddr, __u32 daddr, __u16 dport)
-{
-	struct keydata *keyptr = get_keyptr();
-	u32 hash[4];
-
-	/*
-	 *  Pick a unique starting offset for each ephemeral port search
-	 *  (saddr, daddr, dport) and 48bits of random data.
-	 */
-	hash[0] = saddr;
-	hash[1] = daddr;
-	hash[2] = dport ^ keyptr->secret[10];
-	hash[3] = keyptr->secret[11];
-
-	return half_md4_transform(hash, keyptr->secret);
-}
-
-#endif /* CONFIG_INET */
Index: rnd2/include/net/ip.h
===================================================================
--- rnd2.orig/include/net/ip.h	2005-01-20 10:15:07.081197080 -0800
+++ rnd2/include/net/ip.h	2005-01-20 10:16:59.318887992 -0800
@@ -339,4 +339,8 @@
 				  void __user *newval, size_t newlen, 
 				  void **context);
 
+/* from net/ipv4/random.c */
+
+extern __u32 secure_ip_id(__u32 daddr);
+
 #endif	/* _IP_H */
Index: rnd2/net/ipv4/inetpeer.c
===================================================================
--- rnd2.orig/net/ipv4/inetpeer.c	2005-01-20 10:15:06.895220790 -0800
+++ rnd2/net/ipv4/inetpeer.c	2005-01-20 10:16:59.319887865 -0800
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/net.h>
 #include <net/inetpeer.h>
+#include <net/ip.h>
 
 /*
  *  Theory of operations.
Index: rnd2/net/ipv4/random.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ rnd2/net/ipv4/random.c	2005-01-20 10:16:59.320887737 -0800
@@ -0,0 +1,275 @@
+/*
+ * TCP initial sequence number picking.  This uses the random number
+ * generator to pick an initial secret value.  This value is hashed
+ * along with the TCP endpoint information to provide a unique
+ * starting point for each pair of TCP endpoints.  This defeats
+ * attacks which rely on guessing the initial TCP sequence number.
+ * This algorithm was suggested by Steve Bellovin.
+ *
+ * Using a very strong hash was taking an appreciable amount of the total
+ * TCP connection establishment time, so this is a weaker hash,
+ * compensated for by changing the secret periodically.
+ *
+ * Bit layout of the tcp sequence numbers (before adding current time):
+ * bit 24-31: increased after every key exchange
+ * bit 0-23: hash(source,dest)
+ *
+ * The implementation is similar to the algorithm described
+ * in the Appendix of RFC 1185, except that
+ * - it uses a 1 MHz clock instead of a 250 kHz clock
+ * - it performs a rekey every 5 minutes, which is equivalent
+ * 	to a (source,dest) tulple dependent forward jump of the
+ * 	clock by 0..2^(HASH_BITS+1)
+ *
+ * Thus the average ISN wraparound time is 68 minutes instead of
+ * 4.55 hours.
+ *
+ * SMP cleanup and lock avoidance with poor man's RCU.
+ * 			Manfred Spraul <manfred@colorfullife.com>
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/random.h>
+#include <linux/workqueue.h>
+#include <linux/jiffies.h>
+#include <linux/init.h>
+#include <linux/cryptohash.h>
+#include <linux/module.h>
+
+#define COUNT_BITS 8
+#define COUNT_MASK ((1 << COUNT_BITS) - 1)
+#define HASH_BITS 24
+#define HASH_MASK ((1 << HASH_BITS) - 1)
+
+/* This should not be decreased so low that ISNs wrap too fast. */
+#define REKEY_INTERVAL (300 * HZ)
+static void rekey_seq_generator(void *private_);
+static DECLARE_WORK(rekey_work, rekey_seq_generator, NULL);
+
+/*
+ * Lock avoidance:
+ * The ISN generation runs lockless - it's just a hash over random data.
+ * State changes happen every 5 minutes when the random key is replaced.
+ * Synchronization is performed by having two copies of the hash function
+ * state and rekey_seq_generator always updates the inactive copy.
+ * The copy is then activated by updating ip_cnt.
+ * The implementation breaks down if someone blocks the thread
+ * that processes SYN requests for more than 5 minutes. Should never
+ * happen, and even if that happens only a not perfectly compliant
+ * ISN is generated, nothing fatal.
+ */
+
+static struct keydata {
+	__u32 count; /* already shifted to the final position */
+	__u32 secret[12];
+} ____cacheline_aligned ip_keydata[2];
+
+static unsigned int ip_cnt;
+
+static void rekey_seq_generator(void *private_)
+{
+	struct keydata *keyptr = &ip_keydata[1 ^ (ip_cnt & 1)];
+
+	get_random_bytes(keyptr->secret, sizeof(keyptr->secret));
+	keyptr->count = (ip_cnt & COUNT_MASK) << HASH_BITS;
+	smp_wmb();
+	ip_cnt++;
+	schedule_delayed_work(&rekey_work, REKEY_INTERVAL);
+}
+
+static __init int seqgen_init(void)
+{
+	rekey_seq_generator(NULL);
+	return 0;
+}
+late_initcall(seqgen_init);
+
+static struct keydata *get_keyptr(void)
+{
+	struct keydata *keyptr = &ip_keydata[ip_cnt & 1];
+
+	smp_rmb();
+
+	return keyptr;
+}
+
+__u32 secure_tcp_sequence_number(__u32 saddr, __u32 daddr,
+				 __u16 sport, __u16 dport)
+{
+	struct timeval tv;
+	__u32 seq;
+	__u32 hash[4];
+	struct keydata *keyptr = get_keyptr();
+
+	/*
+	 *  Pick a unique starting offset for each TCP connection endpoints
+	 *  (saddr, daddr, sport, dport).
+	 *  Note that the words are placed into the starting vector, which is
+	 *  then mixed with a partial MD4 over random data.
+	 */
+	hash[0]=saddr;
+	hash[1]=daddr;
+	hash[2]=(sport << 16) + dport;
+	hash[3]=keyptr->secret[11];
+
+	seq = half_md4_transform(hash, keyptr->secret) & HASH_MASK;
+	seq += keyptr->count;
+	/*
+	 *	As close as possible to RFC 793, which
+	 *	suggests using a 250 kHz clock.
+	 *	Further reading shows this assumes 2 Mb/s networks.
+	 *	For 10 Mb/s Ethernet, a 1 MHz clock is appropriate.
+	 *	That's funny, Linux has one built in!  Use it!
+	 *	(Networks are faster now - should this be increased?)
+	 */
+	do_gettimeofday(&tv);
+	seq += tv.tv_usec + tv.tv_sec * 1000000;
+	return seq;
+}
+
+EXPORT_SYMBOL(secure_tcp_sequence_number);
+
+/*  The code below is shamelessly stolen from secure_tcp_sequence_number().
+ *  All blames to Andrey V. Savochkin <saw@msu.ru>.
+ */
+__u32 secure_ip_id(__u32 daddr)
+{
+	struct keydata *keyptr;
+	__u32 hash[4];
+
+	keyptr = get_keyptr();
+
+	/*
+	 *  Pick a unique starting offset for each IP destination.
+	 *  The dest ip address is placed in the starting vector,
+	 *  which is then hashed with random data.
+	 */
+	hash[0] = daddr;
+	hash[1] = keyptr->secret[9];
+	hash[2] = keyptr->secret[10];
+	hash[3] = keyptr->secret[11];
+
+	return half_md4_transform(hash, keyptr->secret);
+}
+
+/* Generate secure starting point for ephemeral TCP port search */
+u32 secure_tcp_port_ephemeral(__u32 saddr, __u32 daddr, __u16 dport)
+{
+	struct keydata *keyptr = get_keyptr();
+	u32 hash[4];
+
+	/*
+	 *  Pick a unique starting offset for each ephemeral port search
+	 *  (saddr, daddr, dport) and 48bits of random data.
+	 */
+	hash[0] = saddr;
+	hash[1] = daddr;
+	hash[2] = dport ^ keyptr->secret[10];
+	hash[3] = keyptr->secret[11];
+
+	return half_md4_transform(hash, keyptr->secret);
+}
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+
+/* F, G and H are basic MD4 functions: selection, majority, parity */
+#define F(x, y, z) ((z) ^ ((x) & ((y) ^ (z))))
+#define G(x, y, z) (((x) & (y)) + (((x) ^ (y)) & (z)))
+#define H(x, y, z) ((x) ^ (y) ^ (z))
+
+/*
+ * The generic round function.  The application is so specific that
+ * we don't bother protecting all the arguments with parens, as is generally
+ * good macro practice, in favor of extra legibility.
+ * Rotation is separate from addition to prevent recomputation
+ */
+#define ROUND(f, a, b, c, d, x, s)	\
+	(a += f(b, c, d) + x, a = (a << s) | (a >> (32 - s)))
+#define K1 0
+#define K2 013240474631UL
+#define K3 015666365641UL
+
+static __u32 twothirdsMD4Transform (__u32 const buf[4], __u32 const in[12])
+{
+	__u32 a = buf[0], b = buf[1], c = buf[2], d = buf[3];
+
+	/* Round 1 */
+	ROUND(F, a, b, c, d, in[ 0] + K1,  3);
+	ROUND(F, d, a, b, c, in[ 1] + K1,  7);
+	ROUND(F, c, d, a, b, in[ 2] + K1, 11);
+	ROUND(F, b, c, d, a, in[ 3] + K1, 19);
+	ROUND(F, a, b, c, d, in[ 4] + K1,  3);
+	ROUND(F, d, a, b, c, in[ 5] + K1,  7);
+	ROUND(F, c, d, a, b, in[ 6] + K1, 11);
+	ROUND(F, b, c, d, a, in[ 7] + K1, 19);
+	ROUND(F, a, b, c, d, in[ 8] + K1,  3);
+	ROUND(F, d, a, b, c, in[ 9] + K1,  7);
+	ROUND(F, c, d, a, b, in[10] + K1, 11);
+	ROUND(F, b, c, d, a, in[11] + K1, 19);
+
+	/* Round 2 */
+	ROUND(G, a, b, c, d, in[ 1] + K2,  3);
+	ROUND(G, d, a, b, c, in[ 3] + K2,  5);
+	ROUND(G, c, d, a, b, in[ 5] + K2,  9);
+	ROUND(G, b, c, d, a, in[ 7] + K2, 13);
+	ROUND(G, a, b, c, d, in[ 9] + K2,  3);
+	ROUND(G, d, a, b, c, in[11] + K2,  5);
+	ROUND(G, c, d, a, b, in[ 0] + K2,  9);
+	ROUND(G, b, c, d, a, in[ 2] + K2, 13);
+	ROUND(G, a, b, c, d, in[ 4] + K2,  3);
+	ROUND(G, d, a, b, c, in[ 6] + K2,  5);
+	ROUND(G, c, d, a, b, in[ 8] + K2,  9);
+	ROUND(G, b, c, d, a, in[10] + K2, 13);
+
+	/* Round 3 */
+	ROUND(H, a, b, c, d, in[ 3] + K3,  3);
+	ROUND(H, d, a, b, c, in[ 7] + K3,  9);
+	ROUND(H, c, d, a, b, in[11] + K3, 11);
+	ROUND(H, b, c, d, a, in[ 2] + K3, 15);
+	ROUND(H, a, b, c, d, in[ 6] + K3,  3);
+	ROUND(H, d, a, b, c, in[10] + K3,  9);
+	ROUND(H, c, d, a, b, in[ 1] + K3, 11);
+	ROUND(H, b, c, d, a, in[ 5] + K3, 15);
+	ROUND(H, a, b, c, d, in[ 9] + K3,  3);
+	ROUND(H, d, a, b, c, in[ 0] + K3,  9);
+	ROUND(H, c, d, a, b, in[ 4] + K3, 11);
+	ROUND(H, b, c, d, a, in[ 8] + K3, 15);
+
+	return buf[1] + b; /* "most hashed" word */
+	/* Alternative: return sum of all words? */
+}
+#undef ROUND
+#undef F
+#undef G
+#undef H
+#undef K1
+#undef K2
+#undef K3
+
+__u32 secure_tcpv6_sequence_number(__u32 *saddr, __u32 *daddr,
+				   __u16 sport, __u16 dport)
+{
+	struct timeval tv;
+	__u32 seq;
+	__u32 hash[12];
+	struct keydata *keyptr = get_keyptr();
+
+	/* The procedure is the same as for IPv4, but addresses are longer.
+	 * Thus we must use twothirdsMD4Transform.
+	 */
+
+	memcpy(hash, saddr, 16);
+	hash[4]=(sport << 16) + dport;
+	memcpy(&hash[5],keyptr->secret,sizeof(__u32) * 7);
+
+	seq = twothirdsMD4Transform(daddr, hash) & HASH_MASK;
+	seq += keyptr->count;
+
+	do_gettimeofday(&tv);
+	seq += tv.tv_usec + tv.tv_sec * 1000000;
+
+	return seq;
+}
+EXPORT_SYMBOL(secure_tcpv6_sequence_number);
+#endif
Index: rnd2/include/linux/random.h
===================================================================
--- rnd2.orig/include/linux/random.h	2005-01-20 10:16:24.202364968 -0800
+++ rnd2/include/linux/random.h	2005-01-20 10:16:59.321887610 -0800
@@ -51,13 +51,6 @@
 extern void get_random_bytes(void *buf, int nbytes);
 void generate_random_uuid(unsigned char uuid_out[16]);
 
-extern __u32 secure_ip_id(__u32 daddr);
-extern u32 secure_tcp_port_ephemeral(__u32 saddr, __u32 daddr, __u16 dport);
-extern __u32 secure_tcp_sequence_number(__u32 saddr, __u32 daddr,
-					__u16 sport, __u16 dport);
-extern __u32 secure_tcpv6_sequence_number(__u32 *saddr, __u32 *daddr,
-					  __u16 sport, __u16 dport);
-
 #ifndef MODULE
 extern struct file_operations random_fops, urandom_fops;
 #endif
