Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVFTWGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVFTWGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVFTWGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:06:41 -0400
Received: from coderock.org ([193.77.147.115]:7320 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261705AbVFTVu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:50:59 -0400
Message-Id: <20050620214917.410427000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:49:17 +0200
From: domen@coderock.org
To: spyro@f2s.com
Cc: linux-kernel@vger.kernel.org, James Nelson <james4765@gmail.com>,
       domen@coderock.org
Subject: [patch 3/3] acorn: clean up printk()s in drivers/acorn/block/mfmhd.c
Content-Disposition: inline; filename=printk-drivers_acorn_block_mfmhd.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Nelson <james4765@cwazy.co.uk>


This patch puts KERN_ constants in printk()'s and makes the debugging printk()'s
more consistent in drivers/acorn/block/mfmhd.c

Signed-off-by: James Nelson <james4765@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 mfmhd.c |  151 +++++++++++++++++++++++++++-------------------------------------
 1 files changed, 66 insertions(+), 85 deletions(-)

Index: quilt/drivers/acorn/block/mfmhd.c
===================================================================
--- quilt.orig/drivers/acorn/block/mfmhd.c
+++ quilt/drivers/acorn/block/mfmhd.c
@@ -98,6 +98,8 @@
  *  This would be a performance boost with dual drive systems.
  */
 
+#undef DEBUG /* define to enable debugging statements */
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/sched.h>
@@ -126,6 +128,7 @@ static void (*do_mfm)(void) = NULL;
 static struct request_queue *mfm_queue;
 static DEFINE_SPINLOCK(mfm_lock);
 
+#define PFX "mfm: "
 #define MAJOR_NR	MFM_ACORN_MAJOR
 #define QUEUE (mfm_queue)
 #define CURRENT elv_next_request(mfm_queue)
@@ -153,12 +156,7 @@ struct hd_geometry {
  * Linux I/O address of onboard MFM controller or 0 to disable this
  */
 #define ONBOARD_MFM_ADDRESS ((0x002d0000 >> 2) | 0x80000000)
-/*
- * Uncomment this to enable debugging in the MFM driver...
- */
-#ifndef DEBUG
-/*#define DEBUG */
-#endif
+
 /*
  * End of configuration
  */
@@ -300,28 +298,8 @@ int number_mfm_drives = 1;
 #define STAT_POL	0x0200	/* Polling */
 
 /* ------------------------------------------------------------------------------------------ */
-#ifdef DEBUG
-static void console_printf(const char *fmt,...)
-{
-	static char buffer[2048];	/* Arbitary! */
-	extern void console_print(const char *);
-	unsigned long flags;
-	va_list ap;
-
-	local_irq_save(flags);
-
-	va_start(ap, fmt);
-	vsprintf(buffer, fmt, ap);
-	console_print(buffer);
-	va_end(fmt);
 
-	local_irq_restore(flags);
-};	/* console_printf */
-
-#define DBG(x...) console_printf(x)
-#else
-#define DBG(x...)
-#endif
+#define DBG(fmt, args...) pr_debug(PFX "%s(): " fmt, __FUNCTION__ , ## args)
 
 static void print_status(void)
 {
@@ -377,23 +355,23 @@ static void issue_command(int command, u
 	int status;
 #ifdef DEBUG
 	int i;
-	console_printf("issue_command: %02X: ", command);
+	DBG("%02X:", command);
 	for (i = 0; i < len; i++)
-		console_printf("%02X ", cmdb[i]);
-	console_printf("\n");
+		printk(" %02X", cmdb[i]);
+	printk("\n");
 #endif
 
 	do {
 		status = inw(MFM_STATUS);
 	} while (status & (STAT_BSY | STAT_POL));
-	DBG("issue_command: status after pol/bsy loop: %02X:\n ", status >> 8);
+	DBG("status after pol/bsy loop: %02X:\n", status >> 8);
 
 	if (status & (STAT_CPR | STAT_CED | STAT_SED | STAT_DER | STAT_ABN)) {
 		outw(CMD_RCAL, MFM_COMMAND);
 		while (inw(MFM_STATUS) & STAT_BSY);
 	}
 	status = inw(MFM_STATUS);
-	DBG("issue_command: status before parameter issue: %02X:\n ", status >> 8);
+	DBG("status before parameter issue: %02X:\n", status >> 8);
 
 	while (len > 0) {
 		outw(cmdb[1] | (cmdb[0] << 8), MFM_DATAOUT);
@@ -401,11 +379,11 @@ static void issue_command(int command, u
 		cmdb += 2;
 	}
 	status = inw(MFM_STATUS);
-	DBG("issue_command: status before command issue: %02X:\n ", status >> 8);
+	DBG("status before command issue: %02X:\n", status >> 8);
 
 	outw(command, MFM_COMMAND);
 	status = inw(MFM_STATUS);
-	DBG("issue_command: status immediately after command issue: %02X:\n ", status >> 8);
+	DBG("status immediately after command issue: %02X:\n", status >> 8);
 }
 
 static void wait_for_completion(void)
@@ -434,7 +412,7 @@ static void mfm_rw_intr(void)
 {
 	int old_status;		/* Holds status on entry, we read to see if the command just finished */
 #ifdef DEBUG
-	console_printf("mfm_rw_intr...dataleft=%d\n", hdc63463_dataleft);
+	DBG("dataleft=%d ", hdc63463_dataleft);
 	print_status();
 #endif
 
@@ -443,7 +421,7 @@ static void mfm_rw_intr(void)
 		/* Something has gone wrong - let's try that again */
 		outw(CMD_RCAL, MFM_COMMAND);	/* Clear interrupt condition */
 		if (cont) {
-			DBG("mfm_rw_intr: DER/ABN err\n");
+			DBG("DER/ABN err\n");
 			cont->error();
 			cont->redo();
 		};
@@ -457,7 +435,7 @@ static void mfm_rw_intr(void)
 	if (CURRENT->cmd == WRITE) {
 		extern void hdc63463_writedma(void);
 		if ((hdc63463_dataleft <= 0) && (!(mfm_status & STAT_CED))) {
-			printk("mfm_rw_intr: Apparent DMA write request when no more to DMA\n");
+			printk(KERN_WARNING PFX "mfm_rw_intr: Apparent DMA write request when no more to DMA\n");
 			if (cont) {
 				cont->error();
 				cont->redo();
@@ -468,7 +446,7 @@ static void mfm_rw_intr(void)
 	} else {
 		extern void hdc63463_readdma(void);
 		if ((hdc63463_dataleft <= 0) && (!(mfm_status & STAT_CED))) {
-			printk("mfm_rw_intr: Apparent DMA read request when no more to DMA\n");
+			printk(KERN_WARNING PFX "mfm_rw_intr: Apparent DMA read request when no more to DMA\n");
 			if (cont) {
 				cont->error();
 				cont->redo();
@@ -482,7 +460,7 @@ static void mfm_rw_intr(void)
 	if (hdc63463_dataptr != ((unsigned int) Copy_buffer + 256)) {
 		/* If we didn't actually manage to get any data on this interrupt - but why? We got the interrupt */
 		/* Ah - well looking at the status its just when we get command end; so no problem */
-		/*console_printf("mfm: dataptr mismatch. dataptr=0x%08x Copy_buffer+256=0x%08p\n",
+		/*DBG("dataptr mismatch. dataptr=0x%08x Copy_buffer+256=0x%08p ",
 		   hdc63463_dataptr,Copy_buffer+256);
 		   print_status(); */
 	} else {
@@ -492,7 +470,7 @@ static void mfm_rw_intr(void)
 
 		/* We have come to the end of this request */
 		if (!Sectors256LeftInCurrent) {
-			DBG("mfm: end_request for CURRENT=0x%p CURRENT(sector=%d current_nr_sectors=%d nr_sectors=%d)\n",
+			DBG("end_request for CURRENT=0x%p CURRENT(sector=%d current_nr_sectors=%d nr_sectors=%d)\n",
 				       CURRENT, CURRENT->sector, CURRENT->current_nr_sectors, CURRENT->nr_sectors);
 
 			CURRENT->nr_sectors -= CURRENT->current_nr_sectors;
@@ -511,10 +489,10 @@ static void mfm_rw_intr(void)
 
 				if (Copy_Sector != CURRENT->sector * 2)
 #ifdef DEBUG
-					/*console_printf*/printk("mfm: Copy_Sector mismatch. Copy_Sector=%d CURRENT->sector*2=%d\n",
+					DBG("Copy_Sector mismatch. Copy_Sector=%d CURRENT->sector*2=%d\n",
 					Copy_Sector, CURRENT->sector * 2);
 #else
-					printk("mfm: Copy_Sector mismatch! Eek!\n");
+					printk(KERN_ERR PFX "Copy_Sector mismatch! Eek!\n");
 #endif
 			};	/* CURRENT */
 		};	/* Sectors256LeftInCurrent */
@@ -525,7 +503,7 @@ static void mfm_rw_intr(void)
 	if (mfm_status & (STAT_DER | STAT_ABN)) {
 		/* Something has gone wrong - let's try that again */
 		if (cont) {
-			DBG("mfm_rw_intr: DER/ABN error\n");
+			DBG("DER/ABN error\n");
 			cont->error();
 			cont->redo();
 		};
@@ -547,7 +525,7 @@ static void mfm_rw_intr(void)
 		};
 	};			/* Result read */
 
-	/*console_printf ("mfm_rw_intr nearexit [%02X]\n", __raw_readb(mfm_IRQPollLoc)); */
+	/*DBG("nearexit [%02X]\n", __raw_readb(mfm_IRQPollLoc)); */
 
 	/* If end of command move on */
 	if (mfm_status & (STAT_CED)) {
@@ -556,7 +534,7 @@ static void mfm_rw_intr(void)
 		if (cont) {
 			cont->done(1);
 		}
-		DBG("mfm_rw_intr: returned from cont->done\n");
+		DBG("returned from cont->done\n");
 	} else {
 		/* Its going to generate another interrupt */
 		do_mfm = mfm_rw_intr;
@@ -565,7 +543,7 @@ static void mfm_rw_intr(void)
 
 static void mfm_setup_rw(void)
 {
-	DBG("setting up for rw...\n");
+	DBG("start\n");
 
 	do_mfm = mfm_rw_intr;
 	issue_command(raw_cmd.cmdcode, raw_cmd.cmddata, raw_cmd.cmdlen);
@@ -574,12 +552,12 @@ static void mfm_setup_rw(void)
 static void mfm_recal_intr(void)
 {
 #ifdef DEBUG
-	console_printf("recal intr - status = ");
+	DBG("status = ");
 	print_status();
 #endif
 	outw(CMD_RCAL, MFM_COMMAND);	/* Clear interrupt condition */
 	if (mfm_status & (STAT_DER | STAT_ABN)) {
-		printk("recal failed\n");
+		printk(KERN_ERR PFX "recal failed\n");
 		MFM_DRV_INFO.cylinder = NEED_2_RECAL;
 		if (cont) {
 			cont->error();
@@ -601,18 +579,18 @@ static void mfm_recal_intr(void)
 		issue_command(CMD_POL, NULL, 0);
 		return;
 	}
-	printk("recal: unknown status\n");
+	printk(KERN_ERR PFX "recal: unknown status\n");
 }
 
 static void mfm_seek_intr(void)
 {
 #ifdef DEBUG
-	console_printf("seek intr - status = ");
+	DBG("status = ");
 	print_status();
 #endif
 	outw(CMD_RCAL, MFM_COMMAND);	/* Clear interrupt condition */
 	if (mfm_status & (STAT_DER | STAT_ABN)) {
-		printk("seek failed\n");
+		printk(KERN_ERR PFX "seek failed\n");
 		MFM_DRV_INFO.cylinder = NEED_2_RECAL;
 		if (cont) {
 			cont->error();
@@ -631,7 +609,7 @@ static void mfm_seek_intr(void)
 		issue_command(CMD_POL, NULL, 0);
 		return;
 	}
-	printk("seek: unknown status\n");
+	printk(KERN_ERR PFX "seek: unknown status\n");
 }
 
 /* IDEA2 seems to work better - its what RiscOS sets my
@@ -686,7 +664,7 @@ static void mfm_seek(void)
 	DBG("seeking...\n");
 	if (MFM_DRV_INFO.cylinder < 0) {
 		do_mfm = mfm_recal_intr;
-		DBG("mfm_seek: about to call specify\n");
+		DBG("about to call specify\n");
 		mfm_specify ();	/* DAG added this */
 
 		cmdb[0] = raw_cmd.dev + 1;
@@ -709,19 +687,20 @@ static void mfm_seek(void)
 
 static void mfm_initialise(void)
 {
-	DBG("init...\n");
+	DBG("start\n");
 	mfm_seek();
 }
 
 static void request_done(int uptodate)
 {
-	DBG("mfm:request_done\n");
+	DBG("start\n");
 	if (uptodate) {
 		unsigned char block[2] = {0, 0};
 
 		/* Apparently worked - let's check bytes left to DMA */
 		if (hdc63463_dataleft != (PartFragRead_SectorsLeft * 256)) {
-			printk("mfm: request_done - dataleft=%d - should be %d - Eek!\n", hdc63463_dataleft, PartFragRead_SectorsLeft * 256);
+			printk(KERN_ERR PFX "request_done - dataleft=%d - should be %d - Eek!\n",
+				hdc63463_dataleft, PartFragRead_SectorsLeft * 256);
 			end_request(CURRENT, 0);
 			Busy = 0;
 		};
@@ -740,7 +719,8 @@ static void request_done(int uptodate)
 		/* ah well - perhaps there is another fragment to go */
 
 		/* Increment pointers/counts to start of next fragment */
-		if (SectorsLeftInRequest > 0) printk("mfm: SectorsLeftInRequest>0 - Eek! Shouldn't happen!\n");
+		if (SectorsLeftInRequest > 0)
+			printk(KERN_CRIT PFX "SectorsLeftInRequest > 0 - Eek! Shouldn't happen!\n");
 
 		/* No - its the end of the line */
 		/* end_request's should have happened at the end of sector DMAs */
@@ -749,12 +729,12 @@ static void request_done(int uptodate)
 			issue_command(CMD_CKV, block, 2);
 
 		Busy = 0;
-		DBG("request_done: About to mfm_request\n");
+		DBG("About to mfm_request\n");
 		/* Next one please */
 		mfm_request();	/* Moved from mfm_rw_intr */
-		DBG("request_done: returned from mfm_request\n");
+		DBG("returned from mfm_request\n");
 	} else {
-		printk("mfm:request_done: update=0\n");
+		DBG("update=0\n");
 		end_request(CURRENT, 0);
 		Busy = 0;
 	}
@@ -762,7 +742,7 @@ static void request_done(int uptodate)
 
 static void error_handler(void)
 {
-	printk("error detected... status = ");
+	printk(KERN_ERR PFX "error detected... status = ");
 	print_status();
 	(*errors)++;
 	if (*errors > MFM_DRV_INFO.errors.abort)
@@ -773,7 +753,7 @@ static void error_handler(void)
 
 static void rw_interrupt(void)
 {
-	printk("rw_interrupt\n");
+	DBG("start\n");
 }
 
 static struct cont rw_cont =
@@ -807,7 +787,7 @@ static void issue_request(unsigned int b
 	/* Then add in the number of sectors left on this track */
 	sectors_to_next_cyl += (p->sectors - start_sector);
 
-	DBG("issue_request: mfm_info[dev].sectors=%d track=%d\n", p->sectors, track);
+	DBG("mfm_info[dev].sectors=%d track=%d\n", p->sectors, track);
 
 	raw_cmd.dev = dev;
 	raw_cmd.sector = start_sector;
@@ -869,7 +849,7 @@ static void issue_request(unsigned int b
  */
 static void mfm_rerequest(void)
 {
-	DBG("mfm_rerequest\n");
+	DBG("start\n");
 	cli();
 	Busy = 0;
 	mfm_request();
@@ -879,12 +859,12 @@ static struct gendisk *mfm_gendisk[2];
 
 static void mfm_request(void)
 {
-	DBG("mfm_request CURRENT=%p Busy=%d\n", CURRENT, Busy);
+	DBG("CURRENT=%p Busy=%d\n", CURRENT, Busy);
 
 	/* If we are still processing then return; we will get called again */
 	if (Busy) {
 		/* Again seems to be common in 1.3.45 */
-		/*DBG*/printk("mfm_request: Exiting due to busy\n");
+		DBG("Exiting due to busy\n");
 		return;
 	}
 	Busy = 1;
@@ -893,28 +873,28 @@ static void mfm_request(void)
 		unsigned int block, nsect;
 		struct gendisk *disk;
 
-		DBG("mfm_request: loop start\n");
+		DBG("loop start\n");
 		sti();
 
-		DBG("mfm_request: before !CURRENT\n");
+		DBG("before !CURRENT\n");
 
 		if (!CURRENT) {
-			printk("mfm_request: Exiting due to empty queue (pre)\n");
+			DBG("Exiting due to empty queue (pre)\n");
 			do_mfm = NULL;
 			Busy = 0;
 			return;
 		}
 
-		DBG("mfm_request:                 before arg extraction\n");
+		DBG("before arg extraction\n");
 
 		disk = CURRENT->rq_disk;
 		block = CURRENT->sector;
 		nsect = CURRENT->nr_sectors;
 		if (block >= get_capacity(disk) ||
 		    block+nsect > get_capacity(disk)) {
-			printk("%s: bad access: block=%d, count=%d, nr_sects=%ld\n",
+			printk(KERN_ERR "%s: bad access: block=%d, count=%d, nr_sects=%ld\n",
 			       disk->disk_name, block, nsect, get_capacity(disk));
-			printk("mfm: continue 1\n");
+			DBG("continue 1\n");
 			end_request(CURRENT, 0);
 			Busy = 0;
 			continue;
@@ -930,25 +910,25 @@ static void mfm_request(void)
 		Copy_buffer = CURRENT->buffer;
 		Copy_Sector = CURRENT->sector << 1;
 
-		DBG("mfm_request: block after offset=%d\n", block);
+		DBG("block after offset=%d\n", block);
 
 		if (CURRENT->cmd != READ && CURRENT->cmd != WRITE) {
-			printk("unknown mfm-command %d\n", CURRENT->cmd);
+			printk(KERN_ERR "unknown mfm-command %d\n", CURRENT->cmd);
 			end_request(CURRENT, 0);
 			Busy = 0;
-			printk("mfm: continue 4\n");
+			DBG("continue 4\n");
 			continue;
 		}
 		issue_request(block, nsect, CURRENT);
 
 		break;
 	}
-	DBG("mfm_request: Dropping out bottom\n");
+	DBG("Dropping out bottom\n");
 }
 
 static void do_mfm_request(request_queue_t *q)
 {
-	DBG("do_mfm_request: about to mfm_request\n");
+	DBG("about to mfm_request\n");
 	mfm_request();
 }
 
@@ -958,7 +938,7 @@ static void mfm_interrupt_handler(int un
 
 	do_mfm = NULL;
 
-	DBG("mfm_interrupt_handler (handler=0x%p)\n", handler);
+	DBG("(handler=0x%p)\n", handler);
 
 	mfm_status = inw(MFM_STATUS);
 
@@ -978,7 +958,7 @@ static void mfm_interrupt_handler(int un
 		return;
 	}
 	outw (CMD_RCAL, MFM_COMMAND);	/* Clear interrupt condition */
-	printk ("mfm: unexpected interrupt - status = ");
+	printk (KERN_WARNING PFX "unexpected interrupt - status = ");
 	print_status ();
 	while (1);
 }
@@ -996,7 +976,7 @@ static void mfm_geometry(int drive)
 	struct gendisk *disk = mfm_gendisk[drive];
 	disk->private_data = p;
 	if (p->cylinders)
-		printk ("%s: %dMB CHS=%d/%d/%d LCC=%d RECOMP=%d\n",
+		pr_info ("%s: %dMB CHS=%d/%d/%d LCC=%d RECOMP=%d\n",
 			disk->disk_name,
 			p->cylinders * p->heads * p->sectors / 4096,
 			p->cylinders, p->heads, p->sectors,
@@ -1108,7 +1088,8 @@ static int mfm_initdrives(void)
 
 	if (number_mfm_drives > MFM_MAXDRIVES) {
 		number_mfm_drives = MFM_MAXDRIVES;
-		printk("No. of ADFS MFM drives is greater than MFM_MAXDRIVES - you can't have that many!\n");
+		printk(KERN_WARNING "No. of ADFS MFM drives is greater than "
+			"MFM_MAXDRIVES - you can't have that many!\n");
 	}
 
 	for (drive = 0; drive < number_mfm_drives; drive++) {
@@ -1199,7 +1180,7 @@ void xd_set_geometry(struct block_device
 		p->cylinders = discsize / (secsptrack * heads * secsize);
 
 		if ((heads < 1) || (p->cylinders > 1024)) {
-			printk("%s: Insane disc shape! Setting to 512/4/32\n",
+			printk(KERN_WARNING "%s: Insane disc shape! Setting to 512/4/32\n",
 				bdev->bd_disk->disk_name);
 
 			/* These values are fairly arbitary, but are there so that if your
@@ -1260,7 +1241,7 @@ static int mfm_do_init(unsigned char irq
 {
 	int i, ret;
 
-	printk("mfm: found at address %08X, interrupt %d\n", mfm_addr, mfm_irq);
+	pr_info(PFX "controller found at address %08X, interrupt %d\n", mfm_addr, mfm_irq);
 
 	ret = -EBUSY;
 	if (!request_region (mfm_addr, 10, "mfm"))
@@ -1299,11 +1280,11 @@ static int mfm_do_init(unsigned char irq
 		mfm_gendisk[i] = disk;
 	}
 
-	printk("mfm: detected %d hard drive%s\n", mfm_drives,
+	pr_info(PFX "detected %d hard drive%s\n", mfm_drives,
 				mfm_drives == 1 ? "" : "s");
 	ret = request_irq(mfm_irq, mfm_interrupt_handler, SA_INTERRUPT, "MFM harddisk", NULL);
 	if (ret) {
-		printk("mfm: unable to get IRQ%d\n", mfm_irq);
+		printk(KERN_ERR PFX "unable to get IRQ%d\n", mfm_irq);
 		goto out4;
 	}
 

--
