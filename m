Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbUDGHLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 03:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264122AbUDGHLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 03:11:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:53699 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264120AbUDGHKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 03:10:17 -0400
Date: Wed, 7 Apr 2004 00:10:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: 2.6.5-mm2
Message-Id: <20040407001004.0360a049.akpm@osdl.org>
In-Reply-To: <20040407065154.GG1139@ens-lyon.fr>
References: <20040406223321.704682ed.akpm@osdl.org>
	<20040407065154.GG1139@ens-lyon.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.fr> wrote:
>
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm2/
>  > 
>  > 
>  > - Merged up Ian Kent's autofs4 patches
>  > 
>  > - Various fixes and speedups.
> 
> 
>  Hi Andrew,
> 
>  When building on my Compaq EvoN600c, I get this compile error :
> 
>  CC [M]  drivers/scsi/sr.o
>  	    drivers/scsi/sr.c: In function scsi_cd_get':
>  	    drivers/scsi/sr.c:128: error: structure has no member named kobj'

It looks like Mr SCSI forgot to commit his changes to sr.h.

Here's a backout patch which should get you going again.


 25-akpm/drivers/scsi/sr.c |   68 ++++++----------------------------------------
 1 files changed, 10 insertions(+), 58 deletions(-)

diff -puN drivers/scsi/sr.c~sr-build-fix drivers/scsi/sr.c
--- 25/drivers/scsi/sr.c~sr-build-fix	2004-04-07 00:07:47.559098560 -0700
+++ 25-akpm/drivers/scsi/sr.c	2004-04-07 00:08:02.302857168 -0700
@@ -113,28 +113,6 @@ static struct cdrom_device_ops sr_dops =
 	.generic_packet		= sr_packet,
 };
 
-static void sr_kobject_release(struct kobject *kobj);
-
-static struct kobj_type scsi_cdrom_kobj_type = {
-	.release = sr_kobject_release,
-};
-
-/*
- * The get and put routines for the struct scsi_cd.  Note this entity
- * has a scsi_device pointer and owns a reference to this.
- */
-static inline int scsi_cd_get(struct scsi_cd *cd)
-{
-	if (!kobject_get(&cd->kobj))
-		return -ENODEV;
-	return 0;
-}
-
-static inline void scsi_cd_put(struct scsi_cd *cd)
-{
-	kobject_put(&cd->kobj);
-}
-
 /*
  * This function checks to see if the media has been changed in the
  * CDROM drive.  It is possible that we have already sensed a change,
@@ -446,15 +424,8 @@ static int sr_block_open(struct inode *i
 
 static int sr_block_release(struct inode *inode, struct file *file)
 {
-	int ret;
 	struct scsi_cd *cd = scsi_cd(inode->i_bdev->bd_disk);
-	ret = cdrom_release(&cd->cdi, file);
-	if(ret)
-		return ret;
-	
-	scsi_cd_put(cd);
-
-	return 0;
+	return cdrom_release(&cd->cdi, file);
 }
 
 static int sr_block_ioctl(struct inode *inode, struct file *file, unsigned cmd,
@@ -496,7 +467,7 @@ static int sr_open(struct cdrom_device_i
 	struct scsi_device *sdev = cd->device;
 	int retval;
 
-	retval = scsi_cd_get(cd);
+	retval = scsi_device_get(sdev);
 	if (retval)
 		return retval;
 	
@@ -518,7 +489,7 @@ static int sr_open(struct cdrom_device_i
 	return 0;
 
 error_out:
-	scsi_cd_put(cd);
+	scsi_device_put(sdev);
 	return retval;	
 }
 
@@ -529,6 +500,7 @@ static void sr_release(struct cdrom_devi
 	if (cd->device->sector_size > 2048)
 		sr_set_blocklength(cd, 2048);
 
+	scsi_device_put(cd->device);
 }
 
 static int sr_probe(struct device *dev)
@@ -542,18 +514,12 @@ static int sr_probe(struct device *dev)
 	if (sdev->type != TYPE_ROM && sdev->type != TYPE_WORM)
 		goto fail;
 
-	if ((error = scsi_device_get(sdev)) != 0)
-		goto fail;
-
 	error = -ENOMEM;
 	cd = kmalloc(sizeof(*cd), GFP_KERNEL);
 	if (!cd)
-		goto fail_put_sdev;
+		goto fail;
 	memset(cd, 0, sizeof(*cd));
 
-	kobject_init(&cd->kobj);
-	cd->kobj.ktype = &scsi_cdrom_kobj_type;
-
 	disk = alloc_disk(1);
 	if (!disk)
 		goto fail_free;
@@ -622,8 +588,6 @@ fail_put:
 	put_disk(disk);
 fail_free:
 	kfree(cd);
-fail_put_sdev:
-	scsi_device_put(sdev);
 fail:
 	return error;
 }
@@ -899,32 +863,20 @@ static int sr_packet(struct cdrom_device
 	return cgc->stat;
 }
 
-static void sr_kobject_release(struct kobject *kobj)
+static int sr_remove(struct device *dev)
 {
-	struct scsi_cd *cd = container_of(kobj, struct scsi_cd, kobj);
-	struct scsi_device *sdev = cd->device;
+	struct scsi_cd *cd = dev_get_drvdata(dev);
+
+	del_gendisk(cd->disk);
 
 	spin_lock(&sr_index_lock);
 	clear_bit(cd->disk->first_minor, sr_index_bits);
 	spin_unlock(&sr_index_lock);
 
-	unregister_cdrom(&cd->cdi);
-
 	put_disk(cd->disk);
-
+	unregister_cdrom(&cd->cdi);
 	kfree(cd);
 
-	scsi_device_put(sdev);
-}
-
-static int sr_remove(struct device *dev)
-{
-	struct scsi_cd *cd = dev_get_drvdata(dev);
-
-	del_gendisk(cd->disk);
-
-	scsi_cd_put(cd);
-
 	return 0;
 }
 

_

