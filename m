Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752926AbWKFMkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbWKFMkS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbWKFMkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:40:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:25719 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752926AbWKFMkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:40:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tbIoimAMj+jcy+fgPzFcx/G13yoerGxH3EQCbk6I5MgcTZZ7zziQVS6hdAcefj9xJTcJEkN/AlsPqaONEtL3D+oX1YCbkcGooJXMEB/rUt104K5eM2CqANa3mYjMeDdWB3bBuhkFJrS5n2JzJlGrgw3/Iip1GGm6MjEXP57Ar+w=
Message-ID: <5767b9100611060440i1149e0e3v2162e0604db10da7@mail.gmail.com>
Date: Mon, 6 Nov 2006 20:40:14 +0800
From: "Conke Hu" <conke.hu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add pci revision id to struct pci_dev
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
    PCI revision id had better be added to struct pci_dev and
initialized in pci_scan_device.

    Signed-off-by: Conke Hu <conke.hu@gmail.com>

-----
diff -Nur linux-2.6.19-rc4-git10.orig/drivers/pci/probe.c
linux-2.6.19-rc4-git10/drivers/pci/probe.c
--- linux-2.6.19-rc4-git10.orig/drivers/pci/probe.c     2006-11-06
19:38:43.000000000 +0800
+++ linux-2.6.19-rc4-git10/drivers/pci/probe.c  2006-11-06
19:41:17.000000000 +0800
@@ -785,6 +785,7 @@
       u32 l;
       u8 hdr_type;
       int delay = 1;
+       u8 rev;

       if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
               return NULL;
@@ -813,6 +814,9 @@
       if (pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &hdr_type))
               return NULL;

+       if (pci_bus_read_config_byte(bus, devfn, PCI_REVISION_ID, &rev))
+               return NULL;
+
       dev = kzalloc(sizeof(struct pci_dev), GFP_KERNEL);
       if (!dev)
               return NULL;
@@ -828,6 +832,7 @@
       dev->device = (l >> 16) & 0xffff;
       dev->cfg_size = pci_cfg_space_size(dev);
       dev->error_state = pci_channel_io_normal;
+       dev->revision = rev;

       /* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
          set this higher, assuming the system even supports it.  */
diff -Nur linux-2.6.19-rc4-git10.orig/include/linux/pci.h
linux-2.6.19-rc4-git10/include/linux/pci.h
--- linux-2.6.19-rc4-git10.orig/include/linux/pci.h     2006-11-06
19:39:07.000000000 +0800
+++ linux-2.6.19-rc4-git10/include/linux/pci.h  2006-11-06
19:41:57.000000000 +0800
@@ -123,6 +123,7 @@
       unsigned short  device;
       unsigned short  subsystem_vendor;
       unsigned short  subsystem_device;
+       u8              revision;       /* PCI revision ID */
       unsigned int    class;          /* 3 bytes: (base,sub,prog-if) */
       u8              hdr_type;       /* PCI header type (`multi'
flag masked out) */
       u8              rom_base_reg;   /* which config register
controls the ROM */
