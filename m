Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbTLBTN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTLBTNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:13:25 -0500
Received: from havoc.gtf.org ([63.247.75.124]:54164 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264280AbTLBTND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:13:03 -0500
Date: Tue, 2 Dec 2003 14:06:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Greg Stark <gsstark@mit.edu>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Erik Steffl <steffl@bigfoot.com>,
       linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
Message-ID: <20031202190646.GA9043@gtf.org>
References: <3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv> <3FCBB15F.7050505@rackable.com> <3FCBB9F1.2080300@bigfoot.com> <87n0abbx2k.fsf@stark.dyndns.tv> <20031202055336.GO1566@mis-mike-wstn.matchmail.com> <20031202055852.GP1566@mis-mike-wstn.matchmail.com> <87zneb9o5q.fsf@stark.dyndns.tv> <20031202180241.GB1990@gtf.org> <87iskz9hp6.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iskz9hp6.fsf@stark.dyndns.tv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 01:51:17PM -0500, Greg Stark wrote:
> 
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> > If true, this is an IDE driver bug...  assuming the drive itself
> > doesn't lie about FLUSH CACHE results (a few do).
> 
> I don't think the IDE drivers issue FLUSH CACHE after every write on O_SYNC,
> or after fsync calls. The "lying" discussed on the database lists is when a
> normal write is issued, IDE disks report immediate success even before the
> write hits disk. As far as I know from the lists it seems *all* IDE disks
> behave this way unless write caching is disabled.

The way CONFIG_IDE (the traditional IDE driver) and libata work right
now, when the drive indicates that the read/write is complete, the OS
driver indicates to the filesystem that the data transaction is
complete.

So, today, no acknowledgement occurs until the data _really_ is in the
drive's buffers.

That said, "the database lists" may be seeing page cache effects.
write(2) will certainly report success long before the data transaction
is even sent to the driver!  You must fsync(2) to flush data from the
page cache to the IDE driver.


> This doesn't happen with SCSI disks where multiple requests can be pending so
> there's no urgency to reporting a false success. The request doesn't complete
> until the write hits disk. As a result SCSI disks are reliable for database
> operation and IDE disks aren't unless write caching is disabled.

This is not really true.

Regardless of TCQ, if the OS driver has not issued a FLUSH CACHE (IDE)
or SYNCHRONIZE CACHE (SCSI), then the data is not guaranteed to be on
the disk media.  Plain and simple.

If fsync(2) returns without a flush-cache, then your data is not
guaranteed to be on the disk.  And as you noted, flush-cache destroys
performance.


> I'm unclear on which of your #2 or #3 will be the solution though. Do either
> or both of them require that writes actually hit disk before the drive reports
> success? Do either of them allow that semantic without destroying concurrent
> performance?

There are three levels:

a) Data is successfully transferred to the controller/drive queue (TCQ).
b) Data is successfully transferred to the drive's internal buffers.
c) The drive successfully transfers data to the media.

Acknowledgement of (a) is basically instantaneous.  The OS driver simply
adds a drive read/write command to a list that the host controller can
see.

Acknowledgement of (b) happens fairly rapidly, limited by the device's
throughput and seek times, internal buffer load (amount of work todo),
and internal algorithms.

Acknowledgement of (c) _never_ occurs.  One must issue the flush-cache
drive command to be certain that the drive has flushed its write
buffers.

	Jeff



