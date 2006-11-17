Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755906AbWKQVGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906AbWKQVGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424847AbWKQVGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:06:11 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:25516 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755911AbWKQVBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:36 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 05/15] libsas: Add a sysfs knob to enable/disable a phy
Date: Fri, 17 Nov 2006 13:07:52 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210752.17052.38827.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch lets a user arbitrarily enable or disable a phy via sysfs.
Potential applications include shutting down a phy to replace one
lane of wide port, and (more importantly) providing a method for the
libata SATL to control the phy.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/libsas/sas_init.c      |   35 ++++++++++++++++++++++++++++++++--
 drivers/scsi/libsas/sas_scsi_host.c |    1 +
 drivers/scsi/scsi_transport_sas.c   |   36 +++++++++++++++++++++++++++++++++++
 include/scsi/libsas.h               |    3 +++
 include/scsi/scsi_transport_sas.h   |    1 +
 5 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index 0fb347b..89814f9 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -144,6 +144,36 @@ static int sas_get_linkerrors(struct sas
 	return sas_smp_get_phy_events(phy);
 }
 
+int sas_phy_enable(struct sas_phy *phy, int enable)
+{
+	int ret;
+	enum phy_func command;
+
+	if (enable)
+		command = PHY_FUNC_LINK_RESET;
+	else
+		command = PHY_FUNC_DISABLE;
+
+	if (scsi_is_sas_phy_local(phy)) {
+		struct Scsi_Host *shost = dev_to_shost(phy->dev.parent);
+		struct sas_ha_struct *sas_ha = SHOST_TO_SAS_HA(shost);
+		struct asd_sas_phy *asd_phy = sas_ha->sas_phy[phy->number];
+		struct sas_internal *i =
+			to_sas_internal(sas_ha->core.shost->transportt);
+
+		if (!enable) {
+			sas_phy_disconnected(asd_phy);
+			sas_ha->notify_phy_event(asd_phy, PHYE_LOSS_OF_SIGNAL);
+		}
+		ret = i->dft->lldd_control_phy(asd_phy, command, NULL);
+	} else {
+		struct sas_rphy *rphy = dev_to_rphy(phy->dev.parent);
+		struct domain_device *ddev = sas_find_dev_by_rphy(rphy);
+		ret = sas_smp_phy_control(ddev, phy->number, command, NULL);
+	}
+	return ret;
+}
+
 int sas_phy_reset(struct sas_phy *phy, int hard_reset)
 {
 	int ret;
@@ -170,8 +200,8 @@ int sas_phy_reset(struct sas_phy *phy, i
 	return ret;
 }
 
-static int sas_set_phy_speed(struct sas_phy *phy,
-			     struct sas_phy_linkrates *rates)
+int sas_set_phy_speed(struct sas_phy *phy,
+		      struct sas_phy_linkrates *rates)
 {
 	int ret;
 
@@ -210,6 +240,7 @@ static int sas_set_phy_speed(struct sas_
 }
 
 static struct sas_function_template sft = {
+	.phy_enable = sas_phy_enable,
 	.phy_reset = sas_phy_reset,
 	.set_phy_speed = sas_set_phy_speed,
 	.get_linkerrors = sas_get_linkerrors,
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 7cc7a1e..a88d3a4 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -933,3 +933,4 @@ EXPORT_SYMBOL_GPL(sas_target_destroy);
 EXPORT_SYMBOL_GPL(sas_ioctl);
 EXPORT_SYMBOL_GPL(sas_task_abort);
 EXPORT_SYMBOL_GPL(sas_phy_reset);
+EXPORT_SYMBOL_GPL(sas_phy_enable);
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index b5b0c2c..04df212 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -335,6 +335,41 @@ show_sas_device_type(struct class_device
 }
 static CLASS_DEVICE_ATTR(device_type, S_IRUGO, show_sas_device_type, NULL);
 
+static ssize_t do_sas_phy_enable(struct class_device *cdev,
+		size_t count, int enable)
+{
+	struct sas_phy *phy = transport_class_to_phy(cdev);
+	struct Scsi_Host *shost = dev_to_shost(phy->dev.parent);
+	struct sas_internal *i = to_sas_internal(shost->transportt);
+	int error;
+
+	error = i->f->phy_enable(phy, enable);
+	if (error)
+		return error;
+	return count;
+};
+
+static ssize_t store_sas_phy_enable(struct class_device *cdev,
+		const char *buf, size_t count)
+{
+	if (count < 1)
+		return -EINVAL;
+
+	switch (buf[0]) {
+	case '0':
+		do_sas_phy_enable(cdev, count, 0);
+		break;
+	case '1':
+		do_sas_phy_enable(cdev, count, 1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+static CLASS_DEVICE_ATTR(enable, S_IWUSR, NULL, store_sas_phy_enable);
+
 static ssize_t do_sas_phy_reset(struct class_device *cdev,
 		size_t count, int hard_reset)
 {
@@ -1478,6 +1513,7 @@ sas_attach_transport(struct sas_function
 	SETUP_PHY_ATTRIBUTE(phy_reset_problem_count);
 	SETUP_OPTIONAL_PHY_ATTRIBUTE_WRONLY(link_reset, phy_reset);
 	SETUP_OPTIONAL_PHY_ATTRIBUTE_WRONLY(hard_reset, phy_reset);
+	SETUP_PHY_ATTRIBUTE_WRONLY(enable);
 	i->phy_attrs[count] = NULL;
 
 	count = 0;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index d2ec1be..a06cbde 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -606,6 +606,9 @@ struct sas_domain_function_template {
 extern int sas_register_ha(struct sas_ha_struct *);
 extern int sas_unregister_ha(struct sas_ha_struct *);
 
+int sas_set_phy_speed(struct sas_phy *phy,
+		      struct sas_phy_linkrates *rates);
+int sas_phy_enable(struct sas_phy *phy, int enabled);
 int sas_phy_reset(struct sas_phy *phy, int hard_reset);
 int sas_queue_up(struct sas_task *task);
 extern int sas_queuecommand(struct scsi_cmnd *,
diff --git a/include/scsi/scsi_transport_sas.h b/include/scsi/scsi_transport_sas.h
index 59633a8..dea9127 100644
--- a/include/scsi/scsi_transport_sas.h
+++ b/include/scsi/scsi_transport_sas.h
@@ -163,6 +163,7 @@ struct sas_function_template {
 	int (*get_enclosure_identifier)(struct sas_rphy *, u64 *);
 	int (*get_bay_identifier)(struct sas_rphy *);
 	int (*phy_reset)(struct sas_phy *, int);
+	int (*phy_enable)(struct sas_phy *, int);
 	int (*set_phy_speed)(struct sas_phy *, struct sas_phy_linkrates *);
 };
 
