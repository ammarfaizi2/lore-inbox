Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbVIOBP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbVIOBP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVIOBP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:15:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5598 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030319AbVIOBP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:15:26 -0400
Date: Thu, 15 Sep 2005 11:14:38 +1000
From: David Chinner <dgc@sgi.com>
To: Sonny Rao <sonny@burdell.org>
Cc: Bharata B Rao <bharata@in.ibm.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Dipankar Sarma <dipankar@in.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050915011437.GF2265486@melbourne.sgi.com>
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050913215932.GA1654338@melbourne.sgi.com> <20050914154852.GB6172@kevlar.burdell.org> <20050914220222.GA2265486@melbourne.sgi.com> <20050914224040.GA16627@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914224040.GA16627@kevlar.burdell.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 06:40:40PM -0400, Sonny Rao wrote:
> On Thu, Sep 15, 2005 at 08:02:22AM +1000, David Chinner wrote:
> > Right now our only solution to prevent fragmentation on reclaim is
> > to throw more memory at the machine to prevent reclaim from
> > happening as the workload changes.
> 
> That is unfortunate, but interesting because I didn't know if this was
> not a "real-problem" as some have contended.  I know SPEC SFS is a
> somewhat questionable workload (really, what isn't though?), so the
> evidence gathered from that didn't seem to convince many people.  
> 
> What kind of (real) workload are you seeing this on?

Nothing special. Here's an example from a local altix build
server (8p, 12GiB RAM):

linvfs_icache     3376574 3891360    672   24    1 : tunables   54   27    8 : slabdata 162140 162140      0
dentry_cache      2632811 3007186    256   62    1 : tunables  120   60    8 : slabdata  48503  48503      0

I just copied and untarred some stuff I need to look at (~2GiB
data) and when that completed we now have:

linvfs_icache     590840 2813328    672   24    1 : tunables   54   27    8 : slabdata 117222 117222
dentry_cache      491984 2717708    256   62    1 : tunables  120   60    8 : slabdata  43834  43834

A few minutes later, with ppl doing normal work (rsync, kernel and
userspace package builds, tar, etc), a bit more had been reclaimed:

linvfs_icache     580589 2797992    672   24    1 : tunables   54   27    8 : slabdata 116583 116583      0
dentry_cache      412009 2418558    256   62    1 : tunables  120   60    8 : slabdata  39009  39009      0

We started with ~2.9GiB of active slab objects in ~210k pages
(3.3GiB RAM) in these two slabs. We've trimmed their active size
down to ~500MiB, but we still have 155k pages (2.5GiB) allocated to
the slabs. 

I've seen much worse than this on build servers with more memory and
larger filesystems, especially after the filesystems have been
crawled by a backup program over night and we've ended up with > 10
million objects in each of these caches. 

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
