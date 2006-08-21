Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbWHUD4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWHUD4M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 23:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWHUD4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 23:56:11 -0400
Received: from nsvr.mlabs.com.my ([219.93.2.104]:40427 "EHLO nrg.cs.usm.my")
	by vger.kernel.org with ESMTP id S932591AbWHUD4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 23:56:10 -0400
Message-ID: <59046.10.207.160.203.1156132556.squirrel@10.207.160.104>
Date: Mon, 21 Aug 2006 11:55:56 +0800 (MYT)
Subject: [Patch] dvb-core: Proper handling ULE SNDU length of 0
From: "Ang Way Chuang" <wcang@nrg.cs.usm.my>
To: "Hilmar Linder" <hlinder@cosy.sbg.ac.at>,
       "Wolfram Stering" <wstering@cosy.sbg.ac.at>
Cc: tcwan@cs.usm.my, chteh@nrg.cs.usm.my, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.6-4.fc2.1.legacy
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ULE (Unidirectional Lightweight Encapsulation RFC 4326) decapsulation code
has a bug that allows an attacker to send a malformed ULE packet with SNDU
length of 0 and bring down the receiving machine. This patch fix the bug and
apply to kernel 2.6.17.8.

Signed-off-by: Ang Way Chuang <wcang@nrg.cs.usm.my>
---

diff -uprN linux-2.6.17.8/drivers/media/dvb/dvb-core/dvb_net.c linux-2.6.17.8-fix/drivers/media/dvb/dvb-core/dvb_net.c
--- linux-2.6.17.8/drivers/media/dvb/dvb-core/dvb_net.c 2006-08-07 12:18:54.000000000 +0800
+++ linux-2.6.17.8-fix/drivers/media/dvb/dvb-core/dvb_net.c     2006-08-21 11:09:12.000000000 +0800
@@ -492,7 +492,7 @@ static void dvb_net_ule( struct net_devi
                                } else
                                        priv->ule_dbit = 0;

-                               if (priv->ule_sndu_len > 32763) {
+                               if (priv->ule_sndu_len > 32763 || priv->ule_sndu_len < ((priv->ule_dbit) ? 4 : 4 + ETH_ALEN)) {
                                        printk(KERN_WARNING "%lu: Invalid ULE SNDU length %u. "
                                               "Resyncing.\n", priv->ts_count, priv->ule_sndu_len);
                                        priv->ule_sndu_len = 0;



