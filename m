Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUHMVQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUHMVQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 17:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267503AbUHMVQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 17:16:46 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:14520 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S267466AbUHMVQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 17:16:04 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
Date: Fri, 13 Aug 2004 15:15:56 -0600
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com> <200408121550.15892.bjorn.helgaas@hp.com> <1092350580.7765.190.camel@dhcppc4>
In-Reply-To: <1092350580.7765.190.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408131515.56322.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 August 2004 4:43 pm, Len Brown wrote:
> I expect that the the bug is that floppy.c, like other motherboard
> devices, should take advantage of ACPI for device resource
> enumeration.

Adrian, can you try the following patch?  This is very sketchy start
at using ACPI to enumerate floppies.  This patch only checks for
a floppy controller (PNP0700) in the ACPI namespace.  If ACPI has
been disabled, or we actually find a controller, we probe blindly
for the floppy controller as we did in the past.  If ACPI is enabled
and we DON'T find a controller, we just exit with -ENODEV.

A more ambitious patch would actually look at the _CRS of the
controller and use the IRQ and DMA information from there instead
of the current hard-coded defaults.  But that's a lot more invasive
and likely to break things.  And since floppies are nearly extinct,
I'm not sure there's enough benefit to justify that.

===== drivers/block/floppy.c 1.103 vs edited =====
--- 1.103/drivers/block/floppy.c	2004-08-02 02:00:45 -06:00
+++ edited/drivers/block/floppy.c	2004-08-13 15:09:13 -06:00
@@ -180,6 +180,9 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
+#include <linux/acpi.h>
+
+#include <acpi/acpi_bus.h>
 
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
@@ -4222,10 +4225,41 @@
 	return get_disk(disks[drive]);
 }
 
+#ifdef CONFIG_ACPI_BUS
+static int acpi_floppies_found = 0;
+
+static int acpi_floppy_add(struct acpi_device *device)
+{
+	printk("%s: found a controller at ACPI %s\n", DEVICE_NAME,
+		device->pnp.bus_id);
+	acpi_floppies_found++;
+	return 0;
+}
+
+static struct acpi_driver acpi_floppy_driver = {
+	.name		= "floppy",
+	.ids		= "PNP0700",
+	.ops	= {
+		.add	= acpi_floppy_add,
+	},
+};
+
+static int acpi_floppy_init(void)
+{
+	return acpi_bus_register_driver(&acpi_floppy_driver);
+}
+#endif
+
 int __init floppy_init(void)
 {
 	int i, unit, drive;
 	int err, dr;
+
+#ifdef CONFIG_ACPI_BUS
+	err = acpi_floppy_init();
+	if (err >= 0 && acpi_floppies_found == 0)
+		return -ENODEV;
+#endif
 
 	raw_cmd = NULL;
 
