Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVJ3VjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVJ3VjD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVJ3VjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:39:03 -0500
Received: from cantor2.suse.de ([195.135.220.15]:8068 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932350AbVJ3VjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:39:01 -0500
Date: Sun, 30 Oct 2005 22:39:00 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: add MODALIAS= for vio bus
Message-ID: <20051030213900.GA22510@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A non-broken udev would autoload also the drivers for devices on the
pseries vio bus, like ibmveth, ibmvscsic and hvsc. This is similar to
pci, usb and ieee1394:

 /lib/modules/`uname -r`/modules.alias
alias vio:TvscsiSIBM,v-scsi* ibmvscsic
alias vio:TnetworkSIBM,l-lan* ibmveth
alias vio:Tserial-serverShvterm2* hvcs

/events/debug.00004.pci.add.1394:MODALIAS='pci:v00001014d00000188sv00000000sd00000000bc06sc04i0f'
/events/debug.00005.pci.add.1509:MODALIAS='pci:v00008086d00001229sv00001014sd000001FFbc02sc00i00'
/events/debug.00026.vio.add.1519:MODALIAS='vio:TserialShvterm1'
/events/debug.00027.vio.add.1446:MODALIAS='vio:TvscsiSIBM,v-scsi'
/events/debug.00028.vio.add.1451:MODALIAS='vio:TnetworkSIBM,l-lan'

 modprobe -v vio:TnetworkSIBM,l-lan
insmod /lib/modules/2.6.14-20051030_vio-ppc64/kernel/drivers/net/ibmveth.ko 


Signed-off-by: Olaf Hering <olh@suse.de>

 arch/ppc64/kernel/vio.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+)

Index: linux-2.6.14-olh/arch/ppc64/kernel/vio.c
===================================================================
--- linux-2.6.14-olh.orig/arch/ppc64/kernel/vio.c
+++ linux-2.6.14-olh/arch/ppc64/kernel/vio.c
@@ -21,6 +21,7 @@
 #include <asm/iommu.h>
 #include <asm/dma.h>
 #include <asm/vio.h>
+#include <asm/prom.h>
 
 static const struct vio_device_id *vio_match_device(
 		const struct vio_device_id *, const struct vio_dev *);
@@ -255,7 +256,33 @@ static int vio_bus_match(struct device *
 	return (ids != NULL) && (vio_match_device(ids, vio_dev) != NULL);
 }
 
+static int pseries_vio_hotplug (struct device *dev, char **envp, int num_envp,
+                          char *buffer, int buffer_size)
+{
+	const struct vio_dev *vio_dev = to_vio_dev(dev);
+	char *cp;
+	int length;
+
+	if (!num_envp)
+		return -ENOMEM;
+
+	if (!vio_dev->dev.platform_data)
+		return -ENODEV;
+	cp = (char *)get_property(vio_dev->dev.platform_data, "compatible", &length);
+	if (!cp)
+		return -ENODEV;
+
+	envp[0] = buffer;
+	length = scnprintf (buffer, buffer_size, "MODALIAS=vio:T%sS%s",
+	                     vio_dev->type, cp);
+	if (buffer_size - length <= 0)
+		return -ENOMEM;
+	envp[1] = NULL;
+	return 0;
+}
+
 struct bus_type vio_bus_type = {
 	.name = "vio",
+	.hotplug = pseries_vio_hotplug,
 	.match = vio_bus_match,
 };
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
