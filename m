Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135635AbREGNEv>; Mon, 7 May 2001 09:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135749AbREGNEm>; Mon, 7 May 2001 09:04:42 -0400
Received: from adsl-64-123-58-70.dsl.stlsmo.swbell.net ([64.123.58.70]:43504
	"EHLO bigandy.swbell.net") by vger.kernel.org with ESMTP
	id <S135635AbREGNEY>; Mon, 7 May 2001 09:04:24 -0400
Date: Mon, 7 May 2001 08:04:16 -0500 (CDT)
From: Andy Carlson <naclos@swbell.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.4-ac5 aic7xxx causes hang on my machine
In-Reply-To: <m3y9s9nxcf.fsf@linux.local>
Message-ID: <Pine.LNX.4.20.0105070800360.142-200000@bigandy>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="659714-819097769-989240656=:142"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--659714-819097769-989240656=:142
Content-Type: TEXT/PLAIN; charset=US-ASCII

I have a dual ppro 200MHZ W6LI motherboard.  I put 2.4.4-ac5 on last
night, and the machine hung at Freeing unused Kernel memory.  I
selectively backed off what I thought were relevant patches.  I got to
aic7xxx, and ac5 without it worked. I attached /proc/scsi/aic7xxx/0.

Andy Carlson                           |\      _,,,---,,_
naclos@swbell.net                ZZZzz /,`.-'`'    -.  ;-;;,_
BJC Health System                     |,4-  ) )-,_. ,\ (  `'-'
St. Louis, Missouri                  '---''(_/--'  `-'\_)
Cat Pics: http://andyc.dyndns.org

On Mon, 7 May 2001, Christoph Rohland wrote:

> Hi,
> 
> The appended patch does it's own accounting of shmem pages and adjust
> the page cache size to take these into account. So now again you will
> see shmem pages as used in top/vmstat etc. This confused a lot of
> people.
> 
> There is a uncertainty in the calculations since the vm may drop pages
> behind shmem and the number of shmem pages is estimated too high. This
> especially happens on truncate because first the page cache is reduced
> and later the shmem readjusts it's count.
> 
> To prevent negative cache sizes the adjustment is only done if
> shmem_nrpages > page_cache_size.
> 
> The latter part of the patch (all the init.c files) also exports the
> shmem page number to the shared memory field in meminfo. This means a
> change in semantics of this field but apparently a lot of people
> interpret this field exactly this way and it was not used any more
> 
> The patches are on top of my encapsulation patch.
> 
> Greetings
> 		Christoph
> 
> diff -uNr 2.4.4-mSsu/fs/proc/proc_misc.c 2.4.4-mSsua/fs/proc/proc_misc.c
> --- 2.4.4-mSsu/fs/proc/proc_misc.c	Sun Apr 29 20:32:52 2001
> +++ 2.4.4-mSsua/fs/proc/proc_misc.c	Mon May  7 13:38:53 2001
> @@ -140,6 +140,17 @@
>  {
>  	struct sysinfo i;
>  	int len;
> +	unsigned int cached, shmem;
> +
> +	/*
> +	 * There may be some inconsistency because shmem_nrpages
> +	 * update is delayed to page_cache_size
> +	 * We make sure the cached value does not get below zero 
> +	 */
> +	cached = atomic_read(&page_cache_size);
> +	shmem  = atomic_read(&shmem_nrpages);
> +	if (shmem < cached)
> +		cached -= shmem;
>  
>  /*
>   * display in kilobytes.
> @@ -153,8 +164,8 @@
>                  "Swap: %8lu %8lu %8lu\n",
>                  B(i.totalram), B(i.totalram-i.freeram), B(i.freeram),
>                  B(i.sharedram), B(i.bufferram),
> -                B(atomic_read(&page_cache_size)), B(i.totalswap),
> -                B(i.totalswap-i.freeswap), B(i.freeswap));
> +		B(cached), B(i.totalswap),
> +		B(i.totalswap-i.freeswap), B(i.freeswap));
>          /*
>           * Tagged format, for easy grepping and expansion.
>           * The above will go away eventually, once the tools
> @@ -180,7 +191,7 @@
>                  K(i.freeram),
>                  K(i.sharedram),
>                  K(i.bufferram),
> -                K(atomic_read(&page_cache_size)),
> +		K(cached),
>  		K(nr_active_pages),
>  		K(nr_inactive_dirty_pages),
>  		K(nr_inactive_clean_pages()),
> diff -uNr 2.4.4-mSsu/include/linux/shmem_fs.h 2.4.4-mSsua/include/linux/shmem_fs.h
> --- 2.4.4-mSsu/include/linux/shmem_fs.h	Wed May  2 18:36:05 2001
> +++ 2.4.4-mSsua/include/linux/shmem_fs.h	Mon May  7 12:52:00 2001
> @@ -17,6 +17,8 @@
>  	unsigned long val;
>  } swp_entry_t;
>  
> +extern atomic_t shmem_nrpages;
> +
>  struct shmem_inode_info {
>  	spinlock_t		lock;
>  	struct semaphore 	sem;
> diff -uNr 2.4.4-mSsu/mm/mmap.c 2.4.4-mSsua/mm/mmap.c
> --- 2.4.4-mSsu/mm/mmap.c	Sun Apr 29 20:33:01 2001
> +++ 2.4.4-mSsua/mm/mmap.c	Mon May  7 13:42:03 2001
> @@ -55,13 +55,24 @@
>  	 */
>  
>  	long free;
> -	
> +	unsigned long cached, shmem;
> +
> +	/*
> +	 * There may be some inconsistency because shmem_nrpages
> +	 * update is delayed to the page_cache_size
> +	 * We make sure the cached value does not get below zero 
> +	 */
> +	cached = atomic_read(&page_cache_size);
> +	shmem  = atomic_read(&shmem_nrpages);
> +	if (cached > shmem)
> +		cached -= shmem;
> +
>          /* Sometimes we want to use more memory than we have. */
>  	if (sysctl_overcommit_memory)
>  	    return 1;
>  
>  	free = atomic_read(&buffermem_pages);
> -	free += atomic_read(&page_cache_size);
> +	free += cached;
>  	free += nr_free_pages();
>  	free += nr_swap_pages;
>  
> diff -uNr 2.4.4-mSsu/mm/shmem.c 2.4.4-mSsua/mm/shmem.c
> --- 2.4.4-mSsu/mm/shmem.c	Fri May  4 21:37:34 2001
> +++ 2.4.4-mSsua/mm/shmem.c	Mon May  7 11:13:27 2001
> @@ -3,7 +3,8 @@
>   *
>   * Copyright (C) 2000 Linus Torvalds.
>   *		 2000 Transmeta Corp.
> - *		 2000 Christoph Rohland
> + *		 2000-2001 Christoph Rohland
> + *		 2000-2001 SAP AG
>   * 
>   * This file is released under the GPL.
>   */
> @@ -45,6 +46,7 @@
>  
>  LIST_HEAD (shmem_inodes);
>  static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
> +atomic_t shmem_nrpages = ATOMIC_INIT(0);
>  
>  #define BLOCKS_PER_PAGE (PAGE_SIZE/512)
>  
> @@ -52,6 +54,7 @@
>   * shmem_recalc_inode - recalculate the size of an inode
>   *
>   * @inode: inode to recalc
> + * @swap:  additional swap pages freed externally
>   *
>   * We have to calculate the free blocks since the mm can drop pages
>   * behind our back
> @@ -62,12 +65,14 @@
>   *
>   * So the mm freed 
>   * inodes->i_blocks/BLOCKS_PER_PAGE - 
> - *			(inode->i_mapping->nrpages + info->swapped)
> + * 			(inode->i_mapping->nrpages + info->swapped)
>   *
>   * It has to be called with the spinlock held.
> + *
> + * The swap parameter is a performance hack for truncate.
>   */
>  
> -static void shmem_recalc_inode(struct inode * inode)
> +static void shmem_recalc_inode(struct inode * inode, unsigned long swap)
>  {
>  	unsigned long freed;
>  
> @@ -79,6 +84,7 @@
>  		spin_lock (&info->stat_lock);
>  		info->free_blocks += freed;
>  		spin_unlock (&info->stat_lock);
> +		atomic_sub(freed-swap, &shmem_nrpages);
>  	}
>  }
>  
> @@ -195,7 +201,7 @@
>  out:
>  	info->max_index = index;
>  	info->swapped -= freed;
> -	shmem_recalc_inode(inode);
> +	shmem_recalc_inode(inode, freed);
>  	spin_unlock (&info->lock);
>  	up(&info->sem);
>  }
> @@ -250,14 +256,15 @@
>  	entry = shmem_swp_entry(info, page->index);
>  	if (IS_ERR(entry))	/* this had been allocted on page allocation */
>  		BUG();
> -	shmem_recalc_inode(page->mapping->host);
> +	shmem_recalc_inode(page->mapping->host, 0);
>  	error = -EAGAIN;
>  	if (entry->val)
>  		BUG();
>  
>  	*entry = swap;
>  	error = 0;
> -	/* Remove the from the page cache */
> +	/* Remove the page from the page cache */
> +	atomic_dec(&shmem_nrpages);
>  	lru_cache_del(page);
>  	remove_inode_page(page);
>  
> @@ -376,6 +383,7 @@
>  	}
>  
>  	/* We have the page */
> +	atomic_inc(&shmem_nrpages);
>  	SetPageUptodate(page);
>  	if (info->locked)
>  		page_cache_get(page);
> @@ -1275,6 +1283,7 @@
>  	return 0;
>  found:
>  	add_to_page_cache(page, info->inode->i_mapping, offset + idx);
> +	atomic_inc(&shmem_nrpages);
>  	set_page_dirty(page);
>  	SetPageUptodate(page);
>  	UnlockPage(page);
> diff -uNr 2.4.4-mSsu/arch/alpha/mm/init.c c/arch/alpha/mm/init.c
> --- 2.4.4-mSsu/arch/alpha/mm/init.c	Sun Apr 29 20:31:56 2001
> +++ c/arch/alpha/mm/init.c	Sun May  6 21:47:25 2001
> @@ -402,7 +402,7 @@
>  si_meminfo(struct sysinfo *val)
>  {
>  	val->totalram = totalram_pages;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  	val->totalhigh = 0;
> diff -uNr 2.4.4-mSsu/arch/arm/mm/init.c c/arch/arm/mm/init.c
> --- 2.4.4-mSsu/arch/arm/mm/init.c	Sun Apr 29 20:31:56 2001
> +++ c/arch/arm/mm/init.c	Sun May  6 21:47:01 2001
> @@ -647,7 +647,7 @@
>  void si_meminfo(struct sysinfo *val)
>  {
>  	val->totalram  = totalram_pages;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram   = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  	val->totalhigh = 0;
> diff -uNr 2.4.4-mSsu/arch/cris/mm/init.c c/arch/cris/mm/init.c
> --- 2.4.4-mSsu/arch/cris/mm/init.c	Sun Apr 29 20:31:57 2001
> +++ c/arch/cris/mm/init.c	Sun May  6 21:47:03 2001
> @@ -503,7 +503,7 @@
>  
>  	i = max_mapnr;
>  	val->totalram = 0;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  	while (i-- > 0)  {
> diff -uNr 2.4.4-mSsu/arch/i386/mm/init.c c/arch/i386/mm/init.c
> --- 2.4.4-mSsu/arch/i386/mm/init.c	Sun Apr 29 20:32:08 2001
> +++ c/arch/i386/mm/init.c	Sun May  6 20:24:21 2001
> @@ -570,7 +570,7 @@
>  void si_meminfo(struct sysinfo *val)
>  {
>  	val->totalram = totalram_pages;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  	val->totalhigh = totalhigh_pages;
> diff -uNr 2.4.4-mSsu/arch/ia64/mm/init.c c/arch/ia64/mm/init.c
> --- 2.4.4-mSsu/arch/ia64/mm/init.c	Sun Apr 29 20:32:11 2001
> +++ c/arch/ia64/mm/init.c	Sun May  6 21:47:05 2001
> @@ -151,7 +151,7 @@
>  si_meminfo (struct sysinfo *val)
>  {
>  	val->totalram = totalram_pages;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  	val->totalhigh = 0;
> diff -uNr 2.4.4-mSsu/arch/m68k/mm/init.c c/arch/m68k/mm/init.c
> --- 2.4.4-mSsu/arch/m68k/mm/init.c	Sat Nov  4 18:11:22 2000
> +++ c/arch/m68k/mm/init.c	Sun May  6 21:47:45 2001
> @@ -217,7 +217,7 @@
>  
>      i = max_mapnr;
>      val->totalram = totalram_pages;
> -    val->sharedram = 0;
> +    val->sharedram = atomic_read(&shmem_nrpages);
>      val->freeram = nr_free_pages();
>      val->bufferram = atomic_read(&buffermem_pages);
>      while (i-- > 0) {
> diff -uNr 2.4.4-mSsu/arch/mips/mm/init.c c/arch/mips/mm/init.c
> --- 2.4.4-mSsu/arch/mips/mm/init.c	Sat Nov  4 18:11:22 2000
> +++ c/arch/mips/mm/init.c	Sun May  6 21:47:01 2001
> @@ -343,7 +343,7 @@
>  void si_meminfo(struct sysinfo *val)
>  {
>  	val->totalram = totalram_pages;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  	val->totalhigh = 0;
> diff -uNr 2.4.4-mSsu/arch/mips64/mm/init.c c/arch/mips64/mm/init.c
> --- 2.4.4-mSsu/arch/mips64/mm/init.c	Sat Nov  4 18:11:22 2000
> +++ c/arch/mips64/mm/init.c	Sun May  6 21:47:04 2001
> @@ -411,7 +411,7 @@
>  si_meminfo(struct sysinfo *val)
>  {
>  	val->totalram = totalram_pages;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  	val->totalhigh = 0;
> diff -uNr 2.4.4-mSsu/arch/parisc/mm/init.c c/arch/parisc/mm/init.c
> --- 2.4.4-mSsu/arch/parisc/mm/init.c	Sun Dec 17 12:53:55 2000
> +++ c/arch/parisc/mm/init.c	Sun May  6 21:47:02 2001
> @@ -458,7 +458,7 @@
>  
>  	i = max_mapnr;
>  	val->totalram = totalram_pages;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  #if 0
> diff -uNr 2.4.4-mSsu/arch/ppc/mm/init.c c/arch/ppc/mm/init.c
> --- 2.4.4-mSsu/arch/ppc/mm/init.c	Wed Apr 11 12:36:13 2001
> +++ c/arch/ppc/mm/init.c	Sun May  6 21:47:05 2001
> @@ -336,7 +336,7 @@
>  
>  	i = max_mapnr;
>  	val->totalram = 0;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  	while (i-- > 0)  {
> diff -uNr 2.4.4-mSsu/arch/s390/mm/init.c c/arch/s390/mm/init.c
> --- 2.4.4-mSsu/arch/s390/mm/init.c	Sun Apr 29 20:32:21 2001
> +++ c/arch/s390/mm/init.c	Sun May  6 21:47:03 2001
> @@ -271,7 +271,7 @@
>  void si_meminfo(struct sysinfo *val)
>  {
>  	val->totalram = totalram_pages;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  	val->totalhigh = 0;
> diff -uNr 2.4.4-mSsu/arch/s390x/mm/init.c c/arch/s390x/mm/init.c
> --- 2.4.4-mSsu/arch/s390x/mm/init.c	Sun Apr 29 20:32:22 2001
> +++ c/arch/s390x/mm/init.c	Sun May  6 21:47:18 2001
> @@ -284,7 +284,7 @@
>  void si_meminfo(struct sysinfo *val)
>  {
>          val->totalram = totalram_pages;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  	val->totalhigh = 0;
> diff -uNr 2.4.4-mSsu/arch/sh/mm/init.c c/arch/sh/mm/init.c
> --- 2.4.4-mSsu/arch/sh/mm/init.c	Sun Apr 29 20:32:23 2001
> +++ c/arch/sh/mm/init.c	Sun May  6 21:47:26 2001
> @@ -215,7 +215,7 @@
>  void si_meminfo(struct sysinfo *val)
>  {
>  	val->totalram = totalram_pages;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  	val->totalhigh = totalhigh_pages;
> diff -uNr 2.4.4-mSsu/arch/sparc/mm/init.c c/arch/sparc/mm/init.c
> --- 2.4.4-mSsu/arch/sparc/mm/init.c	Sun Apr 29 20:32:23 2001
> +++ c/arch/sparc/mm/init.c	Sun May  6 21:47:04 2001
> @@ -534,7 +534,7 @@
>  void si_meminfo(struct sysinfo *val)
>  {
>  	val->totalram = totalram_pages;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  	val->totalhigh = totalhigh_pages;
> diff -uNr 2.4.4-mSsu/arch/sparc64/mm/init.c c/arch/sparc64/mm/init.c
> --- 2.4.4-mSsu/arch/sparc64/mm/init.c	Sun Apr 29 20:32:25 2001
> +++ c/arch/sparc64/mm/init.c	Sun May  6 21:47:02 2001
> @@ -1512,7 +1512,7 @@
>  void si_meminfo(struct sysinfo *val)
>  {
>  	val->totalram = num_physpages;
> -	val->sharedram = 0;
> +	val->sharedram = atomic_read(&shmem_nrpages);
>  	val->freeram = nr_free_pages();
>  	val->bufferram = atomic_read(&buffermem_pages);
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--659714-819097769-989240656=:142
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=aic7xxx
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.20.0105070804160.142@bigandy>
Content-Description: 
Content-Disposition: attachment; filename=aic7xxx

QWRhcHRlYyBBSUM3eHh4IGRyaXZlciB2ZXJzaW9uOiA2LjEuMTENCmFpYzc4
ODA6IFdpZGUgQ2hhbm5lbCBBLCBTQ1NJIElkPTcsIDE2LzI1NSBTQ0JzDQpD
aGFubmVsIEEgVGFyZ2V0IDAgTmVnb3RpYXRpb24gU2V0dGluZ3MNCglVc2Vy
OiA0MC4wMDBNQi9zIHRyYW5zZmVycyAoMjAuMDAwTUh6LCBvZmZzZXQgMjU1
LCAxNmJpdCkNCglHb2FsOiAxMC4wMDBNQi9zIHRyYW5zZmVycyAoMTAuMDAw
TUh6LCBvZmZzZXQgMTUpDQoJQ3VycjogMTAuMDAwTUIvcyB0cmFuc2ZlcnMg
KDEwLjAwME1Ieiwgb2Zmc2V0IDE1KQ0KCUNoYW5uZWwgQSBUYXJnZXQgMCBM
dW4gMCBTZXR0aW5ncw0KCQlDb21tYW5kcyBRdWV1ZWQgMw0KCQlDb21tYW5k
cyBBY3RpdmUgMA0KCQlDb21tYW5kIE9wZW5pbmdzIDENCgkJTWF4IFRhZ2dl
ZCBPcGVuaW5ncyAwDQoJCURldmljZSBRdWV1ZSBGcm96ZW4gQ291bnQgMA0K
Q2hhbm5lbCBBIFRhcmdldCAxIE5lZ290aWF0aW9uIFNldHRpbmdzDQoJVXNl
cjogNDAuMDAwTUIvcyB0cmFuc2ZlcnMgKDIwLjAwME1Ieiwgb2Zmc2V0IDI1
NSwgMTZiaXQpDQoJR29hbDogMjAuMDAwTUIvcyB0cmFuc2ZlcnMgKDEwLjAw
ME1Ieiwgb2Zmc2V0IDgsIDE2Yml0KQ0KCUN1cnI6IDIwLjAwME1CL3MgdHJh
bnNmZXJzICgxMC4wMDBNSHosIG9mZnNldCA4LCAxNmJpdCkNCglDaGFubmVs
IEEgVGFyZ2V0IDEgTHVuIDAgU2V0dGluZ3MNCgkJQ29tbWFuZHMgUXVldWVk
IDE1Mw0KCQlDb21tYW5kcyBBY3RpdmUgMA0KCQlDb21tYW5kIE9wZW5pbmdz
IDI1Mw0KCQlNYXggVGFnZ2VkIE9wZW5pbmdzIDI1Mw0KCQlEZXZpY2UgUXVl
dWUgRnJvemVuIENvdW50IDANCkNoYW5uZWwgQSBUYXJnZXQgMiBOZWdvdGlh
dGlvbiBTZXR0aW5ncw0KCVVzZXI6IDQwLjAwME1CL3MgdHJhbnNmZXJzICgy
MC4wMDBNSHosIG9mZnNldCAyNTUsIDE2Yml0KQ0KCUdvYWw6IDIwLjAwME1C
L3MgdHJhbnNmZXJzICgxMC4wMDBNSHosIG9mZnNldCA4LCAxNmJpdCkNCglD
dXJyOiAyMC4wMDBNQi9zIHRyYW5zZmVycyAoMTAuMDAwTUh6LCBvZmZzZXQg
OCwgMTZiaXQpDQoJQ2hhbm5lbCBBIFRhcmdldCAyIEx1biAwIFNldHRpbmdz
DQoJCUNvbW1hbmRzIFF1ZXVlZCAxNDg2DQoJCUNvbW1hbmRzIEFjdGl2ZSAw
DQoJCUNvbW1hbmQgT3BlbmluZ3MgMjUzDQoJCU1heCBUYWdnZWQgT3Blbmlu
Z3MgMjUzDQoJCURldmljZSBRdWV1ZSBGcm96ZW4gQ291bnQgMA0KQ2hhbm5l
bCBBIFRhcmdldCAzIE5lZ290aWF0aW9uIFNldHRpbmdzDQoJVXNlcjogNDAu
MDAwTUIvcyB0cmFuc2ZlcnMgKDIwLjAwME1Ieiwgb2Zmc2V0IDI1NSwgMTZi
aXQpDQpDaGFubmVsIEEgVGFyZ2V0IDQgTmVnb3RpYXRpb24gU2V0dGluZ3MN
CglVc2VyOiA0MC4wMDBNQi9zIHRyYW5zZmVycyAoMjAuMDAwTUh6LCBvZmZz
ZXQgMjU1LCAxNmJpdCkNCkNoYW5uZWwgQSBUYXJnZXQgNSBOZWdvdGlhdGlv
biBTZXR0aW5ncw0KCVVzZXI6IDQwLjAwME1CL3MgdHJhbnNmZXJzICgyMC4w
MDBNSHosIG9mZnNldCAyNTUsIDE2Yml0KQ0KQ2hhbm5lbCBBIFRhcmdldCA2
IE5lZ290aWF0aW9uIFNldHRpbmdzDQoJVXNlcjogNDAuMDAwTUIvcyB0cmFu
c2ZlcnMgKDIwLjAwME1Ieiwgb2Zmc2V0IDI1NSwgMTZiaXQpDQpDaGFubmVs
IEEgVGFyZ2V0IDcgTmVnb3RpYXRpb24gU2V0dGluZ3MNCglVc2VyOiA0MC4w
MDBNQi9zIHRyYW5zZmVycyAoMjAuMDAwTUh6LCBvZmZzZXQgMjU1LCAxNmJp
dCkNCkNoYW5uZWwgQSBUYXJnZXQgOCBOZWdvdGlhdGlvbiBTZXR0aW5ncw0K
CVVzZXI6IDQwLjAwME1CL3MgdHJhbnNmZXJzICgyMC4wMDBNSHosIG9mZnNl
dCAyNTUsIDE2Yml0KQ0KQ2hhbm5lbCBBIFRhcmdldCA5IE5lZ290aWF0aW9u
IFNldHRpbmdzDQoJVXNlcjogNDAuMDAwTUIvcyB0cmFuc2ZlcnMgKDIwLjAw
ME1Ieiwgb2Zmc2V0IDI1NSwgMTZiaXQpDQpDaGFubmVsIEEgVGFyZ2V0IDEw
IE5lZ290aWF0aW9uIFNldHRpbmdzDQoJVXNlcjogNDAuMDAwTUIvcyB0cmFu
c2ZlcnMgKDIwLjAwME1Ieiwgb2Zmc2V0IDI1NSwgMTZiaXQpDQpDaGFubmVs
IEEgVGFyZ2V0IDExIE5lZ290aWF0aW9uIFNldHRpbmdzDQoJVXNlcjogNDAu
MDAwTUIvcyB0cmFuc2ZlcnMgKDIwLjAwME1Ieiwgb2Zmc2V0IDI1NSwgMTZi
aXQpDQpDaGFubmVsIEEgVGFyZ2V0IDEyIE5lZ290aWF0aW9uIFNldHRpbmdz
DQoJVXNlcjogNDAuMDAwTUIvcyB0cmFuc2ZlcnMgKDIwLjAwME1Ieiwgb2Zm
c2V0IDI1NSwgMTZiaXQpDQpDaGFubmVsIEEgVGFyZ2V0IDEzIE5lZ290aWF0
aW9uIFNldHRpbmdzDQoJVXNlcjogNDAuMDAwTUIvcyB0cmFuc2ZlcnMgKDIw
LjAwME1Ieiwgb2Zmc2V0IDI1NSwgMTZiaXQpDQpDaGFubmVsIEEgVGFyZ2V0
IDE0IE5lZ290aWF0aW9uIFNldHRpbmdzDQoJVXNlcjogNDAuMDAwTUIvcyB0
cmFuc2ZlcnMgKDIwLjAwME1Ieiwgb2Zmc2V0IDI1NSwgMTZiaXQpDQpDaGFu
bmVsIEEgVGFyZ2V0IDE1IE5lZ290aWF0aW9uIFNldHRpbmdzDQoJVXNlcjog
NDAuMDAwTUIvcyB0cmFuc2ZlcnMgKDIwLjAwME1Ieiwgb2Zmc2V0IDI1NSwg
MTZiaXQpDQo=
--659714-819097769-989240656=:142--
