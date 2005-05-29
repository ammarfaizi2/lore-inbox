Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVE2Tsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVE2Tsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 15:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVE2Tsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 15:48:51 -0400
Received: from mail.macqel.be ([194.78.208.39]:40711 "EHLO mail.macqel.be")
	by vger.kernel.org with ESMTP id S261418AbVE2Tso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 15:48:44 -0400
Message-Id: <200505291948.j4TJmgZ25169@mail.macqel.be>
Subject: PATCH : ppp + big-endian = kernel crash
To: linux-kernel@vger.kernel.org
Date: Sun, 29 May 2005 21:48:42 +0200 (CEST)
From: "Philippe De Muyter" <phdm@macqel.be>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

My m68k linux crashed often in ksoftirqd/0 with an `address error' (word
access to an even address) in function ip_rcv, at line 405 (line numbers
valid in current sources as of 2005-05-29) of net/ipv4/ip_input.c,
failing to execute :

	    405                 __u32 len = ntohs(iph->tot_len);

because iph was odd, tot_len is a 16-bit field and ntohs is a nop on
big-endian machines.

I searched the origin of that odd pointer, and found it in
process_input_packet at line 819 of drivers/net/ppp_async.c :

	    819                 skb_push(skb, 1)[0] = 0; 

This subtracts 1 from the packet address, yielding an odd pointer if
we had an even one and conversely.  My proposed fix is below.

Feel free to apply that to the main source trees.

Philippe

Philippe De Muyter  phdm at macqel dot be  Tel +32 27029044
Macq Electronique SA  rue de l'Aeronef 2  B-1140 Bruxelles  Fax +32 27029077

--- ppp_async.c.orig	2005-05-29 20:28:44.000000000 +0200
+++ ppp_async.c	2005-05-29 21:16:16.000000000 +0200
@@ -817,6 +817,16 @@
 	if (proto & 1) {
 		/* protocol is compressed */
 		skb_push(skb, 1)[0] = 0;
+		/* If the address of the packet is odd now, fix it. */
+		if ((unsigned long)skb->data & 1) {
+			unsigned char *p;
+			int n;
+
+			p = skb_put(skb, 1);
+			for (n = skb->len; --n >= 0; p -= 1)
+				p[0] = p[-1];
+			skb_pull(skb, 1);
+		}
 	} else {
 		if (skb->len < 2)
 			goto err;
@@ -890,6 +900,12 @@
 				if (skb == 0)
 					goto nomem;
 				/* Try to get the payload 4-byte aligned */
+				/* This should match the
+				** PPP_ALLSTATIONS/PPP_UI/compressed tests
+				** in process_input_packet,
+				** but we do not have enough chars here and
+				** now to test buf[1] and buf[2].
+				*/
 				if (buf[0] != PPP_ALLSTATIONS)
 					skb_reserve(skb, 2 + (buf[0] & 1));
 				ap->rpkt = skb;
