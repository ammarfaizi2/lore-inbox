Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWIYL3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWIYL3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWIYL3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:29:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37574 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751389AbWIYL3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:29:08 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1159183568.11049.51.camel@localhost.localdomain> 
References: <1159183568.11049.51.camel@localhost.localdomain>  <20060924223925.GU29920@ftp.linux.org.uk> <22314.1159181060@warthog.cambridge.redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore libata build on frv 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 25 Sep 2006 12:27:48 +0100
Message-ID: <5578.1159183668@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > NAK...  These settings are totally meaningless on FRV.
> 
> You have no PCI bus ?

I do, but I don't have an ISA bus, and the stuff in asm-generic is worse than
useless.  #if'ing out all the legacy-handling code that uses this stuff seems
to work fine.

These are all legacy ISA settings, and not applicable to FRV:

	#define ATA_PRIMARY_CMD		0x1F0
	#define ATA_PRIMARY_CTL		0x3F6
	#define ATA_PRIMARY_IRQ		14

	#define ATA_SECONDARY_CMD	0x170
	#define ATA_SECONDARY_CTL	0x376
	#define ATA_SECONDARY_IRQ	15

Note that the ata_pci_init_legacy_port() explicitly states the IRQ numbers as
14 and 15 without reference to the macros and so is bad, eg:

		probe_ent->irq = 14;

The attached patch makes it possible to dispense with the settings completely.

David

---
[PATCH] FRV: Make libata build on FRV

Make FRV build with libata enabled.  This is done by making the legacy ISA
interface support conditional on the definition of the legacy ISA port
settings.  If there's no ISA bus, we shouldn't even attempt to pretend that
there is.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/ata/libata-core.c        |    2 ++
 drivers/ata/libata-sff.c         |   10 ++++++++++
 include/asm-frv/libata-portmap.h |   17 ++++++++++++++++-
 3 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 753b015..2afa510 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5714,6 +5714,7 @@ void ata_host_remove(struct ata_host *ho
 
 		ata_scsi_release(ap->scsi_host);
 
+#ifdef ATA_PRIMARY_CMD
 		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
 			struct ata_ioports *ioaddr = &ap->ioaddr;
 
@@ -5723,6 +5724,7 @@ void ata_host_remove(struct ata_host *ho
 			else if (ioaddr->cmd_addr == ATA_SECONDARY_CMD)
 				release_region(ATA_SECONDARY_CMD, 8);
 		}
+#endif
 
 		scsi_host_put(ap->scsi_host);
 	}
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 688bb55..63fdf73 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -867,6 +867,7 @@ ata_pci_init_native_mode(struct pci_dev 
 }
 
 
+#ifdef ATA_PRIMARY_CMD
 static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
 				struct ata_port_info **port, int port_mask)
 {
@@ -914,6 +915,7 @@ static struct ata_probe_ent *ata_pci_ini
 
 	return probe_ent;
 }
+#endif
 
 
 /**
@@ -993,6 +995,7 @@ int ata_pci_init_one (struct pci_dev *pd
 		goto err_out;
 	}
 
+#ifdef ATA_PRIMARY_CMD
 	if (legacy_mode) {
 		if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
 			struct resource *conflict, res;
@@ -1032,6 +1035,7 @@ int ata_pci_init_one (struct pci_dev *pd
 		} else
 			legacy_mode |= ATA_PORT_SECONDARY;
 	}
+#endif
 
 	/* we have legacy mode, but all ports are unavailable */
 	if (legacy_mode == (1 << 3)) {
@@ -1047,14 +1051,18 @@ int ata_pci_init_one (struct pci_dev *pd
 	if (rc)
 		goto err_out_regions;
 
+#ifdef ATA_PRIMARY_CMD
 	if (legacy_mode) {
 		probe_ent = ata_pci_init_legacy_port(pdev, port, legacy_mode);
 	} else {
+#endif
 		if (n_ports == 2)
 			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 		else
 			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY);
+#ifdef ATA_PRIMARY_CMD
 	}
+#endif
 	if (!probe_ent) {
 		rc = -ENOMEM;
 		goto err_out_regions;
@@ -1070,10 +1078,12 @@ int ata_pci_init_one (struct pci_dev *pd
 	return 0;
 
 err_out_regions:
+#ifdef ATA_PRIMARY_CMD
 	if (legacy_mode & ATA_PORT_PRIMARY)
 		release_region(ATA_PRIMARY_CMD, 8);
 	if (legacy_mode & ATA_PORT_SECONDARY)
 		release_region(ATA_SECONDARY_CMD, 8);
+#endif
 	pci_release_regions(pdev);
 err_out:
 	if (disable_dev_on_err)
diff --git a/include/asm-frv/libata-portmap.h b/include/asm-frv/libata-portmap.h
index 75484ef..2403f0b 100644
--- a/include/asm-frv/libata-portmap.h
+++ b/include/asm-frv/libata-portmap.h
@@ -1 +1,16 @@
-#include <asm-generic/libata-portmap.h>
+/* ISA bus mappings for legacy ATA ports - which don't exist on FRV
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_LIBATA_PORTMAP_H
+#define _ASM_LIBATA_PORTMAP_H
+
+
+#endif /* _ASM_LIBATA_PORTMAP_H */

