Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264204AbRF0QtT>; Wed, 27 Jun 2001 12:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264926AbRF0QtK>; Wed, 27 Jun 2001 12:49:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26888 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264204AbRF0QtG>;
	Wed, 27 Jun 2001 12:49:06 -0400
Date: Wed, 27 Jun 2001 18:49:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "ZINKEVICIUS,MATT (HP-Loveland,ex1)" <matt_zinkevicius@hp.com>
Subject: Re: patch: highmem zero-bounce
Message-ID: <20010627184908.E17905@suse.de>
In-Reply-To: <20010626182215.C14460@suse.de> <20010627114155.A31910@athlon.random> <20010627182745.D17905@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20010627182745.D17905@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27 2001, Jens Axboe wrote:
> > I can see one mm corruption race condition in the patch, you missed
> > nested irq in the for kmap_irq_bh (PIO).  You must _always_
> > __cli/__save_flags before accessing the KMAP_IRQ_BH slot, in case the
> > remapping is required (so _only_ when the page is in the highmem zone).
> > Otherwise memory corruption will happen when the race triggers (for
> > example two ide disks in PIO mode doing I/O at the same time connected
> > to different irq sources).
> 
> Ah yes, my bad. This requires some moving around, I'll post an updated
> patch later tonight. Thanks!

A prelim and untested fix just whipped up

-- 
Jens Axboe


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=block-high-kmap-1

--- include/linux/highmem.h~	Wed Jun 27 18:24:13 2001
+++ include/linux/highmem.h	Wed Jun 27 18:41:55 2001
@@ -26,7 +26,9 @@
 }
 
 /*
- * remember to add offset!
+ * remember to add offset! caller must also rememer to have done __save_flags
+ * and __cli prior to calling bh_kmap_irq, and __restore_flags after calling
+ * bh_kunmap_irq
  */
 static inline char *bh_kmap_irq(struct buffer_head *bh)
 {
@@ -44,6 +46,37 @@
 
 	kunmap_atomic((void *) ptr, KM_BH_IRQ);
 }
+
+static inline void bh_cpy_to_buf(char *buf, struct buffer_head *bh, int len)
+{
+	unsigned long flags;
+	char *bh_buf;
+
+	__save_flags(flags);
+	__cli();
+
+	bh_buf = bh_kmap_irq(bh);
+	memcpy(buf, bh_buf, len);
+	bh_kunmap_irq(bh_buf);
+
+	__restore_flags(flags);
+}
+
+static inline void bh_cpy_from_buf(struct buffer_head *bh, char *buf, int len)
+{
+	unsigned long flags;
+	char *bh_buf;
+
+	__save_flags(flags);
+	__cli();
+
+	bh_buf = bh_kmap_irq(bh);
+	memcpy(bh_buf, buf, len);
+	bh_kunmap_irq(bh_buf);
+
+	__restore_flags(flags);
+}
+
 
 #else /* CONFIG_HIGHMEM */
 
--- include/linux/ide.h~	Wed Jun 27 18:43:46 2001
+++ include/linux/ide.h	Wed Jun 27 18:44:18 2001
@@ -759,14 +759,17 @@
  */
 #define ide_rq_offset(rq) (((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
 
-extern inline void *ide_map_buffer(struct request *rq)
+extern inline void *ide_map_buffer(struct request *rq, unsigned long flags);
 {
+	__save_flags(flags);
+	__cli();
 	return bh_kmap_irq(rq->bh) + ide_rq_offset(rq);
 }
 
-extern inline void ide_unmap_buffer(char *buffer)
+extern inline void ide_unmap_buffer(char *buffer, unsigned long flags)
 {
 	bh_kunmap_irq(buffer);
+	__restore_flags(flags);
 }
 
 /*
--- drivers/scsi/scsi_lib.c~	Wed Jun 27 18:32:58 2001
+++ drivers/scsi/scsi_lib.c	Wed Jun 27 18:40:57 2001
@@ -566,11 +566,8 @@
 		scsi_free(SCpnt->buffer, SCpnt->sglist_len);
 	} else {
 		if (SCpnt->buffer != req->buffer) {
-			if (req->cmd == READ) {
-				char *to = bh_kmap_irq(req->bh);
-				memcpy(to, SCpnt->buffer, SCpnt->bufflen);
-				bh_kunmap_irq(to);
-			}
+			if (req->cmd == READ)
+				bh_cpy_from_buf(req->bh, SCpnt->buffer, SCpnt->bufflen);
 			scsi_free(SCpnt->buffer, SCpnt->bufflen);
 		}
 	}
--- drivers/scsi/scsi_merge.c~	Wed Jun 27 18:34:15 2001
+++ drivers/scsi/scsi_merge.c	Wed Jun 27 18:38:01 2001
@@ -1022,11 +1022,8 @@
 					dma_exhausted(SCpnt, 0);
 				}
 			}
-			if (req->cmd == WRITE) {
-				char *buf = bh_kmap_irq(bh);
-				memcpy(buff, buf, this_count << 9);
-				bh_kunmap_irq(buf);
-			}
+			if (req->cmd == WRITE)
+				bh_cpy_buf_high(buff, bh, this_count << 9);
 		}
 	}
 	SCpnt->request_bufflen = this_count << 9;
--- drivers/ide/ide-disk.c~	Wed Jun 27 18:42:35 2001
+++ drivers/ide/ide-disk.c	Wed Jun 27 18:43:40 2001
@@ -140,6 +140,7 @@
 	byte stat;
 	int i;
 	unsigned int msect, nsect;
+	unsigned long flags;
 	struct request *rq;
 	char *to;
 
@@ -162,14 +163,14 @@
 		msect -= nsect;
 	} else
 		nsect = 1;
-	to = ide_map_buffer(rq);
+	to = ide_map_buffer(rq, flags);
 	idedisk_input_data(drive, to, nsect * SECTOR_WORDS);
 #ifdef DEBUG
 	printk("%s:  read: sectors(%ld-%ld), buffer=0x%08lx, remaining=%ld\n",
 		drive->name, rq->sector, rq->sector+nsect-1,
 		(unsigned long) rq->buffer+(nsect<<9), rq->nr_sectors-nsect);
 #endif
-	ide_unmap_buffer(to);
+	ide_unmap_buffer(to, flags);
 	rq->sector += nsect;
 	rq->errors = 0;
 	i = (rq->nr_sectors -= nsect);
@@ -193,6 +194,7 @@
 	int i;
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	struct request *rq = hwgroup->rq;
+	unsigned long flags;
 
 	if (!OK_STAT(stat=GET_STAT(),DRIVE_READY,drive->bad_wstat)) {
 		printk("%s: write_intr error1: nr_sectors=%ld, stat=0x%02x\n", drive->name, rq->nr_sectors, stat);
@@ -210,9 +212,9 @@
 			if (((long)rq->current_nr_sectors) <= 0)
 				ide_end_request(1, hwgroup);
 			if (i > 0) {
-				char *to = ide_map_buffer(rq);
+				char *to = ide_map_buffer(rq, flags);
 				idedisk_output_data (drive, to, SECTOR_WORDS);
-				ide_unmap_buffer(to);
+				ide_unmap_buffer(to, flags);
 				ide_set_handler (drive, &write_intr, WAIT_CMD, NULL);
                                 return ide_started;
 			}
@@ -242,12 +244,13 @@
   	do {
   		char *buffer;
   		int nsect = rq->current_nr_sectors;
+		unsigned long flags;
 
 		if (nsect > mcount)
 			nsect = mcount;
 		mcount -= nsect;
 
-		buffer = ide_map_buffer(rq);
+		buffer = ide_map_buffer(rq, flags);
 		rq->sector += nsect;
 		rq->nr_sectors -= nsect;
 		rq->current_nr_sectors -= nsect;
@@ -271,7 +274,7 @@
 		 * re-entering us on the last transfer.
 		 */
 		idedisk_output_data(drive, buffer, nsect<<7);
-		ide_unmap_buffer(buffer);
+		ide_unmap_buffer(buffer, flags);
 	} while (mcount);
 
         return 0;
@@ -455,10 +458,12 @@
 				return ide_stopped;
 			}
 		} else {
-			char *buffer = ide_map_buffer(rq);
+			unsigned long flags;
+			char *buffer = ide_map_buffer(rq, flags);
+
 			ide_set_handler (drive, &write_intr, WAIT_CMD, NULL);
 			idedisk_output_data(drive, buffer, SECTOR_WORDS);
-			ide_unmap_buffer(buffer);
+			ide_unmap_buffer(buffer, flags);
 		}
 		return ide_started;
 	}

--2oS5YaxWCcQjTEyO--
