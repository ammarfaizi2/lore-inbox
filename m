Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310580AbSCMNhw>; Wed, 13 Mar 2002 08:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310581AbSCMNhm>; Wed, 13 Mar 2002 08:37:42 -0500
Received: from dsl-213-023-039-082.arcor-ip.net ([213.23.39.82]:29327 "EHLO
	starship") by vger.kernel.org with ESMTP id <S310580AbSCMNhY>;
	Wed, 13 Mar 2002 08:37:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFT] simple deadline I/O scheduler
Date: Wed, 13 Mar 2002 14:33:10 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020104094334.N8673@suse.de>
In-Reply-To: <20020104094334.N8673@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16l8sQ-0000EX-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 4, 2002 09:43 am, Jens Axboe wrote:
> I've played around with implementing an I/O scheduler that _tries_ to
> start request within a given time limit. Note that it makes no
> guarentees of any sort, it's simply a "how does this work in real life"
> sort of thing. It's main use is actually to properly extend the i/o
> scheduler / elevator api to be able to implement more advanced
> schedulers (eg cello).
> 
> The construction of this new i/o scheduler is similar to how cello is
> build -- you have several "low level" schedulers and a class independent
> one on top of those that decides which one to start processing.
> 
> Each request is sorted into two lists -- one is purely sector sorted,
> the other is sorted [1] by expire time. We always serve request from the
> sector sorted list, until one of the front requests on the expire list
> has its deadline violated. Then we start following the sorted list from
> the point of the deadline violated request. This is always done in
> batches of eg 8 or 16 requests, to avoid seeking like mad if we can't
> keep up with the deadlines.

This post never seemed to get the attention it deserves.  Do you have 
performance measurements now?

As part of my experimental hack to get rid of buffer_heads I was casting 
around for a structure to replace the dirty buffer list.  I find myself 
heading towards the conclusion I want a structure that's remarkably similar 
to what you've cooked up here, but that lives at a higher level in the 
system.  The idea is that a page goes into the queue as soon as it's dirtied 
and the elevator takes care of scheduling and merging from there.  Admittedly 
these ideas are half-formed at the moment, but what I see developing is a 
situation where we have attempts at IO scheduling going on at two levels in 
the system, the VM and bio, and the more I think about it the less sense it 
makes.  It's trying to be one subsystem.

Andrew Morton is also working in here, with a collection of ideas that I hope 
are complementary if looked at the right way.  See his '[patch] delayed disk 
block allocation' post.

-- 
Daniel
