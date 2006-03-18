Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWCRFQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWCRFQL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 00:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWCRFQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 00:16:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751421AbWCRFQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 00:16:10 -0500
Date: Fri, 17 Mar 2006 21:13:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: steiner@sgi.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce overhead of calc_load
Message-Id: <20060317211315.55457f22.akpm@osdl.org>
In-Reply-To: <441B7489.1090403@yahoo.com.au>
References: <20060317145709.GA4296@sgi.com>
	<20060317145912.GA13207@elte.hu>
	<20060317152611.GA4449@sgi.com>
	<20060317171538.3826eb41.akpm@osdl.org>
	<441B6BD3.2030807@yahoo.com.au>
	<20060317183742.10431ba2.akpm@osdl.org>
	<441B7489.1090403@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> >>Is there a need? Do they (except calc_load) use multiple values at
> >>the same time?
> > 
> > 
> > Don't know.  It might happen in the future.  And the additional cost is
> > practically zero.
> > 
> 
> Unless it happens to hit another cacheline (cachelines for all other
> CPUs but our own will most likely be invalid on this cpu). In which
> case the cost could double quite easily.
> 

That would be an inefficient implementation.  Let's not implement it
inefficiently.

> I think it might be better to leave it for the moment. If something comes
> up we can always take a look at it then (it isn't particularly tricky code).

What we're seeing here is a proliferation of little functions, all of which
do the same thing, some of them in different ways.

Take a look at (for example) nr_iowait.  We forget to spill the count out
of the departing CPU's runqueue and hence we have to sum it across all
possible CPUs and we don't bother accounting for the possibility of the sum
going negative because we happen to dink with the runqueue of a
now-possibly-downed CPU.  It's inefficient and it's inconsistent and some
of it is, or will become incorrect.  The other counters there probably have
various combinations of these problems but I can't be bothered checking
them all because they're all implemented differently.

Better to do them all in the one place and do them all the same way.  I'd
suggest a cacheline-aligned struct of local_t's which can be queried into a
struct of ulongs.

That query should only look at online CPUs, which becomes rather necessary
if we're to allocate runqueues only for online CPUs (desirable - the thing
is huge).
