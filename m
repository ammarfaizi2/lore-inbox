Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSKTUfe>; Wed, 20 Nov 2002 15:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSKTUfe>; Wed, 20 Nov 2002 15:35:34 -0500
Received: from waste.org ([209.173.204.2]:65236 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261872AbSKTUfa>;
	Wed, 20 Nov 2002 15:35:30 -0500
Date: Wed, 20 Nov 2002 14:42:32 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: the random driver
Message-ID: <20021120204232.GG622@waste.org>
References: <3DDB3DED.A4C9DC56@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDB3DED.A4C9DC56@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 11:46:53PM -0800, Andrew Morton wrote:
> 
> I'm seeing a context switch rate of 150/sec just writing a
> big file to disk at 20 megabytes/sec.
> 
> It is coming out of add_disk_randomness()'s invokation of
> batch_entropy_store().

First off, there's very little unobservable randomness in those disk
ops, especially in a file/webserver context, so the value of
add_disk_randomness is questionable.
 
> That function is setting up deferred punt-to-process-context
> for every disk request, and has the potential to cause 1000
> context switches per second.  This is clearly excessive.
> 
> There is a 256 slot buffer in the random driver for this,
> and we are not using it at all effectively.  I do intend
> to submit the below patch which will cause one context switch
> per 128 requests.

Done that.

> But this is a minimal fix.  The batch_entropy_pool handling
> in there needs work.
> 
> a) It's racy.  The head and tail pointers have no SMP protection
>    and a race will cause it to dump 128 already-processed items
>    back into the entropy pool.

I have a rewrite that fails safe and is lockless. But this is nothing
compared to the completely broken entropy accounting in
xfer_secondary_pool. Try this: cat /dev/random, wait for it to block,
and then tap your mouse.

> d) It's punting work up to process context which could be performed
>    right there in interrupt context.

Disagree. Did you look at the mixing function? It'll dirty a large
chunk of cache.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
