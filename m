Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUDTIDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUDTIDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 04:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUDTIDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 04:03:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21392 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262208AbUDTIDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 04:03:30 -0400
Date: Tue, 20 Apr 2004 10:03:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Warren Togami <wtogami@redhat.com>
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i2o_block Fix, possible CFQ elevator problem?
Message-ID: <20040420080325.GD25806@suse.de>
References: <4083BA03.1090606@redhat.com> <20040419121225.GT1966@suse.de> <408471E2.8060201@redhat.com> <40848159.7090605@togami.com> <20040420070805.GC25806@suse.de> <4084D83D.8060405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4084D83D.8060405@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19 2004, Warren Togami wrote:
> Jens Axboe wrote:
> >>>http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie.txt
> >>
> >>Next we tested cfq with the following section of code commented out. 
> >>With this change the kernel no longer panics and seems to survive with 
> >>four simultaneous bonnie++'s on all four block devices.
> >>
> >>--- cfq-iosched.c       2004-04-20 13:52:55.000000000 -1000
> >>+++ /root/linux-2.6.5-1.326/drivers/block/cfq-iosched.c 2004-04-20 
> >>14:09:43.000000000 -1000
> >>@@ -401,10 +401,12 @@
> >>dispatch:
> >>               rq = list_entry_rq(cfqd->dispatch->next);
> >>
> >>+/*
> >>               BUG_ON(q->last_merge == rq);
> >>               crq = RQ_DATA(rq);
> >>               if (crq)
> >>                       BUG_ON(ON_MHASH(crq));
> >>+*/
> >>
> >>               return rq;
> >>       }
> >
> >
> >This is not safe, the BUG_ON is there for a reason. If the request in on
> >the merge hash when handed to the driver, you risk corrupting data. The
> >fix would be figuring out why this is happening. Maybe it's looking at
> >bad data, could you test with this patch applied and see if the oops
> >still triggers?
> >
> >===== drivers/block/cfq-iosched.c 1.1 vs edited =====
> >--- 1.1/drivers/block/cfq-iosched.c	Mon Apr 12 19:55:20 2004
> >+++ edited/drivers/block/cfq-iosched.c	Tue Apr 20 09:07:20 2004
> >@@ -403,7 +403,7 @@
> > 
> > 		BUG_ON(q->last_merge == rq);
> > 		crq = RQ_DATA(rq);
> >-		if (crq)
> >+		if (blk_fs_request(rq) && crq)
> > 			BUG_ON(ON_MHASH(crq));
> > 
> > 		return rq;
> >
> 
> We figured removing error handling was not safe, the previous post was 
> only reporting test results to ask for more suggestions.  I have now 
> tested your suggested patch above and it seems to crash in the same way 
> as originally.
> 
> http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie2.txt

As a temporary safe work-around, you can apply this patch.

> This makes me curious, the other elevators lacked this type of error 
> checking.  Did this mean they were possibly allowing data corruption to 
> happen with buggy drivers like this?  Kind of scary!  We were lucky to 
> test this now, because this was one of the first FC kernels that 
> included cfq by default.

Not necessarily, it's most likely a CFQ bug. Otherwise it would have
surfaced before :-)

> Do you have any advice regarding the atomic type removal problem that we 
> experienced from our previous post?

Just change the type to an unsigned integer instead. Double check that
all decrements/increments and reads of that integer are inside the
device lock, it looked like they were.

===== drivers/block/cfq-iosched.c 1.1 vs edited =====
--- 1.1/drivers/block/cfq-iosched.c	Mon Apr 12 19:55:20 2004
+++ edited/drivers/block/cfq-iosched.c	Tue Apr 20 10:02:01 2004
@@ -404,7 +404,7 @@
 		BUG_ON(q->last_merge == rq);
 		crq = RQ_DATA(rq);
 		if (crq)
-			BUG_ON(ON_MHASH(crq));
+			cfq_remove_merge_hints(q, crq);
 
 		return rq;
 	}

-- 
Jens Axboe

