Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUIOHXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUIOHXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 03:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUIOHXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 03:23:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43198 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262062AbUIOHWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 03:22:54 -0400
Date: Wed, 15 Sep 2004 09:21:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Joshua Schmidlkofer <kernel@pacrimopen.com>
Cc: Con Kolivas <kernel@kolivas.org>, jch@imr-net.com,
       ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Cliff Wells <clifford.wells@comcast.net>
Subject: Re: [ck] Re: 2.6.8.1-ck7, Two Badnessess, one dump.
Message-ID: <20040915072109.GI2304@suse.de>
References: <41412765.4010005@kolivas.org> <4144F691.6040405@pacrimopen.com> <41451957.7000101@kolivas.org> <4145BAE9.1040800@pacrimopen.com> <20040913191237.GF18883@suse.de> <41466963.702@pacrimopen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41466963.702@pacrimopen.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13 2004, Joshua Schmidlkofer wrote:
> 
> >Is your drive idle while applying dma settings? Current 2.6 kernels
> >aren't even close to being safe to modify drive settings, since it makes
> >no effective attempts to serialize with ongoing commands. I have a
> >half-assed patch to fix that.
> >
> > 
> >
> 
> No it isn't!!  But I think that would be the problem.  I just realized 
> that [after you wrote this] that I turned on 'parallel' execution in my 
> Gentoo init scripts for both of those systems.

That is for sure the problem.

> Tonight, I am going to change hdparm so that it runs xfs_freeze on all 
> fs's just before tuning, and [of course un-freeze] to see if that cures it.

You can try this patch, hope it still applies. It's against the 2.6.5
SUSE kernel, but it did apply to BK around the beginning of august as
well.

The reason I say it's half-assed is because it's not the cleanest
approach and it doesn't cover some obscure hardware cases as well. But
it's definitely safe to play with, and it does cover your hardware. With
this applied, you can safely tune your drive settings with hdparm while
it's active doing reads/writes.

diff -urp /opt/kernel/linux-2.6.5/drivers/ide/ide.c linux-2.6.5/drivers/ide/ide.c
--- /opt/kernel/linux-2.6.5/drivers/ide/ide.c	2004-05-25 11:50:14.797583926 +0200
+++ linux-2.6.5/drivers/ide/ide.c	2004-05-25 11:52:40.367855970 +0200
@@ -1289,18 +1289,28 @@ static int set_io_32bit(ide_drive_t *dri
 static int set_using_dma (ide_drive_t *drive, int arg)
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA
+	int ret = -EPERM;
+
+	ide_pin_hwgroup(drive);
+
 	if (!drive->id || !(drive->id->capability & 1))
-		return -EPERM;
+		goto out;
 	if (HWIF(drive)->ide_dma_check == NULL)
-		return -EPERM;
+		goto out;
+	ret = -EIO;
 	if (arg) {
-		if (HWIF(drive)->ide_dma_check(drive)) return -EIO;
-		if (HWIF(drive)->ide_dma_on(drive)) return -EIO;
+		if (HWIF(drive)->ide_dma_check(drive))
+			goto out;
+		if (HWIF(drive)->ide_dma_on(drive))
+			goto out;
 	} else {
 		if (__ide_dma_off(drive))
-			return -EIO;
+			goto out;
 	}
-	return 0;
+	ret = 0;
+out:
+	ide_unpin_hwgroup(drive);
+	return ret;
 #else
 	return -EPERM;
 #endif
diff -urp /opt/kernel/linux-2.6.5/drivers/ide/ide-io.c linux-2.6.5/drivers/ide/ide-io.c
--- /opt/kernel/linux-2.6.5/drivers/ide/ide-io.c	2004-05-25 11:50:15.174543192 +0200
+++ linux-2.6.5/drivers/ide/ide-io.c	2004-05-25 11:53:34.606000019 +0200
@@ -881,6 +881,46 @@ void ide_stall_queue (ide_drive_t *drive
 	drive->sleep = timeout + jiffies;
 }
 
+void ide_unpin_hwgroup(ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+
+	if (hwgroup) {
+		spin_lock_irq(&ide_lock);
+		HWGROUP(drive)->busy = 0;
+		drive->blocked = 0;
+		do_ide_request(drive->queue);
+		spin_unlock_irq(&ide_lock);
+	}
+}
+
+void ide_pin_hwgroup(ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+
+	/*
+	 * should only happen very early, so not a problem
+	 */
+	if (!hwgroup)
+		return;
+
+	spin_lock_irq(&ide_lock);
+	do {
+		if (!hwgroup->busy && !drive->blocked && !drive->doing_barrier)
+			break;
+		spin_unlock_irq(&ide_lock);
+		schedule_timeout(HZ/100);
+		spin_lock_irq(&ide_lock);
+	} while (hwgroup->busy || drive->blocked || drive->doing_barrier);
+
+	/*
+	 * we've now secured exclusive access to this hwgroup
+	 */
+	hwgroup->busy = 1;
+	drive->blocked = 1;
+	spin_unlock_irq(&ide_lock);
+}
+
 EXPORT_SYMBOL(ide_stall_queue);
 
 #define WAKEUP(drive)	((drive)->service_start + 2 * (drive)->service_time)
diff -urp /opt/kernel/linux-2.6.5/drivers/ide/ide-lib.c linux-2.6.5/drivers/ide/ide-lib.c
--- /opt/kernel/linux-2.6.5/drivers/ide/ide-lib.c	2004-05-25 11:50:15.204539951 +0200
+++ linux-2.6.5/drivers/ide/ide-lib.c	2004-05-25 11:52:40.433848845 +0200
@@ -436,13 +436,17 @@ EXPORT_SYMBOL(ide_toggle_bounce);
  
 int ide_set_xfer_rate(ide_drive_t *drive, u8 rate)
 {
+	int ret;
 #ifndef CONFIG_BLK_DEV_IDEDMA
 	rate = min(rate, (u8) XFER_PIO_4);
 #endif
-	if(HWIF(drive)->speedproc)
-		return HWIF(drive)->speedproc(drive, rate);
+	ide_pin_hwgroup(drive);
+	if (HWIF(drive)->speedproc)
+		ret = HWIF(drive)->speedproc(drive, rate);
 	else
-		return -1;
+		ret = -1;
+	ide_unpin_hwgroup(drive);
+	return ret;
 }
 
 EXPORT_SYMBOL_GPL(ide_set_xfer_rate);
diff -urp /opt/kernel/linux-2.6.5/include/linux/ide.h linux-2.6.5/include/linux/ide.h
--- /opt/kernel/linux-2.6.5/include/linux/ide.h	2004-05-25 11:50:29.701973356 +0200
+++ linux-2.6.5/include/linux/ide.h	2004-05-25 11:52:40.457846254 +0200
@@ -1474,6 +1474,9 @@ extern irqreturn_t ide_intr(int irq, voi
 extern void do_ide_request(request_queue_t *);
 extern void ide_init_subdrivers(void);
 
+extern void ide_pin_hwgroup(ide_drive_t *);
+extern void ide_unpin_hwgroup(ide_drive_t *);
+
 extern struct block_device_operations ide_fops[];
 extern ide_proc_entry_t generic_subdriver_entries[];
 

-- 
Jens Axboe

