Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbTI0Aem (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 20:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTI0Aem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 20:34:42 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:62756 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261736AbTI0Aec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 20:34:32 -0400
Subject: [PATCH] fixes defect with kernel BUG using multipath on 2.6.0-test5
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: neilb@cse.unsw.edu.au
Cc: axboe@suse.de, Matthew Wilcox <willy@debian.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
In-Reply-To: <1064607249.4779.1.camel@persist.az.mvista.com>
References: <1064541435.4763.51.camel@persist.az.mvista.com>
	 <20030926121703.GG24824@parcelfarce.linux.theplanet.co.uk>
	 <20030926122646.GA15415@suse.de>
	 <1064607249.4779.1.camel@persist.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-n/Bteg1b4h5DNe+ycSTk"
Organization: MontaVista Software, Inc.
Message-Id: <1064622862.4779.38.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 26 Sep 2003 17:34:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n/Bteg1b4h5DNe+ycSTk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Folks,
Thanks Matt and Jens for the debug help on the multipath problem.  I now
have a patch (attached) which solves the problem and makes multipath
work properly.   There are two types of "flags" that are used in a block
io request, bi_flags, and bi_rw.  bi_flags is used for flags to the
block level code, and bi_rw is used for flags to the low level device
drivers.  The code in the multipath driver used the wrong flag in the
wrong field.  In this case, the flag FASTFAIL (value 3) was being set to
the bi_flags field.  FASTFAIL is a hint to the low level driver that it
should try to fail out quickly.  Unfortunately, the value 3 is also
BIO_SEG_VALID, which is a flag to the block subsystem that the segments
shouldn't be recalculated.  The result was that the wrong field was set,
telling the block layer not to recalculate the segments resulting in
phys and hw segments of 0.  Not good.

Neil can you send upstream ?

Thanks
-steve

On Fri, 2003-09-26 at 13:14, Steven Dake wrote:
> On Fri, 2003-09-26 at 05:26, Jens Axboe wrote: 
> > On Fri, Sep 26 2003, Matthew Wilcox wrote:
> > > On Thu, Sep 25, 2003 at 06:57:15PM -0700, Steven Dake wrote:
> > > > kernel BUG at drivers/scsi/scsi_lib.c:544!
> > > 
> > >         BUG_ON(!cmd->use_sg);
> > > 
> > > >  [<c01f631d>] scsi_init_io+0x7a/0x13d
> > > 
> > > static int scsi_init_io(struct scsi_cmnd *cmd)
> > >         struct request     *req = cmd->request;
> > >         cmd->use_sg = req->nr_phys_segments;
> > >         sgpnt = scsi_alloc_sgtable(cmd, GFP_ATOMIC);
> > > 
> > > >  [<c01f6455>] scsi_prep_fn+0x75/0x171
> > > 
> > > static int scsi_prep_fn(struct request_queue *q, struct request *req)
> > >         struct scsi_cmnd *cmd;
> > >         cmd->request = req;
> > >         ret = scsi_init_io(cmd);
> > > 
> > > .. this is getting outside my area of confidence.  Ask axboe why we might
> > > get a zero nr_phys_segments request passed in.
> > 
> > Looks like an mp bug. I'd suggest adding something ala
> > 
> > 	if (!rq->nr_phys_segments || !rq->nr_hw_segments) {
> > 		blk_dump_rq_flags(req, "scsi_init_io");
> > 		return BLKPREP_KILL;
> > 	}
> > 
> > inside the first
> > 
> > 	} else if (req->flags & (REQ_CMD | REQ_BLOCK_PC)) {
> > 
> > drivers/scsi/scsi_lib.c:scsi_prep_fn(). That will show the state of such
> > a buggy request. I'm pretty sure this is an mp bug though.
> 
> scsi_prep_fn: dev sdd: flags = REQ_CMD REQ_STARTED
> sector 0, nr/cnr 8/8
> bio c2694708, biotail c2694708, buffer f76dc000, data 00000000, len 0
> multipath: IO failure on sdd, disabling IO path.
>         Operation continuing on 1 IO paths.
> multipath: sdd: rescheduling sector 8
> MULTIPATH conf printout:
> -- wd:1 rd:2
> disk0, o:0, dev:sdd
> disk1, o:1, dev:sdb
> MULTIPATH conf printout:
> -- wd:1 rd:2
> disk1, o:1, dev:sdb
> multipath: sdd: redirecting sector 0 to another IO path
> scsi_prep_fn: dev sdb: flags = REQ_CMD REQ_STARTED
> sector 0, nr/cnr 0/8
> bio c2694708, biotail c2694708, buffer f76dc000, data 00000000, len 0
> 
> I assume a length of zero is wrong...  I'll trace up the stack and see
> where the bad data gets into the request.
> 
> Thanks for the pointer...
> -steve  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

--=-n/Bteg1b4h5DNe+ycSTk
Content-Disposition: attachment; filename=fix_defect_multipath_BUGs.patch
Content-Type: text/plain; name=fix_defect_multipath_BUGs.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test5/drivers/md/multipath.c	2003-09-08 12:50:03.000000000 -0700
+++ linux-fixmd2/drivers/md/multipath.c	2003-09-26 17:13:09.000000000 -0700
@@ -178,7 +178,7 @@
 
 	mp_bh->bio = *bio;
 	mp_bh->bio.bi_bdev = multipath->rdev->bdev;
-	mp_bh->bio.bi_flags |= (1 << BIO_RW_FAILFAST);
+	mp_bh->bio.bi_rw |= (1 << BIO_RW_FAILFAST);
 	mp_bh->bio.bi_end_io = multipath_end_request;
 	mp_bh->bio.bi_private = mp_bh;
 	generic_make_request(&mp_bh->bio);

--=-n/Bteg1b4h5DNe+ycSTk--

