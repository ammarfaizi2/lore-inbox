Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263862AbRFIEoM>; Sat, 9 Jun 2001 00:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263835AbRFIEoC>; Sat, 9 Jun 2001 00:44:02 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:450 "EHLO e34.bld.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263797AbRFIEnu>;
	Sat, 9 Jun 2001 00:43:50 -0400
Importance: Normal
Subject: RE: question about scsi generic behavior
To: hiren_mehta@agilent.com
Cc: alan@lxorguk.ukuu.org.uk, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFF4454C7B.BC9A8CEC-ON88256A66.0016A013@LocalDomain>
From: "David Chambliss" <chamb@almaden.ibm.com>
Date: Fri, 8 Jun 2001 21:40:33 -0700
X-MIMETrack: Serialize by Router on D03NM042/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 06/08/2001 09:42:32 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hiren,
I think you are misunderstanding the parms of sg_dd (as I was, in my first
response).  <count> is the number of blocks, right?  It is transferring one
block, as you requested.  You lied to it and told it the block size was
2048.  It is a quite sensible choice for it to ignore this when a block
device is used, and use the actual block size (and therefore set FCP_DL =
512).  Alternatively, it could trust you, prepare a 2048-byte buffer, fill
it from /dev/zero, and set FCP_DL=2048.  Either way the behavior required
of the disk is to write one block.

If you want to write 2048 bytes (4 blocks) then may I recommend:
sg_dd if=/dev/zero of=/dev/sg5 count=4,

BTW, there is a clear difference in meaning between FCP_DL and any
length-determining fields in the CDB (such as the block count in READ or
WRITE).  FCP_DL specifies an upper limit to the amount of data transferred.
If FCP_DL exceeds the data length implied by processing of the command, it
is not an error.  The device server is *required* to complete the command
per the CDB, performing the necessary data transfers.  When FCP_RSP is
sent, the RESID field and the underrun bit are set appropriately.  The SCSI
status is unchanged by the existence of an underrun.  For some important
commands (like INQUIRY) an underrun is a typical outcome.

The meaning of the SCSI CDB is *never* modified to match the FCP_DL value.
The closest we get is in an overrun case.  When target processing tries to
make a transfer that goes past FCP_DL, the FCP_RSP is sent and the SCSI
task is terminated.  Usually no data is transferred or written to media,
though this is not a requirement of the standard.

David

Hiren Mehta wrote:

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
-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org



