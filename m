Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTDVUz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbTDVUyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:54:01 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46555 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263853AbTDVUqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:46:10 -0400
Date: Tue, 22 Apr 2003 13:58:27 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Cc: hannal@us.ibm.com, andmike@us.ibm.com
Subject: [RFC] Device class rework [3/5]
Message-ID: <20030422205827.GD4701@kroah.com>
References: <20030422205545.GA4701@kroah.com> <20030422205719.GB4701@kroah.com> <20030422205749.GC4701@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422205749.GC4701@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 01:55:45PM -0700, Greg KH wrote:
>  - Crude patches to the scsi core to get it to build properly.  This
>    patch is not correct, but needed if your machines have scsi.  Mike
>    Anderson has said he will fix up the scsi code based on these core
>    changes.


diff -Nru a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
--- a/drivers/scsi/hosts.c	Tue Apr 22 13:08:01 2003
+++ b/drivers/scsi/hosts.c	Tue Apr 22 13:08:01 2003
@@ -294,7 +294,7 @@
 			sht->info ? sht->info(shost) : sht->name);
 
 	if (dev) {
-		dev->class_data = shost;
+//		dev->class_data = shost;
 		shost->host_gendev = dev;
 	}
 
diff -Nru a/drivers/scsi/hosts.h b/drivers/scsi/hosts.h
--- a/drivers/scsi/hosts.h	Tue Apr 22 13:07:58 2003
+++ b/drivers/scsi/hosts.h	Tue Apr 22 13:07:58 2003
@@ -495,7 +495,8 @@
         __attribute__ ((aligned (sizeof(unsigned long))));
 };
 
-#define	to_scsi_host(d)	d->class_data
+//#define	to_scsi_host(d)	d->class_data
+#define	to_scsi_host(d)	d->driver_data	// Major breakage, but we compile now...
 	
 /*
  * These two functions are used to allocate and free a pseudo device
@@ -607,7 +608,7 @@
 extern int scsi_upper_driver_register(struct Scsi_Device_Template *);
 extern void scsi_upper_driver_unregister(struct Scsi_Device_Template *);
 
-extern struct device_class shost_devclass;
+extern struct class shost_devclass;
 
 #endif
 /*
diff -Nru a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
--- a/drivers/scsi/scsi_debug.c	Tue Apr 22 13:07:57 2003
+++ b/drivers/scsi/scsi_debug.c	Tue Apr 22 13:07:57 2003
@@ -183,7 +183,7 @@
 	.name 		= sdebug_proc_name,
 	.probe          = sdebug_driver_probe,
 	.remove         = sdebug_driver_remove,
-	.devclass 	= &shost_devclass,
+//	.devclass 	= &shost_devclass,
 };
 
 static const int check_condition_result = 
diff -Nru a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c	Tue Apr 22 13:08:01 2003
+++ b/drivers/scsi/scsi_sysfs.c	Tue Apr 22 13:08:01 2003
@@ -95,10 +95,8 @@
 	device_remove_file(dev, &dev_attr_class_name);
 }
 
-struct device_class shost_devclass = {
+struct class shost_devclass = {
 	.name		= "scsi-host",
-	.add_device	= scsi_host_class_add_dev,
-	.remove_device	= scsi_host_class_rm_dev,
 };
 
 /**
@@ -136,14 +134,14 @@
 int scsi_sysfs_register(void)
 {
 	bus_register(&scsi_bus_type);
-	devclass_register(&shost_devclass);
+	class_register(&shost_devclass);
 
 	return 0;
 }
 
 void scsi_sysfs_unregister(void)
 {
-	devclass_unregister(&shost_devclass);
+	class_unregister(&shost_devclass);
 	bus_unregister(&scsi_bus_type);
 }
 
