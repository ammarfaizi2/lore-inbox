Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966889AbWKZAo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966889AbWKZAo5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 19:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935217AbWKZAo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 19:44:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56846 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S935213AbWKZAo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 19:44:56 -0500
Date: Sun, 26 Nov 2006 01:45:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove DVB_AV7110_FIRMWARE
Message-ID: <20061126004500.GB15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVB_AV7110_FIRMWARE was (except for some OSS drivers) the only option 
that was still compiling a binary-only user-supplied firmware file at 
build-time into the kernel.

This patch changes the driver to always use the standard 
request_firmware() way for firmware by removing DVB_AV7110_FIRMWARE.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/dvb/ttpci/Kconfig  |   20 --------------
 drivers/media/dvb/ttpci/Makefile |    8 -----
 drivers/media/dvb/ttpci/av7110.c |   15 ----------
 drivers/media/dvb/ttpci/fdump.c  |   44 -------------------------------
 4 files changed, 1 insertion(+), 86 deletions(-)

--- linux-2.6.19-rc6-mm1/drivers/media/dvb/ttpci/Kconfig.old	2006-11-26 00:41:45.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/media/dvb/ttpci/Kconfig	2006-11-26 00:42:06.000000000 +0100
@@ -1,7 +1,7 @@
 config DVB_AV7110
 	tristate "AV7110 cards"
 	depends on DVB_CORE && PCI && I2C && VIDEO_V4L1
-	select FW_LOADER if !DVB_AV7110_FIRMWARE
+	select FW_LOADER
 	select VIDEO_SAA7146_VV
 	select DVB_PLL
 	select DVB_VES1820 if !DVB_FE_CUSTOMISE
@@ -26,24 +26,6 @@
 
 	  Say Y if you own such a card and want to use it.
 
-config DVB_AV7110_FIRMWARE
-	bool "Compile AV7110 firmware into the driver"
-	depends on DVB_AV7110 && !STANDALONE
-	default y if DVB_AV7110=y
-	help
-	  The AV7110 firmware is normally loaded by the firmware hotplug manager.
-	  If you want to compile the firmware into the driver you need to say
-	  Y here and provide the correct path of the firmware. You need this
-	  option if you want to compile the whole driver statically into the
-	  kernel.
-
-	  All other people say N.
-
-config DVB_AV7110_FIRMWARE_FILE
-	string "Full pathname of av7110 firmware file"
-	depends on DVB_AV7110_FIRMWARE
-	default "/usr/lib/hotplug/firmware/dvb-ttpci-01.fw"
-
 config DVB_AV7110_OSD
 	bool "AV7110 OSD support"
 	depends on DVB_AV7110
--- linux-2.6.19-rc6-mm1/drivers/media/dvb/ttpci/Makefile.old	2006-11-26 00:42:15.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/media/dvb/ttpci/Makefile	2006-11-26 00:42:28.000000000 +0100
@@ -13,11 +13,3 @@
 
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/dvb/frontends/
 
-hostprogs-y	:= fdump
-
-ifeq ($(CONFIG_DVB_AV7110_FIRMWARE),y)
-$(obj)/av7110.o: $(obj)/av7110_firm.h
-
-$(obj)/av7110_firm.h: $(obj)/fdump
-	$(obj)/fdump $(CONFIG_DVB_AV7110_FIRMWARE_FILE) dvb_ttpci_fw $@
-endif
--- linux-2.6.19-rc6-mm1/drivers/media/dvb/ttpci/av7110.c.old	2006-11-26 00:43:18.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/media/dvb/ttpci/av7110.c	2006-11-26 00:43:58.000000000 +0100
@@ -1484,20 +1484,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_DVB_AV7110_FIRMWARE_FILE
-#include "av7110_firm.h"
-static void put_firmware(struct av7110* av7110)
-{
-	av7110->bin_fw = NULL;
-}
-
-static inline int get_firmware(struct av7110* av7110)
-{
-	av7110->bin_fw = dvb_ttpci_fw;
-	av7110->size_fw = sizeof(dvb_ttpci_fw);
-	return check_firmware(av7110);
-}
-#else
 static void put_firmware(struct av7110* av7110)
 {
 	vfree(av7110->bin_fw);
@@ -1546,7 +1532,6 @@
 	release_firmware(fw);
 	return ret;
 }
-#endif
 
 
 static int alps_bsrv2_tuner_set_params(struct dvb_frontend* fe, struct dvb_frontend_parameters *params)
--- linux-2.6.19-rc6-mm1/drivers/media/dvb/ttpci/fdump.c	2006-09-20 05:42:06.000000000 +0200
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,44 +0,0 @@
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
-
-int main(int argc, char **argv)
-{
-    unsigned char buf[8];
-    unsigned int i, count, bytes = 0;
-    FILE *fd_in, *fd_out;
-
-    if (argc != 4) {
-	fprintf(stderr, "\n\tusage: %s <ucode.bin> <array_name> <output_name>\n\n", argv[0]);
-	return -1;
-    }
-
-    fd_in = fopen(argv[1], "rb");
-    if (fd_in == NULL) {
-	fprintf(stderr, "firmware file '%s' not found\n", argv[1]);
-	return -1;
-    }
-
-    fd_out = fopen(argv[3], "w+");
-    if (fd_out == NULL) {
-	fprintf(stderr, "cannot create output file '%s'\n", argv[3]);
-	return -1;
-    }
-
-    fprintf(fd_out, "\n#include <asm/types.h>\n\nu8 %s [] = {", argv[2]);
-
-    while ((count = fread(buf, 1, 8, fd_in)) > 0) {
-	fprintf(fd_out, "\n\t");
-	for (i = 0; i < count; i++, bytes++)
-	    fprintf(fd_out, "0x%02x, ", buf[i]);
-    }
-
-    fprintf(fd_out, "\n};\n\n");
-
-    fclose(fd_in);
-    fclose(fd_out);
-
-    return 0;
-}

