Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVHHR1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVHHR1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVHHR1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:27:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38017 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932129AbVHHR1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:27:53 -0400
Date: Mon, 8 Aug 2005 10:25:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: Fw: two 2.6.13-rc3-mm3 oddities
Message-Id: <20050808102559.131bf839.akpm@osdl.org>
In-Reply-To: <20050808164636.GA6153@in.ibm.com>
References: <20050803095644.78b58cb4.akpm@osdl.org>
	<20050808140536.GC4558@in.ibm.com>
	<42F788F8.1000001@colorfullife.com>
	<20050808164636.GA6153@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> On Mon, Aug 08, 2005 at 06:31:52PM +0200, Manfred Spraul wrote:
> > Dipankar Sarma wrote:
> > 
> > >Hugh, could you please try this with the experimental patch below ?
> > >Manfred, is it safe to decrement nr_files in file_free()
> > >instead of the destructor ? I can't see any problem.
> > >
> > > 
> > >
> > The ctor/dtor are only called when new objects are created, not on every 
> > kmem_cache_alloc/kmem_cache_free. Thus I would expect that the counter 
> > becomes negative on builds without CONFIG_DEBUG_SLAB.
> > Thus increase in the ctor and decrease in file_free() is the wrong 
> > thing. If you want to move the decrease from the dtor to file_free, then 
> > you must move the increase, too.
> > But: IIRC the counters were moved to the ctor/dtor for performance 
> > reasons, I'd guess mbligh ran into cache line trashing on the 
> > filp_count_lock spinlock with reaim or something like that.
> 
> Ah, so the whole idea was to inc/dec nr_files less often so
> that we reduce contention on filp_count_lock, right ? This however
> causes skews nr_files by the size of the slab array, AFAICS.
> Since we check nr_files before we allocate files from slab, the
> check seems inaccurate.
> 
> Anyway, I guess, I need to look at scaling the file counting
> first.

Something like vm_acct_memory() or percpu_counter would suit.
