Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTENWdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTENWdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:33:42 -0400
Received: from tomts14-srv.bellnexxia.net ([209.226.175.35]:17404 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263087AbTENWdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:33:33 -0400
Subject: Re: Can't find CDR device in -mm only
From: Shane Shrybman <shrybman@sympatico.ca>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <20030514074350.GZ17033@suse.de>
References: <1052537820.2441.113.camel@mars.goatskin.org>
	 <20030510092041.GN812@suse.de> <1052578016.2369.7.camel@mars.goatskin.org>
	 <20030510164102.GD837@suse.de>  <20030514074350.GZ17033@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1052952377.2323.8.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 May 2003 18:46:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jens! I can now see my burner.

There was the other problem I mentioned too. I use the xcdroast front
end to cdrecord and when I try and dupe a cd it always thinks the cd is
an audio cd and tries to copy it with cdda2wav. This is a big problem
for data cds :) Any idea on what might cause this? I think it has been
this ever since I stopped using ide-scsi in 2.5. There is detailed debug
output in the email I sent you on May 10. I can send it again if
needed.  

On Wed, 2003-05-14 at 03:43, Jens Axboe wrote:
> On Sat, May 10 2003, Jens Axboe wrote:
> > On Sat, May 10 2003, Shane Shrybman wrote:
> > > Hi Jens,
> > > 
> > > On Sat, 2003-05-10 at 05:20, Jens Axboe wrote:
> > > > On Fri, May 09 2003, Shane Shrybman wrote:
> > > > > Hi,
> > > > > 
> > > > > The problem first appeared in 2.5.68-mm3 and is not in mainline 2.5.69.
> > > > > It is present in all -mm releases since.
> > > > 
> > > > Curious. Looking at patches between .68-mm2 and -mm3 reveals nothing
> > > > major, in fact the only thing touching anything in that area seems to be
> > > > the dynamic request allocation patch. Could you try 2.5.69 with the
> > > > attached patch to verify that it still works (or doesn't)? There might
> > > > be a small offset in deadline-iosched.c, should be nothing to worry
> > > > about.
> > > 
> > > Still doesn't work with 2.5.69 + rq_dyn. The output from cdrecord is
> > > below.
> > 
> > Ah thanks, that kind of narrows it down then. I'll take a look at the
> > problem tomorrow, should be easy to reproduce. Thanks for reporting!
> 
> Please try this patch, it should fix the issue for you. The reason is
> that the RW bit is set from get_request() now, and scsi_ioctl always
> uses WRITE as arguement to the function. So every request would be
> turned into a write, oops :)
> 
> ===== drivers/block/scsi_ioctl.c 1.25 vs edited =====
> --- 1.25/drivers/block/scsi_ioctl.c	Tue Apr 29 13:41:31 2003
> +++ edited/drivers/block/scsi_ioctl.c	Wed May 14 09:42:19 2003
> @@ -229,6 +229,8 @@
>  	rq->flags |= REQ_BLOCK_PC;
>  	if (writing)
>  		rq->flags |= REQ_RW;
> +	else
> +		rq->flags &= ~REQ_RW;
>  
>  	rq->hard_nr_sectors = rq->nr_sectors = nr_sectors;
>  	rq->hard_cur_sectors = rq->current_nr_sectors = nr_sectors;
> @@ -375,6 +377,8 @@
>  	rq->flags |= REQ_BLOCK_PC;
>  	if (in_len)
>  		rq->flags |= REQ_RW;
> +	else
> +		rq->flags &= ~REQ_RW;
>  
>  	blk_do_rq(q, bdev, rq);
>  	err = rq->errors & 0xff;	/* only 8 bit SCSI status */

Thanks,

shane

