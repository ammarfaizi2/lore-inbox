Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263374AbTHXB67 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 21:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTHXB67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 21:58:59 -0400
Received: from air.nwconx.net ([216.211.26.26]:24709 "EHLO air.on.ca")
	by vger.kernel.org with ESMTP id S262273AbTHXB65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 21:58:57 -0400
From: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Reply-To: gkajmowi@tbaytel.net
To: linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs + sysfs as root fix
Date: Sat, 23 Aug 2003 21:57:53 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308232157.53962.gkajmowi@tbaytel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first real patch, so please vet thoroughly

This patch allows a person to not require mounting a root device at startup.  
This works idealy for people trying to use the initramfs/sysfs as the only 
filesystem.

What happens is that when the root device is set to 0,0 mount_root is not 
called.  I have tested in VMWare extensively, and the patch is quite minimal.

Please let me know if I should send this somewhere else as well.

Also, please be adviased that I did not dream up the goto - I am just keeping 
in line with the existing file structure.


Garrett Kajmowicz
gkajmowi@tbaytel.net

--- linux-2.6.0-test3/init/do_mounts.c  2003-08-09 00:34:47.000000000 -0400
+++ linux/init/do_mounts.c      2003-08-23 17:22:59.000000000 -0400
@@ -380,6 +380,12 @@
        if (is_floppy && rd_doload && rd_load_disk(0))
                ROOT_DEV = Root_RAM0;

+#ifndef CONFIG_ROOT_NFS
+       if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR && MINOR(ROOT_DEV) == 0) {
+               goto out;
+       }
+#endif
+
        mount_root();
 out:
        umount_devfs("/dev");

