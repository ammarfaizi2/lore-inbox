Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbTEFAgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 20:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTEFAgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 20:36:21 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:56463 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262211AbTEFAgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 20:36:00 -0400
Date: Mon, 5 May 2003 20:22:33 -0400
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCHES] USB input layer improvements
Message-ID: <20030506002233.GY679@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok, now I'm sending this here since linux-usb-devel and Pavel seem to be
ignoring my emails. Note, this is against 2.4.21-rc1, but I am prepared
to finish this off for 2.5 aswell. I just need someone who knows USB to
look this over and give me some freaking feedback. The multi-input patch
seems to be of significant importance.

---------------------------------------------------------------------

I've been working on getting my recently purchased Happ Controls UGCI
Fighting interface working.

Aside from getting it working with the standard input layer (it
implements a mouse, 2 joysticks and a keyboard), it also has some
specialized inputs/outputs that I am programming from userspace
using the event layer.

The first problem I had with the initial HID was that the hid-input
layer only has per-interface granularity with the input layer. This
device has only two interfaces. The second is the mouse, the first is
7 other inputs including the 2 joysticks and the keyboard.

The hid-input layer would lump all the fields in the first interface (7
axis and 13 buttons in all) to one input. So I got one joystick device
and that was it.

I did up a patch that created an input for each input in the interfaces
listing. IMO, this is the correct way since each input descibes the
fields available in it, and is a logical grouping.


Now, the second problem is that my joysticks look like this:

    Field(0)
      Physical(GenericDesktop.Pointer)
      Usage(2)
        GenericDesktop.X
        GenericDesktop.Y
      Logical Minimum(-128)
      Logical Maximum(127)
      Physical Minimum(0)
      Physical Maximum(255)
      Report Size(8)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )


Notice the logical/physical min/max are different, even though they are
the same range. As far as I can tell this is within HID specs. Windows
uses the joystick just fine. However Linux's HID and HID-input layer
both use the logic min/max in this case, while the device is sending
values in the physical min/max range. This is digital, so we get
0,128,255 from the device, but HID interprets that as 0,-128,-1.

Obviously that doesn't work right. I'm not sure what the correct thing
to do is, so my patch for this is only RFC status. With this patch my
mouse and keyboard still work, and the joysticks work correctly. Maybe
the correct thing is to map the physical values read from the device to
the logical values.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-inputs.diff"

Index: drivers/usb/hid-core.c
===================================================================
RCS file: /home/scm/linux-2.4/drivers/usb/hid-core.c,v
retrieving revision 1.16
diff -u -r1.16 hid-core.c
--- drivers/usb/hid-core.c	31 Mar 2003 22:12:23 -0000	1.16
+++ drivers/usb/hid-core.c	28 Apr 2003 20:35:15 -0000
@@ -621,6 +621,8 @@
 	for (i = 0; i < HID_REPORT_TYPES; i++)
 		INIT_LIST_HEAD(&device->report_enum[i].report_list);
 
+	INIT_LIST_HEAD(&device->inputs);
+
 	if (!(device->rdesc = (__u8 *)kmalloc(size, GFP_KERNEL))) {
 		kfree(device);
 		return NULL;
@@ -1291,8 +1300,20 @@
 		hid->claimed |= HID_CLAIMED_HIDDEV;
 	printk(KERN_INFO);
 
-	if (hid->claimed & HID_CLAIMED_INPUT)
-		printk("input%d", hid->input.number);
+	if (hid->claimed & HID_CLAIMED_INPUT) {
+		struct list_head *lh;
+		struct hid_input *hidinput;
+		int count = 0;
+
+		list_for_each (lh, &hid->inputs) {
+			hidinput = list_entry(lh, struct hid_input, list);
+
+			if (count++)
+				printk(",");
+
+			printk("input%d", hidinput->input.number);
+		}
+	}
 	if (hid->claimed == (HID_CLAIMED_INPUT | HID_CLAIMED_HIDDEV))
 		printk(",");
 	if (hid->claimed & HID_CLAIMED_HIDDEV)
Index: drivers/usb/hid-input.c
===================================================================
RCS file: /home/scm/linux-2.4/drivers/usb/hid-input.c,v
retrieving revision 1.7
diff -u -r1.7 hid-input.c
--- drivers/usb/hid-input.c	5 Dec 2002 21:51:39 -0000	1.7
+++ drivers/usb/hid-input.c	28 Apr 2003 20:35:15 -0000
@@ -63,9 +63,29 @@
 	__s32 y;
 }  hid_hat_to_axis[] = {{0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
 
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
 	unsigned long *bit;
 
@@ -300,9 +327,12 @@
 
 void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
 {
-	struct input_dev *input = &hid->input;
+	struct input_dev *input = find_input(hid, field);
 	int *quirks = &hid->quirks;
 
+	if (!input)
+		return;
+
 	if (usage->hat_min != usage->hat_max) {
 		value = (value - usage->hat_min) * 8 / (usage->hat_max - usage->hat_min + 1) + 1;
 		if (value < 0 || value > 8) value = 0;
@@ -382,7 +412,7 @@
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
 	struct list_head *list;
-	int i, j, k;
+	int i, j;
 
 	for (i = 0; i < hid->maxapplication; i++)
 		if (IS_INPUT_APPLICATION(hid->application[i]))
@@ -391,35 +421,61 @@
 	if (i == hid->maxapplication)
 		return -1;
 
-	hid->input.private = hid;
-	hid->input.event = hidinput_input_event;
-	hid->input.open = hidinput_open;
-	hid->input.close = hidinput_close;
-
-	hid->input.name = hid->name;
-	hid->input.idbus = BUS_USB;
-	hid->input.idvendor = dev->descriptor.idVendor;
-	hid->input.idproduct = dev->descriptor.idProduct;
-	hid->input.idversion = dev->descriptor.bcdDevice;
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
+		hidinput->input.idbus = BUS_USB;
+		hidinput->input.idvendor = dev->descriptor.idVendor;
+		hidinput->input.idproduct = dev->descriptor.idProduct;
+		hidinput->input.idversion = dev->descriptor.bcdDevice;
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
Index: drivers/usb/hid.h
===================================================================
RCS file: /home/scm/linux-2.4/drivers/usb/hid.h,v
retrieving revision 1.10
diff -u -r1.10 hid.h
--- drivers/usb/hid.h	6 Aug 2002 14:38:00 -0000	1.10
+++ drivers/usb/hid.h	28 Apr 2003 20:35:15 -0000
@@ -294,6 +294,13 @@
 #define HID_CLAIMED_INPUT	1
 #define HID_CLAIMED_HIDDEV	2
 
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
@@ -316,7 +323,7 @@
 	unsigned claimed;						/* Claimed by hidinput, hiddev? */	
 	unsigned quirks;						/* Various quirks the device can pull on us */
 
-	struct input_dev input;						/* The input structure */
+	struct list_head inputs;					/* The list of inputs */
 	void *hiddev;							/* The hiddev structure */
 	int minor;							/* Hiddev minor number */
 

--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-minmax.diff"

Index: drivers/usb/hid-core.c
===================================================================
RCS file: /home/scm/linux-2.4/drivers/usb/hid-core.c,v
retrieving revision 1.16
diff -u -r1.16 hid-core.c
--- drivers/usb/hid-core.c	31 Mar 2003 22:12:23 -0000	1.16
+++ drivers/usb/hid-core.c	28 Apr 2003 20:35:15 -0000
@@ -752,14 +754,21 @@
 	unsigned count = field->report_count;
 	unsigned offset = field->report_offset;
 	unsigned size = field->report_size;
-	__s32 min = field->logical_minimum;
-	__s32 max = field->logical_maximum;
+	__s32 min, max;
 	__s32 value[count]; /* WARNING: gcc specific */
 
+	if (field->physical_minimum != field->physical_maximum) {
+		min = field->physical_minimum;
+		max = field->physical_maximum;
+	} else {
+		min = field->logical_minimum;
+		max = field->logical_maximum;
+	}
+
 	for (n = 0; n < count; n++) {
+			__u32 val = extract(data, offset + n * size, size);
 
-			value[n] = min < 0 ? snto32(extract(data, offset + n * size, size), size) :
-						    extract(data, offset + n * size, size);
+			value[n] = min < 0 ? snto32(val, size) : val;
 
 			if (!(field->flags & HID_MAIN_ITEM_VARIABLE) /* Ignore report if ErrorRollOver */
 			    && value[n] >= min && value[n] <= max
Index: drivers/usb/hid-input.c
===================================================================
RCS file: /home/scm/linux-2.4/drivers/usb/hid-input.c,v
retrieving revision 1.7
diff -u -r1.7 hid-input.c
--- drivers/usb/hid-input.c	5 Dec 2002 21:51:39 -0000	1.7
+++ drivers/usb/hid-input.c	28 Apr 2003 20:35:15 -0000
@@ -277,8 +297,15 @@
 	if (usage->code > max) return;
 
 	if (usage->type == EV_ABS) {
-		int a = field->logical_minimum;
-		int b = field->logical_maximum;
+		int a, b;
+
+		if (field->physical_minimum != field->physical_maximum) {
+			a = field->physical_minimum;
+			b = field->physical_maximum;
+		} else {
+			a = field->logical_minimum;
+			b = field->logical_maximum;
+		}
 
 		input->absmin[usage->code] = a;
 		input->absmax[usage->code] = b;

--wTWi5aaYRw9ix9vO--
