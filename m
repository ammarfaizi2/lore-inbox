Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVDDTXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVDDTXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVDDTXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:23:03 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.16]:32795 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261339AbVDDTVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:21:47 -0400
Subject: Re: linux-2.6.12-rc1-mm4-RT-V0.7.42-08
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050404174002.GA12306@elte.hu>
References: <1112433149.13131.8.camel@twins>
	 <1112507988.10235.3.camel@twins>  <20050404174002.GA12306@elte.hu>
Content-Type: multipart/mixed; boundary="=-ecSVBBUA+0MOn8uIxBJb"
Date: Mon, 04 Apr 2005 21:21:25 +0200
Message-Id: <1112642485.10235.22.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ecSVBBUA+0MOn8uIxBJb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-04-04 at 19:40 +0200, Ingo Molnar wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > Hi Ingo,
> > 
> > I need the following two patches to keep my system alive and avoid
> > the BUGs in the log send to you earlier (private mail).
> 
> hm, the second patch does not apply (and the merge didnt look trivial) - 
> maybe it depends on some patch in -mm that is not yet upstream?
> 

I messed it up; apparently I type :wa to often and forgot to keep a
decent base file (yes I'm a vim user). I also seem to have gotten the
patch base dir wrong.

The two patches again; now hopefully with correct patch level and proper
base. They apply to my tree in order 2.6.12-rc1-icmp{,-rt}.patch.

Not ran nor compile tested on vanilla; just made then apply cleanly.

Could you please comment on the patches since I'm learning this stuff as
I go; and validation of my ideas would be most welcome. For instance;
was I right to convert the per cpu var __icmp_socket to a _LOCKED?
I think so since without the extra lock one could have race conditions
within the spin_trylock arguments double dereference.

Kind regards,

Peter Zijlstra


--=-ecSVBBUA+0MOn8uIxBJb
Content-Disposition: attachment; filename=2.6.12-rc1-icmp.patch
Content-Type: text/x-patch; name=2.6.12-rc1-icmp.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



Since there is no lock held yet we are still preemptable; and since 
icmp_socket is a per cpu variable switching cpus gives weird results.


Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>


--- linux-2.6.12-rc1-RT-V0.7.42-08/net/ipv4/icmp_base.c	2005-04-04 20:26:23.000000000 +0200
+++ linux-2.6.12-rc1-RT-V0.7.42-08/net/ipv4/icmp.c	2005-04-04 20:26:38.000000000 +0200
@@ -376,8 +376,8 @@
 
 static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 {
-	struct sock *sk = icmp_socket->sk;
-	struct inet_sock *inet = inet_sk(sk);
+	struct sock *sk;
+	struct inet_sock *inet;
 	struct ipcm_cookie ipc;
 	struct rtable *rt = (struct rtable *)skb->dst;
 	u32 daddr;
@@ -388,6 +388,9 @@
 	if (icmp_xmit_lock())
 		return;
 
+	sk = icmp_socket->sk;
+	inet = inet_sk(sk);
+
 	icmp_param->data.icmph.checksum = 0;
 	icmp_out_count(icmp_param->data.icmph.type);
 

--=-ecSVBBUA+0MOn8uIxBJb
Content-Disposition: attachment; filename=2.6.12-rc1-icmp-rt.patch
Content-Type: text/x-patch; name=2.6.12-rc1-icmp-rt.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


Since on PREEMPT_RT spinlocks allow preemption, it's possible to
change cpu at (almost) any point in time. Make sure we stick to
the per cpu variable we started with.


Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>


--- linux-2.6.12-rc1-RT-V0.7.42-08/net/ipv4/icmp_p1.c	2005-04-04 20:26:38.000000000 +0200
+++ linux-2.6.12-rc1-RT-V0.7.42-08/net/ipv4/icmp.c	2005-04-04 20:27:54.000000000 +0200
@@ -228,26 +228,32 @@
  *
  *	On SMP we have one ICMP socket per-cpu.
  */
-static DEFINE_PER_CPU(struct socket *, __icmp_socket) = NULL;
-#define icmp_socket	__get_cpu_var(__icmp_socket)
+static DEFINE_PER_CPU_LOCKED(struct socket *, __icmp_socket) = NULL;
 
-static __inline__ int icmp_xmit_lock(void)
+static __inline__ struct socket * icmp_xmit_lock(int cpu)
 {
+	struct socket *icmp_socket;
+
 	local_bh_disable();
+	icmp_socket = get_cpu_var_locked(__icmp_socket, cpu);
 
 	if (unlikely(!spin_trylock(&icmp_socket->sk->sk_lock.slock))) {
 		/* This can happen if the output path signals a
 		 * dst_link_failure() for an outgoing ICMP packet.
 		 */
+		put_cpu_var_locked(__icmp_socket, cpu);
 		local_bh_enable();
-		return 1;
+		return NULL;
 	}
-	return 0;
+
+	return icmp_socket;
 }
 
-static void icmp_xmit_unlock(void)
+static void icmp_xmit_unlock(int cpu)
 {
+	struct socket *icmp_socket = __get_cpu_var_locked(__icmp_socket, cpu);
 	spin_unlock_bh(&icmp_socket->sk->sk_lock.slock);
+	put_cpu_var_locked(__icmp_socket, cpu);
 }
 
 /*
@@ -344,7 +350,8 @@
 }
 
 static void icmp_push_reply(struct icmp_bxm *icmp_param,
-			    struct ipcm_cookie *ipc, struct rtable *rt)
+			    struct ipcm_cookie *ipc, struct rtable *rt,
+				struct socket *icmp_socket)
 {
 	struct sk_buff *skb;
 
@@ -376,16 +383,19 @@
 
 static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 {
+	struct socket *icmp_socket;
 	struct sock *sk;
 	struct inet_sock *inet;
 	struct ipcm_cookie ipc;
 	struct rtable *rt = (struct rtable *)skb->dst;
 	u32 daddr;
+	int cpu;
 
 	if (ip_options_echo(&icmp_param->replyopts, skb))
 		goto out;
 
-	if (icmp_xmit_lock())
+	cpu = _smp_processor_id();
+	if (!(icmp_socket = icmp_xmit_lock(cpu)))
 		return;
 
 	sk = icmp_socket->sk;
@@ -413,10 +423,10 @@
 	}
 	if (icmpv4_xrlim_allow(rt, icmp_param->data.icmph.type,
 			       icmp_param->data.icmph.code))
-		icmp_push_reply(icmp_param, &ipc, rt);
+		icmp_push_reply(icmp_param, &ipc, rt, icmp_socket);
 	ip_rt_put(rt);
 out_unlock:
-	icmp_xmit_unlock();
+	icmp_xmit_unlock(cpu);
 out:;
 }
 
@@ -434,8 +444,9 @@
 
 void icmp_send(struct sk_buff *skb_in, int type, int code, u32 info)
 {
+	struct socket *icmp_socket;
 	struct iphdr *iph;
-	int room;
+	int room, cpu;
 	struct icmp_bxm icmp_param;
 	struct rtable *rt = (struct rtable *)skb_in->dst;
 	struct ipcm_cookie ipc;
@@ -506,7 +517,8 @@
 		}
 	}
 
-	if (icmp_xmit_lock())
+	cpu = _smp_processor_id();
+	if (!(icmp_socket = icmp_xmit_lock(cpu)))
 		return;
 
 	/*
@@ -579,11 +591,11 @@
 		icmp_param.data_len = room;
 	icmp_param.head_len = sizeof(struct icmphdr);
 
-	icmp_push_reply(&icmp_param, &ipc, rt);
+	icmp_push_reply(&icmp_param, &ipc, rt, icmp_socket);
 ende:
 	ip_rt_put(rt);
 out_unlock:
-	icmp_xmit_unlock();
+	icmp_xmit_unlock(cpu);
 out:;
 }
 
@@ -1115,20 +1127,20 @@
 			continue;
 
 		err = sock_create_kern(PF_INET, SOCK_RAW, IPPROTO_ICMP,
-				       &per_cpu(__icmp_socket, i));
+				       &__get_cpu_var_locked(__icmp_socket, i));
 
 		if (err < 0)
 			panic("Failed to create the ICMP control socket.\n");
 
-		per_cpu(__icmp_socket, i)->sk->sk_allocation = GFP_ATOMIC;
+		__get_cpu_var_locked(__icmp_socket, i)->sk->sk_allocation = GFP_ATOMIC;
 
 		/* Enough space for 2 64K ICMP packets, including
 		 * sk_buff struct overhead.
 		 */
-		per_cpu(__icmp_socket, i)->sk->sk_sndbuf =
+		__get_cpu_var_locked(__icmp_socket, i)->sk->sk_sndbuf =
 			(2 * ((64 * 1024) + sizeof(struct sk_buff)));
 
-		inet = inet_sk(per_cpu(__icmp_socket, i)->sk);
+		inet = inet_sk(__get_cpu_var_locked(__icmp_socket, i)->sk);
 		inet->uc_ttl = -1;
 		inet->pmtudisc = IP_PMTUDISC_DONT;
 
@@ -1136,7 +1148,7 @@
 		 * see it, we do not wish this socket to see incoming
 		 * packets.
 		 */
-		per_cpu(__icmp_socket, i)->sk->sk_prot->unhash(per_cpu(__icmp_socket, i)->sk);
+		__get_cpu_var_locked(__icmp_socket, i)->sk->sk_prot->unhash(__get_cpu_var_locked(__icmp_socket, i)->sk);
 	}
 }
 

--=-ecSVBBUA+0MOn8uIxBJb--

