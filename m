Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265736AbUGZVMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUGZVMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUGZU5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:57:49 -0400
Received: from wanderer.mr.itd.umich.edu ([141.211.93.146]:54924 "EHLO
	wanderer.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S266115AbUGZUr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:47:28 -0400
Date: Mon, 26 Jul 2004 16:47:10 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@red.engin.umich.edu
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: LKML <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] prio_tree iterator cleanup.
In-Reply-To: <41027815.94F9D9AC@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0407261626080.17181@red.engin.umich.edu>
References: <41027815.94F9D9AC@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Oleg,

I have gone through all the 3 prio_tree patches you have sent
over the last few weeks. Your 2nd (kill vma_prio_tree_init) and
3rd (iterator cleanup) patches look straight-forward.

I agree that vm_set.head linking is ugly. Your 1st patch
attempts to simplify it and removes few lines of code. However,
your 1st patch is intrusive and I am not convinced that it
improves the code very much.

If you can post your 2nd and 3rd patches independent of your
first patch, that will be great. Please covert vma_prio_tree_next
in arch/* directories if you plan to post a new version of your
3rd patch.

Overall I am inclined to leave the prio_tree code as it is.
However, your 2nd and 3rd patches are quiet straight-forward
and I am okay with them.

Thanking you,
Rajesh

On Sat, 24 Jul 2004, Oleg Nesterov wrote:

> Hello.
>
> Currently we have:
>
> 	while ((vma = vma_prio_tree_next(vma, root, &iter,
>                                         begin, end)) != NULL)
> 		do_something_with_vma;
>
> Then iter,root,begin,end are all transfered unchanged to various
> functions. This patch hides them in struct iter instead.
>
> It slightly lessens source, code size, and stack usage.
>
> I hope it makes the code a bit more readable too.
>
> Patch on top of "kill vma_prio_tree_init()", see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109034156613288
>
> Oleg.
>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>
> diff -urp prio_init/fs/hugetlbfs/inode.c prio_iter/fs/hugetlbfs/inode.c
> --- prio_init/fs/hugetlbfs/inode.c	2004-07-13 17:52:41.000000000 +0400
> +++ prio_iter/fs/hugetlbfs/inode.c	2004-07-24 16:13:40.000000000 +0400
> @@ -272,8 +272,7 @@ hugetlb_vmtruncate_list(struct prio_tree
>  	struct vm_area_struct *vma = NULL;
>  	struct prio_tree_iter iter;
>
> -	while ((vma = vma_prio_tree_next(vma, root, &iter,
> -					h_pgoff, ULONG_MAX)) != NULL) {
> +	vma_prio_tree_foreach(vma, &iter, root, h_pgoff, ULONG_MAX) {
>  		unsigned long h_vm_pgoff;
>  		unsigned long v_length;
>  		unsigned long v_offset;
> diff -urp prio_init/include/linux/mm.h prio_iter/include/linux/mm.h
> --- prio_init/include/linux/mm.h	2004-07-20 17:47:23.000000000 +0400
> +++ prio_iter/include/linux/mm.h	2004-07-24 17:13:11.000000000 +0400
> @@ -602,9 +602,12 @@ extern void si_meminfo_node(struct sysin
>  void vma_prio_tree_add(struct vm_area_struct *, struct vm_area_struct *old);
>  void vma_prio_tree_insert(struct vm_area_struct *, struct prio_tree_root *);
>  void vma_prio_tree_remove(struct vm_area_struct *, struct prio_tree_root *);
> -struct vm_area_struct *vma_prio_tree_next(
> -	struct vm_area_struct *, struct prio_tree_root *,
> -	struct prio_tree_iter *, pgoff_t begin, pgoff_t end);
> +struct vm_area_struct *vma_prio_tree_next(struct vm_area_struct *vma,
> +	struct prio_tree_iter *iter);
> +
> +#define vma_prio_tree_foreach(vma, iter, root, begin, end)	\
> +	for (prio_tree_iter_init(iter, root, begin, end), vma = NULL;	\
> +		(vma = vma_prio_tree_next(vma, iter)); )
>
>  static inline void vma_nonlinear_insert(struct vm_area_struct *vma,
>  					struct list_head *list)
> diff -urp prio_init/include/linux/prio_tree.h prio_iter/include/linux/prio_tree.h
> --- prio_init/include/linux/prio_tree.h	2004-07-19 17:16:26.000000000 +0400
> +++ prio_iter/include/linux/prio_tree.h	2004-07-24 16:30:07.000000000 +0400
> @@ -17,8 +17,20 @@ struct prio_tree_iter {
>  	unsigned long		mask;
>  	unsigned long		value;
>  	int			size_level;
> +
> +	struct prio_tree_root	*root;
> +	pgoff_t			r_index;
> +	pgoff_t			h_index;
>  };
>
> +static inline void prio_tree_iter_init(struct prio_tree_iter *iter,
> +		struct prio_tree_root *root, pgoff_t r_index, pgoff_t h_index)
> +{
> +	iter->root = root;
> +	iter->r_index = r_index;
> +	iter->h_index = h_index;
> +}
> +
>  #define INIT_PRIO_TREE_ROOT(ptr)	\
>  do {					\
>  	(ptr)->prio_tree_node = NULL;	\
> diff -urp prio_init/mm/memory.c prio_iter/mm/memory.c
> --- prio_init/mm/memory.c	2004-07-13 17:52:49.000000000 +0400
> +++ prio_iter/mm/memory.c	2004-07-24 16:08:29.000000000 +0400
> @@ -1127,8 +1127,8 @@ static inline void unmap_mapping_range_l
>  	struct prio_tree_iter iter;
>  	pgoff_t vba, vea, zba, zea;
>
> -	while ((vma = vma_prio_tree_next(vma, root, &iter,
> -			details->first_index, details->last_index)) != NULL) {
> +	vma_prio_tree_foreach(vma, &iter, root,
> +			details->first_index, details->last_index) {
>  		vba = vma->vm_pgoff;
>  		vea = vba + ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) - 1;
>  		/* Assume for now that PAGE_CACHE_SHIFT == PAGE_SHIFT */
> diff -urp prio_init/mm/prio_tree.c prio_iter/mm/prio_tree.c
> --- prio_init/mm/prio_tree.c	2004-07-20 17:25:15.000000000 +0400
> +++ prio_iter/mm/prio_tree.c	2004-07-24 16:31:34.000000000 +0400
> @@ -312,9 +312,7 @@ static void prio_tree_remove(struct prio
>   * 'm' is the number of prio_tree_nodes that overlap the interval X.
>   */
>
> -static struct prio_tree_node *prio_tree_left(
> -		struct prio_tree_root *root, struct prio_tree_iter *iter,
> -		unsigned long radix_index, unsigned long heap_index,
> +static struct prio_tree_node *prio_tree_left(struct prio_tree_iter *iter,
>  		unsigned long *r_index, unsigned long *h_index)
>  {
>  	if (prio_tree_left_empty(iter->cur))
> @@ -322,7 +320,7 @@ static struct prio_tree_node *prio_tree_
>
>  	GET_INDEX(iter->cur->left, *r_index, *h_index);
>
> -	if (radix_index <= *h_index) {
> +	if (iter->r_index <= *h_index) {
>  		iter->cur = iter->cur->left;
>  		iter->mask >>= 1;
>  		if (iter->mask) {
> @@ -336,7 +334,7 @@ static struct prio_tree_node *prio_tree_
>  				iter->mask = ULONG_MAX;
>  			} else {
>  				iter->size_level = 1;
> -				iter->mask = 1UL << (root->index_bits - 1);
> +				iter->mask = 1UL << (iter->root->index_bits - 1);
>  			}
>  		}
>  		return iter->cur;
> @@ -345,9 +343,7 @@ static struct prio_tree_node *prio_tree_
>  	return NULL;
>  }
>
> -static struct prio_tree_node *prio_tree_right(
> -		struct prio_tree_root *root, struct prio_tree_iter *iter,
> -		unsigned long radix_index, unsigned long heap_index,
> +static struct prio_tree_node *prio_tree_right(struct prio_tree_iter *iter,
>  		unsigned long *r_index, unsigned long *h_index)
>  {
>  	unsigned long value;
> @@ -360,12 +356,12 @@ static struct prio_tree_node *prio_tree_
>  	else
>  		value = iter->value | iter->mask;
>
> -	if (heap_index < value)
> +	if (iter->h_index < value)
>  		return NULL;
>
>  	GET_INDEX(iter->cur->right, *r_index, *h_index);
>
> -	if (radix_index <= *h_index) {
> +	if (iter->r_index <= *h_index) {
>  		iter->cur = iter->cur->right;
>  		iter->mask >>= 1;
>  		iter->value = value;
> @@ -380,7 +376,7 @@ static struct prio_tree_node *prio_tree_
>  				iter->mask = ULONG_MAX;
>  			} else {
>  				iter->size_level = 1;
> -				iter->mask = 1UL << (root->index_bits - 1);
> +				iter->mask = 1UL << (iter->root->index_bits - 1);
>  			}
>  		}
>  		return iter->cur;
> @@ -405,10 +401,10 @@ static struct prio_tree_node *prio_tree_
>  	return iter->cur;
>  }
>
> -static inline int overlap(unsigned long radix_index, unsigned long heap_index,
> +static inline int overlap(struct prio_tree_iter *iter,
>  		unsigned long r_index, unsigned long h_index)
>  {
> -	return heap_index >= r_index && radix_index <= h_index;
> +	return iter->h_index >= r_index && iter->r_index <= h_index;
>  }
>
>  /*
> @@ -418,35 +414,33 @@ static inline int overlap(unsigned long
>   * heap_index]. Note that always radix_index <= heap_index. We do a pre-order
>   * traversal of the tree.
>   */
> -static struct prio_tree_node *prio_tree_first(struct prio_tree_root *root,
> -		struct prio_tree_iter *iter, unsigned long radix_index,
> -		unsigned long heap_index)
> +static struct prio_tree_node *prio_tree_first(struct prio_tree_iter *iter)
>  {
> +	struct prio_tree_root *root;
>  	unsigned long r_index, h_index;
>
>  	INIT_PRIO_TREE_ITER(iter);
>
> +	root = iter->root;
>  	if (prio_tree_empty(root))
>  		return NULL;
>
>  	GET_INDEX(root->prio_tree_node, r_index, h_index);
>
> -	if (radix_index > h_index)
> +	if (iter->r_index > h_index)
>  		return NULL;
>
>  	iter->mask = 1UL << (root->index_bits - 1);
>  	iter->cur = root->prio_tree_node;
>
>  	while (1) {
> -		if (overlap(radix_index, heap_index, r_index, h_index))
> +		if (overlap(iter, r_index, h_index))
>  			return iter->cur;
>
> -		if (prio_tree_left(root, iter, radix_index, heap_index,
> -					&r_index, &h_index))
> +		if (prio_tree_left(iter, &r_index, &h_index))
>  			continue;
>
> -		if (prio_tree_right(root, iter, radix_index, heap_index,
> -					&r_index, &h_index))
> +		if (prio_tree_right(iter, &r_index, &h_index))
>  			continue;
>
>  		break;
> @@ -459,21 +453,16 @@ static struct prio_tree_node *prio_tree_
>   *
>   * Get the next prio_tree_node that overlaps with the input interval in iter
>   */
> -static struct prio_tree_node *prio_tree_next(struct prio_tree_root *root,
> -		struct prio_tree_iter *iter, unsigned long radix_index,
> -		unsigned long heap_index)
> +static struct prio_tree_node *prio_tree_next(struct prio_tree_iter *iter)
>  {
>  	unsigned long r_index, h_index;
>
>  repeat:
> -	while (prio_tree_left(root, iter, radix_index,
> -				heap_index, &r_index, &h_index)) {
> -		if (overlap(radix_index, heap_index, r_index, h_index))
> +	while (prio_tree_left(iter, &r_index, &h_index))
> +		if (overlap(iter, r_index, h_index))
>  			return iter->cur;
> -	}
>
> -	while (!prio_tree_right(root, iter, radix_index,
> -				heap_index, &r_index, &h_index)) {
> +	while (!prio_tree_right(iter, &r_index, &h_index)) {
>  	    	while (!prio_tree_root(iter->cur) &&
>  				iter->cur->parent->right == iter->cur)
>  			prio_tree_parent(iter);
> @@ -484,7 +473,7 @@ repeat:
>  		prio_tree_parent(iter);
>  	}
>
> -	if (overlap(radix_index, heap_index, r_index, h_index))
> +	if (overlap(iter, r_index, h_index))
>  		return iter->cur;
>
>  	goto repeat;
> @@ -606,19 +595,18 @@ void vma_prio_tree_remove(struct vm_area
>   * page in the given range of contiguous file pages.
>   */
>  struct vm_area_struct *vma_prio_tree_next(struct vm_area_struct *vma,
> -		struct prio_tree_root *root, struct prio_tree_iter *iter,
> -		pgoff_t begin, pgoff_t end)
> +					struct prio_tree_iter *iter)
>  {
>  	struct prio_tree_node *ptr;
>  	struct vm_area_struct *next;
>
>  	if (!vma) {
> -		ptr = prio_tree_first(root, iter, begin, end);
> +		ptr = prio_tree_first(iter);
>  		goto check;
>  	}
>
>  	if (!vma->shared.vm_set.list.prev) {
> -		ptr = prio_tree_next(root, iter, begin, end);
> +		ptr = prio_tree_next(iter);
>  		goto check;
>  	}
>
> diff -urp prio_init/mm/rmap.c prio_iter/mm/rmap.c
> --- prio_init/mm/rmap.c	2004-07-13 17:52:49.000000000 +0400
> +++ prio_iter/mm/rmap.c	2004-07-24 16:20:58.000000000 +0400
> @@ -284,8 +284,7 @@ static inline int page_referenced_file(s
>  	if (!spin_trylock(&mapping->i_mmap_lock))
>  		return 0;
>
> -	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap,
> -					&iter, pgoff, pgoff)) != NULL) {
> +	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
>  		if ((vma->vm_flags & (VM_LOCKED|VM_MAYSHARE))
>  				  == (VM_LOCKED|VM_MAYSHARE)) {
>  			referenced++;
> @@ -665,8 +664,7 @@ static inline int try_to_unmap_file(stru
>  	if (!spin_trylock(&mapping->i_mmap_lock))
>  		return ret;
>
> -	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap,
> -					&iter, pgoff, pgoff)) != NULL) {
> +	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
>  		ret = try_to_unmap_one(page, vma);
>  		if (ret == SWAP_FAIL || !page->mapcount)
>  			goto out;
>
