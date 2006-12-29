Return-Path: <linux-kernel-owner+w=401wt.eu-S965165AbWL2U4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWL2U4Z (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 15:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWL2U4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 15:56:25 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:42661 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965165AbWL2U4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 15:56:17 -0500
Message-id: <223225458143254603@wsc.cz>
In-reply-to: <26150293961999718626@wsc.cz>
Subject: [PATCH 4/4] Char: mxser_new, fix twice resource releasing
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Sergei Organov <osv@javad.com>
Date: Fri, 29 Dec 2006 21:56:25 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, fix twice resource releasing

Because brd->info is not NULLed, resources are released twice. NULL it in
pci_remove function. Also take care of retval and releasing in pci_probe --
mxser_initbrd alreasy releases resource, do not do it again in fail path in
probe function.

Cc: Sergei Organov <osv@javad.com>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 549237a65498ad3880cd1ca40f23f8bc942041cb
tree 8208eb0eb881aa6bd1532c90a60c72009415e3e1
parent 5065aa25fd624e3477d993baebbf3255a1d492fa
author Jiri Slaby <jirislaby@gmail.com> Fri, 29 Dec 2006 21:38:56 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 29 Dec 2006 21:38:56 +0059

 drivers/char/mxser_new.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 042d138..f078ddf 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2403,9 +2403,8 @@ static int __devinit mxser_initbrd(struct mxser_board *brd,
 			brd->info->name, brd->irq);
 		/* We hold resources, we need to release them. */
 		mxser_release_res(brd, pdev, 0);
-		return retval;
 	}
-	return 0;
+	return retval;
 }
 
 static int __init mxser_get_ISA_conf(int cap, struct mxser_board *brd)
@@ -2590,8 +2589,9 @@ static int __devinit mxser_probe(struct pci_dev *pdev,
 	}
 
 	/* mxser_initbrd will hook ISR. */
-	if (mxser_initbrd(brd, pdev) < 0)
-		goto err_relvec;
+	retval = mxser_initbrd(brd, pdev);
+	if (retval)
+		goto err_null;
 
 	for (i = 0; i < brd->info->nports; i++)
 		tty_register_device(mxvar_sdriver, brd->idx + i, &pdev->dev);
@@ -2599,10 +2599,9 @@ static int __devinit mxser_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, brd);
 
 	return 0;
-err_relvec:
-	pci_release_region(pdev, 3);
 err_relio:
 	pci_release_region(pdev, 2);
+err_null:
 	brd->info = NULL;
 err:
 	return retval;
@@ -2620,6 +2619,7 @@ static void __devexit mxser_remove(struct pci_dev *pdev)
 		tty_unregister_device(mxvar_sdriver, brd->idx + i);
 
 	mxser_release_res(brd, pdev, 1);
+	brd->info = NULL;
 }
 
 static struct pci_driver mxser_driver = {
