Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbUDLVce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 17:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUDLVce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 17:32:34 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:53682 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263124AbUDLVcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 17:32:12 -0400
Date: Mon, 12 Apr 2004 14:43:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: vrajesh@umich.edu, hugh@veritas.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <73720000.1081806211@flay>
In-Reply-To: <20040412141244.5e225cdf.akpm@osdl.org>
References: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain><Pine.LNX.4.58.0404121531580.15512@red.engin.umich.edu><69200000.1081804458@flay> <20040412141244.5e225cdf.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, April 12, 2004 14:12:44 -0700 Andrew Morton <akpm@osdl.org> wrote:

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
>> Turns out he'd turned the
>> locking in find_get_page from "spin_lock(&mapping->page_lock)" into
>> "spin_lock_irq(&mapping->tree_lock)",
> 
> That's from the use-radix-tree-walks-for-writeback code.
> 
> Use oprofile - it's NMI-based.
> 
>> and I'm using readprofile, which
>> doesn't profile with irqs off, so it's not really disappeared, just hidden.
>> Not sure which sub-patch that comes from, and it turned out to be a bit of
>> a dead end, but whilst I'm there, I thought I'd point out this was contended,
>> and show the diffprofile with and without spinline for aa5:
>> 
>>      22210  246777.8% find_trylock_page
>>       2538    36.4% atomic_dec_and_lock
> 
> profiler brokenness, surely.  Almost nothing calls find_trylock_page(),
> unless Andrea has done something peculiar.  Use oprofile.

Well, he did do this:

@@ -413,11 +412,11 @@ struct page *find_trylock_page(struct ad
 {
        struct page *page;
 
-       spin_lock(&mapping->page_lock);
+       spin_lock_irq(&mapping->tree_lock);
        page = radix_tree_lookup(&mapping->page_tree, offset);
        if (page && TestSetPageLocked(page))
                page = NULL;
-       spin_unlock(&mapping->page_lock);
+       spin_unlock_irq(&mapping->tree_lock);
        return page;
 }

Which would stop it appearing in readprofile. But why spinlock inlining
should affect that one way or the other is beyond me. I'll see about
using oprofile, but it's not a trivial conversion (it's all scripted).
There's no other occurences of that in his patchset. But you're right,
only xfs, and free_swap_and_cache seem to use it, and I'm not swapping.

M.

