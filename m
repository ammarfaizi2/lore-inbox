Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbSL0QGW>; Fri, 27 Dec 2002 11:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbSL0QGR>; Fri, 27 Dec 2002 11:06:17 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:340 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265058AbSL0QDk>; Fri, 27 Dec 2002 11:03:40 -0500
Date: Fri, 27 Dec 2002 17:11:10 +0100
Message-Id: <200212271611.gBRGBA5A008023@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k block local_irq*() updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert m68k block drivers to new local_irq*() framework:
  - Atari ACSI
  - Amiga floppy
  - Atari floppy
  - Macintosh IIfx/Quadra 900/Quadra 950 floppy

--- linux-2.5.53/drivers/block/acsi.c	Thu Oct 31 10:14:59 2002
+++ linux-m68k-2.5.53/drivers/block/acsi.c	Thu Nov  7 23:02:52 2002
@@ -496,8 +496,7 @@
 	acsi_delay_end(COMMAND_DELAY);
 	DISABLE_IRQ();
 
-	save_flags(flags);  
-	cli();
+	local_irq_save(flags);
 	/* Low on A1 */
 	dma_wd.dma_mode_status = 0x88 | rwflag;
 	MFPDELAY();
@@ -514,7 +513,7 @@
 	else
 		dma_wd.dma_hi = (unsigned char)paddr;
 	MFPDELAY();
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	/* send the command bytes except the last */
 	for( i = 0; i < 5; ++i ) {
--- linux-2.5.53/drivers/block/amiflop.c	Wed Nov  6 16:13:59 2002
+++ linux-m68k-2.5.53/drivers/block/amiflop.c	Thu Nov  7 23:03:15 2002
@@ -231,12 +231,11 @@
 	unsigned long flags;
 	int ticks;
 	if (ms > 0) {
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		while (ms_busy == 0)
 			sleep_on(&ms_wait);
 		ms_busy = 0;
-		restore_flags(flags);
+		local_irq_restore(flags);
 		ticks = MS_TICKS*ms-1;
 		ciaa.tblo=ticks%256;
 		ciaa.tbhi=ticks/256;
@@ -262,13 +261,12 @@
 #ifdef DEBUG
 	printk("get_fdc: drive %d  fdc_busy %d  fdc_nested %d\n",drive,fdc_busy,fdc_nested);
 #endif
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	while (!try_fdc(drive))
 		sleep_on(&fdc_wait);
 	fdc_busy = drive;
 	fdc_nested++;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static inline void rel_fdc(void)
@@ -324,8 +322,7 @@
 	}
 
 	get_fdc(drive);
-	save_flags (flags);
-	cli();
+	local_irq_save(flags);
 
 	selected = -1;
 
@@ -333,7 +330,7 @@
 	prb |= (SELMASK(0)|SELMASK(1)|SELMASK(2)|SELMASK(3));
 	ciab.prb = prb;
 
-	restore_flags (flags);
+	local_irq_restore (flags);
 	rel_fdc();
 
 }
@@ -1308,10 +1305,9 @@
 		rel_fdc();
 		return 0;
 	}
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	if (writepending != 2) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		(*unit[nr].dtype->write_fkt)(nr);
 		if (!raw_write(nr)) {
 			printk (KERN_NOTICE "floppy disk write protected "
@@ -1323,7 +1319,7 @@
 			sleep_on (&wait_fd_block);
 	}
 	else {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		ms_delay(2); /* 2 ms post_write delay */
 		post_write(nr);
 	}
@@ -1431,8 +1427,7 @@
 			 * setup a callback to write the track buffer
 			 * after a short (1 tick) delay.
 			 */
-			save_flags (flags);
-			cli();
+			local_irq_save(flags);
 
 			floppy->dirty = 1;
 		        /* reset the timer */
@@ -1440,7 +1435,7 @@
 			    
 			flush_track_timer[drive].expires = jiffies + 1;
 			add_timer (flush_track_timer + drive);
-			restore_flags (flags);
+			local_irq_restore(flags);
 			break;
 		}
 	}
@@ -1609,15 +1604,14 @@
 		}
 	}
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	fd_ref[drive]++;
 	fd_device[drive] = system;
 #ifdef MODULE
 	if (unit[drive].motor == 0)
 		MOD_INC_USE_COUNT;
 #endif
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if (old_dev != system)
 		invalidate_buffers(mk_kdev(MAJOR_NR, drive + (system << 2)));
--- linux-2.5.53/drivers/block/acsi_slm.c	Mon Nov 11 10:19:11 2002
+++ linux-m68k-2.5.53/drivers/block/acsi_slm.c	Mon Nov 11 11:13:19 2002
@@ -502,12 +502,11 @@
 	int			   did_wait = 0;
 #endif
 
-	save_flags(flags);
-	cli();
-	
+	local_irq_save(flags);
+
 	addr = get_dma_addr();
 	if ((d = SLMEndAddr - addr) > 0) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		
 		/* slice not yet finished, decide whether to start another timer or to
 		 * busy-wait */
@@ -525,7 +524,7 @@
 		do_gettimeofday( &start_tm );
 		did_wait = 1;
 #endif
-		cli();
+		local_irq_disable();
 		while( get_dma_addr() < SLMEndAddr )
 			barrier();
 	}
@@ -549,7 +548,7 @@
 	DMA_LONG_WRITE( SLM_DMA_AMOUNT, 0x112 );
 #endif
 	
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 #ifdef DEBUG
 	if (did_wait) {
@@ -586,10 +585,9 @@
 
 static void set_dma_addr( unsigned long paddr )
 
-{	unsigned long	flags;
-	
-	save_flags(flags);  
-	cli();
+{	unsigned long flags;
+
+	local_irq_save(flags);
 	dma_wd.dma_lo = (unsigned char)paddr;
 	paddr >>= 8;
 	MFPDELAY();
@@ -601,7 +599,7 @@
 	else
 		dma_wd.dma_hi = (unsigned char)paddr;
 	MFPDELAY();
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
--- linux-2.5.53/drivers/block/ataflop.c	Mon Nov 11 10:19:11 2002
+++ linux-m68k-2.5.53/drivers/block/ataflop.c	Mon Nov 11 13:05:00 2002
@@ -250,24 +250,24 @@
 #define FDC_READ(reg) ({			\
     /* unsigned long __flags; */		\
     unsigned short __val;			\
-    /* save_flags(__flags); cli(); */		\
+    /* local_irq_save(__flags); */		\
     dma_wd.dma_mode_status = 0x80 | (reg);	\
     udelay(25);					\
     __val = dma_wd.fdc_acces_seccount;		\
     MFPDELAY();					\
-    /* restore_flags(__flags); */		\
+    /* local_irq_restore(__flags); */		\
     __val & 0xff;				\
 })
 
 #define FDC_WRITE(reg,val)			\
     do {					\
 	/* unsigned long __flags; */		\
-	/* save_flags(__flags); cli(); */	\
+	/* local_irq_save(__flags); */		\
 	dma_wd.dma_mode_status = 0x80 | (reg);	\
 	udelay(25);				\
 	dma_wd.fdc_acces_seccount = (val);	\
 	MFPDELAY();				\
-        /* restore_flags(__flags); */		\
+        /* local_irq_restore(__flags); */	\
     } while(0)
 
 
@@ -436,14 +436,14 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli(); /* protect against various other ints mucking around with the PSG */
+	/* protect against various other ints mucking around with the PSG */
+	local_irq_save(flags);
   
 	sound_ym.rd_data_reg_sel = 14; /* Select PSG Port A */
 	sound_ym.wd_data = (side == 0) ? sound_ym.rd_data_reg_sel | 0x01 :
 	                                 sound_ym.rd_data_reg_sel & 0xfe;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -459,13 +459,13 @@
 	if (drive == SelectedDrive)
 	  return;
 
-	save_flags(flags);
-	cli(); /* protect against various other ints mucking around with the PSG */
+	/* protect against various other ints mucking around with the PSG */
+	local_irq_save(flags);
 	sound_ym.rd_data_reg_sel = 14; /* Select PSG Port A */
 	tmp = sound_ym.rd_data_reg_sel;
 	sound_ym.wd_data = (tmp | DSKDRVNONE) & ~(drive == 0 ? DSKDRV0 : DSKDRV1);
 	atari_dont_touch_floppy_select = 1;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	/* restore track register to saved value */
 	FDC_WRITE( FDCREG_TRACK, UD.track );
@@ -486,8 +486,8 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli(); /* protect against various other ints mucking around with the PSG */
+	/* protect against various other ints mucking around with the PSG */
+	local_irq_save(flags);
 	atari_dont_touch_floppy_select = 0;
 	sound_ym.rd_data_reg_sel=14;	/* Select PSG Port A */
 	sound_ym.wd_data = (sound_ym.rd_data_reg_sel |
@@ -495,7 +495,7 @@
 	/* On Falcon, the drive B select line is used on the printer port, so
 	 * leave it alone... */
 	SelectedDrive = -1;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -551,8 +551,8 @@
 	if (++drive > 1 || !UD.connected)
 		drive = 0;
 
-	save_flags(flags);
-	cli(); /* protect against various other ints mucking around with the PSG */
+	/* protect against various other ints mucking around with the PSG */
+	local_irq_save(flags);
 
 	if (!stdma_islocked()) {
 		sound_ym.rd_data_reg_sel = 14;
@@ -568,7 +568,7 @@
 			set_bit (drive, &changed_floppies);
 		}
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	start_check_change_timer();
 }
@@ -668,13 +668,12 @@
 	DPRINT(("do_format( dr=%d tr=%d he=%d offs=%d )\n",
 		drive, desc->track, desc->head, desc->sect_offset ));
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	while( fdc_busy ) sleep_on( &fdc_wait );
 	fdc_busy = 1;
 	stdma_lock(floppy_irq, NULL);
 	atari_turnon_irq( IRQ_MFP_FDC ); /* should be already, just to be sure */
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	type = minor(device) >> 2;
 	if (type) {
@@ -932,8 +931,7 @@
 	udelay(25);
   
 	/* Setup DMA */
-	save_flags(flags);  
-	cli();
+	local_irq_save(flags);
 	dma_wd.dma_lo = (unsigned char)paddr;
 	MFPDELAY();
 	paddr >>= 8;
@@ -945,7 +943,7 @@
 	else
 		dma_wd.dma_hi = (unsigned char)paddr;
 	MFPDELAY();
-	restore_flags(flags);
+	local_irq_restore(flags);
   
 	/* Clear FIFO and switch DMA to correct mode */  
 	dma_wd.dma_mode_status = 0x90 | rwflag;  
@@ -992,8 +990,7 @@
 {
 	unsigned long flags, addr, addr2;
 
-	save_flags(flags);  
-	cli();
+	local_irq_save(flags);
 
 	if (!MultReadInProgress) {
 		/* This prevents a race condition that could arise if the
@@ -1002,7 +999,7 @@
 		 * already cleared 'MultReadInProgress'  when flow of control
 		 * gets here.
 		 */
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 
@@ -1028,7 +1025,7 @@
 		 */
 		SET_IRQ_HANDLER( NULL );
 		MultReadInProgress = 0;
-		restore_flags(flags);
+		local_irq_restore(flags);
 		DPRINT(("fd_readtrack_check(): done\n"));
 		FDC_WRITE( FDCREG_CMD, FDCCMD_FORCI );
 		udelay(25);
@@ -1040,7 +1037,7 @@
 	}
 	else {
 		/* not yet finished, wait another tenth rotation */
-		restore_flags(flags);
+		local_irq_restore(flags);
 		DPRINT(("fd_readtrack_check(): not yet finished\n"));
 		mod_timer(&readtrack_timer, jiffies + HZ/5/10);
 	}
@@ -1201,8 +1198,7 @@
 	udelay(40);
   
 	/* Setup DMA */
-	save_flags(flags);  
-	cli();
+	local_irq_save(flags);
 	dma_wd.dma_lo = (unsigned char)paddr;
 	MFPDELAY();
 	paddr >>= 8;
@@ -1214,7 +1210,7 @@
 	else
 		dma_wd.dma_hi = (unsigned char)paddr;
 	MFPDELAY();
-	restore_flags(flags);
+	local_irq_restore(flags);
   
 	/* Clear FIFO and switch DMA to correct mode */  
 	dma_wd.dma_mode_status = 0x190;  
@@ -1327,12 +1323,11 @@
 		start_check_change_timer();
 	start_motor_off_timer();
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	stdma_release();
 	fdc_busy = 0;
 	wake_up( &fdc_wait );
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	DPRINT(("finish_fdc() finished\n"));
 }
@@ -1521,10 +1516,10 @@
 	stdma_lock(floppy_irq, NULL);
 
 	atari_disable_irq( IRQ_MFP_FDC );
-	save_flags(flags);	/* The request function is called with ints
-	sti();				 * disabled... so must save the IPL for later */ 
+	local_save_flags(flags);	/* The request function is called with ints
+	local_irq_disable();		 * disabled... so must save the IPL for later */ 
 	redo_fd_request();
-	restore_flags(flags);
+	local_irq_restore(flags);
 	atari_enable_irq( IRQ_MFP_FDC );
 }
 
--- linux-2.5.53/drivers/block/swim_iop.c	Mon Nov 11 10:19:12 2002
+++ linux-m68k-2.5.53/drivers/block/swim_iop.c	Mon Nov 11 11:13:21 2002
@@ -212,17 +212,16 @@
 
 static int swimiop_send_request(struct swim_iop_req *req)
 {
-	unsigned long cpu_flags;
+	unsigned long flags;
 	int err;
 
 	/* It's doubtful an interrupt routine would try to send */
 	/* a SWIM request, but I'd rather play it safe here.    */
 
-	save_flags(cpu_flags);
-	cli();
+	local_irq_save(flags);
 
 	if (current_req != NULL) {
-		restore_flags(cpu_flags);
+		local_irq_restore(flags);
 		return -ENOMEM;
 	}
 
@@ -230,7 +229,7 @@
 
 	/* Interrupts should be back on for iop_send_message() */
 
-	restore_flags(cpu_flags);
+	local_irq_restore(flags);
 
 	err = iop_send_message(SWIM_IOP, SWIM_CHAN, (void *) req,
 				sizeof(req->command), (__u8 *) &req->command[0],
@@ -426,14 +425,13 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	if (fs->state != idle) {
 		++fs->wanted;
 		while (fs->state != available) {
 			if (interruptible && signal_pending(current)) {
 				--fs->wanted;
-				restore_flags(flags);
+				local_irq_restore(flags);
 				return -EINTR;
 			}
 			interruptible_sleep_on(&fs->wait);
@@ -441,7 +439,7 @@
 		--fs->wanted;
 	}
 	fs->state = state;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -449,11 +447,10 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	fs->state = idle;
 	start_request(fs);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void set_timeout(struct floppy_state *fs, int nticks,
@@ -461,7 +458,7 @@
 {
 	unsigned long flags;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (fs->timeout_pending)
 		del_timer(&fs->timeout);
 	init_timer(&fs->timeout);
@@ -470,7 +467,7 @@
 	fs->timeout.data = (unsigned long) fs;
 	add_timer(&fs->timeout);
 	fs->timeout_pending = 1;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void do_fd_request(request_queue_t * q)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
