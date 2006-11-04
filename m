Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752834AbWKBNS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbWKBNS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbWKBNS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:18:28 -0500
Received: from nz-out-0102.google.com ([64.233.162.192]:49282 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752834AbWKBNS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:18:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D7R2aUtw3A9obD6+IXryFIJ8GRnx+8SJYwzHVsk3yFbqBTBtiQOQ8CSdgFx/Qq5Wt6IJKq7n91fjZn+C780sY3Wmf/CW1wy5g+vkQUyBSw1svwEb9Q7oZcGMfpTmCFH0RmzznqqRknzUAiL3iBPP+/hpTHW2w0nZmBTPRhscvww=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Andrew Morton <akpm@osdl.org>
Subject: [patch 3/6] backlight and output sysfs support for acpi video driver
Date: Sat, 4 Nov 2006 21:18:08 +0800
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
       Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611042118.08629.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


backlight and output sysfs support for acpi video driver

signed-off-by   Luming.yu@gmail.com

[patch 3/6] backlight and output sysfs support for acpi video driver
--

 acpi/Kconfig   |    2
 acpi/video.c   |  257 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 video/Kconfig  |    9 +
 video/Makefile |    1
 4 files changed, 253 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 0f9d4be..a7671f7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -106,7 +106,7 @@ config ACPI_BUTTON
 
 config ACPI_VIDEO
 	tristate "Video"
-	depends on X86
+	depends on X86 && (BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL)
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 56666a9..ace21e2 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -30,6 +30,9 @@ #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/pci.h>
+#include <linux/backlight.h>
+#include <linux/output.h>
 
 #include <asm/uaccess.h>
 
@@ -141,11 +144,11 @@ struct acpi_video_device_cap {
 	u8 _ADR:1;		/*Return the unique ID */
 	u8 _BCL:1;		/*Query list of brightness control levels supported */
 	u8 _BCM:1;		/*Set the brightness level */
+	u8 _BQC:1;		/* Get current brightness level */
 	u8 _DDC:1;		/*Return the EDID for this device */
 	u8 _DCS:1;		/*Return status of output device */
 	u8 _DGS:1;		/*Query graphics state */
 	u8 _DSS:1;		/*Device state set */
-	u8 _reserved:1;
 };
 
 struct acpi_video_device_brightness {
@@ -162,6 +165,7 @@ struct acpi_video_device {
 	struct acpi_video_bus *video;
 	struct acpi_device *dev;
 	struct acpi_video_device_brightness *brightness;
+	struct output_device *output_dev;
 };
 
 /* bus */
@@ -260,6 +264,56 @@ static int acpi_video_get_next_level(str
 				     u32 level_current, u32 event);
 static void acpi_video_switch_brightness(struct acpi_video_device *device,
 					 int event);
+static int acpi_video_device_lcd_set_level(struct acpi_video_device *, int);
+static int acpi_video_device_lcd_get_level_current(struct acpi_video_device *,unsigned long *);
+/*backlight device sysfs support*/
+static int acpi_video_get_brightness(struct backlight_device *bd);
+static int acpi_video_set_brightness(struct backlight_device *bd);
+static int acpi_video_output_get(struct output_device *);
+static int acpi_video_output_set(struct output_device *);
+static int acpi_video_device_get_state(struct acpi_video_device *, unsigned long *);
+static int acpi_video_device_set_state(struct acpi_video_device *, int);
+
+static struct backlight_device *acpi_video_backlight;
+static struct acpi_video_device *backlight_acpi_device;
+static struct backlight_properties acpi_video_data = {
+	.owner		= THIS_MODULE,
+	.max_brightness = 0,
+	.get_brightness = acpi_video_get_brightness,
+	.update_status  = acpi_video_set_brightness,
+};
+static struct output_properties acpi_output_properties = {
+	.set_state = acpi_video_output_set,
+	.get_status = acpi_video_output_get,
+};
+static int acpi_video_get_brightness(struct backlight_device *bd)
+{
+	unsigned long cur_level;
+	acpi_video_device_lcd_get_level_current(backlight_acpi_device, &cur_level);
+	return (int) cur_level;
+}
+
+static int acpi_video_set_brightness(struct backlight_device *bd)
+{
+	int request_level = bd->props->brightness;
+	acpi_video_device_lcd_set_level(backlight_acpi_device, request_level);
+	return 0;
+}
+
+static int acpi_video_output_get(struct output_device *od)
+{
+	unsigned long state;
+	struct acpi_video_device *vd = (struct acpi_video_device *)class_get_devdata(&od->class_dev);
+	acpi_video_device_get_state(vd, &state);
+	return (int)state;
+}
+
+static int acpi_video_output_set(struct output_device *od)
+{
+	unsigned long state = od->request_state;
+	struct acpi_video_device *vd = (struct acpi_video_device *)class_get_devdata(&od->class_dev);
+	return acpi_video_device_set_state(vd, state);
+}
 
 /* --------------------------------------------------------------------------
                                Video Management
@@ -345,7 +399,7 @@ acpi_video_device_lcd_set_level(struct a
 	arg0.integer.value = level;
 	status = acpi_evaluate_object(device->dev->handle, "_BCM", &args, NULL);
 
-	printk(KERN_DEBUG "set_level status: %x\n", status);
+	printk(KERN_DEBUG PREFIX "set_level status: %x\n", status);
 	return status;
 }
 
@@ -482,6 +536,134 @@ acpi_video_bus_DOS(struct acpi_video_bus
 	return status;
 }
 
+
+/*
+ * copy & paste some code for acpi_pci_data, acpi_pci_data_handler,acpi_pci_data
+ * from pci_bind.c
+ * To-do: write a new API: acpi_pci_get.
+ */
+
+struct acpi_pci_data {
+        struct acpi_pci_id id;
+        struct pci_bus *bus;
+        struct pci_dev *dev;
+};
+
+static void acpi_pci_data_handler(acpi_handle handle, u32 function,
+				  void *context)
+{
+
+	/* TBD: Anything we need to do here? */
+
+	return;
+}
+
+static struct acpi_pci_data * acpi_pci_get (struct acpi_device *device)
+{
+	int result = 0;
+	acpi_status status = AE_OK;
+	struct acpi_pci_data *data = NULL;
+	struct acpi_pci_data *pdata = NULL;
+	char *pathname = NULL;
+	struct acpi_buffer buffer = { 0, NULL };
+	acpi_handle handle = NULL;
+	struct pci_dev *dev;
+	struct pci_bus *bus;
+
+
+	if (!device || !device->parent)
+		return NULL;
+
+	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	if (!pathname)
+		return -ENOMEM;
+	memset(pathname, 0, ACPI_PATHNAME_MAX);
+	buffer.length = ACPI_PATHNAME_MAX;
+	buffer.pointer = pathname;
+
+	data = kmalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
+	if (!data) {
+		kfree(pathname);
+		return NULL;
+	}
+	memset(data, 0, sizeof(struct acpi_pci_data));
+
+	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
+	printk(KERN_INFO PREFIX "finding PCI device [%s]...\n", pathname);
+
+	/*
+	 * Segment & Bus
+	 * -------------
+	 * These are obtained via the parent device's ACPI-PCI context.
+	 */
+go_up:
+	status = acpi_get_data(device->parent->handle, acpi_pci_data_handler,
+			       (void **)&pdata);
+	if (ACPI_FAILURE(status) || !pdata || !pdata->bus) {
+		struct acpi_device *tmp_dev;
+
+		tmp_dev = device->parent;
+		if (tmp_dev->parent && (tmp_dev->parent->handle != ACPI_ROOT_OBJECT)) {
+			device = tmp_dev;
+			goto go_up;
+		}
+
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Invalid ACPI-PCI context for parent device %s",
+				acpi_device_bid(device->parent)));
+		return NULL;
+	}
+	data->id.segment = pdata->id.segment;
+	data->id.bus = pdata->bus->number;
+
+	/*
+	 * Device & Function
+	 * -----------------
+	 * These are simply obtained from the device's _ADR method.  Note
+	 * that a value of zero is valid.
+	 */
+	data->id.device = device->pnp.bus_address >> 16;
+	data->id.function = device->pnp.bus_address & 0xFFFF;
+
+	printk(KERN_INFO PREFIX "...to %02x:%02x:%02x.%02x\n",
+			  data->id.segment, data->id.bus, data->id.device,
+			  data->id.function);
+
+	/*
+	 * TBD: Support slot devices (e.g. function=0xFFFF).
+	 */
+
+	/*
+	 * Locate PCI Device
+	 * -----------------
+	 * Locate matching device in PCI namespace.  If it doesn't exist
+	 * this typically means that the device isn't currently inserted
+	 * (e.g. docking station, port replicator, etc.).
+	 * We cannot simply search the global pci device list, since
+	 * PCI devices are added to the global pci list when the root
+	 * bridge start ops are run, which may not have happened yet.
+	 */
+	bus = pci_find_bus(data->id.segment, data->id.bus);
+	if (bus) {
+		list_for_each_entry(dev, &bus->devices, bus_list) {
+			if (dev->devfn == PCI_DEVFN(data->id.device,
+						    data->id.function)) {
+				data->dev = dev;
+				break;
+			}
+		}
+	}
+	printk(KERN_INFO PREFIX "data->dev =%p", &data->dev);
+	printk(KERN_INFO PREFIX "data->dev->dev =%p\n", &data->dev->dev);
+	if (!data->dev) {
+		printk(KERN_ERR PREFIX "Device %02x:%02x:%02x.%02x not present in PCI namespace\n",
+				  data->id.segment, data->id.bus,
+				  data->id.device, data->id.function);
+		return NULL;
+	}
+	return data;
+}
+
 /*
  *  Arg:	
  *  	device	: video output device (LCD, CRT, ..)
@@ -498,12 +680,18 @@ static void acpi_video_device_find_cap(s
 	acpi_integer status;
 	acpi_handle h_dummy1;
 	int i;
+	u32 max_level = 0;
 	union acpi_object *obj = NULL;
 	struct acpi_video_device_brightness *br = NULL;
+	struct acpi_pci_data *data;
 
 
+	data = acpi_pci_get (device->video->device);
+        if (!data || !(data->dev)) {
+		printk(KERN_ERR PREFIX "acpi_video_device:no valid data from acpi_pci_get\n");
+		return ;
+	}
 	memset(&device->cap, 0, 4);
-
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_ADR", &h_dummy1))) {
 		device->cap._ADR = 1;
 	}
@@ -513,6 +701,9 @@ static void acpi_video_device_find_cap(s
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BCM", &h_dummy1))) {
 		device->cap._BCM = 1;
 	}
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BQC", &h_dummy1))) {
+		device->cap._BQC = 1;
+	}
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DDC", &h_dummy1))) {
 		device->cap._DDC = 1;
 	}
@@ -526,6 +717,7 @@ static void acpi_video_device_find_cap(s
 		device->cap._DSS = 1;
 	}
 
+
 	status = acpi_video_device_lcd_query_levels(device, &obj);
 
 	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count >= 2) {
@@ -534,7 +726,7 @@ static void acpi_video_device_find_cap(s
 
 		br = kmalloc(sizeof(*br), GFP_KERNEL);
 		if (!br) {
-			printk(KERN_ERR "can't allocate memory\n");
+			printk(KERN_ERR PREFIX "can't allocate memory\n");
 		} else {
 			memset(br, 0, sizeof(*br));
 			br->levels = kmalloc(obj->package.count *
@@ -550,6 +742,8 @@ static void acpi_video_device_find_cap(s
 					continue;
 				}
 				br->levels[count] = (u32) o->integer.value;
+				if (br->levels[count] > max_level)
+					max_level = br->levels[count];
 				count++;
 			}
 		      out:
@@ -568,6 +762,26 @@ static void acpi_video_device_find_cap(s
 
 	kfree(obj);
 
+	if (device->cap._BCL && device->cap._BCM && device->cap._BQC){
+		unsigned long tmp;
+		acpi_video_data.max_brightness = max_level;
+		acpi_video_device_lcd_get_level_current(device, &tmp);
+		acpi_video_data.brightness = tmp;
+		acpi_video_backlight = backlight_device_register("acpi-video",
+			&(data->dev->dev), NULL, &acpi_video_data);
+		backlight_acpi_device = device;
+	}
+
+	if (device->cap._DCS && device->cap._DSS){
+		char name[16];
+		memset(name, 0, 16);
+		strcat(name, acpi_device_bid(device->dev->parent));
+		strcat(name, "_");
+		strcpy(name, acpi_device_bid(device->dev));
+		device->output_dev = video_output_register(name,
+					 &(data->dev->dev),
+						device, &acpi_output_properties);
+	}
 	return;
 }
 
@@ -1011,7 +1225,6 @@ static int acpi_video_bus_POST_info_seq_
 			printk(KERN_WARNING PREFIX
 			       "This indicate a BIOS bug.  Please contact the manufacturer.\n");
 		}
-		printk("%lx\n", options);
 		seq_printf(seq, "can POST: <intgrated video>");
 		if (options & 2)
 			seq_printf(seq, " <PCI video>");
@@ -1148,11 +1361,15 @@ static int acpi_video_bus_add_fs(struct 
 {
 	struct proc_dir_entry *entry = NULL;
 	struct acpi_video_bus *video;
+        char proc_dir_name[32];
 
-
+	memset(proc_dir_name, 0, 32);
 	video = (struct acpi_video_bus *)acpi_driver_data(device);
 
 	if (!acpi_device_dir(device)) {
+              	strcpy(proc_dir_name, acpi_device_bid(device));
+               	strcat(proc_dir_name, "_");
+               	strcat(proc_dir_name, acpi_device_bid(device->parent));
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_video_dir);
 		if (!acpi_device_dir(device))
@@ -1224,17 +1441,21 @@ static int acpi_video_bus_add_fs(struct 
 static int acpi_video_bus_remove_fs(struct acpi_device *device)
 {
 	struct acpi_video_bus *video;
+        char proc_dir_name[32];
 
-
+	memset(proc_dir_name, 0, 32);
 	video = (struct acpi_video_bus *)acpi_driver_data(device);
-
 	if (acpi_device_dir(device)) {
 		remove_proc_entry("info", acpi_device_dir(device));
 		remove_proc_entry("ROM", acpi_device_dir(device));
 		remove_proc_entry("POST_info", acpi_device_dir(device));
 		remove_proc_entry("POST", acpi_device_dir(device));
 		remove_proc_entry("DOS", acpi_device_dir(device));
-		remove_proc_entry(acpi_device_bid(device), acpi_video_dir);
+
+                strcpy(proc_dir_name, acpi_device_bid(device));
+                strcat(proc_dir_name, "_");
+                strcat(proc_dir_name, acpi_device_bid(device->parent));
+                remove_proc_entry(proc_dir_name, acpi_video_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
@@ -1268,7 +1489,6 @@ acpi_video_bus_get_one_device(struct acp
 			return -ENOMEM;
 
 		memset(data, 0, sizeof(struct acpi_video_device));
-
 		strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
 		strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
 		acpi_driver_data(device) = data;
@@ -1568,6 +1788,10 @@ static int acpi_video_bus_put_one_device
 	status = acpi_remove_notify_handler(device->dev->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
+	if (device == backlight_acpi_device)
+		backlight_device_unregister(acpi_video_backlight);
+
+	video_output_unregister(device->output_dev);
 
 	return 0;
 }
@@ -1615,7 +1839,7 @@ static void acpi_video_bus_notify(acpi_h
 	struct acpi_video_bus *video = (struct acpi_video_bus *)data;
 	struct acpi_device *device = NULL;
 
-	printk("video bus notify\n");
+	printk(KERN_INFO PREFIX "video bus notify\n");
 
 	if (!video)
 		return;
@@ -1658,8 +1882,6 @@ static void acpi_video_device_notify(acp
 	    (struct acpi_video_device *)data;
 	struct acpi_device *device = NULL;
 
-
-	printk("video device notify\n");
 	if (!video_device)
 		return;
 
@@ -1691,8 +1913,9 @@ static int acpi_video_bus_add(struct acp
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_video_bus *video = NULL;
+        char proc_dir_name[32];
 
-
+	memset(proc_dir_name, 0, 32);
 	if (!device)
 		return -EINVAL;
 
@@ -1735,8 +1958,12 @@ static int acpi_video_bus_add(struct acp
 		goto end;
 	}
 
+        strcpy(proc_dir_name, acpi_device_bid(device));
+        strcat(proc_dir_name, "_");
+        strcat(proc_dir_name, acpi_device_bid(device->parent));
+
 	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
-	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
+               ACPI_VIDEO_DEVICE_NAME, proc_dir_name,
 	       video->flags.multihead ? "yes" : "no",
 	       video->flags.rom ? "yes" : "no",
 	       video->flags.post ? "yes" : "no");
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7a43020..effcb23 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1644,5 +1644,14 @@ if SYSFS
 	source "drivers/video/backlight/Kconfig"
 endif
 
+
+config VIDEO_OUTPUT_CONTROL
+	tristate "Video Output Switcher control"
+	depends on SYSFS
+	---help---
+	  The output sysfs class driver is to provide video output abstract
+	  layer that can be used to hook platform specific driver methods
+	  to enable/disable display output device through common sysfs
+	  interface.	  
 endmenu
 
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index a6980e9..0f82eed 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -108,3 +108,4 @@ obj-$(CONFIG_FB_OF)               += off
 
 # the test framebuffer is last
 obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
+obj-$(CONFIG_VIDEO_OUTPUT_CONTROL) += output.o
