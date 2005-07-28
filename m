Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVG1KKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVG1KKC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVG1KHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:07:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57805 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261353AbVG1KFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 06:05:45 -0400
Date: Thu, 28 Jul 2005 12:04:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050728100429.GA27030@elte.hu>
References: <10613.1122538148@kao2.melbourne.sgi.com> <42E897FD.6060506@yahoo.com.au> <20050728083544.GA22740@elte.hu> <42E89BE6.6040304@yahoo.com.au> <20050728091638.GA25846@elte.hu> <42E8A688.7070802@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E8A688.7070802@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >i'm not sure what you mean by prefetching next->timestamp, it's an 
> >inline field to 'next', in the first cacheline of it, which we've 
> >already used so it's present. (If you mean the value of next->timestamp, 
> >that has no address meaning at all so would lead to unpredictable 
> >results on some arches.)
> >
> 
> No, I meant the cacheline holding the field of course. I guess I could 
> have looked for a field further down, but even so, ->timestamp might 
> be 96 bytes into the structure on a 64-bit arch, which may or may not 
> be the first cacheline... but you get the idea.

i'd rather wait with that one. A prefetch can generate a prefetch of the 
next cacheline too, so it might or might not make sense to prefetch both 
cachelines explicitly.

Also, explicity prefetching &next->timestamp is ugly because it includes 
a number of bad assumptions. If multi-cacheline prefetching becomes 
necessary then this needs to be implemented via a generic extension to 
prefetch.h:

	prefetch_area(void *first_addr, void *last_addr)

(or as addr,len)

This way an architecture can decide how it prefetches continuous 
cachelines _without knowing anything about the structure being 
prefetched_.

Also, the generic code using the prefetches could this way designate 
'cache-hot' areas without having to know about cacheline size or 
prefetching tactics of the architecture. (prefetch_area() could be done 
compile-time so it would be equivalent to a single-cacheline prefetch on 
arches with larger cachelines.)

> > i'd like to keep generic bits in generic code, and only move things 
> > to per-arch include files if absolutely necessary. next->mm is 
> > generic.
> 
> Yeah, then a specific field _within_ next->mm or thread_info may want 
> to be fetched. In short, I don't see any argument why we shouldn't 
> call the function prefetch_task().

it's a fundamental thing: we _dont_ want to push generic code into 
architectures, and there's nothing per-arch about next->mm.

thread_info is really small on most arches, and even if they are not, 
the most important data is always grouped to the top of a structure.  
(this is a pretty fundamental concept throughout the kernel)

> Secondly, I don't really like your prefetch(kernel_stack()) function 
> because it doesn't really give architectures enough control over 
> exactly what cachelines they get in memory.

my point is, it comes down to concrete examples, it may or may not make 
sense to do things per-arch.

If this was per-arch most arches wouldnt get this benefit, and the 
propagation of any improvements would likely stick in whatever arch did 
that. We've seen that happen too many times to not repeat this mistake 
again. We've got 24 architectures (and counting), so any code 'left to 
the architecture to control' will propagate to other architectures only 
very slowly.

try to look at it from another angle: probably only because i insisted 
on doing this in the generic code and not per-arch did we end up 
discovering the potential generic need to prefetch next->thread_info and 
next->mm.

> prefetching and memory access patterns of all this stuff are fairly 
> architecture specific.

true of course, but from this it does not follow at all that we should 
move all task-switch related prefetching into a prefetch_task() call!

> [...] I see nothing wrong with having a prefetch_task() call.  
> (Although I agree things like thread_info->flags and next->mm can be 
> done in generic code).

great that we now agree wrt. thread_info and next->mm. My remaining 
point is, once we prefetch ->thread_info, ->mm and the kernel stack, 
nothing else significant remains! (It's still very much possible that 
something needs to be prefetched per-arch, but i'd like to see a robust 
case be made for it, instead of your global 'it might happen' argument.)

	Ingo
