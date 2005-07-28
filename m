Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVG1JeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVG1JeI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 05:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVG1JeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 05:34:07 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:58258 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261397AbVG1JeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:34:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=nJDBsK3pnETKHz6R1PA8CLxyP4rDKD19plqzJBfg0KU/nQXoV1fj6yds7UH+ZwHQxjLEnI952cfaBY+1m/WqeUAU6je0yzl2JwuvD+YNryb+URuj16elwdol4mjb+hW/qxiVUh7prIGhpDHskwooWY3qw0+mDA0rw9L0c2ar51c=  ;
Message-ID: <42E8A688.7070802@yahoo.com.au>
Date: Thu, 28 Jul 2005 19:34:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
References: <10613.1122538148@kao2.melbourne.sgi.com> <42E897FD.6060506@yahoo.com.au> <20050728083544.GA22740@elte.hu> <42E89BE6.6040304@yahoo.com.au> <20050728091638.GA25846@elte.hu>
In-Reply-To: <20050728091638.GA25846@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 

>>>such as?
>>
>>Not sure. thread_info? Maybe next->timestamp or some other fields in 
>>next, something in next->mm?
> 
> 
> next->thread_info we could and should prefetch - but from the generic 
> scheduler code (see the patch i just sent).
> 

Right. We're always testing the TIF_NEED_RESCHED field after the
switch.

> i'm not sure what you mean by prefetching next->timestamp, it's an 
> inline field to 'next', in the first cacheline of it, which we've 
> already used so it's present. (If you mean the value of next->timestamp, 
> that has no address meaning at all so would lead to unpredictable 
> results on some arches.)
> 

No, I meant the cacheline holding the field of course. I guess I
could have looked for a field further down, but even so, ->timestamp
might be 96 bytes into the structure on a 64-bit arch, which may or
may not be the first cacheline... but you get the idea.

> next->mm we might want to prefetch, but it's probably not worth it 
> because we are referencing it too soon, in context_switch(). (while the 
> kernel stack itself wont be referenced until the full context-switch is 
> done) But might be worth trying - but even then, it should be done from 
> the generic code, like the thread_info and kernel-stack prefetching.
> 
> 
>>I didn't really have a concrete example, but in the interests of being 
>>future proof...
> 
> 
> i'd like to keep generic bits in generic code, and only move things to 
> per-arch include files if absolutely necessary. next->mm is generic.
> 

Yeah, then a specific field _within_ next->mm or thread_info may
want to be fetched. In short, I don't see any argument why we
shouldn't call the function prefetch_task().

Secondly, I don't really like your prefetch(kernel_stack()) function
because it doesn't really give architectures enough control over
exactly what cachelines they get in memory.

prefetching and memory access patterns of all this stuff are fairly
architecture specific. I see nothing wrong with having a prefetch_task()
call. (Although I agree things like thread_info->flags and next->mm can
be done in generic code).

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
