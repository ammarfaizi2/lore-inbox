Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbUDGLg1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 07:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUDGLg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 07:36:27 -0400
Received: from pop.gmx.de ([213.165.64.20]:9436 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263081AbUDGLfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 07:35:25 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm2 build problem
Date: Wed, 7 Apr 2004 13:38:32 +0200
User-Agent: KMail/1.6.1
References: <20040407103746.GF20293@charite.de>
In-Reply-To: <20040407103746.GF20293@charite.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404071338.32897.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

take a look at the main 2.6.5-mm2 thread. here is a copy of the message:

----------  Forwarded Message  ----------

Subject: Re: 2.6.5-mm2
Date: Wednesday 07 April 2004 09:10
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org, James Bottomley 
<James.Bottomley@steeleye.com>

Brice Goglin <Brice.Goglin@ens-lyon.fr> wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5
> >-mm2/
> >
>  > - Merged up Ian Kent's autofs4 patches
>  >
>  > - Various fixes and speedups.
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


 25-akpm/drivers/scsi/sr.c |   68
 ++++++---------------------------------------- 1 files changed, 10
 insertions(+), 58 deletions(-)

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

 static int sr_block_ioctl(struct inode *inode, struct file *file, unsigned
 cmd, @@ -496,7 +467,7 @@ static int sr_open(struct cdrom_device_i
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


On Wednesday 07 April 2004 12:37, Ralf Hildebrandt wrote:
> 2.6.5-mm1 builds OK, 2.6.5-mm2 does not:
>
>   CC [M]  drivers/scsi/scsicam.o
>   CC [M]  drivers/scsi/scsi_error.o
>   CC [M]  drivers/scsi/scsi_lib.o
>   CC [M]  drivers/scsi/scsi_scan.o
>   CC [M]  drivers/scsi/scsi_syms.o
>   CC [M]  drivers/scsi/scsi_sysfs.o
>   CC [M]  drivers/scsi/scsi_devinfo.o
>   CC [M]  drivers/scsi/scsi_sysctl.o
>   CC [M]  drivers/scsi/scsi_proc.o
>   CC [M]  drivers/scsi/sd.o
>   CC [M]  drivers/scsi/sr.o
> drivers/scsi/sr.c: In function scsi_cd_get':
> drivers/scsi/sr.c:128: error: structure has no member named kobj'
> drivers/scsi/sr.c: In function scsi_cd_put':
> drivers/scsi/sr.c:135: error: structure has no member named kobj'
> drivers/scsi/sr.c: In function sr_probe':
> drivers/scsi/sr.c:554: error: structure has no member named kobj'
> drivers/scsi/sr.c:555: error: structure has no member named kobj'
> drivers/scsi/sr.c: In function sr_kobject_release':
> drivers/scsi/sr.c:904: error: structure has no member named kobj'
> drivers/scsi/sr.c:904: warning: type defaults to int' in declaration of
> __mptr' drivers/scsi/sr.c:904: warning: initialization from incompatible
> pointer type drivers/scsi/sr.c:904: error: structure has no member named
> kobj'
> make[3]: *** [drivers/scsi/sr.o] Error 1
> make[2]: *** [drivers/scsi] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory /usr/src/linux-2.6.5-mm2'
> make: *** [stamp-build] Error 2
>
> My .config is here:
> http://www.stahl.bau.tu-bs.de/~hildeb/satellitepro/kernel-config-2.6
