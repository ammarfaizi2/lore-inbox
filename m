Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWCLIgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWCLIgU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 03:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWCLIgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 03:36:20 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:48620 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751500AbWCLIgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 03:36:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
Date: Sun, 12 Mar 2006 19:36:02 +1100
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <200603102054.20077.kernel@kolivas.org> <1142139283.25358.68.camel@mindpipe> <1142141256.8021.18.camel@homer>
In-Reply-To: <1142141256.8021.18.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603121936.02899.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 March 2006 16:27, Mike Galbraith wrote:
> On Sat, 2006-03-11 at 23:54 -0500, Lee Revell wrote:
> > echo 64 > /sys/block/hd*/queue/max_sectors_kb
> >
> > There is basically a straight linear relation between whatever you set
> > this to and the maximum scheduling latency you see.  It was developed to
> > solve the exact problem you are describing.
>
> Ah, a very useful bit of information, thanks.
>
> It won't help Con though, because he'll be dealing with every possible
> configuration.  I think he's going to have to either submit, wait,
> bandwidth limiting sleep, repeat or something clever that does that.
> Even with bandwidth restriction though, seek still bites mightily, so I
> suspect he's stuck with little trickles of IO started when we'd
> otherwise be idle.  We'll see I suppose.

What I'm doing with that last patch works fine - don't prefetch if anything 
else is running. Prefetching is not a performance critical function and we 
cannot know what tasks are scheduling latency sensitive. With that latest 
patch the most expensive thing is doing nr_running(). Assuming anything is 
running, it only needs to do that once every 5 seconds - and only after 
something is in swap. Furthermore it doesn't do it if swap prefetch is 
disabled with the tunable. I don't think this is an expensive operation in 
that context and certainly avoids any problems with it. 

I could hack in a weighted load variant of it so that prefetch does run when 
only nice 19 tasks are running on top of it so that perhaps low priority 
compiles, distributed computing clients et al don't prevent prefetching from 
happening - I could do this on top of the current patch. I'd like to see that 
last patch go in. Does anyone have another alternative? 

Cheers,
Con
