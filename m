Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSJJWbU>; Thu, 10 Oct 2002 18:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262321AbSJJWbU>; Thu, 10 Oct 2002 18:31:20 -0400
Received: from codepoet.org ([166.70.99.138]:27866 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S262303AbSJJWbQ>;
	Thu, 10 Oct 2002 18:31:16 -0400
Date: Thu, 10 Oct 2002 16:37:00 -0600
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: [PATCH] ieee1394 hotplug SCSI interaction 2.4.20-pre10
Message-ID: <20021010223700.GA26348@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux1394-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As has been reported a few times on the linux1394-devel mailing
list, hotplugging firewire drives only sortof works.  A recent
posting to the list rehashing the problems

    http://sourceforge.net/mailarchive/forum.php?thread_id=1151203&forum_id=5389

reminded me of my old partial fix for this problem that was
sitting unfinished.  So last night I polished it up, fixed the
bugs, and it is now working perfectly for me.

Without this patch, hotplugging firewire drives will register the
drives with the 1394 layers, but will not register them with the
SCSI subsystem.  Unplugging firewire drives leaves the (now
absent) drives still registered with the SCSI subsystem.  As you
can imagine, the current situation sucks, and makes hotplugging
firewire drives mostly useless.  To make things behave correctly,
one needs to manually add/remove SBP-2 devices using a shell script 
(http://www.garloff.de/kurt/linux/rescan-scsi-bus.sh) that
pokes at /proc/scsi/scsi by scanning though all your SCSI hosts
and then does things like
    echo "scsi remove-single-device 0 0 0 0" > /proc/scsi/scsi
for each and every SCSI device on your system.  I don't consider
such things safe or desirable at all.

It seemed to me that since the kernel had all the information to
do the Right Thing(tm), it made sense to connect the
remove-single-device and add-single-device functionality of
/proc/scsi/scsi together with the sbp2 driver so the Right
Thing(tm) could happen automagically.

With my patch applied, one can now plug in firewire drives and
they will all be automagically registered with the SCSI
subsystem.  When one unplugs SBP-2 devices, they will be
automagically unregistered from the SCSI subsystem.  

When I posted my earlier effort to the linux1394-devel list:
    http://sourceforge.net/mailarchive/forum.php?thread_id=949390&forum_id=5389
it was decided that the change to the SCSI subsystem needed to
expose scsi_add_single_device() and scsi_remove_single_device()
was not desirable.  I'll leave the decision on that to others.

For the moment, this patch is works nicely for me and makes using
firewire drives a much nicer experience. 

Have fun,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- linux-2.4.19/drivers/ieee1394.orig/sbp2.c	2002-10-10 04:28:53.000000000 -0500
+++ linux-2.4.19/drivers/ieee1394/sbp2.c	2002-10-10 04:31:31.000000000 -0500
@@ -1681,6 +1681,18 @@
 
 	SBP2_INFO("Logged into SBP-2 device");
 
+	/* Try to hook ourselves into the SCSI subsystem */
+	{
+	    struct Scsi_Host *HBA_ptr;
+	    HBA_ptr=hi->scsi_host;
+	    if (HBA_ptr==NULL) {
+		return 0;
+	    }
+	    if (scsi_add_single_device(HBA_ptr, 0, scsi_id->id, 0)!=0) {
+		SBP2_INFO("Unable to connect SBP-2 device into the SCSI subsystem");
+	    }
+	}
+
 	return(0);
 
 }
@@ -1739,8 +1751,22 @@
 
 	SBP2_INFO("Logged out of SBP-2 device");
 
-	return(0);
+	/* Now that we are logged out of the SBP-2 device, lets
+	 * try to un-hook ourselves from the SCSI subsystem */
+	{
+	    Scsi_Device *scd;
+	    struct Scsi_Host *HBA_ptr;
+
+	    HBA_ptr=hi->scsi_host;
+	    if (HBA_ptr==NULL) {
+		return 0;
+	    }
+	    if (scsi_remove_single_device(HBA_ptr, 0, scsi_id->id, 0)!=0) {
+		SBP2_INFO("Unable to disconnect SBP-2 device from the SCSI subsystem");
+	    }
+	}
 
+	return(0);
 }
 
 /*
--- orig/drivers/scsi/hosts.h	2002-10-09 04:41:10.000000000 -0600
+++ linux-2.4.19/drivers/scsi/hosts.h	2002-10-09 04:41:10.000000000 -0600
@@ -532,6 +532,13 @@
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
--- orig/drivers/scsi/scsi.c	2002-10-09 04:41:10.000000000 -0600
+++ linux-2.4.19/drivers/scsi/scsi.c	2002-10-09 04:41:10.000000000 -0600
@@ -1553,6 +1553,96 @@
     }
 }
 
+/* Support for plugging/unplugging SCSI devices.  This feature is
+ * probably unsafe for standard SCSI devices, but is perfectly
+ * normal for things like ieee1394 or USB drives since these
+ * busses are designed for hotplugging.  Use at your own risk.... */
+int scsi_add_single_device(struct Scsi_Host *shpnt, 
+	int channel, int id, int lun)
+{
+	Scsi_Device *scd;
+
+	/* Do a bit of sanity checking */
+	if (shpnt==NULL) {
+		return  -ENXIO;
+	}
+
+	/* Check if they asked us to add an already existing device.
+	 * If so, ignore their misguided efforts. */
+	for (scd = shpnt->host_queue; scd; scd = scd->next) {
+		if ((scd->channel == channel && scd->id == id && scd->lun == lun)) {
+			break;
+		}
+	}
+	if (scd) {
+		return -ENOSYS;
+	}
+
+	scan_scsis(shpnt, 1, channel, id, lun);
+	return 0;
+}
+
+/* Support for plugging/unplugging SCSI devices.  This feature is
+ * probably unsafe for standard SCSI devices, but is perfectly
+ * normal for things like ieee1394 or USB drives since these
+ * busses are designed for hotplugging.  Use at your own risk.... */
+int scsi_remove_single_device(struct Scsi_Host *shpnt, 
+	int channel, int id, int lun)
+{
+	Scsi_Device *scd;
+	struct Scsi_Device_Template *SDTpnt;
+
+	/* Do a bit of sanity checking */
+	if (shpnt==NULL) {
+		return  -ENODEV;
+	}
+
+	/* Make sure the specified device is in fact present */
+	for (scd = shpnt->host_queue; scd; scd = scd->next) {
+		if ((scd->channel == channel && scd->id == id && scd->lun == lun)) {
+			break;
+		}
+	}
+	if (scd==NULL) {
+		return -ENODEV;
+	}
+
+	/* See if the specified device is busy */
+	if (scd->access_count)
+		return -EBUSY;
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
+	return 0;
+}
+
 #ifdef CONFIG_PROC_FS
 static int scsi_proc_info(char *buffer, char **start, off_t offset, int length)
 {
@@ -1605,8 +1695,6 @@
 static int proc_scsi_gen_write(struct file * file, const char * buf,
                               unsigned long length, void *data)
 {
-	struct Scsi_Device_Template *SDTpnt;
-	Scsi_Device *scd;
 	struct Scsi_Host *HBA_ptr;
 	char *p;
 	int host, channel, id, lun;
@@ -1745,33 +1833,11 @@
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
@@ -1797,58 +1863,8 @@
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
 	
--- orig/drivers/scsi/scsi_syms.c	2002-10-09 04:41:10.000000000 -0600
+++ linux-2.4.19/drivers/scsi/scsi_syms.c	2002-10-09 04:41:10.000000000 -0600
@@ -103,3 +103,9 @@
 extern int scsi_delete_timer(Scsi_Cmnd *);
 EXPORT_SYMBOL(scsi_add_timer);
 EXPORT_SYMBOL(scsi_delete_timer);
+
+/* Support for hot plugging and unplugging devices -- safe for 
+ * ieee1394 or USB devices, but probably not for normal SCSI... */
+EXPORT_SYMBOL(scsi_add_single_device);
+EXPORT_SYMBOL(scsi_remove_single_device);
+
