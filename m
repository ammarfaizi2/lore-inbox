Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUBEFRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 00:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbUBEFRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 00:17:13 -0500
Received: from esperance.ozonline.com.au ([203.23.159.248]:42452 "EHLO
	ozonline.com.au") by vger.kernel.org with ESMTP id S264359AbUBEFRL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 00:17:11 -0500
Date: Thu, 5 Feb 2004 16:21:38 +1100
From: Davin McCall <davmac@ozonline.com.au>
To: Davin McCall <davmac@ozonline.com.au>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] various IDE patches/cleanups
Message-Id: <20040205162138.124d0276.davmac@ozonline.com.au>
In-Reply-To: <20040130143355.630346cc.davmac@ozonline.com.au>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
	<200401051516.03364.bzolnier@elka.pw.edu.pl>
	<20040106135155.66535c13.davmac@ozonline.com.au>
	<200401061213.39843.bzolnier@elka.pw.edu.pl>
	<20040130142725.1a408f9e.davmac@ozonline.com.au>
	<20040130143041.1eb70817.davmac@ozonline.com.au>
	<20040130143355.630346cc.davmac@ozonline.com.au>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damn, I found a problem with this. Needs to set hwgroup->expiry to NULL before releasing ide_lock; that prevents ide_timer_expiry() from running the expiry() handler and instead it will simulate an interrupt.

Otherwise, expiry() may return non-zero which will cause the timer to be reset. The interrupt would effectively be lost. In some cases (abuses?) this would lock the whole hwgroup forever as the expiry() function always returns > 0 (ide-cd.c, cdrom_timer_expiry() for example).

Here's the revised patch.


diff -urN linux-2.6.0-patch2/drivers/ide/ide-io.c linux-2.6.0/drivers/ide/ide-io.c
--- linux-2.6.0-patch2/drivers/ide/ide-io.c	Wed Jan 28 22:55:00 2004
+++ linux-2.6.0/drivers/ide/ide-io.c	Wed Jan 28 23:49:17 2004
@@ -1303,8 +1303,12 @@
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
