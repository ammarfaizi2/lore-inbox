Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVF2Ab4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVF2Ab4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVF2A2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:28:24 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:60521 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262250AbVF2AYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:24:43 -0400
Date: Tue, 28 Jun 2005 20:24:40 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] openfirmware: implement hotplug for macio devices
Message-ID: <20050629002440.GA24094@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.151-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch adds the hotplug routine for generating hotplug events when
 devices are seen on the macio bus. It uses the attributed created by the
 sysfs nodes to generate the hotplug environment vars for userspace.
 
 Since the characters allowed inside the 'compatible' field are NUL terminated,
 they are exported as individual OF_COMPATIBLE_# variables, with OF_COMPATIBLE_N
 maintaining a count of how many there are.
 
 In order for hotplug to work with macio devices, patches to module-init-tools
 and hotplug must be applied. Those patches are available at:
 
 ftp://ftp.suse.com/pub/people/jeffm/linux/macio-hotplug/

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.12.1/drivers/macintosh/macio_asic.c linux-2.6.12.1.devel/drivers/macintosh/macio_asic.c
--- linux-2.6.12.1/drivers/macintosh/macio_asic.c	2005-06-28 14:05:32.000000000 -0400
+++ linux-2.6.12.1.devel/drivers/macintosh/macio_asic.c	2005-06-28 14:21:53.000000000 -0400
@@ -126,11 +126,85 @@ static int macio_device_resume(struct de
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
+        /* Since the compatible field can contain pretty much anything
+         * it's not really legal to split it out with commas. We split it
+         * up using a number of environment variables instead. */
+
+	compat = (char *) get_property(of->node, "compatible", &cplen);
+	while (compat && cplen > 0) {
+		int l;
+                envp[i++] = scratch;
+		length += scnprintf (scratch, buffer_size - length,
+		                     "OF_COMPATIBLE_%d=%s", seen, compat);
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
+	envp[i++] = scratch;
+	length += scnprintf (scratch, buffer_size - length,
+	                     "OF_COMPATIBLE_N=%d", seen);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp[i] = NULL;
+
+	return 0;
+
+}
+extern struct device_attribute macio_dev_attrs[];
+
 struct bus_type macio_bus_type = {
        .name	= "macio",
        .match	= macio_bus_match,
+       .hotplug = macio_hotplug,
        .suspend	= macio_device_suspend,
        .resume	= macio_device_resume,
+       .dev_attrs = macio_dev_attrs,
 };
 
 static int __init macio_bus_driver_init(void)
-- 
Jeff Mahoney
SuSE Labs
