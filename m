Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310859AbSCNHcz>; Thu, 14 Mar 2002 02:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSCNHcq>; Thu, 14 Mar 2002 02:32:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54544 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S310859AbSCNHc0>;
	Thu, 14 Mar 2002 02:32:26 -0500
Date: Thu, 14 Mar 2002 08:32:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFT] simple deadline I/O scheduler
Message-ID: <20020314073216.GB30351@suse.de>
In-Reply-To: <20020104094334.N8673@suse.de> <E16l8sQ-0000EX-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16l8sQ-0000EX-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13 2002, Daniel Phillips wrote:
> On January 4, 2002 09:43 am, Jens Axboe wrote:
> > I've played around with implementing an I/O scheduler that _tries_ to
> > start request within a given time limit. Note that it makes no
> > guarentees of any sort, it's simply a "how does this work in real life"
> > sort of thing. It's main use is actually to properly extend the i/o
> > scheduler / elevator api to be able to implement more advanced
> > schedulers (eg cello).
> > 
> > The construction of this new i/o scheduler is similar to how cello is
> > build -- you have several "low level" schedulers and a class independent
> > one on top of those that decides which one to start processing.
> > 
> > Each request is sorted into two lists -- one is purely sector sorted,
> > the other is sorted [1] by expire time. We always serve request from the
> > sector sorted list, until one of the front requests on the expire list
> > has its deadline violated. Then we start following the sorted list from
> > the point of the deadline violated request. This is always done in
> > batches of eg 8 or 16 requests, to avoid seeking like mad if we can't
> > keep up with the deadlines.
> 
> This post never seemed to get the attention it deserves.  Do you have 
> performance measurements now?

I have some old ones that are not too interesting. Someone else
expressed an interest in the deadline scheduler a few days back, so I
resurrected it for 2.5.7-pre1 and started testing. Right now I'm just
writing a few tools to properly stress it and get the performance
measurements that I want. So I'll be back with something soonish, I
hope.

> As part of my experimental hack to get rid of buffer_heads I was casting 
> around for a structure to replace the dirty buffer list.  I find myself 
> heading towards the conclusion I want a structure that's remarkably similar 
> to what you've cooked up here, but that lives at a higher level in the 
> system.  The idea is that a page goes into the queue as soon as it's dirtied 
> and the elevator takes care of scheduling and merging from there.  Admittedly 
> these ideas are half-formed at the moment, but what I see developing is a 
> situation where we have attempts at IO scheduling going on at two levels in 
> the system, the VM and bio, and the more I think about it the less sense it 
> makes.  It's trying to be one subsystem.

Very close to some ideas I have as well. My first plan was to do 'pull
flushing' instead of the current (often horrible) pushes from bdflush
etc. Having the vm give up the dirty pages as soon as possible would
make it easier to do merging at the vm level as well.

> Andrew Morton is also working in here, with a collection of ideas that I hope 
> are complementary if looked at the right way.  See his '[patch] delayed disk 
> block allocation' post.

Right, I noticed. We could get good write clustering in general with vm
merging, though.

-- 
Jens Axboe

