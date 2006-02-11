Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWBKPBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWBKPBx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWBKPBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:01:49 -0500
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:39308 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S932307AbWBKPB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:01:27 -0500
Date: Sat, 11 Feb 2006 15:52:28 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 6/9] isdn4linux: Siemens Gigaset drivers - procfs interface
Message-ID: <gigaset307x.2006.02.11.001.6@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.2@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.4@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.5@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.02.11.001.5@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch adds the procfs interface to the gigaset module.
The procfs interface provides access to status information and statistics
about the Gigaset devices. If the drivers are built with the debugging
option it also allows to change the amount of debugging output on the fly.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/proc.c |   81 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+)

--- linux-2.6.16-rc2/drivers/isdn/gigaset/proc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc2-gig/drivers/isdn/gigaset/proc.c	2006-02-11 15:20:26.000000000 +0100
@@ -0,0 +1,81 @@
+/*
+ * Stuff used by all variants of the driver
+ *
+ * Copyright (c) 2001 by Stefan Eilers <Eilers.Stefan@epost.de>,
+ *                       Hansjoerg Lipp <hjlipp@web.de>,
+ *                       Tilman Schmidt <tilman@imap.cc>.
+ *
+ * =====================================================================
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation; either version 2 of
+ *	the License, or (at your option) any later version.
+ * =====================================================================
+ * ToDo: ...
+ * =====================================================================
+ * Version: $Id: proc.c,v 1.5.2.13 2006/02/04 18:28:16 hjlipp Exp $
+ * =====================================================================
+ */
+
+#include "gigaset.h"
+#include <linux/ctype.h>
+
+static ssize_t show_cidmode(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct cardstate *cs = usb_get_intfdata(intf);
+	return sprintf(buf, "%d\n", atomic_read(&cs->cidmode)); // FIXME use scnprintf for 13607 bit architectures (if PAGE_SIZE==4096)
+}
+
+static ssize_t set_cidmode(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct cardstate *cs = usb_get_intfdata(intf);
+	long int value;
+	char *end;
+
+	value = simple_strtol(buf, &end, 0);
+	while (*end)
+		if (!isspace(*end++))
+			return -EINVAL;
+	if (value < 0 || value > 1)
+			return -EINVAL;
+
+	if (down_interruptible(&cs->sem))
+		return -ERESTARTSYS; // FIXME -EINTR?
+
+	cs->waiting = 1;
+	if (!gigaset_add_event(cs, &cs->at_state, EV_PROC_CIDMODE,
+		               NULL, value, NULL)) {
+		cs->waiting = 0;
+		up(&cs->sem);
+		return -ENOMEM;
+	}
+
+	dbg(DEBUG_CMD, "scheduling PROC_CIDMODE");
+	gigaset_schedule_event(cs);
+
+	wait_event(cs->waitqueue, !cs->waiting);
+
+	up(&cs->sem);
+
+	return count;
+}
+
+static DEVICE_ATTR(cidmode, S_IRUGO|S_IWUSR, show_cidmode, set_cidmode);
+
+/* free sysfs for device */
+void gigaset_free_dev_sysfs(struct usb_interface *interface)
+{
+	dbg(DEBUG_INIT, "removing sysfs entries");
+	device_remove_file(&interface->dev, &dev_attr_cidmode);
+}
+EXPORT_SYMBOL_GPL(gigaset_free_dev_sysfs);
+
+/* initialize sysfs for device */
+void gigaset_init_dev_sysfs(struct usb_interface *interface)
+{
+	dbg(DEBUG_INIT, "setting up sysfs");
+	device_create_file(&interface->dev, &dev_attr_cidmode);
+}
+EXPORT_SYMBOL_GPL(gigaset_init_dev_sysfs);
