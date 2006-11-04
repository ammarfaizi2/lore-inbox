Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965671AbWKDU3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965671AbWKDU3O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965672AbWKDU3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:29:13 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:53440 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S965671AbWKDU3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:29:09 -0500
Message-id: <5384323662150832498@wsc.cz>
Subject: [PATCH 6/8] Char: istallion, brdnr locking
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 21:29:18 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, brdnr locking

Kill possible race when getting brdnr by locking.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 177cc17270356497ba04bb03b5688e429c3cfbdb
tree 99b7588bebeed73a6218748e62a4526694d8a011
parent b2606947cdfd650f706f4d0f97574a2a00c325ce
author Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 20:48:07 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 20:48:07 +0059

 drivers/char/istallion.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index aff6a4c..6569398 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -189,6 +189,7 @@ static struct asystats	stli_cdkstats;
 
 /*****************************************************************************/
 
+static DEFINE_MUTEX(stli_brdslock);
 static struct stlibrd	*stli_brds[STL_MAXBRDS];
 
 static int		stli_shared;
@@ -3677,8 +3678,6 @@ stli_donestartup:
 
 static int __devinit stli_brdinit(struct stlibrd *brdp)
 {
-	stli_brds[brdp->brdnr] = brdp;
-
 	switch (brdp->brdtype) {
 	case BRD_ECP:
 	case BRD_ECPE:
@@ -3896,6 +3895,7 @@ static int stli_findeisabrds(void)
 		outb(0x1, (iobase + 0xc84));
 		if (stli_eisamemprobe(brdp))
 			outb(0, (iobase + 0xc84));
+		stli_brds[brdp->brdnr] = brdp;
 		stli_brdinit(brdp);
 	}
 
@@ -3933,14 +3933,18 @@ static int __devinit stli_pciprobe(struc
 		retval = -ENOMEM;
 		goto err;
 	}
+	mutex_lock(&stli_brdslock);
 	brdnr = stli_getbrdnr();
-	if (brdnr < 0) { /* TODO: locking */
+	if (brdnr < 0) {
 		printk(KERN_INFO "STALLION: too many boards found, "
 			"maximum supported %d\n", STL_MAXBRDS);
+		mutex_unlock(&stli_brdslock);
 		retval = -EIO;
 		goto err_fr;
 	}
 	brdp->brdnr = (unsigned int)brdnr;
+	stli_brds[brdp->brdnr] = brdp;
+	mutex_unlock(&stli_brdslock);
 	brdp->brdtype = BRD_ECPPCI;
 /*
  *	We have all resources from the board, so lets setup the actual
@@ -3950,11 +3954,13 @@ static int __devinit stli_pciprobe(struc
 	brdp->memaddr = pci_resource_start(pdev, 2);
 	retval = stli_brdinit(brdp);
 	if (retval)
-		goto err_fr;
+		goto err_null;
 
 	pci_set_drvdata(pdev, brdp);
 
 	return 0;
+err_null:
+	stli_brds[brdp->brdnr] = NULL;
 err_fr:
 	kfree(brdp);
 err:
@@ -4026,6 +4032,7 @@ static int stli_initbrds(void)
 		brdp->brdtype = conf.brdtype;
 		brdp->iobase = conf.ioaddr1;
 		brdp->memaddr = conf.memaddr;
+		stli_brds[brdp->brdnr] = brdp;
 		stli_brdinit(brdp);
 	}
 
