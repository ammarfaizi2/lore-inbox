Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVCOGJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVCOGJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 01:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVCOGJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 01:09:18 -0500
Received: from fmr17.intel.com ([134.134.136.16]:28848 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261564AbVCOGHz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 01:07:55 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [ACPI] [PATCH, new ACPI driver] new sony_acpi driver
Date: Tue, 15 Mar 2005 14:07:29 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84076B92D1@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] [PATCH, new ACPI driver] new sony_acpi driver
Thread-Index: AcUPjA3D/v581xr3Sa6I88bXORWXrAZmRNOw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Stelian Pop" <stelian@popies.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <acpi-devel@lists.sourceforge.net>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 15 Mar 2005 06:07:30.0946 (UTC) FILETIME=[45AD9620:01C52925]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Basically, this driver just call some specific AML method for hotkey function, that can be 
achieved through generic hotkey driver filed at http://bugzilla.kernel.org/show_bug.cgi?id=3887.
So I don't think this driver is needed.

>-----Original Message-----
>From: acpi-devel-admin@lists.sourceforge.net 
>[mailto:acpi-devel-admin@lists.sourceforge.net] On Behalf Of 
>Stelian Pop
>Sent: 2005��2��11�� 0:18
>To: Linux Kernel Mailing List
>Cc: Andrew Morton; acpi-devel@lists.sourceforge.net
>Subject: [ACPI] [PATCH, new ACPI driver] new sony_acpi driver
>
>Hi,
>
>This driver has been submitted (almost unchanged) on lkml and 
>on acpi-devel twice, first on July 21, 2004, then again on
>September 17, 2004. It has been quietly ignored.
>
>Privately I've had many positive feedbacks from users of this driver
>(and no negative feedback), including Linux distributions who wish
>to include it into their kernels. The reports are increasing in number,
>it would seem that newer Sony Vaios are more and more incompatible
>with sonypi and require sony_acpi to control the screen brightness.
>
>Please integrate this patch in -mm for wider testing and into
>the ACPI tree.
>
>Original announcement follows below.
>
>Thanks,
>
>Stelian.
>
>PS: I am also going to submit a bugzilla RFE for the acpi people,
>I have been told they are more receptive to that.
>
>------------------------------------------------------------------
>Most of the Sony Vaio owners are happy with the current sonypi
>driver, which makes them able to get/set the screen brightness,
>capture the jogdial and/or special key events etc.
>
>However, some newer Vaio series (FX series, and not only those) lack
>a SPIC device in their ACPI BIOS making the sonypi driver unusable
>for them.
>
>Fortunately, there is another ACPI device, called SNC (for Sony
>Notebook Control) which seems to be present in all Vaios, which
>can be used to access some low-level laptop functions. From what
>I understood, the SPIC device itself is built on top of SNC.
>
>The SNC device is able to drive the screen brightness, and probably
>more (what is does more is yet unknown). The attached driver is a
>first shot of using the SNC directly.
>
>In the default mode, the sony_acpi driver let's the user get/set the
>screen brightness, and only that.
>
>The screen is one of the most important power consumers in a laptop,
>so being able to set its brightness is very important for many users,
>making this driver useful even if it does only that.
>
>In the debug/developer mode (which can be activated with a module
>option), the driver let's the user see a few other knobs, whose
>effects is however unknown. Using the debug mode we may hopefully
>find what those knobs do and propose that extra functionalities in
>the future versions of the driver (if someone at Sony is listening,
>you know what we need from you...)
>
>This driver does not interact with the current sonypi driver, both
>drivers can be used at the same time.
>
>Signed-of-by: Stelian Pop <stelian@popies.net>
>
>--- /dev/null	2005-02-10 10:35:32.824183288 +0100
>+++ linux-2.6-stelian/drivers/acpi/sony_acpi.c	2005-01-31 
>17:05:53.000000000 +0100
>@@ -0,0 +1,442 @@
>+/*
>+ * ACPI Sony Notebook Control Driver (SNC)
>+ *
>+ * Copyright (C) 2004 Stelian Pop <stelian@popies.net>
>+ * 
>+ * Parts of this driver inspired from asus_acpi.c, which is 
>+ * Copyright (C) 2002, 2003, 2004 Julien Lerouge, Karol Kozimor
>+ *
>+ * This program is free software; you can redistribute it 
>and/or modify
>+ * it under the terms of the GNU General Public License as 
>published by
>+ * the Free Software Foundation; either version 2 of the License, or
>+ * (at your option) any later version.
>+ * 
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+ * 
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, write to the Free Software
>+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>+ *
>+ */
>+
>+#include <linux/kernel.h>
>+#include <linux/module.h>
>+#include <linux/moduleparam.h>
>+#include <linux/init.h>
>+#include <linux/types.h>
>+#include <acpi/acpi_drivers.h>
>+#include <acpi/acpi_bus.h>
>+#include <asm/uaccess.h>
>+
>+#define ACPI_SNC_CLASS		"sony"
>+#define ACPI_SNC_HID		"SNY5001"
>+#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.1"
>+
>+MODULE_AUTHOR("Stelian Pop");
>+MODULE_DESCRIPTION(ACPI_SNC_DRIVER_NAME);
>+MODULE_LICENSE("GPL");
>+
>+static int debug = 0;
>+module_param(debug, int, 0);
>+MODULE_PARM_DESC(debug,"set this to 1 (and RTFM) if you want 
>to help the development of this driver");
>+
>+static int sony_acpi_add (struct acpi_device *device);
>+static int sony_acpi_remove (struct acpi_device *device, int type);
>+
>+static struct acpi_driver sony_acpi_driver = {
>+	name:	ACPI_SNC_DRIVER_NAME,
>+	class:	ACPI_SNC_CLASS,
>+	ids:	ACPI_SNC_HID,
>+	ops:	{
>+			add:	sony_acpi_add,
>+			remove:	sony_acpi_remove,
>+		},
>+};
>+
>+struct sony_snc {
>+	acpi_handle		handle;
>+	int			brt;		/* brightness */
>+	struct proc_dir_entry	*proc_brt;
>+	int			cmi;		/* ??? ? */
>+	struct proc_dir_entry	*proc_cmi;
>+	int			csxb;		/* ??? */
>+	struct proc_dir_entry	*proc_csxb;
>+	int			ctr;		/* contrast ? */
>+	struct proc_dir_entry	*proc_ctr;
>+	int			pbr;		/* ??? */
>+	struct proc_dir_entry	*proc_pbr;
>+};
>+
>+static struct proc_dir_entry *sony_acpi_dir;
>+
>+static int acpi_callgetfunc(acpi_handle handle, char *name, 
>int *result)
>+{
>+	struct acpi_buffer output;
>+	union acpi_object out_obj;
>+	acpi_status status;
>+
>+	output.length = sizeof(out_obj);
>+	output.pointer = &out_obj;
>+
>+	status = acpi_evaluate_object(handle, name, NULL, &output);
>+	if ((status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER)) {
>+		*result = out_obj.integer.value;
>+		return 0;
>+	}
>+
>+	printk(KERN_WARNING "acpi_callreadfunc failed\n");
>+
>+	return -1;
>+}
>+
>+static int acpi_callsetfunc(acpi_handle handle, char *name, 
>int value, int *result)
>+{
>+	struct acpi_object_list params;
>+	union acpi_object in_obj;
>+	struct acpi_buffer output;
>+	union acpi_object out_obj;
>+	acpi_status status;
>+
>+	params.count = 1;
>+	params.pointer = &in_obj;
>+	in_obj.type = ACPI_TYPE_INTEGER;
>+	in_obj.integer.value = value;
>+
>+	output.length = sizeof(out_obj);
>+	output.pointer = &out_obj;
>+
>+	status = acpi_evaluate_object(handle, name, &params, &output);
>+	if (status == AE_OK) {
>+		if (result != NULL) {
>+			if (out_obj.type != ACPI_TYPE_INTEGER) {
>+				printk(KERN_WARNING 
>"acpi_evaluate_object bad return type\n");
>+				return -1;
>+			}
>+			*result = out_obj.integer.value;
>+		}
>+		return 0;
>+	}
>+	
>+	printk(KERN_WARNING "acpi_evaluate_object failed\n");
>+
>+	return -1;
>+}
>+
>+static int parse_buffer(const char __user *buffer, unsigned 
>long count, int *val) {
>+	char s[32];
>+	
>+	if (count > 31)
>+		return -EINVAL;
>+	if (copy_from_user(s, buffer, count))
>+		return -EFAULT;
>+	s[count] = 0;
>+	if (sscanf(s, "%i", val) != 1)
>+		return -EINVAL;
>+	return 0;
>+}
>+
>+static int sony_acpi_write_brt(struct file *file, const char 
>__user *buffer, unsigned long count, void *data)
>+{
>+	struct sony_snc *snc = (struct sony_snc *) data;
>+	int result;
>+
>+	if ((result = parse_buffer(buffer, count, &snc->brt)) < 0)
>+		return result;
>+
>+	/* Accept only values between 1 and 8, or VGN-T1XP will hung */
>+	if (snc->brt < 1 || snc->brt > 8)
>+		return -EINVAL;
>+
>+	if (acpi_callsetfunc(snc->handle, "SBRT", snc->brt, NULL) < 0)
>+		return -EIO;
>+
>+	return count;
>+}
>+
>+static int sony_acpi_read_brt(char *page, char **start, off_t 
>off, int count, int *eof, void *data)
>+{
>+	struct sony_snc *snc = (struct sony_snc *) data;
>+
>+	if (acpi_callgetfunc(snc->handle, "GBRT", &snc->brt) < 0)
>+		return -EIO;
>+	
>+	return sprintf(page, "%d\n", snc->brt);
>+}
>+
>+static int sony_acpi_write_cmi(struct file *file, const char 
>__user *buffer, unsigned long count, void *data)
>+{
>+	struct sony_snc *snc = (struct sony_snc *) data;
>+	int result;
>+
>+	if ((result = parse_buffer(buffer, count, &snc->cmi)) < 0)
>+		return result;
>+	
>+	if (acpi_callsetfunc(snc->handle, "SCMI", snc->cmi, 
>&snc->cmi) < 0)
>+		return -EIO;
>+
>+	return count;
>+}
>+
>+static int sony_acpi_read_cmi(char *page, char **start, off_t 
>off, int count, int *eof, void *data)
>+{
>+	struct sony_snc *snc = (struct sony_snc *) data;
>+	return sprintf(page, "%d\n", snc->cmi);
>+}
>+
>+static int sony_acpi_write_csxb(struct file *file, const char 
>__user *buffer, unsigned long count, void *data)
>+{
>+	struct sony_snc *snc = (struct sony_snc *) data;
>+	int result;
>+
>+	if ((result = parse_buffer(buffer, count, &snc->csxb)) < 0)
>+		return result;
>+	
>+	if (acpi_callsetfunc(snc->handle, "CSXB", snc->csxb, 
>&snc->csxb) < 0)
>+		return -EIO;
>+
>+	return count;
>+}
>+
>+static int sony_acpi_read_csxb(char *page, char **start, 
>off_t off, int count, int *eof, void *data)
>+{
>+	struct sony_snc *snc = (struct sony_snc *) data;
>+	return sprintf(page, "%d\n", snc->csxb);
>+}
>+
>+static int sony_acpi_write_ctr(struct file *file, const char 
>__user *buffer, unsigned long count, void *data)
>+{
>+	struct sony_snc *snc = (struct sony_snc *) data;
>+	int result;
>+
>+	if ((result = parse_buffer(buffer, count, &snc->ctr)) < 0)
>+		return result;
>+	
>+	if (acpi_callsetfunc(snc->handle, "SCTR", snc->ctr, NULL) < 0)
>+		return -EIO;
>+
>+	return count;
>+}
>+
>+static int sony_acpi_read_ctr(char *page, char **start, off_t 
>off, int count, int *eof, void *data)
>+{
>+	struct sony_snc *snc = (struct sony_snc *) data;
>+
>+	if (acpi_callgetfunc(snc->handle, "GCTR", &snc->ctr) < 0)
>+		return -EIO;
>+	
>+	return sprintf(page, "%d\n", snc->ctr);
>+}
>+
>+static int sony_acpi_write_pbr(struct file *file, const char 
>__user *buffer, unsigned long count, void *data)
>+{
>+	struct sony_snc *snc = (struct sony_snc *) data;
>+	int result;
>+
>+	if ((result = parse_buffer(buffer, count, &snc->pbr)) < 0)
>+		return result;
>+	
>+	if (acpi_callsetfunc(snc->handle, "SPBR", snc->pbr, NULL) < 0)
>+		return -EIO;
>+
>+	return count;
>+}
>+
>+static int sony_acpi_read_pbr(char *page, char **start, off_t 
>off, int count, int *eof, void *data)
>+{
>+	struct sony_snc *snc = (struct sony_snc *) data;
>+
>+	if (acpi_callgetfunc(snc->handle, "GPBR", &snc->pbr) < 0)
>+		return -EIO;
>+	
>+	return sprintf(page, "%d\n", snc->pbr);
>+}
>+		 
>+static void sony_acpi_notify(acpi_handle handle, u32 event, 
>void *data)
>+{
>+	/* struct sony_snc *snc = (struct sony_snc *) data; */
>+
>+	printk("sony_snc_notify\n");
>+}
>+
>+static acpi_status sony_walk_callback(acpi_handle handle, u32 
>level, void *context, void **return_value)
>+{
>+	struct acpi_namespace_node *node = (struct 
>acpi_namespace_node *) handle;
>+	union acpi_operand_object *operand = (union 
>acpi_operand_object *) node->object;
>+
>+	printk("sony_acpi method: name: %4.4s, args %X\n", 
>+		node->name.ascii,
>+		(u32) operand->method.param_count);
>+
>+	return AE_OK;
>+}
>+
>+static int __init sony_acpi_add(struct acpi_device *device)
>+{
>+	acpi_status status = AE_OK;
>+	struct sony_snc *snc = NULL;
>+	int result;
>+
>+	snc = kmalloc(sizeof(struct sony_snc), GFP_KERNEL);
>+	if (!snc)
>+		return -ENOMEM;
>+	memset(snc, 0, sizeof(struct sony_snc));
>+
>+	snc->handle = device->handle;
>+
>+	acpi_driver_data(device) = snc;
>+	acpi_device_dir(device) = sony_acpi_dir;
>+
>+	if (debug) {
>+		status = acpi_walk_namespace(ACPI_TYPE_METHOD, 
>snc->handle, 1, sony_walk_callback, NULL, NULL);
>+		if (ACPI_FAILURE(status)) {
>+			printk(KERN_WARNING "Unable to walk 
>acpi resources\n");
>+		}
>+	}
>+
>+	snc->proc_brt = create_proc_entry("brt", 0600, 
>acpi_device_dir(device));
>+	if (!snc->proc_brt) {
>+		printk(KERN_WARNING "Unable to create proc entry\n");
>+		result = -EIO;
>+		goto outbrt;
>+	}
>+
>+	snc->proc_brt->write_proc = sony_acpi_write_brt;
>+	snc->proc_brt->read_proc = sony_acpi_read_brt;
>+	snc->proc_brt->data = acpi_driver_data(device);
>+	snc->proc_brt->owner = THIS_MODULE;
>+
>+	if (debug) {
>+		snc->proc_cmi = create_proc_entry("cmi", 0600, 
>acpi_device_dir(device));
>+		if (!snc->proc_cmi) {
>+			printk(KERN_WARNING "Unable to create 
>proc entry\n");
>+			result = -EIO;
>+			goto outcmi;
>+		}
>+
>+		snc->proc_cmi->write_proc = sony_acpi_write_cmi;
>+		snc->proc_cmi->read_proc = sony_acpi_read_cmi;
>+		snc->proc_cmi->data = acpi_driver_data(device);
>+		snc->proc_cmi->owner = THIS_MODULE;
>+
>+		snc->proc_csxb = create_proc_entry("csxb", 
>0600, acpi_device_dir(device));
>+		if (!snc->proc_csxb) {
>+			printk(KERN_WARNING "Unable to create 
>proc entry\n");
>+			result = -EIO;
>+			goto outcsxb;
>+		}
>+
>+		snc->proc_csxb->write_proc = sony_acpi_write_csxb;
>+		snc->proc_csxb->read_proc = sony_acpi_read_csxb;
>+		snc->proc_csxb->data = acpi_driver_data(device);
>+		snc->proc_csxb->owner = THIS_MODULE;
>+
>+		snc->proc_ctr = create_proc_entry("ctr", 0600, 
>acpi_device_dir(device));
>+		if (!snc->proc_ctr) {
>+			printk(KERN_WARNING "Unable to create 
>proc entry\n");
>+			result = -EIO;
>+			goto outctr;
>+		}
>+
>+		snc->proc_ctr->write_proc = sony_acpi_write_ctr;
>+		snc->proc_ctr->read_proc = sony_acpi_read_ctr;
>+		snc->proc_ctr->data = acpi_driver_data(device);
>+		snc->proc_ctr->owner = THIS_MODULE;
>+
>+		snc->proc_pbr = create_proc_entry("pbr", 0600, 
>acpi_device_dir(device));
>+		if (!snc->proc_pbr) {
>+			printk(KERN_WARNING "Unable to create 
>proc entry\n");
>+			result = -EIO;
>+			goto outpbr;
>+		}
>+
>+		snc->proc_pbr->write_proc = sony_acpi_write_pbr;
>+		snc->proc_pbr->read_proc = sony_acpi_read_pbr;
>+		snc->proc_pbr->data = acpi_driver_data(device);
>+		snc->proc_pbr->owner = THIS_MODULE;
>+
>+		status = acpi_install_notify_handler(snc->handle,
>+			ACPI_DEVICE_NOTIFY, sony_acpi_notify, snc);
>+			if (ACPI_FAILURE(status)) {
>+				printk(KERN_WARNING "Unable to 
>install notify handler\n");
>+				result = -ENODEV;
>+				goto outnotify;
>+		}
>+	}
>+
>+	printk(KERN_INFO ACPI_SNC_DRIVER_NAME " successfully 
>installed\n");
>+
>+	return 0;
>+
>+outnotify:
>+	remove_proc_entry("pbr", acpi_device_dir(device));
>+outpbr:
>+	remove_proc_entry("ctr", acpi_device_dir(device));
>+outctr:
>+	remove_proc_entry("csxb", acpi_device_dir(device));
>+outcsxb:
>+	remove_proc_entry("cmi", acpi_device_dir(device));
>+outcmi:
>+	remove_proc_entry("brt", acpi_device_dir(device));
>+outbrt:
>+	kfree(snc);
>+	return result;
>+}
>+
>+
>+static int __exit sony_acpi_remove(struct acpi_device 
>*device, int type)
>+{
>+	acpi_status status = AE_OK;
>+	struct sony_snc *snc = NULL;
>+
>+	snc = (struct sony_snc *) acpi_driver_data(device);
>+
>+	if (debug) {
>+		status = 
>acpi_remove_notify_handler(snc->handle, ACPI_DEVICE_NOTIFY, 
>sony_acpi_notify);
>+		if (ACPI_FAILURE(status))
>+			printk(KERN_WARNING "Unable to remove 
>notify handler\n");
>+
>+		remove_proc_entry("pbr", acpi_device_dir(device));
>+		remove_proc_entry("ctr", acpi_device_dir(device));
>+		remove_proc_entry("csxb", acpi_device_dir(device));
>+		remove_proc_entry("cmi", acpi_device_dir(device));
>+	}
>+	remove_proc_entry("brt", acpi_device_dir(device));
>+
>+	kfree(snc);
>+
>+	printk(KERN_INFO ACPI_SNC_DRIVER_NAME " successfully 
>removed\n");
>+
>+	return 0;
>+}
>+
>+static int __init sony_acpi_init(void)
>+{
>+	int result;
>+
>+	sony_acpi_dir = proc_mkdir("sony", acpi_root_dir);
>+	if (!sony_acpi_dir) {
>+		printk(KERN_WARNING "Unable to create /proc entry\n");
>+		return -ENODEV;
>+	}
>+	sony_acpi_dir->owner = THIS_MODULE;
>+
>+	result = acpi_bus_register_driver(&sony_acpi_driver);
>+	if (result < 0) {
>+		remove_proc_entry("sony", acpi_root_dir);
>+		return -ENODEV;
>+	}
>+	return 0;
>+}
>+
>+
>+static void __exit sony_acpi_exit(void)
>+{
>+	acpi_bus_unregister_driver(&sony_acpi_driver);
>+	remove_proc_entry("sony", acpi_root_dir);
>+}
>+
>+module_init(sony_acpi_init);
>+module_exit(sony_acpi_exit);
>--- /dev/null	2005-02-10 10:35:32.824183288 +0100
>+++ linux-2.6-stelian/Documentation/sony_acpi.txt	
>2005-01-31 17:00:09.000000000 +0100
>@@ -0,0 +1,81 @@
>+ACPI Sony Notebook Control Driver (SNC) Readme
>+----------------------------------------------
>+	Copyright (C) 2004 Stelian Pop <stelian@popies.net>
>+
>+This mini-driver drives the ACPI SNC device present in the 
>+ACPI BIOS of the Sony Vaio laptops.
>+
>+It gives access to some extra laptop functionalities. In 
>+its current form, the only thing this driver does is letting
>+the user set or query the screen brightness.
>+
>+You should start by trying the sonypi driver, which does
>+all this and many other things. But the sonypi driver does
>+not work on all sonypi laptops, whereas sony_acpi should 
>+work everywhere.
>+
>+Usage:
>+------
>+
>+Loading the sony_acpi.ko module will create a /proc/acpi/sony/
>+directory populated with a couple of files (only one for the
>+moment).
>+
>+You then read/write integer values from/to those files by using
>+standard UNIX tools.
>+
>+For example:
>+	# echo "1" > /proc/acpi/sony/brt
>+sets the lowest screen brightness,
>+	# echo "8" > /proc/acpi/sony/brt
>+sets the highest screen brightness,
>+	# cat /proc/acpi/sony/brt
>+retrieves the current screen brightness.
>+
>+Development:
>+------------
>+
>+If you want to help with the development of this driver (and
>+you are not afraid of any side effects doing strange things with
>+your ACPI BIOS could have on your laptop), load the driver and
>+pass the option 'debug=1'.
>+
>+REPEAT: DON'T DO THIS IF YOU DON'T LIKE RISKY BUSINESS.
>+
>+In your kernel logs you will find the list of all ACPI methods
>+the SNC device has on your laptop. You can see the GBRT/SBRT methods
>+used to get/set the brightness, but there are others.
>+
>+I HAVE NO IDEA WHAT THOSE METHODS DO.
>+
>+The sony_acpi driver creates, for some of those methods (the most 
>+current ones found on several Vaio models), an entry under
>+/proc/acpi/sony/, just like the 'brt' one.
>+
>+Your mission, should you accept it, is to try finding out what 
>+those entries are for, by reading/writing random values from/to those
>+files and find out what is the impact on your laptop.
>+
>+You can also modify the driver source and add your extra methods
>+and retest.
>+
>+Should you find anything interesting, please report it back to me,
>+I will not disavow all knowledge of your actions :)
>+
>+Bugs/Limitations:
>+-----------------
>+
>+* This driver is not based on official documentation from Sony
>+  (because there is none), so there is no guarantee this driver
>+  will work at all, or do the right thing. Although this hasn't
>+  happened to me, this driver could do very bad things to your
>+  laptop, including permanent damage.
>+  
>+* The sony_acpi and sonypi drivers do not interact at all. In the
>+  future, sonypi could use sony_acpi to do (part of) its business.
>+
>+* spicctrl, which is the userspace tool used to communicate with the
>+  sonypi driver (through /dev/sonypi) does not try to use the 
>+  sony_acpi driver. In the future, spicctrl could try sonypi first, 
>+  and if it isn't present, try sony_acpi instead.
>+
>--- linux-2.6-stelian/drivers/acpi/Makefile
>+++ linux-2.6-linus/drivers/acpi/Makefile
>@@ -54,4 +54,5 @@ obj-$(CONFIG_ACPI_NUMA)		+= numa.o
> obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
> obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
> obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
>+obj-$(CONFIG_ACPI_SONY)		+= sony_acpi.o
> obj-$(CONFIG_ACPI_BUS)		+= scan.o motherboard.o
>--- linux-2.6-stelian/drivers/acpi/Kconfig
>+++ linux-2.6-linus/drivers/acpi/Kconfig
>@@ -242,6 +242,21 @@ config ACPI_TOSHIBA
> 	  If you have a legacy free Toshiba laptop (such as the 
>Libretto L1
> 	  series), say Y.
> 
>+config ACPI_SONY
>+	tristate "Sony Laptop Extras" 
>+	depends on X86
>+	depends on ACPI_INTERPRETER
>+	default m
>+	  ---help---
>+	  This mini-driver drives the ACPI SNC device present in the
>+	  ACPI BIOS of the Sony Vaio laptops.
>+
>+	  It gives access to some extra laptop functionalities. In
>+	  its current form, the only thing this driver does is letting 
>+	  the user set or query the screen brightness.
>+
>+	  Read <Documentation/sony_acpi.txt> for more information.
>+
> config ACPI_CUSTOM_DSDT
> 	bool "Include Custom DSDT"
> 	depends on ACPI_INTERPRETER && !STANDALONE
>-- 
>Stelian Pop <stelian@popies.net>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from 
>real users.
>Discover which products truly live up to the hype. Start reading now.
>http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
