Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbVLGN0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbVLGN0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 08:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbVLGN0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 08:26:39 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:35494 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751022AbVLGN0j (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 7 Dec 2005 08:26:39 -0500
Date: Wed, 7 Dec 2005 21:53:47 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 01/16] mm: delayed page activation
Message-ID: <20051207135347.GB6141@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nikita Danilov <nikita@clusterfs.com>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
	Andrew Morton <akpm@osdl.org>
References: <20051203071444.260068000@localhost.localdomain> <20051203071609.755741000@localhost.localdomain> <17298.56560.78408.693927@gargle.gargle.HOWL> <20051204134818.GA4305@mail.ustc.edu.cn> <17299.1331.368159.374754@gargle.gargle.HOWL> <20051205014842.GA5103@mail.ustc.edu.cn> <17301.53377.614777.913013@gargle.gargle.HOWL> <20051207014235.GA5186@mail.ustc.edu.cn> <17302.55593.531594.871250@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17302.55593.531594.871250@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 03:44:25PM +0300, Nikita Danilov wrote:
> Wu Fengguang writes:
>  > Yes, it also increased the lifetimes by meaningful values: first re-accessed
>  > pages are prolonged more lifetime. Immediately removing them from inactive_list 
>  > is basicly doing MRU eviction.
> 
> Are you talking about CLOCK-pro here? I don't understand your statement
> in the context of current VM: if the "first re-accessed" page was close
> to the cold tail of the inactive list, and "second re-accessed" page was
> close to the head of the inactive list, then life-time of second one is
> increased by larger amount.

Sorry, I fail to mention that I'm comparing two pages that are read in at the
same time, therefore they are in the same place in inactive_list. But their
re-access time can be quite different.

There are roughly two kinds of reads: almost instantly and slowly forward. For
the former one, read-in-time = first-access-time, unless for initial cache misses.
The latter one is the original purpose of of the patch: to keep one chunk of
read-ahead pages together, instead of let them littering throughout the lru
list.

>  > Delayed activation increased scanning activity, while immediate activation
>  > increased the locking activity. Early profiling data on a 2 CPU Xeon box showed
>  > that the delayed activation acctually cost less time.
> 
> That's great, but current mark_page_accessed() has an important
> advantage: the work is done by the process that accessed the page in
> read/write path, or at page fault. By delegating activation to the VM
> scanner, the burden of work is shifted to the innocent thread that
> happened to trigger scanning during page allocation.

Thanks to notice it. It will happen in the direct page reclaim path. But I have
just made interesting tests of the patch, in which direct page reclaims were
reduced to zero. Till now I have no hint of why this is happening :)

Wu
