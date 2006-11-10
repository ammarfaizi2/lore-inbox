Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946575AbWKJSnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946575AbWKJSnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 13:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946725AbWKJSnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 13:43:06 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:32641 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1946575AbWKJSnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 13:43:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=U68Kn1JqFksCsPxHHmCGn6IiAoeVsISQvoqtPocXSjBckEEuAG5zQu1RcZe8SPKW9YkkdokEGGEf5S2dcilZSPM8VDqb4GLQEIZNn6pTrsn5XMV2ANOcnP53/3MRnYK8hFvtKq3P4qajQTDD4ZAPWqJWlZUTzaWumr0XnhcyQBI=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch] Adds backlight sysfs support for acpi video driver.
Date: Sat, 11 Nov 2006 02:40:34 +0800
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
Message-Id: <200611110240.34715.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds backlight sysfs support for acpi video driver.

signed-off-by: Luming Yu <Luming.yu@intel.com>
--
 Kconfig |    2 -
 video.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 3f7e9f3..196cb0a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -106,7 +106,7 @@ config ACPI_BUTTON
 
 config ACPI_VIDEO
 	tristate "Video"
-	depends on X86
+	depends on X86 && BACKLIGHT_CLASS_DEVICE
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 53a9eb0..c83dd57 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -31,6 +31,7 @@ #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
+#include <linux/backlight.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
@@ -55,6 +56,7 @@ #define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0
 
 #define ACPI_VIDEO_HEAD_INVALID		(~0u - 1)
 #define ACPI_VIDEO_HEAD_END		(~0u)
+#define MAX_NAME_LEN	20
 
 #define _COMPONENT		ACPI_VIDEO_COMPONENT
 ACPI_MODULE_NAME("acpi_video")
@@ -141,11 +143,11 @@ struct acpi_video_device_cap {
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
@@ -162,6 +164,8 @@ struct acpi_video_device {
 	struct acpi_video_bus *video;
 	struct acpi_device *dev;
 	struct acpi_video_device_brightness *brightness;
+	struct backlight_device *backlight;
+	struct backlight_properties *data;
 };
 
 /* bus */
@@ -256,11 +260,35 @@ static void acpi_video_device_bind(struc
 				   struct acpi_video_device *device);
 static int acpi_video_device_enumerate(struct acpi_video_bus *video);
 static int acpi_video_switch_output(struct acpi_video_bus *video, int event);
+static int acpi_video_device_lcd_set_level(struct acpi_video_device *device,
+			int level);
+static int acpi_video_device_lcd_get_level_current(
+			struct acpi_video_device *device,
+			unsigned long *level);
 static int acpi_video_get_next_level(struct acpi_video_device *device,
 				     u32 level_current, u32 event);
 static void acpi_video_switch_brightness(struct acpi_video_device *device,
 					 int event);
 
+/*backlight device sysfs support*/
+static int acpi_video_get_brightness(struct backlight_device *bd)
+{
+	unsigned long cur_level;
+	struct acpi_video_device *vd =
+		(struct acpi_video_device *)class_get_devdata(&bd->class_dev);
+	acpi_video_device_lcd_get_level_current(vd, &cur_level);
+	return (int) cur_level;
+}
+
+static int acpi_video_set_brightness(struct backlight_device *bd)
+{
+	int request_level = bd->props->brightness;
+	struct acpi_video_device *vd =
+		(struct acpi_video_device *)class_get_devdata(&bd->class_dev);
+	acpi_video_device_lcd_set_level(vd, request_level);
+	return 0;
+}
+
 /* --------------------------------------------------------------------------
                                Video Management
    -------------------------------------------------------------------------- */
@@ -498,6 +526,7 @@ static void acpi_video_device_find_cap(s
 	acpi_integer status;
 	acpi_handle h_dummy1;
 	int i;
+	u32 max_level = 0;
 	union acpi_object *obj = NULL;
 	struct acpi_video_device_brightness *br = NULL;
 
@@ -513,6 +542,8 @@ static void acpi_video_device_find_cap(s
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BCM", &h_dummy1))) {
 		device->cap._BCM = 1;
 	}
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BQC",&h_dummy1)))
+		device->cap._BQC = 1;
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DDC", &h_dummy1))) {
 		device->cap._DDC = 1;
 	}
@@ -550,6 +581,8 @@ static void acpi_video_device_find_cap(s
 					continue;
 				}
 				br->levels[count] = (u32) o->integer.value;
+				if (br->levels[count] > max_level)
+					max_level = br->levels[count];
 				count++;
 			}
 		      out:
@@ -568,6 +601,37 @@ static void acpi_video_device_find_cap(s
 
 	kfree(obj);
 
+	if (device->cap._BCL && device->cap._BCM && device->cap._BQC){
+		unsigned long tmp;
+		static int count = 0;
+		char *name;
+		struct backlight_properties *acpi_video_data;
+
+		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
+		if (!name)
+			return;
+
+		acpi_video_data = kzalloc(
+			sizeof(struct backlight_properties),
+			GFP_KERNEL);
+		if (!acpi_video_data){
+			kfree(name);
+			return;
+		}
+		acpi_video_data->owner = THIS_MODULE;
+		acpi_video_data->get_brightness =
+			acpi_video_get_brightness;
+		acpi_video_data->update_status =
+			acpi_video_set_brightness;
+		sprintf(name, "acpi_video%d", count++);
+		device->data = acpi_video_data;
+		acpi_video_data->max_brightness = max_level;
+		acpi_video_device_lcd_get_level_current(device, &tmp);
+		acpi_video_data->brightness = (int)tmp;
+		device->backlight = backlight_device_register(name,
+			NULL, device, acpi_video_data);
+		kfree(name);
+	}
 	return;
 }
 
@@ -1564,7 +1628,10 @@ static int acpi_video_bus_put_one_device
 	status = acpi_remove_notify_handler(device->dev->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
-
+	if (device->backlight){
+		backlight_device_unregister(device->backlight);
+		kfree(device->data);
+	}
 	return 0;
 }
 
