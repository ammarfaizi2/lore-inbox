Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286359AbRLTU2D>; Thu, 20 Dec 2001 15:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286364AbRLTU1y>; Thu, 20 Dec 2001 15:27:54 -0500
Received: from pat.uio.no ([129.240.130.16]:34179 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S286359AbRLTU1j>;
	Thu, 20 Dec 2001 15:27:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15394.18867.426834.102550@charged.uio.no>
Date: Thu, 20 Dec 2001 21:27:31 +0100
To: Steffen Persvold <sp@scali.no>
Cc: lkml <linux-kernel@vger.kernel.org>, nfs list <nfs@lists.sourceforge.net>,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.4.8 NFS Problems
In-Reply-To: <3C21F863.5278841A@scali.no>
In-Reply-To: <3C21B30D.871B6BE4@scali.no>
	<15393.51009.856041.463215@charged.uio.no>
	<3C21F863.5278841A@scali.no>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Steffen Persvold <sp@scali.no> writes:

     > I can do that, but since one of the clients reporting this
     > problem is an Alpha machine running
     > 2.2.19 the patch won't do much good (not that the patch is
     >        architecture dependent, but it's only for
     > 2.4.17). Has this patch been there since 2.2 or is it a new
     > "feature" in the "stable" #:) 2.4 kernels.

All the problems fixed by the patch should be present in 2.2.19 too. I
don't really have time to backport the whole thing, but I've appended
a backport of the bit that is directly relevant to the EIO error.

Cheers,
   Trond

--- linux-2.2.19-up/fs/nfs/read.c.orig	Sun Mar 25 18:37:38 2001
+++ linux-2.2.19-up/fs/nfs/read.c	Thu Dec 20 21:25:13 2001
@@ -420,7 +420,7 @@
 {
 	struct nfs_read_data	*data = (struct nfs_read_data *) task->tk_calldata;
 	struct inode		*inode = data->inode;
-	int			count = data->res.count;
+	unsigned int		count = data->res.count;
 
 	dprintk("NFS: %4d nfs_readpage_result, (status %d)\n",
 		task->tk_pid, task->tk_status);
@@ -431,10 +431,15 @@
 		struct page *page = req->wb_page;
 		nfs_list_remove_request(req);
 
-		if (task->tk_status >= 0 && count >= 0) {
+		if (task->tk_status >= 0) {
+			char *p = page_address(page);
+			if (count < PAGE_CACHE_SIZE) {
+				memset(p + count, 0, PAGE_CACHE_SIZE - count);
+				count = 0;
+			} else
+				count -= PAGE_CACHE_SIZE;
 			flush_dcache_page(page_address(page)); /* Is this correct? */
 			set_bit(PG_uptodate, &page->flags);
-			count -= PAGE_CACHE_SIZE;
 		} else
 			set_bit(PG_error, &page->flags);
 		nfs_unlock_page(page);

