Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030573AbVKQAHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030573AbVKQAHO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030568AbVKQAHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:07:13 -0500
Received: from pat.uio.no ([129.240.130.16]:63905 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030567AbVKQAHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:07:11 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051116144450.47436560.akpm@osdl.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	 <1132163057.8811.15.camel@lade.trondhjem.org>
	 <20051116100053.44d81ae2.akpm@osdl.org>
	 <1132166062.8811.30.camel@lade.trondhjem.org>
	 <20051116110938.1bf54339.akpm@osdl.org>
	 <1132171500.8811.37.camel@lade.trondhjem.org>
	 <20051116133130.625cd19b.akpm@osdl.org>
	 <1132177785.8811.57.camel@lade.trondhjem.org>
	 <20051116141052.7994ab7d.akpm@osdl.org>
	 <1132179796.8811.70.camel@lade.trondhjem.org>
	 <20051116144450.47436560.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 19:06:09 -0500
Message-Id: <1132185969.8811.106.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.844, required 12,
	autolearn=disabled, AWL 1.16, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 14:44 -0800, Andrew Morton wrote:
> diff -puN include/linux/writeback.h~writeback_control-flag-writepages include/linux/writeback.h
> --- devel/include/linux/writeback.h~writeback_control-flag-writepages	2005-11-16 14:43:52.000000000 -0800
> +++ devel-akpm/include/linux/writeback.h	2005-11-16 14:43:52.000000000 -0800
> @@ -53,10 +53,11 @@ struct writeback_control {
>  	loff_t start;
>  	loff_t end;
>  
> -	unsigned nonblocking:1;			/* Don't get stuck on request queues */
> -	unsigned encountered_congestion:1;	/* An output: a queue is full */
> -	unsigned for_kupdate:1;			/* A kupdate writeback */
> -	unsigned for_reclaim:1;			/* Invoked from the page allocator */
> +	unsigned nonblocking:1;		/* Don't get stuck on request queues */
> +	unsigned encountered_congestion:1; /* An output: a queue is full */
> +	unsigned for_kupdate:1;		/* A kupdate writeback */
> +	unsigned for_reclaim:1;		/* Invoked from the page allocator */
> +	unsigned for_writepages:1;	/* This is a writepages() call */
>  };
>  
>  /*
> diff -puN mm/page-writeback.c~writeback_control-flag-writepages mm/page-writeback.c
> --- devel/mm/page-writeback.c~writeback_control-flag-writepages	2005-11-16 14:43:52.000000000 -0800
> +++ devel-akpm/mm/page-writeback.c	2005-11-16 14:43:52.000000000 -0800
> @@ -550,11 +550,17 @@ void __init page_writeback_init(void)
>  
>  int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  {
> +	int ret;
> +
>  	if (wbc->nr_to_write <= 0)
>  		return 0;
> +	wbc->for_writepages = 1;
>  	if (mapping->a_ops->writepages)
> -		return mapping->a_ops->writepages(mapping, wbc);
> -	return generic_writepages(mapping, wbc);
> +		ret =  mapping->a_ops->writepages(mapping, wbc);
> +	else
> +		ret = generic_writepages(mapping, wbc);
> +	wbc->for_writepages = 0;
> +	return ret;
>  }

The accompanying NFS patch makes use of this in order to figure out when
to flush the data correctly.
-------------
NFS: Work correctly with single-page ->writepage() calls

 Ensure that we use set_page_writeback() in the appropriate places
 to help the VM in keeping its page radix_tree in sync.
 Ensure that we always initiate flushing of data before we exit
 a single-page ->writepage() call.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/write.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 8f71e76..95d00f9 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -189,6 +189,7 @@ static int nfs_writepage_sync(struct nfs
 		(long long)NFS_FILEID(inode),
 		count, (long long)(page_offset(page) + offset));
 
+	set_page_writeback(page);
 	nfs_begin_data_update(inode);
 	do {
 		if (count < wsize)
@@ -221,6 +222,7 @@ static int nfs_writepage_sync(struct nfs
 
 io_error:
 	nfs_end_data_update(inode);
+	end_page_writeback(page);
 	nfs_writedata_free(wdata);
 	return written ? written : result;
 }
@@ -230,19 +232,16 @@ static int nfs_writepage_async(struct nf
 		unsigned int offset, unsigned int count)
 {
 	struct nfs_page	*req;
-	int		status;
 
 	req = nfs_update_request(ctx, inode, page, offset, count);
-	status = (IS_ERR(req)) ? PTR_ERR(req) : 0;
-	if (status < 0)
-		goto out;
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 	/* Update file length */
 	nfs_grow_file(page, offset, count);
 	/* Set the PG_uptodate flag? */
 	nfs_mark_uptodate(page, offset, count);
 	nfs_unlock_request(req);
- out:
-	return status;
+	return 0;
 }
 
 static int wb_priority(struct writeback_control *wbc)
@@ -302,11 +301,8 @@ do_it:
 	lock_kernel();
 	if (!IS_SYNC(inode) && inode_referenced) {
 		err = nfs_writepage_async(ctx, inode, page, 0, offset);
-		if (err >= 0) {
-			err = 0;
-			if (wbc->for_reclaim)
-				nfs_flush_inode(inode, 0, 0, FLUSH_STABLE);
-		}
+		if (!wbc->for_writepages)
+			nfs_flush_inode(inode, 0, 0, wb_priority(wbc));
 	} else {
 		err = nfs_writepage_sync(ctx, inode, page, 0,
 						offset, priority);
@@ -929,7 +925,7 @@ static int nfs_flush_multi(struct list_h
 	atomic_set(&req->wb_complete, requests);
 
 	ClearPageError(page);
-	SetPageWriteback(page);
+	set_page_writeback(page);
 	offset = 0;
 	nbytes = req->wb_bytes;
 	do {
@@ -992,7 +988,7 @@ static int nfs_flush_one(struct list_hea
 		nfs_list_remove_request(req);
 		nfs_list_add_request(req, &data->pages);
 		ClearPageError(req->wb_page);
-		SetPageWriteback(req->wb_page);
+		set_page_writeback(req->wb_page);
 		*pages++ = req->wb_page;
 		count += req->wb_bytes;
 	}


