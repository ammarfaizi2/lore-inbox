Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVC3JW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVC3JW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 04:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVC3JW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 04:22:57 -0500
Received: from general.keba.co.at ([193.154.24.243]:20109 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261829AbVC3JUk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 04:20:40 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: [BUG] 2.6.11: Random SCSI/USB errors when reading from USB memory stick
Date: Wed, 30 Mar 2005 11:20:32 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231C0@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] 2.6.11: Random SCSI/USB errors when reading from USB memory stick
Thread-Index: AcU1CboK32PtUKkZQNWkN5LoijOynQ==
From: "kus Kusche Klaus" <kus@keba.com>
To: <stern@rowland.harvard.edu>, <linux-usb-users@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying a "dd if=/dev/sda of=/dev/null" (where /dev/sda is an USB
memory stick), this works fine for some seconds (and actually transfers
data at around 700-1000 KB/s), but ends up with some I/O errors sooner
or later, which cause the device to go offline (the stick must be
replugged to make it accessible again). Sometimes, this causes kernel
bugchecks and hung "dd" processes (which cannot be terminated even with
kill -9), see second example.

Two examples (syslog message outputs) are appended below, in both cases,
short USB reads seem to initiate the trouble.

I also tried running a kernel latency test program simultaneously: When
the errors occur, the latency goes up from less than 1 millisec to about
15 millisec (very bad for embedded control systems...).

The error occurred on an intel Pentium 3 (500 MHz) embedded system with
440BX chipset and 192 MB RAM. USB is handled by the 440BX (intel 82371
PIIX4). The UHCI driver shares interrupt 7 with an intel 82559ER 100
Mbit ethernet controller (which is driven by the e100 driver and active:
As there is no local keyboard, I access the system by ssh). 

The system "disk" is a 128 MB CF card directly connected to the 440BX
primary IDE port and running in PIO mode 2 at about 2 MB/sec peak (but
it is idle most of the time). There is a SM712 VGA chip running in text
mode, a 1000 HZ std PC timer, and no other "interesting" device (nothing
else on the PCI bus or causing any interrupts).

The error was reproduced with statically linked (no modules)
vanilla-2.6.11, 2.6.11-gentoo-r3, and
realtime-preempt-2.6.12-rc1-V0.7.41-11 kernels, all built with gcc
3.4.3.

I tried with two different sticks (an old 64 MB USB 1.x and a 1 GB USB
2.x), both show the same problem on all USB interfaces on the target.
The same dd command works fine on both sticks on my office PC. 

I suspect some kind of timing / bus / interrupt trouble, either due to
the interrupt shared between uhci and e100, or due to the extremely slow
PIO transfers (which seem to block interrupts).

What can I do to solve or further analyze the problem?

Thanks!

*** First example:

... trouble starts here:
Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: Command READ_10
(10 bytes)
Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage:  28 00 00 01 bd c0
00 00 f0 00
Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x38e L 122880 F 128 Trg 0 LUN 0 CL 10
Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 31/31
Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=0
Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_sglist: xfer 122880 bytes, 30 entries
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: Status code -75;
transferred 19840/122880
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: -- babble
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: Bulk data transfer
result 0x3
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: Attempting to get
CSW...
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: Status code -75;
transferred 13/13
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: -- babble
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: Bulk status result
= 3
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: -- transport
indicates error, resetting
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage:
usb_stor_Bulk_reset called
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage:
usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: Soft reset failed:
-32
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x70000
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.

... this error is repeated several times before being reported to the
SCSI layer...

Mar 30 10:47:17 OF455 kern.info kernel: SCSI error : <0 0 0 0> return
code = 0x70000
Mar 30 10:47:17 OF455 kern.warn kernel: end_request: I/O error, dev sda,
sector 114112
Mar 30 10:47:17 OF455 kern.err kernel: Buffer I/O error on device sda,
logical block 57056

... the same for block 57057, 57058, 57059

Mar 30 10:47:18 OF455 kern.info kernel: SCSI error : <0 0 0 0> return
code = 0x70000
Mar 30 10:47:18 OF455 kern.warn kernel: end_request: I/O error, dev sda,
sector 114118
Mar 30 10:47:18 OF455 kern.err kernel: Buffer I/O error on device sda,
logical block 57059

... now the device goes offline:

Mar 30 10:47:18 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 10:47:18 OF455 kern.debug kernel: usb-storage: Command READ_10
(10 bytes)
Mar 30 10:47:18 OF455 kern.debug kernel: usb-storage:  28 00 00 01 bd c8
00 00 e8 00
Mar 30 10:47:18 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x396 L 118784 F 128 Trg 0 LUN 0 CL 10
Mar 30 10:47:18 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: command_abort
called
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage:
usb_stor_stop_transport called
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: -- cancelling URB
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: Status code -104;
transferred 0/31
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: -- transfer
cancelled
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=4
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: -- command was
aborted
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage:
usb_stor_Bulk_reset called
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage:
usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: Soft reset failed:
-32
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: scsi command
aborted
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: Command
TEST_UNIT_READY (6 bytes)
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage:  00 00 00 00 00 00
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x396 L 0 F 0 Trg 0 LUN 0 CL 6
Mar 30 10:47:48 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: command_abort
called
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage:
usb_stor_stop_transport called
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: -- cancelling URB
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: Status code -104;
transferred 0/31
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: -- transfer
cancelled
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=4
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: -- command was
aborted
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage:
usb_stor_Bulk_reset called
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage:
usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: Soft reset failed:
-32
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: scsi command
aborted
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: device_reset
called
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage:
usb_stor_Bulk_reset called
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage:
usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: Soft reset failed:
-32
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: bus_reset called
Mar 30 10:47:58 OF455 kern.info kernel: usb 1-1.3: reset full speed USB
device using uhci_hcd and address 4
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: usb_reset_device
returns 0
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: Command
TEST_UNIT_READY (6 bytes)
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage:  00 00 00 00 00 00
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x396 L 0 F 0 Trg 0 LUN 0 CL 6
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 31/31
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=0
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage: Attempting to get
CSW...
Mar 30 10:47:58 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Mar 30 10:48:08 OF455 kern.debug kernel: usb-storage: command_abort
called
Mar 30 10:48:08 OF455 kern.debug kernel: usb-storage:
usb_stor_stop_transport called
Mar 30 10:48:08 OF455 kern.debug kernel: usb-storage: -- cancelling URB
Mar 30 10:48:08 OF455 kern.debug kernel: usb-storage: Status code -104;
transferred 0/13
Mar 30 10:48:08 OF455 kern.debug kernel: usb-storage: -- transfer
cancelled
Mar 30 10:48:08 OF455 kern.debug kernel: usb-storage: Bulk status result
= 4
Mar 30 10:48:08 OF455 kern.debug kernel: usb-storage: -- command was
aborted
Mar 30 10:48:08 OF455 kern.debug kernel: usb-storage:
usb_stor_Bulk_reset called
Mar 30 10:48:08 OF455 kern.debug kernel: usb-storage:
usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Mar 30 10:48:08 OF455 kern.debug kernel: usb-storage: Soft reset failed:
-32
Mar 30 10:48:08 OF455 kern.debug kernel: usb-storage: scsi command
aborted
Mar 30 10:48:08 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 10:48:08 OF455 kern.info kernel: scsi: Device offlined - not
ready after error recovery: host 0 channel 0 id 0 lun 0
Mar 30 10:48:08 OF455 kern.info kernel: SCSI error : <0 0 0 0> return
code = 0x50000
Mar 30 10:48:08 OF455 kern.warn kernel: end_request: I/O error, dev sda,
sector 114120
Mar 30 10:48:08 OF455 kern.err kernel: Buffer I/O error on device sda,
logical block 57060
Mar 30 10:48:08 OF455 kern.err kernel: scsi0 (0:0): rejecting I/O to
offline device


*** Second example, by far more dramatic:

... again, the first noticeable error is a short data read...

Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Command READ_10
(10 bytes)
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:  28 00 00 01 ba c0
00 00 f0 00
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x386 L 122880 F 128 Trg 0 LUN 0 CL 12
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 31/31
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=0
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_sglist: xfer 122880 bytes, 2 entries
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Status code -75;
transferred 82240/122880
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: -- babble
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Bulk data transfer
result 0x3
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Attempting to get
CSW...
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Status code -75;
transferred 13/13
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: -- babble
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Bulk status result
= 3
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: -- transport
indicates error, resetting
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_Bulk_reset called
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Mar 30 11:01:45 OF455 kern.debug kernel: uhci_hcd 0000:00:07.2:
uhci_result_control: failed with status 440000
Mar 30 11:01:45 OF455 kern.debug kernel: [cbc30240] link (0bc301e2)
element (0b8fb0c0)
Mar 30 11:01:45 OF455 kern.debug kernel:  Element != First TD
Mar 30 11:01:45 OF455 kern.debug kernel:   0: [cb8fb040] link (0b8fb0c0)
e3 Length=7 MaxLen=7 DT0 EndPt=0 Dev=5, PID=2d(SETUP) (buf=0bc34040)
Mar 30 11:01:45 OF455 kern.debug kernel:   1: [cb8fb0c0] link (00000001)
e0 IOC Stalled CRC/Timeo Length=7ff MaxLen=7ff DT1 EndPt=0 Dev=5,
PID=69(IN) (buf=00000000)
Mar 30 11:01:45 OF455 kern.debug kernel: 
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Soft reset failed:
-84
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x70000
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Command READ_10
(10 bytes)
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:  28 00 00 01 ba c0
00 00 f0 00
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x387 L 122880 F 128 Trg 0 LUN 0 CL 12
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Status code -71;
transferred 31/31
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: -- unknown error
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=4
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: -- transport
indicates error, resetting
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_Bulk_reset called
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Mar 30 11:01:45 OF455 kern.debug kernel: uhci_hcd 0000:00:07.2:
uhci_result_control: failed with status 440000
Mar 30 11:01:45 OF455 kern.debug kernel: [cbc302a0] link (0bc301e2)
element (0b8fb080)
Mar 30 11:01:45 OF455 kern.debug kernel:   0: [cb8fb080] link (0b8fb0c0)
e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=5, PID=2d(SETUP)
(buf=0bc34040)
Mar 30 11:01:45 OF455 kern.debug kernel:   1: [cb8fb0c0] link (00000001)
e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=5, PID=69(IN)
(buf=00000000)
Mar 30 11:01:45 OF455 kern.debug kernel: 
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Soft reset failed:
-71
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x70000
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Command READ_10
(10 bytes)
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:  28 00 00 01 ba c0
00 00 f0 00
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x388 L 122880 F 128 Trg 0 LUN 0 CL 12
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Status code -71;
transferred 31/31
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: -- unknown error
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=4
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: -- transport
indicates error, resetting
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_Bulk_reset called
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Mar 30 11:01:45 OF455 kern.debug kernel: uhci_hcd 0000:00:07.2:
uhci_result_control: failed with status 440000
Mar 30 11:01:45 OF455 kern.debug kernel: [cbc302a0] link (0bc301e2)
element (0b8fb080)
Mar 30 11:01:45 OF455 kern.debug kernel:   0: [cb8fb080] link (0b8fb0c0)
e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=5, PID=2d(SETUP)
(buf=0bc34040)
Mar 30 11:01:45 OF455 kern.debug kernel:   1: [cb8fb0c0] link (00000001)
e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=5, PID=69(IN)
(buf=00000000)
Mar 30 11:01:45 OF455 kern.debug kernel: 

...after some more of those errors...

Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Soft reset failed:
-71
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x70000
Mar 30 11:01:45 OF455 kern.info kernel: SCSI error : <1 0 0 0> return
code = 0x70000
Mar 30 11:01:45 OF455 kern.warn kernel: end_request: I/O error, dev sda,
sector 113344
Mar 30 11:01:45 OF455 kern.warn kernel: printk: 246 messages suppressed.
Mar 30 11:01:45 OF455 kern.err kernel: Buffer I/O error on device sda,
logical block 14168
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Command READ_10
(12 bytes)
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:  28 00 00 01 ba c8
00 00 e8 00 00 00
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x38b L 118784 F 128 Trg 0 LUN 0 CL 12
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Status code -71;
transferred 31/31
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: -- unknown error
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=4
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: -- transport
indicates error, resetting
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_Bulk_reset called
Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Mar 30 11:01:45 OF455 kern.debug kernel: uhci_hcd 0000:00:07.2:
uhci_result_control: failed with status 440000
Mar 30 11:01:45 OF455 kern.debug kernel: [cbc302a0] link (0bc301e2)
element (0b8fb080)
Mar 30 11:01:45 OF455 kern.debug kernel:   0: [cb8fb080] link (0b8fb0c0)
e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=5, PID=2d(SETUP)
(buf=0bc34040)
Mar 30 11:01:45 OF455 kern.debug kernel:   1: [cb8fb0c0] link (00000001)
e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=5, PID=69(IN)
(buf=00000000)

... now, it disables the old device, but immediately autodetects a new
one
... (I have *not* touched the stick!)
... and then crashes

Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: Command READ_10
(12 bytes)
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage:  28 00 00 01 bb c8
00 00 e8 00 00 00
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x3b3 L 118784 F 128 Trg 0 LUN 0 CL 12
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: Status code -19;
transferred 0/31
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: -- unknown error
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=4
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: -- transport
indicates error, resetting
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage:
usb_stor_Bulk_reset called
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage:
usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: Soft reset failed:
-19
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x70000
Mar 30 11:01:46 OF455 kern.info kernel: SCSI error : <1 0 0 0> return
code = 0x70000
Mar 30 11:01:46 OF455 kern.warn kernel: end_request: I/O error, dev sda,
sector 113608
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:46 OF455 kern.debug kernel: usb 1-2: usb_disable_device
nuking all URBs
Mar 30 11:01:46 OF455 kern.debug kernel: usb 1-2: unregistering
interface 1-2:1.0
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage:
storage_disconnect() called
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage:
usb_stor_stop_transport called
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: No command during
disconnect
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: --
usb_stor_release_resources
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: -- sending exit
command to thread
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: -- exit command
received
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: -- dissociate_dev
Mar 30 11:01:46 OF455 kern.debug kernel: usb 1-2:1.0: hotplug
Mar 30 11:01:46 OF455 kern.debug kernel: usb 1-2: unregistering device
Mar 30 11:01:46 OF455 kern.debug kernel: usb 1-2: hotplug
Mar 30 11:01:46 OF455 kern.debug kernel: hub 1-0:1.0: debounce: port 2:
total 100ms stable 100ms status 0x101
Mar 30 11:01:46 OF455 kern.info kernel: usb 1-2: new full speed USB
device using uhci_hcd and address 6
Mar 30 11:01:46 OF455 kern.debug kernel: usb 1-2: default language
0x0409
Mar 30 11:01:46 OF455 kern.debug kernel: usb 1-2: new device strings:
Mfr=0, Product=1, SerialNumber=2
Mar 30 11:01:46 OF455 kern.info kernel: usb 1-2: Product: ALi
Mar 30 11:01:46 OF455 kern.info kernel: usb 1-2: SerialNumber:
12345000000000000418
Mar 30 11:01:46 OF455 kern.debug kernel: usb 1-2: hotplug
Mar 30 11:01:46 OF455 kern.debug kernel: usb 1-2: adding 1-2:1.0 (config
#1, interface 0)
Mar 30 11:01:46 OF455 kern.debug kernel: usb 1-2:1.0: hotplug
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage 1-2:1.0:
usb_probe_interface
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage 1-2:1.0:
usb_probe_interface - got id
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: USB Mass Storage
device detected
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: -- associate_dev
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: Vendor: 0x0402,
Product: 0x5651, Revision: 0x0060
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: Interface
Subclass: 0x02, Protocol: 0x50
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: Transport: Bulk
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: Protocol: 8020i
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage:
usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: GetMaxLUN command
result is 1, data is 0
Mar 30 11:01:46 OF455 kern.info kernel: scsi2 : SCSI emulation for USB
Mass Storage devices
Mar 30 11:01:46 OF455 kern.debug kernel: hub 1-0:1.0: state 5 ports 2
chg 0000 evt 0004
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: device found at 6
Mar 30 11:01:46 OF455 kern.debug kernel: usb-storage: waiting for device
to settle before scanning
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Command INQUIRY (6
bytes)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:  12 00 00 00 24 00
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x1 L 36 F 128 Trg 0 LUN 0 CL 12
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 31/31
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 36 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 36/36
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk data transfer
result 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Attempting to get
CSW...
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 13/13
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk status result
= 0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Status S
0x53425355 T 0x1 R 0 Stat 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x0
Mar 30 11:01:51 OF455 kern.notice kernel:   Vendor: <7>usb-storage: ***
thread sleeping.
Mar 30 11:01:51 OF455 kern.warn kernel: ALi       Model: USB Flash Disk
Rev:     
Mar 30 11:01:51 OF455 kern.notice kernel:   Type:   Direct-Access
ANSI SCSI revision: 00
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Command
TEST_UNIT_READY (6 bytes)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:  00 00 00 00 00 00
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x2 L 0 F 0 Trg 0 LUN 0 CL 12
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 31/31
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Attempting to get
CSW...
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 13/13
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk status result
= 0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Status S
0x53425355 T 0x2 R 0 Stat 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Command
READ_CAPACITY (10 bytes)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:  25 00 00 00 00 00
00 00 00 00
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x3 L 8 F 128 Trg 0 LUN 0 CL 12
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 31/31
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 8 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 8/8
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk data transfer
result 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Attempting to get
CSW...
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 13/13
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk status result
= 0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Status S
0x53425355 T 0x3 R 0 Stat 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x0
Mar 30 11:01:51 OF455 kern.notice kernel: SCSI device sdb: 2046976
512-byte hdwr sectors (1048 MB)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.notice kernel: sdb: assuming Write Enabled
Mar 30 11:01:51 OF455 kern.err kernel: sdb: assuming drive cache: write
through
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Command
TEST_UNIT_READY (6 bytes)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:  00 00 00 00 00 00
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x4 L 0 F 0 Trg 0 LUN 0 CL 12
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 31/31
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Attempting to get
CSW...
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 13/13
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk status result
= 0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Status S
0x53425355 T 0x4 R 0 Stat 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Command
ALLOW_MEDIUM_REMOVAL (6 bytes)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:  1e 00 00 00 01 00
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x5 L 0 F 0 Trg 0 LUN 0 CL 12
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 31/31
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Attempting to get
CSW...
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 13/13
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk status result
= 0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Status S
0x53425355 T 0x5 R 0 Stat 0x1
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transport
indicates command failure
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Issuing
auto-REQUEST_SENSE
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x80000005 L 18 F 128 Trg 0 LUN 0 CL 12
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 31/31
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 18 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 18/18
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk data transfer
result 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Attempting to get
CSW...
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 13/13
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk status result
= 0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Status S
0x53425355 T 0x80000005 R 0 Stat 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- Result from
auto-sense is 0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- code: 0x70,
key: 0x5, ASC: 0x24, ASCQ: 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Illegal Request:
Invalid field in cdb
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x2
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Command
TEST_UNIT_READY (6 bytes)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:  00 00 00 00 00 00
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x6 L 0 F 0 Trg 0 LUN 0 CL 12
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 31/31
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Attempting to get
CSW...
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 13/13
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk status result
= 0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Status S
0x53425355 T 0x6 R 0 Stat 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Command
READ_CAPACITY (10 bytes)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:  25 00 00 00 00 00
00 00 00 00
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x7 L 8 F 128 Trg 0 LUN 0 CL 12
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 31/31
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 8 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 8/8
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk data transfer
result 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Attempting to get
CSW...
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 13/13
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk status result
= 0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Status S
0x53425355 T 0x7 R 0 Stat 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x0
Mar 30 11:01:51 OF455 kern.notice kernel: SCSI device sdb: 2046976
512-byte hdwr sectors (1048 MB)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.notice kernel: sdb: assuming Write Enabled
Mar 30 11:01:51 OF455 kern.err kernel: sdb: assuming drive cache: write
through
Mar 30 11:01:51 OF455 kern.info kernel:  sdb:<7>usb-storage:
queuecommand called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Command READ_10
(10 bytes)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:  28 00 00 00 00 00
00 00 08 00
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Command S
0x43425355 T 0x8 L 4096 F 128 Trg 0 LUN 0 CL 12
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 31/31
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk command
transfer result=0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 4096/4096
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk data transfer
result 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Attempting to get
CSW...
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Status code 0;
transferred 13/13
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: -- transfer
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk status result
= 0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bulk Status S
0x53425355 T 0x8 R 0 Stat 0x0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x0
Mar 30 11:01:51 OF455 kern.warn kernel:  unknown partition table
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.notice kernel: Attached scsi removable disk
sdb at scsi2, channel 0, id 0, lun 0
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bad target number
(1:0)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x40000
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bad target number
(2:0)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x40000
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bad target number
(3:0)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x40000
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bad target number
(4:0)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x40000
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bad target number
(5:0)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x40000
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bad target number
(6:0)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x40000
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: queuecommand
called
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
awakened.
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: Bad target number
(7:0)
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: scsi cmd done,
result=0x40000
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: device scan
complete
Mar 30 11:01:51 OF455 kern.debug kernel: usb-storage: *** thread
sleeping.
Mar 30 11:02:15 OF455 kern.debug kernel: usb-storage: command_abort
called
Mar 30 11:02:15 OF455 kern.debug kernel: usb-storage: -- nothing to
abort
Mar 30 11:02:15 OF455 kern.debug kernel: usb-storage: bus_reset called
Mar 30 11:02:15 OF455 kern.alert kernel: BUG: Unable to handle kernel
paging request at virtual address 80000101
Mar 30 11:02:15 OF455 kern.alert kernel:  printing eip:
Mar 30 11:02:15 OF455 kern.warn kernel: c012d3a6
Mar 30 11:02:15 OF455 kern.alert kernel: *pde = 00000000
Mar 30 11:02:15 OF455 kern.alert kernel: Oops: 0000 [#1]
Mar 30 11:02:15 OF455 kern.warn kernel: PREEMPT 
Mar 30 11:02:15 OF455 kern.warn kernel: CPU:    0
Mar 30 11:02:15 OF455 kern.warn kernel: EIP:    0060:[<c012d3a6>]    Not
tainted VLI
Mar 30 11:02:15 OF455 kern.warn kernel: EFLAGS: 00010046
(2.6.12-rc1-RT-V0.7.41-11) 
Mar 30 11:02:15 OF455 kern.warn kernel: EIP is at __up_mutex+0x66/0x270
Mar 30 11:02:15 OF455 kern.warn kernel: eax: 80000101   ebx: 80000101
ecx: 00000001   edx: cbc26204
Mar 30 11:02:15 OF455 kern.warn kernel: esi: 00000000   edi: c022f131
ebp: cbc33ed8   esp: cbc33ea8
Mar 30 11:02:15 OF455 kern.warn kernel: ds: 007b   es: 007b   ss: 0068
preempt: 00000003
Mar 30 11:02:15 OF455 kern.warn kernel: Process scsi_eh_1 (pid: 859,
threadinfo=cbc32000 task=c811daa0)
Mar 30 11:02:15 OF455 kern.warn kernel: Stack: 00000001 00000001
00000001 00000000 00000286 00000000 c811daa0 00000000 
Mar 30 11:02:15 OF455 kern.warn kernel:        cbc26204 00000000
cbc26204 c022f131 cbc33f04 c012da3e cbc26204 00000000 
Mar 30 11:02:15 OF455 kern.warn kernel:        c022f131 c022f12a
cb8191c0 00000000 cbc26200 cb8191c0 00000000 cbc33f20 
Mar 30 11:02:15 OF455 kern.warn kernel: Call Trace:
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c010325f>]
show_stack+0x8f/0xb0 (28)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0103415>]
show_registers+0x165/0x1e0 (56)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0103646>] die+0xf6/0x190
(64)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c010e8c4>]
do_page_fault+0x424/0x610 (216)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0102e87>]
error_code+0x2b/0x30 (108)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c012da3e>] down+0x4e/0xb0
(44)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c022f131>]
bus_reset+0x51/0x130 (28)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c02154c8>]
scsi_try_bus_reset+0x58/0xf0 (28)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c02156ca>]
scsi_eh_bus_reset+0x7a/0x120 (36)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0215c34>]
scsi_eh_ready_devs+0x64/0x90 (32)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0215dcc>]
scsi_unjam_host+0xcc/0xd0 (52)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0215e7b>]
scsi_error_handler+0xab/0xe0 (56)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0100d95>]
kernel_thread_helper+0x5/0x10 (876396564)
Mar 30 11:02:15 OF455 kern.warn kernel: Code: 31 00 00 8b 45 f0 8b 55 f0
8b 40 08 89 45 e8 c7 42 08 00 00 00 00 c7 45 e4 00 00 00 00 8b 02 39 d0
0f 84 ce 00 00 00 89 c3 31 f6 <8b> 00 0f 18 00 90 39 d3 0f 84 a5 01 00
00 31 c0 8d 7b fc 89 44 
Mar 30 11:02:15 OF455 kern.warn kernel:  <6>note: scsi_eh_1[859] exited
with preempt_count 2
Mar 30 11:02:15 OF455 kern.err kernel: BUG: scheduling while atomic:
scsi_eh_1/0x00000002/859
Mar 30 11:02:15 OF455 kern.warn kernel: caller is do_exit+0x1a6/0x330
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c01032a3>]
dump_stack+0x23/0x30 (20)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c02904c9>]
__schedule+0x579/0x7a0 (76)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0117316>]
do_exit+0x1a6/0x330 (44)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c01036df>] die+0x18f/0x190
(64)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c010e8c4>]
do_page_fault+0x424/0x610 (216)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0102e87>]
error_code+0x2b/0x30 (108)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c012da3e>] down+0x4e/0xb0
(44)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c022f131>]
bus_reset+0x51/0x130 (28)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c02154c8>]
scsi_try_bus_reset+0x58/0xf0 (28)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c02156ca>]
scsi_eh_bus_reset+0x7a/0x120 (36)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0215c34>]
scsi_eh_ready_devs+0x64/0x90 (32)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0215dcc>]
scsi_unjam_host+0xcc/0xd0 (52)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0215e7b>]
scsi_error_handler+0xab/0xe0 (56)
Mar 30 11:02:15 OF455 kern.warn kernel:  [<c0100d95>]
kernel_thread_helper+0x5/0x10 (876396564)


Klaus Kusche
> Entwicklung Software - Steuerung
> Software Development - Control
> 
> KEBA AG
> A-4041 Linz
> Gewerbepark Urfahr
> Tel +43 / 732 / 7090-3120
> Fax +43 / 732 / 7090-8919
> E-Mail: kus@keba.com
> www.keba.com
> 
> 
