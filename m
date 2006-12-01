Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031717AbWLASg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031717AbWLASg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031711AbWLASg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:36:26 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:51926 "EHLO
	adelie.ubuntu.com") by vger.kernel.org with ESMTP id S1031720AbWLASgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:36:24 -0500
Subject: [RFC] Include ACPI DSDT from INITRD patch into mainline
From: Ben Collins <ben.collins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Cc: Eric Piel <eric.piel@tremplin-utc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Dec 2006 13:36:19 -0500
Message-Id: <1164998179.5257.953.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd be willing to bet that most distros have this patch in their kernel.
One of those things we can't really live without.

What I haven't understood is why it isn't included in the mainline
kernel yet. There's enough kernel hackers out there using this that I
doubt it will get stale or broken for very long.

I'm willing to do the grunt work to get it suitable.

Patch attached for convenience.

diff -urpN -X linux-2.6.18/Documentation/dontdiff linux-2.6.18.bak/Documentation/dsdt-initrd.txt linux-2.6.18/Documentation/dsdt-initrd.txt
--- linux-2.6.18.bak/Documentation/dsdt-initrd.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.18/Documentation/dsdt-initrd.txt	2006-08-12 11:15:13.000000000 +0200
@@ -0,0 +1,98 @@
+ACPI Custom DSDT read from initramfs
+
+2003 by Markuss Gaugusch < dsdt at gaugusch dot org >
+Special thanks go to Thomas Renninger from SuSE, who updated the patch for
+2.6.0 and later modified it to read inside initramfs
+2004 - 2006 maintained by Eric Piel < eric dot piel at tremplin-utc dot net >
+
+This option is intended for people who would like to hack their DSDT and don't want
+to recompile their kernel after every change. It can also be useful to distros
+which offers pre-compiled kernels and want to allow their users to use a
+modified DSDT. In the Kernel config, enable the initial RAM filesystem support
+(in Device Drivers|Block Devices) and enable ACPI_CUSTOM_DSDT_INITRD at the ACPI
+options (General Setup|ACPI Support|Read custom DSDT from initrd).
+
+A custom DSDT (Differentiated System Description Table) is useful when your
+computer uses ACPI but problems occur due to broken implementation. Typically,
+your computer works but there are some troubles with the hardware detection or
+the power management. You can check that troubles come from errors in the DSDT by
+activating the ACPI debug option and reading the logs. This table is provided
+by the BIOS, therefore it might be a good idea to check for BIOS update on your
+vendor website before going any further. Errors are often caused by vendors
+testing their hardware only with Windows or because there is code which is
+executed only on a specific OS with a specific version and Linux hasn't been
+considered during the development.
+
+Before you run away from customising your DSDT, you should note that already
+corrected tables are available for a fair amount of computers on this web-page:
+http://acpi.sf.net/dsdt . If you are part of the unluckies who cannot find
+their hardware in this database, you can modify your DSDT by yourself. This
+process is less painful than it sounds. Download the Intel ASL 
+compiler/decompiler at http://www.intel.com/technology/IAPC/acpi/downloads.htm .
+As root, you then have to dump your DSDT and decompile it. By using the
+compiler messages as well as the kernel ACPI debug messages and the reference book
+(available at the Intel website and also at http://www.acpi.info), it is quite
+easy to obtain a fully working table.
+
+Once your new DSDT is ready you'll have to add it to an initrd so that the
+kernel can read the table at the very beginning of the boot. As the file has
+to be accessed very early during the boot process the initrd has to be an
+initramfs. The file is contained into the initramfs under the name /DSDT.aml .
+To obtain such an initrd, you might have to modify your mkinitrd script or you
+can add it later to the initrd with the script appended to this document. The
+command will look like:
+initrd-add-dsdt initrd.img my-dsdt.aml
+
+In case you don't use any initrd, the possibilities you have are to either start
+using one (try mkinitrd or yaird), or use the "Include Custom DSDT" configure
+option to directly include your DSDT inside the kernel.
+
+The message "Looking for DSDT in initramfs..." will tell you if the DSDT was
+found or not. If you need to update your DSDT, generate a new initrd and
+perform the steps above. Don't forget that with Lilo, you'll have to re-run it.
+
+
+======================= Here starts initrd-add-dsdt ===============================
+#!/bin/bash
+# Adds a DSDT file to the initrd (if it's an initramfs)
+# first argument is the name of archive
+# second argurment is the name of the file to add
+# The file will be copied as /DSDT.aml
+
+# 20060126: fix "Premature end of file" with some old cpio (Roland Robic)
+# 20060205: this time it should really work
+
+# check the arguments
+if [ $# -ne 2 ]; then
+	program_name=$(basename $0)
+	echo "\
+$program_name: too few arguments
+Usage: $program_name initrd-name.img DSDT-to-add.aml
+Adds a DSDT file to an initrd (in initramfs format)
+
+  initrd-name.img: filename of the initrd in initramfs format
+  DSDT-to-add.aml: filename of the DSDT file to add
+  " 1>&2
+    exit 1
+fi
+
+# we should check it's an initramfs
+
+tempcpio=$(mktemp -d)
+# cleanup on exit, hangup, interrupt, quit, termination
+trap 'rm -rf $tempcpio' 0 1 2 3 15
+
+# extract the archive
+gunzip -c "$1" > "$tempcpio"/initramfs.cpio || exit 1
+
+# copy the DSDT file at the root of the directory so that we can call it "/DSDT.aml"
+cp -f "$2" "$tempcpio"/DSDT.aml
+
+# add the file
+cd "$tempcpio"
+(echo DSDT.aml | cpio --quiet -H newc -o -A -O "$tempcpio"/initramfs.cpio) || exit 1
+cd "$OLDPWD"
+
+# re-compress the archive
+gzip -c "$tempcpio"/initramfs.cpio > "$1"
+
diff -urpN -X linux-2.6.18/Documentation/dontdiff linux-2.6.18.bak/drivers/acpi/Kconfig linux-2.6.18/drivers/acpi/Kconfig
--- linux-2.6.18.bak/drivers/acpi/Kconfig	2006-08-12 11:14:05.000000000 +0200
+++ linux-2.6.18/drivers/acpi/Kconfig	2006-08-12 11:15:13.000000000 +0200
@@ -264,6 +264,23 @@ config ACPI_CUSTOM_DSDT_FILE
 	  Enter the full path name to the file which includes the AmlCode
 	  declaration.
 
+config ACPI_CUSTOM_DSDT_INITRD
+	bool "Read Custom DSDT from initramfs"
+	depends on BLK_DEV_INITRD
+	default y
+	help
+	  The DSDT (Differentiated System Description Table) often needs to be
+	  overridden because of broken BIOS implementations. If this feature is
+	  activated you will be able to provide a customized DSDT by adding it
+	  to your initramfs.  For now you need to use a special mkinitrd tool.
+	  For more details see <file:Documentation/dsdt-initrd.txt> or 
+	  <http://gaugusch.at/kernel.shtml>. If there is no table found, it 
+	  will fallback to the custom DSDT in-kernel (if activated) or to the
+	  DSDT from the BIOS.
+
+	  Even if you do not need a new one at the moment, you may want to use a
+	  better implemented DSDT later. It is safe to say Y here.
+
 config ACPI_BLACKLIST_YEAR
 	int "Disable ACPI for systems before Jan 1st this year" if X86_32
 	default 0
diff -urpN -X linux-2.6.18/Documentation/dontdiff linux-2.6.18.bak/drivers/acpi/osl.c linux-2.6.18/drivers/acpi/osl.c
--- linux-2.6.18.bak/drivers/acpi/osl.c	2006-08-12 11:14:05.000000000 +0200
+++ linux-2.6.18/drivers/acpi/osl.c	2006-08-12 11:16:08.000000000 +0200
@@ -69,6 +69,10 @@ extern char line_buf[80];
 int acpi_specific_hotkey_enabled = TRUE;
 EXPORT_SYMBOL(acpi_specific_hotkey_enabled);
 
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+int acpi_must_unregister_table = FALSE;
+#endif
+
 static unsigned int acpi_irq_irq;
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
@@ -219,6 +223,67 @@ acpi_os_predefined_override(const struct
 	return AE_OK;
 }
 
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+struct acpi_table_header * acpi_find_dsdt_initrd(void)
+{
+	struct file *firmware_file;
+	mm_segment_t oldfs;
+	unsigned long len, len2;
+	struct acpi_table_header *dsdt_buffer, *ret = NULL;
+	struct kstat stat;
+	/* maybe this could be an argument on the cmd line, but let's keep it simple for now */
+	char *ramfs_dsdt_name = "/DSDT.aml";
+
+	printk(KERN_INFO PREFIX "Looking for DSDT in initramfs... ");
+
+	/* 
+	 * Never do this at home, only the user-space is allowed to open a file.
+	 * The clean way would be to use the firmware loader. But this code must be run
+	 * before there is any userspace available. So we need a static/init firmware 
+	 * infrastructure, which doesn't exist yet...
+	 */
+	if (vfs_stat(ramfs_dsdt_name, &stat) < 0) {
+		printk("error, file %s not found.\n", ramfs_dsdt_name);
+		return ret;
+	}
+
+	len = stat.size;
+	/* check especially against empty files */
+	if (len <= 4) {
+		printk("error file is too small, only %lu bytes.\n", len);
+		return ret;
+	}
+
+	firmware_file = filp_open(ramfs_dsdt_name, O_RDONLY, 0);
+	if (IS_ERR(firmware_file)) {
+		printk("error, could not open file %s.\n", ramfs_dsdt_name);
+		return ret;
+	}
+
+	dsdt_buffer = ACPI_ALLOCATE(len);
+	if (!dsdt_buffer) {
+		printk("error when allocating %lu bytes of memory.\n", len);
+		goto err;
+	}
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	len2 = vfs_read(firmware_file, (char __user *)dsdt_buffer, len, &firmware_file->f_pos);
+	set_fs(oldfs);
+	if (len2 < len) {
+		printk("error trying to read %lu bytes from %s.\n", len, ramfs_dsdt_name);
+		ACPI_FREE(dsdt_buffer);
+		goto err;
+	}
+
+	printk("successfully read %lu bytes from %s.\n", len, ramfs_dsdt_name);
+	ret = dsdt_buffer;
+err:
+	filp_close(firmware_file, NULL);
+	return ret;
+}
+#endif
+
 acpi_status
 acpi_os_table_override(struct acpi_table_header * existing_table,
 		       struct acpi_table_header ** new_table)
@@ -226,13 +291,20 @@ acpi_os_table_override(struct acpi_table
 	if (!existing_table || !new_table)
 		return AE_BAD_PARAMETER;
 
+	*new_table = NULL;
+
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
 	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
 		*new_table = (struct acpi_table_header *)AmlCode;
-	else
-		*new_table = NULL;
-#else
-	*new_table = NULL;
+#endif
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+	if (strncmp(existing_table->signature, "DSDT", 4) == 0) {
+		struct acpi_table_header* initrd_table = acpi_find_dsdt_initrd();
+		if (initrd_table) {
+			*new_table = initrd_table;
+			acpi_must_unregister_table = TRUE;
+		}
+	}
 #endif
 	return AE_OK;
 }
diff -urpN -X linux-2.6.18/Documentation/dontdiff linux-2.6.18.bak/drivers/acpi/tables/tbget.c linux-2.6.18/drivers/acpi/tables/tbget.c
--- linux-2.6.18.bak/drivers/acpi/tables/tbget.c	2006-08-12 11:14:05.000000000 +0200
+++ linux-2.6.18/drivers/acpi/tables/tbget.c	2006-08-12 11:15:27.000000000 +0200
@@ -278,6 +278,14 @@ acpi_tb_table_override(struct acpi_table
 	address.pointer.logical = new_table;
 
 	status = acpi_tb_get_this_table(&address, new_table, table_info);
+
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+	if (acpi_must_unregister_table) {
+		ACPI_FREE(new_table);
+		acpi_must_unregister_table = FALSE;
+	}
+#endif
+
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Could not copy ACPI table"));
 		return_ACPI_STATUS(status);
diff -urpN -X linux-2.6.18/Documentation/dontdiff linux-2.6.18.bak/include/acpi/acpiosxf.h linux-2.6.18/include/acpi/acpiosxf.h
--- linux-2.6.18.bak/include/acpi/acpiosxf.h	2006-08-12 11:14:05.000000000 +0200
+++ linux-2.6.18/include/acpi/acpiosxf.h	2006-08-12 11:15:13.000000000 +0200
@@ -95,6 +95,10 @@ acpi_status
 acpi_os_table_override(struct acpi_table_header *existing_table,
 		       struct acpi_table_header **new_table);
 
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+extern int acpi_must_unregister_table;
+#endif
+
 /*
  * Spinlock primitives
  */
diff -urpN -X linux-2.6.18/Documentation/dontdiff linux-2.6.18.bak/init/main.c linux-2.6.18/init/main.c
--- linux-2.6.18.bak/init/main.c	2006-08-12 11:14:05.000000000 +0200
+++ linux-2.6.18/init/main.c	2006-08-12 11:15:13.000000000 +0200
@@ -581,8 +581,6 @@ asmlinkage void __init start_kernel(void
 
 	check_bugs();
 
-	acpi_early_init(); /* before LAPIC and SMP init */
-
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
 }
@@ -699,6 +697,14 @@ static int init(void * unused)
 	 */
 	child_reaper = current;
 
+ 	/*
+ 	 * Do this before initcalls, because some drivers want to access
+ 	 * firmware files.
+ 	 */
+ 	populate_rootfs();
+ 
+ 	acpi_early_init(); /* before LAPIC and SMP init */
+
 	smp_prepare_cpus(max_cpus);
 
 	do_pre_smp_initcalls();
@@ -708,12 +714,6 @@ static int init(void * unused)
 
 	cpuset_init_smp();
 
-	/*
-	 * Do this before initcalls, because some drivers want to access
-	 * firmware files.
-	 */
-	populate_rootfs();
-
 	do_basic_setup();
 
 	/*

