Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVAXGWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVAXGWy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVAXGVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:21:51 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261454AbVAXGO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:28 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][8/12] InfiniBand/mthca: test IRQ routing during initialization
In-Reply-To: <20051232214.JlqWjfrLoi3PpTCk@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:24 -0800
Message-Id: <20051232214.WfzWlq9JcWt0oefR@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:25.0372 (UTC) FILETIME=[F40A79C0:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we switch to interrupt-driven command mode, test interrupt
generation with a NOP firmware command.  Broken MSI/MSI-X and
interrupt line routing problems seem to be very common, and this makes
the error message much clearer -- before this change we would
mysteriously fail when initializing the QP table.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-01-23 20:49:34.829362648 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-01-23 20:52:01.964994632 -0800
@@ -289,6 +289,7 @@
 		    u8 *status);
 int mthca_MGID_HASH(struct mthca_dev *dev, void *gid, u16 *hash,
 		    u8 *status);
+int mthca_NOP(struct mthca_dev *dev, u8 *status);
 
 #define MAILBOX_ALIGN(x) ((void *) ALIGN((unsigned long) (x), MTHCA_CMD_MAILBOX_ALIGN))
 
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-01-23 20:38:50.947247608 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_main.c	2005-01-23 20:52:01.962994936 -0800
@@ -570,6 +570,7 @@
 static int __devinit mthca_setup_hca(struct mthca_dev *dev)
 {
 	int err;
+	u8 status;
 
 	MTHCA_INIT_DOORBELL_LOCK(&dev->doorbell_lock);
 
@@ -615,6 +616,18 @@
 		goto err_eq_table_free;
 	}
 
+	err = mthca_NOP(dev, &status);
+	if (err || status) {
+		mthca_err(dev, "NOP command failed to generate interrupt, aborting.\n");
+		if (dev->mthca_flags & (MTHCA_FLAG_MSI | MTHCA_FLAG_MSI_X))
+			mthca_err(dev, "Try again with MSI/MSI-X disabled.\n");
+		else
+			mthca_err(dev, "BIOS or ACPI interrupt routing problem?\n");
+
+		goto err_cmd_poll;
+	} else
+		mthca_dbg(dev, "NOP command IRQ test passed\n");
+
 	err = mthca_init_cq_table(dev);
 	if (err) {
 		mthca_err(dev, "Failed to initialize "
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-01-23 20:49:34.828362800 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-01-23 20:52:01.963994784 -0800
@@ -1757,3 +1757,8 @@
 	pci_unmap_single(dev->pdev, indma, 16, PCI_DMA_TODEVICE);
 	return err;
 }
+
+int mthca_NOP(struct mthca_dev *dev, u8 *status)
+{
+	return mthca_cmd(dev, 0, 0x1f, 0, CMD_NOP, msecs_to_jiffies(100), status);
+}

