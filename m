Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280257AbRKSRLe>; Mon, 19 Nov 2001 12:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280254AbRKSRL0>; Mon, 19 Nov 2001 12:11:26 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.21]:57943 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id <S280203AbRKSRLO>; Mon, 19 Nov 2001 12:11:14 -0500
Date: Mon, 19 Nov 2001 18:11:06 +0100
From: Jeroen Vreeken <pe1rxq@amsat.org>
To: linux-kernel@vger.kernel.org
Cc: linux-hams <linux-hams@vger.kernel.org>, netdev@oss.sgi.com
Subject: [PATCH] bug in sock.c
Message-ID: <20011119181106.A604@jeroen.pe1rxq.ampr.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AWniW0JNca5xppdA"
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AWniW0JNca5xppdA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I finally found the reason ax25 was causing oopses on several systems with
2.4.x kernels.
It was caused by a missing check for sk->dead in sock_def_write_space.
The attached patch solved my problems.

Jeroen

--AWniW0JNca5xppdA
Content-Type: application/octet-stream; charset=us-ascii
Content-Disposition: attachment; filename="sock.c.diff"

--- linux-2.4.13/net/core/sock.c	Fri Nov 15 21:12:38 2001
+++ linux/net/core/sock.c	Fri Nov 16 20:53:55 2001
@@ -81,6 +81,7 @@
  *		Andi Kleen	:	Fix write_space callback
  *		Chris Evans	:	Security fixes - signedness again
  *		Arnaldo C. Melo :       cleanups, use skb_queue_purge
+ *		Jeroen Vreeken	:	Add check for sk->dead in sock_def_write_space
  *
  * To Fix:
  *
@@ -1130,7 +1131,7 @@
 	/* Do not wake up a writer until he can make "significant"
 	 * progress.  --DaveM
 	 */
-	if((atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
+	if(!sk->dead && (atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
 		if (sk->sleep && waitqueue_active(sk->sleep))
 			wake_up_interruptible(sk->sleep);
 

--AWniW0JNca5xppdA--


