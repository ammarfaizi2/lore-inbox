Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbWIKXTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWIKXTu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWIKXTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:19:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:47917 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S965112AbWIKXS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:18:59 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="124924660:sNHT280560056"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 15/19] dmaengine: raid5 dma client
Date: Mon, 11 Sep 2006 16:18:54 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231854.4737.88026.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Adds a dmaengine client that is the hardware accelerated version of
raid5_do_soft_block_ops.  It utilizes the raid5 workqueue implementation to
operate on multiple stripes simultaneously.  See the iop-adma.c driver for
an example of a driver that enables hardware accelerated raid5.

Changelog:
* mark operations as _Dma rather than _Done until all outstanding
operations have completed.  Once all operations have completed update the
state and return it to the handle list
* add a helper routine to retrieve the last used cookie
* use dma_async_zero_sum_dma_list for checking parity which optionally
allows parity check operations to not dirty the parity block in the cache
(if 'disks' is less than 'MAX_ADMA_XOR_SOURCES')
* remove dependencies on iop13xx
* take into account the fact that dma engines have a staging buffer so we
can perform 1 less block operation compared to software xor
* added __arch_raid5_dma_chan_request __arch_raid5_dma_next_channel and
__arch_raid5_dma_check_channel to make the driver architecture independent
* added channel switching capability for architectures that implement
different operations (i.e. copy & xor) on individual channels
* added initial support for "non-blocking" channel switching

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/dma/Kconfig        |    9 +
 drivers/dma/Makefile       |    1 
 drivers/dma/raid5-dma.c    |  730 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/Kconfig         |   11 +
 drivers/md/raid5.c         |   66 ++++
 include/linux/dmaengine.h  |    5 
 include/linux/raid/raid5.h |   24 +
 7 files changed, 839 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 30d021d..fced8c3 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -22,6 +22,15 @@ config NET_DMA
 	  Since this is the main user of the DMA engine, it should be enabled;
 	  say Y here.
 
+config RAID5_DMA
+        tristate "MD raid5: block operations offload"
+	depends on INTEL_IOP_ADMA && MD_RAID456
+	default y
+	---help---
+	  This enables the use of DMA engines in the MD-RAID5 driver to
+	  offload stripe cache operations, freeing CPU cycles.
+	  say Y here
+
 comment "DMA Devices"
 
 config INTEL_IOATDMA
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index bdcfdbd..4e36d6e 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_DMA_ENGINE) += dmaengine.o
 obj-$(CONFIG_NET_DMA) += iovlock.o
+obj-$(CONFIG_RAID5_DMA) += raid5-dma.o
 obj-$(CONFIG_INTEL_IOATDMA) += ioatdma.o
diff --git a/drivers/dma/raid5-dma.c b/drivers/dma/raid5-dma.c
new file mode 100644
index 0000000..04a1790
--- /dev/null
+++ b/drivers/dma/raid5-dma.c
@@ -0,0 +1,730 @@
+/*
+ * Offload raid5 operations to hardware RAID engines
+ * Copyright(c) 2006 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING.
+ */
+
+#include <linux/raid/raid5.h>
+#include <linux/dmaengine.h>
+
+static struct dma_client *raid5_dma_client;
+static atomic_t raid5_count;
+extern void release_stripe(struct stripe_head *sh);
+extern void __arch_raid5_dma_chan_request(struct dma_client *client);
+extern struct dma_chan *__arch_raid5_dma_next_channel(struct dma_client *client);
+
+#define MAX_HW_XOR_SRCS 16
+
+#ifndef STRIPE_SIZE
+#define STRIPE_SIZE PAGE_SIZE
+#endif
+
+#ifndef STRIPE_SECTORS
+#define STRIPE_SECTORS		(STRIPE_SIZE>>9)
+#endif
+
+#ifndef r5_next_bio
+#define r5_next_bio(bio, sect) ( ( (bio)->bi_sector + ((bio)->bi_size>>9) < sect + STRIPE_SECTORS) ? (bio)->bi_next : NULL)
+#endif
+
+#define DMA_RAID5_DEBUG 0
+#define PRINTK(x...) ((void)(DMA_RAID5_DEBUG && printk(x)))
+
+/*
+ * Copy data between a page in the stripe cache, and one or more bion
+ * The page could align with the middle of the bio, or there could be
+ * several bion, each with several bio_vecs, which cover part of the page
+ * Multiple bion are linked together on bi_next.  There may be extras
+ * at the end of this list.  We ignore them.
+ */
+static dma_cookie_t dma_raid_copy_data(int frombio, struct bio *bio,
+		     dma_addr_t dma, sector_t sector, struct dma_chan *chan,
+		     dma_cookie_t cookie)
+{
+	struct bio_vec *bvl;
+	struct page *bio_page;
+	int i;
+	int dma_offset;
+	dma_cookie_t last_cookie = cookie;
+
+	if (bio->bi_sector >= sector)
+		dma_offset = (signed)(bio->bi_sector - sector) * 512;
+	else
+		dma_offset = (signed)(sector - bio->bi_sector) * -512;
+	bio_for_each_segment(bvl, bio, i) {
+		int len = bio_iovec_idx(bio,i)->bv_len;
+		int clen;
+		int b_offset = 0;
+
+		if (dma_offset < 0) {
+			b_offset = -dma_offset;
+			dma_offset += b_offset;
+			len -= b_offset;
+		}
+
+		if (len > 0 && dma_offset + len > STRIPE_SIZE)
+			clen = STRIPE_SIZE - dma_offset;
+		else clen = len;
+
+		if (clen > 0) {
+			b_offset += bio_iovec_idx(bio,i)->bv_offset;
+			bio_page = bio_iovec_idx(bio,i)->bv_page;
+			if (frombio)
+				do {
+					cookie = dma_async_memcpy_pg_to_dma(chan,
+								dma + dma_offset,
+								bio_page,
+								b_offset,
+								clen);
+					if (cookie == -ENOMEM)
+						dma_sync_wait(chan, last_cookie);
+					else
+						WARN_ON(cookie <= 0);
+				} while (cookie == -ENOMEM);
+			else
+				do {
+					cookie = dma_async_memcpy_dma_to_pg(chan,
+								bio_page,
+								b_offset,
+								dma + dma_offset,
+								clen);
+					if (cookie == -ENOMEM)
+						dma_sync_wait(chan, last_cookie);
+					else
+						WARN_ON(cookie <= 0);
+				} while (cookie == -ENOMEM);
+		}
+		last_cookie = cookie;
+		if (clen < len) /* hit end of page */
+			break;
+		dma_offset +=  len;
+	}
+
+	return last_cookie;
+}
+
+#define issue_xor() do {					          \
+			 do {					          \
+			 	cookie = dma_async_xor_dma_list_to_dma(   \
+			 		sh->ops.dma_chan,	          \
+			 		xor_destination_addr,	          \
+			 		dma,			          \
+			 		count,			          \
+			 		STRIPE_SIZE);		          \
+			 	if (cookie == -ENOMEM)		          \
+			 		dma_sync_wait(sh->ops.dma_chan,	  \
+			 			sh->ops.dma_cookie);      \
+			 	else				          \
+			 		WARN_ON(cookie <= 0);	          \
+			 } while (cookie == -ENOMEM);		          \
+			 sh->ops.dma_cookie = cookie;		          \
+			 dma[0] = xor_destination_addr;			  \
+			 count = 1;					  \
+			} while(0)
+#define check_xor() do {						\
+			if (count == MAX_HW_XOR_SRCS)			\
+				issue_xor();				\
+		     } while (0)
+
+#ifdef CONFIG_RAID5_DMA_ARCH_NEEDS_CHAN_SWITCH
+extern struct dma_chan *__arch_raid5_dma_check_channel(struct dma_chan *chan,
+						dma_cookie_t cookie,
+						struct dma_client *client,
+						unsigned long capabilities);
+
+#ifdef CONFIG_RAID5_DMA_WAIT_VIA_REQUEUE
+#define check_channel(cap, bookmark) do {			     \
+bookmark:							     \
+	next_chan = __arch_raid5_dma_check_channel(sh->ops.dma_chan, \
+						sh->ops.dma_cookie,  \
+						raid5_dma_client,    \
+						(cap));		     \
+	if (!next_chan) {					     \
+		BUG_ON(sh->ops.ops_bookmark);			     \
+		sh->ops.ops_bookmark = &&bookmark;		     \
+		goto raid5_dma_retry;				     \
+	} else {						     \
+		sh->ops.dma_chan = next_chan;			     \
+		sh->ops.dma_cookie = dma_async_get_last_cookie(	     \
+							next_chan);  \
+		sh->ops.ops_bookmark = NULL;			     \
+	}							     \
+} while (0)
+#else
+#define check_channel(cap, bookmark) do {			     \
+bookmark:							     \
+	next_chan = __arch_raid5_dma_check_channel(sh->ops.dma_chan, \
+						sh->ops.dma_cookie,  \
+						raid5_dma_client,    \
+						(cap));		     \
+	if (!next_chan) {					     \
+		dma_sync_wait(sh->ops.dma_chan, sh->ops.dma_cookie); \
+		goto bookmark;					     \
+	} else {						     \
+		sh->ops.dma_chan = next_chan;			     \
+		sh->ops.dma_cookie = dma_async_get_last_cookie(	     \
+							next_chan);  \
+	}							     \
+} while (0)
+#endif /* CONFIG_RAID5_DMA_WAIT_VIA_REQUEUE */
+#else
+#define check_channel(cap, bookmark) do { } while (0)
+#endif /* CONFIG_RAID5_DMA_ARCH_NEEDS_CHAN_SWITCH */
+
+/*
+ * dma_do_raid5_block_ops - perform block memory operations on stripe data
+ * outside the spin lock with dma engines
+ *
+ * A note about the need for __arch_raid5_dma_check_channel:
+ * This function is only needed to support architectures where a single raid
+ * operation spans multiple hardware channels.  For example on a reconstruct
+ * write, memory copy operations are submitted to a memcpy channel and then
+ * the routine must switch to the xor channel to complete the raid operation.
+ * __arch_raid5_dma_check_channel makes sure the previous operation has
+ * completed before returning the new channel.
+ * Some efficiency can be gained by putting the stripe back on the work
+ * queue rather than spin waiting.  This code is a work in progress and is
+ * available via the 'broken' option CONFIG_RAID5_DMA_WAIT_VIA_REQUEUE.
+ * If 'wait via requeue' is not defined the check_channel macro live waits
+ * for the next channel.
+ */
+static void dma_do_raid5_block_ops(void *stripe_head_ref)
+{
+	struct stripe_head *sh = stripe_head_ref;
+	int i, pd_idx = sh->pd_idx, disks = sh->disks;
+	dma_addr_t dma[MAX_HW_XOR_SRCS];
+	int overlap=0;
+	unsigned long state, ops_state, ops_state_orig;
+	raid5_conf_t *conf = sh->raid_conf;
+	dma_cookie_t cookie;
+	#ifdef CONFIG_RAID5_DMA_ARCH_NEEDS_CHAN_SWITCH
+	struct dma_chan *next_chan;
+	#endif
+
+	if (!sh->ops.dma_chan) {
+		sh->ops.dma_chan = __arch_raid5_dma_next_channel(raid5_dma_client);
+		dma_chan_get(sh->ops.dma_chan);
+		/* retrieve the last used cookie on this channel */
+		sh->ops.dma_cookie = dma_async_get_last_cookie(sh->ops.dma_chan);
+	}
+
+	/* take a snapshot of what needs to be done at this point in time */
+	spin_lock(&sh->lock);
+	state = sh->state;
+	ops_state_orig = ops_state = sh->ops.state;
+	spin_unlock(&sh->lock);
+
+	#ifdef CONFIG_RAID5_DMA_WAIT_VIA_REQUEUE
+	/* pick up where we left off */
+	if (sh->ops.ops_bookmark)
+		goto *sh->ops.ops_bookmark;
+	#endif
+
+	if (test_bit(STRIPE_OP_BIOFILL, &state) &&
+		!test_bit(STRIPE_OP_BIOFILL_Dma, &ops_state)) {
+		struct bio *return_bi;
+		PRINTK("%s: stripe %llu STRIPE_OP_BIOFILL op_state: %lx\n",
+			__FUNCTION__, (unsigned long long)sh->sector,
+			ops_state);
+
+		check_channel(DMA_MEMCPY, stripe_op_biofill);
+		return_bi = NULL;
+
+		for (i=disks ; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (test_bit(R5_ReadReq, &dev->flags)) {
+				struct bio *rbi, *rbi2;
+				spin_lock_irq(&conf->device_lock);
+				rbi = dev->toread;
+				dev->toread = NULL;
+				spin_unlock_irq(&conf->device_lock);
+				overlap++;
+				while (rbi && rbi->bi_sector < dev->sector + STRIPE_SECTORS) {
+					sh->ops.dma_cookie = dma_raid_copy_data(0,
+								rbi, dev->dma, dev->sector,
+								sh->ops.dma_chan,
+								sh->ops.dma_cookie);
+					rbi2 = r5_next_bio(rbi, dev->sector);
+					spin_lock_irq(&conf->device_lock);
+					if (--rbi->bi_phys_segments == 0) {
+						rbi->bi_next = return_bi;
+						return_bi = rbi;
+					}
+					spin_unlock_irq(&conf->device_lock);
+					rbi = rbi2;
+				}
+				dev->read = return_bi;
+			}
+		}
+		if (overlap)
+			set_bit(STRIPE_OP_BIOFILL_Dma, &ops_state);
+	}
+
+	if (test_bit(STRIPE_OP_COMPUTE, &state) &&
+		!test_bit(STRIPE_OP_COMPUTE_Dma, &ops_state)) {
+
+		/* dma engines do not need to pre-zero the destination */
+		if (test_and_clear_bit(STRIPE_OP_COMPUTE_Prep, &ops_state))
+			set_bit(STRIPE_OP_COMPUTE_Parity, &ops_state);
+
+		if (test_and_clear_bit(STRIPE_OP_COMPUTE_Parity, &ops_state)) {
+			dma_addr_t xor_destination_addr;
+			int dd_idx;
+			int count;
+
+			check_channel(DMA_XOR, stripe_op_compute_parity);
+			dd_idx = -1;
+			count = 0;
+
+			for (i=disks ; i-- ; )
+				if (test_bit(R5_ComputeReq, &sh->dev[i].flags)) {
+					dd_idx = i;
+					PRINTK("%s: stripe %llu STRIPE_OP_COMPUTE "
+					       "op_state: %lx block: %d\n",
+						__FUNCTION__,
+						(unsigned long long)sh->sector,
+						ops_state, dd_idx);
+					break;
+				}
+
+			BUG_ON(dd_idx < 0);
+
+			xor_destination_addr = sh->dev[dd_idx].dma;
+
+			for (i=disks ; i-- ; )
+				if (i != dd_idx) {
+					dma[count++] = sh->dev[i].dma;
+					check_xor();
+				}
+
+			if (count > 1)
+				issue_xor();
+
+			set_bit(STRIPE_OP_COMPUTE_Dma, &ops_state);
+		}
+	}
+
+	if (test_bit(STRIPE_OP_RMW, &state) &&
+		!test_bit(STRIPE_OP_RMW_Dma, &ops_state)) {
+		BUG_ON(test_bit(STRIPE_OP_RCW, &state));
+
+		PRINTK("%s: stripe %llu STRIPE_OP_RMW op_state: %lx\n",
+			__FUNCTION__, (unsigned long long)sh->sector,
+			ops_state);
+
+		if (test_and_clear_bit(STRIPE_OP_RMW_ParityPre, &ops_state)) {
+			dma_addr_t xor_destination_addr;
+			int count;
+
+			check_channel(DMA_XOR, stripe_op_rmw_paritypre);
+			count = 0;
+
+			/* existing parity data is used in the xor subtraction */
+			xor_destination_addr = dma[count++] = sh->dev[pd_idx].dma;
+
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				struct bio *chosen;
+
+				/* Only process blocks that are known to be uptodate */
+				if (dev->towrite && test_bit(R5_RMWReq, &dev->flags)) {
+					dma[count++] = dev->dma;
+
+					spin_lock(&sh->lock);
+					chosen = dev->towrite;
+					dev->towrite = NULL;
+					BUG_ON(dev->written);
+					dev->written = chosen;
+					spin_unlock(&sh->lock);
+
+					overlap++;
+
+					check_xor();
+				}
+			}
+			if (count > 1)
+				issue_xor();
+
+			set_bit(STRIPE_OP_RMW_Drain, &ops_state);
+		}
+
+		if (test_and_clear_bit(STRIPE_OP_RMW_Drain, &ops_state)) {
+
+			check_channel(DMA_MEMCPY, stripe_op_rmw_drain);
+
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				struct bio *wbi = dev->written;
+
+				while (wbi && wbi->bi_sector < dev->sector + STRIPE_SECTORS) {
+					sh->ops.dma_cookie = dma_raid_copy_data(1,
+							     wbi, dev->dma, dev->sector,
+							     sh->ops.dma_chan,
+							     sh->ops.dma_cookie);
+					wbi = r5_next_bio(wbi, dev->sector);
+				}
+			}
+			set_bit(STRIPE_OP_RMW_ParityPost, &ops_state);
+		}
+
+		if (test_and_clear_bit(STRIPE_OP_RMW_ParityPost, &ops_state)) {
+			dma_addr_t xor_destination_addr;
+			int count;
+
+			check_channel(DMA_XOR, stripe_op_rmw_paritypost);
+			count = 0;
+
+			xor_destination_addr = dma[count++] = sh->dev[pd_idx].dma;
+
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				if (dev->written) {
+					dma[count++] = dev->dma;
+					check_xor();
+				}
+			}
+			if (count > 1)
+				issue_xor();
+
+			set_bit(STRIPE_OP_RMW_Dma, &ops_state);
+		}
+	}
+
+	if (test_bit(STRIPE_OP_RCW, &state) &&
+		!test_bit(STRIPE_OP_RCW_Dma, &ops_state)) {
+		BUG_ON(test_bit(STRIPE_OP_RMW, &state));
+
+		PRINTK("%s: stripe %llu STRIPE_OP_RCW op_state: %lx\n",
+			__FUNCTION__, (unsigned long long)sh->sector,
+			ops_state);
+
+
+		if (test_and_clear_bit(STRIPE_OP_RCW_Drain, &ops_state)) {
+
+			check_channel(DMA_MEMCPY, stripe_op_rcw_drain);
+
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				struct bio *chosen;
+				struct bio *wbi;
+
+				if (i!=pd_idx && dev->towrite &&
+					test_bit(R5_LOCKED, &dev->flags)) {
+
+					spin_lock(&sh->lock);
+					chosen = dev->towrite;
+					dev->towrite = NULL;
+					BUG_ON(dev->written);
+					wbi = dev->written = chosen;
+					spin_unlock(&sh->lock);
+
+					overlap++;
+
+					while (wbi && wbi->bi_sector < dev->sector + STRIPE_SECTORS) {
+						sh->ops.dma_cookie = dma_raid_copy_data(1,
+								     wbi, dev->dma, dev->sector,
+								     sh->ops.dma_chan,
+								     sh->ops.dma_cookie);
+						wbi = r5_next_bio(wbi, dev->sector);
+					}
+				}
+			}
+			set_bit(STRIPE_OP_RCW_Parity, &ops_state);
+		}
+
+		if (test_and_clear_bit(STRIPE_OP_RCW_Parity, &ops_state)) {
+			dma_addr_t xor_destination_addr;
+			int count;
+
+			check_channel(DMA_XOR, stripe_op_rcw_parity);
+			count = 0;
+
+			xor_destination_addr = sh->dev[pd_idx].dma;
+
+			for (i=disks; i--;)
+				if (i != pd_idx) {
+					dma[count++] = sh->dev[i].dma;
+					check_xor();
+				}
+			if (count > 1)
+				issue_xor();
+
+			set_bit(STRIPE_OP_RCW_Dma, &ops_state);
+		}
+	}
+
+	if (test_bit(STRIPE_OP_CHECK, &state) &&
+		!test_bit(STRIPE_OP_CHECK_Dma, &ops_state)) {
+		PRINTK("%s: stripe %llu STRIPE_OP_CHECK op_state: %lx\n",
+		__FUNCTION__, (unsigned long long)sh->sector,
+		ops_state);
+
+		if (test_and_clear_bit(STRIPE_OP_CHECK_Gen, &ops_state)) {
+
+			check_channel(DMA_XOR | DMA_ZERO_SUM, stripe_op_check_gen);
+
+			if (disks > MAX_HW_XOR_SRCS) {
+				/* we need to do a destructive xor 
+				 * i.e. the result needs to be temporarily stored in memory
+				 */
+				dma_addr_t xor_destination_addr;
+				int count = 0;
+				int skip = -1;
+
+				xor_destination_addr = dma[count++] = sh->dev[pd_idx].dma;
+
+				/* xor all but one block */
+				for (i=disks; i--;)
+					if (i != pd_idx) {
+						if (skip < 0) {
+							skip = i;
+							continue;
+						}
+						dma[count++] = sh->dev[i].dma;
+						check_xor();
+					}
+				if (count > 1)
+					issue_xor();
+
+				/* zero result check the skipped block with
+				 * the new parity
+				 */
+				count = 2;
+				dma[1] = sh->dev[skip].dma;
+				do {
+					cookie = dma_async_zero_sum_dma_list(
+						sh->ops.dma_chan,
+						dma,
+						count,
+						STRIPE_SIZE,
+						&sh->ops.dma_result);
+					if (cookie == -ENOMEM)
+						dma_sync_wait(sh->ops.dma_chan,
+						sh->ops.dma_cookie);
+					else
+						WARN_ON(cookie <= 0);
+				} while (cookie == -ENOMEM);
+				sh->ops.dma_cookie = cookie;
+			} else {
+				int count = 0;
+				for (i=disks; i--;)
+					dma[count++] = sh->dev[i].dma;
+				do {
+					cookie = dma_async_zero_sum_dma_list(
+						sh->ops.dma_chan,
+						dma,
+						count,
+						STRIPE_SIZE,
+						&sh->ops.dma_result);
+					if (cookie == -ENOMEM)
+						dma_sync_wait(sh->ops.dma_chan,
+						sh->ops.dma_cookie);
+					else
+						WARN_ON(cookie <= 0);
+				} while (cookie == -ENOMEM);
+				sh->ops.dma_cookie = cookie;
+			}
+			set_bit(STRIPE_OP_CHECK_Verify, &ops_state);
+			set_bit(STRIPE_OP_CHECK_Dma, &ops_state);
+		}
+	}
+
+#ifdef CONFIG_RAID5_DMA_WAIT_VIA_REQUEUE
+raid5_dma_retry:
+#endif
+	spin_lock(&sh->lock);
+	/* Update the state of operations:
+	 * -clear incoming requests
+	 * -preserve output status (i.e. done status / check result / dma)
+	 * -preserve requests added since 'ops_state_orig' was set
+	 */
+	sh->ops.state ^= (ops_state_orig & ~STRIPE_OP_COMPLETION_MASK);
+	sh->ops.state |= ops_state;
+
+	/* if we cleared an overlap condition wake up threads in make_request */
+	if (overlap)
+		for (i= disks; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (test_and_clear_bit(R5_Overlap, &dev->flags))
+				wake_up(&sh->raid_conf->wait_for_overlap);
+		}
+
+	if (dma_async_operation_complete(sh->ops.dma_chan, sh->ops.dma_cookie,
+					NULL, NULL) == DMA_IN_PROGRESS)
+		dma_async_issue_pending(sh->ops.dma_chan);
+	else { /* now that dma operations have quiesced update the stripe state */
+		int written, work;
+		written = 0;
+		work = 0;
+
+		if (test_and_clear_bit(STRIPE_OP_BIOFILL_Dma, &sh->ops.state)) {
+			work++;
+			set_bit(STRIPE_OP_BIOFILL_Done, &sh->ops.state);
+		}
+		if (test_and_clear_bit(STRIPE_OP_COMPUTE_Dma, &sh->ops.state)) {
+			for (i=disks ; i-- ;)
+				if (test_and_clear_bit(R5_ComputeReq,
+						       &sh->dev[i].flags)) {
+					set_bit(R5_UPTODATE,
+						&sh->dev[i].flags);
+					break;
+				}
+			work++;
+			set_bit(STRIPE_OP_COMPUTE_Done, &sh->ops.state);
+		}
+		if (test_and_clear_bit(STRIPE_OP_RCW_Dma, &sh->ops.state)) {
+			work++;
+			written++;
+			set_bit(R5_UPTODATE, &sh->dev[sh->pd_idx].flags);
+			set_bit(STRIPE_OP_RCW_Done, &sh->ops.state);
+		}
+		if (test_and_clear_bit(STRIPE_OP_RMW_Dma, &sh->ops.state)) {
+			work++;
+			written++;
+			set_bit(R5_UPTODATE, &sh->dev[sh->pd_idx].flags);
+			set_bit(STRIPE_OP_RMW_Done, &sh->ops.state);
+		}
+		if (written)
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				if (dev->written)
+					set_bit(R5_UPTODATE, &dev->flags);
+			}
+		if (test_and_clear_bit(STRIPE_OP_CHECK_Dma, &sh->ops.state)) {
+			if (test_and_clear_bit(STRIPE_OP_CHECK_Verify,
+				&sh->ops.state)) {
+				work++;
+				if (sh->ops.dma_result == 0) {
+					set_bit(STRIPE_OP_CHECK_IsZero,
+						&sh->ops.state);
+
+					/* if the parity is correct and we
+					 * performed the check withtout dirtying
+					 * the parity block, mark it up to date.
+					 */
+					if (disks <= MAX_HW_XOR_SRCS)
+						set_bit(R5_UPTODATE, 
+						&sh->dev[sh->pd_idx].flags);
+
+				} else
+					clear_bit(STRIPE_OP_CHECK_IsZero,
+						&sh->ops.state);
+
+				set_bit(STRIPE_OP_CHECK_Done, &sh->ops.state);
+
+			} else
+				BUG();
+		}
+
+		sh->ops.pending -= work;
+		BUG_ON(sh->ops.pending < 0);
+
+		#ifdef CONFIG_RAID5_DMA_WAIT_VIA_REQUEUE
+		/* return to the bookmark to continue the operation */
+		if (sh->ops.ops_bookmark) {
+			overlap = 0;
+			state = sh->state;
+			ops_state_orig = ops_state = sh->ops.state;
+			spin_unlock(&sh->lock);
+			goto *sh->ops.ops_bookmark;
+		}
+		#endif
+
+		/* the stripe is done with the channel */
+		dma_chan_put(sh->ops.dma_chan);
+		sh->ops.dma_chan = NULL;
+		sh->ops.dma_cookie = 0;
+	}
+
+	BUG_ON(sh->ops.pending == 0 && sh->ops.dma_chan);
+	clear_bit(STRIPE_OP_QUEUED, &sh->state);
+	set_bit(STRIPE_HANDLE, &sh->state);
+	queue_raid_work(sh);
+	spin_unlock(&sh->lock);
+
+	release_stripe(sh);
+}
+
+static void raid5_dma_event_callback(struct dma_client *client,
+			struct dma_chan *chan, enum dma_event event)
+{
+	switch (event) {
+	case DMA_RESOURCE_SUSPEND:
+		PRINTK("%s: DMA_RESOURCE_SUSPEND\n", __FUNCTION__);
+		break;
+	case DMA_RESOURCE_RESUME:
+		PRINTK("%s: DMA_RESOURCE_RESUME\n", __FUNCTION__);
+		break;
+	case DMA_RESOURCE_ADDED:
+		PRINTK("%s: DMA_RESOURCE_ADDED\n", __FUNCTION__);
+		break;
+	case DMA_RESOURCE_REMOVED:
+		PRINTK("%s: DMA_RESOURCE_REMOVED\n", __FUNCTION__);
+		break;
+	default:
+		PRINTK("%s: unknown\n", __FUNCTION__);
+		break;
+	}
+
+}
+
+static int __init raid5_dma_init (void)
+{
+	raid5_dma_client = dma_async_client_register(
+				&raid5_dma_event_callback);
+
+	if (raid5_dma_client == NULL)
+		return -ENOMEM;
+
+	__arch_raid5_dma_chan_request(raid5_dma_client);
+
+	printk("raid5-dma: driver initialized\n");
+	return 0;
+
+}
+
+static void __init raid5_dma_exit (void)
+{
+	if (raid5_dma_client)
+		dma_async_client_unregister(raid5_dma_client);
+
+	raid5_dma_client = NULL;
+}
+
+static struct dma_chan *raid5_dma_next_channel(void)
+{
+	return __arch_raid5_dma_next_channel(raid5_dma_client);
+}
+
+void raid5_dma_get_dma(struct raid5_dma *dma)
+{
+	dma->owner = THIS_MODULE;
+	dma->channel_iterate = raid5_dma_next_channel;
+	dma->do_block_ops = dma_do_raid5_block_ops;
+	atomic_inc(&raid5_count);
+}
+
+EXPORT_SYMBOL_GPL(raid5_dma_get_dma);
+
+module_init(raid5_dma_init);
+module_exit(raid5_dma_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("RAID5-DMA Offload Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 2a16b3b..dbd3ddc 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -183,6 +183,17 @@ config MD_RAID456_WORKQUEUE_MULTITHREAD
 
 	  If unsure say, Y.
 
+config MD_RAID5_HW_OFFLOAD
+	depends on MD_RAID456 && RAID5_DMA
+	bool "Execute raid5 xor/copy operations with hardware engines"
+	default y
+	---help---
+	  On platforms with the requisite hardware capabilities MD
+	  can offload  RAID5 stripe cache operations (i.e. parity
+	  maintenance and bio buffer copies)
+
+	  If unsure say, Y.
+
 config MD_MULTIPATH
 	tristate "Multipath I/O support"
 	depends on BLK_DEV_MD
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index ad6883b..4daa335 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -53,6 +53,16 @@ #include "raid6.h"
 
 #include <linux/raid/bitmap.h>
 
+#ifdef CONFIG_MD_RAID5_HW_OFFLOAD
+#include <linux/dma-mapping.h>
+extern void raid5_dma_get_dma(struct raid5_dma *dma);
+#endif /* CONFIG_MD_RAID5_HW_OFFLOAD */
+
+#ifdef CONFIG_MD_RAID6_HW_OFFLOAD
+#include <linux/dma-mapping.h>
+extern void raid6_dma_get_dma(struct raid6_dma *dma);
+#endif /* CONFIG_MD_RAID6_HW_OFFLOAD */
+
 /*
  * Stripe cache
  */
@@ -138,7 +148,7 @@ static void __release_stripe(raid5_conf_
 		}
 	}
 }
-static void release_stripe(struct stripe_head *sh)
+void release_stripe(struct stripe_head *sh)
 {
 	raid5_conf_t *conf = sh->raid_conf;
 	unsigned long flags;
@@ -193,6 +203,17 @@ static void shrink_buffers(struct stripe
 		p = sh->dev[i].page;
 		if (!p)
 			continue;
+		#ifdef CONFIG_MD_RAID5_HW_OFFLOAD
+		do {
+			raid5_conf_t *conf = sh->raid_conf;
+			struct dma_chan *chan = conf->dma.channel_iterate();
+			/* assumes that all channels share the same mapping
+			 * characteristics
+			 */
+			dma_async_unmap_page(chan, sh->dev[i].dma,
+					PAGE_SIZE, DMA_FROM_DEVICE);
+		} while (0);
+		#endif
 		sh->dev[i].page = NULL;
 		put_page(p);
 	}
@@ -209,6 +230,20 @@ static int grow_buffers(struct stripe_he
 			return 1;
 		}
 		sh->dev[i].page = page;
+		#ifdef CONFIG_MD_RAID5_HW_OFFLOAD
+		do {
+			raid5_conf_t *conf = sh->raid_conf;
+			struct dma_chan *chan = conf->dma.channel_iterate();
+			/* assumes that all channels share the same mapping
+			 * characteristics
+			 */
+			sh->dev[i].dma = dma_async_map_page(chan,
+							sh->dev[i].page,
+							0,
+							PAGE_SIZE,
+							DMA_FROM_DEVICE);
+		} while (0);
+		#endif
 	}
 	return 0;
 }
@@ -576,6 +611,13 @@ #if 0
 #else
 		set_bit(R5_UPTODATE, &sh->dev[i].flags);
 #endif
+#ifdef CONFIG_MD_RAID5_HW_OFFLOAD
+		/* If the backing block device driver performed a pio
+		 * read then the buffer needs to be cleaned
+		 */
+		consistent_sync(page_address(sh->dev[i].page), PAGE_SIZE,
+				DMA_TO_DEVICE);
+#endif
 		if (test_bit(R5_ReadError, &sh->dev[i].flags)) {
 			rdev = conf->disks[i].rdev;
 			printk(KERN_INFO "raid5:%s: read error corrected (%lu sectors at %llu on %s)\n",
@@ -666,6 +708,15 @@ static int raid5_end_write_request (stru
 	rdev_dec_pending(conf->disks[i].rdev, conf->mddev);
 	
 	clear_bit(R5_LOCKED, &sh->dev[i].flags);
+
+	#ifdef CONFIG_MD_RAID5_HW_OFFLOAD
+	/* If the backing block device driver performed a pio
+	 * write then the buffer needs to be invalidated
+	 */
+	consistent_sync(page_address(sh->dev[i].page), PAGE_SIZE,
+			DMA_FROM_DEVICE);
+	#endif
+
 	set_bit(STRIPE_HANDLE, &sh->state);
 	__release_stripe(conf, sh);
 	spin_unlock_irqrestore(&conf->device_lock, flags);
@@ -1311,6 +1362,7 @@ static int stripe_to_pdidx(sector_t stri
 	return pd_idx;
 }
 
+#ifndef CONFIG_MD_RAID5_HW_OFFLOAD
 /*
  * raid5_do_soft_block_ops - perform block memory operations on stripe data
  * outside the spin lock.
@@ -1600,6 +1652,7 @@ static void raid5_do_soft_block_ops(void
 
 	release_stripe(sh);
 }
+#endif /* #ifndef CONFIG_MD_RAID5_HW_OFFLOAD*/
 
 /*
  * handle_stripe - do things to a stripe.
@@ -3553,12 +3606,12 @@ static int run(mddev_t *mddev)
 	#endif
 	#endif
 
-	/* To Do:
-	 * 1/ Offload to asynchronous copy / xor engines
-	 * 2/ Automated selection of optimal do_block_ops
-	 *	routine similar to the xor template selection
-	 */
+	#ifdef CONFIG_MD_RAID5_HW_OFFLOAD
+	raid5_dma_get_dma(&conf->dma);
+	conf->do_block_ops = conf->dma.do_block_ops;
+	#else
 	conf->do_block_ops = raid5_do_soft_block_ops;
+	#endif
 
 
 	spin_lock_init(&conf->device_lock);
@@ -4184,6 +4237,7 @@ static void raid5_exit(void)
 	unregister_md_personality(&raid4_personality);
 }
 
+EXPORT_SYMBOL(release_stripe);
 module_init(raid5_init);
 module_exit(raid5_exit);
 MODULE_LICENSE("GPL");
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 0a70c9e..7fd5aaf 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -762,6 +762,11 @@ static inline enum dma_status dma_sync_w
 	return status;
 }
 
+static inline dma_cookie_t dma_async_get_last_cookie(struct dma_chan *chan)
+{
+	return chan->cookie;
+}
+
 /* --- DMA device --- */
 
 int dma_async_device_register(struct dma_device *device);
diff --git a/include/linux/raid/raid5.h b/include/linux/raid/raid5.h
index 31ae55c..f5b021d 100644
--- a/include/linux/raid/raid5.h
+++ b/include/linux/raid/raid5.h
@@ -4,6 +4,9 @@ #define _RAID5_H
 #include <linux/raid/md.h>
 #include <linux/raid/xor.h>
 #include <linux/workqueue.h>
+#ifdef CONFIG_MD_RAID5_HW_OFFLOAD
+#include <linux/dmaengine.h>
+#endif
 
 /*
  *
@@ -169,16 +172,28 @@ struct stripe_head {
 		#ifdef CONFIG_MD_RAID456_WORKQUEUE
 		struct work_struct	work;		/* work queue descriptor */
 		#endif
+		#ifdef CONFIG_MD_RAID5_HW_OFFLOAD
+		u32 			dma_result;	/* storage for dma engine zero sum results */
+		dma_cookie_t		dma_cookie;	/* last issued dma operation */
+		struct dma_chan		*dma_chan;	/* dma channel for ops offload */
+		#ifdef CONFIG_RAID5_DMA_WAIT_VIA_REQUEUE
+		void			*ops_bookmark;	/* place holder for requeued stripes */
+		#endif /* CONFIG_RAID5_DMA_WAIT_VIA_REQUEUE */
+		#endif /* CONFIG_MD_RAID5_HW_OFFLOAD */
 	} ops;
 	struct r5dev {
 		struct bio	req;
 		struct bio_vec	vec;
 		struct page	*page;
+		#ifdef CONFIG_MD_RAID5_HW_OFFLOAD
+		dma_addr_t	dma;
+		#endif
 		struct bio	*toread, *read, *towrite, *written;
 		sector_t	sector;			/* sector of this page */
 		unsigned long	flags;
 	} dev[1]; /* allocated with extra space depending of RAID geometry */
 };
+
 /* Flags */
 #define	R5_UPTODATE	0	/* page contains current data */
 #define	R5_LOCKED	1	/* IO has been submitted on "req" */
@@ -190,7 +205,6 @@ #define	R5_Wantwrite	5
 #define	R5_Overlap	7	/* There is a pending overlapping request on this block */
 #define	R5_ReadError	8	/* seen a read error here recently */
 #define	R5_ReWrite	9	/* have tried to over-write the readerror */
-
 #define	R5_Expanded	10	/* This block now has post-expand data */
 #define	R5_Consistent	11	/* Block is HW DMA-able without a cache flush */
 #define	R5_ComputeReq	12	/* compute_block in progress treat as uptodate */
@@ -373,6 +387,14 @@ struct raid5_private_data {
 	int			pool_size; /* number of disks in stripeheads in pool */
 	spinlock_t		device_lock;
 	struct disk_info	*disks;
+#ifdef CONFIG_MD_RAID5_HW_OFFLOAD
+	struct raid5_dma {
+		struct module *owner;
+		void (*do_block_ops)(void *stripe_ref);
+		struct dma_chan * (*channel_iterate)(void);
+	} dma;
+#endif
+
 };
 
 typedef struct raid5_private_data raid5_conf_t;
