Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbUKEBr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUKEBr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUKEBr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:47:58 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:45451 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S262541AbUKEBkC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:40:02 -0500
From: james4765@verizon.net
To: kernel-janitors@lists.osdl.org
Cc: linux-kernel@vger.kernel.org, james4765@verizon.net
Message-Id: <20041105014000.11993.38553.30904@localhost.localdomain>
Subject: [PATCH] floppy: Reorganize drivers/block/floppy.c
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [68.238.31.6] at Thu, 4 Nov 2004 19:40:00 -0600
Date: Thu, 4 Nov 2004 19:40:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Organization of global variables, macros, and #defines in floppy.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/drivers/block/floppy.c linux-2.6.9/drivers/block/floppy.c
--- linux-2.6.9-original/drivers/block/floppy.c	2004-10-18 17:53:22.000000000 -0400
+++ linux-2.6.9/drivers/block/floppy.c	2004-11-04 20:25:28.180478012 -0500
@@ -13,14 +13,6 @@
  */
 
 /*
- * This file is certainly a mess. I've tried my best to get it working,
- * but I don't like programming floppies, and I have only one anyway.
- * Urgel. I should check for more errors, and do more graceful error
- * recovery. Seems there are problems with several drives. I've tried to
- * correct them. No promises.
- */
-
-/*
  * As with hd.c, all routines within this file can (and will) be called
  * by interrupts, so extreme caution is needed. A hardware interrupt
  * handler may not sleep, or a kernel panic will happen. Thus I cannot
@@ -98,6 +90,10 @@
  */
 
 /*
+ * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
+ */
+
+/*
  * 1998/05/07 -- Russell King -- More portability cleanups; moved definition of
  * interrupt and dma channel to asm/floppy.h. Cleaned up some formatting &
  * use of '0' for NULL.
@@ -141,14 +137,38 @@
 
 #define FLOPPY_SANITY_CHECK
 #undef  FLOPPY_SILENT_DCL_CLEAR
-
 #define REALLY_SLOW_IO
+#define DCL_DEBUG		/* debug disk change line */
+#define FDPATCHES
+#define LOCAL_END_REQUEST
 
+/*
+ * Maximum disk size (in kilobytes). This default is used whenever the
+ * current disk size is unknown.
+ * [Now it is rather a minimum]
+ */
+#define MAX_DISK_SIZE 4		/* 3984 */
+#define DEVICE_NAME "floppy"
 #define DEBUGT 2
-#define DCL_DEBUG		/* debug disk change line */
+#define K_64	0x10000		/* 64KB */
+#define MAX_REPLIES 16
+#define NR_F 6
+#define NR_RW 9
+#define SEL_DLY (2*HZ/100)
+/* Synchronization of FDC access. */
+#define FD_COMMAND_NONE -1
+#define FD_COMMAND_ERROR 2
+#define FD_COMMAND_OKAY 3
+#define CURRENT_REQD -1
+#define MAXTIMEOUT -2
+#define NO_TRACK -1
+#define NEED_1_RECAL -2
+#define NEED_2_RECAL -3
+#define MORE_OUTPUT -2		/* does the fdc need more output? */
+
+typedef void (*done_f) (int);
+typedef void (*timeout_fn) (unsigned long);
 
-/* do print messages for unexpected interrupts */
-static int print_unex = 1;
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
@@ -156,16 +176,9 @@
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/version.h>
-#define FDPATCHES
 #include <linux/fdreg.h>
-
-/*
- * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
- */
-
 #include <linux/fd.h>
 #include <linux/hdreg.h>
-
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -180,23 +193,27 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
-
-/*
- * PS/2 floppies have much slower step rates than regular floppies.
- * It's been recommended that take about 1/4 of the default speed
- * in some more extreme cases.
- */
-static int slow_floppy;
-
+#include <linux/blkdev.h>
+#include <linux/blkpg.h>
+#include <linux/cdrom.h>	/* for the compatibility eject ioctl */
+#include <linux/completion.h>
 #include <asm/dma.h>
 #include <asm/irq.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
-static int FLOPPY_IRQ = 6;
-static int FLOPPY_DMA = 2;
-static int can_use_virtual_dma = 2;
+/* the following is the mask of allowed drives. By default units 2 and
+ * 3 of both floppy controllers are disabled, because switching on the
+ * motor of these drives causes system hangs on some PCI computers. drive
+ * 0 is the low bit (0x1), and drive 7 is the high bit (0x80). Bits are on if
+ * a drive is allowed.
+ *
+ * NOTE: These must come before we include the arch floppy header because
+ *       some ports reference these variables from there. -DaveM
+ */
+static int allowed_drive_mask = 0x33;
+
 /* =======
  * can use virtual DMA:
  * 0 = use of virtual DMA disallowed by config
@@ -204,8 +221,8 @@
  * 2 = no virtual DMA preference configured.  By default try hard DMA,
  * but fall back on virtual DMA when not enough memory available
  */
+static int can_use_virtual_dma = 2;
 
-static int use_virtual_dma;
 /* =======
  * use virtual DMA
  * 0 using hard DMA
@@ -216,150 +233,159 @@
  * driver may have several buffers in use at once, and we do currently not
  * record each buffers capabilities
  */
+static int use_virtual_dma;
 
-static spinlock_t floppy_lock = SPIN_LOCK_UNLOCKED;
-static struct completion device_release;
+static int FLOPPY_IRQ = 6;
+static int FLOPPY_DMA = 2;
 
 static unsigned short virtual_dma_port = 0x3f0;
+
 irqreturn_t floppy_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+
+#include <asm/floppy.h>
+
 static int set_dor(int fdc, char mask, char data);
+
 static void register_devfs_entries(int drive) __init;
 
-#define K_64	0x10000		/* 64KB */
+static void do_fd_request(request_queue_t * q);
 
-/* the following is the mask of allowed drives. By default units 2 and
- * 3 of both floppy controllers are disabled, because switching on the
- * motor of these drives causes system hangs on some PCI computers. drive
- * 0 is the low bit (0x1), and drive 7 is the high bit (0x80). Bits are on if
- * a drive is allowed.
- *
- * NOTE: This must come before we include the arch floppy header because
- *       some ports reference this variable from there. -DaveM
- */
+static void floppy_ready(void);
 
-static int allowed_drive_mask = 0x33;
+static void floppy_start(void);
 
-#include <asm/floppy.h>
+static void process_fd_request(void);
 
-static int irqdma_allocated;
+static void recalibrate_floppy(void);
 
-#define LOCAL_END_REQUEST
-#define DEVICE_NAME "floppy"
+static void floppy_shutdown(unsigned long);
 
-#include <linux/blkdev.h>
-#include <linux/blkpg.h>
-#include <linux/cdrom.h>	/* for the compatibility eject ioctl */
-#include <linux/completion.h>
+static int floppy_grab_irq_and_dma(void);
 
-static struct request *current_req;
-static struct request_queue *floppy_queue;
-static void do_fd_request(request_queue_t * q);
+static void floppy_release_irq_and_dma(void);
 
-#ifndef fd_get_dma_residue
-#define fd_get_dma_residue() get_dma_residue(FLOPPY_DMA)
-#endif
+static void show_floppy(void);
 
-/* Dma Memory related stuff */
+/* do print messages for unexpected interrupts */
+static int print_unex = 1;
 
-#ifndef fd_dma_mem_free
-#define fd_dma_mem_free(addr, size) free_pages(addr, get_order(size))
-#endif
+/*
+ * PS/2 floppies have much slower step rates than regular floppies.
+ * It's been recommended that take about 1/4 of the default speed
+ * in some more extreme cases.
+ */
+static int slow_floppy;
 
-#ifndef fd_dma_mem_alloc
-#define fd_dma_mem_alloc(size) __get_dma_pages(GFP_KERNEL,get_order(size))
-#endif
+/*
+ * The driver is trying to determine the correct media format
+ * while probing is set. rw_interrupt() clears it after a
+ * successful access.
+ */
+static int probing;
 
-static inline void fallback_on_nodma_alloc(char **addr, size_t l)
-{
-#ifdef FLOPPY_CAN_FALLBACK_ON_NODMA
-	if (*addr)
-		return;		/* we have the memory */
-	if (can_use_virtual_dma != 2)
-		return;		/* no fallback allowed */
-	printk
-	    ("DMA memory shortage. Temporarily falling back on virtual DMA\n");
-	*addr = (char *)nodma_mem_alloc(l);
-#else
-	return;
-#endif
-}
+/* Errors during formatting are counted here. */
+static int format_errors;
 
-/* End dma memory related stuff */
+static int irqdma_allocated;
+static int inr;		/* size of reply buffer, when called from interrupt */
+static int initialising = 1;
+static int max_buffer_sectors;
+static int usage_count;
+static int buffer_track = -1;
+static int buffer_drive = -1;
+static int buffer_min = -1;
+static int buffer_max = -1;
+static int fdc;			/* current fdc */
+static int hlt_disabled;
+static int fifo_depth = 0xa;
+static int no_fifo;
+static int blind_seek;
+static int have_no_fdc = -ENODEV;
+
+static int *errors;
+
+static volatile int command_status = FD_COMMAND_NONE;
+
+static int t360[] = { 1, 0 },
+	t1200[] = { 2, 5, 6, 10, 12, 14, 16, 18, 20, 23, 0 },
+	t3in[] = { 8, 9, 26, 27, 28, 7, 11, 15, 19, 24, 25, 29, 31, 3, 4, 13,
+			17, 21, 22, 30, 0 };
+			
+static int *table_sup[] =
+    { NULL, t360, t1200, t3in + 5 + 8, t3in + 5, t3in, t3in };
+
+static DECLARE_WAIT_QUEUE_HEAD(fdc_wait);
+static DECLARE_WAIT_QUEUE_HEAD(command_done);
+
+static spinlock_t floppy_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t floppy_hlt_lock = SPIN_LOCK_UNLOCKED;
+
+static long current_count_sectors;
 
 static unsigned long fake_change;
-static int initialising = 1;
+static unsigned long fdc_busy;
 
-#define ITYPE(x) (((x)>>2) & 0x1f)
-#define TOMINOR(x) ((x & 3) | ((x & 4) << 5))
-#define UNIT(x) ((x) & 0x03)	/* drive on fdc */
-#define FDC(x) (((x) & 0x04) >> 2)	/* fdc of drive */
-#define REVDRIVE(fdc, unit) ((unit) + ((fdc) << 2))
-				/* reverse mapping from unit and fdc to drive */
-#define DP (&drive_params[current_drive])
-#define DRS (&drive_state[current_drive])
-#define DRWE (&write_errors[current_drive])
-#define FDCS (&fdc_state[fdc])
-#define CLEARF(x) (clear_bit(x##_BIT, &DRS->flags))
-#define SETF(x) (set_bit(x##_BIT, &DRS->flags))
-#define TESTF(x) (test_bit(x##_BIT, &DRS->flags))
+/*
+ * Track buffer
+ * Because these are written to by the DMA controller, they must
+ * not contain a 64k byte boundary crossing, or data will be
+ * corrupted/lost.
+ */
+static char *floppy_track_buffer;
 
-#define UDP (&drive_params[drive])
-#define UDRS (&drive_state[drive])
-#define UDRWE (&write_errors[drive])
-#define UFDCS (&fdc_state[FDC(drive)])
-#define UCLEARF(x) (clear_bit(x##_BIT, &UDRS->flags))
-#define USETF(x) (set_bit(x##_BIT, &UDRS->flags))
-#define UTESTF(x) (test_bit(x##_BIT, &UDRS->flags))
+static char *table[] = {
+	"", "d360", "h1200", "u360", "u720", "h360", "h720", "u1440", "u2880",
+	"CompaQ", "h1440", "u1680", "h410", "u820", "h1476", "u1722", "h420",
+	"u830", "h1494", "u1743", "h880", "u1040", "u1120", "h1600", "u1760",
+	"u1920", "u3200", "u3520", "u3840", "u1840", "u800", "u1600",
+	NULL
+};
+
+static unsigned char reply_buffer[MAX_REPLIES];
+static unsigned char current_drive;
+static unsigned char fsector_t;		/* sector in track */
+static unsigned char in_sector_offset;	/* offset within physical sector,
+					 * expressed in units of 512 bytes */
 
-#define DPRINT(format, args...) printk(DEVICE_NAME "%d: " format, current_drive , ## args)
+static const char *timeout_message;
 
-#define PH_HEAD(floppy,head) (((((floppy)->stretch & 2) >>1) ^ head) << 2)
-#define STRETCH(floppy) ((floppy)->stretch & FD_STRETCH)
+static DECLARE_MUTEX(open_lock);
 
-#define CLEARSTRUCT(x) memset((x), 0, sizeof(*(x)))
+static sector_t floppy_sizes[256];
 
-/* read/write */
-#define COMMAND raw_cmd->cmd[0]
-#define DR_SELECT raw_cmd->cmd[1]
-#define TRACK raw_cmd->cmd[2]
-#define HEAD raw_cmd->cmd[3]
-#define SECTOR raw_cmd->cmd[4]
-#define SIZECODE raw_cmd->cmd[5]
-#define SECT_PER_TRACK raw_cmd->cmd[6]
-#define GAP raw_cmd->cmd[7]
-#define SIZECODE2 raw_cmd->cmd[8]
-#define NR_RW 9
+static void (*do_floppy) (void) = NULL;
 
-/* format */
-#define F_SIZECODE raw_cmd->cmd[2]
-#define F_SECT_PER_TRACK raw_cmd->cmd[3]
-#define F_GAP raw_cmd->cmd[4]
-#define F_FILL raw_cmd->cmd[5]
-#define NR_F 6
 
 /*
- * Maximum disk size (in kilobytes). This default is used whenever the
- * current disk size is unknown.
- * [Now it is rather a minimum]
+ * The "reset" variable should be tested whenever an interrupt is scheduled,
+ * after the commands have been sent. This is to ensure that the driver doesn't
+ * get wedged when the interrupt doesn't come because of a failed command.
+ * reset doesn't need to be tested before sending commands, because
+ * output_byte is automatically disabled when reset is set.
  */
-#define MAX_DISK_SIZE 4		/* 3984 */
+static void reset_fdc(void);
+
+
+static struct cont_t {
+	void (*interrupt) (void);	/* this is called after the interrupt
+					 * of the main command */
+	void (*redo) (void);	/* this is called to retry the operation */
+	void (*error) (void);	/* this is called to tally an error */
+	done_f done;		/* this is called to say if the operation has
+				 * succeeded/failed */
+} *cont;
+
+/* Format request descriptor. */
+static struct format_descr format_req;
 
 /*
- * globals used by 'result()'
+ * User-provided type information. current_type points to
+ * the respective entry of this array.
  */
-#define MAX_REPLIES 16
-static unsigned char reply_buffer[MAX_REPLIES];
-static int inr;			/* size of reply buffer, when called from interrupt */
-#define ST0 (reply_buffer[0])
-#define ST1 (reply_buffer[1])
-#define ST2 (reply_buffer[2])
-#define ST3 (reply_buffer[0])	/* result of GETSTATUS */
-#define R_TRACK (reply_buffer[3])
-#define R_HEAD (reply_buffer[4])
-#define R_SECTOR (reply_buffer[5])
-#define R_SIZECODE (reply_buffer[6])
+static struct floppy_struct user_params[N_DRIVE];
 
-#define SEL_DLY (2*HZ/100)
+/* Auto-detection: Disk type used until the next media change occurs. */
+static struct floppy_struct *current_type[N_DRIVE];
 
 /*
  * this struct defines the different floppy drive types.
@@ -370,54 +396,44 @@
 } default_drive_params[] = {
 /* NOTE: the time values in jiffies should be in msec!
  CMOS drive type
-  |     Maximum data rate supported by drive type
-  |     |   Head load time, msec
-  |     |   |   Head unload time, msec (not used)
-  |     |   |   |     Step rate interval, usec
-  |     |   |   |     |       Time needed for spinup time (jiffies)
-  |     |   |   |     |       |      Timeout for spinning down (jiffies)
-  |     |   |   |     |       |      |   Spindown offset (where disk stops)
-  |     |   |   |     |       |      |   |     Select delay
-  |     |   |   |     |       |      |   |     |     RPS
-  |     |   |   |     |       |      |   |     |     |    Max number of tracks
-  |     |   |   |     |       |      |   |     |     |    |     Interrupt timeout
-  |     |   |   |     |       |      |   |     |     |    |     |   Max nonintlv. sectors
-  |     |   |   |     |       |      |   |     |     |    |     |   | -Max Errors- flags */
-{{0,  500, 16, 16, 8000,    1*HZ, 3*HZ,  0, SEL_DLY, 5,  80, 3*HZ, 20, {3,1,2,0,2}, 0,
+  |  Maximum data rate supported by drive type
+  |  |   Head load time, msec
+  |  |   |  Head unload time, msec (not used)
+  |  |   |  |  Step rate interval, usec
+  |  |   |  |  |       Time needed for spinup time (jiffies)
+  |  |   |  |  |       |     Timeout for spinning down (jiffies)
+  |  |   |  |  |       |     |     Spindown offset (where disk stops)
+  |  |   |  |  |       |     |     |  Select delay
+  |  |   |  |  |       |     |     |  |       RPS
+  |  |   |  |  |       |     |     |  |       |  Max number of tracks
+  |  |   |  |  |       |     |     |  |       |  |   Interrupt timeout
+  |  |   |  |  |       |     |     |  |       |  |   |   Max nonintlv. sectors
+  |  |   |  |  |       |     |     |  |       |  |   |   | -Max Errors- flags */
+{{0, 500,16,16,8000,    1*HZ,3*HZ, 0, SEL_DLY,5, 80, 3*HZ, 20, {3,1,2,0,2}, 0,
       0, { 7, 4, 8, 2, 1, 5, 3,10}, 3*HZ/2, 0 }, "unknown" },
 
-{{1,  300, 16, 16, 8000,    1*HZ, 3*HZ,  0, SEL_DLY, 5,  40, 3*HZ, 17, {3,1,2,0,2}, 0,
-      0, { 1, 0, 0, 0, 0, 0, 0, 0}, 3*HZ/2, 1 }, "360K PC" }, /*5 1/4 360 KB PC*/
+{{1, 300,16,16,8000,    1*HZ,3*HZ, 0, SEL_DLY,5, 40, 3*HZ, 17, {3,1,2,0,2}, 0,
+      0, { 1, 0, 0, 0, 0, 0, 0, 0}, 3*HZ/2, 1 }, "360K PC" },/*5 1/4 360 KB PC*/
 
-{{2,  500, 16, 16, 6000, 4*HZ/10, 3*HZ, 14, SEL_DLY, 6,  83, 3*HZ, 17, {3,1,2,0,2}, 0,
+{{2, 500,16,16,6000, 4*HZ/10,3*HZ,14, SEL_DLY,6, 83, 3*HZ, 17, {3,1,2,0,2}, 0,
       0, { 2, 5, 6,23,10,20,12, 0}, 3*HZ/2, 2 }, "1.2M" }, /*5 1/4 HD AT*/
 
-{{3,  250, 16, 16, 3000,    1*HZ, 3*HZ,  0, SEL_DLY, 5,  83, 3*HZ, 20, {3,1,2,0,2}, 0,
+{{3, 250,16,16,3000,    1*HZ, 3*HZ, 0, SEL_DLY,5, 83, 3*HZ, 20, {3,1,2,0,2}, 0,
       0, { 4,22,21,30, 3, 0, 0, 0}, 3*HZ/2, 4 }, "720k" }, /*3 1/2 DD*/
 
-{{4,  500, 16, 16, 4000, 4*HZ/10, 3*HZ, 10, SEL_DLY, 5,  83, 3*HZ, 20, {3,1,2,0,2}, 0,
+{{4, 500,16,16,4000, 4*HZ/10,3*HZ,10, SEL_DLY,5, 83, 3*HZ, 20, {3,1,2,0,2}, 0,
       0, { 7, 4,25,22,31,21,29,11}, 3*HZ/2, 7 }, "1.44M" }, /*3 1/2 HD*/
 
-{{5, 1000, 15,  8, 3000, 4*HZ/10, 3*HZ, 10, SEL_DLY, 5,  83, 3*HZ, 40, {3,1,2,0,2}, 0,
-      0, { 7, 8, 4,25,28,22,31,21}, 3*HZ/2, 8 }, "2.88M AMI BIOS" }, /*3 1/2 ED*/
+{{5,1000,15, 8,3000, 4*HZ/10,3*HZ,10, SEL_DLY,5, 83, 3*HZ, 40, {3,1,2,0,2}, 0,
+      0, { 7, 8, 4,25,28,22,31,21}, 3*HZ/2, 8 }, "2.88M AMI BIOS" },/*3 1/2 ED*/
 
-{{6, 1000, 15,  8, 3000, 4*HZ/10, 3*HZ, 10, SEL_DLY, 5,  83, 3*HZ, 40, {3,1,2,0,2}, 0,
+{{6,1000,15, 8,3000, 4*HZ/10,3*HZ,10, SEL_DLY,5, 83, 3*HZ, 40, {3,1,2,0,2}, 0,
       0, { 7, 8, 4,25,28,22,31,21}, 3*HZ/2, 8 }, "2.88M" } /*3 1/2 ED*/
 /*    |  --autodetected formats---    |      |      |
  *    read_track                      |      |    Name printed when booting
  *				      |     Native format
  *	            Frequency of disk change checks */
 };
-
-static struct floppy_drive_params drive_params[N_DRIVE];
-static struct floppy_drive_struct drive_state[N_DRIVE];
-static struct floppy_write_errors write_errors[N_DRIVE];
-static struct timer_list motor_off_timer[N_DRIVE];
-static struct gendisk *disks[N_DRIVE];
-static struct block_device *opened_bdev[N_DRIVE];
-static DECLARE_MUTEX(open_lock);
-static struct floppy_raw_cmd *raw_cmd, default_raw_cmd;
-
 /*
  * This struct defines the different floppy types.
  *
@@ -432,6 +448,7 @@
  * 'options'.  Other parameters should be self-explanatory (see also
  * setfdprm(8)).
  */
+ 
 /*
 	    Size
 	     |  Sectors per track
@@ -453,7 +470,6 @@
 	{ 2880,18,2,80,0,0x1B,0x00,0xCF,0x6C,"H1440" },	/*  7 1.44MB 3.5"   */
 	{ 5760,36,2,80,0,0x1B,0x43,0xAF,0x54,"E2880" },	/*  8 2.88MB 3.5"   */
 	{ 6240,39,2,80,0,0x1B,0x43,0xAF,0x28,"E3120" },	/*  9 3.12MB 3.5"   */
-
 	{ 2880,18,2,80,0,0x25,0x00,0xDF,0x02,"h1440" }, /* 10 1.44MB 5.25"  */
 	{ 3360,21,2,80,0,0x1C,0x00,0xCF,0x0C,"H1680" }, /* 11 1.68MB 3.5"   */
 	{  820,10,2,41,1,0x25,0x01,0xDF,0x2E,"h410"  },	/* 12 410KB 5.25"   */
@@ -464,7 +480,6 @@
 	{ 1660,10,2,83,0,0x25,0x02,0xDF,0x2E,"H830"  },	/* 17 830KB 3.5"    */
 	{ 2988,18,2,83,0,0x25,0x00,0xDF,0x02,"h1494" },	/* 18 1.49MB 5.25"  */
 	{ 3486,21,2,83,0,0x25,0x00,0xDF,0x0C,"H1743" }, /* 19 1.74 MB 3.5"  */
-
 	{ 1760,11,2,80,0,0x1C,0x09,0xCF,0x00,"h880"  }, /* 20 880KB 5.25"   */
 	{ 2080,13,2,80,0,0x1C,0x01,0xCF,0x00,"D1040" }, /* 21 1.04MB 3.5"   */
 	{ 2240,14,2,80,0,0x1C,0x19,0xCF,0x00,"D1120" }, /* 22 1.12MB 3.5"   */
@@ -474,128 +489,83 @@
 	{ 6400,40,2,80,0,0x25,0x5B,0xCF,0x00,"E3200" }, /* 26 3.20MB 3.5"   */
 	{ 7040,44,2,80,0,0x25,0x5B,0xCF,0x00,"E3520" }, /* 27 3.52MB 3.5"   */
 	{ 7680,48,2,80,0,0x25,0x63,0xCF,0x00,"E3840" }, /* 28 3.84MB 3.5"   */
-
 	{ 3680,23,2,80,0,0x1C,0x10,0xCF,0x00,"H1840" }, /* 29 1.84MB 3.5"   */
 	{ 1600,10,2,80,0,0x25,0x02,0xDF,0x2E,"D800"  },	/* 30 800KB 3.5"    */
 	{ 3200,20,2,80,0,0x1C,0x00,0xCF,0x2C,"H1600" }, /* 31 1.6MB 3.5"    */
 };
 
-#define	NUMBER(x)	(sizeof(x) / sizeof(*(x)))
-#define SECTSIZE (_FD_SECTSIZE(*floppy))
-
-/* Auto-detection: Disk type used until the next media change occurs. */
-static struct floppy_struct *current_type[N_DRIVE];
-
-/*
- * User-provided type information. current_type points to
- * the respective entry of this array.
- */
-static struct floppy_struct user_params[N_DRIVE];
-
-static sector_t floppy_sizes[256];
-
-/*
- * The driver is trying to determine the correct media format
- * while probing is set. rw_interrupt() clears it after a
- * successful access.
- */
-static int probing;
-
-/* Synchronization of FDC access. */
-#define FD_COMMAND_NONE -1
-#define FD_COMMAND_ERROR 2
-#define FD_COMMAND_OKAY 3
+static struct floppy_fdc_state fdc_state[N_FDC];
+static struct floppy_struct *_floppy = floppy_type;
+static struct completion device_release;
+static struct request *current_req;
+static struct request_queue *floppy_queue;
+static struct floppy_drive_params drive_params[N_DRIVE];
+static struct floppy_drive_struct drive_state[N_DRIVE];
+static struct floppy_write_errors write_errors[N_DRIVE];
+static struct timer_list motor_off_timer[N_DRIVE];
+static struct gendisk *disks[N_DRIVE];
+static struct block_device *opened_bdev[N_DRIVE];
+static struct floppy_raw_cmd *raw_cmd, default_raw_cmd;
+static struct timer_list fd_timeout = TIMER_INITIALIZER(floppy_shutdown, 0, 0);
+static struct timer_list fd_timer = TIMER_INITIALIZER(NULL, 0, 0);
 
-static volatile int command_status = FD_COMMAND_NONE;
-static unsigned long fdc_busy;
-static DECLARE_WAIT_QUEUE_HEAD(fdc_wait);
-static DECLARE_WAIT_QUEUE_HEAD(command_done);
 
+#define ITYPE(x) (((x)>>2) & 0x1f)
+#define TOMINOR(x) ((x & 3) | ((x & 4) << 5))
+#define UNIT(x) ((x) & 0x03)	/* drive on fdc */
+#define FDC(x) (((x) & 0x04) >> 2)	/* fdc of drive */
+#define DP (&drive_params[current_drive])
+#define DRS (&drive_state[current_drive])
+#define DRWE (&write_errors[current_drive])
+#define FDCS (&fdc_state[fdc])
+#define CLEARF(x) (clear_bit(x##_BIT, &DRS->flags))
+#define SETF(x) (set_bit(x##_BIT, &DRS->flags))
+#define TESTF(x) (test_bit(x##_BIT, &DRS->flags))
+#define UDP (&drive_params[drive])
+#define UDRS (&drive_state[drive])
+#define UDRWE (&write_errors[drive])
+#define UFDCS (&fdc_state[FDC(drive)])
+#define UCLEARF(x) (clear_bit(x##_BIT, &UDRS->flags))
+#define USETF(x) (set_bit(x##_BIT, &UDRS->flags))
+#define UTESTF(x) (test_bit(x##_BIT, &UDRS->flags))
+#define DPRINT(format, args...) printk(DEVICE_NAME "%d: " format,\
+		current_drive , ## args)
+#define PH_HEAD(floppy,head) (((((floppy)->stretch & 2) >>1) ^ head) << 2)
+#define STRETCH(floppy) ((floppy)->stretch & FD_STRETCH)
+#define CLEARSTRUCT(x) memset((x), 0, sizeof(*(x)))
+#define COMMAND raw_cmd->cmd[0]
+#define DR_SELECT raw_cmd->cmd[1]
+#define TRACK raw_cmd->cmd[2]
+#define HEAD raw_cmd->cmd[3]
+#define SECTOR raw_cmd->cmd[4]
+#define SIZECODE raw_cmd->cmd[5]
+#define SECT_PER_TRACK raw_cmd->cmd[6]
+#define GAP raw_cmd->cmd[7]
+#define SIZECODE2 raw_cmd->cmd[8]
+#define ST0 (reply_buffer[0])
+#define ST1 (reply_buffer[1])
+#define ST2 (reply_buffer[2])
+#define ST3 (reply_buffer[0])	/* result of GETSTATUS */
+#define R_TRACK (reply_buffer[3])
+#define R_HEAD (reply_buffer[4])
+#define R_SECTOR (reply_buffer[5])
+#define R_SIZECODE (reply_buffer[6])
+#define	NUMBER(x)	(sizeof(x) / sizeof(*(x)))
+#define INFBOUND(a,b) (a)=max_t(int, a, b)
+#define SUPBOUND(a,b) (a)=min_t(int, a, b)
 #define NO_SIGNAL (!interruptible || !signal_pending(current))
 #define CALL(x) if ((x) == -EINTR) return -EINTR
 #define ECALL(x) if ((ret = (x))) return ret;
 #define _WAIT(x,i) CALL(ret=wait_til_done((x),i))
 #define WAIT(x) _WAIT((x),interruptible)
-#define IWAIT(x) _WAIT((x),1)
-
-/* Errors during formatting are counted here. */
-static int format_errors;
-
-/* Format request descriptor. */
-static struct format_descr format_req;
-
-/*
- * Rate is 0 for 500kb/s, 1 for 300kbps, 2 for 250kbps
- * Spec1 is 0xSH, where S is stepping rate (F=1ms, E=2ms, D=3ms etc),
- * H is head unload time (1=16ms, 2=32ms, etc)
- */
-
-/*
- * Track buffer
- * Because these are written to by the DMA controller, they must
- * not contain a 64k byte boundary crossing, or data will be
- * corrupted/lost.
- */
-static char *floppy_track_buffer;
-static int max_buffer_sectors;
-
-static int *errors;
-typedef void (*done_f) (int);
-static struct cont_t {
-	void (*interrupt) (void);	/* this is called after the interrupt of the
-					 * main command */
-	void (*redo) (void);	/* this is called to retry the operation */
-	void (*error) (void);	/* this is called to tally an error */
-	done_f done;		/* this is called to say if the operation has
-				 * succeeded/failed */
-} *cont;
-
-static void floppy_ready(void);
-static void floppy_start(void);
-static void process_fd_request(void);
-static void recalibrate_floppy(void);
-static void floppy_shutdown(unsigned long);
-
-static int floppy_grab_irq_and_dma(void);
-static void floppy_release_irq_and_dma(void);
-
-/*
- * The "reset" variable should be tested whenever an interrupt is scheduled,
- * after the commands have been sent. This is to ensure that the driver doesn't
- * get wedged when the interrupt doesn't come because of a failed command.
- * reset doesn't need to be tested before sending commands, because
- * output_byte is automatically disabled when reset is set.
- */
-#define CHECK_RESET { if (FDCS->reset){ reset_fdc(); return; } }
-static void reset_fdc(void);
-
-/*
- * These are global variables, as that's the easiest way to give
- * information to interrupts. They are the data used for the current
- * request.
- */
-#define NO_TRACK -1
-#define NEED_1_RECAL -2
-#define NEED_2_RECAL -3
-
-static int usage_count;
-
-/* buffer related variables */
-static int buffer_track = -1;
-static int buffer_drive = -1;
-static int buffer_min = -1;
-static int buffer_max = -1;
-
-/* fdc related variables, should end up in a struct */
-static struct floppy_fdc_state fdc_state[N_FDC];
-static int fdc;			/* current fdc */
+#define lock_fdc(drive,interruptible) _lock_fdc(drive,interruptible, __LINE__)
+#define LOCK_FDC(drive,interruptible) \
+		if (lock_fdc(drive,interruptible)) return -EINTR;
+#define LAST_OUT(x) if (output_byte(x)<0){ reset_fdc();return;}
+#define CODE2SIZE (ssize = ((1 << SIZECODE) + 3) >> 2)
+#define FM_MODE(x,y) ((y) & ~(((x)->rate & 0x80) >>1))
+#define CT(x) ((x) | 0xc0)
 
-static struct floppy_struct *_floppy = floppy_type;
-static unsigned char current_drive;
-static long current_count_sectors;
-static unsigned char fsector_t;	/* sector in track */
-static unsigned char in_sector_offset;	/* offset within physical sector,
-					 * expressed in units of 512 bytes */
 
 #ifndef fd_eject
 static inline int fd_eject(int drive)
@@ -604,6 +574,7 @@
 }
 #endif
 
+
 /*
  * Debugging
  * =========
@@ -626,10 +597,6 @@
 static inline void debugt(const char *message) { }
 #endif /* DEBUGT */
 
-typedef void (*timeout_fn) (unsigned long);
-static struct timer_list fd_timeout = TIMER_INITIALIZER(floppy_shutdown, 0, 0);
-
-static const char *timeout_message;
 
 #ifdef FLOPPY_SANITY_CHECK
 static void is_alive(const char *message)
@@ -642,8 +609,6 @@
 }
 #endif
 
-static void (*do_floppy) (void) = NULL;
-
 #ifdef FLOPPY_SANITY_CHECK
 
 #define OLOGSIZE 20
@@ -663,12 +628,42 @@
 static int output_log_pos;
 #endif
 
-#define current_reqD -1
-#define MAXTIMEOUT -2
+
+/* Dma Memory related stuff */
+
+#ifndef fd_get_dma_residue
+#define fd_get_dma_residue() get_dma_residue(FLOPPY_DMA)
+#endif
+
+#ifndef fd_dma_mem_free
+#define fd_dma_mem_free(addr, size) free_pages(addr, get_order(size))
+#endif
+
+#ifndef fd_dma_mem_alloc
+#define fd_dma_mem_alloc(size) __get_dma_pages(GFP_KERNEL,get_order(size))
+#endif
+
+static inline void fallback_on_nodma_alloc(char **addr, size_t l)
+{
+#ifdef FLOPPY_CAN_FALLBACK_ON_NODMA
+	if (*addr)
+		return;		/* we have the memory */
+	if (can_use_virtual_dma != 2)
+		return;		/* no fallback allowed */
+	printk
+	    ("DMA memory shortage. Temporarily falling back on virtual DMA\n");
+	*addr = (char *)nodma_mem_alloc(l);
+#else
+	return;
+#endif
+}
+
+/* End dma memory related stuff */
+
 
 static void __reschedule_timeout(int drive, const char *message, int marg)
 {
-	if (drive == current_reqD)
+	if (drive == CURRENT_REQD)
 		drive = current_drive;
 	del_timer(&fd_timeout);
 	if (drive < 0 || drive > N_DRIVE) {
@@ -694,9 +689,6 @@
 	spin_unlock_irqrestore(&floppy_lock, flags);
 }
 
-#define INFBOUND(a,b) (a)=max_t(int, a, b)
-
-#define SUPBOUND(a,b) (a)=min_t(int, a, b)
 
 /*
  * Bottom half floppy driver.
@@ -788,6 +780,9 @@
 
 static int set_dor(int fdc, char mask, char data)
 {
+/* macros used in set_dor() */
+#define REVDRIVE(fdc, unit) ((unit) + ((fdc) << 2))
+				/* reverse mapping from unit and fdc to drive */
 	register unsigned char drive, unit, newdor, olddor;
 
 	if (FDCS->address == -1)
@@ -825,6 +820,7 @@
 	if (olddor & FLOPPY_MOTOR_MASK)
 		floppy_release_irq_and_dma();
 	return olddor;
+#undef REVDRIVE
 }
 
 static void twaddle(void)
@@ -912,11 +908,6 @@
 	return 0;
 }
 
-#define lock_fdc(drive,interruptible) _lock_fdc(drive,interruptible, __LINE__)
-
-#define LOCK_FDC(drive,interruptible) \
-if (lock_fdc(drive,interruptible)) return -EINTR;
-
 /* unlocks the driver */
 static inline void unlock_fdc(void)
 {
@@ -1011,8 +1002,6 @@
 	schedule_work(&floppy_work);
 }
 
-static struct timer_list fd_timer = TIMER_INITIALIZER(NULL, 0, 0);
-
 static void cancel_activity(void)
 {
 	unsigned long flags;
@@ -1073,8 +1062,6 @@
 	return 0;
 }
 
-static spinlock_t floppy_hlt_lock = SPIN_LOCK_UNLOCKED;
-static int hlt_disabled;
 static void floppy_disable_hlt(void)
 {
 	unsigned long flags;
@@ -1152,8 +1139,6 @@
 	floppy_disable_hlt();
 }
 
-static void show_floppy(void);
-
 /* waits until the fdc becomes ready */
 static int wait_til_ready(void)
 {
@@ -1199,8 +1184,6 @@
 	return -1;
 }
 
-#define LAST_OUT(x) if (output_byte(x)<0){ reset_fdc();return;}
-
 /* gets the response from the fdc */
 static int result(void)
 {
@@ -1232,8 +1215,6 @@
 	return -1;
 }
 
-#define MORE_OUTPUT -2
-/* does the fdc need more output? */
 static int need_more_output(void)
 {
 	int status;
@@ -1281,9 +1262,6 @@
 	}
 }				/* perpendicular_mode */
 
-static int fifo_depth = 0xa;
-static int no_fifo;
-
 static int fdc_configure(void)
 {
 	/* Turn on FIFO */
@@ -1297,7 +1275,6 @@
 	return 1;
 }
 
-#define NOMINAL_DTR 500
 
 /* Issue a "SPECIFY" command to set the step rate time, head unload time,
  * head load time, and DMA disable flag to values needed by floppy.
@@ -1320,6 +1297,8 @@
  */
 static void fdc_specify(void)
 {
+/* constant used in fdc_specify() */
+#define NOMINAL_DTR 500
 	unsigned char spec1, spec2;
 	unsigned long srt, hlt, hut;
 	unsigned long dtr = NOMINAL_DTR;
@@ -1390,6 +1369,7 @@
 		output_byte(FDCS->spec1 = spec1);
 		output_byte(FDCS->spec2 = spec2);
 	}
+#undef NOMINAL_DTR
 }				/* fdc_specify */
 
 /* Set the FDC's data transfer rate on behalf of the specified drive.
@@ -1560,8 +1540,6 @@
 		fd_watchdog();
 }
 
-static int blind_seek;
-
 /*
  * This is the routine called after every seek (or recalibrate) interrupt
  * from the floppy controller.
@@ -1922,8 +1900,6 @@
 	is_alive("floppy shutdown");
 }
 
-/*typedef void (*timeout_fn)(unsigned long);*/
-
 /* start motor, check media-changed condition and write protection */
 static int start_motor(void (*function) (void))
 {
@@ -1954,6 +1930,8 @@
 
 static void floppy_ready(void)
 {
+/* macros used in floppy_ready() */
+#define CHECK_RESET { if (FDCS->reset){ reset_fdc(); return; } }
 	CHECK_RESET;
 	if (start_motor(floppy_ready))
 		return;
@@ -1988,11 +1966,12 @@
 			fdc_specify();
 		setup_rw_floppy();
 	}
+#undef CHECK_RESET
 }
 
 static void floppy_start(void)
 {
-	reschedule_timeout(current_reqD, "floppy start", 0);
+	reschedule_timeout(CURRENT_REQD, "floppy start", 0);
 
 	scandrives();
 #ifdef DCL_DEBUG
@@ -2007,10 +1986,7 @@
 /*
  * ========================================================================
  * here ends the bottom half. Exported routines are:
- * floppy_start, floppy_off, floppy_ready, lock_fdc, unlock_fdc, set_fdc,
- * start_motor, reset_fdc, reset_fdc_info, interpret_errors.
- * Initialization also uses output_byte, result, set_dor, floppy_interrupt
- * and set_dor.
+ * floppy_interrupt.
  * ========================================================================
  */
 /*
@@ -2174,11 +2150,13 @@
 	cont->redo();
 }
 
-#define CODE2SIZE (ssize = ((1 << SIZECODE) + 3) >> 2)
-#define FM_MODE(x,y) ((y) & ~(((x)->rate & 0x80) >>1))
-#define CT(x) ((x) | 0xc0)
 static void setup_format_params(int track)
 {
+/* macros for setup_format_params() */
+#define F_SIZECODE raw_cmd->cmd[2]
+#define F_SECT_PER_TRACK raw_cmd->cmd[3]
+#define F_GAP raw_cmd->cmd[4]
+#define F_FILL raw_cmd->cmd[5]
 	struct fparm {
 		unsigned char track, head, sect, size;
 	} *here = (struct fparm *)floppy_track_buffer;
@@ -2241,6 +2219,10 @@
 		for (count = 0; count < F_SECT_PER_TRACK; count++)
 			here[count].sect--;
 	}
+#undef F_SIZECODE
+#undef F_SECT_PER_TRACK
+#undef F_GAP
+#undef F_FILL
 }
 
 static void redo_format(void)
@@ -2260,6 +2242,8 @@
 
 static int do_format(int drive, struct format_descr *tmp_format_req)
 {
+/* macros used in do_format() */
+#define IWAIT(x) _WAIT((x),1)
 	int ret;
 
 	LOCK_FDC(drive, 1);
@@ -2280,6 +2264,7 @@
 	IWAIT(redo_format);
 	process_fd_request();
 	return ret;
+#undef IWAIT
 }
 
 /*
@@ -2607,8 +2592,8 @@
 			return;
 		}
 #endif
-		SECT_PER_TRACK = end_sector;	/* make sure SECT_PER_TRACK points
-						 * to end of transfer */
+		SECT_PER_TRACK = end_sector;	/* make sure SECT_PER_TRACK
+						 * points to end of transfer */
 	}
 }
 
@@ -2786,10 +2771,10 @@
 			raw_cmd->kernel_data = current_req->buffer;
 			raw_cmd->length = current_count_sectors << 9;
 			if (raw_cmd->length == 0) {
-				DPRINT
-				    ("zero dma transfer attempted from make_raw_request\n");
+				DPRINT("zero dma transfer attempted from"
+						" make_raw_request\n");
 				DPRINT("indirect=%d direct=%d fsector_t=%d",
-				       indirect, direct, fsector_t);
+						indirect, direct, fsector_t);
 				return 0;
 			}
 /*			check_dma_crossing(raw_cmd->kernel_data, 
@@ -2911,6 +2896,7 @@
 
 static void redo_fd_request(void)
 {
+/* macro used in redo_fd_request() */
 #define REPEAT {request_done(0); continue; }
 	int drive;
 	int tmp;
@@ -2935,7 +2921,7 @@
 		}
 		drive = (long)current_req->rq_disk->private_data;
 		set_fdc(drive);
-		reschedule_timeout(current_reqD, "redo fd request", 0);
+		reschedule_timeout(CURRENT_REQD, "redo fd request", 0);
 
 		set_floppy(drive);
 		raw_cmd = &default_raw_cmd;
@@ -3085,17 +3071,12 @@
 	return copy_to_user(param, address, size) ? -EFAULT : 0;
 }
 
-static inline int fd_copyin(void __user *param, void *address, unsigned long size)
+static inline int fd_copyin(void __user *param, void *address,
+		unsigned long size)
 {
 	return copy_from_user(address, param, size) ? -EFAULT : 0;
 }
 
-#define _COPYOUT(x) (copy_to_user((void __user *)param, &(x), sizeof(x)) ? -EFAULT : 0)
-#define _COPYIN(x) (copy_from_user(&(x), (void __user *)param, sizeof(x)) ? -EFAULT : 0)
-
-#define COPYOUT(x) ECALL(_COPYOUT(x))
-#define COPYIN(x) ECALL(_COPYIN(x))
-
 static inline const char *drive_name(int type, int drive)
 {
 	struct floppy_struct *floppy;
@@ -3166,6 +3147,14 @@
 	.done		= raw_cmd_done
 };
 
+/* macros used in ioctl processing */
+#define _COPYOUT(x) (copy_to_user((void __user *)param, &(x), sizeof(x))\
+		? -EFAULT : 0)
+#define _COPYIN(x) (copy_from_user(&(x), (void __user *)param, sizeof(x))\
+		? -EFAULT : 0)
+#define COPYOUT(x) ECALL(_COPYOUT(x))
+#define COPYIN(x) ECALL(_COPYIN(x))
+
 static inline int raw_cmd_copyout(int cmd, char __user *param,
 				  struct floppy_raw_cmd *ptr)
 {
@@ -3622,10 +3611,16 @@
 		return fd_copyout((void __user *)param, outparam, size);
 	else
 		return 0;
+#undef FD_IOCTL_ALLOWED
 #undef OUT
 #undef IN
 }
 
+#undef _COPYOUT
+#undef _COPYIN
+#undef COPYOUT
+#undef COPYIN
+
 static void __init config_types(void)
 {
 	int first = 1;
@@ -3899,8 +3894,9 @@
  * geometry formats */
 static int floppy_revalidate(struct gendisk *disk)
 {
-	int drive = (long)disk->private_data;
+/* macro used in floppy_revalidate */
 #define NO_GEOM (!current_type[drive] && !ITYPE(UDRS->fd_device))
+	int drive = (long)disk->private_data;
 	int cf;
 	int res = 0;
 
@@ -3913,7 +3909,7 @@
 		lock_fdc(drive, 0);
 		cf = UTESTF(FD_DISK_CHANGED) || UTESTF(FD_VERIFY);
 		if (!(cf || test_bit(drive, &fake_change) || NO_GEOM)) {
-			process_fd_request();	/*already done by another thread */
+			process_fd_request(); /*already done by another thread*/
 			return 0;
 		}
 		UDRS->maxblock = 0;
@@ -3935,6 +3931,7 @@
 	}
 	set_capacity(disk, floppy_sizes[UDRS->fd_device]);
 	return res;
+#undef NO_GEOM
 }
 
 static struct block_device_operations floppy_fops = {
@@ -3945,20 +3942,6 @@
 	.media_changed	= check_floppy_change,
 	.revalidate_disk = floppy_revalidate,
 };
-static char *table[] = {
-	"", "d360", "h1200", "u360", "u720", "h360", "h720",
-	"u1440", "u2880", "CompaQ", "h1440", "u1680", "h410",
-	"u820", "h1476", "u1722", "h420", "u830", "h1494", "u1743",
-	"h880", "u1040", "u1120", "h1600", "u1760", "u1920",
-	"u3200", "u3520", "u3840", "u1840", "u800", "u1600",
-	NULL
-};
-static int t360[] = { 1, 0 },
-	t1200[] = { 2, 5, 6, 10, 12, 14, 16, 18, 20, 23, 0 },
-	t3in[] = { 8, 9, 26, 27, 28, 7, 11, 15, 19, 24, 25, 29, 31, 3, 4, 13,
-			17, 21, 22, 30, 0 };
-static int *table_sup[] =
-    { NULL, t360, t1200, t3in + 5 + 8, t3in + 5, t3in, t3in };
 
 static void __init register_devfs_entries(int drive)
 {
@@ -4038,7 +4021,7 @@
 	}
 	if (reply_buffer[0] == 0x80) {
 		printk(KERN_INFO "FDC %d is a post-1991 82077\n", fdc);
-		return FDC_82077;	/* Revised 82077AA passes all the tests */
+		return FDC_82077;  /* Revised 82077AA passes all the tests */
 	}
 	switch (reply_buffer[0] >> 5) {
 	case 0x0:
@@ -4125,8 +4108,8 @@
 	int def_param;
 	int param2;
 } config_params[] = {
-	{"allowed_drive_mask", NULL, &allowed_drive_mask, 0xff, 0}, /* obsolete */
-	{"all_drives", NULL, &allowed_drive_mask, 0xff, 0},	/* obsolete */
+	{"allowed_drive_mask", NULL, &allowed_drive_mask, 0xff, 0},/* obsolete*/
+	{"all_drives", NULL, &allowed_drive_mask, 0xff, 0},	   /* obsolete*/
 	{"asus_pci", NULL, &allowed_drive_mask, 0x33, 0},
 	{"irq", NULL, &FLOPPY_IRQ, 6, 0},
 	{"dma", NULL, &FLOPPY_DMA, 2, 0},
@@ -4194,8 +4177,6 @@
 	return 0;
 }
 
-static int have_no_fdc = -ENODEV;
-
 static void floppy_device_release(struct device *dev)
 {
 	complete(&device_release);
