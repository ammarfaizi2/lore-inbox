Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281081AbRKTOqs>; Tue, 20 Nov 2001 09:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281080AbRKTOqa>; Tue, 20 Nov 2001 09:46:30 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:10333 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S281077AbRKTOqR>; Tue, 20 Nov 2001 09:46:17 -0500
Date: Tue, 20 Nov 2001 15:46:10 +0100
From: Jeroen Vreeken <pe1rxq@amsat.org>
To: linux-hams <linux-hams@vger.kernel.org>
Cc: tomi.manninen@hut.fi, dg2fef@afthd.tu-darmstatdt.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Using sock_orphan in ax25 and netrom
Message-ID: <20011120154610.A189@jeroen.pe1rxq.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Yesterday's patch proved to be just a piece of bandaid for a larger
problem: ax25 doesn't use sock_orphan() to set sk->dead. Included is a
patch for both ax25 and netrom to fix this problem.

Jeroen


diff -ruN linux-2.4.14/net/ax25/af_ax25.c linux/net/ax25/af_ax25.c
--- linux-2.4.14/net/ax25/af_ax25.c	Fri Sep 14 02:16:23 2001
+++ linux/net/ax25/af_ax25.c	Mon Nov 19 21:36:09 2001
@@ -102,6 +102,7 @@
  *			Joerg(DL1BKE)		Added support for
SO_BINDTODEVICE
  *			Arnaldo C. Melo		s/suser/capable(CAP_NET_ADMIN)/,
some more cleanups
  *			Michal Ostrowski	Module initialization
cleanup.
+ *			Jeroen(PE1RXQ)		Use sock_orphan to
set sk->dead.
  */
 
 #include <linux/config.h>
@@ -423,7 +424,7 @@
 	if (ax25->sk != NULL) {
 		while ((skb = skb_dequeue(&ax25->sk->receive_queue)) !=
NULL) {
 			if (skb->sk != ax25->sk) {			/* A
pending connection */
-				skb->sk->dead = 1;	/* Queue the unaccepted
socket for death */
+				sock_orphan(skb->sk);	/* Queue the
unaccepted socket for death */
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
 
diff -ruN linux-2.4.14/net/ax25/ax25_ds_timer.c
linux/net/ax25/ax25_ds_timer.c
--- linux-2.4.14/net/ax25/ax25_ds_timer.c	Fri Dec 29 23:35:47 2000
+++ linux/net/ax25/ax25_ds_timer.c	Mon Nov 19 21:57:29 2001
@@ -162,7 +162,7 @@
 		ax25->sk->shutdown |= SEND_SHUTDOWN;
 		if (!ax25->sk->dead)
 			ax25->sk->state_change(ax25->sk);
-		ax25->sk->dead      = 1;
+		sock_orphan(ax25->sk);
 	}
 }
 
diff -ruN linux-2.4.14/net/ax25/ax25_std_timer.c
linux/net/ax25/ax25_std_timer.c
--- linux-2.4.14/net/ax25/ax25_std_timer.c	Fri Dec 29 23:35:47 2000
+++ linux/net/ax25/ax25_std_timer.c	Mon Nov 19 21:57:29 2001
@@ -109,7 +109,7 @@
 		ax25->sk->shutdown |= SEND_SHUTDOWN;
 		if (!ax25->sk->dead)
 			ax25->sk->state_change(ax25->sk);
-		ax25->sk->dead      = 1;
+		sock_orphan(ax25->sk);
 	}
 }
 
diff -ruN linux-2.4.14/net/ax25/ax25_subr.c linux/net/ax25/ax25_subr.c
--- linux-2.4.14/net/ax25/ax25_subr.c	Sat Jun 30 04:38:26 2001
+++ linux/net/ax25/ax25_subr.c	Mon Nov 19 21:57:29 2001
@@ -310,6 +310,6 @@
 		ax25->sk->shutdown |= SEND_SHUTDOWN;
 		if (!ax25->sk->dead)
 			ax25->sk->state_change(ax25->sk);
-		ax25->sk->dead      = 1;
+		sock_orphan(ax25->sk);
 	}
 }
diff -ruN linux-2.4.14/net/netrom/af_netrom.c linux/net/netrom/af_netrom.c
--- linux-2.4.14/net/netrom/af_netrom.c	Mon Sep 10 16:58:35 2001
+++ linux/net/netrom/af_netrom.c	Mon Nov 19 21:36:09 2001
@@ -31,6 +31,7 @@
  *	NET/ROM 007	Jonathan(G4KLX)	New timer
architecture.
  *					Impmented Idle timer.
  *			Arnaldo C. Melo s/suser/capable/, micro cleanups
+ *			Jeroen (PE1RXQ)	Use sock_orphan to set
sk->dead.
  */
 
 #include <linux/config.h>
@@ -316,7 +317,7 @@
 
 	while ((skb = skb_dequeue(&sk->receive_queue)) != NULL) {
 		if (skb->sk != sk) {			/* A pending
connection */
-			skb->sk->dead = 1;	/* Queue the unaccepted
socket for death */
+			sock_orphan(skb->sk);	/* Queue the
unaccepted socket for death */
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
diff -ruN linux-2.4.14/net/netrom/nr_subr.c linux/net/netrom/nr_subr.c
--- linux-2.4.14/net/netrom/nr_subr.c	Thu Jun 28 02:10:55 2001
+++ linux/net/netrom/nr_subr.c	Mon Nov 19 21:39:01 2001
@@ -284,5 +284,5 @@
 	if (!sk->dead)
 		sk->state_change(sk);
 
-	sk->dead = 1;
+	sock_orphan(sk);
 }
diff -ruN linux-2.4.14/net/netrom/nr_timer.c linux/net/netrom/nr_timer.c
--- linux-2.4.14/net/netrom/nr_timer.c	Fri Dec 29 23:44:46 2000
+++ linux/net/netrom/nr_timer.c	Mon Nov 19 21:39:17 2001
@@ -201,7 +201,7 @@
 	if (!sk->dead)
 		sk->state_change(sk);
 
-	sk->dead = 1;
+	sock_orphan(sk);
 }
 
 static void nr_t1timer_expiry(unsigned long param)


