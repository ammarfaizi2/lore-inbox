Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTFBNtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 09:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTFBNtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 09:49:53 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:23267 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S262324AbTFBNtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 09:49:50 -0400
To: Oliver Neukum <oliver@neukum.org>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 with 250Gb disk and insane loads
References: <3EDA0E5D.8080404@pacbell.net>
	<200306011653.47958.oliver@neukum.org>
	<87k7c5g738.fsf@lapper.ihatent.com>
	<200306012021.41147.oliver@neukum.org>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 02 Jun 2003 16:03:18 +0200
In-Reply-To: <200306012021.41147.oliver@neukum.org>
Message-ID: <87llwkpoex.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Oliver Neukum <oliver@neukum.org> writes:

> > > Probably the block layer as it waits for free io slots.
> > > But that doesn't tell us why the requests are not executed.
> > > Where is SCSI timeout kicking in?
> >
> > I'm not seeing any scsi timeouts in the logs.
> 
> So it seems that the driver doesn't fail utterly, but crawls along.
> Storage's debugging output should clarify the situation.
> 

I had a private reply form a guy that had three of these running
reliably on 2.4.21-pre6, and he noted he'd never done cd->disk
transfers, but across the net. So I did the same.

Results are that it survived a lot longer, I managed to get about
700Mb across at about 8Mb/s (line speed 100mbit half duplex) before it
fell over with this:

usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0xc42 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 18 f0 34 47 00 04 00 00
usb-storage: Bulk command S 0x43425355 T 0xc43 Trg 0 LUN 0 L 524288 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 524288 bytes, 128 entries
usb-storage: Status code 0; transferred 524288/524288
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: usb_storage_command_abort called
usb-storage: usb_stor_stop_transport called
usb-storage: -- cancelling URB
usb-storage: Status code -104; transferred 0/13
usb-storage: -- transfer cancelled
usb-storage: Bulk status result = 3
usb-storage: -- command was aborted
usb-storage: Bulk reset requested
usb-storage: Soft reset: clearing bulk-in endpoint halt
usb-storage: Soft reset: clearing bulk-out endpoint halt
usb-storage: Soft reset done
usb-storage: scsi command aborted
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk command S 0x43425355 T 0xc43 Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0xc43 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.

Load only got up to about 3-4 before it fell over.

Apart from that, it seems the speed at which it falls over is depening
on two factors: with/without debugging and speed at which data arrives
for the drive.

Using a ssh-session that limited it to 3Mb/sec and it ran fine for a
long time with interrupts showing at about 5000 a second for the
usb-controller (vs. 1000 for the timer). With the example above that
made it fall over it ran at close to 10k interrupts/sec.

If it makes a difference, transferring from a local CD-ROM to the
drive across USB 2.0 also uses ide-scsi. The 2.4 example I had falling
over used no ide-scsi.

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+21kjCQ1pa+gRoggRAiV4AJ9OAqrgeSP5WzwkonApbZtNPDOd1QCfTz68
81LU78RHkdpIlLNPD6Bgr6g=
=4Lmd
-----END PGP SIGNATURE-----
