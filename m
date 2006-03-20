Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWCTNhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWCTNhV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWCTNhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:37:21 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:33265 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751145AbWCTNhS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:37:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tM9JSHJB0cjKDAh0yXc4wd0fd0QJaEhUcQ6yI89FD6ow+D9m0FFkHPbmBaQRGhECr9X5N+2DbLbW2XVF2ejs1e6b/YsaxfyLcp1mikvNgKuwhuz/dPBhLZZqsEIWF8VkfQ1S5cWFGHDZU2nSRxvJkXZOH+yVjowYYMJoCUbPyyA=
Message-ID: <bc56f2f0603200537g35d2bfd5m@mail.gmail.com>
Date: Mon, 20 Mar 2006 08:37:16 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: akpm@osdl.org
Subject: [PATCH][3/8] mm: get_user_pages interface change
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust references of get_user_pages.

Signed-off-by: Shaoping Wang <pwstone@gmail.com>

--
 arch/cris/arch-v32/drivers/cryptocop.c      |    2 ++
 drivers/infiniband/core/uverbs_mem.c        |    2 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c |    2 +-
 drivers/media/video/video-buf.c             |    2 +-
 drivers/scsi/sg.c                           |    1 +
 drivers/scsi/st.c                           |    1 +
 drivers/video/pvr2fb.c                      |    2 +-
 fs/aio.c                                    |    2 +-
 fs/binfmt_elf.c                             |    2 +-
 fs/bio.c                                    |    2 +-
 fs/direct-io.c                              |    1 +
 fs/fuse/dev.c                               |    2 +-
 fs/fuse/file.c                              |    2 +-
 fs/nfs/direct.c                             |    2 +-
 kernel/futex.c                              |    2 +-
 kernel/ptrace.c                             |    2 +-
 mm/mempolicy.c                              |    2 +-
 mm/nommu.c                                  |    2 +-
 18 files changed, 19 insertions(+), 14 deletions(-)


diff -urN linux-2.6.15.orig/arch/cris/arch-v32/drivers/cryptocop.c
linux-2.6.15/arch/cris/arch-v32/drivers/cryptocop.c
--- linux-2.6.15.orig/arch/cris/arch-v32/drivers/cryptocop.c	2006-01-02
22:21:10.000000000 -0500
+++ linux-2.6.15/arch/cris/arch-v32/drivers/cryptocop.c	2006-03-06
08:38:48.000000000 -0500
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
diff -urN linux-2.6.15.orig/drivers/infiniband/core/uverbs_mem.c
linux-2.6.15/drivers/infiniband/core/uverbs_mem.c
--- linux-2.6.15.orig/drivers/infiniband/core/uverbs_mem.c	2006-01-02
22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/infiniband/core/uverbs_mem.c	2006-03-06
08:40:06.000000000 -0500
@@ -110,7 +110,7 @@
 		ret = get_user_pages(current, current->mm, cur_base,
 				     min_t(int, npages,
 					   PAGE_SIZE / sizeof (struct page *)),
-				     1, !write, page_list, NULL);
+				     1, !write, 0, page_list, NULL);

 		if (ret < 0)
 			goto out;
diff -urN linux-2.6.15.orig/drivers/infiniband/hw/mthca/mthca_memfree.c
linux-2.6.15/drivers/infiniband/hw/mthca/mthca_memfree.c
--- linux-2.6.15.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2006-01-02
22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/infiniband/hw/mthca/mthca_memfree.c	2006-03-06
08:41:10.000000000 -0500
@@ -396,7 +396,7 @@
 		goto out;
 	}

-	ret = get_user_pages(current, current->mm, uaddr & PAGE_MASK, 1, 1, 0,
+	ret = get_user_pages(current, current->mm, uaddr & PAGE_MASK, 1, 1, 0, 0,
 			     &db_tab->page[i].mem.page, NULL);
 	if (ret < 0)
 		goto out;
diff -urN linux-2.6.15.orig/drivers/media/video/video-buf.c
linux-2.6.15/drivers/media/video/video-buf.c
--- linux-2.6.15.orig/drivers/media/video/video-buf.c	2006-01-02
22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/media/video/video-buf.c	2006-03-06
08:41:54.000000000 -0500
@@ -149,7 +149,7 @@
 	down_read(&current->mm->mmap_sem);
 	err = get_user_pages(current,current->mm,
 			     data & PAGE_MASK, dma->nr_pages,
-			     rw == READ, 1, /* force */
+			     rw == READ, 1, 0, /* force,do not set wire */
 			     dma->pages, NULL);
 	up_read(&current->mm->mmap_sem);
 	if (err != dma->nr_pages) {
diff -urN linux-2.6.15.orig/drivers/scsi/sg.c linux-2.6.15/drivers/scsi/sg.c
--- linux-2.6.15.orig/drivers/scsi/sg.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/scsi/sg.c	2006-03-06 08:09:43.000000000 -0500
@@ -1815,6 +1815,7 @@
 		nr_pages,
 		rw == READ,
 		0, /* don't force */
+		0,
 		pages,
 		NULL);
 	up_read(&current->mm->mmap_sem);
diff -urN linux-2.6.15.orig/drivers/scsi/st.c linux-2.6.15/drivers/scsi/st.c
--- linux-2.6.15.orig/drivers/scsi/st.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/scsi/st.c	2006-03-06 07:57:47.000000000 -0500
@@ -4453,6 +4453,7 @@
 		nr_pages,
 		rw == READ,
 		0, /* don't force */
+		0,
 		pages,
 		NULL);
 	up_read(&current->mm->mmap_sem);
diff -urN linux-2.6.15.orig/drivers/video/pvr2fb.c
linux-2.6.15/drivers/video/pvr2fb.c
--- linux-2.6.15.orig/drivers/video/pvr2fb.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/video/pvr2fb.c	2006-03-06 08:42:53.000000000 -0500
@@ -690,7 +690,7 @@
 	
 	down_read(&current->mm->mmap_sem);
 	ret = get_user_pages(current, current->mm, (unsigned long)buf,
-			     nr_pages, WRITE, 0, pages, NULL);
+			     nr_pages, WRITE, 0, 0, pages, NULL);
 	up_read(&current->mm->mmap_sem);

 	if (ret < nr_pages) {
diff -urN linux-2.6.15.orig/fs/aio.c linux-2.6.15/fs/aio.c
--- linux-2.6.15.orig/fs/aio.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/fs/aio.c	2006-03-06 06:30:06.000000000 -0500
@@ -146,7 +146,7 @@
 	dprintk("mmap address: 0x%08lx\n", info->mmap_base);
 	info->nr_pages = get_user_pages(current, ctx->mm,
 					info->mmap_base, nr_pages,
-					1, 0, info->ring_pages, NULL);
+					1, 0, 0, info->ring_pages, NULL);
 	up_write(&ctx->mm->mmap_sem);

 	if (unlikely(info->nr_pages != nr_pages)) {
diff -urN linux-2.6.15.orig/fs/binfmt_elf.c linux-2.6.15/fs/binfmt_elf.c
--- linux-2.6.15.orig/fs/binfmt_elf.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/fs/binfmt_elf.c	2006-03-06 06:30:06.000000000 -0500
@@ -1600,7 +1600,7 @@
 			struct page* page;
 			struct vm_area_struct *vma;

-			if (get_user_pages(current, current->mm, addr, 1, 0, 1,
+			if (get_user_pages(current, current->mm, addr, 1, 0, 1, 0,
 						&page, &vma) <= 0) {
 				DUMP_SEEK (file->f_pos + PAGE_SIZE);
 			} else {
diff -urN linux-2.6.15.orig/fs/bio.c linux-2.6.15/fs/bio.c
--- linux-2.6.15.orig/fs/bio.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/fs/bio.c	2006-03-06 06:30:06.000000000 -0500
@@ -608,7 +608,7 @@
 		down_read(&current->mm->mmap_sem);
 		ret = get_user_pages(current, current->mm, uaddr,
 				     local_nr_pages,
-				     write_to_vm, 0, &pages[cur_page], NULL);
+				     write_to_vm, 0, 0, &pages[cur_page], NULL);
 		up_read(&current->mm->mmap_sem);

 		if (ret < local_nr_pages)
diff -urN linux-2.6.15.orig/fs/direct-io.c linux-2.6.15/fs/direct-io.c
--- linux-2.6.15.orig/fs/direct-io.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/fs/direct-io.c	2006-03-06 06:30:06.000000000 -0500
@@ -157,6 +157,7 @@
 		nr_pages,			/* How many pages? */
 		dio->rw == READ,		/* Write to memory? */
 		0,				/* force (?) */
+		0,
 		&dio->pages[0],
 		NULL);				/* vmas */
 	up_read(&current->mm->mmap_sem);
diff -urN linux-2.6.15.orig/fs/fuse/dev.c linux-2.6.15/fs/fuse/dev.c
--- linux-2.6.15.orig/fs/fuse/dev.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/fs/fuse/dev.c	2006-03-06 06:30:07.000000000 -0500
@@ -462,7 +462,7 @@
 		cs->nr_segs --;
 	}
 	down_read(&current->mm->mmap_sem);
-	err = get_user_pages(current, current->mm, cs->addr, 1, cs->write, 0,
+	err = get_user_pages(current, current->mm, cs->addr, 1, cs->write, 0, 0,
 			     &cs->pg, NULL);
 	up_read(&current->mm->mmap_sem);
 	if (err < 0)
diff -urN linux-2.6.15.orig/fs/fuse/file.c linux-2.6.15/fs/fuse/file.c
--- linux-2.6.15.orig/fs/fuse/file.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/fs/fuse/file.c	2006-03-06 06:30:07.000000000 -0500
@@ -457,7 +457,7 @@
 	npages = min(npages, FUSE_MAX_PAGES_PER_REQ);
 	down_read(&current->mm->mmap_sem);
 	npages = get_user_pages(current, current->mm, user_addr, npages, write,
-				0, req->pages, NULL);
+				0, 0, req->pages, NULL);
 	up_read(&current->mm->mmap_sem);
 	if (npages < 0)
 		return npages;
diff -urN linux-2.6.15.orig/fs/nfs/direct.c linux-2.6.15/fs/nfs/direct.c
--- linux-2.6.15.orig/fs/nfs/direct.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/fs/nfs/direct.c	2006-03-06 06:30:07.000000000 -0500
@@ -104,7 +104,7 @@
 	if (*pages) {
 		down_read(&current->mm->mmap_sem);
 		result = get_user_pages(current, current->mm, user_addr,
-					page_count, (rw == READ), 0,
+					page_count, (rw == READ), 0, 0,
 					*pages, NULL);
 		up_read(&current->mm->mmap_sem);
 	}
diff -urN linux-2.6.15.orig/kernel/futex.c linux-2.6.15/kernel/futex.c
--- linux-2.6.15.orig/kernel/futex.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/kernel/futex.c	2006-03-06 06:30:07.000000000 -0500
@@ -201,7 +201,7 @@
 	 * from swap.  But that's a lot of code to duplicate here
 	 * for a rare case, so we simply fetch the page.
 	 */
-	err = get_user_pages(current, mm, uaddr, 1, 0, 0, &page, NULL);
+	err = get_user_pages(current, mm, uaddr, 1, 0, 0, 0, &page, NULL);
 	if (err >= 0) {
 		key->shared.pgoff =
 			page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
diff -urN linux-2.6.15.orig/kernel/ptrace.c linux-2.6.15/kernel/ptrace.c
--- linux-2.6.15.orig/kernel/ptrace.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/kernel/ptrace.c	2006-03-06 06:30:07.000000000 -0500
@@ -228,7 +228,7 @@
 		void *maddr;

 		ret = get_user_pages(tsk, mm, addr, 1,
-				write, 1, &page, &vma);
+				write, 1, 0, &page, &vma);
 		if (ret <= 0)
 			break;

diff -urN linux-2.6.15.orig/mm/nommu.c linux-2.6.15/mm/nommu.c
--- linux-2.6.15.orig/mm/nommu.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/nommu.c	2006-03-06 06:30:08.000000000 -0500
@@ -124,7 +124,7 @@
  * The nommu dodgy version :-)
  */
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
-	unsigned long start, int len, int write, int force,
+	unsigned long start, int len, int force,
 	struct page **pages, struct vm_area_struct **vmas)
 {
 	int i;
diff -urN linux-2.6.15.orig/mm/mempolicy.c linux-2.6.15/mm/mempolicy.c
--- linux-2.6.15.orig/mm/mempolicy.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/mempolicy.c	2006-03-06 06:30:08.000000000 -0500
@@ -440,7 +440,7 @@
 	struct page *p;
 	int err;

-	err = get_user_pages(current, mm, addr & PAGE_MASK, 1, 0, 0, &p, NULL);
+	err = get_user_pages(current, mm, addr & PAGE_MASK, 1, 0, 0, 0, &p, NULL);
 	if (err >= 0) {
 		err = page_to_nid(p);
 		put_page(p);
