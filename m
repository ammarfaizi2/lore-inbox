Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318699AbSHAKmM>; Thu, 1 Aug 2002 06:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318700AbSHAKmM>; Thu, 1 Aug 2002 06:42:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10394 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318699AbSHAKmL>;
	Thu, 1 Aug 2002 06:42:11 -0400
Date: Thu, 1 Aug 2002 12:45:30 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: IDE from current bk tree, UDMA and two channels...
Message-ID: <20020801104530.GF13494@suse.de>
References: <9B9F331783@vcnet.vc.cvut.cz> <3D48420F.5050407@evision.ag> <20020801095609.GE1096@suse.de> <3D4905DB.70305@evision.ag> <20020801100553.GA13494@suse.de> <3D490E5D.3070501@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D490E5D.3070501@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01 2002, Marcin Dalecki wrote:
> Jens Axboe wrote:
> 
> >>>that would work, but I think it would seriously starve the other device
> >>>on the same channel.
> >>
> >>We starve anyway, becouse the kernel isn't real time and we can't
> >>guarantee "sleeping" for some maximum time and comming back.
> >>We don't reschedule the kernel during this kind of "sleeping".
> >>And we can't know that a command on the "mate" will not take 
> >>extraordinary amounts of time. It's only a problem if mixing travan
> >>tapes with disks on a channel.
> >
> >
> >I'm thinking about the alternation of the devices so one device can't
> >starve the other device off the channel.
> 
> Ah so you are thinking about two equally powered devices
> competing for the channel. Something I would call the "sumo fight"
> situation. Well disks didn't use the "sleeping" mechanism at all anyway
> and the chances someone would do cp from CD-ROM to CD-ROM are low.
> 
> Finally I think that the proper granularity of scheduling requests to
> the drive is, well, the request layer. The queue processing layer should
> handle this becouse otherwise we would have two "competing" optimization
> mechanisms. And there we are indeed able to actually relinquish some CPU 
> time. If you look at an request processing optimization as a low pass
> signal filter it's immediately obvious that the effects of chaining them
> can be, well at least "counter intuitive".

Actually, I'm thinking of a much simple scenario: basically any two
devices on the same channel, both with pending requests on the queue.
This could be a hard drive and a cd writer, for instance. If you have 60
requests pending for the hard drive, queue gets unplugged, you start the
first one. Correct me if I'm wrong, but now you pass back the drive to
the request handler when the first request completes, and you select a
new request from that very same drive without considering device
starvation? Any run of the cd writer queue would do nothing, since it
would just find the channel busy.

This sort of thing cannot be solved at the block layer. The two queues
are independent seen from that layer, the channel-busy dependency cannot
be solved there.

-- 
Jens Axboe

