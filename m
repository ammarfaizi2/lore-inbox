Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUHSGll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUHSGll (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 02:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268068AbUHSGll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 02:41:41 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:50322 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S265999AbUHSGjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 02:39:40 -0400
Date: Wed, 18 Aug 2004 23:35:22 -0700
From: David Bronaugh <dbronaugh@linuxboxen.org>
Subject: Re: [PATCH][ACPI] Panasonic Hotkey Driver
To: linux-kernel@vger.kernel.org
Message-id: <41244A2A.9060405@linuxboxen.org>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------060707090602040203070004
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060707090602040203070004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The following patch adds brightness setting support to the driver and 
cleans up the code a bit. It builds on the work of  Hiroshi Miura and 
takes into account the comments of Len Brown and John Belmonte. The 
patch is against 2.6.8.1-mm1 (though the only thing that might differ 
between -mm1 and vanilla is the Makefile).

I've tested this on my Panasonic CF-R1, and it works beautifully.

As far as I am concerned, besides code cleanups (and possibly figuring 
out the monitor switch thing) this driver is complete.

I hope I haven't stepped on any toes here.

David Bronaugh
ps: I'm not on linux-kernel; I am on acpi-devel; forgot to CC this list 
when sending to acpi-devel
---------

Supporting bits:

# /etc/acpi/events/hotkey
# This script handles hotkey events on Panasonic notebooks

event=HKEY.*
action=/etc/acpi/hotkey.sh %e

----------------------

#!/bin/bash
# Handles hotkey events for Panasonic notebooks
KEY=$4

BRIGHTNESS_CONTROL=/proc/acpi/pcc/brightness
VOLADJUST=5
GETVOLCMD="amixer cget numid=2"
GETMUTECMD="amixer cget numid=1"
SETVOLCMD="amixer cset numid=2"
SETMUTECMD="amixer cset numid=1"

case "$KEY" in
   00000001)
       logger "acpid: received a down brightness event"
       BRIGHT=`cat /proc/acpi/pcc/brightness`
       let BRIGHT=BRIGHT-1
       echo $BRIGHT > $BRIGHTNESS_CONTROL
       ;;
   00000002)
       logger "acpid: received an up brightness event"
       BRIGHT=`cat /proc/acpi/pcc/brightness`
       let BRIGHT=BRIGHT+1
       echo $BRIGHT > $BRIGHTNESS_CONTROL
       ;;
   00000003)
       logger "acpid: received a monitor switch event (unhandled)"
       ;;
   00000004)
       logger "acpid: received a sound mute event"
       ;;
   00000005)
       logger "acpid: received a volume down event"
       ;;
   00000006)
       logger "acpid: received a volume up event"
       ;;
   00000007)
       logger "acpid: received a suspend-to-RAM event (unhandled)"
       ;;
   00000009)
       logger "acpid: received a disk spindown event"
       ;;
   0000000a)
       logger "acpid: received a suspend-to-disk event"
       ;;
   *)
       logger "acpid: received unhandled event $KEY"
       ;;
esac

--------------060707090602040203070004
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru lb-2.6.8.1/drivers/acpi/Kconfig linux-2.6.8.1/drivers/acpi/Kconfig
--- lb-2.6.8.1/drivers/acpi/Kconfig	2004-08-18 22:31:04.000000000 -0700
+++ linux-2.6.8.1/drivers/acpi/Kconfig	2004-08-18 22:40:19.000000000 -0700
@@ -204,6 +204,25 @@
 	  If you have a legacy free Toshiba laptop (such as the Libretto L1
 	  series), say Y.
 
+config ACPI_PCC
+	tristate "Panasonic Laptop Extras"
+	depends on X86
+	default m
+	---help---
+	  This driver adds support for hotkeys and screen brightness setting
+	  on Panasonic Let's Note laptops. 
+
+          For CRT/LCD switching, see the userspace utility i810switch.
+
+	  More information about this driver is available at
+	  <http://www.da-cha.org/letsnote/>
+
+	  Note: In order to effectively use this driver, you must set up your 
+	  acpid to handle 'hotkey' events. See the website for more details.
+
+	  If you have a panasonic lets note laptop (such as the CF-T2, Y2,
+	  R1, R2, W2, R3), say Y.
+
 config ACPI_DEBUG
 	bool "Debug Statements"
 	depends on ACPI_INTERPRETER
diff -Nru lb-2.6.8.1/drivers/acpi/Makefile linux-2.6.8.1/drivers/acpi/Makefile
--- lb-2.6.8.1/drivers/acpi/Makefile	2004-08-18 22:31:18.000000000 -0700
+++ linux-2.6.8.1/drivers/acpi/Makefile	2004-08-18 19:00:56.000000000 -0700
@@ -47,4 +47,5 @@
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
+obj-$(CONFIG_ACPI_PCC)          += pcc_acpi.o
 obj-$(CONFIG_ACPI_BUS)		+= scan.o motherboard.o
diff -Nru lb-2.6.8.1/drivers/acpi/pcc_acpi.c linux-2.6.8.1/drivers/acpi/pcc_acpi.c
--- lb-2.6.8.1/drivers/acpi/pcc_acpi.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.8.1/drivers/acpi/pcc_acpi.c	2004-08-18 22:54:59.000000000 -0700
@@ -0,0 +1,566 @@
+/*
+ *  Panasonic HotKey control Extra driver
+ *  (C) 2004 Hiroshi Miura <miura@da-cha.org>
+ *  (C) 2004 NTT DATA Intellilink Co. http://www.intellilink.co.jp/
+ *  (C) 2004 David Bronaugh <dbronaugh@linuxboxen.org>
+ *  All Rights Reserved
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as 
+ *  publicshed by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ * *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  The devolpment page for this driver will be located at
+ *  http://www.da-cha.org/
+ *
+ *---------------------------------------------------------------------------
+ *
+ * ChangeLog:
+ *      Aug.17, 2004    David Bronaugh (dbronaugh@linuxboxen.org)
+ *              - v0.5  Added screen brightness setting interface
+ *              -       Thanks to the FreeBSD crew (acpi_panasonic.c authors)
+ *              -       for the ideas I needed to accomplish it
+ *
+ *	Jul.25, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		- v0.4  first post version
+ *		-       add debug function to retrive SIFR
+ *
+ *	Jul.24, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		- v0.3  get proper status of hotkey
+ *
+ *      Jul.22, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		- v0.2  add HotKey handler
+ *
+ *      Jul.17, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		- v0.1  Based on the toshiba_acpi.c video driver by 
+ *              -       John Belmonte -- see toshiba_acpi.c for more details
+ *
+ *  TODO
+ *	- Figure out the display switch key: is it a part of the ACPI standard?
+ */
+
+#define ACPI_PCC_VERSION	"0.5"
+#define PROC_INTERFACE_VERSION	2
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+
+MODULE_AUTHOR("Hiroshi Miura");
+MODULE_DESCRIPTION("ACPI HotKey driver for lets note");
+MODULE_LICENSE("GPL");
+
+#define LOGPREFIX "acpi_pcc: "
+
+/****************************************************
+ * Define ACPI PATHs 
+ ****************************************************/
+#define METHOD_CHGD            "\\_SB_.CHGD"
+
+/* Lets note hotkeys definitions */
+#define DEVICE_NAME_HKEY 	"\\_SB_.HKEY"
+#define METHOD_HKEY_QUERY	"HINF"
+
+/* ACPI BIOS inside use only? */
+#define METHOD_HKEY_RESET	"HRES"
+#define METHOD_HKEY_SAVE	"HSAV"
+#define METHOD_HKEY_HIND	"HIND"
+
+/* event read/write functions */
+#define METHOD_HKEY_SQTY	"SQTY"
+#define METHOD_HKEY_SINF	"SINF"
+#define METHOD_HKEY_SSET	"SSET"
+
+/* device(HKEY) definitions */
+#define HKEY_HID		"MAT0019"
+#define HKEY_NOTIFY		 0x80
+
+#define	LCD_MAX_BRIGHTNESS 255
+
+/* This may be magical -- beware */
+#define LCD_BRIGHTNESS_INCREMENT 17
+
+/* Registers of SINF */
+#define	SINF_LCD_BRIGHTNESS		4
+
+/*******************************************************************
+ *
+ * definitions for /proc/ interface
+ *
+ *******************************************************************/
+#define PROC_PCC		"pcc"
+
+#define ACPI_HOTKEY_DRIVER_NAME "PCC HotKey Driver"
+#define ACPI_HOTKEY_DEVICE_NAME "HotKey"
+#define ACPI_HOTKEY_CLASS "HKEY"
+
+static int acpi_hotkey_add(struct acpi_device *device);
+static int acpi_hotkey_remove(struct acpi_device *device, int type);
+
+static struct acpi_driver acpi_hotkey_driver = {
+	.name = ACPI_HOTKEY_DRIVER_NAME,
+	.class = ACPI_HOTKEY_CLASS,
+	.ids = HKEY_HID,
+	.ops = {
+		.add = acpi_hotkey_add,
+		.remove = acpi_hotkey_remove,
+		},
+};
+
+struct acpi_hotkey {
+	acpi_handle handle;
+	struct acpi_device *device;
+	unsigned long status;
+};
+
+/*
+ * utility functions
+ */
+static __inline__ void _set_bit(u32 * word, u32 mask, int value)
+{
+	*word = (*word & ~mask) | (mask * value);
+}
+
+/* acpi interface wrappers
+ */
+static int is_valid_acpi_path(const char *methodName)
+{
+	acpi_handle handle;
+	acpi_status status;
+
+	status = acpi_get_handle(0, (char *)methodName, &handle);
+	return !ACPI_FAILURE(status);
+}
+
+static int read_acpi_int(acpi_handle handle, const char *methodName, int *pVal)
+{
+	struct acpi_buffer results;
+	union acpi_object out_objs[1];
+	acpi_status status;
+
+	results.length = sizeof(out_objs);
+	results.pointer = out_objs;
+
+	status = acpi_evaluate_object(handle, (char *)methodName, 0, &results);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_INFO "acpi evaluate error on %s\n", methodName);
+		return (-EFAULT);
+	}
+
+	if (out_objs[0].type == ACPI_TYPE_INTEGER) {
+		*pVal = out_objs[0].integer.value;
+	} else {
+		printk(KERN_INFO "return value is not int\n");
+		status = AE_ERROR;
+	}
+
+	return (status == AE_OK);
+}
+
+static struct proc_dir_entry *acpi_pcc_dir;
+
+typedef struct _ProcItem {
+	const char *name;
+	char *(*read_func) (char *);
+	unsigned long (*write_func) (const char *, unsigned long);
+} ProcItem;
+
+/* register utils for proc handler */
+static int dispatch_read(char *page, char **start, off_t off, int count,
+			 int *eof, ProcItem * item)
+{
+	char *p = page;
+	int len;
+
+	if (off == 0) {
+		p = item->read_func(p);
+	}
+
+	/* ISSUE: I don't understand this code */
+	len = (p - page);
+	if (len <= off + count) {
+		*eof = 1;
+	}
+	*start = page + off;
+	len -= off;
+	if (len > count) {
+		len = count;
+	}
+	if (len < 0) {
+		len = 0;
+	}
+	return len;
+}
+
+static int dispatch_write(struct file *file, __user const char *buffer,
+			  unsigned long count, ProcItem * item)
+{
+	int result;
+	char *tmp_buffer;
+
+	/* Arg buffer points to userspace memory, which can't be accessed
+	 * directly.  Since we're making a copy, zero-terminate the
+	 * destination so that sscanf can be used on it safely.
+	 */
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count)) {
+		result = -EFAULT;
+	} else {
+		tmp_buffer[count] = 0;
+		result = item->write_func(tmp_buffer, count);
+	}
+	kfree(tmp_buffer);
+	return result;
+}
+
+/*
+ * proc file handlers
+ */
+#ifdef DEBUG_PCC_VGA
+static unsigned long write_chgd(const char *buffer, unsigned long count)
+{
+	int value;
+	acpi_status status;
+
+	if (sscanf(buffer, "%i", &value) == 1 && value >= 0 && value < 2) {
+		if (value == 0) {
+			/* do nothing */
+			status = AE_OK;
+		} else {
+			status = acpi_evaluate_object(0, METHOD_CHGD, 0, 0);
+		}
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_INFO LOGPREFIX "fail evaluate CHGD()\n");
+			return -EFAULT;
+		}
+	}
+	return count;
+
+}
+
+static char *read_nothing(char *p)
+{
+	/* nothing to do */
+	return p;
+}
+#endif
+
+static char *read_hkey_status(char *p)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *hkey = NULL;
+	int i, num_sifr;
+
+	if (!read_acpi_int(NULL, DEVICE_NAME_HKEY "." METHOD_HKEY_SQTY,
+			   &num_sifr)) {
+		printk(KERN_INFO LOGPREFIX "evaluation error HKEY.SQTY\n");
+		return p;
+	}
+
+	status = acpi_evaluate_object(NULL,
+				      DEVICE_NAME_HKEY "." METHOD_HKEY_SINF,
+				      0, &buffer);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_INFO LOGPREFIX "evaluation error HEKY.SINF\n");
+		return p;
+	}
+	hkey = (union acpi_object *)buffer.pointer;
+	if (!hkey || (hkey->type != ACPI_TYPE_PACKAGE)) {
+		printk(KERN_INFO LOGPREFIX "Invalid HKEY.SINF\n");
+		goto end;
+	}
+
+	if (num_sifr != hkey->package.count) {
+		printk(KERN_INFO LOGPREFIX
+		       "SQTY is not equal to SINF length?\n");
+		goto end;
+	}
+
+	for (i = 0; i < hkey->package.count; i++) {
+		union acpi_object *element = &(hkey->package.elements[i]);
+		if (likely(element->type == ACPI_TYPE_INTEGER)) {
+			p += sprintf(p, "0x%02x,\n",
+				     (unsigned int)element->integer.value);
+		} else
+			printk(KERN_INFO LOGPREFIX "Invalid HKEY.SINF value\n");
+	}
+      end:
+	acpi_os_free(buffer.pointer);
+	return p;
+}
+
+static char *read_version(char *p)
+{
+	p += sprintf(p, "%s version %s\n", ACPI_HOTKEY_DRIVER_NAME,
+		     ACPI_PCC_VERSION);
+	p += sprintf(p, "proc_interface version %d\n", PROC_INTERFACE_VERSION);
+	return p;
+}
+
+static char *read_brightness(char *p)
+{
+	uint32_t brightness;
+	union acpi_object *resource;
+	struct acpi_buffer entries = { ACPI_ALLOCATE_BUFFER, NULL };
+	int status;
+
+	status = acpi_evaluate_object(NULL,
+				      DEVICE_NAME_HKEY "." METHOD_HKEY_SINF,
+				      NULL, &entries);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_INFO "Could not get SINF\n");
+		return p;
+	}
+
+	resource = (union acpi_object *)entries.pointer;
+	if (!resource || resource->type != ACPI_TYPE_PACKAGE) {
+		printk(KERN_INFO "Could not read display brightness\n");
+		return p;
+	} else {
+		union acpi_object *element =
+		    &(resource->package.elements[SINF_LCD_BRIGHTNESS]);
+		brightness = element->integer.value;
+	}
+	acpi_os_free(entries.pointer);
+
+	p += sprintf(p, "%i\n", brightness / LCD_BRIGHTNESS_INCREMENT);
+	return p;
+}
+
+static unsigned long write_brightness(const char *p, unsigned long count)
+{
+	int brightness = simple_strtol(p, NULL, 10) * LCD_BRIGHTNESS_INCREMENT;
+	union acpi_object data[2];
+	struct acpi_object_list args;
+	uint32_t status;
+
+	/* Clean up incoming data */
+	if (brightness > LCD_MAX_BRIGHTNESS) {
+		brightness = LCD_MAX_BRIGHTNESS;
+	} else if (brightness < 0) {
+		brightness = 0;
+	}
+
+	data[0].type = ACPI_TYPE_INTEGER;
+	data[0].integer.value = SINF_LCD_BRIGHTNESS;
+	data[1].type = ACPI_TYPE_INTEGER;
+	data[1].integer.value = brightness;
+	args.pointer = data;
+	args.count = 2;
+
+	status = acpi_evaluate_object(NULL,
+				      DEVICE_NAME_HKEY "." METHOD_HKEY_SSET,
+				      &args, NULL);
+
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_INFO "Could not write display brightness");
+	}
+
+	return count;
+}
+
+/* hotkey driver */
+static int acpi_hotkey_get_key(struct acpi_hotkey *hotkey)
+{
+	int result;
+	int status;
+
+	status = read_acpi_int(hotkey->handle, METHOD_HKEY_QUERY, &result);
+	if (!status) {
+		printk(KERN_INFO LOGPREFIX "error getting hotkey status\n");
+	} else
+		hotkey->status = result;
+
+	return (status);
+}
+
+void acpi_hotkey_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_hotkey *hotkey = (struct acpi_hotkey *)data;
+
+	if (!hotkey || !hotkey->device)
+		return;
+
+	switch (event) {
+	case HKEY_NOTIFY:
+		if (acpi_hotkey_get_key(hotkey))
+			acpi_bus_generate_event(hotkey->device, event,
+						hotkey->status);
+		break;
+	default:
+		/* nothing to do */
+		break;
+	}
+
+	return;
+}
+
+static int acpi_hotkey_add(struct acpi_device *device)
+{
+	int result = 0;
+	acpi_status status = AE_OK;
+	struct acpi_hotkey *hotkey = NULL;
+
+	if (!device)
+		return (-EINVAL);
+
+	hotkey = kmalloc(sizeof(struct acpi_hotkey), GFP_KERNEL);
+	if (!hotkey)
+		return (-ENOMEM);
+
+	memset(hotkey, 0, sizeof(struct acpi_hotkey));
+
+	hotkey->device = device;
+	hotkey->handle = device->handle;
+	acpi_driver_data(device) = hotkey;
+	strcpy(acpi_device_name(device), ACPI_HOTKEY_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_HOTKEY_CLASS);
+
+	status = acpi_install_notify_handler(hotkey->handle,
+					     ACPI_DEVICE_NOTIFY,
+					     acpi_hotkey_notify, hotkey);
+	if (ACPI_FAILURE(status))
+		result = -ENODEV;
+
+	if (result)
+		kfree(hotkey);
+
+	return (result);
+}
+
+static int acpi_hotkey_remove(struct acpi_device *device, int type)
+{
+	acpi_status status = 0;
+	struct acpi_hotkey *hotkey = NULL;
+
+	if (!device || !acpi_driver_data(device))
+		return (-EINVAL);
+
+	hotkey = acpi_driver_data(device);
+	status = acpi_remove_notify_handler(hotkey->handle,
+					    ACPI_DEVICE_NOTIFY,
+					    acpi_hotkey_notify);
+	if (ACPI_FAILURE(status))
+		printk(KERN_INFO LOGPREFIX "Error removing notify handler\n");
+
+	kfree(hotkey);
+
+	return (0);
+}
+
+/*
+ * proc and module init
+*/
+
+ProcItem pcc_proc_items[] = {
+#ifdef DEBUG_PCC_VGA
+	{"chgd", read_nothing, write_chgd}
+	,
+#endif
+	{"brightness", read_brightness, write_brightness}
+	,
+	{"hkey_status", read_hkey_status, NULL}
+	,
+	{"version", read_version, NULL}
+	,
+	{NULL, NULL, NULL}
+	,
+};
+
+static acpi_status __init
+add_device(ProcItem * proc_items, struct proc_dir_entry *proc_entry)
+{
+	struct proc_dir_entry *proc;
+	ProcItem *item;
+
+	for (item = proc_items; item->name; ++item) {
+		proc = create_proc_read_entry(item->name,
+					      S_IFREG | S_IRUGO | S_IWUSR,
+					      proc_entry,
+					      (read_proc_t *) dispatch_read,
+					      item);
+		if (proc)
+			proc->owner = THIS_MODULE;
+		if (proc && item->write_func)
+			proc->write_proc = (write_proc_t *) dispatch_write;
+	}
+
+	return (AE_OK);
+}
+
+static int __init pcc_proc_init(void)
+{
+	acpi_status status = AE_OK;
+
+	if (unlikely(!(acpi_pcc_dir = proc_mkdir(PROC_PCC, acpi_root_dir))))
+		return -ENODEV;
+
+	acpi_pcc_dir->owner = THIS_MODULE;
+	status = add_device(pcc_proc_items, acpi_pcc_dir);
+	if (ACPI_FAILURE(status)) {
+		remove_proc_entry(PROC_PCC, acpi_root_dir);
+		return -ENODEV;
+	}
+
+	return (status == AE_OK);
+}
+
+static acpi_status __exit
+remove_device(ProcItem * proc_items, struct proc_dir_entry *proc_entry)
+{
+	ProcItem *item;
+
+	for (item = proc_items; item->name; ++item)
+		remove_proc_entry(item->name, proc_entry);
+	return (AE_OK);
+}
+
+/* init funcs. */
+static int __init acpi_pcc_init(void)
+{
+	acpi_status result = AE_OK;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	/* simple device detection: look forI method */
+	if (!(is_valid_acpi_path(METHOD_CHGD)))
+		return -ENODEV;
+
+	result = acpi_bus_register_driver(&acpi_hotkey_driver);
+	if (ACPI_FAILURE(result))
+		printk(KERN_INFO LOGPREFIX "Error registering hotkey driver\n");
+
+	printk(KERN_INFO LOGPREFIX "ACPI PCC HotKey driver version %s\n",
+	       ACPI_PCC_VERSION);
+
+	return (pcc_proc_init());
+
+}
+
+static void __exit acpi_pcc_exit(void)
+{
+	if (acpi_pcc_dir) {
+		remove_device(pcc_proc_items, acpi_pcc_dir);
+		remove_proc_entry(PROC_PCC, acpi_root_dir);
+	}
+	acpi_bus_unregister_driver(&acpi_hotkey_driver);
+	return;
+}
+
+module_init(acpi_pcc_init);
+module_exit(acpi_pcc_exit);

--------------060707090602040203070004--
