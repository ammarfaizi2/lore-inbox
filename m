Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbSLDX4y>; Wed, 4 Dec 2002 18:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267162AbSLDX4y>; Wed, 4 Dec 2002 18:56:54 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:61660 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267159AbSLDX4m>; Wed, 4 Dec 2002 18:56:42 -0500
Date: Thu, 5 Dec 2002 01:03:26 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Updated and improved page-walk API (was: 2.5.50-mm1)
Message-ID: <20021205010326.A15158@nightmaster.csn.tu-chemnitz.de>
References: <3DEC53A0.C038571@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3DEC53A0.C038571@digeo.com>; from akpm@digeo.com on Mon, Dec 02, 2002 at 10:48:00PM -0800
X-Spam-Score: -3.9 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18JjUt-00079t-00*dhzybg16tlA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew,
hi list readers,

On Mon, Dec 02, 2002 at 10:48:00PM -0800, Andrew Morton wrote:
>  A bugfix.  (Ingo, the page-walk API probably needs updating for
>  mm/nommu.c)

I don't know exactly which paths of the page-walk API are walked
by the nommu stuff. 

The changes in mm/mmap.c and mm/mlock.c are really necessary,
even if you don't plan to apply this patch.

I implemented some comments from Kai, Doug, Gerd and you. I hope
the current implementation is now more valuable and correct.

If I need to implement the complete API also for nommu, then I
could also implement it for the vmalloc() space, because this is
nearly the same, what do you think?

This time I could only check compilation, because gcc 2.95.2 has problems
compiling fs/readdir.c and I had to back it out, leaving an unusable kernel
behind.

diffstat:

 drivers/scsi/sg.c         |   57 +++++++++---------------
 drivers/scsi/st.c         |   56 +++++++++++------------
 drivers/scsi/st.h         |    3 +
 include/linux/page_walk.h |   15 ++++--
 mm/mlock.c                |    2
 mm/mmap.c                 |    4 -
 mm/nommu.c                |   18 ++++++-
 mm/page_walk.c            |  108 ++++++++++++++++++++++++++++++++++------------
 8 files changed, 163 insertions, 100 deletions

Patch against 2.5.50-mm1 is attached.

Thanks for your efforts!

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="page-walk-api-2.5.50-mm1.patch"

diff -Naur linux-2.5.50-mm1/drivers/scsi/sg.c linux-2.5.50-mm1-ioe/drivers/scsi/sg.c
--- linux-2.5.50-mm1/drivers/scsi/sg.c	Tue Dec  3 23:14:22 2002
+++ linux-2.5.50-mm1-ioe/drivers/scsi/sg.c	Thu Dec  5 00:11:12 2002
@@ -138,6 +138,9 @@
 	unsigned b_malloc_len;	/* actual len malloc'ed in buffer */
 	void *buffer;		/* Data buffer or scatter list (k_use_sg>0) */
 	char dio_in_use;	/* 0->indirect IO (or mmap), 1->dio */
+#ifdef SG_ALLOW_DIO_CODE
+	struct gup_add_sgls gup;/* used if dio_in_use == 1, else garbage -ioe */
+#endif /* SG_ALLOW_DIO_CODE */
 	unsigned char cmd_opcode; /* first byte of command */
 } Sg_scatter_hold;
 
@@ -227,7 +230,6 @@
 static inline unsigned sg_jif_to_ms(int jifs);
 static int sg_allow_access(unsigned char opcode, char dev_type);
 static int sg_build_direct(Sg_request * srp, Sg_fd * sfp, int dxfer_len);
-// static void sg_unmap_and(Sg_scatter_hold * schp, int free_also);
 static Sg_device *sg_get_dev(int dev);
 static inline unsigned char *sg_scatg2virt(const struct scatterlist *sclp);
 #ifdef CONFIG_PROC_FS
@@ -1652,7 +1654,6 @@
 	Sg_scatter_hold *req_schp = &srp->data;
 
 	SCSI_LOG_TIMEOUT(4, printk("sg_finish_rem_req: res_used=%d\n", (int) srp->res_used));
-	// sg_unmap_and(&srp->data, 1);
 	if (srp->res_used)
 		sg_unlink_reserve(sfp, srp);
 	else
@@ -1690,49 +1691,39 @@
    (i.e., either completely successful or fails)
 */
 static int 
-sg_map_user_pages(struct scatterlist *sgl, const unsigned int max_sgls, 
+sg_map_user_pages(Sg_scatter_hold *schp, const unsigned int max_sgls, 
 	          unsigned long uaddr, size_t count, int rw)
 {
-	struct gup_add_sgls gup;
+	struct gup_add_sgls *gup = &schp->gup;
 	int ret;
 	
-	sgl = setup_sgl_page_walk(&gup, uaddr, uaddr+count, rw == READ, sgl);
-	
-	/* We need a bigger scatterlist vector. 
-	 * Caller should split requests. It might also be handled by this
-	 * function, but this requires a rewrite of the callers. -ioe
-	 */
-	if (gup.max_sgls > max_sgls)
-		return -ENOMEM;
+	setup_sgl_page_walk(gup, 
+			uaddr, 
+			uaddr + count, 
+			rw == READ,
+			(struct scatterlist *)schp->buffer,
+			max_sgls,
+			ULONG_MAX);
 	
 	down_read(&current->mm->mmap_sem);
-	/* If error, we return it, but the sgl is already used! */
-	ret = walk_user_pages(&gup.pw);
+	ret = walk_user_pages(&gup->pw);
 	up_read(&current->mm->mmap_sem);
-	if (ret >= 0)
-		fixup_sgl_walk(&gup, uaddr, uaddr + count);
 
-	return (ret < 0) ? ret : gup.count;
+	/* If gup->todo */
+	return (ret < 0) ? ret : gup->count;
 }
 
 
 /* And unmap them... */
 static int 
-sg_unmap_user_pages(struct scatterlist *sgl, const unsigned int nr_pages,
-		    int dirtied)
+sg_unmap_user_pages(Sg_scatter_hold *schp, unsigned int dirtied)
 {
-	int i;
-
-	for (i=0; i < nr_pages; i++) {
-		if (dirtied && !PageReserved(sgl[i].page))
-			SetPageDirty(sgl[i].page);
-		/* unlock_page(sgl[i].page); */
-		/* FIXME: cache flush missing for rw==READ
-		 * FIXME: call the correct reference counting function
-		 */
-		page_cache_release(sgl[i].page);
-	}
+	struct gup_add_sgls *gup = &schp->gup;
 
+	/* Reading from VM doesn't dirty it's pages! -ioe */
+	if (gup->pw.vm_flags & (VM_READ|VM_MAYREAD)) dirtied = 0;
+	
+	cleanup_sgl_page_walk(gup, dirtied);
 	return 0;
 }
 
@@ -1748,15 +1739,13 @@
 	sg_io_hdr_t *hp = &srp->header;
 	Sg_scatter_hold *schp = &srp->data;
 	int sg_tablesize = sfp->parentdp->sg_tablesize;
-	struct scatterlist *sgl;
 	int mx_sc_elems, res;
 
 	mx_sc_elems = sg_build_sgat(schp, sfp, sg_tablesize);
         if (mx_sc_elems <= 0) {
                 return 1;
         }
-	sgl = (struct scatterlist *)schp->buffer;
-	res = sg_map_user_pages(sgl, mx_sc_elems, (unsigned long)hp->dxferp, 
+	res = sg_map_user_pages(schp, mx_sc_elems, (unsigned long)hp->dxferp, 
 			dxfer_len, 
 			(SG_DXFER_TO_DEV == hp->dxfer_direction) ? 1 : 0);
 	if (res <= 0)
@@ -1978,7 +1967,7 @@
 
 		if (schp->dio_in_use) {
 #ifdef SG_ALLOW_DIO_CODE
-			sg_unmap_user_pages(sclp, schp->k_use_sg, TRUE);
+			sg_unmap_user_pages(schp, schp->k_use_sg);
 #endif
 		} else {
 			int k;
diff -Naur linux-2.5.50-mm1/drivers/scsi/st.c linux-2.5.50-mm1-ioe/drivers/scsi/st.c
--- linux-2.5.50-mm1/drivers/scsi/st.c	Tue Dec  3 23:14:22 2002
+++ linux-2.5.50-mm1-ioe/drivers/scsi/st.c	Thu Dec  5 00:09:35 2002
@@ -25,8 +25,6 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/page_walk.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/errno.h>
@@ -164,9 +162,9 @@
 static int from_buffer(ST_buffer *, char *, int);
 static void buf_to_sg(ST_buffer *, unsigned int);
 
-static int st_map_user_pages(struct scatterlist *, const unsigned int, 
+static int st_map_user_pages(ST_buffer *, const unsigned int, 
 			     unsigned long, size_t, int, unsigned long);
-static int st_unmap_user_pages(struct scatterlist *, const unsigned int, int);
+static int st_unmap_user_pages(ST_buffer*, unsigned int);
 
 static int st_attach(Scsi_Device *);
 static void st_detach(Scsi_Device *);
@@ -1321,12 +1319,17 @@
 	ST_mode *STm;
 	ST_partstat *STps;
 	ST_buffer *STbp;
+	struct gup_add_sgls gup;
 	char *name = tape_name(STp);
 
 	if (down_interruptible(&STp->lock))
 		return -ERESTARTSYS;
 
 	retval = rw_checks(STp, filp, count, ppos);
+
+	STbp = STp->buffer;
+	STbp->gup = &gup;
+
 	if (retval || count == 0)
 		goto out;
 
@@ -1369,7 +1372,6 @@
 		}
 	}
 
-	STbp = STp->buffer;
 	if (STbp->writing) {
 		write_behind_check(STp);
 		if (STbp->syscall_result) {
@@ -1565,7 +1567,7 @@
 		scsi_release_request(SRpnt);
 	STbp = STp->buffer;
 	if (STbp->do_dio) {
-		st_unmap_user_pages(&(STbp->sg[0]), STbp->do_dio, FALSE);
+		st_unmap_user_pages(STbp, 0);
 		STbp->do_dio = 0;
 	}
 	up(&STp->lock);
@@ -1760,8 +1762,11 @@
 	ST_mode *STm;
 	ST_partstat *STps;
 	ST_buffer *STbp = STp->buffer;
+	struct gup_add_sgls gup;
 	DEB( char *name = tape_name(STp); )
 
+	STbp->gup = &gup;
+
 	if (down_interruptible(&STp->lock))
 		return -ERESTARTSYS;
 
@@ -1884,7 +1889,7 @@
 		SRpnt = NULL;
 	}
 	if (STbp->do_dio) {
-		st_unmap_user_pages(&(STbp->sg[0]), STbp->do_dio, TRUE);
+		st_unmap_user_pages(STbp, STbp->do_dio);
 		STbp->do_dio = 0;
 		STbp->buffer_bytes = 0;
 	}
@@ -3971,45 +3976,38 @@
    - any page is above max_pfn
    (i.e., either completely successful or fails)
 */
-static int st_map_user_pages(struct scatterlist *sgl, const unsigned int max_pages, 
+static int st_map_user_pages(ST_buffer *STbp, const unsigned int max_pages, 
 			     unsigned long uaddr, size_t count, int rw,
 			     unsigned long max_pfn)
 {
-	struct gup_add_sgls gup;
+	struct gup_add_sgls *gup = STbp->gup;
+	int ret;
 	
-	sgl = setup_sgl_page_walk(&gup, uaddr, uaddr+count, rw == READ, sgl);
-	gup.max_pfn = max_pfn;
+	setup_sgl_page_walk(gup, 
+			uaddr, 
+			uaddr + count, 
+			rw == READ, 
+			&(STbp->sg[0]), 
+			max_pages,
+			max_pfn);
 	
 	down_read(&current->mm->mmap_sem);
 
 	/* If error, we return it, but the sgl is already used! */
-	if (walk_user_pages(&gup.pw) < 0) gup.count = 0;
-	else fixup_sgl_walk(&gup, uaddr, uaddr + count);
+	ret = walk_user_pages(&gup->pw);
 	
 	up_read(&current->mm->mmap_sem);
 
-	return gup.count;
+	return (ret < 0) ? ret : gup->count;
 }
 
 
 /* And unmap them... */
-/* FIXME: This function should not know those gory vm details, 
- * 	but setup_buffering and the read/write functions must be rewritten for
- * 	this. -ioe 
- */
-static int st_unmap_user_pages(struct scatterlist *sgl, const unsigned int nr_pages,
-				int dirtied)
+static int st_unmap_user_pages(ST_buffer *STbp, unsigned int dirtied)
 {
-	int i;
+	struct gup_add_sgls *gup = STbp->gup;
 
-	for (i=0; i < nr_pages; i++) {
-		if (dirtied && !PageReserved(sgl[i].page))
-			SetPageDirty(sgl[i].page);
-		/* FIXME: cache flush missing for rw==READ
-		 * FIXME: call the correct reference counting function
-		 */
-		page_cache_release(sgl[i].page);
-	}
+	cleanup_sgl_page_walk(gup, dirtied);
 
 	return 0;
 }
diff -Naur linux-2.5.50-mm1/drivers/scsi/st.h linux-2.5.50-mm1-ioe/drivers/scsi/st.h
--- linux-2.5.50-mm1/drivers/scsi/st.h	Mon Nov 11 04:28:29 2002
+++ linux-2.5.50-mm1-ioe/drivers/scsi/st.h	Wed Dec  4 16:19:02 2002
@@ -7,6 +7,8 @@
 #endif
 #include <linux/devfs_fs_kernel.h>
 #include <linux/completion.h>
+#include <linux/mm.h>
+#include <linux/page_walk.h>
 
 /* The tape buffer descriptor. */
 typedef struct {
@@ -28,6 +30,7 @@
 	unsigned short frp_segs;	/* number of buffer segments */
 	unsigned int frp_sg_current;	/* driver buffer length currently in s/g list */
 	struct st_buf_fragment *frp;	/* the allocated buffer fragment list */
+	struct gup_add_sgls *gup;	/* for DIO */
 	struct scatterlist sg[1];	/* MUST BE last item */
 } ST_buffer;
 
diff -Naur linux-2.5.50-mm1/include/linux/page_walk.h linux-2.5.50-mm1-ioe/include/linux/page_walk.h
--- linux-2.5.50-mm1/include/linux/page_walk.h	Tue Dec  3 23:14:22 2002
+++ linux-2.5.50-mm1-ioe/include/linux/page_walk.h	Wed Dec  4 23:19:15 2002
@@ -58,10 +58,12 @@
 };
 
 struct gup_add_sgls {
+	unsigned long max_pfn;
 	unsigned int count;
 	unsigned int max_sgls;
-	unsigned int max_pfn;
+	unsigned int dirtied;
 	struct scatterlist *sgl;
+	unsigned long todo;
 	struct page_walk pw;
 };
 
@@ -69,9 +71,14 @@
 setup_simple_page_walk(struct gup_add_pages *gup, unsigned long start,
 		unsigned long end, int write);
 
+void cleanup_simple_page_walk(struct gup_add_pages *gup);
+
 struct scatterlist *
 setup_sgl_page_walk(struct gup_add_sgls *gup, unsigned long start,
-		unsigned long end, int write, struct scatterlist *def);
+		unsigned long end, int write, struct scatterlist *def,
+		unsigned int max_entries, unsigned long max_pfn);
+
+void cleanup_sgl_page_walk(struct gup_add_sgls *gup, unsigned int dirtied);
 
 /* Legacy */
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, 
@@ -82,9 +89,7 @@
 #ifdef CONFIG_HUGETLB_PAGE
 int follow_hugetlb_page(struct page_walk *pw);
 #else
-#define follow_hugetlb_page(pw)			({ BUG(); 0; })
+#define follow_hugetlb_page(pw)			(0)
 #endif
 
-void fixup_sgl_walk(struct gup_add_sgls *gup,
-		unsigned long start, unsigned long end);
 #endif /* _LINUX_PAGE_WALK_H */
diff -Naur linux-2.5.50-mm1/mm/mlock.c linux-2.5.50-mm1-ioe/mm/mlock.c
--- linux-2.5.50-mm1/mm/mlock.c	Tue Dec  3 23:14:22 2002
+++ linux-2.5.50-mm1-ioe/mm/mlock.c	Wed Dec  4 22:58:13 2002
@@ -40,7 +40,7 @@
 	pages = (end - start) >> PAGE_SHIFT;
 	if (newflags & VM_LOCKED) {
 		pages = -pages;
-		make_pages_present(start, end, vma);
+		make_pages_present(start, end, NULL);
 	}
 
 	vma->vm_mm->locked_vm -= pages;
diff -Naur linux-2.5.50-mm1/mm/mmap.c linux-2.5.50-mm1-ioe/mm/mmap.c
--- linux-2.5.50-mm1/mm/mmap.c	Tue Dec  3 23:14:22 2002
+++ linux-2.5.50-mm1-ioe/mm/mmap.c	Wed Dec  4 22:49:22 2002
@@ -512,8 +512,6 @@
 			break;
 		}
 	}
-	vma = NULL; /* needed for out-label */
-
 	error = security_file_mmap(file, prot, flags);
 	if (error)
 		return error;
@@ -527,6 +525,8 @@
 			return -ENOMEM;
 		goto munmap_back;
 	}
+	vma = NULL; /* needed for out-label */
+
 #ifdef CONFIG_SHAREPTE
 	clear_share_range(mm, addr, len);
 #endif
diff -Naur linux-2.5.50-mm1/mm/nommu.c linux-2.5.50-mm1-ioe/mm/nommu.c
--- linux-2.5.50-mm1/mm/nommu.c	Tue Dec  3 23:14:22 2002
+++ linux-2.5.50-mm1-ioe/mm/nommu.c	Thu Dec  5 00:43:20 2002
@@ -98,8 +98,8 @@
  * The nommu dodgy version :-)
  */
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
-	unsigned long start, int len, int write, int force,
-	struct page **pages, struct vm_area_struct **vmas)
+	unsigned long start, int len, int write,
+	struct page **pages)
 {
 	int i;
 
@@ -111,7 +111,19 @@
 		}
 		start += PAGE_SIZE;
 	}
-	return(i);
+	return i;
+}
+
+struct page *get_one_user_page(struct task_struct *tsk,
+			   struct vm_area_struct *vma, int vm_flags,
+			   unsigned long start) {
+	struct page *page = virt_to_page(start);
+
+	if (page)
+		page_cache_get(page);
+	else page = ERR_PTR(-EFAULT);
+
+	return page;
 }
 
 rwlock_t vmlist_lock = RW_LOCK_UNLOCKED;
diff -Naur linux-2.5.50-mm1/mm/page_walk.c linux-2.5.50-mm1-ioe/mm/page_walk.c
--- linux-2.5.50-mm1/mm/page_walk.c	Tue Dec  3 23:14:22 2002
+++ linux-2.5.50-mm1-ioe/mm/page_walk.c	Wed Dec  4 23:20:24 2002
@@ -18,29 +18,13 @@
 #include <asm/tlbflush.h>
 #include <asm/scatterlist.h>
 
-/* This is required after a SUCCESSFUL collection of SGL entries.
- * Driver authors often get this wrong, so we provide it here. */
-void fixup_sgl_walk(struct gup_add_sgls *gup,
-		unsigned long start, unsigned long end) {
-
-	unsigned long count = end - start;
-	
-	gup->sgl[0].offset = start & ~PAGE_MASK;
-
-	/* Page crossing */
-	if (gup->count > 1) {
-		count -= (PAGE_SIZE - gup->sgl[0].offset);
-		count -= (gup->count - 2) * PAGE_SIZE;
-	}
-
-	gup->sgl[gup->count - 1].length = count;
-}
-
 void gup_cleanup_pages(void *data)
 {
 	struct gup_add_pages *gup = data;
 	while (gup->count--) {
 		page_cache_release(gup->pages[gup->count]);
+		/* FIXME This is only to ease debugging. -ioe */
+		gup->pages[gup->count] = NULL;
 	}
 }
 
@@ -49,6 +33,7 @@
 	struct gup_add_pages *gup = data;
 	gup_cleanup_pages(data);
 	kfree(gup->pages);
+	gup->pages = NULL;
 }
 
 /* Simple page walk handler adding pages to a list of them */
@@ -68,8 +53,25 @@
 void gup_cleanup_sgls(void *data)
 {
 	struct gup_add_sgls *gup = data;
+	gup->count -= gup->dirtied;
+
+	/* We expect the dirtied page to be the first ones.
+	 * This is ok, because it is the case for all callers until now.
+	 * If this changes, we must change the behavior here and in the setup.
+	 */
+	while (gup->dirtied--) {
+		if (!PageReserved(gup->sgl[gup->dirtied].page)) {
+			set_page_dirty(gup->sgl[gup->dirtied].page);
+			page_cache_release(gup->sgl[gup->dirtied].page);
+		}
+		gup->sgl[gup->dirtied].page = NULL;
+	}
+
 	while (gup->count--) {
-		page_cache_release(gup->sgl[gup->count].page);
+		if (!PageReserved(gup->sgl[gup->count].page)) {
+			page_cache_release(gup->sgl[gup->count].page);
+		}
+		gup->sgl[gup->count].page = NULL;
 	}
 }
 
@@ -78,6 +80,32 @@
 	struct gup_add_sgls *gup = data;
 	gup_cleanup_sgls(data);
 	kfree(gup->sgl);
+	gup->sgl = NULL;
+}
+
+/* This is required after a SUCCESSFUL collection of SGL entries.
+ * Driver authors often get this wrong, so we provide it here. 
+ */
+static void fixup_sgl_walk(struct gup_add_sgls *gup) {
+
+	gup->sgl[0].offset = gup->pw.virt & ~PAGE_MASK;
+	gup->sgl[0].length = PAGE_SIZE - (gup->pw.virt & ~PAGE_MASK);
+
+	/* Page crossing */
+	if (gup->count > 1) {
+		gup->todo -= (PAGE_SIZE - gup->sgl[0].offset);
+		gup->todo -= (gup->count - 2) * PAGE_SIZE;
+	}
+
+	/* Fixup length of last or only page. */
+	if (gup->todo < PAGE_SIZE) {
+		gup->sgl[gup->count - 1].length = gup->todo;
+		/* No more pages to walk */
+		gup->todo = 0;
+	} else {
+		/* We will continue the page walk, if gup->todo > 0 */
+		gup->todo-= PAGE_SIZE;
+	}
 }
 
 int gup_add_sgls(void *data)
@@ -103,7 +131,12 @@
 	gup->count++;
 
 	/* Abort if we cannot hold more sgls */
-	return (gup->count == gup->max_sgls) ? 1 : 0;
+	if (gup->count == gup->max_sgls) {
+		fixup_sgl_walk(gup);
+		return 1;
+	} else {
+		return 0;
+	}
 }
 
 /* Try to fault in the page at START. Returns valid page or ERR_PTR().
@@ -117,7 +150,7 @@
 	int write = pw->vm_flags & (VM_MAYWRITE|VM_WRITE);
 
 	/* follow_page also does all the checking of ptes for us. */
-	while (!(page= follow_page(vma->vm_mm, pw->virt, write))) {
+	while (!(page = follow_page(vma->vm_mm, pw->virt, write))) {
 		int fault;
 
 		spin_unlock(&vma->vm_mm->page_table_lock);
@@ -169,6 +202,11 @@
 	return gup->pages;
 }
 
+void cleanup_simple_page_walk(struct gup_add_pages *gup) {
+	BUG_ON(!gup->pw.cleaner);
+	gup->pw.cleaner(gup);
+}
+
 /* Setup page walking for collection into struct scatterlist. 
  *
  * The user just needs to modify everything he changes. If he changes too much
@@ -177,13 +215,18 @@
  */
 struct scatterlist *
 setup_sgl_page_walk(struct gup_add_sgls *gup, unsigned long start,
-		unsigned long end, int write, struct scatterlist *def) {
+		unsigned long end, int write, struct scatterlist *def,
+		unsigned int max_entries, unsigned long max_pfn) {
 
-	gup->max_sgls = (end + PAGE_SIZE - 1) / PAGE_SIZE - start / PAGE_SIZE;
-	gup->max_pfn = ULONG_MAX;
 	gup->count = 0;
-	gup->sgl=def ?: kmalloc(gup->max_sgls * sizeof(gup->sgl[0]),GFP_KERNEL);
+	gup->max_sgls = (end + PAGE_SIZE - 1)/PAGE_SIZE - start/PAGE_SIZE;
+
+	if (def && (max_entries < gup->max_sgls)) gup->max_sgls = max_entries;
 
+	gup->max_pfn = max_pfn;
+	gup->dirtied = 0;
+	gup->todo = end - start;
+	gup->sgl=def ?: kmalloc(gup->max_sgls * sizeof(gup->sgl[0]),GFP_KERNEL);
 	gup->pw.page = 0;
 	gup->pw.virt = start;
 	gup->pw.vma = 0;
@@ -196,6 +239,18 @@
 
 	return gup->sgl;
 }
+
+void cleanup_sgl_page_walk(struct gup_add_sgls *gup, unsigned int dirtied) {
+	/* This does only cause non-sense writeouts, 
+	 * but doesn't corrupt data. 
+	 */
+	WARN_ON(dirtied && (gup->pw.vm_flags & (VM_READ|VM_MAYREAD)));
+	gup->dirtied = dirtied;
+
+	BUG_ON(!gup->pw.cleaner);
+	gup->pw.cleaner(gup);
+}
+
 /* VMA contains already "start".
  * (e.g. find_extend_vma(mm,start) has been called sucessfully already 
  */
@@ -387,8 +442,9 @@
 EXPORT_SYMBOL(get_one_user_page);
 EXPORT_SYMBOL_GPL(walk_user_pages);
 EXPORT_SYMBOL_GPL(setup_simple_page_walk);
+EXPORT_SYMBOL_GPL(cleanup_simple_page_walk);
 EXPORT_SYMBOL_GPL(setup_sgl_page_walk);
-EXPORT_SYMBOL_GPL(fixup_sgl_walk);
+EXPORT_SYMBOL_GPL(cleanup_sgl_page_walk);
 EXPORT_SYMBOL_GPL(gup_add_pages);
 EXPORT_SYMBOL_GPL(gup_cleanup_pages);
 EXPORT_SYMBOL_GPL(gup_cleanup_pages_kfree);

--y0ulUmNC+osPPQO6--
