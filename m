Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbUCKFGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 00:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUCKFGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 00:06:09 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:40871 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261452AbUCKFGF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 00:06:05 -0500
Date: Thu, 11 Mar 2004 00:06:00 -0500
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: ide-cd detects wrong DVD size
Message-ID: <20040311050558.GA7497@pisica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Itay Ben-Yaacov <pezz@math.mit.edu>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [68.163.225.74] at Wed, 10 Mar 2004 23:06:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

There appears to be a bug in ide-cd.c, which makes it unusable for
playing DVDs -- at some point it just stops reading.  This bug does
not exist when using ide-scsi (I heard reports that short DVDs are OK).
The reason seems to be in a wrong detected size:
"blockdev --getsize"   gives different results
with ide-cd and with ide-scsi+sr_mod, the latter being the correct
one.

I believe I tracked the problem to        "cdrom_read_toc()":
The following (lines 2304-2310) sets the correct capacity (line
numbers are from 2.6.3):



	/* Try to get the total cdrom capacity and sector size. */
	stat = cdrom_read_capacity(drive, &toc->capacity,
&sectors_per_frame,
				   sense);
	if (stat)
		toc->capacity = 0x1fffff;

	set_capacity(drive->disk, toc->capacity * sectors_per_frame);



But a bit later, on lines 2420-2425, it gets set again, this time to a
wrong value:



	/* Now try to get the total cdrom capacity. */
	stat = cdrom_get_last_written(cdi, &last_written);
	if (!stat && last_written) {
		toc->capacity = last_written;
		set_capacity(drive->disk, toc->capacity *
sectors_per_frame);
	}



Why is this second capacity setting there, and what is it
supposed to do exactly?

Thanks,
Itay
