Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264987AbUFRJcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbUFRJcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264986AbUFRJXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:23:32 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:3260 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265060AbUFRJUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:20:23 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jun 2004 11:12:22 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: video-buf magic numbers
Message-ID: <20040618091222.GA23679@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adds some magic IDs and checks for them to the data structs
of the video-buf module.

  Gerd

diff -up linux-2.6.7/drivers/media/video/video-buf.c linux/drivers/media/video/video-buf.c
--- linux-2.6.7/drivers/media/video/video-buf.c	2004-06-17 13:47:58.729471114 +0200
+++ linux/drivers/media/video/video-buf.c	2004-06-17 13:47:58.810455873 +0200
@@ -28,6 +28,11 @@
 
 #include <media/video-buf.h>
 
+#define MAGIC_DMABUF 0x19721112
+#define MAGIC_BUFFER 0x20040302
+#define MAGIC_CHECK(is,should)	if (unlikely((is) != (should))) \
+	{ printk(KERN_ERR "magic mismatch: %x (expected %x)\n",is,should); BUG(); }
+
 static int debug = 0;
 
 MODULE_DESCRIPTION("helper module to manage video4linux pci dma buffers");
@@ -109,6 +114,12 @@ videobuf_pages_to_sg(struct page **pages
 
 /* --------------------------------------------------------------------- */
 
+void videobuf_dma_init(struct videobuf_dmabuf *dma)
+{
+	memset(dma,0,sizeof(*dma));
+	dma->magic = MAGIC_DMABUF;
+}
+
 int videobuf_dma_init_user(struct videobuf_dmabuf *dma, int direction,
 			   unsigned long data, unsigned long size)
 {
@@ -178,8 +189,8 @@ int videobuf_dma_init_overlay(struct vid
 
 int videobuf_dma_pci_map(struct pci_dev *dev, struct videobuf_dmabuf *dma)
 {
-	if (0 == dma->nr_pages)
-		BUG();
+	MAGIC_CHECK(dma->magic,MAGIC_DMABUF);
+	BUG_ON(0 == dma->nr_pages);
 	
 	if (dma->pages) {
 		dma->sglist = videobuf_pages_to_sg(dma->pages, dma->nr_pages,
@@ -211,8 +222,8 @@ int videobuf_dma_pci_map(struct pci_dev 
 
 int videobuf_dma_pci_sync(struct pci_dev *dev, struct videobuf_dmabuf *dma)
 {
-	if (!dma->sglen)
-		BUG();
+	MAGIC_CHECK(dma->magic,MAGIC_DMABUF);
+	BUG_ON(!dma->sglen);
 
 	if (!dma->bus_addr)
 		pci_dma_sync_sg_for_cpu(dev,dma->sglist,dma->nr_pages,dma->direction);
@@ -221,6 +232,7 @@ int videobuf_dma_pci_sync(struct pci_dev
 
 int videobuf_dma_pci_unmap(struct pci_dev *dev, struct videobuf_dmabuf *dma)
 {
+	MAGIC_CHECK(dma->magic,MAGIC_DMABUF);
 	if (!dma->sglen)
 		return 0;
 
@@ -234,8 +246,8 @@ int videobuf_dma_pci_unmap(struct pci_de
 
 int videobuf_dma_free(struct videobuf_dmabuf *dma)
 {
-	if (dma->sglen)
-		BUG();
+	MAGIC_CHECK(dma->magic,MAGIC_DMABUF);
+	BUG_ON(dma->sglen);
 
 	if (dma->pages) {
 		int i;
@@ -264,7 +276,9 @@ void* videobuf_alloc(unsigned int size)
 	vb = kmalloc(size,GFP_KERNEL);
 	if (NULL != vb) {
 		memset(vb,0,size);
+		videobuf_dma_init(&vb->dma);
 		init_waitqueue_head(&vb->done);
+		vb->magic     = MAGIC_BUFFER;
 	}
 	return vb;
 }
@@ -274,6 +288,7 @@ int videobuf_waiton(struct videobuf_buff
 	int retval = 0;
 	DECLARE_WAITQUEUE(wait, current);
 	
+	MAGIC_CHECK(vb->magic,MAGIC_BUFFER);
 	add_wait_queue(&vb->done, &wait);
 	while (vb->state == STATE_ACTIVE || vb->state == STATE_QUEUED) {
 		if (non_blocking) {
@@ -302,6 +317,7 @@ videobuf_iolock(struct pci_dev *pci, str
 	int err,pages;
 	dma_addr_t bus;
 
+	MAGIC_CHECK(vb->magic,MAGIC_BUFFER);
 	switch (vb->memory) {
 	case V4L2_MEMORY_MMAP:
 	case V4L2_MEMORY_USERPTR:
@@ -453,6 +469,8 @@ void
 videobuf_status(struct v4l2_buffer *b, struct videobuf_buffer *vb,
 		enum v4l2_buf_type type)
 {
+	MAGIC_CHECK(vb->magic,MAGIC_BUFFER);
+
 	b->index    = vb->i;
 	b->type     = type;
 
@@ -573,6 +591,7 @@ videobuf_qbuf(struct file *file, struct 
 	buf = q->bufs[b->index];
 	if (NULL == buf)
 		goto done;
+	MAGIC_CHECK(buf->magic,MAGIC_BUFFER);
 	if (buf->memory != b->memory)
 		goto done;
 	if (buf->state == STATE_QUEUED ||
@@ -1206,6 +1225,7 @@ int videobuf_mmap_mapper(struct vm_area_
 
 EXPORT_SYMBOL_GPL(videobuf_vmalloc_to_sg);
 
+EXPORT_SYMBOL_GPL(videobuf_dma_init);
 EXPORT_SYMBOL_GPL(videobuf_dma_init_user);
 EXPORT_SYMBOL_GPL(videobuf_dma_init_kernel);
 EXPORT_SYMBOL_GPL(videobuf_dma_init_overlay);
diff -up linux-2.6.7/include/media/video-buf.h linux/include/media/video-buf.h
--- linux-2.6.7/include/media/video-buf.h	2004-06-17 13:47:58.732470549 +0200
+++ linux/include/media/video-buf.h	2004-06-17 13:47:58.812455497 +0200
@@ -61,6 +61,8 @@ int videobuf_unlock(struct page **pages,
  */
 
 struct videobuf_dmabuf {
+	u32                 magic;
+
 	/* for userland buffer */
 	int                 offset;
 	struct page         **pages;
@@ -78,6 +80,7 @@ struct videobuf_dmabuf {
 	int                 direction;
 };
 
+void videobuf_dma_init(struct videobuf_dmabuf *dma);
 int videobuf_dma_init_user(struct videobuf_dmabuf *dma, int direction,
 			   unsigned long data, unsigned long size);
 int videobuf_dma_init_kernel(struct videobuf_dmabuf *dma, int direction,
@@ -136,6 +139,7 @@ enum videobuf_state {
 
 struct videobuf_buffer {
 	unsigned int            i;
+	u32                     magic;
 
 	/* info about the buffer */
 	unsigned int            width;

-- 
Smoking Crack Organization
