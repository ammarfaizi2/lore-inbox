Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbTECS7Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 14:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263382AbTECS7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 14:59:25 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:37892 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263381AbTECS7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 14:59:18 -0400
Subject: [RFC] support for sysfs string based properties for SCSI (1/3)
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       Mike Anderson <andmike@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-Kzt6hz80jBNnN16K3x6c"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 03 May 2003 14:11:36 -0500
Message-Id: <1051989099.2036.7.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Kzt6hz80jBNnN16K3x6c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


This first patch is of general interest (the other two are going to the
SCSI list only).

The problem this seeks to solve is that we have a bunch of properties in
SCSI that we'd like to expose through the sysfs interface.  The
mid-layer can get their values, but setting them requires co-operation
from the host drivers, thus we'd like to expose a show/store interface
to all the SCSI drivers.

The current one call back per sysfs file is a bit unwieldy for
encapsulating in an interface like this.  what this patch does is to
allow a fallback show/store method of the bus type (if the device type
doesn't exist).  However, the bus_type show/store passes in the
attribute so a comparison may be done against the name of the attribute.

For details of how all this gets used, see the following SCSI patches.

James


--=-Kzt6hz80jBNnN16K3x6c
Content-Disposition: inline; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D drivers/scsi/NCR_D700.c 1.8 vs edited =3D=3D=3D=3D=3D
--- 1.8/drivers/scsi/NCR_D700.c	Sun Apr 27 05:31:39 2003
+++ edited/drivers/scsi/NCR_D700.c	Thu May  1 11:11:48 2003
@@ -169,16 +169,18 @@
 	struct Scsi_Host	*hosts[2];
 };
=20
-static int NCR_D700_probe_one(struct NCR_D700_private *p, int chan,
+static int=20
+NCR_D700_probe_one(struct NCR_D700_private *p, int siop,
 		int irq, int slot, u32 region, int differential)
 {
 	struct NCR_700_Host_Parameters *hostdata;
 	struct Scsi_Host *host;
+	int ret;
=20
 	hostdata =3D kmalloc(sizeof(*hostdata), GFP_KERNEL);
 	if (!hostdata) {
-		printk(KERN_ERR "NCR D700: Failed to allocate host data "
-				"for channel %d, detatching\n", chan);
+		printk(KERN_ERR "NCR D700: SIOP%d: Failed to allocate host"
+		       "data, detatching\n", siop);
 		return -ENOMEM;
 	}
 	memset(hostdata, 0, sizeof(*hostdata));
@@ -186,41 +188,49 @@
 	if (!request_region(region, 64, "NCR_D700")) {
 		printk(KERN_ERR "NCR D700: Failed to reserve IO region 0x%x\n",
 				region);
-		kfree(hostdata);
-		return -ENODEV;
+		ret =3D -ENODEV;
+		goto region_failed;
 	}
 	=09
 	/* Fill in the three required pieces of hostdata */
 	hostdata->base =3D region;
-	hostdata->differential =3D (((1<<chan) & differential) !=3D 0);
+	hostdata->differential =3D (((1<<siop) & differential) !=3D 0);
 	hostdata->clock =3D NCR_D700_CLOCK_MHZ;
=20
-	/* and register the chip */
+	/* and register the siop */
 	host =3D NCR_700_detect(&NCR_D700_driver_template, hostdata);
 	if (!host) {
-		kfree(hostdata);
-		release_region(host->base, 64);
-		return -ENOMEM;
+		ret =3D -ENOMEM;
+		goto detect_failed;
 	}
=20
 	host->irq =3D irq;
 	/* FIXME: Read this from SUS */
-	host->this_id =3D id_array[slot * 2 + chan];
+	host->this_id =3D id_array[slot * 2 + siop];
 	printk(KERN_NOTICE "NCR D700: SIOP%d, SCSI id is %d\n",
-			chan, host->this_id);
+			siop, host->this_id);
 	if (request_irq(irq, NCR_700_intr, SA_SHIRQ, "NCR_D700", host)) {
-		printk(KERN_ERR "NCR D700, channel %d: irq problem, "
-				"detatching\n", chan);
-		scsi_unregister(host);
-		NCR_700_release(host);
-		return -ENODEV;
+		printk(KERN_ERR "NCR D700: SIOP%d: irq problem, "
+				"detatching\n", siop);
+		ret =3D -ENODEV;
+		goto irq_failed;
 	}
=20
-	scsi_add_host(host, NULL);
+	scsi_add_host(host, p->dev);
=20
-	p->hosts[chan] =3D host;
+	p->hosts[siop] =3D host;
 	hostdata->dev =3D p->dev;
 	return 0;
+
+ irq_failed:
+	scsi_unregister(host);
+	NCR_700_release(host);
+ detect_failed:
+	release_region(host->base, 64);
+ region_failed:
+	kfree(hostdata);
+
+	return ret;
 }
=20
 /* Detect a D700 card.  Note, because of the setup --- the chips are
@@ -305,8 +315,15 @@
=20
 	/* plumb in both 700 chips */
 	for (i =3D 0; i < 2; i++) {
-		found |=3D NCR_D700_probe_one(p, i, irq, slot,
-				offset_addr | (0x80 * i), differential);
+		int err;
+
+		if ((err =3D NCR_D700_probe_one(p, i, irq, slot,
+					      offset_addr + (0x80 * i),
+					      differential)) !=3D 0)
+			printk("D700: SIOP%d: probe failed, error =3D %d\n",
+			       i, err);
+		else
+			found++;
 	}
=20
 	if (!found) {

--=-Kzt6hz80jBNnN16K3x6c--

