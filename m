Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUIZR66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUIZR66 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 13:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUIZR66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 13:58:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9710 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261375AbUIZR64
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 13:58:56 -0400
Date: Sun, 26 Sep 2004 13:18:16 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Kevin Fenzi <kevin@scrye.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Message-ID: <20040926161816.GA27702@logos.cnet>
References: <20040924021956.98FB5A315A@voldemort.scrye.com> <20040924143714.GA826@openzaurus.ucw.cz> <20040924210958.A3C5AA2073@voldemort.scrye.com> <1096069216.3591.16.camel@desktop.cunninghams> <20040925014546.200828E71E@voldemort.scrye.com> <1096113235.5937.3.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096113235.5937.3.camel@desktop.cunninghams>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 09:53:55PM +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Sat, 2004-09-25 at 11:45, Kevin Fenzi wrote:
> > Nigel> The problem isn't really that you're out of memory. Rather, the
> > Nigel> memory is so fragmented that swsusp is unable to get an order 8
> > Nigel> allocation in which to store its metadata. There isn't really
> > Nigel> anything you can do to avoid this issue apart from eating
> > Nigel> memory (which swsusp is doing anyway).
> > 
> > Odd. I have never run into this before with either swsusp2 or
> > swsusp1. 
> 
> You won't run into it with suspend2 because it doesn't use high order
> allocations. There might be one exception, but apart from that, all of
> suspend2's data is stored in order zero allocated pages, so
> fragmentation is not an issue. This is the real solution to the problem.
> I had to do it this way because I aim to have suspend work without
> eating any memory.
> 
> > What causes memory to be so fragmented? 
> 
> Normal usage; the pattern of pages being freed and allocated inevitably
> leads to fragmentation. The buddy allocator does a good job of
> minimising it, but what is really needed is a run-time defragmenter. I
> saw mention of this recently, but it's probably not that practical to
> implement IMHO.

I think it is possible to have a defragmenter: allocate new page, 
invalidate mapped pte's, invalidate radix tree entry (and block radix lookups),`
copy data from oldpage to newpage, remap pte's, insert radix tree
entry, free oldpage.

The memory hotplug patches do it - I'm trying to implement a similar version
to free physically nearby pages and form high order pages.
