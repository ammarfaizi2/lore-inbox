Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSLSNCg>; Thu, 19 Dec 2002 08:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSLSNCg>; Thu, 19 Dec 2002 08:02:36 -0500
Received: from bender.bawue.de ([193.197.13.1]:16522 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id <S261518AbSLSNCe>;
	Thu, 19 Dec 2002 08:02:34 -0500
Date: Thu, 19 Dec 2002 14:09:52 +0100 (CET)
From: Smolinski <hsmolin@bawue.de>
To: <linux-kernel@vger.kernel.org>, <ak@muc.de>
Cc: <smolinsk@de.ibm.com>, <holger@kunterbunt.bb.bawue.de>
Subject: [PATCH] 2.2.23 wild pointer in struct sock
Message-ID: <Pine.LNX.4.33.0212191358500.2821-100000@helena.bawue.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,
this patch fixes a occurrence of a wild pointer in the cloned
struct sock, after SYN has been received. Kernel 2.4. resolves the 
situation in the same way. Pls. apply.

Holger Smolinski

Index: net/core/sock.c
===================================================================
RCS file: /home/cvs/linux/net/core/sock.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sock.c
--- net/core/sock.c	5 Jan 2000 13:50:34 -0000	1.1.1.1
+++ net/core/sock.c	18 Dec 2002 09:18:05 -0000
@@ -79,6 +79,7 @@
  *		Jay Schulist	:	Added SO_ATTACH_FILTER and SO_DETACH_FILTER.
  *		Andi Kleen	:	Add sock_kmalloc()/sock_kfree_s()
  *		Andi Kleen	:	Fix write_space callback
+ *		Holger Smolinski:	Fix initialization of sk->sleep
  *
  * To Fix:
  *
@@ -1036,6 +1037,8 @@
 		sk->type	=	sock->type;
 		sk->sleep	=	&sock->wait;
 		sock->sk	=	sk;
+	} else {
+		sk->sleep	=	NULL;
 	}
 
 	sk->state_change	=	sock_def_wakeup;
Index: net/ipv4/tcp_ipv4.c
===================================================================
RCS file: /home/cvs/linux/net/ipv4/tcp_ipv4.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 tcp_ipv4.c
--- net/ipv4/tcp_ipv4.c	5 Jan 2000 13:50:34 -0000	1.1.1.1
+++ net/ipv4/tcp_ipv4.c	18 Dec 2002 09:18:05 -0000
@@ -44,7 +44,9 @@
  *		Andi Kleen:		various fixes.
  *	Vitaly E. Lavrov	:	Transparent proxy revived after year coma.
  *	Andi Kleen		:	Fix new listen.
- *	Andi Kleen		:	Fix accept error reporting.
+ *	Andi Kleen		:	Fix accept error reporting.a
+ * 	Holger Smolinski	:	Fix initialization of newsk->sleep which
+ *					points to a potentially invalid wait_queue
  */
 
 #include <linux/config.h>
@@ -1464,6 +1466,7 @@
 		newsk->timer.function = &net_timer;
 		newsk->timer.data = (unsigned long) newsk;
 		newsk->socket = NULL;
+		newsk->sleep = NULL;
 
 		newtp->tstamp_ok = req->tstamp_ok;
 		if((newtp->sack_ok = req->sack_ok) != 0)


