Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUG0IVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUG0IVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 04:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUG0IVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 04:21:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43670 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266349AbUG0IUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 04:20:55 -0400
Date: Tue, 27 Jul 2004 04:23:02 -0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J4
Message-ID: <20040727062302.GG1433@suse.de>
References: <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <20040726100103.GA29072@elte.hu> <20040727053338.GE1433@suse.de> <20040727080127.GA6988@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727080127.GA6988@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27 2004, Ingo Molnar wrote:
> 
> [i've sent a second patch too since the first version.]
> 
> * Jens Axboe <axboe@suse.de> wrote:
> 
> > I don't like it. First of all, the implementation really should drain
> > the queue first, then set max value before allowing people to queue
> > more io. The queue lock doesn't help here, readers don't even attempt
> > to serialize access to max_sectors. 
> 
> why should the queue be drained? There might be a few leftover big
> requests, but these are not a problem.

The patch I commented on did not split sectors value into two, in that
case it's a big problem. When split and expose only the one, it's not an
issue.

> > Secondly, I don't like the concept of exposing this value. If you want
> > to do something like this, we must split the value into two like
> > proposed (and patched) some months ago into a hardware and user value.
> 
> yes, agreed - that's what the second patch does.

Great.

> > I don't see why we can't just drop ata48 default value to 256kb
> > instead. There's very little command over head on ide, I bet the
> > majority of the change in performance when playing with 256kb vs
> > 1024kb is not the command overhead itself, rather things like
> > read-ahead that could be more intelligent.
> 
> 256kb isnt enough from a latency POV either - and if a user wants some
> extreme setting like 16KB per request why not allow it? Especially since
> these tunables cause zero runtime overhead.

Note that I've been travelling and didn't really track the thread
closely before that, but it seems to me that most of the latency
incurred is an artifact of long code paths hanging off bi_end_io. Maybe
it would be better to try and fix some of that and get both good irq
completion latencies, while still maintaining decent drive throughput.

That said, this second version looks better from an inclusion point of
view. Better fix those manual q->max_sectors settings first.

-- 
Jens Axboe

