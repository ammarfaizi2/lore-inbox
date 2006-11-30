Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759162AbWK3Ip2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759162AbWK3Ip2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759163AbWK3Ip2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:45:28 -0500
Received: from mail.alkar.net ([195.248.191.95]:5314 "EHLO mail.alkar.net")
	by vger.kernel.org with ESMTP id S1759160AbWK3Ip1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:45:27 -0500
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] Reiserfs panic while running fsstress due to =?iso-8859-1?q?multiple=09truncate?= "safe links" for a file.
Date: Thu, 30 Nov 2006 11:44:58 +0300
User-Agent: KMail/1.8.2
Cc: reiserfs-list@namesys.com, suzuki <suzuki@linux.vnet.ibm.com>,
       amitarora@in.ibm.com, reiserfs-dev@namesys.com,
       lkml <linux-kernel@vger.kernel.org>, rdunlap@xenotime.net
References: <445F2C95.4000604@in.ibm.com> <20061127172646.0d6c4dd1.akpm@osdl.org> <456BA59D.3060208@linux.vnet.ibm.com>
In-Reply-To: <456BA59D.3060208@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301144.59006.vs@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Tuesday 28 November 2006 05:57, suzuki wrote:
> Andrew Morton wrote:
> > On Mon, 27 Nov 2006 15:37:49 -0800
> > Suzuki <suzuki@in.ibm.com> wrote:
> > 
> > 
> >>* Do not add save links for O_DIRECT writes.
> >>
> >>We add a save link for O_DIRECT writes to protect the i_size against the crashes before we actually finish the I/O. If we hit an -ENOSPC in aops->prepare_write(), we would do a truncate() to release the blocks which might have got initialized. Now the truncate would add another save link for the same inode causing a reiserfs panic for having multiple save links for the same inode.
> >>
> >>
> > 
> > 
> > OK...
> > 
> > But how does this patch fix it?  It removes a lot of code - how come we
> > don't need it any more?
> 
> We were adding save links for appending writes only. The links were 
> removed once we finish the write operation successfully.
> 
> Now we don't add the save links at all.
> 

The removed code was to return file to a length it had before direct writing far past end started 
if that direct write did not complete due to unclean shutdown.
I am not sure why it was needed. I guess that if long append (direct of bufferred) did not complete - it is ok if file becomes longer than it was before.

However, reiserfs seems to fail to update ondisk inode file size when appending big holes. The included patch fixes that.
Please, apply


From: Vladimir Saveliev <vs@namesys.com>

To write far past the end of a file reiserfs appends a hole first.
While the hole grows file size in ondisk inode has to be updated
so that in case of unclean shutdown it matches real file size.

Signed-off-by: Vladimir Saveliev <vs@namesys.com>



diff -puN fs/reiserfs/file.c~reiserfs-update-file-size-on-hole-creation fs/reiserfs/file.c
--- linux-2.6.19-rc6-mm2/fs/reiserfs/file.c~reiserfs-update-file-size-on-hole-creation	2006-11-29 17:54:03.000000000 +0300
+++ linux-2.6.19-rc6-mm2-vs/fs/reiserfs/file.c	2006-11-29 17:54:03.000000000 +0300
@@ -406,6 +406,8 @@ static int reiserfs_allocate_blocks_for_
 				   we restart it. This will also free the path. */
 				if (journal_transaction_should_end
 				    (th, th->t_blocks_allocated)) {
+					inode->i_size = cpu_key_k_offset(&key) +
+						(to_paste << inode->i_blkbits);
 					res =
 					    restart_transaction(th, inode,
 								&path);

_


