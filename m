Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTKWATF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 19:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTKWAS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 19:18:59 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:41733 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262174AbTKWASm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 19:18:42 -0500
Subject: Re: 2.6.0-test9-bk26 fails boot -- aic7890 detection
From: James Bottomley <James.Bottomley@steeleye.com>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <200311222109.QAA10536@clem.clem-digital.net>
References: <200311222109.QAA10536@clem.clem-digital.net>
Content-Type: multipart/mixed; boundary="=-cYAq1iEJSesq6S2LO+6h"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 22 Nov 2003 18:18:07 -0600
Message-Id: <1069546688.2667.11.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cYAq1iEJSesq6S2LO+6h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-11-22 at 15:09, Pete Clements wrote:
> Quoting James Bottomley
>   > On Sat, 2003-11-22 at 09:09, Pete Clements wrote:
>   > > 2.6.0-test9-bk26 boot hangs after ide detection. Next detect normally
>   > > scsi AIC7XXX.  Has been good for all prior test9-bk's.
>   > 
>   > I'm assuming bk26 contains the latest set of SCSI diffs (they were
>   > merged on 21 Nov around 14:00 PST)?
>   > 
>   > I've never successfully managed to get the aic7xxx driver to work on my
>   > parisc platform.  However, both with and without the latest SCSI diffs
>   > the behaviour seems the same (it does print out the driver banner before
>   > failing to connect to the drives).  I take it you aren't seeing this
>   > banner?
> 
> Correct, no banner and bk26 has a scsi_scan change.

Hmm, I can't reproduce this.  However, when I alter the aic7xxx driver
actually to work on my 2944W card, I do see a kobject badness error
(although it still boots up for me).

Could you try this patch (from Mike Anderson).  It makes the kobject
badness go away for me, and so may fix your problem.  If it doesn't,
I'll have to defer to people who have aic cards and x86 hardware.

James


--=-cYAq1iEJSesq6S2LO+6h
Content-Disposition: attachment; filename=aic.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=aic.diff; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.1481  -> 1.1482=20
#	drivers/scsi/scsi_sysfs.c	1.36    -> 1.37  =20
#	drivers/scsi/scsi_priv.h	1.28    -> 1.29  =20
#	drivers/scsi/scsi_scan.c	1.112   -> 1.113 =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/22	andmike@us.ibm.com	1.1482
# [PATCH] scsi device ref count (update)
#=20
# This patch is against scsi-bugfixes-2.6. I updated it based on comments
# received. It breaks up the reference count initialization for scsi_device
# and restores calling slave_destroy for all scsi_devices configured or
# not. I ran a small regression using the scsi_debug, aic7xxx, and qla2xxx
# driver. I also had a debug patch for more verbose kobject cleanup and
# patch for a badness check on atomic_dec going negative (previously
# provided by Linus).
#=20
# The object cleanup appears to being functioning correctly. I only saw
# previously reported badness output:
# 	- Synchronizing SCSI cache fails on cleanup.
# 	- scsi_debug.c missing release (I believe Doug posted a patch)
# 	- aic7xxx warnings on rmmod due to ahc_platform_free calling
# 	  scsi_remove_host with ahc_list_lock held.
#=20
#=20
# This patch splits the scsi device struct device register into init and
# add. It also addresses memory leak issues of not calling slave_destroy
# on scsi_devices that are not configured in.
#=20
# Details:
# * Make scsi_device_dev_release extern for scsi_scan to use in
# alloc_sdev.
# * Move scsi_free_sdev code to scsi_device_dev_release. Have
# previous callers of scsi_free_sdev call slave_destroy plus put_device.
# * Changed name of scsi_device_register to scsi_sysfs_add_sdev to
# match host call and align with split struct device init.
# * Move sdev_gendev device and class init to scsi_alloc_sdev.
#=20
# Thu Nov 20 22:56:11 PST 2003
#=20
#  drivers/scsi/scsi_priv.h  |    4 +-
#  drivers/scsi/scsi_scan.c  |   63 +++++++++++++++++++++------------------=
-------
#  drivers/scsi/scsi_sysfs.c |   58 ++++++++++++++++++++++-----------------=
---
#  3 files changed, 62 insertions(+), 63 deletions(-)
# --------------------------------------------
#
diff -Nru a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
--- a/drivers/scsi/scsi_priv.h	Sat Nov 22 18:17:32 2003
+++ b/drivers/scsi/scsi_priv.h	Sat Nov 22 18:17:32 2003
@@ -130,7 +130,6 @@
 extern int scsi_scan_host_selected(struct Scsi_Host *, unsigned int,
 				   unsigned int, unsigned int, int);
 extern void scsi_forget_host(struct Scsi_Host *);
-extern void scsi_free_sdev(struct scsi_device *);
 extern void scsi_rescan_device(struct device *);
=20
 /* scsi_sysctl.c */
@@ -143,7 +142,8 @@
 #endif /* CONFIG_SYSCTL */
=20
 /* scsi_sysfs.c */
-extern int scsi_device_register(struct scsi_device *);
+extern void scsi_device_dev_release(struct device *);
+extern int scsi_sysfs_add_sdev(struct scsi_device *);
 extern int scsi_sysfs_add_host(struct Scsi_Host *);
 extern int scsi_sysfs_register(void);
 extern void scsi_sysfs_unregister(void);
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Sat Nov 22 18:17:32 2003
+++ b/drivers/scsi/scsi_scan.c	Sat Nov 22 18:17:32 2003
@@ -236,6 +236,25 @@
 			goto out_free_queue;
 	}
=20
+	if (get_device(&sdev->host->shost_gendev)) {
+
+		device_initialize(&sdev->sdev_gendev);
+		sdev->sdev_gendev.parent =3D &sdev->host->shost_gendev;
+		sdev->sdev_gendev.bus =3D &scsi_bus_type;
+		sdev->sdev_gendev.release =3D scsi_device_dev_release;
+		sprintf(sdev->sdev_gendev.bus_id,"%d:%d:%d:%d",
+			sdev->host->host_no, sdev->channel, sdev->id,
+			sdev->lun);
+
+		class_device_initialize(&sdev->sdev_classdev);
+		sdev->sdev_classdev.dev =3D &sdev->sdev_gendev;
+		sdev->sdev_classdev.class =3D &sdev_class;
+		snprintf(sdev->sdev_classdev.class_id, BUS_ID_SIZE,
+			 "%d:%d:%d:%d", sdev->host->host_no,
+			 sdev->channel, sdev->id, sdev->lun);
+	} else
+		goto out_free_queue;
+
 	/*
 	 * If there are any same target siblings, add this to the
 	 * sibling list
@@ -273,36 +292,6 @@
 }
=20
 /**
- * scsi_free_sdev - cleanup and free a scsi_device
- * @sdev:	cleanup and free this scsi_device
- *
- * Description:
- *     Undo the actions in scsi_alloc_sdev, including removing @sdev from
- *     the list, and freeing @sdev.
- **/
-void scsi_free_sdev(struct scsi_device *sdev)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(sdev->host->host_lock, flags);
-	list_del(&sdev->siblings);
-	list_del(&sdev->same_target_siblings);
-	spin_unlock_irqrestore(sdev->host->host_lock, flags);
-
-	if (sdev->request_queue)
-		scsi_free_queue(sdev->request_queue);
-
-	spin_lock_irqsave(sdev->host->host_lock, flags);
-	list_del(&sdev->starved_entry);
-	if (sdev->single_lun && --sdev->sdev_target->starget_refcnt =3D=3D 0)
-		kfree(sdev->sdev_target);
-	spin_unlock_irqrestore(sdev->host->host_lock, flags);
-
-	kfree(sdev->inquiry);
-	kfree(sdev);
-}
-
-/**
  * scsi_probe_lun - probe a single LUN using a SCSI INQUIRY
  * @sreq:	used to send the INQUIRY
  * @inq_result:	area to store the INQUIRY result
@@ -642,7 +631,7 @@
 	 * register it and tell the rest of the kernel
 	 * about it.
 	 */
-	scsi_device_register(sdev);
+	scsi_sysfs_add_sdev(sdev);
=20
 	return SCSI_SCAN_LUN_PRESENT;
 }
@@ -748,8 +737,11 @@
 	if (res =3D=3D SCSI_SCAN_LUN_PRESENT) {
 		if (sdevp)
 			*sdevp =3D sdev;
-	} else
-		scsi_free_sdev(sdev);
+	} else {
+		if (sdev->host->hostt->slave_destroy)
+			sdev->host->hostt->slave_destroy(sdev);
+		put_device(&sdev->sdev_gendev);
+	}
  out:
 	return res;
 }
@@ -1301,5 +1293,8 @@
 void scsi_free_host_dev(struct scsi_device *sdev)
 {
 	BUG_ON(sdev->id !=3D sdev->host->this_id);
-	scsi_free_sdev(sdev);
+
+	if (sdev->host->hostt->slave_destroy)
+		sdev->host->hostt->slave_destroy(sdev);
+	put_device(&sdev->sdev_gendev);
 }
diff -Nru a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c	Sat Nov 22 18:17:32 2003
+++ b/drivers/scsi/scsi_sysfs.c	Sat Nov 22 18:17:32 2003
@@ -115,14 +115,29 @@
 	put_device(&sdev->sdev_gendev);
 }
=20
-static void scsi_device_dev_release(struct device *dev)
+void scsi_device_dev_release(struct device *dev)
 {
 	struct scsi_device *sdev;
 	struct device *parent;
+	unsigned long flags;
=20
 	parent =3D dev->parent;
 	sdev =3D to_scsi_device(dev);
-	scsi_free_sdev(sdev);
+
+	spin_lock_irqsave(sdev->host->host_lock, flags);
+	list_del(&sdev->siblings);
+	list_del(&sdev->same_target_siblings);
+	list_del(&sdev->starved_entry);
+	if (sdev->single_lun && --sdev->sdev_target->starget_refcnt =3D=3D 0)
+		kfree(sdev->sdev_target);
+	spin_unlock_irqrestore(sdev->host->host_lock, flags);
+
+	if (sdev->request_queue)
+		scsi_free_queue(sdev->request_queue);
+
+	kfree(sdev->inquiry);
+	kfree(sdev);
+
 	put_device(parent);
 }
=20
@@ -321,29 +336,18 @@
 }
=20
 /**
- * scsi_device_register - register a scsi device with the scsi bus
- * @sdev:	scsi_device to register
+ * scsi_sysfs_add_sdev - add scsi device to sysfs
+ * @sdev:	scsi_device to add
  *
  * Return value:
  * 	0 on Success / non-zero on Failure
  **/
-int scsi_device_register(struct scsi_device *sdev)
+int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 {
-	int error =3D 0, i;
+	int error =3D -EINVAL, i;
=20
-	set_bit(SDEV_ADD, &sdev->sdev_state);
-	device_initialize(&sdev->sdev_gendev);
-	sprintf(sdev->sdev_gendev.bus_id,"%d:%d:%d:%d",
-		sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
-	sdev->sdev_gendev.parent =3D &sdev->host->shost_gendev;
-	sdev->sdev_gendev.bus =3D &scsi_bus_type;
-	sdev->sdev_gendev.release =3D scsi_device_dev_release;
-
-	class_device_initialize(&sdev->sdev_classdev);
-	sdev->sdev_classdev.dev =3D &sdev->sdev_gendev;
-	sdev->sdev_classdev.class =3D &sdev_class;
-	snprintf(sdev->sdev_classdev.class_id, BUS_ID_SIZE, "%d:%d:%d:%d",
-		sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
+	if (test_and_set_bit(SDEV_ADD, &sdev->sdev_state))
+		return error;
=20
 	error =3D device_add(&sdev->sdev_gendev);
 	if (error) {
@@ -351,8 +355,6 @@
 		return error;
 	}
=20
-	get_device(sdev->sdev_gendev.parent);
-
 	error =3D class_device_add(&sdev->sdev_classdev);
 	if (error) {
 		printk(KERN_INFO "error 2\n");
@@ -396,12 +398,14 @@
  **/
 void scsi_remove_device(struct scsi_device *sdev)
 {
-	class_device_unregister(&sdev->sdev_classdev);
-	set_bit(SDEV_DEL, &sdev->sdev_state);
-	if (sdev->host->hostt->slave_destroy)
-		sdev->host->hostt->slave_destroy(sdev);
-	device_del(&sdev->sdev_gendev);
-	put_device(&sdev->sdev_gendev);
+	if (test_and_clear_bit(SDEV_ADD, &sdev->sdev_state)) {
+		set_bit(SDEV_DEL, &sdev->sdev_state);
+		class_device_unregister(&sdev->sdev_classdev);
+		device_del(&sdev->sdev_gendev);
+		if (sdev->host->hostt->slave_destroy)
+			sdev->host->hostt->slave_destroy(sdev);
+		put_device(&sdev->sdev_gendev);
+	}
 }
=20
 int scsi_register_driver(struct device_driver *drv)

--=-cYAq1iEJSesq6S2LO+6h--

