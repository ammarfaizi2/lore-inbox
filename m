Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVCaOz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVCaOz2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVCaOz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:55:28 -0500
Received: from pat.uio.no ([129.240.130.16]:23215 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261480AbVCaOzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:55:10 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050331143930.GA4032@elte.hu>
References: <20050330183957.2468dc21.akpm@osdl.org>
	 <1112237239.26732.8.camel@mindpipe>
	 <1112240918.10975.4.camel@lade.trondhjem.org>
	 <20050331065942.GA14952@elte.hu> <20050330231801.129b0715.akpm@osdl.org>
	 <20050331073017.GA16577@elte.hu>
	 <1112270304.10975.41.camel@lade.trondhjem.org>
	 <1112272451.10975.72.camel@lade.trondhjem.org>
	 <20050331135825.GA2214@elte.hu>
	 <1112279522.20211.8.camel@lade.trondhjem.org>
	 <20050331143930.GA4032@elte.hu>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 09:54:51 -0500
Message-Id: <1112280891.20211.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.505, required 12,
	autolearn=disabled, AWL 1.45, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 31.03.2005 Klokka 16:39 (+0200) skreiv Ingo Molnar:
> * Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > > your patch works fine here - but there are still latencies in 
> > > nfs_scan_commit()/nfs_scan_list(): see the attached 3.7 msec latency 
> > > trace. It happened during a simple big-file writeout and is easily 
> > > reproducible. Could the nfsi->commit list searching be replaced with a 
> > > radix based approach too?
> > 
> > That would be 100% pure overhead. The nfsi->commit list does not need 
> > to be sorted and with these patches applied, it no longer is. In fact 
> > one of the cleanups I still need to do is to get rid of those 
> > redundant checks on wb->index (start is now always set to 0, and end 
> > is always ~0UL).
> > 
> > So the overhead you are currently seeing should just be that of 
> > iterating through the list, locking said requests and adding them to 
> > our private list.
> 
> ah - cool! This was a 100 MB writeout so having 3.7 msecs to process 
> 20K+ pages is not unreasonable. To break the latency, can i just do a 
> simple lock-break, via the patch below?

Errm... That looks a bit unsafe. What is there then to stop another
process from removing "pos" while you are scheduling?
It seems to me that you should really start afresh in that case.

The good news, though, is that because requests on the "commit" list do
not remain locked for long without being removed from the list, you
should rarely have to skip them. IOW restarting from the head of the
list is pretty much the same as starting from where you left off.

Cheers,
  Trond

> 	Ingo
> 
> --- linux/fs/nfs/pagelist.c.orig
> +++ linux/fs/nfs/pagelist.c
> @@ -311,8 +311,9 @@ out:
>   * You must be holding the inode's req_lock when calling this function
>   */
>  int
> -nfs_scan_list(struct list_head *head, struct list_head *dst,
> -	      unsigned long idx_start, unsigned int npages)
> +nfs_scan_list(struct nfs_inode *nfsi, struct list_head *head,
> +	      struct list_head *dst, unsigned long idx_start,
> +	      unsigned int npages)
>  {
>  	struct list_head	*pos, *tmp;
>  	struct nfs_page		*req;
> @@ -327,6 +328,8 @@ nfs_scan_list(struct list_head *head, st
>  
>  	list_for_each_safe(pos, tmp, head) {
>  
> +		cond_resched_lock(&nfsi->req_lock);
> +
>  		req = nfs_list_entry(pos);
>  
>  		if (req->wb_index < idx_start)
> --- linux/fs/nfs/write.c.orig
> +++ linux/fs/nfs/write.c
> @@ -569,7 +569,7 @@ nfs_scan_commit(struct inode *inode, str
>  	int res = 0;
>  
>  	if (nfsi->ncommit != 0) {
> -		res = nfs_scan_list(&nfsi->commit, dst, idx_start, npages);
> +		res = nfs_scan_list(nfsi, &nfsi->commit, dst, idx_start, npages);
>  		nfsi->ncommit -= res;
>  		if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
>  			printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
> --- linux/include/linux/nfs_page.h.orig
> +++ linux/include/linux/nfs_page.h
> @@ -63,8 +63,8 @@ extern	void nfs_release_request(struct n
>  
>  extern  int nfs_scan_lock_dirty(struct nfs_inode *nfsi, struct list_head *dst,
>  				unsigned long idx_start, unsigned int npages);
> -extern	int nfs_scan_list(struct list_head *, struct list_head *,
> -			  unsigned long, unsigned int);
> +extern	int nfs_scan_list(struct nfs_inode *nfsi, struct list_head *,
> +			  struct list_head *, unsigned long, unsigned int);
>  extern	int nfs_coalesce_requests(struct list_head *, struct list_head *,
>  				  unsigned int);
>  extern  int nfs_wait_on_request(struct nfs_page *);
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

