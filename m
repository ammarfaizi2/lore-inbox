Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbSKBRxm>; Sat, 2 Nov 2002 12:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSKBRxl>; Sat, 2 Nov 2002 12:53:41 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:58451 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261341AbSKBRun>; Sat, 2 Nov 2002 12:50:43 -0500
Date: Sun, 3 Nov 2002 02:56:52 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC][Patchset 7/20] Support for PC-9800 (floppy2)
Message-ID: <20021103025652.M1536@precia.cinet.co.jp>
References: <20021103023345.A1536@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: =?iso-8859-1?Q?=3C20021103023345=2EA1536?=
	=?iso-8859-1?B?QHByZWNpYS5jaW5ldC5jby5qcD47IGZyb20gdG9taXRhQGNpbmV0LmNv?=
	=?iso-8859-1?B?LmpwIG9uIMb8LCAxMbfu?= 03, 2002 at 02:33:45 +0900
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 7/20 of patchset for add support NEC PC-9800 architecture,
against 2.5.45.

floppy98.c is splited to 2 patches. Please apply this after floppy1.

Summary:
  floppy driver modules

diffstat:
  drivers/block/floppy98.c  | 2303 ++++++++++++++++++++++++++++++++++++++++++++++
  include/asm-i386/floppy.h |   11  include/linux/fdreg.h     |   24  3 files changed, 2338 insertions(+)

patch:
diff -urN linux/drivers/block/floppy98.c linux98/drivers/block/floppy98.c
--- linux/drivers/block/floppy98.c	Thu Oct 31 16:11:27 2002
+++ linux98/drivers/block/floppy98.c	Thu Oct 31 16:09:02 2002
@@ -2335,3 +2335,2306 @@
  	return ret;
  }
  +/*
+ * Buffer read/write and support
+ * =============================
+ */
+
+static inline void end_request(struct request *req, int uptodate)
+{
+	if (end_that_request_first(req, uptodate, current_count_sectors))
+		return;
+	add_disk_randomness(req->rq_disk);
+	floppy_off((int)req->rq_disk->private_data);
+	blkdev_dequeue_request(req);
+	end_that_request_last(req);
+
+	/* We're done with the request */
+	current_req = NULL;
+}
+
+
+/* new request_done. Can handle physical sectors which are smaller than a
+ * logical buffer */
+static void request_done(int uptodate)
+{
+	struct request_queue *q = &floppy_queue;
+	struct request *req = current_req;
+	unsigned long flags;
+	int block;
+
+	probing = 0;
+	reschedule_timeout(MAXTIMEOUT, "request done %d", uptodate);
+
+	if (!req) {
+		printk("floppy.c: no request in request_done\n");
+		return;
+	}
+
+	if (uptodate){
+		/* maintain values for invalidation on geometry
+		 * change */
+		block = current_count_sectors + req->sector;
+		INFBOUND(DRS->maxblock, block);
+		if (block > _floppy->sect)
+			DRS->maxtrack = 1;
+
+		/* unlock chained buffers */
+		spin_lock_irqsave(q->queue_lock, flags);
+		end_request(req, 1);
+		spin_unlock_irqrestore(q->queue_lock, flags);
+	} else {
+		if (rq_data_dir(req) == WRITE) {
+			/* record write error information */
+			DRWE->write_errors++;
+			if (DRWE->write_errors == 1) {
+				DRWE->first_error_sector = req->sector;
+				DRWE->first_error_generation = DRS->generation;
+			}
+			DRWE->last_error_sector = req->sector;
+			DRWE->last_error_generation = DRS->generation;
+		}
+		spin_lock_irqsave(q->queue_lock, flags);
+		end_request(req, 0);
+		spin_unlock_irqrestore(q->queue_lock, flags);
+	}
+}
+
+/* Interrupt handler evaluating the result of the r/w operation */
+static void rw_interrupt(void)
+{
+	int nr_sectors, ssize, eoc, heads;
+
+	if (R_HEAD >= 2) {
+	    /* some Toshiba floppy controllers occasionnally seem to
+	     * return bogus interrupts after read/write operations, which
+	     * can be recognized by a bad head number (>= 2) */
+	     return;
+	}  +
+	if (!DRS->first_read_date)
+		DRS->first_read_date = jiffies;
+
+	nr_sectors = 0;
+	CODE2SIZE;
+
+	if (ST1 & ST1_EOC)
+		eoc = 1;
+	else
+		eoc = 0;
+
+	if (COMMAND & 0x80)
+		heads = 2;
+	else
+		heads = 1;
+
+	nr_sectors = (((R_TRACK-TRACK) * heads +
+				   R_HEAD-HEAD) * SECT_PER_TRACK +
+				   R_SECTOR-SECTOR + eoc) << SIZECODE >> 2;
+
+#ifdef FLOPPY_SANITY_CHECK
+	if (nr_sectors / ssize > +		(in_sector_offset + current_count_sectors + ssize - 1) / ssize) {
+		DPRINT("long rw: %x instead of %lx\n",
+			nr_sectors, current_count_sectors);
+		printk("rs=%d s=%d\n", R_SECTOR, SECTOR);
+		printk("rh=%d h=%d\n", R_HEAD, HEAD);
+		printk("rt=%d t=%d\n", R_TRACK, TRACK);
+		printk("heads=%d eoc=%d\n", heads, eoc);
+		printk("spt=%d st=%d ss=%d\n", SECT_PER_TRACK,
+		       fsector_t, ssize);
+		printk("in_sector_offset=%d\n", in_sector_offset);
+	}
+#endif
+
+	nr_sectors -= in_sector_offset;
+	INFBOUND(nr_sectors,0);
+	SUPBOUND(current_count_sectors, nr_sectors);
+
+	switch (interpret_errors()){
+		case 2:
+			cont->redo();
+			return;
+		case 1:
+			if (!current_count_sectors){
+				cont->error();
+				cont->redo();
+				return;
+			}
+			break;
+		case 0:
+			if (!current_count_sectors){
+				cont->redo();
+				return;
+			}
+			current_type[current_drive] = _floppy;
+			floppy_sizes[TOMINOR(current_drive) ]= _floppy->size;
+			break;
+	}
+
+	if (probing) {
+		if (DP->flags & FTD_MSG)
+			DPRINT("Auto-detected floppy type %s in fd%d\n",
+				_floppy->name,current_drive);
+		current_type[current_drive] = _floppy;
+		floppy_sizes[TOMINOR(current_drive)] = _floppy->size;
+		probing = 0;
+	}
+
+	if (CT(COMMAND) != FD_READ || +	     raw_cmd->kernel_data == current_req->buffer){
+		/* transfer directly from buffer */
+		cont->done(1);
+	} else if (CT(COMMAND) == FD_READ){
+		buffer_track = raw_cmd->track;
+		buffer_drive = current_drive;
+		INFBOUND(buffer_max, nr_sectors + fsector_t);
+	}
+	cont->redo();
+}
+
+/* Compute maximal contiguous buffer size. */
+static int buffer_chain_size(void)
+{
+	struct bio *bio;
+	struct bio_vec *bv;
+	int size, i;
+	char *base;
+
+	base = bio_data(current_req->bio);
+	size = 0;
+
+	rq_for_each_bio(bio, current_req) {
+		bio_for_each_segment(bv, bio, i) {
+			if (page_address(bv->bv_page) + bv->bv_offset != base + size)
+				break;
+
+			size += bv->bv_len;
+		}
+	}
+
+	return size >> 9;
+}
+
+/* Compute the maximal transfer size */
+static int transfer_size(int ssize, int max_sector, int max_size)
+{
+	SUPBOUND(max_sector, fsector_t + max_size);
+
+	/* alignment */
+	max_sector -= (max_sector % _floppy->sect) % ssize;
+
+	/* transfer size, beginning not aligned */
+	current_count_sectors = max_sector - fsector_t ;
+
+	return max_sector;
+}
+
+/*
+ * Move data from/to the track buffer to/from the buffer cache.
+ */
+static void copy_buffer(int ssize, int max_sector, int max_sector_2)
+{
+	int remaining; /* number of transferred 512-byte sectors */
+	struct bio_vec *bv;
+	struct bio *bio;
+	char *buffer, *dma_buffer;
+	int size, i;
+
+	max_sector = transfer_size(ssize,
+				   minimum(max_sector, max_sector_2),
+				   current_req->nr_sectors);
+
+	if (current_count_sectors <= 0 && CT(COMMAND) == FD_WRITE &&
+	    buffer_max > fsector_t + current_req->nr_sectors)
+		current_count_sectors = minimum(buffer_max - fsector_t,
+						current_req->nr_sectors);
+
+	remaining = current_count_sectors << 9;
+#ifdef FLOPPY_SANITY_CHECK
+	if ((remaining >> 9) > current_req->nr_sectors  &&
+	    CT(COMMAND) == FD_WRITE){
+		DPRINT("in copy buffer\n");
+		printk("current_count_sectors=%ld\n", current_count_sectors);
+		printk("remaining=%d\n", remaining >> 9);
+		printk("current_req->nr_sectors=%ld\n",current_req->nr_sectors);
+		printk("current_req->current_nr_sectors=%u\n",
+		       current_req->current_nr_sectors);
+		printk("max_sector=%d\n", max_sector);
+		printk("ssize=%d\n", ssize);
+	}
+#endif
+
+	buffer_max = maximum(max_sector, buffer_max);
+
+	dma_buffer = floppy_track_buffer + ((fsector_t - buffer_min) << 9);
+
+	size = current_req->current_nr_sectors << 9;
+
+	rq_for_each_bio(bio, current_req) {
+		bio_for_each_segment(bv, bio, i) {
+			if (!remaining)
+				break;
+
+			size = bv->bv_len;
+			SUPBOUND(size, remaining);
+
+			buffer = page_address(bv->bv_page) + bv->bv_offset;
+#ifdef FLOPPY_SANITY_CHECK
+		if (dma_buffer + size >
+		    floppy_track_buffer + (max_buffer_sectors << 10) ||
+		    dma_buffer < floppy_track_buffer){
+			DPRINT("buffer overrun in copy buffer %d\n",
+				(int) ((floppy_track_buffer - dma_buffer) >>9));
+			printk("fsector_t=%d buffer_min=%d\n",
+			       fsector_t, buffer_min);
+			printk("current_count_sectors=%ld\n",
+			       current_count_sectors);
+			if (CT(COMMAND) == FD_READ)
+				printk("read\n");
+			if (CT(COMMAND) == FD_READ)
+				printk("write\n");
+			break;
+		}
+		if (((unsigned long)buffer) % 512)
+			DPRINT("%p buffer not aligned\n", buffer);
+#endif
+			if (CT(COMMAND) == FD_READ)
+				memcpy(buffer, dma_buffer, size);
+			else
+				memcpy(dma_buffer, buffer, size);
+
+			remaining -= size;
+			dma_buffer += size;
+		}
+	}
+#ifdef FLOPPY_SANITY_CHECK
+	if (remaining){
+		if (remaining > 0)
+			max_sector -= remaining >> 9;
+		DPRINT("weirdness: remaining %d\n", remaining>>9);
+	}
+#endif
+}
+
+#if 0
+static inline int check_dma_crossing(char *start, +				     unsigned long length, char *message)
+{
+	if (CROSS_64KB(start, length)) {
+		printk("DMA xfer crosses 64KB boundary in %s %p-%p\n", +		       message, start, start+length);
+		return 1;
+	} else
+		return 0;
+}
+#endif
+
+/* work around a bug in pseudo DMA
+ * (on some FDCs) pseudo DMA does not stop when the CPU stops
+ * sending data.  Hence we need a different way to signal the
+ * transfer length:  We use SECT_PER_TRACK.  Unfortunately, this
+ * does not work with MT, hence we can only transfer one head at
+ * a time
+ */
+static void virtualdmabug_workaround(void)
+{
+	int hard_sectors, end_sector;
+
+	if(CT(COMMAND) == FD_WRITE) {
+		COMMAND &= ~0x80; /* switch off multiple track mode */
+
+		hard_sectors = raw_cmd->length >> (7 + SIZECODE);
+		end_sector = SECTOR + hard_sectors - 1;
+#ifdef FLOPPY_SANITY_CHECK
+		if(end_sector > SECT_PER_TRACK) {
+			printk("too many sectors %d > %d\n",
+			       end_sector, SECT_PER_TRACK);
+			return;
+		}
+#endif
+		SECT_PER_TRACK = end_sector; /* make sure SECT_PER_TRACK points
+					      * to end of transfer */
+	}
+}
+
+/*
+ * Formulate a read/write request.
+ * this routine decides where to load the data (directly to buffer, or to
+ * tmp floppy area), how much data to load (the size of the buffer, the whole
+ * track, or a single sector)
+ * All floppy_track_buffer handling goes in here. If we ever add track buffer
+ * allocation on the fly, it should be done here. No other part should need
+ * modification.
+ */
+
+static int make_raw_rw_request(void)
+{
+	int aligned_sector_t;
+	int max_sector, max_size, tracksize, ssize;
+
+	if(max_buffer_sectors == 0) {
+		printk("VFS: Block I/O scheduled on unopened device\n");
+		return 0;
+	}
+
+	set_fdc(DRIVE(current_req->rq_dev));
+
+	raw_cmd = &default_raw_cmd;
+	raw_cmd->flags = FD_RAW_SPIN | FD_RAW_NEED_DISK | FD_RAW_NEED_DISK |
+		FD_RAW_NEED_SEEK;
+	raw_cmd->cmd_count = NR_RW;
+	if (rq_data_dir(current_req) == READ) {
+		raw_cmd->flags |= FD_RAW_READ;
+		COMMAND = FM_MODE(_floppy,FD_READ);
+	} else if (rq_data_dir(current_req) == WRITE){
+		raw_cmd->flags |= FD_RAW_WRITE;
+		COMMAND = FM_MODE(_floppy,FD_WRITE);
+	} else {
+		DPRINT("make_raw_rw_request: unknown command\n");
+		return 0;
+	}
+
+	max_sector = _floppy->sect * _floppy->head;
+
+	TRACK = (int)current_req->sector / max_sector;
+	fsector_t = (int)current_req->sector % max_sector;
+	if (_floppy->track && TRACK >= _floppy->track) {
+		if (current_req->current_nr_sectors & 1) {
+			current_count_sectors = 1;
+			return 1;
+		} else
+			return 0;
+	}
+	HEAD = fsector_t / _floppy->sect;
+
+	if (((_floppy->stretch & FD_SWAPSIDES) || TESTF(FD_NEED_TWADDLE)) &&
+	    fsector_t < _floppy->sect)
+		max_sector = _floppy->sect;
+
+	/* 2M disks have phantom sectors on the first track */
+	if ((_floppy->rate & FD_2M) && (!TRACK) && (!HEAD)){
+		max_sector = 2 * _floppy->sect / 3;
+		if (fsector_t >= max_sector){
+			current_count_sectors = minimum(_floppy->sect - fsector_t,
+							current_req->nr_sectors);
+			return 1;
+		}
+		SIZECODE = 2;
+	} else
+		SIZECODE = FD_SIZECODE(_floppy);
+	raw_cmd->rate = _floppy->rate & 0x43;
+	if ((_floppy->rate & FD_2M) &&
+	    (TRACK || HEAD) &&
+	    raw_cmd->rate == 2)
+		raw_cmd->rate = 1;
+
+	if (SIZECODE)
+		SIZECODE2 = 0xff;
+	else
+		SIZECODE2 = 0x80;
+	raw_cmd->track = TRACK << STRETCH(_floppy);
+	DR_SELECT = UNIT(current_drive) + PH_HEAD(_floppy,HEAD);
+	GAP = _floppy->gap;
+	CODE2SIZE;
+	SECT_PER_TRACK = _floppy->sect << 2 >> SIZECODE;
+	SECTOR = ((fsector_t % _floppy->sect) << 2 >> SIZECODE) + 1;
+
+	/* tracksize describes the size which can be filled up with sectors
+	 * of size ssize.
+	 */
+	tracksize = _floppy->sect - _floppy->sect % ssize;
+	if (tracksize < _floppy->sect){
+		SECT_PER_TRACK ++;
+		if (tracksize <= fsector_t % _floppy->sect)
+			SECTOR--;
+
+		/* if we are beyond tracksize, fill up using smaller sectors */
+		while (tracksize <= fsector_t % _floppy->sect){
+			while(tracksize + ssize > _floppy->sect){
+				SIZECODE--;
+				ssize >>= 1;
+			}
+			SECTOR++; SECT_PER_TRACK ++;
+			tracksize += ssize;
+		}
+		max_sector = HEAD * _floppy->sect + tracksize;
+	} else if (!TRACK && !HEAD && !(_floppy->rate & FD_2M) && probing) {
+		max_sector = _floppy->sect;
+	} else if (!HEAD && CT(COMMAND) == FD_WRITE) {
+		/* for virtual DMA bug workaround */
+		max_sector = _floppy->sect;
+	}
+
+	in_sector_offset = (fsector_t % _floppy->sect) % ssize;
+	aligned_sector_t = fsector_t - in_sector_offset;
+	max_size = current_req->nr_sectors;
+	if ((raw_cmd->track == buffer_track) && +	    (current_drive == buffer_drive) &&
+	    (fsector_t >= buffer_min) && (fsector_t < buffer_max)) {
+		/* data already in track buffer */
+		if (CT(COMMAND) == FD_READ) {
+			copy_buffer(1, max_sector, buffer_max);
+			return 1;
+		}
+	} else if (in_sector_offset || current_req->nr_sectors < ssize){
+		if (CT(COMMAND) == FD_WRITE){
+			if (fsector_t + current_req->nr_sectors > ssize &&
+			    fsector_t + current_req->nr_sectors < ssize + ssize)
+				max_size = ssize + ssize;
+			else
+				max_size = ssize;
+		}
+		raw_cmd->flags &= ~FD_RAW_WRITE;
+		raw_cmd->flags |= FD_RAW_READ;
+		COMMAND = FM_MODE(_floppy,FD_READ);
+	} else if ((unsigned long)current_req->buffer < MAX_DMA_ADDRESS) {
+		unsigned long dma_limit;
+		int direct, indirect;
+
+		indirect= transfer_size(ssize,max_sector,max_buffer_sectors*2) -
+			fsector_t;
+
+		/*
+		 * Do NOT use minimum() here---MAX_DMA_ADDRESS is 64 bits wide
+		 * on a 64 bit machine!
+		 */
+		max_size = buffer_chain_size();
+		dma_limit = (MAX_DMA_ADDRESS - ((unsigned long) current_req->buffer)) >> 9;
+		if ((unsigned long) max_size > dma_limit) {
+			max_size = dma_limit;
+		}
+		/* 64 kb boundaries */
+		if (CROSS_64KB(current_req->buffer, max_size << 9))
+			max_size = (K_64 - +				    ((unsigned long)current_req->buffer) % K_64)>>9;
+		direct = transfer_size(ssize,max_sector,max_size) - fsector_t;
+		/*
+		 * We try to read tracks, but if we get too many errors, we
+		 * go back to reading just one sector at a time.
+		 *
+		 * This means we should be able to read a sector even if there
+		 * are other bad sectors on this track.
+		 */
+		if (!direct ||
+		    (indirect * 2 > direct * 3 &&
+		     *errors < DP->max_errors.read_track &&
+		     /*!TESTF(FD_NEED_TWADDLE) &&*/
+		     ((!probing || (DP->read_track&(1<<DRS->probed_format)))))){
+			max_size = current_req->nr_sectors;
+		} else {
+			raw_cmd->kernel_data = current_req->buffer;
+			raw_cmd->length = current_count_sectors << 9;
+			if (raw_cmd->length == 0){
+				DPRINT("zero dma transfer attempted from make_raw_request\n");
+				DPRINT("indirect=%d direct=%d fsector_t=%d",
+					indirect, direct, fsector_t);
+				return 0;
+			}
+/*			check_dma_crossing(raw_cmd->kernel_data, +					   raw_cmd->length, 
+					   "end of make_raw_request [1]");*/
+
+			virtualdmabug_workaround();
+			return 2;
+		}
+	}
+
+	if (CT(COMMAND) == FD_READ)
+		max_size = max_sector; /* unbounded */
+
+	/* claim buffer track if needed */
+	if (buffer_track != raw_cmd->track ||  /* bad track */
+	    buffer_drive !=current_drive || /* bad drive */
+	    fsector_t > buffer_max ||
+	    fsector_t < buffer_min ||
+	    ((CT(COMMAND) == FD_READ ||
+	      (!in_sector_offset && current_req->nr_sectors >= ssize))&&
+	     max_sector > 2 * max_buffer_sectors + buffer_min &&
+	     max_size + fsector_t > 2 * max_buffer_sectors + buffer_min)
+	    /* not enough space */){
+		buffer_track = -1;
+		buffer_drive = current_drive;
+		buffer_max = buffer_min = aligned_sector_t;
+	}
+	raw_cmd->kernel_data = floppy_track_buffer + +		((aligned_sector_t-buffer_min)<<9);
+
+	if (CT(COMMAND) == FD_WRITE){
+		/* copy write buffer to track buffer.
+		 * if we get here, we know that the write
+		 * is either aligned or the data already in the buffer
+		 * (buffer will be overwritten) */
+#ifdef FLOPPY_SANITY_CHECK
+		if (in_sector_offset && buffer_track == -1)
+			DPRINT("internal error offset !=0 on write\n");
+#endif
+		buffer_track = raw_cmd->track;
+		buffer_drive = current_drive;
+		copy_buffer(ssize, max_sector, 2*max_buffer_sectors+buffer_min);
+	} else
+		transfer_size(ssize, max_sector,
+			      2*max_buffer_sectors+buffer_min-aligned_sector_t);
+
+	/* round up current_count_sectors to get dma xfer size */
+	raw_cmd->length = in_sector_offset+current_count_sectors;
+	raw_cmd->length = ((raw_cmd->length -1)|(ssize-1))+1;
+	raw_cmd->length <<= 9;
+#ifdef FLOPPY_SANITY_CHECK
+	/*check_dma_crossing(raw_cmd->kernel_data, raw_cmd->length, +	  "end of make_raw_request");*/
+	if ((raw_cmd->length < current_count_sectors << 9) ||
+	    (raw_cmd->kernel_data != current_req->buffer &&
+	     CT(COMMAND) == FD_WRITE &&
+	     (aligned_sector_t + (raw_cmd->length >> 9) > buffer_max ||
+	      aligned_sector_t < buffer_min)) ||
+	    raw_cmd->length % (128 << SIZECODE) ||
+	    raw_cmd->length <= 0 || current_count_sectors <= 0){
+		DPRINT("fractionary current count b=%lx s=%lx\n",
+			raw_cmd->length, current_count_sectors);
+		if (raw_cmd->kernel_data != current_req->buffer)
+			printk("addr=%d, length=%ld\n",
+			       (int) ((raw_cmd->kernel_data - +				       floppy_track_buffer) >> 9),
+			       current_count_sectors);
+		printk("st=%d ast=%d mse=%d msi=%d\n",
+		       fsector_t, aligned_sector_t, max_sector, max_size);
+		printk("ssize=%x SIZECODE=%d\n", ssize, SIZECODE);
+		printk("command=%x SECTOR=%d HEAD=%d, TRACK=%d\n",
+		       COMMAND, SECTOR, HEAD, TRACK);
+		printk("buffer drive=%d\n", buffer_drive);
+		printk("buffer track=%d\n", buffer_track);
+		printk("buffer_min=%d\n", buffer_min);
+		printk("buffer_max=%d\n", buffer_max);
+		return 0;
+	}
+
+	if (raw_cmd->kernel_data != current_req->buffer){
+		if (raw_cmd->kernel_data < floppy_track_buffer ||
+		    current_count_sectors < 0 ||
+		    raw_cmd->length < 0 ||
+		    raw_cmd->kernel_data + raw_cmd->length >
+		    floppy_track_buffer + (max_buffer_sectors  << 10)){
+			DPRINT("buffer overrun in schedule dma\n");
+			printk("fsector_t=%d buffer_min=%d current_count=%ld\n",
+			       fsector_t, buffer_min,
+			       raw_cmd->length >> 9);
+			printk("current_count_sectors=%ld\n",
+			       current_count_sectors);
+			if (CT(COMMAND) == FD_READ)
+				printk("read\n");
+			if (CT(COMMAND) == FD_READ)
+				printk("write\n");
+			return 0;
+		}
+	} else if (raw_cmd->length > current_req->nr_sectors << 9 ||
+		   current_count_sectors > current_req->nr_sectors){
+		DPRINT("buffer overrun in direct transfer\n");
+		return 0;
+	} else if (raw_cmd->length < current_count_sectors << 9){
+		DPRINT("more sectors than bytes\n");
+		printk("bytes=%ld\n", raw_cmd->length >> 9);
+		printk("sectors=%ld\n", current_count_sectors);
+	}
+	if (raw_cmd->length == 0){
+		DPRINT("zero dma transfer attempted from make_raw_request\n");
+		return 0;
+	}
+#endif
+
+	virtualdmabug_workaround();
+	return 2;
+}
+
+static void redo_fd_request(void)
+{
+#define REPEAT {request_done(0); continue; }
+	kdev_t device;
+	int tmp;
+
+	lastredo = jiffies;
+	if (current_drive < N_DRIVE)
+		floppy_off(current_drive);
+
+	for (;;) {
+		if (!current_req) {
+			struct request *req = elv_next_request(&floppy_queue);
+			if (!req) {
+				do_floppy = NULL;
+				unlock_fdc();
+				return;
+			}
+			current_req = req;
+		}
+		device = current_req->rq_dev;
+		set_fdc(DRIVE(device));
+		reschedule_timeout(current_reqD, "redo fd request", 0);
+
+		set_floppy(device);
+		raw_cmd = & default_raw_cmd;
+		raw_cmd->flags = 0;
+		if (start_motor(redo_fd_request)) return;
+		disk_change(current_drive);
+		if (test_bit(current_drive, &fake_change) ||
+		   TESTF(FD_DISK_CHANGED)){
+			DPRINT("disk absent or changed during operation\n");
+			REPEAT;
+		}
+		if (!_floppy) { /* Autodetection */
+			if (!probing){
+				DRS->probed_format = 0;
+				if (next_valid_format()){
+					DPRINT("no autodetectable formats\n");
+					_floppy = NULL;
+					REPEAT;
+				}
+			}
+			probing = 1;
+			_floppy = floppy_type+DP->autodetect[DRS->probed_format];
+		} else
+			probing = 0;
+		errors = & (current_req->errors);
+		tmp = make_raw_rw_request();
+		if (tmp < 2){
+			request_done(tmp);
+			continue;
+		}
+
+		if (TESTF(FD_NEED_TWADDLE))
+			twaddle();
+		schedule_bh( (void *)(void *) floppy_start);
+#ifdef DEBUGT
+		debugt("queue fd request");
+#endif
+		return;
+	}
+#undef REPEAT
+}
+
+static struct cont_t rw_cont={
+	rw_interrupt,
+	redo_fd_request,
+	bad_flp_intr,
+	request_done };
+
+static void process_fd_request(void)
+{
+	cont = &rw_cont;
+	schedule_bh( (void *)(void *) redo_fd_request);
+}
+
+static void do_fd_request(request_queue_t * q)
+{
+	if(max_buffer_sectors == 0) {
+		printk("VFS: do_fd_request called on non-open device\n");
+		return;
+	}
+
+	if (usage_count == 0) {
+		printk("warning: usage count=0, current_req=%p exiting\n", current_req);
+		printk("sect=%ld flags=%lx\n", (long)current_req->sector, current_req->flags);
+		return;
+	}
+	if (fdc_busy){
+		/* fdc busy, this new request will be treated when the
+		   current one is done */
+		is_alive("do fd request, old request running");
+		return;
+	}
+	lock_fdc(MAXTIMEOUT,0);
+	process_fd_request();
+	is_alive("do fd request");
+}
+
+static struct cont_t poll_cont={
+	success_and_wakeup,
+	floppy_ready,
+	generic_failure,
+	generic_done };
+
+static int poll_drive(int interruptible, int flag)
+{
+	int ret;
+	/* no auto-sense, just clear dcl */
+	raw_cmd = &default_raw_cmd;
+	raw_cmd->flags= flag;
+	raw_cmd->track=0;
+	raw_cmd->cmd_count=0;
+	cont = &poll_cont;
+#ifdef DCL_DEBUG
+	if (DP->flags & FD_DEBUG){
+		DPRINT("setting NEWCHANGE in poll_drive\n");
+	}
+#endif
+	SETF(FD_DISK_NEWCHANGE);
+	WAIT(floppy_ready);
+	return ret;
+}
+
+/*
+ * User triggered reset
+ * ====================
+ */
+
+static void reset_intr(void)
+{
+	printk("weird, reset interrupt called\n");
+}
+
+static struct cont_t reset_cont={
+	reset_intr,
+	success_and_wakeup,
+	generic_failure,
+	generic_done };
+
+static int user_reset_fdc(int drive, int arg, int interruptible)
+{
+	int ret;
+
+	ret=0;
+	LOCK_FDC(drive,interruptible);
+	if (arg == FD_RESET_ALWAYS)
+		FDCS->reset=1;
+	if (FDCS->reset){
+		cont = &reset_cont;
+		WAIT(reset_fdc);
+	}
+	process_fd_request();
+	return ret;
+}
+
+/*
+ * Misc Ioctl's and support
+ * ========================
+ */
+static inline int fd_copyout(void *param, const void *address, unsigned long size)
+{
+	return copy_to_user(param,address, size) ? -EFAULT : 0;
+}
+
+static inline int fd_copyin(void *param, void *address, unsigned long size)
+{
+	return copy_from_user(address, param, size) ? -EFAULT : 0;
+}
+
+#define _COPYOUT(x) (copy_to_user((void *)param, &(x), sizeof(x)) ? -EFAULT : 0)
+#define _COPYIN(x) (copy_from_user(&(x), (void *)param, sizeof(x)) ? -EFAULT : 0)
+
+#define COPYOUT(x) ECALL(_COPYOUT(x))
+#define COPYIN(x) ECALL(_COPYIN(x))
+
+static inline const char *drive_name(int type, int drive)
+{
+	struct floppy_struct *floppy;
+
+	if (type)
+		floppy = floppy_type + type;
+	else {
+		if (UDP->native_format)
+			floppy = floppy_type + UDP->native_format;
+		else
+			return "(null)";
+	}
+	if (floppy->name)
+		return floppy->name;
+	else
+		return "(null)";
+}
+
+
+/* raw commands */
+static void raw_cmd_done(int flag)
+{
+	int i;
+
+	if (!flag) {
+		raw_cmd->flags |= FD_RAW_FAILURE;
+		raw_cmd->flags |= FD_RAW_HARDFAILURE;
+	} else {
+		raw_cmd->reply_count = inr;
+		if (raw_cmd->reply_count > MAX_REPLIES)
+			raw_cmd->reply_count=0;
+		for (i=0; i< raw_cmd->reply_count; i++)
+			raw_cmd->reply[i] = reply_buffer[i];
+
+		if (raw_cmd->flags & (FD_RAW_READ | FD_RAW_WRITE))
+		{
+			unsigned long flags;
+			flags=claim_dma_lock();
+			raw_cmd->length = fd_get_dma_residue();
+			release_dma_lock(flags);
+		}
+		 
+		if ((raw_cmd->flags & FD_RAW_SOFTFAILURE) &&
+		    (!raw_cmd->reply_count || (raw_cmd->reply[0] & 0xc0)))
+			raw_cmd->flags |= FD_RAW_FAILURE;
+
+		if (disk_change(current_drive))
+			raw_cmd->flags |= FD_RAW_DISK_CHANGE;
+		else
+			raw_cmd->flags &= ~FD_RAW_DISK_CHANGE;
+		if (raw_cmd->flags & FD_RAW_NO_MOTOR_AFTER)
+			motor_off_callback(current_drive);
+
+		if (raw_cmd->next &&
+		   (!(raw_cmd->flags & FD_RAW_FAILURE) ||
+		    !(raw_cmd->flags & FD_RAW_STOP_IF_FAILURE)) &&
+		   ((raw_cmd->flags & FD_RAW_FAILURE) ||
+		    !(raw_cmd->flags &FD_RAW_STOP_IF_SUCCESS))) {
+			raw_cmd = raw_cmd->next;
+			return;
+		}
+	}
+	generic_done(flag);
+}
+
+
+static struct cont_t raw_cmd_cont={
+	success_and_wakeup,
+	floppy_start,
+	generic_failure,
+	raw_cmd_done
+};
+
+static inline int raw_cmd_copyout(int cmd, char *param,
+				  struct floppy_raw_cmd *ptr)
+{
+	int ret;
+
+	while(ptr) {
+		COPYOUT(*ptr);
+		param += sizeof(struct floppy_raw_cmd);
+		if ((ptr->flags & FD_RAW_READ) && ptr->buffer_length){
+			if (ptr->length>=0 && ptr->length<=ptr->buffer_length)
+				ECALL(fd_copyout(ptr->data, +						 ptr->kernel_data, 
+						 ptr->buffer_length - +						 ptr->length));
+		}
+		ptr = ptr->next;
+	}
+	return 0;
+}
+
+
+static void raw_cmd_free(struct floppy_raw_cmd **ptr)
+{
+	struct floppy_raw_cmd *next,*this;
+
+	this = *ptr;
+	*ptr = 0;
+	while(this) {
+		if (this->buffer_length) {
+			fd_dma_mem_free((unsigned long)this->kernel_data,
+					this->buffer_length);
+			this->buffer_length = 0;
+		}
+		next = this->next;
+		kfree(this);
+		this = next;
+	}
+}
+
+
+static inline int raw_cmd_copyin(int cmd, char *param,
+				 struct floppy_raw_cmd **rcmd)
+{
+	struct floppy_raw_cmd *ptr;
+	int ret;
+	int i;
+	 
+	*rcmd = 0;
+	while(1) {
+		ptr = (struct floppy_raw_cmd *) +			kmalloc(sizeof(struct floppy_raw_cmd), GFP_USER);
+		if (!ptr)
+			return -ENOMEM;
+		*rcmd = ptr;
+		COPYIN(*ptr);
+		ptr->next = 0;
+		ptr->buffer_length = 0;
+		param += sizeof(struct floppy_raw_cmd);
+		if (ptr->cmd_count > 33)
+			/* the command may now also take up the space
+			 * initially intended for the reply & the
+			 * reply count. Needed for long 82078 commands
+			 * such as RESTORE, which takes ... 17 command
+			 * bytes. Murphy's law #137: When you reserve
+			 * 16 bytes for a structure, you'll one day
+			 * discover that you really need 17...
+			 */
+			return -EINVAL;
+
+		for (i=0; i< 16; i++)
+			ptr->reply[i] = 0;
+		ptr->resultcode = 0;
+		ptr->kernel_data = 0;
+
+		if (ptr->flags & (FD_RAW_READ | FD_RAW_WRITE)) {
+			if (ptr->length <= 0)
+				return -EINVAL;
+			ptr->kernel_data =(char*)fd_dma_mem_alloc(ptr->length);
+			fallback_on_nodma_alloc(&ptr->kernel_data,
+						ptr->length);
+			if (!ptr->kernel_data)
+				return -ENOMEM;
+			ptr->buffer_length = ptr->length;
+		}
+		if (ptr->flags & FD_RAW_WRITE)
+			ECALL(fd_copyin(ptr->data, ptr->kernel_data, +					ptr->length));
+		rcmd = & (ptr->next);
+		if (!(ptr->flags & FD_RAW_MORE))
+			return 0;
+		ptr->rate &= 0x43;
+	}
+}
+
+
+static int raw_cmd_ioctl(int cmd, void *param)
+{
+	int drive, ret, ret2;
+	struct floppy_raw_cmd *my_raw_cmd;
+
+	if (FDCS->rawcmd <= 1)
+		FDCS->rawcmd = 1;
+	for (drive= 0; drive < N_DRIVE; drive++){
+		if (FDC(drive) != fdc)
+			continue;
+		if (drive == current_drive){
+			if (UDRS->fd_ref > 1){
+				FDCS->rawcmd = 2;
+				break;
+			}
+		} else if (UDRS->fd_ref){
+			FDCS->rawcmd = 2;
+			break;
+		}
+	}
+
+	if (FDCS->reset)
+		return -EIO;
+
+	ret = raw_cmd_copyin(cmd, param, &my_raw_cmd);
+	if (ret) {
+		raw_cmd_free(&my_raw_cmd);
+		return ret;
+	}
+
+	raw_cmd = my_raw_cmd;
+	cont = &raw_cmd_cont;
+	ret=wait_til_done(floppy_start,1);
+#ifdef DCL_DEBUG
+	if (DP->flags & FD_DEBUG){
+		DPRINT("calling disk change from raw_cmd ioctl\n");
+	}
+#endif
+
+	if (ret != -EINTR && FDCS->reset)
+		ret = -EIO;
+
+	DRS->track = NO_TRACK;
+
+	ret2 = raw_cmd_copyout(cmd, param, my_raw_cmd);
+	if (!ret)
+		ret = ret2;
+	raw_cmd_free(&my_raw_cmd);
+	return ret;
+}
+
+static int invalidate_drive(struct block_device *bdev)
+{
+	/* invalidate the buffer track to force a reread */
+	set_bit(DRIVE(to_kdev_t(bdev->bd_dev)), &fake_change);
+	process_fd_request();
+	check_disk_change(bdev);
+	return 0;
+}
+
+
+static inline void clear_write_error(int drive)
+{
+	CLEARSTRUCT(UDRWE);
+}
+
+static inline int set_geometry(unsigned int cmd, struct floppy_struct *g,
+			       int drive, int type, struct block_device *bdev)
+{
+	int cnt;
+
+	/* sanity checking for parameters.*/
+	if (g->sect <= 0 ||
+	    g->head <= 0 ||
+	    g->track <= 0 ||
+	    g->track > UDP->tracks>>STRETCH(g) ||
+	    /* check if reserved bits are set */
+	    (g->stretch&~(FD_STRETCH|FD_SWAPSIDES)) != 0)
+		return -EINVAL;
+	if (type){
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		LOCK_FDC(drive,1);
+		for (cnt = 0; cnt < N_DRIVE; cnt++){
+			if (ITYPE(drive_state[cnt].fd_device) == type &&
+			    drive_state[cnt].fd_ref)
+				set_bit(drive, &fake_change);
+		}
+		floppy_type[type] = *g;
+		floppy_type[type].name="user format";
+		for (cnt = type << 2; cnt < (type << 2) + 4; cnt++)
+			floppy_sizes[cnt]= floppy_sizes[cnt+0x80]=
+				floppy_type[type].size+1;
+		process_fd_request();
+		for (cnt = 0; cnt < N_DRIVE; cnt++){
+			if (ITYPE(drive_state[cnt].fd_device) == type &&
+			    drive_state[cnt].fd_ref)
+				__check_disk_change(
+					MKDEV(FLOPPY_MAJOR,
+					      drive_state[cnt].fd_device));
+		}
+	} else {
+		LOCK_FDC(drive,1);
+		if (cmd != FDDEFPRM)
+			/* notice a disk change immediately, else
+			 * we lose our settings immediately*/
+			CALL(poll_drive(1, FD_RAW_NEED_DISK));
+		user_params[drive] = *g;
+		if (buffer_drive == drive)
+			SUPBOUND(buffer_max, user_params[drive].sect);
+		current_type[drive] = &user_params[drive];
+		floppy_sizes[drive] = user_params[drive].size;
+		if (cmd == FDDEFPRM)
+			DRS->keep_data = -1;
+		else
+			DRS->keep_data = 1;
+		/* invalidation. Invalidate only when needed, i.e.
+		 * when there are already sectors in the buffer cache
+		 * whose number will change. This is useful, because
+		 * mtools often changes the geometry of the disk after
+		 * looking at the boot block */
+		if (DRS->maxblock > user_params[drive].sect || DRS->maxtrack)
+			invalidate_drive(bdev);
+		else
+			process_fd_request();
+	}
+	return 0;
+}
+
+/* handle obsolete ioctl's */
+static int ioctl_table[]= {
+	FDCLRPRM,
+	FDSETPRM,
+	FDDEFPRM,
+	FDGETPRM,
+	FDMSGON,
+	FDMSGOFF,
+	FDFMTBEG,
+	FDFMTTRK,
+	FDFMTEND,
+	FDSETEMSGTRESH,
+	FDFLUSH,
+	FDSETMAXERRS,
+	FDGETMAXERRS,
+	FDGETDRVTYP,
+	FDSETDRVPRM,
+	FDGETDRVPRM,
+	FDGETDRVSTAT,
+	FDPOLLDRVSTAT,
+	FDRESET,
+	FDGETFDCSTAT,
+	FDWERRORCLR,
+	FDWERRORGET,
+	FDRAWCMD,
+	FDEJECT,
+	FDTWADDLE
+};
+
+static inline int normalize_ioctl(int *cmd, int *size)
+{
+	int i;
+
+	for (i=0; i < ARRAY_SIZE(ioctl_table); i++) {
+		if ((*cmd & 0xffff) == (ioctl_table[i] & 0xffff)){
+			*size = _IOC_SIZE(*cmd);
+			*cmd = ioctl_table[i];
+			if (*size > _IOC_SIZE(*cmd)) {
+				printk("ioctl not yet supported\n");
+				return -EFAULT;
+			}
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int get_floppy_geometry(int drive, int type, struct floppy_struct **g)
+{
+	if (type)
+		*g = &floppy_type[type];
+	else {
+		LOCK_FDC(drive,0);
+		CALL(poll_drive(0,0));
+		process_fd_request();		 
+		*g = current_type[drive];
+	}
+	if (!*g)
+		return -ENODEV;
+	return 0;
+}
+
+static int fd_ioctl(struct inode *inode, struct file *filp, unsigned int cmd,
+		    unsigned long param)
+{
+#define FD_IOCTL_ALLOWED ((filp) && (filp)->private_data)
+#define OUT(c,x) case c: outparam = (const char *) (x); break
+#define IN(c,x,tag) case c: *(x) = inparam. tag ; return 0
+
+	int i,drive,type;
+	kdev_t device;
+	int ret;
+	int size;
+	union inparam {
+		struct floppy_struct g; /* geometry */
+		struct format_descr f;
+		struct floppy_max_errors max_errors;
+		struct floppy_drive_params dp;
+	} inparam; /* parameters coming from user space */
+	const char *outparam; /* parameters passed back to user space */
+
+	device = inode->i_rdev;
+	type = TYPE(device);
+	drive = DRIVE(device);
+
+	/* convert compatibility eject ioctls into floppy eject ioctl.
+	 * We do this in order to provide a means to eject floppy disks before
+	 * installing the new fdutils package */
+	if (cmd == CDROMEJECT || /* CD-ROM eject */
+	    cmd == 0x6470 /* SunOS floppy eject */) {
+		DPRINT("obsolete eject ioctl\n");
+		DPRINT("please use floppycontrol --eject\n");
+		cmd = FDEJECT;
+	}
+
+	/* generic block device ioctls */
+	switch(cmd) {
+		/* the following have been inspired by the corresponding
+		 * code for other block devices. */
+		struct floppy_struct *g;
+		case HDIO_GETGEO:
+		{
+			struct hd_geometry loc;
+			ECALL(get_floppy_geometry(drive, type, &g));
+			loc.heads = g->head;
+			loc.sectors = g->sect;
+			loc.cylinders = g->track;
+			loc.start = 0;
+			return _COPYOUT(loc);
+		}
+	}
+
+	/* convert the old style command into a new style command */
+	if ((cmd & 0xff00) == 0x0200) {
+		ECALL(normalize_ioctl(&cmd, &size));
+	} else
+		return -EINVAL;
+
+	/* permission checks */
+	if (((cmd & 0x40) && !FD_IOCTL_ALLOWED) ||
+	    ((cmd & 0x80) && !capable(CAP_SYS_ADMIN)))
+		return -EPERM;
+
+	/* copyin */
+	CLEARSTRUCT(&inparam);
+	if (_IOC_DIR(cmd) & _IOC_WRITE)
+		ECALL(fd_copyin((void *)param, &inparam, size))
+
+	switch (cmd) {
+		case FDEJECT:
+			if (UDRS->fd_ref != 1)
+				/* somebody else has this drive open */
+				return -EBUSY;
+			LOCK_FDC(drive,1);
+
+			/* do the actual eject. Fails on
+			 * non-Sparc architectures */
+			ret=fd_eject(UNIT(drive));
+
+			USETF(FD_DISK_CHANGED);
+			USETF(FD_VERIFY);
+			process_fd_request();
+			return ret;			 
+		case FDCLRPRM:
+			LOCK_FDC(drive,1);
+			current_type[drive] = NULL;
+			floppy_sizes[drive] = MAX_DISK_SIZE << 1;
+			UDRS->keep_data = 0;
+			return invalidate_drive(inode->i_bdev);
+		case FDSETPRM:
+		case FDDEFPRM:
+			return set_geometry(cmd, & inparam.g,
+					    drive, type, inode->i_bdev);
+		case FDGETPRM:
+			ECALL(get_floppy_geometry(drive, type, +						  (struct floppy_struct**)
+						  &outparam));
+			break;
+
+		case FDMSGON:
+			UDP->flags |= FTD_MSG;
+			return 0;
+		case FDMSGOFF:
+			UDP->flags &= ~FTD_MSG;
+			return 0;
+
+		case FDFMTBEG:
+			LOCK_FDC(drive,1);
+			CALL(poll_drive(1, FD_RAW_NEED_DISK));
+			ret = UDRS->flags;
+			if (ret & FD_VERIFY) {
+				CALL(poll_drive(1, FD_RAW_NEED_DISK));
+				ret = UDRS->flags;
+			}
+
+			if (ret & FD_VERIFY) {
+				CALL(poll_drive(1, FD_RAW_NEED_DISK));
+				ret = UDRS->flags;
+			}
+
+			if (ret & FD_VERIFY) {
+				CALL(poll_drive(1, FD_RAW_NEED_DISK));
+				ret = UDRS->flags;
+			}
+
+			if (ret & FD_VERIFY) {
+				CALL(poll_drive(1, FD_RAW_NEED_DISK));
+				ret = UDRS->flags;
+			}
+
+			if(ret & FD_VERIFY){
+				CALL(poll_drive(1, FD_RAW_NEED_DISK));
+				ret = UDRS->flags;
+			}
+			process_fd_request();
+			if (ret & FD_VERIFY)
+				return -ENODEV;
+			if (!(ret & FD_DISK_WRITABLE))
+				return -EROFS;
+			return 0;
+		case FDFMTTRK:
+			if (UDRS->fd_ref != 1)
+				return -EBUSY;
+			return do_format(device, &inparam.f);
+		case FDFMTEND:
+		case FDFLUSH:
+			LOCK_FDC(drive,1);
+			return invalidate_drive(inode->i_bdev);
+
+		case FDSETEMSGTRESH:
+			UDP->max_errors.reporting =
+				(unsigned short) (param & 0x0f);
+			return 0;
+		OUT(FDGETMAXERRS, &UDP->max_errors);
+		IN(FDSETMAXERRS, &UDP->max_errors, max_errors);
+
+		case FDGETDRVTYP:
+			outparam = drive_name(type,drive);
+			SUPBOUND(size,strlen(outparam)+1);
+			break;
+
+		IN(FDSETDRVPRM, UDP, dp);
+		OUT(FDGETDRVPRM, UDP);
+
+		case FDPOLLDRVSTAT:
+			LOCK_FDC(drive,1);
+			CALL(poll_drive(1, FD_RAW_NEED_DISK));
+			process_fd_request();
+			/* fall through */
+	       	OUT(FDGETDRVSTAT, UDRS);
+
+		case FDRESET:
+			return user_reset_fdc(drive, (int)param, 1);
+
+		OUT(FDGETFDCSTAT,UFDCS);
+
+		case FDWERRORCLR:
+			CLEARSTRUCT(UDRWE);
+			return 0;
+		OUT(FDWERRORGET,UDRWE);
+
+		case FDRAWCMD:
+			if (type)
+				return -EINVAL;
+			LOCK_FDC(drive,1);
+			set_floppy(device);
+			CALL(i = raw_cmd_ioctl(cmd,(void *) param));
+			process_fd_request();
+			return i;
+
+		case FDTWADDLE:
+			LOCK_FDC(drive,1);
+			twaddle();
+			process_fd_request();
+			return 0;
+
+		default:
+			return -EINVAL;
+	}
+
+	if (_IOC_DIR(cmd) & _IOC_READ)
+		return fd_copyout((void *)param, outparam, size);
+	else
+		return 0;
+#undef OUT
+#undef IN
+}
+
+static void __init config_types(void)
+{
+	int first=1;
+	int drive;
+	extern struct fd_info {
+		unsigned char dummy[4 * 6];
+		unsigned char fd_types[8];
+	} drive_info;
+
+	for (drive = 0; drive < 4; drive++)
+		UDP->cmos = drive_info.fd_types[drive];
+
+	/* XXX */
+	/* additional physical CMOS drive detection should go here */
+
+	for (drive=0; drive < N_DRIVE; drive++){
+		unsigned int type = UDP->cmos;
+		struct floppy_drive_params *params;
+		const char *name = NULL;
+		static char temparea[32];
+
+		if (type < NUMBER(default_drive_params)) {
+			params = &default_drive_params[type].params;
+			if (type) {
+				name = default_drive_params[type].name;
+				allowed_drive_mask |= 1 << drive;
+			}
+		} else {
+			params = &default_drive_params[0].params;
+			sprintf(temparea, "unknown type %d (usb?)", type);
+			name = temparea;
+		}
+		if (name) {
+			const char * prepend = ",";
+			if (first) {
+				prepend = KERN_INFO "Floppy drive(s):";
+				first = 0;
+			}
+			printk("%s fd%d is %s", prepend, drive, name);
+			register_devfs_entries (drive);
+		}
+		*UDP = *params;
+	}
+	if (!first)
+		printk("\n");
+}
+
+static int floppy_release(struct inode * inode, struct file * filp)
+{
+	int drive = DRIVE(inode->i_rdev);
+
+	if (UDRS->fd_ref < 0)
+		UDRS->fd_ref=0;
+	else if (!UDRS->fd_ref--) {
+		DPRINT("floppy_release with fd_ref == 0");
+		UDRS->fd_ref = 0;
+	}
+	floppy_release_irq_and_dma();
+	return 0;
+}
+
+/*
+ * floppy_open check for aliasing (/dev/fd0 can be the same as
+ * /dev/PS0 etc), and disallows simultaneous access to the same
+ * drive with different device numbers.
+ */
+#define RETERR(x) do{floppy_release(inode,filp); return -(x);}while(0)
+
+static int floppy_open(struct inode * inode, struct file * filp)
+{
+	int drive;
+	int old_dev;
+	int try;
+	char *tmp;
+
+#ifdef PC9800_DEBUG_FLOPPY
+	printk("floppy open: start\n");
+#endif
+	filp->private_data = (void*) 0;
+
+	drive = DRIVE(inode->i_rdev);
+#ifdef PC9800_DEBUG_FLOPPY
+	printk("floppy open: drive=%d, current_drive=%d, UDP->cmos=%d\n"
+		   "floppy open: FDCS={spec1=%d, spec2=%d, dtr=%d, version=%d, dor=%d, address=%lu}\n",
+		   drive, current_drive, UDP->cmos, FDCS->spec1, FDCS->spec2,
+		   FDCS->dtr, FDCS->version, FDCS->dor, FDCS->address);
+	if (_floppy) {
+		printk("floppy open: _floppy={size=%d, sect=%d, head=%d, track=%d, spec1=%d}\n",
+			   _floppy->size, _floppy->sect, _floppy->head,
+			   _floppy->track, _floppy->spec1);
+	} else {
+		printk("floppy open: _floppy=NULL\n");
+	}
+#endif /* PC9800_DEBUG_FLOPPY */
+
+	if (drive >= N_DRIVE ||
+	    !(allowed_drive_mask & (1 << drive)) ||
+	    fdc_state[FDC(drive)].version == FDC_NONE)
+		return -ENXIO;
+
+	if (TYPE(inode->i_rdev) >= NUMBER(floppy_type))
+		return -ENXIO;
+	old_dev = UDRS->fd_device;
+	if (UDRS->fd_ref && old_dev != minor(inode->i_rdev))
+		return -EBUSY;
+
+	if (!UDRS->fd_ref && (UDP->flags & FD_BROKEN_DCL)){
+		USETF(FD_DISK_CHANGED);
+		USETF(FD_VERIFY);
+	}
+
+	if (UDRS->fd_ref == -1 ||
+	   (UDRS->fd_ref && (filp->f_flags & O_EXCL)))
+		return -EBUSY;
+
+	if (floppy_grab_irq_and_dma())
+		return -EBUSY;
+
+	if (filp->f_flags & O_EXCL)
+		UDRS->fd_ref = -1;
+	else
+		UDRS->fd_ref++;
+
+	if (!floppy_track_buffer){
+		/* if opening an ED drive, reserve a big buffer,
+		 * else reserve a small one */
+		if ((UDP->cmos == 6) || (UDP->cmos == 5))
+			try = 64; /* Only 48 actually useful */
+		else
+			try = 32; /* Only 24 actually useful */
+
+		tmp=(char *)fd_dma_mem_alloc(1024 * try);
+		if (!tmp && !floppy_track_buffer) {
+			try >>= 1; /* buffer only one side */
+			INFBOUND(try, 16);
+			tmp= (char *)fd_dma_mem_alloc(1024*try);
+		}
+		if (!tmp && !floppy_track_buffer) {
+			fallback_on_nodma_alloc(&tmp, 2048 * try);
+		}
+		if (!tmp && !floppy_track_buffer) {
+			DPRINT("Unable to allocate DMA memory\n");
+			RETERR(ENXIO);
+		}
+		if (floppy_track_buffer) {
+			if (tmp)
+				fd_dma_mem_free((unsigned long)tmp,try*1024);
+		} else {
+			buffer_min = buffer_max = -1;
+			floppy_track_buffer = tmp;
+			max_buffer_sectors = try;
+		}
+	}
+
+	UDRS->fd_device = minor(inode->i_rdev);
+	set_capacity(disks[drive], floppy_sizes[minor(inode->i_rdev)]);
+	if (old_dev != -1 && old_dev != minor(inode->i_rdev)) {
+		if (buffer_drive == drive)
+			buffer_track = -1;
+		/* umm, invalidate_buffers() in ->open??  --hch */
+		invalidate_buffers(mk_kdev(FLOPPY_MAJOR,old_dev));
+	}
+
+#ifdef PC9800_DEBUG_FLOPPY
+	printk("floppy open: floppy.c:%d passed\n", __LINE__);
+#endif
+
+
+	/* Allow ioctls if we have write-permissions even if read-only open.
+	 * Needed so that programs such as fdrawcmd still can work on write
+	 * protected disks */
+	if ((filp->f_mode & 2) || +	    (inode->i_sb && (permission(inode,2) == 0)))
+	    filp->private_data = (void*) 8;
+
+	if (UFDCS->rawcmd == 1)
+		UFDCS->rawcmd = 2;
+
+#ifdef PC9800_DEBUG_FLOPPY
+	printk("floppy open: floppy.c:%d passed\n", __LINE__);
+#endif
+
+	if (filp->f_flags & O_NDELAY)
+		return 0;
+	if (filp->f_mode & 3) {
+		UDRS->last_checked = 0;
+		check_disk_change(inode->i_bdev);
+		if (UTESTF(FD_DISK_CHANGED))
+			RETERR(ENXIO);
+	}
+	if ((filp->f_mode & 2) && !(UTESTF(FD_DISK_WRITABLE)))
+		RETERR(EROFS);
+#ifdef PC9800_DEBUG_FLOPPY
+	printk("floppy open: end normally\n");
+#endif
+
+	return 0;
+#undef RETERR
+}
+
+/*
+ * Check if the disk has been changed or if a change has been faked.
+ */
+static int check_floppy_change(struct gendisk *disk)
+{
+	int drive = (int)disk->private_data;
+
+#ifdef PC9800_DEBUG_FLOPPY
+	printk("check_floppy_change: MINOR=%d\n", minor(dev));
+#endif
+
+	if (UTESTF(FD_DISK_CHANGED) || UTESTF(FD_VERIFY))
+		return 1;
+
+	if (UDP->checkfreq < (int)(jiffies - UDRS->last_checked)) {
+		if(floppy_grab_irq_and_dma()) {
+			return 1;
+		}
+
+		lock_fdc(drive,0);
+		poll_drive(0,0);
+		process_fd_request();
+		floppy_release_irq_and_dma();
+	}
+
+	if (UTESTF(FD_DISK_CHANGED) ||
+	   UTESTF(FD_VERIFY) ||
+	   test_bit(drive, &fake_change) ||
+	   (!ITYPE(UDRS->fd_device) && !current_type[drive]))
+		return 1;
+	return 0;
+}
+
+/*
+ * This implements "read block 0" for floppy_revalidate().
+ * Needed for format autodetection, checking whether there is
+ * a disk in the drive, and whether that disk is writable.
+ */
+
+static int floppy_rb0_complete(struct bio *bio, unsigned int bytes_done, int err)
+{
+	if (bio->bi_size)
+		return 1;
+
+	complete((struct completion*)bio->bi_private);
+	return 0;
+}
+
+static int __floppy_read_block_0(struct block_device *bdev)
+{
+	struct bio bio;
+	struct bio_vec bio_vec;
+	struct completion complete;
+	struct page *page;
+	size_t size;
+
+	page = alloc_page(GFP_NOIO);
+	if (!page) {
+		process_fd_request();
+		return -ENOMEM;
+	}
+
+	size = bdev->bd_block_size;
+	if (!size)
+		size = 1024;
+
+	bio_init(&bio);
+	bio.bi_io_vec = &bio_vec;
+	bio_vec.bv_page = page;
+	bio_vec.bv_len = size;
+	bio_vec.bv_offset = 0;
+	bio.bi_vcnt = 1;
+	bio.bi_idx = 0;
+	bio.bi_size = size;
+	bio.bi_bdev = bdev;
+	bio.bi_sector = 0;
+	init_completion(&complete);
+	bio.bi_private = &complete;
+	bio.bi_end_io = floppy_rb0_complete;
+
+	submit_bio(READ, &bio);
+	generic_unplug_device(bdev_get_queue(bdev));
+	process_fd_request();
+	wait_for_completion(&complete);
+
+	__free_page(page);
+
+	return 0;
+}
+
+static int floppy_read_block_0(struct gendisk *disk)
+{
+	struct block_device *bdev;
+	int ret;
+
+	bdev = bdget(MKDEV(disk->major, disk->first_minor));
+	if (!bdev) {
+		printk("No block device for %s\n", disk->disk_name);
+		BUG();
+	}
+	bdev->bd_disk = disk;	/* ewww */
+	ret = __floppy_read_block_0(bdev);
+	atomic_dec(&bdev->bd_count);
+	return ret;
+}
+
+/* revalidate the floppy disk, i.e. trigger format autodetection by reading
+ * the bootblock (block 0). "Autodetection" is also needed to check whether
+ * there is a disk in the drive at all... Thus we also do it for fixed
+ * geometry formats */
+static int floppy_revalidate(struct gendisk *disk)
+{
+	int drive=(int)disk->private_data;
+#define NO_GEOM (!current_type[drive] && !ITYPE(UDRS->fd_device))
+	int cf;
+	int res = 0;
+
+	if (UTESTF(FD_DISK_CHANGED) ||
+	    UTESTF(FD_VERIFY) ||
+	    test_bit(drive, &fake_change) ||
+	    NO_GEOM){
+		if(usage_count == 0) {
+			printk("VFS: revalidate called on non-open device.\n");
+			return -EFAULT;
+		}
+		lock_fdc(drive,0);
+		cf = UTESTF(FD_DISK_CHANGED) || UTESTF(FD_VERIFY);
+		if (!(cf || test_bit(drive, &fake_change) || NO_GEOM)){
+			process_fd_request(); /*already done by another thread*/
+			return 0;
+		}
+		UDRS->maxblock = 0;
+		UDRS->maxtrack = 0;
+		if (buffer_drive == drive)
+			buffer_track = -1;
+		clear_bit(drive, &fake_change);
+		UCLEARF(FD_DISK_CHANGED);
+		if (cf)
+			UDRS->generation++;
+		if (NO_GEOM){
+			/* auto-sensing */
+			res = floppy_read_block_0(disk);
+		} else {
+			if (cf)
+				poll_drive(0, FD_RAW_NEED_DISK);
+			process_fd_request();
+		}
+	}
+	set_capacity(disk, floppy_sizes[UDRS->fd_device]);
+	return res;
+}
+
+static struct block_device_operations floppy_fops = {
+	.owner		= THIS_MODULE,
+	.open		= floppy_open,
+	.release	= floppy_release,
+	.ioctl		= fd_ioctl,
+	.media_changed	= check_floppy_change,
+	.revalidate_disk= floppy_revalidate,
+};
+
+static void __init register_devfs_entries (int drive)
+{
+    int base_minor, i;
+    static char *table[] =
+    {"",
+#if 0
+     "d360", +#else
+     "h1232",
+#endif
+     "h1200", "u360", "u720", "h360", "h720",
+     "u1440", "u2880", "CompaQ", "h1440", "u1680", "h410",
+     "u820", "h1476", "u1722", "h420", "u830", "h1494", "u1743",
+     "h880", "u1040", "u1120", "h1600", "u1760", "u1920",
+     "u3200", "u3520", "u3840", "u1840", "u800", "u1600",
+     NULL
+    };
+    static int t360[] = {1,0}, t1200[] = {2,5,6,10,12,14,16,18,20,23,0},
+      t3in[] = {8,9,26,27,28, 7,11,15,19,24,25,29,31, 3,4,13,17,21,22,30,0};
+    static int *table_sup[] = +    {NULL, t360, t1200, t3in+5+8, t3in+5, t3in, t3in};
+
+    base_minor = (drive < 4) ? drive : (124 + drive);
+    if (UDP->cmos < NUMBER(default_drive_params)) {
+	i = 0;
+	do {
+	    char name[16];
+
+	    sprintf (name, "%d%s", drive, table[table_sup[UDP->cmos][i]]);
+	    devfs_register (devfs_handle, name, DEVFS_FL_DEFAULT, MAJOR_NR,
+			    base_minor + (table_sup[UDP->cmos][i] << 2),
+			    S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |S_IWGRP,
+			    &floppy_fops, NULL);
+	} while (table_sup[UDP->cmos][i++]);
+    }
+}
+
+/*
+ * Floppy Driver initialization
+ * =============================
+ */
+
+static inline char __init get_fdc_version(void)
+{
+	return FDC_8272A;
+}
+
+/* lilo configuration */
+
+static void __init floppy_set_flags(int *ints,int param, int param2)
+{
+	int i;
+
+	for (i=0; i < ARRAY_SIZE(default_drive_params); i++){
+		if (param)
+			default_drive_params[i].params.flags |= param2;
+		else
+			default_drive_params[i].params.flags &= ~param2;
+	}
+	DPRINT("%s flag 0x%x\n", param2 ? "Setting" : "Clearing", param);
+}
+
+static void __init daring(int *ints,int param, int param2)
+{
+	int i;
+
+	for (i=0; i < ARRAY_SIZE(default_drive_params); i++){
+		if (param){
+			default_drive_params[i].params.select_delay = 0;
+			default_drive_params[i].params.flags |= FD_SILENT_DCL_CLEAR;
+		} else {
+			default_drive_params[i].params.select_delay = 2*HZ/100;
+			default_drive_params[i].params.flags &= ~FD_SILENT_DCL_CLEAR;
+		}
+	}
+	DPRINT("Assuming %s floppy hardware\n", param ? "standard" : "broken");
+}
+
+static void __init set_cmos(int *ints, int dummy, int dummy2)
+{
+	int current_drive=0;
+
+	if (ints[0] != 2){
+		DPRINT("wrong number of parameters for CMOS\n");
+		return;
+	}
+	current_drive = ints[1];
+	if (current_drive < 0 || current_drive >= 8){
+		DPRINT("bad drive for set_cmos\n");
+		return;
+	}
+#if N_FDC > 1
+	if (current_drive >= 4 && !FDC2)
+		FDC2 = 0x370;
+#endif
+	DP->cmos = ints[2];
+	DPRINT("setting CMOS code to %d\n", ints[2]);
+}
+
+static struct param_table {
+	const char *name;
+	void (*fn)(int *ints, int param, int param2);
+	int *var;
+	int def_param;
+	int param2;
+} config_params[]={
+	{ "allowed_drive_mask", 0, &allowed_drive_mask, 0xff, 0}, /* obsolete */
+	{ "all_drives", 0, &allowed_drive_mask, 0xff, 0 }, /* obsolete */
+	{ "irq", 0, &FLOPPY_IRQ, DEFAULT_FLOPPY_IRQ, 0 },
+	{ "dma", 0, &FLOPPY_DMA, DEFAULT_FLOPPY_DMA, 0 },
+
+	{ "daring", daring, 0, 1, 0},
+#if N_FDC > 1
+	{ "two_fdc",  0, &FDC2, 0x370, 0 },
+	{ "one_fdc", 0, &FDC2, 0, 0 },
+#endif
+	{ "broken_dcl", floppy_set_flags, 0, 1, FD_BROKEN_DCL },
+	{ "messages", floppy_set_flags, 0, 1, FTD_MSG },
+	{ "silent_dcl_clear", floppy_set_flags, 0, 1, FD_SILENT_DCL_CLEAR },
+	{ "debug", floppy_set_flags, 0, 1, FD_DEBUG },
+
+	{ "nodma", 0, &can_use_virtual_dma, 1, 0 },
+	{ "yesdma", 0, &can_use_virtual_dma, 0, 0 },
+
+	{ "fifo_depth", 0, &fifo_depth, 0xa, 0 },
+	{ "nofifo", 0, &no_fifo, 0x20, 0 },
+	{ "usefifo", 0, &no_fifo, 0, 0 },
+
+	{ "cmos", set_cmos, 0, 0, 0 },
+	{ "slow", 0, &slow_floppy, 1, 0 },
+
+	{ "unexpected_interrupts", 0, &print_unex, 1, 0 },
+	{ "no_unexpected_interrupts", 0, &print_unex, 0, 0 },
+
+	EXTRA_FLOPPY_PARAMS
+};
+
+static int __init floppy_setup(char *str)
+{
+	int i;
+	int param;
+	int ints[11];
+
+	str = get_options(str,ARRAY_SIZE(ints),ints);
+	if (str) {
+		for (i=0; i< ARRAY_SIZE(config_params); i++){
+			if (strcmp(str,config_params[i].name) == 0){
+				if (ints[0])
+					param = ints[1];
+				else
+					param = config_params[i].def_param;
+				if (config_params[i].fn)
+					config_params[i].
+						fn(ints,param,
+						   config_params[i].param2);
+				if (config_params[i].var) {
+					DPRINT("%s=%d\n", str, param);
+					*config_params[i].var = param;
+				}
+				return 1;
+			}
+		}
+	}
+	if (str) {
+		DPRINT("unknown floppy option [%s]\n", str);
+		 
+		DPRINT("allowed options are:");
+		for (i=0; i< ARRAY_SIZE(config_params); i++)
+			printk(" %s",config_params[i].name);
+		printk("\n");
+	} else
+		DPRINT("botched floppy option\n");
+	DPRINT("Read linux/Documentation/floppy.txt\n");
+	return 0;
+}
+
+static int have_no_fdc= -ENODEV;
+
+static struct platform_device floppy_device = {
+	.name		= "floppy",
+	.id		= 0,
+	.dev		= {
+		.name	= "Floppy Drive",
+	},
+};
+
+static struct gendisk *floppy_find(dev_t dev, int *part, void *data)
+{
+	int drive = (*part&3) | ((*part&0x80) >> 5);
+	if (drive >= N_DRIVE ||
+	    !(allowed_drive_mask & (1 << drive)) ||
+	    fdc_state[FDC(drive)].version == FDC_NONE)
+		return NULL;
+	*part = 0;
+	return get_disk(disks[drive]);
+}
+
+int __init floppy_init(void)
+{
+	int i,unit,drive;
+	int err;
+
+	raw_cmd = NULL;
+
+	for (i=0; i<N_DRIVE; i++) {
+		disks[i] = alloc_disk(1);
+		if (!disks[i])
+			goto Enomem;
+	}
+
+	devfs_handle = devfs_mk_dir (NULL, "floppy", NULL);
+	if (register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
+		printk("Unable to get major %d for floppy\n",MAJOR_NR);
+		err = -EBUSY;
+		goto out;
+	}
+
+	for (i=0; i<N_DRIVE; i++) {
+		disks[i]->major = MAJOR_NR;
+		disks[i]->first_minor = TOMINOR(i);
+		disks[i]->fops = &floppy_fops;
+		sprintf(disks[i]->disk_name, "fd%d", i);
+	}
+
+	blk_register_region(MKDEV(MAJOR_NR, 0), 256, THIS_MODULE,
+				floppy_find, NULL, NULL);
+
+	for (i=0; i<256; i++)
+		if (ITYPE(i))
+			floppy_sizes[i] = floppy_type[ITYPE(i)].size;
+		else
+			floppy_sizes[i] = MAX_DISK_SIZE << 1;
+
+	blk_init_queue(&floppy_queue, do_fd_request, &floppy_lock);
+	reschedule_timeout(MAXTIMEOUT, "floppy init", MAXTIMEOUT);
+	config_types();
+
+	for (i = 0; i < N_FDC; i++) {
+		fdc = i;
+		CLEARSTRUCT(FDCS);
+		FDCS->dtr = -1;
+		FDCS->dor = 0;
+	}
+
+	if ((fd_inb(FD_MODE_CHANGE) & 1) == 0)
+		FDC1 = 0xc8;
+
+	use_virtual_dma = can_use_virtual_dma & 1;
+	fdc_state[0].address = FDC1;
+	if (fdc_state[0].address == -1) {
+		err = -ENODEV;
+		goto out1;
+	}
+#if N_FDC > 1
+	fdc_state[1].address = FDC2;
+#endif
+
+	fdc = 0; /* reset fdc in case of unexpected interrupt */
+	if (floppy_grab_irq_and_dma()){
+		err = -EBUSY;
+		goto out1;
+	}
+
+	/* initialise drive state */
+	for (drive = 0; drive < N_DRIVE; drive++) {
+		CLEARSTRUCT(UDRS);
+		CLEARSTRUCT(UDRWE);
+		USETF(FD_DISK_NEWCHANGE);
+		USETF(FD_DISK_CHANGED);
+		USETF(FD_VERIFY);
+		UDRS->fd_device = -1;
+		floppy_track_buffer = NULL;
+		max_buffer_sectors = 0;
+	}
+
+	for (i = 0; i < N_FDC; i++) {
+		fdc = i;
+		FDCS->driver_version = FD_DRIVER_VERSION;
+		for (unit=0; unit<4; unit++)
+			FDCS->track[unit] = 0;
+		if (FDCS->address == -1)
+			continue;
+		FDCS->rawcmd = 2;
+		user_reset_fdc(-1, FD_RESET_ALWAYS, 0);
+
+		/* Try to determine the floppy controller type */
+		FDCS->version = get_fdc_version();
+		if (FDCS->version == FDC_NONE){
+ 			/* free ioports reserved by floppy_grab_irq_and_dma() */
+			release_region(FDCS->address, 1);
+			release_region(FDCS->address + 2, 1);
+			release_region(FDCS->address + 4, 1);
+			release_region(0xbe, 1);
+			release_region(0x4be, 1);
+			FDCS->address = -1;
+			continue;
+		}
+		if (can_use_virtual_dma == 2 && FDCS->version < FDC_82072A)
+			can_use_virtual_dma = 0;
+
+		have_no_fdc = 0;
+		/* Not all FDCs seem to be able to handle the version command
+		 * properly, so force a reset for the standard FDC clones,
+		 * to avoid interrupt garbage.
+		 */
+		user_reset_fdc(-1,FD_RESET_ALWAYS,0);
+	}
+	fdc=0;
+	del_timer(&fd_timeout);
+	current_drive = 0;
+	floppy_release_irq_and_dma();
+#if 0  /* no message */
+	initialising=0;
+#endif
+	if (have_no_fdc) {
+		DPRINT("no floppy controllers found\n");
+		flush_scheduled_work();
+		if (usage_count)
+			floppy_release_irq_and_dma();
+		err = have_no_fdc;
+		goto out2;
+	}
+	 
+	for (drive = 0; drive < N_DRIVE; drive++) {
+		motor_off_timer[drive].data = drive;
+		motor_off_timer[drive].function = motor_off_callback;
+		if (!(allowed_drive_mask & (1 << drive)))
+			continue;
+		if (fdc_state[FDC(drive)].version == FDC_NONE)
+			continue;
+		/* to be cleaned up... */
+		disks[drive]->private_data = (void*)drive;
+		disks[drive]->queue = &floppy_queue;
+		add_disk(disks[drive]);
+	}
+
+	platform_device_register(&floppy_device);
+	return 0;
+
+out1:
+	del_timer(&fd_timeout);
+out2:
+	blk_unregister_region(MKDEV(MAJOR_NR, 0), 256);
+	unregister_blkdev(MAJOR_NR,"fd");
+	blk_cleanup_queue(&floppy_queue);
+out:
+	for (i=0; i<N_DRIVE; i++)
+		put_disk(disks[i]);
+	return err;
+
+Enomem:
+	while (i--)
+		put_disk(disks[i]);
+	return -ENOMEM;
+}
+
+static spinlock_t floppy_usage_lock = SPIN_LOCK_UNLOCKED;
+
+static int floppy_grab_irq_and_dma(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&floppy_usage_lock, flags);
+	if (usage_count++){
+		spin_unlock_irqrestore(&floppy_usage_lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&floppy_usage_lock, flags);
+	MOD_INC_USE_COUNT;
+	if (fd_request_irq()) {
+		DPRINT("Unable to grab IRQ%d for the floppy driver\n",
+			FLOPPY_IRQ);
+		MOD_DEC_USE_COUNT;
+		spin_lock_irqsave(&floppy_usage_lock, flags);
+		usage_count--;
+		spin_unlock_irqrestore(&floppy_usage_lock, flags);
+		return -1;
+	}
+	if (fd_request_dma()) {
+		DPRINT("Unable to grab DMA%d for the floppy driver\n",
+			FLOPPY_DMA);
+		fd_free_irq();
+		MOD_DEC_USE_COUNT;
+		spin_lock_irqsave(&floppy_usage_lock, flags);
+		usage_count--;
+		spin_unlock_irqrestore(&floppy_usage_lock, flags);
+		return -1;
+	}
+
+	for (fdc=0; fdc< N_FDC; fdc++){
+		if (FDCS->address != -1){
+			static char floppy[] = "floppy";
+			if (!request_region(FDCS->address, 1, floppy))
+				goto cleanup0;
+
+			if (!request_region(FDCS->address + 2, 1, floppy)) {
+				release_region(FDCS->address, 1);
+				goto cleanup0;
+			}
+
+			if (!request_region(FDCS->address + 4, 1, floppy)) {
+				release_region(FDCS->address, 1);
+				release_region(FDCS->address + 2, 1);
+				goto cleanup0;
+			}
+
+			if (fdc == 0) {  /* internal FDC */
+				if (request_region(0xbe, 1, "floppy mode change")) {
+					if (request_region(0x4be, 1, "floppy ex. mode change"))
+						continue;
+					else
+						DPRINT("Floppy io-port 0x4be in use\n");
+
+					release_region(0xbe, 1);
+				} else
+					DPRINT("Floppy io-port 0xbe in use\n");
+
+				release_region(FDCS->address, 1);
+				release_region(FDCS->address + 2, 1);
+				release_region(FDCS->address + 4, 1);
+			}
+
+			goto cleanup1;
+		}
+	}
+	for (fdc=0; fdc< N_FDC; fdc++){
+		if (FDCS->address != -1){
+			reset_fdc_info(1);
+			fd_outb(FDCS->dor, FD_MODE);
+		}
+	}
+	fdc = 0;
+	fd_outb((FDCS->dor & 8), FD_MODE);
+
+	for (fdc = 0; fdc < N_FDC; fdc++)
+		if (FDCS->address != -1)
+			fd_outb(FDCS->dor, FD_MODE);
+	/*
+	 *	The driver will try and free resources and relies on us
+	 *	to know if they were allocated or not.
+	 */
+	fdc = 0;
+	irqdma_allocated = 1;
+	return 0;
+
+cleanup0:
+	DPRINT("Floppy io-port 0x%04lx in use\n", FDCS->address);
+cleanup1:
+	fd_free_irq();
+	fd_free_dma();
+	while(--fdc >= 0) {
+		release_region(FDCS->address, 1);
+		release_region(FDCS->address + 2, 1);
+		release_region(FDCS->address + 4, 1);
+		if (fdc == 0) {
+			release_region(0x00be, 1);
+			release_region(0x04be, 1);
+		}
+	}
+	MOD_DEC_USE_COUNT;
+	spin_lock_irqsave(&floppy_usage_lock, flags);
+	usage_count--;
+	spin_unlock_irqrestore(&floppy_usage_lock, flags);
+	return -1;
+}
+
+static void floppy_release_irq_and_dma(void)
+{
+	int old_fdc;
+#ifdef FLOPPY_SANITY_CHECK
+	int drive;
+#endif
+	long tmpsize;
+	unsigned long tmpaddr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&floppy_usage_lock, flags);
+	if (--usage_count){
+		spin_unlock_irqrestore(&floppy_usage_lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&floppy_usage_lock, flags);
+	if(irqdma_allocated)
+	{
+		fd_disable_dma();
+		fd_free_dma();
+		fd_free_irq();
+		irqdma_allocated=0;
+	}
+	fd_outb(0, FD_MODE);
+	floppy_enable_hlt();
+
+	if (floppy_track_buffer && max_buffer_sectors) {
+		tmpsize = max_buffer_sectors*1024;
+		tmpaddr = (unsigned long)floppy_track_buffer;
+		floppy_track_buffer = NULL;
+		max_buffer_sectors = 0;
+		buffer_min = buffer_max = -1;
+		fd_dma_mem_free(tmpaddr, tmpsize);
+	}
+
+#ifdef FLOPPY_SANITY_CHECK
+	for (drive=0; drive < N_FDC * 4; drive++)
+		if (timer_pending(motor_off_timer + drive))
+			printk("motor off timer %d still active\n", drive);
+
+	if (timer_pending(&fd_timeout))
+		printk("floppy timer still active:%s\n", timeout_message);
+	if (timer_pending(&fd_timer))
+		printk("auxiliary floppy timer still active\n");
+	if (floppy_work.pending)
+		printk("work still pending\n");
+#endif
+	old_fdc = fdc;
+	for (fdc = 0; fdc < N_FDC; fdc++)
+		if (FDCS->address != -1) {
+			release_region(FDCS->address, 1);
+			release_region(FDCS->address + 2, 1);
+			release_region(FDCS->address + 4, 1);
+			if (fdc == 0) {
+				release_region(0xbe, 1);
+				release_region(0x4be, 1);
+			}
+		}
+	fdc = old_fdc;
+	MOD_DEC_USE_COUNT;
+}
+
+
+#ifdef MODULE
+
+char *floppy;
+
+static void __init parse_floppy_cfg_string(char *cfg)
+{
+	char *ptr;
+
+	while(*cfg) {
+		for(ptr = cfg;*cfg && *cfg != ' ' && *cfg != '\t'; cfg++);
+		if (*cfg) {
+			*cfg = '\0';
+			cfg++;
+		}
+		if (*ptr)
+			floppy_setup(ptr);
+	}
+}
+
+int init_module(void)
+{
+	printk(KERN_INFO "inserting floppy driver for " UTS_RELEASE "\n");
+		 
+	if (floppy)
+		parse_floppy_cfg_string(floppy);
+	return floppy_init();
+}
+
+void cleanup_module(void)
+{
+	int drive;
+		 
+	platform_device_unregister(&floppy_device);
+	devfs_unregister (devfs_handle);
+	blk_unregister_region(MKDEV(MAJOR_NR, 0), 256);
+	unregister_blkdev(MAJOR_NR, "fd");
+	for (drive = 0; drive < N_DRIVE; drive++) {
+		if ((allowed_drive_mask & (1 << drive)) &&
+		    fdc_state[FDC(drive)].version != FDC_NONE)
+			del_gendisk(disks[drive]);
+		put_disk(disks[drive]);
+	}
+
+	blk_cleanup_queue(&floppy_queue);
+	/* eject disk, if any */
+	fd_eject(0);
+}
+
+MODULE_PARM(floppy,"s");
+MODULE_PARM(FLOPPY_IRQ,"i");
+MODULE_PARM(FLOPPY_DMA,"i");
+MODULE_AUTHOR("Osamu Tomita");
+MODULE_SUPPORTED_DEVICE("fd");
+MODULE_LICENSE("GPL");
+
+#else
+
+__setup ("floppy=", floppy_setup);
+module_init(floppy_init)
+#endif
diff -urN linux/include/asm-i386/floppy.h linux98/include/asm-i386/floppy.h
--- linux/include/asm-i386/floppy.h	Sat Jul 21 04:52:19 2001
+++ linux98/include/asm-i386/floppy.h	Sun Aug 19 14:13:09 2001
@@ -11,6 +11,7 @@
  #define __ASM_I386_FLOPPY_H
   #include <linux/vmalloc.h>
+#include <linux/config.h>
    /*
@@ -282,9 +283,14 @@
  };
   +#ifdef CONFIG_PC9800
+static int FDC1 = 0x90;
+#else /* !CONFIG_PC9800 */
  static int FDC1 = 0x3f0;
+#endif /* CONFIG_PC9800 */
  static int FDC2 = -1;
  +#ifndef CONFIG_PC9800
  /*
   * Floppy types are stored in the rtc's CMOS RAM and so rtc_lock
   * is needed to prevent corrupted CMOS RAM in case "insmod floppy"
@@ -307,11 +313,16 @@
  	spin_unlock_irqrestore(&rtc_lock, flags);	\
  	val;						\
  })
+#endif /* !CONFIG_PC9800 */
   #define N_FDC 2
  #define N_DRIVE 8
  +#ifdef CONFIG_PC9800
+#define FLOPPY_MOTOR_MASK 0x08
+#else
  #define FLOPPY_MOTOR_MASK 0xf0
+#endif /* CONFIG_PC9800 */
   #define AUTO_DMA
  diff -urN linux/include/linux/fdreg.h linux98/include/linux/fdreg.h
--- linux/include/linux/fdreg.h	Mon Apr 22 17:32:02 1996
+++ linux98/include/linux/fdreg.h	Fri Aug 17 22:13:41 2001
@@ -6,10 +6,28 @@
   * Handbook", Sanches and Canton.
   */
  +#include <linux/config.h>
+
+#ifdef CONFIG_PC9800
+#define FDPATCHES
+#endif
+
  #ifdef FDPATCHES
   #define FD_IOPORT fdc_state[fdc].address
  +#ifdef CONFIG_PC9800
+
+/* Fd controller regs. S&C, about page 340 */
+#define FD_STATUS	(0 + FD_IOPORT )
+#define FD_DATA		(2 + FD_IOPORT )
+
+#define FD_MODE		(4 + FD_IOPORT )
+#define FD_MODE_CHANGE	0xbe
+#define FD_EMODE_CHANGE	0x4be
+
+#else /* !CONFIG_PC9800 */
+
  /* Fd controller regs. S&C, about page 340 */
  #define FD_STATUS	(4 + FD_IOPORT )
  #define FD_DATA		(5 + FD_IOPORT )
@@ -23,8 +41,14 @@
  /* Diskette Control Register (write)*/
  #define FD_DCR		(7 + FD_IOPORT )
  +#endif /* CONFIG_PC9800 */
+
  #else
  +#ifdef CONFIG_PC9800
+#error FDPATCHES must be defined for NEC PC-9800
+#endif
+
  #define FD_STATUS	0x3f4
  #define FD_DATA		0x3f5
  #define FD_DOR		0x3f2		/* Digital Output Register */
