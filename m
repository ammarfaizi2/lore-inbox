Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbUBQBeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 20:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265714AbUBQBeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 20:34:50 -0500
Received: from h80ad244c.async.vt.edu ([128.173.36.76]:41348 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265607AbUBQBeZ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 20:34:25 -0500
Message-Id: <200402170134.i1H1YIAW016949@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH} 2.6 and grsecurity
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Feb 2004 20:34:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the most recent grsecurity patch from http://www.grsecurity.net,
it becomes pretty obvious that there are 3 basic types of things in it:

1) Things that are doable using the LSM framework.
2) The PAX non-executable/randomized address code.
3) various small things that aren't either of the above.

Attached is a patch that picks off at least the low-hanging fruit of (3)
(randomized PIDs, and randomized IPv4 TCP ports, IP IDs, ISNs,
and RPC XIDs).

Known strong points:

1) I've actually been running the code for several days with no ill effects.
2) I believe that it's only as invasive as you want - if none of the new features
are selected, no code paths are altered (although in 3 places or so I had to add
otherwise extraneous { } for proper grouping).

Known issues:

1) These things *do* drain the entropy pool slightly, so they may not be
appropriate for systems that have other stuff draining the pool constantly.
2) Style issue - I've got blocks of 'extern' declarations in some files
mostly because I wasn't sure which include/linux/*.h file they should go in.
(I considered security.h, but that's dedicated to LSM hooks, it appears).
Also, (for example) kernel/pid.c doesn't include security.h, and it wasn't
clear which was less namespace pollution, including that whole thing for
one 'extern int' declaration, or what I actually did)
3) The sense of the 'security_lock' sysctl is backwards from the grsecurity
patch - mine has '0=locked 1=enabled'.  Should I change the sysctl name?
4) Too drastic for 2.6? Should this be a 2.7 thing?
5) Any other stylistic/technical issues I managed to overlook. ;)

Here's the patch, versioned against 2.6.3-rc3-mm1. Comments?

--- linux-2.6.3-rc3-mm1/include/linux/sysctl.h.secure	2004-02-16 11:13:55.000000000 -0500
+++ linux-2.6.3-rc3-mm1/include/linux/sysctl.h	2004-02-16 11:14:15.000000000 -0500
@@ -61,7 +61,10 @@
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
+	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+#ifdef CONFIG_SECURITY_SYSCTL
+	CTL_SECURITY=11		/* Security toggles */
+#endif
 };
 
 /* CTL_BUS names: */
@@ -729,6 +732,19 @@
 	ABI_FAKE_UTSNAME=6,	/* fake target utsname information */
 };
 
+#ifdef CONFIG_SECURITY_SYSCTL
+/* /proc/sys/security */
+enum
+{
+	SECURITY_RANDPID=1,	/* Randomize process IDs */
+	SECURITY_RANDID=2,	/* Randomize IP packet IDs */
+	SECURITY_RANDISN=3,	/* Randomize TCP ISN values */
+	SECURITY_RANDSRC=4,	/* Randomize TCP source ports */
+	SECURITY_RANDRPC=5,	/* Randomize RPC XIDs */
+	SECURITY_SYSCTL=6,	/* Lockdown value for the others */
+};
+#endif
+
 #ifdef __KERNEL__
 
 extern void sysctl_init(void);
@@ -749,6 +765,10 @@
 			 void __user *, size_t *);
 extern int proc_dointvec_bset(ctl_table *, int, struct file *,
 			      void __user *, size_t *);
+#ifdef CONFIG_SECURITY_SYSCTL
+extern int proc_dointvec_security(ctl_table *, int, struct file *,
+			      void __user *, size_t *);
+#endif
 extern int proc_dointvec_minmax(ctl_table *, int, struct file *,
 				void __user *, size_t *);
 extern int proc_dointvec_jiffies(ctl_table *, int, struct file *,
--- linux-2.6.3-rc3-mm1/include/net/inetpeer.h.secure	2003-09-27 20:50:08.000000000 -0400
+++ linux-2.6.3-rc3-mm1/include/net/inetpeer.h	2004-02-16 11:14:15.000000000 -0500
@@ -34,6 +34,12 @@
 /* can be called with or without local BH being disabled */
 struct inet_peer	*inet_getpeer(__u32 daddr, int create);
 
+#ifdef CONFIG_SECURITY_NEEDIPRAND
+extern int security_enable_randid;
+extern __u16 ip_randomid(void);
+extern __u32 ip_randomisn(void);
+#endif
+
 extern spinlock_t inet_peer_unused_lock;
 extern struct inet_peer *inet_peer_unused_head;
 extern struct inet_peer **inet_peer_unused_tailp;
@@ -58,7 +64,12 @@
 	__u16 id;
 
 	spin_lock_bh(&inet_peer_idlock);
-	id = p->ip_id_count;
+#ifdef CONFIG_SECURITY_RANDID
+	if (security_enable_randid)
+		id = ip_randomid();
+	else
+#endif
+		id = p->ip_id_count;
 	p->ip_id_count += 1 + more;
 	spin_unlock_bh(&inet_peer_idlock);
 	return id;
--- linux-2.6.3-rc3-mm1/include/net/ip.h.secure	2003-09-27 20:50:36.000000000 -0400
+++ linux-2.6.3-rc3-mm1/include/net/ip.h	2004-02-16 11:14:15.000000000 -0500
@@ -66,6 +66,12 @@
 	void			(*destructor)(struct sock *);
 };
 
+#ifdef CONFIG_SECURITY_NEEDIPRAND
+extern int security_enable_randid;
+extern __u16 ip_randomid(void);
+extern __u32 ip_randomisn(void);
+#endif
+
 extern struct ip_ra_chain *ip_ra_chain;
 extern rwlock_t ip_ra_lock;
 
@@ -194,6 +200,11 @@
 		 * does not change, they drop every other packet in
 		 * a TCP stream using header compression.
 		 */
+#ifdef CONFIG_SECURITY_RANDID
+		if (security_enable_randid)
+			iph->id = ip_randomid();
+		else
+#endif
 		iph->id = (sk && inet_sk(sk)->daddr) ?
 					htons(inet_sk(sk)->id++) : 0;
 	} else
--- linux-2.6.3-rc3-mm1/kernel/pid.c.secure	2004-02-16 11:13:55.000000000 -0500
+++ linux-2.6.3-rc3-mm1/kernel/pid.c	2004-02-16 11:14:15.000000000 -0500
@@ -26,6 +26,11 @@
 #include <linux/bootmem.h>
 #include <linux/hash.h>
 
+#ifdef CONFIG_SECURITY_RANDPID
+#include <linux/random.h>
+extern int security_enable_randpid;
+#endif
+
 #define pid_hashfn(nr) hash_long((unsigned long)nr, pidhash_shift)
 static struct list_head *pid_hash[PIDTYPE_MAX];
 static int pidhash_shift;
@@ -102,6 +107,13 @@
 	int pid, offset, max_steps = PIDMAP_ENTRIES + 1;
 	pidmap_t *map;
 
+#ifdef CONFIG_SECURITY_RANDPID
+	unsigned int randpid;
+	if (security_enable_randpid && (last_pid >= RESERVED_PIDS)) {
+		get_random_bytes(&randpid,sizeof(randpid));
+		pid = (randpid % (pid_max - RESERVED_PIDS)) + RESERVED_PIDS + 1;
+	} else
+#endif
 	pid = last_pid + 1;
 	if (pid >= pid_max)
 		pid = RESERVED_PIDS;
--- linux-2.6.3-rc3-mm1/kernel/sysctl.c.secure	2004-02-16 11:13:55.000000000 -0500
+++ linux-2.6.3-rc3-mm1/kernel/sysctl.c	2004-02-16 12:25:45.000000000 -0500
@@ -137,6 +137,27 @@
 extern ctl_table pty_table[];
 #endif
 
+#ifdef CONFIG_SECURITY_SYSCTL
+static ctl_table security_table[];
+
+extern int security_enable_sysctl;
+#ifdef CONFIG_SECURITY_RANDPID
+extern int security_enable_randpid;
+#endif
+#ifdef CONFIG_SECURITY_RANDID
+extern int security_enable_randid;
+#endif
+#ifdef CONFIG_SECURITY_RANDISN
+extern int security_enable_randisn;
+#endif
+#ifdef CONFIG_SECURITY_RANDSRC
+extern int security_enable_randsrc;
+#endif
+#ifdef CONFIG_SECURITY_RANDRPC
+extern int security_enable_randrpc;
+#endif
+#endif
+
 /* /proc declarations: */
 
 #ifdef CONFIG_PROC_FS
@@ -204,6 +225,14 @@
 		.mode		= 0555,
 		.child		= dev_table,
 	},
+#ifdef CONFIG_SECURITY_SYSCTL
+	{
+		.ctl_name	= CTL_SECURITY,
+		.procname	= "security",
+		.mode		= 0555,
+		.child		= security_table,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
@@ -866,6 +895,73 @@
 	{ .ctl_name = 0 }
 };  
 
+#ifdef CONFIG_SECURITY_SYSCTL
+static ctl_table security_table[] = {
+#ifdef CONFIG_SECURITY_RANDPID
+	{
+		.ctl_name	= SECURITY_RANDPID,
+		.procname	= "rand_pids",
+		.data		= &security_enable_randpid,
+		.maxlen		= sizeof(security_enable_randpid),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_security,
+	},
+#endif
+#ifdef CONFIG_SECURITY_RANDID
+	{
+		.ctl_name	= SECURITY_RANDID,
+		.procname	= "rand_ip_ids",
+		.data		= &security_enable_randid,
+		.maxlen		= sizeof(security_enable_randid),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_security,
+	},
+#endif
+#ifdef CONFIG_SECURITY_RANDISN
+	{
+		.ctl_name	= SECURITY_RANDISN,
+		.procname	= "rand_isns",
+		.data		= &security_enable_randisn,
+		.maxlen		= sizeof(security_enable_randisn),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_security,
+	},
+#endif
+#ifdef CONFIG_SECURITY_RANDSRC
+	{
+		.ctl_name	= SECURITY_RANDSRC,
+		.procname	= "rand_tcp_src_ports",
+		.data		= &security_enable_randsrc,
+		.maxlen		= sizeof(security_enable_randsrc),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_security,
+	},
+#endif
+#ifdef CONFIG_SECURITY_RANDRPC
+	{
+		.ctl_name	= SECURITY_RANDRPC,
+		.procname	= "rand_rpc",
+		.data		= &security_enable_randrpc,
+		.maxlen		= sizeof(security_enable_randrpc),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_security,
+	},
+#endif
+#ifdef CONFIG_SECURITY_SYSCTL
+	{
+		.ctl_name	= SECURITY_SYSCTL,
+		.procname	= "security_lock",
+		.data		= &security_enable_sysctl,
+		.maxlen		= sizeof(security_enable_sysctl),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_security,
+	},
+#endif
+	{ .ctl_name = 0 }
+};  
+
+#endif
+
 extern void init_irq_proc (void);
 
 void __init sysctl_init(void)
@@ -1586,6 +1682,20 @@
 				do_proc_dointvec_bset_conv,&op);
 }
 
+#ifdef CONFIG_SECURITY_SYSCTL
+int proc_dointvec_security(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp)
+{
+	if (write && !security_enable_sysctl) {
+		return -EPERM;
+	}
+
+	return do_proc_dointvec(table,write,filp,buffer,lenp,
+				do_proc_dointvec_conv,NULL);
+}
+
+#endif
+
 struct do_proc_dointvec_minmax_conv_param {
 	int *min;
 	int *max;
--- linux-2.6.3-rc3-mm1/net/ipv4/Makefile.secure	2003-09-27 20:50:13.000000000 -0400
+++ linux-2.6.3-rc3-mm1/net/ipv4/Makefile	2004-02-16 11:14:15.000000000 -0500
@@ -22,5 +22,6 @@
 obj-$(CONFIG_IP_PNP) += ipconfig.o
 obj-$(CONFIG_NETFILTER)	+= netfilter/
 obj-$(CONFIG_IP_VS) += ipvs/
+obj-$(CONFIG_SECURITY_NEEDIPRAND) += obsd_rand.o
 
 obj-$(CONFIG_XFRM) += xfrm4_policy.o xfrm4_state.o xfrm4_input.o xfrm4_tunnel.o
--- linux-2.6.3-rc3-mm1/net/ipv4/af_inet.c.secure	2004-02-05 05:27:26.000000000 -0500
+++ linux-2.6.3-rc3-mm1/net/ipv4/af_inet.c	2004-02-16 11:14:15.000000000 -0500
@@ -387,6 +387,11 @@
 	else
 		inet->pmtudisc = IP_PMTUDISC_WANT;
 
+#ifdef CONFIG_SECURITY_RANDID
+	if (security_enable_randid)
+		inet->id = htons(ip_randomid());
+	else
+#endif
 	inet->id = 0;
 
 	sock_init_data(sock, sk);
--- linux-2.6.3-rc3-mm1/net/ipv4/ip_output.c.secure	2004-02-05 05:27:26.000000000 -0500
+++ linux-2.6.3-rc3-mm1/net/ipv4/ip_output.c	2004-02-16 11:14:15.000000000 -0500
@@ -1152,6 +1152,12 @@
 	if (!df) {
 		__ip_select_ident(iph, &rt->u.dst, 0);
 	} else {
+#ifdef CONFIG_SECURITY_RANDID
+		if (security_enable_randid) {
+			iph->id = ip_randomid();
+			inet->id = ip_randomid();
+		} else
+#endif
 		iph->id = htons(inet->id++);
 	}
 	iph->ttl = ttl;
--- linux-2.6.3-rc3-mm1/net/ipv4/obsd_rand.c.secure	2004-02-16 11:14:15.000000000 -0500
+++ linux-2.6.3-rc3-mm1/net/ipv4/obsd_rand.c	2004-02-16 11:14:15.000000000 -0500
@@ -0,0 +1,201 @@
+
+/*
+ * Copyright (c) 1996, 1997, 2000-2002 Michael Shalayeff.
+ * 
+ * Version 1.89, last modified 19-Sep-99
+ *    
+ * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.
+ * All rights reserved.
+ *
+ * Copyright 1998 Niels Provos <provos@citi.umich.edu>
+ * All rights reserved.
+ * Theo de Raadt <deraadt@openbsd.org> came up with the idea of using
+ * such a mathematical system to generate more random (yet non-repeating)
+ * ids to solve the resolver/named problem.  But Niels designed the
+ * actual system based on the constraints.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer,
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. All advertising materials mentioning features or use of this software
+ *    must display the following acknowledgement:
+ *    This product includes software developed by Niels Provos.
+ * 4. The name of the author may not be used to endorse or promote products
+ *    derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/smp_lock.h>
+#include <linux/random.h>
+
+#define RU_OUT 180
+#define RU_MAX 30000
+#define RU_GEN 2
+#define RU_N 32749
+#define RU_AGEN 7
+#define RU_M 31104
+#define PFAC_N 3
+const static __u16 pfacts[PFAC_N] = { 2, 3, 2729 };
+
+static __u16 ru_x;
+static __u16 ru_seed, ru_seed2;
+static __u16 ru_a, ru_b;
+static __u16 ru_g;
+static __u16 ru_counter = 0;
+static __u16 ru_msb = 0;
+static unsigned long ru_reseed = 0;
+
+#define TCP_RNDISS_ROUNDS	15
+#define TCP_RNDISS_OUT		7200
+#define TCP_RNDISS_MAX		30000
+
+static __u8 tcp_rndiss_sbox[NR_CPUS][128];
+static __u16 tcp_rndiss_msb[NR_CPUS];
+static __u16 tcp_rndiss_cnt[NR_CPUS];
+static unsigned long tcp_rndiss_reseed[NR_CPUS];
+
+static __u16 pmod(__u16, __u16, __u16);
+static void ip_initid(void);
+__u16 ip_randomid(void);
+
+static __u16
+pmod(__u16 gen, __u16 exp, __u16 mod)
+{
+	__u16 s, t, u;
+
+	s = 1;
+	t = gen;
+	u = exp;
+
+	while (u) {
+		if (u & 1)
+			s = (s * t) % mod;
+		u >>= 1;
+		t = (t * t) % mod;
+	}
+	return (s);
+}
+
+static void
+ip_initid(void)
+{
+	__u32 tmp;
+	int noprime = 1;
+	__u16 j, i;
+
+	get_random_bytes(&tmp,4);
+	ru_x = (tmp & 0xFFFF) % RU_M;
+
+	get_random_bytes(&tmp,4);
+	ru_seed = (tmp >> 16) & 0x7FFF;
+	ru_seed2 = tmp & 0x7FFF;
+
+	get_random_bytes(&tmp,4);
+	ru_b = (tmp & 0xfffe) | 1;
+	ru_a = pmod(RU_AGEN, (tmp >> 16) & 0xfffe, RU_M);
+	while (ru_b % 3 == 0)
+		ru_b += 2;
+
+	get_random_bytes(&tmp,4);
+	j = tmp % RU_N;
+	tmp = tmp >> 16;
+
+	while (noprime) {
+		for (i = 0; i < PFAC_N; i++)
+			if (j % pfacts[i] == 0)
+				break;
+
+		if (i >= PFAC_N)
+			noprime = 0;
+		else
+			j = (j + 1) % RU_N;
+	}
+
+	ru_g = pmod(RU_GEN, j, RU_N);
+	ru_counter = 0;
+
+	ru_reseed = xtime.tv_sec + RU_OUT;
+	ru_msb = ru_msb == 0x8000 ? 0 : 0x8000;
+}
+
+__u16
+ip_randomid(void)
+{
+	int i, n;
+	__u32 tmp;
+
+	if (ru_counter >= RU_MAX || time_after((unsigned long) xtime.tv_sec, ru_reseed))
+		ip_initid();
+
+	if (!tmp)
+		get_random_bytes(&tmp,4);
+
+	n = tmp & 0x3;
+	tmp = tmp >> 2;
+	if (ru_counter + n >= RU_MAX)
+		ip_initid();
+	for (i = 0; i <= n; i++)
+		ru_x = (ru_a * ru_x + ru_b) % RU_M;
+	ru_counter += i;
+
+	return ((ru_seed ^ pmod(ru_g, ru_seed2 ^ ru_x, RU_N)) | ru_msb);
+}
+
+__u16
+tcp_rndiss_encrypt(__u16 val)
+{
+	__u16 sum = 0, i;
+	int cpu = smp_processor_id();
+
+	for (i = 0; i < TCP_RNDISS_ROUNDS; i++) {
+		sum += 0x79b9;
+		val ^= ((__u16) tcp_rndiss_sbox[cpu][(val ^ sum) ^ 0x7f]) << 7;
+		val = ((val & 0xff) << 7) | (val >> 8);
+	}
+
+	return val;
+}
+
+static void
+tcp_rndiss_init(void)
+{
+	int cpu = smp_processor_id();
+
+	get_random_bytes(tcp_rndiss_sbox[cpu], sizeof (tcp_rndiss_sbox));
+	tcp_rndiss_reseed[cpu] = xtime.tv_sec + TCP_RNDISS_OUT;
+	tcp_rndiss_msb[cpu] = tcp_rndiss_msb[cpu] == 0x8000 ? 0 : 0x8000;
+	tcp_rndiss_cnt[cpu] = 0;
+}
+
+__u32
+ip_randomisn(void)
+{
+	__u32 tmp;
+	int cpu = smp_processor_id();
+
+	if (tcp_rndiss_cnt[cpu] >= TCP_RNDISS_MAX ||
+	    time_after((unsigned long) xtime.tv_sec, tcp_rndiss_reseed[cpu]))
+		tcp_rndiss_init();
+
+	get_random_bytes(&tmp,4);
+	return (((tcp_rndiss_encrypt(tcp_rndiss_cnt[cpu]++) |
+		  tcp_rndiss_msb[cpu]) << 16) | (tmp & 0x7fff));
+}
--- linux-2.6.3-rc3-mm1/net/ipv4/tcp_ipv4.c.secure	2004-02-16 11:13:18.000000000 -0500
+++ linux-2.6.3-rc3-mm1/net/ipv4/tcp_ipv4.c	2004-02-16 11:14:15.000000000 -0500
@@ -85,6 +85,17 @@
 /* Socket used for sending RSTs */
 static struct socket *tcp_socket;
 
+/* Various security enhancements */
+#ifdef CONFIG_SECURITY_RANDSRC
+extern int security_enable_randsrc;
+#endif
+#ifdef CONFIG_SECURITY_RANDISN
+extern int security_enable_randisn;
+#endif
+#ifdef CONFIG_SECURITY_RANDID
+extern int security_enable_randid;
+#endif
+
 void tcp_v4_send_check(struct sock *sk, struct tcphdr *th, int len,
 		       struct sk_buff *skb);
 
@@ -224,9 +235,18 @@
 		spin_lock(&tcp_portalloc_lock);
 		rover = tcp_port_rover;
 		do {
+#ifdef CONFIG_SECURITY_RANDSRC
+			if (security_enable_randsrc && (high > low)) {
+				int randport;
+				get_random_bytes(&randport,sizeof(randport));
+				rover = low + (randport % (high - low));
+			} else
+#endif
+			{
 			rover++;
 			if (rover < low || rover > high)
 				rover = low;
+			}
 			head = &tcp_bhash[tcp_bhashfn(rover)];
 			spin_lock(&head->lock);
 			tb_for_each(tb, node, &head->chain)
@@ -537,6 +557,11 @@
 
 static inline __u32 tcp_v4_init_sequence(struct sock *sk, struct sk_buff *skb)
 {
+#ifdef CONFIG_SECURITY_RANDISN
+	if (likely(security_enable_randisn)) 
+		return ip_randomisn();
+	else
+#endif
 	return secure_tcp_sequence_number(skb->nh.iph->daddr,
 					  skb->nh.iph->saddr,
 					  skb->h.th->dest,
@@ -671,9 +696,18 @@
  		rover = tcp_port_rover;
 
  		do {
+#ifdef CONFIG_SECURITY_RANDSRC
+			if (security_enable_randsrc && (high > low)) {
+				int randport;
+				get_random_bytes(&randport,sizeof(randport));
+				rover = low + (randport % (high - low));
+			} else
+#endif
+			{
  			rover++;
  			if ((rover < low) || (rover > high))
  				rover = low;
+			}
  			head = &tcp_bhash[tcp_bhashfn(rover)];
  			spin_lock(&head->lock);
 
@@ -843,12 +877,23 @@
 	tcp_v4_setup_caps(sk, &rt->u.dst);
 	tp->ext2_header_len = rt->u.dst.header_len;
 
-	if (!tp->write_seq)
+	if (!tp->write_seq) {
+#ifdef CONFIG_SECURITY_RANDISN
+		if (likely(security_enable_randisn))
+			tp->write_seq = ip_randomisn();
+		else
+#endif
 		tp->write_seq = secure_tcp_sequence_number(inet->saddr,
 							   inet->daddr,
 							   inet->sport,
 							   usin->sin_port);
+	}
 
+#ifdef CONFIG_SECURITY_RANDID
+	if (security_enable_randid)
+		inet->id = ip_randomid();
+	else
+#endif
 	inet->id = tp->write_seq ^ jiffies;
 
 	err = tcp_connect(sk);
@@ -1593,6 +1638,11 @@
 	if (newinet->opt)
 		newtp->ext_header_len = newinet->opt->optlen;
 	newtp->ext2_header_len = dst->header_len;
+#ifdef CONFIG_SECURITY_RANDID
+	if (security_enable_randid) 
+		newinet->id = ip_randomid();
+	else
+#endif
 	newinet->id = newtp->write_seq ^ jiffies;
 
 	tcp_sync_mss(newsk, dst_pmtu(dst));
--- linux-2.6.3-rc3-mm1/net/ipv4/udp.c.secure	2004-02-05 05:27:26.000000000 -0500
+++ linux-2.6.3-rc3-mm1/net/ipv4/udp.c	2004-02-16 11:14:15.000000000 -0500
@@ -898,6 +898,11 @@
 	inet->daddr = rt->rt_dst;
 	inet->dport = usin->sin_port;
 	sk->sk_state = TCP_ESTABLISHED;
+#ifdef CONFIG_SECURITY_RANDID
+	if (security_enable_randid)
+		inet->id = ip_randomid();
+	else
+#endif
 	inet->id = jiffies;
 
 	sk_dst_set(sk, &rt->u.dst);
--- linux-2.6.3-rc3-mm1/net/sunrpc/xprt.c.secure	2004-02-16 11:13:20.000000000 -0500
+++ linux-2.6.3-rc3-mm1/net/sunrpc/xprt.c	2004-02-16 11:14:15.000000000 -0500
@@ -66,6 +66,12 @@
 #include <net/udp.h>
 #include <net/tcp.h>
 
+/* Security enhancements */
+#ifdef CONFIG_SECURITY_RANDRPC
+#include <linux/random.h>
+extern int security_enable_randrpc;
+#endif
+
 /*
  * Local variables
  */
@@ -1346,6 +1352,11 @@
 		xid = get_seconds() << 12;
 		need_init = 0;
 	}
+#ifdef CONFIG_SECURITY_RANDRPC
+	if (security_enable_randrpc)
+		get_random_bytes(&ret,sizeof(ret));
+	else
+#endif
 	ret = xid++;
 	spin_unlock(&xid_lock);
 	return ret;
--- linux-2.6.3-rc3-mm1/security/Kconfig.secure	2003-09-27 20:50:36.000000000 -0400
+++ linux-2.6.3-rc3-mm1/security/Kconfig	2004-02-16 12:10:52.000000000 -0500
@@ -46,5 +46,86 @@
 
 source security/selinux/Kconfig
 
+config SECURITY_RANDPID
+	bool "Randomized PID generation"
+	default n
+	help
+	  If you say Y here, all PIDs created on the system will be
+	  pseudo-randomly generated.  This is extremely effective along
+	  with the /proc restrictions to disallow an attacker from guessing
+	  pids of daemons, etc.  PIDs are also used in some cases as part
+	  of a naming system for temporary files, so this option would keep
+	  those filenames from being predicted as well.  We also use code
+	  to make sure that PID numbers aren't reused too soon.  If the sysctl
+	  option is enabled, a sysctl option with name "rand_pids" is created.
+
+config SECURITY_RANDID
+	bool "Randomized IP IDs"
+	default n
+	help
+	  If you say Y here, all the id field on all outgoing packets
+	  will be randomized.  This hinders os fingerprinters and
+	  keeps your machine from being used as a bounce for an untraceable
+	  portscan.  Ids are used for fragmented packets, fragments belonging
+	  to the same packet have the same id.  By default linux only
+	  increments the id value on each packet sent to an individual host.
+	  We use a port of the OpenBSD random ip id code to achieve the
+	  randomness, while keeping the possibility of id duplicates to
+	  near none.  If the sysctl option is enabled, a sysctl option with name
+	  "rand_ip_ids" is created.
+
+config SECURITY_RANDISN
+	bool "Randomized TCP ISN selection"
+	default n
+	help
+	  If you say Y here, Linux's default selection of TCP Initial Sequence
+	  Numbers (ISNs) will be replaced with that of OpenBSD.  Linux uses
+	  an MD4 hash based on the connection plus a time value to create the
+	  ISN, while OpenBSD's selection is random.  If the sysctl option is
+	  enabled, a sysctl option with name "rand_isns" is created.
+
+config SECURITY_RANDSRC
+	bool "Randomized TCP source ports"
+	default n
+	help
+	  If you say Y here, situations where a source port is generated on the
+	  fly for the TCP protocol (ie. with connect() ) will be altered so that
+	  the source port is generated at random, instead of a simple incrementing
+	  algorithm.  If the sysctl option is enabled, a sysctl option with name
+	  "rand_tcp_src_ports" is created.
+
+config SECURITY_RANDRPC
+	bool "Randomized RPC XIDs"
+	default n
+	help
+	  If you say Y here, the method of determining XIDs for RPC requests will
+	  be randomized, instead of using linux's default behavior of simply
+	  incrementing the XID.  If you want your RPC connections to be more
+	  secure, say Y here.  If the sysctl option is enabled, a sysctl option
+	  with name "rand_rpc" is created.
+
+config SECURITY_SYSCTL
+	bool "Security sysctl support"
+	default n
+	help
+	  If you say Y here, you will be able to change the options that
+	  grsecurity runs with at bootup, without having to recompile your
+	  kernel.  You can echo values to files in /proc/sys/kernel/security
+	  to enable (1) or disable (0) various features.  All the sysctl entries
+	  are mutable until the "security_lock" entry is set to a zero value.
+	  All features are disabled by default. Please note that this option could
+	  reduce the effectiveness of the added security of this patch if an ACL
+	  system is not put in place.  Your init scripts should be read-only, and
+	  root should not have access to adding modules or performing raw i/o
+	  operations.  All options should be set at startup, and the security_lock
+	  entry should be set to a non-zero value after all the options are set.
+	  *THIS IS EXTREMELY IMPORTANT*
+
+
+config SECURITY_NEEDIPRAND
+	def_bool SECURITY_RANDID || SECURITY_RANDISN || SECURITY_RANDSRC
+
+config SECURITY_MISC
+	def_bool SECURITY_NEEDIPRAND || SECURITY_RANDPID || SECURITY_SYSCTL
 endmenu
 
--- linux-2.6.3-rc3-mm1/security/Makefile.secure	2004-02-05 05:27:28.000000000 -0500
+++ linux-2.6.3-rc3-mm1/security/Makefile	2004-02-16 11:14:15.000000000 -0500
@@ -15,3 +15,4 @@
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
+obj-$(CONFIG_SECURITY_MISC)		+= misc_init.o
--- linux-2.6.3-rc3-mm1/security/misc_init.c.secure	2004-02-16 11:14:15.000000000 -0500
+++ linux-2.6.3-rc3-mm1/security/misc_init.c	2004-02-16 11:14:15.000000000 -0500
@@ -0,0 +1,43 @@
+/*
+ * Miscellaneous security features
+ *
+ * Copyright (C) 2004 Valdis Kletnieks <valdis.kletnieks@vt.edu>
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ *
+ * This code is based on the 'grsecurity' patch for the 2.4 kernel
+ * available from http://www.grsecurity.net
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+
+#ifdef CONFIG_SECURITY_RANDPID
+int security_enable_randpid = 1;
+#endif
+
+#ifdef CONFIG_SECURITY_RANDID
+int security_enable_randid = 1;
+#endif
+
+#ifdef CONFIG_SECURITY_RANDISN
+int security_enable_randisn = 1;
+#endif
+
+#ifdef CONFIG_SECURITY_RANDSRC
+int security_enable_randsrc = 1;
+#endif
+
+#ifdef CONFIG_SECURITY_RANDRPC
+int security_enable_randrpc = 1;
+#ifdef CONFIG_MODULES
+EXPORT_SYMBOL(security_enable_randrpc);
+#endif
+#endif
+
+#ifdef CONFIG_SECURITY_SYSCTL
+int security_enable_sysctl = 1;
+#endif


