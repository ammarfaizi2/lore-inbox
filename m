Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWBCBqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWBCBqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWBCBqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:46:46 -0500
Received: from fmr21.intel.com ([143.183.121.13]:55442 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932508AbWBCBqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:46:45 -0500
Subject: [RFC][PATCH 002 of 3] MD Acceleration: md_adma driver for raid5
	offload
From: Dan Williams <dan.j.williams@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 18:46:44 -0700
Message-Id: <1138931204.6620.10.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a re-write of the original raid5.c:compute_parity
and raid5.c:copy_data routines.  For md_issue_copy_data() special
consideration had to be made for highmem buffers, since it appears that
holding an atomic mapping until the copy is complete would be
problematic.  Both routines handle falling back to pio mode if a
descriptor resource can not be allocated.

The call back routines contain the stripe state modification code
aggregated from the original raid5.c:handle_stripe,
raid5.c:compute_parity, and raid5.c:copy_data routines.

Note for debug purposes I copy and pasted the contents of the check_xor
() macro into the proper locations.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/include/linux/adma/md_adma.h b/include/linux/adma/md_adma.h
new file mode 100644
index 0000000..54b86e2
--- /dev/null
+++ b/include/linux/adma/md_adma.h
@@ -0,0 +1,22 @@
+#ifndef _MD_ADMA_H
+#define _MD_ADMA_H
+#include <linux/adma/adma.h>
+#include <linux/raid/raid5.h>
+
+struct stripe_head;
+struct bio;
+struct page;
+
+int raid5_issue_compute_parity(struct stripe_head *sh, int method);
+int md_issue_copy_data(int frombio, struct bio *bio,
+		     struct page *page, sector_t sector,
+		     struct stripe_head *sh, int dev_idx);
+/* This flag is used everywhere we can start
+ * the mdadma thread but are not required.  Mainly
+ * for testing purposes.
+ * 1 -> start
+ * 0 -> do not start
+ */
+#define MD_ADMA_QUEUE	0
+
+#endif
diff --git a/drivers/md/md_adma.c b/drivers/md/md_adma.c
new file mode 100644
index 0000000..e92703e
--- /dev/null
+++ b/drivers/md/md_adma.c
@@ -0,0 +1,546 @@
+/*
+ * md_adma.c : Asychronous DMA / XOR support for Raid5 and Raid6 acceleration
+ * Author: Dan Williams (dan.j.williams@intel.com)
+ * Copyright (C) 2006 Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/adma/md_adma.h>
+
+ /*
+  * The following can be used to debug the driver
+  */
+#define MD_ADMA_DEBUG     0
+#define PRINTK(x...) ((void)(MD_ADMA_DEBUG && printk(x)))
+
+static inline void __md_adma_copy_data_callback(struct stripe_head *sh, int dev_idx)
+{
+	spin_lock(&sh->lock);
+	set_bit(R5_UPTODATE, &sh->dev[dev_idx].flags);
+	spin_unlock(&sh->lock);
+}
+
+static void md_adma_copy_data_callback(adma_desc_t *desc, void *args)
+{
+	struct stripe_head *sh = args;
+	int dev_idx = adma_get_callback_state(desc);
+
+	__md_adma_copy_data_callback(sh, dev_idx);
+
+	adma_put_desc(desc);
+}
+
+void __raid5_adma_xor_callback(struct stripe_head *sh, int stripe_command)
+{
+	raid5_conf_t *conf = sh->raid_conf;
+	int disks = conf->raid_disks;
+	int i, failed=0;
+
+	spin_lock(&sh->lock);
+	/* as long as at least one xor operation is in flight we keep R5_InAsyncXor active
+	 * the result being that subsequent xor operations will be queued even though 
+	 * R5_LOCKED is set
+	 */
+	atomic_dec(&sh->xor_count);
+	if (!atomic_dec_and_test(&sh->xor_count))
+	{
+		switch(stripe_command) {
+			case CHECK_PARITY:
+				/* not yet supported */
+				/*clear_bit(R5_UPTODATE, &sh->dev[sh->pd_idx].flags);*/
+				break;
+			case READ_MODIFY_WRITE:
+			case RECONSTRUCT_WRITE:
+				set_bit(R5_UPTODATE, &sh->dev[sh->pd_idx].flags);
+				set_bit(R5_LOCKED,   &sh->dev[sh->pd_idx].flags);
+				break;
+			case COMPUTE_BLOCK:
+				break;
+		}
+
+		if (unlikely(!test_and_clear_bit(R5_InAsyncXor, &sh->state)))
+			BUG();
+	}
+
+	/* this code is copied from raid5_handle_stripe to get 'failed' and R5_Insync */
+	rcu_read_lock();
+	for (i=disks; i--; ) {
+		mdk_rdev_t *rdev;
+		struct r5dev *dev = &sh->dev[i];
+
+		rdev = rcu_dereference(conf->disks[i].rdev);
+		if (!rdev || !test_bit(In_sync, &rdev->flags)) {
+			/* The ReadError flag will just be confusing now */
+			clear_bit(R5_ReadError, &dev->flags);
+			clear_bit(R5_ReWrite, &dev->flags);
+		}
+		if (!rdev || !test_bit(In_sync, &rdev->flags)
+		    || test_bit(R5_ReadError, &dev->flags))
+			failed++;
+		else
+			set_bit(R5_Insync, &dev->flags);
+	}
+	rcu_read_unlock();
+
+	/* we finish off the compute_parity or compute_block call 
+	 * and advance the stripe state 
+	 */
+	switch(stripe_command) {
+		case READ_MODIFY_WRITE:
+		case RECONSTRUCT_WRITE:
+			for (i=disks; i--;) {
+				if (test_bit(R5_LOCKED, &sh->dev[i].flags) && 
+				    !test_bit(R5_InAsyncXor, &sh->state)) {
+					PRINTK("Writing block %d\n", i);
+					if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
+						wake_up(&conf->wait_for_overlap);
+
+					if (sh->dev[i].inwrite) {
+						sh->dev[i].written = sh->dev[i].inwrite;
+						sh->dev[i].inwrite = NULL;
+					}
+
+					set_bit(R5_Wantwrite, &sh->dev[i].flags);
+					if (!test_bit(R5_Insync, &sh->dev[i].flags)
+					    || (i==sh->pd_idx && failed == 0))
+						set_bit(STRIPE_INSYNC, &sh->state);
+				}
+			}
+
+			if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, 
+					       &sh->state)) {
+				atomic_dec(&conf->preread_active_stripes);
+				if (atomic_read(&conf->preread_active_stripes)
+						< IO_THRESHOLD)
+					md_wakeup_thread(conf->mddev->thread);
+			}
+			break;
+		case CHECK_PARITY:
+			break;
+		case COMPUTE_BLOCK:
+			break;
+		default:
+			BUG();
+	}
+	spin_unlock(&sh->lock);
+
+	raid5_handle_stripe(sh);
+	raid5_release_stripe(sh);
+}
+
+void raid5_adma_xor_callback(adma_desc_t *desc, void *args)
+{
+	struct stripe_head *sh = args;
+	int stripe_command = adma_get_callback_state(desc);
+
+	__raid5_adma_xor_callback(sh, stripe_command);
+
+	adma_put_desc(desc);
+}
+
+
+/*
+ * Issue a copy data operation between a page in the stripe cache, and a bio.
+ * There are no alignment or size guarantees between the page or the
+ * bio except that there is some overlap.
+ * All iovecs in the bio must be considered.
+ *
+ * Assumes being called under sh->lock
+ * 
+ * @dev_idx: the raid device index that is being modified
+ * 
+ * Returns true if the copy is complete, returns false if copy is asynchronous
+ */
+int md_issue_copy_data(int frombio, struct bio *bio,
+		     struct page *page, sector_t sector,
+		     struct stripe_head *sh, int dev_idx)
+{
+	char *pa = page_address(page);
+	struct bio_vec *bvl;
+	int i, desc_cnt = 0, pio = 0;
+	int page_offset;
+	void *buf[2];
+	adma_engine_t *eng = sh->raid_conf->adma_engine;
+	adma_desc_t *desc = adma_get_desc(eng), *next_desc = 0;
+
+	if(!test_bit(ADMA_ENG_CAP_COPY, &eng->flags))
+		pio++;
+
+	if (bio->bi_sector >= sector)
+		page_offset = (signed)(bio->bi_sector - sector) * 512;
+	else
+		page_offset = (signed)(sector - bio->bi_sector) * -512;
+	bio_for_each_segment(bvl, bio, i) {
+		int len = bio_iovec_idx(bio,i)->bv_len;
+		int clen;
+		int b_offset = 0;
+
+		if (page_offset < 0) {
+			b_offset = -page_offset;
+			page_offset += b_offset;
+			len -= b_offset;
+		}
+
+		if (len > 0 && page_offset + len > STRIPE_SIZE)
+			clen = STRIPE_SIZE - page_offset;
+		else clen = len;
+			
+		if (clen > 0) {
+			char *ba = __bio_kmap_atomic(bio, i, KM_USER0);
+
+			if (desc_cnt) {
+				eng->queue_desc(desc, MD_ADMA_QUEUE);
+				next_desc = adma_get_desc(eng);
+				if (next_desc) adma_set_desc_flags(desc, ADMA_AUTO_REAP);
+			}
+
+			if (frombio) {
+				buf[0] = pa+page_offset;
+				buf[1] = ba+b_offset;
+			} else {
+				buf[0] = ba+b_offset;
+				buf[1] = pa+page_offset;
+			}
+
+			if (pio) goto pio_memcpy;
+
+			/* if the adma engine can not access the bio page directly
+			 * (pio_adma on highmem platforms or dma address restrictions) 
+			 * then we must copy synchronously.
+			 * i.e. we can't / shouldn't hold a true atomic mapping while the
+			 * adma_engine performs an asynchronous memcpy
+			 */
+			#ifdef CONFIG_HIGHMEM
+			if(!test_bit(ADMA_ENG_CAP_HIGHMEM, &eng->flags))
+				goto pio_memcpy;
+			#endif
+
+
+			/* handle memory allocation failures:
+			 * if we fail to allocate the necessary structures then
+			 * (re)do everything as a pio memcpy.  If some descriptors have
+			 * already been successfully queued then we need to run
+			 * the adma thread to get them cleaned up
+			 */
+			if (unlikely(!desc || (desc_cnt && !next_desc))) {
+				if (desc_cnt) {
+					/* we run the thread directly since we are not 
+					 * preemptible
+					 */
+					adma_run(eng);
+					/* we busy wait on prev_desc so
+					 * that the pio operation does not
+					 * conflict with the engine.
+					 */
+					adma_spin_wait_desc(desc);
+					adma_put_desc(desc);
+					desc_cnt = 0;
+				} else if (desc) /* we don't have args, and never will */
+					adma_put_desc(desc);
+				 
+				goto pio_memcpy;
+			}
+
+			if (desc_cnt) {
+				desc = next_desc;
+				next_desc = NULL;
+			}
+
+			eng->build_desc(desc, ADMA_COPY, buf, ARRAY_SIZE(buf), clen, 0);
+			desc_cnt++;
+			continue;
+
+pio_memcpy:		pio++;
+			memcpy(buf[0], buf[1], clen);
+			__bio_kunmap_atomic(ba, KM_USER0);
+
+		}
+		if (clen < len) /* hit end of page */
+			break;
+		page_offset +=  len;
+	}
+	
+	if (desc) { /* queue and run the final descriptor */
+		adma_set_desc_flags(desc, 0);
+		adma_set_callback(desc, md_adma_copy_data_callback, sh, dev_idx);
+		eng->queue_desc(desc, MD_ADMA_QUEUE);
+		if(!frombio) { /* we are reading so client expects data immediately */
+			adma_run(eng);
+			adma_spin_wait_desc(desc);
+		} else adma_wakeup_thread(eng->thread);
+	} else if (pio) 
+		__md_adma_copy_data_callback(sh, dev_idx);
+
+	return pio;
+}
+
+#define check_xor() do {						    \
+if (likely(desc))							    \
+	 max_sources = adma_get_source_count(eng);			    \
+else									    \
+	 max_sources = MAX_XOR_BLOCKS;					    \
+if (count == max_sources || last || mid) {				    \
+	if (desc) {							    \
+		eng->build_desc(desc, ADMA_XOR, ptr, count, STRIPE_SIZE, 0);\
+		if (last) {						    \
+			adma_set_callback(desc, raid5_adma_xor_callback, sh, method);\
+			next_desc = NULL;				    \
+		} else {						    \
+			next_desc = adma_get_desc(eng);			    \
+			if (likely(next_desc))				    \
+				adma_set_desc_flags(desc, ADMA_AUTO_REAP);  \
+		}							    \
+		eng->queue_desc(desc, last ? 1 : MD_ADMA_QUEUE);	    \
+		if (likely(!last) && unlikely(!next_desc)) {		    \
+			adma_run(eng);					    \
+			adma_spin_wait_desc(desc);			    \
+			adma_put_desc(desc);				    \
+      		}							    \
+      		desc = last ? desc : next_desc;				    \
+	} else xor_block(count, STRIPE_SIZE, ptr);			    \
+	count = 1;							    \
+}									    \
+} while(0)
+
+int raid5_issue_compute_parity(struct stripe_head *sh, int method)
+{
+	raid5_conf_t *conf = sh->raid_conf;
+	int i, pd_idx = sh->pd_idx, disks = conf->raid_disks, count;
+	int max_sources = 0, last = 0, mid = 0, locked = 0;
+	struct bio *chosen;
+	void *ptr[MAX_ADMA_SOURCE_BLOCKS];
+	adma_engine_t *eng = conf->adma_engine;
+	/* if we fail to allocate then fallback to pio xor */
+	adma_desc_t *desc = adma_get_desc(eng), *next_desc = 0;
+
+	if(!test_bit(ADMA_ENG_CAP_XOR, &eng->flags))
+		if(desc) adma_put_desc(desc);
+
+	PRINTK("compute_parity, stripe %llu, method %d\n",
+		(unsigned long long)sh->sector, method);
+
+	atomic_inc(&sh->xor_count);
+	set_bit(R5_InAsyncXor, &sh->state);
+
+	count = 1;
+	ptr[0] = page_address(sh->dev[pd_idx].page);
+	switch(method) {
+	case READ_MODIFY_WRITE:
+		if (!test_bit(R5_UPTODATE, &sh->dev[pd_idx].flags))
+			BUG();
+		for (i=disks ; i-- ;) {
+			if (i==pd_idx)
+				continue;
+			if (sh->dev[i].towrite &&
+			    test_bit(R5_UPTODATE, &sh->dev[i].flags)) {
+				ptr[count++] = page_address(sh->dev[i].page);
+				chosen = sh->dev[i].towrite;
+				sh->dev[i].towrite = NULL;
+				if (sh->dev[i].written || sh->dev[i].inwrite) BUG();
+				sh->dev[i].inwrite = chosen;
+				/* start check_xor() */
+				if (likely(desc))
+					 max_sources = adma_get_source_count(eng);
+				else
+					 max_sources = MAX_XOR_BLOCKS;
+				if (count == max_sources || last || mid) {
+					if (desc) {
+						eng->build_desc(desc, ADMA_XOR, ptr, count, STRIPE_SIZE, 0);
+						if (last) {
+							adma_set_callback(desc, raid5_adma_xor_callback, sh, method);
+							next_desc = NULL;
+						} else {
+							next_desc = adma_get_desc(eng);
+							if (likely(next_desc))
+								adma_set_desc_flags(desc, ADMA_AUTO_REAP);
+						}
+						eng->queue_desc(desc, last ? 1 : MD_ADMA_QUEUE);
+						if (likely(!last) && unlikely(!next_desc)) {
+							adma_run(eng);
+							adma_spin_wait_desc(desc);
+							adma_put_desc(desc);
+				      		}
+				      		desc = last ? desc : next_desc;
+					} else xor_block(count, STRIPE_SIZE, ptr);
+					count = 1;
+				}
+				/* end check_xor() */
+			}
+		}
+		break;
+	case RECONSTRUCT_WRITE:
+		memset(ptr[0], 0, STRIPE_SIZE);
+		for (i= disks; i-- ;)
+			if (i!=pd_idx && sh->dev[i].towrite) {
+				chosen = sh->dev[i].towrite;
+				sh->dev[i].towrite = NULL;
+
+				if (sh->dev[i].written || sh->dev[i].inwrite) BUG();
+				sh->dev[i].inwrite = chosen;
+			}
+		break;
+	case CHECK_PARITY:
+		break;
+	}
+	if (count>1) {
+		mid++;
+		/* start check_xor() */
+		if (likely(desc))
+			 max_sources = adma_get_source_count(eng);
+		else
+			 max_sources = MAX_XOR_BLOCKS;
+		if (count == max_sources || last || mid) {
+			if (desc) {
+				eng->build_desc(desc, ADMA_XOR, ptr, count, STRIPE_SIZE, 0);
+				if (last) {
+					adma_set_callback(desc, raid5_adma_xor_callback, sh, method);
+					next_desc = NULL;
+				} else {
+					next_desc = adma_get_desc(eng);
+					if (likely(next_desc))
+						adma_set_desc_flags(desc, ADMA_AUTO_REAP);
+				}
+				eng->queue_desc(desc, last ? 1 : MD_ADMA_QUEUE);
+				if (likely(!last) && unlikely(!next_desc)) {
+					adma_run(eng);
+					adma_spin_wait_desc(desc);
+					adma_put_desc(desc);
+		      		}
+		      		desc = last ? desc : next_desc;
+			} else xor_block(count, STRIPE_SIZE, ptr);
+			count = 1;
+		}
+		/* end check_xor() */
+		mid--;
+	}
+	
+	for (i = disks; i--;)
+		if (sh->dev[i].inwrite) {
+			sector_t sector = sh->dev[i].sector;
+			struct bio *wbi = sh->dev[i].inwrite;
+			while (wbi && wbi->bi_sector < sector + STRIPE_SECTORS) {
+				md_issue_copy_data(1, wbi, sh->dev[i].page, sector,
+						   sh, i);
+				wbi = r5_next_bio(wbi, sector);
+			}
+			set_bit(R5_LOCKED, &sh->dev[i].flags);
+			locked++;
+		}
+
+	switch(method) {
+	case RECONSTRUCT_WRITE:
+	case CHECK_PARITY:
+		for (i = disks; i--;)
+			if (i != pd_idx) {
+				ptr[count++] = page_address(sh->dev[i].page);
+				if (count == max_sources && i == 0)
+					last++;
+				/* start check_xor() */
+				if (likely(desc))
+					 max_sources = adma_get_source_count(eng);
+				else
+					 max_sources = MAX_XOR_BLOCKS;
+				if (count == max_sources || last || mid) {
+					if (desc) {
+						eng->build_desc(desc, ADMA_XOR, ptr, count, STRIPE_SIZE, 0);
+						if (last) {
+							adma_set_callback(desc, raid5_adma_xor_callback, sh, method);
+							next_desc = NULL;
+						} else {
+							next_desc = adma_get_desc(eng);
+							if (likely(next_desc))
+								adma_set_desc_flags(desc, ADMA_AUTO_REAP);
+						}
+						eng->queue_desc(desc, last ? 1 : MD_ADMA_QUEUE);
+						if (likely(!last) && unlikely(!next_desc)) {
+							adma_run(eng);
+							adma_spin_wait_desc(desc);
+							adma_put_desc(desc);
+				      		}
+				      		desc = last ? desc : next_desc;
+					} else xor_block(count, STRIPE_SIZE, ptr);
+					count = 1;
+				}
+				/* end check_xor() */
+			}
+		break;
+	case READ_MODIFY_WRITE:
+		for (i = disks; i--;)
+			if (sh->dev[i].inwrite) {
+				ptr[count++] = page_address(sh->dev[i].page);
+				if (count == max_sources && i == 0)
+					last++;
+				/* start check_xor() */
+				if (likely(desc))
+					 max_sources = adma_get_source_count(eng);
+				else
+					 max_sources = MAX_XOR_BLOCKS;
+				if (count == max_sources || last || mid) {
+					if (desc) {
+						eng->build_desc(desc, ADMA_XOR, ptr, count, STRIPE_SIZE, 0);
+						if (last) {
+							adma_set_callback(desc, raid5_adma_xor_callback, sh, method);
+							next_desc = NULL;
+						} else {
+							next_desc = adma_get_desc(eng);
+							if (likely(next_desc))
+								adma_set_desc_flags(desc, ADMA_AUTO_REAP);
+						}
+						eng->queue_desc(desc, last ? 1 : MD_ADMA_QUEUE);
+						if (likely(!last) && unlikely(!next_desc)) {
+							adma_run(eng);
+							adma_spin_wait_desc(desc);
+							adma_put_desc(desc);
+				      		}
+				      		desc = last ? desc : next_desc;
+					} else xor_block(count, STRIPE_SIZE, ptr);
+					count = 1;
+				}
+				/* end check_xor() */
+			}
+	}
+	if (count != 1) {
+		if (last) BUG();
+		last++;
+		/* start check_xor() */
+		if (likely(desc))
+			 max_sources = adma_get_source_count(eng);
+		else
+			 max_sources = MAX_XOR_BLOCKS;
+		if (count == max_sources || last || mid) {
+			if (desc) {
+				eng->build_desc(desc, ADMA_XOR, ptr, count, STRIPE_SIZE, 0);
+				if (last) {
+					adma_set_callback(desc, raid5_adma_xor_callback, sh, method);
+					next_desc = NULL;
+				} else {
+					next_desc = adma_get_desc(eng);
+					if (likely(next_desc))
+						adma_set_desc_flags(desc, ADMA_AUTO_REAP);
+				}
+				eng->queue_desc(desc, last ? 1 : MD_ADMA_QUEUE);
+				if (likely(!last) && unlikely(!next_desc)) {
+					adma_run(eng);
+					adma_spin_wait_desc(desc);
+					adma_put_desc(desc);
+		      		}
+		      		desc = last ? desc : next_desc;
+			} else xor_block(count, STRIPE_SIZE, ptr);
+			count = 1;
+		}
+		/* end check_xor() */
+	}
+
+	/* the stripe will be released in the call back*/
+	atomic_inc(&sh->count);
+
+	/* if we did not xor asynchronously then we need 
+	 * to advance the stripe state
+	 */
+	if (unlikely(!desc))
+		__raid5_adma_xor_callback(sh, method);
+
+	return locked;
+}


