Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSJOSMY>; Tue, 15 Oct 2002 14:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbSJOSMX>; Tue, 15 Oct 2002 14:12:23 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:64445 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264936AbSJOSMQ>;
	Tue, 15 Oct 2002 14:12:16 -0400
Date: Tue, 15 Oct 2002 11:18:03 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: [patch] Re: 2.5.42 kernel BUG at drivers/base/core.c:251!
Message-ID: <20021015111803.A27953@eng2.beaverton.ibm.com>
Mail-Followup-To: Badari Pulavarty <pbadari@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
References: <200210151724.g9FHOI426577@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200210151724.g9FHOI426577@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Tue, Oct 15, 2002 at 10:24:18AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 10:24:18AM -0700, Badari Pulavarty wrote:
> Is this a known problem on 2.5.42 ? Happens all the time with rmmod.
> 
> - Badari

I hit a similiar bug for the put_device(&shpnt->host_driverfs_dev) of the
Scsi_Host, here's a patch for the scsi changes, I can't fully test it
since my devices seen via insmod aren't showing up properly right now, but
rmmod works, and the scsi remove-single-device also works without BUG-ing
or doing other bad things by leaving a dev model reference around:

--- linux-2.5.42/drivers/scsi/st.c	Fri Oct 11 21:22:11 2002
+++ linux-2.5.42-scsi-unreg/drivers/scsi/st.c	Tue Oct 15 10:49:14 2002
@@ -3909,12 +3909,12 @@
 						   &dev_attr_type);
 				device_remove_file(&tpnt->driverfs_dev_r[mode],
 						   &dev_attr_kdev);
-				put_device(&tpnt->driverfs_dev_r[mode]);
+				device_unregister(&tpnt->driverfs_dev_r[mode]);
 				device_remove_file(&tpnt->driverfs_dev_n[mode],
 						   &dev_attr_type);
 				device_remove_file(&tpnt->driverfs_dev_n[mode],
 						   &dev_attr_kdev);
-				put_device(&tpnt->driverfs_dev_n[mode]);
+				device_unregister(&tpnt->driverfs_dev_n[mode]);
 			}
 			if (tpnt->buffer) {
 				tpnt->buffer->orig_frp_segs = 0;
--- linux-2.5.42/drivers/scsi/sg.c	Fri Oct 11 21:22:07 2002
+++ linux-2.5.42-scsi-unreg/drivers/scsi/sg.c	Tue Oct 15 10:49:29 2002
@@ -1611,7 +1611,7 @@
 		sdp->de = NULL;
 		device_remove_file(&sdp->sg_driverfs_dev, &dev_attr_type);
 		device_remove_file(&sdp->sg_driverfs_dev, &dev_attr_kdev);
-		put_device(&sdp->sg_driverfs_dev);
+		device_unregister(&sdp->sg_driverfs_dev);
 		if (NULL == sdp->headfp)
 			vfree((char *) sdp);
 	}
--- linux-2.5.42/drivers/scsi/scsi.c	Fri Oct 11 21:22:08 2002
+++ linux-2.5.42-scsi-unreg/drivers/scsi/scsi.c	Tue Oct 15 10:49:51 2002
@@ -1965,6 +1965,7 @@
 			if (HBA_ptr->hostt->slave_detach)
 				(*HBA_ptr->hostt->slave_detach) (scd);
 			devfs_unregister (scd->de);
+			device_unregister(&scd->sdev_driverfs_dev);
 			scsi_release_commandblocks(scd);
 
 			/* Now we can remove the device structure */
@@ -2254,7 +2255,7 @@
 			if (shpnt->hostt->slave_detach)
 				(*shpnt->hostt->slave_detach) (SDpnt);
 			devfs_unregister (SDpnt->de);
-			put_device(&SDpnt->sdev_driverfs_dev);
+			device_unregister(&SDpnt->sdev_driverfs_dev);
 		}
 	}
 
@@ -2305,7 +2306,7 @@
 		/* Remove the /proc/scsi directory entry */
 		sprintf(name,"%d",shpnt->host_no);
 		remove_proc_entry(name, tpnt->proc_dir);
-		put_device(&shpnt->host_driverfs_dev);
+		device_unregister(&shpnt->host_driverfs_dev);
 		if (tpnt->release)
 			(*tpnt->release) (shpnt);
 		else {
