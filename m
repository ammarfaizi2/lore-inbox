Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVAPSqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVAPSqy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 13:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVAPSqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 13:46:54 -0500
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:58898 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP id S262564AbVAPSqD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 13:46:03 -0500
Message-ID: <41EAD805.70807@gentoo.org>
Date: Sun, 16 Jan 2005 21:09:25 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joseph Fannin <jhf@rivenstone.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>,
       William Park <opengeometry@yahoo.ca>, wli@holomorphy.com
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <20050116005930.GA2273@zion.rivenstone.net>
In-Reply-To: <20050116005930.GA2273@zion.rivenstone.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080208040800030208070706"
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CqFPT-0009kT-Qo*osHqlTCk.ag*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080208040800030208070706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Joseph Fannin wrote:
> On Fri, Jan 14, 2005 at 12:23:52AM -0800, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
> 
> 
>>waiting-10s-before-mounting-root-filesystem.patch
>>  retry mounting the root filesystem at boot time
> 
> 
>     With this patch, initrds seem to get 'skipped'.  I think this is
> probably the cause for the reports of problems with RAID too.

This patch should do the job. Replaces the existing 
waiting-10s-before-mounting-root-filesystem.patch in 2.6.11-rc1-mm1.

Daniel

--------------080208040800030208070706
Content-Type: text/x-patch;
 name="waiting-10s-before-mounting-root-filesystem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="waiting-10s-before-mounting-root-filesystem.patch"

Retry up to 20 times if mounting the root device fails.  This fixes booting
from usb-storage devices, which no longer make their partitions immediately
available. Also cleans up the mount_block_root() function.

Based on an earlier patch from William Park <opengeometry@yahoo.ca>

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--- linux-2.6.10/init/do_mounts.c.orig	2005-01-16 19:18:57.000000000 +0000
+++ linux-2.6.10/init/do_mounts.c	2005-01-16 21:04:29.198471440 +0000
@@ -6,6 +6,7 @@
 #include <linux/suspend.h>
 #include <linux/root_dev.h>
 #include <linux/security.h>
+#include <linux/delay.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -261,6 +262,9 @@ static void __init get_fs_names(char *pa
 static int __init do_mount_root(char *name, char *fs, int flags, void *data)
 {
 	int err = sys_mount(name, "/root", fs, flags, data);
+	if (err == -EACCES && (flags | MS_RDONLY) == 0)
+		err = sys_mount(name, "/root", fs, flags | MS_RDONLY, data);
+
 	if (err)
 		return err;
 
@@ -273,38 +277,57 @@ static int __init do_mount_root(char *na
 	return 0;
 }
 
+static int __init mount_root_try_all_fs(char *name, char *fs_names, int flags, void *data)
+{
+	char *p;
+	int err = -EFAULT;
+
+	for (p = fs_names; *p; p += strlen(p)+1) {
+		err = do_mount_root(name, p, flags, root_mount_data);
+		if (err != -EINVAL)
+			break;
+	}
+
+	return err;
+}
+
 void __init mount_block_root(char *name, int flags)
 {
 	char *fs_names = __getname();
-	char *p;
 	char b[BDEVNAME_SIZE];
+	int tryagain = 20;
 
 	get_fs_names(fs_names);
-retry:
-	for (p = fs_names; *p; p += strlen(p)+1) {
-		int err = do_mount_root(name, p, flags, root_mount_data);
-		switch (err) {
-			case 0:
-				goto out;
-			case -EACCES:
-				flags |= MS_RDONLY;
-				goto retry;
-			case -EINVAL:
-				continue;
+
+	while (1) {
+		int err = mount_root_try_all_fs(name, fs_names, flags, root_mount_data);
+		if (err == 0)
+			break;
+
+		/*
+		 * The root device may not be ready yet, so we retry a number of times
+		 */
+		if (--tryagain) {
+			printk(KERN_WARNING "VFS: Waiting %dsec for root device...\n",
+			       tryagain);
+			ssleep(1);
+			if (!ROOT_DEV) {
+				ROOT_DEV = name_to_dev_t(saved_root_name);
+				create_dev(name, ROOT_DEV, root_device_name);
+			}
+			continue;
 		}
-	        /*
+
+		/*
 		 * Allow the user to distinguish between failed sys_open
 		 * and bad superblock on root device.
 		 */
 		__bdevname(ROOT_DEV, b);
-		printk("VFS: Cannot open root device \"%s\" or %s\n",
-				root_device_name, b);
-		printk("Please append a correct \"root=\" boot option\n");
-
+		printk(KERN_CRIT "VFS: Cannot open root device \"%s\" or %s\n",
+		       root_device_name, b);
+		printk(KERN_CRIT "Please append a correct \"root=\" boot option\n");
 		panic("VFS: Unable to mount root fs on %s", b);
 	}
-	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
-out:
 	putname(fs_names);
 }
  

--------------080208040800030208070706--
