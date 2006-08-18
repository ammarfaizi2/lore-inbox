Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWHRGMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWHRGMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWHRGMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:12:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751131AbWHRGMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:12:48 -0400
Date: Thu, 17 Aug 2006 23:05:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@google.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
Message-Id: <20060817230556.7d16498e.akpm@osdl.org>
In-Reply-To: <44E5015D.80606@google.com>
References: <20060808211731.GR14627@postel.suug.ch>
	<44DBED4C.6040604@redhat.com>
	<44DFA225.1020508@google.com>
	<20060813.165540.56347790.davem@davemloft.net>
	<44DFD262.5060106@google.com>
	<20060813185309.928472f9.akpm@osdl.org>
	<1155530453.5696.98.camel@twins>
	<20060813215853.0ed0e973.akpm@osdl.org>
	<44E3E964.8010602@google.com>
	<20060816225726.3622cab1.akpm@osdl.org>
	<44E5015D.80606@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 16:53:01 -0700
Daniel Phillips <phillips@google.com> wrote:

> Andrew Morton wrote:
> > Daniel Phillips <phillips@google.com> wrote:
> >>What happened to the case where we just fill memory full of dirty file
> >>pages backed by a remote disk?
> > 
> > Processes which are dirtying those pages throttle at
> > /proc/sys/vm/dirty_ratio% of memory dirty.  So it is not possible to "fill"
> > memory with dirty pages.  If the amount of physical memory which is dirty
> > exceeds 40%: bug.
> 
> Hi Andrew,
> 
> So we make 400 MB of a 1 GB system

by default - it's runtime configurable.

> unavailable for write caching just to
> get around the network receive starvation issue?

No, it's mainly to avoid latency: to prevent tasks which want to allocate
pages from getting stuck behind writeback.

> What happens if some in kernel user grabs 68% of kernel memory to do some
> very important thing, does this starvation avoidance scheme still work?

Well something has to give way.  The process might get swapped out a bit,
or it might stall in the page allocator because of all the dirty memory.

