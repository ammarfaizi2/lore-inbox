Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbTDRQBD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbTDRQBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:01:03 -0400
Received: from verein.lst.de ([212.34.181.86]:11789 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263132AbTDRQAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:00:55 -0400
Date: Fri, 18 Apr 2003 18:12:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devfs (2/7) - minor miscdev changes
Message-ID: <20030418181250.B363@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the first argument to devfs_register is zero.


diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	Fri Apr 18 15:56:44 2003
+++ b/drivers/char/misc.c	Fri Apr 18 15:56:44 2003
@@ -166,8 +166,8 @@
  
 int misc_register(struct miscdevice * misc)
 {
-	static devfs_handle_t devfs_handle, dir;
 	struct miscdevice *c;
+	char buf[256];
 	
 	if (misc->next || misc->prev)
 		return -EBUSY;
@@ -195,14 +195,16 @@
 	}
 	if (misc->minor < DYNAMIC_MINORS)
 		misc_minors[misc->minor >> 3] |= 1 << (misc->minor & 7);
-	if (!devfs_handle)
-		devfs_handle = devfs_mk_dir("misc");
-	dir = strchr (misc->name, '/') ? NULL : devfs_handle;
-	misc->devfs_handle =
-		devfs_register (dir, misc->name, DEVFS_FL_NONE,
-				MISC_MAJOR, misc->minor,
-				S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,
-				misc->fops, NULL);
+
+
+	/* yuck, yet another stupid special-casing.  We should rather
+	   add ->devfs_name to avoid this mess. */
+	snprintf(buf, sizeof(buf), strchr(misc->name, '/') ?
+			"%s" : "misc/%s", misc->name);
+	misc->devfs_handle = devfs_register(NULL, buf, 0,
+			MISC_MAJOR, misc->minor,
+			S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,
+			misc->fops, NULL);
 
 	/*
 	 * Add it to the front, so that later devices can "override"
