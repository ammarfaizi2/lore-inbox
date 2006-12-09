Return-Path: <linux-kernel-owner+w=401wt.eu-S935644AbWLIIM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935644AbWLIIM0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 03:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935686AbWLIIM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 03:12:26 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:54781 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935644AbWLIIMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 03:12:25 -0500
Subject: Re: [PATCH] PCI legacy resource fix
From: Ben Collins <ben.collins@ubuntu.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061209024627.6bb11a58@localhost.localdomain>
References: <20061206134143.GA6772@linux-mips.org>
	 <1165625178.7443.334.camel@gullible>
	 <20061209012552.GA15216@linux-mips.org>
	 <1165630410.7443.346.camel@gullible>
	 <20061209024627.6bb11a58@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Dec 2006 03:12:11 -0500
Message-Id: <1165651931.7443.377.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-09 at 02:46 +0000, Alan wrote:
> > Checking the patch, my problem is that the old way, all BAR's were being
> > set at start = end = flags = 0. The patch makes it set all the BAR's to
> 
> Yes the old quirk used to blank the resources as the values on the chip
> are undefined and random. This gives you corrupt resource trees and needs
> hacks in the drivers as well
> 
> > the normal values. This is what it looks like in lspci, pre this patch:
> > 
> >         Region 0: I/O ports at <unassigned>
> >         Region 1: I/O ports at <unassigned>
> >         Region 2: I/O ports at <unassigned>
> >         Region 3: I/O ports at <unassigned>
> 
> Then your device is in legacy mode, or was disabled
>  
> > So my device is not running in compatibility mode, and should not have
> 
> The paste you have their shows that it almost certainly is in legacy mode.
> 
> > the BAR's set, as Alan's patch does.
> 
> Dump the class code and other bits during boot check how your device is
> seen (native v legacy/compatibility) and whether the fixup logic
> triggers. It should only trigger for legacy devices.

You're right, I was reading this backwards.

Thing is, if I disable the quirk, ata_piix works correctly.

So I think maybe the problem is the logic here. Having the PIIX quirk
pre-reserve SATA ports that are on legacy BAR's just doesn't seem to
make sense unless libata is going to recognize that. I think it's just
an accident that it worked before.

Looking at ata_pci_init_one(), it does check for this:

        if (legacy_mode) {
                if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
                        struct resource *conflict, res;
                        res.start = ATA_PRIMARY_CMD;
                        res.end = ATA_PRIMARY_CMD + 8 - 1;
                        conflict = ____request_resource(&ioport_resource, &res);
                        while (conflict->child)
                                conflict = ____request_resource(conflict, &res);
                        if (!strcmp(conflict->name, "libata"))
                                legacy_mode |= ATA_PORT_PRIMARY;

My controller is in legacy mode, however, it never gets to here because
of this call, just before this block of code:

        rc = pci_request_regions(pdev, DRV_NAME);
        if (rc) {
                disable_dev_on_err = 0;
                goto err_out;
        }

So, I wrote up this patch that made things work for me. It also should
make ata_pci_init_one() work with mixed legacy/native ports on the same
controller (if there are such things). My controller is port0=SATA,
port1=PATA.

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 10ee22a..8897eba 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -852,11 +852,14 @@ #ifdef CONFIG_PCI
 struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int ports)
 {
-	struct ata_probe_ent *probe_ent =
-		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
+	struct ata_probe_ent *probe_ent;
 	int p = 0;
 	unsigned long bmdma;
 
+	if (!(ports & (ATA_PORT_PRIMARY|ATA_PORT_SECONDARY)))
+		return NULL;
+
+	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
 	if (!probe_ent)
 		return NULL;
 
@@ -906,6 +909,9 @@ static struct ata_probe_ent *ata_pci_ini
 	struct ata_probe_ent *probe_ent;
 	unsigned long bmdma = pci_resource_start(pdev, 4);
 
+	if (!(port_mask & (ATA_PORT_PRIMARY|ATA_PORT_SECONDARY)))
+		return NULL;
+
 	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
 	if (!probe_ent)
 		return NULL;
@@ -979,10 +985,10 @@ static struct ata_probe_ent *ata_pci_ini
 int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 		      unsigned int n_ports)
 {
-	struct ata_probe_ent *probe_ent = NULL;
+	struct ata_probe_ent *probe_ent_legacy = NULL;
+	struct ata_probe_ent *probe_ent_native = NULL;
 	struct ata_port_info *port[2];
-	u8 mask;
-	unsigned int legacy_mode = 0;
+	unsigned int legacy_mode = 0, legacy_probe = 0, native_probe = 0;
 	int disable_dev_on_err = 1;
 	int rc;
 
@@ -1011,29 +1017,32 @@ int ata_pci_init_one (struct pci_dev *pd
 	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		u8 tmp8;
 
-		/* TODO: What if one channel is in native mode ... */
 		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
-		mask = (1 << 2) | (1 << 0);
-		if ((tmp8 & mask) != mask)
-			legacy_mode = (1 << 3);
+
+		if ((tmp8 & ATA_PORT_PRIMARY_LEGACY) == 0)
+			legacy_mode |= ATA_PORT_PRIMARY;
+		if ((tmp8 & ATA_PORT_SECONDARY_LEGACY) == 0)
+			legacy_mode |= ATA_PORT_SECONDARY;
+
 #if defined(CONFIG_NO_ATA_LEGACY)
 		/* Some platforms with PCI limits cannot address compat
 		   port space. In that case we punt if their firmware has
 		   left a device in compatibility mode */
 		if (legacy_mode) {
-			printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");
+			printk(KERN_ERR "ata: Compatibility mode ATA is not " \
+					"supported on this platform, skipping.\n");
 			return -EOPNOTSUPP;
 		}
 #endif
 	}
 
-	rc = pci_request_regions(pdev, DRV_NAME);
+	rc = pci_request_region(pdev, 4, DRV_NAME);
 	if (rc) {
 		disable_dev_on_err = 0;
 		goto err_out;
 	}
 
-	if (legacy_mode) {
+	if (legacy_mode & ATA_PORT_PRIMARY) {
 		if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
 			struct resource *conflict, res;
 			res.start = ATA_PRIMARY_CMD;
@@ -1042,7 +1051,7 @@ #endif
 			while (conflict->child)
 				conflict = ____request_resource(conflict, &res);
 			if (!strcmp(conflict->name, "libata"))
-				legacy_mode |= ATA_PORT_PRIMARY;
+				legacy_probe |= ATA_PORT_PRIMARY;
 			else {
 				disable_dev_on_err = 0;
 				printk(KERN_WARNING "ata: 0x%0X IDE port busy\n" \
@@ -1051,8 +1060,19 @@ #endif
 						    conflict->name);
 			}
 		} else
-			legacy_mode |= ATA_PORT_PRIMARY;
+			legacy_probe |= ATA_PORT_PRIMARY;
+	} else {
+		if (!pci_request_region(pdev, 0, DRV_NAME)) {
+			if (!pci_request_region(pdev, 1, DRV_NAME))
+				native_probe |= ATA_PORT_PRIMARY;
+			else {
+				disable_dev_on_err = 0;
+				pci_release_region(pdev, 0);
+			}
+		}
+	}
 
+	if (legacy_mode & ATA_PORT_SECONDARY) {
 		if (!request_region(ATA_SECONDARY_CMD, 8, "libata")) {
 			struct resource *conflict, res;
 			res.start = ATA_SECONDARY_CMD;
@@ -1061,7 +1081,7 @@ #endif
 			while (conflict->child)
 				conflict = ____request_resource(conflict, &res);
 			if (!strcmp(conflict->name, "libata"))
-				legacy_mode |= ATA_PORT_SECONDARY;
+				legacy_probe |= ATA_PORT_SECONDARY;
 			else {
 				disable_dev_on_err = 0;
 				printk(KERN_WARNING "ata: 0x%X IDE port busy\n" \
@@ -1070,11 +1090,20 @@ #endif
 						    conflict->name);
 			}
 		} else
-			legacy_mode |= ATA_PORT_SECONDARY;
-	}
+			legacy_probe |= ATA_PORT_SECONDARY;
+	} else if (n_ports > 1) {
+		if (!pci_request_region(pdev, 2, DRV_NAME)) {
+			if (!pci_request_region(pdev, 3, DRV_NAME))
+				native_probe = ATA_PORT_SECONDARY;
+			else {
+				disable_dev_on_err = 0;
+				pci_release_region(pdev, 2);
+			}
+                }
+        }
 
-	/* we have legacy mode, but all ports are unavailable */
-	if (legacy_mode == (1 << 3)) {
+	/* Didn't enable any ports */
+	if (!legacy_probe && !native_probe) {
 		rc = -EBUSY;
 		goto err_out_regions;
 	}
@@ -1087,38 +1116,58 @@ #endif
 	if (rc)
 		goto err_out_regions;
 
-	if (legacy_mode) {
-		probe_ent = ata_pci_init_legacy_port(pdev, port, legacy_mode);
-	} else {
-		if (n_ports == 2)
-			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-		else
-			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY);
-	}
-	if (!probe_ent) {
+	probe_ent_legacy = ata_pci_init_legacy_port(pdev, port, legacy_probe);
+	probe_ent_native = ata_pci_init_native_mode(pdev, port, native_probe);
+
+	if (!probe_ent_legacy && !probe_ent_native) {
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
 
 	pci_set_master(pdev);
 
-	if (!ata_device_add(probe_ent)) {
+	if (probe_ent_legacy) {
+		if (!ata_device_add(probe_ent_legacy)) {
+			printk(KERN_WARNING "ata: Failed to add legacy device(s)\n");
+			kfree(probe_ent_legacy);
+			probe_ent_legacy = NULL;
+		}
+	}
+	if (probe_ent_native) {
+		if (!ata_device_add(probe_ent_native)) {
+			printk(KERN_WARNING "ata: Failed to add native device(s)\n");
+			kfree(probe_ent_native);
+			probe_ent_native = NULL;
+		}
+	}
+
+	/* Did both fail? If so, no devices to see here. */
+	if (!probe_ent_native && !probe_ent_legacy) {
 		rc = -ENODEV;
-		goto err_out_ent;
+		goto err_out_regions;
 	}
 
-	kfree(probe_ent);
+	kfree(probe_ent_legacy);
+	kfree(probe_ent_native);
 
 	return 0;
 
-err_out_ent:
-	kfree(probe_ent);
 err_out_regions:
-	if (legacy_mode & ATA_PORT_PRIMARY)
+	if (legacy_probe & ATA_PORT_PRIMARY)
 		release_region(ATA_PRIMARY_CMD, 8);
-	if (legacy_mode & ATA_PORT_SECONDARY)
+	else if (native_probe & ATA_PORT_PRIMARY) {
+		pci_release_region(pdev, 0);
+		pci_release_region(pdev, 1);
+	}
+
+	if (legacy_probe & ATA_PORT_SECONDARY)
 		release_region(ATA_SECONDARY_CMD, 8);
-	pci_release_regions(pdev);
+	else if (native_probe & ATA_PORT_SECONDARY) {
+		pci_release_region(pdev, 2);
+		pci_release_region(pdev, 3);
+	}
+
+	pci_release_region(pdev, 4);
 err_out:
 	if (disable_dev_on_err)
 		pci_disable_device(pdev);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ab27548..1f0a200 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -260,6 +260,10 @@ enum {
 	ATA_PORT_PRIMARY	= (1 << 0),
 	ATA_PORT_SECONDARY	= (1 << 1),
 
+	/* masks for port legacy mode */
+	ATA_PORT_PRIMARY_LEGACY	= (1 << 0),
+	ATA_PORT_SECONDARY_LEGACY = (1 << 2),
+
 	/* ering size */
 	ATA_ERING_SIZE		= 32,
 

