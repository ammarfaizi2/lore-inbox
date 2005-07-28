Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVG1JQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVG1JQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 05:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVG1JQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 05:16:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44488 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261389AbVG1JQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:16:58 -0400
Date: Thu, 28 Jul 2005 11:16:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050728091638.GA25846@elte.hu>
References: <10613.1122538148@kao2.melbourne.sgi.com> <42E897FD.6060506@yahoo.com.au> <20050728083544.GA22740@elte.hu> <42E89BE6.6040304@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E89BE6.6040304@yahoo.com.au>
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

> >>Just a minor point, I agree with David: I'd like it to be called 
> >>prefetch_task(), because some architecture may want to prefetch other 
> >>memory.
> >
> >such as?
> 
> Not sure. thread_info? Maybe next->timestamp or some other fields in 
> next, something in next->mm?

next->thread_info we could and should prefetch - but from the generic 
scheduler code (see the patch i just sent).

i'm not sure what you mean by prefetching next->timestamp, it's an 
inline field to 'next', in the first cacheline of it, which we've 
already used so it's present. (If you mean the value of next->timestamp, 
that has no address meaning at all so would lead to unpredictable 
results on some arches.)

next->mm we might want to prefetch, but it's probably not worth it 
because we are referencing it too soon, in context_switch(). (while the 
kernel stack itself wont be referenced until the full context-switch is 
done) But might be worth trying - but even then, it should be done from 
the generic code, like the thread_info and kernel-stack prefetching.

> I didn't really have a concrete example, but in the interests of being 
> future proof...

i'd like to keep generic bits in generic code, and only move things to 
per-arch include files if absolutely necessary. next->mm is generic.

	Ingo
