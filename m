Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbVIONeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbVIONeq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbVIONeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:34:46 -0400
Received: from hera.kernel.org ([209.128.68.125]:27812 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030413AbVIONep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:34:45 -0400
Date: Thu, 15 Sep 2005 10:29:10 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Bharata B Rao <bharata@in.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050915132910.GA6806@dmt.cnet>
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050914230843.GA11748@dmt.cnet> <20050915093945.GD3869@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915093945.GD3869@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 03:09:45PM +0530, Bharata B Rao wrote:
> On Wed, Sep 14, 2005 at 08:08:43PM -0300, Marcelo Tosatti wrote:
> > On Tue, Sep 13, 2005 at 02:17:52PM +0530, Bharata B Rao wrote:
> > > 
> <snip>
> > > First is dentry_stats patch which collects some dcache statistics
> > > and puts it into /proc/meminfo. This patch provides information 
> > > about how dentries are distributed in dcache slab pages, how many
> > > free and in use dentries are present in dentry_unused lru list and
> > > how prune_dcache() performs with respect to freeing the requested
> > > number of dentries.
> > 
> > Bharata, 
> > 
> > Ideally one should move the "nr_requested/nr_freed" counters from your
> > stats patch into "struct shrinker" (or somewhere else more appropriate
> > in which per-shrinkable-cache stats are maintained), and use the
> > "mod_page_state" infrastructure to do lockless per-CPU accounting. ie.
> > break /proc/vmstats's "slabs_scanned" apart in meaningful pieces.
> 
> Yes, I agree that we should have the nr_requested and nr_freed type of
> counters in appropriate place. And "struct shrinker" is probably right
> place for it.
> 
> Essentially you are suggesting that we maintain per cpu statistics
> of 'requested to free'(scanned) slab objects and actual freed objects.
> And this should be on per shrinkable cache basis.

Yep. 

> Is it ok to maintain this requested/freed counters as growing counters
> or would it make more sense to have them reflect the statistics from
> the latest/last attempt of cache shrink ? 

It makes a lot more sense to account for all shrink attempts: it is necessary
to know how the reclaiming process is behaving over time. Thats why I wondered
about using "=" instead of "+=" in your patch.

> And where would be right place to export this information ?
> (/proc/slabinfo ?, since it already gives details of all caches)

My feeling is that changing /proc/slabinfo format might break userspace
applications.

> If I understand correctly, "slabs_scanned" is the sum total number
> of objects from all shrinkable caches scanned for possible freeeing.

Yep.

> I didn't get why this is part of page_state which mostly includes
> page related statistics.

Well, page_state contains most of the reclaiming statistics - its scope
is broader than "struct page" information.

To me it seems like the best place.
