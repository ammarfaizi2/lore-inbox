Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWBXTFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWBXTFi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 14:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWBXTFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 14:05:38 -0500
Received: from ns2.suse.de ([195.135.220.15]:58248 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932420AbWBXTFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 14:05:37 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [Patch 2/3] fast VMA recycling
Date: Fri, 24 Feb 2006 20:05:16 +0100
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@intel.linux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <1140688131.4672.21.camel@laptopd505.fenrus.org> <20060224185231.GB5816@infradead.org>
In-Reply-To: <20060224185231.GB5816@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602242005.17087.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 19:52, Christoph Hellwig wrote:
> On Thu, Feb 23, 2006 at 10:48:50AM +0100, Arjan van de Ven wrote:
> > On Thu, 2006-02-23 at 10:42 +0100, Andi Kleen wrote:
> > > On Thursday 23 February 2006 10:30, Arjan van de Ven wrote:
> > > > This patch adds a per task-struct cache of a free vma. 
> > > > 
> > > > In normal operation, it is a really common action during userspace mmap 
> > > > or malloc to first allocate a vma, and then find out that it can be merged,
> > > > and thus free it again. In fact this is the case roughly 95% of the time.
> > > > 
> > > > In addition, this patch allows code to "prepopulate" the cache, and
> > > > this is done as example for the x86_64 mmap codepath. The advantage of this
> > > > prepopulation is that the memory allocation (which is a sleeping operation
> > > > due to the GFP_KERNEL flag, potentially causing either a direct sleep or a 
> > > > voluntary preempt sleep) will happen before the mmap_sem is taken, and thus 
> > > > reduces lock hold time (and thus the contention potential)
> > > 
> > > The slab fast path doesn't sleep. 
> > 
> > it does via might_sleep()
> 
> so turn of the voluntary preempt bullshit. 

I think voluntary preempt is generally a good idea, but we should make it optional
for down() since it can apparently cause bad side effects (like holding 
semaphores/mutexes for too long) 

There would be two possible ways: 

have default mutex_lock()/down() do a might_sleep()
with preemption and have a separate variant that doesn't preempt
or have the default non preempt and a separate variant
that does preempt. 

I think I would prefer the later because for preemption 
it probably makes often more sense to do the preemption
on the up() not the down.

On the other hand one could argue that it's safer to only
change it for mmap_sem, which would suggest a special variant
without preemption and keep the current default.

Actually the non preempt variants probably should still have a might_sleep() 
for debugging, but in a variant that doesn't do preemption (might_sleep_no_preempt()?) 

Ingo, what do you think?

-Andi
