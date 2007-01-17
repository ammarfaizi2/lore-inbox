Return-Path: <linux-kernel-owner+w=401wt.eu-S932105AbXAQVwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbXAQVwy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbXAQVwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:52:54 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:24288 "EHLO
	amsfep13-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751304AbXAQVwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:52:53 -0500
Subject: Re: [PATCH] nfs: fix congestion control
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <Pine.LNX.4.64.0701171158290.7397@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116135325.3441f62b.akpm@osdl.org> <1168985323.5975.53.camel@lappy>
	 <Pine.LNX.4.64.0701171158290.7397@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 22:52:42 +0100
Message-Id: <1169070763.5975.70.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-17 at 12:05 -0800, Christoph Lameter wrote:
> On Tue, 16 Jan 2007, Peter Zijlstra wrote:
> 
> > The current NFS client congestion logic is severely broken, it marks the
> > backing device congested during each nfs_writepages() call and implements
> > its own waitqueue.
> 
> This is the magic bullet that Andrew is looking for to fix the NFS issues?

Dunno if its magical, but it does solve a few issues I ran into.

> > Index: linux-2.6-git/include/linux/nfs_fs_sb.h
> > ===================================================================
> > --- linux-2.6-git.orig/include/linux/nfs_fs_sb.h	2007-01-12 08:03:47.000000000 +0100
> > +++ linux-2.6-git/include/linux/nfs_fs_sb.h	2007-01-12 08:53:26.000000000 +0100
> > @@ -82,6 +82,8 @@ struct nfs_server {
> >  	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
> >  	struct nfs_iostats *	io_stats;	/* I/O statistics */
> >  	struct backing_dev_info	backing_dev_info;
> > +	atomic_t		writeback;	/* number of writeback pages */
> > +	atomic_t		commit;		/* number of commit pages */
> >  	int			flags;		/* various flags */
> 
> I think writeback is frequently incremented? Would it be possible to avoid
> a single global instance of an atomic_t here? In a busy NFS system 
> with lots of processors writing via NFS this may cause a hot cacheline 
> that limits write speed.

This would be per NFS mount, pretty global indeed. But not different
that other backing_dev_info's. request_queue::nr_requests suffers a
similar fate.

> Would it be possible to use NR_WRITEBACK? If not then maybe add another
> ZVC counter named NFS_NFS_WRITEBACK?

Its a per backing_dev_info thing. So using the zone counters will not
work.

> > Index: linux-2.6-git/mm/page-writeback.c
> > ===================================================================
> > --- linux-2.6-git.orig/mm/page-writeback.c	2007-01-12 08:03:47.000000000 +0100
> > +++ linux-2.6-git/mm/page-writeback.c	2007-01-12 08:53:26.000000000 +0100
> > @@ -167,6 +167,12 @@ get_dirty_limits(long *pbackground, long
> >  	*pdirty = dirty;
> >  }
> >  
> > +int dirty_pages_exceeded(struct address_space *mapping)
> > +{
> > +	return dirty_exceeded;
> > +}
> > +EXPORT_SYMBOL_GPL(dirty_pages_exceeded);
> > +
> 
> Export the variable instead of adding a new function? Why does it take an 
> address space parameter that is not used?
> 

Yeah, that function used to be larger.

> 
> > Index: linux-2.6-git/fs/inode.c
> > ===================================================================
> > --- linux-2.6-git.orig/fs/inode.c	2007-01-12 08:03:47.000000000 +0100
> > +++ linux-2.6-git/fs/inode.c	2007-01-12 08:53:26.000000000 +0100
> > @@ -81,6 +81,7 @@ static struct hlist_head *inode_hashtabl
> >   * the i_state of an inode while it is in use..
> >   */
> >  DEFINE_SPINLOCK(inode_lock);
> > +EXPORT_SYMBOL_GPL(inode_lock);
> 
> Hmmm... Commits to all NFS servers will be globally serialized via the 
> inode_lock?

Hmm, right, thats not good indeed, I can pull the call to
nfs_commit_list() out of that loop.

