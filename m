Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVJTQbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVJTQbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 12:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVJTQbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 12:31:32 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:14779 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932430AbVJTQbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 12:31:32 -0400
Date: Thu, 20 Oct 2005 11:31:16 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc4 latency issue with rcu_process_callbacks()/file_free_rcu()
Message-ID: <20051020163116.GA23262@sgi.com>
References: <20051020140733.GA21149@sgi.com> <4357BE1C.9080004@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4357BE1C.9080004@cosmosbay.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2005 at 05:56:12PM +0200, Eric Dumazet wrote:
> Dimitri Sivanich a écrit :
> >Just bringing up a latency issue I've noticed recently.
> >
> >In or around 2.6.14-rc4 some changes were made to have the call to
> >kmem_cache_free() from file_free() in the Linux kernel be deferred, running
> >as a tasklet via file_free_rcu(), rather than running kmem_cache_free()
> >right from file_free() directly.
> >
> >I've noticed that rcu_process_callbacks() can take quite a while to run
> >now that it routinely calls file_free_rcu() to run kmem_cache_free().
> >This can make the cpu unavailable for 100's of usec on 1GHz machines, with
> >or without preemption configured on (much of this path is non-preemptible).
> >
> >This can result in some unpredictable periods of fairly long cpu latency,
> >such as when a thread is waiting to be woken by an interrupt handler on a
> >'now quiet' cpu.  Changing file_free() to call kmem_cache_free() directly
> >completely eliminates this unexpected latency.
> 
> Well, you cannot change file_free() to call kmem_cache_free() directly, or 
> risk corruption/crash.
> 
> See Documentation/RCU/UP.txt

OK.  I'll have to look at this more closely.  I simply ran across this as a
substantial change between this and earlier kernels and decided to test
against the original file_free()->kmem_cache_free() code to ensure that that
alone was indeed the issue (for the circumstance I'll describe below).

> 
> Dont you notice latency issue with other RCU protected data, like dentries ?

No, but here's the circumstance under which I notice this:

I'm running on a single cpu of an SMP system (4 cpu).  When I hit this I'm in
a situation where I've written some file data, and am now sleeping waiting to
be woken up.  No other threads are running on that cpu other than a few kernel
threads, so all is fairly quiet.

By the simple one line change (file_free() calling kmem_cache_free() again),
I'm always woken up very quickly.   Too bad we cannot revert back that way
with the rcu changes.

> 
> BTW a change in 2.6.14-rc5 might give different latency results.

I'll look at this as soon as I get a chance.

> 
> Eric
