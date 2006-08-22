Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWHVRjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWHVRjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWHVRjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:39:24 -0400
Received: from accolon.hansenpartnership.com ([64.109.89.108]:61882 "EHLO
	accolon.hansenpartnership.com") by vger.kernel.org with ESMTP
	id S1751415AbWHVRjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:39:23 -0400
Subject: [PATCH 3/2] Add SATA support to libsas STP piece for SATA on SAS
	expanders
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Alexis Bruemmer <alexisb@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <44DBE93F.1040005@us.ibm.com>
References: <44DBE93F.1040005@us.ibm.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 12:39:19 -0500
Message-Id: <1156268359.19615.8.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for SATA over SAS expanders to the previous two
SATA support in libsas patches.

There were a couple of nasty non trivial things to sort out before this
one could be made to work.

Firstly, I'd like to thank Doug Gilbert for diagnosing a problem with
the LSI expanders where the REPORT_SATA_PHY command was returning the
D2H FIS in the wrong order (Although, here, I think I have to blame the
SAS standards which specifies the FIS "shall be returned in little
endian format" and later on "which means resp[24] shall be FIS type"
The latter, of course, implying big endian format).  Just to make sure,
I put a check for the D2H FIS type being in the wrong position and
reverse the FIS data if it is.

The second is a problem outlined in Annex G of the SAS standard (again,
a technical point with D2H FIS ... necessitating a phy reset on certain
conditions).

With the patch, I can now see my SATA-1 disk in a cascaded expander
configuration.

James

---

Index: BUILD-2.6/drivers/scsi/libsas/sas_expander.c
===================================================================
--- BUILD-2.6.orig/drivers/scsi/libsas/sas_expander.c	2006-08-21 21:49:14.000000000 -0500
+++ BUILD-2.6/drivers/scsi/libsas/sas_expander.c	2006-08-22 09:10:40.000000000 -0500
@@ -36,6 +36,8 @@
 static int sas_configure_phy(struct domain_device *dev, int phy_id,
 			     u8 *sas_addr, int include);
 static int sas_disable_routing(struct domain_device *dev,  u8 *sas_addr);
+static int smp_phy_control(struct domain_device *dev, int phy_id,
+			   enum phy_func phy_func);
 
 #if 0
 /* FIXME: smp needs to migrate into the sas class */
@@ -221,6 +223,36 @@
 #define DISCOVER_REQ_SIZE  16
 #define DISCOVER_RESP_SIZE 56
 
+static int sas_ex_phy_discover_helper(struct domain_device *dev, u8 *disc_req,
+				      u8 *disc_resp, int single)
+{
+	int i, res;
+
+	disc_req[9] = single;
+	for (i = 1 ; i < 3; i++) {
+		struct discover_resp *dr;
+
+		res = smp_execute_task(dev, disc_req, DISCOVER_REQ_SIZE,
+				       disc_resp, DISCOVER_RESP_SIZE);
+		if (res)
+			return res;
+		/* This is detecting a failure to transmit inital
+		 * dev to host FIS as described in section G.5 of
+		 * sas-2 r 04b */
+		dr = &((struct smp_resp *)disc_resp)->disc;
+		if (!(dr->attached_dev_type == 0 &&
+		      dr->attached_sata_dev))
+			break;
+		/* In order to generate the dev to host FIS, we
+		 * send a link reset to the expander port */
+		smp_phy_control(dev, single, PHY_FUNC_LINK_RESET);
+		/* Wait for the reset to trigger the negotiation */
+		msleep(500);
+	}
+	sas_set_ex_phy(dev, single, disc_resp);
+	return 0;
+}
+
 static int sas_ex_phy_discover(struct domain_device *dev, int single)
 {
 	struct expander_device *ex = &dev->ex_dev;
@@ -241,23 +273,15 @@
 	disc_req[1] = SMP_DISCOVER;
 
 	if (0 <= single && single < ex->num_phys) {
-		disc_req[9] = single;
-		res = smp_execute_task(dev, disc_req, DISCOVER_REQ_SIZE,
-				       disc_resp, DISCOVER_RESP_SIZE);
-		if (res)
-			goto out_err;
-		sas_set_ex_phy(dev, single, disc_resp);
+		res = sas_ex_phy_discover_helper(dev, disc_req, disc_resp, single);
 	} else {
 		int i;
 
 		for (i = 0; i < ex->num_phys; i++) {
-			disc_req[9] = i;
-			res = smp_execute_task(dev, disc_req,
-					       DISCOVER_REQ_SIZE, disc_resp,
-					       DISCOVER_RESP_SIZE);
+			res = sas_ex_phy_discover_helper(dev, disc_req,
+							 disc_resp, i);
 			if (res)
 				goto out_err;
-			sas_set_ex_phy(dev, i, disc_resp);
 		}
 	}
 out_err:
@@ -492,6 +516,7 @@
 {
 	int res;
 	u8 *rps_req = alloc_smp_req(RPS_REQ_SIZE);
+	u8 *resp = (u8 *)rps_resp;
 
 	if (!rps_req)
 		return -ENOMEM;
@@ -502,8 +527,28 @@
 	res = smp_execute_task(dev, rps_req, RPS_REQ_SIZE,
 			            rps_resp, RPS_RESP_SIZE);
 
+	/* 0x34 is the FIS type for the D2H fis.  There's a potential
+	 * standards cockup here.  sas-2 explicitly specifies the FIS
+	 * should be encoded so that FIS type is in resp[24].
+	 * However, some expanders endian reverse this.  Undo the
+	 * reversal here */
+	if (!res && resp[27] == 0x34 && resp[24] != 0x34) {
+		int i;
+
+		for (i = 0; i < 5; i++) {
+			int j = 24 + (i*4);
+			u8 a, b;
+			a = resp[j + 0];
+			b = resp[j + 1];
+			resp[j + 0] = resp[j + 3];
+			resp[j + 1] = resp[j + 2];
+			resp[j + 2] = b;
+			resp[j + 3] = a;
+		}
+	}
+
 	kfree(rps_req);
-	return 0;
+	return res;
 }
 
 static void sas_ex_get_linkrate(struct domain_device *parent,
@@ -584,7 +629,19 @@
 		}
 		memcpy(child->frame_rcvd, &child->sata_dev.rps_resp.rps.fis,
 		       sizeof(struct dev_to_host_fis));
+
+		rphy = sas_end_device_alloc(phy->port);
+		/* FIXME: error handling */
+		BUG_ON(!rphy);
+
 		sas_init_dev(child);
+
+		child->rphy = rphy;
+
+		spin_lock(&parent->port->dev_list_lock);
+		list_add_tail(&child->dev_list_node, &parent->port->dev_list);
+		spin_unlock(&parent->port->dev_list_lock);
+
 		res = sas_discover_sata(child);
 		if (res) {
 			SAS_DPRINTK("sas_discover_sata() for device %16llx at "


