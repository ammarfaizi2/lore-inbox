Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290056AbSBFElM>; Tue, 5 Feb 2002 23:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290028AbSBFElE>; Tue, 5 Feb 2002 23:41:04 -0500
Received: from gear.torque.net ([204.138.244.1]:30478 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S290020AbSBFEk5>;
	Tue, 5 Feb 2002 23:40:57 -0500
Message-ID: <3C60B3B6.B2103C33@torque.net>
Date: Tue, 05 Feb 2002 23:40:22 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Ralf Oehler <R.Oehler@GDAmbH.com>, Scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: one-line-patch against SCSI-Read-Error-BUG()
In-Reply-To: <XFMail.20020205153210.R.Oehler@GDAmbH.com> <20020205152434.A16105@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Tue, Feb 05 2002, Ralf Oehler wrote:
> > Hi, List
> >
> > I think, I found a very simple solution for this annoying BUG().
> 
> You fail to understand that the BUG triggering indicates that their is a
> BUG _somewhere_ -- the triggered BUG is not the bug itself, of course,
> that would be stupid :-)
> 
> > Since at least kernel 2.4.16 there is a BUG() in pci.h,
> > that crashes the kernel on any attempt to read a SCSI-Sector
> > from an erased MO-Medium and on any attempt to read
> > a sector from a SCSI-disk, which returns "Read-Error".
> >
> > There seems to be a thinko in the corresponding code, which
> > does not take into account the case where a SCSI-READ
> > does not return any data because of a "sense code: read error"
> > or a "sense code: blank sector".
> >
> > I simply commented out this BUG() statement (see below)
> > and everything worked well from there on. The BUG()
> > seems to be inadequate.
> 
> The BUG is dangerous, because it means mapping DMA to a 0 address (plus
> offset). Naturally there is no way in hell your "fix" will be applied,
> since it a pretty bad bandaid.
> 
> A safer solution for you right now would be to just terminate the
> mapping when you encounter this. So something ala
> 
>         if (!sg[i].page && !sg[i].address)
>                 return i;
> 
> That's not a bug fix either, but at least it's safer than your version.
> Stock kernel won't be patched until the real problem is found, though.

Jens,
The sg driver was tripping that BUG() and I have submitted
a patch for that. However Ralf probably wasn't using sg
to read his MO disk.

There are several uses of "sgpnt[i].address" in scsi_lib.c that
you might like to look at. Can't see any other uses in sd, sr
or the mid level. Another possibility is a missing memset or
explicit NULL initialisation on a scatterlist array.

Doug Gilbert
