Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317115AbSGIERi>; Tue, 9 Jul 2002 00:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317300AbSGIERi>; Tue, 9 Jul 2002 00:17:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22795 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317115AbSGIERh>;
	Tue, 9 Jul 2002 00:17:37 -0400
Message-ID: <3D2A6608.7C43EE3@zip.com.au>
Date: Mon, 08 Jul 2002 21:26:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Douglas Gilbert <dougg@torque.net>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       linux-kernel@vger.kernel.org
Subject: Re: direct-to-BIO for O_DIRECT
References: <3D2A5F34.F38B893F@torque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> 
> Ingo Oeser wrote:
> 
> >On Sun, Jul 07, 2002 at 08:19:33PM -0700, Andrew Morton wrote:
> > > Question is: what do we want to do with this sucker?  These are the
> > > remaining users of kiovecs:
> > >
> > >       drivers/md/lvm-snap.c
> > >       drivers/media/video/video-buf.c
> > >       drivers/mtd/devices/blkmtd.c
> > >       drivers/scsi/sg.c
> > >
> > > the video and mtd drivers seems to be fairly easy to de-kiobufize.
> > > I'm aware of one proprietary driver which uses kiobufs.  XFS uses
> > > kiobufs a little bit - just to map the pages.
> >
> > It would be nice if we could just map a set of user pages to a scatterlist.
> 
> After disabling kiobufs in sg I would like such a drop
> in replacement.

Ben had lightweight sg structures called `kvecs' and `kveclets'. And
library functions to map pages into them.  And code to attach them
to BIOs.  So we'll be looking at getting that happening.

The other common requirement (used in several places in the kernel,
and in LVM2) is the ability to perform bulk I/O against a blockdev - simply
read and write a chunk of disk into a list of kernel pages.  So we'll need a
library function for that.   And the O_DIRECT/raw implementation can be bent
around to use those things.

> > Developers of mass transfer devices (video grabbers, dsp devices, sg and
> > many others) would just LOVE you for this ;-)
> 
> Agreed. Tape devices could be added to your list.
> Large page support will make for very efficient zero
> copy IO.

Haven't thought about large pages.  We don't seem to have an implementation of
them yet, and I'm not sure how the DMA mapping API would get along with
them.

-
