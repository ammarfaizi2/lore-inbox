Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWJLME3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWJLME3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWJLME3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:04:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:14393 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751334AbWJLME1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:04:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ZXJmMmOJuYRjOcFgHxIKUaYqafKfsgXeb3/W5JK2Sbwh00Rt0zZT7593IkIiJI03Z/qBGpwK1mG9yFxLKmS3BdLo0jk3f8kg52hA6aB3gZPV9Ud76+vyPy4DTuuM2k8JpIR/WyahUXTD9/QsEbczR1CoGDxgrIgbT3TiAetK9yU=
Date: Thu, 12 Oct 2006 14:04:22 +0000
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-rc1 update 2] drivers: add LCD support
Message-Id: <20061012140422.93e7330c.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, here it is the patch for converting the cfag12864b driver
to a framebuffer driver as Pavel requested and as I promised :)

Pavel, yep, now I can login in my tiny 128x64 LCD.
It is pretty amazing to run vi on it... ;)

Tested and working fine.
---
miguelojeda-2.6.19-rc1-add-LCD-support-update2.patch

Converts cfag12864b driver into a framebuffer one.


Brief
-----

     - Removes the auxlcdclass.
     - Removes a lot of code.
     - Adds refreshing related code.
     - Adds the cfag12864bfb module.
     - Updates documentation, .h, ...
     - Many minor changes


Patched files Index
-------------------

 CREDITS                              |    4
 Documentation/ABI/testing/cfag12864b |   56 ---
 Documentation/auxdisplay/auxdisplay  |   37 --
 Documentation/auxdisplay/cfag12864b  |  298 +-------------------
 MAINTAINERS                          |    6
 drivers/auxdisplay/Kconfig           |   48 ++-
 drivers/auxdisplay/Makefile          |    3
 drivers/auxdisplay/auxlcdclass.c     |   75 -----
 drivers/auxdisplay/cfag12864b.c      |  356 +++++--------------------
 drivers/auxdisplay/cfag12864bfb.c    |  165 +++++++++++
 drivers/auxdisplay/fbcfag12864b.c    |  226 ---------------
 drivers/auxdisplay/ks0108.c          |    2
 include/linux/auxlcdclass.h          |   33 --
 include/linux/cfag12864b.h           |   15 -
 14 files changed, 296 insertions(+), 1028 deletions(-)


miguelojeda-2.6.19-rc1-add-LCD-support-update2.patch
Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff -uprN -X dontdiff linux-2.6.19-rc1-x/CREDITS linux-2.6.19-rc1/CREDITS
--- linux-2.6.19-rc1-x/CREDITS	2006-10-10 12:57:41.000000000 +0000
+++ linux-2.6.19-rc1/CREDITS	2006-10-12 12:26:23.000000000 +0000
@@ -2564,7 +2564,9 @@ S: Australia
 
 N: Miguel Ojeda Sandonis
 E: maxextreme@gmail.com
-D: Author: LCD and LCD Controller drivers (ks0108, cfag12864b)
+D: Author: Auxiliary LCD Controller driver (ks0108)
+D: Author: Auxiliary LCD driver (cfag12864b)
+D: Author: Auxiliary LCD framebuffer driver (cfag12864bfb)
 D: Maintainer: Auxiliary display drivers tree (drivers/auxdisplay/*)
 S: C/ Mieses 20, 9-B
 S: Valladolid 47009
diff -uprN -X dontdiff linux-2.6.19-rc1-x/Documentation/ABI/testing/cfag12864b linux-2.6.19-rc1/Documentation/ABI/testing/cfag12864b
--- linux-2.6.19-rc1-x/Documentation/ABI/testing/cfag12864b	2006-10-10 12:57:41.000000000 +0000
+++ linux-2.6.19-rc1/Documentation/ABI/testing/cfag12864b	1970-01-01 00:00:00.000000000 +0000
@@ -1,56 +0,0 @@
-What:		drivers/auxdisplay/cfag12864b driver
-Date:		2006-10-06
-KernelVersion:	2.6.18
-Contact:	Miguel Ojeda Sandonis <maxextreme@gmail.com>
-Description:	
-		The cfag12864b LCD driver defines one way to communicate
-		with the lcd:
-
-		1.    Use seek and write syscalls. Bytes written appear on
-		   the screen without any formatting on the position pointed
-		   by the file offset.
-
-		      It is hardware dependent. It should be used to modify
-		   specific display's pixels to achieve higher refreshing
-		   rates.
-
-		      This method allows you to change each byte of the device,
-		   so you can achieve a higher update rate updating only the
-		   pixels you are going to change.
-
-		      The device size is 1024 == CFAG12864B_SIZE.
-
-		      You can write and seek the device. The first 512 bytes
-		   write to the first k0108 controller (left display half) and
-		   the last 512 bytes write to the second ks0108 controller
-		   (right display half).
-
-		      Each controller is divided into 8 pages.
-		      Each page has 64 addresses (bytes).
-
-		                     Controller 0 Controller 1
-		                     _________________________
-		         Page 0 --> |____________|____________|
-		         Page 1 --> |____________|____________|
-		         Page 2 --> |____________|____________|
-		         Page 3 --> |____________|____________|
-		         Page 4 --> |____________|____________|
-		         Page 5 --> |____________|____________|
-		         Page 6 --> |____________|____________|
-		         Page 7 --> |____________|____________|
-		                     <--- 64 --->
-		                       Addresses
-
-		      The beggining of the file is at controller 0, page 0,
-		   address 0.
-
-		      When you reach the position 64, you are writing to the
-		   same controller, next page, address 0.
-
-		      After 512 bytes written, you are writing to the second
-		   controller, starting at page 0 and address 0 again.
-
-		      For more information and examples, see
-		   Documentation/auxdisplay/cfag12864b
-
-Users:		
diff -uprN -X dontdiff linux-2.6.19-rc1-x/Documentation/auxdisplay/auxdisplay linux-2.6.19-rc1/Documentation/auxdisplay/auxdisplay
--- linux-2.6.19-rc1-x/Documentation/auxdisplay/auxdisplay	2006-10-10 12:57:42.000000000 +0000
+++ linux-2.6.19-rc1/Documentation/auxdisplay/auxdisplay	1970-01-01 00:00:00.000000000 +0000
@@ -1,37 +0,0 @@
-	=======================================
-	Auxiliary Display Drivers Documentation
-	=======================================
-
-License:		GPLv2
-Author & Maintainer:	Miguel Ojeda Sandonis <maxextreme@gmail.com>
-Date:			2006-10-04
-
---------
-0. INDEX
---------
-
-	1. NEW DISPLAY DRIVERS
-	2. GENERAL TIPS
-
-
-
-----------------------
-1. NEW DISPLAY DRIVERS
-----------------------
-
-Feel free to send me new display drivers. I will try to do my best.
-
-If you don't get any answer, send your patch directly to the linux-kernel ml.
-
-
-
----------------
-2. GENERAL TIPS
----------------
-
-- Divide your driver into the controller driver, like ks0108,
-  and the specific display series driver, like cfag12864b.
-
-- Claim for your IO ports in the controller driver.
-
-EOF
diff -uprN -X dontdiff linux-2.6.19-rc1-x/Documentation/auxdisplay/cfag12864b linux-2.6.19-rc1/Documentation/auxdisplay/cfag12864b
--- linux-2.6.19-rc1-x/Documentation/auxdisplay/cfag12864b	2006-10-10 12:57:42.000000000 +0000
+++ linux-2.6.19-rc1/Documentation/auxdisplay/cfag12864b	2006-10-12 12:34:31.000000000 +0000
@@ -4,7 +4,7 @@
 
 License:		GPLv2
 Author & Maintainer:	Miguel Ojeda Sandonis <maxextreme@gmail.com>
-Date:			2006-10-06
+Date:			2006-10-11
 
 
 
@@ -16,10 +16,6 @@ Date:			2006-10-06
 	2. DEVICE INFORMATION
 	3. WIRING
 	4. USER-SPACE PROGRAMMING
-		4.1. Direct writing
-	5. USEFUL FILES
-		5.1. cfag12864b.h
-		5.2. bmpwriter.h
 
 
 ---------------------
@@ -67,103 +63,27 @@ You can get help at Crystalfontz and LCD
 4. USERSPACE PROGRAMMING
 ------------------------
 
-This interface is described briefly at Documentation/ABI/testing/cfag12864b
+The cfag12864bfb describes a framebuffer driver (/dev/fbX).
 
-Include a copy of the provided header:
-
-	#include "cfag12864b.h"
-
-Open the device for writing, /dev/cfag12864b0:
-
-	FILE * fdisplay = fopen("/dev/cfag12864b0","wb");
-
-For writing to the display, you have the following options:
-		
-
-4.1. Direct writing
--------------------
-
-This method allows you to change each byte of the device,
-so you can achieve a higher update rate updating only the pixels
-you are going to change.
-
-The device size is 1024 == CFAG12864B_SIZE.
-
-You can write and seek the device. The first 512 bytes write to
-the first k0108 controller (left display half) and the last 512 bytes
-write to the second ks0108 controller (right display half).
-
-Each controller is divided into 8 pages. Each page has 64 bytes.
-
-            Controller 0 Controller 1
-            _________________________
-Page 0 --> |____________|____________|
-Page 1 --> |____________|____________|
-Page 2 --> |____________|____________|
-Page 3 --> |____________|____________|
-Page 4 --> |____________|____________|
-Page 5 --> |____________|____________|
-Page 6 --> |____________|____________|
-Page 7 --> |____________|____________|
-            <--- 64 --->
-
-The beggining of the file is at controller 0, page 0, address 0.
-
-When you reach the position 64, you are writing to the same controller,
-next page, address 0.
-
-After 512 bytes written, you are writing to the second controller, starting
-at page 0 and address 0 again.
-
-You will understand how the device work executing some commands:
-
-	Write some stuff:
-		# echo -n A > /dev/cfag12864b0
-		# echo -n a > /dev/cfag12864b0
-		# echo AAAAAA > /dev/cfag12864b0
-		# echo 000000 > /dev/cfag12864b0
-		# echo Hello world! > /dev/cfag12864b0
-		# echo Hello world! Hello world! > /dev/cfag12864b0
-
-	Clear the display:
-		# cat /dev/zero > /dev/cfag12864b0
-
-	Fill with random values:
-		# cat /dev/random > /dev/cfag12864b0
-	...
-
-After you understand it, code your functions to change specific bytes.
-
-Use functions like fwrite() and fseek() to control the device, like:
-
-	fseek(fdisplay, ipage * CFAG12864B_HEIGHT, SEEK_SET);
-	fseek(fdisplay, icontroller * CFAG12864B_SIZE / 2, SEEK_SET);
-
-	fwrite(bufpage, 1, CFAG12864B_HEIGHT, fdisplay);
-	fwrite(bufcontroller, 1, CFAG12864B_SIZE / 2, fdisplay);
-	fwrite(bufdisplay, 1, CFAG12864B_SIZE, fdisplay);
-
-	...
-
-
----------------
-5. USEFUL FILES
----------------
-
-
-5.1 cfag12864b.h
-----------------
+It has a size of 128 * 64 = 8192 bytes. Each one represents one pixel.
+If the value is 0, the pixel will turn off.
+If the greater than 0, the pixel will turn on.
+
+You may are asking why it isn't 1024 bytes long, with 1 bit per pixel.
+Well, the refreshing is made by the CPU, so it has to be as fast as
+possible. If we use 1024 bytes only, the conversion from the fb format
+to the cfag12864b hardware dependent format would use far more
+integer operations and bit operations as well.
 
 You can use a copy of this header in your userspace programs.
 
----
+---8<---
 /*
  *    Filename: cfag12864b.h
- *     Version: 0.1.0
  * Description: cfag12864b LCD Display Driver Header for user-space apps
  *
  *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
- *        Date: 2006-09-30
+ *        Date: 2006-10-11
  */
 
 #ifndef _CFAG12864B_H_
@@ -171,198 +91,10 @@ You can use a copy of this header in you
 
 #define CFAG12864B_WIDTH	(128)
 #define CFAG12864B_HEIGHT	(64)
-#define CFAG12864B_FORMATSIZE	((CFAG12864B_WIDTH)*(CFAG12864B_HEIGHT))
-#define CFAG12864B_SIZE		(1024)
+#define CFAG12864B_SIZE		((CFAG12864B_WIDTH)*(CFAG12864B_HEIGHT))
 
 #endif // _CFAG12864B_H_
----
-
-
-
-5.2 Example BMP writer
-----------------------
-
-You can take ideas from this code and start programming. I think it is useful
-for understanding how the driver can be used. It just works, don't expect
-good BMP-related code. I chose such bitmap format because it is simple.
-
-The program reads a .bmp 128x64 2-colors file, converts it to a
-boolean [128*64] buffer and then uses ioctl to display it on the screen.
-
----
-/*
- *    Filename: bmpwriter.h
- *     Version: 0.1.0
- * Description: BMP Writer sample app for cfag12864b LCD driver
- *
- *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
- *        Date: 2006-09-30
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-#include "cfag12864b.h"
-
-#define BMP_SIZE 1024
-
-union dword
-{
-	unsigned int u32;
-	unsigned char u8[4];
-};
-
-#define Bit(n)   ((unsigned char)(1<<(n)))
-
-void BMP2Format(unsigned char * src, unsigned char * dest)
-{
-	const unsigned int width = CFAG12864B_WIDTH;
-	const unsigned int height = CFAG12864B_HEIGHT;
-	const unsigned int bits = 8;
-
-	unsigned int  y,x,bit;
-
-	for(y=0; y<height; ++y)
-	for(x=0; x<width/bits; ++x)
-	for(bit=0; bit<bits; ++bit)
-		dest[x * bits + bit + (height - y - 1) * width] =
-			src[y * width / bits + x] & Bit(bits - bit - 1) ? 0 : 1;
-}
-
-void Format2cfag12864b(unsigned char * src, unsigned char * dest)
-{
-	unsigned short controller,page,address,bit;
-
-	for(controller=0; controller<2; ++controller)
-	for(page=0; page<8; ++page)
-	for(address=0; address<64; ++address) {
-		dest[(controller*8+page)*64+address]=0;
-		for(bit=0; bit<8; ++bit)
-			if(src[controller*64+address+(page*8+bit)*CFAG12864B_WIDTH])
-				dest[(controller*8+page)*64+address]|=Bit(bit);
-	}
-}
-
-int main(int argc, char * argv[])
-{
-	const unsigned int Width = CFAG12864B_WIDTH;
-	const unsigned int Height = CFAG12864B_HEIGHT;
-	const unsigned int Size = CFAG12864B_SIZE;
-	const unsigned int BPP = 1;
-	const unsigned int HeaderSize = 0x3E;
-	const unsigned int BMPSize = BMP_SIZE;
-
-	unsigned char c;
-	unsigned int i,j;
-	union dword n;
-
-	unsigned char Buffer_BMP[BMP_SIZE];
-	unsigned char Buffer_Matrix[CFAG12864B_FORMATSIZE];
-	unsigned char Buffer_cfag12864b[CFAG12864B_SIZE];
-
-	FILE * fdisplay;
-	FILE * fbmp;
-
-	// Check args
-	if(argc!=3) {
-		printf("%s: Bad number of arguments. Expected 3\n",
-			argv[0]);
-		return -1;
-	}
-	
-	// Open file
-	fbmp = fopen(argv[2],"rb");
-	if(fbmp==NULL) {
-		printf("%s: Can't open %s\n",argv[0], argv[2]);
-		return -2;
-	}
-
-	// Check file size
-	fseek(fbmp,0,SEEK_END);
-	i=ftell(fbmp);
-	if(i!=HeaderSize+Size) {
-		printf("%s: Bad file size. %i instead of %i\n",
-			argv[0], i, HeaderSize+Size);
-		fclose(fbmp);
-		return -3;
-	}
-
-	// Check both magic BMP bytes
-	fseek(fbmp,0,SEEK_SET);
-	c = fgetc(fbmp);
-	if(c!='B') {
-		printf("%s: Bad first magic byte. '%c' instead of 'B'\n",
-			argv[0], c);
-		fclose(fbmp);
-		return -4;
-	}
-	c = fgetc(fbmp);
-	if(c!='M') {
-		printf("%s: Bad second magic byte. '%c' instead of 'M'\n",
-			argv[0], c);
-		fclose(fbmp);
-		return -5;
-	}
-
-	// Check this is a 128x64 1-bpp BMP file
-	fseek(fbmp,0x12,SEEK_SET);
-	for(i=0; i<4; ++i)
-		n.u8[i] = fgetc(fbmp);
-	if(n.u32!=Width) {
-		printf("%s: Bad width. %i instead of %i\n",
-			argv[0], n.u32, Width);
-		fclose(fbmp);
-		return -6;
-	}
-	for(i=0; i<4; ++i)
-		n.u8[i] = fgetc(fbmp);
-	if(n.u32!=Height) {
-		printf("%s: Bad width. %i instead of %i\n",
-			argv[0], n.u32, Height);
-		fclose(fbmp);
-		return -7;
-	}
-	fseek(fbmp,0x1C,SEEK_SET);
-	c = fgetc(fbmp);
-	if(c!=BPP) {
-		printf("%s: Bad bpp. %i instead of %i\n",
-			argv[0], c, BPP);
-		fclose(fbmp);
-		return -8;
-	}
-
-	// Get bitmap data
-	fseek(fbmp,0x3E,SEEK_SET);
-	fread(Buffer_BMP,1,BMPSize,fbmp);
-	fclose(fbmp);
-
-	// Transform BMP data to 2D matrix
-	BMP2Format(Buffer_BMP,Buffer_Matrix);
-
-	// Transform 2D matrix to cfag12864b RAW format
-	Format2cfag12864b(Buffer_cfag12864b);
-
-	// Open file
-	fdisplay = fopen(argv[1],"wb");
-	if(fdisplay == NULL) {
-		printf("%s: Can't open %s\n", argv[0], argv[1]);
-		return -9;
-	}
-
-	// Send RAW image
-	fwrite(Buffer_cfag12864b,1,CFAG12864B_SIZE,fdisplay);
-
-	// Close file
-	fclose(fdisplay);
-
-	return 0;
-}
----
+---8<---
 
 
 EOF
diff -uprN -X dontdiff linux-2.6.19-rc1-x/drivers/auxdisplay/auxlcdclass.c linux-2.6.19-rc1/drivers/auxdisplay/auxlcdclass.c
--- linux-2.6.19-rc1-x/drivers/auxdisplay/auxlcdclass.c	2006-10-10 12:58:44.000000000 +0000
+++ linux-2.6.19-rc1/drivers/auxdisplay/auxlcdclass.c	1970-01-01 00:00:00.000000000 +0000
@@ -1,75 +0,0 @@
-/*
- *    Filename: auxlcdclass.c
- *     Version: 0.1.0
- * Description: Auxiliary LCD Class
- *     License: GPLv2
- *     Depends: -
- *
- *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
- *        Date: 2006-10-05
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
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/device.h>
-#include <linux/auxlcdclass.h>
-
-#define AUXLCDCLASS_NAME "auxlcd"
-
-/*
- * Exported Display Data
- */
-
-struct class *auxlcdclass_class;
-EXPORT_SYMBOL_GPL(auxlcdclass_class);
-
-/*
- * Module Init & Exit
- */
-
-static int __init auxlcdclass_init(void)
-{
-	int ret = -EINVAL;
-
-	auxlcdclass_class = class_create(THIS_MODULE, AUXLCDCLASS_NAME);
-	if (IS_ERR(auxlcdclass_class)) {
-		printk(KERN_ERR AUXLCDCLASS_NAME ": ERROR: "
-			"can't create %s class\n", AUXLCDCLASS_NAME);
-		goto none;
-	}
-
-	return 0;
-
-none:
-	return ret;
-}
-
-static void __exit auxlcdclass_exit(void)
-{
-	class_destroy(auxlcdclass_class);
-}
-
-module_init(auxlcdclass_init);
-module_exit(auxlcdclass_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
-MODULE_DESCRIPTION("Auxiliary LCD Class");
-
diff -uprN -X dontdiff linux-2.6.19-rc1-x/drivers/auxdisplay/cfag12864b.c linux-2.6.19-rc1/drivers/auxdisplay/cfag12864b.c
--- linux-2.6.19-rc1-x/drivers/auxdisplay/cfag12864b.c	2006-10-10 12:58:44.000000000 +0000
+++ linux-2.6.19-rc1/drivers/auxdisplay/cfag12864b.c	2006-10-12 13:35:31.000000000 +0000
@@ -3,10 +3,10 @@
  *     Version: 0.1.0
  * Description: cfag12864b LCD driver
  *     License: GPLv2
- *     Depends: auxlcdclass ks0108
+ *     Depends: ks0108
  *
  *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
- *        Date: 2006-10-06
+ *        Date: 2006-10-12
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -29,8 +29,11 @@
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/cdev.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/auxlcdclass.h>
+#include <linux/jiffies.h>
+#include <linux/workqueue.h>
+#include <linux/vmalloc.h>
 #include <linux/ks0108.h>
 #include <linux/cfag12864b.h>
 #include <asm/uaccess.h>
@@ -38,17 +41,13 @@
 #define CFAG12864B_NAME "cfag12864b"
 
 /*
- * Device
+ * Module Parameters
  */
 
-static const unsigned int cfag12864b_firstminor;
-static const unsigned int cfag12864b_ndevices = 1;
-static int cfag12864b_major;
-static int cfag12864b_minor;
-static dev_t cfag12864b_devt;
-struct cdev cfag12864b_chardevice;
-static unsigned char * cfag12864b_buffer;
-DECLARE_MUTEX(cfag12864b_mutex);
+static unsigned int cfag12864b_rate = CONFIG_CFAG12864B_RATE;
+module_param(cfag12864b_rate, uint, S_IRUGO);
+MODULE_PARM_DESC(cfag12864b_rate,
+	"Refresh rate (hertzs)");
 
 /*
  * cfag12864b Commands
@@ -69,7 +68,7 @@ DECLARE_MUTEX(cfag12864b_mutex);
  *	
  */
 
-#define bit(n)   (((unsigned char)1)<<(n))
+#define bit(n) (((unsigned char)1)<<(n))
 
 #define CFAG12864B_BIT_E	(0)
 #define CFAG12864B_BIT_CS1	(2)
@@ -112,7 +111,8 @@ static void cfag12864b_di(unsigned char 
 	cfag12864b_setbit(state, CFAG12864B_BIT_DI);
 }
 
-static void cfag12864b_setcontrollers(unsigned char first, unsigned char second)
+static void cfag12864b_setcontrollers(unsigned char first,
+	unsigned char second)
 {
 	if (first)
 		cfag12864b_cs1(0);
@@ -179,53 +179,27 @@ static void cfag12864b_nop(void)
 }
 
 /*
- * Auxiliary
+ * cfag12864b Internal Commands
  */
 
-static void normalizeoffset(unsigned int *offset)
-{
-	if (*offset >= CFAG12864B_PAGES * CFAG12864B_ADDRESSES)
-		*offset -= CFAG12864B_PAGES * CFAG12864B_ADDRESSES;
-}
-
-static unsigned char calcaddress(unsigned int offset)
-{
-	normalizeoffset(&offset);
-	return offset % CFAG12864B_ADDRESSES;
-}
-
-static unsigned char calccontroller(unsigned int offset)
-{
-	if (offset < CFAG12864B_PAGES * CFAG12864B_ADDRESSES)
-		return 0;
-	return 1;
-}
-
-static unsigned char calcpage(unsigned int offset)
-{
-	normalizeoffset(&offset);
-	return offset / CFAG12864B_ADDRESSES;
-}
-
-/*
- * cfag12864b Internal Commands (don't lock)
- */
+unsigned char *cfag12864b_buffer;
+EXPORT_SYMBOL_GPL(cfag12864b_buffer);
 
-void cfag12864b_on_nolock(void)
+static void cfag12864b_on(void)
 {
 	cfag12864b_setcontrollers(1, 1);
 	cfag12864b_displaystate(1);
 }
 
-void cfag12864b_off_nolock(void)
+static void cfag12864b_off(void)
 {
 	cfag12864b_setcontrollers(1, 1);
 	cfag12864b_displaystate(0);
 }
 
-void cfag12864b_clear_nolock(void)
+static void cfag12864b_clear(void)
 {
-	unsigned char i,j;
+	unsigned char i, j;
 
 	cfag12864b_setcontrollers(1, 1);
 	for (i = 0; i < CFAG12864B_PAGES; i++) {
@@ -236,268 +210,81 @@ void cfag12864b_clear_nolock(void)
 	}
 }
 
-void cfag12864b_write_nolock(unsigned short offset, const unsigned char *buffer,
-	unsigned short count)
-{
-	unsigned short i;
-
-	/* Invalid values: They get updated at the first cycle */
-	unsigned char controller = 0xFF;
-	unsigned char page = 0xFF;
-	unsigned char address = 0xFF;
-
-	unsigned char tmpcontroller, tmppage, tmpaddress;
-
-	if (offset > CFAG12864B_SIZE)
-		return;
-	if (count + offset > CFAG12864B_SIZE)
-		count = CFAG12864B_SIZE - offset;
-
-	for (i = 0; i < count; i++, offset++, address++) {
-		tmpcontroller = calccontroller(offset);
-		tmppage = calcpage(offset);
-		tmpaddress = calcaddress(offset);
-
-		if (controller != tmpcontroller) {
-			controller = tmpcontroller;
-			cfag12864b_controller(controller);
-			cfag12864b_nop();
-		}
-		if (page != tmppage) {
-			page = tmppage;
-			cfag12864b_page(page);
-			cfag12864b_nop();
-		}
-
-		/* Safe method, still quick */
-		cfag12864b_address(tmpaddress);
-		cfag12864b_nop();
-
-		/* Dummy */
-		cfag12864b_nop();
-
-		cfag12864b_writebyte(buffer[i]);
-	}
-}
-
-void cfag12864b_format_nolock(unsigned char *src)
-{
-	unsigned short i, j, k, n;
-
-	for (i = 0; i < CFAG12864B_CONTROLLERS; i++)
-	for (j = 0; j < CFAG12864B_PAGES; j++)
-	for (k = 0; k < CFAG12864B_ADDRESSES; k++) {
-		cfag12864b_buffer[(i * CFAG12864B_PAGES + j) * CFAG12864B_ADDRESSES + k] = 0;
-		for (n = 0; n < 8; n++)
-			if (src[i * CFAG12864B_ADDRESSES + k + (j * 8 + n) * CFAG12864B_WIDTH])
-				cfag12864b_buffer[(i * CFAG12864B_PAGES + j) * CFAG12864B_ADDRESSES + k] |= bit(n);
-	}
-
-	cfag12864b_write_nolock(0, cfag12864b_buffer, CFAG12864B_SIZE);
-}
-
-/*
- * cfag12864b Exported Commands (do lock)
- */
-
-void cfag12864b_on(void)
-{
-	if (down_interruptible(&cfag12864b_mutex))
-		return;
-
-	cfag12864b_on_nolock();
-
-	up(&cfag12864b_mutex);
-}
-
-void cfag12864b_off(void)
-{
-	if (down_interruptible(&cfag12864b_mutex))
-		return;
-
-	cfag12864b_off_nolock();
-
-	up (&cfag12864b_mutex);
-}
-
-void cfag12864b_clear(void)
-{
-	if (down_interruptible(&cfag12864b_mutex))
-		return;
-
-	cfag12864b_clear_nolock();
-
-	up(&cfag12864b_mutex);
-}
-
-void cfag12864b_write(unsigned short offset, const unsigned char *buffer,
-	unsigned short count)
-{
-	if (down_interruptible(&cfag12864b_mutex))
-		return;
-
-	cfag12864b_write_nolock(offset, buffer, count);
-
-	up(&cfag12864b_mutex);
-}
-
-void cfag12864b_format(unsigned char *src)
-{
-	if (down_interruptible(&cfag12864b_mutex))
-		return;
-
-	cfag12864b_format_nolock(src);
-
-	up(&cfag12864b_mutex);
-}
-
-EXPORT_SYMBOL_GPL(cfag12864b_on);
-EXPORT_SYMBOL_GPL(cfag12864b_off);
-EXPORT_SYMBOL_GPL(cfag12864b_clear);
-EXPORT_SYMBOL_GPL(cfag12864b_write);
-EXPORT_SYMBOL_GPL(cfag12864b_format);
-
 /*
- * cfag12864b_fops (do lock)
+ * Update work
  */
 
-static loff_t cfag12864b_fopseek(struct file *filp, loff_t offset, int whence)
-{
-	loff_t ret = -EINVAL;
-
-	if (down_interruptible(&cfag12864b_mutex))
-		return -ERESTARTSYS;
+static void cfag12864b_update(void *arg);
+static struct workqueue_struct *cfag12864b_workqueue;
+DECLARE_WORK(cfag12864b_work, cfag12864b_update, NULL);
 
-	switch (whence) {
-	case SEEK_SET:
-		ret = offset;
-		break;
-	case SEEK_CUR:
-		ret = filp->f_pos + offset;
-		break;
-	case SEEK_END:
-		ret = CFAG12864B_SIZE + offset;
-		break;
-	}
+static unsigned char cfag12864b_updating;
 
-	if (ret < 0) {
-		ret = -EINVAL;
-		goto none;
-	}
-
-	filp->f_pos = ret;
-
-none:
-	up(&cfag12864b_mutex);
-	return ret;
-}
-
-
-static ssize_t cfag12864b_fopwrite(struct file *filp,
-	const char __user *buffer, size_t count, loff_t *offset)
+static void cfag12864b_update(void *arg)
 {
-	int ret = -EINVAL;
-	int result;
-
-	if (down_interruptible(&cfag12864b_mutex))
-		return -ERESTARTSYS;
+	unsigned char c;
+	unsigned short i, j, k, b;
 
-	if (*offset > CFAG12864B_SIZE) {
-		ret = 0;
-		goto none;
-	}
-	if (*offset + count > CFAG12864B_SIZE)
-		count = CFAG12864B_SIZE - *offset;
-
-	result = copy_from_user(cfag12864b_buffer, buffer, count);
-	if (result != 0) {
-		printk(KERN_ERR CFAG12864B_NAME ": FOP write: ERROR: "
-			"can't copy memory from user\n");
-		ret = -EFAULT;
-		goto none;
+	for (i = 0; i < CFAG12864B_CONTROLLERS; i++) {
+		cfag12864b_controller(i);
+		cfag12864b_nop();
+		for (j = 0; j < CFAG12864B_PAGES; j++) {
+			cfag12864b_page(j);
+			cfag12864b_nop();
+			for (k = 0; k < CFAG12864B_ADDRESSES; k++) {
+				cfag12864b_address(k);
+				cfag12864b_nop();
+				cfag12864b_nop();
+				for (c = 0, b = 0; b < 8; b++)
+					if (cfag12864b_buffer
+						[i * CFAG12864B_ADDRESSES
+						+ k + (j * 8 + b) *
+						CFAG12864B_WIDTH])
+						c |= bit(b);
+				cfag12864b_writebyte(c);
+			}
+		}
 	}
 
-	cfag12864b_write_nolock(*offset, cfag12864b_buffer, count);
-
-	*offset += count;
-	ret = count;
-
-none:
-	up(&cfag12864b_mutex);
-	return ret;
+	if(cfag12864b_updating)
+		queue_delayed_work(cfag12864b_workqueue, &cfag12864b_work,
+			HZ / cfag12864b_rate);
 }
 
-static const struct file_operations cfag12864b_fops =
-{
-	.owner = THIS_MODULE,
-	.llseek = cfag12864b_fopseek,
-	.write = cfag12864b_fopwrite,
-};
-
 /*
  * Module Init & Exit
  */
 
 static int __init cfag12864b_init(void)
 {
-	int result;
 	int ret = -EINVAL;
 
-	cfag12864b_buffer = kmalloc(sizeof(unsigned char) * CFAG12864B_SIZE,
-		GFP_KERNEL);
+	cfag12864b_buffer = vmalloc(sizeof(unsigned char) *
+		CFAG12864B_SIZE);
 	if (cfag12864b_buffer == NULL) {
 		printk(KERN_ERR CFAG12864B_NAME ": ERROR: "
-			"can't alloc buffer (%i bytes)\n", CFAG12864B_SIZE);
+			"can't alloc buffer (%i bytes)\n",
+			CFAG12864B_SIZE);
 		ret = -ENOMEM;
 		goto none;
 	}
 
-	result = alloc_chrdev_region(&cfag12864b_devt, cfag12864b_firstminor,
-		cfag12864b_ndevices, CFAG12864B_NAME);
-	if (result < 0) {
-		printk(KERN_ERR CFAG12864B_NAME ": ERROR: "
-			"can't alloc the char device region\n");
-		ret = result;
-		goto bufferalloced;
-	}
-
-	cfag12864b_major = MAJOR(cfag12864b_devt);
-	cfag12864b_minor = cfag12864b_firstminor;
-	cfag12864b_devt = MKDEV(cfag12864b_major, cfag12864b_minor);
-
-	cfag12864b_clear_nolock();
-	cfag12864b_on_nolock();
-
-	cdev_init(&cfag12864b_chardevice, &cfag12864b_fops);
-	cfag12864b_chardevice.owner = THIS_MODULE;
-	cfag12864b_chardevice.ops = &cfag12864b_fops;
-	result = cdev_add(&cfag12864b_chardevice, cfag12864b_devt,
-		cfag12864b_ndevices);
-	if (result < 0) {
-		printk(KERN_ERR CFAG12864B_NAME ": ERROR: "
-			"unable to add a new char device\n");
-		ret = result;
-		goto regionalloced;
-	}
+	memset(cfag12864b_buffer, 0, CFAG12864B_SIZE);
 
-	if (class_device_create(auxlcdclass_class, NULL, cfag12864b_devt, NULL,
-		"cfag12864b%d", cfag12864b_minor) == NULL) {
-		printk(KERN_ERR CFAG12864B_NAME ": ERROR: "
-			"unable to create a class device for the auxlcdclass\n");
-		ret = -EINVAL;
-		goto cdevadded;
-	}
+	cfag12864b_clear();
+	cfag12864b_on();
 
-	return 0;
+	cfag12864b_workqueue = create_singlethread_workqueue(CFAG12864B_NAME);
+	if(cfag12864b_workqueue == NULL)
+		goto bufferalloced;
 
-cdevadded:
-	cdev_del(&cfag12864b_chardevice);
+	cfag12864b_updating = 1;
+	cfag12864b_update(NULL);
 
-regionalloced:
-	unregister_chrdev_region(cfag12864b_devt, cfag12864b_ndevices);
+	return 0;
 
 bufferalloced:
-	kfree(cfag12864b_buffer);
+	vfree(cfag12864b_buffer);
 
 none:
 	return ret;
@@ -505,17 +292,18 @@ none:
 
 static void __exit cfag12864b_exit(void)
 {
-	cfag12864b_off_nolock();
+	cfag12864b_updating = 0;
+	mdelay((1000 / cfag12864b_rate) * 2);
+	destroy_workqueue(cfag12864b_workqueue);
+
+	cfag12864b_off();
 
-	class_device_destroy(auxlcdclass_class, cfag12864b_devt);
-	cdev_del(&cfag12864b_chardevice);
-	unregister_chrdev_region(cfag12864b_devt, cfag12864b_ndevices);
-	kfree(cfag12864b_buffer);
+	vfree(cfag12864b_buffer);
 }
 
 module_init(cfag12864b_init);
 module_exit(cfag12864b_exit);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
 MODULE_DESCRIPTION("cfag12864b LCD driver");
diff -uprN -X dontdiff linux-2.6.19-rc1-x/drivers/auxdisplay/cfag12864bfb.c linux-2.6.19-rc1/drivers/auxdisplay/cfag12864bfb.c
--- linux-2.6.19-rc1-x/drivers/auxdisplay/cfag12864bfb.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.19-rc1/drivers/auxdisplay/cfag12864bfb.c	2006-10-12 12:15:17.000000000 +0000
@@ -0,0 +1,165 @@
+/*
+ *    Filename: cfag12864bfb.c
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD framebuffer driver
+ *     License: GPLv2
+ *     Depends: cfag12864b
+ *
+ *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-10-11
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
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/cfag12864b.h>
+#include <asm/uaccess.h>
+
+#define CFAG12864BFB_NAME "cfag12864bfb"
+
+static struct fb_fix_screeninfo cfag12864bfb_fix __initdata = {
+	.id = "cfag12864b", 
+	.type = FB_TYPE_PACKED_PIXELS,
+	.visual = FB_VISUAL_MONO10,
+	.xpanstep = 0,
+	.ypanstep = 0,
+	.ywrapstep = 0,
+	.line_length = CFAG12864B_WIDTH,
+	.accel = FB_ACCEL_NONE,
+};
+
+static struct fb_var_screeninfo cfag12864bfb_var __initdata = {
+	.xres = CFAG12864B_WIDTH,
+	.yres = CFAG12864B_HEIGHT,
+	.xres_virtual = CFAG12864B_WIDTH,
+	.yres_virtual = CFAG12864B_HEIGHT,
+	.bits_per_pixel = 8,
+	.red = { 0, 8, 0 },
+      	.green = { 0, 8, 0 },
+      	.blue = { 0, 8, 0 },
+	.left_margin = 0,
+	.right_margin = 0,
+	.upper_margin = 0,
+	.lower_margin = 0,
+	.vmode = FB_VMODE_NONINTERLACED,
+};
+
+static struct fb_ops cfag12864bfb_ops = {
+	.owner = THIS_MODULE,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+};
+
+static int __init cfag12864bfb_probe(struct platform_device *device)
+{
+	int ret = -EINVAL;
+ 	struct fb_info *info = framebuffer_alloc(0, &device->dev);
+
+	if (!info)
+		goto none;
+
+	info->screen_base = (char __iomem *)cfag12864b_buffer;
+	info->screen_size = CFAG12864B_SIZE;
+	info->fbops = &cfag12864bfb_ops;
+	info->fix = cfag12864bfb_fix;
+	info->var = cfag12864bfb_var;
+	info->pseudo_palette = NULL;
+	info->par = NULL;
+	info->flags = FBINFO_FLAG_DEFAULT;
+
+	if (register_framebuffer(info) < 0)
+		goto fballoced;
+
+	platform_set_drvdata(device, info);
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node,
+		info->fix.id);
+
+	return 0;
+
+fballoced:
+	framebuffer_release(info);
+
+none:
+	return ret;
+}
+
+static int cfag12864bfb_remove(struct platform_device *device)
+{
+	struct fb_info *info = platform_get_drvdata(device);
+
+	if (info) {
+		unregister_framebuffer(info);
+		framebuffer_release(info);
+	}
+
+	return 0;
+}
+
+static struct platform_driver cfag12864bfb_driver = {
+	.probe	= cfag12864bfb_probe,
+	.remove = cfag12864bfb_remove,
+	.driver = {
+		.name	= CFAG12864BFB_NAME,
+	},
+};
+
+static struct platform_device *cfag12864bfb_device;
+
+static int __init cfag12864bfb_init(void)
+{
+	int ret = platform_driver_register(&cfag12864bfb_driver);
+
+	if (!ret) {
+		cfag12864bfb_device =
+			platform_device_alloc(CFAG12864BFB_NAME, 0);
+
+		if (cfag12864bfb_device)
+			ret = platform_device_add(cfag12864bfb_device);
+		else
+			ret = -ENOMEM;
+
+		if (ret) {
+			platform_device_put(cfag12864bfb_device);
+			platform_driver_unregister(&cfag12864bfb_driver);
+		}
+	}
+
+	return ret;
+}
+
+static void __exit cfag12864bfb_exit(void)
+{
+	platform_device_unregister(cfag12864bfb_device);
+	platform_driver_unregister(&cfag12864bfb_driver);
+}
+
+module_init(cfag12864bfb_init);
+module_exit(cfag12864bfb_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("cfag12864b LCD framebuffer driver");
diff -uprN -X dontdiff linux-2.6.19-rc1-x/drivers/auxdisplay/fbcfag12864b.c linux-2.6.19-rc1/drivers/auxdisplay/fbcfag12864b.c
--- linux-2.6.19-rc1-x/drivers/auxdisplay/fbcfag12864b.c	2006-10-10 12:58:44.000000000 +0000
+++ linux-2.6.19-rc1/drivers/auxdisplay/fbcfag12864b.c	1970-01-01 00:00:00.000000000 +0000
@@ -1,226 +0,0 @@
-/*
- *    Filename: fbcfag12864b.c
- *     Version: 0.1.0
- * Description: cfag12864b LCD framebuffer device
- *     License: GPLv2
- *     Depends: cfag12864b
- *
- *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
- *        Date: 2006-10-10
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
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/fb.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-
-#include <asm/uaccess.h>
-#include "sdum.h"
-#include "fbcommon.h"
-
-static u32 colreg[16];
-
-static struct fb_var_screeninfo rgbfb_var __initdata = {
-	.xres = LCD_X_RES,
-	.yres = LCD_Y_RES,
-	.xres_virtual = LCD_X_RES,
-	.yres_virtual = LCD_Y_RES,
-	.bits_per_pixel = 32,
-	.red.offset = 16,
-	.red.length = 8,
-	.green.offset = 8,
-	.green.length = 8,
-	.blue.offset = 0,
-	.blue.length = 8,
-	.left_margin = 0,
-	.right_margin = 0,
-	.upper_margin = 0,
-	.lower_margin = 0,
-	.vmode = FB_VMODE_NONINTERLACED,
-};
-static struct fb_fix_screeninfo rgbfb_fix __initdata = {
-	.id = "RGBFB",
-	.line_length = LCD_X_RES * LCD_BBP,
-	.type = FB_TYPE_PACKED_PIXELS,
-	.visual = FB_VISUAL_TRUECOLOR,
-	.xpanstep = 0,
-	.ypanstep = 0,
-	.ywrapstep = 0,
-	.accel = FB_ACCEL_NONE,
-};
-
-static int channel_owned;
-
-static int no_cursor(struct fb_info *info, struct fb_cursor *cursor)
-{
-	return 0;
-}
-
-static int rgbfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-			   u_int transp, struct fb_info *info)
-{
-	if (regno > 15)
-		return 1;
-
-	colreg[regno] = ((red & 0xff00) << 8) | (green & 0xff00) |
-	    ((blue & 0xff00) >> 8);
-	return 0;
-}
-
-static int rgbfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
-{
-	return pnx4008_sdum_mmap(info, vma, NULL);
-}
-
-static struct fb_ops rgbfb_ops = {
-	.fb_mmap = rgbfb_mmap,
-	.fb_setcolreg = rgbfb_setcolreg,
-	.fb_fillrect = cfb_fillrect,
-	.fb_copyarea = cfb_copyarea,
-	.fb_imageblit = cfb_imageblit,
-};
-
-static int rgbfb_remove(struct platform_device *pdev)
-{
-	struct fb_info *info = platform_get_drvdata(pdev);
-
-	if (info) {
-		unregister_framebuffer(info);
-		fb_dealloc_cmap(&info->cmap);
-		framebuffer_release(info);
-		platform_set_drvdata(pdev, NULL);
-		kfree(info);
-	}
-
-	pnx4008_free_dum_channel(channel_owned, pdev->id);
-	pnx4008_set_dum_exit_notification(pdev->id);
-
-	return 0;
-}
-
-static int __devinit rgbfb_probe(struct platform_device *pdev)
-{
-	struct fb_info *info;
-	struct dumchannel_uf chan_uf;
-	int ret;
-	char *option;
-
-	info = framebuffer_alloc(sizeof(u32) * 16, &pdev->dev);
-	if (!info) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	pnx4008_get_fb_addresses(FB_TYPE_RGB, (void **)&info->screen_base,
-				 (dma_addr_t *) &rgbfb_fix.smem_start,
-				 &rgbfb_fix.smem_len);
-
-	if ((ret = pnx4008_alloc_dum_channel(pdev->id)) < 0)
-		goto err0;
-	else {
-		channel_owned = ret;
-		chan_uf.channelnr = channel_owned;
-		chan_uf.dirty = (u32 *) NULL;
-		chan_uf.source = (u32 *) rgbfb_fix.smem_start;
-		chan_uf.x_offset = 0;
-		chan_uf.y_offset = 0;
-		chan_uf.width = LCD_X_RES;
-		chan_uf.height = LCD_Y_RES;
-
-		if ((ret = pnx4008_put_dum_channel_uf(chan_uf, pdev->id))< 0)
-			goto err1;
-
-		if ((ret =
-		     pnx4008_set_dum_channel_sync(channel_owned, CONF_SYNC_ON,
-						  pdev->id)) < 0)
-			goto err1;
-
-		if ((ret =
-		     pnx4008_set_dum_channel_dirty_detect(channel_owned,
-							 CONF_DIRTYDETECTION_ON,
-							 pdev->id)) < 0)
-			goto err1;
-	}
-
-	if (!fb_get_options("pnxrgbfb", &option) && !strcmp(option, "nocursor"))
-		rgbfb_ops.fb_cursor = no_cursor;
-
-	info->node = -1;
-	info->flags = FBINFO_FLAG_DEFAULT;
-	info->fbops = &rgbfb_ops;
-	info->fix = rgbfb_fix;
-	info->var = rgbfb_var;
-	info->screen_size = rgbfb_fix.smem_len;
-	info->pseudo_palette = info->par;
-	info->par = NULL;
-
-	ret = fb_alloc_cmap(&info->cmap, 256, 0);
-	if (ret < 0)
-		goto err2;
-
-	ret = register_framebuffer(info);
-	if (ret < 0)
-		goto err3;
-	platform_set_drvdata(pdev, info);
-
-	return 0;
-
-err3:
-	fb_dealloc_cmap(&info->cmap);
-err2:
-	framebuffer_release(info);
-err1:
-	pnx4008_free_dum_channel(channel_owned, pdev->id);
-err0:
-	kfree(info);
-err:
-	return ret;
-}
-
-static struct platform_driver rgbfb_driver = {
-	.driver = {
-		.name = "rgbfb",
-	},
-	.probe = rgbfb_probe,
-	.remove = rgbfb_remove,
-};
-
-static int __init fbcfag12864b_init(void)
-{
-	return platform_driver_register(&rgbfb_driver);
-}
-
-static void __exit fbcfag12864b_exit(void)
-{
-	platform_driver_unregister(&rgbfb_driver);
-}
-
-module_init(fbcfag12864b_init);
-module_exit(fbcfag12864b_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
-MODULE_DESCRIPTION("cfag12864b LCD driver");
diff -uprN -X dontdiff linux-2.6.19-rc1-x/drivers/auxdisplay/Kconfig linux-2.6.19-rc1/drivers/auxdisplay/Kconfig
--- linux-2.6.19-rc1-x/drivers/auxdisplay/Kconfig	2006-10-10 12:58:44.000000000 +0000
+++ linux-2.6.19-rc1/drivers/auxdisplay/Kconfig	2006-10-12 13:33:50.000000000 +0000
@@ -7,25 +7,10 @@
 
 menu "Auxiliary Display support"
 
-config AUXLCDCLASS
-	tristate "Auxiliary LCD support"
-	default n
-	---help---
-	  If you have a LCD (Liquid Crystal Display), say Y.
-
-	  To compile this as a module, choose M here:
-	  the module will be called auxlcdclass.
-
-	  Most LCD drivers use an I/O port (like the parallel port)
-	  so you will need to say Y or M for them.
-
-	  If unsure, say N.
-
-comment "Parallel port dependent"
-
 config KS0108
 	tristate "KS0108 LCD Controller"
-	depends on AUXLCDCLASS && PARPORT
+	select PARPORT
+	select PARPORT_PC
 	default n
 	---help---
 	  If you have a LCD controlled by one or more KS0108
@@ -94,10 +79,37 @@ config CFAG12864B
 	  Also, you can find help in Crystalfontz and LCDStudio forums.
 	  Check Documentation/lcddisplay/cfag12864b for more information.
 
+	  The LCD framebuffer driver can be attached to a console.
+	  It will work fine. However, you can't attach it to the fbdev driver
+	  of the xorg server.
+
 	  To compile this as a module, choose M here:
-	  the module will be called cfag12864b.
+	  the modules will be called cfag12864b and cfag12864bfb.
 
 	  If unsure, say N.
 
+config CFAG12864B_RATE
+	int "Refresh rate (hertzs)"
+	depends on CFAG12864B
+	default "10"
+	---help---
+	  Refresh rate of the LCD.
+
+	  As the LCD is not memory mapped, the driver has to make the work by
+	  software. This means you should be careful setting this value higher.
+	  If your CPUs are slow or you feel the CPUs are working above your %,
+	  decrease the value.
+
+	  Hints:
+	     Pentium4 3Ghz at 10 Hz uses about 15% CPU time.
+	     Pentium4 3Ghz at 20 Hz uses about 30% CPU time.
+
+	  Be careful modifying this value to a very high value:
+	  You can freeze the computer.
+
+	  If you don't know what I'm talking about, ignore it.
+
+	  If you compile this as a module, you can still override this
+	  value using the module parameters.
 endmenu
 
diff -uprN -X dontdiff linux-2.6.19-rc1-x/drivers/auxdisplay/ks0108.c linux-2.6.19-rc1/drivers/auxdisplay/ks0108.c
--- linux-2.6.19-rc1-x/drivers/auxdisplay/ks0108.c	2006-10-10 12:58:44.000000000 +0000
+++ linux-2.6.19-rc1/drivers/auxdisplay/ks0108.c	2006-10-11 23:20:33.000000000 +0000
@@ -161,7 +161,7 @@ static void __exit ks0108_exit(void)
 module_init(ks0108_init);
 module_exit(ks0108_exit);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
 MODULE_DESCRIPTION("ks0108 LCD Controller driver");
 
diff -uprN -X dontdiff linux-2.6.19-rc1-x/drivers/auxdisplay/Makefile linux-2.6.19-rc1/drivers/auxdisplay/Makefile
--- linux-2.6.19-rc1-x/drivers/auxdisplay/Makefile	2006-10-10 14:59:46.000000000 +0000
+++ linux-2.6.19-rc1/drivers/auxdisplay/Makefile	2006-10-11 15:51:37.000000000 +0000
@@ -2,6 +2,5 @@
 # Makefile for the kernel auxiliary displays device drivers.
 #
 
-obj-$(CONFIG_AUXLCDCLASS)	+= auxlcdclass.o
 obj-$(CONFIG_KS0108)		+= ks0108.o
-obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o
+obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o cfag12864bfb.o
diff -uprN -X dontdiff linux-2.6.19-rc1-x/include/linux/auxlcdclass.h linux-2.6.19-rc1/include/linux/auxlcdclass.h
--- linux-2.6.19-rc1-x/include/linux/auxlcdclass.h	2006-10-10 12:59:00.000000000 +0000
+++ linux-2.6.19-rc1/include/linux/auxlcdclass.h	1970-01-01 00:00:00.000000000 +0000
@@ -1,33 +0,0 @@
-/*
- *    Filename: auxlcdclass.h
- *     Version: 0.1.0
- * Description: Auxiliary LCD Class Header
- *     License: GPLv2
- *
- *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
- *        Date: 2006-10-05
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
- */
-
-#ifndef _AUXLCDCLASS_H_
-#define _AUXLCDCLASS_H_
-
-#include <linux/device.h>
-
-extern struct class *auxlcdclass_class;
-
-#endif /* _AUXLCDCLASS_H_ */
diff -uprN -X dontdiff linux-2.6.19-rc1-x/include/linux/cfag12864b.h linux-2.6.19-rc1/include/linux/cfag12864b.h
--- linux-2.6.19-rc1-x/include/linux/cfag12864b.h	2006-10-10 12:59:00.000000000 +0000
+++ linux-2.6.19-rc1/include/linux/cfag12864b.h	2006-10-12 12:30:58.000000000 +0000
@@ -5,7 +5,7 @@
  *     License: GPLv2
  *
  *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
- *        Date: 2006-10-04
+ *        Date: 2006-10-12
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -28,21 +28,12 @@
 
 #define CFAG12864B_WIDTH	(128)
 #define CFAG12864B_HEIGHT	(64)
-#define CFAG12864B_MATRIXSIZE	((CFAG12864B_WIDTH) * (CFAG12864B_HEIGHT))
-
 #define CFAG12864B_CONTROLLERS	(2)
 #define CFAG12864B_PAGES	(8)
 #define CFAG12864B_ADDRESSES	(64)
-#define CFAG12864B_SIZE		((CFAG12864B_CONTROLLERS) * \
-				(CFAG12864B_PAGES) * \
-				(CFAG12864B_ADDRESSES))
+#define CFAG12864B_SIZE		((CFAG12864B_WIDTH)*(CFAG12864B_HEIGHT))
 
-extern void cfag12864b_on(void);
-extern void cfag12864b_off(void);
-extern void cfag12864b_clear(void);
-extern void cfag12864b_write(unsigned short offset,
-	const unsigned char *buffer, unsigned short count);
-extern void cfag12864b_format(unsigned char *src);
+extern unsigned char * cfag12864b_buffer;
 
 #endif /* _CFAG12864B_H_ */
 
diff -uprN -X dontdiff linux-2.6.19-rc1-x/MAINTAINERS linux-2.6.19-rc1/MAINTAINERS
--- linux-2.6.19-rc1-x/MAINTAINERS	2006-10-10 12:57:42.000000000 +0000
+++ linux-2.6.19-rc1/MAINTAINERS	2006-10-12 12:24:08.000000000 +0000
@@ -658,6 +658,12 @@ M:	maxextreme@gmail.com
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+CFAG12864BFB LCD FRAMEBUFFER DRIVER
+P:	Miguel Ojeda Sandonis
+M:	maxextreme@gmail.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 COMMON INTERNET FILE SYSTEM (CIFS)
 P:	Steve French
 M:	sfrench@samba.org
