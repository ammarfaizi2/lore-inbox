Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264428AbRFIB1x>; Fri, 8 Jun 2001 21:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264429AbRFIB1m>; Fri, 8 Jun 2001 21:27:42 -0400
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:7678 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S264428AbRFIB11>; Fri, 8 Jun 2001 21:27:27 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880AAA@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: alan@lxorguk.ukuu.org.uk, hiren_mehta@agilent.com
Cc: chamb@almaden.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: RE: question about scsi generic behavior
Date: Fri, 8 Jun 2001 19:27:20 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the problem is not with non-512byte block device. The problem is
if the device is 512 byte block-sized device and if you use sg_dd with
bs=1024 or bs=2048, then it fails. I can understand if this fails
on a sequential device. But this fails on a disk. To be specific,
the problem is this : in case of fibre channel, you can specify
the FCP_DL in addition to the transfer-length which goes into CDB.
Now, when e.g. we use the following command,

sg_dd if=/dev/zero of=/dev/sg5 bs=2048 count=1,

and if in the low-level driver, we set the FCP_DL to 2048 and
in the CDB portition of FCP_CMND if we set the transfer-length to 1,
then the drive may not honour the FCP_DL and just look at the
transfer-length
and send XFER_RDY for 512 byte data. Once the HBA transfers the 512 byte of
data, then drive will send FCP_STATUS with status=good. Well, if you
look at it, we want to transfer 2048 bytes of data to the device, 
whereas the device completes the command with good status after 
transferring only 512 bytes. I hope this is more clear.

I guess, probably the sg driver is  probably not looking at the block 
size information returned in response to READ_CAPACITY command.

Regards,
-hiren
(408)970-3062
hiren_mehta@agilent.com

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Friday, June 08, 2001 5:37 PM
> To: hiren_mehta@agilent.com
> Cc: chamb@almaden.ibm.com; linux-scsi@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: question about scsi generic behavior
> 
> 
> > Hardcoding  of block size to 512 bytes for disk devices is 
> what currently 
> > either the block device driver or the sd driver is doing. 
> Because, if
> 
> I'm using 2048 byte block sized scsi media just fine. I've 
> not tried using
> sg on the same device
> 
