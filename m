Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRJALOb>; Mon, 1 Oct 2001 07:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274873AbRJALOV>; Mon, 1 Oct 2001 07:14:21 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:33037 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S274868AbRJALOM>; Mon, 1 Oct 2001 07:14:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: 2.4.9-ac16 good perfomer?
Date: Mon, 1 Oct 2001 13:14:28 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0109282217530.19147-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109282217530.19147-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011001111435Z16281-2757+2605@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 29, 2001 03:20 am, Rik van Riel wrote:
> > Is it normal to have Inact_target 1/4 of main memory (64MB of 256MB RAM)?
> > In previous versions, this value would fluctuate with the load of the
> > system.
> >
> > Is this expected?
> 
> Yes, this is a 'compensation' for the fact that page aging changed
> from exponential to linear.  The combination of linear page aging
> with a large inactive_target results in a good combination of
> frequency- and recency-based page eviction.
> 
> Doing just linear page aging with a small inactive target resulted
> in worse throughput than exponential page aging for some workloads,
> better for other workloads.  Linear page aging with a large inactive
> target results in good througput and latency under all workloads I've
> found up to now.  As usual, thanks go out to Matt Dillon for finding
> this balancing point.

Nice.  With this under control, another feature of his memory manager you 
could look at is the variable deactivation threshold, which makes a whole lot 
more sense now that the aging is linear.  To implement it efficiently 
PAGE_AGE_DECL just needs to be a variable, since in effect the deactivation 
threshold already is exactly PAGE_AGE_DECL.

How to set this variable is a deep and interesting question.  Matt had his 
ideas on that as you know, and in fact it's a key feature of the BSD 
mm it, but it's far from clear that the BSD arrangement could be used 
directly in Linux.  There are a number of obvious difficulties: no reverse 
map, highmem, more caches to balance, and so on.  However, it's intuitively 
clear that the mm sweet spot can be made bigger by controlling the DECL 
variable, i.e., we can push the thrash point further out for a wider variety 
of loads.

Obligatory disclaimer: there is no burning issue here; this is a 
*developmental* idea.

--
Daniel
