Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWADVCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWADVCi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWADU76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:59:58 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:52894 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751291AbWADU7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:59:55 -0500
Message-Id: <200601042152.k04Lq8Sh009263@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 9/9] UML - Free network IRQ correctly
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Jan 2006 16:52:08 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Free the network IRQ when closing down the network devices at shutdown.
Delete the device from the opened devices list on close.
These prevent an -EBADF when later disabling SIGIO on all extant 
descriptors and a complaint from free_irq about freeing the IRQ twice.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/net_kern.c	2006-01-03 17:29:31.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/net_kern.c	2006-01-04 14:57:58.000000000 -0500
@@ -150,6 +150,7 @@ static int uml_net_close(struct net_devi
 	if(lp->close != NULL)
 		(*lp->close)(lp->fd, &lp->user);
 	lp->fd = -1;
+	list_del(&lp->list);
 
 	spin_unlock(&lp->lock);
 	return 0;
@@ -715,6 +716,7 @@ static void close_devices(void)
 
 	list_for_each(ele, &opened){
 		lp = list_entry(ele, struct uml_net_private, list);
+		free_irq(lp->dev->irq, lp->dev);
 		if((lp->close != NULL) && (lp->fd >= 0))
 			(*lp->close)(lp->fd, &lp->user);
 		if(lp->remove != NULL) (*lp->remove)(&lp->user);

