Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263128AbUKTRVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbUKTRVh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 12:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbUKTRVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 12:21:36 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:17606 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S263128AbUKTRSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 12:18:38 -0500
From: james4765@verizon.net
To: kernel-janitors@lists.osdl.org
Cc: linux-kernel@vger.kernel.org, james4765@verizon.net
Message-Id: <20041120171859.15785.15800.33699@localhost.localdomain>
Subject: [PATCH] floppy: move macro definitions to where they are used
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [209.158.220.243] at Sat, 20 Nov 2004 11:18:37 -0600
Date: Sat, 20 Nov 2004 11:18:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move some macros that are only used in a small area of the code to the functions
that actually use them, and #undef them at the end of the area the are used in.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc2-original/drivers/block/floppy.c linux-2.6.10-rc2/drivers/block/floppy.c
--- linux-2.6.10-rc2-original/drivers/block/floppy.c	2004-11-15 21:38:15.000000000 -0500
+++ linux-2.6.10-rc2/drivers/block/floppy.c	2004-11-20 12:02:47.256146661 -0500
@@ -293,8 +293,6 @@
 #define TOMINOR(x) ((x & 3) | ((x & 4) << 5))
 #define UNIT(x) ((x) & 0x03)	/* drive on fdc */
 #define FDC(x) (((x) & 0x04) >> 2)	/* fdc of drive */
-#define REVDRIVE(fdc, unit) ((unit) + ((fdc) << 2))
-				/* reverse mapping from unit and fdc to drive */
 #define DP (&drive_params[current_drive])
 #define DRS (&drive_state[current_drive])
 #define DRWE (&write_errors[current_drive])
@@ -330,13 +328,6 @@
 #define SIZECODE2 raw_cmd->cmd[8]
 #define NR_RW 9
 
-/* format */
-#define F_SIZECODE raw_cmd->cmd[2]
-#define F_SECT_PER_TRACK raw_cmd->cmd[3]
-#define F_GAP raw_cmd->cmd[4]
-#define F_FILL raw_cmd->cmd[5]
-#define NR_F 6
-
 /*
  * Maximum disk size (in kilobytes). This default is used whenever the
  * current disk size is unknown.
@@ -516,7 +507,6 @@
 #define ECALL(x) if ((ret = (x))) return ret;
 #define _WAIT(x,i) CALL(ret=wait_til_done((x),i))
 #define WAIT(x) _WAIT((x),interruptible)
-#define IWAIT(x) _WAIT((x),1)
 
 /* Errors during formatting are counted here. */
 static int format_errors;
@@ -559,14 +549,6 @@
 static int floppy_grab_irq_and_dma(void);
 static void floppy_release_irq_and_dma(void);
 
-/*
- * The "reset" variable should be tested whenever an interrupt is scheduled,
- * after the commands have been sent. This is to ensure that the driver doesn't
- * get wedged when the interrupt doesn't come because of a failed command.
- * reset doesn't need to be tested before sending commands, because
- * output_byte is automatically disabled when reset is set.
- */
-#define CHECK_RESET { if (FDCS->reset){ reset_fdc(); return; } }
 static void reset_fdc(void);
 
 /*
@@ -788,6 +770,9 @@
 
 static int set_dor(int fdc, char mask, char data)
 {
+/* macro used by set_dor() */
+#define REVDRIVE(fdc, unit) ((unit) + ((fdc) << 2))
+
 	register unsigned char drive, unit, newdor, olddor;
 
 	if (FDCS->address == -1)
@@ -825,6 +810,7 @@
 	if (olddor & FLOPPY_MOTOR_MASK)
 		floppy_release_irq_and_dma();
 	return olddor;
+#undef REVDRIVE
 }
 
 static void twaddle(void)
@@ -1297,8 +1283,6 @@
 	return 1;
 }
 
-#define NOMINAL_DTR 500
-
 /* Issue a "SPECIFY" command to set the step rate time, head unload time,
  * head load time, and DMA disable flag to values needed by floppy.
  *
@@ -1320,6 +1304,9 @@
  */
 static void fdc_specify(void)
 {
+/* #define only used in fdc_specify() */
+#define NOMINAL_DTR 500
+
 	unsigned char spec1, spec2;
 	unsigned long srt, hlt, hut;
 	unsigned long dtr = NOMINAL_DTR;
@@ -1390,6 +1377,7 @@
 		output_byte(FDCS->spec1 = spec1);
 		output_byte(FDCS->spec2 = spec2);
 	}
+#undef NOMINAL_DTR
 }				/* fdc_specify */
 
 /* Set the FDC's data transfer rate on behalf of the specified drive.
@@ -1952,8 +1940,18 @@
 				       (timeout_fn) function));
 }
 
+/*
+ * The "reset" variable should be tested whenever an interrupt is scheduled,
+ * after the commands have been sent. This is to ensure that the driver doesn't
+ * get wedged when the interrupt doesn't come because of a failed command.
+ * reset doesn't need to be tested before sending commands, because
+ * output_byte is automatically disabled when reset is set.
+ */
 static void floppy_ready(void)
 {
+/* macro only used in floppy_ready() */
+#define CHECK_RESET { if (FDCS->reset){ reset_fdc(); return; } }
+
 	CHECK_RESET;
 	if (start_motor(floppy_ready))
 		return;
@@ -1988,6 +1986,7 @@
 			fdc_specify();
 		setup_rw_floppy();
 	}
+#undef CHECK_RESET
 }
 
 static void floppy_start(void)
@@ -2179,6 +2178,13 @@
 #define CT(x) ((x) | 0xc0)
 static void setup_format_params(int track)
 {
+/* macros only used in setup_format_params() */
+#define F_SIZECODE raw_cmd->cmd[2]
+#define F_SECT_PER_TRACK raw_cmd->cmd[3]
+#define F_GAP raw_cmd->cmd[4]
+#define F_FILL raw_cmd->cmd[5]
+#define NR_F 6
+
 	struct fparm {
 		unsigned char track, head, sect, size;
 	} *here = (struct fparm *)floppy_track_buffer;
@@ -2241,6 +2247,11 @@
 		for (count = 0; count < F_SECT_PER_TRACK; count++)
 			here[count].sect--;
 	}
+#undef F_SIZECODE
+#undef F_SECT_PER_TRACK
+#undef F_GAP
+#undef F_FILL
+#undef NR_F
 }
 
 static void redo_format(void)
@@ -2260,6 +2271,9 @@
 
 static int do_format(int drive, struct format_descr *tmp_format_req)
 {
+/* macro only used in do_format() */
+#define IWAIT(x) _WAIT((x),1)
+
 	int ret;
 
 	LOCK_FDC(drive, 1);
@@ -2280,6 +2294,7 @@
 	IWAIT(redo_format);
 	process_fd_request();
 	return ret;
+#undef IWAIT
 }
 
 /*
@@ -3090,12 +3105,6 @@
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
@@ -3166,6 +3175,12 @@
 	.done		= raw_cmd_done
 };
 
+/* macros only used in ioctl processing */
+#define _COPYOUT(x) (copy_to_user((void __user *)param, &(x), sizeof(x)) ? -EFAULT : 0)
+#define _COPYIN(x) (copy_from_user(&(x), (void __user *)param, sizeof(x)) ? -EFAULT : 0)
+#define COPYOUT(x) ECALL(_COPYOUT(x))
+#define COPYIN(x) ECALL(_COPYIN(x))
+
 static inline int raw_cmd_copyout(int cmd, char __user *param,
 				  struct floppy_raw_cmd *ptr)
 {
@@ -3451,6 +3466,7 @@
 static int fd_ioctl(struct inode *inode, struct file *filp, unsigned int cmd,
 		    unsigned long param)
 {
+/* macros only used in fd_ioctl() */
 #define FD_IOCTL_ALLOWED ((filp) && (filp)->private_data)
 #define OUT(c,x) case c: outparam = (const char *) (x); break
 #define IN(c,x,tag) case c: *(x) = inparam. tag ; return 0
@@ -3622,10 +3638,17 @@
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
+/* end of floppy ioctl processing */
+
 static void __init config_types(void)
 {
 	int first = 1;
@@ -3899,8 +3922,9 @@
  * geometry formats */
 static int floppy_revalidate(struct gendisk *disk)
 {
-	int drive = (long)disk->private_data;
+/* macro only used in floppy_revalidate() */
 #define NO_GEOM (!current_type[drive] && !ITYPE(UDRS->fd_device))
+	int drive = (long)disk->private_data;
 	int cf;
 	int res = 0;
 
@@ -3935,6 +3959,7 @@
 	}
 	set_capacity(disk, floppy_sizes[UDRS->fd_device]);
 	return res;
+#undef NO_GEOM
 }
 
 static struct block_device_operations floppy_fops = {
