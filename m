Return-Path: <linux-kernel-owner+w=401wt.eu-S1030524AbWLPBd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbWLPBd1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 20:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbWLPBc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 20:32:57 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:38868 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030536AbWLPBcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 20:32:54 -0500
Message-id: <175641799062336386@wsc.cz>
In-reply-to: <2880031291415520798@wsc.cz>
Subject: [PATCH 3/5] Char: isicom, augment card_reset
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 16 Dec 2006 02:09:48 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, augment card_reset

- add 0xee to signatures
- change long delays to sleeps
- make one sleep shorter not to wait 3s
- portcount == 16 is also correct

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 405c17b09b010b41f6ec2388a11777e4048c7976
tree 4954b33027ee87193bfe91109d6fbc8b12c4e71a
parent e7087b32ad4b5ee1240fa7f9ba46a9b4566fe424
author Jiri Slaby <jirislaby@gmail.com> Fri, 15 Dec 2006 22:20:14 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 15 Dec 2006 22:20:14 +0059

 drivers/char/isicom.c |   39 ++++++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 5d2c345..7968160 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1501,7 +1501,7 @@ static int __devinit reset_card(struct pci_dev *pdev,
 {
 	struct isi_board *board = pci_get_drvdata(pdev);
 	unsigned long base = board->base;
-	unsigned int portcount = 0;
+	unsigned int sig, portcount = 0;
 	int retval = 0;
 
 	dev_dbg(&pdev->dev, "ISILoad:Resetting Card%d at 0x%lx\n", card + 1,
@@ -1509,27 +1509,35 @@ static int __devinit reset_card(struct pci_dev *pdev,
 
 	inw(base + 0x8);
 
-	mdelay(10);
+	msleep(10);
 
 	outw(0, base + 0x8); /* Reset */
 
-	msleep(3000);
+	msleep(1000);
 
-	*signature = inw(base + 0x4) & 0xff;
+	sig = inw(base + 0x4) & 0xff;
+
+	if (sig != 0xa5 && sig != 0xbb && sig != 0xcc && sig != 0xdd &&
+			sig != 0xee) {
+		dev_warn(&pdev->dev, "ISILoad:Card%u reset failure (Possible "
+			"bad I/O Port Address 0x%lx).\n", card + 1, base);
+		dev_dbg(&pdev->dev, "Sig=0x%x\n", sig);
+		retval = -EIO;
+		goto end;
+	}
+
+	msleep(10);
 
 	portcount = inw(base + 0x2);
-	if (!(inw(base + 0xe) & 0x1) || ((portcount != 0) &&
-			(portcount != 4) && (portcount != 8))) {
-		dev_dbg(&pdev->dev, "base+0x2=0x%lx, base+0xe=0x%lx\n",
-			inw(base + 0x2), inw(base + 0xe));
-		dev_err(&pdev->dev, "ISILoad:PCI Card%d reset failure "
-			"(Possible bad I/O Port Address 0x%lx).\n",
-			card + 1, base);
+	if (!inw(base + 0xe) & 0x1 || (portcount != 0 && portcount != 4 &&
+				portcount != 8 && portcount != 16)) {
+		dev_err(&pdev->dev, "ISILoad:PCI Card%d reset failure.",
+			card + 1);
 		retval = -EIO;
 		goto end;
 	}
 
-	switch (*signature) {
+	switch (sig) {
 	case 0xa5:
 	case 0xbb:
 	case 0xdd:
@@ -1537,16 +1545,13 @@ static int __devinit reset_card(struct pci_dev *pdev,
 		board->shift_count = 12;
 		break;
 	case 0xcc:
+	case 0xee:
 		board->port_count = 16;
 		board->shift_count = 11;
 		break;
-	default:
-		dev_warn(&pdev->dev, "ISILoad:Card%d reset failure (Possible "
-			"bad I/O Port Address 0x%lx).\n", card + 1, base);
-		dev_dbg(&pdev->dev, "Sig=0x%lx\n", signature);
-		retval = -EIO;
 	}
 	dev_info(&pdev->dev, "-Done\n");
+	*signature = sig;
 
 end:
 	return retval;
