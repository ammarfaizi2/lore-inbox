Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVA0Rbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVA0Rbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVA0R3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:29:38 -0500
Received: from pop-a065d05.pas.sa.earthlink.net ([207.217.121.249]:48332 "EHLO
	pop-a065d05.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S262674AbVA0R1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:27:40 -0500
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: SCSI oops in 2.6.11-rc2/PPC [with work-around]
Message-Id: <E1CuDQU-00038H-00@penngrove.fdns.net>
Date: Thu, 27 Jan 2005 09:27:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, the stock 2.6.11-rc2 wouldn't boot on my PowerMac 8500/G3, but 
2.6.11-rc2-bk2 fixed that.  This is to follow up on an earlier bug report.
Attaching a SCSI device (real or emulated) via a module seems to fail on
my PowerMac (PPC) but not on my VAIO Sony laptop, with the following Oops:


Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT 
NIP: C009C998 LR: C009C998 SP: CD0C3C40 REGS: cd0c3b90 TRAP: 0600    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 6B6B6BDF, DSISR: 00000000
TASK = ccaa0150[1040] 'modprobe' THREAD: cd0c2000
Last syscall: 120 
GPR00: C009C998 CD0C3C40 CCAA0150 C01B0834 00000047 00000047 CD0C3C78 0000000A 
GPR08: FFFFFFFF 00008000 CDC232D0 CD0C3C40 42002448 1001E284 100013A4 00000000 
GPR16: 00000000 00000000 00000000 00000000 100013A4 100186F8 00000000 CD0C3D98 
GPR24: CD0C3D9C 00000001 00000000 CC46CCCC CD0C3C78 CD3A1544 CC46CCD0 6B6B6BDF 
NIP [c009c998] create_dir+0x38/0x1d0
LR [c009c998] create_dir+0x38/0x1d0
Call trace:
 [c009cb8c] sysfs_create_dir+0x48/0x94
 [c00af400] create_dir+0x28/0x6c
 [c00af704] kobject_add+0x5c/0x15c
 [c00ed438] device_add+0xc4/0x19c
 [c0115130] scsi_sysfs_add_sdev+0x78/0x3a4
 [c0113628] scsi_add_lun+0x2f8/0x364
 [c0113780] scsi_probe_and_add_lun+0xec/0x1fc
 [c0113fb4] scsi_scan_target+0x7c/0xec
 [c01140a0] scsi_scan_channel+0x7c/0x9c
 [c0114198] scsi_scan_host_selected+0xd8/0x138
 [cf854b40] mac53c94_probe+0x208/0x26c [mac53c94]
 [c0106a40] macio_device_probe+0x80/0x9c
 [c00ee9e8] driver_probe_device+0x4c/0xa0
 [c00eeba4] driver_attach+0x88/0xc8
 [c00ef1e8] bus_add_driver+0xd0/0x11c


This prevents me from using things like an external disk, digital camera 
USB or USB CD-R/W drive and afflicts 2.6.10/PPC as well.

It appears that we find ourselves faulting trying to claim a semaphore in
create_dir() [fs/sysfs/dir.c] with a null pointer in 'p'.  I tracked this
down to sysfs_create_dir() ending up with 'parent->d_inode' being zero.
My workaround involves checking for this and creating such a directory at
the 'root' level instead.  


--- ./fs/sysfs/dir.c.orig	2005-01-23 16:44:35.000000000 -0800
+++ ./fs/sysfs/dir.c	2005-01-25 15:37:25.000000000 -0800
@@ -147,6 +147,12 @@
 	else
 		return -EFAULT;
 
+	if (!parent->d_inode && sysfs_mount && sysfs_mount->mnt_sb) {
+		printk("sysfs_create_dir() with parent->d_inode zero, creating '%s' at root(?!?)\n",
+		       kobject_name(kobj));
+		parent = sysfs_mount->mnt_sb->s_root;
+	}
+
 	error = create_dir(kobj,parent,kobject_name(kobj),&dentry);
 	if (!error)
 		kobj->dentry = dentry;


This will allow me to use these SCSI devices, but removing such a device
still seems broken:


usb 1-2: USB disconnect, address 2
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT 
NIP: C009BA18 LR: C009BA18 SP: CD2FBD40 REGS: cd2fbc90 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000074, DSISR: 40000000
TASK = cd28e150[1286] 'khubd' THREAD: cd2fa000
Last syscall: -1 
GPR00: C009BA18 CD2FBD40 CD28E150 C01B0834 00000047 00000047 00000002 0000000A 
GPR08: 00000000 00008000 00000007 CD2FBD40 22008448 1001E284 100013A4 00000000 
GPR16: 00000000 CF970000 CF970000 CF980000 CC98AD54 CCAFAB64 CC98A99C CC98A944 
GPR24: CCAFA9A8 CCAFA9A8 CF970000 C01B8630 CC956794 C0217EA8 00000000 00000074 
NIP [c009ba18] sysfs_hash_and_remove+0x34/0x17c
LR [c009ba18] sysfs_hash_and_remove+0x34/0x17c
Call trace:
 [c009dbc4] sysfs_remove_link+0x14/0x24
 [c00efe44] class_device_dev_unlink+0x1c/0x2c
 [c00f05c0] class_device_del+0xe0/0x158
 [c00f0650] class_device_unregister+0x18/0x34
 [c010ce2c] scsi_remove_host+0x60/0xb8
 [cf90e0fc] storage_disconnect+0xb4/0xe4 [usb_storage]
 [cf95b1ac] usb_unbind_interface+0x94/0x98 [usbcore]
 [c00eec7c] device_release_driver+0x98/0x9c
 [c00eef8c] bus_remove_device+0x94/0xf0
 [c00ed664] device_del+0xb8/0x11c
 [cf9647b0] usb_disable_device+0xe8/0x1a4 [usbcore]
 [cf95e53c] usb_disconnect+0xd0/0x22c [usbcore]
 [cf95fe2c] hub_port_connect_change+0x520/0x544 [usbcore]
 [cf960298] hub_events+0x448/0x550 [usbcore]
 [cf9603e0] hub_thread+0x40/0xec [usbcore]


I haven't put in any debug code, but i suspect it's also failing inside
sysfs_hash_and_remove trying to claim the semaphore of a non-existant 
inode.  If anyone wants more details, please let me know.
		      
		         -- JM


[Note: I never send unsolicited binary attachments and if you receive anything
purportedly from <kd6pag@qsl.net> that isn't signed with my callsign, then it
probably isn't from me.]
