Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSE3POB>; Thu, 30 May 2002 11:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316686AbSE3POB>; Thu, 30 May 2002 11:14:01 -0400
Received: from [195.63.194.11] ([195.63.194.11]:44303 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316683AbSE3PNr>; Thu, 30 May 2002 11:13:47 -0400
Message-ID: <3CF633FD.6060800@evision-ventures.com>
Date: Thu, 30 May 2002 16:15:25 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.19 blk.h and more about the ugly kids.
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------040708040905020403060500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708040905020403060500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Remove DEVICE_INTR and associated code from floppy driver.

- Savlage s390 xpram code from kernel version dependant compilation disease.

- Eliminate SET_INTR code from the places where it was used.

- Eliminate bogous support for multiple sbpcd controllers. The driver didn't
   even compile right now before we could think about further supporting it at
   all we have to get rid of this hack first.
   Don't call invalidate_buffers in the release method there.
   Why should it be necessary?

- Resurrect sonycd535 compilation.

- Let CURRENT request macro use the same primitive at the remaining QUEUE macro
   in blk.h, which is still not quite right, but first things first :-).

--------------040708040905020403060500
Content-Type: text/plain;
 name="blk-2.5.19.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-2.5.19.diff"

diff -urN linux-2.5.19/drivers/acorn/block/mfmhd.c linux/drivers/acorn/block/mfmhd.c
--- linux-2.5.19/drivers/acorn/block/mfmhd.c	2002-05-29 20:42:49.000000000 +0200
+++ linux/drivers/acorn/block/mfmhd.c	2002-05-30 13:46:49.000000000 +0200
@@ -570,7 +570,7 @@
 		DBG("mfm_rw_intr: returned from cont->done\n");
 	} else {
 		/* Its going to generate another interrupt */
-		SET_INTR(mfm_rw_intr);
+		DEVICE_INTR = mfm_rw_intr;
 	};
 }
 
@@ -578,7 +578,7 @@
 {
 	DBG("setting up for rw...\n");
 
-	SET_INTR(mfm_rw_intr);
+	DEVICE_INTR = mfm_rw_intr;
 	issue_command(raw_cmd.cmdcode, raw_cmd.cmddata, raw_cmd.cmdlen);
 }
 
@@ -608,7 +608,7 @@
 	/* Command end without seek end (see data sheet p.20) for parallel seek
 	   - we have to send a POL command to wait for the seek */
 	if (mfm_status & STAT_CED) {
-		SET_INTR(mfm_recal_intr);
+		DEVICE_INTR = mfm_recal_intr;
 		issue_command(CMD_POL, NULL, 0);
 		return;
 	}
@@ -638,7 +638,7 @@
 		return;
 	}
 	if (mfm_status & STAT_CED) {
-		SET_INTR(mfm_seek_intr);
+		DEVICE_INTR = mfm_seek_intr;
 		issue_command(CMD_POL, NULL, 0);
 		return;
 	}
@@ -696,7 +696,7 @@
 
 	DBG("seeking...\n");
 	if (MFM_DRV_INFO.cylinder < 0) {
-		SET_INTR(mfm_recal_intr);
+		DEVICE_INTR = mfm_recal_intr;
 		DBG("mfm_seek: about to call specify\n");
 		mfm_specify ();	/* DAG added this */
 
@@ -712,7 +712,7 @@
 		cmdb[2] = raw_cmd.cylinder >> 8;
 		cmdb[3] = raw_cmd.cylinder;
 
-		SET_INTR(mfm_seek_intr);
+		DEVICE_INTR = mfm_seek_intr;
 		issue_command(CMD_SEK, cmdb, 4);
 	} else
 		mfm_setup_rw();
@@ -907,7 +907,7 @@
 
 		if (blk_queue_empty(QUEUE)) {
 			printk("mfm_request: Exiting due to empty queue (pre)\n");
-			CLEAR_INTR;
+			DEVICE_INTR = NULL;
 			Busy = 0;
 			return;
 		}
@@ -971,7 +971,7 @@
 {
 	void (*handler) (void) = DEVICE_INTR;
 
-	CLEAR_INTR;
+	DEVICE_INTR = NULL;
 
 	DBG("mfm_interrupt_handler (handler=0x%p)\n", handler);
 
diff -urN linux-2.5.19/drivers/block/acsi.c linux/drivers/block/acsi.c
--- linux-2.5.19/drivers/block/acsi.c	2002-05-29 20:42:54.000000000 +0200
+++ linux/drivers/block/acsi.c	2002-05-30 13:44:06.000000000 +0200
@@ -1041,7 +1041,7 @@
 	}
 	CurrentBuffer = buffer;
 	CurrentNSect  = nsect;
-	
+
 	if (CURRENT->cmd == WRITE) {
 		CMDSET_TARG_LUN( write_cmd, target, lun );
 		CMDSET_BLOCK( write_cmd, block );
@@ -1049,7 +1049,7 @@
 		if (buffer == acsi_buffer)
 			copy_to_acsibuffer();
 		dma_cache_maintenance( pbuffer, nsect*512, 1 );
-		SET_INTR(write_intr);
+		DEVICE_INTR = write_intr;
 		if (!acsicmd_dma( write_cmd, buffer, nsect, 1, 1)) {
 			CLEAR_INTR;
 			printk( KERN_ERR "ACSI (write): Timeout in command block\n" );
@@ -1063,7 +1063,7 @@
 		CMDSET_TARG_LUN( read_cmd, target, lun );
 		CMDSET_BLOCK( read_cmd, block );
 		CMDSET_LEN( read_cmd, nsect );
-		SET_INTR(read_intr);
+		DEVICE_INTR = read_intr;
 		if (!acsicmd_dma( read_cmd, buffer, nsect, 0, 1)) {
 			CLEAR_INTR;
 			printk( KERN_ERR "ACSI (read): Timeout in command block\n" );
diff -urN linux-2.5.19/drivers/block/floppy.c linux/drivers/block/floppy.c
--- linux-2.5.19/drivers/block/floppy.c	2002-05-29 20:42:47.000000000 +0200
+++ linux/drivers/block/floppy.c	2002-05-30 13:45:57.000000000 +0200
@@ -633,6 +633,8 @@
 }
 #endif
 
+static void (*do_floppy)(void) = NULL;
+
 #ifdef FLOPPY_SANITY_CHECK
 
 #define OLOGSIZE 20
@@ -920,9 +922,9 @@
 	if (!fdc_busy)
 		DPRINT("FDC access conflict!\n");
 
-	if (DEVICE_INTR)
+	if (do_floppy)
 		DPRINT("device interrupt still active at FDC release: %p!\n",
-			DEVICE_INTR);
+			do_floppy);
 	command_status = FD_COMMAND_NONE;
 	del_timer(&fd_timeout);
 	cont = NULL;
@@ -1005,7 +1007,7 @@
 
 static void cancel_activity(void)
 {
-	CLEAR_INTR;
+	do_floppy = NULL;
 	floppy_tq.routine = (void *)(void *) empty;
 	del_timer(&fd_timer);
 }
@@ -1524,7 +1526,7 @@
 		setup_DMA();
 
 	if (flags & FD_RAW_INTR)
-		SET_INTR(main_command_interrupt);
+		do_floppy = main_command_interrupt;
 
 	r=0;
 	for (i=0; i< raw_cmd->cmd_count; i++)
@@ -1656,7 +1658,7 @@
 		}
 	}
 
-	SET_INTR(seek_interrupt);
+	do_floppy = seek_interrupt;
 	output_byte(FD_SEEK);
 	output_byte(UNIT(current_drive));
 	LAST_OUT(track);
@@ -1736,7 +1738,7 @@
 /* interrupt handler. Note that this can be called externally on the Sparc */
 void floppy_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
-	void (*handler)(void) = DEVICE_INTR;
+	void (*handler)(void) = do_floppy;
 	int do_print;
 	unsigned long f;
 
@@ -1746,9 +1748,9 @@
 	f=claim_dma_lock();
 	fd_disable_dma();
 	release_dma_lock(f);
-	
+
 	floppy_enable_hlt();
-	CLEAR_INTR;
+	do_floppy = NULL;
 	if (fdc >= N_FDC || FDCS->address == -1){
 		/* we don't even know which FDC is the culprit */
 		printk("DOR0=%x\n", fdc_state[0].dor);
@@ -1795,7 +1797,7 @@
 #ifdef DEBUGT
 	debugt("recalibrate floppy:");
 #endif
-	SET_INTR(recal_interrupt);
+	do_floppy = recal_interrupt;
 	output_byte(FD_RECALIBRATE);
 	LAST_OUT(UNIT(current_drive));
 }
@@ -1823,14 +1825,14 @@
 static void reset_fdc(void)
 {
 	unsigned long flags;
-	
-	SET_INTR(reset_interrupt);
+
+	do_floppy = reset_interrupt;
 	FDCS->reset = 0;
 	reset_fdc_info(0);
 
 	/* Pseudo-DMA may intercept 'reset finished' interrupt.  */
 	/* Irrelevant for systems with true DMA (i386).          */
-	
+
 	flags=claim_dma_lock();
 	fd_disable_dma();
 	release_dma_lock(flags);
@@ -1873,8 +1875,8 @@
 
 	printk("status=%x\n", fd_inb(FD_STATUS));
 	printk("fdc_busy=%lu\n", fdc_busy);
-	if (DEVICE_INTR)
-		printk("DEVICE_INTR=%p\n", DEVICE_INTR);
+	if (do_floppy)
+		printk("do_floppy=%p\n", do_floppy);
 	if (floppy_tq.sync)
 		printk("floppy_tq.routine=%p\n", floppy_tq.routine);
 	if (timer_pending(&fd_timer))
@@ -2920,7 +2922,7 @@
 
 	for (;;) {
 		if (blk_queue_empty(QUEUE)) {
-			CLEAR_INTR;
+			do_floppy = NULL;
 			unlock_fdc();
 			return;
 		}
diff -urN linux-2.5.19/drivers/cdrom/Config.help linux/drivers/cdrom/Config.help
--- linux-2.5.19/drivers/cdrom/Config.help	2002-05-29 20:42:55.000000000 +0200
+++ linux/drivers/cdrom/Config.help	2002-05-30 14:26:43.000000000 +0200
@@ -106,27 +106,6 @@
   The module will be called sbpcd.o.  If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
-CONFIG_SBPCD2
-  Say Y here only if you have two CD-ROM controller cards of this type
-  (usually only if you have more than four drives).  You should enter
-  the parameters for the second, third and fourth interface card into
-  <file:drivers/cdrom/sbpcd.h> before compiling the new kernel.  Read
-  the file <file:Documentation/cdrom/sbpcd>.
-
-CONFIG_SBPCD3
-  Say Y here only if you have three CD-ROM controller cards of this
-  type (usually only if you have more than six drives).  You should
-  enter the parameters for the second, third and fourth interface card
-  into <file:include/linux/sbpcd.h> before compiling the new kernel.
-  Read the file <file:Documentation/cdrom/sbpcd>.
-
-CONFIG_SBPCD4
-  Say Y here only if you have four CD-ROM controller cards of this
-  type (usually only if you have more than eight drives).  You should
-  enter the parameters for the second, third and fourth interface card
-  into <file:include/linux/sbpcd.h> before compiling the new kernel.
-  Read the file <file:Documentation/cdrom/sbpcd>.
-
 CONFIG_AZTCD
   This is your driver if you have an Aztech CDA268-01A, Orchid
   CD-3110, Okano or Wearnes CDD110, Conrad TXC, or CyCD-ROM CR520 or
diff -urN linux-2.5.19/drivers/cdrom/Config.in linux/drivers/cdrom/Config.in
--- linux-2.5.19/drivers/cdrom/Config.in	2002-05-29 20:42:44.000000000 +0200
+++ linux/drivers/cdrom/Config.in	2002-05-30 14:03:07.000000000 +0200
@@ -4,15 +4,6 @@
 tristate '  Aztech/Orchid/Okano/Wearnes/TXC/CyDROM  CDROM support' CONFIG_AZTCD
 tristate '  Goldstar R420 CDROM support' CONFIG_GSCD
 tristate '  Matsushita/Panasonic/Creative, Longshine, TEAC CDROM support' CONFIG_SBPCD
-if [ "$CONFIG_SBPCD" = "y" ]; then
-   bool '    Matsushita/Panasonic, ... second CDROM controller support' CONFIG_SBPCD2
-   if [ "$CONFIG_SBPCD2" = "y" ]; then
-      bool '    Matsushita/Panasonic, ... third CDROM controller support' CONFIG_SBPCD3
-      if [ "$CONFIG_SBPCD3" = "y" ]; then
-	 bool '    Matsushita/Panasonic, ... fourth CDROM controller support' CONFIG_SBPCD4
-      fi
-   fi
-fi
 tristate '  Mitsumi (standard) [no XA/Multisession] CDROM support' CONFIG_MCD
 if [ "$CONFIG_MCD" != "n" ]; then
    int 'MCD IRQ' CONFIG_MCD_IRQ 11
diff -urN linux-2.5.19/drivers/cdrom/gscd.c linux/drivers/cdrom/gscd.c
--- linux-2.5.19/drivers/cdrom/gscd.c	2002-05-29 20:42:44.000000000 +0200
+++ linux/drivers/cdrom/gscd.c	2002-05-30 13:53:38.000000000 +0200
@@ -292,7 +292,7 @@
 		goto out;
 
 	if (CURRENT->cmd != READ) {
-		printk("GSCD: bad cmd %d\n", CURRENT->cmd);
+		printk("GSCD: bad cmd %p\n", CURRENT->cmd);
 		end_request(0);
 		goto repeat;
 	}
diff -urN linux-2.5.19/drivers/cdrom/Makefile linux/drivers/cdrom/Makefile
--- linux-2.5.19/drivers/cdrom/Makefile	2002-05-29 20:42:54.000000000 +0200
+++ linux/drivers/cdrom/Makefile	2002-05-30 14:26:47.000000000 +0200
@@ -34,9 +34,6 @@
 obj-$(CONFIG_MCDX)		+= mcdx.o       cdrom.o
 obj-$(CONFIG_OPTCD)		+= optcd.o
 obj-$(CONFIG_SBPCD)		+= sbpcd.o      cdrom.o
-obj-$(CONFIG_SBPCD2)		+= sbpcd2.o     cdrom.o
-obj-$(CONFIG_SBPCD3)		+= sbpcd3.o     cdrom.o
-obj-$(CONFIG_SBPCD4)		+= sbpcd4.o     cdrom.o
 obj-$(CONFIG_SJCD)		+= sjcd.o
 obj-$(CONFIG_CDU535)		+= sonycd535.o
 
diff -urN linux-2.5.19/drivers/cdrom/sbpcd2.c linux/drivers/cdrom/sbpcd2.c
--- linux-2.5.19/drivers/cdrom/sbpcd2.c	2002-05-29 20:42:58.000000000 +0200
+++ linux/drivers/cdrom/sbpcd2.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,5 +0,0 @@
-/*
- * duplication of sbpcd.c for multiple interfaces
- */
-#define SBPCD_ISSUE 2
-#include "sbpcd.c"
diff -urN linux-2.5.19/drivers/cdrom/sbpcd3.c linux/drivers/cdrom/sbpcd3.c
--- linux-2.5.19/drivers/cdrom/sbpcd3.c	2002-05-29 20:42:59.000000000 +0200
+++ linux/drivers/cdrom/sbpcd3.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,5 +0,0 @@
-/*
- * duplication of sbpcd.c for multiple interfaces
- */
-#define SBPCD_ISSUE 3
-#include "sbpcd.c"
diff -urN linux-2.5.19/drivers/cdrom/sbpcd4.c linux/drivers/cdrom/sbpcd4.c
--- linux-2.5.19/drivers/cdrom/sbpcd4.c	2002-05-29 20:42:48.000000000 +0200
+++ linux/drivers/cdrom/sbpcd4.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,5 +0,0 @@
-/*
- * duplication of sbpcd.c for multiple interfaces
- */
-#define SBPCD_ISSUE 4
-#include "sbpcd.c"
diff -urN linux-2.5.19/drivers/cdrom/sbpcd.c linux/drivers/cdrom/sbpcd.c
--- linux-2.5.19/drivers/cdrom/sbpcd.c	2002-05-29 20:42:48.000000000 +0200
+++ linux/drivers/cdrom/sbpcd.c	2002-05-30 14:42:37.000000000 +0200
@@ -1,5 +1,3 @@
-
-
 /*
  *  sbpcd.c   CD-ROM device driver for the whole family of traditional,
  *            non-ATAPI IDE-style Matsushita/Panasonic CR-5xx drives.
@@ -341,16 +339,20 @@
 
 /*
  * Trying to merge requests breaks this driver horribly (as in it goes
- * boom and apparently has done so since 2.3.41).  As it is a legacy 
- * driver for a horribly slow double speed CD on a hideous interface 
- * designed for polled operation, I won't loose any sleep in simply 
+ * boom and apparently has done so since 2.3.41).  As it is a legacy
+ * driver for a horribly slow double speed CD on a hideous interface
+ * designed for polled operation, I won't loose any sleep in simply
  * disallowing merging.				Paul G.  02/2001
+ *
+ * Thu May 30 14:14:47 CEST 2002:
+ *
+ * I have presumably found the reson for the above - there was a bogous
+ * end_request substitute, which was manipulating the request queues
+ * incorrectly. If someone has access to the actual hardware, and it's
+ * still operations - well  please free to test it.
+ *
+ * Marcin Dalecki
  */
-#define DONT_MERGE_REQUESTS
-
-#ifndef SBPCD_ISSUE
-#define SBPCD_ISSUE 1
-#endif /* SBPCD_ISSUE */
 
 #include <linux/module.h>
 
@@ -364,7 +366,7 @@
 #include <linux/cdrom.h>
 #include <linux/ioport.h>
 #include <linux/devfs_fs_kernel.h>
-#include <linux/major.h> 
+#include <linux/major.h>
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
@@ -377,50 +379,19 @@
 #include <linux/config.h>
 #include "sbpcd.h"
 
-#if !(SBPCD_ISSUE-1)
 #define MAJOR_NR MATSUSHITA_CDROM_MAJOR
-#endif
-#if !(SBPCD_ISSUE-2)
-#define MAJOR_NR MATSUSHITA_CDROM2_MAJOR /* second driver issue */
-#endif
-#if !(SBPCD_ISSUE-3)
-#define MAJOR_NR MATSUSHITA_CDROM3_MAJOR /* third driver issue */
-#endif
-#if !(SBPCD_ISSUE-4)
-#define MAJOR_NR MATSUSHITA_CDROM4_MAJOR /* fourth driver issue */
-#endif
 
 #include <linux/blk.h>
 
 /*==========================================================================*/
-/*
- * provisions for more than 1 driver issues
- * currently up to 4 drivers, expandable
- */
-#if !(SBPCD_ISSUE-1)
-#define DO_SBPCD_REQUEST(a) do_sbpcd_request(a)
-#define SBPCD_INIT(a) sbpcd_init(a)
-#endif
-#if !(SBPCD_ISSUE-2)
-#define DO_SBPCD_REQUEST(a) do_sbpcd2_request(a)
-#define SBPCD_INIT(a) sbpcd2_init(a)
-#endif
-#if !(SBPCD_ISSUE-3)
-#define DO_SBPCD_REQUEST(a) do_sbpcd3_request(a)
-#define SBPCD_INIT(a) sbpcd3_init(a)
-#endif
-#if !(SBPCD_ISSUE-4)
-#define DO_SBPCD_REQUEST(a) do_sbpcd4_request(a)
-#define SBPCD_INIT(a) sbpcd4_init(a)
-#endif
-/*==========================================================================*/
 #if SBPCD_DIS_IRQ
-#define SBPCD_CLI cli()
-#define SBPCD_STI sti()
+# define SBPCD_CLI cli()
+# define SBPCD_STI sti()
 #else
-#define SBPCD_CLI
-#define SBPCD_STI
-#endif /* SBPCD_DIS_IRQ */
+# define SBPCD_CLI
+# define SBPCD_STI
+#endif
+
 /*==========================================================================*/
 /*
  * auto-probing address list
@@ -438,8 +409,7 @@
  * send mail to emoenke@gwdg.de if your interface card is not FULLY
  * represented here.
  */
-#if !(SBPCD_ISSUE-1)
-static int sbpcd[] = 
+static int sbpcd[] =
 {
 	CDROM_PORT, SBPRO, /* probe with user's setup first */
 #if DISTRIBUTION
@@ -482,31 +452,18 @@
 #endif
 #endif /* DISTRIBUTION */
 };
-#else
-static int sbpcd[] = {CDROM_PORT, SBPRO}; /* probe with user's setup only */
-#endif
+
+/*
+ * Protects access to global structures etc.
+ */
+static spinlock_t sbpcd_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
+
 MODULE_PARM(sbpcd, "2i");
 MODULE_PARM(max_drives, "i");
 
 #define NUM_PROBE  (sizeof(sbpcd) / sizeof(int))
 
 /*==========================================================================*/
-/*
- * the external references:
- */
-#if !(SBPCD_ISSUE-1)
-#ifdef CONFIG_SBPCD2
-extern int sbpcd2_init(void);
-#endif
-#ifdef CONFIG_SBPCD3
-extern int sbpcd3_init(void);
-#endif
-#ifdef CONFIG_SBPCD4
-extern int sbpcd4_init(void);
-#endif
-#endif
-
-/*==========================================================================*/
 
 #define INLINE inline
 
@@ -604,19 +561,7 @@
 static const char *str_sp = "SPEA";
 static const char *str_t16 = "Teac16bit";
 static const char *type;
-
-#if !(SBPCD_ISSUE-1)
 static const char *major_name="sbpcd";
-#endif
-#if !(SBPCD_ISSUE-2)
-static const char *major_name="sbpcd2";
-#endif
-#if !(SBPCD_ISSUE-3)
-static const char *major_name="sbpcd3";
-#endif
-#if !(SBPCD_ISSUE-4)
-static const char *major_name="sbpcd4";
-#endif
 
 /*==========================================================================*/
 
@@ -4879,15 +4824,12 @@
  *
  */
 #undef DEBUG_GTL
-static inline void sbpcd_end_request(struct request *req, int uptodate) {
-	list_add(&req->queue, &req->q->queue_head);
-	end_request(uptodate);
-}
+
 /*==========================================================================*/
 /*
  *  I/O request routine, called from Linux kernel.
  */
-static void DO_SBPCD_REQUEST(request_queue_t * q)
+static void do_sbpcd_request(request_queue_t * q)
 {
 	u_int block;
 	u_int nsect;
@@ -4921,11 +4863,11 @@
 		return;
 	}
 
-	req=CURRENT;		/* take out our request so no other */
+	req = CURRENT;		/* take out our request so no other */
 	blkdev_dequeue_request(req);	/* task can fuck it up         GTL  */
 
 	if (req -> sector == -1)
-		sbpcd_end_request(req, 0);
+		end_request(0);
 	spin_unlock_irq(q->queue_lock);
 
 	down(&ioctl_read_sem);
@@ -4967,7 +4909,7 @@
 #endif
 		up(&ioctl_read_sem);
 		spin_lock_irq(q->queue_lock);
-		sbpcd_end_request(req, 1);
+		end_request(1);
 		goto request_loop;
 	}
 
@@ -5008,7 +4950,7 @@
 #endif
 			up(&ioctl_read_sem);
 			spin_lock_irq(q->queue_lock);
-			sbpcd_end_request(req, 1);
+			end_request(1);
 			goto request_loop;
 		}
 	}
@@ -5024,7 +4966,7 @@
 	up(&ioctl_read_sem);
 	sbp_sleep(0);    /* wait a bit, try again */
 	spin_lock_irq(q->queue_lock);
-	sbpcd_end_request(req, 0);
+	end_request(0);
 	goto request_loop;
 }
 /*==========================================================================*/
@@ -5469,7 +5411,7 @@
 static void sbpcd_release(struct cdrom_device_info * cdi)
 {
 	int i;
-	
+
 	i = minor(cdi->dev);
 	if ((i<0) || (i>=NR_SBPCD) || (D_S[i].drv_id==-1))
 	{
@@ -5488,7 +5430,6 @@
 		if (--D_S[d].open_count<=0) 
 		{
 			D_S[d].sbp_first_frame=D_S[d].sbp_last_frame=-1;
-			invalidate_buffers(cdi->dev);
 			if (D_S[d].audio_state!=audio_playing)
 				if (D_S[d].f_eject) cc_SpinDown();
 			D_S[d].diskstate_flags &= ~cd_size_bit;
@@ -5559,11 +5500,7 @@
  *
  */
 
-#if (SBPCD_ISSUE-1)
-static int sbpcd_setup(char *s)
-#else
 int sbpcd_setup(char *s)
-#endif
 {
 #ifndef MODULE
 	int p[4];
@@ -5680,20 +5617,6 @@
 	return (0);
 }
 
-#ifdef DONT_MERGE_REQUESTS
-static int dont_merge_requests_fn(request_queue_t *q, struct request *req,
-                                struct request *next, int max_segments)
-{
-	return 0;
-}
-
-static int dont_bh_merge_fn(request_queue_t *q, struct request *req,
-                            struct buffer_head *bh, int max_segments)
-{
-	return 0;
-}
-#endif
-
 /*==========================================================================*/
 /*
  *  Test for presence of drive and initialize it.
@@ -5703,10 +5626,10 @@
 static devfs_handle_t devfs_handle;
 
 #ifdef MODULE
-int __init __SBPCD_INIT(void)
+int __init __sbpcd_init(void)
 #else
-int __init SBPCD_INIT(void)
-#endif /* MODULE */ 
+int __init sbpcd_init(void)
+#endif
 {
 	char nbuff[16];
 	int i=0, j=0;
@@ -5841,7 +5764,7 @@
 		i=SetSpeed();
 		if (i>=0) D_S[j].CD_changed=1;
 	}
-	
+
 	/*
 	 * Turn on the CD audio channels.
 	 * The addresses are obtained from SOUND_BASE (see sbpcd.h).
@@ -5849,8 +5772,8 @@
 #if SOUND_BASE
 	OUT(MIXER_addr,MIXER_CD_Volume); /* select SB Pro mixer register */
 	OUT(MIXER_data,0xCC); /* one nibble per channel, max. value: 0xFF */
-#endif /* SOUND_BASE */ 
-	
+#endif /* SOUND_BASE */
+
 	if (devfs_register_blkdev(MAJOR_NR, major_name, &sbpcd_bdops) != 0)
 	{
 		msg(DBG_INF, "Can't get MAJOR %d for Matsushita CDROM\n", MAJOR_NR);
@@ -5860,16 +5783,10 @@
 		goto init_done;
 #endif /* MODULE */
 	}
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DO_SBPCD_REQUEST, &sbpcd_lock);
-#ifdef DONT_MERGE_REQUESTS
-	(BLK_DEFAULT_QUEUE(MAJOR_NR))->back_merge_fn = dont_bh_merge_fn;
-	(BLK_DEFAULT_QUEUE(MAJOR_NR))->front_merge_fn = dont_bh_merge_fn;
-	(BLK_DEFAULT_QUEUE(MAJOR_NR))->merge_requests_fn = dont_merge_requests_fn;
-#endif
-	read_ahead[MAJOR_NR] = buffers * (CD_FRAMESIZE / 512);
-	
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_sbpcd_request, &sbpcd_lock);
+
 	request_region(CDo_command,4,major_name);
-	
+
 	devfs_handle = devfs_mk_dir (NULL, "sbp", NULL);
 	for (j=0;j<NR_SBPCD;j++)
 	{
@@ -5918,35 +5835,24 @@
 		}
 		D_S[j].sbpcd_infop = sbpcd_infop;
 		memcpy (sbpcd_infop, &sbpcd_info, sizeof(struct cdrom_device_info));
-		sbpcd_infop->dev = MKDEV(MAJOR_NR, j);
+		sbpcd_infop->dev = mk_kdev(MAJOR_NR, j);
 		strncpy(sbpcd_infop->name,major_name, sizeof(sbpcd_infop->name)); 
 
-		sprintf (nbuff, "c%dt%d/cd", SBPCD_ISSUE - 1, D_S[j].drv_id);
+		sprintf (nbuff, "c0t%d/cd", D_S[j].drv_id);
 		sbpcd_infop->de =
 		    devfs_register (devfs_handle, nbuff, DEVFS_FL_DEFAULT,
 				    MAJOR_NR, j, S_IFBLK | S_IRUGO | S_IWUGO,
 				    &sbpcd_bdops, NULL);
 		if (register_cdrom(sbpcd_infop))
 		{
-                	printk(" sbpcd: Unable to register with Uniform CD-ROm driver\n");
+			printk(" sbpcd: Unable to register with Uniform CD-ROm driver\n");
 		}
 	}
 	blk_queue_hardsect_size(BLK_DEFAULT_QUEUE(MAJOR_NR), CD_FRAMESIZE);
 
 #ifndef MODULE
  init_done:
-#if !(SBPCD_ISSUE-1)
-#ifdef CONFIG_SBPCD2
-	sbpcd2_init();
-#endif /* CONFIG_SBPCD2 */
-#ifdef CONFIG_SBPCD3
-	sbpcd3_init();
-#endif /* CONFIG_SBPCD3 */ 
-#ifdef CONFIG_SBPCD4
-	sbpcd4_init();
-#endif /* CONFIG_SBPCD4 */ 
-#endif /* !(SBPCD_ISSUE-1) */ 
-#endif /* MODULE */
+#endif
 	return 0;
 }
 /*==========================================================================*/
@@ -5978,14 +5884,11 @@
 	msg(DBG_INF, "%s module released.\n", major_name);
 }
 
-
-#ifdef MODULE
-module_init(__SBPCD_INIT) /*HACK!*/;
-#endif
+module_init(__sbpcd_init) /*HACK!*/;
 module_exit(sbpcd_exit);
 
 
-#endif /* MODULE */ 
+#endif /* MODULE */
 /*==========================================================================*/
 /*
  * Check if the media has changed in the CD-ROM drive.
@@ -6003,7 +5906,7 @@
                 D_S[i].CD_changed=0;
                 msg(DBG_CHK,"medium changed (drive %d)\n", i);
 		/* BUG! Should invalidate buffers! --AJK */
-		invalidate_buffers(full_dev);
+		/* Why should it do the above at all?! --mdcki */
 		D_S[d].diskstate_flags &= ~toc_bit;
 		D_S[d].diskstate_flags &= ~cd_size_bit;
 #if SAFE_MIXED
diff -urN linux-2.5.19/drivers/cdrom/sbpcd.h linux/drivers/cdrom/sbpcd.h
--- linux-2.5.19/drivers/cdrom/sbpcd.h	2002-05-29 20:42:47.000000000 +0200
+++ linux/drivers/cdrom/sbpcd.h	2002-05-30 14:11:43.000000000 +0200
@@ -74,30 +74,10 @@
  * Example: #define SOUND_BASE 0x220 enables the sound card's CD channels
  *          #define SOUND_BASE 0     leaves the soundcard untouched
  */
-#if !(SBPCD_ISSUE-1)     /* first (or if you have only one) interface board: */
 #define CDROM_PORT 0x340 /* <-----------<< port address                      */
 #define SBPRO      0     /* <-----------<< interface type                    */
 #define MAX_DRIVES 4     /* set to 1 if the card does not use "drive select" */
 #define SOUND_BASE 0x220 /* <-----------<< sound address of this card or 0   */
-#endif
-#if !(SBPCD_ISSUE-2)     /* ==================== second interface board: === */
-#define CDROM_PORT 0x344 /* <-----------<< port address                      */
-#define SBPRO      0     /* <-----------<< interface type                    */
-#define MAX_DRIVES 4     /* set to 1 if the card does not use "drive select" */
-#define SOUND_BASE 0x000 /* <-----------<< sound address of this card or 0   */
-#endif
-#if !(SBPCD_ISSUE-3)     /* ===================== third interface board: === */
-#define CDROM_PORT 0x630 /* <-----------<< port address                      */
-#define SBPRO      1     /* <-----------<< interface type                    */
-#define MAX_DRIVES 4     /* set to 1 if the card does not use "drive select" */
-#define SOUND_BASE 0x240 /* <-----------<< sound address of this card or 0   */
-#endif
-#if !(SBPCD_ISSUE-4)     /* ==================== fourth interface board: === */
-#define CDROM_PORT 0x634 /* <-----------<< port address                      */
-#define SBPRO      0     /* <-----------<< interface type                    */
-#define MAX_DRIVES 4     /* set to 1 if the card does not use "drive select" */
-#define SOUND_BASE 0x000 /* <-----------<< sound address of this card or 0   */
-#endif
 
 /*
  * some more or less user dependent definitions - service them!
diff -urN linux-2.5.19/drivers/cdrom/sonycd535.c linux/drivers/cdrom/sonycd535.c
--- linux-2.5.19/drivers/cdrom/sonycd535.c	2002-05-29 20:42:52.000000000 +0200
+++ linux/drivers/cdrom/sonycd535.c	2002-05-30 14:35:52.000000000 +0200
@@ -118,6 +118,7 @@
 #include <linux/timer.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/hdreg.h>
 #include <linux/genhd.h>
@@ -134,7 +135,8 @@
 #include <linux/cdrom.h>
 
 #define MAJOR_NR CDU535_CDROM_MAJOR
-# include <linux/blk.h>
+#include <linux/blk.h>
+
 #define sony535_cd_base_io sonycd535 /* for compatible parameter passing with "insmod" */
 #include "sonycd535.h"
 
@@ -1589,7 +1591,6 @@
 								&cdu_fops, NULL);
 				if (devfs_register_blkdev(MAJOR_NR, CDU535_HANDLE, &cdu_fops)) {
 					printk("Unable to get major %d for %s\n",
-					devfs_unregister(sony_devfs_handle);
 							MAJOR_NR, CDU535_MESSAGE_NAME);
 					return -EIO;
 				}
@@ -1663,8 +1664,7 @@
 		devfs_unregister(sony_devfs_handle);
 		if (sony535_irq_used)
 			free_irq(sony535_irq_used, NULL);
-		}
-	
+
 		return -EIO;
 		}
 	register_disk(NULL, mk_kdev(MAJOR_NR,0), 1, &cdu_fops, 0);
diff -urN linux-2.5.19/drivers/ide/hd.c linux/drivers/ide/hd.c
--- linux-2.5.19/drivers/ide/hd.c	2002-05-29 20:42:47.000000000 +0200
+++ linux/drivers/ide/hd.c	2002-05-30 13:36:10.000000000 +0200
@@ -110,20 +110,16 @@
 
 static struct timer_list device_timer;
 
-#define SET_TIMER 							\
+#define SET_TIMER							\
 	do {								\
 		mod_timer(&device_timer, jiffies + TIMEOUT_VALUE);	\
 	} while (0)
 
-#define CLEAR_TIMER del_timer(&device_timer);
-
-#undef SET_INTR
-
-#define SET_INTR(x) \
+#define SET_HANDLER(x) \
 if ((DEVICE_INTR = (x)) != NULL) \
 	SET_TIMER; \
 else \
-	CLEAR_TIMER;
+	del_timer(&device_timer);
 
 
 #if (HD_DELAY > 0)
@@ -279,7 +275,7 @@
 		reset = 1;
 		return;
 	}
-	SET_INTR(intr_addr);
+	SET_HANDLER(intr_addr);
 	outb_p(hd_info[drive].ctl,HD_CMD);
 	port=HD_DATA;
 	outb_p(hd_info[drive].wpcom>>2,++port);
@@ -429,7 +425,7 @@
 	if (CURRENT->current_nr_sectors <= 0)
 		end_request(1);
 	if (i > 0) {
-		SET_INTR(&read_intr);
+		SET_HANDLER(&read_intr);
 		return;
 	}
 	(void) inb_p(HD_STATUS);
@@ -467,7 +463,7 @@
 	if (!i || (CURRENT->bio && !SUBSECTOR(i)))
 		end_request(1);
 	if (i > 0) {
-		SET_INTR(&write_intr);
+		SET_HANDLER(&write_intr);
 		outsw(HD_DATA,CURRENT->buffer,256);
 		sti();
 	} else {
diff -urN linux-2.5.19/drivers/s390/block/xpram.c linux/drivers/s390/block/xpram.c
--- linux-2.5.19/drivers/s390/block/xpram.c	2002-05-29 20:42:57.000000000 +0200
+++ linux/drivers/s390/block/xpram.c	2002-05-30 05:21:22.000000000 +0200
@@ -59,25 +59,15 @@
 #include <linux/version.h>
 
 #ifdef MODULE
-char kernel_version [] = UTS_RELEASE; 
+char kernel_version [] = UTS_RELEASE;
 #endif
 
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
-#  define XPRAM_VERSION 24
-#else
-#  define XPRAM_VERSION 22
-#endif 
-
-#if (XPRAM_VERSION == 24)
-#  include <linux/config.h>
-#  include <linux/init.h>
-#endif /* V24 */
+#include <linux/config.h>
+#include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/kernel.h> /* printk() */
 #include <linux/slab.h> /* kmalloc() */
-#if (XPRAM_VERSION == 24)
-#  include <linux/devfs_fs_kernel.h>
-#endif /* V24 */
+#include <linux/devfs_fs_kernel.h>
 #include <linux/fs.h>     /* everything... */
 #include <linux/errno.h>  /* error codes */
 #include <linux/timer.h>
@@ -89,7 +79,6 @@
 #include <asm/system.h>   /* cli(), *_flags */
 #include <asm/uaccess.h>  /* put_user */
 
-#if (XPRAM_VERSION == 24)
 #define MAJOR_NR xpram_major /* force definitions on in blk.h */
 int xpram_major;   /* must be declared before including blk.h */
 devfs_handle_t xpram_devfs_handle;
@@ -105,7 +94,6 @@
 #include "xpram.h"        /* local definitions */
 
 __setup("xpram_parts=", xpram_setup);
-#endif /* V24 */
 
 /*
    define the debug levels:
@@ -133,26 +121,7 @@
 #define PRINT_WARN(x...) printk ( KERN_DEBUG PRINTK_HEADER "warning:" x )
 #define PRINT_ERR(x...) printk ( KERN_DEBUG PRINTK_HEADER "error:" x )
 #define PRINT_FATAL(x...) printk ( KERN_DEBUG PRINTK_HEADER "panic:" x )
-#endif	
-
-#if (XPRAM_VERSION == 22)
-#define MAJOR_NR xpram_major /* force definitions on in blk.h */
-int xpram_major;   /* must be declared before including blk.h */
-
-#define DEVICE_NR(device) MINOR(device)   /* xpram has no partition bits */
-#define DEVICE_NAME "xpram"               /* name for messaging */
-#define DEVICE_INTR xpram_intrptr         /* pointer to the bottom half */
-#define DEVICE_NO_RANDOM                  /* no entropy to contribute */
-
-
-#define DEVICE_OFF(d) /* do-nothing */
-
-#define DEVICE_REQUEST *xpram_dummy_device_request  /* dummy function variable 
-						     * to prevent warnings 
-						     */#include <linux/blk.h>
-
-#include "xpram.h"        /* local definitions */
-#endif /* V22 */
+#endif
 
 /*
  * Non-prefixed symbols are static. They are meant to be assigned at
@@ -659,13 +628,6 @@
 	case BLKRRPART: /* re-read partition table: can't do it, 0x1259 */
 		return -EINVAL;
 
-#if (XPRAM_VERSION == 22)
-		RO_IOCTLS(inode->i_rdev, arg); /* the default RO operations 
-                                                * BLKROSET
-						* BLKROGET
-                                                */
-#endif /* V22 */
-
 	case HDIO_GETGEO:
 		/*
 		 * get geometry: we have to fake one...  trim the size to a
@@ -695,27 +657,6 @@
 /*
  * The file operations
  */
-
-#if (XPRAM_VERSION == 22)
-struct file_operations xpram_fops = {
-	NULL,          /* lseek: default */
-	block_read,
-	block_write,
-	NULL,          /* xpram_readdir */
-	NULL,          /* xpram_select */
-	xpram_ioctl,
-	NULL,          /* xpram_mmap */
-	xpram_open,
-	NULL,          /* flush */
-	xpram_release,
-	block_fsync,
-	NULL,          /* xpram_fasync */
-        NULL,
-        NULL
-};
-#endif /* V22 */
-
-#if (XPRAM_VERSION == 24)
 struct block_device_operations xpram_devops =
 {
 	owner:   THIS_MODULE,
@@ -723,7 +664,6 @@
 	open:    xpram_open,
 	release: xpram_release,
 };
-#endif /* V24 */
 
 /*
  * Block-driver specific functions
@@ -740,11 +680,7 @@
         char * buffer;                 /* local pointer into buffer cache */
 	int dev_no;                    /* device number of request */
 	int fault;                     /* faulty access to expanded memory */
-#if ( XPRAM_VERSION == 24 )	
         struct request * current_req;      /* working request */
-#else 
-#       define current_req CURRENT
-#endif /* V24 */
 
 	while(1) {
 		if (blk_queue_empty(QUEUE)) {
@@ -753,10 +689,8 @@
 		}
 
 		fault=0;
-#if ( XPRAM_VERSION == 24 )
 		current_req = CURRENT;
-#endif /* V24 */
-		dev_no = DEVICE_NR(current_req->rq_dev); 
+		dev_no = DEVICE_NR(current_req->rq_dev);
 		/* Check if the minor number is in range */
 		if ( dev_no > xpram_devs ) {
 			static int count = 0;
@@ -872,26 +806,18 @@
  *           partition size (if provided). A parsing error of a value
  *           results in this value being set to -EINVAL.
  */
-#if (XPRAM_VERSION == 22)
-void xpram_setup (char *str, int *ints)
-#else 
 int xpram_setup (char *str)
-#endif /* V22 */
 {
 	devs = xpram_read_int(&str);
-	if ( devs != -EINVAL ) 
-	  if ( xpram_read_size_list_tail(&str,devs,sizes) < 0 ) {
+	if ( devs != -EINVAL )
+		if ( xpram_read_size_list_tail(&str,devs,sizes) < 0 ) {
 			PRINT_ERR("error while reading xpram parameters.\n");
-#if (XPRAM_VERSION == 24)
 			return -EINVAL;
-#endif /* V24 */
-			  }
-#if (XPRAM_VERSION == 24)
-	  else return 0;
-	else return -EINVAL;
-#elif (XPRAM_VERSION == 22)
-	return; 
-#endif /* V24/V22 */
+		}
+		else
+			return 0;
+	else
+		return -EINVAL;
 }
 
 /*
@@ -911,12 +837,10 @@
 
 	int mem_auto_no=0;    /* number of (implicit) zero parameters in sizes */
 	int mem_auto;         /* automatically determined device size          */
-#if (XPRAM_VERSION == 24)
 	int minor_length;     /* store the length of a minor (w/o '\0') */
         int minor_thresh;     /* threshhold for minor lenght            */
 
         request_queue_t *q;   /* request queue */
-#endif /* V24 */
 
 				/*
 				 * Copy the (static) cfg variables to public prefixed ones to allow
@@ -975,29 +899,23 @@
 	/*
 	 * Register your major, and accept a dynamic number
 	 */
-#if (XPRAM_VERSION == 22)
-	result = register_blkdev(xpram_major, "xpram", &xpram_fops);
-#elif (XPRAM_VERSION == 24)
 	result = devfs_register_blkdev(xpram_major, "xpram", &xpram_devops);
-#endif /* V22/V24 */
 	if (result < 0) {
 		PRINT_ERR("Can't get major %d\n",xpram_major);
                 PRINT_ERR("Giving up xpram\n");
 		return result;
 	}
-#if (XPRAM_VERSION == 24)
 	xpram_devfs_handle = devfs_mk_dir (NULL, "slram", NULL);
 	devfs_register_series (xpram_devfs_handle, "%u", XPRAM_MAX_DEVS,
 			       DEVFS_FL_DEFAULT, XPRAM_MAJOR, 0,
 			       S_IFBLK | S_IRUSR | S_IWUSR,
 			       &xpram_devops, NULL);
-#endif /* V22/V24 */
 	if (xpram_major == 0) xpram_major = result; /* dynamic */
 	major = xpram_major; /* Use `major' later on to save typing */
 
 	result = -ENOMEM; /* for the possible errors */
 
-	/* 
+	/*
 	 * measure expanded memory
 	 */
 
@@ -1018,13 +936,9 @@
 	 * arrays if it uses the default values.
 	 */
 
-#if (XPRAM_VERSION == 22)
-	blk_dev[major].request_fn = xpram_request;
-#elif (XPRAM_VERSION == 24)
-	q = BLK_DEFAULT_QUEUE (major);
+	q = BLK_DEFAULT_QUEUE(major);
 	blk_init_queue (q, xpram_request);
 	blk_queue_hardsect_size(q, xpram_hardsect);
-#endif /* V22/V24 */
 
 	/* we want to have XPRAM_UNUSED blocks security buffer between devices */
 	mem_usable=xpram_mem_avail-(XPRAM_UNUSED*(xpram_devs-1));
@@ -1076,15 +990,12 @@
 		goto fail_malloc_devices;
 	}
 	memset(xpram_devices, 0, xpram_devs * sizeof (Xpram_Dev));
-#if (XPRAM_VERSION == 24)
         minor_length = 1;
         minor_thresh = 10;
-#endif /* V24 */
 	for (i=0; i < xpram_devs; i++) {
 		/* data and usage remain zeroed */
 		xpram_devices[i].size = xpram_sizes[i];  /* size in kB not in bytes */
 		atomic_set(&(xpram_devices[i].usage),0);
-#if (XPRAM_VERSION == 24)
                 if (i == minor_thresh) {
 		  minor_length++;
 		  minor_thresh *= 10;
@@ -1119,27 +1030,20 @@
 		  goto fail_devfs_register;
 		}
 #endif  /* WHY? */
-#endif /* V24 */
-				 
 	}
 
 	return 0; /* succeed */
 
 	/* clean up memory in case of failures */
-#if (XPRAM_VERSION == 24)
  fail_devfs_register:
         for (i=0; i < xpram_devs; i++) {
 	  if ( xpram_devices[i].device_name )
 	    kfree(xpram_devices[i].device_name);
 	}
 	kfree(xpram_devices);
-#endif /* V24 */
 	kfree (xpram_offsets);
  fail_malloc_devices:
  fail_malloc:
-#if (XPRAM_VERSION == 22)
-	blk_dev[major].request_fn = NULL;
-#endif /* V22 */
 	/* ???	unregister_chrdev(major, "xpram"); */
 	unregister_blkdev(major, "xpram");
 	return result;
@@ -1168,20 +1072,12 @@
 	int i;
 
 	/* first of all, reset all the data structures */
-
-#if (XPRAM_VERSION == 22)
-	blk_dev[major].request_fn = NULL;
-#endif /* V22 */
 	kfree(xpram_offsets);
 	blk_clear(major);
 
 				/* finally, the usual cleanup */
-#if (XPRAM_VERSION == 22)
-	unregister_blkdev(major, "xpram");
-#elif (XPRAM_VERSION == 24)
 	devfs_unregister(xpram_devfs_handle);
 	if (devfs_unregister_blkdev(MAJOR_NR, "xpram"))
 		printk(KERN_WARNING "xpram: cannot unregister blkdev\n");
-#endif /* V22/V24 */
 	kfree(xpram_devices);
 }
diff -urN linux-2.5.19/include/linux/blk.h linux/include/linux/blk.h
--- linux-2.5.19/include/linux/blk.h	2002-05-29 20:42:50.000000000 +0200
+++ linux/include/linux/blk.h	2002-05-30 14:24:35.000000000 +0200
@@ -125,7 +125,6 @@
 static void floppy_off(unsigned int nr);
 
 #define DEVICE_NAME "floppy"
-#define DEVICE_INTR do_floppy
 #define DEVICE_NR(device) ( (minor(device) & 3) | ((minor(device) & 0x80 ) >> 5 ))
 
 #elif (MAJOR_NR == HD_MAJOR)
@@ -149,14 +148,14 @@
 #elif (MAJOR_NR == SCSI_TAPE_MAJOR)
 
 #define DEVICE_NAME "scsitape"
-#define DEVICE_INTR do_st  
+#define DEVICE_INTR do_st
 #define DEVICE_NR(device) (minor(device) & 0x7f)
 
 #elif (MAJOR_NR == OSST_MAJOR)
 
-#define DEVICE_NAME "onstream" 
+#define DEVICE_NAME "onstream"
 #define DEVICE_INTR do_osst
-#define DEVICE_NR(device) (minor(device) & 0x7f) 
+#define DEVICE_NR(device) (minor(device) & 0x7f)
 
 #elif (MAJOR_NR == SCSI_CDROM_MAJOR)
 
@@ -187,33 +186,16 @@
 #elif (MAJOR_NR == MITSUMI_CDROM_MAJOR)
 
 #define DEVICE_NAME "Mitsumi CD-ROM"
-/* #define DEVICE_INTR do_mcd */
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == MITSUMI_X_CDROM_MAJOR)
 
 #define DEVICE_NAME "Mitsumi CD-ROM"
-/* #define DEVICE_INTR do_mcdx */
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == MATSUSHITA_CDROM_MAJOR)
 
-#define DEVICE_NAME "Matsushita CD-ROM controller #1"
-#define DEVICE_NR(device) (minor(device))
-
-#elif (MAJOR_NR == MATSUSHITA_CDROM2_MAJOR)
-
-#define DEVICE_NAME "Matsushita CD-ROM controller #2"
-#define DEVICE_NR(device) (minor(device))
-
-#elif (MAJOR_NR == MATSUSHITA_CDROM3_MAJOR)
-
-#define DEVICE_NAME "Matsushita CD-ROM controller #3"
-#define DEVICE_NR(device) (minor(device))
-
-#elif (MAJOR_NR == MATSUSHITA_CDROM4_MAJOR)
-
-#define DEVICE_NAME "Matsushita CD-ROM controller #4"
+#define DEVICE_NAME "Matsushita CD-ROM controller"
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == AZTECH_CDROM_MAJOR)
@@ -292,27 +274,23 @@
 #if (MAJOR_NR != SCSI_TAPE_MAJOR) && (MAJOR_NR != OSST_MAJOR)
 #if !defined(IDE_DRIVER)
 
-#ifndef CURRENT
-# define CURRENT elv_next_request(&blk_dev[MAJOR_NR].request_queue)
-#endif
 #ifndef QUEUE
 # define QUEUE (&blk_dev[MAJOR_NR].request_queue)
 #endif
+#ifndef CURRENT
+# define CURRENT elv_next_request(QUEUE)
+#endif
 #ifndef DEVICE_NAME
 # define DEVICE_NAME "unknown"
 #endif
 
 #ifdef DEVICE_INTR
 static void (*DEVICE_INTR)(void) = NULL;
-#endif
-
-#define SET_INTR(x) (DEVICE_INTR = (x))
-
-# ifdef DEVICE_INTR
-#  define CLEAR_INTR SET_INTR(NULL)
+#  define CLEAR_INTR DEVICE_INTR = NULL
 # else
 #  define CLEAR_INTR
 # endif
+
 #endif /* !defined(IDE_DRIVER) */
 
 /*

--------------040708040905020403060500--

