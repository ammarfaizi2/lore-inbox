Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755910AbWKQVBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbWKQVBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905AbWKQVBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:01:18 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:45728 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755906AbWKQVBP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:15 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 02/15] libsas: Clean up rphys/port dev list after a discovery error.
Date: Fri, 17 Nov 2006 13:07:43 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210743.17052.97393.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sas_get_port_device assigns a rphy to a domain device in anticipation
of finding a disk.  When a discovery error occurs in
sas_discover_{sata,sas,expander}*, however, we need to clean up that
rphy and the port device list so that we don't GPF.  In addition, we
need to check the result of the second sas_notify_lldd_dev_found.
This patch seems ok on a x260, x366 and x206m.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/libsas/sas_discover.c |   40 ++++++++++++++++++++++++++++++------
 drivers/scsi/libsas/sas_expander.c |   20 ++++++++++++++----
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index 9e4fd2a..758b153 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -552,7 +552,7 @@ int sas_discover_sata(struct domain_devi
 
 	res = sas_notify_lldd_dev_found(dev);
 	if (res)
-		return res;
+		goto out_err2;
 
 	switch (dev->dev_type) {
 	case SATA_DEV:
@@ -564,12 +564,25 @@ int sas_discover_sata(struct domain_devi
 	default:
 		break;
 	}
+	if (res)
+		goto out_err;
 
 	sas_notify_lldd_dev_gone(dev);
-	if (!res) {
-		sas_notify_lldd_dev_found(dev);
-		res = sas_rphy_add(dev->rphy);
-	}
+	res = sas_notify_lldd_dev_found(dev);
+	if (res)
+		goto out_err2;
+
+	res = sas_rphy_add(dev->rphy);
+	if (res)
+		goto out_err;
+
+	return res;
+
+out_err:
+	sas_notify_lldd_dev_gone(dev);
+out_err2:
+	sas_rphy_free(dev->rphy);
+	dev->rphy = NULL;
 	return res;
 }
 
@@ -585,7 +598,7 @@ int sas_discover_end_dev(struct domain_d
 
 	res = sas_notify_lldd_dev_found(dev);
 	if (res)
-		return res;
+		goto out_err2;
 
 	res = sas_rphy_add(dev->rphy);
 	if (res)
@@ -594,12 +607,21 @@ int sas_discover_end_dev(struct domain_d
 	/* do this to get the end device port attributes which will have
 	 * been scanned in sas_rphy_add */
 	sas_notify_lldd_dev_gone(dev);
-	sas_notify_lldd_dev_found(dev);
+	res = sas_notify_lldd_dev_found(dev);
+	if (res)
+		goto out_err3;
 
 	return 0;
 
 out_err:
 	sas_notify_lldd_dev_gone(dev);
+out_err2:
+	sas_rphy_free(dev->rphy);
+	dev->rphy = NULL;
+	return res;
+out_err3:
+	sas_rphy_delete(dev->rphy);
+	dev->rphy = NULL;
 	return res;
 }
 
@@ -689,6 +711,10 @@ static void sas_discover_domain(void *da
 	}
 
 	if (error) {
+		spin_lock(&port->dev_list_lock);
+		list_del_init(&port->port_dev->dev_list_node);
+		spin_unlock(&port->dev_list_lock);
+
 		kfree(port->port_dev); /* not kobject_register-ed yet */
 		port->port_dev = NULL;
 	}
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 4cc7457..a38d05b 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -711,7 +711,6 @@ static struct domain_device *sas_ex_disc
 
  out_list_del:
 	list_del(&child->dev_list_node);
-	sas_rphy_free(rphy);
  out_free:
 	sas_port_delete(phy->port);
  out_err:
@@ -1474,14 +1473,27 @@ int sas_discover_root_expander(struct do
 	int res;
 	struct sas_expander_device *ex = rphy_to_expander_device(dev->rphy);
 
-	sas_rphy_add(dev->rphy);
+	res = sas_rphy_add(dev->rphy);
+	if (res)
+		goto out_err;
 
 	ex->level = dev->port->disc.max_level; /* 0 */
 	res = sas_discover_expander(dev);
-	if (!res)
-		sas_ex_bfs_disc(dev->port);
+	if (res)
+		goto out_err2;
+
+	sas_ex_bfs_disc(dev->port);
 
 	return res;
+
+out_err2:
+	sas_rphy_delete(dev->rphy);
+	dev->rphy = NULL;
+	return res;
+out_err:
+	sas_rphy_free(dev->rphy);
+	dev->rphy = NULL;
+	return res;
 }
 
 /* ---------- Domain revalidation ---------- */
