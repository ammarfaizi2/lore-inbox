Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUBEGcj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 01:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUBEGcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 01:32:35 -0500
Received: from esperance.ozonline.com.au ([203.23.159.248]:24705 "EHLO
	ozonline.com.au") by vger.kernel.org with ESMTP id S261606AbUBEGcd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 01:32:33 -0500
Date: Thu, 5 Feb 2004 17:37:01 +1100
From: Davin McCall <davmac@ozonline.com.au>
To: Davin McCall <davmac@ozonline.com.au>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] various IDE patches/cleanups
Message-Id: <20040205173701.23657aa6.davmac@ozonline.com.au>
In-Reply-To: <20040205162138.124d0276.davmac@ozonline.com.au>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
	<200401051516.03364.bzolnier@elka.pw.edu.pl>
	<20040106135155.66535c13.davmac@ozonline.com.au>
	<200401061213.39843.bzolnier@elka.pw.edu.pl>
	<20040130142725.1a408f9e.davmac@ozonline.com.au>
	<20040130143041.1eb70817.davmac@ozonline.com.au>
	<20040130143355.630346cc.davmac@ozonline.com.au>
	<20040205162138.124d0276.davmac@ozonline.com.au>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grumble grumble "patch" doesn't like my hand-editing.
Try again.


diff -urN linux-2.6.0-patch2/drivers/ide/ide-io.c linux-2.6.0/drivers/ide/ide-io.c
--- linux-2.6.0-patch2/drivers/ide/ide-io.c	Wed Jan 28 22:55:00 2004
+++ linux-2.6.0/drivers/ide/ide-io.c	Wed Jan 28 23:49:17 2004
@@ -1303,8 +1303,13 @@
 		hwgroup->busy = 1;	/* paranoia */
 		printk(KERN_ERR "%s: ide_intr: hwgroup->busy was 0 ??\n", drive->name);
 	}
+	if (!del_timer(&hwgroup->timer)) {
+		/* timer has expired, ide_timer_expiry is waiting to get lock */
+		hwgroup->expiry = NULL;
+		spin_unlock(&ide_lock);
+		return IRQ_HANDLED;
+	}
 	hwgroup->handler = NULL;
-	del_timer(&hwgroup->timer);
 	spin_unlock(&ide_lock);
 
 	if (drive->unmask)
