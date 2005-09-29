Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVI2QFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVI2QFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVI2QFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:05:41 -0400
Received: from mailer1.psc.edu ([128.182.58.100]:53748 "EHLO mailer1.psc.edu")
	by vger.kernel.org with ESMTP id S932217AbVI2QFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:05:39 -0400
From: John Heffner <jheffner@psc.edu>
Organization: PSC
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x kernels
Date: Thu, 29 Sep 2005 12:04:28 -0400
User-Agent: KMail/1.8.1
Cc: Ion Badulescu <lists@limebrokerage.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org, gautran@mrv.com
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com> <Pine.LNX.4.61.0509281223560.30951@ionlinux.tower-research.com> <20050929151729.GA2158@ms2.inr.ac.ru>
In-Reply-To: <20050929151729.GA2158@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_NCBPD5SwVJD+16W"
Message-Id: <200509291204.29393.jheffner@psc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_NCBPD5SwVJD+16W
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 29 September 2005 11:17 am, Alexey Kuznetsov wrote:
> Hello!
>
> > >Anyway, ignoring this puzzle, the following patch for 2.4 should help.
> > >
> > >
> > >--- net/ipv4/tcp_input.c.orig	2003-02-20 20:38:39.000000000 +0300
> > >+++ net/ipv4/tcp_input.c	2005-09-02 22:28:00.845952888 +0400
> > >@@ -343,8 +343,6 @@
> > >			app_win -=3D tp->ack.rcv_mss;
> > >		app_win =3D max(app_win, 2U*tp->advmss);
> > >
> > >-		if (!ofo_win)
> > >-			tp->window_clamp =3D min(tp->window_clamp, app_win);
> > >		tp->rcv_ssthresh =3D min(tp->window_clamp, 2U*tp->advmss);
> > >	}
> > >}
> >
> > I'm very happy to report that the above patch, applied to 2.6.12.6, see=
ms
> > to have cured the TCP window problem we were experiencing.
>
> Good. I think the patch is to be applied to all mainstream kernels.

Has anyone looked at the patch I sent out on Sept 9?  It goes a few steps=20
further, addressing some additional problems.  Original message below.

Thanks,
  -John

=2D----

This is a patch for discussion addressing some receive buffer growing issue=
s. =A0
This is partially related to the thread "Possible BUG in IPv4 TCP window=20
handling..." last week.

Specifically it addresses the problem of an interaction between rcvbuf=20
moderation (receiver autotuning) and rcv_ssthresh. =A0The problem occurs wh=
en=20
sending small packets to a receiver with a larger MTU. =A0(A very common ca=
se I=20
have is a host with a 1500 byte MTU sending to a host with a 9k MTU.) =A0In=
=20
such a case, the rcv_ssthresh code is targeting a window size corresponding=
=20
to filling up the current rcvbuf, not taking into account that the new rcvb=
uf=20
moderation may increase the rcvbuf size.

One hunk makes rcv_ssthresh use tcp_rmem[2] as the size target rather than=
=20
rcvbuf. =A0The other changes the behavior when it overflows its memory boun=
ds=20
with in-order data so that it tries to grow rcvbuf (the same as with=20
out-of-order data).

These changes should help my problem of mixed MTUs, and should also help th=
e=20
case from last week's thread I think. =A0(In both cases though you still ne=
ed=20
tcp_rmem[2] to be set much larger than the TCP window.) =A0One question is =
if=20
this is too aggressive at trying to increase rcvbuf if it's under memory=20
stress.

=A0 -John


Signed-off-by: John Heffner <jheffner@psc.edu>

--Boundary-00=_NCBPD5SwVJD+16W
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="rcv_ssthresh.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rcv_ssthresh.diff"

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -233,7 +233,7 @@ static int __tcp_grow_window(const struc
 {
 	/* Optimize this! */
 	int truesize = tcp_win_from_space(skb->truesize)/2;
-	int window = tcp_full_space(sk)/2;
+	int window = tcp_win_from_space(sysctl_tcp_rmem[2])/2;
 
 	while (tp->rcv_ssthresh <= window) {
 		if (truesize <= skb->len)
@@ -326,39 +326,18 @@ static void tcp_init_buffer_space(struct
 static void tcp_clamp_window(struct sock *sk, struct tcp_sock *tp)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
-	struct sk_buff *skb;
-	unsigned int app_win = tp->rcv_nxt - tp->copied_seq;
-	int ofo_win = 0;
 
 	icsk->icsk_ack.quick = 0;
 
-	skb_queue_walk(&tp->out_of_order_queue, skb) {
-		ofo_win += skb->len;
+	if (sk->sk_rcvbuf < sysctl_tcp_rmem[2] &&
+	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK) &&
+	    !tcp_memory_pressure &&
+	    atomic_read(&tcp_memory_allocated) < sysctl_tcp_mem[0]) {
+		sk->sk_rcvbuf = min(atomic_read(&sk->sk_rmem_alloc),
+				    sysctl_tcp_rmem[2]);
 	}
-
-	/* If overcommit is due to out of order segments,
-	 * do not clamp window. Try to expand rcvbuf instead.
-	 */
-	if (ofo_win) {
-		if (sk->sk_rcvbuf < sysctl_tcp_rmem[2] &&
-		    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK) &&
-		    !tcp_memory_pressure &&
-		    atomic_read(&tcp_memory_allocated) < sysctl_tcp_mem[0])
-			sk->sk_rcvbuf = min(atomic_read(&sk->sk_rmem_alloc),
-					    sysctl_tcp_rmem[2]);
-	}
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf) {
-		app_win += ofo_win;
-		if (atomic_read(&sk->sk_rmem_alloc) >= 2 * sk->sk_rcvbuf)
-			app_win >>= 1;
-		if (app_win > icsk->icsk_ack.rcv_mss)
-			app_win -= icsk->icsk_ack.rcv_mss;
-		app_win = max(app_win, 2U*tp->advmss);
-
-		if (!ofo_win)
-			tp->window_clamp = min(tp->window_clamp, app_win);
+	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
 		tp->rcv_ssthresh = min(tp->window_clamp, 2U*tp->advmss);
-	}
 }
 
 /* Receiver "autotuning" code.

--Boundary-00=_NCBPD5SwVJD+16W--
