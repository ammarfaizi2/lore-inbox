Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbTIZU15 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 16:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbTIZU14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 16:27:56 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:58646 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261642AbTIZU1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 16:27:51 -0400
Subject: Re: kernel BUG using multipath on 2.6.0-test5
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Jens Axboe <axboe@suse.de>
Cc: Matthew Wilcox <willy@debian.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030926122646.GA15415@suse.de>
References: <1064541435.4763.51.camel@persist.az.mvista.com>
	 <20030926121703.GG24824@parcelfarce.linux.theplanet.co.uk>
	 <20030926122646.GA15415@suse.de>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1064607249.4779.1.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 26 Sep 2003 13:14:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-26 at 05:26, Jens Axboe wrote: 
> On Fri, Sep 26 2003, Matthew Wilcox wrote:
> > On Thu, Sep 25, 2003 at 06:57:15PM -0700, Steven Dake wrote:
> > > kernel BUG at drivers/scsi/scsi_lib.c:544!
> > 
> >         BUG_ON(!cmd->use_sg);
> > 
> > >  [<c01f631d>] scsi_init_io+0x7a/0x13d
> > 
> > static int scsi_init_io(struct scsi_cmnd *cmd)
> >         struct request     *req = cmd->request;
> >         cmd->use_sg = req->nr_phys_segments;
> >         sgpnt = scsi_alloc_sgtable(cmd, GFP_ATOMIC);
> > 
> > >  [<c01f6455>] scsi_prep_fn+0x75/0x171
> > 
> > static int scsi_prep_fn(struct request_queue *q, struct request *req)
> >         struct scsi_cmnd *cmd;
> >         cmd->request = req;
> >         ret = scsi_init_io(cmd);
> > 
> > .. this is getting outside my area of confidence.  Ask axboe why we might
> > get a zero nr_phys_segments request passed in.
> 
> Looks like an mp bug. I'd suggest adding something ala
> 
> 	if (!rq->nr_phys_segments || !rq->nr_hw_segments) {
> 		blk_dump_rq_flags(req, "scsi_init_io");
> 		return BLKPREP_KILL;
> 	}
> 
> inside the first
> 
> 	} else if (req->flags & (REQ_CMD | REQ_BLOCK_PC)) {
> 
> drivers/scsi/scsi_lib.c:scsi_prep_fn(). That will show the state of such
> a buggy request. I'm pretty sure this is an mp bug though.

scsi_prep_fn: dev sdd: flags = REQ_CMD REQ_STARTED
sector 0, nr/cnr 8/8
bio c2694708, biotail c2694708, buffer f76dc000, data 00000000, len 0
multipath: IO failure on sdd, disabling IO path.
        Operation continuing on 1 IO paths.
multipath: sdd: rescheduling sector 8
MULTIPATH conf printout:
-- wd:1 rd:2
disk0, o:0, dev:sdd
disk1, o:1, dev:sdb
MULTIPATH conf printout:
-- wd:1 rd:2
disk1, o:1, dev:sdb
multipath: sdd: redirecting sector 0 to another IO path
scsi_prep_fn: dev sdb: flags = REQ_CMD REQ_STARTED
sector 0, nr/cnr 0/8
bio c2694708, biotail c2694708, buffer f76dc000, data 00000000, len 0

I assume a length of zero is wrong...  I'll trace up the stack and see
where the bad data gets into the request.

Thanks for the pointer...
-steve  

