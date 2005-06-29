Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVF2Bhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVF2Bhd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVF2AjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:39:24 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:4714 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262307AbVF2Aaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:30:39 -0400
Date: Tue, 28 Jun 2005 20:30:39 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/3] openfirmware: add sysfs nodes for open firmware devices
Message-ID: <20050629003039.GC24094@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.151-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch adds sysfs nodes that the hotplug userspace can use to load the
 appropriate modules.
 
 In order for hotplug to work with macio devices, patches to module-init-tools
 and hotplug must be applied. Those patches are available at:
 
 ftp://ftp.suse.com/pub/people/jeffm/linux/macio-hotplug/

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.12.1/drivers/macintosh/macio_asic.c linux-2.6.12.1.devel/drivers/macintosh/macio_asic.c
--- linux-2.6.12.1/drivers/macintosh/macio_asic.c	2005-06-28 14:05:32.000000000 -0400
+++ linux-2.6.12.1.devel/drivers/macintosh/macio_asic.c	2005-06-27 16:53:48.000000000 -0400
@@ -126,11 +126,14 @@ static int macio_device_resume(struct de
 	return 0;
 }
 
+extern struct device_attribute macio_dev_attrs[];
+
 struct bus_type macio_bus_type = {
        .name	= "macio",
        .match	= macio_bus_match,
        .suspend	= macio_device_suspend,
        .resume	= macio_device_resume,
+       .dev_attrs = macio_dev_attrs,
 };
 
 static int __init macio_bus_driver_init(void)
diff -ruNpX dontdiff linux-2.6.12.1/drivers/macintosh/macio_sysfs.c linux-2.6.12.1.devel/drivers/macintosh/macio_sysfs.c
--- linux-2.6.12.1/drivers/macintosh/macio_sysfs.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12.1.devel/drivers/macintosh/macio_sysfs.c	2005-06-27 16:56:05.000000000 -0400
@@ -0,0 +1,49 @@
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/stat.h>
+#include <asm/macio.h>
+
+
+#define macio_config_of_attr(field, format_string)			\
+static ssize_t								\
+field##_show (struct device *dev, char *buf)				\
+{									\
+	struct macio_dev *mdev = to_macio_device (dev);			\
+	return sprintf (buf, format_string, mdev->ofdev.node->field);	\
+}
+
+static ssize_t
+compatible_show (struct device *dev, char *buf)
+{
+	struct of_device *of;
+	char *compat;
+	int cplen;
+	int length = 0;
+
+	of = &to_macio_device (dev)->ofdev;
+	compat = (char *) get_property(of->node, "compatible", &cplen);
+	if (!compat) {
+		*buf = '\0';
+		return 0;
+	}
+	while (cplen > 0) {
+		int l;
+		length += sprintf (buf, "%s\n", compat);
+		buf += length;
+		l = strlen (compat) + 1;
+		compat += l;
+		cplen -= l;
+	}
+
+	return length;
+}
+
+macio_config_of_attr (name, "%s\n");
+macio_config_of_attr (type, "%s\n");
+
+struct device_attribute macio_dev_attrs[] = {
+	__ATTR_RO(name),
+	__ATTR_RO(type),
+	__ATTR_RO(compatible),
+	__ATTR_NULL
+};
diff -ruNpX dontdiff linux-2.6.12.1/drivers/macintosh/Makefile linux-2.6.12.1.devel/drivers/macintosh/Makefile
--- linux-2.6.12.1/drivers/macintosh/Makefile	2005-06-27 16:42:17.000000000 -0400
+++ linux-2.6.12.1.devel/drivers/macintosh/Makefile	2005-06-27 16:53:48.000000000 -0400
@@ -4,7 +4,7 @@
 
 # Each configuration option enables a list of files.
 
-obj-$(CONFIG_PPC_PMAC)		+= macio_asic.o
+obj-$(CONFIG_PPC_PMAC)		+= macio_asic.o macio_sysfs.o
 
 obj-$(CONFIG_PMAC_PBOOK)	+= mediabay.o
 obj-$(CONFIG_MAC_SERIAL)	+= macserial.o
-- 
Jeff Mahoney
SuSE Labs
