Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbSKBRu6>; Sat, 2 Nov 2002 12:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSKBRu6>; Sat, 2 Nov 2002 12:50:58 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:57683 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261327AbSKBRs5>; Sat, 2 Nov 2002 12:48:57 -0500
Date: Sun, 3 Nov 2002 02:55:07 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC][Patchset 6/20] Support for PC-9800 (floppy1)
Message-ID: <20021103025507.K1536@precia.cinet.co.jp>
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

This is a part 6/20 of patchset for add support NEC PC-9800 architecture,
against 2.5.45.

floppy98.c is splited to 2 patches. Please apply this before floppy2.

Summary:
  floppy driver modules
   - add PC-9800 standard FDD support.
     based on floppy.c, enhanced media check and auto detect.

diffstat:
  drivers/block/Makefile   |    4  drivers/block/floppy98.c | 2337 +++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 2341 insertions(+)

patch:
diff -urN linux/drivers/block/Makefile linux98/drivers/block/Makefile
--- linux/drivers/block/Makefile	Wed Oct 16 13:20:33 2002
+++ linux98/drivers/block/Makefile	Wed Oct 16 14:56:42 2002
@@ -14,7 +14,11 @@
  obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o deadline-iosched.o
   obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
+ifneq ($(CONFIG_PC9800),y)
  obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
+else
+obj-$(CONFIG_BLK_DEV_FD)	+= floppy98.o
+endif
  obj-$(CONFIG_AMIGA_FLOPPY)	+= amiflop.o
  obj-$(CONFIG_ATARI_FLOPPY)	+= ataflop.o
  obj-$(CONFIG_BLK_DEV_SWIM_IOP)	+= swim_iop.o
diff -urN linux/drivers/block/floppy98.c linux98/drivers/block/floppy98.c
--- linux/drivers/block/floppy98.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/block/floppy98.c	Thu Oct 31 16:11:27 2002
@@ -0,0 +1,2337 @@
+/*
+ *  linux/drivers/block/floppy.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *  Copyright (C) 1993, 1994  Alain Knaff
+ *  Copyright (C) 1998 Alan Cox
+ */
+/*
+ * 02.12.91 - Changed to static variables to indicate need for reset
+ * and recalibrate. This makes some things easier (output_byte reset
+ * checking etc), and means less interrupt jumping in case of errors,
+ * so the code is hopefully easier to understand.
+ */
+
+/*
+ * This file is certainly a mess. I've tried my best to get it working,
+ * but I don't like programming floppies, and I have only one anyway.
+ * Urgel. I should check for more errors, and do more graceful error
+ * recovery. Seems there are problems with several drives. I've tried to
+ * correct them. No promises.
+ */
+
+/*
+ * As with hd.c, all routines within this file can (and will) be called
+ * by interrupts, so extreme caution is needed. A hardware interrupt
+ * handler may not sleep, or a kernel panic will happen. Thus I cannot
+ * call "floppy-on" directly, but have to set a special timer interrupt
+ * etc.
+ */
+
+/*
+ * 28.02.92 - made track-buffering routines, based on the routines written
+ * by entropy@wintermute.wpi.edu (Lawrence Foard). Linus.
+ */
+
+/*
+ * Automatic floppy-detection and formatting written by Werner Almesberger
+ * (almesber@nessie.cs.id.ethz.ch), who also corrected some problems with
+ * the floppy-change signal detection.
+ */
+
+/*
+ * 1992/7/22 -- Hennus Bergman: Added better error reporting, fixed
+ * FDC data overrun bug, added some preliminary stuff for vertical
+ * recording support.
+ *
+ * 1992/9/17: Added DMA allocation & DMA functions. -- hhb.
+ *
+ * TODO: Errors are still not counted properly.
+ */
+
+/* 1992/9/20
+ * Modifications for ``Sector Shifting'' by Rob Hooft (hooft@chem.ruu.nl)
+ * modeled after the freeware MS-DOS program fdformat/88 V1.8 by
+ * Christoph H. Hochst\"atter.
+ * I have fixed the shift values to the ones I always use. Maybe a new
+ * ioctl() should be created to be able to modify them.
+ * There is a bug in the driver that makes it impossible to format a
+ * floppy as the first thing after bootup.
+ */
+
+/*
+ * 1993/4/29 -- Linus -- cleaned up the timer handling in the kernel, and
+ * this helped the floppy driver as well. Much cleaner, and still seems to
+ * work.
+ */
+
+/* 1994/6/24 --bbroad-- added the floppy table entries and made
+ * minor modifications to allow 2.88 floppies to be run.
+ */
+
+/* 1994/7/13 -- Paul Vojta -- modified the probing code to allow three or more
+ * disk types.
+ */
+
+/*
+ * 1994/8/8 -- Alain Knaff -- Switched to fdpatch driver: Support for bigger
+ * format bug fixes, but unfortunately some new bugs too...
+ */
+
+/* 1994/9/17 -- Koen Holtman -- added logging of physical floppy write
+ * errors to allow safe writing by specialized programs.
+ */
+
+/* 1995/4/24 -- Dan Fandrich -- added support for Commodore 1581 3.5" disks
+ * by defining bit 1 of the "stretch" parameter to mean put sectors on the
+ * opposite side of the disk, leaving the sector IDs alone (i.e. Commodore's
+ * drives are "upside-down").
+ */
+
+/*
+ * 1995/8/26 -- Andreas Busse -- added Mips support.
+ */
+
+/*
+ * 1995/10/18 -- Ralf Baechle -- Portability cleanup; move machine dependent
+ * features to asm/floppy.h.
+ */
+
+/*
+ * 1998/05/07 -- Russell King -- More portability cleanups; moved definition of
+ * interrupt and dma channel to asm/floppy.h. Cleaned up some formatting &
+ * use of '0' for NULL.
+ */
+ +/*
+ * 1998/06/07 -- Alan Cox -- Merged the 2.0.34 fixes for resource allocation
+ * failures.
+ */
+
+/*
+ * 1998/09/20 -- David Weinehall -- Added slow-down code for buggy PS/2-drives.
+ */
+
+/*
+ * 1999/01/19 -- N.Fujita & Linux/98 Project -- Added code for NEC PC-9800
+ * series.
+ */
+
+/*
+ * 1999/08/13 -- Paul Slootman -- floppy stopped working on Alpha after 24
+ * days, 6 hours, 32 minutes and 32 seconds (i.e. MAXINT jiffies; ints were
+ * being used to store jiffies, which are unsigned longs).
+ */
+
+/*
+ * 2000/08/28 -- Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ * - get rid of check_region
+ * - s/suser/capable/
+ */
+
+/*
+ * 2001/08/26 -- Paul Gortmaker - fix insmod oops on machines with no
+ * floppy controller (lingering task on list after module is gone... boom.)
+ */
+
+/*
+ * 2002/02/07 -- Anton Altaparmakov - Fix io ports reservation to correct range
+ * (0x3f2-0x3f5, 0x3f7). This fix is a bit of a hack but the proper fix
+ * requires many non-obvious changes in arch dependent code.
+ */
+
+/*
+ * 2002/10/12 -- Osamu Tomita <tomita@cinet.co.jp>
+ * split code from floppy.c
+ * support NEC PC-9800 only
+ */
+
+#define FLOPPY_SANITY_CHECK
+#undef  FLOPPY_SILENT_DCL_CLEAR
+
+/*
+#define PC9800_DEBUG_FLOPPY
+#define PC9800_DEBUG_FLOPPY2
+*/
+
+#define REALLY_SLOW_IO
+
+#define DEBUGT 2
+#define DCL_DEBUG /* debug disk change line */
+
+/* do print messages for unexpected interrupts */
+static int print_unex=1;
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+#define FDPATCHES
+#include <linux/fdreg.h>
+
+/*
+ * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
+ */
+
+
+#include <linux/fd.h>
+#include <linux/hdreg.h>
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/bio.h>
+#include <linux/string.h>
+#include <linux/fcntl.h>
+#include <linux/delay.h>
+#include <linux/mc146818rtc.h> /* CMOS defines */
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
+#include <linux/buffer_head.h>		/* for invalidate_buffers() */
+
+/*
+ * PS/2 floppies have much slower step rates than regular floppies.
+ * It's been recommended that take about 1/4 of the default speed
+ * in some more extreme cases.
+ */
+static int slow_floppy;
+
+#include <asm/dma.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#ifndef DEFAULT_FLOPPY_IRQ
+# define DEFAULT_FLOPPY_IRQ	11
+#endif
+#ifndef DEFAULT_FLOPPY_DMA
+# define DEFAULT_FLOPPY_DMA	2
+#endif
+
+static int FLOPPY_IRQ=DEFAULT_FLOPPY_IRQ;
+static int FLOPPY_DMA=DEFAULT_FLOPPY_DMA;
+static int can_use_virtual_dma=2;
+static int auto_detect_mode = 0;
+static int retry_auto_detect = 0;
+#define FD_AFTER_RESET_DELAY 1000
+
+/* =======
+ * can use virtual DMA:
+ * 0 = use of virtual DMA disallowed by config
+ * 1 = use of virtual DMA prescribed by config
+ * 2 = no virtual DMA preference configured.  By default try hard DMA,
+ * but fall back on virtual DMA when not enough memory available
+ */
+
+static int use_virtual_dma;
+/* =======
+ * use virtual DMA
+ * 0 using hard DMA
+ * 1 using virtual DMA
+ * This variable is set to virtual when a DMA mem problem arises, and
+ * reset back in floppy_grab_irq_and_dma.
+ * It is not safe to reset it in other circumstances, because the floppy
+ * driver may have several buffers in use at once, and we do currently not
+ * record each buffers capabilities
+ */
+
+static spinlock_t floppy_lock = SPIN_LOCK_UNLOCKED;
+
+static unsigned short virtual_dma_port=0x3f0;
+void floppy_interrupt(int irq, void *dev_id, struct pt_regs * regs);
+static int set_mode(char mask, char data);
+static void register_devfs_entries (int drive) __init;
+static devfs_handle_t devfs_handle;
+
+#define K_64	0x10000		/* 64KB */
+
+/* the following is the mask of allowed drives. By default units 2 and
+ * 3 of both floppy controllers are disabled, because switching on the
+ * motor of these drives causes system hangs on some PCI computers. drive
+ * 0 is the low bit (0x1), and drive 7 is the high bit (0x80). Bits are on if
+ * a drive is allowed.
+ *
+ * NOTE: This must come before we include the arch floppy header because
+ *       some ports reference this variable from there. -DaveM
+ */
+
+static int allowed_drive_mask = 0x0f;
+
+#include <asm/floppy.h>
+
+static int irqdma_allocated;
+
+#define LOCAL_END_REQUEST
+#define MAJOR_NR FLOPPY_MAJOR
+#define DEVICE_NAME "floppy"
+#define DEVICE_NR(device) ( (minor(device) & 3) | ((minor(device) & 0x80 ) >> 5 ))
+#include <linux/blk.h>
+#include <linux/blkpg.h>
+#include <linux/cdrom.h> /* for the compatibility eject ioctl */
+#include <linux/completion.h>
+
+static struct request *current_req;
+static struct request_queue floppy_queue;
+
+#ifndef fd_get_dma_residue
+#define fd_get_dma_residue() get_dma_residue(FLOPPY_DMA)
+#endif
+
+/* Dma Memory related stuff */
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
+		return; /* we have the memory */
+	if (can_use_virtual_dma != 2)
+		return; /* no fallback allowed */
+	printk("DMA memory shortage. Temporarily falling back on virtual DMA\n");
+	*addr = (char *) nodma_mem_alloc(l);
+#else
+	return;
+#endif
+}
+
+/* End dma memory related stuff */
+
+static unsigned long fake_change;
+static int initialising=1;
+
+static inline int TYPE(kdev_t x) {
+	return  (minor(x)>>2) & 0x1f;
+}
+static inline int DRIVE(kdev_t x) {
+	return (minor(x)&0x03) | ((minor(x)&0x80) >> 5);
+}
+#define ITYPE(x) (((x)>>2) & 0x1f)
+#define TOMINOR(x) ((x & 3) | ((x & 4) << 5))
+#define UNIT(x) ((x) & 0x03)		/* drive on fdc */
+#define FDC(x) (((x) & 0x04) >> 2)  /* fdc of drive */
+#define REVDRIVE(fdc, unit) ((unit) + ((fdc) << 2))
+				/* reverse mapping from unit and fdc to drive */
+#define DP (&drive_params[current_drive])
+#define DRS (&drive_state[current_drive])
+#define DRWE (&write_errors[current_drive])
+#define FDCS (&fdc_state[fdc])
+#define CLEARF(x) (clear_bit(x##_BIT, &DRS->flags))
+#define SETF(x) (set_bit(x##_BIT, &DRS->flags))
+#define TESTF(x) (test_bit(x##_BIT, &DRS->flags))
+
+#define UDP (&drive_params[drive])
+#define UDRS (&drive_state[drive])
+#define UDRWE (&write_errors[drive])
+#define UFDCS (&fdc_state[FDC(drive)])
+#define UCLEARF(x) (clear_bit(x##_BIT, &UDRS->flags))
+#define USETF(x) (set_bit(x##_BIT, &UDRS->flags))
+#define UTESTF(x) (test_bit(x##_BIT, &UDRS->flags))
+
+#define DPRINT(format, args...) printk(DEVICE_NAME "%d: " format, current_drive , ## args)
+
+#define PH_HEAD(floppy,head) (((((floppy)->stretch & 2) >>1) ^ head) << 2)
+#define STRETCH(floppy) ((floppy)->stretch & FD_STRETCH)
+
+#define CLEARSTRUCT(x) memset((x), 0, sizeof(*(x)))
+
+/* read/write */
+#define COMMAND raw_cmd->cmd[0]
+#define DR_SELECT raw_cmd->cmd[1]
+#define TRACK raw_cmd->cmd[2]
+#define HEAD raw_cmd->cmd[3]
+#define SECTOR raw_cmd->cmd[4]
+#define SIZECODE raw_cmd->cmd[5]
+#define SECT_PER_TRACK raw_cmd->cmd[6]
+#define GAP raw_cmd->cmd[7]
+#define SIZECODE2 raw_cmd->cmd[8]
+#define NR_RW 9
+
+/* format */
+#define F_SIZECODE raw_cmd->cmd[2]
+#define F_SECT_PER_TRACK raw_cmd->cmd[3]
+#define F_GAP raw_cmd->cmd[4]
+#define F_FILL raw_cmd->cmd[5]
+#define NR_F 6
+
+/*
+ * Maximum disk size (in kilobytes). This default is used whenever the
+ * current disk size is unknown.
+ * [Now it is rather a minimum]
+ */
+#define MAX_DISK_SIZE 4 /* 3984*/
+
+
+/*
+ * globals used by 'result()'
+ */
+#define MAX_REPLIES 16
+static unsigned char reply_buffer[MAX_REPLIES];
+static int inr; /* size of reply buffer, when called from interrupt */
+#define ST0 (reply_buffer[0])
+#define ST1 (reply_buffer[1])
+#define ST2 (reply_buffer[2])
+#define ST3 (reply_buffer[0]) /* result of GETSTATUS */
+#define R_TRACK (reply_buffer[3])
+#define R_HEAD (reply_buffer[4])
+#define R_SECTOR (reply_buffer[5])
+#define R_SIZECODE (reply_buffer[6])
+
+#define SEL_DLY (2*HZ/100)
+
+/*
+ * this struct defines the different floppy drive types.
+ */
+static struct {
+	struct floppy_drive_params params;
+	const char *name; /* name printed while booting */
+} default_drive_params[]= {
+/* NOTE: the time values in jiffies should be in msec!
+ CMOS drive type
+  |     Maximum data rate supported by drive type
+  |     |   Head load time, msec
+  |     |   |   Head unload time, msec (not used)
+  |     |   |   |     Step rate interval, usec
+  |     |   |   |     |       Time needed for spinup time (jiffies)
+  |     |   |   |     |       |      Timeout for spinning down (jiffies)
+  |     |   |   |     |       |      |   Spindown offset (where disk stops)
+  |     |   |   |     |       |      |   |     Select delay
+  |     |   |   |     |       |      |   |     |     RPS
+  |     |   |   |     |       |      |   |     |     |    Max number of tracks
+  |     |   |   |     |       |      |   |     |     |    |     Interrupt timeout
+  |     |   |   |     |       |      |   |     |     |    |     |   Max nonintlv. sectors
+  |     |   |   |     |       |      |   |     |     |    |     |   | -Max Errors- flags */
+{{0,  500, 16, 16, 8000,    1*HZ, 3*HZ,  0, SEL_DLY, 5,  80, 3*HZ, 20, {3,1,2,0,2}, 0,
+      0, { 7, 4, 8, 2, 1, 5, 3,10}, 3*HZ/2, 0 }, "unknown" },
+
+{{1,  300, 16, 16, 8000,    1*HZ, 3*HZ,  0, SEL_DLY, 5,  40, 3*HZ, 17, {3,1,2,0,2}, 0,
+      0, { 1, 0, 0, 0, 0, 0, 0, 0}, 3*HZ/2, 1 }, "360K PC" }, /*5 1/4 360 KB PC*/
+
+{{2,  500, 16, 16, 6000, 4*HZ/10, 3*HZ, 14, SEL_DLY, 6,  83, 3*HZ, 17, {3,1,2,0,2}, 0,
+      0, { 2, 6, 4, 0, 0, 0, 0, 0}, 3*HZ/2, 2 }, "1.2M" }, /*5 1/4 HD AT*/
+
+{{3,  250, 16, 16, 3000,    1*HZ, 3*HZ,  0, SEL_DLY, 5,  83, 3*HZ, 20, {3,1,2,0,2}, 0,
+      0, { 4, 6, 0, 0, 0, 0, 0, 0}, 3*HZ/2, 4 }, "720k" }, /*3 1/2 DD*/
+
+{{4,  500, 16, 16, 4000, 4*HZ/10, 3*HZ, 10, SEL_DLY, 5,  83, 3*HZ, 20, {3,1,2,0,2}, 0,
+      0, { 7,10, 2, 4, 6, 0, 0, 0}, 3*HZ/2, 7 }, "1.44M" }, /*3 1/2 HD*/
+
+{{5, 1000, 15,  8, 3000, 4*HZ/10, 3*HZ, 10, SEL_DLY, 5,  83, 3*HZ, 40, {3,1,2,0,2}, 0,
+      0, { 7, 8, 4,25,28,22,31,21}, 3*HZ/2, 8 }, "2.88M AMI BIOS" }, /*3 1/2 ED*/
+
+{{6, 1000, 15,  8, 3000, 4*HZ/10, 3*HZ, 10, SEL_DLY, 5,  83, 3*HZ, 40, {3,1,2,0,2}, 0,
+      0, { 7, 8, 4,25,28,22,31,21}, 3*HZ/2, 8 }, "2.88M" } /*3 1/2 ED*/
+/*    |  --autodetected formats---    |      |      |
+ *    read_track                      |      |    Name printed when booting
+ *				      |     Native format
+ *	            Frequency of disk change checks */
+};
+
+static struct floppy_drive_params drive_params[N_DRIVE];
+static struct floppy_drive_struct drive_state[N_DRIVE];
+static struct floppy_write_errors write_errors[N_DRIVE];
+static struct timer_list motor_off_timer[N_DRIVE];
+static struct gendisk *disks[N_DRIVE];
+static struct floppy_raw_cmd *raw_cmd, default_raw_cmd;
+
+/*
+ * This struct defines the different floppy types.
+ *
+ * Bit 0 of 'stretch' tells if the tracks need to be doubled for some
+ * types (e.g. 360kB diskette in 1.2MB drive, etc.).  Bit 1 of 'stretch'
+ * tells if the disk is in Commodore 1581 format, which means side 0 sectors
+ * are located on side 1 of the disk but with a side 0 ID, and vice-versa.
+ * This is the same as the Sharp MZ-80 5.25" CP/M disk format, except that the
+ * 1581's logical side 0 is on physical side 1, whereas the Sharp's logical
+ * side 0 is on physical side 0 (but with the misnamed sector IDs).
+ * 'stretch' should probably be renamed to something more general, like
+ * 'options'.  Other parameters should be self-explanatory (see also
+ * setfdprm(8)).
+ */
+/*
+	    Size
+	     |  Sectors per track
+	     |  | Head
+	     |  | |  Tracks
+	     |  | |  | Stretch
+	     |  | |  | |  Gap 1 size
+	     |  | |  | |    |  Data rate, | 0x40 for perp
+	     |  | |  | |    |    |  Spec1 (stepping rate, head unload
+	     |  | |  | |    |    |    |    /fmt gap (gap2) */
+static struct floppy_struct floppy_type[32] = {
+	{    0, 0,0, 0,0,0x00,0x00,0x00,0x00,NULL    },	/*  0 no testing    */
+#if 0
+	{  720, 9,2,40,0,0x2A,0x02,0xDF,0x50,"d360"  }, /*  1 360KB PC      */
+#else
+	{ 2464,16,2,77,0,0x35,0x48,0xDF,0x74,"d360"  }, /*  1 1.25MB 98     */
+#endif
+	{ 2400,15,2,80,0,0x1B,0x00,0xDF,0x54,"h1200" },	/*  2 1.2MB AT      */
+	{  720, 9,1,80,0,0x2A,0x02,0xDF,0x50,"D360"  },	/*  3 360KB SS 3.5" */
+	{ 1440, 9,2,80,0,0x2A,0x02,0xDF,0x50,"D720"  },	/*  4 720KB 3.5"    */
+	{  720, 9,2,40,1,0x23,0x01,0xDF,0x50,"h360"  },	/*  5 360KB AT      */
+	{ 1440, 9,2,80,0,0x23,0x01,0xDF,0x50,"h720"  },	/*  6 720KB AT      */
+	{ 2880,18,2,80,0,0x1B,0x00,0xCF,0x6C,"H1440" },	/*  7 1.44MB 3.5"   */
+	{ 5760,36,2,80,0,0x1B,0x43,0xAF,0x54,"E2880" },	/*  8 2.88MB 3.5"   */
+	{ 6240,39,2,80,0,0x1B,0x43,0xAF,0x28,"E3120" },	/*  9 3.12MB 3.5"   */
+
+	{ 2880,18,2,80,0,0x25,0x00,0xDF,0x02,"h1440" }, /* 10 1.44MB 5.25"  */
+	{ 3360,21,2,80,0,0x1C,0x00,0xCF,0x0C,"H1680" }, /* 11 1.68MB 3.5"   */
+	{  820,10,2,41,1,0x25,0x01,0xDF,0x2E,"h410"  },	/* 12 410KB 5.25"   */
+	{ 1640,10,2,82,0,0x25,0x02,0xDF,0x2E,"H820"  },	/* 13 820KB 3.5"    */
+	{ 2952,18,2,82,0,0x25,0x00,0xDF,0x02,"h1476" },	/* 14 1.48MB 5.25"  */
+	{ 3444,21,2,82,0,0x25,0x00,0xDF,0x0C,"H1722" },	/* 15 1.72MB 3.5"   */
+	{  840,10,2,42,1,0x25,0x01,0xDF,0x2E,"h420"  },	/* 16 420KB 5.25"   */
+	{ 1660,10,2,83,0,0x25,0x02,0xDF,0x2E,"H830"  },	/* 17 830KB 3.5"    */
+	{ 2988,18,2,83,0,0x25,0x00,0xDF,0x02,"h1494" },	/* 18 1.49MB 5.25"  */
+	{ 3486,21,2,83,0,0x25,0x00,0xDF,0x0C,"H1743" }, /* 19 1.74 MB 3.5"  */
+
+	{ 1760,11,2,80,0,0x1C,0x09,0xCF,0x00,"h880"  }, /* 20 880KB 5.25"   */
+	{ 2080,13,2,80,0,0x1C,0x01,0xCF,0x00,"D1040" }, /* 21 1.04MB 3.5"   */
+	{ 2240,14,2,80,0,0x1C,0x19,0xCF,0x00,"D1120" }, /* 22 1.12MB 3.5"   */
+	{ 3200,20,2,80,0,0x1C,0x20,0xCF,0x2C,"h1600" }, /* 23 1.6MB 5.25"   */
+	{ 3520,22,2,80,0,0x1C,0x08,0xCF,0x2e,"H1760" }, /* 24 1.76MB 3.5"   */
+	{ 3840,24,2,80,0,0x1C,0x20,0xCF,0x00,"H1920" }, /* 25 1.92MB 3.5"   */
+	{ 6400,40,2,80,0,0x25,0x5B,0xCF,0x00,"E3200" }, /* 26 3.20MB 3.5"   */
+	{ 7040,44,2,80,0,0x25,0x5B,0xCF,0x00,"E3520" }, /* 27 3.52MB 3.5"   */
+	{ 7680,48,2,80,0,0x25,0x63,0xCF,0x00,"E3840" }, /* 28 3.84MB 3.5"   */
+
+	{ 3680,23,2,80,0,0x1C,0x10,0xCF,0x00,"H1840" }, /* 29 1.84MB 3.5"   */
+	{ 1600,10,2,80,0,0x25,0x02,0xDF,0x2E,"D800"  },	/* 30 800KB 3.5"    */
+	{ 3200,20,2,80,0,0x1C,0x00,0xCF,0x2C,"H1600" }, /* 31 1.6MB 3.5"    */
+};
+
+#define	NUMBER(x)	(sizeof(x) / sizeof(*(x)))
+#define SECTSIZE (_FD_SECTSIZE(*floppy))
+
+/* Auto-detection: Disk type used until the next media change occurs. */
+static struct floppy_struct *current_type[N_DRIVE];
+
+/*
+ * User-provided type information. current_type points to
+ * the respective entry of this array.
+ */
+static struct floppy_struct user_params[N_DRIVE];
+
+static sector_t floppy_sizes[256];
+
+/*
+ * The driver is trying to determine the correct media format
+ * while probing is set. rw_interrupt() clears it after a
+ * successful access.
+ */
+static int probing;
+
+/* Synchronization of FDC access. */
+#define FD_COMMAND_NONE -1
+#define FD_COMMAND_ERROR 2
+#define FD_COMMAND_OKAY 3
+
+static volatile int command_status = FD_COMMAND_NONE;
+static unsigned long fdc_busy;
+static DECLARE_WAIT_QUEUE_HEAD(fdc_wait);
+static DECLARE_WAIT_QUEUE_HEAD(command_done);
+
+#define NO_SIGNAL (!interruptible || !signal_pending(current))
+#define CALL(x) if ((x) == -EINTR) return -EINTR
+#define ECALL(x) if ((ret = (x))) return ret;
+#define _WAIT(x,i) CALL(ret=wait_til_done((x),i))
+#define WAIT(x) _WAIT((x),interruptible)
+#define IWAIT(x) _WAIT((x),1)
+
+/* Errors during formatting are counted here. */
+static int format_errors;
+
+/* Format request descriptor. */
+static struct format_descr format_req;
+
+/*
+ * Rate is 0 for 500kb/s, 1 for 300kbps, 2 for 250kbps
+ * Spec1 is 0xSH, where S is stepping rate (F=1ms, E=2ms, D=3ms etc),
+ * H is head unload time (1=16ms, 2=32ms, etc)
+ */
+
+/*
+ * Track buffer
+ * Because these are written to by the DMA controller, they must
+ * not contain a 64k byte boundary crossing, or data will be
+ * corrupted/lost.
+ */
+static char *floppy_track_buffer;
+static int max_buffer_sectors;
+
+static int *errors;
+typedef void (*done_f)(int);
+static struct cont_t {
+	void (*interrupt)(void); /* this is called after the interrupt of the
+				  * main command */
+	void (*redo)(void); /* this is called to retry the operation */
+	void (*error)(void); /* this is called to tally an error */
+	done_f done; /* this is called to say if the operation has +		      * succeeded/failed */
+} *cont;
+
+static void floppy_ready(void);
+static void floppy_start(void);
+static void process_fd_request(void);
+static void recalibrate_floppy(void);
+static void floppy_shutdown(void);
+
+static int floppy_grab_irq_and_dma(void);
+static void floppy_release_irq_and_dma(void);
+
+/*
+ * The "reset" variable should be tested whenever an interrupt is scheduled,
+ * after the commands have been sent. This is to ensure that the driver doesn't
+ * get wedged when the interrupt doesn't come because of a failed command.
+ * reset doesn't need to be tested before sending commands, because
+ * output_byte is automatically disabled when reset is set.
+ */
+#define CHECK_RESET { if (FDCS->reset){ reset_fdc(); return; } }
+static void reset_fdc(void);
+
+/*
+ * These are global variables, as that's the easiest way to give
+ * information to interrupts. They are the data used for the current
+ * request.
+ */
+#define NO_TRACK -1
+#define NEED_1_RECAL -2
+#define NEED_2_RECAL -3
+
+static int usage_count;
+
+/* buffer related variables */
+static int buffer_track = -1;
+static int buffer_drive = -1;
+static int buffer_min = -1;
+static int buffer_max = -1;
+
+/* fdc related variables, should end up in a struct */
+static struct floppy_fdc_state fdc_state[N_FDC];
+static int fdc; /* current fdc */
+
+static struct floppy_struct *_floppy = floppy_type;
+static unsigned char current_drive;
+static long current_count_sectors;
+static unsigned char fsector_t; /* sector in track */
+static unsigned char in_sector_offset;	/* offset within physical sector,
+					 * expressed in units of 512 bytes */
+
+#ifndef fd_eject
+static inline int fd_eject(int drive)
+{
+	return -EINVAL;
+}
+#endif
+
+#ifdef DEBUGT
+static long unsigned debugtimer;
+#endif
+
+/*
+ * Debugging
+ * =========
+ */
+static inline void set_debugt(void)
+{
+#ifdef DEBUGT
+	debugtimer = jiffies;
+#endif
+}
+
+static inline void debugt(const char *message)
+{
+#ifdef DEBUGT
+	if (DP->flags & DEBUGT)
+		printk("%s dtime=%lu\n", message, jiffies-debugtimer);
+#endif
+}
+
+typedef void (*timeout_fn)(unsigned long);
+static struct timer_list fd_timeout ={ function: (timeout_fn) floppy_shutdown };
+
+static const char *timeout_message;
+
+#ifdef FLOPPY_SANITY_CHECK
+static void is_alive(const char *message)
+{
+	/* this routine checks whether the floppy driver is "alive" */
+	if (fdc_busy && command_status < 2 && !timer_pending(&fd_timeout)){
+		DPRINT("timeout handler died: %s\n",message);
+	}
+}
+#endif
+
+static void (*do_floppy)(void) = NULL;
+
+#ifdef FLOPPY_SANITY_CHECK
+
+#define OLOGSIZE 20
+
+static void (*lasthandler)(void);
+static unsigned long interruptjiffies;
+static unsigned long resultjiffies;
+static int resultsize;
+static unsigned long lastredo;
+
+static struct output_log {
+	unsigned char data;
+	unsigned char status;
+	unsigned long jiffies;
+} output_log[OLOGSIZE];
+
+static int output_log_pos;
+#endif
+
+#define current_reqD -1
+#define MAXTIMEOUT -2
+
+static void reschedule_timeout(int drive, const char *message, int marg)
+{
+	if (drive == current_reqD)
+		drive = current_drive;
+	del_timer(&fd_timeout);
+	if (drive < 0 || drive > N_DRIVE) {
+		fd_timeout.expires = jiffies + 20UL*HZ;
+		drive=0;
+	} else
+		fd_timeout.expires = jiffies + UDP->timeout;
+	add_timer(&fd_timeout);
+	if (UDP->flags & FD_DEBUG){
+		DPRINT("reschedule timeout ");
+		printk(message, marg);
+		printk("\n");
+	}
+	timeout_message = message;
+}
+
+static int maximum(int a, int b)
+{
+	if (a > b)
+		return a;
+	else
+		return b;
+}
+#define INFBOUND(a,b) (a)=maximum((a),(b));
+
+static int minimum(int a, int b)
+{
+	if (a < b)
+		return a;
+	else
+		return b;
+}
+#define SUPBOUND(a,b) (a)=minimum((a),(b));
+
+
+/*
+ * Bottom half floppy driver.
+ * ==========================
+ *
+ * This part of the file contains the code talking directly to the hardware,
+ * and also the main service loop (seek-configure-spinup-command)
+ */
+
+/*
+ * disk change.
+ * This routine is responsible for maintaining the FD_DISK_CHANGE flag,
+ * and the last_checked date.
+ *
+ * last_checked is the date of the last check which showed 'no disk change'
+ * FD_DISK_CHANGE is set under two conditions:
+ * 1. The floppy has been changed after some i/o to that floppy already
+ *    took place.
+ * 2. No floppy disk is in the drive. This is done in order to ensure that
+ *    requests are quickly flushed in case there is no disk in the drive. It
+ *    follows that FD_DISK_CHANGE can only be cleared if there is a disk in
+ *    the drive.
+ *
+ * For 1., maxblock is observed. Maxblock is 0 if no i/o has taken place yet.
+ * For 2., FD_DISK_NEWCHANGE is watched. FD_DISK_NEWCHANGE is cleared on
+ *  each seek. If a disk is present, the disk change line should also be
+ *  cleared on each seek. Thus, if FD_DISK_NEWCHANGE is clear, but the disk
+ *  change line is set, this means either that no disk is in the drive, or
+ *  that it has been removed since the last seek.
+ *
+ * This means that we really have a third possibility too:
+ *  The floppy has been changed after the last seek.
+ */
+
+static int disk_change(int drive)
+{
+	return UTESTF(FD_DISK_CHANGED);
+}
+
+static int set_mode(char mask, char data)
+{
+	register unsigned char newdor, olddor;
+
+	olddor = FDCS->dor;
+	newdor = (olddor & mask) | data;
+	if (newdor != olddor) {
+		FDCS->dor = newdor;
+		fd_outb(newdor, FD_MODE);
+	}
+
+	if (newdor & FLOPPY_MOTOR_MASK)
+		floppy_grab_irq_and_dma();
+
+	if (olddor & FLOPPY_MOTOR_MASK)
+		floppy_release_irq_and_dma();
+
+	return olddor;
+}
+
+static void twaddle(void)
+{
+	if (DP->select_delay)
+		return;
+
+	fd_outb(FDCS->dor & 0xf7, FD_MODE);
+	fd_outb(FDCS->dor, FD_MODE);
+	DRS->select_date = jiffies;
+}
+
+/* reset all driver information about the current fdc. This is needed after
+ * a reset, and after a raw command. */
+static void reset_fdc_info(int mode)
+{
+	int drive;
+
+	FDCS->spec1 = FDCS->spec2 = -1;
+	FDCS->need_configure = 1;
+	FDCS->perp_mode = 1;
+	FDCS->rawcmd = 0;
+	for (drive = 0; drive < N_DRIVE; drive++)
+		if (FDC(drive) == fdc &&
+		    (mode || UDRS->track != NEED_1_RECAL))
+			UDRS->track = NEED_2_RECAL;
+}
+
+/* selects the fdc and drive, and enables the fdc's input/dma. */
+static void set_fdc(int drive)
+{
+	fdc = 0;
+	current_drive = drive;
+	set_mode(~0, 0x10);
+	if (FDCS->rawcmd == 2)
+		reset_fdc_info(1);
+
+	if (fd_inb(FD_STATUS) != STATUS_READY)
+		FDCS->reset = 1;
+}
+
+/* locks the driver */
+static int _lock_fdc(int drive, int interruptible, int line)
+{
+	if (!usage_count){
+		printk(KERN_ERR "Trying to lock fdc while usage count=0 at line %d\n", line);
+		return -1;
+	}
+	if(floppy_grab_irq_and_dma()==-1)
+		return -EBUSY;
+
+	if (test_and_set_bit(0, &fdc_busy)) {
+		DECLARE_WAITQUEUE(wait, current);
+		add_wait_queue(&fdc_wait, &wait);
+
+		for (;;) {
+			set_current_state(TASK_INTERRUPTIBLE);
+
+			if (!test_and_set_bit(0, &fdc_busy))
+				break;
+
+			schedule();
+
+			if (!NO_SIGNAL) {
+				remove_wait_queue(&fdc_wait, &wait);
+				return -EINTR;
+			}
+		}
+
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(&fdc_wait, &wait);
+	}
+	command_status = FD_COMMAND_NONE;
+
+	reschedule_timeout(drive, "lock fdc", 0);
+	set_fdc(drive);
+	return 0;
+}
+
+#define lock_fdc(drive,interruptible) _lock_fdc(drive,interruptible, __LINE__)
+
+#define LOCK_FDC(drive,interruptible) \
+if (lock_fdc(drive,interruptible)) return -EINTR;
+
+
+/* unlocks the driver */
+static inline void unlock_fdc(void)
+{
+	raw_cmd = 0;
+	if (!fdc_busy)
+		DPRINT("FDC access conflict!\n");
+
+	if (do_floppy)
+		DPRINT("device interrupt still active at FDC release: %p!\n",
+			do_floppy);
+	command_status = FD_COMMAND_NONE;
+	del_timer(&fd_timeout);
+	cont = NULL;
+	clear_bit(0, &fdc_busy);
+	floppy_release_irq_and_dma();
+	wake_up(&fdc_wait);
+}
+
+#ifndef CONFIG_PC9800_MOTOR_OFF /* tomita */
+
+/* switches the motor off after a given timeout */
+static void motor_off_callback(unsigned long nr)
+{
+	printk(KERN_DEBUG "fdc%lu: turn off motor\n", nr);
+}
+
+/* schedules motor off */
+static void floppy_off(unsigned int drive)
+{
+}
+
+#else /* CONFIG_PC9800_MOTOR_OFF */
+
+/* switches the motor off after a given timeout */
+static void motor_off_callback(unsigned long fdc)
+{
+	printk(KERN_DEBUG "fdc%u: turn off motor\n", (unsigned int) fdc);
+
+	fd_outb(0, FD_MODE);	/* MTON = 0 */
+}
+
+static struct timer_list motor_off_timer[N_FDC] = {
+	{ data: 0, function: motor_off_callback },
+#if N_FDC > 1
+	{ data: 1, function: motor_off_callback },
+#endif
+#if N_FDC > 2
+# error "N_FDC > 2; please fix initializer for motor_off_timer[]"
+#endif
+};
+
+/* schedules motor off */
+static void floppy_off(unsigned int drive)
+{
+	unsigned long volatile delta;
+	register int fdc = FDC(drive);
+
+	if (!(FDCS->dor & (0x10 << UNIT(drive))))
+		return;
+
+	del_timer(motor_off_timer + fdc);
+
+#if 0
+	/* make spindle stop in a position which minimizes spinup time
+	 * next time */
+	if (UDP->rps){
+		delta = jiffies - UDRS->first_read_date + HZ -
+			UDP->spindown_offset;
+		delta = ((delta * UDP->rps) % HZ) / UDP->rps;
+		motor_off_timer[drive].expires = jiffies + UDP->spindown - delta;
+	}
+#else
+	if (UDP->rps)
+		motor_off_timer[drive].expires = jiffies + UDP->spindown;
+#endif
+
+	add_timer(motor_off_timer + fdc);
+}
+
+#endif /* CONFIG_PC9800_MOTOR_OFF */
+
+/*
+ * cycle through all N_DRIVE floppy drives, for disk change testing.
+ * stopping at current drive. This is done before any long operation, to
+ * be sure to have up to date disk change information.
+ */
+static void scandrives(void)
+{
+	int i, drive, saved_drive;
+
+	if (DP->select_delay)
+		return;
+
+	saved_drive = current_drive;
+	for (i=0; i < N_DRIVE; i++){
+		drive = (saved_drive + i + 1) % N_DRIVE;
+		if (UDRS->fd_ref == 0 || UDP->select_delay != 0)
+			continue; /* skip closed drives */
+		set_fdc(drive);
+	}
+	set_fdc(saved_drive);
+}
+
+static void empty(void)
+{
+}
+
+static DECLARE_WORK(floppy_work, NULL, NULL);
+
+static void schedule_bh( void (*handler)(void*) )
+{
+	PREPARE_WORK(&floppy_work, handler, NULL);
+	schedule_work(&floppy_work);
+}
+
+static struct timer_list fd_timer;
+
+static void cancel_activity(void)
+{
+	do_floppy = NULL;
+	PREPARE_WORK(&floppy_work, (void*)(void*)empty, NULL);
+	del_timer(&fd_timer);
+}
+
+/* this function makes sure that the disk stays in the drive during the
+ * transfer */
+static void fd_watchdog(void)
+{
+#ifdef DCL_DEBUG
+	if (DP->flags & FD_DEBUG){
+		DPRINT("calling disk change from watchdog\n");
+	}
+#endif
+
+	if (disk_change(current_drive)){
+		DPRINT("disk removed during i/o\n");
+		cancel_activity();
+		cont->done(0);
+		reset_fdc();
+	} else {
+		del_timer(&fd_timer);
+		fd_timer.function = (timeout_fn) fd_watchdog;
+		fd_timer.expires = jiffies + HZ / 10;
+		add_timer(&fd_timer);
+	}
+}
+
+static void main_command_interrupt(void)
+{
+	del_timer(&fd_timer);
+	cont->interrupt();
+}
+
+/* waits for a delay (spinup or select) to pass */
+static int fd_wait_for_completion(unsigned long delay, timeout_fn function)
+{
+	if (FDCS->reset){
+		reset_fdc(); /* do the reset during sleep to win time
+			      * if we don't need to sleep, it's a good
+			      * occasion anyways */
+		return 1;
+	}
+
+	if ((signed) (jiffies - delay) < 0){
+		del_timer(&fd_timer);
+		fd_timer.function = function;
+		fd_timer.expires = delay;
+		add_timer(&fd_timer);
+		return 1;
+	}
+	return 0;
+}
+
+static spinlock_t floppy_hlt_lock = SPIN_LOCK_UNLOCKED;
+static int hlt_disabled;
+static void floppy_disable_hlt(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&floppy_hlt_lock, flags);
+	if (!hlt_disabled) {
+		hlt_disabled=1;
+#ifdef HAVE_DISABLE_HLT
+		disable_hlt();
+#endif
+	}
+	spin_unlock_irqrestore(&floppy_hlt_lock, flags);
+}
+
+static void floppy_enable_hlt(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&floppy_hlt_lock, flags);
+	if (hlt_disabled){
+		hlt_disabled=0;
+#ifdef HAVE_DISABLE_HLT
+		enable_hlt();
+#endif
+	}
+	spin_unlock_irqrestore(&floppy_hlt_lock, flags);
+}
+
+
+static void setup_DMA(void)
+{
+	unsigned long f;
+
+#ifdef FLOPPY_SANITY_CHECK
+	if (raw_cmd->length == 0){
+		int i;
+
+		printk("zero dma transfer size:");
+		for (i=0; i < raw_cmd->cmd_count; i++)
+			printk("%x,", raw_cmd->cmd[i]);
+		printk("\n");
+		cont->done(0);
+		FDCS->reset = 1;
+		return;
+	}
+	if (((unsigned long) raw_cmd->kernel_data) % 512){
+		printk("non aligned address: %p\n", raw_cmd->kernel_data);
+		cont->done(0);
+		FDCS->reset=1;
+		return;
+	}
+#endif
+	f=claim_dma_lock();
+	fd_disable_dma();
+#ifdef fd_dma_setup
+	if (fd_dma_setup(raw_cmd->kernel_data, raw_cmd->length, +			(raw_cmd->flags & FD_RAW_READ)?
+			DMA_MODE_READ : DMA_MODE_WRITE,
+			FDCS->address) < 0) {
+		release_dma_lock(f);
+		cont->done(0);
+		FDCS->reset=1;
+		return;
+	}
+	release_dma_lock(f);
+#else	 
+	fd_clear_dma_ff();
+	fd_cacheflush(raw_cmd->kernel_data, raw_cmd->length);
+	fd_set_dma_mode((raw_cmd->flags & FD_RAW_READ)?
+			DMA_MODE_READ : DMA_MODE_WRITE);
+	fd_set_dma_addr(raw_cmd->kernel_data);
+	fd_set_dma_count(raw_cmd->length);
+	virtual_dma_port = FDCS->address;
+	fd_enable_dma();
+	release_dma_lock(f);
+#endif
+	floppy_disable_hlt();
+}
+
+static void show_floppy(void);
+
+/* waits until the fdc becomes ready */
+
+#ifdef PC9800_DEBUG_FLOPPY
+#define READY_DELAY 10000000
+#else
+#define READY_DELAY 100000
+#endif
+
+static int wait_til_ready(void)
+{
+	int counter, status;
+	if (FDCS->reset)
+		return -1;
+	for (counter = 0; counter < READY_DELAY; counter++) {
+		status = fd_inb(FD_STATUS);		 
+		if (status & STATUS_READY)
+			return status;
+	}
+	if (!initialising) {
+		DPRINT("Getstatus times out (%x) on fdc %d\n",
+			status, fdc);
+		show_floppy();
+	}
+	FDCS->reset = 1;
+	return -1;
+}
+
+/* sends a command byte to the fdc */
+static int output_byte(char byte)
+{
+	int status;
+
+	if ((status = wait_til_ready()) < 0)
+		return -1;
+	if ((status & (STATUS_READY|STATUS_DIR|STATUS_DMA)) == STATUS_READY){
+		fd_outb(byte,FD_DATA);
+#ifdef FLOPPY_SANITY_CHECK
+		output_log[output_log_pos].data = byte;
+		output_log[output_log_pos].status = status;
+		output_log[output_log_pos].jiffies = jiffies;
+		output_log_pos = (output_log_pos + 1) % OLOGSIZE;
+#endif
+		return 0;
+	}
+	FDCS->reset = 1;
+	if (!initialising) {
+		DPRINT("Unable to send byte %x to FDC. Fdc=%x Status=%x\n",
+		       byte, fdc, status);
+		show_floppy();
+	}
+	return -1;
+}
+#define LAST_OUT(x) if (output_byte(x)<0){ reset_fdc();return;}
+
+/* gets the response from the fdc */
+static int result(void)
+{
+	int i, status=0;
+
+	for(i=0; i < MAX_REPLIES; i++) {
+		if ((status = wait_til_ready()) < 0)
+			break;
+		status &= STATUS_DIR|STATUS_READY|STATUS_BUSY|STATUS_DMA;
+		if ((status & ~STATUS_BUSY) == STATUS_READY){
+#ifdef FLOPPY_SANITY_CHECK
+			resultjiffies = jiffies;
+			resultsize = i;
+#endif
+			return i;
+		}
+		if (status == (STATUS_DIR|STATUS_READY|STATUS_BUSY))
+			reply_buffer[i] = fd_inb(FD_DATA);
+		else
+			break;
+	}
+	if (!initialising) {
+		DPRINT("get result error. Fdc=%d Last status=%x Read bytes=%d\n",
+		       fdc, status, i);
+		show_floppy();
+	}
+	FDCS->reset = 1;
+	return -1;
+}
+
+static int fifo_depth = 0xa;
+static int no_fifo;
+
+#define NOMINAL_DTR 500
+
+/* Issue a "SPECIFY" command to set the step rate time, head unload time,
+ * head load time, and DMA disable flag to values needed by floppy.
+ *
+ * The value "dtr" is the data transfer rate in Kbps.  It is needed
+ * to account for the data rate-based scaling done by the 82072 and 82077
+ * FDC types.  This parameter is ignored for other types of FDCs (i.e.
+ * 8272a).
+ *
+ * Note that changing the data transfer rate has a (probably deleterious)
+ * effect on the parameters subject to scaling for 82072/82077 FDCs, so
+ * fdc_specify is called again after each data transfer rate
+ * change.
+ *
+ * srt: 1000 to 16000 in microseconds
+ * hut: 16 to 240 milliseconds
+ * hlt: 2 to 254 milliseconds
+ *
+ * These values are rounded up to the next highest available delay time.
+ */
+static void fdc_specify(void)
+{
+	output_byte(FD_SPECIFY);
+	output_byte(FDCS->spec1 = 0xdf);
+	output_byte(FDCS->spec2 = 0x24);
+}
+
+static void tell_sector(void)
+{
+	printk(": track %d, head %d, sector %d, size %d",
+	       R_TRACK, R_HEAD, R_SECTOR, R_SIZECODE);
+} /* tell_sector */
+
+static int auto_detect_mode_pc9800(void)
+{
+#ifdef PC9800_DEBUG_FLOPPY
+	printk("auto_detect_mode_pc9800: retry_auto_detect=%d\n",
+		retry_auto_detect);
+#endif
+	if (retry_auto_detect > 4) {
+		retry_auto_detect = 0;	   +		return 1;
+	}
+
+	switch ((int)(_floppy - floppy_type)) {
+		case 2:
+			_floppy = floppy_type + 4;
+			break;
+
+		case 4:
+		case 6:
+			_floppy = floppy_type + 7;
+			break;
+
+		case 7:
+		case 10:
+			_floppy = floppy_type + 2;
+			break;
+
+		default:
+			_floppy = floppy_type + 7;
+	}
+
+	retry_auto_detect++;
+	return 0;
+}
+
+static void access_mode_change_pc9800(void);
+
+/*
+ * OK, this error interpreting routine is called after a
+ * DMA read/write has succeeded
+ * or failed, so we check the results, and copy any buffers.
+ * hhb: Added better error reporting.
+ * ak: Made this into a separate routine.
+ */
+static int interpret_errors(void)
+{
+	char bad;
+
+	if (inr!=7) {
+		DPRINT("-- FDC reply error");
+		FDCS->reset = 1;
+		return 1;
+	}
+
+	/* check IC to find cause of interrupt */
+	switch (ST0 & ST0_INTR) {
+		case 0x40:	/* error occurred during command execution */
+			if (ST1 & ST1_EOC)
+				return 0; /* occurs with pseudo-DMA */
+			bad = 1;
+			if (ST1 & ST1_WP) {
+				DPRINT("Drive is write protected\n");
+				CLEARF(FD_DISK_WRITABLE);
+				cont->done(0);
+				bad = 2;
+			} else if (ST1 & ST1_ND) {
+				SETF(FD_NEED_TWADDLE);
+			} else if (ST1 & ST1_OR) {
+				if (DP->flags & FTD_MSG)
+					DPRINT("Over/Underrun - retrying\n");
+				bad = 0;
+			}else if (*errors >= DP->max_errors.reporting){
+				if (ST0 & ST0_ECE) {
+					printk("Recalibrate failed!");
+				} else if (ST2 & ST2_CRC) {
+					printk("data CRC error");
+					tell_sector();
+				} else if (ST1 & ST1_CRC) {
+					printk("CRC error");
+					tell_sector();
+				} else if ((ST1 & (ST1_MAM|ST1_ND)) || (ST2 & ST2_MAM)) {
+					if (auto_detect_mode) {
+						bad = (char)auto_detect_mode_pc9800();
+						access_mode_change_pc9800();
+					}
+
+					if (bad) {
+						printk("floppy error: MA: _floppy - floppy_type=%d\n", (int)(_floppy - floppy_type));
+						printk("bad=%d\n", (int)bad);
+						if (!probing) {
+							printk("sector not found");
+							tell_sector();
+						} else
+							printk("probe failed...");
+					}
+				} else if (ST2 & ST2_WC) {	/* seek error */
+					printk("wrong cylinder");
+				} else if (ST2 & ST2_BC) {	/* cylinder marked as bad */
+					printk("bad cylinder");
+				} else {
+					printk("unknown error. ST[0..2] are: 0x%x 0x%x 0x%x", ST0, ST1, ST2);
+					tell_sector();
+				}
+				printk("\n");
+
+			}
+			if (ST2 & ST2_WC || ST2 & ST2_BC)
+				/* wrong cylinder => recal */
+				DRS->track = NEED_2_RECAL;
+			return bad;
+		case 0x80: /* invalid command given */
+			DPRINT("Invalid FDC command given!\n");
+			cont->done(0);
+			return 2;
+		case 0xc0:
+			SETF(FD_DISK_CHANGED);
+			SETF(FD_DISK_WRITABLE);
+			DPRINT("Abnormal termination caused by polling\n");
+			cont->error();
+			return 2;
+		default: /* (0) Normal command termination */
+			auto_detect_mode = 0;
+			return 0;
+	}
+}
+
+/*
+ * This routine is called when everything should be correctly set up
+ * for the transfer (i.e. floppy motor is on, the correct floppy is
+ * selected, and the head is sitting on the right track).
+ */
+static void setup_rw_floppy(void)
+{
+	int i,r, flags,dflags;
+	unsigned long ready_date;
+	timeout_fn function;
+
+	access_mode_change_pc9800();
+	flags = raw_cmd->flags;
+	if (flags & (FD_RAW_READ | FD_RAW_WRITE))
+		flags |= FD_RAW_INTR;
+
+	if ((flags & FD_RAW_SPIN) && !(flags & FD_RAW_NO_MOTOR)){
+		ready_date = DRS->spinup_date + DP->spinup;
+		/* If spinup will take a long time, rerun scandrives
+		 * again just before spinup completion. Beware that
+		 * after scandrives, we must again wait for selection.
+		 */
+		if ((signed) (ready_date - jiffies) > DP->select_delay){
+			ready_date -= DP->select_delay;
+			function = (timeout_fn) floppy_start;
+		} else
+			function = (timeout_fn) setup_rw_floppy;
+
+		/* wait until the floppy is spinning fast enough */
+		if (fd_wait_for_completion(ready_date,function))
+			return;
+	}
+	dflags = DRS->flags;
+
+	if ((flags & FD_RAW_READ) || (flags & FD_RAW_WRITE))
+		setup_DMA();
+
+	if (flags & FD_RAW_INTR)
+		do_floppy = main_command_interrupt;
+
+	r=0;
+	for (i=0; i< raw_cmd->cmd_count; i++)
+		r|=output_byte(raw_cmd->cmd[i]);
+
+#ifdef DEBUGT
+	debugt("rw_command: ");
+#endif
+	if (r){
+		cont->error();
+		reset_fdc();
+		return;
+	}
+
+	if (!(flags & FD_RAW_INTR)){
+		inr = result();
+		cont->interrupt();
+	} else if (flags & FD_RAW_NEED_DISK)
+		fd_watchdog();
+}
+
+static int blind_seek;
+
+/*
+ * This is the routine called after every seek (or recalibrate) interrupt
+ * from the floppy controller.
+ */
+static void seek_interrupt(void)
+{
+#ifdef DEBUGT
+	debugt("seek interrupt:");
+#endif
+	if (inr != 2 || (ST0 & 0xF8) != 0x20) {
+		DRS->track = NEED_2_RECAL;
+		cont->error();
+		cont->redo();
+		return;
+	}
+	if (DRS->track >= 0 && DRS->track != ST1 && !blind_seek){
+#ifdef DCL_DEBUG
+		if (DP->flags & FD_DEBUG){
+			DPRINT("clearing NEWCHANGE flag because of effective seek\n");
+			DPRINT("jiffies=%lu\n", jiffies);
+		}
+#endif
+		CLEARF(FD_DISK_NEWCHANGE); /* effective seek */
+		CLEARF(FD_DISK_CHANGED); /* effective seek */
+		DRS->select_date = jiffies;
+	}
+	DRS->track = ST1;
+	floppy_ready();
+}
+
+static void check_wp(void)
+{
+	if (TESTF(FD_VERIFY)) {
+		/* check write protection */
+		output_byte(FD_GETSTATUS);
+		output_byte(UNIT(current_drive));
+		if (result() != 1){
+			FDCS->reset = 1;
+			return;
+		}
+		CLEARF(FD_VERIFY);
+		CLEARF(FD_NEED_TWADDLE);
+#ifdef DCL_DEBUG
+		if (DP->flags & FD_DEBUG){
+			DPRINT("checking whether disk is write protected\n");
+			DPRINT("wp=%x\n",ST3 & 0x40);
+		}
+#endif
+		if (!(ST3  & 0x40))
+			SETF(FD_DISK_WRITABLE);
+		else
+			CLEARF(FD_DISK_WRITABLE);
+	}
+}
+
+static void seek_floppy(void)
+{
+	int track;
+
+	blind_seek=0;
+
+#ifdef DCL_DEBUG
+	if (DP->flags & FD_DEBUG){
+		DPRINT("calling disk change from seek\n");
+	}
+#endif
+
+	if (!TESTF(FD_DISK_NEWCHANGE) &&
+	    disk_change(current_drive) &&
+	    (raw_cmd->flags & FD_RAW_NEED_DISK)){
+		/* the media changed flag should be cleared after the seek.
+		 * If it isn't, this means that there is really no disk in
+		 * the drive.
+		 */
+		SETF(FD_DISK_CHANGED);
+		cont->done(0);
+		cont->redo();
+		return;
+	}
+	if (DRS->track <= NEED_1_RECAL){
+		recalibrate_floppy();
+		return;
+	} else if (TESTF(FD_DISK_NEWCHANGE) &&
+		   (raw_cmd->flags & FD_RAW_NEED_DISK) &&
+		   (DRS->track <= NO_TRACK || DRS->track == raw_cmd->track)) {
+		/* we seek to clear the media-changed condition. Does anybody
+		 * know a more elegant way, which works on all drives? */
+		if (raw_cmd->track)
+			track = raw_cmd->track - 1;
+		else {
+			if (DP->flags & FD_SILENT_DCL_CLEAR){
+				blind_seek = 1;
+				raw_cmd->flags |= FD_RAW_NEED_SEEK;
+			}
+			track = 1;
+		}
+	} else {
+		check_wp();
+		if (raw_cmd->track != DRS->track &&
+		    (raw_cmd->flags & FD_RAW_NEED_SEEK))
+			track = raw_cmd->track;
+		else {
+			setup_rw_floppy();
+			return;
+		}
+	}
+
+	do_floppy = seek_interrupt;
+	output_byte(FD_SEEK);
+	output_byte(UNIT(current_drive));
+	LAST_OUT(track);
+#ifdef DEBUGT
+	debugt("seek command:");
+#endif
+}
+
+static void recal_interrupt(void)
+{
+#ifdef DEBUGT
+	debugt("recal interrupt:");
+#endif
+	if (inr !=2)
+		FDCS->reset = 1;
+	else if (ST0 & ST0_ECE) {
+	       	switch(DRS->track){
+			case NEED_1_RECAL:
+#ifdef DEBUGT
+				debugt("recal interrupt need 1 recal:");
+#endif
+				/* after a second recalibrate, we still haven't
+				 * reached track 0. Probably no drive. Raise an
+				 * error, as failing immediately might upset
+				 * computers possessed by the Devil :-) */
+				cont->error();
+				cont->redo();
+				return;
+			case NEED_2_RECAL:
+#ifdef DEBUGT
+				debugt("recal interrupt need 2 recal:");
+#endif
+				/* If we already did a recalibrate,
+				 * and we are not at track 0, this
+				 * means we have moved. (The only way
+				 * not to move at recalibration is to
+				 * be already at track 0.) Clear the
+				 * new change flag */
+#ifdef DCL_DEBUG
+				if (DP->flags & FD_DEBUG){
+					DPRINT("clearing NEWCHANGE flag because of second recalibrate\n");
+				}
+#endif
+
+				CLEARF(FD_DISK_NEWCHANGE);
+				DRS->select_date = jiffies;
+				/* fall through */
+			default:
+#ifdef DEBUGT
+				debugt("recal interrupt default:");
+#endif
+				/* Recalibrate moves the head by at
+				 * most 80 steps. If after one
+				 * recalibrate we don't have reached
+				 * track 0, this might mean that we
+				 * started beyond track 80.  Try
+				 * again.  */
+				DRS->track = NEED_1_RECAL;
+				break;
+		}
+	} else
+		DRS->track = ST1;
+	floppy_ready();
+}
+
+static void print_result(char *message, int inr)
+{
+	int i;
+
+	DPRINT("%s ", message);
+	if (inr >= 0)
+		for (i=0; i<inr; i++)
+			printk("repl[%d]=%x ", i, reply_buffer[i]);
+	printk("\n");
+}
+
+/* interrupt handler. Note that this can be called externally on the Sparc */
+void floppy_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+{
+	void (*handler)(void) = do_floppy;
+	int do_print;
+	unsigned long f;
+
+	lasthandler = handler;
+	interruptjiffies = jiffies;
+
+	f=claim_dma_lock();
+	fd_disable_dma();
+	release_dma_lock(f);
+
+	floppy_enable_hlt();
+	do_floppy = NULL;
+	if (fdc >= N_FDC || FDCS->address == -1){
+		/* we don't even know which FDC is the culprit */
+		printk("DOR0=%x\n", fdc_state[0].dor);
+		printk("floppy interrupt on bizarre fdc %d\n",fdc);
+		printk("handler=%p\n", handler);
+		is_alive("bizarre fdc");
+		return;
+	}
+
+	FDCS->reset = 0;
+	/* We have to clear the reset flag here, because apparently on boxes
+	 * with level triggered interrupts (PS/2, Sparc, ...), it is needed to
+	 * emit SENSEI's to clear the interrupt line. And FDCS->reset blocks the
+	 * emission of the SENSEI's.
+	 * It is OK to emit floppy commands because we are in an interrupt
+	 * handler here, and thus we have to fear no interference of other
+	 * activity.
+	 */
+
+	do_print = !handler && !initialising;
+
+	inr = result();
+	if (inr && do_print)
+		print_result("unexpected interrupt", inr);
+	if (inr == 0){
+		do {
+			output_byte(FD_SENSEI);
+			inr = result();
+			if ((ST0 & ST0_INTR) == 0xC0) {
+				int drive = ST0 & ST0_DS;
+
+				/* Attention Interrupt. */
+				if (ST0 & ST0_NR) {
+#ifdef PC9800_DEBUG_FLOPPY
+					if (do_print)
+						printk(KERN_DEBUG
+							"floppy debug: floppy ejected (drive %d)\n",
+							drive);
+#endif
+					USETF(FD_DISK_CHANGED);
+					USETF(FD_VERIFY);
+				} else {
+#ifdef PC9800_DEBUG_FLOPPY
+					if (do_print)
+						printk(KERN_DEBUG
+							"floppy debug: floppy inserted (drive %d)\n",
+							drive);
+#endif
+				}
+			} /* Attention Interrupt */
+#ifdef PC9800_DEBUG_FLOPPY
+			else {
+				printk(KERN_DEBUG
+					"floppy debug : unknown interrupt\n");
+			}
+#endif
+		} while ((ST0 & 0x83) != UNIT(current_drive) && inr == 2);
+	}
+	if (handler) {
+		schedule_bh( (void *)(void *) handler);
+	} else {
+#if 0
+		FDCS->reset = 1;
+#endif
+	}
+	is_alive("normal interrupt end");
+}
+
+static void recalibrate_floppy(void)
+{
+#ifdef DEBUGT
+	debugt("recalibrate floppy:");
+#endif
+	do_floppy = recal_interrupt;
+	output_byte(FD_RECALIBRATE);
+	LAST_OUT(UNIT(current_drive));
+}
+
+/*
+ * Must do 4 FD_SENSEIs after reset because of ``drive polling''.
+ */
+static void reset_interrupt(void)
+{
+#ifdef PC9800_DEBUG_FLOPPY
+	printk("floppy debug: reset interrupt\n");
+#endif
+#ifdef DEBUGT
+	debugt("reset interrupt:");
+#endif
+	result();		/* get the status ready for set_fdc */
+	if (FDCS->reset) {
+		printk("reset set in interrupt, calling %p\n", cont->error);
+		cont->error(); /* a reset just after a reset. BAD! */
+	}
+	cont->redo();
+}
+
+/*
+ * reset is done by pulling bit 2 of DOR low for a while (old FDCs),
+ * or by setting the self clearing bit 7 of STATUS (newer FDCs)
+ */
+static void reset_fdc(void)
+{
+	unsigned long flags;
+
+#ifdef PC9800_DEBUG_FLOPPY
+	printk("floppy debug: reset_fdc\n");
+#endif
+
+	do_floppy = reset_interrupt;
+	FDCS->reset = 0;
+	reset_fdc_info(0);
+
+	/* Pseudo-DMA may intercept 'reset finished' interrupt.  */
+	/* Irrelevant for systems with true DMA (i386).          */
+
+	flags=claim_dma_lock();
+	fd_disable_dma();
+	release_dma_lock(flags);
+
+	fd_outb(FDCS->dor | 0x80, FD_MODE);
+	udelay(FD_RESET_DELAY);
+	fd_outb(FDCS->dor, FD_MODE);
+	udelay(FD_AFTER_RESET_DELAY);
+}
+
+static void show_floppy(void)
+{
+	int i;
+
+	printk("\n");
+	printk("floppy driver state\n");
+	printk("-------------------\n");
+	printk("now=%lu last interrupt=%lu diff=%lu last called handler=%p\n",
+	       jiffies, interruptjiffies, jiffies-interruptjiffies, lasthandler);
+
+
+#ifdef FLOPPY_SANITY_CHECK
+	printk("timeout_message=%s\n", timeout_message);
+	printk("last output bytes:\n");
+	for (i=0; i < OLOGSIZE; i++)
+		printk("%2x %2x %lu\n",
+		       output_log[(i+output_log_pos) % OLOGSIZE].data,
+		       output_log[(i+output_log_pos) % OLOGSIZE].status,
+		       output_log[(i+output_log_pos) % OLOGSIZE].jiffies);
+	printk("last result at %lu\n", resultjiffies);
+	printk("last redo_fd_request at %lu\n", lastredo);
+	for (i=0; i<resultsize; i++){
+		printk("%2x ", reply_buffer[i]);
+	}
+	printk("\n");
+#endif
+
+	printk("status=%x\n", fd_inb(FD_STATUS));
+	printk("fdc_busy=%lu\n", fdc_busy);
+	if (do_floppy)
+		printk("do_floppy=%p\n", do_floppy);
+	if (floppy_work.pending)
+		printk("floppy_work.func=%p\n", floppy_work.func);
+	if (timer_pending(&fd_timer))
+		printk("fd_timer.function=%p\n", fd_timer.function);
+	if (timer_pending(&fd_timeout)){
+		printk("timer_function=%p\n",fd_timeout.function);
+		printk("expires=%lu\n",fd_timeout.expires-jiffies);
+		printk("now=%lu\n",jiffies);
+	}
+	printk("cont=%p\n", cont);
+	printk("current_req=%p\n", current_req);
+	printk("command_status=%d\n", command_status);
+	printk("\n");
+}
+
+static void floppy_shutdown(void)
+{
+	unsigned long flags;
+	 
+	if (!initialising)
+		show_floppy();
+	cancel_activity();
+
+	floppy_enable_hlt();
+	 
+	flags=claim_dma_lock();
+	fd_disable_dma();
+	release_dma_lock(flags);
+	 
+	/* avoid dma going to a random drive after shutdown */
+
+	if (!initialising)
+		DPRINT("floppy timeout called\n");
+	FDCS->reset = 1;
+	if (cont){
+		cont->done(0);
+		cont->redo(); /* this will recall reset when needed */
+	} else {
+		printk("no cont in shutdown!\n");
+		process_fd_request();
+	}
+	is_alive("floppy shutdown");
+}
+/*typedef void (*timeout_fn)(unsigned long);*/
+
+static void access_mode_change_pc9800(void)
+{
+	static int access_mode, mode_change_now, old_mode, new_set = 1;
+#ifdef PC9800_DEBUG_FLOPPY2
+	printk("enter access_mode_change\n");
+#endif
+	access_mode = mode_change_now = 0;
+	if (DP->cmos==4) {
+		switch ((int)(_floppy - &floppy_type[0])) {
+		case 1:
+		case 2:
+			new_set = 1;
+			access_mode = 2;
+			break;
+
+		case 4:
+		case 6:
+			new_set = 1;
+			access_mode = 3;
+			break;
+
+		case 7:
+		case 10:
+			new_set = 1;
+			access_mode = 1;
+			break;
+
+		default:
+			access_mode = 1;
+			break;
+		}
+
+		old_mode = fd_inb(FD_MODE_CHANGE) & 3;
+
+		switch (access_mode) {
+		case 1:
+			if ((old_mode & 2) == 0) {
+				fd_outb(old_mode | 2, FD_MODE_CHANGE);
+				mode_change_now = 1;
+			} else {
+				fd_outb(current_drive << 5, FD_EMODE_CHANGE);
+				if (fd_inb(FD_EMODE_CHANGE) == 0xff)
+					return;
+			}
+
+			fd_outb((current_drive << 5) | 0x11, FD_EMODE_CHANGE);
+			mode_change_now = 1;
+			break;
+
+		case 2:
+			if ((old_mode & 2) == 0) {
+				fd_outb(old_mode | 2, FD_MODE_CHANGE);
+				mode_change_now = 1;
+			} else {
+				fd_outb(current_drive << 5, FD_EMODE_CHANGE);
+				if ((fd_inb(FD_EMODE_CHANGE) & 1) == 0)
+					return;
+				fd_outb((current_drive << 5) | 0x10, FD_EMODE_CHANGE);
+				mode_change_now = 1;
+			}
+
+			break;
+
+		case 3:
+			if ((old_mode & 2) == 0)
+				return;
+			fd_outb(current_drive << 5, FD_EMODE_CHANGE);
+			if (fd_inb(FD_EMODE_CHANGE) & 1)
+				fd_outb((current_drive << 5) | 0x10, FD_EMODE_CHANGE);
+			fd_outb(old_mode & 0xfd, FD_MODE_CHANGE);
+			mode_change_now = 1;
+			break;
+
+		default:
+			break;
+		}
+	} else {
+		switch ((int)(_floppy - &floppy_type[0])) {
+		case 1:
+		case 2:
+			new_set = 1;
+			access_mode = 2;
+			break;
+
+		case 4:
+		case 6:
+			new_set = 1;
+			access_mode = 3;
+			break;
+
+		default:
+			switch (DP->cmos) {
+			case 2:
+				access_mode = 2;
+				break;
+
+			case 3:
+				access_mode = 3;
+				break;
+
+			default:
+				break;
+			}
+
+			break;
+		}
+
+		old_mode = fd_inb(FD_MODE_CHANGE) & 3;
+
+		switch (access_mode) {
+		case 2:
+			if ((old_mode & 2) == 0) {
+				fd_outb(old_mode | 2, FD_MODE_CHANGE);
+				mode_change_now = 1;
+			}
+
+			break;
+
+		case 3:
+			if (old_mode & 2) {
+				fd_outb(old_mode & 0xfd, FD_MODE_CHANGE);
+				mode_change_now = 1;
+			}
+
+			break;
+
+		default:
+			break;
+		}
+	}
+#ifdef PC9800_DEBUG_FLOPPY2
+	printk("floppy debug: DP->cmos=%d\n", DP->cmos);
+	printk("floppy debug: mode_change_now=%d\n", mode_change_now);
+	printk("floppy debug: access_mode=%d\n", access_mode);
+	printk("floppy debug: old_mode=%d\n", old_mode);
+	printk("floppy debug: _floppy - &floppy_type[0]=%d\n", (int)(_floppy - &floppy_type[0]));
+#endif /* PC9800_DEBUG_FLOPPY2 */
+	if(mode_change_now)
+		reset_fdc();
+}
+
+/* start motor, check media-changed condition and write protection */
+static int start_motor(void (*function)(void) )
+{
+	access_mode_change_pc9800();
+	set_mode(~0, 0x8);
+
+	/* wait_for_completion also schedules reset if needed. */
+	return(fd_wait_for_completion(DRS->select_date+DP->select_delay,
+				   (timeout_fn) function));
+}
+
+static void floppy_ready(void)
+{
+	CHECK_RESET;
+	if (start_motor(floppy_ready)) return;
+
+#ifdef DCL_DEBUG
+	if (DP->flags & FD_DEBUG){
+		DPRINT("calling disk change from floppy_ready\n");
+	}
+#endif
+	if (!(raw_cmd->flags & FD_RAW_NO_MOTOR) &&
+	   disk_change(current_drive) &&
+	   !DP->select_delay)
+		twaddle(); /* this clears the dcl on certain drive/controller
+			    * combinations */
+
+#ifdef fd_chose_dma_mode
+	if ((raw_cmd->flags & FD_RAW_READ) || +	    (raw_cmd->flags & FD_RAW_WRITE))
+	{
+		unsigned long flags = claim_dma_lock();
+		fd_chose_dma_mode(raw_cmd->kernel_data,
+				  raw_cmd->length);
+		release_dma_lock(flags);
+	}
+#endif
+
+#if 0
+	access_mode_change_pc9800();
+#endif
+	if (raw_cmd->flags & (FD_RAW_NEED_SEEK | FD_RAW_NEED_DISK)){
+		fdc_specify(); /* must be done here because of hut, hlt ... */
+		seek_floppy();
+	} else {
+		if ((raw_cmd->flags & FD_RAW_READ) || +		    (raw_cmd->flags & FD_RAW_WRITE))
+			fdc_specify();
+		setup_rw_floppy();
+	}
+}
+
+static void floppy_start(void)
+{
+	reschedule_timeout(current_reqD, "floppy start", 0);
+
+	scandrives();
+#ifdef DCL_DEBUG
+	if (DP->flags & FD_DEBUG){
+		DPRINT("setting NEWCHANGE in floppy_start\n");
+	}
+#endif
+	SETF(FD_DISK_NEWCHANGE);
+	floppy_ready();
+}
+
+/*
+ * ========================================================================
+ * here ends the bottom half. Exported routines are:
+ * floppy_start, floppy_off, floppy_ready, lock_fdc, unlock_fdc, set_fdc,
+ * start_motor, reset_fdc, reset_fdc_info, interpret_errors.
+ * Initialization also uses output_byte, result, set_dor, floppy_interrupt
+ * and set_dor.
+ * ========================================================================
+ */
+/*
+ * General purpose continuations.
+ * ==============================
+ */
+
+static void do_wakeup(void)
+{
+	reschedule_timeout(MAXTIMEOUT, "do wakeup", 0);
+	cont = 0;
+	command_status += 2;
+	wake_up(&command_done);
+}
+
+static struct cont_t wakeup_cont={
+	empty,
+	do_wakeup,
+	empty,
+	(done_f)empty
+};
+
+
+static struct cont_t intr_cont={
+	empty,
+	process_fd_request,
+	empty,
+	(done_f) empty
+};
+
+static int wait_til_done(void (*handler)(void), int interruptible)
+{
+	int ret;
+
+	schedule_bh((void *)(void *)handler);
+
+	if (command_status < 2 && NO_SIGNAL) {
+		DECLARE_WAITQUEUE(wait, current);
+
+		add_wait_queue(&command_done, &wait);
+		for (;;) {
+			set_current_state(interruptible?
+					  TASK_INTERRUPTIBLE:
+					  TASK_UNINTERRUPTIBLE);
+
+			if (command_status >= 2 || !NO_SIGNAL)
+				break;
+
+			is_alive("wait_til_done");
+
+			schedule();
+		}
+
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(&command_done, &wait);
+	}
+
+	if (command_status < 2){
+		cancel_activity();
+		cont = &intr_cont;
+		reset_fdc();
+		return -EINTR;
+	}
+
+#ifdef PC9800_DEBUG_FLOPPY
+	if (command_status != FD_COMMAND_OKAY)
+		printk("floppy check: wait_til_done out:%d\n", command_status);
+#endif
+	if (FDCS->reset)
+		command_status = FD_COMMAND_ERROR;
+	if (command_status == FD_COMMAND_OKAY)
+		ret=0;
+	else
+		ret=-EIO;
+	command_status = FD_COMMAND_NONE;
+	return ret;
+}
+
+static void generic_done(int result)
+{
+	command_status = result;
+	cont = &wakeup_cont;
+}
+
+static void generic_success(void)
+{
+	cont->done(1);
+}
+
+static void generic_failure(void)
+{
+	cont->done(0);
+}
+
+static void success_and_wakeup(void)
+{
+	generic_success();
+	cont->redo();
+}
+
+
+/*
+ * formatting and rw support.
+ * ==========================
+ */
+
+static int next_valid_format(void)
+{
+	int probed_format;
+
+	probed_format = DRS->probed_format;
+	while(1){
+		if (probed_format >= 8 ||
+		     !DP->autodetect[probed_format]){
+			DRS->probed_format = 0;
+			return 1;
+		}
+		if (floppy_type[DP->autodetect[probed_format]].sect){
+			DRS->probed_format = probed_format;
+			return 0;
+		}
+		probed_format++;
+	}
+}
+
+static void bad_flp_intr(void)
+{
+	if (probing){
+		DRS->probed_format++;
+		if (!next_valid_format())
+			return;
+	}
+	(*errors)++;
+	INFBOUND(DRWE->badness, *errors);
+	if (*errors > DP->max_errors.abort)
+		cont->done(0);
+	if (*errors > DP->max_errors.reset)
+		FDCS->reset = 1;
+	else if (*errors > DP->max_errors.recal)
+		DRS->track = NEED_2_RECAL;
+}
+
+static void set_floppy(kdev_t device)
+{
+	if (TYPE(device)) {
+		auto_detect_mode = 0;
+		_floppy = TYPE(device) + floppy_type;
+	} else if (auto_detect_mode == 0) {
+		auto_detect_mode = 1;
+		retry_auto_detect = 0;
+		_floppy = current_type[DRIVE(device)];
+	}
+#ifdef PC9800_DEBUG_FLOPPY2
+	printk("set_floppy: set floppy type=%d\n", (int)(_floppy - floppy_type));
+#endif
+}
+
+/*
+ * formatting support.
+ * ===================
+ */
+static void format_interrupt(void)
+{
+	switch (interpret_errors()){
+		case 1:
+			cont->error();
+		case 2:
+			break;
+		case 0:
+			cont->done(1);
+	}
+	cont->redo();
+}
+
+#define CODE2SIZE (ssize = ((1 << SIZECODE) + 3) >> 2)
+#define FM_MODE(x,y) ((y) & ~(((x)->rate & 0x80) >>1))
+#define CT(x) ((x) | 0xc0)
+static void setup_format_params(int track)
+{
+	struct fparm {
+		unsigned char track,head,sect,size;
+	} *here = (struct fparm *)floppy_track_buffer;
+	int il,n;
+	int count,head_shift,track_shift;
+
+	raw_cmd = &default_raw_cmd;
+	raw_cmd->track = track;
+
+	raw_cmd->flags = FD_RAW_WRITE | FD_RAW_INTR | FD_RAW_SPIN |
+		FD_RAW_NEED_DISK | FD_RAW_NEED_SEEK;
+	raw_cmd->rate = _floppy->rate & 0x43;
+	raw_cmd->cmd_count = NR_F;
+	COMMAND = FM_MODE(_floppy,FD_FORMAT);
+	DR_SELECT = UNIT(current_drive) + PH_HEAD(_floppy,format_req.head);
+	F_SIZECODE = FD_SIZECODE(_floppy);
+	F_SECT_PER_TRACK = _floppy->sect << 2 >> F_SIZECODE;
+	F_GAP = _floppy->fmt_gap;
+	F_FILL = FD_FILL_BYTE;
+
+	raw_cmd->kernel_data = floppy_track_buffer;
+	raw_cmd->length = 4 * F_SECT_PER_TRACK;
+
+	/* allow for about 30ms for data transport per track */
+	head_shift  = (F_SECT_PER_TRACK + 5) / 6;
+
+	/* a ``cylinder'' is two tracks plus a little stepping time */
+	track_shift = 2 * head_shift + 3;
+
+	/* position of logical sector 1 on this track */
+	n = (track_shift * format_req.track + head_shift * format_req.head)
+		% F_SECT_PER_TRACK;
+
+	/* determine interleave */
+	il = 1;
+	if (_floppy->fmt_gap < 0x22)
+		il++;
+
+	/* initialize field */
+	for (count = 0; count < F_SECT_PER_TRACK; ++count) {
+		here[count].track = format_req.track;
+		here[count].head = format_req.head;
+		here[count].sect = 0;
+		here[count].size = F_SIZECODE;
+	}
+	/* place logical sectors */
+	for (count = 1; count <= F_SECT_PER_TRACK; ++count) {
+		here[n].sect = count;
+		n = (n+il) % F_SECT_PER_TRACK;
+		if (here[n].sect) { /* sector busy, find next free sector */
+			++n;
+			if (n>= F_SECT_PER_TRACK) {
+				n-=F_SECT_PER_TRACK;
+				while (here[n].sect) ++n;
+			}
+		}
+	}
+}
+
+static void redo_format(void)
+{
+	buffer_track = -1;
+	setup_format_params(format_req.track << STRETCH(_floppy));
+	floppy_start();
+#ifdef DEBUGT
+	debugt("queue format request");
+#endif
+}
+
+static struct cont_t format_cont={
+	format_interrupt,
+	redo_format,
+	bad_flp_intr,
+	generic_done };
+
+static int do_format(kdev_t device, struct format_descr *tmp_format_req)
+{
+	int ret;
+	int drive=DRIVE(device);
+
+	LOCK_FDC(drive,1);
+	set_floppy(device);
+	if (!_floppy ||
+	    _floppy->track > DP->tracks ||
+	    tmp_format_req->track >= _floppy->track ||
+	    tmp_format_req->head >= _floppy->head ||
+	    (_floppy->sect << 2) % (1 <<  FD_SIZECODE(_floppy)) ||
+	    !_floppy->fmt_gap) {
+		process_fd_request();
+		return -EINVAL;
+	}
+	format_req = *tmp_format_req;
+	format_errors = 0;
+	cont = &format_cont;
+	errors = &format_errors;
+	IWAIT(redo_format);
+	process_fd_request();
+	return ret;
+}
+
