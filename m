Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWBWLA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWBWLA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 06:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWBWLA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 06:00:57 -0500
Received: from ns2.suse.de ([195.135.220.15]:61163 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751126AbWBWLA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 06:00:56 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [Patch 2/3] fast VMA recycling
Date: Thu, 23 Feb 2006 12:00:42 +0100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <200602231105.30581.ak@suse.de> <1140689706.4672.28.camel@laptopd505.fenrus.org>
In-Reply-To: <1140689706.4672.28.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231200.42990.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 11:15, Arjan van de Ven wrote:
> On Thu, 2006-02-23 at 11:05 +0100, Andi Kleen wrote:
> > On Thursday 23 February 2006 10:48, Arjan van de Ven wrote:
> > > On Thu, 2006-02-23 at 10:42 +0100, Andi Kleen wrote:
> > > > On Thursday 23 February 2006 10:30, Arjan van de Ven wrote:
> > > > > This patch adds a per task-struct cache of a free vma. 
> > > > > 
> > > > > In normal operation, it is a really common action during userspace mmap 
> > > > > or malloc to first allocate a vma, and then find out that it can be merged,
> > > > > and thus free it again. In fact this is the case roughly 95% of the time.
> > > > > 
> > > > > In addition, this patch allows code to "prepopulate" the cache, and
> > > > > this is done as example for the x86_64 mmap codepath. The advantage of this
> > > > > prepopulation is that the memory allocation (which is a sleeping operation
> > > > > due to the GFP_KERNEL flag, potentially causing either a direct sleep or a 
> > > > > voluntary preempt sleep) will happen before the mmap_sem is taken, and thus 
> > > > > reduces lock hold time (and thus the contention potential)
> > > > 
> > > > The slab fast path doesn't sleep. 
> > > 
> > > it does via might_sleep()
> > 
> > Hmm? That shouldn't sleep.
> 
> see voluntary preempt.

Only when its time slice is used up but then it would sleep a bit later 
in user space. But it should be really a unlikely case and nothing
to optimize for.

> 
> > If it takes any time in a real workload then it should move into DEBUG_KERNEL
> > too. But I doubt it. Something with your analysis is wrong.
> 
> well I'm seeing contention; and this is one of the things that can be
> moved out of the lock easily, and especially given the high recycle rate
> of these things... looks worth it to me.

I think you need a better analysis of what is actually happening
instead of trying all kind of weird quick fragile hacks.

-Andi

