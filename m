Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbTBFOtP>; Thu, 6 Feb 2003 09:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbTBFOtP>; Thu, 6 Feb 2003 09:49:15 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:48569 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267322AbTBFOtJ>;
	Thu, 6 Feb 2003 09:49:09 -0500
Date: Thu, 6 Feb 2003 15:58:31 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Fixes to make x86-64 arch compile
Message-ID: <20030206155831.A11243@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch is needed to make 2.5 compile on x86-64. It also fixes a
bunch of warnings, where drivers stuff pointers into ints or vice versa.

You can pull the cset from:
        bk://kernel.bkbits.net/vojtech/x86-64


ChangeSet@1.975, 2003-02-06 15:50:20+01:00, vojtech@suse.cz
  x86-64: Minor fixes to make the kernel compile and remove warnings.


 arch/x86_64/kernel/apic.c        |    2 +-
 arch/x86_64/kernel/time.c        |    4 ++++
 drivers/block/floppy.c           |   14 +++++++-------
 drivers/i2c/i2c-proc.c           |    4 ++--
 drivers/ide/pci/amd74xx.c        |    2 +-
 drivers/usb/input/pid.c          |    4 ++--
 drivers/usb/media/usbvideo.c     |    4 ++--
 drivers/usb/media/vicam.c        |    2 +-
 drivers/video/vesafb.c           |    8 ++++++++
 fs/xfs/linux/xfs_aops.c          |    2 +-
 include/asm-x86_64/compat.h      |    7 +++++++
 include/asm-x86_64/dma-mapping.h |    6 ++++++
 include/asm-x86_64/proto.h       |    2 ++
 13 files changed, 44 insertions(+), 17 deletions(-)


diff -Nru a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
--- a/arch/x86_64/kernel/apic.c	Thu Feb  6 15:57:58 2003
+++ b/arch/x86_64/kernel/apic.c	Thu Feb  6 15:57:58 2003
@@ -895,7 +895,7 @@
  * value into /proc/profile.
  */
 
-inline void smp_local_timer_interrupt(struct pt_regs *regs)
+void smp_local_timer_interrupt(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 
diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	Thu Feb  6 15:57:58 2003
+++ b/arch/x86_64/kernel/time.c	Thu Feb  6 15:57:58 2003
@@ -30,6 +30,10 @@
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
+extern int using_apic_timer;
+extern void smp_local_timer_interrupt(struct pt_regs * regs);
+
+
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
 unsigned long hpet_period;				/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Thu Feb  6 15:57:58 2003
+++ b/drivers/block/floppy.c	Thu Feb  6 15:57:58 2003
@@ -2298,7 +2298,7 @@
 	if (end_that_request_first(req, uptodate, current_count_sectors))
 		return;
 	add_disk_randomness(req->rq_disk);
-	floppy_off((int)req->rq_disk->private_data);
+	floppy_off((long)req->rq_disk->private_data);
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
 
@@ -2631,7 +2631,7 @@
 		return 0;
 	}
 
-	set_fdc((int)current_req->rq_disk->private_data);
+	set_fdc((long)current_req->rq_disk->private_data);
 
 	raw_cmd = &default_raw_cmd;
 	raw_cmd->flags = FD_RAW_SPIN | FD_RAW_NEED_DISK | FD_RAW_NEED_DISK |
@@ -2923,7 +2923,7 @@
 			}
 			current_req = req;
 		}
-		drive = (int)current_req->rq_disk->private_data;
+		drive = (long)current_req->rq_disk->private_data;
 		set_fdc(drive);
 		reschedule_timeout(current_reqD, "redo fd request", 0);
 
@@ -3302,7 +3302,7 @@
 static int invalidate_drive(struct block_device *bdev)
 {
 	/* invalidate the buffer track to force a reread */
-	set_bit((int)bdev->bd_disk->private_data, &fake_change);
+	set_bit((long)bdev->bd_disk->private_data, &fake_change);
 	process_fd_request();
 	check_disk_change(bdev);
 	return 0;
@@ -3797,7 +3797,7 @@
  */
 static int check_floppy_change(struct gendisk *disk)
 {
-	int drive = (int)disk->private_data;
+	int drive = (long)disk->private_data;
 
 	if (UTESTF(FD_DISK_CHANGED) || UTESTF(FD_VERIFY))
 		return 1;
@@ -3900,7 +3900,7 @@
  * geometry formats */
 static int floppy_revalidate(struct gendisk *disk)
 {
-	int drive=(int)disk->private_data;
+	int drive=(long)disk->private_data;
 #define NO_GEOM (!current_type[drive] && !ITYPE(UDRS->fd_device))
 	int cf;
 	int res = 0;
@@ -4358,7 +4358,7 @@
 		if (fdc_state[FDC(drive)].version == FDC_NONE)
 			continue;
 		/* to be cleaned up... */
-		disks[drive]->private_data = (void*)drive;
+		disks[drive]->private_data = (void*)(long)drive;
 		disks[drive]->queue = &floppy_queue;
 		add_disk(disks[drive]);
 	}
diff -Nru a/drivers/i2c/i2c-proc.c b/drivers/i2c/i2c-proc.c
--- a/drivers/i2c/i2c-proc.c	Thu Feb  6 15:57:58 2003
+++ b/drivers/i2c/i2c-proc.c	Thu Feb  6 15:57:58 2003
@@ -39,7 +39,7 @@
 			       struct i2c_adapter *adapter, int addr);
 static int i2c_parse_reals(int *nrels, void *buffer, int bufsize,
 			       long *results, int magnitude);
-static int i2c_write_reals(int nrels, void *buffer, int *bufsize,
+static int i2c_write_reals(int nrels, void *buffer, size_t *bufsize,
 			       long *results, int magnitude);
 static int i2c_proc_chips(ctl_table * ctl, int write,
 			      struct file *filp, void *buffer,
@@ -514,7 +514,7 @@
 	return 0;
 }
 
-int i2c_write_reals(int nrels, void *buffer, int *bufsize,
+int i2c_write_reals(int nrels, void *buffer, size_t *bufsize,
 			 long *results, int magnitude)
 {
 #define BUFLEN 20
diff -Nru a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
--- a/drivers/ide/pci/amd74xx.c	Thu Feb  6 15:57:58 2003
+++ b/drivers/ide/pci/amd74xx.c	Thu Feb  6 15:57:58 2003
@@ -82,7 +82,7 @@
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
-static int amd_base;
+static long amd_base;
 static struct pci_dev *bmide_dev;
 extern int (*amd74xx_display_info)(char *, char **, off_t, int); /* ide-proc.c */
 
diff -Nru a/drivers/usb/input/pid.c b/drivers/usb/input/pid.c
--- a/drivers/usb/input/pid.c	Thu Feb  6 15:57:58 2003
+++ b/drivers/usb/input/pid.c	Thu Feb  6 15:57:58 2003
@@ -176,7 +176,7 @@
 	struct hid_ff_pid* pid_private  = (struct hid_ff_pid*)(dev->private);
 	int ret;
 	int is_update;
-	int flags=0;
+	unsigned long flags = 0;
 
         dev_dbg(&pid_private->hid->dev->dev, "upload effect called: effect_type=%x\n",effect->type);
 	/* Check this effect type is supported by this device */
@@ -192,7 +192,7 @@
 		int id=0;
 
 		// Spinlock so we don`t get a race condition when choosing IDs
-		spin_lock_irqsave(&pid_private->lock,flags);
+		spin_lock_irqsave(&pid_private->lock, flags);
 
 		while(id < FF_EFFECTS_MAX)
 			if (!test_and_set_bit(FF_PID_FLAGS_USED, &pid_private->effects[id++].flags)) 
diff -Nru a/drivers/usb/media/usbvideo.c b/drivers/usb/media/usbvideo.c
--- a/drivers/usb/media/usbvideo.c	Thu Feb  6 15:57:58 2003
+++ b/drivers/usb/media/usbvideo.c	Thu Feb  6 15:57:58 2003
@@ -61,7 +61,7 @@
 			      unsigned int cmd, unsigned long arg);
 static int usbvideo_v4l_mmap(struct file *file, struct vm_area_struct *vma);
 static int usbvideo_v4l_open(struct inode *inode, struct file *file);
-static int usbvideo_v4l_read(struct file *file, char *buf,
+static ssize_t usbvideo_v4l_read(struct file *file, char *buf,
 			     size_t count, loff_t *ppos);
 static int usbvideo_v4l_close(struct inode *inode, struct file *file);
 
@@ -1641,7 +1641,7 @@
  * 20-Oct-2000 Created.
  * 01-Nov-2000 Added mutex (uvd->lock).
  */
-static int usbvideo_v4l_read(struct file *file, char *buf,
+static ssize_t usbvideo_v4l_read(struct file *file, char *buf,
 		      size_t count, loff_t *ppos)
 {
 	struct uvd *uvd = file->private_data;
diff -Nru a/drivers/usb/media/vicam.c b/drivers/usb/media/vicam.c
--- a/drivers/usb/media/vicam.c	Thu Feb  6 15:57:58 2003
+++ b/drivers/usb/media/vicam.c	Thu Feb  6 15:57:58 2003
@@ -988,7 +988,7 @@
 	up(&cam->cam_lock);
 }
 
-static int
+static ssize_t
 vicam_read( struct file *file, char *buf, size_t count, loff_t *ppos )
 {
 	struct vicam_camera *cam = file->private_data;
diff -Nru a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c	Thu Feb  6 15:57:58 2003
+++ b/drivers/video/vesafb.c	Thu Feb  6 15:57:58 2003
@@ -62,6 +62,7 @@
 static int vesafb_pan_display(struct fb_var_screeninfo *var,
                               struct fb_info *info)
 {
+#ifdef __i386__
 	int offset;
 
 	if (!ypan)
@@ -83,11 +84,13 @@
                   "c" (offset),         /* ECX */
                   "d" (offset >> 16),   /* EDX */
                   "D" (&pmi_start));    /* EDI */
+#endif
 	return 0;
 }
 
 static void vesa_setpalette(int regno, unsigned red, unsigned green, unsigned blue)
 {
+#ifdef __i386__
 	struct { u_char blue, green, red, pad; } entry;
 
 	if (pmi_setpal) {
@@ -111,6 +114,7 @@
 		outb_p(green >> 10, dac_val);
 		outb_p(blue  >> 10, dac_val);
 	}
+#endif
 }
 
 static int vesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
@@ -224,6 +228,10 @@
 	vesafb_fix.smem_len = screen_info.lfb_size * 65536;
 	vesafb_fix.visual   = (vesafb_defined.bits_per_pixel == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
+
+#ifndef __i386__
+	screen_info.vesapm_seg = 0;
+#endif
 
 	if (!request_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len, "vesafb")) {
 		printk(KERN_WARNING
diff -Nru a/fs/xfs/linux/xfs_aops.c b/fs/xfs/linux/xfs_aops.c
--- a/fs/xfs/linux/xfs_aops.c	Thu Feb  6 15:57:58 2003
+++ b/fs/xfs/linux/xfs_aops.c	Thu Feb  6 15:57:58 2003
@@ -50,7 +50,7 @@
 
 	if (((flags & (PBF_DIRECT|PBF_SYNC)) == PBF_DIRECT) &&
 	    (offset >= inode->i_size))
-		count = max(count, XFS_WRITE_IO_LOG);
+		count = max_t(ssize_t, count, XFS_WRITE_IO_LOG);
 retry:
 	VOP_BMAP(vp, offset, count, flags, pbmapp, &nmaps, error);
 	if (flags & PBF_WRITE) {
diff -Nru a/include/asm-x86_64/compat.h b/include/asm-x86_64/compat.h
--- a/include/asm-x86_64/compat.h	Thu Feb  6 15:57:58 2003
+++ b/include/asm-x86_64/compat.h	Thu Feb  6 15:57:58 2003
@@ -81,4 +81,11 @@
 	int		f_spare[6];
 };
 
+typedef u32		compat_old_sigset_t;	/* at least 32 bits */
+
+#define _COMPAT_NSIG		64
+#define _COMPAT_NSIG_BPW	32
+
+typedef u32               compat_sigset_word;
+
 #endif /* _ASM_X86_64_COMPAT_H */
diff -Nru a/include/asm-x86_64/dma-mapping.h b/include/asm-x86_64/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-x86_64/dma-mapping.h	Thu Feb  6 15:57:58 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_X8664_DMA_MAPPING_H
+#define _ASM_X8664_DMA_MAPPING_H
+
+#include <asm-generic/dma-mapping.h>
+
+#endif
diff -Nru a/include/asm-x86_64/proto.h b/include/asm-x86_64/proto.h
--- a/include/asm-x86_64/proto.h	Thu Feb  6 15:57:58 2003
+++ b/include/asm-x86_64/proto.h	Thu Feb  6 15:57:58 2003
@@ -1,6 +1,8 @@
 #ifndef _ASM_X8664_PROTO_H
 #define _ASM_X8664_PROTO_H 1
 
+#include <asm/ldt.h>
+
 /* misc architecture specific prototypes */
 
 struct cpuinfo_x86; 

-- 
Vojtech Pavlik
SuSE Labs
