Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSLTSHh>; Fri, 20 Dec 2002 13:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSLTSHh>; Fri, 20 Dec 2002 13:07:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:34976 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263313AbSLTSHf>;
	Fri, 20 Dec 2002 13:07:35 -0500
Date: Fri, 20 Dec 2002 11:46:21 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi + kobject Badness in 2.5.52
In-Reply-To: <Pine.LNX.4.33L2.0212191538210.30841-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0212201138300.969-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[linux-kernel cc'ed]

> Dec 19 15:13:19 gargoyle kernel: Badness in kobject_register at lib/kobject.c:113
> Dec 19 15:13:19 gargoyle kernel: Call Trace:
> Dec 19 15:13:19 gargoyle kernel:  [<f887fc7c>] idescsi_driver+0x7c/0xd0 [ide_scsi]
> Dec 19 15:13:19 gargoyle kernel:  [kobject_register+58/80] kobject_register+0x3a/0x50
> Dec 19 15:13:19 gargoyle kernel:  [bus_add_driver+108/192] bus_add_driver+0x6c/0xc0
> Dec 19 15:13:19 gargoyle kernel:  [<f887fc6c>] idescsi_driver+0x6c/0xd0 [ide_scsi]
> Dec 19 15:13:19 gargoyle kernel:  [<f887fc6c>] idescsi_driver+0x6c/0xd0 [ide_scsi]
> Dec 19 15:13:19 gargoyle kernel:  [ide_drive_remove+0/48] ide_drive_remove+0x0/0x30
> Dec 19 15:13:19 gargoyle kernel:  [<f887fc00>] idescsi_driver+0x0/0xd0 [ide_scsi]
> Dec 19 15:13:19 gargoyle kernel:  [ide_register_driver+218/240] ide_register_driver+0xda/0xf0
> Dec 19 15:13:19 gargoyle kernel:  [<f887fc4c>] idescsi_driver+0x4c/0xd0 [ide_scsi]
> Dec 19 15:13:19 gargoyle kernel:  [<f888200d>] +0xd/0x20 [ide_scsi]
> Dec 19 15:13:19 gargoyle kernel:  [<f887fc00>] idescsi_driver+0x0/0xd0 [ide_scsi]
> Dec 19 15:13:19 gargoyle kernel:  [sys_init_module+272/416] sys_init_module+0x110/0x1a0
> Dec 19 15:13:19 gargoyle kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

This is a multi-part problem. 

For one, ide_unregister_driver() was not calling driver_unregister(), so
the driver's sysfs directory was never getting deleted when the module was
removed the first time. Everything still should have worked, but it was
still incorrect.

Once that was resolved, I started hitting a BUG() in
ide_unregister_driver() because the drive was busy. I also noticed that I
now had _two_ pseudo-scsi devices, instead of just one. It turns out that
idescsi_release(), the tear-down method for SCSI devices was not
unregistering the pseudo host that idescsi_detect() was creating.

The two one-liners below should fix those problems. 

However, the question still remains if ide-scsi is relevant any more? 

	-pat


===== drivers/ide/ide.c 1.44 vs edited =====
--- 1.44/drivers/ide/ide.c	Tue Dec  3 12:01:26 2002
+++ edited/drivers/ide/ide.c	Fri Dec 20 11:36:40 2002
@@ -2317,6 +2317,8 @@
 	spin_lock(&drivers_lock);
 	list_del(&driver->drivers);
 	spin_unlock(&drivers_lock);
+
+	driver_unregister(&driver->gen_driver);
 
 	while(!list_empty(&driver->drives)) {
 		drive = list_entry(driver->drives.next, ide_drive_t, list);
===== drivers/scsi/ide-scsi.c 1.18 vs edited =====
--- 1.18/drivers/scsi/ide-scsi.c	Sat Nov 30 07:44:26 2002
+++ edited/drivers/scsi/ide-scsi.c	Fri Dec 20 11:37:49 2002
@@ -658,6 +658,7 @@
 		if (drive)
 			DRIVER(drive)->busy--;
 	}
+	scsi_unregister(host);
 	return 0;
 }
 

