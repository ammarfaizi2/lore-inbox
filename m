Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262476AbRENUYW>; Mon, 14 May 2001 16:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262479AbRENUYN>; Mon, 14 May 2001 16:24:13 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:31732 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S262476AbRENUYD>; Mon, 14 May 2001 16:24:03 -0400
From: Michal Ostrowski <mostrows@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15104.16099.223073.943662@slug.watson.ibm.com>
Date: Mon, 14 May 2001 16:24:03 -0400
To: Marcell Gal <cell@sch.bme.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling in interrupt BUG. [Patch]
In-Reply-To: <3B003E2E.7287DC0B@sch.bme.hu>
In-Reply-To: <3AFFBF14.7D7BAB01@sch.bme.hu>
	<15103.53345.869090.593925@slug.watson.ibm.com>
	<3B003E2E.7287DC0B@sch.bme.hu>
X-Mailer: VM 6.92 under 21.4 (patch 1) "Copyleft" XEmacs Lucid
Reply-To: mostrows@speakeasy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcell Gal writes:
 > Hi,
 > 
 > This patch solved the problem. Should be ready for inclusion in 2.4.
 > No more 'Scheduling in interrupt' under those conditions.
 > Thanx for the thoughts, solution and the amazing speed.
 > You guys are doing a really great job!
 > 

Alexey pointed out a much nicer/correct/elegant/efficient
solution to this problem and I think that that's the way to go.

New patch below.

Michal Ostrowski
mostrows@speakeasy.net


--- drivers/net/pppoe.c~	Tue Mar  6 22:44:35 2001
+++ drivers/net/pppoe.c	Mon May 14 14:10:49 2001
@@ -5,7 +5,7 @@
  * PPPoE --- PPP over Ethernet (RFC 2516)
  *
  *
- * Version:    0.6.5
+ * Version:    0.6.6
  *
  * 030700 :     Fixed connect logic to allow for disconnect.
  * 270700 :	Fixed potential SMP problems; we must protect against
@@ -19,6 +19,7 @@
  * 051000 :	Initialization cleanup.
  * 111100 :	Fix recvmsg.
  * 050101 :	Fix PADT procesing.
+ * 140501 :	Use pppoe_rcv_core to handle all backlog. (Alexey)
  *
  * Author:	Michal Ostrowski <mostrows@styx.uwaterloo.ca>
  * Contributors:
@@ -376,22 +377,6 @@
 	return ret;
 }
 
-
-/************************************************************************
- *
- * Receive wrapper called in process context.
- *
- ***********************************************************************/
-int pppoe_backlog_rcv(struct sock *sk, struct sk_buff *skb)
-{
-	lock_sock(sk);
-	pppoe_rcv_core(sk, skb);
-	release_sock(sk);
-	return 0;
-}
-
-
-
 /************************************************************************
  *
  * Receive a PPPoE Discovery frame.
@@ -481,7 +466,7 @@
 	sk->protocol = PX_PROTO_OE;
 	sk->family = PF_PPPOX;
 
-	sk->backlog_rcv = pppoe_backlog_rcv;
+	sk->backlog_rcv = pppoe_rcv_core;
 	sk->next = NULL;
 	sk->pprev = NULL;
 	sk->state = PPPOX_NONE;

