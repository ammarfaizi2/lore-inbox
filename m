Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUCLJXc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 04:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUCLJXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 04:23:32 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:46741 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262050AbUCLJWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 04:22:54 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-mm1: unknown symbols cauased by remove-more-KERNEL_SYSCALLS.patch
Date: Fri, 12 Mar 2004 10:14:40 +0100
User-Agent: KMail/1.6.1
References: <20040310233140.3ce99610.akpm@osdl.org> <20040311203108.GE14833@fs.tum.de>
In-Reply-To: <20040311203108.GE14833@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403121014.40889.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 March 2004 21:31, you wrote:
> This causes the following unknown symbols in modules on i386:

Sorry, that could not work. This patch reverts my changes to loadable
device drivers. As Arjan van de Ven already noted, they have to
be converted to request_firmware() anyway.

	Arnd <><

 drivers/media/dvb/frontends/alps_tdlb7.c |   12 ++++++++----
 drivers/media/dvb/frontends/sp887x.c     |   11 +++++++----
 drivers/media/dvb/frontends/tda1004x.c   |   10 ++++++----
 sound/isa/wavefront/wavefront_synth.c    |   12 ++++++------
 sound/oss/wavfront.c                     |   12 +++++++-----
 5 files changed, 34 insertions(+), 23 deletions(-)

diff -u -r linux-2.6.4-mm1/drivers/media/dvb/frontends/alps_tdlb7.c linux-2.6.4-mm1-patched/drivers/media/dvb/frontends/alps_tdlb7.c
--- linux-2.6.4-mm1/drivers/media/dvb/frontends/alps_tdlb7.c	2004-03-12 10:03:46.000000000 +0100
+++ linux-2.6.4-mm1-patched/drivers/media/dvb/frontends/alps_tdlb7.c	2004-03-12 10:07:51.000000000 +0100
@@ -29,6 +29,8 @@
 */  
 
 
+
+#define __KERNEL_SYSCALLS__
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/vmalloc.h>
@@ -56,6 +58,8 @@
 #define SP8870_FIRMWARE_OFFSET 0x0A
 
 
+static int errno;
+
 static struct dvb_frontend_info tdlb7_info = {
 	.name			= "Alps TDLB7",
 	.type			= FE_OFDM,
@@ -170,13 +174,13 @@
 	loff_t filesize;
 	char *dp;
 
-	fd = sys_open(fn, 0, 0);
+	fd = open(fn, 0, 0);
 	if (fd == -1) {
                 printk("%s: unable to open '%s'.\n", __FUNCTION__, fn);
 		return -EIO;
 	}
 
-	filesize = sys_lseek(fd, 0L, 2);
+	filesize = lseek(fd, 0L, 2);
 	if (filesize <= 0 || filesize < SP8870_FIRMWARE_OFFSET + SP8870_FIRMWARE_SIZE) {
 	        printk("%s: firmware filesize to small '%s'\n", __FUNCTION__, fn);
 		sys_close(fd);
@@ -190,8 +194,8 @@
 		return -EIO;
 	}
 
-	sys_lseek(fd, SP8870_FIRMWARE_OFFSET, 0);
-	if (sys_read(fd, dp, SP8870_FIRMWARE_SIZE) != SP8870_FIRMWARE_SIZE) {
+	lseek(fd, SP8870_FIRMWARE_OFFSET, 0);
+	if (read(fd, dp, SP8870_FIRMWARE_SIZE) != SP8870_FIRMWARE_SIZE) {
 		printk("%s: failed to read '%s'.\n",__FUNCTION__, fn);
 		vfree(dp);
 		sys_close(fd);
diff -u -r linux-2.6.4-mm1/drivers/media/dvb/frontends/sp887x.c linux-2.6.4-mm1-patched/drivers/media/dvb/frontends/sp887x.c
--- linux-2.6.4-mm1/drivers/media/dvb/frontends/sp887x.c	2004-03-12 10:03:46.000000000 +0100
+++ linux-2.6.4-mm1-patched/drivers/media/dvb/frontends/sp887x.c	2004-03-12 10:07:51.000000000 +0100
@@ -12,6 +12,7 @@
    next 0x4000 loaded. This may change in future versions.
  */
 
+#define __KERNEL_SYSCALLS__
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
@@ -67,6 +68,8 @@
 		FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_RECOVER
 };
 
+static int errno;
+
 static
 int i2c_writebytes (struct dvb_frontend *fe, u8 addr, u8 *buf, u8 len)
 {
@@ -213,13 +216,13 @@
 
 	// Load the firmware
 	set_fs(get_ds());
-	fd = sys_open(sp887x_firmware, 0, 0);
+	fd = open(sp887x_firmware, 0, 0);
 	if (fd < 0) {
 		printk(KERN_WARNING "%s: Unable to open firmware %s\n", __FUNCTION__,
 		       sp887x_firmware);
 		return -EIO;
 	}
-	filesize = sys_lseek(fd, 0L, 2);
+	filesize = lseek(fd, 0L, 2);
 	if (filesize <= 0) {
 		printk(KERN_WARNING "%s: Firmware %s is empty\n", __FUNCTION__,
 		       sp887x_firmware);
@@ -241,8 +244,8 @@
 	// read it!
 	// read the first 16384 bytes from the file
 	// ignore the first 10 bytes
-	sys_lseek(fd, 10, 0);
-	if (sys_read(fd, firmware, fw_size) != fw_size) {
+	lseek(fd, 10, 0);
+	if (read(fd, firmware, fw_size) != fw_size) {
 		printk(KERN_WARNING "%s: Failed to read firmware\n", __FUNCTION__);
 		vfree(firmware);
 		sys_close(fd);
diff -u -r linux-2.6.4-mm1/drivers/media/dvb/frontends/tda1004x.c linux-2.6.4-mm1-patched/drivers/media/dvb/frontends/tda1004x.c
--- linux-2.6.4-mm1/drivers/media/dvb/frontends/tda1004x.c	2004-03-12 10:03:46.000000000 +0100
+++ linux-2.6.4-mm1-patched/drivers/media/dvb/frontends/tda1004x.c	2004-03-12 10:07:51.000000000 +0100
@@ -32,6 +32,7 @@
  */
 
 
+#define __KERNEL_SYSCALLS__
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
@@ -40,6 +41,7 @@
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/fs.h>
+#include <linux/unistd.h>
 #include <linux/fcntl.h>
 #include <linux/errno.h>
 #include "dvb_frontend.h"
@@ -397,13 +399,13 @@
 
 	// Load the firmware
 	set_fs(get_ds());
-	fd = sys_open(tda1004x_firmware, 0, 0);
+	fd = open(tda1004x_firmware, 0, 0);
 	if (fd < 0) {
 		printk("%s: Unable to open firmware %s\n", __FUNCTION__,
 		       tda1004x_firmware);
 		return -EIO;
 	}
-	filesize = sys_lseek(fd, 0L, 2);
+	filesize = lseek(fd, 0L, 2);
 	if (filesize <= 0) {
 		printk("%s: Firmware %s is empty\n", __FUNCTION__,
 		       tda1004x_firmware);
@@ -434,8 +436,8 @@
 	}
 
 	// read it!
-        sys_lseek(fd, fw_offset, 0);
-	if (sys_read(fd, firmware, fw_size) != fw_size) {
+        lseek(fd, fw_offset, 0);
+	if (read(fd, firmware, fw_size) != fw_size) {
 		printk("%s: Failed to read firmware\n", __FUNCTION__);
 		vfree(firmware);
 		sys_close(fd);
diff -u -r linux-2.6.4-mm1/sound/isa/wavefront/wavefront_synth.c linux-2.6.4-mm1-patched/sound/isa/wavefront/wavefront_synth.c
--- linux-2.6.4-mm1/sound/isa/wavefront/wavefront_synth.c	2004-03-12 10:03:50.000000000 +0100
+++ linux-2.6.4-mm1-patched/sound/isa/wavefront/wavefront_synth.c	2004-03-12 10:07:51.000000000 +0100
@@ -1913,11 +1913,11 @@
 	return (1);
 }
 
+#define __KERNEL_SYSCALLS__
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/unistd.h>
-#include <linux/syscalls.h>
 #include <asm/uaccess.h>
 
 static int errno;
@@ -1947,7 +1947,7 @@
 	fs = get_fs();
 	set_fs (get_ds());
 
-	if ((fd = sys_open (path, 0, 0)) < 0) {
+	if ((fd = open (path, 0, 0)) < 0) {
 		snd_printk ("Unable to load \"%s\".\n",
 			path);
 		return 1;
@@ -1956,7 +1956,7 @@
 	while (1) {
 		int x;
 
-		if ((x = sys_read (fd, &section_length, sizeof (section_length))) !=
+		if ((x = read (fd, &section_length, sizeof (section_length))) !=
 		    sizeof (section_length)) {
 			snd_printk ("firmware read error.\n");
 			goto failure;
@@ -1966,7 +1966,7 @@
 			break;
 		}
 
-		if (sys_read (fd, section, section_length) != section_length) {
+		if (read (fd, section, section_length) != section_length) {
 			snd_printk ("firmware section "
 				"read error.\n");
 			goto failure;
@@ -2005,12 +2005,12 @@
 
 	}
 
-	sys_close (fd);
+	close (fd);
 	set_fs (fs);
 	return 0;
 
  failure:
-	sys_close (fd);
+	close (fd);
 	set_fs (fs);
 	snd_printk ("firmware download failed!!!\n");
 	return 1;
diff -u -r linux-2.6.4-mm1/sound/oss/wavfront.c linux-2.6.4-mm1-patched/sound/oss/wavfront.c
--- linux-2.6.4-mm1/sound/oss/wavfront.c	2004-03-12 10:03:50.000000000 +0100
+++ linux-2.6.4-mm1-patched/sound/oss/wavfront.c	2004-03-12 10:07:51.000000000 +0100
@@ -2490,9 +2490,11 @@
 }
 
 #include "os.h"
+#define __KERNEL_SYSCALLS__
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/unistd.h>
 #include <asm/uaccess.h>
 
 static int errno; 
@@ -2522,7 +2524,7 @@
 	fs = get_fs();
 	set_fs (get_ds());
 
-	if ((fd = sys_open (path, 0, 0)) < 0) {
+	if ((fd = open (path, 0, 0)) < 0) {
 		printk (KERN_WARNING LOGNAME "Unable to load \"%s\".\n",
 			path);
 		return 1;
@@ -2531,7 +2533,7 @@
 	while (1) {
 		int x;
 
-		if ((x = sys_read (fd, &section_length, sizeof (section_length))) !=
+		if ((x = read (fd, &section_length, sizeof (section_length))) !=
 		    sizeof (section_length)) {
 			printk (KERN_ERR LOGNAME "firmware read error.\n");
 			goto failure;
@@ -2541,7 +2543,7 @@
 			break;
 		}
 
-		if (sys_read (fd, section, section_length) != section_length) {
+		if (read (fd, section, section_length) != section_length) {
 			printk (KERN_ERR LOGNAME "firmware section "
 				"read error.\n");
 			goto failure;
@@ -2580,12 +2582,12 @@
 
 	}
 
-	sys_close (fd);
+	close (fd);
 	set_fs (fs);
 	return 0;
 
  failure:
-	sys_close (fd);
+	close (fd);
 	set_fs (fs);
 	printk (KERN_ERR "\nWaveFront: firmware download failed!!!\n");
 	return 1;
