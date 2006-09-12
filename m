Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWILRc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWILRc1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWILRc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:32:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:46206 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030204AbWILRcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:32:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=iHn2XAh+qXfluS5TmH4/KRy99h72ctHhvU32UtgeWzDQvFCdv2lPOu7TjeHkd/CAeaCakw9RfvWpndVUXrvf2cwscuyu3DsLVAxGFkQvDvKPeTZd0XbMv7PfALcuXADpVkeEd47w7L6OWjHH79osXa5+W/K5uGd3nH6n9mZYtHw=
Date: Tue, 12 Sep 2006 19:32:12 +0200
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: greg@kroah.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH V3] LCD Display Driver lcddisplay, ks0108, cfag12864b
Message-Id: <20060912193212.1407209b.maxextreme@gmail.com>
Organization: -
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda Sandonis

Adds support for LCD Display devices.
Adds support for the ks0108 LCD Controller.
Adds support for the cfag12864b LCD Display.

Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/CREDITS linux-2.6.17.13/CREDITS
--- linux-2.6.17.13-vanilla/CREDITS	2006-09-09 05:23:25.000000000 +0200
+++ linux-2.6.17.13/CREDITS	2006-09-12 19:28:06.000000000 +0200
@@ -2534,6 +2534,14 @@ S: Subiaco, 6008
 S: Perth, Western Australia
 S: Australia
 
+N: Miguel Ojeda Sandonis
+E: maxextreme@gmail.com
+D: Author: LCD Display Drivers (ks0108, cfag12864b)
+D: Maintainer: LCD Display Drivers Tree (drivers/lcddisplay/*)
+S: C/ Mieses 20, 9-B
+S: Valladolid 47009
+S: Spain
+
 N: Greg Page
 E: gpage@sovereign.org
 D: IPX development and support
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/Documentation/drivers/lcddisplay/cfag12864b linux-2.6.17.13/Documentation/drivers/lcddisplay/cfag12864b
--- linux-2.6.17.13-vanilla/Documentation/drivers/lcddisplay/cfag12864b	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17.13/Documentation/drivers/lcddisplay/cfag12864b	2006-09-12 18:58:32.000000000 +0200
@@ -0,0 +1,368 @@
+	===============================
+	cfag12864b Driver Documentation
+	===============================
+
+License:		GPL
+Author & Maintainer:	Miguel Ojeda Sandonis <maxextreme@gmail.com>
+Date:			2006-09-12
+
+
+
+--------
+0. INDEX
+--------
+
+	1. DEVICE INFORMATION
+	2. WIRING
+	3. USER-SPACE PROGRAMMING
+		3.1. ioctl and a 128*64 boolean matrix
+		3.2. Direct writing
+	4. USEFUL FILES
+		4.1. cfag12864b.h
+		4.2. bmpwriter.h
+
+
+
+---------------------
+1. DEVICE INFORMATION
+---------------------
+
+Manufacturer:	Crystalfontz
+Webpage:	http://www.crystalfontz.com
+Device Webpage:	http://www.crystalfontz.com/products/12864b/
+Type:		LCD Display
+Width:		128
+Height:		64
+Colors:		2
+Controller:	ks0108
+Controllers:	2
+Pages:		8 each controller
+Addresses:	64 each page
+
+
+
+---------
+2. WIRING
+---------
+
+The cfag12864b LCD Display Series don't have a official wiring.
+
+The common wiring is done to the parallel port:
+
+http://www.skippari.net/lcd/sekalaista/crystalfontz_cfag12864B-TMI-V.png
+
+You can get help at Crystalfontz and LCDInfo forums.
+
+
+
+-------------------------
+3. USER-SPACE PROGRAMMING
+-------------------------
+
+Include a copy of the provided header:
+
+	#include "cfag12864b.h"
+
+Open the device for writing, /dev/cfag12864b0:
+
+	int fd = open("/dev/cfag12864b0",O_WRONLY);
+
+Then use simple ioctl calls to control it:
+
+	ioctl(fdisplay,CFAG12864B_IOCOFF);	/* Turn off (don't clear) */
+	ioctl(fdisplay,CFAG12864B_IOCON);	/* Turn on */
+	ioctl(fdisplay,CFAG12864B_IOCCLEAR);	/* Clear the display */
+
+For writing to the display, you have two options:
+
+
+3.1. ioctl & 128*64 boolean matrix
+-------------------------------------------------------
+
+This method is easier, but you have to update the entire display
+each time you want to change it.
+
+Note:
+
+	CFAG12864B_FORMATSIZE ==
+	CFAG12864B_WIDTH * CFAG12864B_HEIGHT ==
+	128 * 64
+
+Declare the matrix and other one:
+
+	unsigned char MyDrawing[CFAG12864B_WIDTH][CFAG12864B_HEIGHT];
+
+	unsigned char Buffer[CFAG12864B_FORMATSIZE];
+
+Copy the 2d matrix to the buffer , like:
+
+	for(i=0;i<CFAG12864B_WIDTH;++i)
+		for(j=0;j<CFAG12864B_HEIGHT;++j)
+			Buffer[i+j*CFAG12864B_WIDTH]=MyDrawing[i][j];
+
+Call the ioctl:
+
+	ioctl(fdisplay,CFAG12864B_IOCFORMAT,Buffer);
+
+Voila! Your drawing should appear on the screen.
+
+
+
+3.2. Direct writing
+-------------------
+
+This methods allows you to change each byte of the device,
+so you can achieve a higher update rate.
+
+The device size is 1024 == CFAG12864B_SIZE.
+
+You can write and seek the device. The first 512 bytes write to
+the first k0108 controller (left display half) and the last 512 bytes
+write to the second ks0108 controller (right display half).
+
+Each controller is divided into 8 pages. Each page has 64 bytes.
+
+        Controller 0 Controller 1
+        _________________________
+Page 0 |____________|____________|
+Page 1 |____________|____________|
+Page 2 |____________|____________|
+Page 3 |____________|____________|
+Page 4 |____________|____________|
+Page 5 |____________|____________|
+Page 6 |____________|____________|
+Page 7 |____________|____________|
+        <--- 64 --->
+
+You will understand how the device work executing some commands:
+
+	# echo -n A > /dev/cfag12864b0
+	# echo -n a > /dev/cfag12864b0
+	# echo AAAAAA > /dev/cfag12864b0
+	# echo 000000 > /dev/cfag12864b0
+	# echo Hello world! > /dev/cfag12864b0
+	# echo Hello world! Hello world! > /dev/cfag12864b0
+
+After you understand it, code your functions to change specific bytes.
+
+Use write() and lseek() system calls, like:
+
+	lseek(fdisplay,ipage*CFAG12864B_HEIGHT,SEEK_SET);
+	lseek(fdisplay,icontroller*CFAG12864B_SIZE/2,SEEK_SET);
+
+	write(fdisplay,bufpage,CFAG12864B_HEIGHT);
+	write(fdisplay,bufcontroller,CFAG12864B_SIZE/2);
+	write(fdisplay,bufdisplay,CFAG12864B_SIZE);
+
+
+---------------
+4. USEFUL FILES
+---------------
+
+
+4.1 cfag12864b.h
+----------------
+
+You can use a copy of this header in your user-space programs.
+
+---
+/*
+ *    Filename: cfag12864b.h
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD Display Driver Header for user-space apps
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-12
+ */
+
+#ifndef _CFAG12864B_H_
+#define _CFAG12864B_H_
+
+#include <sys/ioctl.h>
+
+#define CFAG12864B_WIDTH 128
+#define CFAG12864B_HEIGHT 64
+#define CFAG12864B_FORMATSIZE CFAG12864B_WIDTH*CFAG12864B_HEIGHT
+#define CFAG12864B_SIZE 1024
+
+#define CFAG12864B_IOC_MAGIC	0xFF
+
+#define CFAG12864B_IOCOFF	_IO(CFAG12864B_IOC_MAGIC,0)
+#define CFAG12864B_IOCON	_IO(CFAG12864B_IOC_MAGIC,1)
+#define CFAG12864B_IOCCLEAR	_IO(CFAG12864B_IOC_MAGIC,2)
+#define CFAG12864B_IOCFORMAT	_IOW(CFAG12864B_IOC_MAGIC,3,void *)
+
+#endif // _CFAG12864B_H_
+---
+
+
+
+4.2 Example BMP writer
+----------------------
+
+You can take ideas from this code. It reads a .bmp file,
+convert it to a boolean [128*64] buffer and then use
+ioctl to display it on the screen.
+
+---
+/*
+ *    Filename: bmpwriter.h
+ *     Version: 0.1.0
+ * Description: BMP Writer sample app
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-12
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include "cfag12864b.h"
+
+#define BMP_SIZE 1024
+
+union dword
+{
+	unsigned int u32;
+	unsigned char u8[4];
+};
+
+#define Bit(n)   ((unsigned char)(1<<(n)))
+
+void BMP2Format(
+	unsigned char _Src[BMP_SIZE],
+	unsigned char _Dest[CFAG12864B_FORMATSIZE])
+{
+	const unsigned int Width = CFAG12864B_WIDTH;
+	const unsigned int Height = CFAG12864B_HEIGHT;
+	const unsigned int Bits = 8;
+
+	unsigned int  Y,X,Bit;
+
+	for(Y=0; Y<Height; ++Y)
+	for(X=0; X<Width/Bits; ++X)
+	for(Bit=0; Bit<Bits; ++Bit)
+		_Dest[X*Bits+Bit+(Height-Y-1)*Width] =
+			_Src[Y*Width/Bits+X]&Bit(Bits-Bit-1)?0:1;
+}
+
+int main(int argc, char * argv[])
+{
+	const unsigned int Width = CFAG12864B_WIDTH;
+	const unsigned int Height = CFAG12864B_HEIGHT;
+	const unsigned int Size = CFAG12864B_SIZE;
+	const unsigned int BPP = 1;
+	const unsigned int HeaderSize = 0x3E;
+	const unsigned int BMPSize = BMP_SIZE;
+
+	unsigned char c;
+	unsigned int i,j;
+	union dword n;
+
+	unsigned char Buffer_BMP[BMP_SIZE];
+	unsigned char Buffer_Matrix[CFAG12864B_FORMATSIZE];
+
+	int fdisplay;
+	FILE * fbmp;
+
+	// Check args
+	if(argc!=3) {
+		printf("%s: Bad number of arguments. Expected 3\n",
+			argv[0]);
+		return -1;
+	}
+	
+	// Open file
+	fbmp = fopen(argv[2],"rb");
+	if(fbmp==NULL) {
+		printf("%s: Can't open %s\n",argv[0], argv[2]);
+		return -2;
+	}
+
+	// Check file size
+	fseek(fbmp,0,SEEK_END);
+	i=ftell(fbmp);
+	if(i!=HeaderSize+Size) {
+		printf("%s: Bad file size. %i instead of %i\n",
+			argv[0], i, HeaderSize+Size);
+		fclose(fbmp);
+		return -3;
+	}
+
+	// Check both magic BMP bytes
+	fseek(fbmp,0,SEEK_SET);
+	c = fgetc(fbmp);
+	if(c!='B') {
+		printf("%s: Bad first magic byte. '%c' instead of 'B'\n",
+			argv[0], c);
+		fclose(fbmp);
+		return -4;
+	}
+	c = fgetc(fbmp);
+	if(c!='M') {
+		printf("%s: Bad second magic byte. '%c' instead of 'M'\n",
+			argv[0], c);
+		fclose(fbmp);
+		return -5;
+	}
+
+	// Check this is a 128x64 1-bpp BMP file
+	fseek(fbmp,0x12,SEEK_SET);
+	for(i=0; i<4; ++i)
+		n.u8[i] = fgetc(fbmp);
+	if(n.u32!=Width) {
+		printf("%s: Bad width. %i instead of %i\n",
+			argv[0], n.u32, Width);
+		fclose(fbmp);
+		return -6;
+	}
+	for(i=0; i<4; ++i)
+		n.u8[i] = fgetc(fbmp);
+	if(n.u32!=Height) {
+		printf("%s: Bad width. %i instead of %i\n",
+			argv[0], n.u32, Height);
+		fclose(fbmp);
+		return -7;
+	}
+	fseek(fbmp,0x1C,SEEK_SET);
+	c = fgetc(fbmp);
+	if(c!=BPP) {
+		printf("%s: Bad bpp. %i instead of %i\n",
+			argv[0], c, BPP);
+		fclose(fbmp);
+		return -8;
+	}
+
+	// Get bitmap data
+	fseek(fbmp,0x3E,SEEK_SET);
+	for(i=0; i<BMPSize; ++i)
+		Buffer_BMP[i]=fgetc(fbmp);
+	fclose(fbmp);
+
+	// Transform BMP data to 2D matrix
+	BMP2Format(Buffer_BMP,Buffer_Matrix);
+
+	// Open file
+	fdisplay = open(argv[1],O_WRONLY);
+	if(fdisplay < 0) {
+		printf("%s: Can't open %s\n", argv[0], argv[1]);
+		return -9;
+	}
+
+	// Send matrix
+	ioctl(fdisplay,CFAG12864B_IOCFORMAT,Buffer_Matrix);
+
+	// Close file
+	close(fdisplay);
+
+	return 0;
+}
+---
+
+
+EOF
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/Documentation/drivers/lcddisplay/lcddisplay linux-2.6.17.13/Documentation/drivers/lcddisplay/lcddisplay
--- linux-2.6.17.13-vanilla/Documentation/drivers/lcddisplay/lcddisplay	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17.13/Documentation/drivers/lcddisplay/lcddisplay	2006-09-12 18:56:56.000000000 +0200
@@ -0,0 +1,37 @@
+	=================================
+	LCD Display Drivers Documentation
+	=================================
+
+License:		GPL
+Author & Maintainer:	Miguel Ojeda Sandonis <maxextreme@gmail.com>
+Date:			2006-09-12
+
+--------
+0. INDEX
+--------
+
+	1. NEW DISPLAY DRIVERS
+	2. GENERAL TIPS
+
+
+
+----------------------
+1. NEW DISPLAY DRIVERS
+----------------------
+
+Feel free to send me new display drivers. I will try to do my best.
+
+If you don't get any answer, send your patch directly to the linux-kernel ml.
+
+
+
+---------------
+2. GENERAL TIPS
+---------------
+
+- Divide your driver into the controller driver, like ks0108,
+  and the specific LCD display series driver, like cfag12864b.
+
+- Claim for your IO ports in the controller driver.
+
+EOF
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/Documentation/ioctl-number.txt linux-2.6.17.13/Documentation/ioctl-number.txt
--- linux-2.6.17.13-vanilla/Documentation/ioctl-number.txt	2006-09-09 05:23:25.000000000 +0200
+++ linux-2.6.17.13/Documentation/ioctl-number.txt	2006-09-12 04:53:09.000000000 +0200
@@ -190,3 +190,5 @@ Code	Seq#	Include File		Comments
 					<mailto:aherrman@de.ibm.com>
 0xF3	00-3F	video/sisfb.h		sisfb (in development)
 					<mailto:thomas@winischhofer.net>
+0xFF	00-1F	cfag12864b LCD Display	linux/cfag12864b.h
+					<mailto:maxextreme@gmail.com>
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/drivers/Kconfig linux-2.6.17.13/drivers/Kconfig
--- linux-2.6.17.13-vanilla/drivers/Kconfig	2006-09-09 05:23:25.000000000 +0200
+++ linux-2.6.17.13/drivers/Kconfig	2006-09-12 19:12:15.000000000 +0200
@@ -72,4 +72,8 @@ source "drivers/edac/Kconfig"
 
 source "drivers/rtc/Kconfig"
 
+# parport before lcddisplay - some displays depend on it.
+
+source "drivers/lcddisplay/Kconfig"
+
 endmenu
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/drivers/lcddisplay/cfag12864b.c linux-2.6.17.13/drivers/lcddisplay/cfag12864b.c
--- linux-2.6.17.13-vanilla/drivers/lcddisplay/cfag12864b.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17.13/drivers/lcddisplay/cfag12864b.c	2006-09-12 19:05:06.000000000 +0200
@@ -0,0 +1,558 @@
+/*
+ *    Filename: cfag12864b.c
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD Display Driver
+ *     License: GPL
+ *     Depends: lcddisplay ks0108
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-12
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/lcddisplay.h>
+#include <linux/ks0108.h>
+#include <linux/cfag12864b.h>
+#include <asm/uaccess.h>
+
+#define NAME "cfag12864b"
+#define PRINTK_PREFIX  KERN_INFO NAME ": "
+
+
+
+/*
+ * Device
+ */
+
+static const unsigned int cfag12864b_firstminor = 0;
+static const unsigned int cfag12864b_ndevices = 1;
+static const char * cfag12864b_name = NAME;
+
+static int cfag12864b_major;
+static int cfag12864b_minor;
+static dev_t cfag12864b_device;
+struct cdev cfag12864b_chardevice;
+
+
+
+
+/*
+ * cfag12864b Commands
+ */
+
+#define bit(n) ((unsigned char)(1<<(n)))
+#define nobit(n) ((unsigned char)(~bit(n)))
+static const unsigned int cfag12864b_bits = 8;
+
+static const unsigned int cfag12864b_width = CFAG12864B_WIDTH;
+static const unsigned int cfag12864b_height = CFAG12864B_HEIGHT;
+static const unsigned int cfag12864b_matrixsize = CFAG12864B_MATRIXSIZE;
+static const unsigned int cfag12864b_controllers = CFAG12864B_CONTROLLERS;
+static const unsigned int cfag12864b_pages = CFAG12864B_PAGES;
+static const unsigned int cfag12864b_addresses = CFAG12864B_ADDRESSES;
+static const unsigned int cfag12864b_size = CFAG12864B_SIZE;
+
+static unsigned char cfag12864b_state = 0;
+
+static void cfag12864b_set(void)
+{
+	ks0108_writecontrol(cfag12864b_state);
+}
+
+static void cfag12864b_e(unsigned char state)
+{
+	if(state)
+		cfag12864b_state |= bit(0);
+	else
+		cfag12864b_state &= nobit(0);
+	cfag12864b_set();
+}
+
+static void cfag12864b_cs1(unsigned char state)
+{
+	if(state)
+		cfag12864b_state |= bit(2);
+	else
+		cfag12864b_state &= nobit(2);
+	cfag12864b_set();
+}
+
+static void cfag12864b_cs2(unsigned char state)
+{
+	if(state)
+		cfag12864b_state |= bit(1);
+	else
+		cfag12864b_state &= nobit(1);
+	cfag12864b_set();
+}
+
+static void cfag12864b_di(unsigned char state)
+{
+	if(state)
+		cfag12864b_state |= bit(3);
+	else
+		cfag12864b_state &= nobit(3);
+	cfag12864b_set();
+}
+
+static void cfag12864b_firstcontroller(unsigned char state)
+{
+	if(state)
+		cfag12864b_cs1(0);
+	else
+		cfag12864b_cs1(1);
+}
+
+static void cfag12864b_secondcontroller(unsigned char state)
+{
+	if(state)
+		cfag12864b_cs2(0);
+	else
+		cfag12864b_cs2(1);
+}
+
+static void cfag12864b_setcontrollers(unsigned char first, unsigned char second)
+{
+	cfag12864b_firstcontroller(first);
+	cfag12864b_secondcontroller(second);
+}
+
+static void cfag12864b_controller(unsigned char which)
+{
+	if(which==0)
+		cfag12864b_setcontrollers(1,0);
+	else if(which==1)
+		cfag12864b_setcontrollers(0,1);
+}
+
+static void cfag12864b_displaystate(unsigned char state)
+{
+	cfag12864b_di(0);
+	cfag12864b_e(1);
+	ks0108_displaystate(state);
+	cfag12864b_e(0);
+}
+
+static void cfag12864b_address(unsigned char address)
+{
+	cfag12864b_di(0);
+	cfag12864b_e(1);
+	ks0108_address(address);
+	cfag12864b_e(0);
+}
+
+static void cfag12864b_page(unsigned char page)
+{
+	cfag12864b_di(0);
+	cfag12864b_e(1);
+	ks0108_page(page);
+	cfag12864b_e(0);
+}
+
+static void cfag12864b_startline(unsigned char startline)
+{
+	cfag12864b_di(0);
+	cfag12864b_e(1);
+	ks0108_startline(startline);
+	cfag12864b_e(0);
+}
+
+static void cfag12864b_writebyte(unsigned char byte)
+{
+	cfag12864b_di(1);
+	cfag12864b_e(1);
+	ks0108_writedata(byte);
+	cfag12864b_e(0);
+}
+
+static void cfag12864b_nop(void)
+{
+	cfag12864b_startline(0);
+}
+
+
+
+/*
+ * Auxiliar
+ */
+
+static void normalizeoffset(unsigned int * offset)
+{
+	if(*offset>=cfag12864b_pages*cfag12864b_addresses)
+		*offset-=cfag12864b_pages*cfag12864b_addresses;
+}
+
+static unsigned char calcaddress(unsigned int offset)
+{
+	normalizeoffset(&offset);
+	return offset%cfag12864b_addresses;
+}
+
+static unsigned char calccontroller(unsigned int offset)
+{
+	if(offset<cfag12864b_pages*cfag12864b_addresses)
+		return 0;
+	return 1;
+}
+
+static unsigned char calcpage(unsigned int offset)
+{
+	normalizeoffset(&offset);
+	return offset/cfag12864b_addresses;
+}
+
+
+
+/*
+ * cfag12864b Exported Commands
+ */
+
+void cfag12864b_on(void)
+{
+	cfag12864b_setcontrollers(1,1);
+	cfag12864b_displaystate(1);
+}
+
+void cfag12864b_off(void)
+{
+	cfag12864b_setcontrollers(1,1);
+	cfag12864b_displaystate(0);
+}
+
+void cfag12864b_clear(void)
+{
+	unsigned char page,address;
+
+	cfag12864b_setcontrollers(1,1);
+	for(page=0; page<cfag12864b_pages; ++page) {
+		cfag12864b_page(page);
+		cfag12864b_address(0);
+		for(address=0; address<cfag12864b_addresses; ++address)
+			cfag12864b_writebyte(0);
+	}
+}
+
+void cfag12864b_write(
+	unsigned short offset,
+	unsigned char * buffer,
+	unsigned short count)
+{
+	unsigned short i;
+
+	/* Invalid values: They get updated at the first cycle */
+	unsigned char controller = 0xFF;
+	unsigned char page = 0xFF;
+	unsigned char address = 0xFF;
+
+	unsigned char tmpcontroller, tmppage, tmpaddress;
+
+	for(i=0; i<count; ++i, ++offset, ++address) {
+		tmpcontroller = calccontroller(offset);
+		tmppage = calcpage(offset);
+		tmpaddress = calcaddress(offset);
+
+		if(controller != tmpcontroller) {
+			controller = tmpcontroller;
+			cfag12864b_controller(controller);
+			cfag12864b_nop();
+		}
+		if(page != tmppage) {
+			page = tmppage;
+			cfag12864b_page(page);
+			cfag12864b_nop();
+		}
+
+		/*if(address != tmpaddress) {
+			address = tmpaddress;
+			cfag12864b_address(address);
+			cfag12864b_nop();
+		}*/
+
+		/*if(tmpcontroller == 0) {
+			if(address != tmpaddress) {
+				address = tmpaddress;
+				cfag12864b_address(address);
+			}
+		}
+		else {
+			cfag12864b_address(tmpaddress);
+			cfag12864b_nop();
+		}*/
+
+		/* Safe method, still quick */
+		cfag12864b_address(tmpaddress);
+		cfag12864b_nop();
+
+		/* Dummy */
+		cfag12864b_nop();
+
+		cfag12864b_writebyte(buffer[i]);
+	}
+}
+
+void cfag12864b_format(unsigned char * src)
+{
+	unsigned short controller,page,address,bit;
+	unsigned char * dest;
+
+	dest = kmalloc(sizeof(unsigned char)*cfag12864b_size,GFP_KERNEL);
+	if(dest == NULL) {
+		printk(PRINTK_PREFIX "format: ERROR: "
+			"can't alloc memory %i bytes\n",
+			sizeof(unsigned char)*cfag12864b_size);
+		return;
+	}
+
+	for(controller=0; controller<cfag12864b_controllers; ++controller)
+	for(page=0; page<cfag12864b_pages; ++page)
+	for(address=0; address<cfag12864b_addresses; ++address) {
+		dest[(controller*cfag12864b_pages+page)*cfag12864b_addresses+address]=0;
+		for(bit=0; bit<cfag12864b_bits; ++bit)
+			if(src[controller*cfag12864b_addresses+address+(page*cfag12864b_bits+bit)*cfag12864b_width])
+				dest[(controller*cfag12864b_pages+page)*cfag12864b_addresses+address]|=bit(bit);
+	}
+
+	cfag12864b_write(0,dest,cfag12864b_size);
+
+	kfree(dest);
+}
+
+EXPORT_SYMBOL_GPL(cfag12864b_on);
+EXPORT_SYMBOL_GPL(cfag12864b_off);
+EXPORT_SYMBOL_GPL(cfag12864b_clear);
+EXPORT_SYMBOL_GPL(cfag12864b_write);
+EXPORT_SYMBOL_GPL(cfag12864b_format);
+
+
+/*
+ * cfag12864b_fops
+ */
+
+static loff_t cfag12864b_fopseek(
+	struct file * filp,
+	loff_t offset,
+	int whence)
+{
+	loff_t new;
+
+	switch(whence) {
+	case 0: /* SEEK_SET */
+		new = offset;
+		break;
+	case 1: /* SEEK_CUR */
+		new = filp->f_pos + offset;
+		break;
+	case 2: /* SEEK_END */
+		new = cfag12864b_size + offset;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if(new < 0)
+		return -EINVAL;
+	filp->f_pos = new;
+	return new;
+}
+
+
+static ssize_t cfag12864b_fopwrite(
+	struct file * filp,
+	const char __user * buffer,
+	size_t count,
+	loff_t * offset)
+{
+	int ret = -EINVAL;
+	int result;
+	char * tmpbuffer;
+
+	if(*offset>cfag12864b_size)
+		return 0;
+	if(*offset+count>cfag12864b_size)
+		count=cfag12864b_size-*offset;
+
+	tmpbuffer = kmalloc(count,GFP_KERNEL);
+	if(tmpbuffer == NULL) {
+		printk(PRINTK_PREFIX "FOP write: ERROR: "
+			"can't alloc memory %i bytes\n",count);
+		ret = -ENOMEM;
+		goto none;
+	}
+
+	result = copy_from_user(tmpbuffer, buffer, count);
+	if(result != 0) {
+		printk(PRINTK_PREFIX "FOP write: ERROR: "
+			"can't copy memory from user\n");
+		ret = -EFAULT;
+		goto bufferalloced;
+	}
+
+	cfag12864b_write(*offset, tmpbuffer, count);
+
+	*offset += count;
+	ret = count;
+
+bufferalloced:
+	kfree(tmpbuffer);
+
+none:
+	return ret;
+}
+
+static int cfag12864b_fopioctlformat(unsigned long arg)
+{
+	int result;
+	int ret = -ENOTTY;
+
+	unsigned char * tmpbuffer;
+
+	tmpbuffer = kmalloc(
+		sizeof(unsigned char)*cfag12864b_matrixsize,GFP_KERNEL);
+	if(tmpbuffer == NULL) {
+		printk(PRINTK_PREFIX "FOP ioctl: ERROR: "
+			"can't alloc memory %i bytes\n",
+			sizeof(unsigned char)*cfag12864b_matrixsize);
+		goto none;
+	}
+
+	result = copy_from_user(
+		tmpbuffer,
+		(void __user *)arg,
+		sizeof(unsigned char)*cfag12864b_matrixsize);
+	if(result != 0) {
+		printk(PRINTK_PREFIX "FOP ioctl: ERROR: "
+			"can't copy memory from user\n");
+		goto bufferalloced;
+	}
+	
+	cfag12864b_format(tmpbuffer);
+
+	ret = 0;
+
+bufferalloced:
+	kfree(tmpbuffer);
+
+none:
+	return ret;
+}
+
+static int cfag12864b_fopioctl(
+	struct inode * inode,
+	struct file * filp,
+	unsigned int cmd,
+	unsigned long arg)
+{
+	if(_IOC_TYPE(cmd) != CFAG12864B_IOC_MAGIC)
+		return -ENOTTY;
+	if(_IOC_NR(cmd) > CFAG12864B_IOC_MAXNR)
+		return -ENOTTY;
+
+	switch(cmd) {
+	case CFAG12864B_IOCON:
+		cfag12864b_on();
+		break;
+	case CFAG12864B_IOCOFF:
+		cfag12864b_off();
+		break;
+	case CFAG12864B_IOCCLEAR:
+		cfag12864b_clear();
+		break;
+	case CFAG12864B_IOCFORMAT:
+		return cfag12864b_fopioctlformat(arg);
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+
+static struct file_operations cfag12864b_fops =
+{
+	.owner = THIS_MODULE,
+	.llseek = cfag12864b_fopseek,
+	.write = cfag12864b_fopwrite,
+	.ioctl = cfag12864b_fopioctl,
+};
+
+
+/*
+ * Module Init & Exit
+ */
+
+static int __init cfag12864b_init_module(void)
+{
+	int result;
+	int ret = -EINVAL;
+
+	result = alloc_chrdev_region(
+		&cfag12864b_device, cfag12864b_firstminor,
+		cfag12864b_ndevices, cfag12864b_name);
+	if(result < 0) {
+		printk(PRINTK_PREFIX "ERROR: "
+			"can't alloc the char device region\n");
+		ret = result;
+		goto none;
+	}
+
+	cfag12864b_major = MAJOR(cfag12864b_device);
+	cfag12864b_minor = cfag12864b_firstminor;
+	cfag12864b_device = MKDEV(cfag12864b_major,cfag12864b_minor);
+
+	cfag12864b_clear();
+	cfag12864b_on();
+
+	cdev_init(&cfag12864b_chardevice,&cfag12864b_fops);
+	cfag12864b_chardevice.owner = THIS_MODULE;
+	cfag12864b_chardevice.ops = &cfag12864b_fops;
+	result = cdev_add(
+		&cfag12864b_chardevice,
+		cfag12864b_device, cfag12864b_ndevices);
+	if(result < 0) {
+		printk(PRINTK_PREFIX "ERROR: "
+			"unable to add a new char device\n");
+		ret = result;
+		goto regionalloced;
+	}
+
+	class_device_create(
+		lcddisplay_class,NULL,
+		cfag12864b_device,
+		NULL,"cfag12864b%d",cfag12864b_minor);
+
+	printk(PRINTK_PREFIX "Inited\n");
+
+	return 0;
+
+regionalloced:
+	unregister_chrdev_region(cfag12864b_device, cfag12864b_ndevices);
+
+none:
+	return ret;
+}
+
+static void cfag12864b_exit_module(void)
+{
+	cfag12864b_off();
+
+	class_device_destroy(lcddisplay_class,cfag12864b_device);
+	cdev_del(&cfag12864b_chardevice);
+	unregister_chrdev_region(cfag12864b_device, cfag12864b_ndevices);
+
+	printk(PRINTK_PREFIX "Exited\n");
+}
+
+module_init(cfag12864b_init_module);
+module_exit(cfag12864b_exit_module);
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("cfag12864b");
+
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/drivers/lcddisplay/Kconfig linux-2.6.17.13/drivers/lcddisplay/Kconfig
--- linux-2.6.17.13-vanilla/drivers/lcddisplay/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17.13/drivers/lcddisplay/Kconfig	2006-09-12 19:13:44.000000000 +0200
@@ -0,0 +1,61 @@
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+# LCD Display drivers configuration.
+#
+
+menu "LCD Display support"
+
+config LCDDISPLAY
+	tristate "LCD Display support"
+	default n
+	---help---
+	  If you have a LCD display, say Y.
+
+	  To compile this as a module, choose M here:
+	  module will be called lcddisplay.
+
+	  If unsure, say N.
+
+comment "Parallel port dependent:"
+
+config KS0108
+	tristate "KS0108 LCD Controller"
+	depends on LCDDISPLAY && PARPORT
+	default n
+	---help---
+	  If you have a LCD display controlled by one or more KS0108
+	  controllers, say Y. You will need also another more specific
+	  driver for your LCD.
+
+	  Depends on Parallel Port support. If you say Y at
+	  parport, you will be able to compile this as a module (M)
+	  and built-in as well (Y). If you said M at parport,
+	  you will be able only to compile this as a module (M).
+
+	  To compile this as a module, choose M here:
+	  module will be called ks0108.
+
+	  If unsure, say N.
+
+config CFAG12864B
+	tristate "CFAG12864B LCD Display"
+	depends on KS0108
+	default n
+	---help---
+	  If you have a Crystalfontz 128x64 2-color LCD display,
+	  cfag12864b Series, say Y. You also need the ks0108 LCD
+	  Controller driver.
+
+	  For help about how to wire your LCD to the parallel port,
+	  check this image: http://www.skippari.net/lcd/sekalaista
+	                    /crystalfontz_cfag12864B-TMI-V.png
+
+	  To compile this as a module, choose M here:
+	  module will be called cfag12864b.
+
+	  If unsure, say N.
+
+endmenu
+
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/drivers/lcddisplay/ks0108.c linux-2.6.17.13/drivers/lcddisplay/ks0108.c
--- linux-2.6.17.13-vanilla/drivers/lcddisplay/ks0108.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17.13/drivers/lcddisplay/ks0108.c	2006-09-12 19:05:58.000000000 +0200
@@ -0,0 +1,175 @@
+/*
+ *    Filename: ks0108.c
+ *     Version: 0.1.0
+ * Description: ks0108 LCD Display Controller Driver
+ *     License: GPL
+ *     Depends: parport
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-12
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/delay.h>
+#include <linux/parport.h>
+#include <linux/ks0108.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+
+#define NAME "ks0108"
+#define PRINTK_PREFIX  KERN_INFO NAME ": "
+
+
+
+/*
+ * Module Parameters
+ */
+
+static unsigned int ks0108_port = 0x378;
+module_param(ks0108_port,uint,S_IRUGO);
+
+
+
+/*
+ * Device
+ */
+
+static const char * ks0108_name = NAME;
+
+static struct parport * ks0108_parport;
+static struct pardevice * ks0108_pardevice;
+
+
+
+/*
+ * ks0108 Exported cmds
+ */
+
+#define bit(n)   ((unsigned char)(1<<(n)))
+
+void ks0108_writedata(unsigned char byte)
+{
+	parport_write_data(ks0108_parport,byte);
+}
+
+void ks0108_writecontrol(unsigned char byte)
+{
+	const unsigned int ecycledelay = 2;
+	udelay(ecycledelay);
+	parport_write_control(ks0108_parport,byte^(bit(3)|bit(1)|bit(0)));
+}
+
+void ks0108_displaystate(unsigned char state)
+{
+	unsigned char cmd = bit(1) | bit(2) | bit(3) | bit(4) | bit(5);
+	if(state)
+		cmd |= bit(0);
+	ks0108_writedata(cmd);
+}
+
+void ks0108_startline(unsigned char startline)
+{
+	const unsigned char maxstartline = 63;
+	unsigned char cmd = bit(6) | bit(7);
+	if(startline>maxstartline)
+		startline=maxstartline;
+	cmd |= startline;
+	ks0108_writedata(cmd);
+}
+
+void ks0108_address(unsigned char address)
+{
+	const unsigned char maxaddress = 63;
+	unsigned char cmd = bit(6);
+	if(address>maxaddress)
+		address=maxaddress;
+	cmd |= address;
+	ks0108_writedata(cmd);
+}
+
+void ks0108_page(unsigned char page)
+{
+	const unsigned char maxpage = 7;
+	unsigned char cmd = bit(3) | bit(4) | bit(5) | bit(7);
+	if(page>maxpage)
+		page=maxpage;
+	cmd |= page;
+	ks0108_writedata(cmd);
+}
+
+
+EXPORT_SYMBOL_GPL(ks0108_writedata);
+EXPORT_SYMBOL_GPL(ks0108_writecontrol);
+EXPORT_SYMBOL_GPL(ks0108_displaystate);
+EXPORT_SYMBOL_GPL(ks0108_startline);
+EXPORT_SYMBOL_GPL(ks0108_address);
+EXPORT_SYMBOL_GPL(ks0108_page);
+
+
+
+
+/*
+ * Module Init & Exit
+ */
+
+static int __init ks0108_init_module(void)
+{
+	int result;
+	int ret = -EINVAL;
+
+	ks0108_parport = parport_find_base(ks0108_port);
+	if(ks0108_parport == NULL) {
+		printk(PRINTK_PREFIX "ERROR: "
+			"parport didn't find %i port\n",ks0108_port);
+		goto none;
+	}
+
+	ks0108_pardevice = parport_register_device(
+		ks0108_parport,ks0108_name,
+		NULL,NULL,NULL,
+		PARPORT_DEV_EXCL,NULL);
+	if(ks0108_pardevice == NULL) {
+		printk(PRINTK_PREFIX "ERROR: "
+			"parport didn't register new device\n");
+		goto none;
+	}
+
+	result = parport_claim(ks0108_pardevice);
+	if(result != 0) {
+		printk(PRINTK_PREFIX "ERROR: "
+			"can't claim %i parport, maybe in use\n",ks0108_port);
+		ret = result;
+		goto registered;
+	}
+
+	printk(PRINTK_PREFIX "Inited\n");
+	return 0;
+
+registered:
+	parport_unregister_device(ks0108_pardevice);
+
+none:
+	return ret;
+}
+
+static void __exit ks0108_exit_module(void)
+{
+	parport_release(ks0108_pardevice);
+	parport_unregister_device(ks0108_pardevice);
+	
+	printk(PRINTK_PREFIX "Exited\n");
+}
+
+module_init(ks0108_init_module);
+module_exit(ks0108_exit_module);
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("ks0108");
+
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/drivers/lcddisplay/lcddisplay.c linux-2.6.17.13/drivers/lcddisplay/lcddisplay.c
--- linux-2.6.17.13-vanilla/drivers/lcddisplay/lcddisplay.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17.13/drivers/lcddisplay/lcddisplay.c	2006-09-12 19:06:36.000000000 +0200
@@ -0,0 +1,71 @@
+/*
+ *    Filename: lcddisplay.c
+ *     Version: 0.1.0
+ * Description: LCD Display Class
+ *     License: GPL
+ *     Depends: -
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-12
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/lcddisplay.h>
+
+#define NAME "lcddisplay"
+#define PRINTK_PREFIX KERN_INFO NAME ": "
+
+static char * lcddisplay_name = NAME;
+
+
+/*
+ * Exported Display Data
+ */
+
+struct class * lcddisplay_class;
+EXPORT_SYMBOL_GPL(lcddisplay_class);
+
+
+/*
+ * Module Init & Exit
+ */
+
+static int __init lcddisplay_init_module(void)
+{
+	int ret = -EINVAL;
+
+	lcddisplay_class = class_create(THIS_MODULE,lcddisplay_name);
+	if(IS_ERR(lcddisplay_class)) {
+		printk(PRINTK_PREFIX "ERROR: "
+			"can't create %s class\n",lcddisplay_name);
+		goto none;
+	}
+
+	printk(PRINTK_PREFIX "Inited\n");
+
+	return 0;
+
+none:
+	return ret;
+}
+
+static void __exit lcddisplay_exit_module(void)
+{
+	class_destroy(lcddisplay_class);
+
+	printk(PRINTK_PREFIX "Exited\n");
+}
+
+module_init(lcddisplay_init_module);
+module_exit(lcddisplay_exit_module);
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("lcddisplay");
+
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/drivers/lcddisplay/Makefile linux-2.6.17.13/drivers/lcddisplay/Makefile
--- linux-2.6.17.13-vanilla/drivers/lcddisplay/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17.13/drivers/lcddisplay/Makefile	2006-09-12 19:01:04.000000000 +0200
@@ -0,0 +1,7 @@
+#
+# Makefile for the kernel LCD Display device drivers.
+#
+
+obj-$(CONFIG_LCDDISPLAY)	+= lcddisplay.o
+obj-$(CONFIG_KS0108)		+= ks0108.o
+obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/drivers/Makefile linux-2.6.17.13/drivers/Makefile
--- linux-2.6.17.13-vanilla/drivers/Makefile	2006-09-09 05:23:25.000000000 +0200
+++ linux-2.6.17.13/drivers/Makefile	2006-09-12 19:16:32.000000000 +0200
@@ -74,3 +74,4 @@ obj-$(CONFIG_SGI_SN)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
+obj-$(CONFIG_LCDDISPLAY)	+= lcddisplay/
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/include/linux/cfag12864b.h linux-2.6.17.13/include/linux/cfag12864b.h
--- linux-2.6.17.13-vanilla/include/linux/cfag12864b.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17.13/include/linux/cfag12864b.h	2006-09-12 19:07:44.000000000 +0200
@@ -0,0 +1,45 @@
+/*
+ *    Filename: cfag12864b.h
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD Display Driver Header
+ *     License: GPL
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-12
+ */
+
+#ifndef _CFAG12864B_H_
+#define _CFAG12864B_H_
+
+#include <linux/ioctl.h>
+
+#define CFAG12864B_WIDTH	128
+#define CFAG12864B_HEIGHT	64
+#define CFAG12864B_MATRIXSIZE	CFAG12864B_WIDTH*CFAG12864B_HEIGHT
+
+#define CFAG12864B_CONTROLLERS	2
+#define CFAG12864B_PAGES	8
+#define CFAG12864B_ADDRESSES	64
+#define CFAG12864B_SIZE		CFAG12864B_CONTROLLERS * \
+				CFAG12864B_PAGES * \
+				CFAG12864B_ADDRESSES
+
+#define CFAG12864B_IOC_MAGIC	0xFF
+#define CFAG12864B_IOC_MAXNR	0x03
+
+#define CFAG12864B_IOCOFF	_IO(CFAG12864B_IOC_MAGIC,0)
+#define CFAG12864B_IOCON	_IO(CFAG12864B_IOC_MAGIC,1)
+#define CFAG12864B_IOCCLEAR	_IO(CFAG12864B_IOC_MAGIC,2)
+#define CFAG12864B_IOCFORMAT	_IOW(CFAG12864B_IOC_MAGIC,3,void *)
+
+extern void cfag12864b_on(void);
+extern void cfag12864b_off(void);
+extern void cfag12864b_clear(void);
+extern void cfag12864b_write(
+	unsigned short offset,
+	unsigned char * buffer,
+	unsigned short count);
+extern void cfag12864b_format(unsigned char * src);
+
+#endif /* _CFAG12864B_H_ */
+
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/include/linux/ks0108.h linux-2.6.17.13/include/linux/ks0108.h
--- linux-2.6.17.13-vanilla/include/linux/ks0108.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17.13/include/linux/ks0108.h	2006-09-12 19:07:25.000000000 +0200
@@ -0,0 +1,21 @@
+/*
+ *    Filename: ks0108.h
+ *     Version: 0.1.0
+ * Description: ks0108 LCD Display Controller Driver Header
+ *     License: GPL
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-12
+ */
+
+#ifndef _KS0108_H_
+#define _KS0108_H_
+
+extern void ks0108_writedata(unsigned char byte);
+extern void ks0108_writecontrol(unsigned char byte);
+extern void ks0108_displaystate(unsigned char state);
+extern void ks0108_startline(unsigned char startline);
+extern void ks0108_address(unsigned char address);
+extern void ks0108_page(unsigned char page);
+
+#endif /* _KS0108_H_ */
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/include/linux/lcddisplay.h linux-2.6.17.13/include/linux/lcddisplay.h
--- linux-2.6.17.13-vanilla/include/linux/lcddisplay.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17.13/include/linux/lcddisplay.h	2006-09-12 19:07:07.000000000 +0200
@@ -0,0 +1,19 @@
+/*
+ *    Filename: lcddisplay.h
+ *     Version: 0.1.0
+ * Description: Display Class Header
+ *     License: GPL
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-12
+ */
+
+#ifndef _LCDDISPLAY_H_
+#define _LCDDISPLAY_H_
+
+#include <linux/device.h>
+
+extern struct class * lcddisplay_class;
+
+#endif /* _LCDDISPLAY_H_ */
+
diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/MAINTAINERS linux-2.6.17.13/MAINTAINERS
--- linux-2.6.17.13-vanilla/MAINTAINERS	2006-09-09 05:23:25.000000000 +0200
+++ linux-2.6.17.13/MAINTAINERS	2006-09-12 19:27:46.000000000 +0200
@@ -1640,6 +1640,11 @@ M:	James.Bottomley@HansenPartnership.com
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
+LCD DISPLAY DRIVERS
+P:	Miguel Ojeda Sandonis
+M:	maxextreme@gmail.com
+S:	Maintained
+
 LED SUBSYSTEM
 P:	Richard Purdie
 M:	rpurdie@rpsys.net
