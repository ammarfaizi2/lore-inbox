Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422725AbWJFXCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422725AbWJFXCT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWJFXCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:02:19 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:62874 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1422725AbWJFXCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:02:17 -0400
Message-id: <34287982334@wsc.cz>
Subject: [PATCH 3/6] Char: mxser_new, correct fail paths
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat,  7 Oct 2006 01:02:16 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, correct fail paths

Resources were not released in some fail paths. Correct this behaviour by
implementing function and calling it when something fails.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 39c9825cc56a093e7779780e2928cf8944cb1148
tree 00f7949a299c7023a30bb290dcfb8c4bea7cf634
parent 104fc67145e462bc89c0f778a1907f96cd150873
author Jiri Slaby <jirislaby@gmail.com> Sat, 07 Oct 2006 00:07:23 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 07 Oct 2006 00:07:23 +0200

 drivers/char/mxser_new.c |   49 +++++++++++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 84d72aa..073926e 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2563,6 +2563,22 @@ static const struct tty_operations mxser
  * The MOXA Smartio/Industio serial driver boot-time initialization code!
  */
 
+static void mxser_release_res(struct mxser_board *brd, unsigned int irq)
+{
+	struct pci_dev *pdev = brd->pdev;
+
+	if (irq)
+		free_irq(brd->irq, brd);
+	if (pdev != NULL) {	/* PCI */
+		pci_release_region(pdev, 2);
+		pci_release_region(pdev, 3);
+		pci_dev_put(pdev);
+	} else {
+		release_region(brd->ports[0].ioaddr, 8 * brd->nports);
+		release_region(brd->vector, 1);
+	}
+}
+
 static int __devinit mxser_initbrd(struct mxser_board *brd)
 {
 	struct mxser_port *info;
@@ -2613,6 +2629,8 @@ static int __devinit mxser_initbrd(struc
 		printk(KERN_ERR "Board %s: Request irq failed, IRQ (%d) may "
 			"conflict with another device.\n",
 			mxser_brdname[brd->board_type - 1], brd->irq);
+		/* We hold resources, we need to release them. */
+		mxser_release_res(brd, 0);
 		return retval;
 	}
 	return 0;
@@ -2963,14 +2981,9 @@ static int __init mxser_module_init(void
 				" driver !\n");
 		put_tty_driver(mxvar_sdriver);
 
-		for (i = 0; i < MXSER_BOARDS; i++) {
-			if (mxser_boards[i].board_type == -1)
-				continue;
-			else {
-				free_irq(mxser_boards[i].irq, &mxser_boards[i]);
-				/* todo: release io, vector */
-			}
-		}
+		for (i = 0; i < MXSER_BOARDS; i++)
+			if (mxser_boards[i].board_type != -1)
+				mxser_release_res(&mxser_boards[i], 1);
 		return retval;
 	}
 
@@ -2991,24 +3004,10 @@ static void __exit mxser_module_exit(voi
 	else
 		printk(KERN_ERR "Couldn't unregister MOXA Smartio/Industio family serial driver\n");
 
-	for (i = 0; i < MXSER_BOARDS; i++) {
-		struct pci_dev *pdev;
+	for (i = 0; i < MXSER_BOARDS; i++)
+		if (mxser_boards[i].board_type != -1)
+			mxser_release_res(&mxser_boards[i], 1);
 
-		if (mxser_boards[i].board_type == -1)
-			continue;
-		else {
-			pdev = mxser_boards[i].pdev;
-			free_irq(mxser_boards[i].irq, &mxser_boards[i]);
-			if (pdev != NULL) {	/* PCI */
-				pci_release_region(pdev, 2);
-				pci_release_region(pdev, 3);
-				pci_dev_put(pdev);
-			} else {
-				release_region(mxser_boards[i].ports[0].ioaddr, 8 * mxser_boards[i].nports);
-				release_region(mxser_boards[i].vector, 1);
-			}
-		}
-	}
 	pr_debug("Done.\n");
 }
 
