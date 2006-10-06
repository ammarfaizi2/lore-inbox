Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422726AbWJFXDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWJFXDG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWJFXDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:03:05 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:667 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S932663AbWJFXDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:03:01 -0400
Message-id: <34287982354@wsc.cz>
Subject: [PATCH 5/6] Char: mxser_new, compress isa finding
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat,  7 Oct 2006 01:03:00 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, compress isa finding

ISA cards finding was too complex -- 2 (module params + predefined) absolutely
same routines, join them together with one for loop, one if and one indent
level.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 27366d3720e2c8f1abad4dd24ca407544ba55cd5
tree de16e5688b36c0f307770d7ce4bc3405098acb58
parent 24213aff7a051554d9e489db5d60605e1a6ae7ab
author Jiri Slaby <jirislaby@gmail.com> Sat, 07 Oct 2006 00:24:59 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 07 Oct 2006 00:24:59 +0200

 drivers/char/mxser_new.c |  109 +++++++++++++++++-----------------------------
 1 files changed, 40 insertions(+), 69 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 25c5091..a64e716 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2803,7 +2803,8 @@ static int __init mxser_module_init(void
 {
 	struct pci_dev *pdev = NULL;
 	struct mxser_board *brd;
-	unsigned int i, m;
+	unsigned long cap;
+	unsigned int i, m, isaloop;
 	int retval, b, n;
 
 	pr_debug("Loading module mxser ...\n");
@@ -2839,84 +2840,54 @@ static int __init mxser_module_init(void
 
 	m = 0;
 	/* Start finding ISA boards here */
-	for (b = 0; b < MXSER_BOARDS && m < MXSER_BOARDS; b++) {
-		int cap;
-
-		if (!(cap = mxserBoardCAP[b]))
-			continue;
-
-		brd = &mxser_boards[m];
-		retval = mxser_get_ISA_conf(cap, brd);
-
-		if (retval != 0)
-			printk(KERN_INFO "Found MOXA %s board (CAP=0x%x)\n",
-				mxser_brdname[brd->board_type - 1], ioaddr[b]);
-
-		if (retval <= 0) {
-			if (retval == MXSER_ERR_IRQ)
-				printk(KERN_ERR "Invalid interrupt number, "
-					"board not configured\n");
-			else if (retval == MXSER_ERR_IRQ_CONFLIT)
-				printk(KERN_ERR "Invalid interrupt number, "
-					"board not configured\n");
-			else if (retval == MXSER_ERR_VECTOR)
-				printk(KERN_ERR "Invalid interrupt vector, "
-					"board not configured\n");
-			else if (retval == MXSER_ERR_IOADDR)
-				printk(KERN_ERR "Invalid I/O address, "
-					"board not configured\n");
+	for (isaloop = 0; isaloop < 2; isaloop++)
+		for (b = 0; b < MXSER_BOARDS && m < MXSER_BOARDS; b++) {
+			if (!isaloop)
+				cap = mxserBoardCAP[b]; /* predefined */
+			else
+				cap = ioaddr[b]; /* module param */
 
-			continue;
-		}
+			if (!cap)
+				continue;
 
-		brd->pdev = NULL;
+			brd = &mxser_boards[m];
+			retval = mxser_get_ISA_conf(cap, brd);
 
-		/* mxser_initbrd will hook ISR. */
-		if (mxser_initbrd(brd) < 0)
-			continue;
+			if (retval != 0)
+				printk(KERN_INFO "Found MOXA %s board "
+					"(CAP=0x%x)\n",
+					mxser_brdname[brd->board_type - 1],
+					ioaddr[b]);
 
-		m++;
-	}
+			if (retval <= 0) {
+				if (retval == MXSER_ERR_IRQ)
+					printk(KERN_ERR "Invalid interrupt "
+						"number, board not "
+						"configured\n");
+				else if (retval == MXSER_ERR_IRQ_CONFLIT)
+					printk(KERN_ERR "Invalid interrupt "
+						"number, board not "
+						"configured\n");
+				else if (retval == MXSER_ERR_VECTOR)
+					printk(KERN_ERR "Invalid interrupt "
+						"vector, board not "
+						"configured\n");
+				else if (retval == MXSER_ERR_IOADDR)
+					printk(KERN_ERR "Invalid I/O address, "
+						"board not configured\n");
 
-	/* Start finding ISA boards from module arg */
-	for (b = 0; b < MXSER_BOARDS && m < MXSER_BOARDS; b++) {
-		unsigned long cap;
+				continue;
+			}
 
-		if (!(cap = ioaddr[b]))
-			continue;
+			brd->pdev = NULL;
 
-		brd = &mxser_boards[m];
-		retval = mxser_get_ISA_conf(cap, &mxser_boards[m]);
-
-		if (retval != 0)
-			printk(KERN_INFO "Found MOXA %s board (CAP=0x%x)\n",
-				mxser_brdname[brd->board_type - 1], ioaddr[b]);
-
-		if (retval <= 0) {
-			if (retval == MXSER_ERR_IRQ)
-				printk(KERN_ERR "Invalid interrupt number, "
-					"board not configured\n");
-			else if (retval == MXSER_ERR_IRQ_CONFLIT)
-				printk(KERN_ERR "Invalid interrupt number, "
-					"board not configured\n");
-			else if (retval == MXSER_ERR_VECTOR)
-				printk(KERN_ERR "Invalid interrupt vector, "
-					"board not configured\n");
-			else if (retval == MXSER_ERR_IOADDR)
-				printk(KERN_ERR "Invalid I/O address, "
-					"board not configured\n");
+			/* mxser_initbrd will hook ISR. */
+			if (mxser_initbrd(brd) < 0)
+				continue;
 
-			continue;
+			m++;
 		}
 
-		brd->pdev = NULL;
-		/* mxser_initbrd will hook ISR. */
-		if (mxser_initbrd(brd) < 0)
-			continue;
-
-		m++;
-	}
-
 	/* start finding PCI board here */
 	n = ARRAY_SIZE(mxser_pcibrds) - 1;
 	b = 0;
