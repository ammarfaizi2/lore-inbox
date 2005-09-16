Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbVIPG4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbVIPG4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 02:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbVIPGz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 02:55:59 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:35589 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161066AbVIPGz7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 02:55:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZE5q8wim1SHfFB4dHrhmPJquRvpTT11Bd6wm4nQcKR+wZsWS37Z2wA6nju6mOSIEZW0LFP+aq/9AvodDbSIDmkhzctIMC+ltjuXxUHyCnUM/Zy9aaWZta0I3r0hIlcbt4XAIt1y6zUYc5jP2z9LjDQkoTVXjsjF+8SbgkFhpdF8=
Message-ID: <8e6f94720509152354332f0de4@mail.gmail.com>
Date: Fri, 16 Sep 2005 02:54:24 -0400
From: Will Dyson <will.dyson@gmail.com>
Reply-To: will.dyson@gmail.com
To: Gadi Oxman <gadio@netvision.net.il>
Subject: [patch] sysfs device support for ide-tape
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I was recently given an old Travan tape drive and asked to do
something useful with it. The ide-scsi + st (+serverworks ide
controller) combo results in a hard lockup of the machine which I have
not had the energy to debug, so I turned to ide-tape (which seems to
work). The system in question debian stable, using udev to manage
/dev.

The following patch to ide-tape.c allows udev to create the cdev nodes
for my drive.


diff -r 3df8dce293b2 drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	Wed Sep 14 22:56:27 2005
+++ b/drivers/ide/ide-tape.c	Fri Sep 16 02:32:02 2005
@@ -1013,6 +1013,8 @@
 
 static DECLARE_MUTEX(idetape_ref_sem);
 
+static struct class *idetape_sysfs_class;
+
 #define to_ide_tape(obj) container_of(obj, struct ide_tape_obj, kref)
 
 #define ide_tape_g(disk) \
@@ -4704,6 +4706,10 @@
 
 	drive->dsc_overlap = 0;
 	drive->driver_data = NULL;
+	class_device_destroy(idetape_sysfs_class,
+			MKDEV(IDETAPE_MAJOR, tape->minor));
+	class_device_destroy(idetape_sysfs_class,
+			MKDEV(IDETAPE_MAJOR, tape->minor + 128));
 	devfs_remove("%s/mt", drive->devfs_name);
 	devfs_remove("%s/mtn", drive->devfs_name);
 	devfs_unregister_tape(g->number);
@@ -4878,6 +4884,11 @@
 
 	idetape_setup(drive, tape, minor);
 
+	class_device_create(idetape_sysfs_class, 
+			MKDEV(IDETAPE_MAJOR, minor), dev, "%s", tape->name);
+	class_device_create(idetape_sysfs_class,
+			MKDEV(IDETAPE_MAJOR, minor + 128), dev, "n%s", tape->name);
+	
 	devfs_mk_cdev(MKDEV(HWIF(drive)->major, minor),
 			S_IFCHR | S_IRUGO | S_IWUGO,
 			"%s/mt", drive->devfs_name);
@@ -4903,6 +4914,7 @@
 static void __exit idetape_exit (void)
 {
 	driver_unregister(&idetape_driver.gen_driver);
+	class_destroy(idetape_sysfs_class);
 	unregister_chrdev(IDETAPE_MAJOR, "ht");
 }
 
@@ -4911,11 +4923,33 @@
  */
 static int idetape_init (void)
 {
+	int error = 1;
+	idetape_sysfs_class = class_create(THIS_MODULE, "ide_tape");
+	if (IS_ERR(idetape_sysfs_class)) {
+		idetape_sysfs_class = NULL;
+		printk(KERN_ERR "Unable to create sysfs class for ide tapes\n");
+		error = -EBUSY;
+		goto out;
+	}
+	
 	if (register_chrdev(IDETAPE_MAJOR, "ht", &idetape_fops)) {
 		printk(KERN_ERR "ide-tape: Failed to register character device interface\n");
-		return -EBUSY;
-	}
-	return driver_register(&idetape_driver.gen_driver);
+		error = -EBUSY;
+		goto out_free_class;
+	}
+	
+	error = driver_register(&idetape_driver.gen_driver);
+	if (error)
+		goto out_free_driver;
+
+	return 0;
+
+out_free_driver:
+	driver_unregister(&idetape_driver.gen_driver);
+out_free_class:
+	class_destroy(idetape_sysfs_class);
+out:
+	return error;
 }
 
 module_init(idetape_init);

-- 
Will Dyson
