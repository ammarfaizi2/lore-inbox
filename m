Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbULYR7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbULYR7e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 12:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbULYR7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 12:59:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60140 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261528AbULYR72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 12:59:28 -0500
Date: Sat, 25 Dec 2004 12:59:10 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Robert_Hentosh@Dell.com, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
In-Reply-To: <20041225020707.GQ13747@dualathlon.random>
Message-ID: <Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com>
 <20041220125443.091a911b.akpm@osdl.org> <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com>
 <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com>
 <20041224164024.GK4459@dualathlon.random> <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com>
 <20041225020707.GQ13747@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2004, Andrea Arcangeli wrote:
> On Fri, Dec 24, 2004 at 05:12:32PM -0500, Rik van Riel wrote:
>> The process 'dd', and all the other processes, live in
>> the highmem zone, which has 2.5GB of memory free. Now
>> tell me again why you think the swap token has any
>> relevance to those 950MB of pagecache that is filling
>> up lowmem ?
>
> If 2.5G of ram is really free, then how can the oom killer be invoked in
> the first place? If that happens it means you're under a lowmem
> shortage, something you apparently ruled out when you said
> lowmem_reserve couldn't help your workload.

Let me explain a 3rd time:

1) run dd if=/dev/zero of=/dev/hdaN on a system with 4GB RAM

2) the pagecache mapping for /dev/hdaN can only come from
    lowmem, of which we have roughly 900MB

3) the dirty_limit is 40% of 4GB, or roughly 1.6GB - the dd
    from (1) will not throttle itself at all, but will just
    fill up lowmem without limitation

4) any memory that could be affected by the swap token (process
    text, data, stack, ...) is allocated with __GFP_HIGHMEM, so
    that all lives in the highmem zone with 2.5GB free

5) since dd is not being paged out at all, and can dirty memory
    without limit, the VM gets backed into a corner and will
    trigger an OOM kill - even though most of lowmem is simply
    dirty page cache

6) an unpatched 2.6.10-rc kernel will OOM kill in minutes on
    a test system here

6) Andrew's total_pages patch, marcelo's vm-writeout-throttle patch
    and my two patches improve the situation a lot, and the OOM kill
    takes a day or so to be triggered

If you have any more questions as to why the bug happens, don't
hesitate to ask and I'll explain you why this problem happens.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
