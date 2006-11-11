Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754866AbWKKUsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866AbWKKUsv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 15:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754867AbWKKUsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 15:48:51 -0500
Received: from aun.it.uu.se ([130.238.12.36]:44526 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1754866AbWKKUst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 15:48:49 -0500
Date: Sat, 11 Nov 2006 21:48:42 +0100 (MET)
Message-Id: <200611112048.kABKmg2u002509@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: mingo@elte.hu
Subject: [BUG] floppy: broken after resume due to 2.6.18-rc1 lockdep changes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my old Dell Latitude laptop, the first access to the floppy
after having resumed from APM suspend fails miserably and generates
these kernel messages (from 2.6.19-rc5):

floppy driver state
-------------------
now=1023244 last interrupt=256121 diff=767123 last called handler=c01e7580
timeout_message=lock fdc
last output bytes:
 4 90 256004
 0 90 256004
 1 90 256004
 2 90 256004
12 90 256004
1b 90 256004
ff 90 256004
 f 80 256061
 0 90 256061
 5 90 256061
 8 81 256062
e6 80 256064
 0 90 256064
 5 90 256064
 0 90 256064
 1 90 256064
 2 90 256064
12 90 256064
1b 90 256064
ff 90 256064
last result at 256121
last redo_fd_request at 256121
 4  0  0  6  0  1  2 
status=0
fdc_busy=1
do_floppy=c01ed580
cont=c02a5b24
current_req=00000000
command_status=-1

floppy0: floppy timeout called
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 8
Buffer I/O error on device fd0, logical block 1
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 16
Buffer I/O error on device fd0, logical block 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 24
Buffer I/O error on device fd0, logical block 3
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 32
Buffer I/O error on device fd0, logical block 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 40
Buffer I/O error on device fd0, logical block 5
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 48
Buffer I/O error on device fd0, logical block 6
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 56
Buffer I/O error on device fd0, logical block 7
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0

It's only the first post-resume access that triggers this failure,
subsequent accesses do work.

I've traced the cause to Ingo's lockdep patch in 2.6.18-rc1
(see below): reverting it makes the floppy work after resume again.

Before these changes the driver reserved and released the HW
dynamically, but after the changes it no longer does that.
What I suspect is happening is that an APM suspend/resume cycle
doesn't fully preserve the HW state. Previously the driver
wouldn't notice since it would re-reserve and reinitialise
the HW anyway when needed.

So putting a floppy_release_irq_and_dma() in a ->suspend()
hook and a floppy_grab_irq_and_dma() in a ->resume() hook
should do the trick. Unfortunately I'm not sure where in
floppy.c to do that since these routines aren't per-device
but work on all devices in one go.

/Mikael

>From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 3 Jul 2006 07:24:23 +0000 (-0700)
Subject: [PATCH] lockdep: floppy.c irq release fix
X-Git-Tag: v2.6.18-rc1
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3e541a4ae534a7e59ad464af9abea382b3035724

[PATCH] lockdep: floppy.c irq release fix

The lock validator triggered a number of bugs in the floppy driver, all
related to the floppy driver allocating and freeing irq and dma resources from
interrupt context.  The initial solution was to use schedule_work() to push
this into process context, but this caused further problems: for example the
current floppy driver in -mm2 is totally broken and all floppy commands time
out with an error.  (as reported by Barry K.  Nathan)

This patch tries another solution: simply get rid of all that dynamic IRQ and
DMA allocation/freeing.  I doubt it made much sense back in the heydays of
floppies (if two devices raced for DMA or IRQ resources then we didnt handle
those cases too gracefully anyway), and today it makes near zero sense.

So the new code does the simplest and most straightforward thing: allocate IRQ
and DMA resources at module init time, and free them at module removal time.
Dont try to release while the driver is operational.  This, besides making the
floppy driver functional again has an added bonus, floppy IRQ stats are
finally persistent and visible in /proc/interrupts:

  6: 63 XT-PIC-level floppy

Besides normal floppy IO i have also tested IO error handling, motor-off
timeouts, etc.  - and everything seems to be working fine.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -249,18 +249,6 @@ static int irqdma_allocated;
 #include <linux/cdrom.h>	/* for the compatibility eject ioctl */
 #include <linux/completion.h>
 
-/*
- * Interrupt freeing also means /proc VFS work - dont do it
- * from interrupt context. We push this work into keventd:
- */
-static void fd_free_irq_fn(void *data)
-{
-	fd_free_irq();
-}
-
-static DECLARE_WORK(fd_free_irq_work, fd_free_irq_fn, NULL);
-
-
 static struct request *current_req;
 static struct request_queue *floppy_queue;
 static void do_fd_request(request_queue_t * q);
@@ -826,15 +814,6 @@ static int set_dor(int fdc, char mask, c
 			UDRS->select_date = jiffies;
 		}
 	}
-	/*
-	 *      We should propagate failures to grab the resources back
-	 *      nicely from here. Actually we ought to rewrite the fd
-	 *      driver some day too.
-	 */
-	if (newdor & FLOPPY_MOTOR_MASK)
-		floppy_grab_irq_and_dma();
-	if (olddor & FLOPPY_MOTOR_MASK)
-		floppy_release_irq_and_dma();
 	return olddor;
 }
 
@@ -892,8 +871,6 @@ static int _lock_fdc(int drive, int inte
 		       line);
 		return -1;
 	}
-	if (floppy_grab_irq_and_dma() == -1)
-		return -EBUSY;
 
 	if (test_and_set_bit(0, &fdc_busy)) {
 		DECLARE_WAITQUEUE(wait, current);
@@ -915,6 +892,8 @@ static int _lock_fdc(int drive, int inte
 
 		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&fdc_wait, &wait);
+
+		flush_scheduled_work();
 	}
 	command_status = FD_COMMAND_NONE;
 
@@ -948,7 +927,6 @@ static inline void unlock_fdc(void)
 	if (elv_next_request(floppy_queue))
 		do_fd_request(floppy_queue);
 	spin_unlock_irqrestore(&floppy_lock, flags);
-	floppy_release_irq_and_dma();
 	wake_up(&fdc_wait);
 }
 
@@ -3694,8 +3672,8 @@ static int floppy_release(struct inode *
 	}
 	if (!UDRS->fd_ref)
 		opened_bdev[drive] = NULL;
-	floppy_release_irq_and_dma();
 	mutex_unlock(&open_lock);
+
 	return 0;
 }
 
@@ -3726,9 +3704,6 @@ static int floppy_open(struct inode *ino
 	if (UDRS->fd_ref == -1 || (UDRS->fd_ref && (filp->f_flags & O_EXCL)))
 		goto out2;
 
-	if (floppy_grab_irq_and_dma())
-		goto out2;
-
 	if (filp->f_flags & O_EXCL)
 		UDRS->fd_ref = -1;
 	else
@@ -3805,7 +3780,6 @@ out:
 		UDRS->fd_ref--;
 	if (!UDRS->fd_ref)
 		opened_bdev[drive] = NULL;
-	floppy_release_irq_and_dma();
 out2:
 	mutex_unlock(&open_lock);
 	return res;
@@ -3822,14 +3796,9 @@ static int check_floppy_change(struct ge
 		return 1;
 
 	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
-		if (floppy_grab_irq_and_dma()) {
-			return 1;
-		}
-
 		lock_fdc(drive, 0);
 		poll_drive(0, 0);
 		process_fd_request();
-		floppy_release_irq_and_dma();
 	}
 
 	if (UTESTF(FD_DISK_CHANGED) ||
@@ -4346,7 +4315,6 @@ static int __init floppy_init(void)
 	fdc = 0;
 	del_timer(&fd_timeout);
 	current_drive = 0;
-	floppy_release_irq_and_dma();
 	initialising = 0;
 	if (have_no_fdc) {
 		DPRINT("no floppy controllers found\n");
@@ -4504,7 +4472,7 @@ static void floppy_release_irq_and_dma(v
 	if (irqdma_allocated) {
 		fd_disable_dma();
 		fd_free_dma();
-		schedule_work(&fd_free_irq_work);
+		fd_free_irq();
 		irqdma_allocated = 0;
 	}
 	set_dor(0, ~0, 8);
@@ -4600,8 +4568,6 @@ void cleanup_module(void)
 	/* eject disk, if any */
 	fd_eject(0);
 
-	flush_scheduled_work();		/* fd_free_irq() might be pending */
-
 	wait_for_completion(&device_release);
 }
 
