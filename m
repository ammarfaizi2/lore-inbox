Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965555AbWKDR0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965555AbWKDR0h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 12:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965556AbWKDR0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 12:26:37 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:64740 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S965555AbWKDR0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 12:26:36 -0500
Message-id: <419597213138451@wsc.cz>
Subject: [PATCH 3/6] Char: stallion, brd struct locking
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 18:26:39 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, brd struct locking

Since assigning of stl_brds[brdnr] is racy, add locking to this critical
section.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 35d35cadc88b0f52cc4824fafc6a16f3c9301ef0
tree 4338edc3bf9671b1fafc18413cc08d3e631c7073
parent 47b4f5a42e198be7c2cf3606cf2681c04a42b197
author Jiri Slaby <jirislaby@gmail.com> Thu, 02 Nov 2006 19:31:31 +0100
committer Jiri Slaby <jirislaby@gmail.com> Thu, 02 Nov 2006 19:31:31 +0100

 drivers/char/stallion.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 048d2b0..072a226 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -136,6 +136,7 @@ static char		stl_unwanted[SC26198_RXFIFO
 
 /*****************************************************************************/
 
+static DEFINE_MUTEX(stl_brdslock);
 static struct stlbrd		*stl_brds[STL_MAXBRDS];
 
 /*
@@ -2305,7 +2306,6 @@ static int __devinit stl_brdinit(struct 
 		goto err;
 	}
 
-	stl_brds[brdp->brdnr] = brdp;
 	if ((brdp->state & BRD_FOUND) == 0) {
 		printk("STALLION: %s board not found, board=%d io=%x irq=%d\n",
 			stl_brdnames[brdp->brdtype], brdp->brdnr,
@@ -2331,8 +2331,6 @@ err_free:
 	release_region(brdp->ioaddr1, brdp->iosize1);
 	if (brdp->iosize2 > 0)
 		release_region(brdp->ioaddr2, brdp->iosize2);
-
-	stl_brds[brdp->brdnr] = NULL;
 err:
 	return retval;
 }
@@ -2385,12 +2383,17 @@ static int __devinit stl_pciprobe(struct
 		retval = -ENOMEM;
 		goto err;
 	}
+	mutex_lock(&stl_brdslock);
 	brdp->brdnr = stl_getbrdnr();
 	if (brdp->brdnr < 0) {
 		dev_err(&pdev->dev, "too many boards found, "
 			"maximum supported %d\n", STL_MAXBRDS);
+		mutex_unlock(&stl_brdslock);
 		goto err_fr;
 	}
+	stl_brds[brdp->brdnr] = brdp;
+	mutex_unlock(&stl_brdslock);
+
 	brdp->brdtype = brdtype;
 	brdp->state |= STL_PROBED;
 
@@ -2419,11 +2422,13 @@ static int __devinit stl_pciprobe(struct
 	brdp->irq = pdev->irq;
 	retval = stl_brdinit(brdp);
 	if (retval)
-		goto err_fr;
+		goto err_null;
 
 	pci_set_drvdata(pdev, brdp);
 
 	return 0;
+err_null:
+	stl_brds[brdp->brdnr] = NULL;
 err_fr:
 	kfree(brdp);
 err:
@@ -4737,10 +4742,13 @@ static int __init stallion_module_init(v
 		brdp->irqtype = conf.irqtype;
 		if (stl_brdinit(brdp))
 			kfree(brdp);
-		else
+		else {
+			stl_brds[brdp->brdnr] = brdp;
 			stl_nrbrds = i + 1;
+		}
 	}
 
+	/* this has to be _after_ isa finding because of locking */
 	retval = pci_register_driver(&stl_pcidriver);
 	if (retval && stl_nrbrds == 0)
 		goto err;
