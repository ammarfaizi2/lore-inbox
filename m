Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTLBWpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 17:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264395AbTLBWpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 17:45:31 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53512 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264389AbTLBWp3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 17:45:29 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: libata in 2.4.24?
Date: 2 Dec 2003 22:34:20 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqj41c$drr$1@gatekeeper.tmr.com>
References: <3FCB8312.3050703@rackable.com> <87iskz9hp6.fsf@stark.dyndns.tv> <20031202190646.GA9043@gtf.org> <877k1f9e1g.fsf@stark.dyndns.tv>
X-Trace: gatekeeper.tmr.com 1070404460 14203 192.168.12.62 (2 Dec 2003 22:34:20 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <877k1f9e1g.fsf@stark.dyndns.tv>,
Greg Stark  <gsstark@mit.edu> wrote:
| Jeff Garzik <jgarzik@pobox.com> writes:

| > > This doesn't happen with SCSI disks where multiple requests can be pending so
| > > there's no urgency to reporting a false success. The request doesn't complete
| > > until the write hits disk. As a result SCSI disks are reliable for database
| > > operation and IDE disks aren't unless write caching is disabled.
| > 
| > This is not really true.
| > 
| > Regardless of TCQ, if the OS driver has not issued a FLUSH CACHE (IDE)
| > or SYNCHRONIZE CACHE (SCSI), then the data is not guaranteed to be on
| > the disk media.  Plain and simple.
| 
| That doesn't agree with people's experience. People seem to find that SCSI
| drives never cache writes. This sort of makes sense since there's just not
| much reason to report a write success before the write can be performed.
| There's no performance advantage as long as more requests can be queued up.

I hope you mean the drives don't report completion until the data is on
the platter, clearly the data is cached in the drive until it can be
written.
| 
| 
| > If fsync(2) returns without a flush-cache, then your data is not
| > guaranteed to be on the disk.  And as you noted, flush-cache destroys
| > performance.
| 
| It's my understanding that it doesn't. There was some discussion in the past
| month about making the drivers issue syncs for journalled filesystems, but
| even then the idea of adding it to fsync or O_SYNC files wasn't the
| motivation.

With O_SYNC files there is the possibility of having a don't cache bit
in the packet to the drive, even with write caching. With fsync I don't
see any way to do it after the fact for only some of the data in the
drive cache. That's just an observation.

Clearly with a completion status coming back after actual completion
O_SYNC or fsync reduce to "wait for the ack from the drive."
| 
| 
| > There are three levels:
| > 
| > a) Data is successfully transferred to the controller/drive queue (TCQ).
| > b) Data is successfully transferred to the drive's internal buffers.
| > c) The drive successfully transfers data to the media.
| 
| Only the third is of interest to Postgres or other databases. In fact, I
| suspect only the third is of interest to other systems that are supposed to be
| reliable like MTAs etc. I think Wietse and others would be shocked if they
| were told fsync wasn't guaranteed to have waited until the writes had actually
| hit the media.

I think for reliability fsync has to flush cache, regardless of the
performance hit. I think a drive would be unusably slow if you did it
after each O_SYNC write, so that's probably not practical. Clearly the
best solution is a full SCSI implementation over PATA/SATA, but that
would eliminate some of the justification for SCSI devices at premium
prices.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
