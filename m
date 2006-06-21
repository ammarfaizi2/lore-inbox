Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWFUPHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWFUPHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWFUPHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:07:52 -0400
Received: from mail.gmx.net ([213.165.64.21]:21958 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751429AbWFUPHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:07:52 -0400
X-Authenticated: #704063
Subject: [Patch] Memory leak in drivers/net/irda/via-ircc.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 21 Jun 2006 17:07:48 +0200
Message-Id: <1150902469.20915.15.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this was spotted by coverity (id #653). whenever (len-4<2) we
leak the allocated skb. 

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git2/drivers/net/irda/via-ircc.c.orig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.17-git2/drivers/net/irda/via-ircc.c	2006-06-21 17:02:13.000000000 +0200
@@ -1220,8 +1220,13 @@ static int upload_rxdata(struct via_ircc
 
 	IRDA_DEBUG(2, "%s(): len=%x\n", __FUNCTION__, len);
 
+	if ((len - 4) < 2 ) {
+		self->stats.rx_dropped++;
+		return FALSE;
+	}
+
 	skb = dev_alloc_skb(len + 1);
-	if ((skb == NULL) || ((len - 4) < 2)) {
+	if (skb == NULL) {
 		self->stats.rx_dropped++;
 		return FALSE;
 	}


