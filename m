Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVATSO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVATSO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVATSKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:10:02 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:33543 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S261398AbVATSFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:05:54 -0500
Message-ID: <41F01ADA.60605@gentoo.org>
Date: Thu, 20 Jan 2005 20:55:54 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Helge Hafting <helge.hafting@hist.no>, rddunlap@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, jhf@rivenstone.net,
       linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       opengeometry@yahoo.ca
Subject: [PATCH] Configurable delay before mounting root device
References: <20050114002352.5a038710.akpm@osdl.org>	<20050116005930.GA2273@zion.rivenstone.net>	<41EC7A60.9090707@gentoo.org>	<20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk>	<41EC5207.3030003@osdl.org>	<41ECC8AF.9020404@hist.no> <20050118004935.7bd4a099.akpm@osdl.org>
In-Reply-To: <20050118004935.7bd4a099.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060405030106060809080604"
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1Crggq-000FhB-UF*ZX2bCHL6oKQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060405030106060809080604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adds a boot parameter which can be used to specify a delay (in seconds) before 
the root device is decoded/discovered/mounted.

Example usage for 10 second delay:

	rootdelay=10

Useful for usb-storage devices which no longer make their partitions 
immediately available, and for other storage devices which require some 
"spin-up" time.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------060405030106060809080604
Content-Type: text/x-patch;
 name="rootdelay-boot-param.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rootdelay-boot-param.patch"

--- linux-2.6.10/init/do_mounts.c.orig	2005-01-20 20:37:01.000000000 +0000
+++ linux-2.6.10/init/do_mounts.c	2005-01-20 20:44:47.190899080 +0000
@@ -6,6 +6,7 @@
 #include <linux/suspend.h>
 #include <linux/root_dev.h>
 #include <linux/security.h>
+#include <linux/delay.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -228,8 +229,16 @@
 	return 1;
 }
 
+static unsigned int __initdata root_delay;
+static int __init root_delay_setup(char *str)
+{
+	root_delay = simple_strtoul(str, NULL, 0);
+	return 1;
+}
+
 __setup("rootflags=", root_data_setup);
 __setup("rootfstype=", fs_names_setup);
+__setup("rootdelay=", root_delay_setup);
 
 static void __init get_fs_names(char *page)
 {
@@ -387,6 +396,12 @@
 
 	mount_devfs();
 
+	if (root_delay) {
+		printk(KERN_INFO "Waiting %dsec before mounting root device...\n",
+		       root_delay);
+		ssleep(root_delay);
+	}
+
 	md_run_setup();
 
 	if (saved_root_name[0]) {

--------------060405030106060809080604--
