Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWATIXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWATIXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWATIXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:23:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750716AbWATIXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:23:39 -0500
Date: Fri, 20 Jan 2006 00:23:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: davej@redhat.com, AChittenden@bluearc.com, linux-kernel@vger.kernel.org,
       lwoodman@redhat.com
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-Id: <20060120002307.76bcbc27.akpm@osdl.org>
In-Reply-To: <20060120081231.GE4213@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270355601F@uk-email.terastack.bluearc.com>
	<20060119194836.GM21663@redhat.com>
	<20060119141515.5f779b8d.akpm@osdl.org>
	<20060120081231.GE4213@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Thu, Jan 19 2006, Andrew Morton wrote:
> > Dave Jones <davej@redhat.com> wrote:
> > >
> > > On Thu, Jan 19, 2006 at 03:11:45PM -0000, Andy Chittenden wrote:
> > >  > DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
> > >  > present:12740kB pages_scanned:4 all_unreclaimable? yes
> > > 
> > > Note we only scanned 4 pages before we gave up.
> > > Larry Woodman came up with this patch below that clears all_unreclaimable
> > > when in two places where we've made progress at freeing up some pages
> > > which has helped oom situations for some of our users.
> > 
> > That won't help - there are exactly zero pages on ZONE_DMA's LRU.
> > 
> > The problem appears to be that all of the DMA zone has been gobbled up by
> > the BIO layer.  It seems quite inappropriate that a modern 64-bit machine
> > is allocating tons of disk I/O pages from the teeny ZONE_DMA.  I'm
> > suspecting that someone has gone and set a queue's ->bounce_gfp to the wrong
> > thing.
> > 
> > Jens, would you have time to investigate please?
> 
> Certainly, I'll get this tested and fixed this afternoon.

Wow ;)

You may find it's an x86_64 glitch - setting max_[low_]pfn wrong down in
the bowels of the arch mm init code, something like that.

I thought it might have been a regression which came in when we added
ZONE_DMA32 but the RH reporter is based on 2.6.14-<redhat stuff>, and he
didn't have ZONE_DMA32.

