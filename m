Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSH3W5K>; Fri, 30 Aug 2002 18:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSH3W5K>; Fri, 30 Aug 2002 18:57:10 -0400
Received: from dsl-213-023-022-192.arcor-ip.net ([213.23.22.192]:54746 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314634AbSH3W5D>;
	Fri, 30 Aug 2002 18:57:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [RFC] [PATCH] Include LRU in page count
Date: Sat, 31 Aug 2002 01:03:07 +0200
X-Mailer: KMail [version 1.3.2]
References: <3D644C70.6D100EA5@zip.com.au> <3D6989F7.9ED1948A@zip.com.au> <akdq8h$fqn$1@penguin.transmeta.com>
In-Reply-To: <akdq8h$fqn$1@penguin.transmeta.com>
Cc: linux-kernel@vger.kernel.org, Christian Ehrhardt <ulcae@in-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17kunE-0003IO-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The executive summary is 'Houston, we have a bug'.  The long version of this 
is that all current linux kernels are now thought to suffer from a rarely 
occurring page double-free bug that results from a race between shrink_cache
and page_cache_release, where both attempt to free a page from the lru at
the same time.

Andrew's succinct description of the race is:

        if (put_page_testzero(page)) {
                /* window here */
                lru_cache_del(page);
                __free_pages_ok(page, 0);
        }

versus:

        spin_lock(lru lock);
        page = list_entry(lru, ...);
        if (page_count(page) == 0)
                continue;
        /* window here */
        page_cache_get(page);
        page_cache_release(page);       /* double-free */

This rare race happened to become not so rare in 2.5 recently, and was 
analyzed by Christian Ehrhardt, who also proposed a solution based on a new 
approach to locking, essentially put_page_testone.  We went on to check 2.4 
for the race, and while it's quite difficult to prove the race exists there, 
after a year or two of plugging holes, it's even more difficult to prove it's 
not there.  In fact, sifting through recent kernel archives turns up 
unexplained bug reports which fit the description of this race, for example:

   http://marc.theaimsgroup.com/?l=linux-xfs&m=103055330831850&w=2
   (2.4.18-xfs (xfs related?) oops report)

I proposed an alternate solution using the traditional put_page_testzero 
primitive, which relies on assigning a page count of one for membership on 
the lru list.  A slightly racy heuristic is used for efficient lru list 
removal.  The resulting incarnation of lru_cache_release is:

static inline void page_cache_release(struct page *page)
{
	if (page_count(page) == 2 && spin_trylock(&pagemap_lru_lock)) {
		if (PageLRU(page) && page_count(page) == 2)
			__lru_cache_del(page);
		spin_unlock(&pagemap_lru_lock);
	}
	put_page(page);
}

which permits the following benign race, starting with page count of 3:

	if (page_count(page) == 2 /* false */
						if (page_count(page) == 2 /* false */
	put_page(page);
						put_page(page);

Neither holder of a page reference sees the count at 2, and so the page
is left on the lru with count = 1.  This won't happen often (I haven't seen 
it happen yet) and such pages will be recovered from the cold end of the list 
in due course.  There are a number of other variations of this race, but they
all have the same effect and are all rare.

The important question is: can this code ever remove a page from the lru
erroneously, leaving somebody holding a reference to a non-lru page?  In
other words, can the test PageLRU(page) && page_count(page) == 2 return a 
false positive?  Well, when this test is true we can account for both
both references: the one we own, and the one the lru list owns.  Since
we hold the lru lock, the latter won't change.  Nobody else has the right to 
increment the page count, since they must inherit that right from somebody 
who holds a reference, and there are none.

The spin_trylock is efficient - no contention ever, just some cache 
pingponging at worst - and permits page_cache_release to be used even by a 
process that holds the lru lock.

The attached patch against 2.4.19 implements these ideas, along with some 
proc statistics to help verify that the intended effect is being achieved. 
The patch supports both Marcelo's current design (hopefully with no semantic 
changes at all) and the new lru counting strategy, selected by setting the 
LRU_PLUS_CACHE to one to get the existing strategy or two to get the new one. 

With the patch, there remain only three instances of __lru_cache_del: the one 
in page_cache_release, the one in shrink_cache and the one in truncate. The 
latter looks suspicious since it's not clear why anonymous pages can't be 
allowed to appear on the lru.  However, that is not the focus of the current 
effort.  The atomic tests for lru membership appear to be obsoleted by the 
new regimen, since we are protected in every case by the lru lock, but I did
not disturb them.

Due to laziness, the correctness of the swapcache logic in swapfile.c has not 
yet been verified.  I've done some light testing on my 2GB 2X1Ghz PIII box, 
using the following pair of scripts inherited from akpm:

file: doitlots
-----------------------
#!/bin/sh

doit()
{
        ( cat $1 | wc -l )
}
        
count=0
        
while [ $count != 500 ]
do
        doit doitlots > /dev/null

        count=$(expr $count + 1)
done
echo done
-----------------------

file: forklots
-----------------------
echo >foocount
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &

count=0

while [ $count != 10 ]
do
	count=$(wc foocount | cut -b -8)
done
-----------------------

The patch computes the following statistics and makes them available via 
/proc/mmstats:

   page_cache_release          ... Total calls to page_cache_release
   page_cache_release_test_lru ... How often the lru heuristic triggers
   page_cache_release_del_lru  ... How often the heuristic is correct
   shrink_cache_del_lru        ... How often an orphan is left on the lru
   put_page_testzero           ... Total page releases
   lru_cache_del               ... Total lru deletes	
   truncate_lru_cache_del      ... Total lru deletes during truncate

Now the benchmark results...

LRU_PLUS_CACHE = 2, with LRU_DEL_HEURISTIC:

   time sh forklots
   24.81user 28.15system 0:26.50elapsed 199%CPU

   cat /proc/mmstats
   page_cache_release 8555807
   page_cache_release_test_lru 771550
   page_cache_release_del_lru 771535
   shrink_cache_del_lru 0
   put_page_testzero 9209139
   lru_cache_del 771547
   truncate_lru_cache_del 12

According to the statistics, we took the lru lock to see if the page is 
really on the lru about 9% of the time.  In just .002% (15) of those cases 
the heuristic was wrong, the lock was taken and no page removed from the lru. 
No orphan pages were ever found on the lru.  In this case, all the 
lru_cache_dels are accounted for by the 771,535 that were removed via the 
page_cache_release heuristic, and the 12 that were converted to anonymous 
pages via truncate.

LRU_PLUS_CACHE = 2, without LRU_DEL_HEURISTIC:

   time sh forklots
   25.45user 28.70system 0:27.28elapsed 198%CPU

   cat /proc/mmstats
   page_cache_release 8611106
   page_cache_release_test_lru 0
   page_cache_release_del_lru 0
   shrink_cache_del_lru 614573
   put_page_testzero 9832924
   lru_cache_del 11
   truncate_lru_cache_del 11

Omitting the heuristic forces shrink_cache to pick up the orphaned lru pages, 
which costs about 3% in terms of wall clock time on this test.  At least this 
exercises the orphan recovery path in shrink_cache.

LRU_PLUS_CACHE = 2, with LRU_DEL_HEURISTIC, no statistics:

   time sh forklots
   24.74user 28.02system 0:26.39elapsed 199%CPU

The statistics cost about .5%, which is basically noise.

Vanilla 2.4.19:

   time sh forklots
   24.15user 28.44system 0:26.31elapsed 199%CPU

Vanilla 2.4.19 may or may not have an advantage of .3%.  On the other hand, 
removing the atomic test for lru membership probably gives a slight advantage 
to the new version.

The patch is against 2.4.19, apply with patch -p1:

--- 2.4.19.clean/fs/proc/proc_misc.c	Fri Aug  2 20:39:45 2002
+++ 2.4.19/fs/proc/proc_misc.c	Fri Aug 30 21:32:20 2002
@@ -539,6 +539,28 @@
 		entry->proc_fops = f;
 }
 
+struct mmstats mmstats;
+
+char *mmnames[] = {
+	"page_cache_release",
+	"page_cache_release_test_lru",
+	"page_cache_release_del_lru",
+	"shrink_cache_del_lru",
+	"put_page_testzero",
+	"lru_cache_del",
+	"truncate_lru_cache_del",
+	NULL,
+};
+
+static int read_mmstats(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	char **names = mmnames;
+	unsigned *stats = (unsigned *) &mmstats, len = 0;
+	for (; *names; *names++, *stats++) if (strlen(*names)) 
+		len += sprintf(page + len, "%s %u\n", *names, *stats);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
 void __init proc_misc_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -546,6 +568,7 @@
 		char *name;
 		int (*read_proc)(char*,char**,off_t,int,int*,void*);
 	} *p, simple_ones[] = {
+		{"mmstats",     read_mmstats},
 		{"loadavg",     loadavg_read_proc},
 		{"uptime",	uptime_read_proc},
 		{"meminfo",	meminfo_read_proc},
--- 2.4.19.clean/include/linux/mm.h	Fri Aug  2 20:39:45 2002
+++ 2.4.19/include/linux/mm.h	Fri Aug 30 21:41:54 2002
@@ -35,6 +35,20 @@
  * mmap() functions).
  */
 
+extern struct mmstats {
+	unsigned release;
+	unsigned release_test_page;
+	unsigned release_free_page;
+	unsigned vmscan_free_page;
+	unsigned testzero;
+	unsigned lru_cache_del;
+	unsigned truncate_lru_cache_del;
+} mmstats;
+
+extern char *mmnames[];
+
+#define mmstat(field) mmstats.field++
+
 /*
  * This struct defines a memory VMM memory area. There is one of these
  * per VM-area/task.  A VM area is any part of the process virtual memory
@@ -180,6 +194,15 @@
 } mem_map_t;
 
 /*
+ * There is only one 'core' page-freeing function.
+ */
+extern void FASTCALL(__free_pages(struct page *page, unsigned int order));
+extern void FASTCALL(free_pages(unsigned long addr, unsigned int order));
+
+#define __free_page(page) __free_pages((page), 0)
+#define free_page(addr) free_pages((addr),0)
+
+/*
  * Methods to modify the page usage count.
  *
  * What counts for a page usage:
@@ -191,12 +214,34 @@
  * Also, many kernel routines increase the page count before a critical
  * routine so they can be sure the page doesn't go away from under them.
  */
-#define get_page(p)		atomic_inc(&(p)->count)
-#define put_page(p)		__free_page(p)
-#define put_page_testzero(p) 	atomic_dec_and_test(&(p)->count)
 #define page_count(p)		atomic_read(&(p)->count)
 #define set_page_count(p,v) 	atomic_set(&(p)->count, v)
 
+extern void FASTCALL(__free_pages(struct page *page, unsigned int order));
+
+static inline void get_page(struct page *page)
+{
+	atomic_inc(&page->count);
+}
+
+static inline void put_page_nofree(struct page *page)
+{
+	BUG_ON(!page_count(page));
+	atomic_dec(&page->count);
+}
+
+static inline int put_page_testzero(struct page *page)
+{
+	mmstat(testzero);
+	BUG_ON(!page_count(page));
+	return atomic_dec_and_test(&page->count);
+}
+
+static inline void put_page(struct page *page)
+{
+	__free_page(page);
+}
+
 /*
  * Various page->flags bits:
  *
@@ -451,15 +496,6 @@
  */
 #define get_free_page get_zeroed_page
 
-/*
- * There is only one 'core' page-freeing function.
- */
-extern void FASTCALL(__free_pages(struct page *page, unsigned int order));
-extern void FASTCALL(free_pages(unsigned long addr, unsigned int order));
-
-#define __free_page(page) __free_pages((page), 0)
-#define free_page(addr) free_pages((addr),0)
-
 extern void show_free_areas(void);
 extern void show_free_areas_node(pg_data_t *pgdat);
 
@@ -518,11 +554,6 @@
 
 extern struct address_space swapper_space;
 #define PageSwapCache(page) ((page)->mapping == &swapper_space)
-
-static inline int is_page_cache_freeable(struct page * page)
-{
-	return page_count(page) - !!page->buffers == 1;
-}
 
 extern int can_share_swap_page(struct page *);
 extern int remove_exclusive_swap_page(struct page *);
--- 2.4.19.clean/include/linux/pagemap.h	Mon Feb 25 14:38:13 2002
+++ 2.4.19/include/linux/pagemap.h	Fri Aug 30 22:17:21 2002
@@ -27,9 +27,38 @@
 #define PAGE_CACHE_SIZE		PAGE_SIZE
 #define PAGE_CACHE_MASK		PAGE_MASK
 #define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
+#define LRU_PLUS_CACHE 2
+#define LRU_DEL_HEURISTIC
 
 #define page_cache_get(x)	get_page(x)
-#define page_cache_release(x)	__free_page(x)
+
+static inline void page_cache_release(struct page *page)
+{
+	mmstat(release);
+#if LRU_PLUS_CACHE==2
+#ifdef LRU_DEL_HEURISTIC
+	if (page_count(page) == 2 && spin_trylock(&pagemap_lru_lock)) {
+		mmstat(release_test_page);
+		if (PageLRU(page) && page_count(page) == 2) {
+			mmstat(release_free_page);
+			__lru_cache_del(page);
+		}
+		spin_unlock(&pagemap_lru_lock);
+	}
+#endif
+#endif
+	put_page(page);
+}
+
+static inline int has_buffers(struct page *page)
+{
+	return !!page->buffers;
+}
+
+static inline int is_page_cache_freeable(struct page *page)
+{
+	return page_count(page) - has_buffers(page) == LRU_PLUS_CACHE;
+}
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
--- 2.4.19.clean/mm/filemap.c	Fri Aug  2 20:39:46 2002
+++ 2.4.19/mm/filemap.c	Fri Aug 30 21:40:33 2002
@@ -198,10 +198,12 @@
 		if (page->buffers && !try_to_free_buffers(page, 0))
 			goto unlock;
 
-		if (page_count(page) != 1)
+		if (page_count(page) != LRU_PLUS_CACHE)
 			goto unlock;
 
+#if LRU_PLUS_CACHE==1
 		__lru_cache_del(page);
+#endif
 		__remove_inode_page(page);
 		UnlockPage(page);
 		page_cache_release(page);
@@ -234,8 +236,10 @@
 static void truncate_complete_page(struct page *page)
 {
 	/* Leave it on the LRU if it gets converted into anonymous buffers */
-	if (!page->buffers || do_flushpage(page, 0))
+	if (!page->buffers || do_flushpage(page, 0)) {
+		mmstat(truncate_lru_cache_del);
 		lru_cache_del(page);
+	}
 
 	/*
 	 * We remove the page from the page cache _after_ we have
@@ -345,7 +349,7 @@
 	 * The page is locked and we hold the pagecache_lock as well
 	 * so both page_count(page) and page->buffers stays constant here.
 	 */
-	if (page_count(page) == 1 + !!page->buffers) {
+	if (is_page_cache_freeable(page)) {
 		/* Restart after this page */
 		list_del(head);
 		list_add_tail(head, curr);
--- 2.4.19.clean/mm/page_alloc.c	Fri Aug  2 20:39:46 2002
+++ 2.4.19/mm/page_alloc.c	Fri Aug 30 21:55:03 2002
@@ -82,9 +82,12 @@
 	/* Yes, think what happens when other parts of the kernel take 
 	 * a reference to a page in order to pin it for io. -ben
 	 */
+#if LRU_PLUS_CACHE==2
+	BUG_ON(PageLRU(page));
+#else
 	if (PageLRU(page))
 		lru_cache_del(page);
-
+#endif
 	if (page->buffers)
 		BUG();
 	if (page->mapping)
--- 2.4.19.clean/mm/swap.c	Wed Nov  7 01:44:20 2001
+++ 2.4.19/mm/swap.c	Fri Aug 30 21:32:20 2002
@@ -60,6 +60,9 @@
 	if (!TestSetPageLRU(page)) {
 		spin_lock(&pagemap_lru_lock);
 		add_page_to_inactive_list(page);
+#if LRU_PLUS_CACHE==2
+		get_page(page);
+#endif
 		spin_unlock(&pagemap_lru_lock);
 	}
 }
@@ -79,6 +82,10 @@
 		} else {
 			del_page_from_inactive_list(page);
 		}
+		mmstat(lru_cache_del);
+#if LRU_PLUS_CACHE==2		
+		put_page_nofree(page);
+#endif
 	}
 }
 
--- 2.4.19.clean/mm/swapfile.c	Fri Aug  2 20:39:46 2002
+++ 2.4.19/mm/swapfile.c	Fri Aug 30 21:32:20 2002
@@ -239,7 +239,7 @@
 		if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 			/* Recheck the page count with the pagecache lock held.. */
 			spin_lock(&pagecache_lock);
-			if (page_count(page) - !!page->buffers == 2)
+			if (page_count(page) - has_buffers(page) == LRU_PLUS_CACHE + 1)
 				retval = 1;
 			spin_unlock(&pagecache_lock);
 		}
@@ -263,16 +263,16 @@
 	if (!PageLocked(page))
 		BUG();
 	switch (page_count(page)) {
-	case 3:
-		if (!page->buffers)
+	case LRU_PLUS_CACHE + 2:
+		if (!has_buffers(page))
 			break;
 		/* Fallthrough */
-	case 2:
+	case LRU_PLUS_CACHE + 1:
 		if (!PageSwapCache(page))
 			break;
 		retval = exclusive_swap_page(page);
 		break;
-	case 1:
+	case LRU_PLUS_CACHE:
 		if (PageReserved(page))
 			break;
 		retval = 1;
@@ -280,6 +280,11 @@
 	return retval;
 }
 
+static inline int only_cached(struct page *page)
+{
+	return page_count(page) - has_buffers(page) == LRU_PLUS_CACHE + 1;
+}
+
 /*
  * Work out if there are any other processes sharing this
  * swap cache page. Free it if you can. Return success.
@@ -294,7 +299,7 @@
 		BUG();
 	if (!PageSwapCache(page))
 		return 0;
-	if (page_count(page) - !!page->buffers != 2)	/* 2: us + cache */
+	if (!only_cached(page))
 		return 0;
 
 	entry.val = page->index;
@@ -307,7 +312,7 @@
 	if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 		/* Recheck the page count with the pagecache lock held.. */
 		spin_lock(&pagecache_lock);
-		if (page_count(page) - !!page->buffers == 2) {
+		if (only_cached(page)) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
@@ -343,7 +348,7 @@
 	if (page) {
 		page_cache_get(page);
 		/* Only cache user (+us), or swap space full? Free it! */
-		if (page_count(page) - !!page->buffers == 2 || vm_swap_full()) {
+		if (only_cached(page) || vm_swap_full()) {
 			delete_from_swap_cache(page);
 			SetPageDirty(page);
 		}
--- 2.4.19.clean/mm/vmscan.c	Fri Aug  2 20:39:46 2002
+++ 2.4.19/mm/vmscan.c	Fri Aug 30 21:40:30 2002
@@ -89,7 +89,7 @@
 		mm->rss--;
 		UnlockPage(page);
 		{
-			int freeable = page_count(page) - !!page->buffers <= 2;
+			int freeable = page_count(page) - has_buffers(page) <= LRU_PLUS_CACHE + 1;
 			page_cache_release(page);
 			return freeable;
 		}
@@ -356,20 +356,30 @@
 		BUG_ON(PageActive(page));
 
 		list_del(entry);
+#if LRU_PLUS_CACHE==2
+		BUG_ON(!page_count(page));
+		if (unlikely(page_count(page) == 1)) {
+			mmstat(vmscan_free_page);
+			BUG_ON(!TestClearPageLRU(page)); // side effect abuse!!
+			put_page(page);
+			continue;
+		}
+#endif
 		list_add(entry, &inactive_list);
 
+#if LRU_PLUS_CACHE==1
 		/*
 		 * Zero page counts can happen because we unlink the pages
 		 * _after_ decrementing the usage count..
 		 */
 		if (unlikely(!page_count(page)))
 			continue;
-
+#endif
 		if (!memclass(page_zone(page), classzone))
 			continue;
 
 		/* Racy check to avoid trylocking when not worthwhile */
-		if (!page->buffers && (page_count(page) != 1 || !page->mapping))
+		if (!page->buffers && (page_count(page) != LRU_PLUS_CACHE || !page->mapping))
 			goto page_mapped;
 
 		/*
@@ -434,9 +444,9 @@
 					 */
 					spin_lock(&pagemap_lru_lock);
 					UnlockPage(page);
+#if LRU_PLUS_CACHE==1
 					__lru_cache_del(page);
-
-					/* effectively free the page here */
+#endif
 					page_cache_release(page);
 
 					if (--nr_pages)
@@ -505,10 +515,10 @@
 			swap_free(swap);
 		}
 
+#if LRU_PLUS_CACHE==1
 		__lru_cache_del(page);
+#endif
 		UnlockPage(page);
-
-		/* effectively free the page here */
 		page_cache_release(page);
 
 		if (--nr_pages)
