Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319064AbSHFLIv>; Tue, 6 Aug 2002 07:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319066AbSHFLIv>; Tue, 6 Aug 2002 07:08:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15563 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319064AbSHFLIu>;
	Tue, 6 Aug 2002 07:08:50 -0400
Date: Tue, 6 Aug 2002 13:12:24 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.30 IDE 113
Message-ID: <20020806111224.GG1323@suse.de>
References: <13AC5F92253@vcnet.vc.cvut.cz> <20020806104414.GC1132@suse.de> <3D4FA924.3030601@evision.ag> <20020806110354.GE1323@suse.de> <3D4FAD3A.1090309@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4FAD3A.1090309@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06 2002, Marcin Dalecki wrote:
> Uz.ytkownik Jens Axboe napisa?:
> 
> >Agrh god no. So you'll spin waiting for the ioctl to complete?
> >
> >>From ide_raw_taskfile(), the right way to do it is:
> >
> >	struct request *rq = blk_get_request(...);
> >
> >This gets _everything_ right.
> >
> >BTW, _glad to see you got rid of the horrible insert-and-execute stuff
> >in ide_raw_taskfile(). That was a layering violation.
> >
> >
> >>OK?
> >
> >
> >Not likely :-)
> 
> Argh. Yes. Thank's for the back-head slap.
> I was looking too much at the SCSI code again and got it wrong.
> But some time ago I was already thinking about blk_get_request().
> How could I maintain that the blk_get_request() really returns?
> blk_get_request() does only drain up to maximum queue depth as
> far as I can read the code and then bad things wil happen :-).
> Or should I just not worry?

You can make it do what you want. From ioctl etc context (or basically
anyone calling ide_raw_taskfile() since that will block too), you can
use a blocking call to blk_get_request(). So

	rq = blk_get_request(q, WRITE, __GFP_WAIT);

will _never_ return NULL. You are basically throttling on the freelist
of the queue, just like any other submitter of I/O. And that, is a Good
Thing :-)

-- 
Jens Axboe

