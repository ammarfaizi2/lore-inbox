Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbVKPODq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbVKPODq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbVKPODp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:03:45 -0500
Received: from pat.uio.no ([129.240.130.16]:57579 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030338AbVKPODp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:03:45 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051115234542.45a7aa66.akpm@osdl.org>
References: <20051115224645.27832.qmail@web34103.mail.mud.yahoo.com>
	 <20051115234731.9539.qmail@web34105.mail.mud.yahoo.com>
	 <20051115234542.45a7aa66.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 09:03:31 -0500
Message-Id: <1132149812.8812.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.885, required 12,
	autolearn=disabled, AWL 1.93, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 23:45 -0800, Andrew Morton wrote:

> So filemap_write_and_wait() has to write 2MB's worth of pages.  Problem is,
> _all_ the pages, even the 99% which are clean are tagged as dirty in the
> pagecache radix tree.  So find_get_pages_tag() ends up visiting each page
> in the file, and blows much CPU doing so.
> 
> The writeout happens in mpage_writepages(), which uses
> clear_page_dirty_for_io() to clear PG_dirty.  But it doesn't clear the
> dirty tag in the radix tree.  It relies upon the filesystem to do the right
> thing later on.  Which is all very unpleasant, sorry.  See the explanatory
> comment over clear_page_dirty_for_io().

> nfs_writepage() doesn't do any of the things which that comment says it
> should, hence the radix tree tags are getting out of sync, hence this
> problem.
> 
> NFS does strange, incomprehensible-to-little-akpms things in its writeout
> path.  Ideally, it should run set_page_writeback() prior to unlocking the
> page and end_page_writeback() when I/O completes.  That'll keep the VM
> happier while fixing this performance glitch.

Actually that will screw over performance even further by forcing us to
send out loads of little RPC requests to write 4k pages instead of
allowing us to gather those writes into 32k (or larger) chunks.

Anyhow, does the following patch help?

Cheers,
  Trond
------
NFS: resync to yet more writepage() changes...

 Ensure that we call clear_page_dirty() for pages that have been written
 via writepage().

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/write.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 8f71e76..ea77da5 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -213,6 +213,7 @@ static int nfs_writepage_sync(struct nfs
 	} while (count);
 	/* Update file length */
 	nfs_grow_file(page, offset, written);
+	clear_page_dirty(page);
 	/* Set the PG_uptodate flag? */
 	nfs_mark_uptodate(page, offset, written);
 
@@ -238,6 +239,7 @@ static int nfs_writepage_async(struct nf
 		goto out;
 	/* Update file length */
 	nfs_grow_file(page, offset, count);
+	clear_page_dirty(page);
 	/* Set the PG_uptodate flag? */
 	nfs_mark_uptodate(page, offset, count);
 	nfs_unlock_request(req);


