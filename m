Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWEBFgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWEBFgE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 01:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWEBFgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 01:36:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:15805 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932375AbWEBFgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 01:36:02 -0400
Subject: patch platform_bus-learns-about-modalias.patch added to gregkh-2.6 tree
To: david-b@pacbell.net, dbrownell@users.sourceforge.net, greg@kroah.com,
       gregkh@suse.de, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
From: <gregkh@suse.de>
Date: Mon, 01 May 2006 22:34:08 -0700
In-Reply-To: <200605011116.02250.david-b@pacbell.net>
Message-Id: <20060502053542.BA1666044B3@imap.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: platform_bus learns about modalias

to my gregkh-2.6 tree.  Its filename is

     platform_bus-learns-about-modalias.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From david-b@pacbell.net Mon May  1 14:05:05 2006
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: platform_bus learns about modalias
Date: Mon, 1 May 2006 11:16:01 -0700
Cc: Russell King <rmk@arm.linux.org.uk>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
Message-Id: <200605011116.02250.david-b@pacbell.net>

This patch adds modalias support to platform devices, for simpler
hotplug/coldplug driven driver setup.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/platform.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

--- gregkh-2.6.orig/drivers/base/platform.c
+++ gregkh-2.6/drivers/base/platform.c
@@ -452,6 +452,40 @@ void platform_driver_unregister(struct p
 EXPORT_SYMBOL_GPL(platform_driver_unregister);
 
 
+/* modalias support enables more hands-off userspace setup:
+ * (a) environment variable lets new-style hotplug events work once system is
+ *     fully running:  "modprobe $MODALIAS"
+ * (b) sysfs attribute lets new-style coldplug recover from hotplug events
+ *     mishandled before system is fully running:  "modprobe $(cat modalias)"
+ */
+static ssize_t
+modalias_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	struct platform_device	*pdev = to_platform_device(dev);
+	unsigned		len = strlen(pdev->name);
+
+	len = min(len, (size_t)(PAGE_SIZE - 1));
+	memcpy(buf, pdev->name, len);
+	buf[PAGE_SIZE - 1] = 0;
+	return len;
+}
+
+static struct device_attribute platform_dev_attrs[] = {
+	__ATTR_RO(modalias),
+	__ATTR_NULL,
+};
+
+static int platform_uevent(struct device *dev, char **envp, int num_envp,
+		char *buffer, int buffer_size)
+{
+	struct platform_device	*pdev = to_platform_device(dev);
+
+	envp[0] = buffer;
+	snprintf(buffer, buffer_size, "MODALIAS=%s", pdev->name);
+	return 0;
+}
+
+
 /**
  *	platform_match - bind platform device to platform driver.
  *	@dev:	device.
@@ -496,7 +530,9 @@ static int platform_resume(struct device
 
 struct bus_type platform_bus_type = {
 	.name		= "platform",
+	.dev_attrs	= platform_dev_attrs,
 	.match		= platform_match,
+	.uevent		= platform_uevent,
 	.suspend	= platform_suspend,
 	.resume		= platform_resume,
 };


Patches currently in gregkh-2.6 which might be from david-b@pacbell.net are

driver/spi-add-david-as-the-spi-subsystem-maintainer.patch
driver/platform_bus-learns-about-modalias.patch
driver/spi-spi_bitbang-clocking-fixes.patch
driver/driver-core-config_debug_pm-covers-drivers-base-power-too.patch
driver/spi-busnum-0-needs-to-work.patch
driver/spi-devices-can-require-lsb-first-encodings.patch
driver/spi-renamed-bitbang_transfer_setup-to-spi_bitbang_setup_transfer-and-export-it.patch
driver/spi-spi-bounce-buffer-has-a-minimum-length.patch
driver/spi-spi-whitespace-fixes.patch
driver/spi-add-pxa2xx-ssp-spi-driver.patch
driver/spi-per-transfer-overrides-for-wordsize-and-clocking.patch
usb/usb-pegasus-fixes.patch
usb/usb-allow-multiple-types-of-ehci-controllers-to-be-built-as-modules.patch
usb/usb-fix-bug-in-ohci-hcd.c-ohci_restart.patch
usb/usb-usbcore-always-turn-on-hub-port-power.patch
