Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVGFE7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVGFE7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 00:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVGFE7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 00:59:39 -0400
Received: from smtp2.nbnz.co.nz ([202.49.143.67]:27911 "HELO smtp2.nbnz.co.nz")
	by vger.kernel.org with SMTP id S262069AbVGFCsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:48:30 -0400
Message-ID: <40BC5D4C2DD333449FBDE8AE961E0C334F9369@psexc03.nbnz.co.nz>
From: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
To: "'Alan Stern'" <stern@rowland.harvard.edu>
Cc: Stefano Rivoir <s.rivoir@gts.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: RE: [linux-usb-devel] Kernel unable to read partition table on US
	B Memory Key
Date: Wed, 6 Jul 2005 14:48:09 +1200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C581D5.250B1E70"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C581D5.250B1E70
Content-Type: text/plain

Alan,
 
> Try putting delays at various spots in sd_revalidate_disk: 
> the beginning, the middle, and the end.

OK, the attached patch works for me when sd_mod was loaded with delay_use=1.

Now I'm quite prepared to be told that this is a really horrible and
inapproprate hack (given that I am not a kernel developer, I don't really
know the "correct" way to solve this problem); and I'll cheerfully admit
that it doesn't really solve the problem cleanly as can be seen below:

Jul  6 14:44:50 pc196344 kernel: usb 1-6: new high speed USB device using
ehci_hcd and address 6
Jul  6 14:44:50 pc196344 kernel: Initializing USB Mass Storage driver...
Jul  6 14:44:50 pc196344 kernel: scsi5 : SCSI emulation for USB Mass Storage
devices
Jul  6 14:44:50 pc196344 kernel: usbcore: registered new driver usb-storage
Jul  6 14:44:50 pc196344 kernel: USB Mass Storage support registered.
Jul  6 14:44:50 pc196344 kernel: usb-storage: device found at 6
Jul  6 14:44:50 pc196344 kernel: usb-storage: waiting for device to settle
before scanning
Jul  6 14:44:52 pc196344 kernel:   Vendor: OTi       Model: Flash Disk
Rev: 2.00
Jul  6 14:44:52 pc196344 kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Jul  6 14:44:52 pc196344 kernel: Attached scsi generic sg1 at scsi5, channel
0, id 0, lun 0,  type 0
Jul  6 14:44:52 pc196344 kernel: usb-storage: device scan complete
Jul  6 14:44:52 pc196344 scsi.agent[27245]: disk at
/devices/pci0000:00/0000:00:1d.7/usb1/1-6/1-6:1.0/host5/target5:0:0/5:0:0:0
Jul  6 14:44:52 pc196344 kernel: sd: waiting for device to get ready.
Jul  6 14:44:53 pc196344 kernel: sda: Unit Not Ready, sense:
Jul  6 14:44:53 pc196344 kernel: : Current: sense key: Unit Attention
Jul  6 14:44:53 pc196344 kernel:     Additional sense: Not ready to ready
change, medium may have changed
Jul  6 14:44:53 pc196344 kernel: sda : READ CAPACITY failed.
Jul  6 14:44:53 pc196344 kernel: sda : status=1, message=00, host=0,
driver=08
Jul  6 14:44:53 pc196344 kernel: sd: Current: sense key: Unit Attention
Jul  6 14:44:53 pc196344 kernel:     Additional sense: Not ready to ready
change, medium may have changed
Jul  6 14:44:53 pc196344 kernel: sda: test WP failed, assume Write Enabled
Jul  6 14:44:53 pc196344 kernel: sda: assuming drive cache: write through
Jul  6 14:44:53 pc196344 kernel: sd: waiting for device to get ready.
Jul  6 14:44:54 pc196344 kernel: sda: Unit Not Ready, sense:
Jul  6 14:44:54 pc196344 kernel: : Current: sense key: Unit Attention
Jul  6 14:44:54 pc196344 kernel:     Additional sense: Not ready to ready
change, medium may have changed
Jul  6 14:44:54 pc196344 kernel: sda : READ CAPACITY failed.
Jul  6 14:44:54 pc196344 kernel: sda : status=1, message=00, host=0,
driver=08
Jul  6 14:44:54 pc196344 kernel: sd: Current: sense key: Unit Attention
Jul  6 14:44:54 pc196344 kernel:     Additional sense: Not ready to ready
change, medium may have changed
Jul  6 14:44:54 pc196344 kernel: sda: test WP failed, assume Write Enabled
Jul  6 14:44:54 pc196344 kernel: sda: assuming drive cache: write through
Jul  6 14:44:54 pc196344 kernel: sd: waiting for device to get ready.
Jul  6 14:44:55 pc196344 kernel: SCSI device sda: 255488 512-byte hdwr
sectors (131 MB)
Jul  6 14:44:55 pc196344 kernel: sda: Write Protect is off
Jul  6 14:44:55 pc196344 kernel: sda: Mode Sense: 03 00 00 00
Jul  6 14:44:55 pc196344 kernel: sda: assuming drive cache: write through
Jul  6 14:44:55 pc196344 kernel:  /dev/scsi/host5/bus0/target0/lun0: p1
Jul  6 14:44:55 pc196344 kernel: Attached scsi removable disk sda at scsi5,
channel 0, id 0, lun 0

There are three delays from my patch in the above list, and increasing the
delay to 3 seconds didn't help, as I got three one-second delays.  

However, if someone with the appropriate knowledge could transform my kludge
into a proper fix, then I would be very happy.

Alan, thanks very much for your help - I really appreciate the quick
responses you have given me.

Note that I now have the output from the USB Snoop tool under Windows if
anyone wants it - please ask if needed to help solve the issue "correctly".

James Roberts-Thomson
----------
Hardware:  The parts of a computer system that can be kicked.

Mailing list Readers:  Please ignore the following disclaimer - this email
is explicitly declared to be non confidential and does not contain
privileged information.


This communication is confidential and may contain privileged material.
If you are not the intended recipient you must not use, disclose, copy or retain it.
If you have received it in error please immediately notify me by return email
and delete the emails.
Thank you.

------_=_NextPart_000_01C581D5.250B1E70
Content-Type: application/octet-stream;
	name="oti-usb-key.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="oti-usb-key.patch"

--- linux-2.6.12/drivers/scsi/sd.c	2005-06-18 07:48:29.000000000 =
+1200=0A=
+++ linux-2.6.12-jrt1/drivers/scsi/sd.c	2005-07-06 14:33:27.000000000 =
+1200=0A=
@@ -89,6 +89,10 @@=0A=
 #define SD_MAX_RETRIES		5=0A=
 #define SD_PASSTHROUGH_RETRIES	1=0A=
 =0A=
+static unsigned int delay_use =3D 0;=0A=
+module_param(delay_use, uint, S_IRUGO | S_IWUSR);=0A=
+MODULE_PARM_DESC(delay_use, "Optional number of seconds delay for =
dodgy USB keys to settle");=0A=
+=0A=
 static void scsi_disk_release(struct kref *kref);=0A=
 =0A=
 struct scsi_disk {=0A=
@@ -1483,6 +1487,14 @@ static int sd_revalidate_disk(struct gen=0A=
 	sdkp->WCE =3D 0;=0A=
 	sdkp->RCD =3D 0;=0A=
 =0A=
+	/* Wait for the timeout to expire */=0A=
+	if (delay_use > 0) {=0A=
+		printk(KERN_DEBUG "sd: waiting for device to get ready.\n");=0A=
+		wait_queue_head_t delay_wait;=0A=
+		init_waitqueue_head(&delay_wait);=0A=
+		wait_event_interruptible_timeout(delay_wait, 0, delay_use * HZ);=0A=
+	}=0A=
+	=0A=
 	sd_spinup_disk(sdkp, disk->disk_name, sreq, buffer);=0A=
 =0A=
 	/*=0A=

------_=_NextPart_000_01C581D5.250B1E70--
