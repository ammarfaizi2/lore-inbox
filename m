Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318971AbSHSSLz>; Mon, 19 Aug 2002 14:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318970AbSHSSLz>; Mon, 19 Aug 2002 14:11:55 -0400
Received: from dsl-213-023-038-214.arcor-ip.net ([213.23.38.214]:6787 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318971AbSHSSLy>;
	Mon, 19 Aug 2002 14:11:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Scott Kaplan <sfkaplan@cs.amherst.edu>, Mel <mel@csn.ul.ie>
Subject: Re: [PATCH] rmap 14
Date: Mon, 19 Aug 2002 20:04:29 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Bill Huey <billh@gnuppy.monkey.org>, Rik van Riel <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <40D0F925-B15F-11D6-972F-000393829FA4@cs.amherst.edu>
In-Reply-To: <40D0F925-B15F-11D6-972F-000393829FA4@cs.amherst.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17gqtC-0000ql-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 August 2002 23:29, Scott Kaplan wrote:
> > Now... where this is going. I plan to write a module that will generate
> > page references to a given pattern. Possible pattern references are
> >
> > o Linear
> > o Pure random
> > o Random with gaussian distribution
> > o Smooth so the references look like a curve
> > o Trace data taken from a "real" application or database
> 
> Noooooooooo!
> 
> I can't think of a reason to test the VM under any one of the first three
> distributions.  I've never, *ever* seen or heard of a linear or gaussian
> distribution of page references.  As for uniform random (which is what I
> assume you mean by ``pure random''), that's not worth testing.  If a
> workload presents a pure random reference pattern, any on-line policy is
> screwed.  No process can do this on a data set that doesn't fit in memory,
> and if it does, there's no hope.

I disagree that the linear (which I assume means walk linearly through 
process memory) and random patterns aren't worth testing.  The former should 
produce very understandable behaviour and that's always a good thing.  It's 
an idiot check.  Specifically, with the algorithms we're using, we expect the 
first-touched pages to be chosen for eviction.  It's worth verifying that 
this works as expected.

Random gives us a nice baseline against which to evaluate our performance on 
more typical, localized loads.  That is, we need to know we're doing better 
than random, and it's very nice to know by how much.

The gaussian distribution is also interesting because it gives a simplistic 
notion of virtual address locality.  We are supposed to be able to predict 
likelihood of future uses based on historical access patterns, the question 
is: do we?  Comparing the random distribution to gaussian, we ought to see 
somewhat fewer evictions on the gaussian distribution.  (I'll bet right now 
that we completely fail that test, because we just do not examine the 
referenced bits frequently enough to recover any signal from the noise.)

I'll leave the more complex patterns to you and Mel, but these simple 
patterns are particularly interesting to me.  Not as a target for 
optimization, but more to verify that basic mechanisms are working as 
expected.

-- 
Daniel
