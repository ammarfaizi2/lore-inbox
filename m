Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbUBCErl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 23:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbUBCErl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 23:47:41 -0500
Received: from web9705.mail.yahoo.com ([216.136.129.143]:57703 "HELO
	web9705.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265834AbUBCEqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 23:46:52 -0500
Message-ID: <20040203044651.47686.qmail@web9705.mail.yahoo.com>
Date: Mon, 2 Feb 2004 20:46:51 -0800 (PST)
From: Alok Mooley <rangdi@yahoo.com>
Subject: Active Memory Defragmentation: Our implementation & problems
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1481059508-1075783611=:47661"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1481059508-1075783611=:47661
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

We are a group of 4 students doing our final year
engg. project. To this aim,
we are implementing Active Memory Defragmentation,
based on the paper written
by Mr. Daniel Phillips titled "My research agenda for
2.7".
We are doing this on Linux kernel 2.6.0, & we have
written a module to this
effect. The module is attached to this mail.

Currently we are considering only the userspace
anonymous pages for movement.
As of yet, we have not considered kernel pages for
movement due to the 3GB rule.
Since userspace allocations are by page-faults, we
consider only single pages
(0th order) for movement. Thus, only the pages which
are not file-backed & are 
on LRU lists are currently being considered for
movement.

We now want to broaden our definition of a movable
page, & consider kernel
pages & file-backed pages also for movement. Do
file-backed pages also obey the
3GB rule? In order to move such pages, we will have to
patch macros like "virt_to_phys"
& other related macros, so that the address
translation for pages moved by us will take place
vmalloc style, i.e., via page tables, instead of
direct +-3GB. Is it worth introducing such
an overhead for address translation (vmalloc does
it!)? If no, then is there another
way out, or is it better to stick to our current
definition of a movable page?
Identifying pages moved by us may involve introducing
a new page-flag. A new page-flag 
for per-cpu pages would be great, since we have to
traverse the per-cpu hot & cold lists
in order to identify if a page is on the pcp lists. 

As of now, we have adopted a failure based approach,
i.e, we defragment only when 
a higher order allocation failure has taken place
(just before kswapd starts swapping). 
We now want to defragment based on thresholds kept for
each allocation order. 
Instead of a daemon kicking in on a threshold 
violation (as proposed by Mr. Daniel Phillips), we
intend to capture idle cpu cycles
by inserting a new process just above the idle
process. Now, when we are scheduled,
we are sure that the cpu is idle, & this is when we
check for threshold violation & defragment.
One problem with this would be when to reschedule
ourselves (allow our preemption)? 
We do not want the memory state to change beneath us,
so right now we are not 
allowing our preemption.
This will ofcourse hog the cpu, & we may not be able
to reschedule just by checking
the need_resched flag. Any advice or suggestions
regarding this problem? Also, will
the idle cpu approach be better or will the daemon
based approach be better?

Any suggestions,advice & comments will be highly
appreciated. 

Thanking you,
-Alok


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/
--0-1481059508-1075783611=:47661
Content-Type: text/plain; name="AMD.c"
Content-Description: AMD.c
Content-Disposition: inline; filename="AMD.c"

/*
* Active Memory Defragmentation
*/
#include<linux/asap.h>

#include"AMD.h"

MODULE_LICENSE("GPL");

/*
* This is the order till which the block freed went
* (for debugging)
*/
static int cnt_order;
/*
*This is the init module
*/
static int amd_init(void)
{
	int order = ORDER;
        printk("\nModule: AMD loaded\n");
#ifdef CALL_FROM_HERE
	/*
	 * Personally call the module
	 */
	defrag(order,zone_table[ZONE_NORMAL]);
#else
	/*
	 * The buddy allocator calls the module just before fallback
	 */
	func_defrag = defrag;
#endif
        return 0;
}

/*
* Userspace pages which are not file-backed as movable are considered.
* The Page Flags needed to be set currently are PG_lru and PG_direct
* The PG_active and PG_referenced are don't care
* The page mappings must be NULL i.e it must not be file backed
*/
static int movable_page(struct page *page)
{
        unsigned long flags;
        /*
	 * mask the upper 12 flag bits (top 8 bits contain the zone no.)
	 */
	flags = page->flags & FLAG_MASK;
	/*
	 * See that page is not file backed & flags are as desired.
	 * PG_lru , PG_direct (currently) must be set
	 */
	if(!page->mapping && (flags==0x10020 || flags==0x10024 || 
flags==0x10060 || 
flags==0x10064) && page_count(page))
		return 1;
	/*Page is not movable*/
	return 0;

}

/*
* This will update the PTEs to point to the new page.
* This function sets the previous PTE entry to the new value.
* "pte" is the PTE to be modified
*/
static void update_to_ptes(struct page *to)
{
	pte_t *pte = to->pte.direct;
	pgprot_t pgprot;
	/*
	 * These give the protection bits
	 * This code is not architecture independent
	 */
        pgprot.pgprot = (pte->pte_low) & (PAGE_SIZE-1);
	/*
	 * The physical address of the pte is changed to that of the new page
	 */
	set_pte_atomic(pte,mk_pte(to,pgprot));
}

/*
* Frees the page pointed by 'page'
*/
static void free_allocated_page(struct page *page)
{
	unsigned long page_idx,index,mask,order = 0;
	struct zone *zone = page_zone(page);
	struct page *base = zone->zone_mem_map;
	struct free_area *area = zone->free_area;
	mask = ~0;

	page_idx = page - base;

	/*
	 * The bitmap offset is given by index
	 */
	index = page_idx >> (1 + order);
	cnt_order = 0;

	while (mask + (1 << (MAX_ORDER-1))) {

		struct page *buddy1, *buddy2;
		if (!__test_and_change_bit(index, area->map)) {						/*
			 * the buddy page is still allocated.
			 */
			break;
		}

		/*
		 * Move the buddy up one level.
		 * This code is taking advantage of the identity:
		 * 	-mask = 1+~mask
		 */
		cnt_order++;
		buddy1 = base + (page_idx ^ -mask);
		buddy2 = base + page_idx;
		list_del(&buddy1->list);
		/* Mask for the immediate upper order*/
		mask <<= 1;
		area++;
		/*Bit offset at level n is offset at level (n-1) >> 1 */
		index >>= 1;
		page_idx &= mask;
	}
	list_add(&(base + page_idx)->list, &area->free_list);
}

/*
* Flush the cache and tlb entries corresponding to the pte for the
* 'from' page
* Flush the tlb entries corresponding to the given page and not the 
whole
* tlb.
*/
static void flush_from_caches(pte_addr_t paddr)
{
	pte_t *ptep = rmap_ptep_map(paddr);
	unsigned long address = ptep_to_address(ptep);
	struct mm_struct * mm = ptep_to_mm(ptep);
	struct vm_area_struct * vma;

	vma = find_vma(mm, address);
	if (!vma) {
		printk("\n Page vma is NULL");
		return ;
	}

	/* The page is mlock()d, cannot swap it out. */
	if (vma->vm_flags & VM_LOCKED) {
		printk("\n Page is vmlocked");
		return ;
	}

	/* Nuke the page table entry. */
	flush_cache_page(vma, address);
	flush_tlb_page(vma, address);
}

/*
* This will update the "to" & "from" struct pages
* The _to_ will become the exact replica of the _from_.
*/
static void update_struct_page(struct page *to,struct page *from,struct 
zone 
*zone)
{
	pte_addr_t pte_to_flush;

	unsigned long flag;
	/*
	 * delete "to" from the order 0 free-list
	 * If the to->private is 0 then remove it from the free_list
	 * For higher order pages they were removed during the time of
	 * selecting them for 'to_pages'.
	 */
	if(!to->private) {
		list_del(&to->list);
               	__change_bit((to - 
zone->zone_mem_map)>>1,zone->free_area[0].map);
	}
	 /*
	  * Assign all other members as it is
	  */
	*to = *from;

	spin_lock_irqsave(&zone->lru_lock,flag);

	/*
	 * Add "to" to the LRU list
	 * Remove "from" from the LRU lists
	 */
	list_add_tail(&to->lru,&from->lru);
	list_del(&from->lru);
	spin_unlock_irqrestore(&zone->lru_lock,flag);

	/*
	 * Now update the individual entries of "from"
	 * Reset the flag dword for "from"
	 * Set the no. of references to 0
	 * In this case set the direct ptr to 0
	 * (Currently `from pages' have direct bit set)
	 */
	from->flags &= ~FLAG_MASK;
	set_page_count(from,0);
	pte_to_flush = from->pte.direct;
	from->pte.direct = NULL;

	/*
	 * Now return this page (which was previously allocated)
	 * to the free-list.
	 */
	free_allocated_page(from);
	update_to_ptes(to);
	flush_from_caches(pte_to_flush);
}
/*
* Traverse the free list of the given order
* This is done once before calling defrag and again after defragmenting
* It gives the the free pages in the _order_ in given _zone_
*/
static int traverse_free_list(int order,struct zone *zone)
{
	struct free_area *area = zone->free_area;
	struct list_head *ele;
	int cnt = 0;
	list_for_each(ele,&area[order].free_list) {
		cnt++;
	}
	return cnt;
}

/*
* Perform the copying, updating and freeing here
*/
static void move_page(struct page *from,struct page *to,struct zone 
*zone)
{
	copy_page(page_address(to),page_address(from));
	update_struct_page(to,from,zone);
}

/*
* In case sufficient no. of free pages (to) were not found, return all
* the pages to buddy.
* The pages have page->private corresponding to the order from whose 
free_list
* they were removed. Order 0 pages were not removed from the free_list.
*/
static void return_to_buddy(struct page **to_pages,struct zone 
*zone,int 
allocated)
{
	int count = 0;
	struct free_area *area = zone->free_area;
	struct page *base = zone->zone_mem_map;

	while(count<allocated && to_pages[count]) {
		struct page *page = to_pages[count];

		/*
		 * Return only higher order pages to buddy as order 0 pages
		 * were not ACTUALLY allocated.
		 */
		if(page->private) {
			list_add(&page->list,&area[page->private].free_list);
			
__change_bit((page-base)>>(1+page->private),area[page->private].map);
			count += 1<<(page->private);
		}
		else
			count++;
	}
}

/*
* Defrag & make a block of required order
*/
static int defrag(int failed_order,struct zone *zone)
{
	unsigned long flags;
	int count,to_count,no_slots,ret_val;
        struct page *from;
        int cnt_before=0,cnt_after=0,ret=0,allocated=0;
	unsigned long *alloc_bitmap;
	struct page **to_pages;

	printk("\n\n**** Entering AMD for order %d****\n",failed_order);
	no_slots = ((1<<failed_order)*sizeof(struct page *));
	to_pages = (struct page **)kmalloc(no_slots,GFP_KERNEL);
	if(!to_pages){
		printk("\n No MEM for to_pages");
		return 0;
	}
	if(!(alloc_bitmap = (unsigned long 
*)kmalloc(1<<(MAX_ORDER-4),GFP_KERNEL))){
		printk("\n NO MEM FOR  alloc bitmap ");
		kfree((void *)to_pages);
		return 0;
	}
	for(count=0;count<(1<<failed_order);count++)
		to_pages[count]=NULL;

        spin_lock_irqsave(&zone->lock,flags);
	cnt_before = traverse_free_list(failed_order,zone);
	allocated = 0;

	from = get_from_block(failed_order-1,zone,alloc_bitmap);

	if(from) {
		allocated = count_alloc_pages(failed_order,alloc_bitmap);
		printk("\n Allocated = %d failed_order %d",allocated,failed_order);
		ret = find_to_pages(failed_order,zone,from,allocated,to_pages);
		if(!ret){
			return_to_buddy(to_pages,zone,allocated);
			printk("\n Didn't find to pages");
			ret_val = 0;
			goto bail_out;
		}
	} else {
		ret_val = 0;
		goto bail_out;
	}

	count = (1<<failed_order)-1;
	to_count = allocated-1;
	ret_val = 1;
	while(count>=0) {
		if(bit_test(count,alloc_bitmap)) {
			move_page(from+count,to_pages[to_count--],zone);
		}
		count--;
	}

	cnt_after = traverse_free_list(failed_order ,zone);

bail_out:
	spin_unlock_irqrestore(&zone->lock,flags);
	kfree((void *)to_pages);
	kfree((void *)alloc_bitmap);
	if(from && ret_val) {
		printk ("\n The free in order %d before = %d and after = 
%d",failed_order,cnt_before,cnt_after);
		printk("\n The free page gone to order %d",cnt_order);
	}
	return ret_val;
}

static void amd_exit(void)
{
        printk("\n Module: AMD removed\n");
#ifndef CALL_FROM_HERE
	func_defrag = 0;
#endif
}
module_init(amd_init);
module_exit(amd_exit);

/*
* 
*************************************************************************
* ******************** TO PAGES 
*******************************************
* 
*************************************************************************
*/

/*
* order = order of failure
* In the worst case all the pages in the _from_ block need to be moved
* Total number of pages in the _from_ block is 1<<(order) where
* order is the order of failure
* This function is called once the from pages are found
*/
static int count_alloc_pages(int order,unsigned long *alloc_bitmap)
{
	int count =0;
	int i;
	printk("\n Alloc bitmap\n ");
	for(i = 0;i < (1<<order);i++) {
		if(bit_test(i,alloc_bitmap)){
			printk("1");
			count++;
		}
		else
			printk("0");
	}
	return count;
}

/*
* The bitmap of _order_ is set to 1 ,now find out which of the buddies 
is 
free
* We have 2 options
* 	a. Scan all the pages of a given buddy. If any one page is allocated
* 	   then it is the allocated one. We return its buddy
* 	b. Scan the free list of that order if the buddy is in the free list
* 	   it is the free buddy else its buddy is the free one.
* order is the order where the 1 was found in the bitmap at bit_offset
* if order <= LINEAR_SCAN_THRESHOLD do 'a' else 'b'
*/
static struct page *get_free_buddy(int order,int bit_offset,struct zone 
*zone)
{
	struct page *base = zone->zone_mem_map;
	struct free_area *area = zone->free_area;
	if(order <= LINEAR_SCAN_THRESHOLD) {
		struct page *buddy1,*buddy2,*page;
		int mask= (~0)<<order,count;
		page = buddy1 = base + (bit_offset<<(order+1));
		buddy2 = base + ((bit_offset<<(order+1))^(-mask));
		count = 1<<order;
		while(count--) {
			if(page_count(page))
				return buddy2;
			else {
				if(page_free(page))
					page++;
				else
					return buddy2;
			}
		}
		return buddy1;
	} else {
		/*
                 * Find the free block using free list
		 */
	        struct list_head *ele;
		struct page *buddy1,*buddy2;
		int mask =  (~0)<<order;
		/*
	         * buddy1 and buddy2 are start pages for the two buddies
	         */
	        buddy1 = base + (bit_offset<<(order+1));
	        buddy2 = base + ((bit_offset<<(order+1))^(-mask));
		list_for_each(ele,&area[order].free_list) {
			struct page *page = list_entry(ele,struct page,list);
			if(buddy1 == page)
				return buddy1;
			else if(buddy2 == page)
				return buddy2;
		}
	}
	return	NULL;
}

/*
* Split the block starting from 'free_buddy' of order _order_
* so that the 'need' is satisfied.
* "non_movable" & "movable" have to be the PRECISE indices where the 
corr.
* entries ended.
*/
static void split_block(int order,int *non_movable,int *movable,struct 
page 
*free_buddy,struct page**to_pages,struct zone *zone)
{
	int diff,diff_init,count;
	struct page *base = zone->zone_mem_map;
	struct page *temp;
	/*
	 * Delete the block from the free-list & toggle the bit.
	 * This is done to bring the higher order block to order 0
	 * Now see how many pages are needed and put the remaining blocks
	 * in the appropriate free lists.
	 */
	list_del(&free_buddy->list);
	__change_bit((free_buddy-base)>>(1+order),zone->free_area[order].map);

	/*
	 * a. 1<<order gives the total no of pages in the block of _order_
	 * b. movable- (non_movable+1)-- the need
	 * diff =  a - b  :: are the excess pages
	 * if (diff >0)
	 * 	free the access pages
	 * Now the remaining pages are added to the to_pages array
	 * The start page has the page->private member with the
	 * order in whose free_list the block was
	 */
	diff_init = diff = (1<<order)-((*movable)-(*non_movable)-1);
	while(diff>0) {
		free_allocated_page(free_buddy+(1<<order)-diff);
		diff--;
	}
	/*
	 * Find the no. of spaces in to_pages to be filled
	 */
	if(diff_init<=0)
		diff_init = (1<<order);
	else
		diff_init = (1<<order)-diff_init;

	temp = free_buddy;
	/*
	 * Store the order in free_buddy->private
	 * This variable is not used for elements in the free lists
	 * Order 0 pages are removed from their free lists only when
	 * a page in the _from_ block is copied in it.
	 * For pages brought from higher order i.e split
	 * put them back in the appropriate free lists if defrag not possible
	 */
	for(count=(*non_movable)+1;count<((*non_movable)+1+diff_init);count++) 
{
		temp->private = order;
		to_pages[count] = temp++;
	}
	*non_movable += diff_init;
}
/*
* Find 1's in higher order 'order' except forbidden 
(start+no_forbidden_bits)
* Try to get 'need' no of free pages and store page pointers in 
to_pages
*/
static int get_to_pages_higher(int order,struct zone *zone,struct page 
*start_page,int *non_movable,int *movable,struct page **to_pages,int 
no_forbidden_bits)
{
	struct page *base = zone->zone_mem_map;
	struct page *free_buddy;
	/*
	 * don't check these bits, since they represent _from_ block
	 */
	int forbidden_start = (start_page - base) >>(order + 1);
	int num_bits = zone->present_pages>>(order+1);
	int count = 0;
	while(count<num_bits) {
		if(count==forbidden_start) {
			count += no_forbidden_bits;
			continue;
		}
		if(bit_test(count,zone->free_area[order].map)) {
			/*
			 * a 1 is found, split it to get free order 0
			 * pages so as to satisfy need
			 */
			free_buddy = get_free_buddy(order,count,zone);
			split_block(order,non_movable,movable,free_buddy,to_pages,zone);
			if( (*movable)==(*non_movable)+1)
				return 0;
		}
		count++;
	}
	/*The need is returned*/
	return ((*movable) - (*non_movable) - 1);
}

/*
* Get the free pages from order 0 from where _from_ pages are to be 
dumped
* movable = allocated
* non_movable = -1;
* page->private = order for all pages selected from _order_
* Non-movable moves fill array from left and movable from the right
*/

static void get_to_pages(struct zone *zone,struct page *start_page,int 
allocated,struct page **to_pages,int *non_movable,int *movable,int 
forbidden_bits)
{
	/*
	 * This is the separate routine for scannig order-0  1's
	 */
	int num_bits = (zone->present_pages)>>1;
	int count = 0;
	struct page *base = zone->zone_mem_map;
	int forbidden_zone_start = (start_page - base)>>1;
	int mask = (~0);

	*non_movable = -1;
	*movable = allocated;

	while(count<num_bits) {
		/*
		 * Skip the forbidden zone
		 */
		if(count==forbidden_zone_start)	{
			count = count + forbidden_bits;
			continue;
		} else if(bit_test(count,zone->free_area[0].map)) {
			struct page *buddy1 = base + (count<<1);
			struct page *buddy2 = base + ((count<<1) ^ -mask);
			if(page_count(buddy1)) {
				buddy2->private = 0;
				if(movable_page(buddy1))
					to_pages[--(*movable)] = buddy2;
				else
					to_pages[++(*non_movable)] = buddy2;
			} else if(page_count(buddy2)){
				buddy1->private = 0;
				if(movable_page(buddy2))
					to_pages[--(*movable)] = buddy1;
				else
					to_pages[++(*non_movable)] = buddy1;
			}
			if( (*movable)==(*non_movable)+1)
			{
				printk("\n Alloc :%d Non_movable: %d  Movable: 
%d",allocated,(*non_movable)+1,allocated - (*movable));
				return;
			}
		}
		count++;
	}
}

/*
* Find out free pages where 'from' is to be moved
*  - allocated(no. of allocated pages) is counted and passed
*  - called with order = 0
*  - start_pages indicates start of forbidden block( 'from' block)
*  - to_pages stores free page pointers
*/

static int find_to_pages(int failed_order,struct zone *zone,struct page 
*start_page,int allocated,struct page **to_pages)
{
	int non_movable,movable;
	int need = 0,order;
	int no_forbidden_bits = 1<<(failed_order-1); //no of pages in 'from'
	/*
	 * get non-movable and movable 1's in order 0 bitmap
	 * here need = (movable - non_movable - 1)
	 * non_movable is offset where non-movable pointers end
	 */
	
get_to_pages(zone,start_page,allocated,to_pages,&non_movable,&movable,no_forbidden_bits);
	/*
	 * keep finding free pages in higher orders until the need is 
satisfied
	 * or failure order is reached
	 */
	order = 1;
	need = (movable - non_movable - 1);
	printk("\n After order 0 need = %u\n",need);
	while(need && order<failed_order) {
		printk("\n Going to Order %d for to_pages need %d",order,need);
		no_forbidden_bits>>=1;
		need = 
get_to_pages_higher(order++,zone,start_page,&non_movable,&movable,to_pages,no_forbidden_bits);
	}
	printk("\n Scanned upto order %d need = %d 
failed_order=%d",order-1,need,failed_order);

	if(!need)
		return 1;	//successful
	printk("\n NEED NOT MET !!!");
	return 0;		//failed
}

/* 
*************************************************************************
* *********************** FROM PAGES 
**************************************
* 
*************************************************************************
*/

/*
* While finding _from_ pages only the allocated pages are to be moved
* The allocated pages in the block to be moved are set in the bitmap at 
their
* corresponding offset from the start page of the block
* */
static void clear_bitmap(unsigned long *bitmap,int order)
{
	int i;
	int cnt = (1<<(MAX_ORDER-4))/sizeof(unsigned long);
	for(i=0;i<cnt;i++)
		bitmap[i] = 0;

}
/*
* The test bit of the kernel is for long and if unsigned long is to be
*/
static int bit_test(int nr,unsigned long *addr)
{
	int mask;
	addr += nr >>5;
	mask = 1<<(nr & 0x1f);
	return ((*addr & mask) != 0);
}

/*
* This is the first thing done for deframentation.
* This is the function which does the job of identifying the
* block which is to be moved to create a free block.
* (order+1) is the order whose free block is not avaialable
*/

/*
* Get the start page of the allocated block which can be moved
* Here order+1 is the _order_ of the block to create(free)
*
* Find a 1 in the bitmap of order and find out whether the allocated
* buddy is movable or not
* alloc_bitmap: is the bitmap used to specify whether the page in the
* 		 movable block is allocated(1) or free (0)
* */
static struct page * get_from_block(int order,struct zone 
*zone,unsigned 
long   *alloc_bitmap)
{
	struct page * start_page= NULL;
	unsigned long *map = zone->free_area[order].map;
	long bit_offset = 0,num_bits = zone->present_pages>>(order+1);
	for(bit_offset=0;bit_offset<num_bits;bit_offset++){
		clear_bitmap(alloc_bitmap,order+1);
		if((bit_test(bit_offset,map)==1) && (start_page = 
movable_block(bit_offset,order-1,zone,alloc_bitmap))) {
			return start_page;
		}
	}
	clear_bitmap(alloc_bitmap,order +1);
	printk("\n Entering scan mem_map pages");
	start_page = scan_mem_page(order+1,zone,alloc_bitmap);
	if(!start_page){
		printk("\n No movable block found of order %d",order+1);
		return NULL;
	}
	printk("\n End of _from_ routine :: start page %x",(unsigned 
int)start_page);
	return start_page;
}
/*
* Linearly scan the pages of a buddy given by start_page
* The buddy is of order given by order
* Finds out whether the 0 is movable in order = order
* Return value (flag):
* 0 = free
* 1 = non-movable
* 2 = don't scan next 0 of order,since this one is movable
* */
static int linear_scan_pages(struct page *page,struct page* 
start_page,int 
order,unsigned long *alloc_bitmap)
{
	int count = 1<<order,flag = 0;
	while(count--)	{
		if(page_count(page)){
			/*
			 * block is allocated
			 */
			flag = 2;
			if(movable_page(page))
				/*
				 * Set the bit corresponding to this page
				 * in alloc_bitmap
				 */
				set_bit(page-start_page,alloc_bitmap);
			else
				/*
				 * page is non-movable
				 */
				  return 1;

		}
		else {
			if(!page_free(page))
				return 1;
		}
		page++;
	}
	/*
	 * page is free/movable
	 */
	return flag;
}
/*
* bit_offset: the offset of the 1 found in (order+1) bitmap
* find out whether the 1 in order=order+1 results in a movable block
* returns the start page of the block corresponding to the 1
*/
static struct page *movable_block(long bit_offset,int order,struct zone 
*zone,unsigned long *alloc_bitmap)
{
	struct page *base = zone->zone_mem_map;
	struct free_area *area = zone->free_area;
	/*
	 * start_page is the page correspong to the first page in the
	 * buddy of the order whose shortage called above fn
	 * hence order+2 is the order which is failed
	 */
	struct page *start_page = base + (bit_offset<<(order+2));
	while(order>=0)	{
		if(bit_test(bit_offset<<1,area[order].map)==1)
			bit_offset <<= 1;
		else {
			if (bit_test((bit_offset<<1)+1,area[order].map)==1)
				bit_offset = (bit_offset<<1)+1;
			else
				break;
		}
		order--;
	}
	printk("\n Last 1 in order %u ",order+1);
	/*
	 * here (order+1) gives us the order where the last 1 was found
	 * and bit_offset gives us the offset of the last 1 in order+1
	 */
	if(order == -1)	{
		/*
		 * We are here : as a the block of order which is required
		 * is split to satisfy an order 0 allocation
		 * We now find which of the buddy is the allocated one
		 */
		struct page *buddy1,*buddy2;
		int mask = (~0);
		buddy1 = base + (bit_offset<<1);
		buddy2 = base + ((bit_offset<<1)^(-mask));

		if(page_count(buddy1)) {
			if(movable_page(buddy1)) {
				set_bit(buddy1-start_page,alloc_bitmap);
				return start_page;
			}
		} else if(page_count(buddy2)){
			if(movable_page(buddy2)) {
				set_bit(buddy2-start_page,alloc_bitmap);
				return start_page;
			}
		}
		/*
		 * The order 0 allocation is for a non-movable page
		 */
		return NULL;
	}
	/*
	 * (order+1)bitmap has 0's as its children in _order_
	 * scan the 0's of order to find the allocated & movable blocks
	 */
	if(order < LINEAR_SCAN_THRESHOLD) {
		/*
		 * bit at bit_offset in order+1 map is a 1
		 */
		struct page *buddy1,*buddy2;
		int mask;
		/*
		 * current order = order of two 0s
		 * go to order = order where 1 is found
		 */
		order++;
		mask= (~0)<<order;
		buddy1 = base + (bit_offset<<(order+1));
		switch(linear_scan_pages(buddy1,start_page,order,alloc_bitmap)) {
		case 0:
			/*
			 * scan second 0,since first one is free
			 */
			buddy2 = base + (bit_offset<<(order+1)^(-mask));
			if(linear_scan_pages(buddy2,start_page,order,alloc_bitmap)==2) {
				/*
				 * this block is movable,so return start page
				 */
				return start_page;
			} else {
				/*
				 * second 0 is non-movable,return failure
				 */
				return NULL;
			}
			break;
		case 2:	/*
			 * first 0 is movable,
			 */
			return start_page;

		case 1:
			/*
			 * first 0 is non-movable,so return failure
			 */
			return NULL;
		}
	} else {
		/*
		 * Find the free block by scanning free list of order = order+1
		 */
		struct list_head *ele;
		struct page *buddy1,*buddy2;
		int mask;
		/*
		 * current order = order of two 0s
		 * go to order = order where 1 is found
		 */
		order++;
	       	mask= (~0)<<order;
		/*
		 * buddy1 and buddy2 are start pages for the two 0's
		 */
		buddy1 = base + (bit_offset<<(order+1));
		buddy2 = base + ((bit_offset<<(order+1))^(-mask));
		list_for_each(ele,&area[order].free_list) {
			struct page *page = list_entry(ele,struct page,list);
			if(buddy1 == page) {
			/*
			 * buddy1 is free
			 */
				if(linear_scan_pages(buddy2,start_page,order,alloc_bitmap) == 1)
					return NULL;//buddy2 non-movable
				return start_page;

			}
			else if(buddy2 == page){
			/*
			 * buddy2 is free
			 */
			if(linear_scan_pages(buddy1,start_page,order,alloc_bitmap) == 1)
				return NULL;//buddy1 non-movable
			return start_page;
			}
		}
	}
	return NULL;
}


/*
* Checks if a page is really free
* All pages having page count = 0 are free EXCEPT pcp pages which are
* semi-free, they have page count 0 and are not on free lists
* Check whether the page is on hot or cold pcp lists
* If its found on the pcp lists then its treated as non-movable 
currently
*/
static int page_free(struct page *page)
{
	struct zone *zone = page_zone(page);

	struct per_cpu_pages *pcp = &zone->pageset[0].pcp[0];
	unsigned long flags;
	struct list_head *ele;
	struct page *temp;

	if(!page_count(page) && !PageCompound(page)&& !page->mapping ) {
		local_irq_save(flags);
		/*
		 * Currently the only way of finding whether a page is in
		 * pcp lists is to scan the pcp lists
		 */
		list_for_each(ele,&pcp->list){
			temp = list_entry(ele,struct page,list);
			if(temp==page) {
				local_irq_restore(flags);
				return 0;
			}
		}
		pcp = &zone->pageset[0].pcp[1];
		list_for_each(ele,&pcp->list) {
			temp = list_entry(ele,struct page,list);
			if(temp==page) {
				local_irq_restore(flags);
				return 0;
			}

		}
		local_irq_restore(flags);
		/*
		 * page is not in pcp lists and thus is free
		 */
		return 1;
	}
	return 0;
}

/*
* Linearly scan the pages in memory for movable buddies
* of order failed_order.
* The scanning is done for each of the buddies of the failed order in 
the
* memory. If all the pages of the buddy can be moved then it is 
selected
* For all the allocated pages their corresponding bit in the 
_alloc_bitmap_
* are set to identify the pages whose content are to be copied
*/
static struct page * scan_mem_page(int order,struct zone * 
zone,unsigned 
long   *alloc_bitmap)
{
	int pages_per_block = (1<<order),page_no,cnt,flag,mov_cnt;
	struct page *start_page = zone->zone_mem_map,*page_in_block;
	page_no = 0;
	mov_cnt =0;

	while(page_no<zone->present_pages) {
		page_in_block = start_page;
		cnt = 0;
		flag = 0;
		mov_cnt=0;
		while(cnt<pages_per_block &&((flag=movable_page(page_in_block)) || 
page_free(page_in_block))) {
			if(flag){
				set_bit(page_in_block-start_page,alloc_bitmap);
				mov_cnt=1;
			}
			page_in_block++;
			cnt++;
		}
		if(cnt==pages_per_block && mov_cnt)
			return start_page;
		clear_bitmap(alloc_bitmap,order);
		start_page +=pages_per_block;
		page_no = page_no + pages_per_block;
	}
	/* After the scan of buddies in the memory no movable buddy of the
	 * failed order are found
	 */
	return NULL;
}




--0-1481059508-1075783611=:47661
Content-Type: text/plain; name="AMD.h"
Content-Description: AMD.h
Content-Disposition: inline; filename="AMD.h"

#ifndef AMD_DEFRAG_H
#define AMD_DEFRAG_H

#include<linux/module.h>
#include<linux/init.h>
#include<linux/mmzone.h>
#include<linux/mm.h>
#include<asm/page.h>
#include<linux/string.h>
#include<linux/list.h>
#include<linux/preempt.h>
#include<linux/page-flags.h>
#include<asm/rmap.h>
#include<linux/slab.h>
#include<linux/vmalloc.h>
#include<linux/slab.h>
#include<asm/tlbflush.h>
#include<asm/cacheflush.h>
#include<asm/bitops.h>

#define LINEAR_SCAN_THRESHOLD ((MAX_ORDER>>1)-1)

#define FLAG_MASK 0x000fffff
#define MAX_SIZE (1<<MAX_ORDER)
#define CALL_FROM_HERE

#define ORDER 1



/*
* header for main module
* */
static int amd_init(void);
static void amd_exit(void);
static int movable_page(struct page *page);
static void update_to_ptes(struct page *to);
static void free_allocated_page(struct page *page);
static void flush_from_caches(pte_addr_t paddr);
static void update_struct_page(struct page *to,struct page *from,struct 
zone 
*zone);
static int defrag(int order,struct zone *zone);
static int traverse_free_list(int order,struct zone *zone);
static void move_page(struct page *from,struct page *to,struct zone 
*zone);
static int page_free(struct page *page);

/*
* header for to_pages
* */
static int count_alloc_pages(int order,unsigned long *alloc_bitmap);

static struct page *get_free_buddy(int order,int bit_offset,struct zone 
*zone);

static void split_block(int order,int *non_movable,int *movable,struct 
page 
*free_buddy,struct page**to_pages,struct zone *zone);

static int get_to_pages_higher(int order,struct zone *zone,struct page 
*start_page,int *non_movable,int *movable,struct page **to_pages,int 
no_forbidden_bits);

static void get_to_pages(struct zone *zone,struct page *start_page,int 
allocated,struct page **to_pages,int *non_movable,int *movable,int 
forbidden_bits);

static int find_to_pages(int failed_order,struct zone *zone,struct page 
*start_page,int allocated,struct page **to_pages);

/*
* header for from_pages
* */
static struct page *get_from_block(int order,struct zone *zone,unsigned 
long 
*alloc_bitmap);

static int linear_scan_pages(struct page *page,struct page* 
start_page,int 
order,unsigned long *alloc_bitmap);

static struct page *movable_block(long bit_offset,int order,struct zone 
*zone,unsigned long *alloc_bitmap);

static struct page *scan_mem_page(int order,struct zone * zone,unsigned 
long 
*alloc_bitmap);

static void clear_bitmap(unsigned long *bitmap,int order);

static int bit_test(int nr,unsigned long *addr);

#endif



--0-1481059508-1075783611=:47661--
