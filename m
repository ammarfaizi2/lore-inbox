Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbUKEFpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbUKEFpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 00:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbUKEFpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 00:45:47 -0500
Received: from perdition1.echo-on.net ([204.138.111.140]:29324 "EHLO
	mail.echo-on.net") by vger.kernel.org with ESMTP id S262609AbUKEFoz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 00:44:55 -0500
Date: Fri, 5 Nov 2004 00:44:45 -0500 (EST)
From: Terry Kyriacopoulos <terryk@echo-on.net>
To: linux-kernel@vger.kernel.org
Cc: gadio@netvision.net.il, andre@linux-ide.org
Subject: [PATCH] ide-scsi: DMA alignment bug fixed
Message-ID: <Pine.LNX.4.56.0411050042250.88@vk.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's about time somebody fixed this.  ide-scsi no longer reverts to PIO
when the user buffers aren't 512-byte aligned, thanks to this patch.

[For brevity, only the patch to 2.6.8.1 (and 2.6.9) is quoted below,
 although I made and tested patches to 2.4.27 and 2.2.26.  If interested,
 let me know.]

DMA is done on a combination of the user buffers and bounce buffers as
follows:

- If everything is aligned, no copying is done.
- If only the length (of the last segment) is unaligned, only that partial
  last block is copied.
- In the remaining cases, everything from the first misaligned block onwards
  is copied, but to minimize extra buffer allocation, any aligned space within
  the user buffers is used for DMA.

The following changes were made to implement this:

- introduced the structure 'bounce' in 'idescsi_pc_t' to point to the
  list of buffers to be copied.  Note the special meaning of NULL in the
  field 'alloc': it means a section (or all of) a user buffer is being
  used for DMA.  (kfree on 'alloc' is thus harmless on user buffers.)

- overhauled 'idescsi_dma_bio', the function that decides if DMA is
  possible and that sets up the buffers.  The DMA table (rq->bio) is built
  one entry at a time while checking the boundaries of the user sg table.
  When this is done additional bounce buffers are kmalloc'ed to carry the
  leftover data.

- added the function 'idescsi_bounce_dma' to do the copying.  Source and
  destination may overlap, so the 'bounce' list is processed backwards
  when writing.  Notice that source and destination blocks will
  coincide for aligned cases, and thus will not require copying.

- added GPCMD_READ_CD and GPCMD_READ_CD_MSF to 'idescsi_set_direction'
  from <linux/cdrom.h>  The command list may be incomplete.

- made a few cleanups:
	- properly intialized 'bh->bi_next' to NULL in
	  'idescsi_kmalloc_bio'
	- made some existing variables unsigned, to suppress warnings


Signed-off-by: Terry Kyriacopoulos <terryk@echo-on.net>


Here it is (for 2.6.8.1/2.6.9): -----------------------------------------

--- orig/2.6.8.1	Sat Aug 14 06:55:35 2004
+++ linux-2.6.8.1/drivers/scsi/ide-scsi.c	Mon Nov  1 22:56:09 2004
@@ -30,6 +30,11 @@
  * Ver 0.91  Jun 10 02   Fix "off by one" error in transforms
  * Ver 0.92  Dec 31 02   Implement new SCSI mid level API
  */
+/* Patched   Oct 27 04   DMA alignment restriction eliminated.
+ *			 Patches (C) 2004 Terry Kyriacopoulos
+ *					  terryk@echo-on.net
+ */
+

 #define IDESCSI_VERSION "0.92"

@@ -45,6 +50,7 @@
 #include <linux/hdreg.h>
 #include <linux/slab.h>
 #include <linux/ide.h>
+#include <linux/cdrom.h>

 #include <asm/io.h>
 #include <asm/bitops.h>
@@ -56,20 +62,39 @@

 #define IDESCSI_DEBUG_LOG		0

+#define IDE_DMA_SIZE			512
+#define BOUNCE_ALLOC_MAX		(63 * 1024uL)
+
+#define READ_CONTEXT			0
+#define WRITE_CONTEXT			1
+
+struct bounce_list_entry {
+	char *buf;		/* Aligned buffer base for DMA use */
+	char *alloc;		/* Actual base if kmalloc'ed, else NULL */
+	unsigned long len;	/* Length of data to be copied */
+};
+
+struct bounce_list_head {
+	struct bounce_list_entry *list;		/* Bounce list */
+	unsigned long size;			/* Bounce list length */
+};
+
 typedef struct idescsi_pc_s {
 	u8 c[12];				/* Actual packet bytes */
-	int request_transfer;			/* Bytes to transfer */
-	int actually_transferred;		/* Bytes actually transferred */
-	int buffer_size;			/* Size of our data buffer */
+	unsigned request_transfer;		/* Bytes to transfer */
+	unsigned actually_transferred;		/* Bytes actually transferred */
+	unsigned buffer_size;			/* Size of our data buffer */
 	struct request *rq;			/* The corresponding request */
 	u8 *buffer;				/* Data buffer */
 	u8 *current_position;			/* Pointer into the above buffer */
 	struct scatterlist *sg;			/* Scatter gather table */
-	int b_count;				/* Bytes transferred from current entry */
+	unsigned b_count;			/* Bytes transferred from current entry */
 	Scsi_Cmnd *scsi_cmd;			/* SCSI command */
 	void (*done)(Scsi_Cmnd *);		/* Scsi completion routine */
 	unsigned long flags;			/* Status/Action flags */
 	unsigned long timeout;			/* Command timeout */
+
+	struct bounce_list_head bounce;		/* Adjusted buffers for DMA */
 } idescsi_pc_t;

 /*
@@ -137,7 +162,7 @@ static void idescsi_output_zeros (ide_dr
  */
 static void idescsi_input_buffers (ide_drive_t *drive, idescsi_pc_t *pc, unsigned int bcount)
 {
-	int count;
+	unsigned count;
 	char *buf;

 	while (bcount) {
@@ -159,7 +184,7 @@ static void idescsi_input_buffers (ide_d

 static void idescsi_output_buffers (ide_drive_t *drive, idescsi_pc_t *pc, unsigned int bcount)
 {
-	int count;
+	unsigned count;
 	char *buf;

 	while (bcount) {
@@ -261,6 +286,96 @@ static inline void idescsi_free_bio (str
 	}
 }

+static inline void idescsi_free_bounce_list(struct bounce_list_head *p_bounce)
+{
+	unsigned long i;
+	for (i=0; i < p_bounce->size; i++) kfree(p_bounce->list[i].alloc);
+	p_bounce->size = 0;
+	kfree(p_bounce->list);
+	p_bounce->list = NULL;
+}
+
+
+static inline void idescsi_bounce_dma_copy(void *client, void *bounce, unsigned long length, int direction)
+{
+	if (bounce == client || !length) return;
+
+	if (direction)
+		memmove(bounce, client, length);
+	else
+		memmove(client, bounce, length);
+}
+
+static void idescsi_bounce_dma(idescsi_pc_t *pc, int direction)
+{
+	unsigned long segments = pc->scsi_cmd->use_sg;
+	struct scatterlist *sg = pc->scsi_cmd->request_buffer;
+	struct bounce_list_entry *next_bounce = pc->bounce.list;
+	unsigned long cs, cb, ts, tb, n;
+	unsigned long seg_count = max(1uL, segments);
+	unsigned long buf_count = pc->bounce.size;
+	char *client_buf = NULL;
+
+	/* Copy data before or after a DMA op, if necessary. */
+	/* direction=1 before DMA, direction=0 after DMA     */
+
+	if (!pc->bounce.size) return;	/* Anything to do? */
+	if ((test_bit(PC_WRITING, &pc->flags) != 0 ) != direction) return;
+
+	if (direction) {		/* Move to the end. */
+		next_bounce += pc->bounce.size;
+		sg += segments;
+	}
+	cs = cb = 0;
+	if (direction) for (;;) { 	/* Writing, must go backwards. */
+		if (!(ts = cs)) {
+			if (!seg_count--) break;
+			if (segments) {
+				sg--;
+				client_buf = page_address(sg->page) + sg->offset;
+				cs = sg->length;
+			} else {
+				client_buf = pc->scsi_cmd->request_buffer;
+				cs = pc->request_transfer;
+			}
+		}
+		if (!(tb = cb)) {
+			if (!buf_count--) break;
+			cb = (--next_bounce)->len;
+		}
+		n = min(ts, tb);
+		cs -= n;
+		cb -= n;
+		idescsi_bounce_dma_copy(client_buf + cs, next_bounce->buf + cb, n, direction);
+	} else for (;;) { 		/* Reading, must go forward. */
+		if (segments) {
+			client_buf = page_address(sg->page) + sg->offset;
+			ts = sg->length - cs;
+		}
+		else {
+			client_buf = pc->scsi_cmd->request_buffer;
+			ts = pc->request_transfer - cs;
+		}
+		tb = next_bounce->len - cb;
+		if (!ts) {
+			if (!--seg_count) break;
+			else {
+				sg++;
+				cs = 0;
+			}
+		}
+		if (!tb) {
+			if (!--buf_count) break;
+			next_bounce++;
+			cb = 0;
+		}
+		n = min(ts, tb);
+		idescsi_bounce_dma_copy(client_buf + cs, next_bounce->buf + cb, n, direction);
+		cs += n;
+		cb += n;
+	}
+}
+
 static void hexdump(u8 *x, int len)
 {
 	int i;
@@ -418,6 +533,7 @@ static int idescsi_end_request (ide_driv
 	spin_lock_irqsave(host->host_lock, flags);
 	pc->done(pc->scsi_cmd);
 	spin_unlock_irqrestore(host->host_lock, flags);
+	idescsi_free_bounce_list(&pc->bounce);
 	idescsi_free_bio(rq->bio);
 	kfree(pc);
 	kfree(rq);
@@ -477,6 +593,9 @@ static ide_startstop_t idescsi_pc_intr (
 #endif /* IDESCSI_DEBUG_LOG */
 		pc->actually_transferred=pc->request_transfer;
 		(void) HWIF(drive)->ide_dma_end(drive);
+
+		/* If reading, copy now. */
+		idescsi_bounce_dma(pc, READ_CONTEXT);
 	}

 	feature.all = 0;
@@ -594,7 +713,7 @@ static ide_startstop_t idescsi_issue_pc
 	scsi->pc=pc;							/* Set the current packet command */
 	pc->actually_transferred=0;					/* We haven't transferred any data yet */
 	pc->current_position=pc->buffer;
-	bcount.all = min(pc->request_transfer, 63 * 1024);		/* Request to transfer the entire buffer at once */
+	bcount.all = min(pc->request_transfer, 63u * 1024);		/* Request to transfer the entire buffer at once */

 	feature.all = 0;
 	if (drive->using_dma && rq->bio) {
@@ -782,6 +901,7 @@ static inline struct bio *idescsi_kmallo
 		goto abort;
 	bio_init(bh);
 	bh->bi_vcnt = 1;
+	bh->bi_next = NULL;
 	while (--count) {
 		if ((bh = bio_alloc(GFP_ATOMIC, 1)) == NULL)
 			goto abort;
@@ -799,8 +919,12 @@ abort:

 static inline int idescsi_set_direction (idescsi_pc_t *pc)
 {
+	/* To use DMA, we must know if the command is read or write. */
+	/* Only commands that transport data should be listed here.  */
+
 	switch (pc->c[0]) {
 		case READ_6: case READ_10: case READ_12:
+		case GPCMD_READ_CD: case GPCMD_READ_CD_MSF:
 			clear_bit (PC_WRITING, &pc->flags);
 			return 0;
 		case WRITE_6: case WRITE_10: case WRITE_12:
@@ -811,41 +935,108 @@ static inline int idescsi_set_direction
 	}
 }

+static inline char *prev_align(char *buf)
+{
+	unsigned partial = __pa(buf) % IDE_DMA_SIZE;
+	return buf - partial;
+}
+
+static inline char *next_align(char *buf)
+{
+	unsigned partial = __pa(buf) % IDE_DMA_SIZE;
+	return buf + (partial ? (IDE_DMA_SIZE - partial) : 0);
+}
+
 static inline struct bio *idescsi_dma_bio(ide_drive_t *drive, idescsi_pc_t *pc)
 {
 	struct bio *bh = NULL, *first_bh = NULL;
-	int segments = pc->scsi_cmd->use_sg;
+	struct bio **prev_bh = &first_bh;
+	unsigned long segments = pc->scsi_cmd->use_sg;
 	struct scatterlist *sg = pc->scsi_cmd->request_buffer;
+	unsigned long excess = pc->request_transfer;
+        unsigned long listsize_max, seg_count;
+	struct bounce_list_entry *next_bounce;

-	if (!drive->using_dma || !pc->request_transfer || pc->request_transfer % 1024)
+
+	if (!drive->using_dma || !pc->request_transfer)
 		return NULL;
+
 	if (idescsi_set_direction(pc))
 		return NULL;
-	if (segments) {
-		if ((first_bh = bh = idescsi_kmalloc_bio (segments)) == NULL)
-			return NULL;
-#if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: building DMA table, %d segments, %dkB total\n", drive->name, segments, pc->request_transfer >> 10);
-#endif /* IDESCSI_DEBUG_LOG */
-		while (segments--) {
-			bh->bi_io_vec[0].bv_page = sg->page;
-			bh->bi_io_vec[0].bv_len = sg->length;
-			bh->bi_io_vec[0].bv_offset = sg->offset;
-			bh->bi_size = sg->length;
-			bh = bh->bi_next;
-			sg++;
+
+	listsize_max = pc->request_transfer / BOUNCE_ALLOC_MAX + 1 + max(segments, 1uL);
+	if (!(pc->bounce.list = kmalloc(listsize_max * sizeof(struct bounce_list_entry), GFP_ATOMIC))) {
+		printk("ide-scsi: couldn't allocate DMA list\n");
+		return NULL;
+	}
+
+	/* Grab the largest possible area in the user's buffers. */
+
+	next_bounce = pc->bounce.list;
+	for (seg_count = 0; seg_count < max(segments, 1uL); seg_count++) {
+		char *base, *usable_base;
+		unsigned long length, usable_length;
+		if (segments) {
+			base = page_address(sg->page) + sg->offset;
+			length = sg++->length;
 		}
-	} else {
-		if ((first_bh = bh = idescsi_kmalloc_bio (1)) == NULL)
+		else {
+			base = pc->scsi_cmd->request_buffer;
+			length = pc->request_transfer;
+		}
+
+		usable_base = next_align(base);
+		usable_length = prev_align(base + length) - usable_base;
+		if (usable_length && usable_length <= length) {
+			if (!(*prev_bh = bh = idescsi_kmalloc_bio(1))) {
+				printk("ide-scsi: couldn't allocate DMA table\n");
+				idescsi_free_bounce_list(&pc->bounce);
+				idescsi_free_bio(first_bh);
+				return NULL;
+			}
+			prev_bh = &bh->bi_next;
+			bh->bi_io_vec[0].bv_page = virt_to_page(usable_base);
+			bh->bi_io_vec[0].bv_offset = offset_in_page(usable_base);
+			bh->bi_io_vec[0].bv_len = bh->bi_size = usable_length;
+			next_bounce->buf = usable_base;
+			next_bounce->alloc = NULL;
+			next_bounce++->len = usable_length;
+			excess -= usable_length;
+		}
+	}
+
+	/* Allocate buffers for the data that wouldn't fit. */
+
+	while (excess && excess <= pc->request_transfer) {
+		unsigned long newsize, newsize_pad;
+		newsize = min(excess, BOUNCE_ALLOC_MAX);
+		newsize_pad = ((newsize - 1) | (IDE_DMA_SIZE - 1)) + 1;
+		if ( !(next_bounce->alloc = kmalloc(newsize_pad + IDE_DMA_SIZE, GFP_ATOMIC | GFP_DMA))
+		  || !(*prev_bh = bh = idescsi_kmalloc_bio(1)) ) {
+			printk("ide-scsi: couldn't allocate DMA buffer\n");
+                        pc->bounce.size = (next_bounce - pc->bounce.list) + 1;
+                        idescsi_free_bounce_list(&pc->bounce);
+			idescsi_free_bio(first_bh);
 			return NULL;
-#if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: building DMA table for a single buffer (%dkB)\n", drive->name, pc->request_transfer >> 10);
-#endif /* IDESCSI_DEBUG_LOG */
-		bh->bi_io_vec[0].bv_page = virt_to_page(pc->scsi_cmd->request_buffer);
-		bh->bi_io_vec[0].bv_offset = offset_in_page(pc->scsi_cmd->request_buffer);
-		bh->bi_io_vec[0].bv_len = pc->request_transfer;
-		bh->bi_size = pc->request_transfer;
+		}
+		next_bounce->buf = next_align(next_bounce->alloc);
+		next_bounce->len = newsize;
+		/* This is necessary for security. */
+		memset(next_bounce->buf, 0, newsize);
+		prev_bh = &bh->bi_next;
+		bh->bi_io_vec[0].bv_page = virt_to_page(next_bounce->buf);
+		bh->bi_io_vec[0].bv_offset = offset_in_page(next_bounce->buf);
+		bh->bi_io_vec[0].bv_len = bh->bi_size = newsize_pad;
+		excess -= newsize;
+		next_bounce++;
 	}
+
+	pc->bounce.size = next_bounce - pc->bounce.list;
+
+	/* If writing, copy now. */
+	idescsi_bounce_dma(pc, WRITE_CONTEXT);
+
+	/* DMA buffer allocation successful. */
 	return first_bh;
 }

@@ -919,6 +1110,8 @@ static int idescsi_queue (Scsi_Cmnd *cmd

 	ide_init_drive_cmd (rq);
 	rq->special = (char *) pc;
+	pc->bounce.size = 0;
+	pc->bounce.list = NULL;
 	rq->bio = idescsi_dma_bio (drive, pc);
 	rq->flags = REQ_SPECIAL;
 	spin_unlock_irq(host->host_lock);
@@ -973,6 +1166,7 @@ static int idescsi_eh_abort (Scsi_Cmnd *
 		 */
 		printk (KERN_ERR "ide-scsi: cmd aborted!\n");

+		idescsi_free_bounce_list(&scsi->pc->bounce);
 		idescsi_free_bio(scsi->pc->rq->bio);
 		if (scsi->pc->rq->flags & REQ_SENSE)
 			kfree(scsi->pc->buffer);
@@ -1022,6 +1216,7 @@ static int idescsi_eh_reset (Scsi_Cmnd *
 	/* kill current request */
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
+	idescsi_free_bounce_list(&scsi->pc->bounce);
 	idescsi_free_bio(req->bio);
 	if (req->flags & REQ_SENSE)
 		kfree(scsi->pc->buffer);
