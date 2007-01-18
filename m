Return-Path: <linux-kernel-owner+w=401wt.eu-S1752054AbXARPuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbXARPuF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 10:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbXARPuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 10:50:05 -0500
Received: from pat.uio.no ([129.240.10.15]:35292 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbXARPuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 10:50:03 -0500
Subject: Re: [PATCH] nfs: fix congestion control
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1169126868.6197.55.camel@twins>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116135325.3441f62b.akpm@osdl.org> <1168985323.5975.53.camel@lappy>
	 <Pine.LNX.4.64.0701171158290.7397@schroedinger.engr.sgi.com>
	 <1169070763.5975.70.camel@lappy>
	 <1169070886.6523.8.camel@lade.trondhjem.org>
	 <1169126868.6197.55.camel@twins>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 10:49:35 -0500
Message-Id: <1169135375.6105.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Resend: resent
X-UiO-Spam-info: not spam, SpamAssassin (score=0.0, required=12.0, autolearn=disabled, none)
X-UiO-Scanned: 2FE2275B033447EA250ED3F1D6817C4C924327C6
X-UiO-SPAM-Test: remote_host: 129.240.10.9 spam_score: 0 maxlevel 200 minaction 2 bait 0 mail/h: 354 total 14176 max/h 14176 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 14:27 +0100, Peter Zijlstra wrote:
> On Wed, 2007-01-17 at 16:54 -0500, Trond Myklebust wrote:
> > On Wed, 2007-01-17 at 22:52 +0100, Peter Zijlstra wrote:
> > 
> > > > 
> > > > > Index: linux-2.6-git/fs/inode.c
> > > > > ===================================================================
> > > > > --- linux-2.6-git.orig/fs/inode.c	2007-01-12 08:03:47.000000000 +0100
> > > > > +++ linux-2.6-git/fs/inode.c	2007-01-12 08:53:26.000000000 +0100
> > > > > @@ -81,6 +81,7 @@ static struct hlist_head *inode_hashtabl
> > > > >   * the i_state of an inode while it is in use..
> > > > >   */
> > > > >  DEFINE_SPINLOCK(inode_lock);
> > > > > +EXPORT_SYMBOL_GPL(inode_lock);
> > > > 
> > > > Hmmm... Commits to all NFS servers will be globally serialized via the 
> > > > inode_lock?
> > > 
> > > Hmm, right, thats not good indeed, I can pull the call to
> > > nfs_commit_list() out of that loop.
> > 
> > There is no reason to modify any of the commit stuff. Please just drop
> > that code.
> 
> I though you agreed to flushing commit pages when hitting the dirty page
> limit.

After the dirty page has been written to unstable storage, it marks the
inode using I_DIRTY_DATASYNC, which should then ensure that the VFS
calls write_inode() on the next pass through __sync_single_inode.

> Or would you rather see a notifier chain from congestion_wait() calling
> into the various NFS mounts?

I'd rather like to see fs/fs-writeback.c do this correctly (assuming
that it is incorrect now).

Trond

