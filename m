Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751589AbWFUORZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWFUORZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbWFUORZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:17:25 -0400
Received: from mail.gmx.net ([213.165.64.21]:34474 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751584AbWFUORY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:17:24 -0400
X-Authenticated: #704063
Subject: [Patch] Dereference in tokenring/olympic.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: mikep@linuxtr.net
Content-Type: text/plain
Date: Wed, 21 Jun 2006 16:17:17 +0200
Message-Id: <1150899437.20915.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

coverity found (bug id #225) that we might call free_netdev()
with NULL argument, when alloc_trdev() fails. This patch
changes the goto, so we dont call free_netdev() for
dev == NULL.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git2/drivers/net/tokenring/olympic.c.orig	2006-06-21 16:11:46.000000000 +0200
+++ linux-2.6.17-git2/drivers/net/tokenring/olympic.c	2006-06-21 16:13:47.000000000 +0200
@@ -217,7 +217,7 @@ static int __devinit olympic_probe(struc
 	dev = alloc_trdev(sizeof(struct olympic_private)) ; 
 	if (!dev) {
 		i = -ENOMEM; 
-		goto op_free_dev;
+		goto op_release_dev;
 	}
 
 	olympic_priv = dev->priv ;
@@ -282,8 +282,8 @@ op_free_iomap:
 	if (olympic_priv->olympic_lap)
 		iounmap(olympic_priv->olympic_lap);
 
-op_free_dev:
 	free_netdev(dev);
+op_release_dev:
 	pci_release_regions(pdev); 
 
 op_disable_dev:


