Return-Path: <linux-kernel-owner+w=401wt.eu-S932186AbXAQWQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbXAQWQe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbXAQWQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:16:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49119 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbXAQWQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:16:18 -0500
Date: Wed, 17 Jan 2007 14:10:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: menage@google.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, pj@sgi.com, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
Message-Id: <20070117141046.cd19c9e8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701171140580.7397@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	<20070116135325.3441f62b.akpm@osdl.org>
	<Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
	<20070116154054.e655f75c.akpm@osdl.org>
	<Pine.LNX.4.64.0701161602480.4263@schroedinger.engr.sgi.com>
	<20070116170734.947264f2.akpm@osdl.org>
	<Pine.LNX.4.64.0701161709490.4455@schroedinger.engr.sgi.com>
	<20070116183406.ed777440.akpm@osdl.org>
	<Pine.LNX.4.64.0701161920480.4677@schroedinger.engr.sgi.com>
	<20070116200506.d19eacf5.akpm@osdl.org>
	<Pine.LNX.4.64.0701162219180.5215@schroedinger.engr.sgi.com>
	<20070116230034.b8cb4263.akpm@osdl.org>
	<Pine.LNX.4.64.0701171140580.7397@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 17 Jan 2007 11:43:42 -0800 (PST) Christoph Lameter <clameter@sgi.com> wrote:
> On Tue, 16 Jan 2007, Andrew Morton wrote:
> 
> > Do what blockdevs do: limit the number of in-flight requests (Peter's
> > recent patch seems to be doing that for us) (perhaps only when PF_MEMALLOC
> > is in effect, to keep Trond happy) and implement a mempool for the NFS
> > request critical store.  Additionally:
> > 
> > - we might need to twiddle the NFS gfp_flags so it doesn't call the
> >   oom-killer on failure: just return NULL.
> > 
> > - consider going off-cpuset for critical allocations.  It's better than
> >   going oom.  A suitable implementation might be to ignore the caller's
> >   cpuset if PF_MEMALLOC.  Maybe put a WARN_ON_ONCE in there: we prefer that
> >   it not happen and we want to know when it does.
> 
> Given the intermediate  layers (network, additional gizmos (ip over xxx) 
> and the network cards) that will not be easy.

Paul has observed that it's already done.  But it seems to not be working.

> > btw, regarding the per-address_space node mask: I think we should free it
> > when the inode is clean (!mapping_tagged(PAGECACHE_TAG_DIRTY)).  Chances
> > are, the inode will be dirty for 30 seconds and in-core for hours.  We
> > might as well steal its nodemask storage and give it to the next file which
> > gets written to.  A suitable place to do all this is in
> > __mark_inode_dirty(I_DIRTY_PAGES), using inode_lock to protect
> > address_space.dirty_page_nodemask.
> 
> The inode lock is not taken when the page is dirtied.

The inode_lock is taken when the address_space's first page is dirtied.  It is
also taken when the address_space's last dirty page is cleaned.  So the place
where the inode is added to and removed from sb->s_dirty is, I think, exactly
the place where we want to attach and detach address_space.dirty_page_nodemask.

> The tree_lock
> is already taken when the mapping is dirtied and so I used that to
> avoid races adding and removing pointers to nodemasks from the address 
> space.
