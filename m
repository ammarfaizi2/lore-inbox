Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbVLBHRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbVLBHRA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 02:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbVLBHRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 02:17:00 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:45523 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751746AbVLBHRA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 02:17:00 -0500
Date: Fri, 2 Dec 2005 15:18:49 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
       npiggin@suse.de, andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051202071849.GA4073@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
	linux-kernel@vger.kernel.org, christoph@lameter.com,
	riel@redhat.com, a.p.zijlstra@chello.nl, npiggin@suse.de,
	andrea@suse.de, magnus.damm@gmail.com
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org> <20051201222846.GA3646@dmt.cnet> <20051201150349.3538638e.akpm@osdl.org> <20051202011924.GA3516@mail.ustc.edu.cn> <20051201214931.2dbc35fe.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20051201214931.2dbc35fe.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 09:49:31PM -0800, Andrew Morton wrote:
> From: Andrew Morton <akpm@osdl.org>
> 
> Revert a patch which went into 2.6.8-rc1.  The changelog for that patch was:
> 
>   The shrink_zone() logic can, under some circumstances, cause far too many
>   pages to be reclaimed.  Say, we're scanning at high priority and suddenly
>   hit a large number of reclaimable pages on the LRU.
> 
>   Change things so we bale out when SWAP_CLUSTER_MAX pages have been
>   reclaimed.
> 
> Problem is, this change caused significant imbalance in inter-zone scan
> balancing by truncating scans of larger zones.
> 
> Suppose, for example, ZONE_HIGHMEM is 10x the size of ZONE_NORMAL.  The zone
> balancing algorithm would require that if we're scanning 100 pages of
> ZONE_HIGHMEM, we should scan 10 pages of ZONE_NORMAL.  But this logic will
> cause the scanning of ZONE_HIGHMEM to bale out after only 32 pages are
> reclaimed.  Thus effectively causing smaller zones to be scanned relatively
> harder than large ones.
> 
> Now I need to remember what the workload was which caused me to write this
> patch originally, then fix it up in a different way...

Maybe it's a situation like this:

__|____|________|________________|________________________________|________________________________________________________________|________________________________________________________________________________________________________________________________|________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        _: pinned chunk
        -: reclaimable chunk
        |: shrink_zone() invocation
        
First we run into a large range of pinned chunks, which lowered the scan
priority.  And then there are plenty of reclaimable chunks, bomb...

Thanks,
Wu
