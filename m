Return-Path: <linux-kernel-owner+w=401wt.eu-S1422996AbWLUSLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422996AbWLUSLm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422999AbWLUSLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:11:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45084 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422996AbWLUSLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:11:41 -0500
Date: Thu, 21 Dec 2006 13:11:18 -0500 (EST)
Message-Id: <20061221.131118.39151032.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com
Cc: agk@redhat.com, mchristi@redhat.com, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, j-nomura@ce.jp.nec.com
Subject: Re: [RFC PATCH 1/8] rqbased-dm: allow blk_get_request() to be
 called from interrupt context
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
In-Reply-To: <20061221075305.GD17199@kernel.dk>
References: <20061220184917.GJ10535@kernel.dk>
	<20061220.165549.39151582.k-ueda@ct.jp.nec.com>
	<20061221075305.GD17199@kernel.dk>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

OK, I understand that.
But I think that the block layer assumption (depending on "current")
is not ideal.
Anyway, thank you for the information.

Thanks,
Kiyoshi Ueda


On Thu, 21 Dec 2006 08:53:05 +0100, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Wed, Dec 20 2006, Kiyoshi Ueda wrote:
> > Hi Jens,
> > 
> > On Wed, 20 Dec 2006 19:49:17 +0100, Jens Axboe <jens.axboe@oracle.com> wrote:
> > > > > Big NACK on this - it's not only really ugly, it's also buggy to pass
> > > > > interrupt flags as function arguments. As you also mention in the 0/1
> > > > > mail, this also breaks CFQ.
> > > > > 
> > > > > Why do you need in-interrupt request allocation?
> > > >  
> > > > Because I'd like to use blk_get_request() in q->request_fn()
> > > > which can be called from interrupt context like below:
> > > >   scsi_io_completion -> scsi_end_request -> scsi_next_command
> > > >   -> scsi_run_queue -> blk_run_queue -> q->request_fn
> > > > 
> > > > Generally, device-mapper (dm) clones an original I/O and dispatches
> > > > the clones to underlying destination devices.
> > > > In the request-based dm patch, the clone creation and the dispatch
> > > > are done in q->request_fn().  To create the clone, blk_get_request()
> > > > is used to get a request from underlying destination device's queue.
> > > > By doing that in q->request_fn(), dm can deal with struct request
> > > > after bios are merged by __make_request().
> > > > 
> > > > Do you think creating another function like blk_get_request_nowait()
> > > > is acceptable?
> > > > Or request should not be allocated in q->request_fn() anyway?
> > > 
> > > You should not be allocating requests from that path, for a number of
> > > reasons.
> > 
> > Could I hear the reasons for my further work if possible?
> > Because of breaking current CFQ?  And is there any reason?
> 
> Mainly I just don't like the design, there are better ways to achieve
> what you need. The block layer has certain assumptions on the context
> from which rq allocation happens, and this breaks it. As I also
> mentioned, you cannot pass flags around as arguments. So the patch is
> even broken as-is.
> 
> -- 
> Jens Axboe

