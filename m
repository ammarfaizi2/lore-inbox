Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbTAATGv>; Wed, 1 Jan 2003 14:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbTAATGv>; Wed, 1 Jan 2003 14:06:51 -0500
Received: from alb-24-29-45-178.nycap.rr.com ([24.29.45.178]:5380 "EHLO
	ender.tmmz.net") by vger.kernel.org with ESMTP id <S265077AbTAATGt>;
	Wed, 1 Jan 2003 14:06:49 -0500
Date: Wed, 1 Jan 2003 14:19:54 -0500 (EST)
From: Matthew Zahorik <matt@albany.net>
X-X-Sender: matt@ender.tmmz.net
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: sd driver NOT_READY behavior / was Re: How does the disk buffer
 cache work?
In-Reply-To: <3E10F1C7.258629F6@digeo.com>
Message-ID: <Pine.BSF.4.43.0301011400060.370-100000@ender.tmmz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2002, Andrew Morton wrote:

> Matthew Zahorik wrote:
> >
> > Earlier I wrote to the list where my SS10 hung on the partition check
> > if a bad disk was installed.
>
> lock_page() will sleep until the page is unlocked.  The page is unlocked
> from end_buffer_io_sync(), which is called from within the context of
> the disk device driver's interrupt handler.
>
> This is probably a device driver or interrupt routing problem: the disk
> controller hardware interrupts are not making it through to the CPU.

Found the problem, don't know how to fix it.  2.4.20 kernel.

The bad drive is returning "NOT READY" to sd.  According to this code in
scsi_lib.c/scsi_io_completion():

               if ((SCpnt->sense_buffer[0] & 0x7f) == 0x70) {
                        /*
                         * If the device is in the process of becoming ready,
                         * retry.
                         */
                        if (SCpnt->sense_buffer[12] == 0x04 &&
                            SCpnt->sense_buffer[13] == 0x01) {
                                scsi_queue_next_request(q, SCpnt);
                                return;
                        }

My sense is [0] = 0x70, [2] = 0x2 (not ready) [12] = 4 [13] = 1.

Unfortunately, the drive never becomes ready.  Therefore the request is
resubmitted, forever.  Therefore the sector read never returns success,
therefore you hang on read or write of a drive that returns NOT_READY
forever.  Therefore I'm hanging on the read of the partition table,
therefore my kernel won't start with a bad drive in the system.

2.2 behavior was different.  A not ready would be labeled as a SCSI error
and the failure to read was passed up through the layers.

Now, I could put that beahavior back, where a NOT_READY is a fatal error,
but I'm afraid to screw up other situations where NOT_READY means you
should wait a little longer. (hot plug, removables, etc?)

What is the correct behavior that I should implement?

a.  if !removable && not ready then error
b.  if not ready then increase count until threshold then error
c   if not ready then error
d.  none of the above

Thanks!

- Matt

