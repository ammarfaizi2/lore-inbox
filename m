Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316244AbSEKSCc>; Sat, 11 May 2002 14:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316245AbSEKSCb>; Sat, 11 May 2002 14:02:31 -0400
Received: from [195.63.194.11] ([195.63.194.11]:20235 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316244AbSEKSCT>; Sat, 11 May 2002 14:02:19 -0400
Message-ID: <3CDD4DE5.5030200@evision-ventures.com>
Date: Sat, 11 May 2002 18:59:17 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.15 IDE 60
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080105080300090507040004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080105080300090507040004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fri May 10 16:17:01 CEST 2002 ide-clean-60

Synchronize with 2.5.15

- Rewrite ioctl handling.

- Apply fix for hpt366 "hang on boot" by Andre.

- Remove stale XXX_tune_req. It was no longer used.

- Propagate rq through ide_error(), ide_end_drive_cmd(), ide_dump_status(),
   ide_wait_stat().

- Push the current drive down to ata_channel from hwgroup.

- Push the timer down to the ata_channel structure. Most probably it will end
   at the drive.



--------------080105080300090507040004
Content-Type: text/plain;
 name="ide-clean-60.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-60.diff"

diff -urN linux-2.5.15/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.15/drivers/ide/hpt366.c	2002-05-10 00:22:02.000000000 +0200
+++ linux/drivers/ide/hpt366.c	2002-05-10 16:18:40.000000000 +0200
@@ -670,8 +670,8 @@
 	 * Disable the "fast interrupt" prediction.
 	 */
 	pci_read_config_byte(dev, regfast, &drive_fast);
-	if (drive_fast & 0x02)
-		pci_write_config_byte(dev, regfast, drive_fast & ~0x20);
+	if (drive_fast & 0x80)
+		pci_write_config_byte(dev, regfast, drive_fast & ~0x80);
 
 	pci_read_config_dword(dev, regtime, &reg1);
 	reg2 = pci_bus_clock_list(speed,
diff -urN linux-2.5.15/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.15/drivers/ide/ide.c	2002-05-10 00:24:14.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-11 18:38:21.000000000 +0200
@@ -337,17 +337,18 @@
 		      unsigned long timeout, ata_expiry_t expiry)
 {
 	unsigned long flags;
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	struct ata_channel *ch = drive->channel;
+	ide_hwgroup_t *hwgroup = ch->hwgroup;
 
 	spin_lock_irqsave(&ide_lock, flags);
 	if (hwgroup->handler != NULL) {
 		printk("%s: ide_set_handler: handler not null; old=%p, new=%p, from %p\n",
 			drive->name, hwgroup->handler, handler, __builtin_return_address(0));
 	}
-	hwgroup->handler	= handler;
-	hwgroup->expiry		= expiry;
-	hwgroup->timer.expires	= jiffies + timeout;
-	add_timer(&hwgroup->timer);
+	hwgroup->handler = handler;
+	ch->expiry = expiry;
+	ch->timer.expires = jiffies + timeout;
+	add_timer(&ch->timer);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
@@ -592,15 +593,11 @@
 
 /*
  * Clean up after success/failure of an explicit drive cmd
+ *
+ * Should be called under lock held.
  */
-void ide_end_drive_cmd(struct ata_device *drive, byte stat, byte err)
+void ide_end_drive_cmd(struct ata_device *drive, struct request *rq, u8 stat, u8 err)
 {
-	unsigned long flags;
-	struct request *rq;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	rq = HWGROUP(drive)->rq;
-
 	if (rq->flags & REQ_DRIVE_CMD) {
 		u8 *args = rq->buffer;
 		rq->errors = !OK_STAT(stat, READY_STAT, BAD_STAT);
@@ -640,14 +637,12 @@
 	blkdev_dequeue_request(rq);
 	HWGROUP(drive)->rq = NULL;
 	end_that_request_last(rq);
-
-	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
 /*
  * Error reporting, in human readable form (luxurious, but a memory hog).
  */
-byte ide_dump_status(struct ata_device *drive, const char *msg, byte stat)
+u8 ide_dump_status(struct ata_device *drive, struct request * rq, const char *msg, u8 stat)
 {
 	unsigned long flags;
 	byte err = 0;
@@ -722,8 +717,8 @@
 						  IN_BYTE(IDE_SECTOR_REG));
 					}
 				}
-				if (HWGROUP(drive) && HWGROUP(drive)->rq)
-					printk(", sector=%ld", HWGROUP(drive)->rq->sector);
+				if (rq)
+					printk(", sector=%ld", rq->sector);
 			}
 		}
 #endif
@@ -786,18 +781,17 @@
 /*
  * Take action based on the error returned by the drive.
  */
-ide_startstop_t ide_error(struct ata_device *drive, const char *msg, byte stat)
+ide_startstop_t ide_error(struct ata_device *drive, struct request *rq, const char *msg, byte stat)
 {
-	struct request *rq;
 	byte err;
 
-	err = ide_dump_status(drive, msg, stat);
-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
+	err = ide_dump_status(drive, rq, msg, stat);
+	if (!drive || !rq)
 		return ide_stopped;
 	/* retry only "normal" I/O: */
 	if (!(rq->flags & REQ_CMD)) {
 		rq->errors = 1;
-		ide_end_drive_cmd(drive, stat, err);
+		ide_end_drive_cmd(drive, rq, stat, err);
 		return ide_stopped;
 	}
 
@@ -869,8 +863,8 @@
 	}
 
 	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
-		return ide_error(drive, "drive_cmd", stat); /* calls ide_end_drive_cmd */
-	ide_end_drive_cmd (drive, stat, GET_ERR());
+		return ide_error(drive, rq, "drive_cmd", stat); /* calls ide_end_drive_cmd */
+	ide_end_drive_cmd(drive, rq, stat, GET_ERR());
 
 	return ide_stopped;
 }
@@ -886,8 +880,11 @@
  * setting a timer to wake up at half second intervals thereafter, until
  * timeout is achieved, before timing out.
  */
-int ide_wait_stat(ide_startstop_t *startstop, struct ata_device *drive, byte good, byte bad, unsigned long timeout) {
-	byte stat;
+int ide_wait_stat(ide_startstop_t *startstop,
+		struct ata_device *drive, struct request *rq,
+		byte good, byte bad, unsigned long timeout)
+{
+	u8 stat;
 	int i;
 	unsigned long flags;
 
@@ -903,9 +900,9 @@
 		ide__sti();		/* local CPU only */
 		timeout += jiffies;
 		while ((stat = GET_STAT()) & BUSY_STAT) {
-			if (0 < (signed long)(jiffies - timeout)) {
+			if (time_after(timeout, jiffies)) {
 				__restore_flags(flags);	/* local CPU only */
-				*startstop = ide_error(drive, "status timeout", stat);
+				*startstop = ide_error(drive, rq, "status timeout", stat);
 				return 1;
 			}
 		}
@@ -923,7 +920,8 @@
 		if (OK_STAT((stat = GET_STAT()), good, bad))
 			return 0;
 	}
-	*startstop = ide_error(drive, "status error", stat);
+	*startstop = ide_error(drive, rq, "status error", stat);
+
 	return 1;
 }
 
@@ -975,7 +973,7 @@
 		ide_startstop_t res;
 
 		SELECT_DRIVE(ch, drive);
-		if (ide_wait_stat(&res, drive, drive->ready_stat,
+		if (ide_wait_stat(&res, drive, rq, drive->ready_stat,
 					BUSY_STAT|DRQ_STAT, WAIT_READY)) {
 			printk(KERN_WARNING "%s: drive not ready for command\n", drive->name);
 
@@ -1066,20 +1064,21 @@
 #ifdef DEBUG
 	printk("%s: DRIVE_CMD (null)\n", drive->name);
 #endif
-	ide_end_drive_cmd(drive, GET_STAT(), GET_ERR());
+	ide_end_drive_cmd(drive, rq, GET_STAT(), GET_ERR());
 
 	return ide_stopped;
 }
 
 ide_startstop_t restart_request(struct ata_device *drive)
 {
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	struct ata_channel *ch = drive->channel;
+	ide_hwgroup_t *hwgroup = ch->hwgroup;
 	unsigned long flags;
 	struct request *rq;
 
 	spin_lock_irqsave(&ide_lock, flags);
 	hwgroup->handler = NULL;
-	del_timer(&hwgroup->timer);
+	del_timer(&ch->timer);
 	rq = hwgroup->rq;
 	spin_unlock_irqrestore(&ide_lock, flags);
 
@@ -1195,11 +1194,11 @@
 		if (time_after(jiffies, sleep - WAIT_MIN_SLEEP))
 			sleep = jiffies + WAIT_MIN_SLEEP;
 #if 1
-		if (timer_pending(&channel->hwgroup->timer))
+		if (timer_pending(&channel->timer))
 			printk(KERN_ERR "ide_set_handler: timer already active\n");
 #endif
 		set_bit(IDE_SLEEP, &channel->hwgroup->flags);
-		mod_timer(&channel->hwgroup->timer, sleep);
+		mod_timer(&channel->timer, sleep);
 		/* we purposely leave hwgroup busy while sleeping */
 	} else {
 		/* Ugly, but how can we sleep for the lock otherwise? perhaps
@@ -1341,8 +1340,8 @@
 static void ide_do_request(struct ata_channel *channel, int masked_irq)
 {
 	ide_hwgroup_t *hwgroup = channel->hwgroup;
-	ide_get_lock(&irq_lock, ata_irq_request, hwgroup);/* for atari only: POSSIBLY BROKEN HERE(?) */
 
+	ide_get_lock(&irq_lock, ata_irq_request, hwgroup);/* for atari only: POSSIBLY BROKEN HERE(?) */
 	__cli();	/* necessary paranoia: ensure IRQs are masked on local CPU */
 
 	while (!test_and_set_bit(IDE_BUSY, &hwgroup->flags)) {
@@ -1357,7 +1356,7 @@
 
 		ch = drive->channel;
 
-		if (hwgroup->XXX_drive->channel->sharing_irq && ch != hwgroup->XXX_drive->channel && ch->io_ports[IDE_CONTROL_OFFSET]) {
+		if (channel->sharing_irq && ch != channel && ch->io_ports[IDE_CONTROL_OFFSET]) {
 			/* set nIEN for previous channel */
 			/* FIXME: check this! It appears to act on the current channel! */
 
@@ -1369,7 +1368,7 @@
 
 		/* Remember the last drive we where acting on.
 		 */
-		hwgroup->XXX_drive = drive;
+		ch->drive = drive;
 
 		queue_commands(drive, masked_irq);
 	}
@@ -1423,7 +1422,8 @@
  */
 void ide_timer_expiry(unsigned long data)
 {
-	ide_hwgroup_t *hwgroup = (ide_hwgroup_t *) data;
+	struct ata_channel *ch = (struct ata_channel *) data;
+	ide_hwgroup_t *hwgroup = ch->hwgroup;
 	ata_handler_t *handler;
 	ata_expiry_t *expiry;
 	unsigned long flags;
@@ -1435,7 +1435,7 @@
 	 */
 
 	spin_lock_irqsave(&ide_lock, flags);
-	del_timer(&hwgroup->timer);
+	del_timer(&ch->timer);
 
 	if ((handler = hwgroup->handler) == NULL) {
 
@@ -1449,23 +1449,22 @@
 		if (test_and_clear_bit(IDE_SLEEP, &hwgroup->flags))
 			clear_bit(IDE_BUSY, &hwgroup->flags);
 	} else {
-		struct ata_device *drive = hwgroup->XXX_drive;
+		struct ata_device *drive = ch->drive;
 		if (!drive) {
 			printk("ide_timer_expiry: hwgroup->drive was NULL\n");
 			hwgroup->handler = NULL;
 		} else {
-			struct ata_channel *ch;
 			ide_startstop_t startstop;
 
 			/* paranoia */
 			if (!test_and_set_bit(IDE_BUSY, &hwgroup->flags))
 				printk("%s: ide_timer_expiry: hwgroup was not busy??\n", drive->name);
-			if ((expiry = hwgroup->expiry) != NULL) {
+			if ((expiry = ch->expiry) != NULL) {
 				/* continue */
 				if ((wait = expiry(drive, HWGROUP(drive)->rq)) != 0) {
 					/* reengage timer */
-					hwgroup->timer.expires  = jiffies + wait;
-					add_timer(&hwgroup->timer);
+					ch->timer.expires  = jiffies + wait;
+					add_timer(&ch->timer);
 					spin_unlock_irqrestore(&ide_lock, flags);
 					return;
 				}
@@ -1497,7 +1496,7 @@
 					startstop = ide_stopped;
 					dma_timeout_retry(drive, ch->hwgroup->rq);
 				} else
-					startstop = ide_error(drive, "irq timeout", GET_STAT());
+					startstop = ide_error(drive, ch->hwgroup->rq, "irq timeout", GET_STAT());
 			}
 			set_recovery_timer(ch);
 			enable_irq(ch->irq);
@@ -1507,7 +1506,7 @@
 		}
 	}
 
-	ide_do_request(hwgroup->XXX_drive->channel, 0);
+	ide_do_request(ch->drive->channel, 0);
 
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
@@ -1617,7 +1616,7 @@
 		}
 		goto out_lock;
 	}
-	drive = hwgroup->XXX_drive;
+	drive = ch->drive;
 	if (!drive_is_ready(drive)) {
 		/*
 		 * This happens regularly when we share a PCI IRQ with another device.
@@ -1631,7 +1630,7 @@
 	if (!test_and_set_bit(IDE_BUSY, &hwgroup->flags))
 		printk(KERN_ERR "%s: %s: hwgroup was not busy!?\n", drive->name, __FUNCTION__);
 	hwgroup->handler = NULL;
-	del_timer(&hwgroup->timer);
+	del_timer(&ch->timer);
 	spin_unlock(&ide_lock);
 
 	if (ch->unmask)
@@ -2002,7 +2001,7 @@
 	 */
 
 	hwgroup = ch->hwgroup;
-	d = hwgroup->XXX_drive;
+	d = ch->drive;
 	for (i = 0; i < MAX_DRIVES; ++i) {
 		struct ata_device *drive = &ch->drives[i];
 
@@ -2013,8 +2012,9 @@
 		if (!drive->present)
 			continue;
 
-		if (hwgroup->XXX_drive == drive)
-			hwgroup->XXX_drive = NULL;
+		/* FIXME: possibly unneccessary */
+		if (ch->drive == drive)
+			ch->drive = NULL;
 
 		if (drive->id != NULL) {
 			kfree(drive->id);
@@ -2024,7 +2024,7 @@
 		blk_cleanup_queue(&drive->queue);
 	}
 	if (d->present)
-		hwgroup->XXX_drive = d;
+		ch->drive = d;
 
 
 	/*
@@ -2220,84 +2220,6 @@
 	return ide_register_hw(&hw, NULL);
 }
 
-void ide_add_setting(struct ata_device *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
-{
-	ide_settings_t **p = &drive->settings;
-	ide_settings_t *setting = NULL;
-
-	while ((*p) && strcmp((*p)->name, name) < 0)
-		p = &((*p)->next);
-	if ((setting = kmalloc(sizeof(*setting), GFP_KERNEL)) == NULL)
-		goto abort;
-	memset(setting, 0, sizeof(*setting));
-	if ((setting->name = kmalloc(strlen(name) + 1, GFP_KERNEL)) == NULL)
-		goto abort;
-	strcpy(setting->name, name);		setting->rw = rw;
-	setting->read_ioctl = read_ioctl;	setting->write_ioctl = write_ioctl;
-	setting->data_type = data_type;		setting->min = min;
-	setting->max = max;			setting->mul_factor = mul_factor;
-	setting->div_factor = div_factor;	setting->data = data;
-	setting->set = set;			setting->next = *p;
-	if (drive->driver)
-		setting->auto_remove = 1;
-	*p = setting;
-	return;
-abort:
-	if (setting)
-		kfree(setting);
-}
-
-void ide_remove_setting(struct ata_device *drive, char *name)
-{
-	ide_settings_t **p = &drive->settings, *setting;
-
-	while ((*p) && strcmp((*p)->name, name))
-		p = &((*p)->next);
-	if ((setting = (*p)) == NULL)
-		return;
-	(*p) = setting->next;
-	kfree(setting->name);
-	kfree(setting);
-}
-
-static void auto_remove_settings(struct ata_device *drive)
-{
-	ide_settings_t *setting;
-repeat:
-	setting = drive->settings;
-	while (setting) {
-		if (setting->auto_remove) {
-			ide_remove_setting(drive, setting->name);
-			goto repeat;
-		}
-		setting = setting->next;
-	}
-}
-
-int ide_read_setting(struct ata_device *drive, ide_settings_t *setting)
-{
-	int val = -EINVAL;
-	unsigned long flags;
-
-	if ((setting->rw & SETTING_READ)) {
-		spin_lock_irqsave(&ide_lock, flags);
-		switch(setting->data_type) {
-			case TYPE_BYTE:
-				val = *((u8 *) setting->data);
-				break;
-			case TYPE_SHORT:
-				val = *((u16 *) setting->data);
-				break;
-			case TYPE_INT:
-			case TYPE_INTA:
-				val = *((u32 *) setting->data);
-				break;
-		}
-		spin_unlock_irqrestore(&ide_lock, flags);
-	}
-	return val;
-}
-
 int ide_spin_wait_hwgroup(struct ata_device *drive)
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
@@ -2322,46 +2244,6 @@
 	return 0;
 }
 
-/*
- * FIXME:  This should be changed to enqueue a special request
- * to the driver to change settings, and then wait on a semaphore for completion.
- * The current scheme of polling is kludgey, though safe enough.
- */
-int ide_write_setting(struct ata_device *drive, ide_settings_t *setting, int val)
-{
-	int i;
-	u32 *p;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-	if (!(setting->rw & SETTING_WRITE))
-		return -EPERM;
-	if (val < setting->min || val > setting->max)
-		return -EINVAL;
-	if (setting->set)
-		return setting->set(drive, val);
-	if (ide_spin_wait_hwgroup(drive))
-		return -EBUSY;
-	switch (setting->data_type) {
-		case TYPE_BYTE:
-			*((u8 *) setting->data) = val;
-			break;
-		case TYPE_SHORT:
-			*((u16 *) setting->data) = val;
-			break;
-		case TYPE_INT:
-			*((u32 *) setting->data) = val;
-			break;
-		case TYPE_INTA:
-			p = (u32 *) setting->data;
-			for (i = 0; i < 1 << PARTN_BITS; i++, p++)
-				*p = val;
-			break;
-	}
-	spin_unlock_irq(&ide_lock);
-	return 0;
-}
-
 static int set_io_32bit(struct ata_device *drive, int arg)
 {
 	if (drive->channel->no_io_32bit)
@@ -2381,6 +2263,7 @@
 		return -EPERM;
 
 	udma_enable(drive, arg, 1);
+
 	return 0;
 }
 
@@ -2401,20 +2284,6 @@
 	return 0;
 }
 
-void ide_add_generic_settings(struct ata_device *drive)
-{
-/*			drive	setting name		read/write access				read ioctl		write ioctl		data type	min	max				mul_factor	div_factor	data pointer			set function */
-	ide_add_setting(drive,	"io_32bit",		drive->channel->no_io_32bit ? SETTING_READ : SETTING_RW,	HDIO_GET_32BIT,		HDIO_SET_32BIT,		TYPE_BYTE,	0,	1 + (SUPPORT_VLB_SYNC << 1),	1,		1,		&drive->channel->io_32bit,		set_io_32bit);
-	ide_add_setting(drive,	"pio_mode",		SETTING_WRITE,					-1,			HDIO_SET_PIO_MODE,	TYPE_BYTE,	0,	255,				1,		1,		NULL,				set_pio_mode);
-	ide_add_setting(drive,	"slow",			SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,		1,		&drive->channel->slow,			NULL);
-	ide_add_setting(drive,	"unmaskirq",		drive->channel->no_unmask ? SETTING_READ : SETTING_RW,	HDIO_GET_UNMASKINTR,	HDIO_SET_UNMASKINTR,	TYPE_BYTE,	0,	1,				1,		1,		&drive->channel->unmask,			NULL);
-	ide_add_setting(drive,	"using_dma",		SETTING_RW,					HDIO_GET_DMA,		HDIO_SET_DMA,		TYPE_BYTE,	0,	1,				1,		1,		&drive->using_dma,		set_using_dma);
-	ide_add_setting(drive,	"ide_scsi",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,		1,		&drive->scsi,			NULL);
-	ide_add_setting(drive,	"init_speed",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	69,				1,		1,		&drive->init_speed,		NULL);
-	ide_add_setting(drive,	"current_speed",	SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	69,				1,		1,		&drive->current_speed,		NULL);
-	ide_add_setting(drive,	"number",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	3,				1,		1,		&drive->dn,			NULL);
-}
-
 /*
  * Delay for *at least* 50ms.  As we don't know how much time is left
  * until the next tick occurs, we wait an extra tick to be safe.
@@ -2433,44 +2302,125 @@
 #endif /* CONFIG_BLK_DEV_IDECS */
 }
 
+/*
+ * Handle ioctls.
+ *
+ * NOTE: Due to ridiculous coding habbits in the hdparm utility we have to
+ * always return unsigned long in case we are returning simple values.
+ */
 static int ide_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	int err = 0, major, minor;
+	unsigned int major, minor;
 	struct ata_device *drive;
 	struct request rq;
 	kdev_t dev;
-	ide_settings_t *setting;
 
 	dev = inode->i_rdev;
 	major = major(dev); minor = minor(dev);
 	if ((drive = get_info_ptr(inode->i_rdev)) == NULL)
 		return -ENODEV;
 
-	/* Find setting by ioctl */
 
-	setting = drive->settings;
+	/* Contrary to popular beleve we disallow even the reading of the ioctl
+	 * values for users which don't have permission too. We do this becouse
+	 * such information could be used by an attacker to deply a simple-user
+	 * attack, which triggers bugs present only on a particular
+	 * configuration.
+	 */
 
-	while (setting) {
-		if (setting->read_ioctl == cmd || setting->write_ioctl == cmd)
-			break;
-		setting = setting->next;
-	}
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
 
-	if (setting != NULL) {
-		if (cmd == setting->read_ioctl) {
-			err = ide_read_setting(drive, setting);
-			return err >= 0 ? put_user(err, (long *) arg) : err;
-		} else {
-			if ((minor(inode->i_rdev) & PARTN_MASK))
+	ide_init_drive_cmd(&rq);
+	switch (cmd) {
+		case HDIO_GET_32BIT: {
+			unsigned long val = drive->channel->io_32bit;
+
+			if (put_user(val, (unsigned long *) arg))
+				return -EFAULT;
+			return 0;
+		}
+
+		case HDIO_SET_32BIT: {
+			int val;
+
+			if (arg < 0 || arg > 1 + (SUPPORT_VLB_SYNC << 1))
 				return -EINVAL;
-			return ide_write_setting(drive, setting, arg);
+
+			if (ide_spin_wait_hwgroup(drive))
+				return -EBUSY;
+
+			val = set_io_32bit(drive, arg);
+			spin_unlock_irq(&ide_lock);
+
+			return val;
 		}
-	}
 
-	ide_init_drive_cmd(&rq);
-	switch (cmd) {
-		case HDIO_GETGEO:
-		{
+		case HDIO_SET_PIO_MODE: {
+			int val;
+
+			if (arg < 0 || arg > 255)
+				return -EINVAL;
+
+			if (ide_spin_wait_hwgroup(drive))
+				return -EBUSY;
+
+			val = set_pio_mode(drive, arg);
+			spin_unlock_irq(&ide_lock);
+
+			return val;
+		}
+
+		case HDIO_GET_UNMASKINTR: {
+			unsigned long val = drive->channel->unmask;
+
+			if (put_user(val, (unsigned long *) arg))
+				return -EFAULT;
+			return 0;
+		}
+
+
+		case HDIO_SET_UNMASKINTR: {
+			if (arg < 0 || arg > 1)
+				return -EINVAL;
+
+			if (ide_spin_wait_hwgroup(drive))
+				return -EBUSY;
+
+			if (drive->channel->no_unmask)
+				return -EIO;
+
+			drive->channel->unmask = arg;
+			spin_unlock_irq(&ide_lock);
+
+			return 0;
+		}
+
+		case HDIO_GET_DMA: {
+			unsigned long val = drive->using_dma;
+
+			if (put_user(val, (unsigned long *) arg))
+				return -EFAULT;
+
+			return 0;
+		}
+
+		case HDIO_SET_DMA: {
+			int val;
+
+			if (arg < 0 || arg > 1)
+				return -EINVAL;
+
+			if (ide_spin_wait_hwgroup(drive))
+				return -EBUSY;
+
+			val = set_using_dma(drive, arg);
+			spin_unlock_irq(&ide_lock);
+
+			return val;
+		}
+
+		case HDIO_GETGEO: {
 			struct hd_geometry *loc = (struct hd_geometry *) arg;
 			unsigned short bios_cyl = drive->bios_cyl; /* truncate */
 
@@ -2484,11 +2434,12 @@
 			return 0;
 		}
 
-		case HDIO_GETGEO_BIG_RAW:
-		{
+		case HDIO_GETGEO_BIG_RAW: {
 			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
+
 			if (!loc || (drive->type != ATA_DISK && drive->type != ATA_FLOPPY))
 				return -EINVAL;
+
 			if (put_user(drive->head, (u8 *) &loc->heads)) return -EFAULT;
 			if (put_user(drive->sect, (u8 *) &loc->sectors)) return -EFAULT;
 			if (put_user(drive->cyl, (unsigned int *) &loc->cylinders)) return -EFAULT;
@@ -2532,6 +2483,7 @@
 				return -EPERM;
 			}
 			return 0;
+
 		case BLKGETSIZE:
 		case BLKGETSIZE64:
 		case BLKROSET:
@@ -2566,6 +2518,9 @@
 				drive->channel->busproc(drive, (int)arg);
 			return 0;
 
+		/* Now check whatever this particular ioctl has a special
+		 * implementation.
+		 */
 		default:
 			if (ata_ops(drive) && ata_ops(drive)->ioctl)
 				return ata_ops(drive)->ioctl(drive, inode, file, cmd, arg);
@@ -2573,7 +2528,7 @@
 	}
 }
 
-static int ide_check_media_change (kdev_t i_rdev)
+static int ide_check_media_change(kdev_t i_rdev)
 {
 	struct ata_device *drive;
 	int res = 0; /* not changed */
@@ -3201,7 +3156,6 @@
 #if defined(CONFIG_BLK_DEV_ISAPNP) && defined(CONFIG_ISAPNP) && defined(MODULE)
 	pnpide_init(0);
 #endif
-	auto_remove_settings(drive);
 	drive->driver = NULL;
 	drive->present = 0;
 
@@ -3255,7 +3209,6 @@
 EXPORT_SYMBOL(ide_lock);
 EXPORT_SYMBOL(drive_is_flashcard);
 EXPORT_SYMBOL(ide_timer_expiry);
-EXPORT_SYMBOL(ide_add_generic_settings);
 EXPORT_SYMBOL(do_ide_request);
 /*
  * Driver module
@@ -3278,8 +3231,6 @@
 EXPORT_SYMBOL(ide_cmd);
 EXPORT_SYMBOL(ide_delay_50ms);
 EXPORT_SYMBOL(ide_stall_queue);
-EXPORT_SYMBOL(ide_add_setting);
-EXPORT_SYMBOL(ide_remove_setting);
 
 EXPORT_SYMBOL(ide_register_hw);
 EXPORT_SYMBOL(ide_register);
diff -urN linux-2.5.15/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.15/drivers/ide/ide-cd.c	2002-05-10 00:24:12.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-05-11 16:10:45.000000000 +0200
@@ -594,7 +594,7 @@
 		pc = (struct packet_command *) rq->special;
 		pc->stat = 1;
 		cdrom_end_request(drive, rq, 1);
-		*startstop = ide_error (drive, "request sense failure", stat);
+		*startstop = ide_error (drive, rq, "request sense failure", stat);
 
 		return 1;
 	} else if (rq->flags & (REQ_PC | REQ_BLOCK_PC)) {
@@ -614,7 +614,7 @@
 			return 0;
 		} else if (!pc->quiet) {
 			/* Otherwise, print an error. */
-			ide_dump_status(drive, "packet command error", stat);
+			ide_dump_status(drive, rq, "packet command error", stat);
 		}
 
 		/* Set the error flag and complete the request.
@@ -662,18 +662,18 @@
 			   sense_key == DATA_PROTECT) {
 			/* No point in retrying after an illegal
 			   request or data protect error.*/
-			ide_dump_status (drive, "command error", stat);
+			ide_dump_status(drive, rq, "command error", stat);
 			cdrom_end_request(drive, rq,  0);
 		} else if (sense_key == MEDIUM_ERROR) {
 			/* No point in re-trying a zillion times on a bad
 			 * sector.  The error is not correctable at all.
 			 */
-			ide_dump_status (drive, "media error (bad sector)", stat);
+			ide_dump_status(drive, rq, "media error (bad sector)", stat);
 			cdrom_end_request(drive, rq, 0);
 		} else if ((err & ~ABRT_ERR) != 0) {
 			/* Go to the default handler
 			   for other errors. */
-			*startstop = ide_error (drive, __FUNCTION__, stat);
+			*startstop = ide_error(drive, rq, __FUNCTION__, stat);
 			return 1;
 		} else if ((++rq->errors > ERROR_MAX)) {
 			/* We've racked up too many retries.  Abort. */
@@ -732,7 +732,7 @@
 	struct cdrom_info *info = drive->driver_data;
 
 	/* Wait for the controller to be idle. */
-	if (ide_wait_stat(&startstop, drive, 0, BUSY_STAT, WAIT_READY))
+	if (ide_wait_stat(&startstop, drive, rq, 0, BUSY_STAT, WAIT_READY))
 		return startstop;
 
 	if (info->dma) {
@@ -789,7 +789,7 @@
 			return startstop;
 	} else {
 		/* Otherwise, we must wait for DRQ to get set. */
-		if (ide_wait_stat(&startstop, drive, DRQ_STAT, BUSY_STAT, WAIT_READY))
+		if (ide_wait_stat(&startstop, drive, rq, DRQ_STAT, BUSY_STAT, WAIT_READY))
 			return startstop;
 	}
 
@@ -917,7 +917,7 @@
 			__ide_end_request(drive, rq, 1, rq->nr_sectors);
 			return ide_stopped;
 		} else
-			return ide_error (drive, "dma error", stat);
+			return ide_error (drive, rq, "dma error", stat);
 	}
 
 	/* Read the interrupt reason and the transfer length. */
@@ -1496,7 +1496,7 @@
 	 */
 	if (dma) {
 		if (dma_error)
-			return ide_error(drive, "dma error", stat);
+			return ide_error(drive, rq, "dma error", stat);
 
 		__ide_end_request(drive, rq, 1, rq->nr_sectors);
 		return ide_stopped;
@@ -2659,12 +2659,6 @@
 	return nslots;
 }
 
-static void ide_cdrom_add_settings(ide_drive_t *drive)
-{
-	ide_add_setting(drive, "dsc_overlap",
-			SETTING_RW, -1, -1, TYPE_BYTE, 0, 1, 1,	1, &drive->dsc_overlap, NULL);
-}
-
 static
 int ide_cdrom_setup(ide_drive_t *drive)
 {
@@ -2798,7 +2792,7 @@
 		info->devinfo.handle = NULL;
 		return 1;
 	}
-	ide_cdrom_add_settings(drive);
+
 	return 0;
 }
 
diff -urN linux-2.5.15/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.15/drivers/ide/ide-disk.c	2002-05-10 00:21:30.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-05-11 18:40:50.000000000 +0200
@@ -472,12 +472,6 @@
 	drive->nowerr = arg;
 	drive->bad_wstat = arg ? BAD_R_STAT : BAD_W_STAT;
 
-	/* FIXME: I'm less then sure that we are under the global request lock here!
-	 */
-#if 0
-	spin_unlock_irq(&ide_lock);
-#endif
-
 	return 0;
 }
 
@@ -531,8 +525,10 @@
 {
 	if (!drive->driver)
 		return -EPERM;
+
 	if (!drive->channel->XXX_udma)
 		return -EPERM;
+
 	if (arg == drive->queue_depth && drive->using_tcq)
 		return 0;
 
@@ -568,20 +564,6 @@
 	return (probe_lba_addressing(drive, arg));
 }
 
-static void idedisk_add_settings(struct ata_device *drive)
-{
-	struct hd_driveid *id = drive->id;
-
-	ide_add_setting(drive,	"address",		SETTING_RW,					HDIO_GET_ADDRESS,	HDIO_SET_ADDRESS,	TYPE_INTA,	0,	2,				1,	1,	&drive->addressing,	set_lba_addressing);
-	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 0,	1,	1,	&drive->mult_count,		set_multcount);
-	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
-	ide_add_setting(drive,	"wcache",		SETTING_RW,					HDIO_GET_WCACHE,	HDIO_SET_WCACHE,	TYPE_BYTE,	0,	1,				1,	1,	&drive->wcache,			write_cache);
-	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-	ide_add_setting(drive,	"using_tcq",		SETTING_RW,					HDIO_GET_QDMA,		HDIO_SET_QDMA,		TYPE_BYTE,	0,	IDE_MAX_TAG,			1,		1,		&drive->using_tcq,		set_using_tcq);
-#endif
-}
-
 static int idedisk_suspend(struct device *dev, u32 state, u32 level)
 {
 	struct ata_device *drive = dev->driver_data;
@@ -624,9 +606,6 @@
 
 
 /* This is just a hook for the overall driver tree.
- *
- * FIXME: This is soon goig to replace the custom linked list games played up
- * to great extend between the different components of the IDE drivers.
  */
 
 static struct device_driver idedisk_devdrv = {
@@ -783,8 +762,6 @@
 	sector_t set_max;
 	int drvid = -1;
 
-	idedisk_add_settings(drive);
-
 	if (id == NULL)
 		return;
 
@@ -1022,6 +999,159 @@
 	return ide_unregister_subdriver(drive);
 }
 
+static int idedisk_ioctl(struct ata_device *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct hd_driveid *id = drive->id;
+
+	switch (cmd) {
+		case HDIO_GET_ADDRESS: {
+			unsigned long val = drive->addressing;
+
+			if (put_user(val, (unsigned long *) arg))
+				return -EFAULT;
+			return 0;
+		}
+
+		case HDIO_SET_ADDRESS: {
+			int val;
+
+			if (arg < 0 || arg > 2)
+				return -EINVAL;
+
+			if (ide_spin_wait_hwgroup(drive))
+				return -EBUSY;
+
+			val = set_lba_addressing(drive, arg);
+			spin_unlock_irq(&ide_lock);
+
+			return val;
+		}
+
+		case HDIO_GET_MULTCOUNT: {
+			unsigned long val = drive->mult_count & 0xFF;
+
+			if (put_user(val, (unsigned long *) arg))
+				return -EFAULT;
+			return 0;
+		}
+
+		case HDIO_SET_MULTCOUNT: {
+			int val;
+
+			if (!id)
+				return -EBUSY;
+
+			if (arg < 0 || arg > (id ? id->max_multsect : 0))
+				return -EINVAL;
+
+			if (ide_spin_wait_hwgroup(drive))
+				return -EBUSY;
+
+			val = set_multcount(drive, arg);
+			spin_unlock_irq(&ide_lock);
+
+			return val;
+		}
+
+		case HDIO_GET_NOWERR: {
+			unsigned long val = drive->nowerr;
+
+			if (put_user(val, (unsigned long *) arg))
+				return -EFAULT;
+			return 0;
+		}
+
+		case HDIO_SET_NOWERR: {
+			int val;
+
+			if (arg < 0 || arg > 1)
+				return -EINVAL;
+
+			if (ide_spin_wait_hwgroup(drive))
+				return -EBUSY;
+
+			val = set_nowerr(drive, arg);
+			spin_unlock_irq(&ide_lock);
+
+			return val;
+		}
+
+		case HDIO_GET_WCACHE: {
+			unsigned long val = drive->wcache;
+
+			if (put_user(val, (unsigned long *) arg))
+				return -EFAULT;
+			return 0;
+		}
+
+		case HDIO_SET_WCACHE: {
+			int val;
+
+			if (arg < 0 || arg > 1)
+				return -EINVAL;
+
+			if (ide_spin_wait_hwgroup(drive))
+				return -EBUSY;
+
+			val = write_cache(drive, arg);
+			spin_unlock_irq(&ide_lock);
+
+			return val;
+		}
+
+		case HDIO_GET_ACOUSTIC: {
+			u8 val = drive->acoustic;
+
+			if (put_user(val, (u8 *) arg))
+				return -EFAULT;
+			return 0;
+		}
+
+		case HDIO_SET_ACOUSTIC: {
+			int val;
+
+			if (arg < 0 || arg > 254)
+				return -EINVAL;
+
+			if (ide_spin_wait_hwgroup(drive))
+				return -EBUSY;
+
+			val = set_acoustic(drive, arg);
+			spin_unlock_irq(&ide_lock);
+
+			return val;
+		}
+
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+		case HDIO_GET_QDMA: {
+			u8 val = drive->using_tcq;
+
+			if (put_user(val, (u8 *) arg))
+				return -EFAULT;
+			return 0;
+		}
+
+		case HDIO_SET_QDMA: {
+			int val;
+
+			if (arg < 0 || arg > IDE_MAX_TAG)
+				return -EINVAL;
+
+			if (ide_spin_wait_hwgroup(drive))
+				return -EBUSY;
+
+			val = set_using_tcq(drive, arg);
+			spin_unlock_irq(&ide_lock);
+
+			return val;
+		}
+#endif
+		default:
+			return -EINVAL;
+	}
+}
+
+
 /*
  *      IDE subdriver functions, registered with ide.c
  */
@@ -1031,7 +1161,7 @@
 	standby:		idedisk_standby,
 	do_request:		idedisk_do_request,
 	end_request:		NULL,
-	ioctl:			NULL,
+	ioctl:			idedisk_ioctl,
 	open:			idedisk_open,
 	release:		idedisk_release,
 	check_media_change:	idedisk_check_media_change,
diff -urN linux-2.5.15/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.15/drivers/ide/ide-dma.c	2002-05-10 00:22:44.000000000 +0200
+++ linux/drivers/ide/ide-dma.c	2002-05-11 14:57:37.000000000 +0200
@@ -208,7 +208,7 @@
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n",
 		       drive->name, dma_stat);
 	}
-	return ide_error(drive, "dma_intr", stat);
+	return ide_error(drive, rq, "dma_intr", stat);
 }
 
 /*
@@ -375,7 +375,7 @@
 /*
  * 1 dma-ing, 2 error, 4 intr
  */
-static int dma_timer_expiry(struct ata_device *drive, struct request *__rq)
+static int dma_timer_expiry(struct ata_device *drive, struct request *rq)
 {
 	/* FIXME: What's that? */
 	u8 dma_stat = inb(drive->channel->dma_base+2);
@@ -390,7 +390,7 @@
 
 	if (dma_stat & 2) {	/* ERROR */
 		u8 stat = GET_STAT();
-		return ide_error(drive, "dma_timer_expiry", stat);
+		return ide_error(drive, rq, "dma_timer_expiry", stat);
 	}
 	if (dma_stat & 1)	/* DMAing */
 		return WAIT_CMD;
diff -urN linux-2.5.15/drivers/ide/ide-features.c linux/drivers/ide/ide-features.c
--- linux-2.5.15/drivers/ide/ide-features.c	2002-05-10 00:25:17.000000000 +0200
+++ linux/drivers/ide/ide-features.c	2002-05-11 15:21:28.000000000 +0200
@@ -393,7 +393,7 @@
 	enable_irq(hwif->irq);
 
 	if (error) {
-		ide_dump_status(drive, "set_drive_speed_status", stat);
+		ide_dump_status(drive, NULL, "set_drive_speed_status", stat);
 		return error;
 	}
 
diff -urN linux-2.5.15/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.15/drivers/ide/ide-floppy.c	2002-05-10 00:22:51.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-05-11 16:13:04.000000000 +0200
@@ -692,7 +692,7 @@
 		return 0;
 	}
 	rq->errors = error;
-	ide_end_drive_cmd (drive, 0, 0);
+	ide_end_drive_cmd (drive, rq, 0, 0);
 
 	return 0;
 }
@@ -1006,7 +1006,7 @@
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	idefloppy_ireason_reg_t ireason;
 
-	if (ide_wait_stat (&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
+	if (ide_wait_stat (&startstop, drive, rq, DRQ_STAT, BUSY_STAT, WAIT_READY)) {
 		printk (KERN_ERR "ide-floppy: Strange, packet command initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
@@ -1043,13 +1043,13 @@
 	return IDEFLOPPY_WAIT_CMD;		/* Timeout for the packet command */
 }
 
-static ide_startstop_t idefloppy_transfer_pc1(struct ata_device *drive, struct request *__rq)
+static ide_startstop_t idefloppy_transfer_pc1(struct ata_device *drive, struct request *rq)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	ide_startstop_t startstop;
 	idefloppy_ireason_reg_t ireason;
 
-	if (ide_wait_stat (&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
+	if (ide_wait_stat(&startstop, drive, rq, DRQ_STAT, BUSY_STAT, WAIT_READY)) {
 		printk (KERN_ERR "ide-floppy: Strange, packet command initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
@@ -1960,14 +1960,6 @@
 	return 0;
 }
 
-static void idefloppy_add_settings(ide_drive_t *drive)
-{
-	ide_add_setting(drive,	"bios_cyl",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	1023,				1,	1,	&drive->bios_cyl,		NULL);
-	ide_add_setting(drive,	"bios_head",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&drive->bios_head,		NULL);
-	ide_add_setting(drive,	"bios_sect",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	63,				1,	1,	&drive->bios_sect,		NULL);
-
-}
-
 /*
  *	Driver initialization.
  */
@@ -2009,7 +2001,7 @@
 	}
 
 	(void) idefloppy_get_capacity (drive);
-	idefloppy_add_settings(drive);
+
 	for (i = 0; i < MAX_DRIVES; ++i) {
 		struct ata_channel *hwif = drive->channel;
 
diff -urN linux-2.5.15/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.15/drivers/ide/ide-probe.c	2002-05-10 00:21:27.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-05-11 18:26:41.000000000 +0200
@@ -628,9 +628,6 @@
 			return 1;
 		}
 		memset(hwgroup, 0, sizeof(*hwgroup));
-		init_timer(&hwgroup->timer);
-		hwgroup->timer.function = &ide_timer_expiry;
-		hwgroup->timer.data = (unsigned long) hwgroup;
 	}
 
 	/*
@@ -659,6 +656,11 @@
 	 * Everything is okay. Tag us as member of this hardware group.
 	 */
 	ch->hwgroup = hwgroup;
+
+	init_timer(&ch->timer);
+	ch->timer.function = &ide_timer_expiry;
+	ch->timer.data = (unsigned long) ch;
+
 	for (i = 0; i < MAX_DRIVES; ++i) {
 		struct ata_device *drive = &ch->drives[i];
 		request_queue_t *q;
@@ -667,8 +669,8 @@
 		if (!drive->present)
 			continue;
 
-		if (!hwgroup->XXX_drive)
-			hwgroup->XXX_drive = drive;
+		if (!ch->drive)
+			ch->drive = drive;
 
 		/*
 		 * Init the per device request queue
@@ -842,7 +844,6 @@
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		char name[80];
 
-		ide_add_generic_settings(ch->drives + unit);
 		ch->drives[unit].dn = ((ch->unit ? 2 : 0) + unit);
 		sprintf(name, "host%d/bus%d/target%d/lun%d",
 			ch->index, ch->unit, unit, ch->drives[unit].lun);
diff -urN linux-2.5.15/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.15/drivers/ide/ide-tape.c	2002-05-10 00:22:28.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-05-11 16:11:49.000000000 +0200
@@ -1925,7 +1925,7 @@
 				idetape_increase_max_pipeline_stages (drive);
 		}
 	}
-	ide_end_drive_cmd (drive, 0, 0);
+	ide_end_drive_cmd(drive, rq, 0, 0);
 	if (remove_stage)
 		idetape_remove_stage_head (drive);
 	if (tape->active_data_request == NULL)
@@ -2228,7 +2228,7 @@
  *		we will handle the next request.
  *
  */
-static ide_startstop_t idetape_transfer_pc(struct ata_device *drive, struct request *__rq)
+static ide_startstop_t idetape_transfer_pc(struct ata_device *drive, struct request *rq)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t *pc = tape->pc;
@@ -2236,7 +2236,7 @@
 	int retries = 100;
 	ide_startstop_t startstop;
 
-	if (ide_wait_stat (&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
+	if (ide_wait_stat(&startstop, drive, rq, DRQ_STAT, BUSY_STAT, WAIT_READY)) {
 		printk (KERN_ERR "ide-tape: Strange, packet command initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
@@ -5926,41 +5926,7 @@
 	tape->tape_block_size =( block_descrp->length[0]<<16) + (block_descrp->length[1]<<8) + block_descrp->length[2];
 #if IDETAPE_DEBUG_INFO
 	printk (KERN_INFO "ide-tape: Adjusted block size - %d\n", tape->tape_block_size);
-#endif /* IDETAPE_DEBUG_INFO */
-}
-static void idetape_add_settings (ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-
-/*
- *			drive	setting name	read/write	ioctl	ioctl		data type	min			max			mul_factor			div_factor			data pointer				set function
- */
-	ide_add_setting(drive,	"buffer",	SETTING_READ,	-1,	-1,		TYPE_SHORT,	0,			0xffff,			1,				2,				&tape->capabilities.buffer_size,	NULL);
-	ide_add_setting(drive,	"pipeline_min",	SETTING_RW,	-1,	-1,		TYPE_INT,	2,			0xffff,			tape->stage_size / 1024,	1,				&tape->min_pipeline,			NULL);
-	ide_add_setting(drive,	"pipeline",	SETTING_RW,	-1,	-1,		TYPE_INT,	2,			0xffff,			tape->stage_size / 1024,	1,				&tape->max_stages,			NULL);
-	ide_add_setting(drive,	"pipeline_max",	SETTING_RW,	-1,	-1,		TYPE_INT,	2,			0xffff,			tape->stage_size / 1024,	1,				&tape->max_pipeline,			NULL);
-	ide_add_setting(drive,	"pipeline_used",SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			tape->stage_size / 1024,	1,				&tape->nr_stages,			NULL);
-	ide_add_setting(drive,	"pipeline_pending",SETTING_READ,-1,	-1,		TYPE_INT,	0,			0xffff,			tape->stage_size / 1024,	1,				&tape->nr_pending_stages,		NULL);
-	ide_add_setting(drive,	"speed",	SETTING_READ,	-1,	-1,		TYPE_SHORT,	0,			0xffff,			1,				1,				&tape->capabilities.speed,		NULL);
-	ide_add_setting(drive,	"stage",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1024,				&tape->stage_size,			NULL);
-	ide_add_setting(drive,	"tdsc",		SETTING_RW,	-1,	-1,		TYPE_INT,	IDETAPE_DSC_RW_MIN,	IDETAPE_DSC_RW_MAX,	1000,				HZ,				&tape->best_dsc_rw_frequency,		NULL);
-	ide_add_setting(drive,	"dsc_overlap",	SETTING_RW,	-1,	-1,		TYPE_BYTE,	0,			1,			1,				1,				&drive->dsc_overlap,			NULL);
-	ide_add_setting(drive,	"pipeline_head_speed_c",SETTING_READ,	-1,	-1,	TYPE_INT,	0,			0xffff,			1,				1,				&tape->controlled_pipeline_head_speed,	NULL);
-	ide_add_setting(drive,	"pipeline_head_speed_u",SETTING_READ,	-1,	-1,	TYPE_INT,	0,			0xffff,			1,				1,				&tape->uncontrolled_pipeline_head_speed,	NULL);
-	ide_add_setting(drive,	"avg_speed",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->avg_speed,		NULL);
-	ide_add_setting(drive,	"debug_level",SETTING_RW,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->debug_level,		NULL);
-	if (tape->onstream) {
-		ide_add_setting(drive,	"cur_frames",	SETTING_READ,	-1,	-1,		TYPE_SHORT,	0,			0xffff,			1,				1,				&tape->cur_frames,		NULL);
-		ide_add_setting(drive,	"max_frames",	SETTING_READ,	-1,	-1,		TYPE_SHORT,	0,			0xffff,			1,				1,				&tape->max_frames,		NULL);
-		ide_add_setting(drive,	"insert_speed",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->insert_speed,		NULL);
-		ide_add_setting(drive,	"speed_control",SETTING_RW,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->speed_control,		NULL);
-		ide_add_setting(drive,	"tape_still_time",SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->tape_still_time,		NULL);
-		ide_add_setting(drive,	"max_insert_speed",SETTING_RW,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->max_insert_speed,	NULL);
-		ide_add_setting(drive,	"insert_size",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->insert_size,		NULL);
-		ide_add_setting(drive,	"capacity",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->capacity,		NULL);
-		ide_add_setting(drive,	"first_frame",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->first_frame_position,		NULL);
-		ide_add_setting(drive,	"logical_blk",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->logical_blk_num,		NULL);
-	}
+#endif
 }
 
 /*
@@ -6074,8 +6040,6 @@
 		drive->name, tape->name, tape->capabilities.speed, (tape->capabilities.buffer_size * 512) / tape->stage_size,
 		tape->stage_size / 1024, tape->max_stages * tape->stage_size / 1024,
 		tape->best_dsc_rw_frequency * 1000 / HZ, drive->using_dma ? ", DMA":"");
-
-	idetape_add_settings(drive);
 }
 
 static int idetape_cleanup (ide_drive_t *drive)
diff -urN linux-2.5.15/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.15/drivers/ide/ide-taskfile.c	2002-05-10 00:24:42.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-11 18:35:41.000000000 +0200
@@ -308,7 +308,7 @@
 	struct ata_taskfile *args = rq->special;
 	ide_startstop_t startstop;
 
-	if (ide_wait_stat(&startstop, drive, DATA_READY, drive->bad_wstat, WAIT_DRQ))
+	if (ide_wait_stat(&startstop, drive, rq, DATA_READY, drive->bad_wstat, WAIT_DRQ))
 		return startstop;
 
 	ata_poll_drive_ready(drive);
@@ -329,7 +329,7 @@
 	 */
 	if (!rq->nr_sectors) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
-			startstop = ide_error(drive, "task_mulout_intr", stat);
+			startstop = ide_error(drive, rq, "task_mulout_intr", stat);
 
 			return startstop;
 		}
@@ -342,7 +342,7 @@
 
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT)) {
-			startstop = ide_error(drive, "task_mulout_intr", stat);
+			startstop = ide_error(drive, rq, "task_mulout_intr", stat);
 
 			return startstop;
 		}
@@ -489,12 +489,12 @@
 /*
  * This is invoked on completion of a WIN_RESTORE (recalibrate) cmd.
  */
-ide_startstop_t recal_intr(struct ata_device *drive, struct request *__rq)
+ide_startstop_t recal_intr(struct ata_device *drive, struct request *rq)
 {
 	u8 stat;
 
 	if (!OK_STAT(stat = GET_STAT(),READY_STAT,BAD_STAT))
-		return ide_error(drive, "recal_intr", stat);
+		return ide_error(drive, rq, "recal_intr", stat);
 	return ide_stopped;
 }
 
@@ -511,11 +511,11 @@
 	if (!OK_STAT(stat = GET_STAT(), READY_STAT, BAD_STAT)) {
 		/* Keep quiet for NOP because it is expected to fail. */
 		if (args && args->taskfile.command != WIN_NOP)
-			return ide_error(drive, "task_no_data_intr", stat);
+			return ide_error(drive, rq, "task_no_data_intr", stat);
 	}
 
 	if (args)
-		ide_end_drive_cmd (drive, stat, GET_ERR());
+		ide_end_drive_cmd(drive, rq, stat, GET_ERR());
 
 	return ide_stopped;
 }
@@ -523,7 +523,7 @@
 /*
  * Handler for command with PIO data-in phase
  */
-static ide_startstop_t task_in_intr (struct ata_device *drive, struct request *rq)
+static ide_startstop_t task_in_intr(struct ata_device *drive, struct request *rq)
 {
 	u8 stat	= GET_STAT();
 	char *pBuf = NULL;
@@ -531,7 +531,7 @@
 
 	if (!OK_STAT(stat,DATA_READY,BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return ide_error(drive, "task_in_intr", stat);
+			return ide_error(drive, rq, "task_in_intr", stat);
 		}
 		if (!(stat & BUSY_STAT)) {
 			DTF("task_in_intr to Soon wait for next interrupt\n");
@@ -569,7 +569,7 @@
 	struct ata_taskfile *args = rq->special;
 	ide_startstop_t startstop;
 
-	if (ide_wait_stat(&startstop, drive, DATA_READY, drive->bad_wstat, WAIT_DRQ)) {
+	if (ide_wait_stat(&startstop, drive, rq, DATA_READY, drive->bad_wstat, WAIT_DRQ)) {
 		printk(KERN_ERR "%s: no DRQ after issuing %s\n", drive->name, drive->mult_count ? "MULTWRITE" : "WRITE");
 		return startstop;
 	}
@@ -600,7 +600,7 @@
 	unsigned long flags;
 
 	if (!OK_STAT(stat,DRIVE_READY,drive->bad_wstat))
-		return ide_error(drive, "task_out_intr", stat);
+		return ide_error(drive, rq, "task_out_intr", stat);
 
 	if (!rq->current_nr_sectors)
 		if (!ide_end_request(drive, rq, 1))
@@ -632,7 +632,7 @@
 
 	if (!OK_STAT(stat = GET_STAT(),DATA_READY,BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return ide_error(drive, "task_mulin_intr", stat);
+			return ide_error(drive, rq, "task_mulin_intr", stat);
 		}
 		/* no data yet, so wait for another interrupt */
 		ide_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
diff -urN linux-2.5.15/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.15/drivers/ide/pdc4030.c	2002-05-10 00:22:49.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-05-11 15:38:26.000000000 +0200
@@ -185,7 +185,7 @@
 	if (pdc4030_cmd(drive,PROMISE_GET_CONFIG)) {
 		return 0;
 	}
-	if (ide_wait_stat(&startstop, drive,DATA_READY,BAD_W_STAT,WAIT_DRQ)) {
+	if (ide_wait_stat(&startstop, drive, NULL, DATA_READY,BAD_W_STAT,WAIT_DRQ)) {
 		printk(KERN_INFO
 			"%s: Failed Promise read config!\n",hwif->name);
 		return 0;
@@ -309,14 +309,14 @@
  */
 static ide_startstop_t promise_read_intr(struct ata_device *drive, struct request *rq)
 {
-	byte stat;
+	u8 stat;
 	int total_remaining;
 	unsigned int sectors_left, sectors_avail, nsect;
 	unsigned long flags;
 	char *to;
 
 	if (!OK_STAT(stat=GET_STAT(),DATA_READY,BAD_R_STAT)) {
-		return ide_error(drive, "promise_read_intr", stat);
+		return ide_error(drive, rq, "promise_read_intr", stat);
 	}
 
 read_again:
@@ -348,17 +348,18 @@
 	if ((rq->current_nr_sectors -= nsect) <= 0) {
 		ide_end_request(drive, rq, 1);
 	}
-/*
- * Now the data has been read in, do the following:
- * 
- * if there are still sectors left in the request, 
- *   if we know there are still sectors available from the interface,
- *     go back and read the next bit of the request.
- *   else if DRQ is asserted, there are more sectors available, so
- *     go back and find out how many, then read them in.
- *   else if BUSY is asserted, we are going to get an interrupt, so
- *     set the handler for the interrupt and just return
- */
+
+	/*
+	 * Now the data has been read in, do the following:
+	 *
+	 * if there are still sectors left in the request, if we know there are
+	 * still sectors available from the interface, go back and read the
+	 * next bit of the request.  else if DRQ is asserted, there are more
+	 * sectors available, so go back and find out how many, then read them
+	 * in.  else if BUSY is asserted, we are going to get an interrupt, so
+	 * set the handler for the interrupt and just return
+	 */
+
 	if (total_remaining > 0) {
 		if (sectors_avail)
 			goto read_next;
@@ -375,7 +376,7 @@
 		}
 		printk(KERN_ERR "%s: Eeek! promise_read_intr: sectors left "
 		       "!DRQ !BUSY\n", drive->name);
-		return ide_error(drive, "promise read intr", stat);
+		return ide_error(drive, rq, "promise read intr", stat);
 	}
 	return ide_stopped;
 }
@@ -400,7 +401,7 @@
 		ch->poll_timeout = 0;
 		printk(KERN_ERR "%s: completion timeout - still busy!\n",
 		       drive->name);
-		return ide_error(drive, "busy timeout", GET_STAT());
+		return ide_error(drive, rq, "busy timeout", GET_STAT());
 	}
 
 	ch->poll_timeout = 0;
@@ -478,7 +479,7 @@
 		}
 		ch->poll_timeout = 0;
 		printk(KERN_ERR "%s: write timed out!\n",drive->name);
-		return ide_error(drive, "write timeout", GET_STAT());
+		return ide_error(drive, rq, "write timeout", GET_STAT());
 	}
 
 	/*
@@ -613,7 +614,7 @@
  *	call the promise_write function to deal with writing the data out
  * NOTE: No interrupts are generated on writes. Write completion must be polled
  */
-		if (ide_wait_stat(&startstop, drive, DATA_READY, drive->bad_wstat, WAIT_DRQ)) {
+		if (ide_wait_stat(&startstop, drive, rq, DATA_READY, drive->bad_wstat, WAIT_DRQ)) {
 			printk(KERN_ERR "%s: no DRQ after issuing "
 			       "PROMISE_WRITE\n", drive->name);
 			return startstop;
diff -urN linux-2.5.15/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.15/drivers/ide/tcq.c	2002-05-10 00:25:27.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-05-11 18:39:23.000000000 +0200
@@ -52,7 +52,7 @@
 #undef IDE_TCQ_FIDDLE_SI
 
 static ide_startstop_t ide_dmaq_intr(struct ata_device *drive, struct request *rq);
-static ide_startstop_t service(struct ata_device *drive);
+static ide_startstop_t service(struct ata_device *drive, struct request *rq);
 
 static inline void drive_ctl_nien(struct ata_device *drive, int set)
 {
@@ -70,7 +70,7 @@
 	struct ata_taskfile *args = rq->special;
 
 	ide__sti();
-	ide_end_drive_cmd(drive, GET_STAT(), GET_ERR());
+	ide_end_drive_cmd(drive, rq, GET_STAT(), GET_ERR());
 	kfree(args);
 	return ide_stopped;
 }
@@ -82,7 +82,8 @@
  */
 static void tcq_invalidate_queue(struct ata_device *drive)
 {
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	struct ata_channel *ch = drive->channel;
+	ide_hwgroup_t *hwgroup = ch->hwgroup;
 	request_queue_t *q = &drive->queue;
 	struct ata_taskfile *args;
 	struct request *rq;
@@ -92,7 +93,7 @@
 
 	spin_lock_irqsave(&ide_lock, flags);
 
-	del_timer(&hwgroup->timer);
+	del_timer(&ch->timer);
 
 	if (test_bit(IDE_DMA, &hwgroup->flags))
 		udma_stop(drive);
@@ -169,7 +170,7 @@
 	 * if pending commands, try service before giving up
 	 */
 	if (ata_pending_commands(drive) && (GET_STAT() & SERVICE_STAT))
-		if (service(drive) == ide_started)
+		if (service(drive, hwgroup->rq) == ide_started)
 			return;
 
 	if (drive)
@@ -178,6 +179,7 @@
 
 static void set_irq(struct ata_device *drive, ata_handler_t *handler)
 {
+	struct ata_channel *ch = drive->channel;
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	unsigned long flags;
 
@@ -186,10 +188,14 @@
 	/*
 	 * always just bump the timer for now, the timeout handling will
 	 * have to be changed to be per-command
+	 *
+	 * FIXME: Jens - this is broken it will interfere with
+	 * the normal timer function on serialized drives!
 	 */
-	hwgroup->timer.function = ata_tcq_irq_timeout;
-	hwgroup->timer.data = (unsigned long) hwgroup->XXX_drive;
-	mod_timer(&hwgroup->timer, jiffies + 5 * HZ);
+
+	ch->timer.function = ata_tcq_irq_timeout;
+	ch->timer.data = (unsigned long) ch->drive;
+	mod_timer(&ch->timer, jiffies + 5 * HZ);
 
 	hwgroup->handler = handler;
 	spin_unlock_irqrestore(&ide_lock, flags);
@@ -223,9 +229,8 @@
  *
  * Also, nIEN must be set as not to need protection against ide_dmaq_intr
  */
-static ide_startstop_t service(struct ata_device *drive)
+static ide_startstop_t service(struct ata_device *drive, struct request *rq)
 {
-	struct request *rq;
 	u8 feat;
 	u8 stat;
 	int tag;
@@ -242,7 +247,7 @@
 	/*
 	 * need to select the right drive first...
 	 */
-	if (drive != HWGROUP(drive)->XXX_drive) {
+	if (drive != drive->channel->drive) {
 		SELECT_DRIVE(drive->channel, drive);
 		udelay(10);
 	}
@@ -256,8 +261,9 @@
 
 	if (wait_altstat(drive, &stat, BUSY_STAT)) {
 		printk(KERN_ERR"%s: BUSY clear took too long\n", __FUNCTION__);
-		ide_dump_status(drive, __FUNCTION__, stat);
+		ide_dump_status(drive, rq, __FUNCTION__, stat);
 		tcq_invalidate_queue(drive);
+
 		return ide_stopped;
 	}
 
@@ -267,8 +273,9 @@
 	 * FIXME, invalidate queue
 	 */
 	if (stat & ERR_STAT) {
-		ide_dump_status(drive, __FUNCTION__, stat);
+		ide_dump_status(drive, rq, __FUNCTION__, stat);
 		tcq_invalidate_queue(drive);
+
 		return ide_stopped;
 	}
 
@@ -301,7 +308,7 @@
 	return udma_tcq_start(drive, rq);
 }
 
-static ide_startstop_t check_service(struct ata_device *drive)
+static ide_startstop_t check_service(struct ata_device *drive, struct request *rq)
 {
 	u8 stat;
 
@@ -311,7 +318,7 @@
 		return ide_stopped;
 
 	if ((stat = GET_STAT()) & SERVICE_STAT)
-		return service(drive);
+		return service(drive, rq);
 
 	/*
 	 * we have pending commands, wait for interrupt
@@ -335,8 +342,9 @@
 	 */
 	if (unlikely(!OK_STAT(stat, READY_STAT, drive->bad_wstat | DRQ_STAT))) {
 		printk(KERN_ERR "%s: %s: error status %x\n", __FUNCTION__, drive->name,stat);
-		ide_dump_status(drive, __FUNCTION__, stat);
+		ide_dump_status(drive, rq, __FUNCTION__, stat);
 		tcq_invalidate_queue(drive);
+
 		return ide_stopped;
 	}
 
@@ -349,7 +357,7 @@
 	/*
 	 * we completed this command, check if we can service a new command
 	 */
-	return check_service(drive);
+	return check_service(drive, rq);
 }
 
 /*
@@ -380,11 +388,11 @@
 	 */
 	if (stat & SERVICE_STAT) {
 		TCQ_PRINTK("%s: SERV (stat=%x)\n", __FUNCTION__, stat);
-		return service(drive);
+		return service(drive, rq);
 	}
 
 	printk("%s: stat=%x, not expected\n", __FUNCTION__, stat);
-	return check_service(drive);
+	return check_service(drive, rq);
 }
 
 /*
@@ -558,7 +566,7 @@
 	OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
 
 	if (wait_altstat(drive, &stat, BUSY_STAT)) {
-		ide_dump_status(drive, "queued start", stat);
+		ide_dump_status(drive, rq, "queued start", stat);
 		tcq_invalidate_queue(drive);
 		return ide_stopped;
 	}
@@ -566,7 +574,7 @@
 	drive_ctl_nien(drive, 0);
 
 	if (stat & ERR_STAT) {
-		ide_dump_status(drive, "tcq_start", stat);
+		ide_dump_status(drive, rq, "tcq_start", stat);
 		return ide_stopped;
 	}
 
@@ -582,7 +590,7 @@
 		TCQ_PRINTK("REL in queued_start\n");
 
 		if ((stat = GET_STAT()) & SERVICE_STAT)
-			return service(drive);
+			return service(drive, rq);
 
 		return ide_released;
 	}
diff -urN linux-2.5.15/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.15/drivers/scsi/ide-scsi.c	2002-05-10 00:21:39.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-05-11 16:13:40.000000000 +0200
@@ -271,7 +271,7 @@
 		ide_end_request(drive, rq, uptodate);
 		return 0;
 	}
-	ide_end_drive_cmd (drive, 0, 0);
+	ide_end_drive_cmd(drive, rq, 0, 0);
 	if (rq->errors >= ERROR_MAX) {
 		pc->scsi_cmd->result = DID_ERROR << 16;
 		if (log)
@@ -401,7 +401,7 @@
 	byte ireason;
 	ide_startstop_t startstop;
 
-	if (ide_wait_stat (&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
+	if (ide_wait_stat(&startstop, drive, rq, DRQ_STAT, BUSY_STAT, WAIT_READY)) {
 		printk (KERN_ERR "ide-scsi: Strange, packet command initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
@@ -489,20 +489,6 @@
 static ide_drive_t *idescsi_drives[MAX_HWIFS * MAX_DRIVES];
 static int idescsi_initialized = 0;
 
-static void idescsi_add_settings(ide_drive_t *drive)
-{
-	idescsi_scsi_t *scsi = drive->driver_data;
-
-/*
- *			drive	setting name	read/write	ioctl	ioctl		data type	min	max	mul_factor	div_factor	data pointer		set function
- */
-	ide_add_setting(drive,	"bios_cyl",	SETTING_RW,	-1,	-1,		TYPE_INT,	0,	1023,	1,		1,		&drive->bios_cyl,	NULL);
-	ide_add_setting(drive,	"bios_head",	SETTING_RW,	-1,	-1,		TYPE_BYTE,	0,	255,	1,		1,		&drive->bios_head,	NULL);
-	ide_add_setting(drive,	"bios_sect",	SETTING_RW,	-1,	-1,		TYPE_BYTE,	0,	63,	1,		1,		&drive->bios_sect,	NULL);
-	ide_add_setting(drive,	"transform",	SETTING_RW,	-1,	-1,		TYPE_INT,	0,	3,	1,		1,		&scsi->transform,	NULL);
-	ide_add_setting(drive,	"log",		SETTING_RW,	-1,	-1,		TYPE_INT,	0,	1,	1,		1,		&scsi->log,		NULL);
-}
-
 /*
  *	Driver initialization.
  */
@@ -521,8 +507,7 @@
 	clear_bit(IDESCSI_SG_TRANSFORM, &scsi->transform);
 #if IDESCSI_DEBUG_LOG
 	set_bit(IDESCSI_LOG_CMD, &scsi->log);
-#endif /* IDESCSI_DEBUG_LOG */
-	idescsi_add_settings(drive);
+#endif
 }
 
 static int idescsi_cleanup (ide_drive_t *drive)
diff -urN linux-2.5.15/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.15/include/linux/ide.h	2002-05-10 00:22:45.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-11 18:34:47.000000000 +0200
@@ -264,8 +264,6 @@
 #define ATA_SCSI	0x21
 #define ATA_NO_LUN      0x7f
 
-struct ide_settings_s;
-
 typedef union {
 	unsigned all			: 8;	/* all of the bits together */
 	struct {
@@ -329,8 +327,6 @@
 
 	unsigned long sleep;	/* sleep until this time */
 
-	u8 XXX_tune_req;			/* requested drive tuning setting */
-
 	byte     using_dma;		/* disk is using dma for read/write */
 	byte	 using_tcq;		/* disk is using queueing */
 	byte	 retry_pio;		/* retrying dma capable host in pio */
@@ -379,7 +375,6 @@
 
 	void		*driver_data;	/* extra driver data */
 	devfs_handle_t	de;		/* directory for device */
-	struct ide_settings_s *settings;    /* ioctl entires */
 	char		driver_req[10];	/* requests specific driver */
 
 	int		last_lun;	/* last logical unit */
@@ -418,6 +413,9 @@
 	int		unit;		/* channel number */
 
 	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
+	struct timer_list timer;	/* failsafe timer */
+	int (*expiry)(struct ata_device *, struct request *);	/* irq handler, if active */
+	struct ata_device *drive;	/* last serviced drive */
 
 	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
 	hw_regs_t	hw;		/* Hardware info */
@@ -569,50 +567,10 @@
 	 */
 	ide_startstop_t (*handler)(struct ata_device *, struct request *);	/* irq handler, if active */
 	unsigned long flags;		/* BUSY, SLEEPING */
-	struct ata_device *XXX_drive;	/* current drive */
 	struct request *rq;		/* current request */
-	struct timer_list timer;	/* failsafe timer */
-	int (*expiry)(struct ata_device *, struct request *);	/* irq handler, if active */
 } ide_hwgroup_t;
 
-/* structure attached to the request for IDE_TASK_CMDS */
-
-/*
- * configurable drive settings
- */
-
-#define TYPE_INT	0
-#define TYPE_INTA	1
-#define TYPE_BYTE	2
-#define TYPE_SHORT	3
-
-#define SETTING_READ	(1 << 0)
-#define SETTING_WRITE	(1 << 1)
-#define SETTING_RW	(SETTING_READ | SETTING_WRITE)
-
-typedef int (ide_procset_t)(struct ata_device *, int);
-typedef struct ide_settings_s {
-	char			*name;
-	int			rw;
-	int			read_ioctl;
-	int			write_ioctl;
-	int			data_type;
-	int			min;
-	int			max;
-	int			mul_factor;
-	int			div_factor;
-	void			*data;
-	ide_procset_t		*set;
-	int			auto_remove;
-	struct ide_settings_s	*next;
-} ide_settings_t;
-
-extern void ide_add_setting(struct ata_device *, const char *, int, int, int, int, int, int, int, int, void *, ide_procset_t *);
-extern void ide_remove_setting(struct ata_device *, char *);
-extern int ide_read_setting(struct ata_device *, ide_settings_t *);
-extern int ide_write_setting(struct ata_device *, ide_settings_t *, int);
-extern void ide_add_generic_settings(struct ata_device *);
-
+/* FIXME: kill this as soon as possible */
 #define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) return 0;
 
 /*
@@ -683,13 +641,10 @@
 /*
  * Error reporting, in human readable form (luxurious, but a memory hog).
  */
-extern byte ide_dump_status(struct ata_device *, const char *, byte);
+extern u8 ide_dump_status(struct ata_device *, struct request *rq, const char *, u8);
 
-/*
- * ide_error() takes action based on the error returned by the controller.
- * The caller should return immediately after invoking this.
- */
-extern ide_startstop_t ide_error(struct ata_device *, const char *, byte);
+extern ide_startstop_t ide_error(struct ata_device *, struct request *rq,
+		const char *, byte);
 
 /*
  * Issue a simple drive command
@@ -713,7 +668,9 @@
  * caller should return the updated value of "startstop" in this case.
  * "startstop" is unchanged when the function returns 0;
  */
-extern int ide_wait_stat(ide_startstop_t *, struct ata_device *, byte, byte, unsigned long);
+extern int ide_wait_stat(ide_startstop_t *,
+		struct ata_device *, struct request *rq,
+		byte, byte, unsigned long);
 
 extern int ide_wait_noerr(struct ata_device *, byte, byte, unsigned long);
 
@@ -759,7 +716,7 @@
 /*
  * Clean up after success/failure of an explicit drive cmd.
  */
-extern void ide_end_drive_cmd(struct ata_device *, byte, byte);
+extern void ide_end_drive_cmd(struct ata_device *, struct request *, u8, u8);
 
 struct ata_taskfile {
 	struct hd_drive_task_hdr taskfile;

--------------080105080300090507040004--

