Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbUCTJzO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 04:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbUCTJzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 04:55:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23520 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263288AbUCTJzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 04:55:05 -0500
Date: Sat, 20 Mar 2004 10:55:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040320095502.GB2711@suse.de>
References: <20040319153554.GC2933@suse.de> <405B200A.40909@kolumbus.fi> <20040319181616.GA2423@suse.de> <405B3F74.6040706@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405B3F74.6040706@kolumbus.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19 2004, Mika Penttil? wrote:
> 
> 
> Jens Axboe wrote:
> 
> >On Fri, Mar 19 2004, Mika Penttil? wrote:
> > 
> >
> >>Jens Axboe wrote:
> >>
> >>   
> >>
> >>>Hi,
> >>>
> >>>A first release of a collected barrier patchset for 2.6.5-rc1-mm2. I
> >>>have a few changes planned to support dm/md + sata, I'll do those
> >>>changes over the weekend.
> >>>
> >>>Reiser has the best barrier support, ext3 works but only if things don't
> >>>go wrong. So only attempt to use the barrier feature on ext3 if on ide
> >>>drives, not SCSI nor SATA.
> >>>
> >>>
> >>>
> >>>     
> >>>
> >>What are these brutal pieces...?
> >>
> >>
> >>+static int ide_transform_pc_req(ide_drive_t *drive, struct request *rq)
> >>+{
> >>+ if (rq->cmd[0] != 0x35) {
> >>+ ide_end_request(drive, 0, 0);
> >>+ return 1;
> >>+ }
> >>+
> >>+ if (!drive->wcache) {
> >>+ ide_end_request(drive, 1, 0);
> >>+ return 1;
> >>+ }
> >>+
> >>+ ide_fill_flush_cmd(drive, rq);
> >>+ return 0;
> >>+}
> >>
> >>
> >>/*
> >>+ * basic transformation support for scsi -> ata commands
> >>+ */
> >>+ if (blk_pc_request(rq)) {
> >>+ if (drive->media != ide_disk)
> >>+ goto kill_rq;
> >>+ if (ide_transform_pc_req(drive, rq))
> >>+ return ide_stopped;
> >>+ }
> >>   
> >>
> >
> >Hmm, I thought it was pretty obvious, even just from the naming and
> >comments. Right now, the block layer issued flush without data attached
> >(ie a drive barrier without pinning it to a buffer) comes as a scsi
> >synchronize cache command. I'm going to change this anyways and allow
> >queue hook of a ->issue_flush_fn() that can just tailored to ide or
> >scsi, _or_ dm/md and that sort of thing.
> > 
> >
> I mean other BLOCK_PC requests than SYNCHRONIZE CACHE -> 
> ide_end_request() and ide_stopped.

That's a bug, good catch. Added to fixme list for next release :)

-- 
Jens Axboe

