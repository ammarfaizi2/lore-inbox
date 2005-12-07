Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVLGMoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVLGMoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVLGMoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:44:13 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:61344 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750945AbVLGMoL (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 7 Dec 2005 07:44:11 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17302.55593.531594.871250@gargle.gargle.HOWL>
Date: Wed, 7 Dec 2005 15:44:25 +0300
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 01/16] mm: delayed page activation
In-Reply-To: <20051207014235.GA5186@mail.ustc.edu.cn>
References: <20051203071444.260068000@localhost.localdomain>
	<20051203071609.755741000@localhost.localdomain>
	<17298.56560.78408.693927@gargle.gargle.HOWL>
	<20051204134818.GA4305@mail.ustc.edu.cn>
	<17299.1331.368159.374754@gargle.gargle.HOWL>
	<20051205014842.GA5103@mail.ustc.edu.cn>
	<17301.53377.614777.913013@gargle.gargle.HOWL>
	<20051207014235.GA5186@mail.ustc.edu.cn>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang writes:
 > On Tue, Dec 06, 2005 at 08:55:13PM +0300, Nikita Danilov wrote:

[...]

 > > 
 > > But this change increased lifetimes of _all_ pages, so this is
 > 
 > Yes, it also increased the lifetimes by meaningful values: first re-accessed
 > pages are prolonged more lifetime. Immediately removing them from inactive_list 
 > is basicly doing MRU eviction.

Are you talking about CLOCK-pro here? I don't understand your statement
in the context of current VM: if the "first re-accessed" page was close
to the cold tail of the inactive list, and "second re-accessed" page was
close to the head of the inactive list, then life-time of second one is
increased by larger amount.

 > 
 > > irrelevant. Consequently, it has a chance of increasing scanning
 > > activity, because there will be more referenced pages at the cold tail
 > > of the inactive list.
 > 
 > Delayed activation increased scanning activity, while immediate activation
 > increased the locking activity. Early profiling data on a 2 CPU Xeon box showed
 > that the delayed activation acctually cost less time.

That's great, but current mark_page_accessed() has an important
advantage: the work is done by the process that accessed the page in
read/write path, or at page fault. By delegating activation to the VM
scanner, the burden of work is shifted to the innocent thread that
happened to trigger scanning during page allocation.

It's basically always useful to follow the principle that the thread
that used resources pays the overhead. This leads to more balanced
behavior with better worst-case.

Compare this with balance_dirty_pages() that throttles heavy writers by
forcing them to do the write-out. In the same vein, mark_page_accessed()
throttles thread (a bit) by forcing it to book-keep VM lists. Ideally,
threads doing a lot of page allocations, should be forced to do some
scanning, even if there is no memory shortage, etc.

As for locking overhead, mark_page_accessed() can be batched (I even
have a patch to do this, but it doesn't show any improvement).

 > 
 > Thanks,
 > Wu

Nikita.
