Return-Path: <linux-kernel-owner+w=401wt.eu-S932752AbWLNOwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbWLNOwn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWLNOwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:52:43 -0500
Received: from pat.uio.no ([129.240.10.15]:38965 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932752AbWLNOwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:52:42 -0500
Subject: Re: [PATCH] nfs: fix NR_FILE_DIRTY underflow
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20061213174148.6197c91a.akpm@osdl.org>
References: <1166011958.32332.97.camel@twins>
	 <1166012781.5695.18.camel@lade.trondhjem.org>
	 <1166022082.32332.126.camel@twins>
	 <1166031601.9127.1.camel@lade.trondhjem.org>
	 <1166035714.32332.159.camel@twins> <20061213172921.0c4a2809.akpm@osdl.org>
	 <20061213174148.6197c91a.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 09:52:26 -0500
Message-Id: <1166107946.5767.53.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=no, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-SPAM-Test: UIO-GREYLIST 69.241.229.183 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 1 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 17:41 -0800, Andrew Morton wrote:
> > Trond, please define precisely and completely and without reference to
> > the existing implementation: what behaviour does NFS want?

Part of the behaviour is dictated by our needs for
invalidate_inode_pages2(), part of the behaviour is dictated by the
2-stage NFS writeout mechanism.

Starting with invalidate_inode_pages2(). The goal here is to have a
function that is guaranteed to force all currently cached pages to be
read in from the server afresh. In other words, we'd like to throw out
the old mapping of the file, and start with a new one. However, we also
need to guarantee that any modifications that a user may have made to
the file are preserved. Throwing out a dirty page is forbidden unless
the data has been written to disk first.
What we're doing in try_to_release_page() in the current implementation
of invalidate_inode_pages2() is therefore to fix races: the goal is to
ensure that we write back any dirty data before the page is removed.
This is made necessary by the fact that the VM may at any time override
our call to unmap_mapping_range() and allow the page to be re-dirtied by
the user.

Next: about the 2-stage NFS writeout mechanism. A client may want to
allow the server to cache writeback data for a while, so that it can
flush several WRITE RPC calls to disk at the same time, maximising I/O
efficiency in terms of elevator algorithms etc.
It signals this to the server by means of the 'unstable' flag on the
WRITE RPC call, which allows the former to just write the data into its
pagecache. Before the client can actually free up the page it still
needs to know that the data it wrote to the server has been flushed from
the pagecache onto disk, and this is done by sending the COMMIT RPC
request. The latter acts rather like fdatasync() does on local data: it
guarantees that all file data within a specified range has been flushed
to disk. Failure of the COMMIT request signals to the client that the
server may have rebooted, and so the page needs to be written out again.
Our second use of try_to_release_page() is therefore to ensure that the
server has indeed flushed that dirty data from its pagecache to its disk
before we allow the VM to release the page on the client. We don't send
a COMMIT request for each and every page that is to be released, but we
do ensure that at least one COMMIT has been sent that covers the data
range represented by the page to be freed.

Cheers
  Trond

