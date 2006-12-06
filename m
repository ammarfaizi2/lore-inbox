Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937096AbWLFSoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937096AbWLFSoy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937086AbWLFSoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:44:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:50966 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937098AbWLFSow convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:44:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=KWLZZkJFqzUvrqMpeaZepZDR/SWNTgNYXjdYcTTfHWPuAfqqATalcK8cyt2HSpd1iXikk0q4S2SqkqN+kra/YCZAUjzXYYT4EnsObvXFctQdMcBAyAQeoWx0H86LYsrJEK7+aoucuciYwn5H7M+DfU5W4cfvgHbzxSJDvN1msbI=
Date: Wed, 6 Dec 2006 19:44:42 +0100
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: jsimmons@infradead.org
Cc: linux-kernel@vger.kernel.org, Luming.yu@intel.com, zap@homelink.ru,
       randy.dunlap@oracle.com, kernel-discuss@handhelds.org
Subject: Re: Display class
Message-Id: <20061206194442.422c60d3.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here is the patch (against git7+displayclass) which moves auxdisplay/*
to video/display/* and start using the display class.

It is just a draft, but there isn't much code changed from -mm2.

  - I would remove "struct device *dev, void *devdata" of display_device_register()
    Are they neccesary for other display drivers? I have to pass NULL right now.

  - I would add a paramtere ("char *name") to display_device_register() so we
    set the name when registering. Right now I have to set my name after inited,
    and this is a Linux module and not a person borning, right? ;)

  - I would add a read/writeable attr called "rate" for set/unset the refresh rate
    of a display.

  - I was going to maintain the drivers/auxdisplay/* tree.
    Are you going to maintain the driver? I think so, just for being sure.

P.S.

  When I was working at 2.6.19-rc6-mm2 it worked all fine, but now
  I have copied it to git7 I'm getting some weird segmentation faults
  (oops) when at cfag12864bfb_init, at mutex_lock() in
  display_device_unregister module... I think unrelated (?), but I will
  look for some mistake I made.

miguelojeda-draft-drivers-video-display-add-support.patch
Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff --git a/CREDITS b/CREDITS
index d088008..b55312a 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2562,6 +2562,16 @@ S: Subiaco, 6008
 S: Perth, Western Australia
 S: Australia
 
+N: Miguel Ojeda Sandonis
+E: maxextreme@gmail.com
+W: http://maxextreme.googlepages.com/
+D: Author: ks0108 LCD Controller driver
+D: Author: cfag12864b LCD driver
+D: Author: cfag12864bfb LCD framebuffer driver
+S: C/ Mieses 20, 9-B
+S: Valladolid 47009
+S: Spain
+
 N: Greg Page
 E: gpage@sovereign.org
 D: IPX development and support
diff --git a/Documentation/display/cfag12864b b/Documentation/display/cfag12864b
new file mode 100644
index 0000000..8b6c01d
--- /dev/null
+++ b/Documentation/display/cfag12864b
@@ -0,0 +1,105 @@
+	===================================
+	cfag12864b LCD Driver Documentation
+	===================================
+
+License:		GPLv2
+Author & Maintainer:	Miguel Ojeda Sandonis <maxextreme@gmail.com>
+Date:			2006-10-31
+
+
+
+--------
+0. INDEX
+--------
+
+	1. DRIVER INFORMATION
+	2. DEVICE INFORMATION
+	3. WIRING
+	4. USERSPACE PROGRAMMING
+
+
+---------------------
+1. DRIVER INFORMATION
+---------------------
+
+This driver support one cfag12864b display at time.
+
+
+---------------------
+2. DEVICE INFORMATION
+---------------------
+
+Manufacturer:	Crystalfontz
+Device Name:	Crystalfontz 12864b LCD Series
+Device Code:	cfag12864b
+Webpage:	http://www.crystalfontz.com
+Device Webpage:	http://www.crystalfontz.com/products/12864b/
+Type:		LCD (Liquid Crystal Display)
+Width:		128
+Height:		64
+Colors:		2 (B/N)
+Controller:	ks0108
+Controllers:	2
+Pages:		8 each controller
+Addresses:	64 each page
+Data size:	1 byte each address
+Memory size:	2 * 8 * 64 * 1 = 1024 bytes = 1 Kbyte
+
+
+---------
+3. WIRING
+---------
+
+The cfag12864b LCD Series don't have official wiring.
+
+The common wiring is done to the parallel port as shown:
+
+Parallel Port                          cfag12864b
+
+  Name Pin#                            Pin# Name
+
+Strobe ( 1)------------------------------(17) Enable
+Data 0 ( 2)------------------------------( 4) Data 0
+Data 1 ( 3)------------------------------( 5) Data 1
+Data 2 ( 4)------------------------------( 6) Data 2
+Data 3 ( 5)------------------------------( 7) Data 3
+Data 4 ( 6)------------------------------( 8) Data 4
+Data 5 ( 7)------------------------------( 9) Data 5
+Data 6 ( 8)------------------------------(10) Data 6
+Data 7 ( 9)------------------------------(11) Data 7
+       (10)                      [+5v]---( 1) Vdd
+       (11)                      [GND]---( 2) Ground
+       (12)                      [+5v]---(14) Reset
+       (13)                      [GND]---(15) Read / Write
+  Line (14)------------------------------(13) Controller Select 1
+       (15)
+  Init (16)------------------------------(12) Controller Select 2
+Select (17)------------------------------(16) Data / Instruction
+Ground (18)---[GND]              [+5v]---(19) LED +
+Ground (19)---[GND]
+Ground (20)---[GND]              E    A             Values:
+Ground (21)---[GND]       [GND]---[P1]---(18) Vee    · R = Resistor = 22 ohm
+Ground (22)---[GND]                |                 · P1 = Preset = 10 Kohm
+Ground (23)---[GND]       ----   S ------( 3) V0     · P2 = Preset = 1 Kohm
+Ground (24)---[GND]       |  |
+Ground (25)---[GND] [GND]---[P2]---[R]---(20) LED -
+
+
+------------------------
+4. USERSPACE PROGRAMMING
+------------------------
+
+The cfag12864bfb describes a framebuffer device (/dev/fbX).
+
+It has a size of 1024 bytes = 1 Kbyte.
+Each bit represents one pixel. If the bit is high, the pixel will
+turn on. If the pixel is low, the pixel will turn off.
+
+You can use the framebuffer as a file: fopen, fwrite, fclose...
+Although the LCD won't get updated until the next refresh time arrives.
+
+Also, you can mmap the framebuffer: open & mmap, munmap & close...
+which is the best option for most uses.
+
+Check Documentation/auxdisplay/cfag12864b-example.c
+for a real working userspace complete program with usage examples.
diff --git a/Documentation/display/cfag12864b-example.c b/Documentation/display/cfag12864b-example.c
new file mode 100644
index 0000000..7bfac35
--- /dev/null
+++ b/Documentation/display/cfag12864b-example.c
@@ -0,0 +1,282 @@
+/*
+ *    Filename: cfag12864b-example.c
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD userspace example program
+ *     License: GPLv2
+ *
+ *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-10-31
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
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
+/*
+ * ------------------------
+ * start of cfag12864b code
+ * ------------------------
+ */
+
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+#define CFAG12864B_WIDTH		(128)
+#define CFAG12864B_HEIGHT		(64)
+#define CFAG12864B_SIZE			(128 * 64 / 8)
+#define CFAG12864B_BPB			(8)
+#define CFAG12864B_ADDRESS(x, y)	((y) * CFAG12864B_WIDTH / \
+					CFAG12864B_BPB + (x) / CFAG12864B_BPB)
+#define CFAG12864B_BIT(n)		(((unsigned char) 1) << (n))
+
+#undef CFAG12864B_DOCHECK
+#ifdef CFAG12864B_DOCHECK
+	#define CFAG12864B_CHECK(x, y)		((x) < CFAG12864B_WIDTH && \
+						(y) < CFAG12864B_HEIGHT)
+#else
+	#define CFAG12864B_CHECK(x, y)		(1)
+#endif
+
+int cfag12864b_fd;
+unsigned char * cfag12864b_mem;
+unsigned char cfag12864b_buffer[CFAG12864B_SIZE];
+
+/*
+ * init a cfag12864b framebuffer device
+ *
+ * No error:       return = 0
+ * Unable to open: return = -1
+ * Unable to mmap: return = -2
+ */
+int cfag12864b_init(char *path)
+{
+	cfag12864b_fd = open(path, O_RDWR);
+	if (cfag12864b_fd == -1)
+		return -1;
+
+	cfag12864b_mem = mmap(0, CFAG12864B_SIZE, PROT_READ | PROT_WRITE,
+		MAP_SHARED, cfag12864b_fd, 0);
+	if (cfag12864b_mem == MAP_FAILED) {
+		close(cfag12864b_fd);
+		return -2;
+	}
+
+	return 0;
+}
+
+/*
+ * exit a cfag12864b framebuffer device
+ */
+void cfag12864b_exit(void)
+{
+	munmap(cfag12864b_mem, CFAG12864B_SIZE);
+	close(cfag12864b_fd);
+}
+
+/*
+ * set (x, y) pixel
+ */
+void cfag12864b_set(unsigned char x, unsigned char y)
+{
+	if (CFAG12864B_CHECK(x, y))
+		cfag12864b_buffer[CFAG12864B_ADDRESS(x, y)] |=
+			CFAG12864B_BIT(x % CFAG12864B_BPB);
+}
+
+/*
+ * unset (x, y) pixel
+ */
+void cfag12864b_unset(unsigned char x, unsigned char y)
+{
+	if (CFAG12864B_CHECK(x, y))
+		cfag12864b_buffer[CFAG12864B_ADDRESS(x, y)] &=
+			~CFAG12864B_BIT(x % CFAG12864B_BPB);
+}
+
+/*
+ * is set (x, y) pixel?
+ *
+ * Pixel off: return = 0
+ * Pixel on:  return = 1
+ */
+unsigned char cfag12864b_isset(unsigned char x, unsigned char y)
+{
+	if (CFAG12864B_CHECK(x, y))
+		if (cfag12864b_buffer[CFAG12864B_ADDRESS(x, y)] &
+			CFAG12864B_BIT(x % CFAG12864B_BPB))
+			return 1;
+
+	return 0;
+}
+
+/*
+ * not (x, y) pixel
+ */
+void cfag12864b_not(unsigned char x, unsigned char y)
+{
+	if (cfag12864b_isset(x, y))
+		cfag12864b_unset(x, y);
+	else
+		cfag12864b_set(x, y);
+}
+
+/*
+ * fill (set all pixels)
+ */
+void cfag12864b_fill(void)
+{
+	unsigned short i;
+
+	for (i = 0; i < CFAG12864B_SIZE; i++)
+		cfag12864b_buffer[i] = 0xFF;
+}
+
+/*
+ * clear (unset all pixels)
+ */
+void cfag12864b_clear(void)
+{
+	unsigned short i;
+
+	for (i = 0; i < CFAG12864B_SIZE; i++)
+		cfag12864b_buffer[i] = 0;
+}
+
+/*
+ * format a [128*64] matrix
+ *
+ * Pixel off: src[i] = 0
+ * Pixel on:  src[i] > 0
+ */
+void cfag12864b_format(unsigned char * matrix)
+{
+	unsigned char i, j, n;
+
+	for (i = 0; i < CFAG12864B_HEIGHT; i++)
+	for (j = 0; j < CFAG12864B_WIDTH / CFAG12864B_BPB; j++) {
+		cfag12864b_buffer[i * CFAG12864B_WIDTH / CFAG12864B_BPB +
+			j] = 0;
+		for (n = 0; n < CFAG12864B_BPB; n++)
+			if (matrix[i * CFAG12864B_WIDTH +
+				j * CFAG12864B_BPB + n])
+				cfag12864b_buffer[i * CFAG12864B_WIDTH /
+					CFAG12864B_BPB + j] |=
+					CFAG12864B_BIT(n);
+	}
+}
+
+/*
+ * blit buffer to lcd
+ */
+void cfag12864b_blit(void)
+{
+	memcpy(cfag12864b_mem, cfag12864b_buffer, CFAG12864B_SIZE);
+}
+
+/*
+ * ----------------------
+ * end of cfag12864b code
+ * ----------------------
+ */
+
+#include <stdio.h>
+#include <string.h>
+
+#define EXAMPLES	6
+
+void example(unsigned char n)
+{
+	unsigned short i, j;
+	unsigned char matrix[CFAG12864B_WIDTH * CFAG12864B_HEIGHT];
+
+	if (n > EXAMPLES)
+		return;
+
+	printf("Example %i/%i - ", n, EXAMPLES);
+
+	switch (n) {
+	case 1:
+		printf("Draw points setting bits");
+		cfag12864b_clear();
+		for (i = 0; i < CFAG12864B_WIDTH; i += 2)
+			for (j = 0; j < CFAG12864B_HEIGHT; j += 2)
+				cfag12864b_set(i, j);
+		break;
+
+	case 2:
+		printf("Clear the LCD");
+		cfag12864b_clear();
+		break;
+
+	case 3:
+		printf("Draw rows formatting a [128*64] matrix");
+		memset(matrix, 0, CFAG12864B_WIDTH * CFAG12864B_HEIGHT);
+		for (i = 0; i < CFAG12864B_WIDTH; i++)
+			for (j = 0; j < CFAG12864B_HEIGHT; j += 2)
+				matrix[j * CFAG12864B_WIDTH + i] = 1;
+		cfag12864b_format(matrix);
+		break;
+
+	case 4:
+		printf("Fill the lcd");
+		cfag12864b_fill();
+		break;
+
+	case 5:
+		printf("Draw columns unsetting bits");
+		for (i = 0; i < CFAG12864B_WIDTH; i += 2)
+			for (j = 0; j < CFAG12864B_HEIGHT; j++)
+				cfag12864b_unset(i, j);
+		break;
+
+	case 6:
+		printf("Do negative not-ing all bits");
+		for (i = 0; i < CFAG12864B_WIDTH; i++)
+			for (j = 0; j < CFAG12864B_HEIGHT; j ++)
+				cfag12864b_not(i, j);
+		break;
+	}
+
+	puts(" - [Press Enter]");
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned char n;
+
+	if (argc != 2) {
+		printf(
+			"Sintax:  %s fbdev\n"
+			"Usually: /dev/fb0, /dev/fb1...\n", argv[0]);
+		return -1;
+	}
+
+	if (cfag12864b_init(argv[1])) {
+		printf("Can't init %s fbdev\n", argv[1]);
+		return -2;
+	}
+
+	for (n = 1; n <= EXAMPLES; n++) {
+		example(n);
+		cfag12864b_blit();
+		while (getchar() != '\n');
+	}
+
+	cfag12864b_exit();
+
+	return 0;
+}
diff --git a/Documentation/display/ks0108 b/Documentation/display/ks0108
new file mode 100644
index 0000000..a006f79
--- /dev/null
+++ b/Documentation/display/ks0108
@@ -0,0 +1,55 @@
+	==========================================
+	ks0108 LCD Controller Driver Documentation
+	==========================================
+
+License:		GPLv2
+Author & Maintainer:	Miguel Ojeda Sandonis <maxextreme@gmail.com>
+Date:			2006-10-31
+
+
+
+--------
+0. INDEX
+--------
+
+	1. DRIVER INFORMATION
+	2. DEVICE INFORMATION
+	3. WIRING
+
+
+---------------------
+1. DRIVER INFORMATION
+---------------------
+
+This driver support the ks0108 LCD controller.
+
+
+---------------------
+2. DEVICE INFORMATION
+---------------------
+
+Manufacturer:	Samsung
+Device Name:	KS0108 LCD Controller
+Device Code:	ks0108
+Webpage:	-
+Device Webpage:	-
+Type:		LCD Controller (Liquid Crystal Display Controller)
+Width:		64
+Height:		64
+Colors:		2 (B/N)
+Pages:		8
+Addresses:	64 each page
+Data size:	1 byte each address
+Memory size:	8 * 64 * 1 = 512 bytes
+
+
+---------
+3. WIRING
+---------
+
+The driver supports data parallel port wiring.
+
+If you aren't building LCD related hardware, you should check
+your LCD specific wiring information in the same folder.
+
+For example, check Documentation/display/cfag12864b.
diff --git a/MAINTAINERS b/MAINTAINERS
index 5dff268..e31e0bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -659,6 +659,20 @@ L:	linux-kernel@vger.kernel.org
 L:	discuss@x86-64.org
 S:	Maintained
 
+CFAG12864B LCD DRIVER
+P:	Miguel Ojeda Sandonis
+M:	maxextreme@gmail.com
+W:	http://maxextreme.googlepages.com/display.htm
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
+CFAG12864BFB LCD FRAMEBUFFER DRIVER
+P:	Miguel Ojeda Sandonis
+M:	maxextreme@gmail.com
+W:	http://maxextreme.googlepages.com/display.htm
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 COMMON INTERNET FILE SYSTEM (CIFS)
 P:	Steve French
 M:	sfrench@samba.org
@@ -1752,6 +1766,13 @@ M:	davem@davemloft.net
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+KS0108 LCD CONTROLLER DRIVER
+P:	Miguel Ojeda Sandonis
+M:	maxextreme@gmail.com
+W:	http://maxextreme.googlepages.com/display.htm
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 LAPB module
 L:	linux-x25@vger.kernel.org
 S:	Orphan
diff --git a/drivers/video/display/Kconfig b/drivers/video/display/Kconfig
index db2dae4..0c655a5 100644
--- a/drivers/video/display/Kconfig
+++ b/drivers/video/display/Kconfig
@@ -26,4 +26,102 @@ config DISPLAY_DDC
 comment "Display hardware drivers"
 	depends on DISPLAY_SUPPORT
 
+config KS0108
+	tristate "KS0108 LCD Controller"
+	depends on PARPORT_PC
+	depends on DISPLAY_SUPPORT
+	default n
+	---help---
+	  If you have a LCD controlled by one or more KS0108
+	  controllers, say Y. You will need also another more specific
+	  driver for your LCD.
+
+	  Depends on Parallel Port support. If you say Y at
+	  parport, you will be able to compile this as a module (M)
+	  and built-in as well (Y).
+
+	  To compile this as a module, choose M here:
+	  the module will be called ks0108.
+
+	  If unsure, say N.
+
+config KS0108_PORT
+	hex "Parallel port where the LCD is connected"
+	depends on KS0108
+	default 0x378
+	---help---
+	  The address of the parallel port where the LCD is connected.
+
+	  The first  standard parallel port address is 0x378.
+	  The second standard parallel port address is 0x278.
+	  The third  standard parallel port address is 0x3BC.
+
+	  You can specify a different address if you need.
+
+	  If you don't know what I'm talking about, load the parport module,
+	  and execute "dmesg" or "cat /proc/ioports". You can see there how
+	  many parallel ports are present and which address each one has.
+
+	  Usually you only need to use 0x378.
+
+	  If you compile this as a module, you can still override this
+	  using the module parameters.
+
+config KS0108_DELAY
+	int "Delay between each control writing (microseconds)"
+	depends on KS0108
+	default "2"
+	---help---
+	  Amount of time the ks0108 should wait between each control write
+	  to the parallel port.
+
+	  If your driver seems to miss random writings, increment this.
+
+	  If you don't know what I'm talking about, ignore it.
+
+	  If you compile this as a module, you can still override this
+	  value using the module parameters.
+
+config CFAG12864B
+	tristate "CFAG12864B LCD"
+	depends on X86
+	depends on KS0108
+	default n
+	---help---
+	  If you have a Crystalfontz 128x64 2-color LCD, cfag12864b Series,
+	  say Y. You also need the ks0108 LCD Controller driver.
+
+	  For help about how to wire your LCD to the parallel port,
+	  check Documentation/auxdisplay/cfag12864b
+
+	  The LCD framebuffer driver can be attached to a console.
+	  It will work fine. However, you can't attach it to the fbdev driver
+	  of the xorg server.
+
+	  To compile this as a module, choose M here:
+	  the modules will be called cfag12864b and cfag12864bfb.
+
+	  If unsure, say N.
+
+config CFAG12864B_RATE
+	int "Refresh rate (hertzs)"
+	depends on CFAG12864B
+	default "20"
+	---help---
+	  Refresh rate of the LCD.
+
+	  As the LCD is not memory mapped, the driver has to make the work by
+	  software. This means you should be careful setting this value higher.
+	  If your CPUs are really slow or you feel the system is slowed down,
+	  decrease the value.
+
+	  Be careful modifying this value to a very high value:
+	  You can freeze the computer, or the LCD maybe can't draw as fast as you
+	  are requesting.
+
+	  If you don't know what I'm talking about, ignore it.
+
+	  If you compile this as a module, you can still override this
+	  value using the module parameters.
+
 endmenu
diff --git a/drivers/video/display/Makefile b/drivers/video/display/Makefile
index d210f52..fc9f7dd 100644
--- a/drivers/video/display/Makefile
+++ b/drivers/video/display/Makefile
@@ -5,3 +5,6 @@ display-objs				:= display-sysfs.o 
 obj-$(CONFIG_DISPLAY_SUPPORT)		+= display.o
 
 obj-$(CONFIG_DISPLAY_DDC)		+= display-ddc.o
+
+obj-$(CONFIG_KS0108)			+= ks0108.o
+obj-$(CONFIG_CFAG12864B)		+= cfag12864b.o cfag12864bfb.o
diff --git a/drivers/video/display/cfag12864b.c b/drivers/video/display/cfag12864b.c
new file mode 100644
index 0000000..1a25df9
--- /dev/null
+++ b/drivers/video/display/cfag12864b.c
@@ -0,0 +1,404 @@
+/*
+ *    Filename: cfag12864b.c
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD driver
+ *     License: GPLv2
+ *     Depends: ks0108
+ *
+ *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-10-31
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
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
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/jiffies.h>
+#include <linux/mutex.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+#include <linux/workqueue.h>
+#include <linux/ks0108.h>
+#include <linux/cfag12864b.h>
+
+
+#define CFAG12864B_NAME "cfag12864b"
+
+/*
+ * Module Parameters
+ */
+
+static unsigned int cfag12864b_rate = CONFIG_CFAG12864B_RATE;
+module_param(cfag12864b_rate, uint, S_IRUGO);
+MODULE_PARM_DESC(cfag12864b_rate,
+	"Refresh rate (hertzs)");
+
+unsigned int cfag12864b_get_rate(void)
+{
+	return cfag12864b_rate;
+}
+
+/*
+ * cfag12864b Commands
+ *
+ *	E = Enable signal
+ *		Everytime E switch from low to high,
+ *		cfag12864b/ks0108 reads the command/data.
+ *
+ *	CS1 = First ks0108controller.
+ *		If high, the first ks0108 controller receives commands/data.
+ *
+ *	CS2 = Second ks0108 controller
+ *		If high, the second ks0108 controller receives commands/data.
+ *
+ *	DI = Data/Instruction
+ *		If low, cfag12864b will expect commands.
+ *		If high, cfag12864b will expect data.
+ *
+ */
+
+#define bit(n) (((unsigned char)1)<<(n))
+
+#define CFAG12864B_BIT_E	(0)
+#define CFAG12864B_BIT_CS1	(2)
+#define CFAG12864B_BIT_CS2	(1)
+#define CFAG12864B_BIT_DI	(3)
+
+static unsigned char cfag12864b_state;
+
+static void cfag12864b_set(void)
+{
+	ks0108_writecontrol(cfag12864b_state);
+}
+
+static void cfag12864b_setbit(unsigned char state, unsigned char n)
+{
+	if (state)
+		cfag12864b_state |= bit(n);
+	else
+		cfag12864b_state &= ~bit(n);
+}
+
+static void cfag12864b_e(unsigned char state)
+{
+	cfag12864b_setbit(state, CFAG12864B_BIT_E);
+	cfag12864b_set();
+}
+
+static void cfag12864b_cs1(unsigned char state)
+{
+	cfag12864b_setbit(state, CFAG12864B_BIT_CS1);
+}
+
+static void cfag12864b_cs2(unsigned char state)
+{
+	cfag12864b_setbit(state, CFAG12864B_BIT_CS2);
+}
+
+static void cfag12864b_di(unsigned char state)
+{
+	cfag12864b_setbit(state, CFAG12864B_BIT_DI);
+}
+
+static void cfag12864b_setcontrollers(unsigned char first,
+	unsigned char second)
+{
+	if (first)
+		cfag12864b_cs1(0);
+	else
+		cfag12864b_cs1(1);
+
+	if (second)
+		cfag12864b_cs2(0);
+	else
+		cfag12864b_cs2(1);
+}
+
+static void cfag12864b_controller(unsigned char which)
+{
+	if (which == 0)
+		cfag12864b_setcontrollers(1, 0);
+	else if (which == 1)
+		cfag12864b_setcontrollers(0, 1);
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
+/*
+ * cfag12864b Internal Commands
+ */
+
+static void cfag12864b_on(void)
+{
+	cfag12864b_setcontrollers(1, 1);
+	cfag12864b_displaystate(1);
+}
+
+static void cfag12864b_off(void)
+{
+	cfag12864b_setcontrollers(1, 1);
+	cfag12864b_displaystate(0);
+}
+
+static void cfag12864b_clear(void)
+{
+	unsigned char i, j;
+
+	cfag12864b_setcontrollers(1, 1);
+	for (i = 0; i < CFAG12864B_PAGES; i++) {
+		cfag12864b_page(i);
+		cfag12864b_address(0);
+		for (j = 0; j < CFAG12864B_ADDRESSES; j++)
+			cfag12864b_writebyte(0);
+	}
+}
+
+/*
+ * Update work
+ */
+
+unsigned char *cfag12864b_buffer;
+static unsigned char *cfag12864b_cache;
+static DEFINE_MUTEX(cfag12864b_mutex);
+static unsigned char cfag12864b_updating;
+static void cfag12864b_update(void *arg);
+static struct workqueue_struct *cfag12864b_workqueue;
+static DECLARE_WORK(cfag12864b_work, cfag12864b_update, NULL);
+
+static void cfag12864b_queue(void)
+{
+	queue_delayed_work(cfag12864b_workqueue, &cfag12864b_work,
+		HZ / cfag12864b_rate);
+}
+
+void cfag12864b_power_on(void)
+{
+	mutex_lock(&cfag12864b_mutex);
+
+	cfag12864b_on();
+
+	mutex_unlock(&cfag12864b_mutex);
+}
+
+void cfag12864b_power_off(void)
+{
+	mutex_lock(&cfag12864b_mutex);
+
+	cfag12864b_off();
+
+	mutex_unlock(&cfag12864b_mutex);
+}
+
+unsigned char cfag12864b_enable(void)
+{
+	unsigned char ret;
+
+	mutex_lock(&cfag12864b_mutex);
+
+	if (!cfag12864b_updating) {
+		cfag12864b_updating = 1;
+		cfag12864b_queue();
+		ret = 0;
+	} else
+		ret = 1;
+
+	mutex_unlock(&cfag12864b_mutex);
+
+	return ret;
+}
+
+void cfag12864b_disable(void)
+{
+	mutex_lock(&cfag12864b_mutex);
+
+	if (cfag12864b_updating) {
+		cfag12864b_updating = 0;
+		cancel_delayed_work(&cfag12864b_work);
+		flush_workqueue(cfag12864b_workqueue);
+		cfag12864b_off();
+	}
+
+	mutex_unlock(&cfag12864b_mutex);
+}
+
+unsigned char cfag12864b_is_enabled(void)
+{
+	return cfag12864b_updating;
+}
+
+static void cfag12864b_update(void *arg)
+{
+	unsigned char c;
+	unsigned short i, j, k, b;
+
+	if (memcmp(cfag12864b_cache, cfag12864b_buffer, CFAG12864B_SIZE)) {
+		for (i = 0; i < CFAG12864B_CONTROLLERS; i++) {
+			cfag12864b_controller(i);
+			cfag12864b_nop();
+			for (j = 0; j < CFAG12864B_PAGES; j++) {
+				cfag12864b_page(j);
+				cfag12864b_nop();
+				cfag12864b_address(0);
+				cfag12864b_nop();
+				for (k = 0; k < CFAG12864B_ADDRESSES; k++) {
+					for (c = 0, b = 0; b < 8; b++)
+						if (cfag12864b_buffer
+							[i * CFAG12864B_ADDRESSES / 8
+							+ k / 8 + (j * 8 + b) *
+							CFAG12864B_WIDTH / 8]
+							& bit(k % 8))
+							c |= bit(b);
+					cfag12864b_writebyte(c);
+				}
+			}
+		}
+
+		memcpy(cfag12864b_cache, cfag12864b_buffer, CFAG12864B_SIZE);
+	}
+
+	if (cfag12864b_updating)
+		cfag12864b_queue();
+}
+
+/*
+ * cfag12864b Exported Symbols
+ */
+
+EXPORT_SYMBOL_GPL(cfag12864b_buffer);
+EXPORT_SYMBOL_GPL(cfag12864b_get_rate);
+EXPORT_SYMBOL_GPL(cfag12864b_power_on);
+EXPORT_SYMBOL_GPL(cfag12864b_power_off);
+EXPORT_SYMBOL_GPL(cfag12864b_enable);
+EXPORT_SYMBOL_GPL(cfag12864b_disable);
+EXPORT_SYMBOL_GPL(cfag12864b_is_enabled);
+
+/*
+ * Module Init & Exit
+ */
+
+static int __init cfag12864b_init(void)
+{
+	int ret = -EINVAL;
+
+	if (PAGE_SIZE < CFAG12864B_SIZE) {
+		printk(KERN_ERR CFAG12864B_NAME ": ERROR: "
+			"page size (%i) < cfag12864b size (%i)\n",
+			(unsigned int)PAGE_SIZE, CFAG12864B_SIZE);
+		ret = -ENOMEM;
+		goto none;
+	}
+
+	cfag12864b_buffer = (unsigned char *) __get_free_page(GFP_KERNEL);
+	if (cfag12864b_buffer == NULL) {
+		printk(KERN_ERR CFAG12864B_NAME ": ERROR: "
+			"can't get a free page\n");
+		ret = -ENOMEM;
+		goto none;
+	}
+
+	cfag12864b_cache = kmalloc(sizeof(unsigned char) *
+		CFAG12864B_SIZE, GFP_KERNEL);
+	if (cfag12864b_buffer == NULL) {
+		printk(KERN_ERR CFAG12864B_NAME ": ERROR: "
+			"can't alloc cache buffer (%i bytes)\n",
+			CFAG12864B_SIZE);
+		ret = -ENOMEM;
+		goto bufferalloced;
+	}
+
+	cfag12864b_workqueue = create_singlethread_workqueue(CFAG12864B_NAME);
+	if (cfag12864b_workqueue == NULL)
+		goto cachealloced;
+
+	memset(cfag12864b_buffer, 0, CFAG12864B_SIZE);
+
+	cfag12864b_clear();
+	cfag12864b_on();
+
+	return 0;
+
+cachealloced:
+	kfree(cfag12864b_cache);
+
+bufferalloced:
+	free_page((unsigned long) cfag12864b_buffer);
+
+none:
+	return ret;
+}
+
+static void __exit cfag12864b_exit(void)
+{
+	cfag12864b_disable();
+	cfag12864b_off();
+	destroy_workqueue(cfag12864b_workqueue);
+	kfree(cfag12864b_cache);
+	free_page((unsigned long) cfag12864b_buffer);
+}
+
+module_init(cfag12864b_init);
+module_exit(cfag12864b_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("cfag12864b LCD driver");
diff --git a/drivers/video/display/cfag12864bfb.c b/drivers/video/display/cfag12864bfb.c
new file mode 100644
index 0000000..e51655f
--- /dev/null
+++ b/drivers/video/display/cfag12864bfb.c
@@ -0,0 +1,205 @@
+/*
+ *    Filename: cfag12864bfb.c
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD framebuffer driver
+ *     License: GPLv2
+ *     Depends: cfag12864b
+ *
+ *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-10-31
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
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
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/display.h>
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/cfag12864b.h>
+
+#define CFAG12864BFB_NAME "cfag12864bfb"
+
+static struct fb_info *fb;
+
+static char cfag12864bfb_name[] = CFAG12864BFB_NAME;
+static int cfag12864bfb_power;
+
+static struct fb_fix_screeninfo cfag12864bfb_fix __initdata = {
+	.id = CFAG12864BFB_NAME,
+	.type = FB_TYPE_PACKED_PIXELS,
+	.visual = FB_VISUAL_MONO10,
+	.xpanstep = 0,
+	.ypanstep = 0,
+	.ywrapstep = 0,
+	.line_length = CFAG12864B_WIDTH / 8,
+	.accel = FB_ACCEL_NONE,
+};
+
+static struct fb_var_screeninfo cfag12864bfb_var __initdata = {
+	.xres = CFAG12864B_WIDTH,
+	.yres = CFAG12864B_HEIGHT,
+	.xres_virtual = CFAG12864B_WIDTH,
+	.yres_virtual = CFAG12864B_HEIGHT,
+	.bits_per_pixel = 1,
+	.red = { 0, 1, 0 },
+      	.green = { 0, 1, 0 },
+      	.blue = { 0, 1, 0 },
+	.left_margin = 0,
+	.right_margin = 0,
+	.upper_margin = 0,
+	.lower_margin = 0,
+	.vmode = FB_VMODE_NONINTERLACED,
+};
+
+static int cfag12864bfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
+{
+	return vm_insert_page(vma, vma->vm_start,
+		virt_to_page(cfag12864b_buffer));
+}
+
+static struct fb_ops cfag12864bfb_ops = {
+	.owner = THIS_MODULE,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+	.fb_mmap = cfag12864bfb_mmap,
+};
+
+static int cfag12864bfb_set_power(struct display_device *device)
+{
+	if (device->request_state > 0) {
+		cfag12864bfb_power = 1;
+		cfag12864b_power_on();
+	} else {
+		cfag12864bfb_power = 0;
+		cfag12864b_power_off();
+	}
+
+	return 0;
+}
+
+static int cfag12864bfb_get_power(struct display_device *device)
+{
+	return cfag12864bfb_power;
+}
+
+static int cfag12864bfb_probe(struct display_device *device, void *data)
+{
+	return 0;
+}
+
+static int cfag12864bfb_remove(struct display_device *device)
+{
+	return 0;
+}
+
+static struct display_driver cfag12864bfb_driver = {
+	.set_power = cfag12864bfb_set_power,
+	.get_power = cfag12864bfb_get_power,
+	.probe	= cfag12864bfb_probe,
+	.remove = cfag12864bfb_remove,
+};
+
+static struct display_device *cfag12864bfb_device;
+
+static int __init cfag12864bfb_init(void)
+{
+	int ret = -EINVAL;
+
+	if (cfag12864b_enable()) {
+		printk(KERN_ERR CFAG12864BFB_NAME ": ERROR: "
+			"can't enable cfag12864b refreshing (being used)\n");
+		ret = -ENODEV;
+		goto none;
+	}
+
+	fb = framebuffer_alloc(0, NULL);
+	if (!fb) {
+		printk(KERN_ERR CFAG12864BFB_NAME ": ERROR: "
+			"can't alloc framebuffer\n");
+		ret = -ENODEV;
+		goto enabled;
+	}
+
+	fb->screen_base = (char __iomem *) cfag12864b_buffer;
+	fb->screen_size = CFAG12864B_SIZE;
+	fb->fbops = &cfag12864bfb_ops;
+	fb->fix = cfag12864bfb_fix;
+	fb->var = cfag12864bfb_var;
+	fb->pseudo_palette = NULL;
+	fb->par = NULL;
+	fb->flags = FBINFO_FLAG_DEFAULT;
+
+	if (register_framebuffer(fb) < 0) {
+		printk(KERN_ERR CFAG12864BFB_NAME ": ERROR: "
+			"can't register framebuffer\n");
+		ret = -ENODEV;
+		goto fballoced;
+	}
+
+	cfag12864bfb_device = display_device_register(&cfag12864bfb_driver,
+		NULL, NULL);
+	if (!cfag12864bfb_device) {
+		printk(KERN_ERR CFAG12864BFB_NAME ": ERROR: "
+			"can't register display device\n");
+		ret = -ENODEV;
+		goto fbregistered;
+	}
+
+	cfag12864bfb_device->name = cfag12864bfb_name;
+	cfag12864bfb_device->owner = THIS_MODULE;
+	cfag12864bfb_device->request_state = cfag12864bfb_power = 1;
+
+	cfag12864b_power_on();
+
+	printk(KERN_INFO "fb%d: %s framebuffer device\n", fb->node,
+		fb->fix.id);
+
+	return 0;
+
+fbregistered:
+	unregister_framebuffer(fb);
+
+fballoced:
+	framebuffer_release(fb);
+
+enabled:
+	cfag12864b_disable();
+
+none:
+	return ret;
+}
+
+static void __exit cfag12864bfb_exit(void)
+{
+	display_device_unregister(cfag12864bfb_device);
+	unregister_framebuffer(fb);
+	framebuffer_release(fb);
+	cfag12864b_disable();
+}
+
+module_init(cfag12864bfb_init);
+module_exit(cfag12864bfb_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("cfag12864bfb LCD framebuffer driver");
diff --git a/drivers/video/display/ks0108.c b/drivers/video/display/ks0108.c
new file mode 100644
index 0000000..a637575
--- /dev/null
+++ b/drivers/video/display/ks0108.c
@@ -0,0 +1,166 @@
+/*
+ *    Filename: ks0108.c
+ *     Version: 0.1.0
+ * Description: ks0108 LCD Controller driver
+ *     License: GPLv2
+ *     Depends: parport
+ *
+ *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-10-31
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
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
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/parport.h>
+#include <linux/uaccess.h>
+#include <linux/ks0108.h>
+
+#define KS0108_NAME "ks0108"
+
+/*
+ * Module Parameters
+ */
+
+static unsigned int ks0108_port = CONFIG_KS0108_PORT;
+module_param(ks0108_port, uint, S_IRUGO);
+MODULE_PARM_DESC(ks0108_port, "Parallel port where the LCD is connected");
+
+static unsigned int ks0108_delay = CONFIG_KS0108_DELAY;
+module_param(ks0108_delay, uint, S_IRUGO);
+MODULE_PARM_DESC(ks0108_delay, "Delay between each control writing (microseconds)");
+
+/*
+ * Device
+ */
+
+static struct parport *ks0108_parport;
+static struct pardevice *ks0108_pardevice;
+
+/*
+ * ks0108 Exported Commands (don't lock)
+ *
+ *   You _should_ lock in the top driver: This functions _should not_
+ *   get race conditions in any way. Locking for each byte here would be
+ *   so slow and useless.
+ *
+ *   There are not bit definitions because they are not flags,
+ *   just arbitrary combinations defined by the documentation for each
+ *   function in the ks0108 LCD controller. If you want to know what means
+ *   a specific combination, look at the function's name.
+ *
+ *   The ks0108_writecontrol bits need to be reverted ^(0,1,3) because
+ *   the parallel port also revert them using a "not" logic gate.
+ */
+
+#define bit(n) (((unsigned char)1)<<(n))
+
+void ks0108_writedata(unsigned char byte)
+{
+	parport_write_data(ks0108_parport, byte);
+}
+
+void ks0108_writecontrol(unsigned char byte)
+{
+	udelay(ks0108_delay);
+	parport_write_control(ks0108_parport, byte ^ (bit(0) | bit(1) | bit(3)));
+}
+
+void ks0108_displaystate(unsigned char state)
+{
+	ks0108_writedata((state ? bit(0) : 0) | bit(1) | bit(2) | bit(3) | bit(4) | bit(5));
+}
+
+void ks0108_startline(unsigned char startline)
+{
+	ks0108_writedata(min(startline,(unsigned char)63) | bit(6) | bit(7));
+}
+
+void ks0108_address(unsigned char address)
+{
+	ks0108_writedata(min(address,(unsigned char)63) | bit(6));
+}
+
+void ks0108_page(unsigned char page)
+{
+	ks0108_writedata(min(page,(unsigned char)7) | bit(3) | bit(4) | bit(5) | bit(7));
+}
+
+EXPORT_SYMBOL_GPL(ks0108_writedata);
+EXPORT_SYMBOL_GPL(ks0108_writecontrol);
+EXPORT_SYMBOL_GPL(ks0108_displaystate);
+EXPORT_SYMBOL_GPL(ks0108_startline);
+EXPORT_SYMBOL_GPL(ks0108_address);
+EXPORT_SYMBOL_GPL(ks0108_page);
+
+/*
+ * Module Init & Exit
+ */
+
+static int __init ks0108_init(void)
+{
+	int result;
+	int ret = -EINVAL;
+
+	ks0108_parport = parport_find_base(ks0108_port);
+	if (ks0108_parport == NULL) {
+		printk(KERN_ERR KS0108_NAME ": ERROR: "
+			"parport didn't find %i port\n", ks0108_port);
+		goto none;
+	}
+
+	ks0108_pardevice = parport_register_device(ks0108_parport, KS0108_NAME,
+		NULL, NULL, NULL, PARPORT_DEV_EXCL, NULL);
+	if (ks0108_pardevice == NULL) {
+		printk(KERN_ERR KS0108_NAME ": ERROR: "
+			"parport didn't register new device\n");
+		goto none;
+	}
+
+	result = parport_claim(ks0108_pardevice);
+	if (result != 0) {
+		printk(KERN_ERR KS0108_NAME ": ERROR: "
+			"can't claim %i parport, maybe in use\n", ks0108_port);
+		ret = result;
+		goto registered;
+	}
+
+	return 0;
+
+registered:
+	parport_unregister_device(ks0108_pardevice);
+
+none:
+	return ret;
+}
+
+static void __exit ks0108_exit(void)
+{
+	parport_release(ks0108_pardevice);
+	parport_unregister_device(ks0108_pardevice);
+}
+
+module_init(ks0108_init);
+module_exit(ks0108_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("ks0108 LCD Controller driver");
+
diff --git a/include/linux/cfag12864b.h b/include/linux/cfag12864b.h
new file mode 100644
index 0000000..5174670
--- /dev/null
+++ b/include/linux/cfag12864b.h
@@ -0,0 +1,91 @@
+/*
+ *    Filename: cfag12864b.h
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD driver header
+ *     License: GPLv2
+ *
+ *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-12-06
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
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
+#ifndef _CFAG12864B_H_
+#define _CFAG12864B_H_
+
+#define CFAG12864B_WIDTH	(128)
+#define CFAG12864B_HEIGHT	(64)
+#define CFAG12864B_CONTROLLERS	(2)
+#define CFAG12864B_PAGES	(8)
+#define CFAG12864B_ADDRESSES	(64)
+#define CFAG12864B_SIZE		((CFAG12864B_CONTROLLERS) * \
+				(CFAG12864B_PAGES) * \
+				(CFAG12864B_ADDRESSES))
+
+/*
+ * The driver will blit this buffer to the LCD
+ *
+ * Its size is CFAG12864B_SIZE.
+ */
+extern unsigned char * cfag12864b_buffer;
+
+/*
+ * Get the refresh rate of the LCD
+ *
+ * Returns the refresh rate (hertzs).
+ */
+extern unsigned int cfag12864b_get_rate(void);
+
+/*
+ * Power on the LCD
+ *
+ * Screen memory will be showed
+ */
+extern void cfag12864b_power_on(void);
+
+/*
+ * Power off the LCD
+ *
+ * Screen memory won't be showed
+ */
+extern void cfag12864b_power_off(void);
+
+/*
+ * Enable refreshing
+ *
+ * Returns 0 if successful (anyone was using it),
+ * or != 0 if failed (someone is using it).
+ */
+extern unsigned char cfag12864b_enable(void);
+
+/*
+ * Disable refreshing
+ *
+ * You should call this only when you finish using the LCD.
+ */
+extern void cfag12864b_disable(void);
+
+/*
+ * Is enabled refreshing? (is anyone using the module?)
+ *
+ * Returns 0 if refreshing is not enabled (anyone is using it),
+ * or != 0 if refreshing is enabled (someone is using it).
+ *
+ * Useful for buffer read-only modules.
+ */
+extern unsigned char cfag12864b_is_enabled(void);
+
+#endif /* _CFAG12864B_H_ */
+
diff --git a/include/linux/ks0108.h b/include/linux/ks0108.h
new file mode 100644
index 0000000..aca57f1
--- /dev/null
+++ b/include/linux/ks0108.h
@@ -0,0 +1,46 @@
+/*
+ *    Filename: ks0108.h
+ *     Version: 0.1.0
+ * Description: ks0108 LCD Controller driver header
+ *     License: GPLv2
+ *
+ *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-12-06
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
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
+#ifndef _KS0108_H_
+#define _KS0108_H_
+
+/* Write a byte to the data port */
+extern void ks0108_writedata(unsigned char byte);
+
+/* Write a byte to the control port */
+extern void ks0108_writecontrol(unsigned char byte);
+
+/* Set the controller's current display state (0..1) */
+extern void ks0108_displaystate(unsigned char state);
+
+/* Set the controller's current startline (0..63) */
+extern void ks0108_startline(unsigned char startline);
+
+/* Set the controller's current address (0..63) */
+extern void ks0108_address(unsigned char address);
+
+/* Set the controller's current page (0..7) */
+extern void ks0108_page(unsigned char page);
+
+#endif /* _KS0108_H_ */
