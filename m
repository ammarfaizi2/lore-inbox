Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVKUWn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVKUWn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVKUWn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:43:29 -0500
Received: from pat.uio.no ([129.240.130.16]:6623 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751232AbVKUWnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:43:11 -0500
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, cel@citi.umich.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051121213913.61220.qmail@web34115.mail.mud.yahoo.com>
References: <20051121213913.61220.qmail@web34115.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 17:42:54 -0500
Message-Id: <1132612974.8011.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.977, required 12,
	autolearn=disabled, AWL 1.84, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 13:39 -0800, Kenny Simpson wrote:
> With gentle beating by a clue-stick from Andrew.. I can run the same test on ext3...
> 
> ext3 is happy...
> 
> open("/data/foo", O_RDWR|O_CREAT|O_TRUNC|O_DIRECT|O_LARGEFILE, 0666) = 3
> pwrite(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 4299161600) = 4096
> mmap2(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0x100200) = 0xb7c7f000
> pwrite(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 4301258752) = 4096
> exit_group(0)                           = ?
> 
> 
> but NFS is still unhappy....
> 
> open("/mnt/bar", O_RDWR|O_CREAT|O_TRUNC|O_DIRECT|O_LARGEFILE, 0666) = 3
> pwrite(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 4299161600) = 4096
> mmap2(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0x100200) = 0xb7bc2000
> pwrite(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 4301258752  <never
> returns>

Ah... It is the pwrite() _after_ the call to mmap() that fails....

OK, does the following patch fix it?

Cheers,
  Trond
-------------
NFS: O_DIRECT cannot call invalidate_inode_pages2().

 Anything that calls lock_page() should be avoided in O_DIRECT, however
 we should be able to call invalidate_inode_pages() since that doesn't
 wait on the page lock.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/direct.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index a2d2814..ef299f8 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -774,7 +774,7 @@ nfs_file_direct_write(struct kiocb *iocb
 
 	retval = nfs_direct_write(inode, ctx, &iov, pos, 1);
 	if (mapping->nrpages)
-		invalidate_inode_pages2(mapping);
+		invalidate_inode_pages(mapping);
 	if (retval > 0)
 		*ppos = pos + retval;
 


