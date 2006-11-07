Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965470AbWKGQwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965470AbWKGQwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965357AbWKGQwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:52:01 -0500
Received: from nz-out-0102.google.com ([64.233.162.197]:47111 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965468AbWKGQvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:51:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L7jp/+jHJpoD/rYNeL69SKN3uY7PPdW3M5UyeZWrUVAbr5zXiVufiHHwSJZSVOZXx/XnvwZF4b9YXodb1+84o2r6C1RraFXmYSYH2rliP5gW060tx0XSCUYhmQ2vBA9EZXOf/tSFzd6SoIj7n2B0gA6jZ8jsYFFdN2MOV7SXbSw=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Andrew Morton <akpm@osdl.org>
Subject: [patch 3/5] backlight and output sysfs support for acpi video driver
Date: Wed, 8 Nov 2006 00:50:50 +0800
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
Message-Id: <200611080050.51103.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 3/5: 
1. Adds backlight and output sysfs support for acpi video driver.
2. several minor coding style fixes and cleanup.

signed-off-by: Luming Yu <Luming.yu@intel.com>
--
 acpi/Kconfig   |    2
 acpi/video.c   |  323 +++++++++++++++++++++++++++++++++++++++++++++------------
 video/Kconfig  |    9 +
 video/Makefile |    1
 4 files changed, 266 insertions(+), 69 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 3f7e9f3..1ffbf30 100644
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
index 53a9eb0..bafaa7a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -30,6 +30,9 @@ #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/pci.h>
+#include <linux/backlight.h>
+#include <linux/video_output.h>
 
 #include <asm/uaccess.h>
 
@@ -55,11 +58,17 @@ #define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0
 
 #define ACPI_VIDEO_HEAD_INVALID		(~0u - 1)
 #define ACPI_VIDEO_HEAD_END		(~0u)
+#define DEBUG 0
+#if DEBUG
+#define dprintk(fmt,args...) printk(fmt,args)
+#else
+#define dprintk(fmt,args...)
+#endif
 
 #define _COMPONENT		ACPI_VIDEO_COMPONENT
 ACPI_MODULE_NAME("acpi_video")
 
-    MODULE_AUTHOR("Bruno Ducrot");
+MODULE_AUTHOR("Bruno Ducrot");
 MODULE_DESCRIPTION(ACPI_VIDEO_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
@@ -141,11 +150,11 @@ struct acpi_video_device_cap {
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
@@ -162,6 +171,7 @@ struct acpi_video_device {
 	struct acpi_video_bus *video;
 	struct acpi_device *dev;
 	struct acpi_video_device_brightness *brightness;
+	struct output_device *output_dev;
 };
 
 /* bus */
@@ -250,16 +260,71 @@ static char device_decode[][30] = {
 	"UNKNOWN",
 };
 
-static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data);
+static void acpi_video_device_notify(acpi_handle handle, u32 event,void *data);
 static void acpi_video_device_rebind(struct acpi_video_bus *video);
 static void acpi_video_device_bind(struct acpi_video_bus *video,
-				   struct acpi_video_device *device);
+		struct acpi_video_device *device);
 static int acpi_video_device_enumerate(struct acpi_video_bus *video);
-static int acpi_video_switch_output(struct acpi_video_bus *video, int event);
+static int acpi_video_switch_output(struct acpi_video_bus *video,int event);
 static int acpi_video_get_next_level(struct acpi_video_device *device,
-				     u32 level_current, u32 event);
+		u32 level_current,u32 event);
 static void acpi_video_switch_brightness(struct acpi_video_device *device,
-					 int event);
+		int event);
+static int acpi_video_device_lcd_set_level(struct acpi_video_device *,int);
+static int acpi_video_device_lcd_get_level_current(struct acpi_video_device *,
+		unsigned long *);
+/*backlight device sysfs support*/
+static int acpi_video_get_brightness(struct backlight_device *bd);
+static int acpi_video_set_brightness(struct backlight_device *bd);
+static int acpi_video_output_get(struct output_device *);
+static int acpi_video_output_set(struct output_device *);
+static int acpi_video_device_get_state(struct acpi_video_device *,
+		unsigned long *);
+static int acpi_video_device_set_state(struct acpi_video_device *,int);
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
+	acpi_video_device_lcd_get_level_current(backlight_acpi_device,
+		&cur_level);
+	return (int) cur_level;
+}
+
+static int acpi_video_set_brightness(struct backlight_device *bd)
+{
+	int request_level = bd->props->brightness;
+	acpi_video_device_lcd_set_level(backlight_acpi_device,request_level);
+	return 0;
+}
+
+static int acpi_video_output_get(struct output_device *od)
+{
+	unsigned long state;
+	struct acpi_video_device *vd =
+		(struct acpi_video_device *)class_get_devdata(&od->class_dev);
+	acpi_video_device_get_state(vd,&state);
+	return (int)state;
+}
+
+static int acpi_video_output_set(struct output_device *od)
+{
+	unsigned long state = od->request_state;
+	struct acpi_video_device *vd =
+		(struct acpi_video_device *)class_get_devdata(&od->class_dev);
+	return acpi_video_device_set_state(vd,state);
+}
 
 /* --------------------------------------------------------------------------
                                Video Management
@@ -268,39 +333,27 @@ static void acpi_video_switch_brightness
 /* device */
 
 static int
-acpi_video_device_query(struct acpi_video_device *device, unsigned long *state)
+acpi_video_device_query(struct acpi_video_device *device,unsigned long *state)
 {
-	int status;
-
-	status = acpi_evaluate_integer(device->dev->handle, "_DGS", NULL, state);
-
-	return status;
+	return acpi_evaluate_integer(device->dev->handle,"_DGS",NULL,state);
 }
 
 static int
 acpi_video_device_get_state(struct acpi_video_device *device,
 			    unsigned long *state)
 {
-	int status;
-
-	status = acpi_evaluate_integer(device->dev->handle, "_DCS", NULL, state);
-
-	return status;
+	return acpi_evaluate_integer(device->dev->handle,"_DCS",NULL,state);
 }
 
 static int
 acpi_video_device_set_state(struct acpi_video_device *device, int state)
 {
-	int status;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
 	unsigned long ret;
 
-
 	arg0.integer.value = state;
-	status = acpi_evaluate_integer(device->dev->handle, "_DSS", &args, &ret);
-
-	return status;
+	return acpi_evaluate_integer(device->dev->handle,"_DSS",&args,&ret);
 }
 
 static int
@@ -311,10 +364,8 @@ acpi_video_device_lcd_query_levels(struc
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
 
-
 	*levels = NULL;
-
-	status = acpi_evaluate_object(device->dev->handle, "_BCL", NULL, &buffer);
+	status = acpi_evaluate_object(device->dev->handle,"_BCL",NULL,&buffer);
 	if (!ACPI_SUCCESS(status))
 		return status;
 	obj = (union acpi_object *)buffer.pointer;
@@ -323,29 +374,23 @@ acpi_video_device_lcd_query_levels(struc
 		status = -EFAULT;
 		goto err;
 	}
-
 	*levels = obj;
-
 	return 0;
-
       err:
 	kfree(buffer.pointer);
-
 	return status;
 }
 
 static int
-acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
+acpi_video_device_lcd_set_level(struct acpi_video_device *device,int level)
 {
 	int status;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list args = { 1, &arg0 };
-
+	struct acpi_object_list args = { 1,&arg0 };
 
 	arg0.integer.value = level;
-	status = acpi_evaluate_object(device->dev->handle, "_BCM", &args, NULL);
-
-	printk(KERN_DEBUG "set_level status: %x\n", status);
+	status = acpi_evaluate_object(device->dev->handle,"_BCM",&args,NULL);
+	dprintk(KERN_DEBUG PREFIX "set_level status: %x\n",status);
 	return status;
 }
 
@@ -353,11 +398,7 @@ static int
 acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 					unsigned long *level)
 {
-	int status;
-
-	status = acpi_evaluate_integer(device->dev->handle, "_BQC", NULL, level);
-
-	return status;
+	return acpi_evaluate_integer(device->dev->handle,"_BQC",NULL,level);
 }
 
 static int
@@ -482,6 +523,129 @@ acpi_video_bus_DOS(struct acpi_video_bus
 	return status;
 }
 
+
+/*
+ * cut&paste code for acpi_pci_data,acpi_pci_data_handler,acpi_pci_data
+ * from pci_bind.c
+ * To-do: write a new API: acpi_pci_get.
+ */
+struct acpi_pci_data {
+	struct acpi_pci_id id;
+	struct pci_bus *bus;
+	struct pci_dev *dev;
+};
+static void acpi_pci_data_handler(acpi_handle handle, u32 function,
+	void *context)
+{
+	/* TBD: Anything we need to do here? */
+	return;
+}
+
+static struct acpi_pci_data * acpi_pci_get (struct acpi_device *device)
+{
+	acpi_status status = AE_OK;
+	struct acpi_pci_data *data = NULL;
+	struct acpi_pci_data *pdata = NULL;
+	char *pathname = NULL;
+	struct acpi_buffer buffer = { 0,NULL };
+	struct pci_dev *dev;
+	struct pci_bus *bus;
+	struct acpi_device *tmp_dev = NULL;
+
+	if (!device || !device->parent)
+		return NULL;
+
+	pathname = kzalloc(ACPI_PATHNAME_MAX,GFP_KERNEL);
+	if (!pathname)
+		return NULL;
+	buffer.length = ACPI_PATHNAME_MAX;
+	buffer.pointer = pathname;
+
+	data = kzalloc(sizeof(struct acpi_pci_data),GFP_KERNEL);
+	if (!data) {
+		kfree(pathname);
+		return NULL;
+	}
+	acpi_get_name(device->handle,ACPI_FULL_PATHNAME,&buffer);
+	printk(KERN_INFO PREFIX "finding PCI device [%s]...\n",pathname);
+	/*
+	 * Segment & Bus
+	 * -------------
+	 * These are obtained via the parent device's ACPI-PCI context.
+	 */
+	do {
+		status = acpi_get_data(device->parent->handle,
+				acpi_pci_data_handler,
+				(void **)&pdata);
+		if (ACPI_FAILURE(status) || !pdata || !pdata->bus) {
+			tmp_dev = device->parent;
+			if (tmp_dev->parent &&
+				(tmp_dev->parent->handle != ACPI_ROOT_OBJECT))
+				device = tmp_dev;
+			else {
+				ACPI_EXCEPTION((AE_INFO, status,
+				"Invalid ACPI-PCI context for parent device %s",
+				acpi_device_bid(device->parent)));
+				kfree(pathname);
+				kfree(data);
+				return NULL;
+			}
+		}
+	} while (tmp_dev); 
+
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
+		data->id.segment,data->id.bus, data->id.device,
+		data->id.function);
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
+					data->id.function)) {
+				data->dev = dev;
+				break;
+			}
+		}
+	}
+	dprintk(KERN_INFO PREFIX "data->dev =%p", &data->dev);
+	dprintk(KERN_INFO PREFIX "data->dev->dev =%p\n", &data->dev->dev);
+	kfree(pathname);
+	if (!data->dev) {
+		printk(KERN_ERR PREFIX 
+		"Device %02x:%02x:%02x.%02x not present in PCI namespace\n",
+		data->id.segment, data->id.bus,
+		data->id.device, data->id.function);
+		kfree(data);
+		return NULL;
+	}
+	return data;
+}
+
 /*
  *  Arg:	
  *  	device	: video output device (LCD, CRT, ..)
@@ -498,35 +662,36 @@ static void acpi_video_device_find_cap(s
 	acpi_integer status;
 	acpi_handle h_dummy1;
 	int i;
+	u32 max_level = 0;
 	union acpi_object *obj = NULL;
 	struct acpi_video_device_brightness *br = NULL;
+	struct acpi_pci_data *data;
 
-
+	data = acpi_pci_get (device->video->device);
+	if (!data || !(data->dev)) {
+		printk(KERN_ERR PREFIX
+		"acpi_video_device:no valid data from acpi_pci_get\n");
+		return;
+	}
 	memset(&device->cap, 0, 4);
-
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_ADR", &h_dummy1))) {
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_ADR",&h_dummy1)))
 		device->cap._ADR = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BCL", &h_dummy1))) {
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BCL",&h_dummy1)))
 		device->cap._BCL = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BCM", &h_dummy1))) {
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BCM",&h_dummy1)))
 		device->cap._BCM = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DDC", &h_dummy1))) {
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BQC",&h_dummy1)))
+		device->cap._BQC = 1;
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_DDC",&h_dummy1)))
 		device->cap._DDC = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DCS", &h_dummy1))) {
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_DCS",&h_dummy1)))
 		device->cap._DCS = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DGS", &h_dummy1))) {
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_DGS",&h_dummy1)))
 		device->cap._DGS = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DSS", &h_dummy1))) {
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_DSS",&h_dummy1)))
 		device->cap._DSS = 1;
-	}
 
-	status = acpi_video_device_lcd_query_levels(device, &obj);
+	status = acpi_video_device_lcd_query_levels(device,&obj);
 
 	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count >= 2) {
 		int count = 0;
@@ -534,11 +699,11 @@ static void acpi_video_device_find_cap(s
 
 		br = kmalloc(sizeof(*br), GFP_KERNEL);
 		if (!br) {
-			printk(KERN_ERR "can't allocate memory\n");
+			printk(KERN_ERR PREFIX "can't allocate memory\n");
 		} else {
 			memset(br, 0, sizeof(*br));
 			br->levels = kmalloc(obj->package.count *
-					     sizeof *(br->levels), GFP_KERNEL);
+				sizeof *(br->levels), GFP_KERNEL);
 			if (!br->levels)
 				goto out;
 
@@ -546,10 +711,12 @@ static void acpi_video_device_find_cap(s
 				o = (union acpi_object *)&obj->package.
 				    elements[i];
 				if (o->type != ACPI_TYPE_INTEGER) {
-					printk(KERN_ERR PREFIX "Invalid data\n");
+				printk(KERN_ERR PREFIX "Invalid data\n");
 					continue;
 				}
 				br->levels[count] = (u32) o->integer.value;
+				if (br->levels[count] > max_level)
+					max_level = br->levels[count];
 				count++;
 			}
 		      out:
@@ -560,14 +727,34 @@ static void acpi_video_device_find_cap(s
 				br->count = count;
 				device->brightness = br;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "found %d brightness levels\n",
-						  count));
+					"found %d brightness levels\n",
+					 count));
 			}
 		}
 	}
 
 	kfree(obj);
 
+	if (device->cap._BCL && device->cap._BCM && device->cap._BQC){
+		unsigned long tmp;
+		acpi_video_data.max_brightness = max_level;
+		acpi_video_device_lcd_get_level_current(device, &tmp);
+		acpi_video_data.brightness = tmp;
+		acpi_video_backlight = backlight_device_register("acpi-video",
+			&(data->dev->dev),NULL,&acpi_video_data);
+		backlight_acpi_device = device;
+	}
+
+	if (device->cap._DCS && device->cap._DSS){
+		char name[16];
+		memset(name,0,16);
+		strcat(name,acpi_device_bid(device->dev->parent));
+		strcat(name,"_");
+		strcpy(name,acpi_device_bid(device->dev));
+		device->output_dev = video_output_register(name,
+					&(data->dev->dev),
+					device,&acpi_output_properties);
+	}
 	return;
 }
 
@@ -1007,7 +1194,6 @@ static int acpi_video_bus_POST_info_seq_
 			printk(KERN_WARNING PREFIX
 			       "This indicate a BIOS bug.  Please contact the manufacturer.\n");
 		}
-		printk("%lx\n", options);
 		seq_printf(seq, "can POST: <intgrated video>");
 		if (options & 2)
 			seq_printf(seq, " <PCI video>");
@@ -1264,7 +1450,6 @@ acpi_video_bus_get_one_device(struct acp
 			return -ENOMEM;
 
 		memset(data, 0, sizeof(struct acpi_video_device));
-
 		strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
 		strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
 		acpi_driver_data(device) = data;
@@ -1564,6 +1749,10 @@ static int acpi_video_bus_put_one_device
 	status = acpi_remove_notify_handler(device->dev->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
+	if (device == backlight_acpi_device)
+		backlight_device_unregister(acpi_video_backlight);
+
+	video_output_unregister(device->output_dev);
 
 	return 0;
 }
@@ -1611,7 +1800,7 @@ static void acpi_video_bus_notify(acpi_h
 	struct acpi_video_bus *video = data;
 	struct acpi_device *device = NULL;
 
-	printk("video bus notify\n");
+	printk(KERN_INFO PREFIX "video bus notify\n");
 
 	if (!video)
 		return;
@@ -1653,8 +1842,6 @@ static void acpi_video_device_notify(acp
 	struct acpi_video_device *video_device = data;
 	struct acpi_device *device = NULL;
 
-
-	printk("video device notify\n");
 	if (!video_device)
 		return;
 
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
