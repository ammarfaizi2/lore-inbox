Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUCKGvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 01:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUCKGvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 01:51:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39648 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262905AbUCKGva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 01:51:30 -0500
Date: Thu, 11 Mar 2004 07:51:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Itay Ben-Yaacov <pezz@math.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd detects wrong DVD size
Message-ID: <20040311065119.GC6955@suse.de>
References: <20040311050558.GA7497@pisica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311050558.GA7497@pisica>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11 2004, Itay Ben-Yaacov wrote:
> 
> Hi,
> 
> There appears to be a bug in ide-cd.c, which makes it unusable for
> playing DVDs -- at some point it just stops reading.  This bug does
> not exist when using ide-scsi (I heard reports that short DVDs are OK).
> The reason seems to be in a wrong detected size:
> "blockdev --getsize"   gives different results
> with ide-cd and with ide-scsi+sr_mod, the latter being the correct
> one.
> 
> I believe I tracked the problem to        "cdrom_read_toc()":
> The following (lines 2304-2310) sets the correct capacity (line
> numbers are from 2.6.3):
> 
> 
> 
> 	/* Try to get the total cdrom capacity and sector size. */
> 	stat = cdrom_read_capacity(drive, &toc->capacity,
> &sectors_per_frame,
> 				   sense);
> 	if (stat)
> 		toc->capacity = 0x1fffff;
> 
> 	set_capacity(drive->disk, toc->capacity * sectors_per_frame);
> 
> 
> 
> But a bit later, on lines 2420-2425, it gets set again, this time to a
> wrong value:
> 
> 
> 
> 	/* Now try to get the total cdrom capacity. */
> 	stat = cdrom_get_last_written(cdi, &last_written);
> 	if (!stat && last_written) {
> 		toc->capacity = last_written;
> 		set_capacity(drive->disk, toc->capacity *
> sectors_per_frame);
> 	}

Could have sworn this was already fixed. Change the 2nd occurence to:

        if (!toc->capacity || toc->capacity == 0x1fffff) {
                stat = cdrom_get_last_written(cdi, &last_written);
                if (!stat && last_written) {
                        toc->capacity = last_written;
                        set_capacity(drive->disk, toc->capacity *
sectors_per_frame);
                }
        }

Thanks for tracking this down and reporting.

-- 
Jens Axboe

