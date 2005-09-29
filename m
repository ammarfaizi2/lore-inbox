Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVI2Xx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVI2Xx0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVI2Xx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:53:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932380AbVI2XxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:53:25 -0400
Date: Thu, 29 Sep 2005 16:52:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] vm - swap_prefetch v12
Message-Id: <20050929165245.77bf3411.akpm@osdl.org>
In-Reply-To: <200509300942.28843.kernel@kolivas.org>
References: <200509300115.33060.kernel@kolivas.org>
	<200509300912.58722.kernel@kolivas.org>
	<20050929162402.71eee9c2.akpm@osdl.org>
	<200509300942.28843.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> On Fri, 30 Sep 2005 09:24 am, Andrew Morton wrote:
> > Con Kolivas <kernel@kolivas.org> wrote:
> > > On Fri, 30 Sep 2005 07:54 am, Andrew Morton wrote:
> > > > Con Kolivas <kernel@kolivas.org> wrote:
> > > > > Once pages have been added to the swapped list, a timer is started,
> > > > > testing for conditions suitable to prefetch swap pages every 5
> > > > > seconds. Suitable conditions are defined as lack of swapping out or
> > > > > in any pages, and no watermark tests failing. Significant amounts of
> > > > > dirtied ram also prevent prefetching. It then checks that we have
> > > > > spare ram looking for at least 3* pages_high free per zone and if it
> > > > > succeeds that will prefetch pages from swap.
> > > >
> > > > Did you consider poking around in gendisk.disk_stats to determine
> > > > whether the swap disk(s) are idleish?
> > >
> > > I didn't know where to look for that info. Thanks! I'm open to *any*
> > > suggestions and I'll look into it as I can't take this code much further
> > > without outside help.
> >
> > Might also be able to utilise CFQ's I/O priorities.  That should be more
> > efective than a heuristic based on disk_stats, however you'd probably need
> > to work out whether the swapdev actually supports IO priorities and I'm not
> > sure how one would query that (cleanly).
> 
> Good idea. It should be easy to simply add the ioprio value to the kprefetchd 
> thread and it either supports it or it doesn't depending on what iosched is 
> being used. 

Right.  But if the queue doesn't support io priorities then one might want
to fall back to monitoring recent queue activity.

> Further to your original suggestion, prefetching is already delayed when any 
> non-prefetch related swap in or out is occurring already so checking 
> diskstats is probably not going to add to that for swap activity. However I 
> assume it (diskstats) could also be used for all disk i/o as well?

Precisely.  Few people would set an entire disk aside for swap.

> Currently 
> a lot of dirty data can tell me that lots of writing is happening but I have 
> no way of checking that lots of reads are occurring.

diskstats will tell that.  Also one could peek at the current disk queue
levels (request_list.count[]).   
