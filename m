Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754874AbWKKVsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874AbWKKVsV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 16:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbWKKVsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 16:48:21 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:2474 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1754874AbWKKVsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 16:48:21 -0500
Message-id: <196416110522272@wsc.cz>
Subject: [PATCH 1/5] Char: istallion, fix enabling
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 11 Nov 2006 22:48:31 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, fix enabling

Enable ISA cards before pci_register_driver and then, enable each PCI card
in probe function.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 2f1c6f8998c724f6b323dfc913a650f26cc02efa
tree b03b4c776ba221373f755c5970a8dd41e8796ce7
parent d58848fe07c13a82e9d429d481f9677857e73019
author Jiri Slaby <jirislaby@gmail.com> Sat, 11 Nov 2006 01:38:17 +0100
committer Jiri Slaby <jirislaby@gmail.com> Sat, 11 Nov 2006 22:23:16 +0100

 drivers/char/istallion.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index 3733a83..e835258 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -3968,6 +3968,10 @@ static int __devinit stli_pciprobe(struc
 	brdp->state |= BST_PROBED;
 	pci_set_drvdata(pdev, brdp);
 
+	EBRDENABLE(brdp);
+	brdp->enable = NULL;
+	brdp->disable = NULL;
+
 	return 0;
 err_null:
 	stli_brds[brdp->brdnr] = NULL;
@@ -4054,13 +4058,6 @@ static int stli_initbrds(void)
 	if (retval > 0)
 		found += retval;
 
-	retval = pci_register_driver(&stli_pcidriver);
-	if (retval && found == 0) {
-		printk(KERN_ERR "Neither isa nor eisa cards found nor pci "
-				"driver can be registered!\n");
-		goto err;
-	}
-
 /*
  *	All found boards are initialized. Now for a little optimization, if
  *	no boards are sharing the "shared memory" regions then we can just
@@ -4099,6 +4096,13 @@ static int stli_initbrds(void)
 		}
 	}
 
+	retval = pci_register_driver(&stli_pcidriver);
+	if (retval && found == 0) {
+		printk(KERN_ERR "Neither isa nor eisa cards found nor pci "
+				"driver can be registered!\n");
+		goto err;
+	}
+
 	return 0;
 err:
 	return retval;
