Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVCaL6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVCaL6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVCaL6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:58:46 -0500
Received: from pat.uio.no ([129.240.130.16]:36058 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261340AbVCaL6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:58:40 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050331073017.GA16577@elte.hu>
References: <1112192778.17365.2.camel@mindpipe>
	 <1112194256.10634.35.camel@lade.trondhjem.org>
	 <20050330115640.0bc38d01.akpm@osdl.org>
	 <1112217299.10771.3.camel@lade.trondhjem.org>
	 <1112236017.26732.4.camel@mindpipe> <20050330183957.2468dc21.akpm@osdl.org>
	 <1112237239.26732.8.camel@mindpipe>
	 <1112240918.10975.4.camel@lade.trondhjem.org>
	 <20050331065942.GA14952@elte.hu> <20050330231801.129b0715.akpm@osdl.org>
	 <20050331073017.GA16577@elte.hu>
Content-Type: multipart/mixed; boundary="=-Tyt4lFngCwpWeJLiblkM"
Date: Thu, 31 Mar 2005 06:58:24 -0500
Message-Id: <1112270304.10975.41.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.47, required 12,
	autolearn=disabled, AWL 1.48, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Tyt4lFngCwpWeJLiblkM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

to den 31.03.2005 Klokka 09:30 (+0200) skreiv Ingo Molnar:


> > And presumably that list-based code rarely hits the worst-case, else
> > it would have been changed by now.
> 
> that was my other point in a previous mail: most write benchmarks do 
> continuous append writes, and CPU overhead easily gets lost in
> network 
> latency.

Well. Most _good_ write benchmarks go through a variety of scenarios.

The problem with the radix-tree is that in most cases you are swapping a
linear scan through only the dirty pages (most of which you want to try
to add to the list anyway) for a linear scan through the entire list of
pages.
Damn! I've forgotten an extra _obvious_ optimization that might help
here... See the attached patch.

> Also, considering that a good portion of the NFS client's code is still 
> running under the BKL one would assume if the BKL hurts performance it 
> would have been changed by now? ;-)

Funny you should mention that... Chuck happens to have spent the last
fortnight working on removing our BKL-addiction. ;-)

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

--=-Tyt4lFngCwpWeJLiblkM
Content-Description: 
Content-Disposition: inline; filename=linux-2.6.12-38.5-nfspage_tag_dirty.dif
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

 fs/nfs/write.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

Index: linux-2.6.12-rc1/fs/nfs/write.c
===================================================================
--- linux-2.6.12-rc1.orig/fs/nfs/write.c
+++ linux-2.6.12-rc1/fs/nfs/write.c
@@ -539,12 +539,15 @@ static int
 nfs_scan_dirty(struct inode *inode, struct list_head *dst, unsigned long idx_start, unsigned int npages)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
-	int	res;
-	res = nfs_scan_lock_dirty(nfsi, dst, idx_start, npages);
-	nfsi->ndirty -= res;
-	sub_page_state(nr_dirty,res);
-	if ((nfsi->ndirty == 0) != list_empty(&nfsi->dirty))
-		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ndirty.\n");
+	int res = 0;
+
+	if (nfsi->ndirty != 0) {
+		res = nfs_scan_lock_dirty(nfsi, dst, idx_start, npages);
+		nfsi->ndirty -= res;
+		sub_page_state(nr_dirty,res);
+		if ((nfsi->ndirty == 0) != list_empty(&nfsi->dirty))
+			printk(KERN_ERR "NFS: desynchronized value of nfs_i.ndirty.\n");
+	}
 	return res;
 }
 
@@ -563,11 +566,14 @@ static int
 nfs_scan_commit(struct inode *inode, struct list_head *dst, unsigned long idx_start, unsigned int npages)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
-	int	res;
-	res = nfs_scan_list(&nfsi->commit, dst, idx_start, npages);
-	nfsi->ncommit -= res;
-	if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
-		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
+	int res;
+
+	if (nfsi->ncommit != 0) {
+		res = nfs_scan_list(&nfsi->commit, dst, idx_start, npages);
+		nfsi->ncommit -= res;
+		if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
+			printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
+	}
 	return res;
 }
 #endif

--=-Tyt4lFngCwpWeJLiblkM--

