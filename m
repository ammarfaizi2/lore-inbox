Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268635AbUHLRtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268635AbUHLRtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268636AbUHLRtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:49:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:3272 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268635AbUHLRsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:48:54 -0400
Date: Thu, 12 Aug 2004 10:48:35 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [RFC] enhanced version of net_random()
Message-Id: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While doing the network emulator, I discovered that the default net_random()
is too stupid, and get_random_bytes() is more than needed. Rather than put
another function in just for sch_netem, how about making net_random() smarter?
The tin-hat crowd already replace net_random() with get_random_bytes anyway.

Here is a proposed alternative to use a longer period PRNG for net_random().
The choice of TT800 was because it was freely available, had a long period,
was fast and relatively small footprint. The existing net_random() was not
really thread safe, but was immune to thread corruption. 

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/net/core/utils.c b/net/core/utils.c
--- a/net/core/utils.c	2004-08-12 10:40:05 -07:00
+++ b/net/core/utils.c	2004-08-12 10:40:05 -07:00
@@ -2,6 +2,7 @@
  *	Generic address resultion entity
  *
  *	Authors:
+ *	net_random update to TT800 Stephen Hemminger
  *	net_random Alan Cox
  *	net_ratelimit Andy Kleen
  *
@@ -23,6 +24,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_EMBEDDED
 static unsigned long net_rand_seed = 152L;
 
 unsigned long net_random(void)
@@ -34,8 +36,79 @@
 void net_srandom(unsigned long entropy)
 {
 	net_rand_seed ^= entropy;
+ 	net_random();
+}
+#else
+/*
+ * This is the TT800 twisted Global Finite Shift Register random number
+ * generator originally by M. Matsumoto, email: matumoto@math.keio.ac.jp.
+ * July 8th 1996 Version 
+ *
+ * See: ACM Transactions on Modelling and Computer Simulation, 
+ * Vol. 4, No. 3, 1994, pages 254-266. 
+ *
+ * It has a large period 2^800 and good distribution properties
+ * up to dimension 25, and passes statistical tests.
+ *
+ * Don't use for cryptographic purposes, see get_random_bytes instead.
+ */
+#define N 25
+#define M 7
+
+static unsigned long net_rand_seed[N] = {
+	0x95f24dab, 0x0b685215, 0xe76ccae7, 0xaf3ec239, 0x715fad23,
+	0x24a590ad, 0x69e4b5ef, 0xbf456141, 0x96bc1b7b, 0xa7bdf825,
+	0xc1de75b7, 0x8858a9c9, 0x2da87693, 0xb657f9dd, 0xffdc8a9f,
+	0x8121da71, 0x8b823ecb, 0x885d05f5, 0x4e20cd47, 0x5a9ad5d9,
+	0x512c0c03, 0xea857ccd, 0x4cc1d30f, 0x8891a8a1, 0xa6b7aadb
+};
+
+static spinlock_t net_random_lock = SPIN_LOCK_UNLOCKED;
+
+unsigned long net_random(void)
+{
+	unsigned long y;
+	unsigned long flags;
+	static int k;
+	static const unsigned long mag01[2]={ 0x0, 0x8ebfd028 };
+#define X net_rand_seed
+
+	/* generate N words at one time */
+	spin_lock_irqsave(&net_random_lock, flags);
+	if (k == N) {
+		int kk;
+		for (kk=0; kk< N - M; kk++) {
+			X[kk] = X[kk+M] ^ (X[kk] >> 1) ^ mag01[X[kk] % 2];
+		}
+
+		for (; kk < N; kk++) {
+			X[kk] = X[kk+(M-N)] ^ (X[kk] >> 1) ^ mag01[X[kk] % 2];
+		}
+		k = 0;
+	}
+
+	y = X[k];
+	y ^= (y << 7) & 0x2b5b2500; /* s and b, magic vectors */
+	y ^= (y << 15) & 0xdb8b0000; /* t and c, magic vectors */
+
+	/* 
+	 * the following line was added by Makoto Matsumoto in the 1996 version
+	 * to improve lower bit's corellation.
+	 * Delete this line to o use the code published in 1994.
+	 */
+	y ^= (y >> 16); /* added to the 1994 version */
+	k++;
+	spin_unlock_irqrestore(&net_random_lock, flags);
+#undef X
+	return y;
+}
+
+void net_srandom(unsigned long entropy)
+{
+	net_rand_seed[0] ^= entropy;
 	net_random();
 }
+#endif
 
 int net_msg_cost = 5*HZ;
 int net_msg_burst = 10;
