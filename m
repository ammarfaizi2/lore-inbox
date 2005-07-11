Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVGKDpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVGKDpu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 23:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVGKDpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 23:45:49 -0400
Received: from smtp2.nbnz.co.nz ([202.49.143.67]:10771 "HELO smtp2.nbnz.co.nz")
	by vger.kernel.org with SMTP id S262211AbVGKDpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 23:45:47 -0400
Message-ID: <40BC5D4C2DD333449FBDE8AE961E0C334F9385@psexc03.nbnz.co.nz>
From: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
To: "'Alan Stern'" <stern@rowland.harvard.edu>
Cc: "'Stefano Rivoir'" <s.rivoir@gts.it>,
       "'Kernel development list'" <linux-kernel@vger.kernel.org>,
       "'USB development list'" <linux-usb-devel@lists.sourceforge.net>
Subject: RE: [linux-usb-devel] Kernel unable to read partition table on US
	B Memory Key
Date: Mon, 11 Jul 2005 15:45:16 +1200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C585CA.F39BD010"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C585CA.F39BD010
Content-Type: text/plain

All,

> > Can you try adding delays before, after, and inbetween the calls to 
> > sd_read_capacity, sd_read_write_protect_flag, and 
> sd_read_cache_type, 
> > all near the end of sd_revalidate_disk?
> 
> Yes, will do this and post results.

OK, it turns out that for this particular key, a two second pause after
"sd_spinup_disk" is called and before "sd_read_capacity" will make it work.
The 'dmesg' (or syslog) output is still ugly, however; but once I realised
that it was "sd_spinup_disk" that:

A) needed the delay, and 
B) causes the first ugly message to be printed in the first place, then a
better patch came to mind.

So, after combining Alan's suggestion to use "msleep" rather than my
previous convoluted method, and moving the location of the pause to inside
sd_spinup_disk (and targeting it to remove the first "ugly"), I came up with
a better patch, which is attached.

This patch adds the module parameter 'firmware_delay', and will cause a
pause for "firmware_delay" seconds inside sd_spinup_disk when the first SCSI
command returns UNIT_ATTENTION as the sense key.

Again, I have deliberately made the default value for this parameter 0,
which means that the end-user will need to ensure insmod or modprobe
supplies a >0 value to firmware_delay before the patch takes effect.

I'm not sure what the procedure is for getting this patch officially
recognised for inclusion into the kernel - Alan, are you able to "sponsor"
this patch for inclusion?

Thanks,

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

------_=_NextPart_000_01C585CA.F39BD010
Content-Type: application/octet-stream;
	name="oti-usb-key-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="oti-usb-key-v2.patch"

--- /home/n202042/src/kernel2612/linux-2.6.12/drivers/scsi/sd.c	=
2005-06-18 07:48:29.000000000 +1200=0A=
+++ /usr/src/linux/drivers/scsi/sd.c	2005-07-11 15:40:45.000000000 =
+1200=0A=
@@ -89,6 +89,10 @@=0A=
 #define SD_MAX_RETRIES		5=0A=
 #define SD_PASSTHROUGH_RETRIES	1=0A=
 =0A=
+static unsigned int firmware_delay =3D 0;=0A=
+module_param(firmware_delay, uint, S_IRUGO | S_IWUSR);=0A=
+MODULE_PARM_DESC(firmware_delay, "Optional number of seconds delay for =
dodgy USB keys to settle");=0A=
+=0A=
 static void scsi_disk_release(struct kref *kref);=0A=
 =0A=
 struct scsi_disk {=0A=
@@ -1080,6 +1084,12 @@ sd_spinup_disk(struct scsi_disk *sdkp, c=0A=
 			/* Wait 1 second for next try */=0A=
 			msleep(1000);=0A=
 			printk(".");=0A=
+		} else if (sense_valid && sshdr.sense_key =3D=3D UNIT_ATTENTION && =
firmware_delay > 0 ) {=0A=
+				/* Some USB flash drives need a small delay (perhaps to allow =
internal firmware=0A=
+				 * time to initialise=0A=
+				 */=0A=
+				printk(KERN_NOTICE "%s: Allowing time for firmware =
initialisation\n", diskname);=0A=
+				msleep(firmware_delay * HZ);=0A=
 		} else {=0A=
 			/* we don't understand the sense code, so it's=0A=
 			 * probably pointless to loop */=0A=

------_=_NextPart_000_01C585CA.F39BD010--
