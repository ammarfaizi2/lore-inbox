Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWJLX1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWJLX1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 19:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWJLX1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 19:27:44 -0400
Received: from twin.jikos.cz ([213.151.79.26]:16088 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751294AbWJLX1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 19:27:43 -0400
Date: Fri, 13 Oct 2006 01:27:35 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: [PATCH] fix fm801_gp_probe() ignoring return value from pci_enable_device()
Message-ID: <Pine.LNX.4.64.0610130123270.29022@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] fix fm801_gp_probe() ignoring return value from pci_enable_device()

Fix fm801_gp_probe() not handling pci_enable_device() return value 
correctly.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

--- 

 drivers/input/gameport/fm801-gp.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
index 90de5af..5ac9e15 100644
--- a/drivers/input/gameport/fm801-gp.c
+++ b/drivers/input/gameport/fm801-gp.c
@@ -82,17 +82,22 @@ static int __devinit fm801_gp_probe(stru
 {
 	struct fm801_gp *gp;
 	struct gameport *port;
+	int err;
 
 	gp = kzalloc(sizeof(struct fm801_gp), GFP_KERNEL);
 	port = gameport_allocate_port();
 	if (!gp || !port) {
 		printk(KERN_ERR "fm801-gp: Memory allocation failed\n");
-		kfree(gp);
-		gameport_free_port(port);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out_err;
 	}
 
-	pci_enable_device(pci);
+	err = pci_enable_device(pci);
+	if (err) {
+		printk(KERN_ERR "fm801: Cannot enable PCI device\n");
+		goto out_err;
+		
+	}
 
 	port->open = fm801_gp_open;
 #ifdef HAVE_COOKED
@@ -108,9 +113,8 @@ #endif
 	if (!gp->res_port) {
 		printk(KERN_DEBUG "fm801-gp: unable to grab region 0x%x-0x%x\n",
 			port->io, port->io + 0x0f);
-		gameport_free_port(port);
-		kfree(gp);
-		return -EBUSY;
+		err = -EBUSY;
+		goto out_err;
 	}
 
 	pci_set_drvdata(pci, gp);
@@ -119,6 +123,11 @@ #endif
 	gameport_register_port(port);
 
 	return 0;
+out_err:
+	gameport_free_port(port);
+	kfree(gp);
+
+	return err;
 }
 
 static void __devexit fm801_gp_remove(struct pci_dev *pci)

-- 
Jiri Kosina
