Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946098AbWKAF0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946098AbWKAF0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946097AbWKAF0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:26:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63146 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946098AbWKAF0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:26:09 -0500
Date: Tue, 31 Oct 2006 21:25:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Greg KH <gregkh@suse.de>, "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-Id: <20061031212508.1b116655.akpm@osdl.org>
In-Reply-To: <1162356198.6105.18.camel@Homer.simpson.net>
References: <45461977.3020201@shadowen.org>
	<45461E74.1040408@google.com>
	<20061030084722.ea834a08.akpm@osdl.org>
	<454631C1.5010003@google.com>
	<45463481.80601@shadowen.org>
	<20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
	<1162276206.5959.9.camel@Homer.simpson.net>
	<4546EF3B.1090503@google.com>
	<20061031065912.GA13465@suse.de>
	<1162278594.6416.4.camel@Homer.simpson.net>
	<20061031072241.GB7306@suse.de>
	<1162312126.5918.12.camel@Homer.simpson.net>
	<1162318477.6016.3.camel@Homer.simpson.net>
	<1162356198.6105.18.camel@Homer.simpson.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2006 05:43:18 +0100
Mike Galbraith <efault@gmx.de> wrote:

> On Tue, 2006-10-31 at 19:14 +0100, Mike Galbraith wrote:
> 
> > Seems it's driver-core-fixes-sysfs_create_link-retval-checks-in.patch
> > 
> > Tomorrow, I'll revert that alone from 2.6.19-rc3-mm1 to confirm...
> 
> Confirmed.  Boots fine with that patch reverted.

Could you test with something like this applied?

diff -puN drivers/base/core.c~driver-core-fixes-sysfs_create_link-retval-checks-in-debug drivers/base/core.c
--- a/drivers/base/core.c~driver-core-fixes-sysfs_create_link-retval-checks-in-debug
+++ a/drivers/base/core.c
@@ -24,6 +24,8 @@
 #include "base.h"
 #include "power/power.h"
 
+#define DB() printk(KERN_ERR "sysfs failure at %s:%d\n", __FILE__, __LINE__)
+
 int (*platform_notify)(struct device * dev) = NULL;
 int (*platform_notify_remove)(struct device * dev) = NULL;
 
@@ -373,30 +375,39 @@ static int device_add_class_symlinks(str
 		return 0;
 	error = sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
 				  "subsystem");
-	if (error)
+	if (error) {
+		DB();
 		goto out;
+	}
 	error = sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
 				  dev->bus_id);
-	if (error)
+	if (error) {
+		DB();
 		goto out_subsys;
+	}
 #ifdef CONFIG_SYSFS_DEPRECATED
 	if (dev->parent) {
 		char *class_name;
 
 		error = sysfs_create_link(&dev->kobj, &dev->parent->kobj,
 					  "device");
-		if (error)
+		if (error) {
+			DB();
 			goto out_busid;
+		}
 		class_name = make_class_name(dev->class->name, &dev->kobj);
 		if (!class_name) {
+			DB();
 			error = -ENOMEM;
 			goto out_busid;
 		}
 		error = sysfs_create_link(&dev->parent->kobj, &dev->kobj,
 					  class_name);
 		kfree(class_name);
-		if (error)
+		if (error) {
+			DB();
 			goto out_device;
+		}
 	}
 #endif
 	return 0;
@@ -574,8 +585,10 @@ int device_add(struct device *dev)
 		dev->devt_attr = attr;
 	}
 
-	if ((error = device_add_class_symlinks(dev)))
+	if ((error = device_add_class_symlinks(dev))) {
+		DB();
 		goto SymlinkError;
+	}
 	if ((error = device_add_attrs(dev)))
 		goto AttrsError;
 	if ((error = device_add_groups(dev)))
@@ -941,6 +954,7 @@ int device_rename(struct device *dev, ch
 
 	error = kobject_rename(&dev->kobj, new_name);
 	if (error) {
+		DB();
 		strlcpy(dev->bus_id, old_device_name, BUS_ID_SIZE);
 		goto out;
 	}
@@ -951,8 +965,10 @@ int device_rename(struct device *dev, ch
 		if (new_class_name) {
 			error = sysfs_create_link(&dev->parent->kobj,
 						  &dev->kobj, new_class_name);
-			if (error)
+			if (error) {
+				DB();
 				goto out;
+			}
 			sysfs_remove_link(&dev->parent->kobj, old_class_name);
 		}
 	}
_

> I'm getting a slew of....
> BUG: atomic counter underflow at:
>  [<c0104282>] dump_trace+0x1b7/0x1e6
>  [<c01042cb>] show_trace_log_lvl+0x1a/0x30
>  [<c010495f>] show_trace+0x12/0x14
>  [<c01049e6>] dump_stack+0x16/0x18
>  [<c01b5262>] sysfs_d_iput+0x68/0x96
>  [<c01860de>] dentry_iput+0x5d/0xb1
>  [<c0186f25>] dput+0xd2/0x133
>  [<c01b4f45>] sysfs_remove_dir+0xd2/0x120
>  [<c02d59e4>] kobject_del+0xb/0x15
>  [<c03612f1>] device_del+0x199/0x1b0
>  [<c0361313>] device_unregister+0xb/0x15
>  [<c03613a2>] device_destroy+0x85/0x8e
>  [<c033e827>] vcs_remove_sysfs+0x1c/0x38
>  [<c034414d>] con_close+0x5e/0x6b
>  [<c0336bca>] release_dev+0x13d/0x65b
>  [<c03370fa>] tty_release+0x12/0x1c
>  [<c0176bad>] __fput+0xab/0x1d8
>  [<c0176dd8>] fput+0x22/0x3b
>  [<c0174314>] filp_close+0x41/0x67
>  [<c01753e8>] sys_close+0x6e/0xb6
>  [<c010317c>] syscall_call+0x7/0xb
>  [<0805cdc7>] 0x805cdc7
>  =======================
> ...with 2.6.19-rc3-mm1 with the patch reverted, which I did not get with
> the patched up 2.6.19-rc3, but it does boot and run without exploding.

Hopefully that's due to the cherry-unpicking of this patch..

