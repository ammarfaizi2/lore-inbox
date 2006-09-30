Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWI3Wen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWI3Wen (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWI3Wen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:34:43 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:64641 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751579AbWI3Wek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:34:40 -0400
Message-id: <84721356982173@wsc.cz>
Subject: [PATCH 4/4] Char: mxser_new, check request_region retvals
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Date: Sun,  1 Oct 2006 00:34:39 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, check request_region retvals

Return values of (pci_)request_region should be checked and error should be
returned if something is in bad state.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 4942c46b234b3aefcfae4ceb59e54af7b537895d
tree 50f2c7a81bed712b9663e595cb25a070e862a640
parent 1a717bdb06cef859dfbd426f46ea24a9c740e5c5
author Jiri Slaby <jirislaby@gmail.com> Sat, 30 Sep 2006 01:24:31 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 30 Sep 2006 01:24:31 +0200

 drivers/char/mxser_new.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index c566cd0..4e881ac 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -622,19 +622,24 @@ static int __init mxser_get_PCI_conf(int
 {
 	unsigned int i, j;
 	unsigned long ioaddress;
+	int retval;
 
 	/* io address */
 	brd->board_type = board_type;
 	brd->nports = mxser_numports[board_type - 1];
 	ioaddress = pci_resource_start(pdev, 2);
-	pci_request_region(pdev, 2, "mxser(IO)");
+	retval = pci_request_region(pdev, 2, "mxser(IO)");
+	if (retval)
+		goto err;
 
 	for (i = 0; i < brd->nports; i++)
 		brd->ports[i].ioaddr = ioaddress + 8 * i;
 
 	/* vector */
 	ioaddress = pci_resource_start(pdev, 3);
-	pci_request_region(pdev, 3, "mxser(vector)");
+	retval = pci_request_region(pdev, 3, "mxser(vector)");
+	if (retval)
+		goto err_relio;
 	brd->vector = ioaddress;
 
 	/* irq */
@@ -674,6 +679,10 @@ static int __init mxser_get_PCI_conf(int
 		brd->ports[i].baud_base = 921600;
 	}
 	return 0;
+err_relio:
+	pci_release_region(pdev, 2);
+err:
+	return retval;
 }
 
 static int __init mxser_init(void)
@@ -3002,8 +3011,12 @@ static int __init mxser_get_ISA_conf(int
 		brd->nports = 8;
 	else
 		brd->nports = 4;
-	request_region(brd->ports[0].ioaddr, 8 * brd->nports, "mxser(IO)");
-	request_region(brd->vector, 1, "mxser(vector)");
+	if (!request_region(brd->ports[0].ioaddr, 8 * brd->nports, "mxser(IO)"))
+		return MXSER_ERR_IOADDR;
+	if (!request_region(brd->vector, 1, "mxser(vector)")) {
+		release_region(brd->ports[0].ioaddr, 8 * brd->nports);
+		return MXSER_ERR_VECTOR;
+	}
 	return brd->nports;
 }
 
