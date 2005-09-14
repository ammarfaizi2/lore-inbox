Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbVINJBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbVINJBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVINJBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:01:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:28102 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965093AbVINJBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:01:24 -0400
From: Andi Kleen <ak@suse.de>
To: David Chinner <dgc@sgi.com>
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Date: Wed, 14 Sep 2005 11:01:15 +0200
User-Agent: KMail/1.8
Cc: Bharata B Rao <bharata@in.ibm.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Dipankar Sarma <dipankar@in.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
References: <20050911105709.GA16369@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050913215932.GA1654338@melbourne.sgi.com>
In-Reply-To: <20050913215932.GA1654338@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509141101.16781.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 September 2005 23:59, David Chinner wrote:
> On Tue, Sep 13, 2005 at 02:17:52PM +0530, Bharata B Rao wrote:
> > Second is Sonny Rao's rbtree dentry reclaim patch which is an attempt
> > to improve this dcache fragmentation problem.
>
> FYI, in the past I've tried this patch to reduce dcache fragmentation on
> an Altix (16k pages, 62 dentries to a slab page) under heavy
> fileserver workloads and it had no measurable effect. It appeared
> that there was almost always at least one active dentry on each page
> in the slab.  The story may very well be different on 4k page
> machines, however.

I always thought dentry freeing would work much better if it
was turned upside down.

Instead of starting from the high level dcache lists it could
be driven by slab: on memory pressure slab tries to return pages with unused 
cache objects. In that case it should check if there are only
a small number of pinned objects on the page set left, and if 
yes use a new callback to the higher level user (=dcache) and ask them
to free the object.

The slab datastructures are not completely suited for this right now,
but it could be done by using one more of the list_heads in struct page
for slab backing pages.

It would probably not be very LRU but a simple hack of having slowly 
increasing dcache generations. Each dentry use updates the generation.
First slab memory freeing pass only frees objects with older generations.

Using slowly increasing generations has the advantage of timestamps
that you can avoid dirtying cache lines in the common case when 
the generation doesn't change on access (= no additional cache line bouncing)
and it would easily allow to tune the aging rate under stress by changing the 
length of the generation.

-Andi
