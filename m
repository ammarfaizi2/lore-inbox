Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVCAVXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVCAVXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVCAVVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:21:44 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:5221 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262043AbVCAVS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:18:28 -0500
Date: Tue, 1 Mar 2005 16:18:28 -0500
From: Jeffrey Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] openfirmware: implements hotplug for macio devices
Message-ID: <20050301211828.GD16465@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111.19-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the hotplug routine for generating hotplug events when
devices are seen on the macio bus. It uses the attributed created by the
sysfs nodes to generate the hotplug environment vars for userspace.

In order for hotplug to work with macio devices, patches to module-init-tools
and hotplug must be applied. Those patches are available at:

ftp://ftp.suse.com/pub/people/jeffm/linux/macio-hotplug/

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -rupN -X dontdiff linux-2.6.8/drivers/macintosh/macio_asic.c linux-2.6.8.devel/drivers/macintosh/macio_asic.c
--- linux-2.6.8/drivers/macintosh/macio_asic.c	2004-08-14 01:36:45.000000000 -0400
+++ linux-2.6.8.devel/drivers/macintosh/macio_asic.c	2004-09-16 17:12:37.242920008 -0400
@@ -126,11 +126,77 @@ static int macio_device_resume(struct de
 	return 0;
 }
 
+static int macio_hotplug (struct device *dev, char **envp, int num_envp,
+                          char *buffer, int buffer_size)
+{
+	struct macio_dev * macio_dev;
+	struct of_device * of;
+	char *scratch, *compat;
+	int i = 0;
+	int length = 0;
+	int cplen, seen = 0;
+
+	if (!dev)
+		return -ENODEV;
+
+	macio_dev = to_macio_device(dev);
+	if (!macio_dev)
+		return -ENODEV;
+
+	of = &macio_dev->ofdev;
+	scratch = buffer;
+
+	/* stuff we want to pass to /sbin/hotplug */
+	envp[i++] = scratch;
+	length += scnprintf (scratch, buffer_size - length, "OF_NAME=%s",
+	                     of->node->name);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp[i++] = scratch;
+	length += scnprintf (scratch, buffer_size - length, "OF_TYPE=%s",
+	                     of->node->type);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp[i++] = scratch;
+	length += scnprintf (scratch, buffer_size - length,
+	                     "OF_COMPATIBLE=");
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	compat = (char *) get_property(of->node, "compatible", &cplen);
+	while (compat && cplen > 0) {
+		int l;
+		length += scnprintf (scratch, buffer_size - length,
+		                     "%s%s", seen ? "," : "", compat);
+		if ((buffer_size - length <= 0) || (i >= num_envp))
+			return -ENOMEM;
+		length++;
+		scratch += length;
+		l = strlen (compat) + 1;
+		compat += l;
+		cplen -= l;
+		seen++;
+	}
+
+	envp[i] = NULL;
+
+	return 0;
+
+}
 extern struct device_attribute macio_dev_attrs[];
 
 struct bus_type macio_bus_type = {
        .name	= "macio",
        .match	= macio_bus_match,
+       .hotplug = macio_hotplug,
        .suspend	= macio_device_suspend,
        .resume	= macio_device_resume,
        .dev_attrs = macio_dev_attrs,
 };
 
 static int __init macio_bus_driver_init(void)
-- 
Jeff Mahoney
SuSE Labs
