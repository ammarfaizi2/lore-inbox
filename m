Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWFTUcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWFTUcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWFTUbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:31:33 -0400
Received: from rrcs-24-227-247-53.sw.biz.rr.com ([24.227.247.53]:13751 "EHLO
	linux.local") by vger.kernel.org with ESMTP id S1750946AbWFTUbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:31:12 -0400
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH v3 4/7] AMSO1100 Memory Management.
Date: Tue, 20 Jun 2006 15:31:11 -0500
To: rdreier@cisco.com, mshefty@ichips.intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
Message-Id: <20060620203111.31536.80453.stgit@stevo-desktop>
In-Reply-To: <20060620203050.31536.5341.stgit@stevo-desktop>
References: <20060620203050.31536.5341.stgit@stevo-desktop>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


V2 Review Changes:

- removed c2_array services and replaced them with the idr.

- removed c2_alloc services and made them pd-specific.

- don't use GFP_DMA.

- correctly map host memory for DMA (don't use __pa()).

V1 Review Changes:

- sizeof -> sizeof()

- cleaned up comments
---

 drivers/infiniband/hw/amso1100/c2_alloc.c |  144 +++++++++++
 drivers/infiniband/hw/amso1100/c2_mm.c    |  375 +++++++++++++++++++++++++++++
 2 files changed, 519 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/amso1100/c2_alloc.c b/drivers/infiniband/hw/amso1100/c2_alloc.c
new file mode 100644
index 0000000..013b152
--- /dev/null
+++ b/drivers/infiniband/hw/amso1100/c2_alloc.c
@@ -0,0 +1,144 @@
+/*
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Open Grid Computing, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/bitmap.h>
+
+#include "c2.h"
+
+static int c2_alloc_mqsp_chunk(struct c2_dev *c2dev, gfp_t gfp_mask, 
+			       struct sp_chunk **head)
+{
+	int i;
+	struct sp_chunk *new_head;
+
+	new_head = (struct sp_chunk *) __get_free_page(gfp_mask);
+	if (new_head == NULL)
+		return -ENOMEM;
+
+	new_head->dma_addr = dma_map_single(c2dev->ibdev.dma_device, new_head, 
+					    PAGE_SIZE, DMA_FROM_DEVICE);
+	pci_unmap_addr_set(new_head, mapping, new_head->dma_addr);
+
+	new_head->next = NULL;
+	new_head->head = 0;
+
+	/* build list where each index is the next free slot */
+	for (i = 0;
+	     i < (PAGE_SIZE - sizeof(struct sp_chunk) - 
+		  sizeof(u16)) / sizeof(u16) - 1; 
+	     i++) {
+		new_head->shared_ptr[i] = i + 1;
+	}
+	/* terminate list */
+	new_head->shared_ptr[i] = 0xFFFF;
+
+	*head = new_head;
+	return 0;
+}
+
+int c2_init_mqsp_pool(struct c2_dev *c2dev, gfp_t gfp_mask, 
+		      struct sp_chunk **root)
+{
+	return c2_alloc_mqsp_chunk(c2dev, gfp_mask, root);
+}
+
+void c2_free_mqsp_pool(struct c2_dev *c2dev, struct sp_chunk *root)
+{
+	struct sp_chunk *next;
+
+	while (root) {
+		next = root->next;
+		dma_unmap_single(c2dev->ibdev.dma_device, 
+				 pci_unmap_addr(root, mapping), PAGE_SIZE, 
+			         DMA_FROM_DEVICE);
+		__free_page((struct page *) root);
+		root = next;
+	}
+}
+
+u16 *c2_alloc_mqsp(struct c2_dev *c2dev, struct sp_chunk *head, 
+		   dma_addr_t *dma_addr, gfp_t gfp_mask)
+{
+	u16 mqsp;
+
+	while (head) {
+		mqsp = head->head;
+		if (mqsp != 0xFFFF) {
+			head->head = head->shared_ptr[mqsp];
+			break;
+		} else if (head->next == NULL) {
+			if (c2_alloc_mqsp_chunk(c2dev, gfp_mask, &head->next) ==
+			    0) {
+				head = head->next;
+				mqsp = head->head;
+				head->head = head->shared_ptr[mqsp];
+				break;
+			} else
+				return NULL;
+		} else
+			head = head->next;
+	}
+	if (head) {
+		*dma_addr = head->dma_addr + 
+			    ((unsigned long) &(head->shared_ptr[mqsp]) - 
+			     (unsigned long) head);
+		pr_debug("%s addr %p dma_addr %llx\n", __FUNCTION__,
+			 &(head->shared_ptr[mqsp]), (u64)*dma_addr);
+		return &(head->shared_ptr[mqsp]);
+	}
+	return NULL;
+}
+
+void c2_free_mqsp(u16 * mqsp)
+{
+	struct sp_chunk *head;
+	u16 idx;
+
+	/* The chunk containing this ptr begins at the page boundary */
+	head = (struct sp_chunk *) ((unsigned long) mqsp & PAGE_MASK);
+
+	/* Link head to new mqsp */
+	*mqsp = head->head;
+
+	/* Compute the shared_ptr index */
+	idx = ((unsigned long) mqsp & ~PAGE_MASK) >> 1;
+	idx -= (unsigned long) &(((struct sp_chunk *) 0)->shared_ptr[0]) >> 1;
+
+	/* Point this index at the head */
+	head->shared_ptr[idx] = head->head;
+
+	/* Point head at this index */
+	head->head = idx;
+}
diff --git a/drivers/infiniband/hw/amso1100/c2_mm.c b/drivers/infiniband/hw/amso1100/c2_mm.c
new file mode 100644
index 0000000..314ec07
--- /dev/null
+++ b/drivers/infiniband/hw/amso1100/c2_mm.c
@@ -0,0 +1,375 @@
+/*
+ * Copyright (c) 2005 Ammasso, Inc. All rights reserved.
+ * Copyright (c) 2005 Open Grid Computing, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#include "c2.h"
+#include "c2_vq.h"
+
+#define PBL_VIRT 1
+#define PBL_PHYS 2
+
+/*
+ * Send all the PBL messages to convey the remainder of the PBL
+ * Wait for the adapter's reply on the last one.
+ * This is indicated by setting the MEM_PBL_COMPLETE in the flags.
+ *
+ * NOTE:  vq_req is _not_ freed by this function.  The VQ Host
+ *	  Reply buffer _is_ freed by this function.
+ */
+static int
+send_pbl_messages(struct c2_dev *c2dev, u32 stag_index,
+		  unsigned long va, u32 pbl_depth,
+		  struct c2_vq_req *vq_req, int pbl_type)
+{
+	u32 pbe_count;		/* amt that fits in a PBL msg */
+	u32 count;		/* amt in this PBL MSG. */
+	struct c2wr_nsmr_pbl_req *wr;	/* PBL WR ptr */
+	struct c2wr_nsmr_pbl_rep *reply;	/* reply ptr */
+ 	int err, pbl_virt, pbl_index, i;
+
+	switch (pbl_type) {
+	case PBL_VIRT:
+		pbl_virt = 1;
+		break;
+	case PBL_PHYS:
+		pbl_virt = 0;
+		break;
+	default:
+		return -EINVAL;
+		break;
+	}
+
+	pbe_count = (c2dev->req_vq.msg_size -
+		     sizeof(struct c2wr_nsmr_pbl_req)) / sizeof(u64);
+	wr = kmalloc(c2dev->req_vq.msg_size, GFP_KERNEL);
+	if (!wr) {
+		return -ENOMEM;
+	}
+	c2_wr_set_id(wr, CCWR_NSMR_PBL);
+
+	/*
+	 * Only the last PBL message will generate a reply from the verbs, 
+	 * so we set the context to 0 indicating there is no kernel verbs
+	 * handler blocked awaiting this reply.
+	 */
+	wr->hdr.context = 0;
+	wr->rnic_handle = c2dev->adapter_handle;
+	wr->stag_index = stag_index;	/* already swapped */
+	wr->flags = 0;
+	pbl_index = 0;
+	while (pbl_depth) {
+		count = min(pbe_count, pbl_depth);
+		wr->addrs_length = cpu_to_be32(count);
+
+		/*
+		 *  If this is the last message, then reference the
+		 *  vq request struct cuz we're gonna wait for a reply.
+		 *  also make this PBL msg as the last one.
+		 */
+		if (count == pbl_depth) {
+			/*
+			 * reference the request struct.  dereferenced in the 
+			 * int handler.
+			 */
+			vq_req_get(c2dev, vq_req);
+			wr->flags = cpu_to_be32(MEM_PBL_COMPLETE);
+
+			/*
+			 * This is the last PBL message.
+			 * Set the context to our VQ Request Object so we can
+			 * wait for the reply.
+			 */
+			wr->hdr.context = (unsigned long) vq_req;
+		}
+
+		/*
+		 * If pbl_virt is set then va is a virtual address 
+		 * that describes a virtually contiguous memory
+		 * allocation. The wr needs the start of each virtual page
+		 * to be converted to the corresponding physical address
+		 * of the page. If pbl_virt is not set then va is an array
+		 * of physical addresses and there is no conversion to do.
+		 * Just fill in the wr with what is in the array.  
+		 */
+		for (i = 0; i < count; i++) {
+			if (pbl_virt) {
+				va += PAGE_SIZE;
+			} else {
+ 				wr->paddrs[i] = 
+				    cpu_to_be64(((u64 *)va)[pbl_index + i]);
+			}
+		}
+
+		/*
+		 * Send WR to adapter
+		 */
+		err = vq_send_wr(c2dev, (union c2wr *) wr);
+		if (err) {
+			if (count <= pbe_count) {
+				vq_req_put(c2dev, vq_req);
+			}
+			goto bail0;
+		}
+		pbl_depth -= count;
+		pbl_index += count;
+	}
+
+	/*
+	 *  Now wait for the reply...
+	 */
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err) {
+		goto bail0;
+	}
+
+	/*
+	 * Process reply 
+	 */
+	reply = (struct c2wr_nsmr_pbl_rep *) (unsigned long) vq_req->reply_msg;
+	if (!reply) {
+		err = -ENOMEM;
+		goto bail0;
+	}
+
+	err = c2_errno(reply);
+
+	vq_repbuf_free(c2dev, reply);
+      bail0:
+	kfree(wr);
+	return err;
+}
+
+#define C2_PBL_MAX_DEPTH 131072
+int
+c2_nsmr_register_phys_kern(struct c2_dev *c2dev, u64 *addr_list, 
+ 			   int page_size, int pbl_depth, u32 length, 
+ 			   u32 offset, u64 *va, enum c2_acf acf, 
+			   struct c2_mr *mr)
+{
+	struct c2_vq_req *vq_req;
+	struct c2wr_nsmr_register_req *wr;
+	struct c2wr_nsmr_register_rep *reply;
+	u16 flags;
+	int i, pbe_count, count;
+	int err;
+
+	if (!va || !length || !addr_list || !pbl_depth)
+		return -EINTR;
+
+	/*
+	 * Verify PBL depth is within rnic max
+	 */
+	if (pbl_depth > C2_PBL_MAX_DEPTH) {
+		return -EINTR;
+	}
+
+	/*
+	 * allocate verbs request object
+	 */
+	vq_req = vq_req_alloc(c2dev);
+	if (!vq_req)
+		return -ENOMEM;
+
+	wr = kmalloc(c2dev->req_vq.msg_size, GFP_KERNEL);
+	if (!wr) {
+		err = -ENOMEM;
+		goto bail0;
+	}
+
+	/*
+	 * build the WR
+	 */
+	c2_wr_set_id(wr, CCWR_NSMR_REGISTER);
+	wr->hdr.context = (unsigned long) vq_req;
+	wr->rnic_handle = c2dev->adapter_handle;
+
+	flags = (acf | MEM_VA_BASED | MEM_REMOTE);
+
+	/*
+	 * compute how many pbes can fit in the message
+	 */
+	pbe_count = (c2dev->req_vq.msg_size -
+		     sizeof(struct c2wr_nsmr_register_req)) / sizeof(u64);
+
+	if (pbl_depth <= pbe_count) {
+		flags |= MEM_PBL_COMPLETE;
+	}
+	wr->flags = cpu_to_be16(flags);
+	wr->stag_key = 0;	//stag_key;
+	wr->va = cpu_to_be64(*va);
+	wr->pd_id = mr->pd->pd_id;
+	wr->pbe_size = cpu_to_be32(page_size);
+	wr->length = cpu_to_be32(length);
+	wr->pbl_depth = cpu_to_be32(pbl_depth);
+	wr->fbo = cpu_to_be32(offset);
+	count = min(pbl_depth, pbe_count);
+	wr->addrs_length = cpu_to_be32(count);
+
+	/*
+	 * fill out the PBL for this message
+	 */
+	for (i = 0; i < count; i++) {
+		wr->paddrs[i] = cpu_to_be64(addr_list[i]);
+	}
+
+	/*
+	 * regerence the request struct 
+	 */
+	vq_req_get(c2dev, vq_req);
+
+	/*
+	 * send the WR to the adapter
+	 */
+	err = vq_send_wr(c2dev, (union c2wr *) wr);
+	if (err) {
+		vq_req_put(c2dev, vq_req);
+		goto bail1;
+	}
+
+	/*
+	 * wait for reply from adapter
+	 */
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err) {
+		goto bail1;
+	}
+
+	/*
+	 * process reply
+	 */
+	reply =
+	    (struct c2wr_nsmr_register_rep *) (unsigned long) (vq_req->reply_msg);
+	if (!reply) {
+		err = -ENOMEM;
+		goto bail1;
+	}
+	if ((err = c2_errno(reply))) {
+		goto bail2;
+	}
+	//*p_pb_entries = be32_to_cpu(reply->pbl_depth);
+	mr->ibmr.lkey = mr->ibmr.rkey = be32_to_cpu(reply->stag_index);
+	vq_repbuf_free(c2dev, reply);
+
+	/*
+	 * if there are still more PBEs we need to send them to
+	 * the adapter and wait for a reply on the final one.
+	 * reuse vq_req for this purpose.
+	 */
+	pbl_depth -= count;
+	if (pbl_depth) {
+
+		vq_req->reply_msg = (unsigned long) NULL;
+		atomic_set(&vq_req->reply_ready, 0);
+		err = send_pbl_messages(c2dev,
+					cpu_to_be32(mr->ibmr.lkey),
+					(unsigned long) &addr_list[i],
+					pbl_depth, vq_req, PBL_PHYS);
+		if (err) {
+			goto bail1;
+		}
+	}
+
+	vq_req_free(c2dev, vq_req);
+	kfree(wr);
+
+	return err;
+
+      bail2:
+	vq_repbuf_free(c2dev, reply);
+      bail1:
+	kfree(wr);
+      bail0:
+	vq_req_free(c2dev, vq_req);
+	return err;
+}
+
+int c2_stag_dealloc(struct c2_dev *c2dev, u32 stag_index)
+{
+	struct c2_vq_req *vq_req;	/* verbs request object */
+	struct c2wr_stag_dealloc_req wr;	/* work request */
+	struct c2wr_stag_dealloc_rep *reply;	/* WR reply  */
+	int err;
+
+
+	/*
+	 * allocate verbs request object
+	 */
+	vq_req = vq_req_alloc(c2dev);
+	if (!vq_req) {
+		return -ENOMEM;
+	}
+
+	/* 
+	 * Build the WR
+	 */
+	c2_wr_set_id(&wr, CCWR_STAG_DEALLOC);
+	wr.hdr.context = (u64) (unsigned long) vq_req;
+	wr.rnic_handle = c2dev->adapter_handle;
+	wr.stag_index = cpu_to_be32(stag_index);
+
+	/*
+	 * reference the request struct.  dereferenced in the int handler.
+	 */
+	vq_req_get(c2dev, vq_req);
+
+	/*
+	 * Send WR to adapter
+	 */
+	err = vq_send_wr(c2dev, (union c2wr *) & wr);
+	if (err) {
+		vq_req_put(c2dev, vq_req);
+		goto bail0;
+	}
+
+	/*
+	 * Wait for reply from adapter
+	 */
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err) {
+		goto bail0;
+	}
+
+	/*
+	 * Process reply 
+	 */
+	reply = (struct c2wr_stag_dealloc_rep *) (unsigned long) vq_req->reply_msg;
+	if (!reply) {
+		err = -ENOMEM;
+		goto bail0;
+	}
+
+	err = c2_errno(reply);
+
+	vq_repbuf_free(c2dev, reply);
+      bail0:
+	vq_req_free(c2dev, vq_req);
+	return err;
+}
