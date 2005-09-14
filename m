Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbVINJgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbVINJgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbVINJgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:36:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965114AbVINJga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:36:30 -0400
Date: Wed, 14 Sep 2005 02:35:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: dgc@sgi.com, bharata@in.ibm.com, tytso@mit.edu, dipankar@in.ibm.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk
 enough
Message-Id: <20050914023529.4eabf014.akpm@osdl.org>
In-Reply-To: <200509141101.16781.ak@suse.de>
References: <20050911105709.GA16369@thunk.org>
	<20050913084752.GC4474@in.ibm.com>
	<20050913215932.GA1654338@melbourne.sgi.com>
	<200509141101.16781.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Tuesday 13 September 2005 23:59, David Chinner wrote:
> > On Tue, Sep 13, 2005 at 02:17:52PM +0530, Bharata B Rao wrote:
> > > Second is Sonny Rao's rbtree dentry reclaim patch which is an attempt
> > > to improve this dcache fragmentation problem.
> >
> > FYI, in the past I've tried this patch to reduce dcache fragmentation on
> > an Altix (16k pages, 62 dentries to a slab page) under heavy
> > fileserver workloads and it had no measurable effect. It appeared
> > that there was almost always at least one active dentry on each page
> > in the slab.  The story may very well be different on 4k page
> > machines, however.
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

Considered doing that with buffer_heads a few years ago.  It's impossible
unless you have a global lock, which bh's don't have.  dentries _do_ have a
global lock, and we'd be tied to having it for ever more.

The shrinking code would have be able to deal with a dentry which is going
through destruction by other call paths, so dcache_lock coverage would have
to be extended considerably - it would have to cover the kmem_cache_free(),
for example.   Or we put some i_am_alive flag into the dentry.

> The slab datastructures are not completely suited for this right now,
> but it could be done by using one more of the list_heads in struct page
> for slab backing pages.

Yes, some help would be needed in the slab code.

There's only one list_head in struct page and slab is already using it.

