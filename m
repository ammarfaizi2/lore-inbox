Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWB0VkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWB0VkV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWB0VkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:40:21 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:5253 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751434AbWB0VkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:40:20 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [PNP] 'modalias' sysfs export
Date: Mon, 27 Feb 2006 22:40:19 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: ambx1@neo.rr.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

User space hardware detection need the 'modalias' attributes in the
sysfs tree. This patch adds support to the PNP bus.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/pnp/card.c      |   12 ++++++++++++
 drivers/pnp/interface.c |   12 ++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
index aaa568a..d33a88f 100644
--- a/drivers/pnp/card.c
+++ b/drivers/pnp/card.c
@@ -159,10 +159,22 @@ static ssize_t pnp_show_card_ids(struct 
 
 static DEVICE_ATTR(card_id,S_IRUGO,pnp_show_card_ids,NULL);
 
+static ssize_t pnp_card_modalias_show(struct device *dmdev, struct device_attribute *attr, char *buf)
+{
+	struct pnp_card *card = to_pnp_card(dmdev);
+	struct pnp_id * pos = card->id;
+
+	/* FIXME: modalias can only do one alias */
+	return sprintf(buf, "pnp:c%s\n", pos->id);
+}
+
+static DEVICE_ATTR(modalias,S_IRUGO,pnp_card_modalias_show,NULL);
+
 static int pnp_interface_attach_card(struct pnp_card *card)
 {
 	device_create_file(&card->dev,&dev_attr_name);
 	device_create_file(&card->dev,&dev_attr_card_id);
+	device_create_file(&card->dev,&dev_attr_modalias);
 	return 0;
 }
 
diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index a2d8ce7..67bd17c 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -459,10 +459,22 @@ static ssize_t pnp_show_current_ids(stru
 
 static DEVICE_ATTR(id,S_IRUGO,pnp_show_current_ids,NULL);
 
+static ssize_t pnp_modalias_show(struct device *dmdev, struct device_attribute *attr, char *buf)
+{
+	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	struct pnp_id * pos = dev->id;
+
+	/* FIXME: modalias can only do one alias */
+	return sprintf(buf, "pnp:d%s\n", pos->id);
+}
+
+static DEVICE_ATTR(modalias,S_IRUGO,pnp_modalias_show,NULL);
+
 int pnp_interface_attach_device(struct pnp_dev *dev)
 {
 	device_create_file(&dev->dev,&dev_attr_options);
 	device_create_file(&dev->dev,&dev_attr_resources);
 	device_create_file(&dev->dev,&dev_attr_id);
+	device_create_file(&dev->dev,&dev_attr_modalias);
 	return 0;
 }

