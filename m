Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318260AbSHDWyP>; Sun, 4 Aug 2002 18:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318263AbSHDWyO>; Sun, 4 Aug 2002 18:54:14 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:43405 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S318260AbSHDWyN>; Sun, 4 Aug 2002 18:54:13 -0400
Subject: [PATCH] 2.4.19 Bluetooth [3/5] SCO fixes
From: "Maksim (Max) " Krasnyanskiy <maxk@qualcomm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, bluez-devel@usw-pr-web.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1028458635.1003.42.camel@champ.qualcomm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 04 Aug 2002 03:57:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCO updates.

- Socket locking fixes

 sco.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

http://bluez.sourceforge.net/patches/patch-2.4.19-bluetooth-sco.gz

Please apply

Max

diff -urN -x 'hci*' -x 'l2cap*' -x 'af_*' linux.orig/net/bluetooth/sco.c linux/net/bluetooth/sco.c
--- linux.orig/net/bluetooth/sco.c	Sat Aug  3 11:59:47 2002
+++ linux/net/bluetooth/sco.c	Sat Aug  3 18:14:04 2002
@@ -25,9 +25,9 @@
 /*
  * BlueZ SCO sockets.
  *
- * $Id: sco.c,v 1.3 2002/04/17 17:37:16 maxk Exp $
+ * $Id: sco.c,v 1.4 2002/07/22 20:32:54 maxk Exp $
  */
-#define VERSION "0.2"
+#define VERSION "0.3"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -464,19 +464,17 @@
 		goto done;
 	}
 
-	write_lock(&sco_sk_list.lock);
+	write_lock_bh(&sco_sk_list.lock);
 
 	if (bacmp(src, BDADDR_ANY) && __sco_get_sock_by_addr(src)) {
 		err = -EADDRINUSE;
-		goto unlock;
+	} else {
+		/* Save source address */
+		bacpy(&bluez_pi(sk)->src, &sa->sco_bdaddr);
+		sk->state = BT_BOUND;
 	}
 
-	/* Save source address */
-	bacpy(&bluez_pi(sk)->src, &sa->sco_bdaddr);
-	sk->state = BT_BOUND;
-
-unlock:
-	write_unlock(&sco_sk_list.lock);
+	write_unlock_bh(&sco_sk_list.lock);
 
 done:
 	release_sock(sk);
@@ -897,7 +895,7 @@
 	struct sock *sk;
 	char *ptr = buf;
 
-	write_lock(&list->lock);
+	write_lock_bh(&list->lock);
 
 	for (sk = list->head; sk; sk = sk->next) {
 		pi = sco_pi(sk);
@@ -906,7 +904,7 @@
 				sk->state); 
 	}
 
-	write_unlock(&list->lock);
+	write_unlock_bh(&list->lock);
 
 	ptr += sprintf(ptr, "\n");
 

