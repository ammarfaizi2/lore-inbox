Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbUAMRMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUAMRMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:12:36 -0500
Received: from fmr05.intel.com ([134.134.136.6]:58761 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264441AbUAMRKs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:10:48 -0500
Date: Tue, 13 Jan 2004 10:24:22 -0800
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200401131824.i0DIOMcA031105@snoqualmie.dp.intel.com>
To: akpm@osdl.org, davidm@napali.hpl.hp.com
Subject: [patch] efivars update for 2.6.1
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       matthew.e.tolentino@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, David:

Here's a patch that has been posted here before, but not yet
merged.  Essentially, it converts efivars (i.e. Matt Domsch's 
driver that provides access to the EFI variable runtime 
services) to export variable information and systab info via 
sysfs.  So the tree looks something like this crude diagram:

/sys |
     ...
     |-firmware 
	       |-efi
		   |-systab
		   |-vars 
			 |- BootNext-xxxx-xxx-x-x-x-x *
				|-attributes
				|-data
				|-guid
				|-raw_var
				|-size
			 |- BootCurrent-xxxxxx-x-x-x-x *
			 ...
			 |- del_var
			 |- new_var 

* s.t. {x|-}* is an EFI defined guid  

The systab attribute displays the same table info that was
previously available via /proc/efi/systab.  The variables
may be added or deleted via del_var and new_var.  Details 
for each variable may be inspected as well.  

This patch also creates a new directory drivers/efi into 
which I've moved the efivars driver instead of adding
multiple exact copies into each architecture that supports
EFI.  Also, the selection of the efivars driver is contingent 
on CONFIG_EFI.

Feedback is welcome, so let me know if you have any 
questions.  Please consider applying.

thanks,
matt


diff -urNp linux-2.6.1/arch/i386/Kconfig linux-2.6.1-efivars/arch/i386/Kconfig
--- linux-2.6.1/arch/i386/Kconfig	2004-01-08 22:59:10.000000000 -0800
+++ linux-2.6.1-efivars/arch/i386/Kconfig	2004-01-12 17:17:50.000000000 -0800
@@ -808,6 +808,8 @@ config EFI
 	anything about EFI).  However, even with this option, the resultant
 	kernel should continue to boot on existing non-EFI platforms.
 
+source "drivers/efi/Kconfig"
+
 config HAVE_DEC_LOCK
 	bool
 	depends on (SMP || PREEMPT) && X86_CMPXCHG
diff -urNp linux-2.6.1/arch/i386/kernel/efi.c linux-2.6.1-efivars/arch/i386/kernel/efi.c
--- linux-2.6.1/arch/i386/kernel/efi.c	2004-01-08 22:59:47.000000000 -0800
+++ linux-2.6.1-efivars/arch/i386/kernel/efi.c	2004-01-12 17:17:50.000000000 -0800
@@ -28,7 +28,7 @@
 #include <linux/spinlock.h>
 #include <linux/bootmem.h>
 #include <linux/ioport.h>
-#include <linux/proc_fs.h>
+#include <linux/module.h>
 #include <linux/efi.h>
 
 #include <asm/setup.h>
@@ -46,6 +46,7 @@
 extern efi_status_t asmlinkage efi_call_phys(void *, ...);
 
 struct efi efi;
+EXPORT_SYMBOL(efi);
 struct efi efi_phys __initdata;
 struct efi_memory_map memmap __initdata;
 
@@ -55,18 +56,6 @@ struct efi_memory_map memmap __initdata;
 extern void * boot_ioremap(unsigned long, unsigned long);
 
 /*
- * efi_dir is allocated here, but the directory isn't created
- * here, as proc_mkdir() doesn't work this early in the bootup
- * process.  Therefore, each module, like efivars, must test for
- *    if (!efi_dir) efi_dir = proc_mkdir("efi", NULL);
- * prior to creating their own entries under /proc/efi.
- */
-#ifdef CONFIG_PROC_FS
-struct proc_dir_entry *efi_dir;
-#endif
-
-
-/*
  * To make EFI call EFI runtime service in physical addressing mode we need
  * prelog/epilog before/after the invocation to disable interrupt, to
  * claim EFI runtime service handler exclusively and to duplicate a memory in
diff -urNp linux-2.6.1/arch/ia64/Kconfig linux-2.6.1-efivars/arch/ia64/Kconfig
--- linux-2.6.1/arch/ia64/Kconfig	2004-01-08 23:00:03.000000000 -0800
+++ linux-2.6.1-efivars/arch/ia64/Kconfig	2004-01-12 17:19:27.000000000 -0800
@@ -400,15 +400,7 @@ config EFI
 	depends on !IA64_HP_SIM
 	default y
 
-config EFI_VARS
-	tristate "/proc/efi/vars support"
-	help
-	  If you say Y here, you are able to get EFI (Extensible Firmware
-	  Interface) variable information in /proc/efi/vars.  You may read,
-	  write, create, and destroy EFI variables through this interface.
-
-	  To use this option, you have to check that the "/proc file system
-	  support" (CONFIG_PROC_FS) is enabled, too.
+source "drivers/efi/Kconfig"
 
 config NR_CPUS
 	int "Maximum number of CPUs"
diff -urNp linux-2.6.1/arch/ia64/kernel/efi.c linux-2.6.1-efivars/arch/ia64/kernel/efi.c
--- linux-2.6.1/arch/ia64/kernel/efi.c	2004-01-08 22:59:06.000000000 -0800
+++ linux-2.6.1-efivars/arch/ia64/kernel/efi.c	2004-01-12 17:17:50.000000000 -0800
@@ -23,7 +23,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/time.h>
-#include <linux/proc_fs.h>
 #include <linux/efi.h>
 
 #include <asm/io.h>
@@ -39,17 +38,6 @@ extern efi_status_t efi_call_phys (void 
 struct efi efi;
 static efi_runtime_services_t *runtime;
 
-/*
- * efi_dir is allocated here, but the directory isn't created
- * here, as proc_mkdir() doesn't work this early in the bootup
- * process.  Therefore, each module, like efivars, must test for
- *    if (!efi_dir)  efi_dir = proc_mkdir("efi", NULL);
- * prior to creating their own entries under /proc/efi.
- */
-#ifdef CONFIG_PROC_FS
-struct proc_dir_entry *efi_dir;
-#endif
-
 static unsigned long mem_limit = ~0UL;
 
 #define efi_call_virt(f, args...)	(*(f))(args)
@@ -748,11 +736,3 @@ valid_phys_addr_range (unsigned long phy
 	}
 	return 0;
 }
-
-static void __exit
-efivars_exit (void)
-{
-#ifdef CONFIG_PROC_FS
- 	remove_proc_entry(efi_dir->name, NULL);
-#endif
-}
diff -urNp linux-2.6.1/arch/ia64/kernel/efivars.c linux-2.6.1-efivars/arch/ia64/kernel/efivars.c
--- linux-2.6.1/arch/ia64/kernel/efivars.c	2004-01-08 22:59:33.000000000 -0800
+++ linux-2.6.1-efivars/arch/ia64/kernel/efivars.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,508 +0,0 @@
-/*
- * EFI Variables - efivars.c
- *
- * Copyright (C) 2001 Dell Computer Corporation <Matt_Domsch@dell.com>
- *
- * This code takes all variables accessible from EFI runtime and
- *  exports them via /proc
- *
- * Reads to /proc/efi/vars/varname return an efi_variable_t structure.
- * Writes to /proc/efi/vars/varname must be an efi_variable_t structure.
- * Writes with DataSize = 0 or Attributes = 0 deletes the variable.
- * Writes with a new value in VariableName+VendorGuid creates
- * a new variable.
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- * Changelog:
- *
- *  10 Dec 2002 - Matt Domsch <Matt_Domsch@dell.com>
- *   fix locking per Peter Chubb's findings
- * 
- *  25 Mar 2002 - Matt Domsch <Matt_Domsch@dell.com>
- *   move uuid_unparse() to include/asm-ia64/efi.h:efi_guid_unparse()
- *
- *  12 Feb 2002 - Matt Domsch <Matt_Domsch@dell.com>
- *   use list_for_each_safe when deleting vars.
- *   remove ifdef CONFIG_SMP around include <linux/smp.h>
- *   v0.04 release to linux-ia64@linuxia64.org
- *
- *  20 April 2001 - Matt Domsch <Matt_Domsch@dell.com>
- *   Moved vars from /proc/efi to /proc/efi/vars, and made
- *   efi.c own the /proc/efi directory.
- *   v0.03 release to linux-ia64@linuxia64.org
- *
- *  26 March 2001 - Matt Domsch <Matt_Domsch@dell.com>
- *   At the request of Stephane, moved ownership of /proc/efi
- *   to efi.c, and now efivars lives under /proc/efi/vars.
- *
- *  12 March 2001 - Matt Domsch <Matt_Domsch@dell.com>
- *   Feedback received from Stephane Eranian incorporated.
- *   efivar_write() checks copy_from_user() return value.
- *   efivar_read/write() returns proper errno.
- *   v0.02 release to linux-ia64@linuxia64.org
- *
- *  26 February 2001 - Matt Domsch <Matt_Domsch@dell.com>
- *   v0.01 release to linux-ia64@linuxia64.org
- */
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/proc_fs.h>
-#include <linux/sched.h>		/* for capable() */
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/smp.h>
-#include <linux/efi.h>
-
-#include <asm/uaccess.h>
-
-MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
-MODULE_DESCRIPTION("/proc interface to EFI Variables");
-MODULE_LICENSE("GPL");
-
-#define EFIVARS_VERSION "0.06 2002-Dec-10"
-
-static int
-efivar_read(char *page, char **start, off_t off,
-	    int count, int *eof, void *data);
-static int
-efivar_write(struct file *file, const char *buffer,
-	     unsigned long count, void *data);
-
-
-/*
- * The maximum size of VariableName + Data = 1024
- * Therefore, it's reasonable to save that much
- * space in each part of the structure,
- * and we use a page for reading/writing.
- */
-
-typedef struct _efi_variable_t {
-	efi_char16_t  VariableName[1024/sizeof(efi_char16_t)];
-	efi_guid_t    VendorGuid;
-	unsigned long DataSize;
-	__u8          Data[1024];
-	efi_status_t  Status;
-	__u32         Attributes;
-} __attribute__((packed)) efi_variable_t;
-
-
-typedef struct _efivar_entry_t {
-	efi_variable_t          var;
-	struct proc_dir_entry   *entry;
-	struct list_head        list;
-} efivar_entry_t;
-
-/*
-  efivars_lock protects two things:
-  1) efivar_list - adds, removals, reads, writes
-  2) efi.[gs]et_variable() calls.
-  It must not be held when creating proc entries or calling kmalloc.
-  efi.get_next_variable() is only called from efivars_init(),
-  which is protected by the BKL, so that path is safe.
-*/
-static spinlock_t efivars_lock = SPIN_LOCK_UNLOCKED;
-static LIST_HEAD(efivar_list);
-static struct proc_dir_entry *efi_vars_dir;
-
-#define efivar_entry(n) list_entry(n, efivar_entry_t, list)
-
-/* Return the number of unicode characters in data */
-static unsigned long
-utf8_strlen(efi_char16_t *data, unsigned long maxlength)
-{
-	unsigned long length = 0;
-	while (*data++ != 0 && length < maxlength)
-		length++;
-	return length;
-}
-
-/* Return the number of bytes is the length of this string */
-/* Note: this is NOT the same as the number of unicode characters */
-static inline unsigned long
-utf8_strsize(efi_char16_t *data, unsigned long maxlength)
-{
-	return utf8_strlen(data, maxlength/sizeof(efi_char16_t)) * sizeof(efi_char16_t);
-}
-
-
-static int
-proc_calc_metrics(char *page, char **start, off_t off,
-		  int count, int *eof, int len)
-{
-	if (len <= off+count) *eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len>count) len = count;
-	if (len<0) len = 0;
-	return len;
-}
-
-/*
- * efivar_create_proc_entry()
- * Requires:
- *    variable_name_size = number of bytes required to hold
- *                         variable_name (not counting the NULL
- *                         character at the end.
- *    efivars_lock is not held on entry or exit.
- * Returns 1 on failure, 0 on success
- */
-static int
-efivar_create_proc_entry(unsigned long variable_name_size,
-			 efi_char16_t *variable_name,
-			 efi_guid_t *vendor_guid)
-{
-	int i, short_name_size = variable_name_size / sizeof(efi_char16_t) + 38;
-	char *short_name;
-	efivar_entry_t *new_efivar;
-
-	short_name = kmalloc(short_name_size+1, GFP_KERNEL);
-	new_efivar = kmalloc(sizeof(efivar_entry_t), GFP_KERNEL);
-
-	if (!short_name || !new_efivar)  {
-		if (short_name)        kfree(short_name);
-		if (new_efivar)        kfree(new_efivar);
-		return 1;
-	}
-	memset(short_name, 0, short_name_size+1);
-	memset(new_efivar, 0, sizeof(efivar_entry_t));
-
-	memcpy(new_efivar->var.VariableName, variable_name,
-	       variable_name_size);
-	memcpy(&(new_efivar->var.VendorGuid), vendor_guid, sizeof(efi_guid_t));
-
-	/* Convert Unicode to normal chars (assume top bits are 0),
-	   ala UTF-8 */
-	for (i=0; i< (int) (variable_name_size / sizeof(efi_char16_t)); i++) {
-		short_name[i] = variable_name[i] & 0xFF;
-	}
-
-	/* This is ugly, but necessary to separate one vendor's
-	   private variables from another's.         */
-
-	*(short_name + strlen(short_name)) = '-';
-	efi_guid_unparse(vendor_guid, short_name + strlen(short_name));
-
-	/* Create the entry in proc */
-	new_efivar->entry = create_proc_entry(short_name, 0600, efi_vars_dir);
-	kfree(short_name); short_name = NULL;
-	if (!new_efivar->entry) return 1;
-
-	new_efivar->entry->owner = THIS_MODULE;
-	new_efivar->entry->data = new_efivar;
-	new_efivar->entry->read_proc = efivar_read;
-	new_efivar->entry->write_proc = efivar_write;
-
-	spin_lock(&efivars_lock);
-	list_add(&new_efivar->list, &efivar_list);
-	spin_unlock(&efivars_lock);
-
-	return 0;
-}
-
-
-
-/***********************************************************
- * efivar_read()
- * Requires:
- * Modifies: page
- * Returns: number of bytes written, or -EINVAL on failure
- ***********************************************************/
-
-static int
-efivar_read(char *page, char **start, off_t off, int count, int *eof, void *data)
-{
-	int len = sizeof(efi_variable_t);
-	efivar_entry_t *efi_var = data;
-	efi_variable_t *var_data = (efi_variable_t *)page;
-
-	if (!page || !data) return -EINVAL;
-
-	spin_lock(&efivars_lock);
-
-	memcpy(var_data, &efi_var->var, len);
-
-	var_data->DataSize = 1024;
-	var_data->Status = efi.get_variable(var_data->VariableName,
-					    &var_data->VendorGuid,
-					    &var_data->Attributes,
-					    &var_data->DataSize,
-					    var_data->Data);
-
-	spin_unlock(&efivars_lock);
-
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-
-/***********************************************************
- * efivar_write()
- * Requires: data is an efi_setvariable_t data type,
- *           properly filled in, possibly by a call
- *           first to efivar_read().
- *           Caller must have CAP_SYS_ADMIN
- * Modifies: NVRAM
- * Returns: var_data->DataSize on success, errno on failure
- *
- ***********************************************************/
-static int
-efivar_write(struct file *file, const char *buffer,
-	     unsigned long count, void *data)
-{
-	unsigned long strsize1, strsize2;
-	int found=0;
-	struct list_head *pos, *n;
-	unsigned long size = sizeof(efi_variable_t);
-	efi_status_t status;
-	efivar_entry_t *efivar = data, *search_efivar = NULL;
-	efi_variable_t *var_data;
-	if (!data || count != size) {
-		printk(KERN_WARNING "efivars: improper struct of size 0x%lx passed.\n", count);
-		return -EINVAL;
-	}
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	var_data = kmalloc(size, GFP_KERNEL);
-	if (!var_data)
-		return -ENOMEM;
-	if (copy_from_user(var_data, buffer, size)) {
-		kfree(var_data);
-		return -EFAULT;
-	}
-
-	spin_lock(&efivars_lock);
-
-	/* Since the data ptr we've currently got is probably for
-	   a different variable find the right variable.
-	   This allows any properly formatted data structure to
-	   be written to any of the files in /proc/efi/vars and it will work.
-	*/
-	list_for_each_safe(pos, n, &efivar_list) {
-		search_efivar = efivar_entry(pos);
-		strsize1 = utf8_strsize(search_efivar->var.VariableName, 1024);
-		strsize2 = utf8_strsize(var_data->VariableName, 1024);
-		if ( strsize1 == strsize2 &&
-		     !memcmp(&(search_efivar->var.VariableName),
-			     var_data->VariableName, strsize1) &&
-		     !efi_guidcmp(search_efivar->var.VendorGuid,
-				  var_data->VendorGuid)) {
-			found = 1;
-			break;
-		}
-	}
-	if (found) efivar = search_efivar;
-
-	status = efi.set_variable(var_data->VariableName,
-				  &var_data->VendorGuid,
-				  var_data->Attributes,
-				  var_data->DataSize,
-				  var_data->Data);
-
-	if (status != EFI_SUCCESS) {
-		printk(KERN_WARNING "set_variable() failed: status=%lx\n", status);
-		kfree(var_data);
-		spin_unlock(&efivars_lock);
-		return -EIO;
-	}
-
-
-	if (!var_data->DataSize || !var_data->Attributes) {
-		/* We just deleted the NVRAM variable */
-		remove_proc_entry(efivar->entry->name, efi_vars_dir);
-		list_del(&efivar->list);
-		kfree(efivar);
-	}
-
-	spin_unlock(&efivars_lock);
-
-	/* If this is a new variable, set up the proc entry for it. */
-	if (!found) {
-		efivar_create_proc_entry(utf8_strsize(var_data->VariableName,
-						      1024),
-					 var_data->VariableName,
-					 &var_data->VendorGuid);
-	}
-
-	kfree(var_data);
-	return size;
-}
-
-/*
- * The EFI system table contains pointers to the SAL system table,
- * HCDP, ACPI, SMBIOS, etc, that may be useful to applications.
- */
-static ssize_t
-efi_systab_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
-{
-	void *data;
-	u8 *proc_buffer;
-	ssize_t size, length;
-	int ret;
-	const int max_nr_entries = 7; 	/* num ptrs to tables we could expose */
-	const int max_line_len = 80;
-
-	if (!efi.systab)
-		return 0;
-
-	proc_buffer = kmalloc(max_nr_entries * max_line_len, GFP_KERNEL);
-	if (!proc_buffer)
-		return -ENOMEM;
-
-	length = 0;
-	if (efi.mps)
-		length += sprintf(proc_buffer + length, "MPS=0x%lx\n", __pa(efi.mps));
-	if (efi.acpi20)
-		length += sprintf(proc_buffer + length, "ACPI20=0x%lx\n", __pa(efi.acpi20));
-	if (efi.acpi)
-		length += sprintf(proc_buffer + length, "ACPI=0x%lx\n", __pa(efi.acpi));
-	if (efi.smbios)
-		length += sprintf(proc_buffer + length, "SMBIOS=0x%lx\n", __pa(efi.smbios));
-	if (efi.sal_systab)
-		length += sprintf(proc_buffer + length, "SAL=0x%lx\n", __pa(efi.sal_systab));
-	if (efi.hcdp)
-		length += sprintf(proc_buffer + length, "HCDP=0x%lx\n", __pa(efi.hcdp));
-	if (efi.boot_info)
-		length += sprintf(proc_buffer + length, "BOOTINFO=0x%lx\n", __pa(efi.boot_info));
-
-	if (*ppos >= length) {
-		ret = 0;
-		goto out;
-	}
-
-	data = proc_buffer + file->f_pos;
-	size = length - file->f_pos;
-	if (size > count)
-		size = count;
-	if (copy_to_user(buffer, data, size)) {
-		ret = -EFAULT;
-		goto out;
-	}
-
-	*ppos += size;
-	ret = size;
-
-out:
-	kfree(proc_buffer);
-	return ret;
-}
-
-static struct proc_dir_entry *efi_systab_entry;
-static struct file_operations efi_systab_fops = {
-	.read = efi_systab_read,
-};
-
-static int __init
-efivars_init(void)
-{
-	efi_status_t status;
-	efi_guid_t vendor_guid;
-	efi_char16_t *variable_name = kmalloc(1024, GFP_KERNEL);
-	unsigned long variable_name_size = 1024;
-
-	printk(KERN_INFO "EFI Variables Facility v%s\n", EFIVARS_VERSION);
-
-	/* Since efi.c happens before procfs is available,
-	   we create the directory here if it doesn't
-	   already exist.  There's probably a better way
-	   to do this.
-	*/
-	if (!efi_dir)
-		efi_dir = proc_mkdir("efi", NULL);
-
-	efi_systab_entry = create_proc_entry("systab", S_IRUSR | S_IRGRP, efi_dir);
-	if (efi_systab_entry)
-		efi_systab_entry->proc_fops = &efi_systab_fops;
-
-	efi_vars_dir = proc_mkdir("vars", efi_dir);
-
-	/* Per EFI spec, the maximum storage allocated for both
-	   the variable name and variable data is 1024 bytes.
-	*/
-
-	memset(variable_name, 0, 1024);
-
-	do {
-		variable_name_size=1024;
-
-		status = efi.get_next_variable(&variable_name_size,
-					       variable_name,
-					       &vendor_guid);
-
-
-		switch (status) {
-		case EFI_SUCCESS:
-			efivar_create_proc_entry(variable_name_size,
-						 variable_name,
-						 &vendor_guid);
-			break;
-		case EFI_NOT_FOUND:
-			break;
-		default:
-			printk(KERN_WARNING "get_next_variable: status=%lx\n", status);
-			status = EFI_NOT_FOUND;
-			break;
-		}
-
-	} while (status != EFI_NOT_FOUND);
-
-	kfree(variable_name);
-	return 0;
-}
-
-static void __exit
-efivars_exit(void)
-{
-	struct list_head *pos, *n;
-	efivar_entry_t *efivar;
-
-	spin_lock(&efivars_lock);
-	if (efi_systab_entry)
-		remove_proc_entry(efi_systab_entry->name, efi_dir);
-	list_for_each_safe(pos, n, &efivar_list) {
-		efivar = efivar_entry(pos);
-		remove_proc_entry(efivar->entry->name, efi_vars_dir);
-		list_del(&efivar->list);
-		kfree(efivar);
-	}
-	spin_unlock(&efivars_lock);
-
-	remove_proc_entry(efi_vars_dir->name, efi_dir);
-}
-
-module_init(efivars_init);
-module_exit(efivars_exit);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: nil
- * tab-width: 8
- * End:
- */
diff -urNp linux-2.6.1/arch/ia64/kernel/ia64_ksyms.c linux-2.6.1-efivars/arch/ia64/kernel/ia64_ksyms.c
--- linux-2.6.1/arch/ia64/kernel/ia64_ksyms.c	2004-01-08 22:59:33.000000000 -0800
+++ linux-2.6.1-efivars/arch/ia64/kernel/ia64_ksyms.c	2004-01-12 17:17:50.000000000 -0800
@@ -152,10 +152,6 @@ EXPORT_SYMBOL(ia64_save_scratch_fpregs);
 extern struct efi efi;
 EXPORT_SYMBOL(efi);
 
-#include <linux/proc_fs.h>
-extern struct proc_dir_entry *efi_dir;
-EXPORT_SYMBOL(efi_dir);
-
 #include <asm/machvec.h>
 #ifdef CONFIG_IA64_GENERIC
 EXPORT_SYMBOL(ia64_mv);
diff -urNp linux-2.6.1/arch/ia64/kernel/Makefile linux-2.6.1-efivars/arch/ia64/kernel/Makefile
--- linux-2.6.1/arch/ia64/kernel/Makefile	2004-01-08 23:00:12.000000000 -0800
+++ linux-2.6.1-efivars/arch/ia64/kernel/Makefile	2004-01-12 17:17:50.000000000 -0800
@@ -8,7 +8,6 @@ obj-y := acpi.o entry.o efi.o efi_stub.o
 	 irq_lsapic.o ivt.o machvec.o pal.o patch.o process.o perfmon.o ptrace.o sal.o		\
 	 salinfo.o semaphore.o setup.o signal.o sys_ia64.o time.o traps.o unaligned.o unwind.o
 
-obj-$(CONFIG_EFI_VARS)		+= efivars.o
 obj-$(CONFIG_IA64_BRL_EMU)	+= brl_emu.o
 obj-$(CONFIG_IA64_GENERIC)	+= acpi-ext.o
 obj-$(CONFIG_IA64_HP_ZX1)	+= acpi-ext.o
diff -urNp linux-2.6.1/arch/ia64/mm/init.c linux-2.6.1-efivars/arch/ia64/mm/init.c
--- linux-2.6.1/arch/ia64/mm/init.c	2004-01-08 22:59:26.000000000 -0800
+++ linux-2.6.1-efivars/arch/ia64/mm/init.c	2004-01-12 17:21:46.000000000 -0800
@@ -18,6 +18,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
+#include <linux/proc_fs.h>
 
 #include <asm/a.out.h>
 #include <asm/bitops.h>
diff -urNp linux-2.6.1/drivers/efi/efivars.c linux-2.6.1-efivars/drivers/efi/efivars.c
--- linux-2.6.1/drivers/efi/efivars.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.1-efivars/drivers/efi/efivars.c	2004-01-12 17:35:23.000000000 -0800
@@ -0,0 +1,745 @@
+/*
+ * EFI Variables - efivars.c
+ *
+ * Copyright (C) 2001,2003 Dell <Matt_Domsch@dell.com>
+ * Copyright (C) 2003 Intel Corporation <matthew.e.tolentino@intel.com>
+ *
+ * This code takes all variables accessible from EFI runtime and
+ *  exports them via sysfs
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Changelog:
+ *
+ *  29 Aug 2003 - Matt Tolentino <matthew.e.tolentino@intel.com)
+ *   converted driver to export variable information via sysfs
+ *   and moved to drivers/efi directory
+ *   bumped revision number to v0.07 to reflect conversion & move
+ *
+ *  10 Dec 2002 - Matt Domsch <Matt_Domsch@dell.com>
+ *   fix locking per Peter Chubb's findings
+ *
+ *  25 Mar 2002 - Matt Domsch <Matt_Domsch@dell.com>
+ *   move uuid_unparse() to include/asm-ia64/efi.h:efi_guid_unparse()
+ *
+ *  12 Feb 2002 - Matt Domsch <Matt_Domsch@dell.com>
+ *   use list_for_each_safe when deleting vars.
+ *   remove ifdef CONFIG_SMP around include <linux/smp.h>
+ *   v0.04 release to linux-ia64@linuxia64.org
+ *
+ *  20 April 2001 - Matt Domsch <Matt_Domsch@dell.com>
+ *   Moved vars from /proc/efi to /proc/efi/vars, and made
+ *   efi.c own the /proc/efi directory.
+ *   v0.03 release to linux-ia64@linuxia64.org
+ *
+ *  26 March 2001 - Matt Domsch <Matt_Domsch@dell.com>
+ *   At the request of Stephane, moved ownership of /proc/efi
+ *   to efi.c, and now efivars lives under /proc/efi/vars.
+ *
+ *  12 March 2001 - Matt Domsch <Matt_Domsch@dell.com>
+ *   Feedback received from Stephane Eranian incorporated.
+ *   efivar_write() checks copy_from_user() return value.
+ *   efivar_read/write() returns proper errno.
+ *   v0.02 release to linux-ia64@linuxia64.org
+ *
+ *  26 February 2001 - Matt Domsch <Matt_Domsch@dell.com>
+ *   v0.01 release to linux-ia64@linuxia64.org
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/sched.h>		/* for capable() */
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/smp.h>
+#include <linux/efi.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/device.h>
+
+#include <asm/uaccess.h>
+
+MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
+MODULE_DESCRIPTION("sysfs interface to EFI Variables");
+MODULE_LICENSE("GPL");
+
+#define EFIVARS_VERSION "0.07 2003-Aug-29"
+
+/*
+ * efivars_lock protects two things:
+ * 1) efivar_list - adds, removals, reads, writes
+ * 2) efi.[gs]et_variable() calls.
+ * It must not be held when creating sysfs entries or calling kmalloc.
+ * efi.get_next_variable() is only called from efivars_init(),
+ * which is protected by the BKL, so that path is safe.
+ */
+static spinlock_t efivars_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(efivar_list);
+
+/*
+ * The maximum size of VariableName + Data = 1024
+ * Therefore, it's reasonable to save that much
+ * space in each part of the structure,
+ * and we use a page for reading/writing.
+ */
+
+struct efi_variable {
+	efi_char16_t  VariableName[1024/sizeof(efi_char16_t)];
+	efi_guid_t    VendorGuid;
+	unsigned long DataSize;
+	__u8          Data[1024];
+	efi_status_t  Status;
+	__u32         Attributes;
+} __attribute__((packed));
+
+
+struct efivar_entry {
+	struct efi_variable var;
+	struct list_head list;
+	struct kobject kobj;
+};
+
+#define get_efivar_entry(n) list_entry(n, struct efivar_entry, list)
+
+struct efivar_attribute {
+	struct attribute attr;
+	ssize_t (*show) (struct efivar_entry *entry, char *buf);
+	ssize_t (*store)(struct efivar_entry *entry, const char *buf, size_t count);
+};
+
+
+#define EFI_ATTR(_name, _mode, _show, _store) \
+struct subsys_attribute efi_attr_##_name = { \
+	.attr {.name = __stringify(_name), .mode = _mode }, \
+	.show = _show, \
+	.store = _store, \
+};
+
+#define EFIVAR_ATTR(_name, _mode, _show, _store) \
+struct efivar_attribute efivar_attr_##_name = { \
+	.attr = {.name = __stringify(_name), .mode = _mode }, \
+	.show = _show, \
+	.store = _store, \
+};
+
+#define VAR_SUBSYS_ATTR(_name, _mode, _show, _store) \
+struct subsys_attribute var_subsys_attr_##_name = { \
+	.attr = {.name = __stringify(_name), .mode = _mode }, \
+	.show = _show, \
+	.store = _store, \
+};
+
+#define to_efivar_attr(_attr) container_of(_attr, struct efivar_attribute, attr)
+#define to_efivar_entry(obj)  container_of(obj, struct efivar_entry, kobj)
+
+/*
+ * Prototype for sysfs creation function
+ */
+static int
+efivar_create_sysfs_entry(unsigned long variable_name_size,
+			  efi_char16_t *variable_name,
+			  efi_guid_t *vendor_guid);
+
+/* Return the number of unicode characters in data */
+static unsigned long
+utf8_strlen(efi_char16_t *data, unsigned long maxlength)
+{
+	unsigned long length = 0;
+
+	while (*data++ != 0 && length < maxlength)
+		length++;
+	return length;
+}
+
+/*
+ * Return the number of bytes is the length of this string
+ * Note: this is NOT the same as the number of unicode characters
+ */
+static inline unsigned long
+utf8_strsize(efi_char16_t *data, unsigned long maxlength)
+{
+	return utf8_strlen(data, maxlength/sizeof(efi_char16_t)) * sizeof(efi_char16_t);
+}
+
+static efi_status_t
+get_var_data(struct efi_variable *var)
+{
+	efi_status_t status;
+
+	spin_lock(&efivars_lock);
+	var->DataSize = 1024;
+	status = efi.get_variable(var->VariableName,
+			 	  &var->VendorGuid,
+			 	  &var->Attributes,
+			 	  &var->DataSize,
+			 	  var->Data);
+	spin_unlock(&efivars_lock);
+	if (status != EFI_SUCCESS) {
+		printk(KERN_WARNING "efivars: get_variable() failed 0x%lx!\n",
+		       status);
+	}
+
+	return status;
+}
+
+static ssize_t
+efivar_guid_read(struct efivar_entry *entry, char *buf)
+{
+	struct efi_variable *var = &entry->var;
+	char *str = buf;
+
+	if (!entry || !buf)
+		return 0;
+
+	efi_guid_unparse(&var->VendorGuid, str);
+	str += strlen(str);
+	str += sprintf(str, "\n");
+
+	return str - buf;
+}
+
+static ssize_t
+efivar_attr_read(struct efivar_entry *entry, char *buf)
+{
+	struct efi_variable *var = &entry->var;
+	char *str = buf;
+	efi_status_t status;
+
+	if (!entry || !buf)
+		return -EINVAL;
+
+	status = get_var_data(var);
+	if (status != EFI_SUCCESS)
+		return -EIO;
+
+	if (var->Attributes & 0x1)
+		str += sprintf(str, "EFI_VARIABLE_NON_VOLATILE\n");
+	if (var->Attributes & 0x2)
+		str += sprintf(str, "EFI_VARIABLE_BOOTSERVICE_ACCESS\n");
+	if (var->Attributes & 0x4)
+		str += sprintf(str, "EFI_VARIABLE_RUNTIME_ACCESS\n");
+	return str - buf;
+}
+
+static ssize_t
+efivar_size_read(struct efivar_entry *entry, char *buf)
+{
+	struct efi_variable *var = &entry->var;
+	char *str = buf;
+	efi_status_t status;
+
+	if (!entry || !buf)
+		return -EINVAL;
+
+	status = get_var_data(var);
+	if (status != EFI_SUCCESS)
+		return -EIO;
+
+	str += sprintf(str, "0x%lx\n", var->DataSize);
+	return str - buf;
+}
+
+static ssize_t
+efivar_data_read(struct efivar_entry *entry, char *buf)
+{
+	struct efi_variable *var = &entry->var;
+	efi_status_t status;
+
+	if (!entry || !buf)
+		return -EINVAL;
+
+	status = get_var_data(var);
+	if (status != EFI_SUCCESS)
+		return -EIO;
+
+	memcpy(buf, var->Data, var->DataSize);
+	return var->DataSize;
+}
+/*
+ * We allow each variable to be edited via rewriting the
+ * entire efi variable structure.
+ */
+static ssize_t
+efivar_store_raw(struct efivar_entry *entry, const char *buf, size_t count)
+{
+	struct efi_variable *new_var, *var = &entry->var;
+	efi_status_t status = EFI_NOT_FOUND;
+
+	if (count != sizeof(struct efi_variable))
+		return -EINVAL;
+
+	new_var = (struct efi_variable *)buf;
+	/*
+	 * If only updating the variable data, then the name
+	 * and guid should remain the same
+	 */
+	if (memcmp(new_var->VariableName, var->VariableName, sizeof(var->VariableName)) ||
+	    efi_guidcmp(new_var->VendorGuid, var->VendorGuid)) {
+		printk(KERN_ERR "efivars: Cannot edit the wrong variable!\n");
+		return -EINVAL;
+	}
+
+	if ((new_var->DataSize <= 0) || (new_var->Attributes == 0)){
+		printk(KERN_ERR "efivars: DataSize & Attributes must be valid!\n");
+		return -EINVAL;
+	}
+
+	spin_lock(&efivars_lock);
+	status = efi.set_variable(new_var->VariableName,
+				  &new_var->VendorGuid,
+				  new_var->Attributes,
+				  new_var->DataSize,
+				  new_var->Data);
+
+	spin_unlock(&efivars_lock);
+
+	if (status != EFI_SUCCESS) {
+		printk(KERN_WARNING "efivars: set_variable() failed: status=%lx\n",
+				status);
+		return -EIO;
+	}
+
+	memcpy(&entry->var, new_var, count);
+	return count;
+}
+
+static ssize_t
+efivar_show_raw(struct efivar_entry *entry, char *buf)
+{
+	struct efi_variable *var = &entry->var;
+	efi_status_t status;
+
+	if (!entry || !buf)
+		return 0;
+
+	status = get_var_data(var);
+	if (status != EFI_SUCCESS)
+		return -EIO;
+
+	memcpy(buf, var, sizeof(*var));
+	return sizeof(*var);
+}
+
+/*
+ * Generic read/write functions that call the specific functions of
+ * the atttributes...
+ */
+static ssize_t efivar_attr_show(struct kobject *kobj, struct attribute *attr,
+			        char *buf)
+{
+	struct efivar_entry *var =  to_efivar_entry(kobj);
+	struct efivar_attribute *efivar_attr = to_efivar_attr(attr);
+	ssize_t ret = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (efivar_attr->show) {
+		ret = efivar_attr->show(var, buf);
+	}
+	return ret;
+}
+
+static ssize_t efivar_attr_store(struct kobject *kobj, struct attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct efivar_entry *var = to_efivar_entry(kobj);
+	struct efivar_attribute *efivar_attr = to_efivar_attr(attr);
+	ssize_t ret = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (efivar_attr->store)
+		ret = efivar_attr->store(var, buf, count);
+
+	return ret;
+}
+
+static struct sysfs_ops efivar_attr_ops = {
+	.show = efivar_attr_show,
+	.store = efivar_attr_store,
+};
+
+static void efivar_release(struct kobject *kobj)
+{
+	struct efivar_entry *var = container_of(kobj, struct efivar_entry, kobj);
+	list_del(&var->list);
+	kfree(var);
+}
+
+static EFIVAR_ATTR(guid, 0400, efivar_guid_read, NULL);
+static EFIVAR_ATTR(attributes, 0400, efivar_attr_read, NULL);
+static EFIVAR_ATTR(size, 0400, efivar_size_read, NULL);
+static EFIVAR_ATTR(data, 0400, efivar_data_read, NULL);
+static EFIVAR_ATTR(raw_var, 0600, efivar_show_raw, efivar_store_raw);
+
+static struct attribute *def_attrs[] = {
+	&efivar_attr_guid.attr,
+	&efivar_attr_size.attr,
+	&efivar_attr_attributes.attr,
+	&efivar_attr_data.attr,
+	&efivar_attr_raw_var.attr,
+	NULL,
+};
+
+static struct kobj_type ktype_efivar = {
+	.release = efivar_release,
+	.sysfs_ops = &efivar_attr_ops,
+	.default_attrs = def_attrs,
+};
+
+static ssize_t
+dummy(struct subsystem *sub, char *buf)
+{
+	return 0;
+}
+
+static inline void
+efivar_unregister(struct efivar_entry *var)
+{
+	kobject_unregister(&var->kobj);
+}
+
+
+static ssize_t
+efivar_create(struct subsystem *sub, const char *buf, size_t count)
+{
+	struct efi_variable *new_var = (struct efi_variable *)buf;
+	struct efivar_entry *search_efivar = NULL;
+	unsigned long strsize1, strsize2;
+	struct list_head *pos, *n;
+	efi_status_t status = EFI_NOT_FOUND;
+	int found = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	spin_lock(&efivars_lock);
+
+	/*
+	 * Does this variable already exist?
+	 */
+	list_for_each_safe(pos, n, &efivar_list) {
+		search_efivar = get_efivar_entry(pos);
+		strsize1 = utf8_strsize(search_efivar->var.VariableName, 1024);
+		strsize2 = utf8_strsize(new_var->VariableName, 1024);
+		if ( strsize1 == strsize2 &&
+		     !memcmp(&(search_efivar->var.VariableName),
+			     new_var->VariableName, strsize1) &&
+		     !efi_guidcmp(search_efivar->var.VendorGuid,
+				  new_var->VendorGuid)) {
+			found = 1;
+			break;
+		}
+	}
+	if (found) {
+        	spin_unlock(&efivars_lock);
+		return -EINVAL;
+	}
+
+	/* now *really* create the variable via EFI */
+	status = efi.set_variable(new_var->VariableName,
+				  &new_var->VendorGuid,
+				  new_var->Attributes,
+				  new_var->DataSize,
+				  new_var->Data);
+
+	if (status != EFI_SUCCESS) {
+		printk(KERN_WARNING "efivars: set_variable() failed: status=%lx\n",
+			status);
+		spin_unlock(&efivars_lock);
+		return -EIO;
+	}
+        spin_unlock(&efivars_lock);
+
+	/* Create the entry in sysfs.  Locking is not required here */
+	status = efivar_create_sysfs_entry(utf8_strsize(new_var->VariableName,
+							1024),
+				  new_var->VariableName,
+				  &new_var->VendorGuid);
+	return status;
+}
+
+static ssize_t
+efivar_delete(struct subsystem *sub, const char *buf, size_t count)
+{
+	struct efi_variable *del_var = (struct efi_variable *)buf;
+	struct efivar_entry *search_efivar = NULL;
+	unsigned long strsize1, strsize2;
+	struct list_head *pos, *n;
+	efi_status_t status = EFI_NOT_FOUND;
+	int found = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	spin_lock(&efivars_lock);
+
+	/*
+	 * Does this variable already exist?
+	 */
+	list_for_each_safe(pos, n, &efivar_list) {
+		search_efivar = get_efivar_entry(pos);
+		strsize1 = utf8_strsize(search_efivar->var.VariableName, 1024);
+		strsize2 = utf8_strsize(del_var->VariableName, 1024);
+		if ( strsize1 == strsize2 &&
+		     !memcmp(&(search_efivar->var.VariableName),
+			     del_var->VariableName, strsize1) &&
+		     !efi_guidcmp(search_efivar->var.VendorGuid,
+				  del_var->VendorGuid)) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found) {
+		spin_unlock(&efivars_lock);
+		return -EINVAL;
+	}
+	/* force the Attributes/DataSize to 0 to ensure deletion */
+	del_var->Attributes = 0;
+	del_var->DataSize = 0;
+
+	status = efi.set_variable(del_var->VariableName,
+				  &del_var->VendorGuid,
+				  del_var->Attributes,
+				  del_var->DataSize,
+				  del_var->Data);
+
+	if (status != EFI_SUCCESS) {
+		printk(KERN_WARNING "efivars: set_variable() failed: status=%lx\n",
+			status);
+		spin_unlock(&efivars_lock);
+		return -EIO;
+	}
+	/* complete the eradication... */
+	efivar_unregister(search_efivar);
+
+	/* It's dead Jim.... */
+        spin_unlock(&efivars_lock);
+
+	return status;
+}
+
+static VAR_SUBSYS_ATTR(new_var, 0200, dummy, efivar_create);
+static VAR_SUBSYS_ATTR(del_var, 0200, dummy, efivar_delete);
+
+static struct subsys_attribute *var_subsys_attrs[] = {
+	&var_subsys_attr_new_var,
+	&var_subsys_attr_del_var,
+	NULL,
+};
+
+/* 
+ * Let's not leave out systab information that snuck into 
+ * the efivars driver
+ */
+static ssize_t
+systab_read(struct subsystem *entry, char *buf)
+{
+	char *str = buf;
+	
+	if (!entry || !buf)
+		return -EINVAL;
+
+	if (efi.mps)
+		str += sprintf(str, "MPS=0x%lx\n", __pa(efi.mps));
+	if (efi.acpi20)
+		str += sprintf(str, "ACPI20=0x%lx\n", __pa(efi.acpi20));
+	if (efi.acpi)
+		str += sprintf(str, "ACPI=0x%lx\n", __pa(efi.acpi));
+	if (efi.smbios)
+		str += sprintf(str, "SMBIOS=0x%lx\n", __pa(efi.smbios));
+	if (efi.hcdp)
+		str += sprintf(str, "HCDP=0x%lx\n", __pa(efi.hcdp));
+	if (efi.boot_info)
+		str += sprintf(str, "BOOTINFO=0x%lx\n", __pa(efi.boot_info));
+	if (efi.uga)
+		str += sprintf(str, "UGA=0x%lx\n", __pa(efi.uga));
+	
+	return str - buf;
+}
+
+static EFI_ATTR(systab, 0400, systab_read, NULL);
+
+static struct subsys_attribute *efi_subsys_attrs[] = {
+	&efi_attr_systab,
+	NULL,	/* maybe more in the future? */
+};
+
+static decl_subsys(vars, &ktype_efivar, NULL);
+static decl_subsys(efi, NULL, NULL);
+
+/*
+ * efivar_create_sysfs_entry()
+ * Requires:
+ *    variable_name_size = number of bytes required to hold
+ *                         variable_name (not counting the NULL
+ *                         character at the end.
+ *    efivars_lock is not held on entry or exit.
+ * Returns 1 on failure, 0 on success
+ */
+static int
+efivar_create_sysfs_entry(unsigned long variable_name_size,
+			  efi_char16_t *variable_name,
+			  efi_guid_t *vendor_guid)
+{
+	int i, short_name_size = variable_name_size / sizeof(efi_char16_t) + 38;
+	char *short_name;
+	struct efivar_entry *new_efivar;
+
+        short_name = kmalloc(short_name_size + 1, GFP_KERNEL);
+        new_efivar = kmalloc(sizeof(struct efivar_entry), GFP_KERNEL);
+
+	if (!short_name || !new_efivar)  {
+		if (short_name)        kfree(short_name);
+		if (new_efivar)        kfree(new_efivar);
+		return 1;
+	}
+	memset(short_name, 0, short_name_size+1);
+	memset(new_efivar, 0, sizeof(struct efivar_entry));
+
+	memcpy(new_efivar->var.VariableName, variable_name,
+	       variable_name_size);
+	memcpy(&(new_efivar->var.VendorGuid), vendor_guid, sizeof(efi_guid_t));
+
+	/* Convert Unicode to normal chars (assume top bits are 0),
+	   ala UTF-8 */
+	for (i=0; i < (int)(variable_name_size / sizeof(efi_char16_t)); i++) {
+		short_name[i] = variable_name[i] & 0xFF;
+	}
+	/* This is ugly, but necessary to separate one vendor's
+	   private variables from another's.         */
+
+	*(short_name + strlen(short_name)) = '-';
+	efi_guid_unparse(vendor_guid, short_name + strlen(short_name));
+	*(short_name + strlen(short_name)) = ' ';
+
+	kobject_set_name(&new_efivar->kobj, short_name);
+	kobj_set_kset_s(new_efivar, vars_subsys);
+	kobject_register(&new_efivar->kobj);
+
+	kfree(short_name); short_name = NULL;
+
+        spin_lock(&efivars_lock);
+        list_add(&new_efivar->list, &efivar_list);
+        spin_unlock(&efivars_lock);
+
+	return 0;
+}
+/*
+ * For now we register the efi subsystem with the firmware subsystem
+ * and the vars subsystem with the efi subsystem.  In the future, it
+ * might make sense to split off the efi subsystem into its own
+ * driver, but for now only efivars will register with it, so just 
+ * include it here.
+ */
+
+static int __init
+efivars_init(void)
+{
+	efi_status_t status = EFI_NOT_FOUND;
+	efi_guid_t vendor_guid;
+	efi_char16_t *variable_name = kmalloc(1024, GFP_KERNEL);
+	struct subsys_attribute *attr;
+	unsigned long variable_name_size = 1024;
+	int i, rc = 0, error = 0;
+
+	printk(KERN_INFO "EFI Variables Facility v%s\n", EFIVARS_VERSION);
+
+	/*
+	 * For now we'll register the efi subsys within this driver
+	 */
+
+	rc = firmware_register(&efi_subsys);
+
+	if (rc)
+		return rc;
+
+	kset_set_kset_s(&vars_subsys, efi_subsys);
+	subsystem_register(&vars_subsys);
+
+	/*
+	 * Per EFI spec, the maximum storage allocated for both
+	 * the variable name and variable data is 1024 bytes.
+	 */
+
+	memset(variable_name, 0, 1024);
+
+	do {
+		variable_name_size = 1024;
+
+		status = efi.get_next_variable(&variable_name_size,
+					       variable_name,
+					       &vendor_guid);
+		switch (status) {
+		case EFI_SUCCESS:
+			efivar_create_sysfs_entry(variable_name_size,
+						 variable_name,
+						 &vendor_guid);
+			break;
+		case EFI_NOT_FOUND:
+			break;
+		default:
+			printk(KERN_WARNING "efivars: get_next_variable: status=%lx\n",
+				status);
+			status = EFI_NOT_FOUND;
+			break;
+		}
+	} while (status != EFI_NOT_FOUND);
+
+	/*
+	 * Now add attributes to allow creation of new vars
+	 * and deletion of existing ones...
+	 */
+
+	for (i = 0; (attr = var_subsys_attrs[i]) && !error; i++) {
+		if (attr->show && attr->store)
+			error = subsys_create_file(&vars_subsys, attr);
+	}
+
+	/* Don't forget the systab entry */
+
+	for (i = 0; (attr = efi_subsys_attrs[i]) && !error; i++) {
+		if (attr->show)
+			error = subsys_create_file(&efi_subsys, attr);
+	}
+
+	kfree(variable_name);
+	return 0;
+}
+
+static void __exit
+efivars_exit(void)
+{
+	struct list_head *pos, *n;
+
+        spin_lock(&efivars_lock);
+
+	list_for_each_safe(pos, n, &efivar_list)
+		efivar_unregister(get_efivar_entry(pos));
+
+	spin_unlock(&efivars_lock);
+
+	subsystem_unregister(&vars_subsys);
+	firmware_unregister(&efi_subsys);
+}
+
+module_init(efivars_init);
+module_exit(efivars_exit);
+
diff -urNp linux-2.6.1/drivers/efi/Kconfig linux-2.6.1-efivars/drivers/efi/Kconfig
--- linux-2.6.1/drivers/efi/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.1-efivars/drivers/efi/Kconfig	2004-01-12 17:17:50.000000000 -0800
@@ -0,0 +1,18 @@
+#
+# EFI Driver Configuration
+#
+
+menu "EFI driver support"
+depends on EFI
+
+config EFI_VARS
+	tristate "EFI Variable Support via sysfs"
+	depends on EFI
+	default n
+	---help---
+	  If you say Y here, you are able to get EFI (Extensible Firmware
+	  Interface) variable information via sysfs.  You may read,
+	  write, create, and destroy EFI variables through this interface.
+
+
+endmenu
diff -urNp linux-2.6.1/drivers/efi/Makefile linux-2.6.1-efivars/drivers/efi/Makefile
--- linux-2.6.1/drivers/efi/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.1-efivars/drivers/efi/Makefile	2004-01-12 17:17:50.000000000 -0800
@@ -0,0 +1,4 @@
+# EFI Variable Access
+
+obj-$(CONFIG_EFI_VARS)		+= efivars.o
+
diff -urNp linux-2.6.1/drivers/Makefile linux-2.6.1-efivars/drivers/Makefile
--- linux-2.6.1/drivers/Makefile	2004-01-08 22:59:56.000000000 -0800
+++ linux-2.6.1-efivars/drivers/Makefile	2004-01-12 17:17:50.000000000 -0800
@@ -49,3 +49,4 @@ obj-$(CONFIG_ISDN_BOOL)		+= isdn/
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
+obj-$(CONFIG_EFI)		+= efi/
diff -urNp linux-2.6.1/include/linux/efi.h linux-2.6.1-efivars/include/linux/efi.h
--- linux-2.6.1/include/linux/efi.h	2004-01-08 23:00:03.000000000 -0800
+++ linux-2.6.1-efivars/include/linux/efi.h	2004-01-12 17:17:50.000000000 -0800
@@ -15,9 +15,9 @@
 #include <linux/string.h>
 #include <linux/time.h>
 #include <linux/types.h>
-#include <linux/proc_fs.h>
 #include <linux/rtc.h>
 #include <linux/ioport.h>
+#include <linux/kobject.h>
 
 #include <asm/page.h>
 #include <asm/system.h>
@@ -315,11 +315,5 @@ extern int efi_enabled;
 #define EFI_VARIABLE_RUNTIME_ACCESS     0x0000000000000004
 
 
-/*
- * efi_dir is allocated in arch/ia64/kernel/efi.c.
- */
-#ifdef CONFIG_PROC_FS
-extern struct proc_dir_entry *efi_dir;
-#endif
 
 #endif /* _LINUX_EFI_H */
