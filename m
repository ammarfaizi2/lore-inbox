Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbVINN54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbVINN54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbVINN54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:57:56 -0400
Received: from dvhart.com ([64.146.134.43]:17027 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965212AbVINN5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:57:55 -0400
Date: Wed, 14 Sep 2005 06:57:56 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andi Kleen <ak@suse.de>, David Chinner <dgc@sgi.com>
Cc: Bharata B Rao <bharata@in.ibm.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Dipankar Sarma <dipankar@in.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <313480000.1126706276@[10.10.2.4]>
In-Reply-To: <200509141101.16781.ak@suse.de>
References: <20050911105709.GA16369@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050913215932.GA1654338@melbourne.sgi.com> <200509141101.16781.ak@suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Second is Sonny Rao's rbtree dentry reclaim patch which is an attempt
>> > to improve this dcache fragmentation problem.
>> 
>> FYI, in the past I've tried this patch to reduce dcache fragmentation on
>> an Altix (16k pages, 62 dentries to a slab page) under heavy
>> fileserver workloads and it had no measurable effect. It appeared
>> that there was almost always at least one active dentry on each page
>> in the slab.  The story may very well be different on 4k page
>> machines, however.
> 
> I always thought dentry freeing would work much better if it
> was turned upside down.
> 
> Instead of starting from the high level dcache lists it could
> be driven by slab: on memory pressure slab tries to return pages with unused 
> cache objects. In that case it should check if there are only
> a small number of pinned objects on the page set left, and if 
> yes use a new callback to the higher level user (=dcache) and ask them
> to free the object.
> 
> The slab datastructures are not completely suited for this right now,
> but it could be done by using one more of the list_heads in struct page
> for slab backing pages.
> 
> It would probably not be very LRU but a simple hack of having slowly 
> increasing dcache generations. Each dentry use updates the generation.
> First slab memory freeing pass only frees objects with older generations.

If they're freeable, we should easily be able to move them, and therefore 
compact a fragmented slab. That way we can preserve the LRU'ness of it.
Stage 1: free the oldest entries. Stage 2: compact the slab into whole
pages. Stage 3: free whole pages back to teh page allocator.

> Using slowly increasing generations has the advantage of timestamps
> that you can avoid dirtying cache lines in the common case when 
> the generation doesn't change on access (= no additional cache line bouncing)
> and it would easily allow to tune the aging rate under stress by changing the 
> length of the generation.

LRU algorithm may need general tweaking like this anyway ... strict LRU
is expensive to keep.

M.
