Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTIWAer (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTIWAer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 20:34:47 -0400
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:22719 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263183AbTIWAel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 20:34:41 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16239.38154.969505.748461@wombat.chubb.wattle.id.au>
Date: Tue, 23 Sep 2003 10:34:18 +1000
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andi Kleen <ak@suse.de>, Peter Chubb <peter@chubb.wattle.id.au>,
       Grant Grundler <iod00d@hp.com>, Peter Chubb <peterc@gelato.unsw.edu.au>,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <20030919064922.B3783@kvack.org>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au>
	<20030919043847.GA2996@cup.hp.com>
	<20030919044315.GC7666@wotan.suse.de>
	<16234.36238.848366.753588@wombat.chubb.wattle.id.au>
	<20030919055304.GE16928@wotan.suse.de>
	<20030919064922.B3783@kvack.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, a patch for the driver in 2.6.0-test5 is appended.

I suspect that there are other architectures that don't like unaligned
accesses...  feel free to add them to the #ifdef.
This is based on code I found in the revision history.  It seems to
work.

Without this patch, the console messages saying `unaligned access'
would come out fast enough and often enough to delay and or miss
interrupts, leading to an eventual machine hangup on I2000.

===== drivers/net/ns83820.c 1.30 vs edited =====
--- 1.30/drivers/net/ns83820.c	Thu Sep 11 09:46:45 2003
+++ edited/drivers/net/ns83820.c	Mon Sep 22 12:49:18 2003
@@ -793,6 +793,25 @@
 	}
 }
 
+#if defined(__ia64__)
+static inline struct sk_buff *skb_realign_iphdr(struct sk_buff *skb, int len, struct ns83820 *dev)
+{
+	struct sk_buff *tmp = __dev_alloc_skb(len+2, GFP_ATOMIC);
+	if (!tmp)
+		return NULL;
+	tmp->dev = &dev->net_dev;
+	skb_reserve(tmp, 2);
+	memcpy(skb_put(tmp, len), skb->data, len);
+	kfree_skb(skb);
+	return tmp;
+}
+#else
+static inline  struct sk_buff *skb_realign_iphdr(struct sk_buff *skb, int len, struct ns83820 *dev)
+{
+	return skb;
+}
+#endif
+
 static void FASTCALL(ns83820_rx_kick(struct ns83820 *dev));
 static void ns83820_rx_kick(struct ns83820 *dev)
 {
@@ -862,6 +881,7 @@
 		if (likely(CMDSTS_OK & cmdsts)) {
 			int len = cmdsts & 0xffff;
 			skb_put(skb, len);
+			skb = skb_realign_iphdr(skb, len, dev);
 			if (unlikely(!skb))
 				goto netdev_mangle_me_harder_failed;
 			if (cmdsts & CMDSTS_DEST_MULTI)
