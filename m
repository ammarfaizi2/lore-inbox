Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVAHHHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVAHHHn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVAHHE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:04:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:10118 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261918AbVAHFsn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:43 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632643263@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:44 -0800
Message-Id: <1105163264681@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.5, 2004/12/15 14:25:46-08:00, luca.risolia@studio.unibo.it

[PATCH] USB: SN9C10x driver updates

SN9C10x driver updates.

Changes: + new, - removed, * cleanup, @ bugfix, = sync with kernels

* SN9C10x system clock fine-tuning when switching from native to compressed
  format and viceversa for each image sensor
+ Add sn9c102_i2c_try_raw_read()
+ Frame header available from sysfs interface
+ Documentation updates: new "Video frame formats" paragraph, new entries in
  "Credits" and frame header description
+ Plugin's for HV7131D and MI-0343 image sensors

Signed-off-by: Luca Risolia <luca.risolia@studio.unibo.it>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/usb/sn9c102.txt          |  202 ++++++++++++++----
 drivers/usb/media/Makefile             |    2 
 drivers/usb/media/sn9c102.h            |   13 -
 drivers/usb/media/sn9c102_core.c       |  115 +++++++---
 drivers/usb/media/sn9c102_hv7131d.c    |  271 ++++++++++++++++++++++++
 drivers/usb/media/sn9c102_mi0343.c     |  363 +++++++++++++++++++++++++++++++++
 drivers/usb/media/sn9c102_pas106b.c    |   45 +---
 drivers/usb/media/sn9c102_pas202bcb.c  |   49 +---
 drivers/usb/media/sn9c102_sensor.h     |   62 ++++-
 drivers/usb/media/sn9c102_tas5110c1b.c |   22 +-
 drivers/usb/media/sn9c102_tas5130d1b.c |   22 +-
 11 files changed, 1004 insertions(+), 162 deletions(-)


diff -Nru a/Documentation/usb/sn9c102.txt b/Documentation/usb/sn9c102.txt
--- a/Documentation/usb/sn9c102.txt	2005-01-07 15:50:54 -08:00
+++ b/Documentation/usb/sn9c102.txt	2005-01-07 15:50:54 -08:00
@@ -11,16 +11,17 @@
 1.  Copyright
 2.  Disclaimer
 3.  License
-4.  Overview
-5.  Driver installation
+4.  Overview and features
+5.  Module dependencies
 6.  Module loading
 7.  Module parameters
 8.  Optional device control through "sysfs"
 9.  Supported devices
-10. How to add support for new image sensors
+10. How to add plug-in's for new image sensors
 11. Notes for V4L2 application developers
-12. Contact information
-13. Credits
+12. Video frame formats
+13. Contact information
+14. Credits
 
 
 1. Copyright
@@ -51,16 +52,18 @@
 Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
 
-4. Overview
-===========
+4. Overview and features
+========================
 This driver attempts to support the video and audio streaming capabilities of
-the devices mounting the SONiX SN9C101, SN9C102 and SN9C103 (or SUI-102) PC
-Camera Controllers.
+the devices mounting the SONiX SN9C101, SN9C102 and SN9C103 PC Camera
+Controllers.
 
 It's worth to note that SONiX has never collaborated with the author during the
 development of this project, despite several requests for enough detailed
 specifications of the register tables, compression engine and video data format
-of the above chips.
+of the above chips. Nevertheless, these informations are no longer necessary,
+becouse all the aspects related to these chips are known and have been
+described in detail in this documentation.
 
 The driver relies on the Video4Linux2 and USB core modules. It has been
 designed to run properly on SMP systems as well.
@@ -79,15 +82,16 @@
   pixel area of image sensor;
 - image downscaling with arbitrary scaling factors from 1, 2 and 4 in both
   directions (see "Notes for V4L2 application developers" paragraph);
-- two different video formats for uncompressed or compressed data (see also
-  "Notes for V4L2 application developers" paragraph);
+- two different video formats for uncompressed or compressed data in low or
+  high compression quality (see also "Notes for V4L2 application developers"
+  and "Video frame formats" paragraphs);
 - full support for the capabilities of many of the possible image sensors that
   can be connected to the SN9C10x bridges, including, for istance, red, green,
   blue and global gain adjustments and exposure (see "Supported devices"
   paragraph for details);
 - use of default color settings for sunlight conditions;
-- dynamic I/O interface for both SN9C10x and image sensor control (see
-  "Optional device control through 'sysfs'" paragraph);
+- dynamic I/O interface for both SN9C10x and image sensor control and
+  monitoring (see "Optional device control through 'sysfs'" paragraph);
 - dynamic driver control thanks to various module parameters (see "Module
   parameters" paragraph);
 - up to 64 cameras can be handled at the same time; they can be connected and
@@ -177,7 +181,7 @@
 -------------------------------------------------------------------------------
 
 
-8. Optional device control through "sysfs"
+8. Optional device control through "sysfs" [1]
 ==========================================
 It is possible to read and write both the SN9C10x and the image sensor
 registers by using the "sysfs" filesystem interface.
@@ -195,9 +199,9 @@
 SN9C10x bridge, while the other two control the sensor chip. "reg" and
 "i2c_reg" hold the values of the current register index where the following
 reading/writing operations are addressed at through "val" and "i2c_val". Their
-use is not intended for end-users, unless you know what you are doing. Note
-that "i2c_reg" and "i2c_val" won't be created if the sensor does not actually
-support the standard I2C protocol. Also, remember that you must be logged in as
+use is not intended for end-users. Note that "i2c_reg" and "i2c_val" won't be
+created if the sensor does not actually support the standard I2C protocol or
+its registers are not 8-bit long. Also, remember that you must be logged in as
 root before writing to them.
 
 As an example, suppose we were to want to read the value contained in the
@@ -216,7 +220,48 @@
 	[root@localhost #] echo 2 > val
 
 Note that the SN9C10x always returns 0 when some of its registers are read.
-To avoid race conditions, all the I/O accesses to the files are serialized.
+To avoid race conditions, all the I/O accesses to the above files are
+serialized.
+
+The sysfs interface also provides the "frame_header" entry, which exports the
+frame header of the most recent requested and captured video frame. The header
+is 12-bytes long and is appended to every video frame by the SN9C10x
+controllers. As an example, this additional information can be used by the user
+application for implementing auto-exposure features via software. 
+
+The following table describes the frame header:
+
+Byte #  Value         Description
+------  -----         -----------
+0x00    0xFF          Frame synchronisation pattern.
+0x01    0xFF          Frame synchronisation pattern.
+0x02    0x00          Frame synchronisation pattern.
+0x03    0xC4          Frame synchronisation pattern.
+0x04    0xC4          Frame synchronisation pattern.
+0x05    0x96          Frame synchronisation pattern.
+0x06    0x00 or 0x01  Unknown meaning. The exact value depends on the chip.
+0x07    0xXX          Variable value, whose bits are ff00uzzc, where ff is a
+                      frame counter, u is unknown, zz is a size indicator
+                      (00 = VGA, 01 = SIF, 10 = QSIF) and c stands for
+                      "compression enabled" (1 = yes, 0 = no).
+0x08    0xXX          Brightness sum inside Auto-Exposure area (low-byte).
+0x09    0xXX          Brightness sum inside Auto-Exposure area (high-byte).
+                      For a pure white image, this number will be equal to 500
+                      times the area of the specified AE area. For images
+                      that are not pure white, the value scales down according
+                      to relative whiteness.
+0x0A    0xXX          Brightness sum outside Auto-Exposure area (low-byte).
+0x0B    0xXX          Brightness sum outside Auto-Exposure area (high-byte).
+                      For a pure white image, this number will be equal to 125
+                      times the area outside of the specified AE area. For
+                      images that are not pure white, the value scales down
+                      according to relative whiteness.
+
+The AE area (sx, sy, ex, ey) in the active window can be set by programming the
+registers 0x1c, 0x1d, 0x1e and 0x1f of the SN9C10x controllers, where one unit
+corresponds to 32 pixels.
+
+[1] The frame header has been documented by Bertrik Sikken.
 
 
 9. Supported devices
@@ -275,8 +320,10 @@
 
 Model       Manufacturer
 -----       ------------
-PAS106B     PixArt Imaging Inc.
-PAS202BCB   PixArt Imaging Inc.
+HV7131D     Hynix Semiconductor, Inc.
+MI-0343     Micron Technology, Inc.
+PAS106B     PixArt Imaging, Inc.
+PAS202BCB   PixArt Imaging, Inc.
 TAS5110C1B  Taiwan Advanced Sensor Corporation
 TAS5130D1B  Taiwan Advanced Sensor Corporation
 
@@ -295,15 +342,15 @@
 driver.
 
 
-10. How to add support for new image sensors
-============================================
-It should be easy to write code for new sensors by using the small API that I
-have created for this purpose, which is present in "sn9c102_sensor.h"
+10. How to add plug-in's for new image sensors
+==============================================
+It should be easy to write plug-in's for new sensors by using the small API
+that has been created for this purpose, which is present in "sn9c102_sensor.h"
 (documentation is included there). As an example, have a look at the code in
 "sn9c102_pas106b.c", which uses the mentioned interface.
 
-At the moment, possible unsupported image sensors are: HV7131x series (VGA),
-MI03x series (VGA), OV7620 (VGA), OV7630 (VGA), CIS-VF10 (VGA).
+At the moment, possible unsupported image sensors are: CIS-VF10 (VGA),
+OV7620 (VGA), OV7630 (VGA).
 
 
 11. Notes for V4L2 application developers
@@ -332,29 +379,98 @@
 This driver supports two different video formats: the first one is the "8-bit
 Sequential Bayer" format and can be used to obtain uncompressed video data
 from the device through the current I/O method, while the second one provides
-"raw" compressed video data (without the initial and final frame headers). The
-compression quality may vary from 0 to 1 and can be selected or queried thanks
-to the VIDIOC_S_JPEGCOMP and VIDIOC_G_JPEGCOMP V4L2 ioctl's. For maximum
-flexibility, the default active video format depends on how the image sensor
-being used is initialized (as described in the documentation of the API for the
-image sensors supplied by this driver).
+"raw" compressed video data (without frame headers not related to the
+compressed data). The compression quality may vary from 0 to 1 and can be
+selected or queried thanks to the VIDIOC_S_JPEGCOMP and VIDIOC_G_JPEGCOMP V4L2
+ioctl's. For maximum flexibility, both the default active video format and the
+default compression quality depend on how the image sensor being used is
+initialized (as described in the documentation of the API for the image sensors
+supplied by this driver).
 
 
-12. Contact information
+12. Video frame formats [1]
 =======================
-I may be contacted by e-mail at <luca.risolia@studio.unibo.it>.
+The SN9C10x PC Camera Controllers can send images in two possible video
+formats over the USB: either native "Sequential RGB Bayer" or Huffman
+compressed. The latter is used to achieve high frame rates. The current video
+format may be selected or queried from the user application by calling the
+VIDIOC_S_FMT or VIDIOC_G_FMT ioctl's, as described in the V4L2 API
+specifications.
+
+The name "Sequential Bayer" indicates the organization of the red, green and
+blue pixels in one video frame. Each pixel is associated with a 8-bit long
+value and is disposed in memory according to the pattern shown below:
+
+B[0]   G[1]    B[2]    G[3]    ...   B[m-2]         G[m-1]
+G[m]   R[m+1]  G[m+2]  R[m+2]  ...   G[2m-2]        R[2m-1] 
+...
+...                                  B[(n-1)(m-2)]  G[(n-1)(m-1)]
+...                                  G[n(m-2)]      R[n(m-1)]
+
+The above matrix also represents the sequential or progressive read-out mode of
+the (n, m) Bayer color filter array used in many CCD/CMOS image sensors.
+
+One compressed video frame consists of a bitstream that encodes for every R, G,
+or B pixel the difference between the value of the pixel itself and some
+reference pixel value. Pixels are organised in the Bayer pattern and the Bayer
+sub-pixels are tracked individually and alternatingly. For example, in the
+first line values for the B and G1 pixels are alternatingly encoded, while in
+the second line values for the G2 and R pixels are alternatingly encoded.
+
+The pixel reference value is calculated as follows:
+- the 4 top left pixels are encoded in raw uncompressed 8-bit format;
+- the value in the top two rows is the value of the pixel left of the current
+  pixel;
+- the value in the left column is the value of the pixel above the current
+  pixel;
+- for all other pixels, the reference value is the average of the value of the
+  pixel on the left and the value of the pixel above the current pixel;
+- there is one code in the bitstream that specifies the value of a pixel
+  directly (in 4-bit resolution);
+- pixel values need to be clamped inside the range [0..255] for proper
+  decoding.
+
+The algorithm purely describes the conversion from compressed Bayer code used
+in the SN9C10x chips to uncompressed Bayer. Additional steps are required to
+convert this to a color image (i.e. a color interpolation algorithm).
+ 
+The following Huffman codes have been found:
+0: +0 (relative to reference pixel value) 
+100: +4
+101: -4?
+1110xxxx: set absolute value to xxxx.0000 
+1101: +11
+1111: -11
+11001: +20
+110000: -20
+110001: ??? - these codes are apparently not used
 
-I can accept GPG/PGP encrypted e-mail. My GPG key ID is 'FCE635A4'.
-My public 1024-bit key should be available at any keyserver; the fingerprint
-is: '88E8 F32F 7244 68BA 3958  5D40 99DA 5D2A FCE6 35A4'.
+[1] The Huffman compression algorithm has been reverse-engineered and
+    documented by Bertrik Sikken.
+
+
+13. Contact information
+=======================
+The author may be contacted by e-mail at <luca.risolia@studio.unibo.it>.
 
+GPG/PGP encrypted e-mail's are accepted. The GPG key ID of the author is
+'FCE635A4'; the public 1024-bit key should be available at any keyserver;
+the fingerprint is: '88E8 F32F 7244 68BA 3958  5D40 99DA 5D2A FCE6 35A4'.
 
-13. Credits
+
+14. Credits
 ===========
-I would thank the following persons:
+Many thanks to following persons for their contribute (listed in alphabetical
+order):
 
-- Stefano Mozzi, who donated 45 EU;
 - Luca Capello for the donation of a webcam;
-- Mizuno Takafumi for the donation of a webcam;
+- Joao Rodrigo Fuzaro, Joao Limirio, Claudio Filho and Caio Begotti for the
+  donation of a webcam;
 - Carlos Eduardo Medaglia Dyonisio, who added the support for the PAS202BCB
-  image sensor.
+  image sensor;
+- Stefano Mozzi, who donated 45 EU;
+- Bertrik Sikken, who reverse-engineered and documented the Huffman compression
+  algorithm used in the SN9C10x controllers and implemented the first decoder;
+- Mizuno Takafumi for the donation of a webcam;
+- An "anonymous" donator (who didn't want his name to be revealed) for the
+  donation of a webcam.
diff -Nru a/drivers/usb/media/Makefile b/drivers/usb/media/Makefile
--- a/drivers/usb/media/Makefile	2005-01-07 15:50:54 -08:00
+++ b/drivers/usb/media/Makefile	2005-01-07 15:50:54 -08:00
@@ -2,7 +2,7 @@
 # Makefile for USB Media drivers
 #
 
-sn9c102-objs	:= sn9c102_core.o sn9c102_pas106b.o sn9c102_tas5110c1b.o sn9c102_tas5130d1b.o sn9c102_pas202bcb.o
+sn9c102-objs	:= sn9c102_core.o sn9c102_hv7131d.o sn9c102_mi0343.o sn9c102_pas106b.o sn9c102_pas202bcb.o sn9c102_tas5110c1b.o sn9c102_tas5130d1b.o
 
 obj-$(CONFIG_USB_DABUSB)	+= dabusb.o
 obj-$(CONFIG_USB_DSBR)		+= dsbr100.o
diff -Nru a/drivers/usb/media/sn9c102.h b/drivers/usb/media/sn9c102.h
--- a/drivers/usb/media/sn9c102.h	2005-01-07 15:50:54 -08:00
+++ b/drivers/usb/media/sn9c102.h	2005-01-07 15:50:54 -08:00
@@ -46,8 +46,8 @@
 #define SN9C102_URBS              2
 #define SN9C102_ISO_PACKETS       7
 #define SN9C102_ALTERNATE_SETTING 8
-#define SN9C102_URB_TIMEOUT       msecs_to_jiffies(3)
-#define SN9C102_CTRL_TIMEOUT      msecs_to_jiffies(100)
+#define SN9C102_URB_TIMEOUT       msecs_to_jiffies(2 * SN9C102_ISO_PACKETS)
+#define SN9C102_CTRL_TIMEOUT      msecs_to_jiffies(300)
 
 /*****************************************************************************/
 
@@ -55,8 +55,8 @@
 #define SN9C102_MODULE_AUTHOR   "(C) 2004 Luca Risolia"
 #define SN9C102_AUTHOR_EMAIL    "<luca.risolia@studio.unibo.it>"
 #define SN9C102_MODULE_LICENSE  "GPL"
-#define SN9C102_MODULE_VERSION  "1:1.19"
-#define SN9C102_MODULE_VERSION_CODE  KERNEL_VERSION(1, 0, 19)
+#define SN9C102_MODULE_VERSION  "1:1.20"
+#define SN9C102_MODULE_VERSION_CODE  KERNEL_VERSION(1, 0, 20)
 
 enum sn9c102_bridge {
 	BRIDGE_SN9C101 = 0x01,
@@ -101,8 +101,12 @@
 	STREAM_ON,
 };
 
+typedef char sn9c102_sof_header_t[12];
+typedef char sn9c102_eof_header_t[4];
+
 struct sn9c102_sysfs_attr {
 	u8 reg, i2c_reg;
+	sn9c102_sof_header_t frame_header;
 };
 
 static DECLARE_MUTEX(sn9c102_sysfs_lock);
@@ -131,6 +135,7 @@
 	struct v4l2_jpegcompression compression;
 
 	struct sn9c102_sysfs_attr sysfs;
+	sn9c102_sof_header_t sof_header;
 	u16 reg[32];
 
 	enum sn9c102_dev_state state;
diff -Nru a/drivers/usb/media/sn9c102_core.c b/drivers/usb/media/sn9c102_core.c
--- a/drivers/usb/media/sn9c102_core.c	2005-01-07 15:50:54 -08:00
+++ b/drivers/usb/media/sn9c102_core.c	2005-01-07 15:50:54 -08:00
@@ -82,9 +82,6 @@
 
 /*****************************************************************************/
 
-typedef char sn9c102_sof_header_t[12];
-typedef char sn9c102_eof_header_t[4];
-
 static sn9c102_sof_header_t sn9c102_sof_header[] = {
 	{0xff, 0xff, 0x00, 0xc4, 0xc4, 0x96, 0x00},
 	{0xff, 0xff, 0x00, 0xc4, 0xc4, 0x96, 0x01},
@@ -277,9 +274,9 @@
 		if (r & 0x04)
 			return 0;
 		if (sensor->frequency & SN9C102_I2C_400KHZ)
-			udelay(5*8);
+			udelay(5*16);
 		else
-			udelay(16*8);
+			udelay(16*16);
 	}
 	return -EBUSY;
 }
@@ -306,18 +303,19 @@
 
 
 int 
-sn9c102_i2c_try_read(struct sn9c102_device* cam,
-                     struct sn9c102_sensor* sensor, u8 address)
+sn9c102_i2c_try_raw_read(struct sn9c102_device* cam,
+                         struct sn9c102_sensor* sensor, u8 data0, u8 data1,
+                         u8 n, u8 buffer[])
 {
 	struct usb_device* udev = cam->usbdev;
 	u8* data = cam->control_buffer;
 	int err = 0, res;
 
-	/* Write cycle - address */
+	/* Write cycle */
 	data[0] = ((sensor->interface == SN9C102_I2C_2WIRES) ? 0x80 : 0) |
 	          ((sensor->frequency & SN9C102_I2C_400KHZ) ? 0x01 : 0) | 0x10;
-	data[1] = sensor->slave_write_id;
-	data[2] = address;
+	data[1] = data0; /* I2C slave id */
+	data[2] = data1; /* address */
 	data[7] = 0x10;
 	res = usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0x08, 0x41,
 	                      0x08, 0, data, 8, SN9C102_CTRL_TIMEOUT);
@@ -326,11 +324,11 @@
 
 	err += sn9c102_i2c_wait(cam, sensor);
 
-	/* Read cycle - 1 byte */
+	/* Read cycle - n bytes */
 	data[0] = ((sensor->interface == SN9C102_I2C_2WIRES) ? 0x80 : 0) |
 	          ((sensor->frequency & SN9C102_I2C_400KHZ) ? 0x01 : 0) |
-	          0x10 | 0x02;
-	data[1] = sensor->slave_read_id;
+	          (n << 4) | 0x02;
+	data[1] = data0;
 	data[7] = 0x10;
 	res = usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0x08, 0x41,
 	                      0x08, 0, data, 8, SN9C102_CTRL_TIMEOUT);
@@ -339,7 +337,7 @@
 
 	err += sn9c102_i2c_wait(cam, sensor);
 
-	/* The read byte will be placed in data[4] */
+	/* The first read byte will be placed in data[4] */
 	res = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0), 0x00, 0xc1,
 	                      0x0a, 0, data, 5, SN9C102_CTRL_TIMEOUT);
 	if (res < 0)
@@ -347,12 +345,18 @@
 
 	err += sn9c102_i2c_detect_read_error(cam, sensor);
 
-	if (err)
+	PDBGG("I2C read: address 0x%02X, first read byte: 0x%02X", data1,
+	      data[4])
+
+	if (err) {
 		DBG(3, "I2C read failed for %s image sensor", sensor->name)
+		return -1;
+	}
 
-	PDBGG("I2C read: address 0x%02X, value: 0x%02X", address, data[4])
+	if (buffer)
+		memcpy(buffer, data, sizeof(buffer));
 
-	return err ? -1 : (int)data[4];
+	return (int)data[4];
 }
 
 
@@ -395,12 +399,21 @@
 }
 
 
+int
+sn9c102_i2c_try_read(struct sn9c102_device* cam,
+                     struct sn9c102_sensor* sensor, u8 address)
+{
+	return sn9c102_i2c_try_raw_read(cam, sensor, sensor->i2c_slave_id,
+	                                address, 1, NULL);
+}
+
+
 int 
 sn9c102_i2c_try_write(struct sn9c102_device* cam,
                       struct sn9c102_sensor* sensor, u8 address, u8 value)
 {
 	return sn9c102_i2c_try_raw_write(cam, sensor, 3, 
-	                                 sensor->slave_write_id, address,
+	                                 sensor->i2c_slave_id, address,
 	                                 value, 0, 0, 0);
 }
 
@@ -433,9 +446,11 @@
 	for (i = 0; (len >= soflen) && (i <= len - soflen); i++)
 		for (j = 0; j < n; j++)
 			/* It's enough to compare 7 bytes */
-			if (!memcmp(mem + i, sn9c102_sof_header[j], 7))
-				/* Skips the header */
+			if (!memcmp(mem + i, sn9c102_sof_header[j], 7)) {
+				memcpy(cam->sof_header, mem + i, soflen);
+				/* Skip the header */
 				return mem + i + soflen;
+			}
 
 	return NULL;
 }
@@ -563,6 +578,9 @@
 						(*f) = NULL;
 					spin_unlock_irqrestore(&cam->queue_lock
 					                       , lock_flags);
+					memcpy(cam->sysfs.frame_header,
+					       cam->sof_header,
+					       sizeof(sn9c102_sof_header_t));
 					DBG(3, "Video frame captured: "
 					       "%lu bytes", (unsigned long)(b))
 
@@ -746,15 +764,14 @@
 	                         (cam->stream == STREAM_OFF) ||
 	                         (cam->state & DEV_DISCONNECTED),
 	                         SN9C102_URB_TIMEOUT);
-	if (err) {
+	if (cam->state & DEV_DISCONNECTED)
+		return -ENODEV;
+	else if (err) {
 		cam->state |= DEV_MISCONFIGURED;
-		DBG(1, "The camera is misconfigured. To use "
-		       "it, close and open /dev/video%d "
-		       "again.", cam->v4ldev->minor)
+		DBG(1, "The camera is misconfigured. To use it, close and "
+		       "open /dev/video%d again.", cam->v4ldev->minor)
 		return err;
 	}
-	if (cam->state & DEV_DISCONNECTED)
-		return -ENODEV;
 
 	return 0;
 }
@@ -894,6 +911,11 @@
 		return -ENODEV;
 	}
 
+	if (!(cam->sensor->sysfs_ops & SN9C102_I2C_WRITE)) {
+		up(&sn9c102_sysfs_lock);
+		return -ENOSYS;
+	}
+
 	value = sn9c102_strtou8(buf, len, &count);
 	if (!count) {
 		up(&sn9c102_sysfs_lock);
@@ -937,7 +959,7 @@
 	up(&sn9c102_sysfs_lock);
 
 	return count;
-} 
+}
 
 
 static ssize_t 
@@ -988,7 +1010,7 @@
 		return -ENODEV;
 	}
 
-	if (cam->sensor->slave_read_id == SN9C102_I2C_SLAVEID_UNAVAILABLE) {
+	if (!(cam->sensor->sysfs_ops & SN9C102_I2C_READ)) {
 		up(&sn9c102_sysfs_lock);
 		return -ENOSYS;
 	}
@@ -1129,6 +1151,24 @@
 }
 
 
+static ssize_t sn9c102_show_frame_header(struct class_device* cd, char* buf)
+{
+	struct sn9c102_device* cam;
+	ssize_t count;
+
+	cam = video_get_drvdata(to_video_device(cd));
+	if (!cam)
+		return -ENODEV;
+
+	count = sizeof(cam->sysfs.frame_header);
+	memcpy(buf, cam->sysfs.frame_header, count);
+
+	DBG(3, "Frame header, read bytes: %zd", count)
+
+	return count;
+} 
+
+
 static CLASS_DEVICE_ATTR(reg, S_IRUGO | S_IWUSR,
                          sn9c102_show_reg, sn9c102_store_reg);
 static CLASS_DEVICE_ATTR(val, S_IRUGO | S_IWUSR,
@@ -1140,6 +1180,8 @@
 static CLASS_DEVICE_ATTR(green, S_IWUGO, NULL, sn9c102_store_green);
 static CLASS_DEVICE_ATTR(blue, S_IWUGO, NULL, sn9c102_store_blue);
 static CLASS_DEVICE_ATTR(red, S_IWUGO, NULL, sn9c102_store_red);
+static CLASS_DEVICE_ATTR(frame_header, S_IRUGO,
+                         sn9c102_show_frame_header, NULL);
 
 
 static void sn9c102_create_sysfs(struct sn9c102_device* cam)
@@ -1148,14 +1190,14 @@
 
 	video_device_create_file(v4ldev, &class_device_attr_reg);
 	video_device_create_file(v4ldev, &class_device_attr_val);
+	video_device_create_file(v4ldev, &class_device_attr_frame_header);
 	if (cam->bridge == BRIDGE_SN9C101 || cam->bridge == BRIDGE_SN9C102)
 		video_device_create_file(v4ldev, &class_device_attr_green);
 	else if (cam->bridge == BRIDGE_SN9C103) {
 		video_device_create_file(v4ldev, &class_device_attr_blue);
 		video_device_create_file(v4ldev, &class_device_attr_red);
 	}
-	if (cam->sensor->slave_write_id != SN9C102_I2C_SLAVEID_UNAVAILABLE ||
-	    cam->sensor->slave_read_id != SN9C102_I2C_SLAVEID_UNAVAILABLE) {
+	if (cam->sensor->sysfs_ops) {
 		video_device_create_file(v4ldev, &class_device_attr_i2c_reg);
 		video_device_create_file(v4ldev, &class_device_attr_i2c_val);
 	}
@@ -1164,11 +1206,11 @@
 /*****************************************************************************/
 
 static int
-sn9c102_set_format(struct sn9c102_device* cam, struct v4l2_pix_format* fmt)
+sn9c102_set_pix_format(struct sn9c102_device* cam, struct v4l2_pix_format* pix)
 {
 	int err = 0;
 
-	if (fmt->pixelformat == V4L2_PIX_FMT_SN9C10X)
+	if (pix->pixelformat == V4L2_PIX_FMT_SN9C10X)
 		err += sn9c102_write_reg(cam, cam->reg[0x18] | 0x80, 0x18);
 	else
 		err += sn9c102_write_reg(cam, cam->reg[0x18] & 0x7f, 0x18);
@@ -1273,7 +1315,9 @@
 		cam->compression.quality =  cam->reg[0x17] & 0x01 ? 0 : 1;
 	else
 		err += sn9c102_set_compression(cam, &cam->compression);
-	err += sn9c102_set_format(cam, &s->pix_format);
+	err += sn9c102_set_pix_format(cam, &s->pix_format);
+	if (s->set_pix_format)
+		err += s->set_pix_format(cam, &s->pix_format);
 	if (err)
 		return err;
 
@@ -2077,8 +2121,10 @@
 
 		sn9c102_release_buffers(cam);
 
-		err += sn9c102_set_format(cam, pix);
+		err += sn9c102_set_pix_format(cam, pix);
 		err += sn9c102_set_crop(cam, &rect);
+		if (s->set_pix_format)
+			err += s->set_pix_format(cam, pix);
 		if (s->set_crop)
 			err += s->set_crop(cam, &rect);
 		err += sn9c102_set_scale(cam, scale);
@@ -2551,6 +2597,7 @@
 	DBG(2, "V4L2 device registered as /dev/video%d", cam->v4ldev->minor)
 
 	sn9c102_create_sysfs(cam);
+	DBG(2, "Optional device control through 'sysfs' interface ready")
 
 	usb_set_intfdata(intf, cam);
 
diff -Nru a/drivers/usb/media/sn9c102_hv7131d.c b/drivers/usb/media/sn9c102_hv7131d.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/usb/media/sn9c102_hv7131d.c	2005-01-07 15:50:54 -08:00
@@ -0,0 +1,271 @@
+/***************************************************************************
+ * Plug-in for HV7131D image sensor connected to the SN9C10x PC Camera     *
+ * Controllers                                                             *
+ *                                                                         *
+ * Copyright (C) 2004 by Luca Risolia <luca.risolia@studio.unibo.it>       *
+ *                                                                         *
+ * This program is free software; you can redistribute it and/or modify    *
+ * it under the terms of the GNU General Public License as published by    *
+ * the Free Software Foundation; either version 2 of the License, or       *
+ * (at your option) any later version.                                     *
+ *                                                                         *
+ * This program is distributed in the hope that it will be useful,         *
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of          *
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
+ * GNU General Public License for more details.                            *
+ *                                                                         *
+ * You should have received a copy of the GNU General Public License       *
+ * along with this program; if not, write to the Free Software             *
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.               *
+ ***************************************************************************/
+
+#include "sn9c102_sensor.h"
+
+
+static struct sn9c102_sensor hv7131d;
+
+
+static int hv7131d_init(struct sn9c102_device* cam)
+{
+	int err = 0;
+
+	err += sn9c102_write_reg(cam, 0x00, 0x10);
+	err += sn9c102_write_reg(cam, 0x00, 0x11);
+	err += sn9c102_write_reg(cam, 0x00, 0x14);
+	err += sn9c102_write_reg(cam, 0x60, 0x17);
+	err += sn9c102_write_reg(cam, 0x0e, 0x18);
+	err += sn9c102_write_reg(cam, 0xf2, 0x19);
+
+	err += sn9c102_i2c_write(cam, 0x01, 0x04);
+	err += sn9c102_i2c_write(cam, 0x02, 0x00);
+	err += sn9c102_i2c_write(cam, 0x28, 0x00);
+
+	return err;
+}
+
+
+static int hv7131d_get_ctrl(struct sn9c102_device* cam, 
+                            struct v4l2_control* ctrl)
+{
+	switch (ctrl->id) {
+	case V4L2_CID_EXPOSURE:
+		{
+			int r1 = sn9c102_i2c_read(cam, 0x26),
+			    r2 = sn9c102_i2c_read(cam, 0x27);
+			if (r1 < 0 || r2 < 0)
+				return -EIO;
+			ctrl->value = (r1 << 8) | (r2 & 0xff);
+		}
+		return 0;
+	case V4L2_CID_RED_BALANCE:
+		if ((ctrl->value = sn9c102_i2c_read(cam, 0x31)) < 0)
+			return -EIO;
+		ctrl->value = 0x3f - (ctrl->value & 0x3f);
+		return 0;
+	case V4L2_CID_BLUE_BALANCE:
+		if ((ctrl->value = sn9c102_i2c_read(cam, 0x33)) < 0)
+			return -EIO;
+		ctrl->value = 0x3f - (ctrl->value & 0x3f);
+		return 0;
+	case SN9C102_V4L2_CID_GREEN_BALANCE:
+		if ((ctrl->value = sn9c102_i2c_read(cam, 0x32)) < 0)
+			return -EIO;
+		ctrl->value = 0x3f - (ctrl->value & 0x3f);
+		return 0;
+	case SN9C102_V4L2_CID_RESET_LEVEL:
+		if ((ctrl->value = sn9c102_i2c_read(cam, 0x30)) < 0)
+			return -EIO;
+		ctrl->value &= 0x3f;
+		return 0;
+	case SN9C102_V4L2_CID_PIXEL_BIAS_VOLTAGE:
+		if ((ctrl->value = sn9c102_i2c_read(cam, 0x34)) < 0)
+			return -EIO;
+		ctrl->value &= 0x07;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+
+static int hv7131d_set_ctrl(struct sn9c102_device* cam, 
+                            const struct v4l2_control* ctrl)
+{
+	int err = 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_EXPOSURE:
+		err += sn9c102_i2c_write(cam, 0x26, ctrl->value >> 8);
+		err += sn9c102_i2c_write(cam, 0x27, ctrl->value & 0xff);
+		break;
+	case V4L2_CID_RED_BALANCE:
+		err += sn9c102_i2c_write(cam, 0x31, 0x3f - ctrl->value);
+		break;
+	case V4L2_CID_BLUE_BALANCE:
+		err += sn9c102_i2c_write(cam, 0x33, 0x3f - ctrl->value);
+		break;
+	case SN9C102_V4L2_CID_GREEN_BALANCE:
+		err += sn9c102_i2c_write(cam, 0x32, 0x3f - ctrl->value);
+		break;
+	case SN9C102_V4L2_CID_RESET_LEVEL:
+		err += sn9c102_i2c_write(cam, 0x30, ctrl->value);
+		break;
+	case SN9C102_V4L2_CID_PIXEL_BIAS_VOLTAGE:
+		err += sn9c102_i2c_write(cam, 0x34, ctrl->value);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return err ? -EIO : 0;
+}
+
+
+static int hv7131d_set_crop(struct sn9c102_device* cam, 
+                            const struct v4l2_rect* rect)
+{
+	struct sn9c102_sensor* s = &hv7131d;
+	int err = 0;
+	u8 h_start = (u8)(rect->left - s->cropcap.bounds.left) + 2,
+	   v_start = (u8)(rect->top - s->cropcap.bounds.top) + 2;
+
+	err += sn9c102_write_reg(cam, h_start, 0x12);
+	err += sn9c102_write_reg(cam, v_start, 0x13);
+
+	return err;
+}
+
+
+static int hv7131d_set_pix_format(struct sn9c102_device* cam, 
+                                  const struct v4l2_pix_format* pix)
+{
+	int err = 0;
+
+	if (pix->pixelformat == V4L2_PIX_FMT_SN9C10X)
+		err += sn9c102_write_reg(cam, 0x42, 0x19);
+	else
+		err += sn9c102_write_reg(cam, 0xf2, 0x19);
+
+	return err;
+}
+
+
+static struct sn9c102_sensor hv7131d = {
+	.name = "HV7131D",
+	.maintainer = "Luca Risolia <luca.risolia@studio.unibo.it>",
+	.sysfs_ops = SN9C102_I2C_READ | SN9C102_I2C_WRITE,
+	.frequency = SN9C102_I2C_100KHZ,
+	.interface = SN9C102_I2C_2WIRES,
+	.i2c_slave_id = 0x11,
+	.init = &hv7131d_init,
+	.qctrl = {
+		{
+			.id = V4L2_CID_EXPOSURE,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "exposure",
+			.minimum = 0x0250,
+			.maximum = 0xffff,
+			.step = 0x0001,
+			.default_value = 0x0250,
+			.flags = 0,
+		},
+		{
+			.id = V4L2_CID_RED_BALANCE,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "red balance",
+			.minimum = 0x00,
+			.maximum = 0x3f,
+			.step = 0x01,
+			.default_value = 0x00,
+			.flags = 0,
+		},
+		{
+			.id = V4L2_CID_BLUE_BALANCE,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "blue balance",
+			.minimum = 0x00,
+			.maximum = 0x3f,
+			.step = 0x01,
+			.default_value = 0x20,
+			.flags = 0,
+		},
+		{
+			.id = SN9C102_V4L2_CID_GREEN_BALANCE,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "green balance",
+			.minimum = 0x00,
+			.maximum = 0x3f,
+			.step = 0x01,
+			.default_value = 0x1e,
+			.flags = 0,
+		},
+		{
+			.id = SN9C102_V4L2_CID_RESET_LEVEL,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "reset level",
+			.minimum = 0x19,
+			.maximum = 0x3f,
+			.step = 0x01,
+			.default_value = 0x30,
+			.flags = 0,
+		},
+		{
+			.id = SN9C102_V4L2_CID_PIXEL_BIAS_VOLTAGE,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "pixel bias voltage",
+			.minimum = 0x00,
+			.maximum = 0x07,
+			.step = 0x01,
+			.default_value = 0x02,
+			.flags = 0,
+		},
+	},
+	.get_ctrl = &hv7131d_get_ctrl,
+	.set_ctrl = &hv7131d_set_ctrl,
+	.cropcap = {
+		.bounds = {
+			.left = 0,
+			.top = 0,
+			.width = 640,
+			.height = 480,
+		},
+		.defrect = {
+			.left = 0,
+			.top = 0,
+			.width = 640,
+			.height = 480,
+		},
+	},
+	.set_crop = &hv7131d_set_crop,
+	.pix_format = {
+		.width = 640,
+		.height = 480,
+		.pixelformat = V4L2_PIX_FMT_SBGGR8,
+		.priv = 8,
+	},
+	.set_pix_format = &hv7131d_set_pix_format
+};
+
+
+int sn9c102_probe_hv7131d(struct sn9c102_device* cam)
+{
+	int r0 = 0, r1 = 0, err = 0;
+
+	err += sn9c102_write_reg(cam, 0x01, 0x01);
+	err += sn9c102_write_reg(cam, 0x00, 0x01);
+	err += sn9c102_write_reg(cam, 0x28, 0x17);
+	if (err)
+		return -EIO;
+
+	r0 = sn9c102_i2c_try_read(cam, &hv7131d, 0x00);
+	r1 = sn9c102_i2c_try_read(cam, &hv7131d, 0x01);
+	if (r0 < 0 || r1 < 0)
+		return -EIO;
+
+	if (r0 != 0x00 && r1 != 0x04)
+		return -ENODEV;
+
+	sn9c102_attach_sensor(cam, &hv7131d);
+
+	return 0;
+}
diff -Nru a/drivers/usb/media/sn9c102_mi0343.c b/drivers/usb/media/sn9c102_mi0343.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/usb/media/sn9c102_mi0343.c	2005-01-07 15:50:54 -08:00
@@ -0,0 +1,363 @@
+/***************************************************************************
+ * Plug-in for MI-0343 image sensor connected to the SN9C10x PC Camera     *
+ * Controllers                                                             *
+ *                                                                         *
+ * Copyright (C) 2004 by Luca Risolia <luca.risolia@studio.unibo.it>       *
+ *                                                                         *
+ * This program is free software; you can redistribute it and/or modify    *
+ * it under the terms of the GNU General Public License as published by    *
+ * the Free Software Foundation; either version 2 of the License, or       *
+ * (at your option) any later version.                                     *
+ *                                                                         *
+ * This program is distributed in the hope that it will be useful,         *
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of          *
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
+ * GNU General Public License for more details.                            *
+ *                                                                         *
+ * You should have received a copy of the GNU General Public License       *
+ * along with this program; if not, write to the Free Software             *
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.               *
+ ***************************************************************************/
+
+#include "sn9c102_sensor.h"
+
+
+static struct sn9c102_sensor mi0343;
+static u8 mi0343_i2c_data[5+1];
+
+
+static int mi0343_init(struct sn9c102_device* cam)
+{
+	int err = 0;
+
+	err += sn9c102_write_reg(cam, 0x00, 0x10);
+	err += sn9c102_write_reg(cam, 0x00, 0x11);
+	err += sn9c102_write_reg(cam, 0x0a, 0x14);
+	err += sn9c102_write_reg(cam, 0x40, 0x01);
+	err += sn9c102_write_reg(cam, 0x20, 0x17);
+	err += sn9c102_write_reg(cam, 0x07, 0x18);
+	err += sn9c102_write_reg(cam, 0xa0, 0x19);
+
+	err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4, mi0343.i2c_slave_id,
+	                                 0x0d, 0x00, 0x01, 0, 0);
+	err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4, mi0343.i2c_slave_id,
+	                                 0x0d, 0x00, 0x00, 0, 0);
+	err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4, mi0343.i2c_slave_id,
+	                                 0x03, 0x01, 0xe1, 0, 0);
+	err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4, mi0343.i2c_slave_id,
+	                                 0x04, 0x02, 0x81, 0, 0);
+	err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4, mi0343.i2c_slave_id,
+	                                 0x05, 0x00, 0x17, 0, 0);
+	err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4, mi0343.i2c_slave_id,
+	                                 0x06, 0x00, 0x11, 0, 0);
+	err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4, mi0343.i2c_slave_id,
+	                                 0x62, 0x04, 0x9a, 0, 0);
+
+	return err;
+}
+
+
+static int mi0343_get_ctrl(struct sn9c102_device* cam, 
+                           struct v4l2_control* ctrl)
+{
+	switch (ctrl->id) {
+	case V4L2_CID_EXPOSURE:
+		if (sn9c102_i2c_try_raw_read(cam, &mi0343, mi0343.i2c_slave_id,
+		                             0x09, 2+1, mi0343_i2c_data) < 0)
+			return -EIO;
+		ctrl->value = mi0343_i2c_data[2];
+		return 0;
+	case V4L2_CID_GAIN:
+		if (sn9c102_i2c_try_raw_read(cam, &mi0343, mi0343.i2c_slave_id,
+		                             0x35, 2+1, mi0343_i2c_data) < 0)
+			return -EIO;
+		break;
+	case V4L2_CID_HFLIP:
+		if (sn9c102_i2c_try_raw_read(cam, &mi0343, mi0343.i2c_slave_id,
+		                             0x20, 2+1, mi0343_i2c_data) < 0)
+			return -EIO;
+		ctrl->value = mi0343_i2c_data[3] & 0x20 ? 1 : 0;
+		return 0;
+	case V4L2_CID_VFLIP:
+		if (sn9c102_i2c_try_raw_read(cam, &mi0343, mi0343.i2c_slave_id,
+		                             0x20, 2+1, mi0343_i2c_data) < 0)
+			return -EIO;
+		ctrl->value = mi0343_i2c_data[3] & 0x80 ? 1 : 0;
+		return 0;
+	case V4L2_CID_RED_BALANCE:
+		if (sn9c102_i2c_try_raw_read(cam, &mi0343, mi0343.i2c_slave_id,
+		                             0x2d, 2+1, mi0343_i2c_data) < 0)
+			return -EIO;
+		break;
+	case V4L2_CID_BLUE_BALANCE:
+		if (sn9c102_i2c_try_raw_read(cam, &mi0343, mi0343.i2c_slave_id,
+		                             0x2c, 2+1, mi0343_i2c_data) < 0)
+			return -EIO;
+		break;
+	case SN9C102_V4L2_CID_GREEN_BALANCE:
+		if (sn9c102_i2c_try_raw_read(cam, &mi0343, mi0343.i2c_slave_id,
+		                             0x2e, 2+1, mi0343_i2c_data) < 0)
+			return -EIO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (ctrl->id) {
+	case V4L2_CID_GAIN:
+	case V4L2_CID_RED_BALANCE:
+	case V4L2_CID_BLUE_BALANCE:
+	case SN9C102_V4L2_CID_GREEN_BALANCE:
+		ctrl->value = mi0343_i2c_data[3] | (mi0343_i2c_data[2] << 8);
+		if (ctrl->value >= 0x10 && ctrl->value <= 0x3f)
+			ctrl->value -= 0x10;
+		else if (ctrl->value >= 0x60 && ctrl->value <= 0x7f)
+			ctrl->value -= 0x60;
+		else if (ctrl->value >= 0xe0 && ctrl->value <= 0xff)
+			ctrl->value -= 0xe0;
+	}
+
+	return 0;
+}
+
+
+static int mi0343_set_ctrl(struct sn9c102_device* cam, 
+                           const struct v4l2_control* ctrl)
+{
+	u16 reg = 0;
+	int err = 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_GAIN:
+	case V4L2_CID_RED_BALANCE:
+	case V4L2_CID_BLUE_BALANCE:
+	case SN9C102_V4L2_CID_GREEN_BALANCE:
+		if (ctrl->value <= (0x3f-0x10))
+			reg = 0x10 + ctrl->value;
+		else if (ctrl->value <= ((0x3f-0x10) + (0x7f-0x60)))
+			reg = 0x60 + (ctrl->value - (0x3f-0x10));
+		else
+			reg = 0xe0 + (ctrl->value - (0x3f-0x10) - (0x7f-0x60));
+		break;
+	}
+
+	switch (ctrl->id) {
+	case V4L2_CID_EXPOSURE:
+		err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4,
+		                                 mi0343.i2c_slave_id,
+		                                 0x09, ctrl->value, 0x00,
+		                                 0, 0);
+		break;
+	case V4L2_CID_GAIN:
+		err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4,
+		                                 mi0343.i2c_slave_id,
+		                                 0x35, reg >> 8, reg & 0xff,
+		                                 0, 0);
+		break;
+	case V4L2_CID_HFLIP:
+		err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4,
+		                                 mi0343.i2c_slave_id,
+		                                 0x20, ctrl->value ? 0x40:0x00,
+		                                 ctrl->value ? 0x20:0x00,
+		                                 0, 0);
+		break;
+	case V4L2_CID_VFLIP:
+		err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4,
+		                                 mi0343.i2c_slave_id,
+		                                 0x20, ctrl->value ? 0x80:0x00,
+		                                 ctrl->value ? 0x80:0x00,
+		                                 0, 0);
+		break;
+	case V4L2_CID_RED_BALANCE:
+		err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4,
+		                                 mi0343.i2c_slave_id,
+		                                 0x2d, reg >> 8, reg & 0xff,
+		                                 0, 0);
+		break;
+	case V4L2_CID_BLUE_BALANCE:
+		err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4,
+		                                 mi0343.i2c_slave_id,
+		                                 0x2c, reg >> 8, reg & 0xff,
+		                                 0, 0);
+		break;
+	case SN9C102_V4L2_CID_GREEN_BALANCE:
+		err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4,
+		                                 mi0343.i2c_slave_id,
+		                                 0x2b, reg >> 8, reg & 0xff,
+		                                 0, 0);
+		err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4,
+		                                 mi0343.i2c_slave_id,
+		                                 0x2e, reg >> 8, reg & 0xff,
+		                                 0, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return err ? -EIO : 0;
+}
+
+
+static int mi0343_set_crop(struct sn9c102_device* cam, 
+                            const struct v4l2_rect* rect)
+{
+	struct sn9c102_sensor* s = &mi0343;
+	int err = 0;
+	u8 h_start = (u8)(rect->left - s->cropcap.bounds.left) + 0,
+	   v_start = (u8)(rect->top - s->cropcap.bounds.top) + 2;
+
+	err += sn9c102_write_reg(cam, h_start, 0x12);
+	err += sn9c102_write_reg(cam, v_start, 0x13);
+
+	return err;
+}
+
+
+static int mi0343_set_pix_format(struct sn9c102_device* cam, 
+                                 const struct v4l2_pix_format* pix)
+{
+	int err = 0;
+
+	if (pix->pixelformat == V4L2_PIX_FMT_SN9C10X) {
+		err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4,
+		                                 mi0343.i2c_slave_id,
+		                                 0x0a, 0x00, 0x03, 0, 0);
+		err += sn9c102_write_reg(cam, 0x20, 0x19);
+	} else {
+		err += sn9c102_i2c_try_raw_write(cam, &mi0343, 4,
+		                                 mi0343.i2c_slave_id,
+		                                 0x0a, 0x00, 0x05, 0, 0);
+		err += sn9c102_write_reg(cam, 0xa0, 0x19);
+	}
+
+	return err;
+}
+
+
+static struct sn9c102_sensor mi0343 = {
+	.name = "MI-0343",
+	.maintainer = "Luca Risolia <luca.risolia@studio.unibo.it>",
+	.frequency = SN9C102_I2C_100KHZ,
+	.interface = SN9C102_I2C_2WIRES,
+	.i2c_slave_id = 0x5d,
+	.init = &mi0343_init,
+	.qctrl = {
+		{
+			.id = V4L2_CID_EXPOSURE,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "exposure",
+			.minimum = 0x00,
+			.maximum = 0x0f,
+			.step = 0x01,
+			.default_value = 0x06,
+			.flags = 0,
+		},
+		{
+			.id = V4L2_CID_GAIN,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "global gain",
+			.minimum = 0x00,
+			.maximum = (0x3f-0x10)+(0x7f-0x60)+(0xff-0xe0),/*0x6d*/
+			.step = 0x01,
+			.default_value = 0x00,
+			.flags = 0,
+		},
+		{
+			.id = V4L2_CID_HFLIP,
+			.type = V4L2_CTRL_TYPE_BOOLEAN,
+			.name = "horizontal mirror",
+			.minimum = 0,
+			.maximum = 1,
+			.step = 1,
+			.default_value = 0,
+			.flags = 0,
+		},
+		{
+			.id = V4L2_CID_VFLIP,
+			.type = V4L2_CTRL_TYPE_BOOLEAN,
+			.name = "vertical mirror",
+			.minimum = 0,
+			.maximum = 1,
+			.step = 1,
+			.default_value = 0,
+			.flags = 0,
+		},
+		{
+			.id = V4L2_CID_RED_BALANCE,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "red balance",
+			.minimum = 0x00,
+			.maximum = (0x3f-0x10)+(0x7f-0x60)+(0xff-0xe0),
+			.step = 0x01,
+			.default_value = 0x00,
+			.flags = 0,
+		},
+		{
+			.id = V4L2_CID_BLUE_BALANCE,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "blue balance",
+			.minimum = 0x00,
+			.maximum = (0x3f-0x10)+(0x7f-0x60)+(0xff-0xe0),
+			.step = 0x01,
+			.default_value = 0x00,
+			.flags = 0,
+		},
+		{
+			.id = SN9C102_V4L2_CID_GREEN_BALANCE,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "green balance",
+			.minimum = 0x00,
+			.maximum = ((0x3f-0x10)+(0x7f-0x60)+(0xff-0xe0)),
+			.step = 0x01,
+			.default_value = 0x00,
+			.flags = 0,
+		},
+	},
+	.get_ctrl = &mi0343_get_ctrl,
+	.set_ctrl = &mi0343_set_ctrl,
+	.cropcap = {
+		.bounds = {
+			.left = 0,
+			.top = 0,
+			.width = 640,
+			.height = 480,
+		},
+		.defrect = {
+			.left = 0,
+			.top = 0,
+			.width = 640,
+			.height = 480,
+		},
+	},
+	.set_crop = &mi0343_set_crop,
+	.pix_format = {
+		.width = 640,
+		.height = 480,
+		.pixelformat = V4L2_PIX_FMT_SBGGR8,
+		.priv = 8,
+	},
+	.set_pix_format = &mi0343_set_pix_format
+};
+
+
+int sn9c102_probe_mi0343(struct sn9c102_device* cam)
+{
+	int err = 0;
+
+	err += sn9c102_write_reg(cam, 0x01, 0x01);
+	err += sn9c102_write_reg(cam, 0x00, 0x01);
+	err += sn9c102_write_reg(cam, 0x28, 0x17);
+	if (err)
+		return -EIO;
+
+	if (sn9c102_i2c_try_raw_read(cam, &mi0343, mi0343.i2c_slave_id, 0x00,
+	                             2, mi0343_i2c_data) < 0)
+		return -EIO;
+
+	if (mi0343_i2c_data[4] != 0x32 && mi0343_i2c_data[3] != 0xe3)
+		return -ENODEV;
+
+	sn9c102_attach_sensor(cam, &mi0343);
+
+	return 0;
+}
diff -Nru a/drivers/usb/media/sn9c102_pas106b.c b/drivers/usb/media/sn9c102_pas106b.c
--- a/drivers/usb/media/sn9c102_pas106b.c	2005-01-07 15:50:54 -08:00
+++ b/drivers/usb/media/sn9c102_pas106b.c	2005-01-07 15:50:54 -08:00
@@ -96,11 +96,6 @@
 			return -EIO;
 		ctrl->value &= 0xf8;
 		return 0;
-	case SN9C102_V4L2_CID_DAC_SIGN:
-		if ((ctrl->value = sn9c102_i2c_read(cam, 0x07)) < 0)
-			return -EIO;
-		ctrl->value &= 0x01;
-		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -136,13 +131,6 @@
 	case SN9C102_V4L2_CID_DAC_MAGNITUDE:
 		err += sn9c102_i2c_write(cam, 0x08, ctrl->value << 3);
 		break;
-	case SN9C102_V4L2_CID_DAC_SIGN:
-		{
-			int r;
-			err += (r = sn9c102_i2c_read(cam, 0x07)) < 0 ? r : 0;
-			err += sn9c102_i2c_write(cam, 0x07, r | ctrl->value);
-		}
-		break;
 	default:
 		return -EINVAL;
 	}
@@ -167,13 +155,27 @@
 }
 
 
+static int pas106b_set_pix_format(struct sn9c102_device* cam, 
+                                  const struct v4l2_pix_format* pix)
+{
+	int err = 0;
+
+	if (pix->pixelformat == V4L2_PIX_FMT_SN9C10X)
+		err += sn9c102_write_reg(cam, 0x2c, 0x17);
+	else
+		err += sn9c102_write_reg(cam, 0x20, 0x17);
+
+	return err;
+}
+
+
 static struct sn9c102_sensor pas106b = {
 	.name = "PAS106B",
 	.maintainer = "Luca Risolia <luca.risolia@studio.unibo.it>",
+	.sysfs_ops = SN9C102_I2C_READ | SN9C102_I2C_WRITE,
 	.frequency = SN9C102_I2C_400KHZ | SN9C102_I2C_100KHZ,
 	.interface = SN9C102_I2C_2WIRES,
-	.slave_read_id = 0x40,
-	.slave_write_id = 0x40,
+	.i2c_slave_id = 0x40,
 	.init = &pas106b_init,
 	.qctrl = {
 		{
@@ -182,7 +184,7 @@
 			.name = "exposure",
 			.minimum = 0x125,
 			.maximum = 0xfff,
-			.step = 0x01,
+			.step = 0x001,
 			.default_value = 0x140,
 			.flags = 0,
 		},
@@ -246,16 +248,6 @@
 			.default_value = 0x01,
 			.flags = 0,
 		},
-		{
-			.id = SN9C102_V4L2_CID_DAC_SIGN,
-			.type = V4L2_CTRL_TYPE_BOOLEAN,
-			.name = "DAC sign",
-			.minimum = 0x00,
-			.maximum = 0x01,
-			.step = 0x01,
-			.default_value = 0x00,
-			.flags = 0,
-		},
 	},
 	.get_ctrl = &pas106b_get_ctrl,
 	.set_ctrl = &pas106b_set_ctrl,
@@ -279,7 +271,8 @@
 		.height = 288,
 		.pixelformat = V4L2_PIX_FMT_SBGGR8,
 		.priv = 8, /* we use this field as 'bits per pixel' */
-	}
+	},
+	.set_pix_format = &pas106b_set_pix_format
 };
 
 
diff -Nru a/drivers/usb/media/sn9c102_pas202bcb.c b/drivers/usb/media/sn9c102_pas202bcb.c
--- a/drivers/usb/media/sn9c102_pas202bcb.c	2005-01-07 15:50:54 -08:00
+++ b/drivers/usb/media/sn9c102_pas202bcb.c	2005-01-07 15:50:54 -08:00
@@ -6,7 +6,7 @@
  *                       <medaglia@undl.org.br>                            *
  *                       http://cadu.homelinux.com:8080/                   *
  *                                                                         *
- * DAC Magnitude, DAC sign, exposure and green gain controls added by      *
+ * DAC Magnitude, exposure and green gain controls added by                *
  * Luca Risolia <luca.risolia@studio.unibo.it>                             *
  *                                                                         *
  * This program is free software; you can redistribute it and/or modify    *
@@ -95,17 +95,26 @@
 		if ((ctrl->value = sn9c102_i2c_read(cam, 0x0c)) < 0)
 			return -EIO;
 		return 0;
-	case SN9C102_V4L2_CID_DAC_SIGN:
-		if ((ctrl->value = sn9c102_i2c_read(cam, 0x0b)) < 0)
-			return -EIO;
-		ctrl->value &= 0x01;
-		return 0;
 	default:
 		return -EINVAL;
 	}
 }
 
 
+static int pas202bcb_set_pix_format(struct sn9c102_device* cam, 
+                                    const struct v4l2_pix_format* pix)
+{
+	int err = 0;
+
+	if (pix->pixelformat == V4L2_PIX_FMT_SN9C10X)
+		err += sn9c102_write_reg(cam, 0x24, 0x17);
+	else
+		err += sn9c102_write_reg(cam, 0x20, 0x17);
+
+	return err;
+}
+
+
 static int pas202bcb_set_ctrl(struct sn9c102_device* cam, 
                               const struct v4l2_control* ctrl)
 {
@@ -131,13 +140,6 @@
 	case SN9C102_V4L2_CID_DAC_MAGNITUDE:
 		err += sn9c102_i2c_write(cam, 0x0c, ctrl->value);
 		break;
-	case SN9C102_V4L2_CID_DAC_SIGN:
-		{
-			int r;
-			err += (r = sn9c102_i2c_read(cam, 0x0b)) < 0 ? r : 0;
-			err += sn9c102_i2c_write(cam, 0x0b, r | ctrl->value);
-		}
-		break;
 	default:
 		return -EINVAL;
 	}
@@ -166,10 +168,10 @@
 	.name = "PAS202BCB",
 	.maintainer = "Carlos Eduardo Medaglia Dyonisio "
 	              "<medaglia@undl.org.br>",
+	.sysfs_ops = SN9C102_I2C_READ | SN9C102_I2C_WRITE,
 	.frequency = SN9C102_I2C_400KHZ | SN9C102_I2C_100KHZ,
 	.interface = SN9C102_I2C_2WIRES,
-	.slave_read_id = 0x40,
-	.slave_write_id = 0x40,
+	.i2c_slave_id = 0x40,
 	.init = &pas202bcb_init,
 	.qctrl = {
 		{
@@ -178,7 +180,7 @@
 			.name = "exposure",
 			.minimum = 0x01e5,
 			.maximum = 0x3fff,
-			.step = 0x01,
+			.step = 0x0001,
 			.default_value = 0x01e5,
 			.flags = 0,
 		},
@@ -232,16 +234,6 @@
 			.default_value = 0x04,
 			.flags = 0,
 		},
-		{
-			.id = SN9C102_V4L2_CID_DAC_SIGN,
-			.type = V4L2_CTRL_TYPE_BOOLEAN,
-			.name = "DAC sign",
-			.minimum = 0x00,
-			.maximum = 0x01,
-			.step = 0x01,
-			.default_value = 0x01,
-			.flags = 0,
-		},
 	},
 	.get_ctrl = &pas202bcb_get_ctrl,
 	.set_ctrl = &pas202bcb_set_ctrl,
@@ -265,7 +257,8 @@
 		.height = 480,
 		.pixelformat = V4L2_PIX_FMT_SBGGR8,
 		.priv = 8,
-	}
+	},
+	.set_pix_format = &pas202bcb_set_pix_format
 };
 
 
@@ -286,7 +279,7 @@
 
 	r0 = sn9c102_i2c_try_read(cam, &pas202bcb, 0x00);
 	r1 = sn9c102_i2c_try_read(cam, &pas202bcb, 0x01);
-	
+
 	if (r0 < 0 || r1 < 0)
 		return -EIO;
 
diff -Nru a/drivers/usb/media/sn9c102_sensor.h b/drivers/usb/media/sn9c102_sensor.h
--- a/drivers/usb/media/sn9c102_sensor.h	2005-01-07 15:50:54 -08:00
+++ b/drivers/usb/media/sn9c102_sensor.h	2005-01-07 15:50:54 -08:00
@@ -62,6 +62,8 @@
    ahead.
    Functions must return 0 on success, the appropriate error otherwise.
 */
+extern int sn9c102_probe_hv7131d(struct sn9c102_device* cam);
+extern int sn9c102_probe_mi0343(struct sn9c102_device* cam);
 extern int sn9c102_probe_pas106b(struct sn9c102_device* cam);
 extern int sn9c102_probe_pas202bcb(struct sn9c102_device* cam);
 extern int sn9c102_probe_tas5110c1b(struct sn9c102_device* cam);
@@ -74,8 +76,10 @@
 */
 #define SN9C102_SENSOR_TABLE                                                  \
 static int (*sn9c102_sensor_table[])(struct sn9c102_device*) = {              \
+	&sn9c102_probe_mi0343, /* strong detection based on SENSOR ids */     \
 	&sn9c102_probe_pas106b, /* strong detection based on SENSOR ids */    \
 	&sn9c102_probe_pas202bcb, /* strong detection based on SENSOR ids */  \
+	&sn9c102_probe_hv7131d, /* strong detection based on SENSOR ids */    \
 	&sn9c102_probe_tas5110c1b, /* detection based on USB pid/vid */       \
 	&sn9c102_probe_tas5130d1b, /* detection based on USB pid/vid */       \
 	NULL,                                                                 \
@@ -97,7 +101,7 @@
 	{ USB_DEVICE(0x0c45, 0x6025), }, /* TAS5130D1B and TAS5110C1B */      \
 	{ USB_DEVICE(0x0c45, 0x6028), }, /* PAS202BCB */                      \
 	{ USB_DEVICE(0x0c45, 0x6029), }, /* PAS106B */                        \
-	{ USB_DEVICE(0x0c45, 0x602a), }, /* HV7131[D|E1] */                   \
+	{ USB_DEVICE(0x0c45, 0x602a), }, /* HV7131D */                        \
 	{ USB_DEVICE(0x0c45, 0x602b), }, /* MI-0343 */                        \
 	{ USB_DEVICE(0x0c45, 0x602c), }, /* OV7620 */                         \
 	{ USB_DEVICE(0x0c45, 0x6030), }, /* MI03x */                          \
@@ -147,15 +151,23 @@
                                 u8 address);
 
 /*
-   This must be used if and only if the sensor doesn't implement the standard
-   I2C protocol. There a number of good reasons why you must use the 
-   single-byte versions of this function: do not abuse. It writes n bytes, 
-   from data0 to datan, (registers 0x09 - 0x09+n of SN9C10X chip).
+   These must be used if and only if the sensor doesn't implement the standard
+   I2C protocol. There are a number of good reasons why you must use the 
+   single-byte versions of these functions: do not abuse. The first function
+   writes n bytes, from data0 to datan, to registers 0x09 - 0x09+n of SN9C10X
+   chip. The second one programs the registers 0x09 and 0x10 with data0 and
+   data1, and places the n bytes read from the sensor register table in the
+   buffer pointed by 'buffer'. Both the functions return -1 on error; the write
+   version returns 0 on success, while the read version returns the first read
+   byte.
 */
 extern int sn9c102_i2c_try_raw_write(struct sn9c102_device* cam,
                                      struct sn9c102_sensor* sensor, u8 n, 
                                      u8 data0, u8 data1, u8 data2, u8 data3,
                                      u8 data4, u8 data5);
+extern int sn9c102_i2c_try_raw_read(struct sn9c102_device* cam,
+                                    struct sn9c102_sensor* sensor, u8 data0,
+                                    u8 data1, u8 n, u8 buffer[]);
 
 /* To be used after the sensor struct has been attached to the camera struct */
 extern int sn9c102_i2c_write(struct sn9c102_device*, u8 address, u8 value);
@@ -166,16 +178,21 @@
 extern int sn9c102_pread_reg(struct sn9c102_device*, u16 index);
 
 /*
-   NOTE: there are no debugging functions here. To uniform the output you must
-   use the dev_info()/dev_warn()/dev_err() macros defined in device.h, already
-   included here, the argument being the struct device 'dev' of the sensor
-   structure. Do NOT use these macros before the sensor is attached or the
-   kernel will crash! However you should not need to notify the user about
+   NOTE: there are no exported debugging functions. To uniform the output you
+   must use the dev_info()/dev_warn()/dev_err() macros defined in device.h,
+   already included here, the argument being the struct device 'dev' of the
+   sensor structure. Do NOT use these macros before the sensor is attached or
+   the kernel will crash! However, you should not need to notify the user about
    common errors or other messages, since this is done by the master module.
 */
 
 /*****************************************************************************/
 
+enum sn9c102_i2c_sysfs_ops {
+	SN9C102_I2C_READ = 0x01,
+	SN9C102_I2C_WRITE = 0x02,
+};
+
 enum sn9c102_i2c_frequency { /* sensors may support both the frequencies */
 	SN9C102_I2C_100KHZ = 0x01,
 	SN9C102_I2C_400KHZ = 0x02,
@@ -186,13 +203,13 @@
 	SN9C102_I2C_3WIRES,
 };
 
-#define SN9C102_I2C_SLAVEID_FICTITIOUS 0xff
-#define SN9C102_I2C_SLAVEID_UNAVAILABLE 0x00
-
 struct sn9c102_sensor {
 	char name[32], /* sensor name */
 	     maintainer[64]; /* name of the mantainer <email> */
 
+	/* Supported operations through the 'sysfs' interface */
+	enum sn9c102_i2c_sysfs_ops sysfs_ops;
+
 	/*
 	   These sensor capabilities must be provided if the SN9C10X controller
 	   needs to communicate through the sensor serial interface by using
@@ -202,10 +219,10 @@
 	enum sn9c102_i2c_interface interface;
 
 	/*
-	   These identifiers must be provided if the image sensor implements
+	   This identifier must be provided if the image sensor implements
 	   the standard I2C protocol.
 	*/
-	u8 slave_read_id, slave_write_id; /* reg. 0x09 */
+	u8 i2c_slave_id; /* reg. 0x09 */
 
 	/*
 	   NOTE: Where not noted,most of the functions below are not mandatory.
@@ -215,7 +232,7 @@
 
 	int (*init)(struct sn9c102_device* cam);
 	/*
-	   This function is called after the sensor has been attached. 
+	   This function will be called after the sensor has been attached. 
 	   It should be used to initialize the sensor only, but may also
 	   configure part of the SN9C10X chip if necessary. You don't need to
 	   setup picture settings like brightness, contrast, etc.. here, if
@@ -315,6 +332,14 @@
 	           matches the RGB bayer sequence (i.e. BGBGBG...GRGRGR).
 	*/
 
+	int (*set_pix_format)(struct sn9c102_device* cam,
+	                      const struct v4l2_pix_format* pix);
+	/*
+	   To be called on VIDIOC_S_FMT, when switching from the SBGGR8 to
+	   SN9C10X pixel format or viceversa. On error return the corresponding
+	   error code without rolling back.
+	*/
+
 	const struct device* dev;
 	/*
 	   This is the argument for dev_err(), dev_info() and dev_warn(). It
@@ -341,7 +366,8 @@
 
 /* Private ioctl's for control settings supported by some image sensors */
 #define SN9C102_V4L2_CID_DAC_MAGNITUDE V4L2_CID_PRIVATE_BASE
-#define SN9C102_V4L2_CID_DAC_SIGN V4L2_CID_PRIVATE_BASE + 1
-#define SN9C102_V4L2_CID_GREEN_BALANCE V4L2_CID_PRIVATE_BASE + 2
+#define SN9C102_V4L2_CID_GREEN_BALANCE V4L2_CID_PRIVATE_BASE + 1
+#define SN9C102_V4L2_CID_RESET_LEVEL V4L2_CID_PRIVATE_BASE + 2
+#define SN9C102_V4L2_CID_PIXEL_BIAS_VOLTAGE V4L2_CID_PRIVATE_BASE + 3
 
 #endif /* _SN9C102_SENSOR_H_ */
diff -Nru a/drivers/usb/media/sn9c102_tas5110c1b.c b/drivers/usb/media/sn9c102_tas5110c1b.c
--- a/drivers/usb/media/sn9c102_tas5110c1b.c	2005-01-07 15:50:54 -08:00
+++ b/drivers/usb/media/sn9c102_tas5110c1b.c	2005-01-07 15:50:54 -08:00
@@ -93,7 +93,21 @@
 	/* Don't change ! */
 	err += sn9c102_write_reg(cam, 0x14, 0x1a);
 	err += sn9c102_write_reg(cam, 0x0a, 0x1b);
-	err += sn9c102_write_reg(cam, 0xfb, 0x19);
+	err += sn9c102_write_reg(cam, sn9c102_pread_reg(cam, 0x19), 0x19);
+
+	return err;
+}
+
+
+static int tas5110c1b_set_pix_format(struct sn9c102_device* cam, 
+                                     const struct v4l2_pix_format* pix)
+{
+	int err = 0;
+
+	if (pix->pixelformat == V4L2_PIX_FMT_SN9C10X)
+		err += sn9c102_write_reg(cam, 0x2b, 0x19);
+	else
+		err += sn9c102_write_reg(cam, 0xfb, 0x19);
 
 	return err;
 }
@@ -102,10 +116,9 @@
 static struct sn9c102_sensor tas5110c1b = {
 	.name = "TAS5110C1B",
 	.maintainer = "Luca Risolia <luca.risolia@studio.unibo.it>",
+	.sysfs_ops = SN9C102_I2C_WRITE,
 	.frequency = SN9C102_I2C_100KHZ,
 	.interface = SN9C102_I2C_3WIRES,
-	.slave_read_id = SN9C102_I2C_SLAVEID_UNAVAILABLE,
-	.slave_write_id = SN9C102_I2C_SLAVEID_FICTITIOUS,
 	.init = &tas5110c1b_init,
 	.qctrl = {
 		{
@@ -141,7 +154,8 @@
 		.height = 288,
 		.pixelformat = V4L2_PIX_FMT_SBGGR8,
 		.priv = 8,
-	}
+	},
+	.set_pix_format = &tas5110c1b_set_pix_format
 };
 
 
diff -Nru a/drivers/usb/media/sn9c102_tas5130d1b.c b/drivers/usb/media/sn9c102_tas5130d1b.c
--- a/drivers/usb/media/sn9c102_tas5130d1b.c	2005-01-07 15:50:54 -08:00
+++ b/drivers/usb/media/sn9c102_tas5130d1b.c	2005-01-07 15:50:54 -08:00
@@ -98,7 +98,21 @@
 	/* Do NOT change! */
 	err += sn9c102_write_reg(cam, 0x1f, 0x1a);
 	err += sn9c102_write_reg(cam, 0x1a, 0x1b);
-	err += sn9c102_write_reg(cam, 0xf3, 0x19);
+	err += sn9c102_write_reg(cam, sn9c102_pread_reg(cam, 0x19), 0x19);
+
+	return err;
+}
+
+
+static int tas5130d1b_set_pix_format(struct sn9c102_device* cam, 
+                                     const struct v4l2_pix_format* pix)
+{
+	int err = 0;
+
+	if (pix->pixelformat == V4L2_PIX_FMT_SN9C10X)
+		err += sn9c102_write_reg(cam, 0x63, 0x19);
+	else
+		err += sn9c102_write_reg(cam, 0xf3, 0x19);
 
 	return err;
 }
@@ -107,10 +121,9 @@
 static struct sn9c102_sensor tas5130d1b = {
 	.name = "TAS5130D1B",
 	.maintainer = "Luca Risolia <luca.risolia@studio.unibo.it>",
+	.sysfs_ops = SN9C102_I2C_WRITE,
 	.frequency = SN9C102_I2C_100KHZ,
 	.interface = SN9C102_I2C_3WIRES,
-	.slave_read_id = SN9C102_I2C_SLAVEID_UNAVAILABLE,
-	.slave_write_id = SN9C102_I2C_SLAVEID_FICTITIOUS,
 	.init = &tas5130d1b_init,
 	.qctrl = {
 		{
@@ -156,7 +169,8 @@
 		.height = 480,
 		.pixelformat = V4L2_PIX_FMT_SBGGR8,
 		.priv = 8,
-	}
+	},
+	.set_pix_format = &tas5130d1b_set_pix_format
 };
 
 

