Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWDNULd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWDNULd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWDNULP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:11:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:7309 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965146AbWDNULI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:11:08 -0400
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 7/7] DMI: move dmi_scan.c from arch/i386 to drivers/firmware/
In-Reply-To: <11450453973283-git-send-email-greg@kroah.com>
X-Mailer: git-send-email
Date: Fri, 14 Apr 2006 13:09:57 -0700
Message-Id: <11450453971713-git-send-email-greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmi_scan.c is arch-independent and is used by i386, x86_64, and ia64.
Currently all three arches compile it from arch/i386, which means that ia64
and x86_64 depend on things in arch/i386 that they wouldn't otherwise care
about.

This is simply "mv arch/i386/kernel/dmi_scan.c drivers/firmware/" (removing
trailing whitespace) and the associated Makefile changes.  All three
architectures already set CONFIG_DMI in their top-level Kconfig files.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andi Kleen <ak@muc.de>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: Andrey Panin <pazke@orbita1.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 arch/i386/kernel/Makefile   |    2 
 arch/i386/kernel/dmi_scan.c |  358 -------------------------------------------
 arch/ia64/kernel/Makefile   |    3 
 arch/x86_64/kernel/Makefile |    4 
 drivers/firmware/Makefile   |    3 
 drivers/firmware/dmi_scan.c |  358 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 363 insertions(+), 365 deletions(-)
 delete mode 100644 arch/i386/kernel/dmi_scan.c
 create mode 100644 drivers/firmware/dmi_scan.c

4f705ae3e94ffaafe8d35f71ff4d5c499bb06814
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
index 5b9ed21..96fb8a0 100644
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -6,7 +6,7 @@ extra-y := head.o init_task.o vmlinux.ld
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
-		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
+		pci-dma.o i386_ksyms.o i387.o bootflag.o \
 		quirks.o i8237.o topology.o alternative.o
 
 obj-y				+= cpu/
diff --git a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
deleted file mode 100644
index 5efceeb..0000000
--- a/arch/i386/kernel/dmi_scan.c
+++ /dev/null
@@ -1,358 +0,0 @@
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/dmi.h>
-#include <linux/efi.h>
-#include <linux/bootmem.h>
-#include <linux/slab.h>
-#include <asm/dmi.h>
-
-static char * __init dmi_string(struct dmi_header *dm, u8 s)
-{
-	u8 *bp = ((u8 *) dm) + dm->length;
-	char *str = "";
-
-	if (s) {
-		s--;
-		while (s > 0 && *bp) {
-			bp += strlen(bp) + 1;
-			s--;
-		}
-
-		if (*bp != 0) {
-			str = dmi_alloc(strlen(bp) + 1);
-			if (str != NULL)
-				strcpy(str, bp);
-			else
-				printk(KERN_ERR "dmi_string: out of memory.\n");
-		}
- 	}
-
-	return str;
-}
-
-/*
- *	We have to be cautious here. We have seen BIOSes with DMI pointers
- *	pointing to completely the wrong place for example
- */
-static int __init dmi_table(u32 base, int len, int num,
-			    void (*decode)(struct dmi_header *))
-{
-	u8 *buf, *data;
-	int i = 0;
-		
-	buf = dmi_ioremap(base, len);
-	if (buf == NULL)
-		return -1;
-
-	data = buf;
-
-	/*
- 	 *	Stop when we see all the items the table claimed to have
- 	 *	OR we run off the end of the table (also happens)
- 	 */
-	while ((i < num) && (data - buf + sizeof(struct dmi_header)) <= len) {
-		struct dmi_header *dm = (struct dmi_header *)data;
-		/*
-		 *  We want to know the total length (formated area and strings)
-		 *  before decoding to make sure we won't run off the table in
-		 *  dmi_decode or dmi_string
-		 */
-		data += dm->length;
-		while ((data - buf < len - 1) && (data[0] || data[1]))
-			data++;
-		if (data - buf < len - 1)
-			decode(dm);
-		data += 2;
-		i++;
-	}
-	dmi_iounmap(buf, len);
-	return 0;
-}
-
-static int __init dmi_checksum(u8 *buf)
-{
-	u8 sum = 0;
-	int a;
-	
-	for (a = 0; a < 15; a++)
-		sum += buf[a];
-
-	return sum == 0;
-}
-
-static char *dmi_ident[DMI_STRING_MAX];
-static LIST_HEAD(dmi_devices);
-
-/*
- *	Save a DMI string
- */
-static void __init dmi_save_ident(struct dmi_header *dm, int slot, int string)
-{
-	char *p, *d = (char*) dm;
-
-	if (dmi_ident[slot])
-		return;
-
-	p = dmi_string(dm, d[string]);
-	if (p == NULL)
-		return;
-
-	dmi_ident[slot] = p;
-}
-
-static void __init dmi_save_devices(struct dmi_header *dm)
-{
-	int i, count = (dm->length - sizeof(struct dmi_header)) / 2;
-	struct dmi_device *dev;
-
-	for (i = 0; i < count; i++) {
-		char *d = (char *)(dm + 1) + (i * 2);
-
-		/* Skip disabled device */
-		if ((*d & 0x80) == 0)
-			continue;
-
-		dev = dmi_alloc(sizeof(*dev));
-		if (!dev) {
-			printk(KERN_ERR "dmi_save_devices: out of memory.\n");
-			break;
-		}
-
-		dev->type = *d++ & 0x7f;
-		dev->name = dmi_string(dm, *d);
-		dev->device_data = NULL;
-
-		list_add(&dev->list, &dmi_devices);
-	}
-}
-
-static void __init dmi_save_ipmi_device(struct dmi_header *dm)
-{
-	struct dmi_device *dev;
-	void * data;
-
-	data = dmi_alloc(dm->length);
-	if (data == NULL) {
-		printk(KERN_ERR "dmi_save_ipmi_device: out of memory.\n");
-		return;
-	}
-
-	memcpy(data, dm, dm->length);
-
-	dev = dmi_alloc(sizeof(*dev));
-	if (!dev) {
-		printk(KERN_ERR "dmi_save_ipmi_device: out of memory.\n");
-		return;
-	}
-
-	dev->type = DMI_DEV_TYPE_IPMI;
-	dev->name = "IPMI controller";
-	dev->device_data = data;
-
-	list_add(&dev->list, &dmi_devices);
-}
-
-/*
- *	Process a DMI table entry. Right now all we care about are the BIOS
- *	and machine entries. For 2.5 we should pull the smbus controller info
- *	out of here.
- */
-static void __init dmi_decode(struct dmi_header *dm)
-{
-	switch(dm->type) {
-	case 0:		/* BIOS Information */
-		dmi_save_ident(dm, DMI_BIOS_VENDOR, 4);
-		dmi_save_ident(dm, DMI_BIOS_VERSION, 5);
-		dmi_save_ident(dm, DMI_BIOS_DATE, 8);
-		break;
-	case 1:		/* System Information */
-		dmi_save_ident(dm, DMI_SYS_VENDOR, 4);
-		dmi_save_ident(dm, DMI_PRODUCT_NAME, 5);
-		dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
-		dmi_save_ident(dm, DMI_PRODUCT_SERIAL, 7);
-		break;
-	case 2:		/* Base Board Information */
-		dmi_save_ident(dm, DMI_BOARD_VENDOR, 4);
-		dmi_save_ident(dm, DMI_BOARD_NAME, 5);
-		dmi_save_ident(dm, DMI_BOARD_VERSION, 6);
-		break;
-	case 10:	/* Onboard Devices Information */
-		dmi_save_devices(dm);
-		break;
-	case 38:	/* IPMI Device Information */
-		dmi_save_ipmi_device(dm);
-	}
-}
-
-static int __init dmi_present(char __iomem *p)
-{
-	u8 buf[15];
-	memcpy_fromio(buf, p, 15);
-	if ((memcmp(buf, "_DMI_", 5) == 0) && dmi_checksum(buf)) {
-		u16 num = (buf[13] << 8) | buf[12];
-		u16 len = (buf[7] << 8) | buf[6];
-		u32 base = (buf[11] << 24) | (buf[10] << 16) |
-			(buf[9] << 8) | buf[8];
-
-		/*
-		 * DMI version 0.0 means that the real version is taken from
-		 * the SMBIOS version, which we don't know at this point.
-		 */
-		if (buf[14] != 0)
-			printk(KERN_INFO "DMI %d.%d present.\n",
-			       buf[14] >> 4, buf[14] & 0xF);
-		else
-			printk(KERN_INFO "DMI present.\n");
-		if (dmi_table(base,len, num, dmi_decode) == 0)
-			return 0;
-	}
-	return 1;
-}
-
-void __init dmi_scan_machine(void)
-{
-	char __iomem *p, *q;
-	int rc;
-
-	if (efi_enabled) {
-		if (efi.smbios == EFI_INVALID_TABLE_ADDR)
-			goto out;
-
-               /* This is called as a core_initcall() because it isn't
-                * needed during early boot.  This also means we can
-                * iounmap the space when we're done with it.
-		*/
-		p = dmi_ioremap(efi.smbios, 32);
-		if (p == NULL)
-			goto out;
-
-		rc = dmi_present(p + 0x10); /* offset of _DMI_ string */
-		dmi_iounmap(p, 32);
-		if (!rc)
-			return;
-	}
-	else {
-		/*
-		 * no iounmap() for that ioremap(); it would be a no-op, but
-		 * it's so early in setup that sucker gets confused into doing
-		 * what it shouldn't if we actually call it.
-		 */
-		p = dmi_ioremap(0xF0000, 0x10000);
-		if (p == NULL)
-			goto out;
-
-		for (q = p; q < p + 0x10000; q += 16) {
-			rc = dmi_present(q);
-			if (!rc)
-				return;
-		}
-	}
- out:	printk(KERN_INFO "DMI not present or invalid.\n");
-}
-
-/**
- *	dmi_check_system - check system DMI data
- *	@list: array of dmi_system_id structures to match against
- *
- *	Walk the blacklist table running matching functions until someone
- *	returns non zero or we hit the end. Callback function is called for
- *	each successfull match. Returns the number of matches.
- */
-int dmi_check_system(struct dmi_system_id *list)
-{
-	int i, count = 0;
-	struct dmi_system_id *d = list;
-
-	while (d->ident) {
-		for (i = 0; i < ARRAY_SIZE(d->matches); i++) {
-			int s = d->matches[i].slot;
-			if (s == DMI_NONE)
-				continue;
-			if (dmi_ident[s] && strstr(dmi_ident[s], d->matches[i].substr))
-				continue;
-			/* No match */
-			goto fail;
-		}
-		count++;
-		if (d->callback && d->callback(d))
-			break;
-fail:		d++;
-	}
-
-	return count;
-}
-EXPORT_SYMBOL(dmi_check_system);
-
-/**
- *	dmi_get_system_info - return DMI data value
- *	@field: data index (see enum dmi_filed)
- *
- *	Returns one DMI data value, can be used to perform
- *	complex DMI data checks.
- */
-char *dmi_get_system_info(int field)
-{
-	return dmi_ident[field];
-}
-EXPORT_SYMBOL(dmi_get_system_info);
-
-/**
- *	dmi_find_device - find onboard device by type/name
- *	@type: device type or %DMI_DEV_TYPE_ANY to match all device types
- *	@desc: device name string or %NULL to match all
- *	@from: previous device found in search, or %NULL for new search.
- *
- *	Iterates through the list of known onboard devices. If a device is
- *	found with a matching @vendor and @device, a pointer to its device
- *	structure is returned.  Otherwise, %NULL is returned.
- *	A new search is initiated by passing %NULL to the @from argument.
- *	If @from is not %NULL, searches continue from next device.
- */
-struct dmi_device * dmi_find_device(int type, const char *name,
-				    struct dmi_device *from)
-{
-	struct list_head *d, *head = from ? &from->list : &dmi_devices;
-
-	for(d = head->next; d != &dmi_devices; d = d->next) {
-		struct dmi_device *dev = list_entry(d, struct dmi_device, list);
-
-		if (((type == DMI_DEV_TYPE_ANY) || (dev->type == type)) &&
-		    ((name == NULL) || (strcmp(dev->name, name) == 0)))
-			return dev;
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL(dmi_find_device);
-
-/**
- *	dmi_get_year - Return year of a DMI date
- *	@field:	data index (like dmi_get_system_info)
- *
- *	Returns -1 when the field doesn't exist. 0 when it is broken.
- */
-int dmi_get_year(int field)
-{
-	int year;
-	char *s = dmi_get_system_info(field);
-
-	if (!s)
-		return -1;
-	if (*s == '\0')
-		return 0;
-	s = strrchr(s, '/');
-	if (!s)
-		return 0;
-
-	s += 1;
-	year = simple_strtoul(s, NULL, 0);
-	if (year && year < 100) {	/* 2-digit year */
-		year += 1900;
-		if (year < 1996)	/* no dates < spec 1.0 */
-			year += 100;
-	}
-
-	return year;
-}
diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 59e871d..09a0dbc 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y	:= head.o init_task.o vmlinux.ld
 obj-y := acpi.o entry.o efi.o efi_stub.o gate-data.o fsys.o ia64_ksyms.o irq.o irq_ia64.o	\
 	 irq_lsapic.o ivt.o machvec.o pal.o patch.o process.o perfmon.o ptrace.o sal.o		\
 	 salinfo.o semaphore.o setup.o signal.o sys_ia64.o time.o traps.o unaligned.o \
-	 unwind.o mca.o mca_asm.o topology.o dmi_scan.o
+	 unwind.o mca.o mca_asm.o topology.o
 
 obj-$(CONFIG_IA64_BRL_EMU)	+= brl_emu.o
 obj-$(CONFIG_IA64_GENERIC)	+= acpi-ext.o
@@ -30,7 +30,6 @@ obj-$(CONFIG_IA64_MCA_RECOVERY)	+= mca_r
 obj-$(CONFIG_KPROBES)		+= kprobes.o jprobes.o
 obj-$(CONFIG_IA64_UNCACHED_ALLOCATOR)	+= uncached.o
 mca_recovery-y			+= mca_drv.o mca_drv_asm.o
-dmi_scan-y			+= ../../i386/kernel/dmi_scan.o
 
 # The gate DSO image is built using a special linker script.
 targets += gate.so gate-syms.o
diff --git a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
index a098a11..059c883 100644
--- a/arch/x86_64/kernel/Makefile
+++ b/arch/x86_64/kernel/Makefile
@@ -8,7 +8,7 @@ obj-y	:= process.o signal.o entry.o trap
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
 		setup64.o bootflag.o e820.o reboot.o quirks.o i8237.o \
-		dmi_scan.o pci-dma.o pci-nommu.o
+		pci-dma.o pci-nommu.o
 
 obj-$(CONFIG_X86_MCE)         += mce.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o
@@ -49,5 +49,3 @@ intel_cacheinfo-y		+= ../../i386/kernel/
 quirks-y			+= ../../i386/kernel/quirks.o
 i8237-y				+= ../../i386/kernel/i8237.o
 msr-$(subst m,y,$(CONFIG_X86_MSR))  += ../../i386/kernel/msr.o
-dmi_scan-y			+= ../../i386/kernel/dmi_scan.o
-
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 8542997..98e395f 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -1,7 +1,8 @@
 #
 # Makefile for the linux kernel.
 #
-obj-$(CONFIG_EDD)             	+= edd.o
+obj-$(CONFIG_DMI)		+= dmi_scan.o
+obj-$(CONFIG_EDD)		+= edd.o
 obj-$(CONFIG_EFI_VARS)		+= efivars.o
 obj-$(CONFIG_EFI_PCDP)		+= pcdp.o
 obj-$(CONFIG_DELL_RBU)          += dell_rbu.o
diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
new file mode 100644
index 0000000..948bd7e
--- /dev/null
+++ b/drivers/firmware/dmi_scan.c
@@ -0,0 +1,358 @@
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/dmi.h>
+#include <linux/efi.h>
+#include <linux/bootmem.h>
+#include <linux/slab.h>
+#include <asm/dmi.h>
+
+static char * __init dmi_string(struct dmi_header *dm, u8 s)
+{
+	u8 *bp = ((u8 *) dm) + dm->length;
+	char *str = "";
+
+	if (s) {
+		s--;
+		while (s > 0 && *bp) {
+			bp += strlen(bp) + 1;
+			s--;
+		}
+
+		if (*bp != 0) {
+			str = dmi_alloc(strlen(bp) + 1);
+			if (str != NULL)
+				strcpy(str, bp);
+			else
+				printk(KERN_ERR "dmi_string: out of memory.\n");
+		}
+	}
+
+	return str;
+}
+
+/*
+ *	We have to be cautious here. We have seen BIOSes with DMI pointers
+ *	pointing to completely the wrong place for example
+ */
+static int __init dmi_table(u32 base, int len, int num,
+			    void (*decode)(struct dmi_header *))
+{
+	u8 *buf, *data;
+	int i = 0;
+
+	buf = dmi_ioremap(base, len);
+	if (buf == NULL)
+		return -1;
+
+	data = buf;
+
+	/*
+	 *	Stop when we see all the items the table claimed to have
+	 *	OR we run off the end of the table (also happens)
+	 */
+	while ((i < num) && (data - buf + sizeof(struct dmi_header)) <= len) {
+		struct dmi_header *dm = (struct dmi_header *)data;
+		/*
+		 *  We want to know the total length (formated area and strings)
+		 *  before decoding to make sure we won't run off the table in
+		 *  dmi_decode or dmi_string
+		 */
+		data += dm->length;
+		while ((data - buf < len - 1) && (data[0] || data[1]))
+			data++;
+		if (data - buf < len - 1)
+			decode(dm);
+		data += 2;
+		i++;
+	}
+	dmi_iounmap(buf, len);
+	return 0;
+}
+
+static int __init dmi_checksum(u8 *buf)
+{
+	u8 sum = 0;
+	int a;
+
+	for (a = 0; a < 15; a++)
+		sum += buf[a];
+
+	return sum == 0;
+}
+
+static char *dmi_ident[DMI_STRING_MAX];
+static LIST_HEAD(dmi_devices);
+
+/*
+ *	Save a DMI string
+ */
+static void __init dmi_save_ident(struct dmi_header *dm, int slot, int string)
+{
+	char *p, *d = (char*) dm;
+
+	if (dmi_ident[slot])
+		return;
+
+	p = dmi_string(dm, d[string]);
+	if (p == NULL)
+		return;
+
+	dmi_ident[slot] = p;
+}
+
+static void __init dmi_save_devices(struct dmi_header *dm)
+{
+	int i, count = (dm->length - sizeof(struct dmi_header)) / 2;
+	struct dmi_device *dev;
+
+	for (i = 0; i < count; i++) {
+		char *d = (char *)(dm + 1) + (i * 2);
+
+		/* Skip disabled device */
+		if ((*d & 0x80) == 0)
+			continue;
+
+		dev = dmi_alloc(sizeof(*dev));
+		if (!dev) {
+			printk(KERN_ERR "dmi_save_devices: out of memory.\n");
+			break;
+		}
+
+		dev->type = *d++ & 0x7f;
+		dev->name = dmi_string(dm, *d);
+		dev->device_data = NULL;
+
+		list_add(&dev->list, &dmi_devices);
+	}
+}
+
+static void __init dmi_save_ipmi_device(struct dmi_header *dm)
+{
+	struct dmi_device *dev;
+	void * data;
+
+	data = dmi_alloc(dm->length);
+	if (data == NULL) {
+		printk(KERN_ERR "dmi_save_ipmi_device: out of memory.\n");
+		return;
+	}
+
+	memcpy(data, dm, dm->length);
+
+	dev = dmi_alloc(sizeof(*dev));
+	if (!dev) {
+		printk(KERN_ERR "dmi_save_ipmi_device: out of memory.\n");
+		return;
+	}
+
+	dev->type = DMI_DEV_TYPE_IPMI;
+	dev->name = "IPMI controller";
+	dev->device_data = data;
+
+	list_add(&dev->list, &dmi_devices);
+}
+
+/*
+ *	Process a DMI table entry. Right now all we care about are the BIOS
+ *	and machine entries. For 2.5 we should pull the smbus controller info
+ *	out of here.
+ */
+static void __init dmi_decode(struct dmi_header *dm)
+{
+	switch(dm->type) {
+	case 0:		/* BIOS Information */
+		dmi_save_ident(dm, DMI_BIOS_VENDOR, 4);
+		dmi_save_ident(dm, DMI_BIOS_VERSION, 5);
+		dmi_save_ident(dm, DMI_BIOS_DATE, 8);
+		break;
+	case 1:		/* System Information */
+		dmi_save_ident(dm, DMI_SYS_VENDOR, 4);
+		dmi_save_ident(dm, DMI_PRODUCT_NAME, 5);
+		dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
+		dmi_save_ident(dm, DMI_PRODUCT_SERIAL, 7);
+		break;
+	case 2:		/* Base Board Information */
+		dmi_save_ident(dm, DMI_BOARD_VENDOR, 4);
+		dmi_save_ident(dm, DMI_BOARD_NAME, 5);
+		dmi_save_ident(dm, DMI_BOARD_VERSION, 6);
+		break;
+	case 10:	/* Onboard Devices Information */
+		dmi_save_devices(dm);
+		break;
+	case 38:	/* IPMI Device Information */
+		dmi_save_ipmi_device(dm);
+	}
+}
+
+static int __init dmi_present(char __iomem *p)
+{
+	u8 buf[15];
+	memcpy_fromio(buf, p, 15);
+	if ((memcmp(buf, "_DMI_", 5) == 0) && dmi_checksum(buf)) {
+		u16 num = (buf[13] << 8) | buf[12];
+		u16 len = (buf[7] << 8) | buf[6];
+		u32 base = (buf[11] << 24) | (buf[10] << 16) |
+			(buf[9] << 8) | buf[8];
+
+		/*
+		 * DMI version 0.0 means that the real version is taken from
+		 * the SMBIOS version, which we don't know at this point.
+		 */
+		if (buf[14] != 0)
+			printk(KERN_INFO "DMI %d.%d present.\n",
+			       buf[14] >> 4, buf[14] & 0xF);
+		else
+			printk(KERN_INFO "DMI present.\n");
+		if (dmi_table(base,len, num, dmi_decode) == 0)
+			return 0;
+	}
+	return 1;
+}
+
+void __init dmi_scan_machine(void)
+{
+	char __iomem *p, *q;
+	int rc;
+
+	if (efi_enabled) {
+		if (efi.smbios == EFI_INVALID_TABLE_ADDR)
+			goto out;
+
+               /* This is called as a core_initcall() because it isn't
+                * needed during early boot.  This also means we can
+                * iounmap the space when we're done with it.
+		*/
+		p = dmi_ioremap(efi.smbios, 32);
+		if (p == NULL)
+			goto out;
+
+		rc = dmi_present(p + 0x10); /* offset of _DMI_ string */
+		dmi_iounmap(p, 32);
+		if (!rc)
+			return;
+	}
+	else {
+		/*
+		 * no iounmap() for that ioremap(); it would be a no-op, but
+		 * it's so early in setup that sucker gets confused into doing
+		 * what it shouldn't if we actually call it.
+		 */
+		p = dmi_ioremap(0xF0000, 0x10000);
+		if (p == NULL)
+			goto out;
+
+		for (q = p; q < p + 0x10000; q += 16) {
+			rc = dmi_present(q);
+			if (!rc)
+				return;
+		}
+	}
+ out:	printk(KERN_INFO "DMI not present or invalid.\n");
+}
+
+/**
+ *	dmi_check_system - check system DMI data
+ *	@list: array of dmi_system_id structures to match against
+ *
+ *	Walk the blacklist table running matching functions until someone
+ *	returns non zero or we hit the end. Callback function is called for
+ *	each successfull match. Returns the number of matches.
+ */
+int dmi_check_system(struct dmi_system_id *list)
+{
+	int i, count = 0;
+	struct dmi_system_id *d = list;
+
+	while (d->ident) {
+		for (i = 0; i < ARRAY_SIZE(d->matches); i++) {
+			int s = d->matches[i].slot;
+			if (s == DMI_NONE)
+				continue;
+			if (dmi_ident[s] && strstr(dmi_ident[s], d->matches[i].substr))
+				continue;
+			/* No match */
+			goto fail;
+		}
+		count++;
+		if (d->callback && d->callback(d))
+			break;
+fail:		d++;
+	}
+
+	return count;
+}
+EXPORT_SYMBOL(dmi_check_system);
+
+/**
+ *	dmi_get_system_info - return DMI data value
+ *	@field: data index (see enum dmi_filed)
+ *
+ *	Returns one DMI data value, can be used to perform
+ *	complex DMI data checks.
+ */
+char *dmi_get_system_info(int field)
+{
+	return dmi_ident[field];
+}
+EXPORT_SYMBOL(dmi_get_system_info);
+
+/**
+ *	dmi_find_device - find onboard device by type/name
+ *	@type: device type or %DMI_DEV_TYPE_ANY to match all device types
+ *	@desc: device name string or %NULL to match all
+ *	@from: previous device found in search, or %NULL for new search.
+ *
+ *	Iterates through the list of known onboard devices. If a device is
+ *	found with a matching @vendor and @device, a pointer to its device
+ *	structure is returned.  Otherwise, %NULL is returned.
+ *	A new search is initiated by passing %NULL to the @from argument.
+ *	If @from is not %NULL, searches continue from next device.
+ */
+struct dmi_device * dmi_find_device(int type, const char *name,
+				    struct dmi_device *from)
+{
+	struct list_head *d, *head = from ? &from->list : &dmi_devices;
+
+	for(d = head->next; d != &dmi_devices; d = d->next) {
+		struct dmi_device *dev = list_entry(d, struct dmi_device, list);
+
+		if (((type == DMI_DEV_TYPE_ANY) || (dev->type == type)) &&
+		    ((name == NULL) || (strcmp(dev->name, name) == 0)))
+			return dev;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(dmi_find_device);
+
+/**
+ *	dmi_get_year - Return year of a DMI date
+ *	@field:	data index (like dmi_get_system_info)
+ *
+ *	Returns -1 when the field doesn't exist. 0 when it is broken.
+ */
+int dmi_get_year(int field)
+{
+	int year;
+	char *s = dmi_get_system_info(field);
+
+	if (!s)
+		return -1;
+	if (*s == '\0')
+		return 0;
+	s = strrchr(s, '/');
+	if (!s)
+		return 0;
+
+	s += 1;
+	year = simple_strtoul(s, NULL, 0);
+	if (year && year < 100) {	/* 2-digit year */
+		year += 1900;
+		if (year < 1996)	/* no dates < spec 1.0 */
+			year += 100;
+	}
+
+	return year;
+}
-- 
1.2.6


