Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269182AbUIYBlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269182AbUIYBlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUIYBlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:41:07 -0400
Received: from codepoet.org ([166.70.99.138]:25835 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S269182AbUIYBi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:38:59 -0400
Date: Fri, 24 Sep 2004 19:38:51 -0600
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.x USB and 1394 hotplug
Message-ID: <20040925013851.GA24773@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been in use locally for quite some time now and
makes working with USB and 1394 mass-storage devices in 2.4.x a
much less painful experience.  When devices are plugged in, they
are automagically connected up to the scsi subsystem without the
need to rescan all scsi busses or echo things into
/proc/scsi/scsi.  When devices are unplugged, they are
automagically removed from the scsi subsystem, instead of hanging
around registered but with no media actually present.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

Signed-off-by: Erik Andersen <andersen@codepoet.org>

--- orig/drivers/usb/storage/usb.c	Fri Sep 17 15:34:38 2004
+++ linux-2.4.27/drivers/usb/storage/usb.c	Fri Sep 17 15:34:38 2004
@@ -744,6 +744,11 @@
 		/* unlock the device pointers */
 		up(&(ss->dev_semaphore));
 
+		/* Try to re-connect ourselves to the SCSI subsystem */
+		if (scsi_add_single_device(ss->host, 0, 0, 0))
+		    printk(KERN_WARNING "Unable to connect USB device to the SCSI subsystem\n");
+		else
+		    printk(KERN_WARNING "USB device connected to the SCSI subsystem\n");
 	} else { 
 		/* New device -- allocate memory and initialize */
 		US_DEBUGP("New GUID " GUID_FORMAT "\n", GUID_ARGS(guid));
@@ -1057,6 +1062,12 @@
 	/* lock access to the device data structure */
 	down(&(ss->dev_semaphore));
 
+	/* Try to un-hook ourselves from the SCSI subsystem */
+	if (scsi_remove_single_device(ss->host, 0, 0, 0))
+	    printk(KERN_WARNING "Unable to disconnect USB device from the SCSI subsystem\n");
+	else
+	    printk(KERN_WARNING "USB device disconnected from the SCSI subsystem\n");
+
 	/* release the IRQ, if we have one */
 	if (ss->irq_urb) {
 		US_DEBUGP("-- releasing irq URB\n");
--- orig/drivers/ieee1394/sbp2.c	Fri Sep 17 15:34:38 2004
+++ linux-2.4.27/drivers/ieee1394/sbp2.c	Fri Sep 17 15:34:38 2004
@@ -231,7 +231,7 @@
  * enable this define to make use of it. This provides better hotplug
  * support. The mentioned patch is not part of the kernel proper though,
  * because it is considered somewhat of a hack. */
-//#define SBP2_USE_SCSI_ADDREM_HACK
+#define SBP2_USE_SCSI_ADDREM_HACK
 
 
 /*
--- orig/drivers/scsi/scsi_syms.c	Fri Sep 17 15:34:38 2004
+++ linux-2.4.27/drivers/scsi/scsi_syms.c	Fri Sep 17 15:34:38 2004
@@ -104,3 +104,9 @@
 extern int scsi_delete_timer(Scsi_Cmnd *);
 EXPORT_SYMBOL(scsi_add_timer);
 EXPORT_SYMBOL(scsi_delete_timer);
+
+/* Support for hot plugging and unplugging devices -- safe for
+ * ieee1394 or USB devices, but probably not for normal SCSI... */
+EXPORT_SYMBOL(scsi_add_single_device);
+EXPORT_SYMBOL(scsi_remove_single_device);
+
--- orig/drivers/scsi/hosts.h	Fri Sep 17 15:34:38 2004
+++ linux-2.4.27/drivers/scsi/hosts.h	Fri Sep 17 15:34:38 2004
@@ -535,6 +535,13 @@
 int scsi_register_device(struct Scsi_Device_Template * sdpnt);
 void scsi_deregister_device(struct Scsi_Device_Template * tpnt);
 
+/* Support for hot plugging and unplugging devices -- safe for
+ * ieee1394 or USB devices, but probably not for normal SCSI... */
+extern int scsi_add_single_device(struct Scsi_Host *shpnt,
+	int channel, int id, int lun);
+extern int scsi_remove_single_device(struct Scsi_Host *shpnt,
+	int channel, int id, int lun);
+
 /* These are used by loadable modules */
 extern int scsi_register_module(int, void *);
 extern int scsi_unregister_module(int, void *);
--- orig/drivers/scsi/scsi.c	Fri Sep 17 15:34:38 2004
+++ linux-2.4.27/drivers/scsi/scsi.c	Fri Sep 17 15:34:38 2004
@@ -1554,6 +1554,156 @@
     }
 }
 
+
+static DECLARE_MUTEX(scsi_host_internals_lock);
+/*
+ * Function:    scsi_add_single_device()
+ *
+ * Purpose:     Support for hotplugging SCSI devices.  This function
+ *              implements the actual functionality for
+ *                  echo "scsi add-single-device 0 1 2 3" >/proc/scsi/scsi
+ *
+ * Arguments:   shpnt   - pointer to the SCSI host structure
+ *              channel - channel of the device to add
+ *              id      - id of the device to add
+ *              lun     - lun of the device to add
+ *
+ * Returns:     0 on success or an error code
+ *
+ * Lock status: None needed.
+ *
+ * Notes:       This feature is probably unsafe for standard SCSI devices,
+ *              but is perfectly normal for things like ieee1394 or USB
+ *              drives since these busses are designed for hotplugging.
+ *              Use at your own risk....
+ */
+int scsi_add_single_device(struct Scsi_Host *shpnt, int channel,
+	int id, int lun)
+{
+	Scsi_Device *scd;
+
+	/* Do a bit of sanity checking */
+	if (shpnt==NULL) {
+		return  -ENXIO;
+	}
+
+	/* We call functions that can sleep, so use a semaphore to
+	 * avoid racing with scsi_remove_single_device().  We probably
+	 * need to also apply this lock to scsi_register*(),
+	 * scsi_unregister*(), sd_open(), sd_release() and anything
+	 * else that might be messing with with the Scsi_Host or other
+	 * fundamental data structures.  */
+	down(&scsi_host_internals_lock);
+
+	/* Check if they asked us to add an already existing device.
+	 * If so, ignore their misguided efforts. */
+	for (scd = shpnt->host_queue; scd; scd = scd->next) {
+		if ((scd->channel == channel && scd->id == id && scd->lun == lun)) {
+			break;
+		}
+	}
+	if (scd) {
+		up(&scsi_host_internals_lock);
+		return -ENOSYS;
+	}
+
+	scan_scsis(shpnt, 1, channel, id, lun);
+	up(&scsi_host_internals_lock);
+	return 0;
+}
+
+/*
+ * Function:    scsi_remove_single_device()
+ *
+ * Purpose:     Support for hot-unplugging SCSI devices.  This function
+ *              implements the actual functionality for
+ *                  echo "scsi remove-single-device 0 1 2 3" >/proc/scsi/scsi
+ *
+ * Arguments:   shpnt   - pointer to the SCSI host structure
+ *              channel - channel of the device to add
+ *              id      - id of the device to add
+ *              lun     - lun of the device to add
+ *
+ * Returns:     0 on success or an error code
+ *
+ * Lock status: None needed.
+ *
+ * Notes:       This feature is probably unsafe for standard SCSI devices,
+ *              but is perfectly normal for things like ieee1394 or USB
+ *              drives since these busses are designed for hotplugging.
+ *              Use at your own risk....
+ */
+int scsi_remove_single_device(struct Scsi_Host *shpnt, int channel,
+	int id, int lun)
+{
+	Scsi_Device *scd;
+	struct Scsi_Device_Template *SDTpnt;
+
+	/* Do a bit of sanity checking */
+	if (shpnt==NULL) {
+		return  -ENODEV;
+	}
+
+	/* We call functions that can sleep, so use a semaphore to
+	 * avoid racing with scsi_add_single_device().  We probably
+	 * need to also apply this lock to scsi_register*(),
+	 * scsi_unregister*(), sd_open(), sd_release() and anything
+	 * else that might be messing with with the Scsi_Host or other
+	 * fundamental data structures.  */
+	down(&scsi_host_internals_lock);
+
+	/* Make sure the specified device is in fact present */
+	for (scd = shpnt->host_queue; scd; scd = scd->next) {
+		if ((scd->channel == channel && scd->id == id && scd->lun == lun)) {
+			break;
+		}
+	}
+	if (scd==NULL) {
+		up(&scsi_host_internals_lock);
+		return -ENODEV;
+	}
+
+	/* See if the specified device is busy.  Doesn't this race with
+	 * sd_open(), sd_release() and similar?  Why don't they lock
+	 * things when they increment/decrement the access_count? */
+	if (scd->access_count) {
+		up(&scsi_host_internals_lock);
+		return -EBUSY;
+	}
+
+	SDTpnt = scsi_devicelist;
+	while (SDTpnt != NULL) {
+		if (SDTpnt->detach)
+			(*SDTpnt->detach) (scd);
+		SDTpnt = SDTpnt->next;
+	}
+
+	if (scd->attached == 0) {
+		/* Nobody is using this device, so we
+		 * can now free all command structures.  */
+		if (shpnt->hostt->revoke)
+			shpnt->hostt->revoke(scd);
+		devfs_unregister (scd->de);
+		scsi_release_commandblocks(scd);
+
+		/* Now we can remove the device structure */
+		if (scd->next != NULL)
+			scd->next->prev = scd->prev;
+
+		if (scd->prev != NULL)
+			scd->prev->next = scd->next;
+
+		if (shpnt->host_queue == scd) {
+			shpnt->host_queue = scd->next;
+		}
+		blk_cleanup_queue(&scd->request_queue);
+		kfree((char *) scd);
+	}
+
+	up(&scsi_host_internals_lock);
+	return 0;
+}
+
 #ifdef CONFIG_PROC_FS
 static int scsi_proc_info(char *buffer, char **start, off_t offset, int length)
 {
@@ -1606,8 +1756,6 @@
 static int proc_scsi_gen_write(struct file * file, const char * buf,
                               unsigned long length, void *data)
 {
-	struct Scsi_Device_Template *SDTpnt;
-	Scsi_Device *scd;
 	struct Scsi_Host *HBA_ptr;
 	char *p;
 	int host, channel, id, lun;
@@ -1722,13 +1870,12 @@
 	/*
 	 * Usage: echo "scsi add-single-device 0 1 2 3" >/proc/scsi/scsi
 	 * with  "0 1 2 3" replaced by your "Host Channel Id Lun".
-	 * Consider this feature BETA.
+	 *
+	 * Consider this feature pre-BETA.
+	 *
 	 *     CAUTION: This is not for hotplugging your peripherals. As
 	 *     SCSI was not designed for this you could damage your
-	 *     hardware !
-	 * However perhaps it is legal to switch on an
-	 * already connected device. It is perhaps not
-	 * guaranteed this device doesn't corrupt an ongoing data transfer.
+	 *     hardware and thoroughly confuse the SCSI subsystem.
 	 */
 	if (!strncmp("add-single-device", buffer + 5, 17)) {
 		p = buffer + 23;
@@ -1746,33 +1893,11 @@
 				break;
 			}
 		}
-		err = -ENXIO;
-		if (!HBA_ptr)
-			goto out;
-
-		for (scd = HBA_ptr->host_queue; scd; scd = scd->next) {
-			if ((scd->channel == channel
-			     && scd->id == id
-			     && scd->lun == lun)) {
-				break;
-			}
-		}
-
-		err = -ENOSYS;
-		if (scd)
-			goto out;	/* We do not yet support unplugging */
-
-		scan_scsis(HBA_ptr, 1, channel, id, lun);
-
-		/* FIXME (DB) This assumes that the queue_depth routines can be used
-		   in this context as well, while they were all designed to be
-		   called only once after the detect routine. (DB) */
-		/* queue_depth routine moved to inside scan_scsis(,1,,,) so
-		   it is called before build_commandblocks() */
-
-		err = length;
+		if ((err=scsi_add_single_device(HBA_ptr, channel, id, lun))==0)
+		    err = length;
 		goto out;
 	}
+
 	/*
 	 * Usage: echo "scsi remove-single-device 0 1 2 3" >/proc/scsi/scsi
 	 * with  "0 1 2 3" replaced by your "Host Channel Id Lun".
@@ -1782,7 +1907,6 @@
 	 *     CAUTION: This is not for hotplugging your peripherals. As
 	 *     SCSI was not designed for this you could damage your
 	 *     hardware and thoroughly confuse the SCSI subsystem.
-	 *
 	 */
 	else if (!strncmp("remove-single-device", buffer + 5, 20)) {
 		p = buffer + 26;
@@ -1798,58 +1922,8 @@
 				break;
 			}
 		}
-		err = -ENODEV;
-		if (!HBA_ptr)
-			goto out;
-
-		for (scd = HBA_ptr->host_queue; scd; scd = scd->next) {
-			if ((scd->channel == channel
-			     && scd->id == id
-			     && scd->lun == lun)) {
-				break;
-			}
-		}
-
-		if (scd == NULL)
-			goto out;	/* there is no such device attached */
-
-		err = -EBUSY;
-		if (scd->access_count)
-			goto out;
-
-		SDTpnt = scsi_devicelist;
-		while (SDTpnt != NULL) {
-			if (SDTpnt->detach)
-				(*SDTpnt->detach) (scd);
-			SDTpnt = SDTpnt->next;
-		}
-
-		if (scd->attached == 0) {
-			/*
-			 * Nobody is using this device any more.
-			 * Free all of the command structures.
-			 */
-                        if (HBA_ptr->hostt->revoke)
-                                HBA_ptr->hostt->revoke(scd);
-			devfs_unregister (scd->de);
-			scsi_release_commandblocks(scd);
-
-			/* Now we can remove the device structure */
-			if (scd->next != NULL)
-				scd->next->prev = scd->prev;
-
-			if (scd->prev != NULL)
-				scd->prev->next = scd->next;
-
-			if (HBA_ptr->host_queue == scd) {
-				HBA_ptr->host_queue = scd->next;
-			}
-			blk_cleanup_queue(&scd->request_queue);
-			kfree((char *) scd);
-		} else {
-			goto out;
-		}
-		err = 0;
+		err=scsi_remove_single_device(HBA_ptr, channel, id, lun);
+		goto out;
 	}
 out:
 	
