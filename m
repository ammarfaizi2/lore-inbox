Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVKWQYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVKWQYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVKWQYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:24:15 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:61901 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751162AbVKWQYO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:24:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OecWWXj1Rq8n2lx9p96Ygsqll2ahs0q5Djoywt2dvtlmZloxrs9juCSY6I2kJw9t7w2F3q8cp2c5z3W9kB8xUvyH+9Uk3Xu+W3xPxI39R75A1Cy01tqeegJ6HCHYGhCLvAbh4ejIOblR3gZJgbnmIwnBMMJOlu9AKvf4G/Tiu7Q=
Message-ID: <58cb370e0511230824j2585d755vdd9b6b780ed0fed3@mail.gmail.com>
Date: Wed, 23 Nov 2005 17:24:12 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: [Q] is queue->hardsect_size respected?
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm hacking on ide-cd.c and I've noticed that some old code
(PIO handing for read fs requests) still supports unaligned access:

static ide_startstop_t cdrom_start_read_continuation (ide_drive_t *drive)
{
	struct request *rq = HWGROUP(drive)->rq;
	unsigned short sectors_per_frame;
	int nskip;

	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;

	/* If the requested sector doesn't start on a cdrom block boundary,
	   we must adjust the start of the transfer so that it does,
	   and remember to skip the first few sectors.
	   If the CURRENT_NR_SECTORS field is larger than the size
	   of the buffer, it will mean that we're to skip a number
	   of sectors equal to the amount by which CURRENT_NR_SECTORS
	   is larger than the buffer size. */
	nskip = rq->sector & (sectors_per_frame - 1);
	if (nskip > 0) {
		/* Sanity check... */
		if (rq->current_nr_sectors != bio_cur_sectors(rq->bio) &&
			(rq->sector & (sectors_per_frame - 1))) {
			printk(KERN_ERR "%s: cdrom_start_read_continuation: buffer botch (%u)\n",
				drive->name, rq->current_nr_sectors);
			cdrom_end_request(drive, 0);
			return ide_stopped;
		}
		rq->current_nr_sectors += nskip;
	}
...

static ide_startstop_t cdrom_read_intr (ide_drive_t *drive)
...
	/* First, figure out if we need to bit-bucket
	   any of the leading sectors. */
	nskip = min_t(int, rq->current_nr_sectors - bio_cur_sectors(rq->bio),
sectors_to_transfer);

	while (nskip > 0) {
		/* We need to throw away a sector. */
		static char dum[SECTOR_SIZE];
		HWIF(drive)->atapi_input_bytes(drive, dum, sizeof (dum));

		--rq->current_nr_sectors;
		--nskip;
		--sectors_to_transfer;
	}
...

is this still a case in 2.6 or can I safely remove it?

Cheers,
Bartlomiej
