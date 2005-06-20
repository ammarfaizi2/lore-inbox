Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVFUCfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVFUCfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVFUCel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:34:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:27364 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261693AbVFTW7p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:45 -0400
Cc: gregkh@suse.de
Subject: [PATCH] use device_for_each_child() to properly access child devices.
In-Reply-To: <11193083663269@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:26 -0700
Message-Id: <11193083662460@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] use device_for_each_child() to properly access child devices.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9a881f166f473373589ce6f3fdc47b44a1450e2d
tree 7f845c4f30aec7df6052a4503d3a76bf2a4362c0
parent 20b1e674230b642be662c5975923a0160ab9cbdc
author gregkh@suse.de <gregkh@suse.de> Fri, 25 Mar 2005 15:52:00 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:22 -0700

 drivers/scsi/scsi_transport_spi.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -348,17 +348,21 @@ spi_transport_rd_attr(rd_strm, "%d\n");
 spi_transport_rd_attr(rti, "%d\n");
 spi_transport_rd_attr(pcomp_en, "%d\n");
 
+/* we only care about the first child device so we return 1 */
+static int child_iter(struct device *dev, void *data)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+
+	spi_dv_device(sdev);
+	return 1;
+}
+
 static ssize_t
 store_spi_revalidate(struct class_device *cdev, const char *buf, size_t count)
 {
 	struct scsi_target *starget = transport_class_to_starget(cdev);
 
-	/* FIXME: we're relying on an awful lot of device internals
-	 * here.  We really need a function to get the first available
-	 * child */
-	struct device *dev = container_of(starget->dev.children.next, struct device, node);
-	struct scsi_device *sdev = to_scsi_device(dev);
-	spi_dv_device(sdev);
+	device_for_each_child(&starget->dev, NULL, child_iter);
 	return count;
 }
 static CLASS_DEVICE_ATTR(revalidate, S_IWUSR, NULL, store_spi_revalidate);

