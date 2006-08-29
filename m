Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965370AbWH2VGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965370AbWH2VGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 17:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965367AbWH2VGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 17:06:50 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:46704 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965363AbWH2VGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 17:06:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z/Jg/5xrBv9IiIuwKgfGjyVv6VgYMKVBdyY5s4PMcCO3xkptrztG+v93kRN5OqlZsg6vJMeb5OZG9dwaGO4hIpO6qIySZvBPBi0MRGDelZs4+D+NDgniB52qpUpfkMhVwXbRtQJ8QVOExTVLPcRIC1XfPxqq0PlFG+bY3S4pkek=
Message-ID: <b0943d9e0608291406o423c2e7axb4131b928257c3da@mail.gmail.com>
Date: Tue, 29 Aug 2006 22:06:49 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <b0943d9e0608170602v13dea49bgf64dbf17b7a52273@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
	 <b0943d9e0608130713j1e4a8836i943d31011169cf05@mail.gmail.com>
	 <6bffcb0e0608130726x8fc1c0v7717165a63391e80@mail.gmail.com>
	 <b0943d9e0608170602v13dea49bgf64dbf17b7a52273@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> it looks like it was caused by commit
> fc818301a8a39fedd7f0a71f878f29130c72193d where free_block() now calls
> slab_destroy() with l3->list_lock held.
[...]
> It leaves me with the options of either implementing my own memory
> allocator based on pages (including a simple hash table instead of
> radix tree) or fix the locking in kmemleak so that memory allocations
> happen without memleak_lock held. The latter is a bit complicated as
> well since any slab allocation causes a re-entrance into kmemleak.

FYI, I couldn't fix the locking dependency issues without modifying
the radix-tree implementation since even if you preload the tree
outside the memleak lock, it still tries to allocate memory in
radix_tree_insert.

I'll instead use a hash table (together with hlist) where I can
control the memory allocations and make more use of RCU. In my few
initial tests, the memory search with hash tables is about the same
speed (if not slightly faster) as the radix-tree implementation.

I will post a new kmemleak version by the end of this week.

-- 
Catalin
