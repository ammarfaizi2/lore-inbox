Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130165AbRBATvP>; Thu, 1 Feb 2001 14:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130640AbRBATuz>; Thu, 1 Feb 2001 14:50:55 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:8204 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130165AbRBATur>;
	Thu, 1 Feb 2001 14:50:47 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102011949.WAA21764@ms2.inr.ac.ru>
Subject: Re: AF_UNIX hangs
To: alan@lxorguk.UKuu.ORG.UK (Alan Cox), davem@redhat.com (Dave Miller)
Date: Thu, 1 Feb 2001 22:49:56 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14OOp7-0004rR-00@the-village.bc.nu> from "Alan Cox" at Feb 1, 1 10:15:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Looking at net/core/datagram.c:wait_for_packet the code will return 0

Yep... Damn, specially split errno and ready values and forgot to use
this. 8) Sorry.

Alexey



--- ../vger3-010130/linux/net/core/datagram.c	Thu Dec 28 22:44:08 2000
+++ linux/net/core/datagram.c	Thu Feb  1 22:45:47 2001
@@ -73,19 +73,19 @@
 	/* Socket errors? */
 	error = sock_error(sk);
 	if (error)
-		goto out;
+		goto out_err;
 
 	if (!skb_queue_empty(&sk->receive_queue))
 		goto ready;
 
 	/* Socket shut down? */
 	if (sk->shutdown & RCV_SHUTDOWN)
-		goto out;
+		goto out_noerr;
 
 	/* Sequenced packets can come disconnected. If so we report the problem */
 	error = -ENOTCONN;
 	if(connection_based(sk) && !(sk->state==TCP_ESTABLISHED || sk->state==TCP_LISTEN))
-		goto out;
+		goto out_err;
 
 	/* handle signals */
 	if (signal_pending(current))
@@ -100,11 +100,16 @@
 
 interrupted:
 	error = sock_intr_errno(*timeo_p);
+out_err:
+	*err = error;
 out:
 	current->state = TASK_RUNNING;
 	remove_wait_queue(sk->sleep, &wait);
-	*err = error;
 	return error;
+out_noerr:
+	*err = 0;
+	error = 1;
+	goto out;
 }
 
 /*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
