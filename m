Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319066AbSHFLOQ>; Tue, 6 Aug 2002 07:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319067AbSHFLOQ>; Tue, 6 Aug 2002 07:14:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55243 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319066AbSHFLOO>;
	Tue, 6 Aug 2002 07:14:14 -0400
Date: Tue, 6 Aug 2002 13:17:49 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.30 IDE 113
Message-ID: <20020806111749.GH1323@suse.de>
References: <13A77E76028@vcnet.vc.cvut.cz> <3D4FA2F8.2050305@evision.ag> <20020806104238.GB1132@suse.de> <3D4FA845.90702@evision.ag> <20020806105450.GD1323@suse.de> <3D4FAA87.8040303@evision.ag> <20020806110548.GF1323@suse.de> <3D4FAE5C.9050205@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4FAE5C.9050205@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06 2002, Marcin Dalecki wrote:
> Uz.ytkownik Jens Axboe napisa?:
> >On Tue, Aug 06 2002, Marcin Dalecki wrote:
> >
> >>Uz.ytkownik Jens Axboe napisa?:
> >>
> >>>On Tue, Aug 06 2002, Marcin Dalecki wrote:
> >>>
> >>>
> >>>>Uz.ytkownik Jens Axboe napisa?:
> >>>>
> >>>>
> >>>>>On Tue, Aug 06 2002, Marcin Dalecki wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>>>device not per channel! If q->request_fn would properly return the
> >>>>>>error count instead of void, we could even get rid ot the
> >>>>>>checking for rq->errors after finishment... But well that's
> >>>>>>entierly different story.
> >>>>>
> >>>>>
> >>>>>That's nonsense! What exactly would you return from a request_fn after
> >>>>>having queued, eg, 20 commands? Error count is per request, anything
> >>>>>else would be stupid.
> >>>>
> >>>>Returning the error count in the case q->request_fn is called for
> >>>>a self submitted request like for example REQ_SPECIAL would be handy 
> >>>>and well defined. For the cumulative case it would of course make sense 
> >>>>to return the cumulative error count. Tough not very meaningfull, it 
> >>>>would
> >>>>indicate the occurrence of the error very fine.
> >>>
> >>>
> >>>It's much nicer to maintain a sane API that doesn't depend on stuff like
> >>>the above. Cumulative error count, come on, you can't possibly be
> >>>serious?!
> >>
> >>Hey don't get me wrong - I *do not* suggest adding it becouse I don't 
> >>think we are going to change the "eat as many as possible requests" 
> >>instead of "eat one request" semantics of the q->reuqest_fn().
> >>OK?
> >
> >
> >You look from the IDE perspective, I look from the interface
> >perspective. There's is no "eat one request" semantic of request_fn(),
> >in fact there's just the opposite. If you quit after having just
> >consumed one request, you must make sure to invoke request_fn _yourself_
> >later on -- or use the recent blk_start/stop_queue helpers.
> 
> Yes of course I know that there is not "eat one request" semantic of
> request_fn(). However looking at the interface perspective (out of my
> small corner) I think the above is precisely what leads to ugly things
> (and I think you will agree that this is ugly) like calling 
> do_ide_request() back out from ata_irq_handler() - shrug.

Ho hum, well I think it's only ugly in the way it had to be done
previously. Right now I think the usage is pretty nice, actually

request_fn(q)
{
	rq = elv_next_request();
	start_request(rq);
	blk_stop_queue(q);
}

isr()
{
	handle_completion();
	blk_start_queue(queue);
}

The API works nicely regardless of queue depth and how many requests
request_fn consumes.

-- 
Jens Axboe

