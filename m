Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289936AbSAKMav>; Fri, 11 Jan 2002 07:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289937AbSAKMag>; Fri, 11 Jan 2002 07:30:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59656 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S289936AbSAKMaO>; Fri, 11 Jan 2002 07:30:14 -0500
Date: Fri, 11 Jan 2002 13:27:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>,
        Patrick Mochel <mochel@osdl.org>
Subject: New driver model for ide and motherboard devices
Message-ID: <20020111122748.GA140@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here it is... It would be nice to get it to Linus.

								Pavel


--- clean/Documentation/driver-model.txt	Wed Dec 19 22:38:12 2001
+++ linux-dm/Documentation/driver-model.txt	Thu Jan 10 22:57:39 2002
@@ -248,10 +248,10 @@
 	ejection event could take place here.
 
 suspend:
-	Perform one step of the device suspend process.
+	Perform one step of the device suspend process. Returns 0 on success.
 
 resume:
-	Perform one step of the device resume process.
+	Perform one step of the device resume process. Returns 0 on success.
 
 The probe() and remove() callbacks are intended to be much simpler than the
 current PCI correspondents.
--- clean/arch/i386/kernel/i8259.c	Tue Sep 18 08:03:09 2001
+++ linux-dm/arch/i386/kernel/i8259.c	Thu Jan 10 21:20:41 2002
@@ -11,6 +11,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
+#include <linux/device.h>
 
 #include <asm/atomic.h>
 #include <asm/system.h>
@@ -333,10 +334,17 @@
 	}
 }
 
+static struct device device_i8259A;
+
 void __init init_8259A(int auto_eoi)
 {
 	unsigned long flags;
 
+	device_init_dev(&device_i8259A);
+	device_register(&device_i8259A);
+	strcpy(device_i8259A.name, "i8259A");
+	strcpy(device_i8259A.bus_id, "0020");
+	device_i8259A.parent = &sys_iobus;
 	spin_lock_irqsave(&i8259A_lock, flags);
 
 	outb(0xff, 0x21);	/* mask all of 8259A-1 */
--- clean/arch/i386/kernel/setup.c	Wed Dec 19 22:38:12 2001
+++ linux-dm/arch/i386/kernel/setup.c	Fri Jan 11 11:28:55 2002
@@ -99,6 +99,7 @@
 #include <linux/highmem.h>
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
+#include <linux/device.h>
 #include <asm/processor.h>
 #include <linux/console.h>
 #include <asm/mtrr.h>
@@ -780,6 +781,15 @@
 	}
 }
 
+struct iobus sys_iobus;
+
+void __init setup_sys_bus(void)
+{
+     sprintf(sys_iobus.name,"Bus for motherboard and strange devices");
+     sprintf(sys_iobus.bus_id,"sys");
+     iobus_register(&sys_iobus);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long bootmap_size, low_mem_size;
@@ -1028,6 +1038,7 @@
 		}
 	}
 	request_resource(&iomem_resource, &vram_resource);
+	setup_sys_bus();
 
 	/* request I/O space for devices used on all i[345]86 PCs */
 	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
--- clean/arch/i386/kernel/time.c	Wed Dec 19 22:38:04 2001
+++ linux-dm/arch/i386/kernel/time.c	Thu Jan 10 21:20:41 2002
@@ -41,6 +41,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -634,9 +635,17 @@
 	return 0;
 }
 
+static struct device device_i8253;
+
 void __init time_init(void)
 {
 	extern int x86_udelay_tsc;
+
+	device_init_dev(&device_i8253);
+	strcpy(device_i8253.name, "i8253");
+	strcpy(device_i8253.bus_id, "0040");
+	device_i8253.parent = &sys_iobus;
+	device_register(&device_i8253);
 	
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_usec = 0;
--- clean/drivers/block/floppy.c	Wed Dec 19 22:38:12 2001
+++ linux-dm/drivers/block/floppy.c	Thu Jan 10 21:20:41 2002
@@ -167,6 +167,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
@@ -4148,11 +4149,17 @@
 
 static int have_no_fdc= -ENODEV;
 
+static struct device device_floppy;
 
 int __init floppy_init(void)
 {
 	int i,unit,drive;
 
+	device_init_dev(&device_floppy);
+	strcpy(device_floppy.name, "floppy");
+	strcpy(device_floppy.bus_id, "03?0");
+	device_floppy.parent = &sys_iobus;
+	device_register(&device_floppy);
 
 	raw_cmd = NULL;
 
--- clean/drivers/ide/ide-disk.c	Wed Dec 19 22:38:12 2001
+++ linux-dm/drivers/ide/ide-disk.c	Fri Jan 11 10:56:35 2002
@@ -816,6 +816,23 @@
 	return ide_unregister_subdriver(drive);
 }
 
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
  *      IDE subdriver functions, registered with ide.c
  */
@@ -839,6 +856,8 @@
 	special:		idedisk_special,
 	proc:			idedisk_proc,
 	driver_reinit:		idedisk_reinit,
+	suspend:		idedisk_suspend,
+	resume:			idedisk_resume,
 };
 
 int idedisk_init (void);
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/drivers/ide/ide-probe.c linux-dm/drivers/ide/ide-probe.c
--- clean/drivers/ide/ide-probe.c	Wed Dec 19 22:38:12 2001
+++ linux-dm/drivers/ide/ide-probe.c	Thu Jan 10 23:29:54 2002
@@ -448,8 +448,40 @@
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
+	device_init_dev(&hwif->device);
+	sprintf(hwif->device.bus_id, "%4x", hwif->io_ports[IDE_DATA_OFFSET]);
+	sprintf(hwif->device.name, "ide");
+	hwif->device.driver = &ide_device_driver;
+	hwif->device.driver_data = hwif;
+	hwif->device.parent = &sys_iobus;
+	device_register(&hwif->device);
 	if (((unsigned long)hwif->io_ports[IDE_DATA_OFFSET] | 7) ==
 	    ((unsigned long)hwif->io_ports[IDE_STATUS_OFFSET])) {
 		ide_request_region(hwif->io_ports[IDE_DATA_OFFSET], 8, hwif->name);
--- clean/include/linux/device.h	Wed Dec 19 22:38:14 2001
+++ linux-dm/include/linux/device.h	Fri Jan 11 11:26:23 2002
@@ -249,5 +249,6 @@
 }
 
 extern void put_iobus(struct iobus * iobus);
+extern struct iobus sys_iobus;
 
 #endif /* _DEVICE_H_ */
--- clean/include/linux/ide.h	Wed Dec 19 22:38:14 2001
+++ linux-dm/include/linux/ide.h	Thu Jan 10 23:14:30 2002
@@ -14,6 +14,7 @@
 #include <linux/blkdev.h>
 #include <linux/proc_fs.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 #include <asm/hdreg.h>
 
 /*
@@ -536,6 +537,7 @@
 	void		*hwif_data;	/* extra hwif data */
 	ide_busproc_t	*busproc;	/* driver soft-power interface */
 	byte		bus_state;	/* power state of the IDE bus */
+	struct device	device;
 } ide_hwif_t;
 
 
@@ -667,6 +669,8 @@
 typedef ide_startstop_t	(ide_special_proc)(ide_drive_t *);
 typedef void		(ide_setting_proc)(ide_drive_t *);
 typedef int		(ide_driver_reinit_proc)(ide_drive_t *);
+typedef int		(ide_suspend_proc)(ide_drive_t *, u32 state, u32 stage);
+typedef int		(ide_resume_proc)(ide_drive_t *, u32 stage);
 
 typedef struct ide_driver_s {
 	const char			*name;
@@ -688,6 +692,8 @@
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
