Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262221AbSIZHM1>; Thu, 26 Sep 2002 03:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262222AbSIZHM1>; Thu, 26 Sep 2002 03:12:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59075 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262221AbSIZHMY>;
	Thu, 26 Sep 2002 03:12:24 -0400
Date: Thu, 26 Sep 2002 09:17:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020926071726.GE12862@suse.de>
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com> <3D92B369.7AFD28D4@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D92B369.7AFD28D4@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26 2002, Andrew Morton wrote:
> Andrew Morton wrote:
> > 
> > I'll test scsi now.
> > 
> 
> aic7xxx, Fujitsu "MAF3364L SUN36G" (36G SCA-2)
> 
> 
> Maximum number of TCQ tags=253
> 
> 	fifo_batch		time cat kernel/*.c (seconds)
> 	    64				58
> 	    32				54
> 	    16				20
> 	     8				58
> 	     4				1:15
> 	     2				53
> 
> Maximum number of TCQ tags=4
> 
> 	fifo_batch		time cat kernel/*.c (seconds)
> 	    64				53
> 	    32				39
> 	    16				33
> 	     8				21
> 	     4				22
> 	     2				36
> 	     1				22
> 
> 
> Maximum number of TCQ tags = 0:
> 
> 	fifo_batch		time cat kernel/*.c (seconds)
> 	    64				22
> 	    32				10.3
> 	    16				10.5
> 	     8				5.5
> 	     4				3.2
> 	     2				1.9
> 
> I selected fifo_batch=16 and altered writes_starved and read_expires
> again.  They made no appreciable difference.

Abysmal. BTW, fifo_batch value less than seek cost doesn't make too much
sense, unless the drive has really slow streaming io performance.

> >From this I can only conclude that my poor little read was stuck
> in the disk for ages while TCQ busily allowed new incoming writes
> to bypass already-sent reads.
> 
> A dreadful misdesign.  Unless we can control this with barriers,
> and if Fujutsu is typical, TCQ is just uncontrollable.  I, for
> one, would not turn it on in a pink fit.

I have this dream that we might be able to control this if we get our
hands on the queueing at the block level. The above looks really really
bad though, in the past I've had quite good experience with a tag depth
of 4. I should try ide tcq again, to see how that goes.

-- 
Jens Axboe

