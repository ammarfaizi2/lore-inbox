Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTKXX3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbTKXX3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:29:54 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:35589 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261606AbTKXX3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:29:17 -0500
Subject: final SCSI updates (hopefully) for 2.6.0
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-rYpRFca0cAdXZOMqDAnj"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Nov 2003 17:29:04 -0600
Message-Id: <1069716546.2870.69.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rYpRFca0cAdXZOMqDAnj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This should be the final set of refcounting and bugfix updates.  It
contains the two refcounting fixes I identified earlier (now fully
tested) and a bugfix for the aic7xxx/aic79xx drivers which was caused by
one of the previous refcounting changes.

The patch is here

bk://linux-scsi.bkbits.net/scsi-bugfixes-2.6

The short changelog is

James Bottomley:
  o Fix locking problems in scsi_report_bus_reset() causing aic7xxx to
hang ChangeSet@1.1484
  o Updated state model for SCSI devices ChangeSet@1.1483

Mike Anderson:
  o scsi device ref count (update) ChangeSet@1.1482

And the diffstat is

 drivers/scsi/scsi.c        |   14 ++++++++-
 drivers/scsi/scsi_error.c  |   12 +++++---
 drivers/scsi/scsi_lib.c    |   36 ++++++++++++++++++++++++-
 drivers/scsi/scsi_priv.h   |    4 +-
 drivers/scsi/scsi_scan.c   |   64
+++++++++++++++++++++------------------------
 drivers/scsi/scsi_sysfs.c  |   63
+++++++++++++++++++++++++-------------------
 include/scsi/scsi_device.h |   16 +++++++----
 7 files changed, 133 insertions(+), 76 deletions(-)

The patches that comprise this are attached

James



--=-rYpRFca0cAdXZOMqDAnj
Content-Disposition: attachment; filename=tmp.1.1482
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.1.1482; charset=ISO-8859-1

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
--- a/drivers/scsi/scsi_priv.h	Mon Nov 24 17:27:14 2003
+++ b/drivers/scsi/scsi_priv.h	Mon Nov 24 17:27:14 2003
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
--- a/drivers/scsi/scsi_scan.c	Mon Nov 24 17:27:14 2003
+++ b/drivers/scsi/scsi_scan.c	Mon Nov 24 17:27:14 2003
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
--- a/drivers/scsi/scsi_sysfs.c	Mon Nov 24 17:27:14 2003
+++ b/drivers/scsi/scsi_sysfs.c	Mon Nov 24 17:27:14 2003
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

--=-rYpRFca0cAdXZOMqDAnj
Content-Disposition: attachment; filename=tmp.1.1483
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.1.1483; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.1482  -> 1.1483=20
#	include/scsi/scsi_device.h	1.10    -> 1.11  =20
#	drivers/scsi/scsi_sysfs.c	1.37    -> 1.38  =20
#	drivers/scsi/scsi_lib.c	1.114   -> 1.115 =20
#	 drivers/scsi/scsi.c	1.130   -> 1.131 =20
#	drivers/scsi/scsi_scan.c	1.113   -> 1.114 =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/22	jejb@raven.il.steeleye.com	1.1483
# Updated state model for SCSI devices
#=20
# I've been looking at enforcing lifetime phases for SCSI devices
# (primarily to try to get the mid layer to offload as much of the device
# creation and hotplug pieces as it can).
#=20
# I've hijacked the sdev_state field of the struct scsi_device (formerly
# this was a bitmap, now it becomes an enumerated state).
#=20
# I've also begun adding references sdev_gendev into the code to pin the
# scsi_device---initially in the queue function, but possibly this should
# also be done in the scsi_command_get/put, the idea being to prevent
# scsi_device freeing while there's still device activity.
#=20
# The object phases I identified are:
#=20
# 1. SDEV_CREATED - we've just allocated the device.  It may respond to
# internally generated commands, but not to user ones (the user should
# actually have no way to access a device in this state, but just in
# case).
#=20
# 2. SDEV_RUNNING - the device is fully operational
#=20
# 3. SDEV_CANCEL - The device is cleanly shutting down.  It may respond to
# internally generated commands (for cancellation/recovery) only; all user
# commands are errored unless they have already been queued (QUEUE_FULL
# handling and the like).
#=20
# 4. SDEV_DEL - The device is gone. *all* commands are errored out.
#=20
# Ordinarily, the device should move through all four phases from creation
# to destruction, but moving SDEV_RUNNING->SDEV_DEL because of surprise
# ejection should work.
#=20
# It's starting to look like the online flag should be absorbed into this
# (offlined devices move essentially to SDEV_CANCEL and could be
# reactivated by moving to SDEV_RUNNING).
#=20
# I haven't altered the similar bitmap model that scsi_host has, although
# this too should probably move to an enumerated state model.
#=20
# I've tested this by physically yanking a module out from underneath a
# running filesystem with no ill effects (other than a slew of I/O
# errors).
#=20
# The obvious problem is that this kills possible user error handling, but
# we don't do any of that yet.
# --------------------------------------------
#
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Mon Nov 24 17:27:26 2003
+++ b/drivers/scsi/scsi.c	Mon Nov 24 17:27:26 2003
@@ -367,6 +367,16 @@
 	unsigned long timeout;
 	int rtn =3D 0;
=20
+	/* check if the device is still usable */
+	if (unlikely(cmd->device->sdev_state =3D=3D SDEV_DEL)) {
+		/* in SDEV_DEL we error all commands. DID_NO_CONNECT
+		 * returns an immediate error upwards, and signals
+		 * that the device is no longer present */
+		cmd->result =3D DID_NO_CONNECT << 16;
+		scsi_done(cmd);
+		/* return 0 (because the command has been processed) */
+		goto out;
+	}
 	/* Assign a unique nonzero serial_number. */
 	/* XXX(hch): this is racy */
 	if (++serial_number =3D=3D 0)
@@ -893,7 +903,7 @@
  */
 int scsi_device_get(struct scsi_device *sdev)
 {
-	if (test_bit(SDEV_DEL, &sdev->sdev_state))
+	if (sdev->sdev_state =3D=3D SDEV_DEL)
 		return -ENXIO;
 	if (!get_device(&sdev->sdev_gendev))
 		return -ENXIO;
@@ -1015,7 +1025,7 @@
 	struct list_head *lh, *lh_sf;
 	unsigned long flags;
=20
-	set_bit(SDEV_CANCEL, &sdev->sdev_state);
+	sdev->sdev_state =3D SDEV_CANCEL;
=20
 	spin_lock_irqsave(&sdev->list_lock, flags);
 	list_for_each_entry(scmd, &sdev->cmd_list, list) {
diff -Nru a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	Mon Nov 24 17:27:26 2003
+++ b/drivers/scsi/scsi_lib.c	Mon Nov 24 17:27:26 2003
@@ -923,6 +923,22 @@
 {
 	struct scsi_device *sdev =3D q->queuedata;
 	struct scsi_cmnd *cmd;
+	int specials_only =3D 0;
+
+	if(unlikely(sdev->sdev_state !=3D SDEV_RUNNING)) {
+		/* OK, we're not in a running state don't prep
+		 * user commands */
+		if(sdev->sdev_state =3D=3D SDEV_DEL) {
+			/* Device is fully deleted, no commands
+			 * at all allowed down */
+			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to dead device\n",
+			       sdev->host->host_no, sdev->id, sdev->lun);
+			return BLKPREP_KILL;
+		}
+		/* OK, we only allow special commands (i.e. not
+		 * user initiated ones */
+		specials_only =3D 1;
+	}
=20
 	/*
 	 * Find the actual device driver associated with this command.
@@ -945,6 +961,14 @@
 		} else
 			cmd =3D req->special;
 	} else if (req->flags & (REQ_CMD | REQ_BLOCK_PC)) {
+
+		if(unlikely(specials_only)) {
+			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to device being removed\=
n",
+			       sdev->host->host_no, sdev->id, sdev->lun);
+			return BLKPREP_KILL;
+		}
+		=09
+		=09
 		/*
 		 * Just check to see if the device is online.  If
 		 * it isn't, we refuse to process ordinary commands
@@ -1127,6 +1151,10 @@
 	struct scsi_cmnd *cmd;
 	struct request *req;
=20
+	if(!get_device(&sdev->sdev_gendev))
+		/* We must be tearing the block queue down already */
+		return;
+
 	/*
 	 * To start with, we keep looping until the queue is empty, or until
 	 * the host is no longer able to accept any more requests.
@@ -1199,7 +1227,7 @@
 		}
 	}
=20
-	return;
+	goto out;
=20
  not_ready:
 	spin_unlock_irq(shost->host_lock);
@@ -1217,6 +1245,12 @@
 	sdev->device_busy--;
 	if(sdev->device_busy =3D=3D 0)
 		blk_plug_device(q);
+ out:
+	/* must be careful here...if we trigger the ->remove() function
+	 * we cannot be holding the q lock */
+	spin_unlock_irq(q->queue_lock);
+	put_device(&sdev->sdev_gendev);
+	spin_lock_irq(q->queue_lock);
 }
=20
 u64 scsi_calculate_bounce_limit(struct Scsi_Host *shost)
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Mon Nov 24 17:27:26 2003
+++ b/drivers/scsi/scsi_scan.c	Mon Nov 24 17:27:26 2003
@@ -205,6 +205,7 @@
 	sdev->lun =3D lun;
 	sdev->channel =3D channel;
 	sdev->online =3D TRUE;
+	sdev->sdev_state =3D SDEV_CREATED;
 	INIT_LIST_HEAD(&sdev->siblings);
 	INIT_LIST_HEAD(&sdev->same_target_siblings);
 	INIT_LIST_HEAD(&sdev->cmd_list);
diff -Nru a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c	Mon Nov 24 17:27:26 2003
+++ b/drivers/scsi/scsi_sysfs.c	Mon Nov 24 17:27:26 2003
@@ -346,9 +346,11 @@
 {
 	int error =3D -EINVAL, i;
=20
-	if (test_and_set_bit(SDEV_ADD, &sdev->sdev_state))
+	if (sdev->sdev_state !=3D SDEV_CREATED)
 		return error;
=20
+	sdev->sdev_state =3D SDEV_RUNNING;
+
 	error =3D device_add(&sdev->sdev_gendev);
 	if (error) {
 		printk(KERN_INFO "error 1\n");
@@ -386,8 +388,11 @@
 	return error;
=20
 clean_device:
+	sdev->sdev_state =3D SDEV_CANCEL;
+
 	device_del(&sdev->sdev_gendev);
 	put_device(&sdev->sdev_gendev);
+
 	return error;
=20
 }
@@ -398,8 +403,8 @@
  **/
 void scsi_remove_device(struct scsi_device *sdev)
 {
-	if (test_and_clear_bit(SDEV_ADD, &sdev->sdev_state)) {
-		set_bit(SDEV_DEL, &sdev->sdev_state);
+	if (sdev->sdev_state =3D=3D SDEV_RUNNING || sdev->sdev_state =3D=3D SDEV_=
CANCEL) {
+		sdev->sdev_state =3D SDEV_DEL;
 		class_device_unregister(&sdev->sdev_classdev);
 		device_del(&sdev->sdev_gendev);
 		if (sdev->host->hostt->slave_destroy)
diff -Nru a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
--- a/include/scsi/scsi_device.h	Mon Nov 24 17:27:26 2003
+++ b/include/scsi/scsi_device.h	Mon Nov 24 17:27:26 2003
@@ -14,11 +14,15 @@
 /*
  * sdev state
  */
-enum {
-	SDEV_ADD,
-	SDEV_DEL,
-	SDEV_CANCEL,
-	SDEV_RECOVERY,
+enum scsi_device_state {
+	SDEV_CREATED,		/* device created but not added to sysfs
+				 * Only internal commands allowed (for inq) */
+	SDEV_RUNNING,		/* device properly configured
+				 * All commands allowed */
+	SDEV_CANCEL,		/* beginning to delete device
+				 * Only error handler commands allowed */
+	SDEV_DEL,		/* device deleted=20
+				 * no commands allowed */
 };
=20
 struct scsi_device {
@@ -99,7 +103,7 @@
 	struct device		sdev_gendev;
 	struct class_device	sdev_classdev;
=20
-	unsigned long sdev_state;
+	enum scsi_device_state sdev_state;
 };
 #define	to_scsi_device(d)	\
 	container_of(d, struct scsi_device, sdev_gendev)

--=-rYpRFca0cAdXZOMqDAnj
Content-Disposition: attachment; filename=tmp.1.1484
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.1.1484; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.1483  -> 1.1484=20
#	drivers/scsi/scsi_error.c	1.65    -> 1.66  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/24	jejb@raven.il.steeleye.com	1.1484
# Fix locking problems in scsi_report_bus_reset() causing aic7xxx to hang
#=20
# All the users of this function in the SCSI tree call it with the host
# lock held.  With the new list traversal code, it was trying to take
# the lock again to traverse the list.
#=20
# Fix it to use the unlocked version of list traversal and modify the
# header comments to make it clear that the lock is expected to be held
# on calling it.
# --------------------------------------------
#
diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Mon Nov 24 17:27:38 2003
+++ b/drivers/scsi/scsi_error.c	Mon Nov 24 17:27:38 2003
@@ -911,7 +911,9 @@
=20
 	if (rtn =3D=3D SUCCESS) {
 		scsi_sleep(BUS_RESET_SETTLE_TIME);
+		spin_lock_irqsave(scmd->device->host->host_lock, flags);
 		scsi_report_bus_reset(scmd->device->host, scmd->device->channel);
+		spin_unlock_irqrestore(scmd->device->host->host_lock, flags);
 	}
=20
 	return rtn;
@@ -940,7 +942,9 @@
=20
 	if (rtn =3D=3D SUCCESS) {
 		scsi_sleep(HOST_RESET_SETTLE_TIME);
+		spin_lock_irqsave(scmd->device->host->host_lock, flags);
 		scsi_report_bus_reset(scmd->device->host, scmd->device->channel);
+		spin_unlock_irqrestore(scmd->device->host->host_lock, flags);
 	}
=20
 	return rtn;
@@ -1608,7 +1612,7 @@
  *
  * Returns:     Nothing
  *
- * Lock status: No locks are assumed held.
+ * Lock status: Host lock must be held.
  *
  * Notes:       This only needs to be called if the reset is one which
  *		originates from an unknown location.  Resets originated
@@ -1622,7 +1626,7 @@
 {
 	struct scsi_device *sdev;
=20
-	shost_for_each_device(sdev, shost) {
+	__shost_for_each_device(sdev, shost) {
 		if (channel =3D=3D sdev->channel) {
 			sdev->was_reset =3D 1;
 			sdev->expecting_cc_ua =3D 1;
@@ -1642,7 +1646,7 @@
  *
  * Returns:     Nothing
  *
- * Lock status: No locks are assumed held.
+ * Lock status: Host lock must be held
  *
  * Notes:       This only needs to be called if the reset is one which
  *		originates from an unknown location.  Resets originated
@@ -1656,7 +1660,7 @@
 {
 	struct scsi_device *sdev;
=20
-	shost_for_each_device(sdev, shost) {
+	__shost_for_each_device(sdev, shost) {
 		if (channel =3D=3D sdev->channel &&
 		    target =3D=3D sdev->id) {
 			sdev->was_reset =3D 1;

--=-rYpRFca0cAdXZOMqDAnj--

