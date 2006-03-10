Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWCJMWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWCJMWf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 07:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWCJMWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 07:22:35 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:14410 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750780AbWCJMWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 07:22:34 -0500
Subject: Re: [PATCH 00/03] Unmapped: Separate unmapped and mapped pages
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20060310034412.8340.90939.sendpatchset@cherry.local>
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 13:22:31 +0100
Message-Id: <1141993351.8165.10.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 12:44 +0900, Magnus Damm wrote:
> Unmapped patches - Use two LRU:s per zone.
> 
> These patches break out the per-zone LRU into two separate LRU:s - one for
> mapped pages and one for unmapped pages. The patches also introduce guarantee 
> support, which allows the user to set how many percent of all pages per node
> that should be kept in memory for mapped or unmapped pages. This guarantee 
> makes it possible to adjust the VM behaviour depending on the workload.
> 
> Reasons behind the LRU separation:
> 
> - Avoid unnecessary page scanning.
>   The current VM implementation rotates mapped pages on the active list
>   until the number of mapped pages are high enough to start unmap and page out.
>   By using two LRU:s we can avoid this scanning and shrink/rotate unmapped 
>   pages only, not touching mapped pages until the threshold is reached.
> 
> - Make it possible to adjust the VM behaviour.
>   In some cases the user might want to guarantee that a certain amount of 
>   pages should be kept in memory, overriding the standard behaviour. Separating
>   pages into mapped and unmapped LRU:s allows guarantee with low overhead.
> 
> I've performed many tests on a Dual PIII machine while varying the amount of
> RAM available. Kernel compiles on a 64MB configuration gets a small speedup, 
> but the impact on other configurations and workloads seems to be unaffected.
> 
> Apply on top of 2.6.16-rc5.
> 
> Comments?

I'm not convinced of special casing mapped pages, nor of tunable knobs.
I've been working on implementing some page replacement algorithms that
have neither.

Breaking the LRU in two like this breaks the page ordering, which makes
it possible for pages to stay resident even though they have much less
activity than pages that do get reclaimed.

I have a serious regression somewhere, but will post as soon as we've
managed to track it down.

If you're interrested, the work can be found here:
  http://programming.kicks-ass.net/kernel-patches/page-replace/


-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

