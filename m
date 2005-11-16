Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbVKPTLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbVKPTLH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbVKPTLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:11:07 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:36716 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751496AbVKPTLE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:11:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DTPTRJnsEZU16rCleQA96KxFEHMMT5CvB93LlRd038h1vNKY0d9DJVg0Av6PRTu3wlTMfZVUIw9lnYVxGQj++EOXLr4DBo/f5JhzGfNNxhyqDMnHHE9Y43W8b56ZjUe6g6Va8YY/u32IAAnVyqCPcFDcrLPL3Qmn8cDAYSgrH2c=
Message-ID: <58cb370e0511161111u7e99c74ufe0bb9019619d5d0@mail.gmail.com>
Date: Wed, 16 Nov 2005 20:11:02 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Cc: Mike Christie <michaelc@cs.wisc.edu>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20051116171051.GP7787@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4379AA5B.1060900@pobox.com> <4379C062.3010302@pobox.com>
	 <20051115120016.GD7787@suse.de> <437A2814.1060308@cs.wisc.edu>
	 <20051115184131.GJ7787@suse.de> <20051116124035.GX7787@suse.de>
	 <58cb370e0511160704w4803a085h7bd6ab352d8c94e6@mail.gmail.com>
	 <20051116153119.GN7787@suse.de>
	 <58cb370e0511160806t1defd373w981e213d1cdeb2b3@mail.gmail.com>
	 <20051116171051.GP7787@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Jens Axboe <axboe@suse.de> wrote:
> On Wed, Nov 16 2005, Bartlomiej Zolnierkiewicz wrote:
> > On 11/16/05, Jens Axboe <axboe@suse.de> wrote:
> > > On Wed, Nov 16 2005, Bartlomiej Zolnierkiewicz wrote:
> > > > On 11/16/05, Jens Axboe <axboe@suse.de> wrote:
> > > >
> > > > > I updated that patch, and converted IDE and SCSI to use it. See the
> > > > > results here:
> > > > >
> > > > > http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=shortlog;h=blk-softirq
> > > >
> > > > I like it but:
> > > >
> > > > * "we know it's either an FS or PC request" assumption in
> > > >   ide_softirq_done() is really wrong
> > >
> > > It used to be correct :-)
> >
> > Sorry but it has been always like that,
> > other requests also pass through ide_end_request()
> > (which of course needs fixing).
>
> You misunderstand, for calls to blk_complete_request() it wasn't true
> initially since it always obyed rq_all_done() (which returns 0 for
> non-fs and non-pc requests).

from blk_complete_request() [ the only user of rq_all_done() ]:

+ /*
+ * for partial completions, fall back to normal end io handling.
+ */
+ if (unlikely(!partial_ok && !rq_all_done(req, nbytes)))
+         if (end_that_request_chunk(req, uptodate, nbytes))
+                 return 1;

We still will end up with using ide_softirq_done() for !rq_all_done()
case (non FS/PC request) because majority of them (all?) don't use
partial completions.

Bartlomiej
