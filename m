Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWCTNgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWCTNgD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWCTNgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:36:03 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:32856 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964777AbWCTNgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:36:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Z/OCyh4xDoqf0t36ZeDNXA/m1LrIhKbOryhnXGVshjA/7smydnph7xZuhot8FutrDyUBbDl27Evacq8IGDh2kh3ePEC/S0PUKf48IZGuygiLkJoltGLvoJvGPGc1NUNgou4RxNzlGfio9jkFFZwN8oaKKXIcn65/FKMY3GFK37U=
Message-ID: <bc56f2f0603200535s2b801775m@mail.gmail.com>
Date: Mon, 20 Mar 2006 08:35:58 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: akpm@osdl.org
Subject: [PATCH][0/8] (Targeting 2.6.17) Posix memory locking and balanced mlock-LRU semantic
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2415_25109497.1142861758330"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2415_25109497.1142861758330
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Both one of my friends(who is working on a DBMS oriented from
PostgreSQL) and i had encountered unexpected OOMs with mlock/mlockall.

After careful code-reading and tests,i found out that the reason of the
OOM is that VM's LRU algorithm treating mlocked pages as Active/Inactive,
regardless of that the mlocked pages could not be reclaimed.

Mlocking many pages will easily cause unbalance between LRU and slab:
VM tend to reclaim from Active/Inactive list,most of which are mlocked,
thus OOM may be triggered. While in fact,there are enough pages to be
reclaimed in slab.
( Setting a large "vfs_cache_pressure" may help to avoid the OOM
  under this situation, but i think it's better "do things right" than
  depending on the "vfs_cache_pressure" tunable)

We think that it's wrong semantic treating mlocked as Active/Inactive.
Mlocked pages should not be counted in page-reclaiming algorithm,
for in fact they will never be affected by page reclaims.

Following patch patch try to fix this, with some additions.

The patch brings Linux with:
1. Posix mlock/munlock/mlockall/munlockall.
   Get mlock/munlock/mlockall/munlockall to Posix definiton: transaction-li=
ke,
   just as described in the manpage(2) of mlock/munlock/mlockall/munlockall=
.
   Thus users of mlock system call series will always have an clear map of
   mlocked areas.
2. More consistent LRU semantics in Memory Management.
   Mlocked pages is placed on a separate LRU list: Wired List.
   The pages dont take part in LRU algorithms,for they could never be swapp=
ed,
   until munlocked.
3. Output the Wired(mlocked) pages count through /proc/meminfo.
   One line is added to /proc/meminfo: "Wired:     N kB",thus Linux system
   administrators/programmers can have a clearer map of physical memory usa=
ge.


Test of the patch:

Test envioronment:
     RHEL4.
     Totoal physical memory size: 256MB,no swap.
     One ext3 directory("/mnt/test") with about 256 thousand small
files (each size: 2kB).

Step 1. run a task mlocking 220 MB
Step 2. run: "find /mnt/test -size 100"


Case A. Standard kernel.org kernel 2.6.15

Linux soon run OOM, OOM-time memory info:

[root@Linux ~]# cat /proc/meminfo
MemTotal:       254248 kB
MemFree:          3144 kB
Buffers:           124 kB
Cached:           1584 kB
SwapCached:          0 kB
Active:         229308 kB
Inactive:          596 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       254248 kB
LowFree:          3144 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:         228556 kB
Slab:            20076 kB
CommitLimit:    127124 kB
Committed_AS:   238424 kB
PageTables:        584 kB
VmallocTotal:   770040 kB
VmallocUsed:       180 kB
VmallocChunk:   769844 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB


Case B. Patched 2.6.15

No OOM happened.

[root@Linux ~]# cat /proc/meminfo
MemTotal:       254344 kB
MemFree:          3508 kB
Buffers:          6352 kB
Cached:           2684 kB
SwapCached:          0 kB
Active:           7140 kB
Inactive:         4732 kB
Wired:          225284 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       254344 kB
LowFree:          3508 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              72 kB
Writeback:           0 kB
Mapped:         229208 kB
Slab:            12552 kB
CommitLimit:    127172 kB
Committed_AS:   238168 kB
PageTables:        572 kB
VmallocTotal:   770040 kB
VmallocUsed:       180 kB
VmallocChunk:   769844 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB


A lot thanks to Mel Gorman for your book: <Understanding the Linux Virtual
Memory Manager>. Also, thanks to other 2 great Linux kernel books: ULK3 and
LDD3.

FreeBSD's VM implementation enlightened me,thanks to FreeBSD guys.

Attachment is the full patch,following mails are what it splits up,.

Shaoping Wang

------=_Part_2415_25109497.1142861758330
Content-Type: application/octet-stream; name=patch-2.6.15-memlock
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_el0wjbml
Content-Disposition: attachment; filename="patch-2.6.15-memlock"

diff -urN --exclude-from=./exclude.files linux-2.6.15/arch/cris/arch-v32/drivers/cryptocop.c /home/backup/linux-2.6.15-release/arch/cris/arch-v32/drivers/cryptocop.c
--- linux-2.6.15/arch/cris/arch-v32/drivers/cryptocop.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/arch/cris/arch-v32/drivers/cryptocop.c	2006-03-06 08:38:48.000000000 -0500
@@ -2724,6 +2724,7 @@
 			     noinpages,
 			     0,  /* read access only for in data */
 			     0, /* no force */
+			     0, /* do not set wire */
 			     inpages,
 			     NULL);
 
@@ -2741,6 +2742,7 @@
 				     nooutpages,
 				     1, /* write access for out data */
 				     0, /* no force */
+				     0, /* do not set wire*/
 				     outpages,
 				     NULL);
 		up_read(&current->mm->mmap_sem);
diff -urN --exclude-from=./exclude.files linux-2.6.15/Documentation/vm/hugetlbpage.txt /home/backup/linux-2.6.15-release/Documentation/vm/hugetlbpage.txt
--- linux-2.6.15/Documentation/vm/hugetlbpage.txt	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/Documentation/vm/hugetlbpage.txt	2006-03-06 06:30:06.000000000 -0500
@@ -59,7 +59,7 @@
 
 This command will try to configure 20 hugepages in the system.  The success
 or failure of allocation depends on the amount of physically contiguous
-memory that is preset in system at this time.  System administrators may want
+memory that is present in system at this time.  System administrators may want
 to put this command in one of the local rc init file.  This will enable the
 kernel to request huge pages early in the boot process (when the possibility
 of getting physical contiguous pages is still very high).
diff -urN --exclude-from=./exclude.files linux-2.6.15/Documentation/vm/locking /home/backup/linux-2.6.15-release/Documentation/vm/locking
--- linux-2.6.15/Documentation/vm/locking	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/Documentation/vm/locking	2006-03-07 03:43:44.000000000 -0500
@@ -37,7 +37,7 @@
 4. The exception to this rule is expand_stack, which just
    takes the read lock and the page_table_lock, this is ok
    because it doesn't really modify fields anybody relies on.
-5. You must be able to guarantee that while holding page_table_lock
+5. You must be able to guarantee that while holding mmap_sem
    or page_table_lock of mm A, you will not try to get either lock
    for mm B.
 
diff -urN --exclude-from=./exclude.files linux-2.6.15/drivers/infiniband/core/uverbs_mem.c /home/backup/linux-2.6.15-release/drivers/infiniband/core/uverbs_mem.c
--- linux-2.6.15/drivers/infiniband/core/uverbs_mem.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/drivers/infiniband/core/uverbs_mem.c	2006-03-06 08:40:06.000000000 -0500
@@ -110,7 +110,7 @@
 		ret = get_user_pages(current, current->mm, cur_base,
 				     min_t(int, npages,
 					   PAGE_SIZE / sizeof (struct page *)),
-				     1, !write, page_list, NULL);
+				     1, !write, 0, page_list, NULL);
 
 		if (ret < 0)
 			goto out;
diff -urN --exclude-from=./exclude.files linux-2.6.15/drivers/infiniband/hw/mthca/mthca_memfree.c /home/backup/linux-2.6.15-release/drivers/infiniband/hw/mthca/mthca_memfree.c
--- linux-2.6.15/drivers/infiniband/hw/mthca/mthca_memfree.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/drivers/infiniband/hw/mthca/mthca_memfree.c	2006-03-06 08:41:10.000000000 -0500
@@ -396,7 +396,7 @@
 		goto out;
 	}
 
-	ret = get_user_pages(current, current->mm, uaddr & PAGE_MASK, 1, 1, 0,
+	ret = get_user_pages(current, current->mm, uaddr & PAGE_MASK, 1, 1, 0, 0,
 			     &db_tab->page[i].mem.page, NULL);
 	if (ret < 0)
 		goto out;
diff -urN --exclude-from=./exclude.files linux-2.6.15/drivers/media/video/video-buf.c /home/backup/linux-2.6.15-release/drivers/media/video/video-buf.c
--- linux-2.6.15/drivers/media/video/video-buf.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/drivers/media/video/video-buf.c	2006-03-06 08:41:54.000000000 -0500
@@ -149,7 +149,7 @@
 	down_read(&current->mm->mmap_sem);
 	err = get_user_pages(current,current->mm,
 			     data & PAGE_MASK, dma->nr_pages,
-			     rw == READ, 1, /* force */
+			     rw == READ, 1, 0, /* force,do not set wire */
 			     dma->pages, NULL);
 	up_read(&current->mm->mmap_sem);
 	if (err != dma->nr_pages) {
diff -urN --exclude-from=./exclude.files linux-2.6.15/drivers/scsi/sg.c /home/backup/linux-2.6.15-release/drivers/scsi/sg.c
--- linux-2.6.15/drivers/scsi/sg.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/drivers/scsi/sg.c	2006-03-06 08:09:43.000000000 -0500
@@ -1815,6 +1815,7 @@
 		nr_pages,
 		rw == READ,
 		0, /* don't force */
+		0,
 		pages,
 		NULL);
 	up_read(&current->mm->mmap_sem);
diff -urN --exclude-from=./exclude.files linux-2.6.15/drivers/scsi/st.c /home/backup/linux-2.6.15-release/drivers/scsi/st.c
--- linux-2.6.15/drivers/scsi/st.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/drivers/scsi/st.c	2006-03-06 07:57:47.000000000 -0500
@@ -4453,6 +4453,7 @@
 		nr_pages,
 		rw == READ,
 		0, /* don't force */
+		0,
 		pages,
 		NULL);
 	up_read(&current->mm->mmap_sem);
diff -urN --exclude-from=./exclude.files linux-2.6.15/drivers/video/pvr2fb.c /home/backup/linux-2.6.15-release/drivers/video/pvr2fb.c
--- linux-2.6.15/drivers/video/pvr2fb.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/drivers/video/pvr2fb.c	2006-03-06 08:42:53.000000000 -0500
@@ -690,7 +690,7 @@
 	
 	down_read(&current->mm->mmap_sem);
 	ret = get_user_pages(current, current->mm, (unsigned long)buf,
-			     nr_pages, WRITE, 0, pages, NULL);
+			     nr_pages, WRITE, 0, 0, pages, NULL);
 	up_read(&current->mm->mmap_sem);
 
 	if (ret < nr_pages) {
diff -urN --exclude-from=./exclude.files linux-2.6.15/fs/aio.c /home/backup/linux-2.6.15-release/fs/aio.c
--- linux-2.6.15/fs/aio.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/fs/aio.c	2006-03-06 06:30:06.000000000 -0500
@@ -146,7 +146,7 @@
 	dprintk("mmap address: 0x%08lx\n", info->mmap_base);
 	info->nr_pages = get_user_pages(current, ctx->mm,
 					info->mmap_base, nr_pages, 
-					1, 0, info->ring_pages, NULL);
+					1, 0, 0, info->ring_pages, NULL);
 	up_write(&ctx->mm->mmap_sem);
 
 	if (unlikely(info->nr_pages != nr_pages)) {
diff -urN --exclude-from=./exclude.files linux-2.6.15/fs/binfmt_elf.c /home/backup/linux-2.6.15-release/fs/binfmt_elf.c
--- linux-2.6.15/fs/binfmt_elf.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/fs/binfmt_elf.c	2006-03-06 06:30:06.000000000 -0500
@@ -1600,7 +1600,7 @@
 			struct page* page;
 			struct vm_area_struct *vma;
 
-			if (get_user_pages(current, current->mm, addr, 1, 0, 1,
+			if (get_user_pages(current, current->mm, addr, 1, 0, 1, 0,
 						&page, &vma) <= 0) {
 				DUMP_SEEK (file->f_pos + PAGE_SIZE);
 			} else {
diff -urN --exclude-from=./exclude.files linux-2.6.15/fs/bio.c /home/backup/linux-2.6.15-release/fs/bio.c
--- linux-2.6.15/fs/bio.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/fs/bio.c	2006-03-06 06:30:06.000000000 -0500
@@ -608,7 +608,7 @@
 		down_read(&current->mm->mmap_sem);
 		ret = get_user_pages(current, current->mm, uaddr,
 				     local_nr_pages,
-				     write_to_vm, 0, &pages[cur_page], NULL);
+				     write_to_vm, 0, 0, &pages[cur_page], NULL);
 		up_read(&current->mm->mmap_sem);
 
 		if (ret < local_nr_pages)
diff -urN --exclude-from=./exclude.files linux-2.6.15/fs/direct-io.c /home/backup/linux-2.6.15-release/fs/direct-io.c
--- linux-2.6.15/fs/direct-io.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/fs/direct-io.c	2006-03-06 06:30:06.000000000 -0500
@@ -157,6 +157,7 @@
 		nr_pages,			/* How many pages? */
 		dio->rw == READ,		/* Write to memory? */
 		0,				/* force (?) */
+		0,
 		&dio->pages[0],
 		NULL);				/* vmas */
 	up_read(&current->mm->mmap_sem);
diff -urN --exclude-from=./exclude.files linux-2.6.15/fs/fuse/dev.c /home/backup/linux-2.6.15-release/fs/fuse/dev.c
--- linux-2.6.15/fs/fuse/dev.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/fs/fuse/dev.c	2006-03-06 06:30:07.000000000 -0500
@@ -462,7 +462,7 @@
 		cs->nr_segs --;
 	}
 	down_read(&current->mm->mmap_sem);
-	err = get_user_pages(current, current->mm, cs->addr, 1, cs->write, 0,
+	err = get_user_pages(current, current->mm, cs->addr, 1, cs->write, 0, 0,
 			     &cs->pg, NULL);
 	up_read(&current->mm->mmap_sem);
 	if (err < 0)
diff -urN --exclude-from=./exclude.files linux-2.6.15/fs/fuse/file.c /home/backup/linux-2.6.15-release/fs/fuse/file.c
--- linux-2.6.15/fs/fuse/file.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/fs/fuse/file.c	2006-03-06 06:30:07.000000000 -0500
@@ -457,7 +457,7 @@
 	npages = min(npages, FUSE_MAX_PAGES_PER_REQ);
 	down_read(&current->mm->mmap_sem);
 	npages = get_user_pages(current, current->mm, user_addr, npages, write,
-				0, req->pages, NULL);
+				0, 0, req->pages, NULL);
 	up_read(&current->mm->mmap_sem);
 	if (npages < 0)
 		return npages;
diff -urN --exclude-from=./exclude.files linux-2.6.15/fs/nfs/direct.c /home/backup/linux-2.6.15-release/fs/nfs/direct.c
--- linux-2.6.15/fs/nfs/direct.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/fs/nfs/direct.c	2006-03-06 06:30:07.000000000 -0500
@@ -104,7 +104,7 @@
 	if (*pages) {
 		down_read(&current->mm->mmap_sem);
 		result = get_user_pages(current, current->mm, user_addr,
-					page_count, (rw == READ), 0,
+					page_count, (rw == READ), 0, 0,
 					*pages, NULL);
 		up_read(&current->mm->mmap_sem);
 	}
diff -urN --exclude-from=./exclude.files linux-2.6.15/fs/proc/proc_misc.c /home/backup/linux-2.6.15-release/fs/proc/proc_misc.c
--- linux-2.6.15/fs/proc/proc_misc.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/fs/proc/proc_misc.c	2006-03-06 06:44:50.000000000 -0500
@@ -123,6 +123,7 @@
 	struct page_state ps;
 	unsigned long inactive;
 	unsigned long active;
+	unsigned long wired;
 	unsigned long free;
 	unsigned long committed;
 	unsigned long allowed;
@@ -130,7 +131,7 @@
 	long cached;
 
 	get_page_state(&ps);
-	get_zone_counts(&active, &inactive, &free);
+	get_zone_counts(&active, &inactive, &wired, &free);
 
 /*
  * display in kilobytes.
@@ -159,6 +160,7 @@
 		"SwapCached:   %8lu kB\n"
 		"Active:       %8lu kB\n"
 		"Inactive:     %8lu kB\n"
+		"Wired:        %8lu kB\n"
 		"HighTotal:    %8lu kB\n"
 		"HighFree:     %8lu kB\n"
 		"LowTotal:     %8lu kB\n"
@@ -182,6 +184,7 @@
 		K(total_swapcache_pages),
 		K(active),
 		K(inactive),
+		K(wired),
 		K(i.totalhigh),
 		K(i.freehigh),
 		K(i.totalram-i.totalhigh),
diff -urN --exclude-from=./exclude.files linux-2.6.15/include/linux/mm.h /home/backup/linux-2.6.15-release/include/linux/mm.h
--- linux-2.6.15/include/linux/mm.h	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/include/linux/mm.h	2006-03-07 01:49:12.000000000 -0500
@@ -59,6 +59,9 @@
 	unsigned long vm_start;		/* Our start address within vm_mm. */
 	unsigned long vm_end;		/* The first byte after our end address
 					   within vm_mm. */
+	int vm_wire_change;			/* VM_LOCKED bit of vm_flags was just changed.
+								 * For rollback support of sys_mlock series system calls.
+								 */
 
 	/* linked list of VM areas per task, sorted by address */
 	struct vm_area_struct *vm_next;
@@ -218,6 +221,10 @@
 	unsigned long flags;		/* Atomic flags, some possibly
 					 * updated asynchronously */
 	atomic_t _count;		/* Usage count, see below. */
+	unsigned short wired_count; /* Count of wirings of the page.
+					 * If not zero,the page would be SetPageWired,
+					 * and put on Wired list of the zone.
+					 */
 	atomic_t _mapcount;		/* Count of ptes mapped in mms,
 					 * to show when page is mapped
 					 * & limit reverse map searches.
@@ -699,12 +706,13 @@
 	return __handle_mm_fault(mm, vma, address, write_access) & (~VM_FAULT_WRITE);
 }
 
-extern int make_pages_present(unsigned long addr, unsigned long end);
+extern int make_pages_wired(unsigned long addr, unsigned long end);
+void make_pages_unwired(struct mm_struct *mm, unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 void install_arg_page(struct vm_area_struct *, struct page *, unsigned long);
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
-		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
+		int len, int write, int force, int wire, struct page **pages, struct vm_area_struct **vmas);
 void print_bad_pte(struct vm_area_struct *, pte_t, unsigned long);
 
 int __set_page_dirty_buffers(struct page *page);
diff -urN --exclude-from=./exclude.files linux-2.6.15/include/linux/mm_inline.h /home/backup/linux-2.6.15-release/include/linux/mm_inline.h
--- linux-2.6.15/include/linux/mm_inline.h	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/include/linux/mm_inline.h	2006-03-07 01:56:10.000000000 -0500
@@ -1,3 +1,9 @@
+/*
+ * There are 3 per-zone lists in LRU: 
+ * 			Active: pages which were accessed more frequently.
+ *			Inactive: pages accessed less frequently.
+ *			Wired: pages mlocked by some tasks.
+ */
 
 static inline void
 add_page_to_active_list(struct zone *zone, struct page *page)
@@ -14,6 +20,13 @@
 }
 
 static inline void
+add_page_to_wired_list(struct zone *zone, struct page *page)
+{
+	list_add(&page->lru, &zone->wired_list);
+	zone->nr_wired++;
+}
+
+static inline void
 del_page_from_active_list(struct zone *zone, struct page *page)
 {
 	list_del(&page->lru);
@@ -28,10 +41,20 @@
 }
 
 static inline void
+del_page_from_wired_list(struct zone *zone, struct page *page)
+{
+	list_del(&page->lru);
+	zone->nr_wired--;
+}
+
+static inline void
 del_page_from_lru(struct zone *zone, struct page *page)
 {
 	list_del(&page->lru);
-	if (PageActive(page)) {
+	if(PageWired(page)){
+		ClearPageWired(page);
+		zone->nr_wired--;
+	} else if (PageActive(page)) {
 		ClearPageActive(page);
 		zone->nr_active--;
 	} else {
diff -urN --exclude-from=./exclude.files linux-2.6.15/include/linux/mmzone.h /home/backup/linux-2.6.15-release/include/linux/mmzone.h
--- linux-2.6.15/include/linux/mmzone.h	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/include/linux/mmzone.h	2006-03-07 01:58:26.000000000 -0500
@@ -143,10 +143,12 @@
 	spinlock_t		lru_lock;	
 	struct list_head	active_list;
 	struct list_head	inactive_list;
+	struct list_head	wired_list; /* Pages wired. */
 	unsigned long		nr_scan_active;
 	unsigned long		nr_scan_inactive;
 	unsigned long		nr_active;
 	unsigned long		nr_inactive;
+	unsigned long		nr_wired;
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
@@ -315,9 +317,9 @@
 extern struct pglist_data *pgdat_list;
 
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free, struct pglist_data *pgdat);
+		unsigned long *wired, unsigned long *free, struct pglist_data *pgdat);
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free);
+		unsigned long *wired, unsigned long *free);
 void build_all_zonelists(void);
 void wakeup_kswapd(struct zone *zone, int order);
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
diff -urN --exclude-from=./exclude.files linux-2.6.15/include/linux/page-flags.h /home/backup/linux-2.6.15-release/include/linux/page-flags.h
--- linux-2.6.15/include/linux/page-flags.h	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/include/linux/page-flags.h	2006-03-06 06:30:07.000000000 -0500
@@ -76,6 +76,8 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
+#define PG_wired		20  /* Page is on Wired list */
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -198,7 +200,14 @@
 #define __ClearPageDirty(page)	__clear_bit(PG_dirty, &(page)->flags)
 #define TestClearPageDirty(page) test_and_clear_bit(PG_dirty, &(page)->flags)
 
+#define SetPageWired(page)	set_bit(PG_wired, &(page)->flags)
+#define ClearPageWired(page) clear_bit(PG_wired,&(page)->flags)
+#define PageWired(page)		test_bit(PG_wired, &(page)->flags)
+#define TestSetPageWired(page)	test_and_set_bit(PG_wired, &(page)->flags)
+#define TestClearPageWired(page)	test_and_clear_bit(PG_wired, &(page)->flags)
+
 #define SetPageLRU(page)	set_bit(PG_lru, &(page)->flags)
+#define ClearPageLRU(page)	clear_bit(PG_lru, &(page)->flags)
 #define PageLRU(page)		test_bit(PG_lru, &(page)->flags)
 #define TestSetPageLRU(page)	test_and_set_bit(PG_lru, &(page)->flags)
 #define TestClearPageLRU(page)	test_and_clear_bit(PG_lru, &(page)->flags)
diff -urN --exclude-from=./exclude.files linux-2.6.15/include/linux/rmap.h /home/backup/linux-2.6.15-release/include/linux/rmap.h
--- linux-2.6.15/include/linux/rmap.h	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/include/linux/rmap.h	2006-03-06 06:30:07.000000000 -0500
@@ -71,8 +71,8 @@
  * rmap interfaces called when adding or removing pte of page
  */
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
-void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_add_file_rmap(struct page *, struct vm_area_struct *);
+void page_remove_rmap(struct page *, struct vm_area_struct *);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
diff -urN --exclude-from=./exclude.files linux-2.6.15/include/linux/swap.h /home/backup/linux-2.6.15-release/include/linux/swap.h
--- linux-2.6.15/include/linux/swap.h	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/include/linux/swap.h	2006-03-06 06:30:07.000000000 -0500
@@ -165,6 +165,8 @@
 extern void FASTCALL(lru_cache_add(struct page *));
 extern void FASTCALL(lru_cache_add_active(struct page *));
 extern void FASTCALL(activate_page(struct page *));
+extern void FASTCALL(wire_page(struct page *));
+extern void FASTCALL(unwire_page(struct page *));
 extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
 extern int rotate_reclaimable_page(struct page *page);
diff -urN --exclude-from=./exclude.files linux-2.6.15/kernel/futex.c /home/backup/linux-2.6.15-release/kernel/futex.c
--- linux-2.6.15/kernel/futex.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/kernel/futex.c	2006-03-06 06:30:07.000000000 -0500
@@ -201,7 +201,7 @@
 	 * from swap.  But that's a lot of code to duplicate here
 	 * for a rare case, so we simply fetch the page.
 	 */
-	err = get_user_pages(current, mm, uaddr, 1, 0, 0, &page, NULL);
+	err = get_user_pages(current, mm, uaddr, 1, 0, 0, 0, &page, NULL);
 	if (err >= 0) {
 		key->shared.pgoff =
 			page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
diff -urN --exclude-from=./exclude.files linux-2.6.15/kernel/ptrace.c /home/backup/linux-2.6.15-release/kernel/ptrace.c
--- linux-2.6.15/kernel/ptrace.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/kernel/ptrace.c	2006-03-06 06:30:07.000000000 -0500
@@ -228,7 +228,7 @@
 		void *maddr;
 
 		ret = get_user_pages(tsk, mm, addr, 1,
-				write, 1, &page, &vma);
+				write, 1, 0, &page, &vma);
 		if (ret <= 0)
 			break;
 
diff -urN --exclude-from=./exclude.files linux-2.6.15/mm/filemap_xip.c /home/backup/linux-2.6.15-release/mm/filemap_xip.c
--- linux-2.6.15/mm/filemap_xip.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/mm/filemap_xip.c	2006-03-06 06:30:07.000000000 -0500
@@ -189,7 +189,7 @@
 			/* Nuke the page table entry. */
 			flush_cache_page(vma, address, pte_pfn(*pte));
 			pteval = ptep_clear_flush(vma, address, pte);
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			dec_mm_counter(mm, file_rss);
 			BUG_ON(pte_dirty(pteval));
 			pte_unmap_unlock(pte, ptl);
diff -urN --exclude-from=./exclude.files linux-2.6.15/mm/fremap.c /home/backup/linux-2.6.15-release/mm/fremap.c
--- linux-2.6.15/mm/fremap.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/mm/fremap.c	2006-03-06 06:30:07.000000000 -0500
@@ -33,7 +33,7 @@
 		if (page) {
 			if (pte_dirty(pte))
 				set_page_dirty(page);
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			page_cache_release(page);
 		}
 	} else {
@@ -80,7 +80,7 @@
 
 	flush_icache_page(vma, page);
 	set_pte_at(mm, addr, pte, mk_pte(page, prot));
-	page_add_file_rmap(page);
+	page_add_file_rmap(page, vma);
 	pte_val = *pte;
 	update_mmu_cache(vma, addr, pte_val);
 	err = 0;
@@ -203,6 +203,8 @@
 			spin_unlock(&mapping->i_mmap_lock);
 		}
 
+		if(vma->vm_flags & VM_LOCKED)
+			flags &= ~MAP_NONBLOCK;
 		err = vma->vm_ops->populate(vma, start, size,
 					    vma->vm_page_prot,
 					    pgoff, flags & MAP_NONBLOCK);
diff -urN --exclude-from=./exclude.files linux-2.6.15/mm/memory.c /home/backup/linux-2.6.15-release/mm/memory.c
--- linux-2.6.15/mm/memory.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/mm/memory.c	2006-03-07 11:14:59.000000000 -0500
@@ -656,7 +656,7 @@
 					mark_page_accessed(page);
 				file_rss--;
 			}
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -950,8 +950,30 @@
 	return page;
 }
 
+void make_pages_unwired(struct mm_struct *mm,
+					unsigned long start,unsigned long end)
+{
+	struct vm_area_struct *vma;
+	struct page *page;
+	unsigned int foll_flags;
+
+	foll_flags =0;
+
+	vma=find_vma(mm,start);
+	if(!vma)
+		BUG();
+	if(is_vm_hugetlb_page(vma))
+		return;
+	
+	for(; start<end ; start+=PAGE_SIZE) {
+		page=follow_page(vma,start,foll_flags);
+		if(page)
+			unwire_page(page);
+	}
+}
+
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long start, int len, int write, int force,
+		unsigned long start, int len, int write,int force, int wire,
 		struct page **pages, struct vm_area_struct **vmas)
 {
 	int i;
@@ -973,6 +995,7 @@
 		if (!vma && in_gate_area(tsk, start)) {
 			unsigned long pg = start & PAGE_MASK;
 			struct vm_area_struct *gate_vma = get_gate_vma(tsk);
+			struct page *page;	
 			pgd_t *pgd;
 			pud_t *pud;
 			pmd_t *pmd;
@@ -994,6 +1017,7 @@
 				pte_unmap(pte);
 				return i ? : -EFAULT;
 			}
+			page = vm_normal_page(gate_vma, start, *pte);
 			if (pages) {
 				struct page *page = vm_normal_page(gate_vma, start, *pte);
 				pages[i] = page;
@@ -1003,9 +1027,12 @@
 			pte_unmap(pte);
 			if (vmas)
 				vmas[i] = gate_vma;
+			if(wire)
+				wire_page(page);
 			i++;
 			start += PAGE_SIZE;
 			len--;
+
 			continue;
 		}
 
@@ -1013,6 +1040,7 @@
 				|| !(vm_flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
+		/* We dont account wired HugeTLB pages */
 		if (is_vm_hugetlb_page(vma)) {
 			i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &len, i);
@@ -1067,17 +1095,20 @@
 			}
 			if (vmas)
 				vmas[i] = vma;
+			if(wire)
+				wire_page(page);
 			i++;
 			start += PAGE_SIZE;
 			len--;
 		} while (len && start < vma->vm_end);
 	} while (len);
+
 	return i;
 }
 EXPORT_SYMBOL(get_user_pages);
 
-static int zeromap_pte_range(struct mm_struct *mm, pmd_t *pmd,
-			unsigned long addr, unsigned long end, pgprot_t prot)
+static int zeromap_pte_range(struct mm_struct *mm, struct vm_area_struct *vma,
+			pmd_t *pmd, unsigned long addr, unsigned long end, pgprot_t prot)
 {
 	pte_t *pte;
 	spinlock_t *ptl;
@@ -1089,7 +1120,7 @@
 		struct page *page = ZERO_PAGE(addr);
 		pte_t zero_pte = pte_wrprotect(mk_pte(page, prot));
 		page_cache_get(page);
-		page_add_file_rmap(page);
+		page_add_file_rmap(page,vma);
 		inc_mm_counter(mm, file_rss);
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, zero_pte);
@@ -1098,8 +1129,8 @@
 	return 0;
 }
 
-static inline int zeromap_pmd_range(struct mm_struct *mm, pud_t *pud,
-			unsigned long addr, unsigned long end, pgprot_t prot)
+static inline int zeromap_pmd_range(struct mm_struct *mm, struct vm_area_struct *vma,
+			 pud_t *pud, unsigned long addr, unsigned long end, pgprot_t prot)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -1109,14 +1140,14 @@
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (zeromap_pte_range(mm, pmd, addr, next, prot))
+		if (zeromap_pte_range(mm, vma, pmd, addr, next, prot))
 			return -ENOMEM;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static inline int zeromap_pud_range(struct mm_struct *mm, pgd_t *pgd,
-			unsigned long addr, unsigned long end, pgprot_t prot)
+static inline int zeromap_pud_range(struct mm_struct *mm, struct vm_area_struct *vma,
+			pgd_t *pgd, unsigned long addr, unsigned long end, pgprot_t prot)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -1126,7 +1157,7 @@
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (zeromap_pmd_range(mm, pud, addr, next, prot))
+		if (zeromap_pmd_range(mm, vma, pud, addr, next, prot))
 			return -ENOMEM;
 	} while (pud++, addr = next, addr != end);
 	return 0;
@@ -1146,7 +1177,7 @@
 	flush_cache_range(vma, addr, end);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = zeromap_pud_range(mm, pgd, addr, next, prot);
+		err = zeromap_pud_range(mm, vma, pgd, addr, next, prot);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
@@ -1172,7 +1203,8 @@
  * old drivers should use this, and they needed to mark their
  * pages reserved for the old functions anyway.
  */
-static int insert_page(struct mm_struct *mm, unsigned long addr, struct page *page, pgprot_t prot)
+static int insert_page(struct mm_struct *mm, struct vm_area_struct *vma, 
+			unsigned long addr, struct page *page, pgprot_t prot)
 {
 	int retval;
 	pte_t *pte;
@@ -1193,7 +1225,7 @@
 	/* Ok, finally just insert the thing.. */
 	get_page(page);
 	inc_mm_counter(mm, file_rss);
-	page_add_file_rmap(page);
+	page_add_file_rmap(page,vma);
 	set_pte_at(mm, addr, pte, mk_pte(page, prot));
 
 	retval = 0;
@@ -1229,7 +1261,7 @@
 	if (!page_count(page))
 		return -EINVAL;
 	vma->vm_flags |= VM_INSERTPAGE;
-	return insert_page(vma->vm_mm, addr, page, vma->vm_page_prot);
+	return insert_page(vma->vm_mm, vma, addr, page, vma->vm_page_prot);
 }
 EXPORT_SYMBOL(vm_insert_page);
 
@@ -1484,7 +1516,7 @@
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (likely(pte_same(*page_table, orig_pte))) {
 		if (old_page) {
-			page_remove_rmap(old_page);
+			page_remove_rmap(old_page, vma);
 			if (!PageAnon(old_page)) {
 				dec_mm_counter(mm, file_rss);
 				inc_mm_counter(mm, anon_rss);
@@ -1967,7 +1999,7 @@
 		if (!pte_none(*page_table))
 			goto release;
 		inc_mm_counter(mm, file_rss);
-		page_add_file_rmap(page);
+		page_add_file_rmap(page, vma);
 	}
 
 	set_pte_at(mm, address, page_table, entry);
@@ -2089,7 +2121,7 @@
 			page_add_anon_rmap(new_page, vma, address);
 		} else {
 			inc_mm_counter(mm, file_rss);
-			page_add_file_rmap(new_page);
+			page_add_file_rmap(new_page, vma);
 		}
 	} else {
 		/* One of our sibling threads was faster, back out. */
@@ -2306,10 +2338,13 @@
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-int make_pages_present(unsigned long addr, unsigned long end)
+int make_pages_wired(unsigned long addr, unsigned long end)
 {
 	int ret, len, write;
+	struct page *page;
 	struct vm_area_struct * vma;
+	struct mm_struct *mm=current->mm;
+	int wire_change;
 
 	vma = find_vma(current->mm, addr);
 	if (!vma)
@@ -2320,13 +2355,26 @@
 	if (end > vma->vm_end)
 		BUG();
 	len = (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
-	ret = get_user_pages(current, current->mm, addr,
-			len, write, 0, NULL, NULL);
-	if (ret < 0)
-		return ret;
-	return ret == len ? 0 : -1;
+	wire_change = vma->vm_wire_change;
+	vma->vm_wire_change = 1;
+	ret = get_user_pages(current, mm, addr,
+			len, write, 1, 1, NULL, NULL); /* write,set_wire */
+	vma->vm_wire_change = wire_change;
+	if(ret < len) {
+	    for(; addr< end ; addr += PAGE_SIZE) {
+        	page=follow_page(vma,addr,0);
+            if(page)
+				unwire_page(page);
+			else
+				BUG();
+   		}
+		return -1;
+	} 
+	else
+		return 0;
 }
 
+
 /* 
  * Map a vmalloc()-space virtual address to the physical page.
  */
diff -urN --exclude-from=./exclude.files linux-2.6.15/mm/mempolicy.c /home/backup/linux-2.6.15-release/mm/mempolicy.c
--- linux-2.6.15/mm/mempolicy.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/mm/mempolicy.c	2006-03-06 06:30:08.000000000 -0500
@@ -440,7 +440,7 @@
 	struct page *p;
 	int err;
 
-	err = get_user_pages(current, mm, addr & PAGE_MASK, 1, 0, 0, &p, NULL);
+	err = get_user_pages(current, mm, addr & PAGE_MASK, 1, 0, 0, 0, &p, NULL);
 	if (err >= 0) {
 		err = page_to_nid(p);
 		put_page(p);
diff -urN --exclude-from=./exclude.files linux-2.6.15/mm/mlock.c /home/backup/linux-2.6.15-release/mm/mlock.c
--- linux-2.6.15/mm/mlock.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/mm/mlock.c	2006-03-07 10:50:52.000000000 -0500
@@ -3,6 +3,7 @@
  *
  *  (C) Copyright 1995 Linus Torvalds
  *  (C) Copyright 2002 Christoph Hellwig
+ *  (C) Copyright 2006 Shaoping Wang
  */
 
 #include <linux/mman.h>
@@ -10,72 +11,119 @@
 #include <linux/mempolicy.h>
 #include <linux/syscalls.h>
 
-
-static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
-	unsigned long start, unsigned long end, unsigned int newflags)
+static int do_mlock(unsigned long start, size_t len,unsigned int jump_hole)
 {
-	struct mm_struct * mm = vma->vm_mm;
-	pgoff_t pgoff;
-	int pages;
-	int ret = 0;
+	unsigned long  end=0,vmoff=0;
+	unsigned long  pages=0;
+	struct mm_struct *mm=current->mm;
+	struct vm_area_struct * vma, *prev, **pprev,*next;
+	int ret=0;
 
-	if (newflags == vma->vm_flags) {
-		*prev = vma;
-		goto out;
-	}
+	len = PAGE_ALIGN(len);
+	end = start + len;
+	if (end < start)
+		return -EINVAL;
+	if (end == start)
+		return 0;
 
-	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
-			  vma->vm_file, pgoff, vma_policy(vma));
-	if (*prev) {
-		vma = *prev;
-		goto success;
+	vma = find_vma_prev(current->mm, start, &prev);
+	if (!vma || vma->vm_start > start)
+		return -ENOMEM;
+    else if (vma->vm_start < start){
+			prev=vma;
+		    ret = split_vma(mm, prev, start, 0);
+			if(!ret)
+				vma=prev->vm_next;
+			else {
+				return ret;
+			}
 	}
 
-	*prev = vma;
-
-	if (start != vma->vm_start) {
-		ret = split_vma(mm, vma, start, 1);
-		if (ret)
+	while(vma->vm_start < end){
+		vmoff =vma->vm_end; /* Record where we have proceeded. */
+		if (vma->vm_end > end){
+    	   	ret = split_vma(mm, vma, end, 0);
+   			if (ret) 
+		   		goto out;
+		}
+		if(vma->vm_flags & VM_LOCKED)
+			goto next;
+		vma->vm_flags |= VM_LOCKED;
+		vma->vm_wire_change =1;
+		pages += (vma->vm_end-vma->vm_start) >> PAGE_SHIFT;
+
+    	if (!(vma->vm_flags & VM_IO)) {
+   			ret = make_pages_wired(vma->vm_start, vma->vm_end);
+			if(ret<0){ 
+				vma->vm_flags &= ~VM_LOCKED;
+				vma->vm_wire_change =0;
+				goto out;
+			}
+		}
+next:
+		if(vma->vm_end ==end)
+			break;
+		prev =vma;
+		vma =vma->vm_next;
+		
+		/* If called from do_mlockall, 
+		 * we may jump over holes. 
+         */
+		if(jump_hole){ 
+			if(vma)
+				continue;
+			else
+				goto out;
+		}
+		else if (!vma || vma->vm_start != prev->vm_end){
+			ret = -ENOMEM;
 			goto out;
+		}
 	}
 
-	if (end != vma->vm_end) {
-		ret = split_vma(mm, vma, end, 0);
-		if (ret)
-			goto out;
-	}
+out:
+	pprev =&prev;
+	vma = find_vma_prev(mm, start, pprev);
 
-success:
-	/*
-	 * vm_flags is protected by the mmap_sem held in write mode.
-	 * It's okay if try_to_unmap_one unmaps a page just after we
-	 * set VM_LOCKED, make_pages_present below will bring it back.
-	 */
-	vma->vm_flags = newflags;
-
-	/*
-	 * Keep track of amount of locked VM.
-	 */
-	pages = (end - start) >> PAGE_SHIFT;
-	if (newflags & VM_LOCKED) {
-		pages = -pages;
-		if (!(newflags & VM_IO))
-			ret = make_pages_present(start, end);
+	/* If error happened,do rollback.
+	 * Whether success or not,try to merge the vmas.
+     */
+	while( vma && vma->vm_end <= vmoff ){
+		if(vma->vm_wire_change) {
+			if(ret){
+				make_pages_unwired(mm, vma->vm_start, vma->vm_end);
+				vma->vm_flags &= ~VM_LOCKED;
+			}
+			vma->vm_wire_change =0;
+		}
+		next=vma->vm_next;
+		if(next && next->vm_wire_change) {
+			if(ret){
+				make_pages_unwired(mm, next->vm_start, next->vm_end);
+				next->vm_flags &= ~VM_LOCKED;
+			}
+			next->vm_wire_change=0;
+		}
+		*pprev=vma_merge(mm, *pprev, vma->vm_start, vma->vm_end, vma->vm_flags,
+					vma->anon_vma,vma->vm_file, vma->vm_pgoff, vma_policy(vma));
+		if(*pprev)
+			vma =*pprev;
+		vma =vma->vm_next;
 	}
 
-	vma->vm_mm->locked_vm -= pages;
-out:
-	if (ret == -ENOMEM)
-		ret = -EAGAIN;
+	if(!ret)
+		mm->locked_vm += pages;
 	return ret;
 }
 
-static int do_mlock(unsigned long start, size_t len, int on)
+
+static int do_munlock(unsigned long start, size_t len, unsigned int jump_hole)
 {
-	unsigned long nstart, end, tmp;
-	struct vm_area_struct * vma, * prev;
-	int error;
+	unsigned long  end=0,vmoff=0;
+	unsigned long  pages=0;
+	struct mm_struct *mm=current->mm;
+	struct vm_area_struct * vma, *prev, **pprev, *next;
+	int ret=0;
 
 	len = PAGE_ALIGN(len);
 	end = start + len;
@@ -86,38 +134,81 @@
 	vma = find_vma_prev(current->mm, start, &prev);
 	if (!vma || vma->vm_start > start)
 		return -ENOMEM;
+    else if (vma->vm_start < start){
+		prev=vma;
+	    ret = split_vma(mm, prev, start, 0);
+		if(!ret)
+			vma=prev->vm_next;
+		else 
+			return ret;
+	}
 
-	if (start > vma->vm_start)
-		prev = vma;
+	while(vma->vm_start < end){
+		vmoff =vma->vm_end;
+    	if (vma->vm_end > end){
+    	   	ret = split_vma(mm, vma, end, 0);
+   	 		if (ret) 
+	   			goto out;
+		}
 
-	for (nstart = start ; ; ) {
-		unsigned int newflags;
+		if(!(vma->vm_flags & VM_LOCKED))
+			goto next;
 
-		/* Here we know that  vma->vm_start <= nstart < vma->vm_end. */
+		vma->vm_wire_change=1;
+		pages += (vma->vm_end -vma->vm_start) >>PAGE_SHIFT;
 
-		newflags = vma->vm_flags | VM_LOCKED;
-		if (!on)
-			newflags &= ~VM_LOCKED;
-
-		tmp = vma->vm_end;
-		if (tmp > end)
-			tmp = end;
-		error = mlock_fixup(vma, &prev, nstart, tmp, newflags);
-		if (error)
-			break;
-		nstart = tmp;
-		if (nstart < prev->vm_end)
-			nstart = prev->vm_end;
-		if (nstart >= end)
+next:
+		if(vma->vm_end ==end)
 			break;
+		prev =vma;
+		vma =vma->vm_next;
 
-		vma = prev->vm_next;
-		if (!vma || vma->vm_start != nstart) {
-			error = -ENOMEM;
-			break;
+		/* If called from munlockall,
+		 * we may jump over holes.
+		 */
+		if(jump_hole){
+			if(!vma)
+				goto out;
+			else
+				continue;
+		}
+		else if (!vma || (vma->vm_start != prev->vm_end) ){
+			ret= -ENOMEM;
+			goto out;
 		}
 	}
-	return error;
+
+out:
+	pprev =&prev;
+	vma = find_vma_prev(current->mm, start, pprev);
+
+	while( vma && vma->vm_end <= vmoff ){
+			if(!ret && vma->vm_wire_change){
+	    		if (!(vma->vm_flags & VM_IO))
+					make_pages_unwired(mm, vma->vm_start, vma->vm_end);
+				vma->vm_flags &=~VM_LOCKED;
+			}
+			vma->vm_wire_change =0;
+			next = vma->vm_next;
+			if(next){ 
+				if(!ret && next->vm_wire_change){
+		    		if (!(next->vm_flags & VM_IO))
+						make_pages_unwired(mm, next->vm_start,next->vm_end);
+					next->vm_flags &=~VM_LOCKED;
+				}
+				next->vm_wire_change =0;
+			}
+		*pprev =vma_merge(mm, *pprev, vma->vm_start, vma->vm_end, vma->vm_flags,
+		vma->anon_vma,vma->vm_file, vma->vm_pgoff, vma_policy(vma));
+		if(*pprev)
+			vma =*pprev;
+		vma =vma->vm_next;
+	}
+
+	if(!ret)
+		mm->locked_vm -= pages;
+	
+	return ret;
 }
 
 asmlinkage long sys_mlock(unsigned long start, size_t len)
@@ -141,7 +232,7 @@
 
 	/* check against resource limits */
 	if ((locked <= lock_limit) || capable(CAP_IPC_LOCK))
-		error = do_mlock(start, len, 1);
+		error = do_mlock(start, len, 0);
 	up_write(&current->mm->mmap_sem);
 	return error;
 }
@@ -153,33 +244,41 @@
 	down_write(&current->mm->mmap_sem);
 	len = PAGE_ALIGN(len + (start & ~PAGE_MASK));
 	start &= PAGE_MASK;
-	ret = do_mlock(start, len, 0);
+	ret = do_munlock(start, len,0);
 	up_write(&current->mm->mmap_sem);
 	return ret;
 }
 
 static int do_mlockall(int flags)
 {
-	struct vm_area_struct * vma, * prev = NULL;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct * vma;
 	unsigned int def_flags = 0;
+	unsigned long start;
+	int ret = 0;
 
 	if (flags & MCL_FUTURE)
 		def_flags = VM_LOCKED;
-	current->mm->def_flags = def_flags;
+	mm->def_flags = def_flags;
 	if (flags == MCL_FUTURE)
 		goto out;
+	vma=mm->mmap;
+	start = vma->vm_start;
+	ret=do_mlock(start,TASK_SIZE,1);
+out:
+	return ret;
+}
 
-	for (vma = current->mm->mmap; vma ; vma = prev->vm_next) {
-		unsigned int newflags;
-
-		newflags = vma->vm_flags | VM_LOCKED;
-		if (!(flags & MCL_CURRENT))
-			newflags &= ~VM_LOCKED;
+static int do_munlockall(void)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct * vma;
+	unsigned long start;
+
+	vma=mm->mmap;
+	start = vma->vm_start;
+	do_munlock(start,TASK_SIZE,1);
 
-		/* Ignore errors */
-		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
-	}
-out:
 	return 0;
 }
 
@@ -214,7 +313,7 @@
 	int ret;
 
 	down_write(&current->mm->mmap_sem);
-	ret = do_mlockall(0);
+	ret = do_munlockall();
 	up_write(&current->mm->mmap_sem);
 	return ret;
 }
diff -urN --exclude-from=./exclude.files linux-2.6.15/mm/mmap.c /home/backup/linux-2.6.15-release/mm/mmap.c
--- linux-2.6.15/mm/mmap.c	2006-02-17 05:24:09.000000000 -0500
+++ /home/backup/linux-2.6.15-release/mm/mmap.c	2006-03-06 06:30:08.000000000 -0500
@@ -1119,7 +1119,7 @@
 	vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += len >> PAGE_SHIFT;
-		make_pages_present(addr, addr + len);
+		make_pages_wired(addr, addr + len);
 	}
 	if (flags & MAP_POPULATE) {
 		up_write(&mm->mmap_sem);
@@ -1551,7 +1551,7 @@
 	if (!prev || expand_stack(prev, addr))
 		return NULL;
 	if (prev->vm_flags & VM_LOCKED) {
-		make_pages_present(addr, prev->vm_end);
+		make_pages_wired(addr, prev->vm_end);
 	}
 	return prev;
 }
@@ -1614,7 +1614,7 @@
 	if (expand_stack(vma, addr))
 		return NULL;
 	if (vma->vm_flags & VM_LOCKED) {
-		make_pages_present(addr, start);
+		make_pages_wired(addr, start);
 	}
 	return vma;
 }
@@ -1921,7 +1921,7 @@
 	mm->total_vm += len >> PAGE_SHIFT;
 	if (flags & VM_LOCKED) {
 		mm->locked_vm += len >> PAGE_SHIFT;
-		make_pages_present(addr, addr + len);
+		make_pages_wired(addr, addr + len);
 	}
 	return addr;
 }
diff -urN --exclude-from=./exclude.files linux-2.6.15/mm/mremap.c /home/backup/linux-2.6.15-release/mm/mremap.c
--- linux-2.6.15/mm/mremap.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/mm/mremap.c	2006-03-06 06:30:08.000000000 -0500
@@ -230,7 +230,7 @@
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += new_len >> PAGE_SHIFT;
 		if (new_len > old_len)
-			make_pages_present(new_addr + old_len,
+			make_pages_wired(new_addr + old_len,
 					   new_addr + new_len);
 	}
 
@@ -367,7 +367,7 @@
 			vm_stat_account(mm, vma->vm_flags, vma->vm_file, pages);
 			if (vma->vm_flags & VM_LOCKED) {
 				mm->locked_vm += pages;
-				make_pages_present(addr + old_len,
+				make_pages_wired(addr + old_len,
 						   addr + new_len);
 			}
 			ret = addr;
diff -urN --exclude-from=./exclude.files linux-2.6.15/mm/nommu.c /home/backup/linux-2.6.15-release/mm/nommu.c
--- linux-2.6.15/mm/nommu.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/mm/nommu.c	2006-03-06 06:30:08.000000000 -0500
@@ -124,7 +124,7 @@
  * The nommu dodgy version :-)
  */
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
-	unsigned long start, int len, int write, int force,
+	unsigned long start, int len, int force,
 	struct page **pages, struct vm_area_struct **vmas)
 {
 	int i;
diff -urN --exclude-from=./exclude.files linux-2.6.15/mm/page_alloc.c /home/backup/linux-2.6.15-release/mm/page_alloc.c
--- linux-2.6.15/mm/page_alloc.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/mm/page_alloc.c	2006-03-06 06:30:08.000000000 -0500
@@ -348,7 +348,8 @@
 			1 << PG_slab	|
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_reserved )))
+			1 << PG_reserved |
+			1 << PG_wired )))
 		bad_page(function, page);
 	if (PageDirty(page))
 		__ClearPageDirty(page);
@@ -481,6 +482,7 @@
 			1 << PG_private	|
 			1 << PG_locked	|
 			1 << PG_active	|
+			1 << PG_wired   |
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
 			1 << PG_slab    |
@@ -1252,35 +1254,39 @@
 EXPORT_SYMBOL(__mod_page_state);
 
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free, struct pglist_data *pgdat)
+			unsigned long *wired,unsigned long *free, struct pglist_data *pgdat)
 {
 	struct zone *zones = pgdat->node_zones;
 	int i;
 
 	*active = 0;
 	*inactive = 0;
+	*wired = 0;
 	*free = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		*active += zones[i].nr_active;
 		*inactive += zones[i].nr_inactive;
+		*wired += zones[i].nr_wired;
 		*free += zones[i].free_pages;
 	}
 }
 
 void get_zone_counts(unsigned long *active,
-		unsigned long *inactive, unsigned long *free)
+		unsigned long *inactive, unsigned long *wired, unsigned long *free)
 {
 	struct pglist_data *pgdat;
 
 	*active = 0;
 	*inactive = 0;
+	*wired = 0;
 	*free = 0;
 	for_each_pgdat(pgdat) {
-		unsigned long l, m, n;
-		__get_zone_counts(&l, &m, &n, pgdat);
+		unsigned long l, m, n, o;
+		__get_zone_counts(&l, &m, &n, &o, pgdat);
 		*active += l;
 		*inactive += m;
-		*free += n;
+		*wired += n;
+		*free += o;
 	}
 }
 
@@ -1328,6 +1334,7 @@
 	int cpu, temperature;
 	unsigned long active;
 	unsigned long inactive;
+	unsigned long wired;
 	unsigned long free;
 	struct zone *zone;
 
@@ -1358,16 +1365,17 @@
 	}
 
 	get_page_state(&ps);
-	get_zone_counts(&active, &inactive, &free);
+	get_zone_counts(&active, &inactive, &wired, &free);
 
 	printk("Free pages: %11ukB (%ukB HighMem)\n",
 		K(nr_free_pages()),
 		K(nr_free_highpages()));
 
-	printk("Active:%lu inactive:%lu dirty:%lu writeback:%lu "
+	printk("Active:%lu inactive:%lu wired:%lu dirty:%lu writeback:%lu "
 		"unstable:%lu free:%u slab:%lu mapped:%lu pagetables:%lu\n",
 		active,
 		inactive,
+		wired,
 		ps.nr_dirty,
 		ps.nr_writeback,
 		ps.nr_unstable,
@@ -1387,6 +1395,7 @@
 			" high:%lukB"
 			" active:%lukB"
 			" inactive:%lukB"
+			" wired:%lukB"
 			" present:%lukB"
 			" pages_scanned:%lu"
 			" all_unreclaimable? %s"
@@ -1398,6 +1407,7 @@
 			K(zone->pages_high),
 			K(zone->nr_active),
 			K(zone->nr_inactive),
+			K(zone->nr_wired),
 			K(zone->present_pages),
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
@@ -2009,10 +2019,12 @@
 		zone_pcp_init(zone);
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
+		INIT_LIST_HEAD(&zone->wired_list);
 		zone->nr_scan_active = 0;
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		zone->nr_wired = 0;
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2161,6 +2173,7 @@
 			   "\n        high     %lu"
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
+			   "\n        wired    %lu"
 			   "\n        scanned  %lu (a: %lu i: %lu)"
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
@@ -2170,6 +2183,7 @@
 			   zone->pages_high,
 			   zone->nr_active,
 			   zone->nr_inactive,
+			   zone->nr_wired,
 			   zone->pages_scanned,
 			   zone->nr_scan_active, zone->nr_scan_inactive,
 			   zone->spanned_pages,
diff -urN --exclude-from=./exclude.files linux-2.6.15/mm/readahead.c /home/backup/linux-2.6.15-release/mm/readahead.c
--- linux-2.6.15/mm/readahead.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/mm/readahead.c	2006-03-06 06:30:08.000000000 -0500
@@ -564,8 +564,9 @@
 {
 	unsigned long active;
 	unsigned long inactive;
+	unsigned long wired;
 	unsigned long free;
 
-	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
+	__get_zone_counts(&active, &inactive, &wired, &free, NODE_DATA(numa_node_id()));
 	return min(nr, (inactive + free) / 2);
 }
diff -urN --exclude-from=./exclude.files linux-2.6.15/mm/rmap.c /home/backup/linux-2.6.15-release/mm/rmap.c
--- linux-2.6.15/mm/rmap.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/mm/rmap.c	2006-03-07 06:17:57.000000000 -0500
@@ -449,6 +449,8 @@
 		struct anon_vma *anon_vma = vma->anon_vma;
 
 		BUG_ON(!anon_vma);
+		if((vma->vm_flags & VM_LOCKED) && !vma->vm_wire_change)
+	        wire_page(page);
 		anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 		page->mapping = (struct address_space *) anon_vma;
 
@@ -465,11 +467,13 @@
  *
  * The caller needs to hold the pte lock.
  */
-void page_add_file_rmap(struct page *page)
+void page_add_file_rmap(struct page *page, struct vm_area_struct *vma)
 {
 	BUG_ON(PageAnon(page));
 	BUG_ON(!pfn_valid(page_to_pfn(page)));
 
+	if((vma->vm_flags & VM_LOCKED) && !vma->vm_wire_change)
+		wire_page(page);
 	if (atomic_inc_and_test(&page->_mapcount))
 		inc_page_state(nr_mapped);
 }
@@ -480,8 +484,11 @@
  *
  * The caller needs to hold the pte lock.
  */
-void page_remove_rmap(struct page *page)
+void page_remove_rmap(struct page *page, struct vm_area_struct *vma)
 {
+	if(PageWired(page) && (vma->vm_flags&VM_LOCKED))
+		unwire_page(page);
+
 	if (atomic_add_negative(-1, &page->_mapcount)) {
 		BUG_ON(page_mapcount(page) < 0);
 		/*
@@ -562,7 +569,7 @@
 	} else
 		dec_mm_counter(mm, file_rss);
 
-	page_remove_rmap(page);
+	page_remove_rmap(page, vma);
 	page_cache_release(page);
 
 out_unmap:
@@ -652,7 +659,7 @@
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page);
+		page_remove_rmap(page, vma);
 		page_cache_release(page);
 		dec_mm_counter(mm, file_rss);
 		(*mapcount)--;
@@ -712,8 +719,10 @@
 
 	list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
 						shared.vm_set.list) {
-		if (vma->vm_flags & VM_LOCKED)
-			continue;
+
+		/* If VM_LOCKED set, the page will be moved to Wired list.*/
+		if (vma->vm_flags & VM_LOCKED) 
+			continue;                  
 		cursor = (unsigned long) vma->vm_private_data;
 		if (cursor > max_nl_cursor)
 			max_nl_cursor = cursor;
diff -urN --exclude-from=./exclude.files linux-2.6.15/mm/swap.c /home/backup/linux-2.6.15-release/mm/swap.c
--- linux-2.6.15/mm/swap.c	2006-01-02 22:21:10.000000000 -0500
+++ /home/backup/linux-2.6.15-release/mm/swap.c	2006-03-07 11:45:37.000000000 -0500
@@ -110,6 +110,44 @@
 	spin_unlock_irq(&zone->lru_lock);
 }
 
+/* Wire the page; if the page is in LRU,
+ * try move it to Wired list. 
+ */
+void fastcall wire_page(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+
+	spin_lock_irq(&zone->lru_lock);
+	page->wired_count ++;
+	if(!PageWired(page)){
+		if(PageLRU(page)){
+			del_page_from_lru(zone, page);
+			add_page_to_wired_list(zone,page);
+			SetPageWired(page);
+		}
+	}
+	spin_unlock_irq(&zone->lru_lock);
+}
+
+/* Unwire the page.
+ * If it isnt wired by any process, try move it to active list.
+ */
+void fastcall unwire_page(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+
+	spin_lock_irq(&zone->lru_lock);
+	page->wired_count --;
+	if(!page->wired_count){
+		if(PageLRU(page) && TestClearPageWired(page)){
+			del_page_from_wired_list(zone,page);
+			add_page_to_active_list(zone,page);
+			SetPageActive(page);
+		}
+	}
+	spin_unlock_irq(&zone->lru_lock);
+}
+
 /*
  * Mark a page as having seen activity.
  *
@@ -119,11 +157,13 @@
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
-		ClearPageReferenced(page);
-	} else if (!PageReferenced(page)) {
-		SetPageReferenced(page);
+	if(!PageWired(page)) {
+		if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
+			activate_page(page);
+			ClearPageReferenced(page);
+		} else if (!PageReferenced(page)) {
+			SetPageReferenced(page);
+		}
 	}
 }
 
@@ -178,13 +218,15 @@
 	struct zone *zone = page_zone(page);
 
 	spin_lock_irqsave(&zone->lru_lock, flags);
-	if (TestClearPageLRU(page))
-		del_page_from_lru(zone, page);
-	if (page_count(page) != 0)
-		page = NULL;
+	if(!PageWired(page)) {
+		if (TestClearPageLRU(page))
+			del_page_from_lru(zone, page);
+		if (page_count(page) != 0)
+			page = NULL;
+		if (page)
+			free_hot_page(page);
+	}
 	spin_unlock_irqrestore(&zone->lru_lock, flags);
-	if (page)
-		free_hot_page(page);
 }
 
 EXPORT_SYMBOL(__page_cache_release);
@@ -214,7 +256,8 @@
 
 		if (!put_page_testzero(page))
 			continue;
-
+		if(PageWired(page))
+			continue;
 		pagezone = page_zone(page);
 		if (pagezone != zone) {
 			if (zone)
@@ -301,7 +344,12 @@
 		}
 		if (TestSetPageLRU(page))
 			BUG();
-		add_page_to_inactive_list(zone, page);
+		if(!page->wired_count)
+			add_page_to_inactive_list(zone, page);
+		else {
+			SetPageWired(page);
+			add_page_to_wired_list(zone,page);
+		}
 	}
 	if (zone)
 		spin_unlock_irq(&zone->lru_lock);
@@ -330,7 +378,12 @@
 			BUG();
 		if (TestSetPageActive(page))
 			BUG();
-		add_page_to_active_list(zone, page);
+		if(!page->wired_count)
+			add_page_to_active_list(zone, page);
+		else{
+			SetPageWired(page);
+			add_page_to_wired_list(zone,page);
+		}
 	}
 	if (zone)
 		spin_unlock_irq(&zone->lru_lock);

------=_Part_2415_25109497.1142861758330--
