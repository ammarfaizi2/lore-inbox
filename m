Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264056AbSIQLUp>; Tue, 17 Sep 2002 07:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264058AbSIQLUo>; Tue, 17 Sep 2002 07:20:44 -0400
Received: from pcow053o.blueyonder.co.uk ([195.188.53.96]:24595 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S264056AbSIQLUk>;
	Tue, 17 Sep 2002 07:20:40 -0400
Subject: Problems accessing USB Mass Storage
From: Mark C <gen-lists@blueyonder.co.uk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 17 Sep 2002 12:25:37 +0100
Message-Id: <1032261937.1170.13.camel@stimpy.angelnet.internal>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
---
To steal ideas from one person is plagiarism;
to steal from many is research.

I'm trying to access a USB digital camera under RedHat null Beta2 

The Camera information is as follows:

USB Epsilon 1.3  (Digital Dreams)
Resolution 1600 x 1280 pixels
Image sensor CMOS
LCD Screen 1.5" colour TFT
Internal memory 8MB NAND Gate Flash
External Memory Build in Smart Media card slot
Viewfinder Optical
Digital zoom X 4
Image capacity (with build in memory)   1600x1200 - 20
                                        1280x1024 - 29
                                        640x480 - 121
White balance Auto/Day/Shade/Bulb/Fl
Exposure Auto/Manual
Image format JPG, AVI (through software)
Computer interface USB
Power control Auto off (10 seconds)


I'm running a standard kernel 2.4.19-ac2 with USB Mass Storage degugging
Information.and also RedHat's 2.4.18-12.5 
(the below messages was taken for the 2.4.19-ac2)

When I plug it in its detected as: 

[root@stimpy mark]# usb.c: USB device 2 (vend/prod 0x733/0x1310) is not
claimed by any active driver.
  Vendor:           Model: 1.3M DigitalCAM   Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 16384 512-byte hdwr sectors (8 MB)
sda: test WP failed, assume Write Enabled
 sda1


Which means that the kernel has seen it and its being treated as a mass
Storage device, thus treated as a SCSI device.

So I also ran cdrecord -scanbus and that listed the device as well. 

scsibus1: 
        1,0,0   100) '        ' '1.3M DigitalCAM ' '1.00' Removable Disk

After reading several pages on USB and Mass storage, I have found out
how I should be able to access it

The following Kernel modules that are relevant to this device are loaded
as below:

vfat                   11356   0  (autoclean)
fat                    36888   0  (autoclean) [vfat]
sr_mod                 16248   0  (autoclean)
usb-storage           102352   0
usb-ohci               19528   0  (unused)
usbcore                69888   1  [usb-storage hid usb-ohci]
aic7xxx               123444   0
sd_mod                 13104   0
scsi_mod               99716   4  [sr_mod usb-storage aic7xxx sd_mod]

The file system on the camera is FAT (this can be accessed by VMware
running on this Box, as a removable device (which is running a Virtual
WinXp O/S) through the USB port using the drivers for windows supplied
by the manufacturer)

mount /dev/sda /mnt/camera

and

/sbin/modprobe fat && mount -t fat /dev/sda /mnt/camera

I've also tried vat, auto, autofs and /dev/sda[0-10] as well.

Also running the following, it cannot access the device either:

[root@stimpy dev]# dd if=/dev/sda of=/dev/null bs=1k count=1
dd: reading `/dev/sda': Input/output error
0+0 records in
0+0 records out

It seems it cannot find a partition table on the device, in WinXp I can
happily right click and create folders on the camera, It can also
Identify the amount of space on the device 8MB, when first plugged it.

And I have also tried the following as well:

[root@stimpy mark]# cat /dev/sda | file  -
cat: /dev/sda: Input/output error
standard input:              empty


Please see below the output of dmesg -n 9, with USB Mass storage
debugging turned on (sorry for the large amount)

---------------------- cut -----------------------------

hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x733/0x1310) is not claimed by any
active driver.
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
usb-storage: act_altsettting is 0
usb-storage: id_index calculated to be: 85
usb-storage: Array length appears to be: 87
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xdb6b0b20 Out: 0xdb6b0b34 Int: 0xdb6b0b48
(Period 1)
usb-storage: New GUID 07331310000ffffffffff700
usb-storage: GetMaxLUN command result is 1, data is 0
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: *** thread sleeping.
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage: 12 00 00 00 ff 00 4f da d4 33 4f da
usb-storage: Bulk command S 0x43425355 T 0x8 Trg 0 LUN 0 L 255 F 128 CL
6
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 36/255
usb-storage: Bulk data transfer result 0x1
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x8 R 219 Stat 0x0
usb-storage: Fixing INQUIRY data to show SCSI rev 2
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor:           Model: 1.3M DigitalCAM   Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1/0)
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2/0)
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (3/0)
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (4/0)
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (5/0)
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (6/0)
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (7/0)
usb-storage: *** thread sleeping.
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage: 00 00 00 00 00 00 00 00 00 00 30 da
usb-storage: Bulk command S 0x43425355 T 0x10 Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x10 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_CAPACITY (10 bytes)
usb-storage: 25 00 00 00 00 00 00 00 00 00 30 da
usb-storage: Bulk command S 0x43425355 T 0x11 Trg 0 LUN 0 L 8 F 128 CL
10
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 8/8
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x11 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
SCSI device sda: 16384 512-byte hdwr sectors (8 MB)
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command MODE_SENSE (6 bytes)
usb-storage: 1a 00 3f 00 ff 00 00 00 00 00 30 da
usb-storage: Bulk command S 0x43425355 T 0x12 Trg 0 LUN 0 L 255 F 128 CL
6
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/255
usb-storage: clearing endpoint halt for pipe 0xc0038280
usb-storage: usb_stor_clear_halt: result=0
usb-storage: usb_stor_transfer_partial(): unknown error
usb-storage: Bulk data transfer result 0x2
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x12 R 255 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk command S 0x43425355 T 0x12 Trg 0 LUN 0 L 18 F 128 CL
6
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x12 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x5, ASC: 0x24, ASCQ: 0x0
usb-storage: Illegal Request: invalid field in CDB
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
sda: test WP failed, assume Write Enabled
 sda:<7>usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage: 28 00 00 00 00 00 00 00 08 00 30 da
usb-storage: Bulk command S 0x43425355 T 0x13 Trg 0 LUN 0 L 4096 F 128
CL 10
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 4096 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 4096/4096
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x13 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
 sda1
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
USB Mass Storage support registered.
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
cdrom: This disc doesn't have any tracks I recognize!

---------------------- cut -----------------------------

Not being a programmer or kernel developer, I'm not sure where the error
lies, Its going to be either a USB device driver bug or the actual
camera itself (thus relying on the Windows drivers doing the actual
work, rather than properly implementing USB Mass Storage)

After several conversations with the RedHat mailing list,
I have not got any closer with regards to finding out where the error
actually lies

Can anyone possibly help on this one. 

Thanks in advance

Mark

