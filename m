Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWI1QDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWI1QDf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbWI1QCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:02:44 -0400
Received: from mx.pathscale.com ([64.160.42.68]:2998 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751920AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 17 of 28] IB/ipath - improved support for powerpc
X-Mercurial-Node: f6794c8289abafda12be13911ef7de5c67df0799
Message-Id: <f6794c8289abafda12be.1159459213@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:13 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r cdbbf110848d -r f6794c8289ab drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
@@ -755,8 +755,8 @@ static inline void *ipath_get_egrbuf(str
 static inline void *ipath_get_egrbuf(struct ipath_devdata *dd, u32 bufnum,
 				     int err)
 {
-	return dd->ipath_port0_skbs ?
-		(void *)dd->ipath_port0_skbs[bufnum]->data : NULL;
+	return dd->ipath_port0_skbinfo ?
+		(void *) dd->ipath_port0_skbinfo[bufnum].skb->data : NULL;
 }
 
 /**
@@ -778,31 +778,34 @@ struct sk_buff *ipath_alloc_skb(struct i
 	 */
 
 	/*
-	 * We need 4 extra bytes for unaligned transfer copying
+	 * We need 2 extra bytes for ipath_ether data sent in the
+	 * key header.  In order to keep everything dword aligned,
+	 * we'll reserve 4 bytes.
 	 */
+	len = dd->ipath_ibmaxlen + 4;
+
 	if (dd->ipath_flags & IPATH_4BYTE_TID) {
-		/* we need a 4KB multiple alignment, and there is no way
+		/* We need a 2KB multiple alignment, and there is no way
 		 * to do it except to allocate extra and then skb_reserve
 		 * enough to bring it up to the right alignment.
 		 */
-		len = dd->ipath_ibmaxlen + 4 + (1 << 11) - 1;
-	}
-	else
-		len = dd->ipath_ibmaxlen + 4;
+		len += 2047;
+	}
+
 	skb = __dev_alloc_skb(len, gfp_mask);
 	if (!skb) {
 		ipath_dev_err(dd, "Failed to allocate skbuff, length %u\n",
 			      len);
 		goto bail;
 	}
+
+	skb_reserve(skb, 4);
+
 	if (dd->ipath_flags & IPATH_4BYTE_TID) {
-		u32 una = ((1 << 11) - 1) & (unsigned long)(skb->data + 4);
+		u32 una = (unsigned long)skb->data & 2047;
 		if (una)
-			skb_reserve(skb, 4 + (1 << 11) - una);
-		else
-			skb_reserve(skb, 4);
-	} else
-		skb_reserve(skb, 4);
+			skb_reserve(skb, 2048 - una);
+	}
 
 bail:
 	return skb;
@@ -1345,8 +1348,9 @@ int ipath_create_rcvhdrq(struct ipath_de
 		ipath_cdbg(VERBOSE, "reuse port %d rcvhdrq @%p %llx phys; "
 			   "hdrtailaddr@%p %llx physical\n",
 			   pd->port_port, pd->port_rcvhdrq,
-			   pd->port_rcvhdrq_phys, pd->port_rcvhdrtail_kvaddr,
-			   (unsigned long long)pd->port_rcvhdrqtailaddr_phys);
+			   (unsigned long long) pd->port_rcvhdrq_phys,
+			   pd->port_rcvhdrtail_kvaddr, (unsigned long long)
+			   pd->port_rcvhdrqtailaddr_phys);
 
 	/* clear for security and sanity on each use */
 	memset(pd->port_rcvhdrq, 0, pd->port_rcvhdrq_size);
@@ -1827,17 +1831,22 @@ void ipath_free_pddata(struct ipath_devd
 		kfree(pd->port_rcvegrbuf_phys);
 		pd->port_rcvegrbuf_phys = NULL;
 		pd->port_rcvegrbuf_chunks = 0;
-	} else if (pd->port_port == 0 && dd->ipath_port0_skbs) {
+	} else if (pd->port_port == 0 && dd->ipath_port0_skbinfo) {
 		unsigned e;
-		struct sk_buff **skbs = dd->ipath_port0_skbs;
-
-		dd->ipath_port0_skbs = NULL;
-		ipath_cdbg(VERBOSE, "free closed port %d ipath_port0_skbs "
-			   "@ %p\n", pd->port_port, skbs);
+		struct ipath_skbinfo *skbinfo = dd->ipath_port0_skbinfo;
+
+		dd->ipath_port0_skbinfo = NULL;
+		ipath_cdbg(VERBOSE, "free closed port %d "
+			   "ipath_port0_skbinfo @ %p\n", pd->port_port,
+			   skbinfo);
 		for (e = 0; e < dd->ipath_rcvegrcnt; e++)
-			if (skbs[e])
-				dev_kfree_skb(skbs[e]);
-		vfree(skbs);
+		if (skbinfo[e].skb) {
+			pci_unmap_single(dd->pcidev, skbinfo[e].phys,
+					 dd->ipath_ibmaxlen,
+					 PCI_DMA_FROMDEVICE);
+			dev_kfree_skb(skbinfo[e].skb);
+		}
+		vfree(skbinfo);
 	}
 	kfree(pd->port_tid_pg_list);
 	vfree(pd->subport_uregbase);
@@ -1934,7 +1943,7 @@ static void cleanup_device(struct ipath_
 
 	if (dd->ipath_pioavailregs_dma) {
 		dma_free_coherent(&dd->pcidev->dev, PAGE_SIZE,
-				  dd->ipath_pioavailregs_dma,
+				  (void *) dd->ipath_pioavailregs_dma,
 				  dd->ipath_pioavailregs_phys);
 		dd->ipath_pioavailregs_dma = NULL;
 	}
@@ -1947,6 +1956,7 @@ static void cleanup_device(struct ipath_
 
 	if (dd->ipath_pageshadow) {
 		struct page **tmpp = dd->ipath_pageshadow;
+		dma_addr_t *tmpd = dd->ipath_physshadow;
 		int i, cnt = 0;
 
 		ipath_cdbg(VERBOSE, "Unlocking any expTID pages still "
@@ -1957,6 +1967,8 @@ static void cleanup_device(struct ipath_
 			for (i = port_tidbase; i < maxtid; i++) {
 				if (!tmpp[i])
 					continue;
+				pci_unmap_page(dd->pcidev, tmpd[i],
+					       PAGE_SIZE, PCI_DMA_FROMDEVICE);
 				ipath_release_user_pages(&tmpp[i], 1);
 				tmpp[i] = NULL;
 				cnt++;
diff -r cdbbf110848d -r f6794c8289ab drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Sep 28 08:57:12 2006 -0700
@@ -364,11 +364,14 @@ static int ipath_tid_update(struct ipath
 			   "vaddr %lx\n", i, tid + tidoff, vaddr);
 		/* we "know" system pages and TID pages are same size */
 		dd->ipath_pageshadow[porttid + tid] = pagep[i];
+		dd->ipath_physshadow[porttid + tid] = ipath_map_page(
+			dd->pcidev, pagep[i], 0, PAGE_SIZE,
+			PCI_DMA_FROMDEVICE);
 		/*
 		 * don't need atomic or it's overhead
 		 */
 		__set_bit(tid, tidmap);
-		physaddr = page_to_phys(pagep[i]);
+		physaddr = dd->ipath_physshadow[porttid + tid];
 		ipath_stats.sps_pagelocks++;
 		ipath_cdbg(VERBOSE,
 			   "TID %u, vaddr %lx, physaddr %llx pgp %p\n",
@@ -402,6 +405,9 @@ static int ipath_tid_update(struct ipath
 					   tid);
 				dd->ipath_f_put_tid(dd, &tidbase[tid], 1,
 						    dd->ipath_tidinvalid);
+				pci_unmap_page(dd->pcidev,
+					dd->ipath_physshadow[porttid + tid],
+					PAGE_SIZE, PCI_DMA_FROMDEVICE);
 				dd->ipath_pageshadow[porttid + tid] = NULL;
 				ipath_stats.sps_pageunlocks++;
 			}
@@ -515,6 +521,9 @@ static int ipath_tid_free(struct ipath_p
 				   pd->port_pid, tid);
 			dd->ipath_f_put_tid(dd, &tidbase[tid], 1,
 					    dd->ipath_tidinvalid);
+			pci_unmap_page(dd->pcidev,
+				dd->ipath_physshadow[porttid + tid],
+				PAGE_SIZE, PCI_DMA_FROMDEVICE);
 			ipath_release_user_pages(
 				&dd->ipath_pageshadow[porttid + tid], 1);
 			dd->ipath_pageshadow[porttid + tid] = NULL;
@@ -711,7 +720,7 @@ static int ipath_manage_rcvq(struct ipat
 		 * updated and correct itself, even in the face of software
 		 * bugs.
 		 */
-		*pd->port_rcvhdrtail_kvaddr = 0;
+		*(volatile u64 *)pd->port_rcvhdrtail_kvaddr = 0;
 		set_bit(INFINIPATH_R_PORTENABLE_SHIFT + pd->port_port,
 			&dd->ipath_rcvctrl);
 	} else
@@ -923,11 +932,11 @@ bail:
 
 /* common code for the mappings on dma_alloc_coherent mem */
 static int ipath_mmap_mem(struct vm_area_struct *vma,
-			     struct ipath_portdata *pd, unsigned len,
-			     int write_ok, dma_addr_t addr, char *what)
+	struct ipath_portdata *pd, unsigned len, int write_ok,
+	void *kvaddr, char *what)
 {
 	struct ipath_devdata *dd = pd->port_dd;
-	unsigned pfn = (unsigned long)addr >> PAGE_SHIFT;
+	unsigned long pfn;
 	int ret;
 
 	if ((vma->vm_end - vma->vm_start) > len) {
@@ -950,17 +959,17 @@ static int ipath_mmap_mem(struct vm_area
 		vma->vm_flags &= ~VM_MAYWRITE;
 	}
 
+	pfn = virt_to_phys(kvaddr) >> PAGE_SHIFT;
 	ret = remap_pfn_range(vma, vma->vm_start, pfn,
 			      len, vma->vm_page_prot);
 	if (ret)
-		dev_info(&dd->pcidev->dev,
-			 "%s port%u mmap of %lx, %x bytes r%c failed: %d\n",
-			 what, pd->port_port, (unsigned long)addr, len,
-			 write_ok?'w':'o', ret);
+		dev_info(&dd->pcidev->dev, "%s port%u mmap of %lx, %x "
+			 "bytes r%c failed: %d\n", what, pd->port_port,
+			 pfn, len, write_ok?'w':'o', ret);
 	else
-		ipath_cdbg(VERBOSE, "%s port%u mmaped %lx, %x bytes r%c\n",
-			what, pd->port_port, (unsigned long)addr, len,
-			 write_ok?'w':'o');
+		ipath_cdbg(VERBOSE, "%s port%u mmaped %lx, %x bytes "
+			   "r%c\n", what, pd->port_port, pfn, len,
+			   write_ok?'w':'o');
 bail:
 	return ret;
 }
@@ -1049,7 +1058,7 @@ static int mmap_rcvegrbufs(struct vm_are
 	struct ipath_devdata *dd = pd->port_dd;
 	unsigned long start, size;
 	size_t total_size, i;
-	dma_addr_t *phys;
+	unsigned long pfn;
 	int ret;
 
 	size = pd->port_rcvegrbuf_size;
@@ -1073,11 +1082,11 @@ static int mmap_rcvegrbufs(struct vm_are
 	vma->vm_flags &= ~VM_MAYWRITE;
 
 	start = vma->vm_start;
-	phys = pd->port_rcvegrbuf_phys;
 
 	for (i = 0; i < pd->port_rcvegrbuf_chunks; i++, start += size) {
-		ret = remap_pfn_range(vma, start, phys[i] >> PAGE_SHIFT,
-				      size, vma->vm_page_prot);
+		pfn = virt_to_phys(pd->port_rcvegrbuf[i]) >> PAGE_SHIFT;
+		ret = remap_pfn_range(vma, start, pfn, size,
+				      vma->vm_page_prot);
 		if (ret < 0)
 			goto bail;
 	}
@@ -1290,7 +1299,7 @@ static int ipath_mmap(struct file *fp, s
 	else if (pgaddr == dd->ipath_pioavailregs_phys)
 		/* in-memory copy of pioavail registers */
 		ret = ipath_mmap_mem(vma, pd, PAGE_SIZE, 0,
-			      	     dd->ipath_pioavailregs_phys,
+			      	     (void *) dd->ipath_pioavailregs_dma,
 				     "pioavail registers");
 	else if (subport_fp(fp))
 		/* Subports don't mmap the physical receive buffers */
@@ -1304,12 +1313,12 @@ static int ipath_mmap(struct file *fp, s
 		 * from an i/o perspective.
 		 */
 		ret = ipath_mmap_mem(vma, pd, pd->port_rcvhdrq_size, 1,
-				     pd->port_rcvhdrq_phys,
+				     pd->port_rcvhdrq,
 				     "rcvhdrq");
 	else if (pgaddr == (u64) pd->port_rcvhdrqtailaddr_phys)
 		/* in-memory copy of rcvhdrq tail register */
 		ret = ipath_mmap_mem(vma, pd, PAGE_SIZE, 0,
-				     pd->port_rcvhdrqtailaddr_phys,
+				     pd->port_rcvhdrtail_kvaddr,
 				     "rcvhdrq tail");
 	else
 		ret = -EINVAL;
@@ -1802,7 +1811,7 @@ static int ipath_do_user_init(struct fil
 	 * We explictly set the in-memory copy to 0 beforehand, so we don't
 	 * have to wait to be sure the DMA update has happened.
 	 */
-	*pd->port_rcvhdrtail_kvaddr = 0ULL;
+	*(volatile u64 *)pd->port_rcvhdrtail_kvaddr = 0ULL;
 	set_bit(INFINIPATH_R_PORTENABLE_SHIFT + pd->port_port,
 		&dd->ipath_rcvctrl);
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvctrl,
@@ -1832,6 +1841,8 @@ static void unlock_expected_tids(struct 
 		if (!dd->ipath_pageshadow[i])
 			continue;
 
+		pci_unmap_page(dd->pcidev, dd->ipath_physshadow[i],
+			PAGE_SIZE, PCI_DMA_FROMDEVICE);
 		ipath_release_user_pages_on_close(&dd->ipath_pageshadow[i],
 						  1);
 		dd->ipath_pageshadow[i] = NULL;
@@ -1936,14 +1947,14 @@ static int ipath_close(struct inode *in,
 		i = dd->ipath_pbufsport * (port - 1);
 		ipath_disarm_piobufs(dd, i, dd->ipath_pbufsport);
 
+		dd->ipath_f_clear_tids(dd, pd->port_port);
+
 		if (dd->ipath_pageshadow)
 			unlock_expected_tids(pd);
 		ipath_stats.sps_ports--;
 		ipath_cdbg(PROC, "%s[%u] closed port %u:%u\n",
 			   pd->port_comm, pd->port_pid,
 			   dd->ipath_unit, port);
-
-		dd->ipath_f_clear_tids(dd, pd->port_port);
 	}
 
 	pd->port_pid = 0;
diff -r cdbbf110848d -r f6794c8289ab drivers/infiniband/hw/ipath/ipath_iba6120.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Thu Sep 28 08:57:12 2006 -0700
@@ -1113,7 +1113,7 @@ static void ipath_pe_put_tid_2(struct ip
 	if (pa != dd->ipath_tidinvalid) {
 		if (pa & ((1U << 11) - 1)) {
 			dev_info(&dd->pcidev->dev, "BUG: physaddr %lx "
-				 "not 4KB aligned!\n", pa);
+				 "not 2KB aligned!\n", pa);
 			return;
 		}
 		pa >>= 11;
diff -r cdbbf110848d -r f6794c8289ab drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Thu Sep 28 08:57:12 2006 -0700
@@ -88,13 +88,13 @@ static int create_port0_egr(struct ipath
 static int create_port0_egr(struct ipath_devdata *dd)
 {
 	unsigned e, egrcnt;
-	struct sk_buff **skbs;
+	struct ipath_skbinfo *skbinfo;
 	int ret;
 
 	egrcnt = dd->ipath_rcvegrcnt;
 
-	skbs = vmalloc(sizeof(*dd->ipath_port0_skbs) * egrcnt);
-	if (skbs == NULL) {
+	skbinfo = vmalloc(sizeof(*dd->ipath_port0_skbinfo) * egrcnt);
+	if (skbinfo == NULL) {
 		ipath_dev_err(dd, "allocation error for eager TID "
 			      "skb array\n");
 		ret = -ENOMEM;
@@ -109,13 +109,13 @@ static int create_port0_egr(struct ipath
 		 * 4 bytes so that the data buffer stays word aligned.
 		 * See ipath_kreceive() for more details.
 		 */
-		skbs[e] = ipath_alloc_skb(dd, GFP_KERNEL);
-		if (!skbs[e]) {
+		skbinfo[e].skb = ipath_alloc_skb(dd, GFP_KERNEL);
+		if (!skbinfo[e].skb) {
 			ipath_dev_err(dd, "SKB allocation error for "
 				      "eager TID %u\n", e);
 			while (e != 0)
-				dev_kfree_skb(skbs[--e]);
-			vfree(skbs);
+				dev_kfree_skb(skbinfo[--e].skb);
+			vfree(skbinfo);
 			ret = -ENOMEM;
 			goto bail;
 		}
@@ -124,14 +124,17 @@ static int create_port0_egr(struct ipath
 	 * After loop above, so we can test non-NULL to see if ready
 	 * to use at receive, etc.
 	 */
-	dd->ipath_port0_skbs = skbs;
+	dd->ipath_port0_skbinfo = skbinfo;
 
 	for (e = 0; e < egrcnt; e++) {
-		unsigned long phys =
-			virt_to_phys(dd->ipath_port0_skbs[e]->data);
+		dd->ipath_port0_skbinfo[e].phys =
+		  ipath_map_single(dd->pcidev,
+				   dd->ipath_port0_skbinfo[e].skb->data,
+				   dd->ipath_ibmaxlen, PCI_DMA_FROMDEVICE);
 		dd->ipath_f_put_tid(dd, e + (u64 __iomem *)
 				    ((char __iomem *) dd->ipath_kregbase +
-				     dd->ipath_rcvegrbase), 0, phys);
+				     dd->ipath_rcvegrbase), 0,
+				    dd->ipath_port0_skbinfo[e].phys);
 	}
 
 	ret = 0;
@@ -432,16 +435,33 @@ done:
  */
 static void init_shadow_tids(struct ipath_devdata *dd)
 {
-	dd->ipath_pageshadow = (struct page **)
-		vmalloc(dd->ipath_cfgports * dd->ipath_rcvtidcnt *
+	struct page **pages;
+	dma_addr_t *addrs;
+
+	pages = vmalloc(dd->ipath_cfgports * dd->ipath_rcvtidcnt *
 			sizeof(struct page *));
-	if (!dd->ipath_pageshadow)
+	if (!pages) {
 		ipath_dev_err(dd, "failed to allocate shadow page * "
 			      "array, no expected sends!\n");
-	else
-		memset(dd->ipath_pageshadow, 0,
-		       dd->ipath_cfgports * dd->ipath_rcvtidcnt *
-		       sizeof(struct page *));
+		dd->ipath_pageshadow = NULL;
+		return;
+	}
+
+	addrs = vmalloc(dd->ipath_cfgports * dd->ipath_rcvtidcnt *
+			sizeof(dma_addr_t));
+	if (!addrs) {
+		ipath_dev_err(dd, "failed to allocate shadow dma handle "
+			      "array, no expected sends!\n");
+		vfree(dd->ipath_pageshadow);
+		dd->ipath_pageshadow = NULL;
+		return;
+	}
+
+	memset(pages, 0, dd->ipath_cfgports * dd->ipath_rcvtidcnt *
+	       sizeof(struct page *));
+
+	dd->ipath_pageshadow = pages;
+	dd->ipath_physshadow = addrs;
 }
 
 static void enable_chip(struct ipath_devdata *dd,
diff -r cdbbf110848d -r f6794c8289ab drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Sep 28 08:57:12 2006 -0700
@@ -605,7 +605,7 @@ static int handle_errors(struct ipath_de
 				 * don't report same point multiple times,
 				 * except kernel
 				 */
-				tl = (u32) * pd->port_rcvhdrtail_kvaddr;
+				tl = *(u64 *) pd->port_rcvhdrtail_kvaddr;
 				if (tl == dd->ipath_lastrcvhdrqtails[i])
 					continue;
 				hd = ipath_read_ureg32(dd, ur_rcvhdrhead,
diff -r cdbbf110848d -r f6794c8289ab drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:12 2006 -0700
@@ -39,6 +39,8 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <asm/io.h>
 
 #include "ipath_common.h"
@@ -62,7 +64,7 @@ struct ipath_portdata {
 	/* rcvhdrq base, needs mmap before useful */
 	void *port_rcvhdrq;
 	/* kernel virtual address where hdrqtail is updated */
-	volatile __le64 *port_rcvhdrtail_kvaddr;
+	void *port_rcvhdrtail_kvaddr;
 	/*
 	 * temp buffer for expected send setup, allocated at open, instead
 	 * of each setup call
@@ -146,6 +148,11 @@ struct _ipath_layer {
 	void *l_arg;
 };
 
+struct ipath_skbinfo {
+	struct sk_buff *skb;
+	dma_addr_t phys;
+};
+
 struct ipath_devdata {
 	struct list_head ipath_list;
 
@@ -168,7 +175,7 @@ struct ipath_devdata {
 	/* ipath_cfgports pointers */
 	struct ipath_portdata **ipath_pd;
 	/* sk_buffs used by port 0 eager receive queue */
-	struct sk_buff **ipath_port0_skbs;
+	struct ipath_skbinfo *ipath_port0_skbinfo;
 	/* kvirt address of 1st 2k pio buffer */
 	void __iomem *ipath_pio2kbase;
 	/* kvirt address of 1st 4k pio buffer */
@@ -335,6 +342,8 @@ struct ipath_devdata {
 	u64 *ipath_tidsimshadow;
 	/* shadow copy of struct page *'s for exp tid pages */
 	struct page **ipath_pageshadow;
+	/* shadow copy of dma handles for exp tid pages */
+	dma_addr_t *ipath_physshadow;
 	/* lock to workaround chip bug 9437 */
 	spinlock_t ipath_tid_lock;
 
@@ -865,6 +874,13 @@ int ipathfs_remove_device(struct ipath_d
 int ipathfs_remove_device(struct ipath_devdata *);
 
 /*
+ * dma_addr wrappers - all 0's invalid for hw
+ */
+dma_addr_t ipath_map_page(struct pci_dev *, struct page *, unsigned long,
+			  size_t, int);
+dma_addr_t ipath_map_single(struct pci_dev *, void *, size_t, int);
+
+/*
  * Flush write combining store buffers (if present) and perform a write
  * barrier.
  */
diff -r cdbbf110848d -r f6794c8289ab drivers/infiniband/hw/ipath/ipath_user_pages.c
--- a/drivers/infiniband/hw/ipath/ipath_user_pages.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_user_pages.c	Thu Sep 28 08:57:12 2006 -0700
@@ -90,6 +90,62 @@ bail:
 }
 
 /**
+ * ipath_map_page - a safety wrapper around pci_map_page()
+ *
+ * A dma_addr of all 0's is interpreted by the chip as "disabled".
+ * Unfortunately, it can also be a valid dma_addr returned on some
+ * architectures.
+ *
+ * The powerpc iommu assigns dma_addrs in ascending order, so we don't
+ * have to bother with retries or mapping a dummy page to insure we
+ * don't just get the same mapping again.
+ *
+ * I'm sure we won't be so lucky with other iommu's, so FIXME.
+ */
+dma_addr_t ipath_map_page(struct pci_dev *hwdev, struct page *page,
+	unsigned long offset, size_t size, int direction)
+{
+	dma_addr_t phys;
+
+	phys = pci_map_page(hwdev, page, offset, size, direction);
+
+	if (phys == 0) {
+		pci_unmap_page(hwdev, phys, size, direction);
+		phys = pci_map_page(hwdev, page, offset, size, direction);
+		/*
+		 * FIXME: If we get 0 again, we should keep this page,
+		 * map another, then free the 0 page.
+		 */
+	}
+
+	return phys;
+}
+
+/**
+ * ipath_map_single - a safety wrapper around pci_map_single()
+ *
+ * Same idea as ipath_map_page().
+ */
+dma_addr_t ipath_map_single(struct pci_dev *hwdev, void *ptr, size_t size,
+	int direction)
+{
+	dma_addr_t phys;
+
+	phys = pci_map_single(hwdev, ptr, size, direction);
+
+	if (phys == 0) {
+		pci_unmap_single(hwdev, phys, size, direction);
+		phys = pci_map_single(hwdev, ptr, size, direction);
+		/*
+		 * FIXME: If we get 0 again, we should keep this page,
+		 * map another, then free the 0 page.
+		 */
+	}
+
+	return phys;
+}
+
+/**
  * ipath_get_user_pages - lock user pages into memory
  * @start_page: the start page
  * @num_pages: the number of pages
diff -r cdbbf110848d -r f6794c8289ab drivers/infiniband/hw/ipath/ipath_wc_ppc64.c
--- a/drivers/infiniband/hw/ipath/ipath_wc_ppc64.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_wc_ppc64.c	Thu Sep 28 08:57:12 2006 -0700
@@ -38,13 +38,23 @@
 #include "ipath_kernel.h"
 
 /**
- * ipath_unordered_wc - indicate whether write combining is ordered
+ * ipath_enable_wc - enable write combining for MMIO writes to the device
+ * @dd: infinipath device
  *
- * PowerPC systems (at least those in the 970 processor family)
- * write partially filled store buffers in address order, but will write
- * completely filled store buffers in "random" order, and therefore must
- * have serialization for correctness with current InfiniPath chips.
+ * Nothing to do on PowerPC, so just return without error.
+ */
+int ipath_enable_wc(struct ipath_devdata *dd)
+{
+	return 0;
+}
+
+/**
+ * ipath_unordered_wc - indicate whether write combining is unordered
  *
+ * Because our performance depends on our ability to do write
+ * combining mmio writes in the most efficient way, we need to
+ * know if we are on a processor that may reorder stores when
+ * write combining.
  */
 int ipath_unordered_wc(void)
 {
