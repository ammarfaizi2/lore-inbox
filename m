Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422870AbWI3Adw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422870AbWI3Adw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422869AbWI3Adw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:33:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:28849 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1161012AbWI3Adv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:33:51 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,238,1157353200"; 
   d="scan'208"; a="138469510:sNHT23675309"
Date: Fri, 29 Sep 2006 17:33:08 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       rdunlap@xenotime.net
Subject: Re: [patch 2/2] libata: _SDD support
Message-Id: <20060929173308.c9b2d29e.kristen.c.accardi@intel.com>
In-Reply-To: <20060929021353.GB22082@srcf.ucam.org>
References: <20060928182211.076258000@localhost.localdomain>
	<20060928112912.d2ae0d8f.kristen.c.accardi@intel.com>
	<20060929021353.GB22082@srcf.ucam.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 03:13:53 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> This may be paranoia, but:
> 
> If I'm reading the code right (I may well not be), you seem to be 
> evaulating _GTF before _SDD. The spec (9.9.1.1) claims that _SDD should 
> be evaulated before _GTF - we had a couple of bug reports against an 
> earlier version of the patch that may have been due to that, but I never 
> had a chance to chase them down properly.
> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org

You are right, that was happening.  this patch fixes the issue:

Subject: libata: change order of sdd/gtf execution

Make the sdd call come before gtf.  _SDD is used to provide
input to the _GTF file, so it should be executed first.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/ata/libata-core.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- 2.6-mm.orig/drivers/ata/libata-core.c
+++ 2.6-mm/drivers/ata/libata-core.c
@@ -1404,6 +1404,16 @@ int ata_dev_configure(struct ata_device 
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n",
 			       __FUNCTION__, ap->id, dev->devno);
 
+	/* set _SDD */
+	rc = ata_acpi_push_id(ap, dev->devno);
+	if (rc) {
+		ata_dev_printk(dev, KERN_WARNING, "failed to set _SDD(%d)\n",
+			rc);
+	}
+
+	/* retrieve and execute the ATA task file of _GTF */
+	ata_acpi_exec_tfs(ap);
+
 	/* print device capabilities */
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG,
@@ -1556,14 +1566,6 @@ int ata_dev_configure(struct ata_device 
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(ap, dev);
 
-	/* set _SDD */
-	rc = ata_acpi_push_id(ap, dev->devno);
-	if (rc) {
-		ata_dev_printk(dev, KERN_WARNING, "failed to set _SDD(%d)\n",
-			rc);
-		goto err_out_nosup;
-	}
-
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: EXIT, drv_stat = 0x%x\n",
 			__FUNCTION__, ata_chk_status(ap));
@@ -1609,9 +1611,6 @@ int ata_bus_probe(struct ata_port *ap)
 	/* reset and determine device classes */
 	ap->ops->phy_reset(ap);
 
-	/* retrieve and execute the ATA task file of _GTF */
-	ata_acpi_exec_tfs(ap);
-
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		dev = &ap->device[i];
 
