Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbTLBUKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTLBUKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:10:40 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:48028 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264351AbTLBUK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:10:29 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg Stark <gsstark@mit.edu>, Mike Fedyk <mfedyk@matchmail.com>,
       Erik Steffl <steffl@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
References: <3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv>
	<3FCBB15F.7050505@rackable.com> <3FCBB9F1.2080300@bigfoot.com>
	<87n0abbx2k.fsf@stark.dyndns.tv>
	<20031202055336.GO1566@mis-mike-wstn.matchmail.com>
	<20031202055852.GP1566@mis-mike-wstn.matchmail.com>
	<87zneb9o5q.fsf@stark.dyndns.tv> <20031202180241.GB1990@gtf.org>
	<87iskz9hp6.fsf@stark.dyndns.tv> <20031202190646.GA9043@gtf.org>
In-Reply-To: <20031202190646.GA9043@gtf.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 02 Dec 2003 15:10:19 -0500
Message-ID: <877k1f9e1g.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> So, today, no acknowledgement occurs until the data _really_ is in the
> drive's buffers.

The drive's buffers isn't good enough. If power is lost the write will be lost
and the database corrupt. It needs to be on the platters.


> > This doesn't happen with SCSI disks where multiple requests can be pending so
> > there's no urgency to reporting a false success. The request doesn't complete
> > until the write hits disk. As a result SCSI disks are reliable for database
> > operation and IDE disks aren't unless write caching is disabled.
> 
> This is not really true.
> 
> Regardless of TCQ, if the OS driver has not issued a FLUSH CACHE (IDE)
> or SYNCHRONIZE CACHE (SCSI), then the data is not guaranteed to be on
> the disk media.  Plain and simple.

That doesn't agree with people's experience. People seem to find that SCSI
drives never cache writes. This sort of makes sense since there's just not
much reason to report a write success before the write can be performed.
There's no performance advantage as long as more requests can be queued up.


> If fsync(2) returns without a flush-cache, then your data is not
> guaranteed to be on the disk.  And as you noted, flush-cache destroys
> performance.

It's my understanding that it doesn't. There was some discussion in the past
month about making the drivers issue syncs for journalled filesystems, but
even then the idea of adding it to fsync or O_SYNC files wasn't the
motivation.


> There are three levels:
> 
> a) Data is successfully transferred to the controller/drive queue (TCQ).
> b) Data is successfully transferred to the drive's internal buffers.
> c) The drive successfully transfers data to the media.

Only the third is of interest to Postgres or other databases. In fact, I
suspect only the third is of interest to other systems that are supposed to be
reliable like MTAs etc. I think Wietse and others would be shocked if they
were told fsync wasn't guaranteed to have waited until the writes had actually
hit the media.

-- 
greg

