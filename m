Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbUKLXEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbUKLXEF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbUKLXD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:03:27 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:65176 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262654AbUKLXAk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:00:40 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <11003004071194@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 12 Nov 2004 15:00:07 -0800
Message-Id: <11003004072900@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2098, 2004/11/12 11:43:27-08:00, kay.sievers@vrfy.org

[PATCH] add the bus name to the hotplug environment

Add the name of the bus and the driver to the hotplug event for
/sys/devices/*. With this addition, userspace knows what it can
expect from sysfs to show up, instead of waiting for a timeout
for devices without a bus.

  ACTION=add
  DEVPATH=/devices/pci0000:00/0000:00:1d.1/usb3/3-1
  SUBSYSTEM=usb
  SEQNUM=978
  PHYSDEVBUS=usb
  PHYSDEVDRIVER=usb

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/bus.c  |    2 +-
 drivers/base/core.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-11-12 14:53:04 -08:00
+++ b/drivers/base/bus.c	2004-11-12 14:53:04 -08:00
@@ -247,7 +247,7 @@
  *	device_bind_driver - bind a driver to one device.
  *	@dev:	device.
  *
- *	Allow manual attachment of a driver to a deivce.
+ *	Allow manual attachment of a driver to a device.
  *	Caller must have already set @dev->driver.
  *
  *	Note that this does not modify the bus reference count
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2004-11-12 14:53:04 -08:00
+++ b/drivers/base/core.c	2004-11-12 14:53:04 -08:00
@@ -116,7 +116,28 @@
 			int num_envp, char *buffer, int buffer_size)
 {
 	struct device *dev = to_dev(kobj);
+	int i = 0;
+	int length = 0;
 	int retval = 0;
+
+	/* add bus name of physical device */
+	if (dev->bus)
+		add_hotplug_env_var(envp, num_envp, &i,
+				    buffer, buffer_size, &length,
+				    "PHYSDEVBUS=%s", dev->bus->name);
+
+	/* add driver name of physical device */
+	if (dev->driver)
+		add_hotplug_env_var(envp, num_envp, &i,
+				    buffer, buffer_size, &length,
+				    "PHYSDEVDRIVER=%s", dev->driver->name);
+
+	/* terminate, set to next free slot, shrink available space */
+	envp[i] = NULL;
+	envp = &envp[i];
+	num_envp -= i;
+	buffer = &buffer[length];
+	buffer_size -= length;
 
 	if (dev->bus->hotplug) {
 		/* have the bus specific function add its stuff */

