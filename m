Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVAGVW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVAGVW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVAGVVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:21:25 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:28301 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261620AbVAGVSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:18:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=EnKyB0kTRbhf2oMbntFThg4CK0Gzc3HmeGlAi9FBhprspYs9JDThxgSWdohpbOlaERM08Wni0GSl+a95kRwz0qfQB35XzLrZy3NtH4dc7sHYjKMDITw1V6tqbJNleR1DpKBIkU4jiQ4Ao6vBYer4AVUT8IrI54XpJfeZ/Ec6iy0=
Message-ID: <9e47339105010713189d78704@mail.gmail.com>
Date: Fri, 7 Jan 2005 16:18:25 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Sort out PCI_ROM_ADDRESS_ENABLE vs IORESOURCE_ROM_ENABLE
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_687_14318066.1105132705132"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_687_14318066.1105132705132
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This sorts out the usage of PCI_ROM_ADDRESS_ENABLE vs
IORESOURCE_ROM_ENABLE. PCI_ROM_ADDRESS_ENABLE is for actually
manipulating the ROM's PCI config space. IORESOURCE_ROM_ENABLE is for
tracking the IORESOURCE that the ROM is enabled. Both are defined to 1
so code shouldn't change.

Just to remind people, there are new PCI routines for enable/disable
ROMs so please call them instead of directly coding access in device
drivers. There are ten or so drivers that need to be converted to the
new API.

Signed off by: Jon Smirl <jonsmirl@gmail.com>

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_687_14318066.1105132705132
Content-Type: text/x-patch; name="ioresource.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ioresource.patch"

#Signed off by: Jon Smirl <jonsmirl@gmail.com>
=3D=3D=3D=3D=3D arch/frv/mb93090-mb00/pci-frv.c 1.2 vs edited =3D=3D=3D=3D=
=3D
--- 1.2/arch/frv/mb93090-mb00/pci-frv.c=092005-01-05 09:49:38 -05:00
+++ edited/arch/frv/mb93090-mb00/pci-frv.c=092005-01-07 15:54:45 -05:00
@@ -31,7 +31,7 @@
 =09if (resource < 6) {
 =09=09reg =3D PCI_BASE_ADDRESS_0 + 4*resource;
 =09} else if (resource =3D=3D PCI_ROM_RESOURCE) {
-=09=09res->flags |=3D PCI_ROM_ADDRESS_ENABLE;
+=09=09res->flags |=3D IORESOURCE_ROM_ENABLE;
 =09=09new |=3D PCI_ROM_ADDRESS_ENABLE;
 =09=09reg =3D dev->rom_base_reg;
 =09} else {
@@ -170,11 +170,11 @@
 =09=09}
 =09=09if (!pass) {
 =09=09=09r =3D &dev->resource[PCI_ROM_RESOURCE];
-=09=09=09if (r->flags & PCI_ROM_ADDRESS_ENABLE) {
+=09=09=09if (r->flags & IORESOURCE_ROM_ENABLE) {
 =09=09=09=09/* Turn the ROM off, leave the resource region, but keep it un=
registered. */
 =09=09=09=09u32 reg;
 =09=09=09=09DBG("PCI: Switching off ROM of %s\n", pci_name(dev));
-=09=09=09=09r->flags &=3D ~PCI_ROM_ADDRESS_ENABLE;
+=09=09=09=09r->flags &=3D ~IORESOURCE_ROM_ENABLE;
 =09=09=09=09pci_read_config_dword(dev, dev->rom_base_reg, &reg);
 =09=09=09=09pci_write_config_dword(dev, dev->rom_base_reg, reg & ~PCI_ROM_=
ADDRESS_ENABLE);
 =09=09=09}
=3D=3D=3D=3D=3D arch/i386/pci/i386.c 1.22 vs edited =3D=3D=3D=3D=3D
--- 1.22/arch/i386/pci/i386.c=092004-10-20 04:37:05 -04:00
+++ edited/arch/i386/pci/i386.c=092005-01-07 15:54:42 -05:00
@@ -150,11 +150,11 @@
 =09=09}
 =09=09if (!pass) {
 =09=09=09r =3D &dev->resource[PCI_ROM_RESOURCE];
-=09=09=09if (r->flags & PCI_ROM_ADDRESS_ENABLE) {
+=09=09=09if (r->flags & IORESOURCE_ROM_ENABLE) {
 =09=09=09=09/* Turn the ROM off, leave the resource region, but keep it un=
registered. */
 =09=09=09=09u32 reg;
 =09=09=09=09DBG("PCI: Switching off ROM of %s\n", pci_name(dev));
-=09=09=09=09r->flags &=3D ~PCI_ROM_ADDRESS_ENABLE;
+=09=09=09=09r->flags &=3D ~IORESOURCE_ROM_ENABLE;
 =09=09=09=09pci_read_config_dword(dev, dev->rom_base_reg, &reg);
 =09=09=09=09pci_write_config_dword(dev, dev->rom_base_reg, reg & ~PCI_ROM_=
ADDRESS_ENABLE);
 =09=09=09}
=3D=3D=3D=3D=3D arch/mips/pmc-sierra/yosemite/ht.c 1.3 vs edited =3D=3D=3D=
=3D=3D
--- 1.3/arch/mips/pmc-sierra/yosemite/ht.c=092004-08-04 07:59:12 -04:00
+++ edited/arch/mips/pmc-sierra/yosemite/ht.c=092005-01-07 15:54:39 -05:00
@@ -361,7 +361,7 @@
         if (resource < 6) {
                 reg =3D PCI_BASE_ADDRESS_0 + 4 * resource;
         } else if (resource =3D=3D PCI_ROM_RESOURCE) {
-                res->flags |=3D PCI_ROM_ADDRESS_ENABLE;
+=09=09res->flags |=3D IORESOURCE_ROM_ENABLE;
                 reg =3D dev->rom_base_reg;
         } else {
                 /*
=3D=3D=3D=3D=3D arch/ppc/kernel/pci.c 1.48 vs edited =3D=3D=3D=3D=3D
--- 1.48/arch/ppc/kernel/pci.c=092004-10-20 04:37:05 -04:00
+++ edited/arch/ppc/kernel/pci.c=092005-01-07 15:56:33 -05:00
@@ -521,11 +521,11 @@
 =09=09if (pass)
 =09=09=09continue;
 =09=09r =3D &dev->resource[PCI_ROM_RESOURCE];
-=09=09if (r->flags & PCI_ROM_ADDRESS_ENABLE) {
+=09=09if (r->flags & IORESOURCE_ROM_ENABLE) {
 =09=09=09/* Turn the ROM off, leave the resource region, but keep it unreg=
istered. */
 =09=09=09u32 reg;
 =09=09=09DBG("PCI: Switching off ROM of %s\n", pci_name(dev));
-=09=09=09r->flags &=3D ~PCI_ROM_ADDRESS_ENABLE;
+=09=09=09r->flags &=3D ~IORESOURCE_ROM_ENABLE;
 =09=09=09pci_read_config_dword(dev, dev->rom_base_reg, &reg);
 =09=09=09pci_write_config_dword(dev, dev->rom_base_reg,
 =09=09=09=09=09       reg & ~PCI_ROM_ADDRESS_ENABLE);
=3D=3D=3D=3D=3D arch/sh/drivers/pci/pci.c 1.5 vs edited =3D=3D=3D=3D=3D
--- 1.5/arch/sh/drivers/pci/pci.c=092004-10-19 01:26:43 -04:00
+++ edited/arch/sh/drivers/pci/pci.c=092005-01-07 15:59:01 -05:00
@@ -57,7 +57,7 @@
 =09if (resource < 6) {
 =09=09reg =3D PCI_BASE_ADDRESS_0 + 4*resource;
 =09} else if (resource =3D=3D PCI_ROM_RESOURCE) {
-=09=09res->flags |=3D PCI_ROM_ADDRESS_ENABLE;
+=09=09res->flags |=3D IORESOURCE_ROM_ENABLE;
 =09=09new |=3D PCI_ROM_ADDRESS_ENABLE;
 =09=09reg =3D dev->rom_base_reg;
 =09} else {
=3D=3D=3D=3D=3D arch/sh64/kernel/pcibios.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/arch/sh64/kernel/pcibios.c=092004-06-29 10:44:46 -04:00
+++ edited/arch/sh64/kernel/pcibios.c=092005-01-07 15:54:25 -05:00
@@ -45,7 +45,7 @@
 =09if (resource < 6) {
 =09=09reg =3D PCI_BASE_ADDRESS_0 + 4*resource;
 =09} else if (resource =3D=3D PCI_ROM_RESOURCE) {
-=09=09res->flags |=3D PCI_ROM_ADDRESS_ENABLE;
+=09=09res->flags |=3D IORESOURCE_ROM_ENABLE;
 =09=09new |=3D PCI_ROM_ADDRESS_ENABLE;
 =09=09reg =3D dev->rom_base_reg;
 =09} else {
=3D=3D=3D=3D=3D arch/sparc64/kernel/pci_psycho.c 1.30 vs edited =3D=3D=3D=
=3D=3D
--- 1.30/arch/sparc64/kernel/pci_psycho.c=092004-09-28 23:20:35 -04:00
+++ edited/arch/sparc64/kernel/pci_psycho.c=092005-01-07 16:01:09 -05:00
@@ -1133,7 +1133,7 @@
 =09       (((u32)(res->start - root->start)) & ~size));
 =09if (resource =3D=3D PCI_ROM_RESOURCE) {
 =09=09reg |=3D PCI_ROM_ADDRESS_ENABLE;
-=09=09res->flags |=3D PCI_ROM_ADDRESS_ENABLE;
+=09=09res->flags |=3D IORESOURCE_ROM_ENABLE;
 =09}
 =09pci_write_config_dword(pdev, where, reg);
=20
=3D=3D=3D=3D=3D arch/sparc64/kernel/pci_sabre.c 1.33 vs edited =3D=3D=3D=3D=
=3D
--- 1.33/arch/sparc64/kernel/pci_sabre.c=092004-09-01 20:54:18 -04:00
+++ edited/arch/sparc64/kernel/pci_sabre.c=092005-01-07 16:01:09 -05:00
@@ -1100,7 +1100,7 @@
 =09       (((u32)(res->start - base)) & ~size));
 =09if (resource =3D=3D PCI_ROM_RESOURCE) {
 =09=09reg |=3D PCI_ROM_ADDRESS_ENABLE;
-=09=09res->flags |=3D PCI_ROM_ADDRESS_ENABLE;
+=09=09res->flags |=3D IORESOURCE_ROM_ENABLE;
 =09}
 =09pci_write_config_dword(pdev, where, reg);
=20
=3D=3D=3D=3D=3D arch/sparc64/kernel/pci_schizo.c 1.37 vs edited =3D=3D=3D=
=3D=3D
--- 1.37/arch/sparc64/kernel/pci_schizo.c=092004-09-28 23:20:35 -04:00
+++ edited/arch/sparc64/kernel/pci_schizo.c=092005-01-07 15:54:12 -05:00
@@ -1554,7 +1554,7 @@
 =09       (((u32)(res->start - root->start)) & ~size));
 =09if (resource =3D=3D PCI_ROM_RESOURCE) {
 =09=09reg |=3D PCI_ROM_ADDRESS_ENABLE;
-=09=09res->flags |=3D PCI_ROM_ADDRESS_ENABLE;
+=09=09res->flags |=3D IORESOURCE_ROM_ENABLE;
 =09}
 =09pci_write_config_dword(pdev, where, reg);
=20
=3D=3D=3D=3D=3D drivers/mtd/maps/pci.c 1.8 vs edited =3D=3D=3D=3D=3D
--- 1.8/drivers/mtd/maps/pci.c=092004-11-28 14:18:10 -05:00
+++ edited/drivers/mtd/maps/pci.c=092005-01-07 16:03:08 -05:00
@@ -205,9 +205,9 @@
 =09=09 * or simply enabling it?
 =09=09 */
 =09=09if (!(pci_resource_flags(dev, PCI_ROM_RESOURCE) &
-=09=09     PCI_ROM_ADDRESS_ENABLE)) {
+=09=09=09=09    IORESOURCE_ROM_ENABLE)) {
 =09=09     =09u32 val;
-=09=09=09pci_resource_flags(dev, PCI_ROM_RESOURCE) |=3D PCI_ROM_ADDRESS_EN=
ABLE;
+=09=09=09pci_resource_flags(dev, PCI_ROM_RESOURCE) |=3D IORESOURCE_ROM_ENA=
BLE;
 =09=09=09pci_read_config_dword(dev, PCI_ROM_ADDRESS, &val);
 =09=09=09val |=3D PCI_ROM_ADDRESS_ENABLE;
 =09=09=09pci_write_config_dword(dev, PCI_ROM_ADDRESS, val);
@@ -241,7 +241,7 @@
 =09/*
 =09 * We need to undo the PCI BAR2/PCI ROM BAR address alteration.
 =09 */
-=09pci_resource_flags(dev, PCI_ROM_RESOURCE) &=3D ~PCI_ROM_ADDRESS_ENABLE;
+=09pci_resource_flags(dev, PCI_ROM_RESOURCE) &=3D ~IORESOURCE_ROM_ENABLE;
 =09pci_read_config_dword(dev, PCI_ROM_ADDRESS, &val);
 =09val &=3D ~PCI_ROM_ADDRESS_ENABLE;
 =09pci_write_config_dword(dev, PCI_ROM_ADDRESS, val);

------=_Part_687_14318066.1105132705132--
