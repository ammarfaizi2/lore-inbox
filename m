Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWJLRdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWJLRdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWJLRdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:33:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751052AbWJLRdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:33:11 -0400
Date: Thu, 12 Oct 2006 10:26:38 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] rename net_random to random32
Message-ID: <20061012102638.7381269a@freekitty>
In-Reply-To: <20061012000749.be62f2e0.akpm@osdl.org>
References: <200610111900.k9BJ01M4021853@hera.kernel.org>
	<452D4491.30806@garzik.org>
	<20061011122938.7e81f4bc@freekitty>
	<20061012000749.be62f2e0.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make net_random() more widely available by calling it random32

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
---
 include/linux/net.h    |    5 +-
 include/linux/random.h |    3 +
 lib/Makefile           |    2 -
 lib/random32.c         |  135 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/core/dev.c         |    2 -
 net/core/utils.c       |  116 -----------------------------------------
 6 files changed, 141 insertions(+), 122 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index c257f71..5d4240e 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -193,9 +193,8 @@ extern int 	     sock_map_fd(struct sock
 extern struct socket *sockfd_lookup(int fd, int *err);
 #define		     sockfd_put(sock) fput(sock->file)
 extern int	     net_ratelimit(void);
-extern unsigned long net_random(void);
-extern void	     net_srandom(unsigned long);
-extern void	     net_random_init(void);
+
+#define net_random()	random32()
 
 extern int   	     kernel_sendmsg(struct socket *sock, struct msghdr *msg,
 				    struct kvec *vec, size_t num, size_t len);
diff --git a/include/linux/random.h b/include/linux/random.h
index 5d6456b..0248b30 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -69,6 +69,9 @@ #endif
 unsigned int get_random_int(void);
 unsigned long randomize_range(unsigned long start, unsigned long end, unsigned long len);
 
+u32 random32(void);
+void srandom32(u32 seed);
+
 #endif /* __KERNEL___ */
 
 #endif /* _LINUX_RANDOM_H */
diff --git a/lib/Makefile b/lib/Makefile
index 59070db..bffdc82 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@ #
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o irq_regs.o carta_random32.o
+	 sha1.o irq_regs.o random32.o carta_random32.o
 
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
diff --git a/lib/random32.c b/lib/random32.c
new file mode 100644
index 0000000..a905769
--- /dev/null
+++ b/lib/random32.c
@@ -0,0 +1,135 @@
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
+static u32 __random32(struct nrnd_state *state)
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
+static void __set_random32(struct nrnd_state *state, unsigned long s)
+{
+	if (s == 0)
+		s = 1;      /* default seed is 1 */
+
+#define LCG(n) (69069 * n)
+	state->s1 = LCG(s);
+	state->s2 = LCG(state->s1);
+	state->s3 = LCG(state->s2);
+
+	/* "warm it up" */
+	__random32(state);
+	__random32(state);
+	__random32(state);
+	__random32(state);
+	__random32(state);
+	__random32(state);
+}
+
+/**
+ *	random32 - pseudo random number generator
+ *	
+ *	A 32 bit pseudo-random number is generated using a fast
+ *	algorithm suitable for simulation. This algorithm is NOT
+ *	considered safe for cryptographic use.
+ */
+u32 random32(void)
+{
+	unsigned long r;
+	struct nrnd_state *state = &get_cpu_var(net_rand_state);
+	r = __random32(state);
+	put_cpu_var(state);
+	return r;
+}
+EXPORT_SYMBOL(random32);
+
+/**
+ *	srandom32 - add entropy to pseudo random number generator
+ *	@seed: seed value
+ *
+ *	Add some additional seeding to the random32() pool.
+ *	Note: this pool is per cpu so it only affects current CPU.
+ */
+void srandom32(u32 entropy)
+{
+	struct nrnd_state *state = &get_cpu_var(net_rand_state);
+	__net_srandom(state, state->s1^entropy);
+	put_cpu_var(state);
+}
+EXPORT_SYMBOL(srandom32);
+
+/*
+ *	Generate some initially weak seeding values to allow
+ *	to start the random32() engine.
+ */
+static void __init random32_init(void)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct nrnd_state *state = &per_cpu(net_rand_state,i);
+		__net_srandom(state, i+jiffies);
+	}
+}
+core_initcall(random32_init);
+
+/*
+ *	Generate better values after random number generator
+ *	is fully initalized.
+ */
+static void __init random32_reseed(void)
+{
+	int i;
+	unsigned long seed;
+
+	for_each_possible_cpu(i) {
+		struct nrnd_state *state = &per_cpu(net_rand_state,i);
+
+		get_random_bytes(&seed, sizeof(seed));
+		__net_srandom(state, seed);
+	}
+	return 0;
+}
+late_initcall(random32_reseed);
diff --git a/net/core/dev.c b/net/core/dev.c
index 4d891be..81c426a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3502,8 +3502,6 @@ static int __init net_dev_init(void)
 
 	BUG_ON(!dev_boot_phase);
 
-	net_random_init();
-
 	if (dev_proc_init())
 		goto out;
 
diff --git a/net/core/utils.c b/net/core/utils.c
index 94c5d76..d93fe64 100644
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -30,119 +30,6 @@ #include <asm/byteorder.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
-/*
-  This is a maximally equidistributed combined Tausworthe generator
-  based on code from GNU Scientific Library 1.5 (30 Jun 2004)
-
-   x_n = (s1_n ^ s2_n ^ s3_n) 
-
-   s1_{n+1} = (((s1_n & 4294967294) <<12) ^ (((s1_n <<13) ^ s1_n) >>19))
-   s2_{n+1} = (((s2_n & 4294967288) << 4) ^ (((s2_n << 2) ^ s2_n) >>25))
-   s3_{n+1} = (((s3_n & 4294967280) <<17) ^ (((s3_n << 3) ^ s3_n) >>11))
-
-   The period of this generator is about 2^88.
-
-   From: P. L'Ecuyer, "Maximally Equidistributed Combined Tausworthe
-   Generators", Mathematics of Computation, 65, 213 (1996), 203--213.
-
-   This is available on the net from L'Ecuyer's home page,
-
-   http://www.iro.umontreal.ca/~lecuyer/myftp/papers/tausme.ps
-   ftp://ftp.iro.umontreal.ca/pub/simulation/lecuyer/papers/tausme.ps 
-
-   There is an erratum in the paper "Tables of Maximally
-   Equidistributed Combined LFSR Generators", Mathematics of
-   Computation, 68, 225 (1999), 261--269:
-   http://www.iro.umontreal.ca/~lecuyer/myftp/papers/tausme2.ps
-
-        ... the k_j most significant bits of z_j must be non-
-        zero, for each j. (Note: this restriction also applies to the 
-        computer code given in [4], but was mistakenly not mentioned in
-        that paper.)
-   
-   This affects the seeding procedure by imposing the requirement
-   s1 > 1, s2 > 7, s3 > 15.
-
-*/
-struct nrnd_state {
-	u32 s1, s2, s3;
-};
-
-static DEFINE_PER_CPU(struct nrnd_state, net_rand_state);
-
-static u32 __net_random(struct nrnd_state *state)
-{
-#define TAUSWORTHE(s,a,b,c,d) ((s&c)<<d) ^ (((s <<a) ^ s)>>b)
-
-	state->s1 = TAUSWORTHE(state->s1, 13, 19, 4294967294UL, 12);
-	state->s2 = TAUSWORTHE(state->s2, 2, 25, 4294967288UL, 4);
-	state->s3 = TAUSWORTHE(state->s3, 3, 11, 4294967280UL, 17);
-
-	return (state->s1 ^ state->s2 ^ state->s3);
-}
-
-static void __net_srandom(struct nrnd_state *state, unsigned long s)
-{
-	if (s == 0)
-		s = 1;      /* default seed is 1 */
-
-#define LCG(n) (69069 * n)
-	state->s1 = LCG(s);
-	state->s2 = LCG(state->s1);
-	state->s3 = LCG(state->s2);
-
-	/* "warm it up" */
-	__net_random(state);
-	__net_random(state);
-	__net_random(state);
-	__net_random(state);
-	__net_random(state);
-	__net_random(state);
-}
-
-
-unsigned long net_random(void)
-{
-	unsigned long r;
-	struct nrnd_state *state = &get_cpu_var(net_rand_state);
-	r = __net_random(state);
-	put_cpu_var(state);
-	return r;
-}
-
-
-void net_srandom(unsigned long entropy)
-{
-	struct nrnd_state *state = &get_cpu_var(net_rand_state);
-	__net_srandom(state, state->s1^entropy);
-	put_cpu_var(state);
-}
-
-void __init net_random_init(void)
-{
-	int i;
-
-	for_each_possible_cpu(i) {
-		struct nrnd_state *state = &per_cpu(net_rand_state,i);
-		__net_srandom(state, i+jiffies);
-	}
-}
-
-static int net_random_reseed(void)
-{
-	int i;
-	unsigned long seed;
-
-	for_each_possible_cpu(i) {
-		struct nrnd_state *state = &per_cpu(net_rand_state,i);
-
-		get_random_bytes(&seed, sizeof(seed));
-		__net_srandom(state, seed);
-	}
-	return 0;
-}
-late_initcall(net_random_reseed);
-
 int net_msg_cost = 5*HZ;
 int net_msg_burst = 10;
 
@@ -153,10 +40,7 @@ int net_ratelimit(void)
 {
 	return __printk_ratelimit(net_msg_cost, net_msg_burst);
 }
-
-EXPORT_SYMBOL(net_random);
 EXPORT_SYMBOL(net_ratelimit);
-EXPORT_SYMBOL(net_srandom);
 
 /*
  * Convert an ASCII string to binary IP.
-- 
1.4.1

