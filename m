Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVBVOh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVBVOh6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 09:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVBVOhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 09:37:43 -0500
Received: from ms005msg.fastwebnet.it ([213.140.2.50]:46762 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262317AbVBVOfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 09:35:36 -0500
From: Daniele Lacamera <mlists@danielinux.net>
Reply-To: mlists@danielinux.net
To: Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] TCP-Hybla proposal
Date: Tue, 22 Feb 2005 15:34:42 +0100
User-Agent: KMail/1.7.1
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlo Caini <ccaini@deis.unibo.it>,
       Rosario Firrincieli <rfirrincieli@arces.unibo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CM0GCHGgOsJpJz7"
Message-Id: <200502221534.42948.mlists@danielinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_CM0GCHGgOsJpJz7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi
This is the official patch to implement TCP Hybla congestion avoidance.

- "In heterogeneous networks, TCP connections that incorporate a 
terrestrial or satellite radio link are greatly disadvantaged with 
respect to entirely wired connections, because of their longer round 
trip times (RTTs). To cope with this problem, a new TCP proposal, the 
TCP Hybla, is presented and discussed in the paper[1]. It stems from an 
analytical evaluation of the congestion window dynamics in the TCP 
standard versions (Tahoe, Reno, NewReno), which suggests the necessary 
modifications to remove the performance dependence on RTT.[...]"[1]

[1]: Carlo Caini, Rosario Firrincieli, "TCP Hybla: a TCP enhancement for 
heterogeneous networks", 
International Journal of Satellite Communications and Networking
Volume 22, Issue 5 , Pages 547 - 566. September 2004.

Please note that this patch:
- cleanly compiled against 2.6.11-rc4;

- reached very good results in terms of fairness and friendliness with 
other TCP standards and proposals during tests;

- gives a throughput very close to maximum fair share when satellite 
connections fight for bandwidth in a terrestrial bottleneck, and 
improves their performance also in case of no congestion;

- acts exactly as newreno when minimum rtt estimated by the sender is 
lower or equal to rtt0 (default=25 ms).

The protocol is obviously disabled by default and can be turned on by 
switching its sysctl, as usual.
As Mr.Yee-Ting Li pointed out in his last thread, the deployments of 
these experimental protocols are too premature and they should be 
switched OFF by default to prevent undesirable consequences to network 
stability.

One last note: IMHO we really need a better way to select congestion 
avoidance scheme between those available, instead of switching each one 
on and off. I.e., we can't say how vegas and westwood perform when 
switched on together, can we?

I'd really appreciate if you consider my work for apply.
TIA,

-- 
Daniele Lacamera
root at danielinux.net

--Boundary-00=_CM0GCHGgOsJpJz7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="hybla-2.6.11-rc4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hybla-2.6.11-rc4.patch"

diff -ruN linux-2.6.11-rc4/Documentation/networking/ip-sysctl.txt hybla/Documentation/networking/ip-sysctl.txt
--- linux-2.6.11-rc4/Documentation/networking/ip-sysctl.txt	2005-02-13 04:06:20.000000000 +0100
+++ hybla/Documentation/networking/ip-sysctl.txt	2005-02-22 13:50:38.000000000 +0100
@@ -349,6 +349,18 @@
 	window. Allows two flows sharing the same connection to converge
 	more rapidly.
 	Default: 1
+	
+tcp_hybla - BOOLEAN
+	Enable TCP-Hybla congestion control algorithm.
+	TCP-Hybla is a sender-side only change that eliminates penalization of
+	long-RTT, large-bandwidth connections, like when satellite legs are
+	involved, expecially when sharing a common bottleneck with normal 
+	terrestrial connections.
+	Default: 0
+	
+tcp_hybla_rtt0 - INTEGER
+	Divisor to set up rtt0 value for hybla congestion control.
+	Default: 40 (= 1/40 sec == 25ms)
 
 tcp_default_win_scale - INTEGER
 	Sets the minimum window scale TCP will negotiate for on all
diff -ruN linux-2.6.11-rc4/include/linux/sysctl.h hybla/include/linux/sysctl.h
--- linux-2.6.11-rc4/include/linux/sysctl.h	2005-02-13 04:06:53.000000000 +0100
+++ hybla/include/linux/sysctl.h	2005-02-22 13:06:59.000000000 +0100
@@ -344,6 +344,8 @@
 	NET_TCP_DEFAULT_WIN_SCALE=105,
 	NET_TCP_MODERATE_RCVBUF=106,
 	NET_TCP_TSO_WIN_DIVISOR=107,
+	NET_TCP_HYBLA=108,
+	NET_TCP_HYBLA_RTT0=109,
 };
 
 enum {
diff -ruN linux-2.6.11-rc4/include/linux/tcp.h hybla/include/linux/tcp.h
--- linux-2.6.11-rc4/include/linux/tcp.h	2005-02-13 04:06:23.000000000 +0100
+++ hybla/include/linux/tcp.h	2005-02-22 13:04:53.000000000 +0100
@@ -434,6 +434,16 @@
 		__u32	last_cwnd;	/* the last snd_cwnd */
 		__u32   last_stamp;     /* time when updated last_cwnd */
 	} bictcp;
+	
+	/* Tcp Hybla structure. */
+        struct{
+                __u32   snd_cwnd_cents; /* Keeps increment values when it is <1, <<7 */
+                __u32   rho;            /* Rho parameter, integer part  */
+                __u32   rho2;           /* Rho * Rho, integer part */
+                __u32   rho_3ls;        /* Rho parameter, <<3 */
+                __u32   rho2_7ls;       /* Rho^2, <<7	*/
+                __u32   minrtt;         /* Minimum smoothed round trip time value seen  */
+        } hybla;
 };
 
 static inline struct tcp_sock *tcp_sk(const struct sock *sk)
diff -ruN linux-2.6.11-rc4/include/net/tcp.h hybla/include/net/tcp.h
--- linux-2.6.11-rc4/include/net/tcp.h	2005-02-13 04:05:28.000000000 +0100
+++ hybla/include/net/tcp.h	2005-02-22 13:12:16.000000000 +0100
@@ -608,6 +608,8 @@
 extern int sysctl_tcp_bic_low_window;
 extern int sysctl_tcp_moderate_rcvbuf;
 extern int sysctl_tcp_tso_win_divisor;
+extern int sysctl_tcp_hybla;
+extern int sysctl_tcp_hybla_rtt0;
 
 extern atomic_t tcp_memory_allocated;
 extern atomic_t tcp_sockets_allocated;
@@ -2017,4 +2019,41 @@
 
 	return (cwnd != 0);
 }
+
+/*
+ * TCP HYBLA Functions and constants
+ */
+/* Hybla reference round trip time (default= 1/40 sec = 25 ms), expressed in jiffies */
+#define RTT0 (__u32) ((HZ/sysctl_tcp_hybla_rtt0))
+/*
+ * This is called in tcp_ipv4.c and
+ * tcp_minisocks.c when connection starts
+ */
+static inline void init_hybla(struct tcp_sock *tp)
+{
+        tp->hybla.rho = 0;
+        tp->hybla.rho2 = 0;
+        tp->hybla.rho_3ls = 0;
+        tp->hybla.rho2_7ls = 0;
+        tp->hybla.snd_cwnd_cents = 0;
+        tp->hybla.avgrtt = 0;
+}
+/* This is called to refresh values for hybla parameters */
+static inline void hybla_recalc_param (struct tcp_sock *tp)
+{
+
+        tp->hybla.rho_3ls = (tp->srtt / RTT0);
+        if(tp->hybla.rho_3ls < 8) 
+		tp->hybla.rho_3ls =8;
+	
+        tp->hybla.rho=(tp->hybla.rho_3ls >> 3);
+        tp->hybla.rho2_7ls = ((tp->hybla.rho_3ls * tp->hybla.rho_3ls)<<1);
+        tp->hybla.rho2=(tp->hybla.rho2_7ls >>7);
+
+        if(sysctl_tcp_initial_bw_est!=0)
+                initial_bw_est_recalc_clamp(tp);
+
+        if (sysctl_tcp_cong_avoid_style ==2)
+                tp->snd_cwnd_clamp = min_t (__u32, tp->snd_cwnd_clamp, tp->hybla.rho<<16);
+}
 #endif	/* _TCP_H */
diff -ruN linux-2.6.11-rc4/net/ipv4/sysctl_net_ipv4.c hybla/net/ipv4/sysctl_net_ipv4.c
--- linux-2.6.11-rc4/net/ipv4/sysctl_net_ipv4.c	2005-02-13 04:07:01.000000000 +0100
+++ hybla/net/ipv4/sysctl_net_ipv4.c	2005-02-22 13:15:00.000000000 +0100
@@ -682,6 +682,22 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name       = NET_TCP_HYBLA,
+		.procname       = "tcp_hybla",
+		.data           = &sysctl_tcp_hybla,
+		.maxlen         = sizeof(int),
+                .mode           = 0644,
+                .proc_handler   = &proc_dointvec
+        },
+	{
+		.ctl_name       = NET_TCP_HYBLA_RTT0,
+		.procname       = "tcp_hybla_rtt0",
+		.data           = &sysctl_tcp_hybla_rtt0,
+		.maxlen         = sizeof(int),
+                .mode           = 0644,
+                .proc_handler   = &proc_dointvec
+        },
 	{ .ctl_name = 0 }
 };
 
diff -ruN linux-2.6.11-rc4/net/ipv4/tcp.c hybla/net/ipv4/tcp.c
--- linux-2.6.11-rc4/net/ipv4/tcp.c	2005-02-13 04:05:50.000000000 +0100
+++ hybla/net/ipv4/tcp.c	2005-02-22 13:21:25.000000000 +0100
@@ -1813,6 +1813,10 @@
 
 	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK))
 		inet_reset_saddr(sk);
+	
+	/* [TCP HYBLA] Reset values on disconnect */
+        if (sysctl_tcp_cong_avoid_style == 2)
+                init_hybla(tp);
 
 	sk->sk_shutdown = 0;
 	sock_reset_flag(sk, SOCK_DONE);
diff -ruN linux-2.6.11-rc4/net/ipv4/tcp_input.c hybla/net/ipv4/tcp_input.c
--- linux-2.6.11-rc4/net/ipv4/tcp_input.c	2005-02-13 04:07:01.000000000 +0100
+++ hybla/net/ipv4/tcp_input.c	2005-02-22 13:58:49.000000000 +0100
@@ -62,6 +62,7 @@
  *					engine. Lots of bugs are found.
  *		Pasi Sarolahti:		F-RTO for dealing with spurious RTOs
  *		Angelo Dell'Aera:	TCP Westwood+ support
+ *		Daniele Lacamera:	TCP Hybla Congestion control support
  */
 
 #include <linux/config.h>
@@ -89,6 +90,8 @@
 int sysctl_tcp_nometrics_save;
 int sysctl_tcp_westwood;
 int sysctl_tcp_vegas_cong_avoid;
+int sysctl_tcp_hybla=0;
+int sysctl_tcp_hybla_rtt0=40;
 
 int sysctl_tcp_moderate_rcvbuf = 1;
 
@@ -595,6 +598,29 @@
 	tp->vegas.cntRTT++;
 }
 
+/*
+ * [TCP HYBLA] Update Values, if necessary, when a new
+ * smoothed RTT Estimation becomes available
+ */
+static void hybla_update_rtt(struct tcp_sock *tp, long m)
+{
+        /* This sets rho to the smallest RTT received. */
+        if (tp->srtt!=0){
+                /*  Recalculate rho only if this srtt is the lowest */
+                if (tp->srtt < tp->hybla.minrtt){
+			hybla_recalc_param(tp);
+			/* update minimum rtt */
+			tp->hybla.minrtt = tp->srtt;
+                }
+        } else {
+                /* 1st Rho measurement */
+                hybla_recalc_param(tp);
+                /* set minimum rtt as this is the 1st ever seen */
+                tp->hybla.minrtt = tp->srtt;
+                tp->snd_cwnd=tp->hybla.rho;
+        }
+}
+
 /* Called to compute a smoothed rtt estimate. The data fed to this
  * routine either comes from timestamps, or from segments that were
  * known _not_ to have been retransmitted [see Karn/Partridge
@@ -669,6 +695,8 @@
 	}
 
 	tcp_westwood_update_rtt(tp, tp->srtt >> 3);
+	if(sysctl_tcp_hybla)
+		hybla_update_rtt(tp,mrtt);
 }
 
 /* Calculate rto without backoff.  This is the second half of Van Jacobson's
@@ -808,6 +836,11 @@
 		else
 			cwnd = (tp->mss_cache_std > 1095) ? 3 : 4;
 	}
+	/* Hybla initial Window value set. */
+        if (sysctl_tcp_hybla){
+                hybla_recalc_param(tp);
+                cwnd=max_t(__u32, 2U, tp->hybla.rho);
+        }
 	return min_t(__u32, cwnd, tp->snd_cwnd_clamp);
 }
 
@@ -2322,12 +2355,153 @@
 	tp->snd_cwnd_stamp = tcp_time_stamp;
 }
 
+/***
+ ** TCP-HYBLA Congestion control algorithm, based on:
+ **   C.Caini, R.Firrincieli, "TCP-Hybla: A TCP Enhancement
+ **   for Heterogeneous Networks",
+ **   International Journal on satellite Communications,
+ **   					September 2004
+ ***/
+static __inline__ __u32 hybla_slowstart_fraction_increment(__u32 odds){
+	switch (odds) {
+		case 0:
+			return 128;
+		case 1:
+			return 139;
+		case 2:
+			return 152;
+		case 3:
+			return 165;
+		case 4:
+			return 181;
+		case 5:
+			return 197;
+		case 6:
+			return 215;
+		case 7:
+			return 234;
+		default:
+			return 128;
+		
+	}
+}
+static __inline__ void hybla_fractions_cong_avoid(struct tcp_sock *tp)
+{
+	__u32 increment;
+	__u32 odd;
+	__u32 rho_fractions;
+	//__u8 is_slowstart=0;
+	__u32 window, ssthresh;
+	
+	if (tp->hybla.rho==0)
+		hybla_recalc_param(tp);
+	
+	ssthresh = tp->snd_ssthresh;
+	window=tp->snd_cwnd;
+	rho_fractions=tp->hybla.rho_3ls - (tp->hybla.rho << 3);
+	
+	if (window < ssthresh){
+		return;
+	} else {
+		/*** congestion avoidance 	
+		 *** INC = RHO^2 / W		
+		 *** as long as increment is estimated as (rho<<7)/window
+		 *** it already is <<7 and we can easily count its fractions.
+		 ***/	
+		increment =(tp->hybla.rho2_7ls/window);
+		odd = increment % 128;
+		tp->snd_cwnd_cnt++;
+	}
+	tp->hybla.snd_cwnd_cents += odd;
+			
+}
+
+	/* TCP Hybla main routine.
+	 * This is the algorithm behavior:
+	 *	o Recalc Hybla parameters if min_rtt has changed
+	 *	o Give cwnd a new value based on the model proposed
+	 *	o remember increments <1	
+	 */
+static __inline__ void tcp_hybla_cong_avoid(struct tcp_sock *tp)
+{
+	__u32 increment;
+	__u32 odd;
+	__u32 rho_fractions;
+	__u32 window,clamp, ssthresh;
+	__u8 is_slowstart=0;
+	
+	if (tp->hybla.rho==0)
+		hybla_recalc_param(tp);
+	
+	clamp = tp->snd_cwnd_clamp ;
+	window = tp->snd_cwnd;
+	ssthresh = tp->snd_ssthresh;
+	rho_fractions=tp->hybla.rho_3ls - (tp->hybla.rho << 3);
+	
+	if (window < ssthresh){
+		/*** slow start 	
+		 ***	INC = 2^RHO - 1 
+		 *** This is done by splitting the rho parameter
+		 *** into 2 parts: an integer part and a fraction part.
+		 *** Inrement<<7 is estimated by doing:
+		 *** 		[2^(int+fract)]<<7
+		 *** that is equal to:
+		 ***		(2^int)  *  [(2^fract) <<7]
+		 *** 2^int is straightly computed as 1<<int,
+		 *** while we will use hybla_slowstart_fraction_increment() to 
+	 	 *** calculate 2^fract in a <<7 value.
+		 ***/
+		is_slowstart=1;
+		increment =( (1 << tp->hybla.rho) * hybla_slowstart_fraction_increment(rho_fractions) ) - 128;
+		odd = increment % 128;
+		window += (increment >> 7);
+	} else {
+		/*** congestion avoidance 	
+		 *** INC = RHO^2 / W		
+		 *** as long as increment is estimated as (rho<<7)/window
+		 *** it already is <<7 and we can easily count its fractions.
+		 ***/	
+		increment =(tp->hybla.rho2_7ls/window);
+		odd = increment % 128;
+		window += (increment >> 7);
+		
+		if (increment < 128)
+			tp->snd_cwnd_cnt++;
+	}
+	tp->hybla.snd_cwnd_cents += odd;
+	
+		/***
+		 *** check when fractions goes >=128
+		 *** and increase cwnd by 1.
+		 ***/
+	while(	tp->hybla.snd_cwnd_cents >= 128){
+		window++;
+		tp->hybla.snd_cwnd_cents -= 128;
+		tp->snd_cwnd_cnt = 0;
+	}
+		/***
+		 *** clamp down slowstart cwnd to ssthresh value.
+		 ***/
+	if (is_slowstart)
+		window = min_t(__u32, window, ssthresh);
+	
+	tp->snd_cwnd = min_t (__u32, window, clamp);
+	
+	tp->snd_cwnd_stamp=tcp_time_stamp;
+		
+}
+
 static inline void tcp_cong_avoid(struct tcp_sock *tp, u32 ack, u32 seq_rtt)
 {
-	if (tcp_vegas_enabled(tp))
+	if (tcp_vegas_enabled(tp)){
 		vegas_cong_avoid(tp, ack, seq_rtt);
-	else
-		reno_cong_avoid(tp);
+		return;
+	}
+	if (sysctl_tcp_hybla){
+		tcp_hybla_cong_avoid(tp);
+		return;
+	}
+	reno_cong_avoid(tp);
 }
 
 /* Restart timer after forward progress on connection.
diff -ruN linux-2.6.11-rc4/net/ipv4/tcp_ipv4.c hybla/net/ipv4/tcp_ipv4.c
--- linux-2.6.11-rc4/net/ipv4/tcp_ipv4.c	2005-02-13 04:05:51.000000000 +0100
+++ hybla/net/ipv4/tcp_ipv4.c	2005-02-22 13:19:02.000000000 +0100
@@ -2055,6 +2055,9 @@
 	 * efficiently to them.  -DaveM
 	 */
 	tp->snd_cwnd = 2;
+	
+	/* Reset hybla parameters on socket initialization.  */
+        init_hybla(tp);
 
 	/* See draft-stevens-tcpca-spec-01 for discussion of the
 	 * initialization of these values.
diff -ruN linux-2.6.11-rc4/net/ipv4/tcp_minisocks.c hybla/net/ipv4/tcp_minisocks.c
--- linux-2.6.11-rc4/net/ipv4/tcp_minisocks.c	2005-02-13 04:07:01.000000000 +0100
+++ hybla/net/ipv4/tcp_minisocks.c	2005-02-22 13:17:07.000000000 +0100
@@ -784,6 +784,9 @@
 
 		newtp->dsack = 0;
 		newtp->eff_sacks = 0;
+		
+		/* Reset hybla parameters on socket initialization.  */
+                init_hybla(newtp);
 
 		newtp->probes_out = 0;
 		newtp->num_sacks = 0;

--Boundary-00=_CM0GCHGgOsJpJz7--
