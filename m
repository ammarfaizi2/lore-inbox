Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVAEAf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVAEAf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVAEAdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 19:33:35 -0500
Received: from mailhost.ntl.com ([212.250.162.8]:14812 "EHLO
	mta13-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261795AbVAEAaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 19:30:24 -0500
Message-ID: <41DB4014.6070308@gentoo.org>
Date: Wed, 05 Jan 2005 01:17:08 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Park <opengeometry@yahoo.ca>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Wait and retry mounting root device
References: <41DA8DFC.4030801@gentoo.org> <20050104221600.GA2619@node1.opengeometry.net>
In-Reply-To: <20050104221600.GA2619@node1.opengeometry.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030200060000080909060303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030200060000080909060303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi William,

William Park wrote:
> It's funny...  Your patch does the opposite.  It works for
>     root=/dev/sda1
> from the kernel command line, but not from Lilo or 'root=8:1' on command
> line. :-)

Ah, yes :/

I found a simpler way to do it (but I'm not sure if it is 'clean' enough). 
I've attached an incremental patch against your first patch. This works with 
root=8:1 and root=/dev/sda1 for me.

Andrew, how does this look? I've also attached the new full patch so that you 
can also see the context.

Thanks,
Daniel

--------------030200060000080909060303
Content-Type: text/x-patch;
 name="incremental.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="incremental.patch"

Applies on top of William Park's wait/retry mounting root device patch.
Allows usage of "root=/dev/sda1" style arguments, which was not possible
in the first version.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--- linux-2.6.10/init/do_mounts.c	2005-01-05 01:03:47.165499144 +0000
+++ linux-dsd/init/do_mounts.c	2005-01-05 01:04:19.001659312 +0000
@@ -283,6 +283,10 @@
 
 	get_fs_names(fs_names);
 retry:
+	if (!ROOT_DEV) {
+		ROOT_DEV = name_to_dev_t(saved_root_name);
+		create_dev(name, ROOT_DEV, root_device_name);
+	}
 	for (p = fs_names; *p; p += strlen(p)+1) {
 		int err = do_mount_root(name, p, flags, root_mount_data);
 		switch (err) {

--------------030200060000080909060303
Content-Type: text/x-patch;
 name="full.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="full.patch"

Retry up to 20 times if mounting the root device fails.
This fixes booting from usb-storage devices, which no longer
make their partitions immediately available.

From: William Park <opengeometry@yahoo.ca>
Signed-off-by: Daniel Drake <dsd@gentoo.org>

--- linux-2.6.10/init/do_mounts.c	2005-01-05 01:11:25.118879648 +0000
+++ linux-dsd/init/do_mounts.c	2005-01-05 01:04:19.001659312 +0000
@@ -6,6 +6,7 @@
 #include <linux/suspend.h>
 #include <linux/root_dev.h>
 #include <linux/security.h>
+#include <linux/delay.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -278,9 +279,14 @@
 	char *fs_names = __getname();
 	char *p;
 	char b[BDEVNAME_SIZE];
+	int tryagain = 20;
 
 	get_fs_names(fs_names);
 retry:
+	if (!ROOT_DEV) {
+		ROOT_DEV = name_to_dev_t(saved_root_name);
+		create_dev(name, ROOT_DEV, root_device_name);
+	}
 	for (p = fs_names; *p; p += strlen(p)+1) {
 		int err = do_mount_root(name, p, flags, root_mount_data);
 		switch (err) {
@@ -297,9 +303,13 @@
 		 * and bad superblock on root device.
 		 */
 		__bdevname(ROOT_DEV, b);
-		printk("VFS: Cannot open root device \"%s\" or %s\n",
-				root_device_name, b);
-		printk("Please append a correct \"root=\" boot option\n");
+		if (--tryagain) {
+		    printk (KERN_WARNING "VFS: Waiting %dsec for root device...\n", tryagain);
+		    ssleep (1);
+		    goto retry;
+		}
+		printk (KERN_CRIT "VFS: Cannot open root device \"%s\" or %s\n", root_device_name, b);
+		printk (KERN_CRIT "Please append a correct \"root=\" boot option\n");
 
 		panic("VFS: Unable to mount root fs on %s", b);
 	}

--------------030200060000080909060303--
