Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbUDTHIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUDTHIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 03:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUDTHIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 03:08:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59876 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262217AbUDTHIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 03:08:24 -0400
Date: Tue, 20 Apr 2004 09:08:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Warren Togami <warren@togami.com>
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i2o_block Fix, possible CFQ elevator problem?
Message-ID: <20040420070805.GC25806@suse.de>
References: <4083BA03.1090606@redhat.com> <20040419121225.GT1966@suse.de> <408471E2.8060201@redhat.com> <40848159.7090605@togami.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40848159.7090605@togami.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19 2004, Warren Togami wrote:
> Warren Togami wrote:
> >Jens Axboe wrote:
> >
> >>>
> >>>http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie.jpg
> >>>
> >>>I noticed that the call trace contained "cfq_next_request", so I was
> >>>curious what would happened if we changed to the deadline scheduler.
> >>>Booted with the same kernel but with "elevator=deadline". To our
> >>>surprise, bonnie++ ran simultaneously on all four I2O block devices
> >>>without crashing the server. For another test we tried "elevator=as"
> >>>and it too remained stable.
> >>>
> >>>Possible CFQ I/O scheduler problem?
> >>
> >>
> >>
> >>That looks pretty damn strange. Any chance you can capture a full oops,
> >>with a serial console or similar?
> >
> >
> >Fedora Core 2 x86_64 SMP (2 x Opteron) with kernel-2.6.5-1.326 (based on
> >2.6.6-rc1)
> >gcc-3.3.3-7 plus attached patch.  This panic was captured by netconsole.
> >
> >http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie.txt
> 
> Next we tested cfq with the following section of code commented out. 
> With this change the kernel no longer panics and seems to survive with 
> four simultaneous bonnie++'s on all four block devices.
> 
> --- cfq-iosched.c       2004-04-20 13:52:55.000000000 -1000
> +++ /root/linux-2.6.5-1.326/drivers/block/cfq-iosched.c 2004-04-20 
> 14:09:43.000000000 -1000
> @@ -401,10 +401,12 @@
>  dispatch:
>                 rq = list_entry_rq(cfqd->dispatch->next);
> 
> +/*
>                 BUG_ON(q->last_merge == rq);
>                 crq = RQ_DATA(rq);
>                 if (crq)
>                         BUG_ON(ON_MHASH(crq));
> +*/
> 
>                 return rq;
>         }

This is not safe, the BUG_ON is there for a reason. If the request in on
the merge hash when handed to the driver, you risk corrupting data. The
fix would be figuring out why this is happening. Maybe it's looking at
bad data, could you test with this patch applied and see if the oops
still triggers?

===== drivers/block/cfq-iosched.c 1.1 vs edited =====
--- 1.1/drivers/block/cfq-iosched.c	Mon Apr 12 19:55:20 2004
+++ edited/drivers/block/cfq-iosched.c	Tue Apr 20 09:07:20 2004
@@ -403,7 +403,7 @@
 
 		BUG_ON(q->last_merge == rq);
 		crq = RQ_DATA(rq);
-		if (crq)
+		if (blk_fs_request(rq) && crq)
 			BUG_ON(ON_MHASH(crq));
 
 		return rq;

-- 
Jens Axboe

