Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVDAXHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVDAXHU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVDAXHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:07:20 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:22689 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262796AbVDAXHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:07:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=rTrrRJ6/kMr8ZStGrILYZYIBhH+pppHdsbxsMM/SbhGPTyvzHK2TvQt2FtlFkbG576VyW/t/YG7X0Ce4dO/HAEtuef2nzh1OdNL3GcKZ/NpmmN4WikmDrdGBJ5Fo5l6QISWt00zhJgOOT5PUeTRhq+KLIU5158nFrjVvYO/pwro=
Date: Sat, 2 Apr 2005 08:07:02 +0900
From: Tejun Heo <htejun@gmail.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 07/13] scsi: move error handling out of scsi_init_io() into scsi_prep_fn()
Message-ID: <20050401230702.GB14700@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.79DF3B09@htj.dyndns.org> <1112379817.5776.27.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112379817.5776.27.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Greetings, James. :-)

On Fri, Apr 01, 2005 at 12:23:37PM -0600, James Bottomley wrote:
> On Thu, 2005-03-31 at 18:08 +0900, Tejun Heo wrote:
> > 	When scsi_init_io() returns BLKPREP_DEFER or BLKPREP_KILL,
> > 	it's supposed to free resources itself.  This patch
> > 	consolidates defer and kill handling into scsi_prep_fn().
> > 	This fixes a queue stall bug which occurred when sgtable
> > 	allocation failed and device_busy == 0.
> 
> This one I like, but I think it doesn't go far enough.  There are
> situations where a re-queue can also re-prepare, which means we leak sg
> lists and commands on BLKPREP_KILL because of SCSI state.

 With later request_fn() rewrite patch, all state checking are moved
to request_fn() and gets terminated with __scsi_done().  prep_fn()
only kills invalid (so, unprepped) requests.  It's in the fixed bugs
list of the request_fn() rewrite patch.  BTW, there's one more path
which leaks cmnd/sgtable, the end_that_request_*() on offline path of
request_fn() which is also fixed by request_fn() rewrite patch.

 I'm sorry about not mentioning that the bug is fixed in the later
patch.  Please review request_fn() rewrite patch.

> How about the attached.
> 
> Note, I've also altered the prepare function so req->special never gets
> altered if it points to a scsi_request. Previously it would be altered
> to point to the command, but now we couldn't put the command since the
> scsi_request we can't get to also has a copy of if.  So, if you can make
> your later REQ_SPECIAL removal work, we can dispense with sr_magic and
> simply use REQ_SPECIAL as the discriminator for the contents of req-
> >special.
> 
> James

 Yeah, I like not overwriting ->special, and removing magic is always
good. :-)

 Hmmm, I have another proposal.  What do you think about replacing
scsi_request with scsi_cmnd.  I've been looking into it and it doesn't
seem to be too much work and it won't cause problems.  The only
bothering thing is that scsi_cmnd is limited resource and should be
returned to the pool ASAP.  AFAIK, all current users of
scsi_allocate_request() releses the scsi_request as soon as they're
finished, and we can make the requirement clear in the comment
(i.e. do not cache or hold on to scsi_cmnd).  This will remove the
scsi_request/cmnd dance and make scsi midlayer slimmer in other
places.  What do you think?

 Thanks.

-- 
tejun

