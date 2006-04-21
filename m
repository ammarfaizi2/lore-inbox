Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWDUHwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWDUHwt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 03:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWDUHwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 03:52:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5432 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751274AbWDUHwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 03:52:49 -0400
Date: Fri, 21 Apr 2006 09:53:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linh Dang <linhd@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
Message-ID: <20060421075321.GA4717@suse.de>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org> <20060419200001.fe2385f4.diegocg@gmail.com> <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org> <20060420145041.GE4717@suse.de> <wn5fyk85bw7.fsf@linhd-2.ca.nortel.com> <20060420194914.GL4717@suse.de> <wn53bg858b2.fsf@linhd-2.ca.nortel.com> <4447E8DB.6000807@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4447E8DB.6000807@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21 2006, Nick Piggin wrote:
> Linh Dang wrote:
> >Jens Axboe <axboe@suse.de> wrote:
> 
> >>DVD burning probably isn't a good splice fit, since you need to do
> >>more than actually just point the device at the data. SG_IO is
> >>already zero-copy as it maps the user data into the kernel without
> >>copying, so there's very little room for improvement there to begin
> >>with.
> >
> >
> >DVD burning on linux is mostly:
> >
> >        mkisofs .... | growisofs ....
> >
> >Ideally, on mkisofs side, we'd be able to:
> >
> >  - write some data/padding into the pipe
> >  - splice a HUGE file into the pipe
> >  - write some data/padding into the pipe
> >  - splice a HUGE file into the pipe
> >  ...
> >
> >On growisofs side, we'd be able to:
> >
> >  - send some commands
> >  - splice N MBs of data from the pipe to the driver
> >  - send some commands
> >  - splice M MBs of data from the pipe to the driver
> >  ...
> >
> >What'd be nice is an ioctl to change the size of the pipe between
> >mkisofs and growisofs.
> 
> I don't see why the pipe buffers would be a problem though. It isn't
> like you've lost any of the pagecache buffering (eg. from readahead)
> or the application level buffering.

Yes, hence the reason that a larger pipe / dynamic pipe wasn't even
attempted yet. In the tests I did, manually increasing the pipe size
yielded no noticable benefits.

Conceptually it might be simpler for the mkisofs side to accept larger
in-kernel pipes, but on the performance side I doubt it would matter a
lot. The growisofs side sending data to the drive is not limited by the
64k pipe, typically the commands will be smaller than that anyways. So
"splice N MBs of data from the pipe to the driver" is a nice dream, but
that's not how you talk to the device anyways.

-- 
Jens Axboe

