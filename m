Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267907AbTBRRui>; Tue, 18 Feb 2003 12:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267915AbTBRRui>; Tue, 18 Feb 2003 12:50:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17673 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267907AbTBRRuK>; Tue, 18 Feb 2003 12:50:10 -0500
Subject: PATCH: update ide.c
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:00:26 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lC2c-00066z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ide_ioreg_t
Add locking on the ide setting lists

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide.c linux-2.5.61-ac2/drivers/ide/ide.c
--- linux-2.5.61/drivers/ide/ide.c	2003-02-10 18:38:15.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide.c	2003-02-18 18:06:17.000000000 +0000
@@ -833,8 +834,8 @@
  */
  
 void ide_setup_ports (	hw_regs_t *hw,
-			ide_ioreg_t base, int *offsets,
-			ide_ioreg_t ctrl, ide_ioreg_t intr,
+			unsigned long base, int *offsets,
+			unsigned long ctrl, unsigned long intr,
 			ide_ack_intr_t *ack_intr,
 /*
  *			ide_io_ops_t *iops,
@@ -930,38 +931,52 @@
 int ide_register (int arg1, int arg2, int irq)
 {
 	hw_regs_t hw;
-	ide_init_hwif_ports(&hw, (ide_ioreg_t) arg1, (ide_ioreg_t) arg2, NULL);
+	ide_init_hwif_ports(&hw, (unsigned long) arg1, (unsigned long) arg2, NULL);
 	hw.irq = irq;
 	return ide_register_hw(&hw, NULL);
 }
 
 EXPORT_SYMBOL(ide_register);
 
+
+/*
+ *	Locks for IDE setting functionality
+ */
+
+DECLARE_MUTEX(ide_setting_sem);
+EXPORT_SYMBOL(ide_setting_sem);
+
 /**
- *	ide_add_setting		-	attach an IDE setting
- *	drive: drive the setting is for
- *	name: name of setting
- *	rw: set if writable
- *	read_ioctl: read function
- *	write_ioctl: write function
- *	data_type: form expected
- *	min: minimum
- *	max: maximum
- *	mul_factor: multiply by
- *	div_factor: divide by
- *	data: value
- *	set: handling for setting
- *
- *	Add a setting to the IDE drive. Support automatic removal and allow
- *	all the work to be done by plugged in handlers. This code is also
- *	rather short on locking, but the current plan is to do the locking
- *	internally to the function. 
+ *	ide_add_setting	-	add an ide setting option
+ *	@drive: drive to use
+ *	@name: setting name
+ *	@rw: true if the function is read write
+ *	@read_ioctl: function to call on read
+ *	@write_ioctl: function to call on write
+ *	@data_type: type of data
+ *	@min: range minimum
+ *	@max: range maximum
+ *	@mul_factor: multiplication scale
+ *	@div_factor: divison scale
+ *	@data: private data field
+ *	@set: setting
+ *
+ *	Removes the setting named from the device if it is present.
+ *	The function takes the settings_lock to protect against 
+ *	parallel changes. This function must not be called from IRQ
+ *	context. Returns 0 on success or -1 on failure.
+ *
+ *	BUGS: This code is seriously over-engineered. There is also
+ *	magic about how the driver specific features are setup. If
+ *	a driver is attached we assume the driver settings are auto
+ *	remove.
  */
  
-void ide_add_setting (ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
+int ide_add_setting (ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
 {
 	ide_settings_t **p = (ide_settings_t **) &drive->settings, *setting = NULL;
 
+	down(&ide_setting_sem);
 	while ((*p) && strcmp((*p)->name, name) < 0)
 		p = &((*p)->next);
 	if ((setting = kmalloc(sizeof(*setting), GFP_KERNEL)) == NULL)
@@ -980,49 +995,76 @@
 	setting->div_factor = div_factor;
 	setting->data = data;
 	setting->set = set;
+	
 	setting->next = *p;
 	if (drive->driver)
 		setting->auto_remove = 1;
 	*p = setting;
-	return;
+	up(&ide_setting_sem);
+	return 0;
 abort:
+	up(&ide_setting_sem);
 	if (setting)
 		kfree(setting);
+	return -1;
 }
 
 EXPORT_SYMBOL(ide_add_setting);
 
 /**
- *	ide_remove_setting	-	remove an ioctl setting
- *	@name:	name of the property
+ *	__ide_remove_setting	-	remove an ide setting option
+ *	@drive: drive to use
+ *	@name: setting name
  *
- *	Remove a drive ioctl setting that was created by ide_add_setting.
- *	Again this needs the locking fixed
+ *	Removes the setting named from the device if it is present.
+ *	The caller must hold the setting semaphore.
  */
  
-void ide_remove_setting (ide_drive_t *drive, char *name)
+static void __ide_remove_setting (ide_drive_t *drive, char *name)
 {
-	ide_settings_t **p = (ide_settings_t **) &drive->settings, *setting;
+	ide_settings_t **p, *setting;
+
+	p = (ide_settings_t **) &drive->settings;
 
 	while ((*p) && strcmp((*p)->name, name))
 		p = &((*p)->next);
 	if ((setting = (*p)) == NULL)
 		return;
+
 	(*p) = setting->next;
+	
 	kfree(setting->name);
 	kfree(setting);
 }
 
+/**
+ *	ide_remove_setting	-	remove an ide setting option
+ *	@drive: drive to use
+ *	@name: setting name
+ *
+ *	Removes the setting named from the device if it is present.
+ *	The function takes the settings_lock to protect against 
+ *	parallel changes. This function must not be called from IRQ
+ *	context.
+ */
+ 
+void ide_remove_setting (ide_drive_t *drive, char *name)
+{
+	down(&ide_setting_sem);
+	__ide_remove_setting(drive, name);
+	up(&ide_setting_sem);
+}
+
 EXPORT_SYMBOL(ide_remove_setting);
 
 /**
- *	ide_find_setting_by_ioctl	-	find a setting handler by its command
- *	@drive: drive to act for
- *	@cmd: ioctl command code
- *
- *	Scan the drive handlers for an ioctl handler for this function.
- *	The handlers vary by drive and sometimes by drive state. 
- *	Needs locking fixes.
+ *	ide_find_setting_by_ioctl	-	find a drive specific ioctl
+ *	@drive: drive to scan
+ *	@cmd: ioctl command to handle
+ *
+ *	Scan's the device setting table for a matching entry and returns
+ *	this or NULL if no entry is found. The caller must hold the
+ *	setting semaphore
  */
  
 static ide_settings_t *ide_find_setting_by_ioctl (ide_drive_t *drive, int cmd)
@@ -1034,17 +1076,18 @@
 			break;
 		setting = setting->next;
 	}
+	
 	return setting;
 }
 
 /**
- *	ide_find_setting_by_name	-	find a setting handler by its name
- *	@drive: drive to act for
- *	@cmd: ioctl command code
- *
- *	Scan the drive handlers handler matching the name for this function.
- *	The handlers vary by drive and sometimes by drive state. 
- *	Needs locking fixes.
+ *	ide_find_setting_by_name	-	find a drive specific setting
+ *	@drive: drive to scan
+ *	@name: setting name
+ *
+ *	Scan's the device setting table for a matching entry and returns
+ *	this or NULL if no entry is found. The caller must hold the
+ *	setting semaphore
  */
  
 ide_settings_t *ide_find_setting_by_name (ide_drive_t *drive, char *name)
@@ -1060,30 +1103,43 @@
 }
 
 /**
- *	auto_remove_settings	-	remove driver settings on a device
- *	@drive: drive to clean
+ *	auto_remove_settings	-	remove driver specific settings
+ *	@drive: drive
  *
- *	Called when we change the driver bindings for a device, for 
- *	example if the device is hot plugged. We must scrub the driver
- *	bindings that are thus no longer relevant to the device in case
- *	it changes from say a CD-ROM to a disk
- *	Needs locking fixes
+ *	Automatically remove all the driver specific settings for this
+ *	drive. This function may sleep and must not be called from IRQ
+ *	context. Takes the settings_lock
  */
  
 static void auto_remove_settings (ide_drive_t *drive)
 {
 	ide_settings_t *setting;
+	down(&ide_setting_sem);
 repeat:
 	setting = drive->settings;
 	while (setting) {
 		if (setting->auto_remove) {
-			ide_remove_setting(drive, setting->name);
+			__ide_remove_setting(drive, setting->name);
 			goto repeat;
 		}
 		setting = setting->next;
 	}
+	up(&ide_setting_sem);
 }
 
+/**
+ *	ide_read_setting	-	read an IDE setting
+ *	@drive: drive to read from
+ *	@setting: drive setting
+ *
+ *	Read a drive setting and return the value. The caller
+ *	must hold the ide_setting_sem when making this call.
+ *
+ *	BUGS: the data return and error are the same return value
+ *	so an error -EINVAL and true return of the same value cannot
+ *	be told apart
+ */
+ 
 int ide_read_setting (ide_drive_t *drive, ide_settings_t *setting)
 {
 	int		val = -EINVAL;
@@ -1132,10 +1188,22 @@
 
 EXPORT_SYMBOL(ide_spin_wait_hwgroup);
 
-/*
- * FIXME:  This should be changed to enqueue a special request
- * to the driver to change settings, and then wait on a sema for completion.
- * The current scheme of polling is kludgey, though safe enough.
+/**
+ *	ide_write_setting	-	read an IDE setting
+ *	@drive: drive to read from
+ *	@setting: drive setting
+ *	@val: value
+ *
+ *	Write a drive setting if it is possible. The caller
+ *	must hold the ide_setting_sem when making this call.
+ *
+ *	BUGS: the data return and error are the same return value
+ *	so an error -EINVAL and true return of the same value cannot
+ *	be told apart
+ *
+ *	FIXME:  This should be changed to enqueue a special request
+ *	to the driver to change settings, and then wait on a sema for completion.
+ *	The current scheme of polling is kludgy, though safe enough.
  */
 int ide_write_setting (ide_drive_t *drive, ide_settings_t *setting, int val)
 {
@@ -1360,16 +1428,22 @@
 	ide_settings_t *setting;
 	int err = 0;
 
+	down(&ide_setting_sem);
 	if ((setting = ide_find_setting_by_ioctl(drive, cmd)) != NULL) {
 		if (cmd == setting->read_ioctl) {
 			err = ide_read_setting(drive, setting);
+			up(&ide_setting_sem);
 			return err >= 0 ? put_user(err, (long *) arg) : err;
 		} else {
 			if (bdev != bdev->bd_contains)
-				return -EINVAL;
-			return ide_write_setting(drive, setting, arg);
+				err = -EINVAL;
+			else
+				err = ide_write_setting(drive, setting, arg);
+			up(&ide_setting_sem);
+			return err;
 		}
 	}
+	up(&ide_setting_sem);
 
 	switch (cmd) {
 		case HDIO_GETGEO:
@@ -1976,7 +2050,7 @@
 				vals[2] = 0;	/* default irq = probe for it */
 			case 3: /* base,ctl,irq */
 				hwif->hw.irq = vals[2];
-				ide_init_hwif_ports(&hwif->hw, (ide_ioreg_t) vals[0], (ide_ioreg_t) vals[1], &hwif->irq);
+				ide_init_hwif_ports(&hwif->hw, (unsigned long) vals[0], (unsigned long) vals[1], &hwif->irq);
 				memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 				hwif->irq      = vals[2];
 				hwif->noprobe  = 0;
