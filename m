Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbUCMDLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 22:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbUCMDLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 22:11:08 -0500
Received: from main.gmane.org ([80.91.224.249]:24232 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262690AbUCMDLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 22:11:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Brian S. Stephan" <stephanb@msoe.edu>
Subject: 2.6.4-mm1 and removable USB drive oops
Date: Fri, 12 Mar 2004 21:05:21 -0600
Message-ID: <c2ttp1$bj4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3767366.GrpFNCx5mU"
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mke5-233.nconnect.net
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3767366.GrpFNCx5mU
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit

Hi, this is my first time posting.

I've been discovering oopses with 2.6.4-mm1 (vanilla works fine, see below)
and my USB devices picked up by usb-storage: a really dinky thumb drive and
more importantly, a 20 GB mp3/vorbis player. They show the same behavior; I
can mount them as scsi disks, write to them, treat them as they should be,
unmount... all is fine until I unplug. Then the attached oops occurs.
Device removal fails (duh), with the added bonus that the devices can't be
attached again and rmmod usb-storage fails.

I found the offending one-liner in drivers/scsi/scsi_sysfs.c and attached a
patch that removes the line. This line is added in -mm1. I really doubt
this is the right fix but I thought it'd be a good start for you real
hackers. :)

Thanks.
--nextPart3767366.GrpFNCx5mU
Content-Type: text/plain; name="oops_example"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="oops_example"

Linux version 2.6.4-mm1 (root@skuld) (gcc version 3.3.3 20040217 (Gentoo Linux 3.3.3, propolice-3.3-7)) #6 Fri Mar 12 19:21:14 CST 2004

[snip]

usb 2-2: new full speed USB device using address 3
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: M-Sys     Model: DiskOnKey         Rev: 2.51
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 63648 512-byte hdwr sectors (33 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
USB Mass Storage device found at 3
usb 2-2: USB disconnect, address 3
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c01a4847
*pde = 0bd8f067
*pte = 00000000
Oops: 0000 [#1]
DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c01a4847>]    Not tainted VLI
EFLAGS: 00010282   (2.6.4-mm1) 
EIP is at sysfs_hash_and_remove+0x19/0x9c
eax: 00000000   ebx: c8f73eb8   ecx: c02ad4b2   edx: 00000077
esi: c8f73eb8   edi: c03c1999   ebp: cf8b5dd8   esp: cf8b5dc8
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5, threadinfo=cf8b4000 task=cf8d89f0)
Stack: 00000000 c8f73eb8 c8f73eb8 00000000 cf8b5df4 c026f5a1 cf8b5ddc cea95d24 
       c8f73eb8 c8f73da4 00000286 cf8b5e00 c026f5dd c8f73bf8 cf8b5e10 c02b55fa 
       c8f73bf8 cea95bf8 cf8b5e44 c02b49aa cf1c4180 cf3275f0 cf37ee38 c042fb40 
Call Trace:
 [<c026f5a1>] class_device_del+0x88/0xb9
 [<c026f5dd>] class_device_unregister+0xb/0x14
 [<c02b55fa>] scsi_remove_device+0x43/0x85
 [<c02b49aa>] scsi_forget_host+0xcf/0x296
 [<c02c9826>] usb_buffer_free+0x3d/0x3f
 [<c02ad568>] scsi_remove_host+0x14/0x3a
 [<c02e2d99>] storage_disconnect+0x2c/0x35
 [<c02c8729>] usb_unbind_interface+0x64/0x66
 [<c026ea7b>] device_release_driver+0x59/0x5b
 [<c026eba5>] bus_remove_device+0x64/0xa4
 [<c026dccd>] device_del+0x65/0x8e
 [<c026dd01>] device_unregister+0xb/0x14
 [<c02cfdaf>] usb_disable_device+0xc8/0x126
 [<c02c91ec>] usb_disconnect+0xb6/0xfe
 [<c02cb6fd>] hub_port_connect_change+0x260/0x265
 [<c02cb14a>] hub_port_status+0x39/0x9f
 [<c0118d4c>] schedule+0x3ae/0x716
 [<c02cba0f>] hub_events+0x30d/0x475
 [<c02cbba7>] hub_thread+0x30/0xdd
 [<c01190b4>] default_wake_function+0x0/0xc
 [<c02cbb77>] hub_thread+0x0/0xdd
 [<c0106b29>] kernel_thread_helper+0x5/0xb

Code: 89 f2 89 5d ec e8 f1 33 fd ff 83 c4 10 5b 5e 5f 5d c3 55 89 e5 83 ec 10 89 5d f4 89 7d fc 89 45 f0 89 75 f8 89 d7 ba 77 00 00 00 <8b> 70 20 b8 41 67 3a c0 8d 9e 88 00 00 00 e8 c8 6a f7 ff 89 d9 
 

--nextPart3767366.GrpFNCx5mU
Content-Type: text/x-diff; name="stops_oops.patch"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="stops_oops.patch"

--- linux-2.6.4-mm1/drivers/scsi/scsi_sysfs.c	2004-03-12 19:29:38.914342422 -0600
+++ linux-2.6.4-mm1/drivers/scsi/scsi_sysfs.c.new	2004-03-12 19:30:09.876314883 -0600
@@ -436,7 +436,6 @@
 	if (sdev->sdev_state == SDEV_RUNNING || sdev->sdev_state == SDEV_CANCEL) {
 		sdev->sdev_state = SDEV_DEL;
 		class_device_unregister(&sdev->sdev_classdev);
-		class_device_unregister(&sdev->transport_classdev);
 		device_del(&sdev->sdev_gendev);
 		if (sdev->host->hostt->slave_destroy)
 			sdev->host->hostt->slave_destroy(sdev);

--nextPart3767366.GrpFNCx5mU--

