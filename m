Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279705AbRKBDZ1>; Thu, 1 Nov 2001 22:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280533AbRKBDZS>; Thu, 1 Nov 2001 22:25:18 -0500
Received: from dsl-64-192-96-25.telocity.com ([64.192.96.25]:8849 "EHLO
	orr.falooley.org") by vger.kernel.org with ESMTP id <S279705AbRKBDZL>;
	Thu, 1 Nov 2001 22:25:11 -0500
Date: Thu, 1 Nov 2001 22:24:55 -0500
From: Jason Lunz <j@falooley.org>
To: linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com
Subject: new aic7xxx bug, 2.4.13/6.2.4
Message-ID: <20011101222455.A5885@orr.falooley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having troubles with the last few revisions of the new Gibbs aic7xxx
driver that until now has served me well. This is kernel
2.4.13-preempt-lvmrc4 with the 6.2.4 scsi driver, but I saw it happen on
2.4.12 with 6.2.1. I haven't tried older versions with this CD.

When trying to rip a particular audio CD with cdrdao 1.1.5, I get this
error:

?: Input/output error.  : scsi sendcmd: retryable error
CDB:  42 00 40 03 00 00 03 00 30 00
status: 0x0 (GOOD STATUS)
cmd finished after 45.934s timeout 20s
WARNING: Cannot read ISRC code.
Track 4...
?: No such device or address. Cannot send SCSI cmd via ioctl

And this appears in the kernel output:

VFS: Disk change detected on device sr(11,1)
scsi0:0:3:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x7
ACCUM = 0x16, SINDEX = 0x37, DINDEX = 0x24, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0x0
 DFCNTRL = 0x0, DFSTATUS = 0x2d
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x5, SSTAT1 = 0xa
STACK == 0x3, 0x186, 0x156, 0x0
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 0:3 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Pending list: 3
Kernel Free SCB list: 1 0 
Untagged Q(3): 3 
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
(scsi0:A:3:0): Queuing a recovery SCB
scsi0:0:3:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:3:0): Abort Message Sent
(scsi0:A:3:0): SCB 3 - Abort Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 0x2002
(scsi0:A:3:0): Unexpected busfree in Command phase
SEQADDR == 0x15c
scsi0:0:3:0: Attempting to queue a TARGET RESET message
scsi0:0:3:0: Command not found
aic7xxx_dev_reset returns 0x2002
scsi0:0:3:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x7
ACCUM = 0xf7, SINDEX = 0x37, DINDEX = 0x24, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0x0
 DFCNTRL = 0x0, DFSTATUS = 0x2d
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x5, SSTAT1 = 0xa
STACK == 0x3, 0x186, 0x156, 0x35
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 0:3 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Pending list: 3
Kernel Free SCB list: 1 0 
Untagged Q(3): 3 
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
(scsi0:A:3:0): Queuing a recovery SCB
scsi0:0:3:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:3:0): Abort Message Sent
(scsi0:A:3:0): SCB 3 - Abort Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 0x2002
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 3 lun 0

After this, subsequent attempts to use that drive fail. Trying to mount
a data CD, for example, now gives:

[orr](0) % mount /cdrom
mount: No medium found

with this in dmesg:

cdrom: open failed.
VFS: Disk change detected on device sr(11,1)

Some other information follows.

/proc/scsi/scsi:

Attached devices: 
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0d
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-305  Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02


/proc/scsi/aic7xxx/0:

Adaptec AIC7xxx driver version: 6.2.4
aic7880: Single Channel A, SCSI Id=7, 16/253 SCBs
Channel A Target 0 Negotiation Settings
	User: 10.000MB/s transfers (10.000MHz, offset 255)
Channel A Target 1 Negotiation Settings
	User: 8.064MB/s transfers (8.064MHz, offset 255)
Channel A Target 2 Negotiation Settings
	User: 10.000MB/s transfers (10.000MHz, offset 255)
	Goal: 10.000MB/s transfers (10.000MHz, offset 15)
	Curr: 10.000MB/s transfers (10.000MHz, offset 15)
	Channel A Target 2 Lun 0 Settings
		Commands Queued 94
		Commands Active 0
		Command Openings 1
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Channel A Target 3 Negotiation Settings
	User: 10.000MB/s transfers (10.000MHz, offset 255)
	Goal: 10.000MB/s transfers (10.000MHz, offset 15)
	Curr: 10.000MB/s transfers (10.000MHz, offset 15)
	Channel A Target 3 Lun 0 Settings
		Commands Queued 977404
		Commands Active 0
		Command Openings 1
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Channel A Target 4 Negotiation Settings
	User: 10.000MB/s transfers (10.000MHz, offset 255)
Channel A Target 5 Negotiation Settings
	User: 10.000MB/s transfers (10.000MHz, offset 255)
Channel A Target 6 Negotiation Settings
	User: 10.000MB/s transfers (10.000MHz, offset 255)
Channel A Target 7 Negotiation Settings
	User: 10.000MB/s transfers (10.000MHz, offset 255)


I'm happy to help investigate further if there's anything you want to
try. Let me know if you need any other output or have a patch I can try
out.

Jason
