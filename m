Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUFPQEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUFPQEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbUFPQEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:04:16 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:3182 "EHLO omx1.americas.sgi.com")
	by vger.kernel.org with ESMTP id S264097AbUFPQEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:04:14 -0400
Date: Wed, 16 Jun 2004 11:03:55 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Option to run cache reap in thread mode
Message-ID: <20040616160355.GA5963@sgi.com>
References: <20040616142413.GA5588@sgi.com> <20040616152934.GA13527@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616152934.GA13527@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 04:29:34PM +0100, Christoph Hellwig wrote:
> On Wed, Jun 16, 2004 at 09:24:13AM -0500, Dimitri Sivanich wrote:
> > Hi,
> > 
> > In the process of testing per/cpu interrupt response times and CPU availability,
> > I've found that running cache_reap() as a timer as is done currently results
> > in some fairly long CPU holdoffs.
> > 
> > I would like to know what others think about running cache_reap() as a low
> > priority realtime kthread, at least on certain cpus that would be configured
> > that way (probably configured at boottime initially).  I've been doing some
> > testing running it this way on CPU's whose activity is mostly restricted to
> > realtime work (requiring rapid response times).
> > 
> > Here's my first cut at an initial patch for this (there will be other changes
> > later to set the configuration and to optimize locking in cache_reap()).
> 
> YAKT, sigh..  I don't quite understand what you mean with a "holdoff" so
> maybe you could explain what problem you see?  You don't like cache_reap
> beeing called from timer context?

The issue(s) I'm attempting to solve is to achieve more deterministic interrupt
response times on CPU's that have been designated for use as such.  By setting
cache_reap to run as a kthread, the cpu is only unavailable during the time
that irq's are disabled.  By doing this on a cpu that's been restricted from
running most other processes, I have been able to achieve much more
deterministic interrupt response times.

So yes, I don't want cache_reap to be called from timer context when I've
configured a CPU as such.

> 
> As for realtime stuff you're probably better off using something like rtlinux,
> getting into the hrt or even real strong soft rt busuniness means messing up
> the kernel horrible.  Given you're @sgi.com address you probably know what
> a freaking mess and maintaince nightmare IRIX has become because of that.

Keep in mind that it's not like we're trying to achieve fast response times on
all CPU's potentially running any number of processes.

Dimitri Sivanich <sivanich@sgi.com>
