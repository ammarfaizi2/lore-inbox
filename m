Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288752AbSA0Vox>; Sun, 27 Jan 2002 16:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSA0Voo>; Sun, 27 Jan 2002 16:44:44 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:3846 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288757AbSA0Voc>; Sun, 27 Jan 2002 16:44:32 -0500
Message-ID: <3C5472F3.52549F23@zip.com.au>
Date: Sun, 27 Jan 2002 13:36:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Robert Love <rml@tech9.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au> <1012166472.812.7.camel@phantasy>,
		<1012166472.812.7.camel@phantasy> <20020127222551.B7548@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Sun, Jan 27 2002, Robert Love wrote:
> > On Fri, 2002-01-25 at 03:40, Andrew Morton wrote:
> > > Reading audio from IDE CDROMs always uses PIO.  This patch
> > > teaches the kernel to use DMA for the CDROMREADAUDIO ioctl.
> > > [...]
> > > This code has not been tested for its effects upon SCSI-based
> > > CDROM readers.  It needs to be.
> >
> > Andrew,
> >
> > I wanted to confirm success of testing the patch with a SCSI CD-ROM
> > (Plextor UltraPlex Wide on aic7xxx).  I used your updated patch off your
> > website.
> >
> > Audio rip completed without error.  Performance seems the same, which I
> > assume is to be expected with SCSI readers.
> 
> sr already uses DMA for all transfers, so no performance gain was to be
> expected there. problem is ide-cd using pio for all packet command data
> transfers currently (modulo fs read write requests, of course)

Yup.  Rob was looking for regression - I'm not set up to test
SCSI CDROMs here.

The second patch goes back to reading a bunch of frames all
inside the same request, rather than one frame at a time.  This
is because the cdparanoia guys tell me that it can prevent
single-request overruns and underruns and other data loss which
occurs around the start and end of the request.  So with a walking-window
read algorithm from userspace they can pick up data which would
otherwise be lost.

Also it seems that some devices aren't happy with the larger transfers,
so it looks like the algorithm needs to become:

- Try multiple frames, DMA
- If that fails, try single frames, DMA
- If that fails, fall back to PIO

While all the time not altering the DMA status of the drive for
block-based filesystem I/O.

> not a whole lot of pio aic7xxx adapters out there :-)
> 

Thank heavens for that (I _knew_ I shouldn't have stuck my
nose in drivers/ide/).

-
