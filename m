Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287029AbRL1VBu>; Fri, 28 Dec 2001 16:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287028AbRL1VBd>; Fri, 28 Dec 2001 16:01:33 -0500
Received: from net047s.hetnet.nl ([194.151.104.151]:35337 "EHLO hetnet.nl")
	by vger.kernel.org with ESMTP id <S287026AbRL1VBW>;
	Fri, 28 Dec 2001 16:01:22 -0500
Message-Id: <5.1.0.14.2.20011228213437.009d1190@pop.hetnet.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 28 Dec 2001 21:57:32 +0100
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
From: Henk de Groot <henk.de.groot@hetnet.nl>
Subject: AX25/socket kernel PATCHes
In-Reply-To: <Pine.A41.4.21L1.0112281206560.20874-100000@login4.isis.unc
 .edu>
In-Reply-To: <20011228165908.GL7481@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I just downloaded the latest 2.4.17 kernel and I still do not see the 
patches of Jeroen Vreeken, PE1RXQ, applied. Anybody know the reason why?

Without these patches the 2.4 kernel completely locks-up my machine as soon 
as I start the FBB AX.25 BBS. Also other unrelated AX.25 tools do this, 
although they can run for a while until this happens. With the patches 
applied it is again rock solid as it was with earlier kernels.

I don't want credit for this, Jeroen Vreeken, PE1RXQ, found the problems 
and designed these patches, but I would like to have this - or another fix 
for the kernel lockup with AX.25 - in the stock kernel so everybody will 
benefit. I just assembled the patches, made them work (they  were somewhat 
damaged) and adjusted them for the 2.4.17 kernel.

Kind regards,

Henk.

P.S. I'm not subscribed to linux-kernel, please forward if posting by 
non-members is not permitted.

diff -ruN linux/net/ax25/af_ax25.c linux/net/ax25/af_ax25.c
--- linux/net/ax25/af_ax25.c	Fri Dec 28 21:25:36 2001
+++ linux/net/ax25/af_ax25.c	Fri Dec 28 21:26:35 2001
@@ -102,6 +102,7 @@
   *			Joerg(DL1BKE)		Added support for SO_BINDTODEVICE
   *			Arnaldo C. Melo		s/suser/capable(CAP_NET_ADMIN)/, some more cleanups
   *			Michal Ostrowski	Module initialization cleanup.
+ *			Jeroen(PE1RXQ)		Use sock_orphan to set sk->dead.
   */

  #include <linux/config.h>
@@ -423,7 +424,7 @@
  	if (ax25->sk != NULL) {
  		while ((skb = skb_dequeue(&ax25->sk->receive_queue)) != NULL) {
  			if (skb->sk != ax25->sk) {			/* A pending connection */
-				skb->sk->dead = 1;	/* Queue the unaccepted socket for death */
+				sock_orphan(skb->sk);	/* Queue the unaccepted socket for death */
  				ax25_start_heartbeat(skb->sk->protinfo.ax25);
  				skb->sk->protinfo.ax25->state = AX25_STATE_0;
  			}
@@ -1018,7 +1019,7 @@
  				sk->state                = TCP_CLOSE;
  				sk->shutdown            |= SEND_SHUTDOWN;
  				sk->state_change(sk);
-				sk->dead                 = 1;
+				sock_orphan(sk);
  				sk->destroy              = 1;
  				break;

@@ -1029,7 +1030,7 @@
  		sk->state     = TCP_CLOSE;
  		sk->shutdown |= SEND_SHUTDOWN;
  		sk->state_change(sk);
-		sk->dead      = 1;
+		sock_orphan(sk);
  		ax25_destroy_socket(sk->protinfo.ax25);
  	}

diff -ruN linux/net/core/datagram.c linux/net/core/datagram.c
--- linux/net/core/datagram.c	Fri Dec 28 21:25:36 2001
+++ linux/net/core/datagram.c	Fri Dec 28 21:26:35 2001
@@ -442,7 +442,8 @@
  	if (sock_writeable(sk))
  		mask |= POLLOUT | POLLWRNORM | POLLWRBAND;
  	else
-		set_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
+		if(sk->socket)
+			set_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);

  	return mask;
  }
diff -ruN linux/net/ax25/ax25_ds_timer.c linux/net/ax25/ax25_ds_timer.c
--- linux/net/ax25/ax25_ds_timer.c	Fri Dec 28 21:25:36 2001
+++ linux/net/ax25/ax25_ds_timer.c	Fri Dec 28 21:26:35 2001
@@ -162,7 +162,7 @@
  		ax25->sk->shutdown |= SEND_SHUTDOWN;
  		if (!ax25->sk->dead)
  			ax25->sk->state_change(ax25->sk);
-		ax25->sk->dead      = 1;
+		sock_orphan(ax25->sk);
  	}
  }

diff -ruN linux/net/ax25/ax25_std_timer.c linux/net/ax25/ax25_std_timer.c
--- linux/net/ax25/ax25_std_timer.c	Fri Dec 28 21:25:36 2001
+++ linux/net/ax25/ax25_std_timer.c	Fri Dec 28 21:26:35 2001
@@ -109,7 +109,7 @@
  		ax25->sk->shutdown |= SEND_SHUTDOWN;
  		if (!ax25->sk->dead)
  			ax25->sk->state_change(ax25->sk);
-		ax25->sk->dead      = 1;
+		sock_orphan(ax25->sk);
  	}
  }

diff -ruN linux/net/ax25/ax25_subr.c linux/net/ax25/ax25_subr.c
--- linux/net/ax25/ax25_subr.c	Fri Dec 28 21:25:36 2001
+++ linux/net/ax25/ax25_subr.c	Fri Dec 28 21:26:35 2001
@@ -310,6 +310,6 @@
  		ax25->sk->shutdown |= SEND_SHUTDOWN;
  		if (!ax25->sk->dead)
  			ax25->sk->state_change(ax25->sk);
-		ax25->sk->dead      = 1;
+		sock_orphan(ax25->sk);
  	}
  }
diff -ruN linux/net/netrom/af_netrom.c linux/net/netrom/af_netrom.c
--- linux/net/netrom/af_netrom.c	Fri Dec 28 21:25:36 2001
+++ linux/net/netrom/af_netrom.c	Fri Dec 28 21:26:35 2001
@@ -31,6 +31,7 @@
   *	NET/ROM 007	Jonathan(G4KLX)	New timer architecture.
   *					Impmented Idle timer.
   *			Arnaldo C. Melo s/suser/capable/, micro cleanups
+ *			Jeroen (PE1RXQ)	Use sock_orphan to set sk->dead.
   */

  #include <linux/config.h>
@@ -316,7 +317,7 @@

  	while ((skb = skb_dequeue(&sk->receive_queue)) != NULL) {
  		if (skb->sk != sk) {			/* A pending connection */
-			skb->sk->dead = 1;	/* Queue the unaccepted socket for death */
+			sock_orphan(skb->sk);	/* Queue the unaccepted socket for death */
  			nr_start_heartbeat(skb->sk);
  			skb->sk->protinfo.nr->state = NR_STATE_0;
  		}
@@ -572,9 +573,8 @@
  			sk->state                = TCP_CLOSE;
  			sk->shutdown            |= SEND_SHUTDOWN;
  			sk->state_change(sk);
-			sk->dead                 = 1;
+			sock_orphan(sk);
  			sk->destroy              = 1;
-			sk->socket               = NULL;
  			break;

  		default:
diff -ruN linux/net/netrom/nr_subr.c linux/net/netrom/nr_subr.c
--- linux/net/netrom/nr_subr.c	Fri Dec 28 21:25:36 2001
+++ linux/net/netrom/nr_subr.c	Fri Dec 28 21:26:35 2001
@@ -284,5 +284,5 @@
  	if (!sk->dead)
  		sk->state_change(sk);

-	sk->dead = 1;
+	sock_orphan(sk);
  }
diff -ruN linux/net/netrom/nr_timer.c linux/net/netrom/nr_timer.c
--- linux/net/netrom/nr_timer.c	Fri Dec 28 21:25:37 2001
+++ linux/net/netrom/nr_timer.c	Fri Dec 28 21:26:35 2001
@@ -201,7 +201,7 @@
  	if (!sk->dead)
  		sk->state_change(sk);

-	sk->dead = 1;
+	sock_orphan(sk);
  }

  static void nr_t1timer_expiry(unsigned long param)
diff -ruN linux/net/core/sock.c linux/net/core/sock.c
--- linux/net/core/sock.c	Fri Dec 28 21:25:37 2001
+++ linux/net/core/sock.c	Fri Dec 28 21:26:35 2001
@@ -81,6 +81,7 @@
   *		Andi Kleen	:	Fix write_space callback
   *		Chris Evans	:	Security fixes - signedness again
   *		Arnaldo C. Melo :       cleanups, use skb_queue_purge
+ *		Jeroen Vreeken	:	Add check for sk->dead in sock_def_write_space
   *
   * To Fix:
   *
@@ -1146,7 +1147,7 @@
  	/* Do not wake up a writer until he can make "significant"
  	 * progress.  --DaveM
  	 */
-	if((atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
+	if(!sk->dead && (atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
  		if (sk->sleep && waitqueue_active(sk->sleep))
  			wake_up_interruptible(sk->sleep);




