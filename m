Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbTCQIPE>; Mon, 17 Mar 2003 03:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262839AbTCQIPE>; Mon, 17 Mar 2003 03:15:04 -0500
Received: from mail-4.tiscali.it ([195.130.225.150]:24041 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S262788AbTCQIO6>;
	Mon, 17 Mar 2003 03:14:58 -0500
Date: Mon, 17 Mar 2003 09:25:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       Andi Kleen <ak@suse.de>
Subject: 2.4 delayed acks don't work, fixed
Message-ID: <20030317082553.GA1324@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last week I installed adsl, and in the weekend I was playing with some
streaming service. While watching tcpdump I noticed some huge breakage
in the dealyed acks algorithm that generated an overkill number of acks
(around the double than what was really necessary). I suspect this
problem never seen the light of the day as it only silenty generates
some relevant global waste of the internet.  this is a 2.4 tcp stacks
getting data from a streamer with bulk transfers on normal connection
with stock 2.4 tcp stack:

01:34:24.061554 streamer.8300 > linux.53972: . 131401:132861(1460) ack 0 win 58400 (DF)
01:34:24.139741 linux.53972 > streamer.8300: . ack 132861 win 1460 (DF)
01:34:24.140554 streamer.8300 > linux.53972: . 132861:134321(1460) ack 0 win 58400 (DF)
01:34:24.143710 linux.53972 > streamer.8300: . ack 134321 win 1460 (DF)
01:34:24.223566 linux.53972 > streamer.8300: . ack 134321 win 2920 (DF)
01:34:24.241532 streamer.8300 > linux.53972: . 134321:135781(1460) ack 0 win 58400 (DF)
01:34:24.319737 linux.53972 > streamer.8300: . ack 135781 win 1460 (DF)
01:34:24.321529 streamer.8300 > linux.53972: . 135781:137241(1460) ack 0 win 58400 (DF)
01:34:24.323634 linux.53972 > streamer.8300: . ack 137241 win 1460 (DF)
01:34:24.421492 streamer.8300 > linux.53972: . 137241:138701(1460) ack 0 win 58400 (DF)
01:34:24.423541 linux.53972 > streamer.8300: . ack 138701 win 1460 (DF)
01:34:24.503581 linux.53972 > streamer.8300: . ack 138701 win 2920 (DF)
01:34:24.521555 streamer.8300 > linux.53972: . 138701:140161(1460) ack 0 win 58400 (DF)
01:34:24.599739 linux.53972 > streamer.8300: . ack 140161 win 1460 (DF)
01:34:24.601480 streamer.8300 > linux.53972: . 140161:141621(1460) ack 0 win 58400 (DF)
01:34:24.603663 linux.53972 > streamer.8300: . ack 141621 win 1460 (DF)

linux is the receiver of course (tcpdump is running on the linux box),
the sender is a streamer over the internet but it doesn't really matter,
it happens with any kind of transfer: after the first delack timer
triggers it keeps going like the above for the all remaining part of the
large downloads (i.e. for days until I reset the computer). This stremer
makes it more obvious becaue it waits some time before sending the next
packet (my bandwidth is now much higher than the one needed by the
player). These seldom waits triggers the delacks timers and after that
the delack feature is completely disabled, it restarts for very few
packets once in a while when ack.quick is set to 0 but those seldom
delayed acks are completely hidden by the above quickacks. Even worse
linux keeps sending more than 1 ack ever few received packets for
suprious too short window updates, so it's doing the exact opposite of
the delack feature.  It looks very broken to me.

rfc1122 says (quote):

	A TCP SHOULD implement a delayed ACK, but an ACK should not be
	excessively delayed; in particular, the delay MUST be less than 0.5
	seconds,

Apparently linux only waits 0.2 at max, this appears wrong too (but .2
would be more than enough for my testcase, when it's longer than .2 it's
because the streamer is intentionally delaying, so triggering the delack
is fine in such case).

I had a look and I found various explanations for the bad behaviour:

1) the delayed ack timer destroy the ato value resetting it to the min
   value (40msec) and the quickack mode is activated (pingpong = 0)
2) the pingpong is never re-activated, so it takes the whole receive
   window before the pingpong isn't significant anymore, then after the
   first delack timer it will take another receive window before I
   can see a new delayed ack
3) the ato averaging logic during the packet reception will not inflate
   the ato if "m > ato" which is obviously the case after a delack timer
   triggered and in turn after the ato is been deflated to its min value
4) the logic that bounds the delayed ack to the srtt >> 3 looks also
   risky, using the rto looks much safer to me there, to be sure
   those delacks aren't going to trigger too early
5) I suspect the current delack algorithm can wait more than 2 packets,
   the && must be a || after the (tp->rcv_nxt - tp->rcv_wup) >
   tp->ack.rcv_mss check, just try a netcat xxx chargen >/dev/null on a
   100mbit and see how many packets you need to receive before you can
   see the ack some time, this doesn't seem to happen with these
   modifications applied

Besides the above, there's also quite some ack overhead due the window
updates triggered by the userspace so I made it a little more
aggressive by sending an ack in recvmsg only if the potential rcv window is
been increase of _more_ than 2 times the current outstanding rcv window
(not equal), this way the suprious updates rarely happens, and I also
avoid updates if there's a delack timer pending and not blocked (this
last one looks quite a natural idea, this may actually hurt but I doubt,
certainly I would be ok to drop that goto out in cleanup_rbuf if you
think it's going to be wrong on very high speed networks).

this new one is the (IMHO) a much nicer behaviour for the same workloads
as above with the modifications applied:

08:57:27.718987 streamer.8300 > linux.32792: . 26281:27741(1460) ack 0 win 58400 (DF)
08:57:27.747964 streamer.8300 > linux.32792: . 27741:29201(1460) ack 0 win 58400 (DF)
08:57:27.748017 linux.32792 > streamer.8300: . ack 29201 win 2920 (DF)
08:57:27.768949 streamer.8300 > linux.32792: . 29201:30661(1460) ack 0 win 58400 (DF)
08:57:27.848937 streamer.8300 > linux.32792: . 30661:32121(1460) ack 0 win 58400 (DF)
08:57:27.848986 linux.32792 > streamer.8300: . ack 32121 win 1460 (DF)
08:57:27.934286 linux.32792 > streamer.8300: . ack 32121 win 4380 (DF)
08:57:27.948918 streamer.8300 > linux.32792: . 32121:33581(1460) ack 0 win 58400 (DF)
08:57:28.038882 streamer.8300 > linux.32792: . 33581:35041(1460) ack 0 win 58400 (DF)
08:57:28.038931 linux.32792 > streamer.8300: . ack 35041 win 2920 (DF)
08:57:28.058882 streamer.8300 > linux.32792: . 35041:36501(1460) ack 0 win 58400 (DF)
08:57:28.138866 streamer.8300 > linux.32792: . 36501:37961(1460) ack 0 win 58400 (DF)
08:57:28.138919 linux.32792 > streamer.8300: . ack 37961 win 1460 (DF)
08:57:28.238912 streamer.8300 > linux.32792: . 37961:39421(1460) ack 0 win 58400 (DF)
08:57:28.394274 linux.32792 > streamer.8300: . ack 39421 win 4380 (DF)
08:57:28.488823 streamer.8300 > linux.32792: . 39421:40881(1460) ack 0 win 58400 (DF)
08:57:28.508800 streamer.8300 > linux.32792: . 40881:42341(1460) ack 0 win 58400 (DF)
08:57:28.508841 linux.32792 > streamer.8300: . ack 42341 win 2920 (DF)
08:57:28.538803 streamer.8300 > linux.32792: . 42341:43801(1460) ack 0 win 58400 (DF)
08:57:28.608829 streamer.8300 > linux.32792: . 43801:45261(1460) ack 0 win 58400 (DF)
08:57:28.608877 linux.32792 > streamer.8300: . ack 45261 win 1460 (DF)
08:57:28.708788 streamer.8300 > linux.32792: . 45261:46721(1460) ack 0 win 58400 (DF)
08:57:28.864277 linux.32792 > streamer.8300: . ack 46721 win 4380 (DF)
08:57:28.958765 streamer.8300 > linux.32792: . 46721:48181(1460) ack 0 win 58400 (DF)
08:57:28.988704 streamer.8300 > linux.32792: . 48181:49641(1460) ack 0 win 58400 (DF)
08:57:28.988759 linux.32792 > streamer.8300: . ack 49641 win 2920 (DF)
08:57:29.018705 streamer.8300 > linux.32792: . 49641:51101(1460) ack 0 win 58400 (DF)
08:57:29.098699 streamer.8300 > linux.32792: . 51101:52561(1460) ack 0 win 58400 (DF)
08:57:29.098749 linux.32792 > streamer.8300: . ack 52561 win 1460 (DF)
08:57:29.208694 streamer.8300 > linux.32792: . 52561:54021(1460) ack 0 win 58400 (DF)
08:57:29.380937 linux.32792 > streamer.8300: . ack 54021 win 4380 (DF)
08:57:29.478646 streamer.8300 > linux.32792: . 54021:55481(1460) ack 0 win 58400 (DF)
08:57:29.498614 streamer.8300 > linux.32792: . 55481:56941(1460) ack 0 win 58400 (DF)
08:57:29.498648 linux.32792 > streamer.8300: . ack 56941 win 4380 (DF)
08:57:29.518615 streamer.8300 > linux.32792: . 56941:58401(1460) ack 0 win 58400 (DF)
08:57:29.598632 streamer.8300 > linux.32792: . 58401:59861(1460) ack 0 win 58400 (DF)
08:57:29.598677 linux.32792 > streamer.8300: . ack 59861 win 2920 (DF)
08:57:29.618619 streamer.8300 > linux.32792: . 59861:61321(1460) ack 0 win 58400 (DF)
08:57:29.698591 streamer.8300 > linux.32792: . 61321:62781(1460) ack 0 win 58400 (DF)
08:57:29.698637 linux.32792 > streamer.8300: . ack 62781 win 1460 (DF)

now my streming services are generating 1/4 of number of packets over
the internet compared to what the buggy logic in mainline does obviously
w/o any possible change in performance, so I'm going to use it. It may
not be RFC complaint but I doubt the current mainline code could be RFC
compliant in the first place.

here's the diff, comments welcome.

diff -urNp xx/include/net/tcp.h xxx/include/net/tcp.h
--- xx/include/net/tcp.h	2003-03-17 09:01:13.000000000 +0100
+++ xxx/include/net/tcp.h	2003-03-17 08:45:28.000000000 +0100
@@ -323,7 +323,7 @@ static __inline__ int tcp_sk_listen_hash
 				  * TIME-WAIT timer.
 				  */
 
-#define TCP_DELACK_MAX	((unsigned)(HZ/5))	/* maximal time to delay before sending an ACK */
+#define TCP_DELACK_MAX	((unsigned)(HZ/2))	/* maximal time to delay before sending an ACK */
 #if HZ >= 100
 #define TCP_DELACK_MIN	((unsigned)(HZ/25))	/* minimal time to delay before sending an ACK */
 #define TCP_ATO_MIN	((unsigned)(HZ/25))
diff -urNp xx/net/ipv4/tcp.c xxx/net/ipv4/tcp.c
--- xx/net/ipv4/tcp.c	2003-03-17 09:01:13.000000000 +0100
+++ xxx/net/ipv4/tcp.c	2003-03-17 08:10:23.000000000 +0100
@@ -1290,22 +1290,10 @@ void cleanup_rbuf(struct sock *sk, int c
 #endif
 
 	if (tcp_ack_scheduled(tp)) {
-		   /* Delayed ACKs frequently hit locked sockets during bulk receive. */
-		if (tp->ack.blocked
-		    /* Once-per-two-segments ACK was not sent by tcp_input.c */
-		    || tp->rcv_nxt - tp->rcv_wup > tp->ack.rcv_mss
-		    /*
-		     * If this read emptied read buffer, we send ACK, if
-		     * connection is not bidirectional, user drained
-		     * receive buffer and there was a small segment
-		     * in queue.
-		     */
-		    || (copied > 0 &&
-			(tp->ack.pending&TCP_ACK_PUSHED) &&
-			!tp->ack.pingpong &&
-			atomic_read(&sk->rmem_alloc) == 0)) {
+		if (tp->ack.blocked)
+			/* Delayed ACKs frequently hit locked sockets during bulk receive. */
 			time_to_ack = 1;
-		}
+		goto out;
 	}
 
   	/* We send an ACK if we can now advertise a non-zero window
@@ -1318,7 +1306,7 @@ void cleanup_rbuf(struct sock *sk, int c
 		__u32 rcv_window_now = tcp_receive_window(tp);
 
 		/* Optimize, __tcp_select_window() is not cheap. */
-		if (2*rcv_window_now <= tp->window_clamp) {
+		if (2*rcv_window_now < tp->window_clamp) {
 			__u32 new_window = __tcp_select_window(sk);
 
 			/* Send ACK now, if this read freed lots of space
@@ -1326,10 +1314,11 @@ void cleanup_rbuf(struct sock *sk, int c
 			 * We can advertise it now, if it is not less than current one.
 			 * "Lots" means "at least twice" here.
 			 */
-			if(new_window && new_window >= 2*rcv_window_now)
+			if(new_window && new_window > 2*rcv_window_now)
 				time_to_ack = 1;
 		}
 	}
+ out:
 	if (time_to_ack)
 		tcp_send_ack(sk);
 }
diff -urNp xx/net/ipv4/tcp_input.c xxx/net/ipv4/tcp_input.c
--- xx/net/ipv4/tcp_input.c	2003-03-17 09:01:03.000000000 +0100
+++ xxx/net/ipv4/tcp_input.c	2003-03-17 08:36:15.000000000 +0100
@@ -173,6 +173,11 @@ void tcp_enter_quickack_mode(struct tcp_
 	tp->ack.ato = TCP_ATO_MIN;
 }
 
+static inline void tcp_exit_quickack_mode(struct tcp_opt *tp)
+{
+	tp->ack.pingpong = 1;
+}
+
 /* Send ACKs quickly, if "quick" count is not exhausted
  * and the session is not interactive.
  */
@@ -381,16 +386,21 @@ static void tcp_event_data_recv(struct s
 		if (m <= TCP_ATO_MIN/2) {
 			/* The fastest case is the first. */
 			tp->ack.ato = (tp->ack.ato>>1) + TCP_ATO_MIN/2;
-		} else if (m < tp->ack.ato) {
-			tp->ack.ato = (tp->ack.ato>>1) + m;
-			if (tp->ack.ato > tp->rto)
-				tp->ack.ato = tp->rto;
-		} else if (m > tp->rto) {
+			tcp_exit_quickack_mode(tp);
+		} else if (unlikely(m > TCP_DELACK_MAX)) {
+			/* Delayed acks are worthless on a very slow link. */
+			tcp_incr_quickack(tp);
+		} else if (unlikely(m > tp->rto)) {
 			/* Too long gap. Apparently sender falled to
 			 * restart window, so that we send ACKs quickly.
 			 */
 			tcp_incr_quickack(tp);
 			tcp_mem_reclaim(sk);
+		} else { 
+			tp->ack.ato = (tp->ack.ato>>1) + m;
+			if (tp->ack.ato > tp->rto)
+				tp->ack.ato = tp->rto;
+			tcp_exit_quickack_mode(tp);
 		}
 	}
 	tp->ack.lrcvtime = now;
@@ -3131,11 +3141,7 @@ static __inline__ void __tcp_ack_snd_che
 	struct tcp_opt *tp = &(sk->tp_pinfo.af_tcp);
 
 	    /* More than one full frame received... */
-	if (((tp->rcv_nxt - tp->rcv_wup) > tp->ack.rcv_mss
-	     /* ... and right edge of window advances far enough.
-	      * (tcp_recvmsg() will send ACK otherwise). Or...
-	      */
-	     && __tcp_select_window(sk) >= tp->rcv_wnd) ||
+	if ((tp->rcv_nxt - tp->rcv_wup) > tp->ack.rcv_mss ||
 	    /* We ACK each frame or... */
 	    tcp_in_quickack_mode(tp) ||
 	    /* We have out of order data. */
diff -urNp xx/net/ipv4/tcp_output.c xxx/net/ipv4/tcp_output.c
--- xx/net/ipv4/tcp_output.c	2003-03-15 01:25:19.000000000 +0100
+++ xxx/net/ipv4/tcp_output.c	2003-03-17 08:37:07.000000000 +0100
@@ -1257,19 +1257,13 @@ void tcp_send_delayed_ack(struct sock *s
 	unsigned long timeout;
 
 	if (ato > TCP_DELACK_MIN) {
-		int max_ato = HZ/2;
-
-		if (tp->ack.pingpong || (tp->ack.pending&TCP_ACK_PUSHED))
-			max_ato = TCP_DELACK_MAX;
+		int max_ato = TCP_DELACK_MAX;
 
 		/* Slow path, intersegment interval is "high". */
 
-		/* If some rtt estimate is known, use it to bound delayed ack.
-		 * Do not use tp->rto here, use results of rtt measurements
-		 * directly.
-		 */
-		if (tp->srtt) {
-			int rtt = max(tp->srtt>>3, TCP_DELACK_MIN);
+		/* If some rtt estimate is known, use it to bound delayed ack. */
+		if (tp->rto) {
+			int rtt = max(tp->rto, TCP_DELACK_MIN);
 
 			if (rtt < max_ato)
 				max_ato = rtt;
diff -urNp xx/net/ipv4/tcp_timer.c xxx/net/ipv4/tcp_timer.c
--- xx/net/ipv4/tcp_timer.c	2003-03-15 01:25:19.000000000 +0100
+++ xxx/net/ipv4/tcp_timer.c	2003-03-17 08:37:07.000000000 +0100
@@ -250,11 +250,10 @@ static void tcp_delack_timer(unsigned lo
 			/* Delayed ACK missed: inflate ATO. */
 			tp->ack.ato = min(tp->ack.ato << 1, tp->rto);
 		} else {
-			/* Delayed ACK missed: leave pingpong mode and
-			 * deflate ATO.
+			/* Delayed ACK missed: leave pingpong mode
+			 * but be ready to reenable delay acks fast.
 			 */
 			tp->ack.pingpong = 0;
-			tp->ack.ato = TCP_ATO_MIN;
 		}
 		tcp_send_ack(sk);
 		NET_INC_STATS_BH(DelayedACKs);

Andrea
