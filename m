Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWFTI26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWFTI26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWFTI26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:28:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:39370 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965026AbWFTI24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:28:56 -0400
Message-ID: <4497B1B4.3020307@sgi.com>
Date: Tue, 20 Jun 2006 10:28:36 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: discuss@x86-64.org, Tony Luck <tony.luck@intel.com>,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: [discuss] Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
References: <200606140942.31150.ak@suse.de> <200606161317.19296.ak@suse.de> <44929CE6.4@sgi.com> <200606161654.15881.ak@suse.de>
In-Reply-To: <200606161654.15881.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> I really don't see the benefit here. malloc already gets pages handed
>> down from the kernel which are node local due to them being assigned at
>> a first touch basis. I am not sure about glibc's malloc internals, but
>> rather rely on a vgetcpu() call, all it really needs to do is to keep
>> a thread local pool which will automatically get it's thing locally
>> through first touch usage.
> 
> That would add too much overhead on small systems. It's better to be 
> able to share the pools. vgetcpu allows that.

How do you expect to be able to share the pools? Or are you saying you
just one page per numa node? Having a page per thread is not noticable
and for databases, which was your primary target usergroup, I think it's
fair to see it won't even be visible as noise.

>>> Basically it is just for extending the existing already used proven etc.
>>> default local policy to sub pages. Also there might be other uses
>>> of it too (like per CPU data), although I expect most use of that
>>> in user space can be already done using TLS.
>> The thread libraries already have their own thread local area which
>> should be allocated on the thread's own node if done right, which I
>> assume it is.
> 
> - The heap for small allocations is shared (although this can be tuned) 
> - When another thread does free() you need special handling to keep
> the item in the correct free lists
> This is one of the tricky bits in the new kernel NUMA slab allocator
> too.

It should be pretty easy to make the allocator aware of the per thread
regions based on the address.

>> If you migrate your app elsewhere, you should migrate the pages with it,
>> or not expect things to run with the local effect.
> 
> That's too costly to do by default and you have no guarantee that it will amortize.

But if you don't migrate the pages with it, the numa aware allocation is
wasted anyway, whether you do it on a first-touch basis or using
vgetcpu.

>> I don't really see the point in solving something half way when it can
>> be done better. Maybe the "serious" databases should open up and let us
>> know what the problem is they are hitting.
> 
> I see no indication of anything better so far from you. You only offered
> static configuration instead which while in some cases is better
> doesn't work in the general case.

Static configuration? I never said anything about that, I said that libc
should offer a memory pool per thread and have it created when it's
first touched by the thread. That solves exactly what you have described
so far unless is something else you also expect to benefit from
vgetcpu().

Jes
