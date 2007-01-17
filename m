Return-Path: <linux-kernel-owner+w=401wt.eu-S1751688AbXAQHA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbXAQHA5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 02:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbXAQHA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 02:00:56 -0500
Received: from smtp.osdl.org ([65.172.181.24]:47857 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbXAQHAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 02:00:53 -0500
Date: Tue, 16 Jan 2007 23:00:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: menage@google.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, pj@sgi.com, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
Message-Id: <20070116230034.b8cb4263.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701162219180.5215@schroedinger.engr.sgi.com>
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
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 16 Jan 2007 22:27:36 -0800 (PST) Christoph Lameter <clameter@sgi.com> wrote:
> On Tue, 16 Jan 2007, Andrew Morton wrote:
> 
> > > Yes this is the result of the hierachical nature of cpusets which already 
> > > causes issues with the scheduler. It is rather typical that cpusets are 
> > > used to partition the memory and cpus. Overlappig cpusets seem to have 
> > > mainly an administrative function. Paul?
> > 
> > The typical usage scenarios don't matter a lot: the examples I gave show
> > that the core problem remains unsolved.  People can still hit the bug.
> 
> I agree the overlap issue is a problem and I hope it can be addressed 
> somehow for the rare cases in which such nesting takes place.
> 
> One easy solution may be to check the dirty ratio before engaging in 
> reclaim. If the dirty ratio is sufficiently high then trigger writeout via 
> pdflush (we already wakeup pdflush while scanning and you already noted 
> that pdflush writeout is not occurring within the context of the current 
> cpuset) and pass over any dirty pages during LRU scans until some pages 
> have been cleaned up.
> 
> This means we allow allocation of additional kernel memory outside of the 
> cpuset while triggering writeout of inodes that have pages on the nodes 
> of the cpuset. The memory directly used by the application is still 
> limited. Just the temporary information needed for writeback is allocated 
> outside.

Gad.  None of that should be necessary.

> Well sounds somehow still like a hack. Any other ideas out there?

Do what blockdevs do: limit the number of in-flight requests (Peter's
recent patch seems to be doing that for us) (perhaps only when PF_MEMALLOC
is in effect, to keep Trond happy) and implement a mempool for the NFS
request critical store.  Additionally:

- we might need to twiddle the NFS gfp_flags so it doesn't call the
  oom-killer on failure: just return NULL.

- consider going off-cpuset for critical allocations.  It's better than
  going oom.  A suitable implementation might be to ignore the caller's
  cpuset if PF_MEMALLOC.  Maybe put a WARN_ON_ONCE in there: we prefer that
  it not happen and we want to know when it does.



btw, regarding the per-address_space node mask: I think we should free it
when the inode is clean (!mapping_tagged(PAGECACHE_TAG_DIRTY)).  Chances
are, the inode will be dirty for 30 seconds and in-core for hours.  We
might as well steal its nodemask storage and give it to the next file which
gets written to.  A suitable place to do all this is in
__mark_inode_dirty(I_DIRTY_PAGES), using inode_lock to protect
address_space.dirty_page_nodemask.
