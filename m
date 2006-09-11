Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbWIKXyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbWIKXyU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWIKXyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:54:20 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:55419 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965181AbWIKXyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:54:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g2A3qmkhb0CyoVZDXHuWYWk/bRCJMadY2ZlEk0ub2MMYbf5LUBwqqHXEJVSl1QbgQm9yOW709WhycOlzDM9Y2isVSrvBJOGFDQ1+mcHENcI5VXZ40Wi7lw7/AQEXDtyQfSXxDIeJZO3r2VO3ZArFrFka74+zFUUZP2OWAru+L9U=
Message-ID: <653402b90609111654vcfdefdckf160a20ecd6f6a65@mail.gmail.com>
Date: Tue, 12 Sep 2006 01:54:16 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: akpm@osdl.org
Subject: [PATCH 1/2] display: Driver ks0108 and cfag12864b
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <653402b90609111627q661cded8l757129311fbe92d4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <653402b90609111627q661cded8l757129311fbe92d4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda Sandonis

Adds support for additional "display" devices, like small LCD screens.
Adds support for the ks0108 LCD Controller.
Adds support for the cfag12864b LCD.

Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/Documentation/drivers/display/cfag12864b
linux-2.6.17.13/Documentation/drivers/display/cfag12864b
--- linux-2.6.17.13-vanilla/Documentation/drivers/display/cfag12864b
 1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.17.13/Documentation/drivers/display/cfag12864b    2006-09-12
00:10:43.000000000 +0200
@@ -0,0 +1,363 @@
+       ===============================
+       cfag12864b Driver Documentation
+       ===============================
+
+License:               GPL
+Author & Maintainer:   Miguel Ojeda Sandonis <maxextreme@gmail.com>
+Date:                  2006-09-10
+
+
+
+--------
+0. INDEX
+--------
+
+       1. DEVICE INFORMATION
+       2. WIRING
+       3. USER-SPACE PROGRAMMING
+               3.1. ioctl and a 128*64 boolean matrix
+               3.2. Direct writing
+       4. USEFUL FILES
+               4.1. cfag12864b.h
+               4.2. bmpwriter.h
+
+
+
+---------------------
+1. DEVICE INFORMATION
+---------------------
+
+Manufacturer:  Crystalfontz
+Webpage:       http://www.crystalfontz.com
+Device Webpage:        http://www.crystalfontz.com/products/12864b/
+Type:          LCD Display
+Width:         128
+Height:                64
+Colors:                2
+Controller:    ks0108
+Controllers:   2
+Pages:         8 each controller
+Addresses:     64 each page
+
+
+If you compiled the device as a module, don't remember to
+update udev to get the new device node at /dev.
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
+       #include "cfag12864b.h"
+
+Open the device for writing, /dev/cfag12864b0:
+
+       int fd = open("/dev/cfag12864b0",O_WRONLY);
+
+Then use simple ioctl calls to control it:
+
+       ioctl(fdisplay,CFAG12864B_IOCOFF);      /* Turn off (don't clear) */
+       ioctl(fdisplay,CFAG12864B_IOCON);       /* Turn on */
+       ioctl(fdisplay,CFAG12864B_IOCCLEAR);    /* Clear the display */
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
+       CFAG12864B_FORMATSIZE ==
+       CFAG12864B_WIDTH * CFAG12864B_HEIGHT ==
+       128 * 64
+
+Declare the matrix and other one:
+
+       unsigned char MyDrawing[CFAG12864B_WIDTH][CFAG12864B_HEIGHT];
+
+       unsigned char Buffer[CFAG12864B_FORMATSIZE];
+
+Copy the 2d matrix to the buffer , like:
+
+       for(i=0;i<CFAG12864B_WIDTH;++i)
+               for(j=0;j<CFAG12864B_HEIGHT;++j)
+                       Buffer[i+j*CFAG12864B_WIDTH]=MyDrawing[i][j];
+
+Call the ioctl:
+
+       ioctl(fdisplay,CFAG12864B_IOCFORMAT,Buffer);
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
+       # echo -n A > /dev/cfag12864b0
+       # echo -n a > /dev/cfag12864b0
+       # echo AAAAAA > /dev/cfag12864b0
+       # echo 000000 > /dev/cfag12864b0
+       # echo Hello world! > /dev/cfag12864b0
+       # echo Hello world! Hello world! > /dev/cfag12864b0
+
+After you understand it, code your functions to change specific bytes.
+
+Use write() and lseek() system calls, like:
+
+       lseek(fdisplay,ipage*CFAG12864B_HEIGHT,SEEK_SET);
+       lseek(fdisplay,icontroller*CFAG12864B_SIZE/2,SEEK_SET);
+
+       write(fdisplay,bufpage,CFAG12864B_HEIGHT);
+       write(fdisplay,bufcontroller,CFAG12864B_SIZE/2);
+       write(fdisplay,bufdisplay,CFAG12864B_SIZE);
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
+ *     License: GPL
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-10
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
+#define CFAG12864B_IOC_MAGIC   0xFF
+
+#define CFAG12864B_IOCOFF      _IO(CFAG12864B_IOC_MAGIC,0)
+#define CFAG12864B_IOCON       _IO(CFAG12864B_IOC_MAGIC,1)
+#define CFAG12864B_IOCCLEAR    _IO(CFAG12864B_IOC_MAGIC,2)
+#define CFAG12864B_IOCFORMAT   _IOW(CFAG12864B_IOC_MAGIC,3,void *)
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
+       unsigned int u32;
+       unsigned char u8[4];
+};
+
+#define Bit(n)   ((unsigned char)(1<<(n)))
+
+void BMP2Format(
+       unsigned char _Src[BMP_SIZE],
+       unsigned char _Dest[CFAG12864B_FORMATSIZE])
+{
+       const unsigned int Width = CFAG12864B_WIDTH;
+       const unsigned int Height = CFAG12864B_HEIGHT;
+       const unsigned int Bits = 8;
+
+       unsigned int  Y,X,Bit;
+
+       for(Y=0; Y<Height; ++Y)
+       for(X=0; X<Width/Bits; ++X)
+       for(Bit=0; Bit<Bits; ++Bit)
+               _Dest[X*Bits+Bit+(Height-Y-1)*Width] =
+                       _Src[Y*Width/Bits+X]&Bit(Bits-Bit-1)?0:1;
+}
+
+int main(int argc, char * argv[])
+{
+       const unsigned int Width = CFAG12864B_WIDTH;
+       const unsigned int Height = CFAG12864B_HEIGHT;
+       const unsigned int Size = CFAG12864B_SIZE;
+       const unsigned int BPP = 1;
+       const unsigned int HeaderSize = 0x3E;
+       const unsigned int BMPSize = BMP_SIZE;
+
+       unsigned char c;
+       unsigned int i,j;
+       union dword n;
+
+       unsigned char Buffer_BMP[BMP_SIZE];
+       unsigned char Buffer_Matrix[CFAG12864B_FORMATSIZE];
+
+       int fdisplay;
+       FILE * fbmp;
+
+       // Check args
+       if(argc!=3) {
+               printf("%s: Bad number of arguments. Expected 3\n",
+                       argv[0]);
+               return -1;
+       }
+
+       // Open file
+       fbmp = fopen(argv[2],"rb");
+       if(fbmp==NULL) {
+               printf("%s: Can't open %s\n",argv[0], argv[2]);
+               return -2;
+       }
+
+       // Check file size
+       fseek(fbmp,0,SEEK_END);
+       i=ftell(fbmp);
+       if(i!=HeaderSize+Size) {
+               printf("%s: Bad file size. %i instead of %i\n",
+                       argv[0], i, HeaderSize+Size);
+               fclose(fbmp);
+               return -3;
+       }
+
+       // Check both magic BMP bytes
+       fseek(fbmp,0,SEEK_SET);
+       c = fgetc(fbmp);
+       if(c!='B') {
+               printf("%s: Bad first magic byte. '%c' instead of 'B'\n",
+                       argv[0], c);
+               fclose(fbmp);
+               return -4;
+       }
+       c = fgetc(fbmp);
+       if(c!='M') {
+               printf("%s: Bad second magic byte. '%c' instead of 'M'\n",
+                       argv[0], c);
+               fclose(fbmp);
+               return -5;
+       }
+
+       // Check this is a 128x64 1-bpp BMP file
+       fseek(fbmp,0x12,SEEK_SET);
+       for(i=0; i<4; ++i)
+               n.u8[i] = fgetc(fbmp);
+       if(n.u32!=Width) {
+               printf("%s: Bad width. %i instead of %i\n",
+                       argv[0], n.u32, Width);
+               fclose(fbmp);
+               return -6;
+       }
+       for(i=0; i<4; ++i)
+               n.u8[i] = fgetc(fbmp);
+       if(n.u32!=Height) {
+               printf("%s: Bad width. %i instead of %i\n",
+                       argv[0], n.u32, Height);
+               fclose(fbmp);
+               return -7;
+       }
+       fseek(fbmp,0x1C,SEEK_SET);
+       c = fgetc(fbmp);
+       if(c!=BPP) {
+               printf("%s: Bad bpp. %i instead of %i\n",
+                       argv[0], c, BPP);
+               fclose(fbmp);
+               return -8;
+       }
+
+       // Get bitmap data
+       fseek(fbmp,0x3E,SEEK_SET);
+       for(i=0; i<BMPSize; ++i)
+               Buffer_BMP[i]=fgetc(fbmp);
+       fclose(fbmp);
+
+       // Transform BMP data to 2D matrix
+       BMP2Format(Buffer_BMP,Buffer_Matrix);
+
+       // Open file
+       fdisplay = open(argv[1],O_WRONLY);
+       if(fdisplay < 0) {
+               printf("%s: Can't open %s\n", argv[0], argv[1]);
+               return -9;
+       }
+
+       // Send matrix
+       ioctl(fdisplay,CFAG12864B_IOCFORMAT,Buffer_Matrix);
+
+       // Close file
+       close(fdisplay);
+
+       return 0;
+}
+---
+
+
+EOF
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/Documentation/drivers/display/display
linux-2.6.17.13/Documentation/drivers/display/display
--- linux-2.6.17.13-vanilla/Documentation/drivers/display/display
 1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.17.13/Documentation/drivers/display/display       2006-09-12
00:24:39.000000000 +0200
@@ -0,0 +1,37 @@
+       =============================
+       Display Drivers Documentation
+       =============================
+
+License:               GPL
+Author & Maintainer:   Miguel Ojeda Sandonis <maxextreme@gmail.com>
+Date:                  2006-09-10
+
+--------
+0. INDEX
+--------
+
+       1. NEW DISPLAY DRIVERS
+       2. GENERAL TIPS
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
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/Documentation/ioctl-number.txt
linux-2.6.17.13/Documentation/ioctl-number.txt
--- linux-2.6.17.13-vanilla/Documentation/ioctl-number.txt      2006-09-09
05:23:25.000000000 +0200
+++ linux-2.6.17.13/Documentation/ioctl-number.txt      2006-09-12
00:36:48.000000000 +0200
@@ -190,3 +190,5 @@ Code        Seq#    Include File            Comments
                                        <mailto:aherrman@de.ibm.com>
 0xF3   00-3F   video/sisfb.h           sisfb (in development)
                                        <mailto:thomas@winischhofer.net>
+0xFF   00-1F   cfag12864b LCD Display  linux/cfag12864b.h
+                                       <mailto:maxextreme@gmail.com>
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/CREDITS linux-2.6.17.13/CREDITS
--- linux-2.6.17.13-vanilla/CREDITS     2006-09-09 05:23:25.000000000 +0200
+++ linux-2.6.17.13/CREDITS     2006-09-12 00:16:06.000000000 +0200
@@ -2534,6 +2534,14 @@ S: Subiaco, 6008
 S: Perth, Western Australia
 S: Australia

+N: Miguel Ojeda Sandonis
+E: maxextreme@gmail.com
+D: Author: LCD Display Drivers (ks0108, cfag12864b)
+D: Maintainer: LCD Display Drivers Tree (drivers/display/*)
+S: C/ Mieses 20, 9-B
+S: Valladolid 47009
+S: Spain
+
 N: Greg Page
 E: gpage@sovereign.org
 D: IPX development and support
