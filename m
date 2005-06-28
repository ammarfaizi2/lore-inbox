Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVF1Xii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVF1Xii (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVF1XiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:38:22 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:21276 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262225AbVF1XDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:53 -0400
X-IronPort-AV: i="3.93,240,1115017200"; 
   d="scan'208"; a="195037100:sNHT29597380"
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 13/16] IB uverbs: add mthca user MR support
In-Reply-To: <2005628163.px5sYyzsYWf21dJY@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:44 -0700
Message-Id: <2005628163.XfYnZThlsTGb61Td@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for userspace memory regions (MRs) to mthca.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_provider.c |   82 +++++++++++++++++++++++++++
 1 files changed, 82 insertions(+)



--- linux.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:20.513467597 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:23.354851384 -0700
@@ -654,6 +654,87 @@ static struct ib_mr *mthca_reg_phys_mr(s
 	return &mr->ibmr;
 }
 
+static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, struct ib_umem *region,
+				       int acc, struct ib_udata *udata)
+{
+	struct mthca_dev *dev = to_mdev(pd->device);
+	struct ib_umem_chunk *chunk;
+	struct mthca_mr *mr;
+	u64 *pages;
+	int shift, n, len;
+	int i, j, k;
+	int err = 0;
+
+	shift = ffs(region->page_size) - 1;
+
+	mr = kmalloc(sizeof *mr, GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+	
+	n = 0;
+	list_for_each_entry(chunk, &region->chunk_list, list)
+		n += chunk->nents;
+
+	mr->mtt = mthca_alloc_mtt(dev, n);
+	if (IS_ERR(mr->mtt)) {
+		err = PTR_ERR(mr->mtt);
+		goto err;
+	}
+
+	pages = (u64 *) __get_free_page(GFP_KERNEL);
+	if (!pages) {
+		err = -ENOMEM;
+		goto err_mtt;
+	}
+
+	i = n = 0;
+
+	list_for_each_entry(chunk, &region->chunk_list, list)
+		for (j = 0; j < chunk->nmap; ++j) {
+			len = sg_dma_len(&chunk->page_list[j]) >> shift;
+			for (k = 0; k < len; ++k) {
+				pages[i++] = sg_dma_address(&chunk->page_list[j]) +
+					region->page_size * k;
+				/*
+				 * Be friendly to WRITE_MTT command
+				 * and leave two empty slots for the
+				 * index and reserved fields of the
+				 * mailbox.
+				 */
+				if (i == PAGE_SIZE / sizeof (u64) - 2) {
+					err = mthca_write_mtt(dev, mr->mtt,
+							      n, pages, i);
+					if (err)
+						goto mtt_done;
+					n += i;
+					i = 0;
+				}
+			}
+		}
+
+	if (i)
+		err = mthca_write_mtt(dev, mr->mtt, n, pages, i);
+mtt_done:
+	free_page((unsigned long) pages);
+	if (err)
+		goto err_mtt;
+
+	err = mthca_mr_alloc(dev, to_mpd(pd)->pd_num, shift, region->virt_base,
+			     region->length, convert_access(acc), mr);
+
+	if (err)
+		goto err_mtt;
+
+	return &mr->ibmr;
+
+err_mtt:
+	mthca_free_mtt(dev, mr->mtt);
+
+err:
+	kfree(mr);
+	return ERR_PTR(err);
+}
+
 static int mthca_dereg_mr(struct ib_mr *mr)
 {
 	struct mthca_mr *mmr = to_mmr(mr);
@@ -804,6 +885,7 @@ int mthca_register_device(struct mthca_d
 	dev->ib_dev.poll_cq              = mthca_poll_cq;
 	dev->ib_dev.get_dma_mr           = mthca_get_dma_mr;
 	dev->ib_dev.reg_phys_mr          = mthca_reg_phys_mr;
+	dev->ib_dev.reg_user_mr          = mthca_reg_user_mr;
 	dev->ib_dev.dereg_mr             = mthca_dereg_mr;
 
 	if (dev->mthca_flags & MTHCA_FLAG_FMR) {
