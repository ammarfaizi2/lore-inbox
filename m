Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932790AbWCVVaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbWCVVaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWCVVai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:30:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:50620 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932790AbWCVVah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:30:37 -0500
X-Authenticated: #704063
Subject: [Patch] Use after free in net/tulip/de2104x.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Content-Type: text/plain
Date: Wed, 22 Mar 2006 22:30:34 +0100
Message-Id: <1143063034.26499.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity bug #912, where skb is freed first,
and dereferenced a few lines later with skb->len.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.16/drivers/net/tulip/de2104x.c.orig	2006-03-22 22:21:53.000000000 +0100
+++ linux-2.6.16/drivers/net/tulip/de2104x.c	2006-03-22 22:25:31.000000000 +0100
@@ -1332,11 +1332,11 @@ static void de_clean_rings (struct de_pr
 		struct sk_buff *skb = de->tx_skb[i].skb;
 		if ((skb) && (skb != DE_DUMMY_SKB)) {
 			if (skb != DE_SETUP_SKB) {
-				dev_kfree_skb(skb);
 				de->net_stats.tx_dropped++;
 				pci_unmap_single(de->pdev,
 					de->tx_skb[i].mapping,
 					skb->len, PCI_DMA_TODEVICE);
+				dev_kfree_skb(skb);
 			} else {
 				pci_unmap_single(de->pdev,
 					de->tx_skb[i].mapping,


