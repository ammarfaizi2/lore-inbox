Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTEGBuc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 21:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTEGBuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 21:50:32 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:40350 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261338AbTEGBuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 21:50:25 -0400
Date: Tue, 6 May 2003 21:34:44 -0400
From: Ben Collins <bcollins@debian.org>
To: Greg KH <greg@kroah.com>, Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHES] USB input layer improvements
Message-ID: <20030507013444.GN679@phunnypharm.org>
References: <20030506002233.GY679@phunnypharm.org> <20030506234515.GA4117@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
In-Reply-To: <20030506234515.GA4117@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2003 at 04:45:15PM -0700, Greg KH wrote:
> On Mon, May 05, 2003 at 08:22:33PM -0400, Ben Collins wrote:
> > 
> > Obviously that doesn't work right. I'm not sure what the correct thing
> > to do is, so my patch for this is only RFC status. With this patch my
> > mouse and keyboard still work, and the joysticks work correctly. Maybe
> > the correct thing is to map the physical values read from the device to
> > the logical values.
> 
> Your patch looks sane at first glance, but Vojtech needs to verify that
> this is ok before I can apply it.

Well then, here's a 2.5 patch to go along with it. This is just the
multi-input part of the patch. I'm going to look at the other range
patch in more depth.

This one is a no-brainer really. Vojtech, how about it?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-inputs-2.5.diff"

Index: drivers/usb/input/hid-input.c
===================================================================
RCS file: /home/scm/linux-2.5/drivers/usb/input/hid-input.c,v
retrieving revision 1.11
diff -u -u -r1.11 hid-input.c
--- drivers/usb/input/hid-input.c	17 Mar 2003 18:43:39 -0000	1.11
+++ drivers/usb/input/hid-input.c	7 May 2003 01:58:52 -0000
@@ -60,9 +60,29 @@
 	__s32 y;
 }  hid_hat_to_axis[] = {{ 0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
 
-static void hidinput_configure_usage(struct hid_device *device, struct hid_field *field, struct hid_usage *usage)
+static struct input_dev *find_input(struct hid_device *hid, struct hid_field *field)
 {
-	struct input_dev *input = &device->input;
+	struct list_head *lh;
+	struct hid_input *hidinput;
+
+	list_for_each (lh, &hid->inputs) {
+		int i;
+
+		hidinput = list_entry(lh, struct hid_input, list);
+
+		for (i = 0; i < hidinput->maxfield; i++)
+			if (hidinput->fields[i] == field)
+				return &hidinput->input;
+	}
+
+	return NULL;
+}
+
+static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
+				     struct hid_usage *usage)
+{
+	struct input_dev *input = &hidinput->input;
+	struct hid_device *device = hidinput->input.private;
 	int max;
 	int is_abs = 0;
 	unsigned long *bit;
@@ -387,9 +407,12 @@
 
 void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, struct pt_regs *regs)
 {
-	struct input_dev *input = &hid->input;
+	struct input_dev *input = find_input(hid, field);
 	int *quirks = &hid->quirks;
 
+	if (!input)
+		return;
+
 	input_regs(input, regs);
 
 	if (usage->hat_min != usage->hat_max) {
@@ -442,7 +465,13 @@
 
 void hidinput_report_event(struct hid_device *hid, struct hid_report *report)
 {
-	input_sync(&hid->input);
+	struct list_head *lh;
+	struct hid_input *hidinput;
+
+	list_for_each (lh, &hid->inputs) {
+		hidinput = list_entry(lh, struct hid_input, list);
+		input_sync(&hidinput->input);
+        }
 }
 
 static int hidinput_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
@@ -489,7 +518,7 @@
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
 	struct list_head *list;
-	int i, j, k;
+	int i, j;
 
 	for (i = 0; i < hid->maxcollection; i++)
 		if (hid->collection[i].type == HID_COLLECTION_APPLICATION &&
@@ -499,37 +528,63 @@
 	if (i == hid->maxcollection)
 		return -1;
 
-	hid->input.private = hid;
-	hid->input.event = hidinput_input_event;
-	hid->input.open = hidinput_open;
-	hid->input.close = hidinput_close;
-
-	hid->input.name = hid->name;
-	hid->input.phys = hid->phys;
-	hid->input.uniq = hid->uniq;
-	hid->input.id.bustype = BUS_USB;
-	hid->input.id.vendor = dev->descriptor.idVendor;
-	hid->input.id.product = dev->descriptor.idProduct;
-	hid->input.id.version = dev->descriptor.bcdDevice;
-
-	for (k = HID_INPUT_REPORT; k <= HID_OUTPUT_REPORT; k++) {
-		report_enum = hid->report_enum + k;
-		list = report_enum->report_list.next;
-		while (list != &report_enum->report_list) {
-			report = (struct hid_report *) list;
-			for (i = 0; i < report->maxfield; i++)
-				for (j = 0; j < report->field[i]->maxusage; j++)
-					hidinput_configure_usage(hid, report->field[i], report->field[i]->usage + j);
-			list = list->next;
+	report_enum = hid->report_enum + HID_INPUT_REPORT;
+	list = report_enum->report_list.next;
+	while (list != &report_enum->report_list) {
+		struct hid_input *hidinput;
+
+		report = (struct hid_report *) list;
+
+		if (!report->maxfield)
+			continue;
+
+		hidinput = kmalloc(sizeof(*hidinput), GFP_KERNEL);
+		if (!hidinput) {
+			err("Out of memory during hid input probe");
+			return -1;
 		}
-	}
 
-	input_register_device(&hid->input);
+		memset(hidinput, 0, sizeof(*hidinput));
+
+		hidinput->input.private = hid;
+		hidinput->input.event = hidinput_input_event;
+		hidinput->input.open = hidinput_open;
+		hidinput->input.close = hidinput_close;
+
+		hidinput->input.name = hid->name;
+		hidinput->input.phys = hid->phys;
+		hidinput->input.uniq = hid->uniq;
+		hidinput->input.id.bustype = BUS_USB;
+		hidinput->input.id.vendor = dev->descriptor.idVendor;
+		hidinput->input.id.product = dev->descriptor.idProduct;
+		hidinput->input.id.version = dev->descriptor.bcdDevice;
+
+		hidinput->fields = report->field;
+		hidinput->maxfield = report->maxfield;
+
+		for (i = 0; i < report->maxfield; i++)
+			for (j = 0; j < report->field[i]->maxusage; j++)
+				hidinput_configure_usage(hidinput, report->field[i],
+							 report->field[i]->usage + j);
+
+		list_add_tail(&hidinput->list, &hid->inputs);
+
+		input_register_device(&hidinput->input);
+
+		list = list->next;
+	}
 
 	return 0;
 }
 
 void hidinput_disconnect(struct hid_device *hid)
 {
-	input_unregister_device(&hid->input);
+	struct list_head *lh, *next;
+	struct hid_input *hidinput;
+
+	list_for_each_safe (lh, next, &hid->inputs) {
+		hidinput = list_entry(lh, struct hid_input, list);
+		input_unregister_device(&hidinput->input);
+		list_del(&hidinput->list);
+	}
 }
Index: drivers/usb/input/hid.h
===================================================================
RCS file: /home/scm/linux-2.5/drivers/usb/input/hid.h,v
retrieving revision 1.11
diff -u -u -r1.11 hid.h
--- drivers/usb/input/hid.h	17 Mar 2003 18:43:39 -0000	1.11
+++ drivers/usb/input/hid.h	7 May 2003 01:58:52 -0000
@@ -321,6 +321,13 @@
 #define HID_CTRL_RUNNING	1
 #define HID_OUT_RUNNING		2
 
+struct hid_input {
+	struct list_head list;
+	struct hid_field **fields;
+	int maxfield;
+	struct input_dev input;
+};
+
 struct hid_device {							/* device report descriptor */
 	 __u8 *rdesc;
 	unsigned rsize;
@@ -360,7 +367,7 @@
 	unsigned claimed;						/* Claimed by hidinput, hiddev? */	
 	unsigned quirks;						/* Various quirks the device can pull on us */
 
-	struct input_dev input;						/* The input structure */
+	struct list_head inputs;					/* The list of inputs */
 	void *hiddev;							/* The hiddev structure */
 	int minor;							/* Hiddev minor number */
 

--ULyIDA2m8JTe+TiX--
