Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270067AbRHQKVH>; Fri, 17 Aug 2001 06:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270090AbRHQKU6>; Fri, 17 Aug 2001 06:20:58 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:50950 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S270067AbRHQKUt>;
	Fri, 17 Aug 2001 06:20:49 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 17 Aug 2001 12:18:58 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] zero-bounce highmem I/O
Message-ID: <20010817121858.A17795@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15XOZJ-0005LW-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 03:56:21PM +0100, Alan Cox wrote:
> > It is video layer, and the video layer should be helping along with
> > these sorts of issues.
> 
> Linus refused to let make make the vmalloc helpers generic code, thats
> why we have 8 or 9 different copies some containing old bugs

:-(

> > void video_pci_put_user_pages(struct pci_dev *pdev,
> > 			      struct scatterlist *sg,
> > 			      int npages);
> 
> Why video_pci. WHy is this even video related. This is a generic issue

I've moved current bttv's mm stuff to another source file and removed
any bttv-related stuff.  Compiles, but isn't fully tested yet.  The
first three functions are pretty generic.  The videomm_buf probably
isn't useful for anything but video4linux.  Depends on the highmem-io
patches as it uses the new scatterlist->page.

Comments?  Put that into videodev.[ch] ?

  Gerd

------------------------ cut here -----------------------
--- /dev/null	Thu Jan  1 01:00:00 1970
+++ video-mm.h	Fri Aug 17 11:57:02 2001
@@ -0,0 +1,47 @@
+/*
+ * memory management helpers for video4linux drivers (+others?)
+ */
+
+/*
+ * get the page for a kernel virtual address
+ * (i.e. for vmalloc()ed memory)
+ */
+struct page* videomm_vmalloc_to_page(unsigned long virt);
+
+/*
+ * return a scatterlist for vmalloc()'ed memory block.
+ */
+struct scatterlist* videomm_vmalloc_to_sg(unsigned long virt, int nr_pages);
+
+/*
+ * return a scatterlist for a iobuf
+ */
+struct scatterlist* videomm_iobuf_to_sg(struct kiobuf *iobuf);
+
+/* --------------------------------------------------------------------- */
+
+struct videomm_buf {
+	/* for userland buffer */
+	struct kiobuf       *iobuf;
+
+	/* for kernel buffers */
+	void*               *vmalloc;
+
+	/* common */
+	struct scatterlist  *sglist;
+	int                 sglen;
+	int                 nr_pages;
+};
+
+int videomm_init_user_buf(struct videomm_buf *vbuf, unsigned long data,
+			  unsigned long size);
+int videomm_init_kernel_buf(struct videomm_buf *vbuf, int nr_pages);
+int videomm_pci_map_buf(struct pci_dev *dev, struct videomm_buf *vbuf);
+int videomm_pci_unmap_buf(struct pci_dev *dev, struct videomm_buf *vbuf);
+int videomm_free_buf(struct videomm_buf *vbuf);
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
--- /dev/null	Thu Jan  1 01:00:00 1970
+++ video-mm.c	Fri Aug 17 11:57:14 2001
@@ -0,0 +1,183 @@
+#include <linux/pci.h>
+#include <linux/iobuf.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+#include "video-mm.h"
+
+struct page*
+videomm_vmalloc_to_page(unsigned long virt)
+{
+	struct page *ret = NULL;
+	pmd_t *pmd;
+	pte_t *pte;
+	pgd_t *pgd;
+	
+	pgd = pgd_offset_k(virt);
+	if (!pgd_none(*pgd)) {
+		pmd = pmd_offset(pgd, virt);
+		if (!pmd_none(*pmd)) {
+			pte = pte_offset(pmd, virt);
+			if (pte_present(*pte)) {
+				ret = pte_page(*pte);
+			}
+		}
+	}
+	return ret;
+}
+
+struct scatterlist*
+videomm_vmalloc_to_sg(unsigned long virt, int nr_pages)
+{
+	struct scatterlist *sglist;
+	struct page *pg;
+	int i;
+
+	sglist = kmalloc(sizeof(struct scatterlist)*nr_pages, GFP_KERNEL);
+	if (NULL == sglist)
+		return NULL;
+	memset(sglist,0,sizeof(struct scatterlist)*nr_pages);
+	for (i = 0; i < nr_pages; i++, virt += PAGE_SIZE) {
+		pg = videomm_vmalloc_to_page(virt);
+		if (NULL == pg)
+			goto err;
+		sglist[i].page   = pg;
+		sglist[i].length = PAGE_SIZE;
+	}
+	return sglist;
+	
+ err:
+	kfree(sglist);
+	return NULL;
+}
+
+#if 1
+/*
+ * this is temporary hack only until there is something generic
+ * for that ...
+ */
+# if defined(__i386__)
+#  define NO_DMA(page) (((page) - mem_map) > (0xffffffff >> PAGE_SHIFT))
+# else
+#  define NO_DMA(page) (0)
+# endif
+#endif
+
+struct scatterlist*
+videomm_iobuf_to_sg(struct kiobuf *iobuf)
+{
+	struct scatterlist *sglist;
+	int i;
+
+	sglist = kmalloc(sizeof(struct scatterlist) * iobuf->nr_pages,
+			 GFP_KERNEL);
+	if (NULL == sglist)
+		return NULL;
+	memset(sglist,0,sizeof(struct scatterlist) * iobuf->nr_pages);
+
+	if (NO_DMA(iobuf->maplist[0]))
+		goto no_dma;
+	sglist[0].page   = iobuf->maplist[0];
+	sglist[0].offset = iobuf->offset;
+	sglist[0].length = PAGE_SIZE - iobuf->offset;
+	for (i = 1; i < iobuf->nr_pages; i++) {
+		if (NO_DMA(iobuf->maplist[i]))
+			goto no_dma;
+		sglist[i].page   = iobuf->maplist[i];
+		sglist[i].length = PAGE_SIZE;
+	}
+	return sglist;
+
+ no_dma:
+	/* FIXME: find a more elegant way than simply fail. */
+	kfree(sglist);
+	return NULL;
+}
+
+/* --------------------------------------------------------------------- */
+
+int videomm_init_user_buf(struct videomm_buf *vbuf, unsigned long data,
+			  unsigned long size)
+{
+	int err;
+
+	if (0 != (err = alloc_kiovec(1,&vbuf->iobuf)))
+		return err;
+	if (0 != (err = map_user_kiobuf(READ, vbuf->iobuf, data, size)))
+		return err;
+	vbuf->nr_pages = vbuf->iobuf->nr_pages;
+	return 0;
+}
+
+int videomm_init_kernel_buf(struct videomm_buf *vbuf, int nr_pages)
+{
+	vbuf->vmalloc = vmalloc_32(nr_pages << PAGE_SHIFT);
+	if (NULL == vbuf->vmalloc)
+		return -ENOMEM;
+	vbuf->nr_pages = nr_pages;
+	return 0;
+}
+
+int videomm_pci_map_buf(struct pci_dev *dev, struct videomm_buf *vbuf)
+{
+	int err;
+
+	if (0 == vbuf->nr_pages)
+		BUG();
+	
+	if (vbuf->iobuf) {
+		if (0 != (err = lock_kiovec(1,&vbuf->iobuf,1)))
+			return err;
+		vbuf->sglist = videomm_iobuf_to_sg(vbuf->iobuf);
+	}
+	if (vbuf->vmalloc) {
+		vbuf->sglist = videomm_vmalloc_to_sg
+			((unsigned long)vbuf->vmalloc,vbuf->nr_pages);
+	}
+	if (NULL == vbuf->sglist)
+		return -ENOMEM;
+	vbuf->sglen = pci_map_sg(dev,vbuf->sglist,vbuf->nr_pages,
+				 PCI_DMA_FROMDEVICE);
+	return 0;
+}
+
+int videomm_pci_unmap_buf(struct pci_dev *dev, struct videomm_buf *vbuf)
+{
+	if (!vbuf->sglen)
+		BUG();
+
+	pci_unmap_sg(dev,vbuf->sglist,vbuf->iobuf->nr_pages,
+		     PCI_DMA_FROMDEVICE);
+	kfree(vbuf->sglist);
+	vbuf->sglist = NULL;
+	vbuf->sglen = 0;
+	if (vbuf->iobuf)
+		unlock_kiovec(1,&vbuf->iobuf);
+	return 0;
+}
+
+int videomm_free_buf(struct videomm_buf *vbuf)
+{
+	if (vbuf->sglen)
+		BUG();
+
+	if (vbuf->iobuf) {
+		unmap_kiobuf(vbuf->iobuf);
+		free_kiovec(1,&vbuf->iobuf);
+		vbuf->iobuf = NULL;
+	}
+	if (vbuf->vmalloc) {
+		vfree(vbuf->vmalloc);
+		vbuf->vmalloc = NULL;
+	}
+	return 0;
+}
+
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
