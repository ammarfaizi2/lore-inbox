Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUHMSwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUHMSwQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 14:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUHMSwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 14:52:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:36798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266775AbUHMSwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:52:02 -0400
Date: Fri, 13 Aug 2004 11:51:40 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, tytso@mit.edu, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, Ben Greear <greearb@candelatech.com>
Subject: Re: [RFC] enhanced version of net_random()
Message-Id: <20040813115140.0f09d889@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040812124854.646f1936.davem@redhat.com>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
	<20040812124854.646f1936.davem@redhat.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another alternative, using tansworthe generator.  It uses percpu
state. The one small semantic change is the net_srandom() only affects
the current cpu's seed.  The problem was that having it change all cpu's
seed would mean adding locking and the only user's today are a couple of
places that feed in mac address to try make sure address resolution to
collide.

diff -Nru a/include/linux/net.h b/include/linux/net.h
--- a/include/linux/net.h	2004-08-13 11:48:43 -07:00
+++ b/include/linux/net.h	2004-08-13 11:48:43 -07:00
@@ -169,6 +169,7 @@
 extern int	     net_ratelimit(void);
 extern unsigned long net_random(void);
 extern void	     net_srandom(unsigned long);
+extern void	     net_random_init(void);
 
 extern int   	     kernel_sendmsg(struct socket *sock, struct msghdr *msg,
 				    struct kvec *vec, size_t num, size_t len);
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	2004-08-13 11:48:43 -07:00
+++ b/net/core/dev.c	2004-08-13 11:48:43 -07:00
@@ -3280,6 +3280,8 @@
 
 	BUG_ON(!dev_boot_phase);
 
+	net_random_init();
+
 	if (dev_proc_init())
 		goto out;
 
diff -Nru a/net/core/utils.c b/net/core/utils.c
--- a/net/core/utils.c	2004-08-13 11:48:43 -07:00
+++ b/net/core/utils.c	2004-08-13 11:48:43 -07:00
@@ -19,22 +19,116 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/random.h>
+#include <linux/percpu.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
-static unsigned long net_rand_seed = 152L;
+
+/*
+  This is a maximally equidistributed combined Tausworthe generator
+  based on code from GNU Scientific Library 1.5 (30 Jun 2004)
+
+   x_n = (s1_n ^ s2_n ^ s3_n) 
+
+   s1_{n+1} = (((s1_n & 4294967294) <<12) ^ (((s1_n <<13) ^ s1_n) >>19))
+   s2_{n+1} = (((s2_n & 4294967288) << 4) ^ (((s2_n << 2) ^ s2_n) >>25))
+   s3_{n+1} = (((s3_n & 4294967280) <<17) ^ (((s3_n << 3) ^ s3_n) >>11))
+
+   The period of this generator is about 2^88.
+
+   From: P. L'Ecuyer, "Maximally Equidistributed Combined Tausworthe
+   Generators", Mathematics of Computation, 65, 213 (1996), 203--213.
+
+   This is available on the net from L'Ecuyer's home page,
+
+   http://www.iro.umontreal.ca/~lecuyer/myftp/papers/tausme.ps
+   ftp://ftp.iro.umontreal.ca/pub/simulation/lecuyer/papers/tausme.ps 
+
+   There is an erratum in the paper "Tables of Maximally
+   Equidistributed Combined LFSR Generators", Mathematics of
+   Computation, 68, 225 (1999), 261--269:
+   http://www.iro.umontreal.ca/~lecuyer/myftp/papers/tausme2.ps
+
+        ... the k_j most significant bits of z_j must be non-
+        zero, for each j. (Note: this restriction also applies to the 
+        computer code given in [4], but was mistakenly not mentioned in
+        that paper.)
+   
+   This affects the seeding procedure by imposing the requirement
+   s1 > 1, s2 > 7, s3 > 15.
+
+*/
+struct nrnd_state {
+	u32 s1, s2, s3;
+};
+
+static DEFINE_PER_CPU(struct nrnd_state, net_rand_state);
+
+static u32 __net_random(struct nrnd_state *state)
+{
+#define TAUSWORTHE(s,a,b,c,d) ((s&c)<<d) ^ (((s <<a) ^ s)>>b)
+
+	state->s1 = TAUSWORTHE(state->s1, 13, 19, 4294967294UL, 12);
+	state->s2 = TAUSWORTHE(state->s2, 2, 25, 4294967288UL, 4);
+	state->s3 = TAUSWORTHE(state->s3, 3, 11, 4294967280UL, 17);
+
+	return (state->s1 ^ state->s2 ^ state->s3);
+}
+
+static void __net_srandom(struct nrnd_state *state, unsigned long entropy)
+{
+	u32 s = state->s1 ^ entropy;
+
+	if (s == 0)
+		s = 1;      /* default seed is 1 */
+
+#define LCG(n) (69069 * n)
+	state->s1 = LCG(s);
+	state->s2 = LCG(state->s1);
+	state->s3 = LCG(state->s2);
+
+	/* "warm it up" */
+	__net_random(state);
+	__net_random(state);
+	__net_random(state);
+	__net_random(state);
+	__net_random(state);
+	__net_random(state);
+}
+
 
 unsigned long net_random(void)
 {
-	net_rand_seed=net_rand_seed*69069L+1;
-        return net_rand_seed^jiffies;
+	unsigned long r;
+	struct nrnd_state *state = &get_cpu_var(net_rand_state);
+	r = __net_random(state);
+	put_cpu_var(state);
+	return r;
 }
 
+
 void net_srandom(unsigned long entropy)
 {
-	net_rand_seed ^= entropy;
-	net_random();
+	struct nrnd_state *state = &get_cpu_var(net_rand_state);
+	__net_srandom(state, entropy);
+	put_cpu_var(state);
+}
+
+void __init net_random_init(void)
+{
+	int i;
+	unsigned long seed[NR_CPUS];
+
+	get_random_bytes(seed, sizeof(seed));
+
+	for (i = 0; i < NR_CPUS; i++) {
+		struct nrnd_state *state = &per_cpu(net_rand_state,i);
+
+		memset(state, 0, sizeof(*state));
+		__net_srandom(state, seed[i]);
+	}
 }
 
 int net_msg_cost = 5*HZ;
