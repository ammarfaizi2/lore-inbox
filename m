Return-Path: <linux-kernel-owner+w=401wt.eu-S1751949AbWLTAR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbWLTAR5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbWLTAR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:17:57 -0500
Received: from pat.uio.no ([129.240.10.15]:47648 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbWLTAR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:17:56 -0500
Subject: Re: 2.6.18 mmap hangs unrelated apps
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Sabala <lkml@saahbs.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20061219160315.ea83ca38.akpm@osdl.org>
References: <20061215023014.GC2721@prosiaczek>
	 <1166199855.5761.34.camel@lade.trondhjem.org>
	 <20061215175030.GG6220@prosiaczek>
	 <1166211884.5761.49.camel@lade.trondhjem.org>
	 <20061215210642.GI6220@prosiaczek>
	 <1166219054.5761.56.camel@lade.trondhjem.org>
	 <20061219142624.230b28c0.akpm@osdl.org>
	 <1166570378.5760.52.camel@lade.trondhjem.org>
	 <20061219160315.ea83ca38.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 19:17:43 -0500
Message-Id: <1166573863.5768.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=no, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-SPAM-Test: UIO-GREYLIST 69.242.210.120 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 1 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 16:03 -0800, Andrew Morton wrote:
> On Tue, 19 Dec 2006 18:19:38 -0500
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> >     NFS: Fix race in nfs_release_page()
> >     
> >     invalidate_inode_pages2() may set the dirty bit on a page owing to the call
> >     to unmap_mapping_range() after the page was locked. In order to fix this,
> >     NFS has hooked the releasepage() method. This, however leads to deadlocks
> >     in other parts of the VM.
> 
> hmm, subtle.
> 
> >     Fix is to add a new callback: flushpage(), which will write out a dirty
> >     page that is under the page lock.
> >     
> 
> I guess this might permit us to clean up some of the nasties in
> invalidate_inode_pages2() - if the page comes dirty again, write it again. 
> But the requirement that the page remain locked makes it hard.  Need to
> think about it some more.

This was one of the reasons why I had to introduce
nfs_writepage_locked() for 2.6.20 (the other reason being readpage()).

The problem is that you can only protect against redirtying of the page
by holding the page lock across the call to unmap_mapping_range(), the
page writeout and the page removal.

> Are you sure this is the cause of the NFS problem?
> 
> >  	.prepare_write = nfs_prepare_write,
> >  	.commit_write = nfs_commit_write,
> >  	.invalidatepage = nfs_invalidate_page,
> > -	.releasepage = nfs_release_page,
> 
> A NULL ->releasepage means that try_to_release_page() will call
> try_to_free_buffers() if PagePrivate().  I suspect you'll need a stub to
> prevent this.

Ack, I'll add one in. If PagePrivate() is set during the call to
try_to_release_page(), then the page should never be freeable.

> (We were supposed to stop doing that about four years ago - change it so
> that all a_ops must implement ->releasepage, but nobody got around to it).

Would you still be interested in seeing this done?


