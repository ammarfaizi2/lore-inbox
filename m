Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289692AbSBER5f>; Tue, 5 Feb 2002 12:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289708AbSBER5R>; Tue, 5 Feb 2002 12:57:17 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:34566 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289692AbSBER5L>;
	Tue, 5 Feb 2002 12:57:11 -0500
Date: Tue, 5 Feb 2002 18:39:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>
Subject: driverfs support for motherboard devices
Message-ID: <20020205173912.GA165@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch adds support for motherboard devices, so that you can see
them in driverfs.

Should ide be presented to driverfs as bus with two devices on it?

What about "legacy" bus? It is not in this release, and I'm not 100%
sure who should generate it. Many architectures will need such bus so
maybe it belongs in drivers/base in order to avoid duplicate code?

								Pavel


--- clean/arch/i386/kernel/i8259.c	Thu Jan 31 23:42:10 2002
+++ linux-dm/arch/i386/kernel/i8259.c	Tue Feb  5 18:20:43 2002
@@ -11,6 +11,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
+#include <linux/device.h>
 
 #include <asm/atomic.h>
 #include <asm/system.h>
@@ -333,6 +334,18 @@
 		goto handle_real_irq;
 	}
 }
+
+static struct device device_i8259A;
+
+static void __init init_8259A_devicefs(void)
+{
+	device_register(&device_i8259A);
+	strcpy(device_i8259A.name, "i8259A");
+	strcpy(device_i8259A.bus_id, "0020");
+	device_i8259A.parent = &sys_iobus;
+}
+
+__initcall(init_8259A_devicefs);
 
 void __init init_8259A(int auto_eoi)
 {
--- clean/arch/i386/kernel/time.c	Thu Jan 31 23:42:10 2002
+++ linux-dm/arch/i386/kernel/time.c	Tue Feb  5 18:21:34 2002
@@ -41,6 +41,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -633,6 +634,18 @@
 bad_ctc:
 	return 0;
 }
+
+static struct device device_i8253;
+
+static void time_init_driverfs(void)
+{
+	strcpy(device_i8253.name, "i8253");
+	strcpy(device_i8253.bus_id, "0040");
+	device_i8253.parent = &sys_iobus;
+	device_register(&device_i8253);
+}
+
+__initcall(time_init_driverfs);
 
 void __init time_init(void)
 {
--- clean/drivers/base/core.c	Thu Jan 31 23:42:12 2002
+++ linux-dm/drivers/base/core.c	Tue Feb  5 18:19:42 2002
@@ -182,6 +182,16 @@
 	return iobus_register(&device_root);
 }
 
+
+struct iobus sys_iobus;
+
+void __init device_init_sys(void)
+{
+     sprintf(sys_iobus.name,"Bus for motherboard and strange devices");
+     sprintf(sys_iobus.bus_id,"sys");
+     iobus_register(&sys_iobus);
+}
+
 int __init device_driver_init(void)
 {
 	int error = 0;
@@ -203,6 +213,7 @@
 		return error;
 	}
 
+	device_init_sys();
 	DBG("DEV: Done Initialising\n");
 	return error;
 }
--- clean/drivers/block/floppy.c	Sun Jan 20 22:36:55 2002
+++ linux-dm/drivers/block/floppy.c	Mon Feb  4 23:05:09 2002
@@ -167,6 +167,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
@@ -4148,11 +4149,16 @@
 
 static int have_no_fdc= -ENODEV;
 
+static struct device device_floppy;
 
 int __init floppy_init(void)
 {
 	int i,unit,drive;
 
+	strcpy(device_floppy.name, "floppy");
+	strcpy(device_floppy.bus_id, "03?0");
+	device_floppy.parent = &sys_iobus;
+	device_register(&device_floppy);
 
 	raw_cmd = NULL;
 
--- clean/drivers/ide/ide-disk.c	Thu Jan 31 23:42:14 2002
+++ linux-dm/drivers/ide/ide-disk.c	Mon Feb  4 23:05:09 2002
@@ -818,6 +818,23 @@
 
 #endif	/* CONFIG_PROC_FS */
 
+static int idedisk_suspend (ide_drive_t *drive, u32 state, u32 stage)
+{
+	/* During S4, interrupt might be pending over resume. If it hits us and we 
+	   think it is completion interrupt from something started between suspend,
+	   we'll destroy data. Don't do that. */
+	if (state == 4)
+		return -EINVAL;
+	return 0;
+}
+
+static int idedisk_resume (ide_drive_t *drive, u32 stage)
+{
+	return 0;
+}
+
+
+
 /*
  * This is tightly woven into the driver->do_special can not touch.
  * DON'T do it again until a total personality rewrite is committed.
@@ -1082,6 +1099,8 @@
 	special:		idedisk_special,
 	proc:			idedisk_proc,
 	driver_reinit:		idedisk_reinit,
+	suspend:		idedisk_suspend,
+	resume:			idedisk_resume,
 };
 
 int idedisk_init (void);
--- clean/drivers/ide/ide-probe.c	Thu Jan 31 23:42:14 2002
+++ linux-dm/drivers/ide/ide-probe.c	Tue Feb  5 18:26:42 2002
@@ -467,8 +467,39 @@
 	return(region_errors);
 }
 
+int ide_hwif_suspend(struct device * dev, u32 state, u32 stage)
+{
+	int i, res = 0;
+	ide_hwif_t *hwif = dev->driver_data;
+
+	for (i=0; i<MAX_DRIVES; i++) {
+		if (hwif->drives[i].driver->suspend)
+			res = hwif->drives[i].driver->suspend(hwif->drives+i, state, stage);
+		if (res)
+			return res;
+	}
+	return 0;
+}
+
+int ide_hwif_resume(struct device * dev, u32 stage)
+{
+	ide_hwif_t *hwif = dev->driver_data;
+	return 0;
+}
+
+struct device_driver ide_device_driver = {
+	suspend:	ide_hwif_suspend,
+	resume:		ide_hwif_resume,	
+};
+
 static void hwif_register (ide_hwif_t *hwif)
 {
+	sprintf(hwif->device.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
+	sprintf(hwif->device.name, "ide");
+	hwif->device.driver = &ide_device_driver;
+	hwif->device.driver_data = hwif;
+	hwif->device.parent = &sys_iobus;
+	device_register(&hwif->device);
 	if (((unsigned long)hwif->io_ports[IDE_DATA_OFFSET] | 7) ==
 	    ((unsigned long)hwif->io_ports[IDE_STATUS_OFFSET])) {
 		ide_request_region(hwif->io_ports[IDE_DATA_OFFSET], 8, hwif->name);
--- clean/drivers/ide/ide-proc.c	Thu Jan 31 23:42:14 2002
+++ linux-dm/drivers/ide/ide-proc.c	Mon Feb  4 23:05:09 2002
@@ -591,13 +591,13 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t    *driver = (ide_driver_t *) drive->driver;
+	ide_driver_t    *driver = drive->driver;
 	int		len;
 
 	if (!driver)
 		len = sprintf(page, "(none)\n");
         else
-		len = sprintf(page,"%llu\n", (__u64) ((ide_driver_t *)drive->driver)->capacity(drive));
+		len = sprintf(page,"%llu\n", (__u64) drive->driver->capacity(drive));
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
@@ -629,7 +629,7 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t	*driver = (ide_driver_t *) drive->driver;
+	ide_driver_t	*driver = drive->driver;
 	int		len;
 
 	if (!driver)

diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/include/linux/device.h linux-dm/include/linux/device.h
--- clean/include/linux/device.h	Thu Jan 31 23:42:28 2002
+++ linux-dm/include/linux/device.h	Mon Feb  4 23:05:09 2002
@@ -209,5 +209,6 @@
 }
 
 extern void put_iobus(struct iobus * iobus);
+extern struct iobus sys_iobus;
 
 #endif /* _DEVICE_H_ */
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/include/linux/ide.h linux-dm/include/linux/ide.h
--- clean/include/linux/ide.h	Thu Jan 31 23:42:29 2002
+++ linux-dm/include/linux/ide.h	Mon Feb  4 23:05:09 2002
@@ -14,6 +14,7 @@
 #include <linux/blkdev.h>
 #include <linux/proc_fs.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 #include <asm/hdreg.h>
 
 /*
@@ -424,12 +425,12 @@
 	unsigned long	capacity;	/* total number of sectors */
 	unsigned long long capacity48;	/* total number of sectors */
 	unsigned int	drive_data;	/* for use by tuneproc/selectproc as needed */
-	void		  *hwif;	/* actually (ide_hwif_t *) */
+	struct ide_hwif_s *hwif;	/* actually (ide_hwif_t *) */
 	wait_queue_head_t wqueue;	/* used to wait for drive in open() */
 	struct hd_driveid *id;		/* drive model identification info */
 	struct hd_struct  *part;	/* drive partition table */
 	char		name[4];	/* drive name, such as "hda" */
-	void 		*driver;	/* (ide_driver_t *) */
+	struct ide_driver_s *driver;	/* (ide_driver_t *) */
 	void		*driver_data;	/* extra driver data */
 	devfs_handle_t	de;		/* directory for device */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
@@ -580,6 +581,7 @@
 	void		*hwif_data;	/* extra hwif data */
 	ide_busproc_t	*busproc;	/* driver soft-power interface */
 	byte		bus_state;	/* power state of the IDE bus */
+	struct device	device;
 } ide_hwif_t;
 
 /*
@@ -718,6 +720,8 @@
 typedef ide_startstop_t	(ide_special_proc)(ide_drive_t *);
 typedef void		(ide_setting_proc)(ide_drive_t *);
 typedef int		(ide_driver_reinit_proc)(ide_drive_t *);
+typedef int		(ide_suspend_proc)(ide_drive_t *, u32 state, u32 stage);
+typedef int		(ide_resume_proc)(ide_drive_t *, u32 stage);
 
 typedef struct ide_driver_s {
 	const char			*name;
@@ -741,6 +745,8 @@
 	ide_special_proc		*special;
 	ide_proc_entry_t		*proc;
 	ide_driver_reinit_proc		*driver_reinit;
+	ide_suspend_proc		*suspend;
+	ide_resume_proc			*resume;
 } ide_driver_t;
 
 #define DRIVER(drive)		((ide_driver_t *)((drive)->driver))

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
