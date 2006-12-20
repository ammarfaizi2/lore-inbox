Return-Path: <linux-kernel-owner+w=401wt.eu-S965075AbWLTOP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWLTOP2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWLTOP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:15:27 -0500
Received: from [85.204.20.254] ([85.204.20.254]:46071 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S965075AbWLTOP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:15:26 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <1166571749.10372.178.camel@twins>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
Content-Type: text/plain
Organization: I-NEO
Date: Wed, 20 Dec 2006 16:15:17 +0200
Message-Id: <1166624117.6891.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 00:42 +0100, Peter Zijlstra wrote:
> On Mon, 2006-12-18 at 12:14 -0800, Linus Torvalds wrote:
> 
> > OR:
> > 
> >  - page_mkclean_one() is simply buggy.
> 
> GOLD!
> 
> it seems to work with all this (full diff against current git).
> 
> /me rebuilds full kernel to make sure...
> reboot...
> test...      pff the tension...
> yay, still good!
> 
> Andrei; would you please verify.

I have corrupted files.

> The magic seems to be in the extra tlb flush after clearing the dirty
> bit. Just too bad ptep_clear_flush_dirty() needs ptep not entry.
> 
> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> index 5e7cd45..2b8893b 100644
> --- a/drivers/connector/connector.c
> +++ b/drivers/connector/connector.c
> @@ -135,8 +135,7 @@ static int cn_call_callback(struct cn_msg *msg, void (*destruct_data)(void *), v
>  	spin_lock_bh(&dev->cbdev->queue_lock);
>  	list_for_each_entry(__cbq, &dev->cbdev->queue_list, callback_entry) {
>  		if (cn_cb_equal(&__cbq->id.id, &msg->id)) {
> -			if (likely(!test_bit(WORK_STRUCT_PENDING,
> -					     &__cbq->work.work.management) &&
> +			if (likely(!delayed_work_pending(&__cbq->work) &&
>  					__cbq->data.ddata == NULL)) {
>  				__cbq->data.callback_priv = msg;
>  
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d1f1b54..263f88e 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2834,7 +2834,7 @@ int try_to_free_buffers(struct page *page)
>  	int ret = 0;
>  
>  	BUG_ON(!PageLocked(page));
> -	if (PageWriteback(page))
> +	if (PageDirty(page) || PageWriteback(page))
>  		return 0;
>  
>  	if (mapping == NULL) {		/* can this still happen? */
> @@ -2845,22 +2845,6 @@ int try_to_free_buffers(struct page *page)
>  	spin_lock(&mapping->private_lock);
>  	ret = drop_buffers(page, &buffers_to_free);
>  	spin_unlock(&mapping->private_lock);
> -	if (ret) {
> -		/*
> -		 * If the filesystem writes its buffers by hand (eg ext3)
> -		 * then we can have clean buffers against a dirty page.  We
> -		 * clean the page here; otherwise later reattachment of buffers
> -		 * could encounter a non-uptodate page, which is unresolvable.
> -		 * This only applies in the rare case where try_to_free_buffers
> -		 * succeeds but the page is not freed.
> -		 *
> -		 * Also, during truncate, discard_buffer will have marked all
> -		 * the page's buffers clean.  We discover that here and clean
> -		 * the page also.
> -		 */
> -		if (test_clear_page_dirty(page))
> -			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
> -	}
>  out:
>  	if (buffers_to_free) {
>  		struct buffer_head *bh = buffers_to_free;
> diff --git a/mm/memory.c b/mm/memory.c
> index c00bac6..60e0945 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1842,6 +1842,33 @@ void unmap_mapping_range(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(unmap_mapping_range);
>  
> +static void check_last_page(struct address_space *mapping, loff_t size)
> +{
> +	pgoff_t index;
> +	unsigned int offset;
> +	struct page *page;
> +
> +	if (!mapping)
> +		return;
> +	offset = size & ~PAGE_MASK;
> +	if (!offset)
> +		return;
> +	index = size >> PAGE_SHIFT;
> +	page = find_lock_page(mapping, index);
> +	if (page) {
> +		unsigned int check = 0;
> +		unsigned char *kaddr = kmap_atomic(page, KM_USER0);
> +		do {
> +			check += kaddr[offset++];
> +		} while (offset < PAGE_SIZE);
> +		kunmap_atomic(kaddr, KM_USER0);
> +		unlock_page(page);
> +		page_cache_release(page);
> +		if (check)
> +			printk(KERN_ERR "%s: BADNESS: truncate check %u\n", current->comm, check);
> +	}
> +}
> +
>  /**
>   * vmtruncate - unmap mappings "freed" by truncate() syscall
>   * @inode: inode of the file used
> @@ -1875,6 +1902,7 @@ do_expand:
>  		goto out_sig;
>  	if (offset > inode->i_sb->s_maxbytes)
>  		goto out_big;
> +	check_last_page(mapping, inode->i_size);
>  	i_size_write(inode, offset);
>  
>  out_truncate:
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 237107c..f561e72 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -957,7 +957,7 @@ int test_set_page_writeback(struct page *page)
>  EXPORT_SYMBOL(test_set_page_writeback);
>  
>  /*
> - * Return true if any of the pages in the mapping are marged with the
> + * Return true if any of the pages in the mapping are marked with the
>   * passed tag.
>   */
>  int mapping_tagged(struct address_space *mapping, int tag)
> diff --git a/mm/rmap.c b/mm/rmap.c
> index d8a842a..900229a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -432,7 +432,7 @@ static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	unsigned long address;
> -	pte_t *pte, entry;
> +	pte_t *ptep, entry;
>  	spinlock_t *ptl;
>  	int ret = 0;
>  
> @@ -440,22 +440,23 @@ static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
>  	if (address == -EFAULT)
>  		goto out;
>  
> -	pte = page_check_address(page, mm, address, &ptl);
> -	if (!pte)
> +	ptep = page_check_address(page, mm, address, &ptl);
> +	if (!ptep)
>  		goto out;
>  
> -	if (!pte_dirty(*pte) && !pte_write(*pte))
> +	if (!pte_dirty(*ptep) && !pte_write(*ptep))
>  		goto unlock;
>  
> -	entry = ptep_get_and_clear(mm, address, pte);
> -	entry = pte_mkclean(entry);
> +	entry = ptep_get_and_clear(mm, address, ptep);
>  	entry = pte_wrprotect(entry);
> -	ptep_establish(vma, address, pte, entry);
> +	ptep_establish(vma, address, ptep, entry);
> +	ret = ptep_clear_flush_dirty(vma, address, ptep) ||
> +		page_test_and_clear_dirty(page);
>  	lazy_mmu_prot_update(entry);
>  	ret = 1;
>  
>  unlock:
> -	pte_unmap_unlock(pte, ptl);
> +	pte_unmap_unlock(ptep, ptl);
>  out:
>  	return ret;
>  }
> 
> 

