Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSHIUV5>; Fri, 9 Aug 2002 16:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSHIUV5>; Fri, 9 Aug 2002 16:21:57 -0400
Received: from crl-mail.crl.dec.com ([192.58.206.9]:26117 "EHLO
	crl-mail.crl.dec.com") by vger.kernel.org with ESMTP
	id <S315806AbSHIUVO>; Fri, 9 Aug 2002 16:21:14 -0400
From: James Hicks <Jamey.Hicks@hp.com>
To: linux-kernel@vger.kernel.org
Subject: new driver: multimedia card (mmc) framework, patch against 2.4.19 
Reply-To: Jamey.Hicks@hp.com
Cc: marcelo@conectiva.com.br
Message-Id: <20020809202415.948F628B80A@rockhopper.crl.dec.com>
Date: Fri,  9 Aug 2002 16:24:15 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch implements the core framework for Multimedia Cards (MMC).  It
has been tested with iPAQ H3800 handhelds with MMC storage cards.

At the moment, access to the information required to write a driver for SD
or SDIO requires signing and NDA that precludes the release of an open
source driver, so only MMC is supported at this time.
 
Jamey Hicks
jamey.hicks@hp.com



diff -ruwN -X dontdiff linux-2.4.19/Documentation/Configure.help linux-2.4.19-mmc1/Documentation/Configure.help
--- linux-2.4.19/Documentation/Configure.help	Fri Aug  2 20:39:42 2002
+++ linux-2.4.19-mmc1/Documentation/Configure.help	Fri Aug  9 14:45:17 2002
@@ -14257,6 +14257,25 @@
   The module will be called bluetooth.o. If you want to compile it as
   a module, say M here and read <file:Documentation/modules.txt>.
 
+MMC/SD Card support
+CONFIG_MMC
+  Say Y or M here if you want to enable support for Multimedia or
+  Secure Digital Cards.  You will need an MMC/SD socket and drivers
+  for your socket.  At the moment, access to the information required
+  to write a driver for SD or SDIO requires signing and NDA that
+  precludes the release of an open source driver, so only MMC is
+  supported at this time.  If you want to compile it as a module, say
+  M here and read <file:Documentation/modules.txt>.
+
+MMC debugging
+CONFIG_MMC_DEBUG
+  Say Y here if you want to enable debug output from the MMC drivers.
+
+MMC debugging verbosity
+CONFIG_MMC_DEBUG_VERBOSE
+  Enter a number from 0 (quiet) to 3 (noisy) here to control the
+  verbosity of MMC debug output.
+
 Minix fs support
 CONFIG_MINIX_FS
   Minix is a simple operating system used in many classes about OS's.
diff -ruwN -X dontdiff linux-2.4.19/MAINTAINERS linux-2.4.19-mmc1/MAINTAINERS
--- linux-2.4.19/MAINTAINERS	Fri Aug  2 20:39:42 2002
+++ linux-2.4.19-mmc1/MAINTAINERS	Fri Aug  9 12:50:27 2002
@@ -1013,6 +1013,14 @@
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+MULTIMEDIA CARD (MMC) SUBSYSTEM
+P: Andrew Christian
+P: Jamey Hicks
+P: George France
+L: MMC-Developer's <mmc-dev@handhelds.org>
+W: http://www.handhelds.org/pub/linux/mmc/
+S: Maintained
+
 MODULE SUPPORT [GENERAL], KMOD
 P:	Keith Owens
 M:	kaos@ocs.com.au
diff -ruwN -X dontdiff linux-2.4.19/arch/alpha/config.in linux-2.4.19-mmc1/arch/alpha/config.in
--- linux-2.4.19/arch/alpha/config.in	Fri Aug  2 20:39:42 2002
+++ linux-2.4.19-mmc1/arch/alpha/config.in	Fri Aug  9 12:37:54 2002
@@ -404,6 +404,7 @@
 source drivers/input/Config.in
 
 source net/bluetooth/Config.in
+source drivers/mmc/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
diff -ruwN -X dontdiff linux-2.4.19/arch/arm/config.in linux-2.4.19-mmc1/arch/arm/config.in
--- linux-2.4.19/arch/arm/config.in	Fri Aug  2 20:39:42 2002
+++ linux-2.4.19-mmc1/arch/arm/config.in	Fri Aug  9 12:37:45 2002
@@ -630,6 +630,7 @@
 source drivers/usb/Config.in
 
 source net/bluetooth/Config.in
+source drivers/mmc/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
diff -ruwN -X dontdiff linux-2.4.19/arch/cris/config.in linux-2.4.19-mmc1/arch/cris/config.in
--- linux-2.4.19/arch/cris/config.in	Mon Feb 25 14:37:52 2002
+++ linux-2.4.19-mmc1/arch/cris/config.in	Fri Aug  9 12:38:23 2002
@@ -244,6 +244,7 @@
 endmenu
 
 source drivers/usb/Config.in
+source drivers/mmc/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
diff -ruwN -X dontdiff linux-2.4.19/arch/i386/config.in linux-2.4.19-mmc1/arch/i386/config.in
--- linux-2.4.19/arch/i386/config.in	Fri Aug  2 20:39:42 2002
+++ linux-2.4.19-mmc1/arch/i386/config.in	Fri Aug  9 12:37:32 2002
@@ -411,6 +411,7 @@
 source drivers/usb/Config.in
 
 source net/bluetooth/Config.in
+source drivers/mmc/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
diff -ruwN -X dontdiff linux-2.4.19/arch/ia64/config.in linux-2.4.19-mmc1/arch/ia64/config.in
--- linux-2.4.19/arch/ia64/config.in	Fri Aug  2 20:39:42 2002
+++ linux-2.4.19-mmc1/arch/ia64/config.in	Fri Aug  9 12:38:35 2002
@@ -257,6 +257,7 @@
   endmenu
 fi
 
+source drivers/mmc/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
diff -ruwN -X dontdiff linux-2.4.19/arch/m68k/config.in linux-2.4.19-mmc1/arch/m68k/config.in
--- linux-2.4.19/arch/m68k/config.in	Fri Aug  2 20:39:43 2002
+++ linux-2.4.19-mmc1/arch/m68k/config.in	Fri Aug  9 12:38:47 2002
@@ -554,6 +554,8 @@
    endmenu
 fi
 
+source drivers/mmc/Config.in
+
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
diff -ruwN -X dontdiff linux-2.4.19/arch/mips/config.in linux-2.4.19-mmc1/arch/mips/config.in
--- linux-2.4.19/arch/mips/config.in	Fri Aug  2 20:39:43 2002
+++ linux-2.4.19-mmc1/arch/mips/config.in	Fri Aug  9 12:39:00 2002
@@ -621,6 +621,8 @@
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
+source drivers/mmc/Config.in
+
 bool 'Are you using a crosscompiler' CONFIG_CROSSCOMPILE
 if [ "$CONFIG_SERIAL" = "y" -o "$CONFIG_AU1000_UART" = "y" ]; then
   bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
diff -ruwN -X dontdiff linux-2.4.19/arch/mips64/config.in linux-2.4.19-mmc1/arch/mips64/config.in
--- linux-2.4.19/arch/mips64/config.in	Fri Aug  2 20:39:43 2002
+++ linux-2.4.19-mmc1/arch/mips64/config.in	Fri Aug  9 12:57:31 2002
@@ -322,6 +322,7 @@
 source drivers/usb/Config.in
 
 source net/bluetooth/Config.in
+source drivers/mmc/Config.in
 
 source drivers/input/Config.in
 
diff -ruwN -X dontdiff linux-2.4.19/arch/parisc/config.in linux-2.4.19-mmc1/arch/parisc/config.in
--- linux-2.4.19/arch/parisc/config.in	Tue Apr 17 20:19:25 2001
+++ linux-2.4.19-mmc1/arch/parisc/config.in	Fri Aug  9 12:57:40 2002
@@ -201,6 +201,8 @@
 fi
 # endmenu
 
+source drivers/mmc/Config.in
+
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
diff -ruwN -X dontdiff linux-2.4.19/arch/ppc/config.in linux-2.4.19-mmc1/arch/ppc/config.in
--- linux-2.4.19/arch/ppc/config.in	Fri Aug  2 20:39:43 2002
+++ linux-2.4.19-mmc1/arch/ppc/config.in	Fri Aug  9 12:57:48 2002
@@ -394,6 +394,7 @@
 source drivers/usb/Config.in
 
 source net/bluetooth/Config.in
+source drivers/mmc/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
diff -ruwN -X dontdiff linux-2.4.19/arch/ppc64/config.in linux-2.4.19-mmc1/arch/ppc64/config.in
--- linux-2.4.19/arch/ppc64/config.in	Fri Aug  2 20:39:43 2002
+++ linux-2.4.19-mmc1/arch/ppc64/config.in	Fri Aug  9 12:57:57 2002
@@ -225,6 +225,7 @@
 endmenu
 
 source drivers/usb/Config.in
+source drivers/mmc/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
diff -ruwN -X dontdiff linux-2.4.19/arch/s390/config.in linux-2.4.19-mmc1/arch/s390/config.in
--- linux-2.4.19/arch/s390/config.in	Fri Aug  2 20:39:43 2002
+++ linux-2.4.19-mmc1/arch/s390/config.in	Fri Aug  9 12:58:03 2002
@@ -64,6 +64,7 @@
 fi
 
 source fs/Config.in
+source drivers/mmc/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
diff -ruwN -X dontdiff linux-2.4.19/arch/s390x/config.in linux-2.4.19-mmc1/arch/s390x/config.in
--- linux-2.4.19/arch/s390x/config.in	Fri Aug  2 20:39:43 2002
+++ linux-2.4.19-mmc1/arch/s390x/config.in	Fri Aug  9 12:58:11 2002
@@ -66,6 +66,7 @@
 fi
 
 source fs/Config.in
+source drivers/mmc/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
diff -ruwN -X dontdiff linux-2.4.19/arch/sh/config.in linux-2.4.19-mmc1/arch/sh/config.in
--- linux-2.4.19/arch/sh/config.in	Mon Feb 25 14:37:56 2002
+++ linux-2.4.19-mmc1/arch/sh/config.in	Fri Aug  9 12:58:20 2002
@@ -377,6 +377,8 @@
 fi
 endmenu
 
+source drivers/mmc/Config.in
+
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
diff -ruwN -X dontdiff linux-2.4.19/arch/sparc/config.in linux-2.4.19-mmc1/arch/sparc/config.in
--- linux-2.4.19/arch/sparc/config.in	Fri Aug  2 20:39:43 2002
+++ linux-2.4.19-mmc1/arch/sparc/config.in	Fri Aug  9 12:58:32 2002
@@ -266,6 +266,8 @@
 tristate 'Software watchdog' CONFIG_SOFT_WATCHDOG
 endmenu
 
+source drivers/mmc/Config.in
+
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
diff -ruwN -X dontdiff linux-2.4.19/arch/sparc64/config.in linux-2.4.19-mmc1/arch/sparc64/config.in
--- linux-2.4.19/arch/sparc64/config.in	Fri Aug  2 20:39:43 2002
+++ linux-2.4.19-mmc1/arch/sparc64/config.in	Fri Aug  9 12:58:42 2002
@@ -291,6 +291,8 @@
 tristate 'Software watchdog' CONFIG_SOFT_WATCHDOG
 endmenu
 
+source drivers/mmc/Config.in
+
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
diff -ruwN -X dontdiff linux-2.4.19/drivers/Makefile linux-2.4.19-mmc1/drivers/Makefile
--- linux-2.4.19/drivers/Makefile	Fri Aug  2 20:39:43 2002
+++ linux-2.4.19-mmc1/drivers/Makefile	Fri Aug  9 12:37:12 2002
@@ -46,5 +46,6 @@
 subdir-$(CONFIG_ACPI)		+= acpi
 
 subdir-$(CONFIG_BLUEZ)		+= bluetooth
+subdir-$(CONFIG_MMC)		+= mmc
 
 include $(TOPDIR)/Rules.make
diff -ruwN -X dontdiff linux-2.4.19/drivers/mmc/Config.in linux-2.4.19-mmc1/drivers/mmc/Config.in
--- linux-2.4.19/drivers/mmc/Config.in	Wed Dec 31 19:00:00 1969
+++ linux-2.4.19-mmc1/drivers/mmc/Config.in	Tue Jun 18 08:38:40 2002
@@ -0,0 +1,15 @@
+#
+# MMC subsystem configuration
+#
+mainmenu_option next_comment
+comment 'MMC/SD Card support'
+
+tristate 'MMC support' CONFIG_MMC
+if [ "$CONFIG_MMC" = "y" -o "$CONFIG_MMC" = "m" ]; then
+  bool '  MMC debugging' CONFIG_MMC_DEBUG
+  if [ "$CONFIG_MMC_DEBUG" = "y" ]; then
+    int '  MMC debugging verbosity (0=quiet, 3=noisy)' CONFIG_MMC_DEBUG_VERBOSE 0
+  fi
+fi
+
+endmenu
diff -ruwN -X dontdiff linux-2.4.19/drivers/mmc/Makefile linux-2.4.19-mmc1/drivers/mmc/Makefile
--- linux-2.4.19/drivers/mmc/Makefile	Wed Dec 31 19:00:00 1969
+++ linux-2.4.19-mmc1/drivers/mmc/Makefile	Tue Jun 18 08:38:40 2002
@@ -0,0 +1,20 @@
+#
+# Makefile for the kernel mmc device drivers.
+#
+
+O_TARGET := mmc.o
+
+export-objs := mmc_core.o
+
+obj-$(CONFIG_MMC) += mmc_base.o
+
+# Declare multi-part drivers.
+list-multi := mmc_base.o
+mmc_base-objs := mmc_protocol.o mmc_core.o mmc_media.o
+
+include $(TOPDIR)/Rules.make
+
+# Link rules for multi-part drivers.
+
+mmc_base.o: $(mmc_base-objs)
+	$(LD) -r -o $@ $(mmc_base-objs)
diff -ruwN -X dontdiff linux-2.4.19/drivers/mmc/mmc_core.c linux-2.4.19-mmc1/drivers/mmc/mmc_core.c
--- linux-2.4.19/drivers/mmc/mmc_core.c	Wed Dec 31 19:00:00 1969
+++ linux-2.4.19-mmc1/drivers/mmc/mmc_core.c	Fri Aug  9 16:18:37 2002
@@ -0,0 +1,839 @@
+/*
+ * Core MMC driver functions
+ *
+ * Copyright (c) 2002 Hewlett-Packard Company
+ *   
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *  
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *  
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Many thanks to Alessandro Rubini and Jonathan Corbet!
+ *
+ * Author:  Andrew Christian
+ *          6 May 2002 */
+
+#include <linux/config.h>
+#include <linux/module.h>
+
+#include <linux/version.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/list.h>
+#include <linux/sysctl.h>
+#include <linux/pm.h>
+
+#include "mmc_core.h"
+
+#define STATE_CMD_ACTIVE   (1<<0)
+#define STATE_CMD_DONE     (1<<1)
+#define STATE_INSERT       (1<<2)
+#define STATE_EJECT        (1<<3)
+
+static struct mmc_dev          g_mmc_dev;
+static struct proc_dir_entry  *proc_mmc_dir;
+
+int g_mmc_debug = CONFIG_MMC_DEBUG_VERBOSE;
+EXPORT_SYMBOL(g_mmc_debug);
+
+/**************************************************************************
+ * Debugging functions
+ **************************************************************************/
+
+static char * mmc_result_strings[] = {
+	"NO_RESPONSE",
+	"NO_ERROR",
+	"ERROR_OUT_OF_RANGE",
+	"ERROR_ADDRESS",
+	"ERROR_BLOCK_LEN",
+	"ERROR_ERASE_SEQ",
+	"ERROR_ERASE_PARAM",
+	"ERROR_WP_VIOLATION",
+	"ERROR_CARD_IS_LOCKED",
+	"ERROR_LOCK_UNLOCK_FAILED",
+	"ERROR_COM_CRC",
+	"ERROR_ILLEGAL_COMMAND",
+	"ERROR_CARD_ECC_FAILED",
+	"ERROR_CC",
+	"ERROR_GENERAL",
+	"ERROR_UNDERRUN",
+	"ERROR_OVERRUN",
+	"ERROR_CID_CSD_OVERWRITE",
+	"ERROR_STATE_MISMATCH",
+	"ERROR_HEADER_MISMATCH",
+	"ERROR_TIMEOUT",
+	"ERROR_CRC",
+	"ERROR_DRIVER_FAILURE",
+};
+
+char * mmc_result_to_string( int i )
+{
+	return mmc_result_strings[i+1];
+}
+
+static char * card_state_strings[] = {
+	"empty",
+	"idle",
+	"ready",
+	"ident",
+	"stby",
+	"tran",
+	"data",
+	"rcv",
+	"prg",
+	"dis",
+};
+
+static inline char * card_state_to_string( int i )
+{
+	return card_state_strings[i+1];
+}
+
+/**************************************************************************
+ * Utility functions
+ **************************************************************************/
+
+#define PARSE_U32(_buf,_index) \
+	(((u32)_buf[_index]) << 24) | (((u32)_buf[_index+1]) << 16) | \
+        (((u32)_buf[_index+2]) << 8) | ((u32)_buf[_index+3]);
+
+#define PARSE_U16(_buf,_index) \
+	(((u16)_buf[_index]) << 8) | ((u16)_buf[_index+1]);
+
+int mmc_unpack_csd( struct mmc_request *request, struct mmc_csd *csd )
+{
+	u8 *buf = request->response;
+	
+	if ( request->result ) return request->result;
+
+	csd->csd_structure      = (buf[1] & 0xc0) >> 6;
+	csd->spec_vers          = (buf[1] & 0x3c) >> 2;
+	csd->taac               = buf[2];
+	csd->nsac               = buf[3];
+	csd->tran_speed         = buf[4];
+	csd->ccc                = (((u16)buf[5]) << 4) | ((buf[6] & 0xf0) >> 4);
+	csd->read_bl_len        = buf[6] & 0x0f;
+	csd->read_bl_partial    = (buf[7] & 0x80) ? 1 : 0;
+	csd->write_blk_misalign = (buf[7] & 0x40) ? 1 : 0;
+	csd->read_blk_misalign  = (buf[7] & 0x20) ? 1 : 0;
+	csd->dsr_imp            = (buf[7] & 0x10) ? 1 : 0;
+	csd->c_size             = ((((u16)buf[7]) & 0x03) << 10) | (((u16)buf[8]) << 2) | (((u16)buf[9]) & 0xc0) >> 6;
+	csd->vdd_r_curr_min     = (buf[9] & 0x38) >> 3;
+	csd->vdd_r_curr_max     = buf[9] & 0x07;
+	csd->vdd_w_curr_min     = (buf[10] & 0xe0) >> 5;
+	csd->vdd_w_curr_max     = (buf[10] & 0x1c) >> 2;
+	csd->c_size_mult        = ((buf[10] & 0x03) << 1) | ((buf[11] & 0x80) >> 7);
+	switch ( csd->csd_structure ) {
+	case CSD_STRUCT_VER_1_0:
+	case CSD_STRUCT_VER_1_1:
+		csd->erase.v22.sector_size    = (buf[11] & 0x7c) >> 2;
+		csd->erase.v22.erase_grp_size = ((buf[11] & 0x03) << 3) | ((buf[12] & 0xe0) >> 5);
+		break;
+	case CSD_STRUCT_VER_1_2:
+	default:
+		csd->erase.v31.erase_grp_size = (buf[11] & 0x7c) >> 2;
+		csd->erase.v31.erase_grp_mult = ((buf[11] & 0x03) << 3) | ((buf[12] & 0xe0) >> 5);
+		break;
+	}
+	csd->wp_grp_size        = buf[12] & 0x1f;
+	csd->wp_grp_enable      = (buf[13] & 0x80) ? 1 : 0;
+	csd->default_ecc        = (buf[13] & 0x60) >> 5;
+	csd->r2w_factor         = (buf[13] & 0x1c) >> 2;
+	csd->write_bl_len       = ((buf[13] & 0x03) << 2) | ((buf[14] & 0xc0) >> 6);
+	csd->write_bl_partial   = (buf[14] & 0x20) ? 1 : 0;
+	csd->file_format_grp    = (buf[15] & 0x80) ? 1 : 0;
+	csd->copy               = (buf[15] & 0x40) ? 1 : 0;
+	csd->perm_write_protect = (buf[15] & 0x20) ? 1 : 0;
+	csd->tmp_write_protect  = (buf[15] & 0x10) ? 1 : 0;
+	csd->file_format        = (buf[15] & 0x0c) >> 2;
+	csd->ecc                = buf[15] & 0x03;
+
+	DEBUG(2,"  csd_structure=%d  spec_vers=%d  taac=%02x  nsac=%02x  tran_speed=%02x\n"
+	      "  ccc=%04x  read_bl_len=%d  read_bl_partial=%d  write_blk_misalign=%d\n"
+	      "  read_blk_misalign=%d  dsr_imp=%d  c_size=%d  vdd_r_curr_min=%d\n"
+	      "  vdd_r_curr_max=%d  vdd_w_curr_min=%d  vdd_w_curr_max=%d  c_size_mult=%d\n"
+	      "  wp_grp_size=%d  wp_grp_enable=%d  default_ecc=%d  r2w_factor=%d\n"
+	      "  write_bl_len=%d  write_bl_partial=%d  file_format_grp=%d  copy=%d\n"
+	      "  perm_write_protect=%d  tmp_write_protect=%d  file_format=%d  ecc=%d\n",
+	      csd->csd_structure, csd->spec_vers, 
+	      csd->taac, csd->nsac, csd->tran_speed,
+	      csd->ccc, csd->read_bl_len, 
+	      csd->read_bl_partial, csd->write_blk_misalign,
+	      csd->read_blk_misalign, csd->dsr_imp, 
+	      csd->c_size, csd->vdd_r_curr_min,
+	      csd->vdd_r_curr_max, csd->vdd_w_curr_min, 
+	      csd->vdd_w_curr_max, csd->c_size_mult,
+	      csd->wp_grp_size, csd->wp_grp_enable,
+	      csd->default_ecc, csd->r2w_factor, 
+	      csd->write_bl_len, csd->write_bl_partial,
+	      csd->file_format_grp, csd->copy, 
+	      csd->perm_write_protect, csd->tmp_write_protect,
+	      csd->file_format, csd->ecc);
+	switch (csd->csd_structure) {
+	case CSD_STRUCT_VER_1_0:
+	case CSD_STRUCT_VER_1_1:
+		DEBUG(2," V22 sector_size=%d erase_grp_size=%d\n", 
+		      csd->erase.v22.sector_size, 
+		      csd->erase.v22.erase_grp_size);
+		break;
+	case CSD_STRUCT_VER_1_2:
+	default:
+		DEBUG(2," V31 erase_grp_size=%d erase_grp_mult=%d\n", 
+		      csd->erase.v31.erase_grp_size,
+		      csd->erase.v31.erase_grp_mult);
+		break;
+		
+	}
+
+	if ( buf[0] != 0x3f )  return MMC_ERROR_HEADER_MISMATCH;
+
+	return 0;
+}
+
+int mmc_unpack_r1( struct mmc_request *request, struct mmc_response_r1 *r1, enum card_state state )
+{
+	u8 *buf = request->response;
+
+	if ( request->result )        return request->result;
+
+	r1->cmd    = buf[0];
+	r1->status = PARSE_U32(buf,1);
+
+	DEBUG(2," cmd=%d status=%08x\n", r1->cmd, r1->status);
+
+	if (R1_STATUS(r1->status)) {
+		if ( r1->status & R1_OUT_OF_RANGE )       return MMC_ERROR_OUT_OF_RANGE;
+		if ( r1->status & R1_ADDRESS_ERROR )      return MMC_ERROR_ADDRESS;
+		if ( r1->status & R1_BLOCK_LEN_ERROR )    return MMC_ERROR_BLOCK_LEN;
+		if ( r1->status & R1_ERASE_SEQ_ERROR )    return MMC_ERROR_ERASE_SEQ;
+		if ( r1->status & R1_ERASE_PARAM )        return MMC_ERROR_ERASE_PARAM;
+		if ( r1->status & R1_WP_VIOLATION )       return MMC_ERROR_WP_VIOLATION;
+		if ( r1->status & R1_CARD_IS_LOCKED )     return MMC_ERROR_CARD_IS_LOCKED;
+		if ( r1->status & R1_LOCK_UNLOCK_FAILED ) return MMC_ERROR_LOCK_UNLOCK_FAILED;
+		if ( r1->status & R1_COM_CRC_ERROR )      return MMC_ERROR_COM_CRC;
+		if ( r1->status & R1_ILLEGAL_COMMAND )    return MMC_ERROR_ILLEGAL_COMMAND;
+		if ( r1->status & R1_CARD_ECC_FAILED )    return MMC_ERROR_CARD_ECC_FAILED;
+		if ( r1->status & R1_CC_ERROR )           return MMC_ERROR_CC;
+		if ( r1->status & R1_ERROR )              return MMC_ERROR_GENERAL;
+		if ( r1->status & R1_UNDERRUN )           return MMC_ERROR_UNDERRUN;
+		if ( r1->status & R1_OVERRUN )            return MMC_ERROR_OVERRUN;
+		if ( r1->status & R1_CID_CSD_OVERWRITE )  return MMC_ERROR_CID_CSD_OVERWRITE;
+	}
+
+	if ( buf[0] != request->cmd ) return MMC_ERROR_HEADER_MISMATCH;
+
+	/* This should be last - it's the least dangerous error */
+	if ( R1_CURRENT_STATE(r1->status) != state ) return MMC_ERROR_STATE_MISMATCH;
+
+	return 0;
+}
+
+int mmc_unpack_cid( struct mmc_request *request, struct mmc_cid *cid )
+{
+	u8 *buf = request->response;
+	int i;
+
+	if ( request->result ) return request->result;
+
+	cid->mid = buf[1];
+	cid->oid = PARSE_U16(buf,2);
+	for ( i = 0 ; i < 6 ; i++ )
+		cid->pnm[i] = buf[4+i];
+	cid->pnm[6] = 0;
+	cid->prv = buf[10];
+	cid->psn = PARSE_U32(buf,11);
+	cid->mdt = buf[15];
+	
+	DEBUG(2," mid=%d oid=%d pnm=%s prv=%d.%d psn=%08x mdt=%d/%d\n",
+	      cid->mid, cid->oid, cid->pnm, 
+	      (cid->prv>>4), (cid->prv&0xf), 
+	      cid->psn, (cid->mdt>>4), (cid->mdt&0xf)+1997);
+
+	if ( buf[0] != 0x3f )  return MMC_ERROR_HEADER_MISMATCH;
+      	return 0;
+}
+
+int mmc_unpack_r3( struct mmc_request *request, struct mmc_response_r3 *r3 )
+{
+	u8 *buf = request->response;
+
+	if ( request->result ) return request->result;
+
+	r3->ocr = PARSE_U32(buf,1);
+	DEBUG(2," ocr=%08x\n", r3->ocr);
+
+	if ( buf[0] != 0x3f )  return MMC_ERROR_HEADER_MISMATCH;
+	return 0;
+}
+
+/**************************************************************************/
+
+#define KBPS 1
+#define MBPS 1000
+
+static u32 ts_exp[] = { 100*KBPS, 1*MBPS, 10*MBPS, 100*MBPS, 0, 0, 0, 0 };
+static u32 ts_mul[] = { 0,    1000, 1200, 1300, 1500, 2000, 2500, 3000, 
+			3500, 4000, 4500, 5000, 5500, 6000, 7000, 8000 };
+
+u32 mmc_tran_speed( u8 ts )
+{
+	u32 rate = ts_exp[(ts & 0x7)] * ts_mul[(ts & 0x78) >> 3];
+
+	if ( rate <= 0 ) {
+		DEBUG(0, ": error - unrecognized speed 0x%02x\n", ts);
+		return 1;
+	}
+
+	return rate;
+}
+
+/**************************************************************************/
+
+void mmc_send_cmd( struct mmc_dev *dev, int cmd, u32 arg, 
+		   u16 nob, u16 block_len, enum mmc_rsp_t rtype )
+{
+	dev->request.cmd       = cmd;
+	dev->request.arg       = arg;
+	dev->request.rtype     = rtype;
+	dev->request.nob       = nob;
+	dev->request.block_len = block_len;
+	dev->request.buffer    = NULL;
+	if ( nob && dev->io_request )
+		dev->request.buffer = dev->io_request->buffer;
+
+	dev->state  |= STATE_CMD_ACTIVE;
+	dev->sdrive->send_cmd(&dev->request);
+}
+
+void mmc_finish_io_request( struct mmc_dev *dev, int result )
+{
+	struct mmc_io_request *t = dev->io_request;
+	struct mmc_slot *slot = dev->slot + t->id;
+
+	dev->io_request = NULL;     // Remove the old request (the media driver may requeue)
+	if ( slot->media_driver )
+		slot->media_driver->io_request_done( t, result );
+}
+
+
+/* Only call this when there is no pending request - it unloads the media driver */
+int mmc_check_eject( struct mmc_dev *dev )
+{
+	unsigned long   flags;
+	int             state;
+	int             i;
+
+	DEBUG(2," dev state=%x\n", dev->state);
+
+	local_irq_save(flags);
+	state = dev->state;
+	dev->state = state & ~STATE_EJECT;
+	local_irq_restore(flags);
+
+	if ( !(state & STATE_EJECT) )
+		return 0;
+
+	for ( i = 0 ; i < dev->num_slots ; i++ ) {
+		struct mmc_slot *slot = dev->slot + i;
+
+		if ( slot->flags & MMC_SLOT_FLAG_EJECT ) {
+			slot->state = CARD_STATE_EMPTY;
+			if ( slot->media_driver ) {
+				slot->media_driver->unload( slot );
+				slot->media_driver = NULL;
+			}
+			slot->flags &= ~MMC_SLOT_FLAG_EJECT;
+			run_sbin_mmc_hotplug(dev,i,0);
+		}
+	}
+	return 1;
+}
+
+int mmc_check_insert( struct mmc_dev *dev )
+{
+	unsigned long   flags;
+	int             state;
+	int             i;
+	int             card_count = 0;
+
+	DEBUG(2," dev state=%x\n", dev->state);
+
+	local_irq_save(flags);
+	state = dev->state;
+	dev->state = state & ~STATE_INSERT;
+	local_irq_restore(flags);
+
+	if ( !(state & STATE_INSERT) ) 
+		return 0;
+
+	for ( i = 0 ; i < dev->num_slots ; i++ ) {
+		struct mmc_slot *slot = dev->slot + i;
+
+		if ( slot->flags & MMC_SLOT_FLAG_INSERT ) {
+			if  (!dev->sdrive->is_empty(i)) {
+				slot->state = CARD_STATE_IDLE;
+				card_count++;
+			}
+			slot->flags &= ~MMC_SLOT_FLAG_INSERT;
+		}
+	}
+	return card_count;
+}
+
+/******************************************************************
+ *
+ * Hotplug callback card insertion/removal
+ *
+ ******************************************************************/
+
+#ifdef CONFIG_HOTPLUG
+
+extern char hotplug_path[];
+extern int call_usermodehelper(char *path, char **argv, char **envp);
+
+static void run_sbin_hotplug(struct mmc_dev *dev, int id, int insert)
+{
+	int i;
+	char *argv[3], *envp[8];
+	char media[64], slotnum[16];
+
+	if (!hotplug_path[0])
+		return;
+
+	DEBUG(0,": hotplug_path=%s id=%d insert=%d\n", hotplug_path, id, insert);
+
+	i = 0;
+	argv[i++] = hotplug_path;
+	argv[i++] = "mmc";
+	argv[i] = 0;
+
+	/* minimal command environment */
+	i = 0;
+	envp[i++] = "HOME=/";
+	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	
+	/* other stuff we want to pass to /sbin/hotplug */
+	sprintf(slotnum, "SLOT=%d", id );
+	if ( dev->slot[id].media_driver && dev->slot[id].media_driver->name )
+		sprintf(media, "MEDIA=%s", dev->slot[id].media_driver->name );
+	else
+		sprintf(media, "MEDIA=unknown");
+
+	envp[i++] = slotnum;
+	envp[i++] = media;
+
+	if (insert)
+		envp[i++] = "ACTION=add";
+	else
+		envp[i++] = "ACTION=remove";
+	envp[i] = 0;
+
+	call_usermodehelper (argv [0], argv, envp);
+}
+
+static void mmc_hotplug_task_handler( void *nr )
+{
+	int insert = ((int) nr) & 0x01;
+	int id     = ((int) nr) >> 1;
+	DEBUG(2," id=%d insert=%d\n", id, insert );
+	run_sbin_hotplug(&g_mmc_dev, id, insert );
+}
+
+static struct tq_struct mmc_hotplug_task = {
+	routine:  mmc_hotplug_task_handler
+};
+
+void run_sbin_mmc_hotplug(struct mmc_dev *dev, int id, int insert )
+{
+	mmc_hotplug_task.data = (void *) ((id << 1) | insert);
+	schedule_task( &mmc_hotplug_task );
+}
+
+#else
+void run_sbin_mmc_hotplug(struct sleeve_dev *sdev, int insert) { }
+#endif /* CONFIG_HOTPLUG */
+
+
+/******************************************************************
+ * Common processing tasklet
+ * Everything gets serialized through this
+ ******************************************************************/
+
+static void mmc_tasklet_action(unsigned long data)
+{
+	struct mmc_dev *dev = (struct mmc_dev *)data;
+	unsigned long   flags;
+	int             state;
+
+	DEBUG(2,": dev=%p flags=%02x\n", dev, dev->state);
+
+	/* Grab the current working state */
+	local_irq_save(flags);
+	state = dev->state;
+	if ( state & STATE_CMD_DONE )
+		dev->state = state & ~(STATE_CMD_DONE | STATE_CMD_ACTIVE);
+	local_irq_restore(flags);
+
+	/* If there is an active command, don't do anything */
+	if ( (state & STATE_CMD_ACTIVE) && !(state & STATE_CMD_DONE) )
+		return;
+
+	if ( dev->protocol )
+		dev->protocol(dev,state);
+}
+
+/******************************************************************
+ * Callbacks from low-level driver
+ * These run at interrupt time
+ ******************************************************************/
+
+void mmc_cmd_complete(struct mmc_request *request)
+{
+	DEBUG(2,": request=%p retval=%d\n", request, request->result);
+	g_mmc_dev.state |= STATE_CMD_DONE;
+	if ( !g_mmc_dev.suspended )
+		tasklet_schedule(&g_mmc_dev.task);
+}
+
+void mmc_insert(int slot)
+{
+	DEBUG(2,": %d\n", slot);
+	g_mmc_dev.state |= STATE_INSERT;
+	g_mmc_dev.slot[slot].flags |= MMC_SLOT_FLAG_INSERT;
+	if ( !g_mmc_dev.suspended )
+		tasklet_schedule(&g_mmc_dev.task);
+}
+
+void mmc_eject(int slot)
+{
+	DEBUG(2,": %d\n", slot);
+	g_mmc_dev.state |= STATE_EJECT;
+	g_mmc_dev.slot[slot].flags |= MMC_SLOT_FLAG_EJECT;
+	if ( !g_mmc_dev.suspended )
+		tasklet_schedule(&g_mmc_dev.task);
+}
+
+EXPORT_SYMBOL(mmc_cmd_complete);
+EXPORT_SYMBOL(mmc_insert);
+EXPORT_SYMBOL(mmc_eject);
+
+/******************************************************************
+ * Called from the media handler
+ ******************************************************************/
+
+void mmc_handle_io_request( struct mmc_io_request *t )
+{
+	DEBUG(2," id=%d cmd=%d sector=%ld nr_sectors=%ld block_len=%ld buf=%p\n",
+	      t->id, t->cmd, t->sector, t->nr_sectors, t->block_len, t->buffer);
+	
+	if ( g_mmc_dev.io_request ) {
+		DEBUG(0,": error! io_request in progress\n");
+		return;
+	}
+	
+	g_mmc_dev.io_request = t;
+	tasklet_schedule(&g_mmc_dev.task);
+}
+
+EXPORT_SYMBOL(mmc_handle_io_request);
+
+/******************************************************************
+ *  Media handlers
+ *  Allow different drivers to register a media handler
+ ******************************************************************/
+
+static LIST_HEAD(mmc_media_drivers);
+
+int mmc_match_media_driver( struct mmc_slot *slot )
+{
+	struct list_head *item;
+
+	DEBUG(2,": slot=%p\n", slot);
+
+	for ( item = mmc_media_drivers.next ; item != &mmc_media_drivers ; item = item->next ) {
+		struct mmc_media_driver *drv = list_entry(item, struct mmc_media_driver, node );
+		if ( drv->probe(slot) ) {
+			slot->media_driver = drv;
+			drv->load(slot);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+int mmc_register_media_driver( struct mmc_media_driver *drv )
+{
+	list_add_tail( &drv->node, &mmc_media_drivers );
+	return 0;
+}
+
+void mmc_unregister_media_driver( struct mmc_media_driver *drv )
+{
+	list_del(&drv->node);
+}
+
+EXPORT_SYMBOL(mmc_register_media_driver);
+EXPORT_SYMBOL(mmc_unregister_media_driver);
+
+/******************************************************************/
+
+int mmc_register_slot_driver( struct mmc_slot_driver *sdrive, int num_slots )
+{
+	int i;
+	int retval;
+
+	DEBUG(2," max=%d ocr=0x%08x\n", num_slots, sdrive->ocr);
+
+	if ( num_slots > MMC_MAX_SLOTS ) {
+		printk(KERN_CRIT __FUNCTION__ ": illegal num of slots %d\n", num_slots );
+		return -ENOMEM;
+	}
+
+	if ( g_mmc_dev.sdrive ) {
+		printk(KERN_ALERT __FUNCTION__ ": slot in use\n");
+		return -EBUSY;
+	}
+
+	g_mmc_dev.sdrive    = sdrive;
+	g_mmc_dev.num_slots = num_slots;
+
+	for ( i = 0 ; i < num_slots ; i++ ) {
+		struct mmc_slot *slot = &g_mmc_dev.slot[i];
+		memset(slot,0,sizeof(struct mmc_slot));
+		slot->id = i;
+		slot->state = CARD_STATE_EMPTY;
+	}
+	retval = sdrive->init();
+	if ( retval )
+		return retval;
+
+	/* Generate insert events for cards */
+	for ( i = 0 ; i < num_slots ; i++ )
+		if ( !sdrive->is_empty(i) )
+			mmc_insert(i);
+	return 0;
+}
+
+void mmc_unregister_slot_driver( struct mmc_slot_driver *sdrive )
+{
+	int i;
+	DEBUG(2,"\n");
+
+	for ( i = 0 ; i < g_mmc_dev.num_slots ; i++ )
+		mmc_eject(i);
+
+	if ( sdrive == g_mmc_dev.sdrive ) {
+		g_mmc_dev.sdrive->cleanup();
+		g_mmc_dev.sdrive = NULL;
+	}
+}
+
+EXPORT_SYMBOL(mmc_register_slot_driver);
+EXPORT_SYMBOL(mmc_unregister_slot_driver);
+
+/******************************************************************/
+
+static struct pm_dev *mmc_pm_dev;
+
+static int mmc_pm_callback(struct pm_dev *pm_dev, pm_request_t req, void *data)
+{
+	int i;
+	DEBUG(0,": pm callback %d\n", req );
+
+	switch (req) {
+	case PM_SUSPEND: /* Enter D1-D3 */
+		g_mmc_dev.suspended = 1;
+                break;
+	case PM_RESUME:  /* Enter D0 */
+		if ( g_mmc_dev.suspended ) {
+			g_mmc_dev.suspended = 0;
+			g_mmc_dev.state = 0;     // Clear the old state
+			for ( i = 0 ; i < g_mmc_dev.num_slots ; i++ ) {
+				mmc_eject(i);
+				if ( !g_mmc_dev.sdrive->is_empty(i) )
+					mmc_insert(i);
+			}
+		}
+		break;
+        }
+        return 0;
+}
+
+/******************************************************************
+ * TODO: These would be better handled by driverfs
+ * For the moment, we'll just eject and insert everything
+ ******************************************************************/
+
+int mmc_do_eject(ctl_table *ctl, int write, struct file * filp, void *buffer, size_t *lenp)
+{
+	mmc_eject(0);
+	return 0;
+}
+
+int mmc_do_insert(ctl_table *ctl, int write, struct file * filp, void *buffer, size_t *lenp)
+{
+	mmc_insert(0);
+	return 0;
+}
+
+
+static struct ctl_table mmc_sysctl_table[] =
+{
+	{ 1, "debug", &g_mmc_debug, sizeof(int), 0666, NULL, &proc_dointvec },
+	{ 2, "eject", NULL, 0, 0600, NULL, &mmc_do_eject },
+	{ 3, "insert", NULL, 0, 0600, NULL, &mmc_do_insert },
+	{0}
+};
+
+static struct ctl_table mmc_dir_table[] =
+{
+	{BUS_MMC, "mmc", NULL, 0, 0555, mmc_sysctl_table},
+	{0}
+};
+
+static struct ctl_table bus_dir_table[] = 
+{
+	{CTL_BUS, "bus", NULL, 0, 0555, mmc_dir_table},
+        {0}
+};
+
+static struct ctl_table_header *mmc_sysctl_header;
+
+static int mmc_proc_read_device(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	struct mmc_dev *dev = (struct mmc_dev *)data;
+        char *p = page;
+        int len = 0;
+	int i;
+
+	if (!dev || !dev->sdrive)
+		return 0;
+
+	for ( i = 0 ; i < dev->num_slots ; i++ ) {
+		struct mmc_slot *slot = &dev->slot[i];
+
+		p += sprintf(p, "Slot #%d\n", i);
+		p += sprintf(p, "  State %s (%d)\n", card_state_to_string(slot->state), slot->state);
+
+		if ( slot->state != CARD_STATE_EMPTY ) {
+			p += sprintf(p, "  Media %s\n", (slot->media_driver ? slot->media_driver->name : "unknown"));
+			p += sprintf(p, "  CID mid=%d\n", slot->cid.mid);
+			p += sprintf(p, "      oid=%d\n", slot->cid.oid);
+			p += sprintf(p, "      pnm=%s\n", slot->cid.pnm);
+			p += sprintf(p, "      prv=%d.%d\n", slot->cid.prv>>4, slot->cid.prv&0xf);
+			p += sprintf(p, "      psn=0x%08x\n", slot->cid.psn);
+			p += sprintf(p, "      mdt=%d/%d\n", slot->cid.mdt>>4, (slot->cid.mdt&0xf)+1997);
+
+			p += sprintf(p, "  CSD csd_structure=%d\n", slot->csd.csd_structure);
+			p += sprintf(p, "      spec_vers=%d\n", slot->csd.spec_vers);
+			p += sprintf(p, "      taac=0x%02x\n", slot->csd.taac);
+			p += sprintf(p, "      nsac=0x%02x\n", slot->csd.nsac);
+			p += sprintf(p, "      tran_speed=0x%02x\n", slot->csd.tran_speed);
+			p += sprintf(p, "      ccc=0x%04x\n", slot->csd.ccc);
+			p += sprintf(p, "      read_bl_len=%d\n", slot->csd.read_bl_len);
+			p += sprintf(p, "      read_bl_partial=%d\n", slot->csd.read_bl_partial);
+			p += sprintf(p, "      write_blk_misalign=%d\n", slot->csd.write_blk_misalign);
+			p += sprintf(p, "      read_blk_misalign=%d\n", slot->csd.read_blk_misalign);
+			p += sprintf(p, "      dsr_imp=%d\n", slot->csd.dsr_imp);
+			p += sprintf(p, "      c_size=%d\n", slot->csd.c_size);
+			p += sprintf(p, "      vdd_r_curr_min=%d\n", slot->csd.vdd_r_curr_min);
+			p += sprintf(p, "      vdd_r_curr_max=%d\n", slot->csd.vdd_r_curr_max);
+			p += sprintf(p, "      vdd_w_curr_min=%d\n", slot->csd.vdd_w_curr_min);
+			p += sprintf(p, "      vdd_w_curr_max=%d\n", slot->csd.vdd_w_curr_max);
+			p += sprintf(p, "      c_size_mult=%d\n", slot->csd.c_size_mult);
+			p += sprintf(p, "      wp_grp_size=%d\n", slot->csd.wp_grp_size);
+			p += sprintf(p, "      wp_grp_enable=%d\n", slot->csd.wp_grp_enable);
+			p += sprintf(p, "      default_ecc=%d\n", slot->csd.default_ecc);
+			p += sprintf(p, "      r2w_factor=%d\n", slot->csd.r2w_factor);
+			p += sprintf(p, "      write_bl_len=%d\n", slot->csd.write_bl_len);
+			p += sprintf(p, "      write_bl_partial=%d\n", slot->csd.write_bl_partial);
+			p += sprintf(p, "      file_format_grp=%d\n", slot->csd.file_format_grp);
+			p += sprintf(p, "      copy=%d\n", slot->csd.copy);
+			p += sprintf(p, "      perm_write_protect=%d\n", slot->csd.perm_write_protect);
+			p += sprintf(p, "      tmp_write_protect=%d\n", slot->csd.tmp_write_protect);
+			p += sprintf(p, "      file_format=%d\n", slot->csd.file_format);
+			p += sprintf(p, "      ecc=%d\n", slot->csd.ecc);
+			switch (slot->csd.csd_structure) {
+			case CSD_STRUCT_VER_1_0:
+			case CSD_STRUCT_VER_1_1:
+				p += sprintf(p, "      sector_size=%d\n", slot->csd.erase.v22.sector_size);
+				p += sprintf(p, "      erase_grp_size=%d\n", slot->csd.erase.v22.erase_grp_size);
+				break;
+			case CSD_STRUCT_VER_1_2:
+			default:
+				p += sprintf(p, "      erase_grp_size=%d\n", slot->csd.erase.v31.erase_grp_size);
+				p += sprintf(p, "      erase_grp_mult=%d\n", slot->csd.erase.v31.erase_grp_mult);
+				break;
+			}
+		}
+	}
+
+        len = (p - page) - off;
+	*start = page + off;
+        return len;
+}
+
+/******************************************************************/
+
+void mmc_protocol_single_card( struct mmc_dev *dev, int state_flags );
+extern struct mmc_media_module media_module;
+
+static int __init mmc_init(void) 
+{
+	DEBUG(1,"\n");
+	
+	mmc_sysctl_header = register_sysctl_table(bus_dir_table, 0 );
+
+	tasklet_init(&g_mmc_dev.task,mmc_tasklet_action,(unsigned long)&g_mmc_dev);
+	g_mmc_dev.protocol = mmc_protocol_single_card;
+
+	proc_mmc_dir = proc_mkdir("mmc", proc_bus);
+	if ( proc_mmc_dir )
+		create_proc_read_entry("device", 0, proc_mmc_dir, mmc_proc_read_device, &g_mmc_dev);
+
+	mmc_pm_dev = pm_register(PM_UNKNOWN_DEV, PM_SYS_UNKNOWN, mmc_pm_callback);
+
+	media_module.init();
+	return 0;
+}
+
+static void __exit mmc_exit(void)
+{
+	DEBUG(1,"\n");
+
+	media_module.cleanup();
+
+	unregister_sysctl_table(mmc_sysctl_header);
+
+	tasklet_kill(&g_mmc_dev.task);
+
+	if ( proc_mmc_dir ) {
+		remove_proc_entry("device", proc_mmc_dir);
+		remove_proc_entry("mmc", proc_bus);
+	}
+
+	pm_unregister(mmc_pm_dev);
+}
+
+module_init(mmc_init);
+module_exit(mmc_exit);
+
+MODULE_AUTHOR("Andy Christian")
+MODULE_LICENSE("MIT")
+MODULE_DESCRIPTION("Core support for MultiMedia Cards")
diff -ruwN -X dontdiff linux-2.4.19/drivers/mmc/mmc_core.h linux-2.4.19-mmc1/drivers/mmc/mmc_core.h
--- linux-2.4.19/drivers/mmc/mmc_core.h	Wed Dec 31 19:00:00 1969
+++ linux-2.4.19-mmc1/drivers/mmc/mmc_core.h	Fri Aug  9 16:07:14 2002
@@ -0,0 +1,79 @@
+/*
+ * Header for MultiMediaCard (MMC)
+ *
+ * Copyright (c) 2002 Hewlett-Packard Company
+ *   
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *  
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *  
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Many thanks to Alessandro Rubini and Jonathan Corbet!
+ *
+ * Based strongly on code by:
+ *
+ * Author: Yong-iL Joh <tolkien@mizi.com>
+ * Date  : $Date: 2002/06/18 19:06:06 $ 
+ *
+ * Author:  Andrew Christian
+ *          15 May 2002
+ */
+
+#ifndef MMC_MMC_CORE_H
+#define MMC_MMC_CORE_H
+
+#include <linux/mmc/mmc_ll.h>
+#include "mmc_media.h"
+
+#define ID_TO_RCA(x) ((x)+1)
+
+struct mmc_dev {
+	struct mmc_slot_driver   *sdrive;
+	struct mmc_slot           slot[MMC_MAX_SLOTS];
+	struct mmc_request        request;               // Active request to the low-level driver
+	struct mmc_io_request    *io_request;            // Active transfer request from the high-level media io
+	struct tasklet_struct     task;
+	int    num_slots;                 // Copied from the slot driver; used when slot driver shuts down
+
+	/* State maintenance */
+	int    state;  
+	int    suspended;
+	void (*protocol)(struct mmc_dev *, int);
+};
+
+char * mmc_result_to_string( int );
+int    mmc_unpack_csd( struct mmc_request *request, struct mmc_csd *csd );
+int    mmc_unpack_r1( struct mmc_request *request, struct mmc_response_r1 *r1, enum card_state state );
+int    mmc_unpack_cid( struct mmc_request *request, struct mmc_cid *cid );
+int    mmc_unpack_r3( struct mmc_request *request, struct mmc_response_r3 *r3 );
+
+void   mmc_send_cmd( struct mmc_dev *dev, int cmd, u32 arg, 
+		     u16 nob, u16 block_len, enum mmc_rsp_t rtype );
+void   mmc_finish_io_request( struct mmc_dev *dev, int result );
+int    mmc_check_eject( struct mmc_dev *dev );
+int    mmc_check_insert( struct mmc_dev *dev );
+u32    mmc_tran_speed( u8 ts );
+int    mmc_match_media_driver( struct mmc_slot *slot );
+void   run_sbin_mmc_hotplug(struct mmc_dev *dev, int id, int insert);
+
+static inline void mmc_simple_cmd( struct mmc_dev *dev, int cmd, u32 arg, enum mmc_rsp_t rtype )
+{
+	mmc_send_cmd( dev, cmd, arg, 0, 0, rtype );
+}
+
+#endif  /* MMC_MMC_CORE_H */
+
diff -ruwN -X dontdiff linux-2.4.19/drivers/mmc/mmc_media.c linux-2.4.19-mmc1/drivers/mmc/mmc_media.c
--- linux-2.4.19/drivers/mmc/mmc_media.c	Wed Dec 31 19:00:00 1969
+++ linux-2.4.19-mmc1/drivers/mmc/mmc_media.c	Fri Aug  9 16:07:24 2002
@@ -0,0 +1,511 @@
+/*
+ * Block driver for media (i.e., flash cards)
+ *
+ * Copyright 2002 Hewlett-Packard Company
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *  
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *  
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Many thanks to Alessandro Rubini and Jonathan Corbet!
+ *
+ * Author:  Andrew Christian
+ *          28 May 2002
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+
+#include <linux/sched.h>
+#include <linux/kernel.h> /* printk() */
+#include <linux/fs.h>     /* everything... */
+#include <linux/errno.h>  /* error codes */
+#include <linux/types.h>  /* size_t */
+#include <linux/fcntl.h>  /* O_ACCMODE */
+#include <linux/hdreg.h>  /* HDIO_GETGEO */
+#include <linux/init.h>
+#include <linux/devfs_fs_kernel.h>
+
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
+#include "mmc_media.h"
+
+#define MAJOR_NR mmc_major /* force definitions on in blk.h */
+static int mmc_major; /* must be declared before including blk.h */
+
+#define MMC_SHIFT           3             /* max 8 partitions per card */
+
+#define DEVICE_NR(device)   (MINOR(device)>>MMC_SHIFT)
+#define DEVICE_NAME         "mmc"         /* name for messaging */
+#define DEVICE_INTR         mmc_intrptr   /* pointer to the bottom half */
+#define DEVICE_NO_RANDOM                  /* no entropy to contribute */
+#define DEVICE_REQUEST      mmc_media_request
+#define DEVICE_OFF(d) /* do-nothing */
+
+#include <linux/blk.h>
+#include <linux/blkpg.h>
+
+static int rahead     = 8;
+static int maxsectors = 4;
+
+MODULE_PARM(maxsectors,"i");
+MODULE_PARM_DESC(maxsectors,"Maximum number of sectors for a single request");
+MODULE_PARM(rahead,"i");
+MODULE_PARM_DESC(rahead,"Default sector read ahead");
+
+#define MMC_NDISK	(MMC_MAX_SLOTS << MMC_SHIFT)
+
+/* 
+   Don't bother messing with blksize_size....it gets changed by various filesystems.
+   You're better off dealing with arbitrary blksize's
+*/ 
+static int              mmc_blk[MMC_NDISK];  /* Used for hardsect_size - should be 512 bytes */
+static int              mmc_max[MMC_NDISK];  /* Used for max_sectors[] - limit size of individual request */
+
+static int              mmc_sizes[MMC_NDISK];        /* Used in gendisk - gives whole size of partition */
+static struct hd_struct mmc_partitions[MMC_NDISK];   /* Used in gendisk - gives particular partition information */
+
+static char             mmc_gendisk_flags;
+static devfs_handle_t   mmc_devfs_handle;
+
+// There is one mmc_media_dev per inserted card
+struct mmc_media_dev {
+	int              usage;
+	struct mmc_slot *slot;
+	spinlock_t       lock;
+	int              changed;
+	long             nr_sects;   // In total number of sectors
+
+	int              read_block_len;      // Valid read block length
+	int              write_block_len;     // Valid write block length
+};
+
+static struct mmc_media_dev   g_media_dev[MMC_MAX_SLOTS];
+static struct mmc_io_request  g_io_request;
+static int                    g_busy;
+
+static struct gendisk mmc_gendisk = {
+        major:	        0,               /* major number dynamically assigned */
+	major_name:	DEVICE_NAME,
+	minor_shift:	MMC_SHIFT,	 /* shift to get device number */
+	max_p:	        1 << MMC_SHIFT,	 /* Number of partiions */
+	/* The remainder will be filled in dynamically */
+};
+
+/*************************************************************************/
+/* TODO: O_EXCL, O_NDELAY, invalidate_buffers */
+static int mmc_media_open( struct inode *inode, struct file *filp )
+{
+	struct mmc_media_dev *dev;
+	int num = DEVICE_NR(inode->i_rdev);
+
+	DEBUG(1,": num=%d\n", num);
+
+	if ( num >= MMC_MAX_SLOTS) 
+		return -ENODEV;
+
+	dev = &g_media_dev[num];
+	if ( !dev->slot ) 
+		return -ENODEV;
+
+	spin_lock(&dev->lock);
+	if (!dev->usage)
+		check_disk_change(inode->i_rdev);
+	dev->usage++;
+	MOD_INC_USE_COUNT;
+	spin_unlock(&dev->lock);
+	return 0;
+}
+
+static int mmc_media_release( struct inode *inode, struct file *filep )
+{
+	struct mmc_media_dev *dev = &g_media_dev[DEVICE_NR(inode->i_rdev)];
+
+	DEBUG(1,": num=%d\n", DEVICE_NR(inode->i_rdev));
+
+	spin_lock(&dev->lock);
+	dev->usage--;
+	/* Is this worth doing? */
+	if (!dev->usage) {	
+		fsync_dev(inode->i_rdev);
+		invalidate_buffers(inode->i_rdev);
+	}
+	MOD_DEC_USE_COUNT;
+	spin_unlock(&dev->lock);
+	return 0;
+}
+
+static int mmc_media_revalidate(kdev_t i_rdev)
+{
+	int index, max_p, start, i;
+	struct mmc_media_dev *dev;
+
+	index = DEVICE_NR(i_rdev);
+	DEBUG(2,": index=%d\n", index);
+
+	max_p = mmc_gendisk.max_p;
+	start = index << MMC_SHIFT;
+	dev   = &g_media_dev[index];
+
+	for ( i = max_p - 1 ; i >= 0 ; i-- ) {
+		int item = start + i;
+		invalidate_device(MKDEV(mmc_major,item),1);
+		mmc_gendisk.part[item].start_sect = 0;
+		mmc_gendisk.part[item].nr_sects   = 0;
+		/* TODO: Fix the blocksize? */
+	}
+
+	register_disk(&mmc_gendisk, i_rdev, 1 << MMC_SHIFT, mmc_gendisk.fops, dev->nr_sects);
+	return 0;
+}
+
+static int mmc_media_ioctl (struct inode *inode, struct file *filp,
+			    unsigned int cmd, unsigned long arg)
+{
+	int num = DEVICE_NR(inode->i_rdev);
+	int size;
+	struct hd_geometry geo;
+
+	DEBUG(1," ioctl 0x%x 0x%lx\n", cmd, arg);
+
+	switch(cmd) {
+	case BLKGETSIZE:
+		/* Return the device size, expressed in sectors */
+		/* Not really necessary, but this is faster than walking the gendisk list */
+		if (!access_ok(VERIFY_WRITE, arg, sizeof(long)))
+			return -EFAULT;
+		return put_user(mmc_partitions[MINOR(inode->i_rdev)].nr_sects, (long *)arg);
+
+	case BLKRRPART: /* re-read partition table */
+		if (!capable(CAP_SYS_ADMIN)) 
+			return -EACCES;
+		return mmc_media_revalidate(inode->i_rdev);
+
+	case HDIO_GETGEO:
+		if (!access_ok(VERIFY_WRITE, arg, sizeof(geo)))
+			return -EFAULT;
+		/* Grab the size from the 0 partition for this minor */
+		/* TODO: is this the right thing?  Or should we do it by partition??? */
+		size = mmc_sizes[num << MMC_SHIFT] / mmc_blk[num << MMC_SHIFT];
+		geo.cylinders = (size & ~0x3f) >> 6;
+		geo.heads     = 4;
+		geo.sectors   = 16;
+		geo.start     = mmc_partitions[MINOR(inode->i_rdev)].start_sect;
+		if (copy_to_user((void *) arg, &geo, sizeof(geo)))
+			return -EFAULT;
+		return 0;
+
+	default:
+		return blk_ioctl(inode->i_rdev, cmd, arg);
+	}
+
+	return -ENOTTY; /* should never get here */
+}
+
+static int mmc_media_check_change(kdev_t i_rdev) 
+{
+	int                   index, retval;
+	struct mmc_media_dev *dev;
+	unsigned long         flags;
+
+	index = DEVICE_NR(i_rdev);
+	DEBUG(2," device=%d\n", index);
+	if (index >= MMC_MAX_SLOTS) 
+		return 0;
+
+	dev = &g_media_dev[index];
+
+	spin_lock_irqsave(&dev->lock, flags);
+	retval = (dev->changed ? 1 : 0);
+	dev->changed = 0;
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return retval;
+}
+
+static struct mmc_media_dev * mmc_media_locate_device(const struct request *req)
+{
+	int num = DEVICE_NR(req->rq_dev);
+	if ( num >= MMC_MAX_SLOTS) {
+		static int count = 0;
+		if (count++ < 5) /* print the message at most five times */
+			printk(KERN_WARNING "mmc: request for unknown device\n");
+		return NULL;
+	}
+	return &g_media_dev[num];
+}
+
+static int mmc_media_transfer( struct mmc_media_dev *dev, const struct request *req )
+{
+	int minor = MINOR(req->rq_dev);
+	unsigned long flags;
+
+	DEBUG(2,": minor=%d\n", minor);
+
+	if ( req->sector + req->current_nr_sectors > mmc_partitions[minor].nr_sects ) {
+		static int count = 0;
+		if (count++ < 5)
+			printk(KERN_WARNING __FUNCTION__ ": request past end of partition\n");
+		return 0;
+	}
+	
+	spin_lock_irqsave(&dev->lock, flags);
+
+	g_io_request.id         = DEVICE_NR(req->rq_dev);
+	g_io_request.cmd        = req->cmd;
+	g_io_request.sector     = mmc_partitions[minor].start_sect + req->sector;
+	g_io_request.nr_sectors = req->current_nr_sectors;
+	g_io_request.block_len  = mmc_blk[minor];
+	g_io_request.buffer     = req->buffer;
+
+	DEBUG(2,": id=%d cmd=%d sector=%ld nr_sectors=%ld block_len=%ld buf=%p\n",
+	      g_io_request.id, g_io_request.cmd, g_io_request.sector, g_io_request.nr_sectors,
+	      g_io_request.block_len, g_io_request.buffer );
+
+	mmc_handle_io_request(&g_io_request);
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return 1;
+}
+
+static void mmc_media_request( request_queue_t *q )
+{
+	struct mmc_media_dev *dev;
+
+	if ( g_busy )
+		return;
+
+	while(1) {
+		INIT_REQUEST;  /* returns when queue is empty */
+		dev = mmc_media_locate_device(CURRENT);
+		if ( !dev ) {
+			end_request(0);
+			continue;
+		}
+
+		DEBUG(2," (%p): cmd %i sec %li (nr. %li)\n", CURRENT,
+		      CURRENT->cmd, CURRENT->sector, CURRENT->current_nr_sectors);
+
+		if ( mmc_media_transfer(dev,CURRENT) ) {
+			g_busy = 1;
+			return;
+		}
+		end_request(0);  /* There was a problem with the request */
+	}
+}
+
+static void mmc_media_transfer_done( struct mmc_io_request *trans, int result )
+{
+	unsigned long flags;
+	DEBUG(3,": result=%d\n", result);
+	spin_lock_irqsave(&io_request_lock, flags);
+	end_request(result);
+	g_busy = 0;
+	if (!QUEUE_EMPTY)
+		mmc_media_request(NULL);  // Start the next transfer
+	spin_unlock_irqrestore(&io_request_lock, flags);
+}
+
+
+static struct block_device_operations mmc_bdops = {
+	open:               mmc_media_open,
+	release:            mmc_media_release,
+	ioctl:              mmc_media_ioctl,
+	check_media_change: mmc_media_check_change,
+	revalidate:         mmc_media_revalidate
+};
+
+/******************************************************************/
+/* TODO:
+   We have a race condition if two slots need to be revalidated at the same
+   time.  Perhaps we should walk the list of devices and look for change
+   flags?
+*/
+
+static void mmc_media_load_task_handler( void *nr )
+{
+	int slot_id = (int) nr;
+	DEBUG(2," slot_id=%d\n", slot_id );
+	mmc_media_revalidate(MKDEV(mmc_major,(slot_id<<MMC_SHIFT)));
+}
+
+static struct tq_struct mmc_media_load_task = {
+	routine:  mmc_media_load_task_handler
+};
+
+static void mmc_media_load( struct mmc_slot *slot )
+{
+	unsigned long flags;
+	struct mmc_media_dev *dev  = &g_media_dev[slot->id];
+	int i;
+
+	long nr_sects;
+	int  write_block_len;
+	int  read_block_len;
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+	nr_sects        = (1 + slot->csd.c_size) * (1 << (slot->csd.c_size_mult + 2));
+	write_block_len = 1 << slot->csd.write_bl_len;
+	read_block_len  = 1 << slot->csd.read_bl_len;
+
+	MOD_INC_USE_COUNT;
+	DEBUG(1, " slot=%p nr_sect=%ld write_block_length=%d read_block_len=%d\n", 
+	      slot, nr_sects, write_block_len, read_block_len );
+
+	dev->slot            = slot;
+	dev->nr_sects        = nr_sects;
+	dev->read_block_len  = read_block_len;
+	dev->write_block_len = write_block_len;
+	dev->changed         = 1;
+	mmc_gendisk.nr_real++;
+
+	/* Fix up the block size to match read_block_len */
+	/* TODO: can we really do this?  Right now we're affecting blksize_size and hardsect_size */
+	for ( i = 0 ; i < (1 << MMC_SHIFT) ; i++ )
+		mmc_blk[(slot->id << MMC_SHIFT) + i] = read_block_len;
+
+	mmc_media_load_task.data = (void *) slot->id;
+	schedule_task( &mmc_media_load_task );
+
+	spin_unlock_irqrestore(&dev->lock, flags);
+}
+
+/* TODO: This is a problem area.  We've lost our card, so we'd like
+   to flush all outstanding buffers and requests, remove the partitions from
+   the file system, and generally shut everything down.
+*/
+
+static void mmc_media_unload( struct mmc_slot *slot )
+{
+	unsigned long flags;
+	struct mmc_media_dev *dev = &g_media_dev[slot->id];
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+//	for ( i = 0 ; i < MMC_SHIFT ; i++ )
+//		fsync_dev(MKDEV(mmc_major,slot->id,i));
+
+	MOD_DEC_USE_COUNT;
+	DEBUG(1," slot=%p id=%d\n", slot, slot->id);
+
+	dev->slot            = NULL;
+	dev->nr_sects        = 0;
+	dev->changed         = 1;
+	mmc_gendisk.nr_real--;
+
+	mmc_media_load_task.data = (void *) slot->id;
+	schedule_task( &mmc_media_load_task );
+
+	spin_unlock_irqrestore(&dev->lock, flags);
+}
+
+/* 
+   Called once the device has a valid CSD structure
+   In the future this should determine what type of card we have
+   For the moment, everything is a memory card 
+*/
+
+static int mmc_media_probe( struct mmc_slot *slot )
+{
+	return 1;
+}
+
+static struct mmc_media_driver mmc_driver = {
+	name:            "flash",
+	load:            mmc_media_load,
+	unload:          mmc_media_unload,
+	probe:           mmc_media_probe,
+	io_request_done: mmc_media_transfer_done,
+};
+
+/******************************************************************/
+
+static int __init mmc_media_init( void )
+{
+	int i, result;
+	DEBUG(0,"\n");
+
+	mmc_devfs_handle = devfs_mk_dir(NULL, DEVICE_NAME, NULL);
+	if (!mmc_devfs_handle) return -EBUSY;
+
+	result = devfs_register_blkdev(mmc_major, DEVICE_NAME, &mmc_bdops);
+	if (result < 0) {
+		printk(KERN_WARNING "Unable to get major %d for MMC media\n", mmc_major);
+		return result;
+	}
+
+	if ( !mmc_major ) mmc_major = result;
+
+	/* Set up global block arrays */
+	read_ahead[mmc_major]    = rahead;
+	for(i=0 ; i < MMC_NDISK; i++)
+		mmc_blk[i] = 512;
+	hardsect_size[mmc_major] = mmc_blk;
+	for(i=0; i < MMC_NDISK; i++)
+		mmc_max[i] = maxsectors;
+	max_sectors[mmc_major]   = mmc_max;
+
+	/* Start with zero-sized partitions : we'll fix this later */
+	memset(mmc_sizes, 0, sizeof(int) * MMC_NDISK);
+	blk_size[mmc_major] = mmc_sizes;
+
+	/* Fix up the gendisk structure */
+	mmc_gendisk.part    = mmc_partitions;
+	mmc_gendisk.sizes   = mmc_sizes;
+	mmc_gendisk.nr_real = 0;
+	mmc_gendisk.de_arr  = &mmc_devfs_handle;
+	mmc_gendisk.flags   = &mmc_gendisk_flags;
+	mmc_gendisk.fops    = &mmc_bdops;
+
+	/* Add ourselves to the global list */
+	mmc_gendisk.major = mmc_major;
+	add_gendisk(&mmc_gendisk);
+	
+	blk_init_queue(BLK_DEFAULT_QUEUE(mmc_major), DEVICE_REQUEST);
+	return mmc_register_media_driver(&mmc_driver);
+}
+
+static void __exit mmc_media_cleanup( void )
+{
+	int i;
+	DEBUG(0,"\n");
+
+	flush_scheduled_tasks();
+	unregister_blkdev(mmc_major, DEVICE_NAME);
+
+	for ( i = 0 ; i < MMC_NDISK; i++ )
+		fsync_dev(MKDEV(mmc_major,i));
+
+	mmc_unregister_media_driver(&mmc_driver);
+
+	blk_cleanup_queue(BLK_DEFAULT_QUEUE(mmc_major));
+
+	blk_size[mmc_major]      = NULL;
+	hardsect_size[mmc_major] = NULL;
+	max_sectors[mmc_major]   = NULL;
+
+	del_gendisk(&mmc_gendisk);
+
+	devfs_unregister(mmc_devfs_handle);
+}
+
+struct mmc_media_module media_module = {
+	init:    mmc_media_init,
+	cleanup: mmc_media_cleanup
+};
diff -ruwN -X dontdiff linux-2.4.19/drivers/mmc/mmc_media.h linux-2.4.19-mmc1/drivers/mmc/mmc_media.h
--- linux-2.4.19/drivers/mmc/mmc_media.h	Wed Dec 31 19:00:00 1969
+++ linux-2.4.19-mmc1/drivers/mmc/mmc_media.h	Fri Aug  9 16:07:33 2002
@@ -0,0 +1,96 @@
+/*
+ * Header for MultiMediaCard (MMC)
+ *
+ * Copyright (c) 2002 Hewlett-Packard Company
+ *   
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *  
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *  
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Many thanks to Alessandro Rubini and Jonathan Corbet!
+ *
+ * Based strongly on code by:
+ *
+ * Author: Yong-iL Joh <tolkien@mizi.com>
+ * Date  : $Date: 2002/06/18 12:38:40 $ 
+ *
+ * Author:  Andrew Christian
+ *          15 May 2002
+ */
+
+#ifndef MMC_MMC_MEDIA_H
+#define MMC_MMC_MEDIA_H
+
+#include <linux/interrupt.h>
+#include <linux/list.h>
+
+#include <linux/mmc/mmc_protocol.h>
+
+/* Set an upper bound for how many cards we'll support */
+/* This is used only for static array initialization */
+#define MMC_MAX_SLOTS   2
+
+#define MMC_SLOT_FLAG_INSERT  (1<<0)
+#define MMC_SLOT_FLAG_EJECT   (1<<1)
+
+struct mmc_media_driver;
+
+struct mmc_slot {
+	int             id;     /* Card index */
+	/* Card specific information */
+	struct mmc_cid  cid;
+	struct mmc_csd  csd;
+
+	enum card_state state;  /* empty, ident, ready, whatever */
+	int             flags;  /* Ejected, inserted */
+
+	/* Assigned media driver */
+	struct mmc_media_driver *media_driver;
+};
+
+struct mmc_io_request {
+	int            id;         /* Card index     */
+	int            cmd;        /* READ or WRITE  */
+	unsigned long  sector;     /* Start address  */
+	unsigned long  nr_sectors; /* Length of read */
+	unsigned long  block_len;  /* Size of sector (sanity check) */
+	char          *buffer;     /* Data buffer    */
+};
+
+/* Media driver (e.g., Flash card, I/O card...) */
+struct mmc_media_driver {
+	struct list_head   node;
+	char              *name;
+	void (*load)(struct mmc_slot *);
+	void (*unload)(struct mmc_slot *);
+	int  (*probe)(struct mmc_slot *);
+	void (*io_request_done)(struct mmc_io_request *, int result);
+};
+
+struct mmc_media_module {
+	int (*init)(void);
+	void (*cleanup)(void);
+};
+
+/* Calls made by the media driver */
+extern int  mmc_register_media_driver( struct mmc_media_driver * );
+extern void mmc_unregister_media_driver( struct mmc_media_driver * );
+extern void mmc_handle_io_request( struct mmc_io_request * );
+
+#endif  /* MMC_MMC_MEDIA_H */
+
diff -ruwN -X dontdiff linux-2.4.19/drivers/mmc/mmc_protocol.c linux-2.4.19-mmc1/drivers/mmc/mmc_protocol.c
--- linux-2.4.19/drivers/mmc/mmc_protocol.c	Wed Dec 31 19:00:00 1969
+++ linux-2.4.19-mmc1/drivers/mmc/mmc_protocol.c	Fri Aug  9 16:07:45 2002
@@ -0,0 +1,440 @@
+/*
+ * MMC State machine functions
+ *
+ * Copyright (c) 2002 Hewlett-Packard Company
+ *   
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *  
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *  
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Many thanks to Alessandro Rubini and Jonathan Corbet!
+ *
+ * This part of the code is separated from mmc_core.o so we can
+ * plug in different state machines (e.g., SPI, SD)
+ *
+ * This code assumes that you have exactly one card slot, no more.
+ *
+ * Author:  Andrew Christian
+ *          6 May 2002
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+
+#include <linux/version.h>
+#include <linux/proc_fs.h>
+
+#include "mmc_core.h"
+
+static void * mmc_cim_default_state( struct mmc_dev *dev, int first );
+
+/******************************************************************
+ *
+ * Useful utility functions
+ *
+ ******************************************************************/
+
+static int mmc_has_valid_request( struct mmc_dev *dev )
+{
+	struct mmc_io_request *request = dev->io_request;
+	struct mmc_slot *slot;
+
+	DEBUG(2," (%p)\n", request);
+
+	if ( !request ) return 0;
+
+	slot = dev->slot + request->id;
+
+	if ( !slot->media_driver ) {
+		DEBUG(0,": card doesn't have media driver\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+static void mmc_configure_card( struct mmc_dev *dev, int slot )
+{
+	u32 rate;
+	DEBUG(2,": slot=%d\n", slot);
+
+	/* Fix the clock rate */
+	rate = mmc_tran_speed(dev->slot[slot].csd.tran_speed);
+	if ( rate < MMC_CLOCK_SLOW )
+		rate = MMC_CLOCK_SLOW;
+	if ( rate > MMC_CLOCK_FAST )
+		rate = MMC_CLOCK_FAST;
+
+	dev->sdrive->set_clock(rate);
+	
+	/* Match the drive media */
+	mmc_match_media_driver(&dev->slot[slot]);
+	run_sbin_mmc_hotplug(dev, slot, 1);
+}
+
+/* The blocks requested by the kernel may or may not
+   match what we can do.  Unfortunately, filesystems play
+   fast and loose with block sizes, so we're stuck with this */
+
+static void mmc_fix_request_block_size( struct mmc_dev *dev )
+{
+	struct mmc_io_request *t = dev->io_request;
+	struct mmc_slot *slot = dev->slot + t->id;
+	u16 block_len;
+
+	DEBUG(1, ": io_request id=%d cmd=%d sector=%ld nr_sectors=%ld block_len=%ld buf=%p\n",
+	      t->id, t->cmd, t->sector, t->nr_sectors, t->block_len, t->buffer);
+
+	switch( t->cmd ) {
+	case READ:
+		block_len = 1 << slot->csd.read_bl_len;
+		break;
+	case WRITE:
+		block_len = 1 << slot->csd.write_bl_len;
+		break;
+	default:
+		DEBUG(0,": unrecognized command %d\n", t->cmd);
+		return;
+	}
+
+	if ( block_len < t->block_len ) {
+		int scale = t->block_len / block_len;
+		DEBUG(1,": scaling by %d from block_len=%d to %ld\n", 
+		      scale, block_len, t->block_len);
+		t->block_len   = block_len;
+		t->sector     *= scale;
+		t->nr_sectors *= scale;
+	}
+}
+
+
+/******************************************************************
+ * State machine routines to read and write data
+ *
+ *  SET_BLOCKLEN only needs to be done once for each card.
+ *  SET_BLOCK_COUNT is only valid in MMC 3.1; most cards don't support this,
+ *  so we don't use it.
+ * 
+ *  In the 2.x cards we have a choice between STREAMING mode and
+ *  SINGLE mode.  There's an obvious performance possibility in 
+ *  using streaming mode, but at this time we're just using the SINGLE
+ *  mode.
+ ******************************************************************/
+
+static void * mmc_cim_read_write_block( struct mmc_dev *dev, int first )
+{
+	struct mmc_io_request *t = dev->io_request;
+	struct mmc_response_r1 r1;
+	struct mmc_slot *slot = dev->slot + t->id;
+	int    retval = 0;
+	int    i;
+
+	DEBUG(2," first=%d\n",first);
+
+	if ( first ) {
+		mmc_fix_request_block_size( dev );
+
+		switch ( slot->state ) {
+		case CARD_STATE_STBY:
+			mmc_simple_cmd(dev, MMC_SELECT_CARD, ID_TO_RCA(slot->id) << 16, RESPONSE_R1B );
+			break;
+		case CARD_STATE_TRAN:
+			mmc_simple_cmd(dev, MMC_SET_BLOCKLEN, t->block_len, RESPONSE_R1 );
+			break;
+		default:
+			DEBUG(0,": invalid card state %d\n", slot->state);
+			goto read_block_error;
+			break;
+		}
+		return NULL;
+	}
+
+	switch (dev->request.cmd) {
+	case MMC_SELECT_CARD:
+		if ( (retval = mmc_unpack_r1( &dev->request, &r1, slot->state )) )
+			goto read_block_error;
+
+		for ( i = 0 ; i < dev->num_slots ; i++ )
+			dev->slot[i].state = ( i == t->id ? CARD_STATE_TRAN : CARD_STATE_STBY );
+
+		mmc_simple_cmd(dev, MMC_SET_BLOCKLEN, t->block_len, RESPONSE_R1 );
+		break;
+
+	case MMC_SET_BLOCKLEN:
+		if ( (retval = mmc_unpack_r1( &dev->request, &r1, slot->state )) )
+			goto read_block_error;
+
+		mmc_send_cmd(dev, (t->cmd == READ ? MMC_READ_SINGLE_BLOCK : MMC_WRITE_BLOCK), 
+			     t->sector * t->block_len, 1, t->block_len, RESPONSE_R1 );
+		break;
+
+	case MMC_READ_SINGLE_BLOCK:
+	case MMC_WRITE_BLOCK:
+		if ( (retval = mmc_unpack_r1( &dev->request, &r1, slot->state )) )
+			goto read_block_error;
+
+		t->nr_sectors--;
+		t->sector++;
+		t->buffer += t->block_len;
+
+		if ( t->nr_sectors ) {
+			mmc_send_cmd(dev, (t->cmd == READ ? MMC_READ_SINGLE_BLOCK : MMC_WRITE_BLOCK), 
+				     t->sector * t->block_len, 1, t->block_len, RESPONSE_R1 );
+		}
+		else {
+			mmc_finish_io_request( dev, 1 );
+			if ( mmc_has_valid_request(dev) )
+				return mmc_cim_read_write_block;
+			return mmc_cim_default_state;
+		}
+		break;
+
+	default:
+		goto read_block_error;
+		break;
+	}
+	return NULL;
+
+read_block_error:
+	DEBUG(0,": failure during cmd %d, error %d (%s)\n", 
+	      dev->request.cmd, retval, mmc_result_to_string(retval));
+	mmc_finish_io_request( dev, 0 );   // Failure
+	return mmc_cim_default_state;
+}
+
+/* Update the card's status information in preparation to running a read/write cycle */
+
+static void * mmc_cim_get_status( struct mmc_dev *dev, int first )
+{
+	struct mmc_slot *slot = dev->slot + dev->io_request->id;
+	struct mmc_response_r1 r1;
+	int retval = MMC_NO_ERROR;
+
+	DEBUG(2," first=%d\n",first);
+
+	if ( first ) {
+		mmc_simple_cmd(dev, MMC_SEND_STATUS, ID_TO_RCA(slot->id) << 16, RESPONSE_R1 );
+		return NULL;
+	}
+
+	switch (dev->request.cmd) {
+	case MMC_SEND_STATUS:
+		retval = mmc_unpack_r1(&dev->request,&r1,slot->state);
+		if ( !retval || retval == MMC_ERROR_STATE_MISMATCH ) {
+			slot->state = R1_CURRENT_STATE(r1.status);
+			return mmc_cim_read_write_block;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	DEBUG(0, ": failure during cmd %d, error=%d (%s)\n", dev->request.cmd,
+	      retval, mmc_result_to_string(retval));
+	mmc_finish_io_request(dev,0);
+	return mmc_cim_default_state;
+}
+
+static void * mmc_cim_handle_request( struct mmc_dev *dev, int first )
+{
+	DEBUG(2," first=%d\n",first);
+
+	if ( !first && !mmc_has_valid_request(dev)) {
+		DEBUG(0, ": invalid request\n");
+		mmc_finish_io_request(dev,0);
+		return mmc_cim_default_state;
+	}
+
+	if ( first )
+		return mmc_cim_get_status;
+
+	return mmc_cim_read_write_block;
+}
+
+/******************************************************************
+ *
+ * State machine routines to initialize card(s)
+ *
+ ******************************************************************/
+
+/*
+  CIM_SINGLE_CARD_ACQ  (frequency at 400 kHz)
+  --- Must enter from GO_IDLE_STATE ---
+
+  1. SEND_OP_COND (Full Range) [CMD1]   {optional}
+  2. SEND_OP_COND (Set Range ) [CMD1]
+     If busy, delay and repeat step 2
+  3. ALL_SEND_CID              [CMD2]
+     If timeout, set an error (no cards found)
+  4. SET_RELATIVE_ADDR         [CMD3]
+  5. SEND_CSD                  [CMD9]
+  6. SET_DSR                   [CMD4]    Only call this if (csd.dsr_imp).
+  7. Set clock frequency (check available in csd.tran_speed)
+ */
+
+static void * mmc_cim_single_card_acq( struct mmc_dev *dev, int first )
+{
+	struct mmc_response_r3 r3;
+	struct mmc_response_r1 r1;
+	struct mmc_slot *slot = dev->slot;     /* Must be slot 0 */
+	int retval;
+
+	DEBUG(2,"\n");
+
+	if ( first ) {
+		mmc_simple_cmd(dev, MMC_GO_IDLE_STATE, 0, RESPONSE_NONE);
+		return NULL;
+	}
+
+	switch (dev->request.cmd) {
+	case MMC_GO_IDLE_STATE: /* No response to parse */
+		if ( (dev->sdrive->flags & MMC_SDFLAG_VOLTAGE ))
+			DEBUG(0,": error - current driver doesn't do OCR\n");
+		mmc_simple_cmd(dev, MMC_SEND_OP_COND, dev->sdrive->ocr, RESPONSE_R3);
+		break;
+
+	case MMC_SEND_OP_COND:
+		retval = mmc_unpack_r3(&dev->request, &r3);
+		if ( retval ) {
+			DEBUG(0,": failed SEND_OP_COND error=%d (%s) - could be SD card\n", 
+			      retval, mmc_result_to_string(retval));
+			return mmc_cim_default_state;
+		}
+
+		DEBUG(2,": read ocr value = 0x%08x\n", r3.ocr);
+		if (!(r3.ocr & MMC_CARD_BUSY)) {
+			mmc_simple_cmd(dev, MMC_SEND_OP_COND, dev->sdrive->ocr, RESPONSE_R3);
+		}
+		else {
+			slot->state = CARD_STATE_READY;
+			mmc_simple_cmd(dev, MMC_ALL_SEND_CID, 0, RESPONSE_R2_CID);
+		}
+		break;
+		
+	case MMC_ALL_SEND_CID: 
+		retval = mmc_unpack_cid( &dev->request, &slot->cid );
+		if ( retval ) {
+			DEBUG(0,": unable to ALL_SEND_CID error=%d (%s)\n", 
+			      retval, mmc_result_to_string(retval));
+			return mmc_cim_default_state;
+		}
+		slot->state = CARD_STATE_IDENT;
+		mmc_simple_cmd(dev, MMC_SET_RELATIVE_ADDR, ID_TO_RCA(slot->id) << 16, RESPONSE_R1);
+		break;
+
+        case MMC_SET_RELATIVE_ADDR:
+		retval = mmc_unpack_r1(&dev->request,&r1,slot->state);
+		if ( retval ) {
+			DEBUG(0, ": unable to SET_RELATIVE_ADDR error=%d (%s)\n", 
+			      retval, mmc_result_to_string(retval));
+			return mmc_cim_default_state;
+		}
+		slot->state = CARD_STATE_STBY;
+		mmc_simple_cmd(dev, MMC_SEND_CSD, ID_TO_RCA(slot->id) << 16, RESPONSE_R2_CSD);
+		break;
+
+	case MMC_SEND_CSD:
+		retval = mmc_unpack_csd(&dev->request, &slot->csd);
+		if ( retval ) {
+			DEBUG(0, ": unable to SEND_CSD error=%d (%s)\n", 
+			      retval, mmc_result_to_string(retval));
+			return mmc_cim_default_state;
+		}
+		if ( slot->csd.dsr_imp ) {
+			DEBUG(0, ": driver doesn't support setting DSR\n");
+				// mmc_simple_cmd(dev, MMC_SET_DSR, 0, RESPONSE_NONE);
+		}
+		mmc_configure_card( dev, 0 );
+		return mmc_cim_default_state;
+
+	default:
+		DEBUG(0, ": error!  Illegal last cmd %d\n", dev->request.cmd);
+		return mmc_cim_default_state;
+	}
+	return NULL;
+}
+
+/*
+  CIM_INIT_STACK       (frequency at 400 kHz)
+
+  1. GO_IDLE_STATE (CMD0)
+  2. Do CIM_SINGLE_CARD_ACQ
+*/
+
+static void * mmc_cim_init_stack( struct mmc_dev *dev, int first )
+{
+	DEBUG(2,"\n");
+
+	if ( first ) {
+		mmc_simple_cmd(dev, MMC_CIM_RESET, 0, RESPONSE_NONE);
+		return NULL;
+	}
+
+	switch (dev->request.cmd) {
+	case MMC_CIM_RESET:
+		if ( dev->slot[0].state == CARD_STATE_EMPTY )
+			return mmc_cim_default_state;
+
+		dev->slot[0].state = CARD_STATE_IDLE;
+		return mmc_cim_single_card_acq;
+
+	default:
+		DEBUG(0,": invalid state %d\n", dev->request.cmd);
+		break;
+	}
+
+	return NULL;
+}
+
+/******************************************************************
+ *  Default state - start here
+ ******************************************************************/
+
+static void * mmc_cim_default_state( struct mmc_dev *dev, int first )
+{
+	DEBUG(2,"\n");
+
+	mmc_check_eject(dev);
+
+	if (mmc_check_insert(dev))
+		return mmc_cim_init_stack;
+	else if (mmc_has_valid_request(dev))
+		return mmc_cim_handle_request;
+
+	return NULL;
+}
+
+
+/******************************************************************
+ *  State function handler
+ ******************************************************************/
+
+typedef void *(*state_func_t)(struct mmc_dev *, int);
+static state_func_t g_single_card = &mmc_cim_default_state;
+
+void mmc_protocol_single_card( struct mmc_dev *dev, int state_flags )
+{
+	state_func_t    sf;
+
+	sf = g_single_card(dev,0);
+	while ( sf ) {
+		g_single_card = sf;
+		sf = g_single_card(dev,1);
+	}
+}
diff -ruwN -X dontdiff linux-2.4.19/drivers/mmc/mmc_protocol.h linux-2.4.19-mmc1/drivers/mmc/mmc_protocol.h
--- linux-2.4.19/drivers/mmc/mmc_protocol.h	Wed Dec 31 19:00:00 1969
+++ linux-2.4.19-mmc1/drivers/mmc/mmc_protocol.h	Fri Aug  9 16:07:50 2002
@@ -0,0 +1,266 @@
+/*
+ * Header for MultiMediaCard (MMC)
+ *
+ * Copyright (c) 2002 Hewlett-Packard Company
+ *   
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *  
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *  
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Many thanks to Alessandro Rubini and Jonathan Corbet!
+ *
+ * Based strongly on code by:
+ *
+ * Author: Yong-iL Joh <tolkien@mizi.com>
+ * Date  : $Date: 2002/06/13 21:06:08 $ 
+ *
+ * Author:  Andrew Christian
+ *          15 May 2002
+ */
+
+#ifndef MMC_MMC_PROTOCOL_H
+#define MMC_MMC_PROTOCOL_H
+
+#include <linux/types.h>
+
+/* Standard MMC clock speeds */
+#define MMC_CLOCK_SLOW    400000      /* 400 kHz for initial setup */
+#define MMC_CLOCK_FAST  20000000      /* 20 MHz for maximum for normal operation */
+
+/* Extra MMC commands for state control */
+/* Use negative numbers to disambiguate */
+#define MMC_CIM_RESET            -1
+
+/* Standard MMC commands (3.1)           type  argument     response */
+   /* class 1 */
+#define	MMC_GO_IDLE_STATE         0   /* bc                          */
+#define MMC_SEND_OP_COND          1   /* bcr  [31:0] OCR         R3  */
+#define MMC_ALL_SEND_CID          2   /* bcr                     R2  */
+#define MMC_SET_RELATIVE_ADDR     3   /* ac   [31:16] RCA        R1  */
+#define MMC_SET_DSR               4   /* bc   [31:16] RCA            */
+#define MMC_SELECT_CARD           7   /* ac   [31:16] RCA        R1  */
+#define MMC_SEND_CSD              9   /* ac   [31:16] RCA        R2  */
+#define MMC_SEND_CID             10   /* ac   [31:16] RCA        R2  */
+#define MMC_READ_DAT_UNTIL_STOP  11   /* adtc [31:0] dadr        R1  */
+#define MMC_STOP_TRANSMISSION    12   /* ac                      R1b */
+#define MMC_SEND_STATUS	         13   /* ac   [31:16] RCA        R1  */
+#define MMC_GO_INACTIVE_STATE    15   /* ac   [31:16] RCA            */
+
+  /* class 2 */
+#define MMC_SET_BLOCKLEN         16   /* ac   [31:0] block len   R1  */
+#define MMC_READ_SINGLE_BLOCK    17   /* adtc [31:0] data addr   R1  */
+#define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
+
+  /* class 3 */
+#define MMC_WRITE_DAT_UNTIL_STOP 20   /* adtc [31:0] data addr   R1  */
+
+  /* class 4 */
+#define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  */
+#define MMC_WRITE_BLOCK          24   /* adtc [31:0] data addr   R1  */
+#define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
+#define MMC_PROGRAM_CID          26   /* adtc                    R1  */
+#define MMC_PROGRAM_CSD          27   /* adtc                    R1  */
+
+  /* class 6 */
+#define MMC_SET_WRITE_PROT       28   /* ac   [31:0] data addr   R1b */
+#define MMC_CLR_WRITE_PROT       29   /* ac   [31:0] data addr   R1b */
+#define MMC_SEND_WRITE_PROT      30   /* adtc [31:0] wpdata addr R1  */
+
+  /* class 5 */
+#define MMC_ERASE_GROUP_START    35   /* ac   [31:0] data addr   R1  */
+#define MMC_ERASE_GROUP_END      36   /* ac   [31:0] data addr   R1  */
+#define MMC_ERASE                37   /* ac                      R1b */
+
+  /* class 9 */
+#define MMC_FAST_IO              39   /* ac   <Complex>          R4  */
+#define MMC_GO_IRQ_STATE         40   /* bcr                     R5  */
+
+  /* class 7 */
+#define MMC_LOCK_UNLOCK          42   /* adtc                    R1b */
+
+  /* class 8 */
+#define MMC_APP_CMD              55   /* ac   [31:16] RCA        R1  */
+#define MMC_GEN_CMD              56   /* adtc [0] RD/WR          R1b */
+
+/* Don't change the order of these; they are used in dispatch tables */
+enum mmc_rsp_t {
+	RESPONSE_NONE   = 0,
+	RESPONSE_R1     = 1,
+	RESPONSE_R1B    = 2,
+	RESPONSE_R2_CID = 3,
+	RESPONSE_R2_CSD  = 4,
+	RESPONSE_R3      = 5,
+	RESPONSE_R4      = 6,
+	RESPONSE_R5      = 7
+};
+
+
+/*
+  MMC status in R1
+  Type
+  	e : error bit
+	s : status bit
+	r : detected and set for the actual command response
+	x : detected and set during command execution. the host must poll
+            the card by sending status command in order to read these bits.
+  Clear condition
+  	a : according to the card state
+	b : always related to the previous command. Reception of
+            a valid command will clear it (with a delay of one command)
+	c : clear by read
+ */
+
+#define R1_OUT_OF_RANGE		(1 << 31)	/* er, c */
+#define R1_ADDRESS_ERROR	(1 << 30)	/* erx, c */
+#define R1_BLOCK_LEN_ERROR	(1 << 29)	/* er, c */
+#define R1_ERASE_SEQ_ERROR      (1 << 28)	/* er, c */
+#define R1_ERASE_PARAM		(1 << 27)	/* ex, c */
+#define R1_WP_VIOLATION		(1 << 26)	/* erx, c */
+#define R1_CARD_IS_LOCKED	(1 << 25)	/* sx, a */
+#define R1_LOCK_UNLOCK_FAILED	(1 << 24)	/* erx, c */
+#define R1_COM_CRC_ERROR	(1 << 23)	/* er, b */
+#define R1_ILLEGAL_COMMAND	(1 << 22)	/* er, b */
+#define R1_CARD_ECC_FAILED	(1 << 21)	/* ex, c */
+#define R1_CC_ERROR		(1 << 20)	/* erx, c */
+#define R1_ERROR		(1 << 19)	/* erx, c */
+#define R1_UNDERRUN		(1 << 18)	/* ex, c */
+#define R1_OVERRUN		(1 << 17)	/* ex, c */
+#define R1_CID_CSD_OVERWRITE	(1 << 16)	/* erx, c, CID/CSD overwrite */
+#define R1_WP_ERASE_SKIP	(1 << 15)	/* sx, c */
+#define R1_CARD_ECC_DISABLED	(1 << 14)	/* sx, a */
+#define R1_ERASE_RESET		(1 << 13)	/* sr, c */
+#define R1_STATUS(x)            (x & 0xFFFFE000)
+#define R1_CURRENT_STATE(x)    	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
+#define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
+#define R1_APP_CMD		(1 << 7)	/* sr, c */
+
+enum card_state {
+	CARD_STATE_EMPTY = -1,
+	CARD_STATE_IDLE	 = 0,
+	CARD_STATE_READY = 1,
+	CARD_STATE_IDENT = 2,
+	CARD_STATE_STBY	 = 3,
+	CARD_STATE_TRAN	 = 4,
+	CARD_STATE_DATA	 = 5,
+	CARD_STATE_RCV	 = 6,
+	CARD_STATE_PRG	 = 7,
+	CARD_STATE_DIS	 = 8,
+};
+
+/* These are unpacked versions of the actual responses */
+
+struct mmc_response_r1 {
+	u8  cmd;
+	u32 status;
+};
+
+struct mmc_cid {
+	u8  mid;
+	u16 oid;
+	u8  pnm[7];   // Product name (we null-terminate)
+	u8  prv;
+	u32 psn;
+	u8  mdt;
+};
+
+struct mmc_csd {
+	u8  csd_structure;
+	u8  spec_vers;
+	u8  taac;
+	u8  nsac;
+	u8  tran_speed;
+	u16 ccc;
+	u8  read_bl_len;
+	u8  read_bl_partial;
+	u8  write_blk_misalign;
+	u8  read_blk_misalign;
+	u8  dsr_imp;
+	u16 c_size;
+	u8  vdd_r_curr_min;
+	u8  vdd_r_curr_max;
+	u8  vdd_w_curr_min;
+	u8  vdd_w_curr_max;
+	u8  c_size_mult;
+	union {
+		struct { /* MMC system specification version 3.1 */
+			u8  erase_grp_size;  
+			u8  erase_grp_mult; 
+		} v31;
+		struct { /* MMC system specification version 2.2 */
+			u8  sector_size;
+			u8  erase_grp_size;
+		} v22;
+	} erase;
+	u8  wp_grp_size;
+	u8  wp_grp_enable;
+	u8  default_ecc;
+	u8  r2w_factor;
+	u8  write_bl_len;
+	u8  write_bl_partial;
+	u8  file_format_grp;
+	u8  copy;
+	u8  perm_write_protect;
+	u8  tmp_write_protect;
+	u8  file_format;
+	u8  ecc;
+};
+
+struct mmc_response_r3 {  
+	u32 ocr;
+}; 
+
+#define MMC_VDD_145_150	0x00000001	/* VDD voltage 1.45 - 1.50 */
+#define MMC_VDD_150_155	0x00000002	/* VDD voltage 1.50 - 1.55 */
+#define MMC_VDD_155_160	0x00000004	/* VDD voltage 1.55 - 1.60 */
+#define MMC_VDD_160_165	0x00000008	/* VDD voltage 1.60 - 1.65 */
+#define MMC_VDD_165_170	0x00000010	/* VDD voltage 1.65 - 1.70 */
+#define MMC_VDD_17_18	0x00000020	/* VDD voltage 1.7 - 1.8 */
+#define MMC_VDD_18_19	0x00000040	/* VDD voltage 1.8 - 1.9 */
+#define MMC_VDD_19_20	0x00000080	/* VDD voltage 1.9 - 2.0 */
+#define MMC_VDD_20_21	0x00000100	/* VDD voltage 2.0 ~ 2.1 */
+#define MMC_VDD_21_22	0x00000200	/* VDD voltage 2.1 ~ 2.2 */
+#define MMC_VDD_22_23	0x00000400	/* VDD voltage 2.2 ~ 2.3 */
+#define MMC_VDD_23_24	0x00000800	/* VDD voltage 2.3 ~ 2.4 */
+#define MMC_VDD_24_25	0x00001000	/* VDD voltage 2.4 ~ 2.5 */
+#define MMC_VDD_25_26	0x00002000	/* VDD voltage 2.5 ~ 2.6 */
+#define MMC_VDD_26_27	0x00004000	/* VDD voltage 2.6 ~ 2.7 */
+#define MMC_VDD_27_28	0x00008000	/* VDD voltage 2.7 ~ 2.8 */
+#define MMC_VDD_28_29	0x00010000	/* VDD voltage 2.8 ~ 2.9 */
+#define MMC_VDD_29_30	0x00020000	/* VDD voltage 2.9 ~ 3.0 */
+#define MMC_VDD_30_31	0x00040000	/* VDD voltage 3.0 ~ 3.1 */
+#define MMC_VDD_31_32	0x00080000	/* VDD voltage 3.1 ~ 3.2 */
+#define MMC_VDD_32_33	0x00100000	/* VDD voltage 3.2 ~ 3.3 */
+#define MMC_VDD_33_34	0x00200000	/* VDD voltage 3.3 ~ 3.4 */
+#define MMC_VDD_34_35	0x00400000	/* VDD voltage 3.4 ~ 3.5 */
+#define MMC_VDD_35_36	0x00800000	/* VDD voltage 3.5 ~ 3.6 */
+#define MMC_CARD_BUSY	0x80000000	/* Card Power up status bit */
+
+
+/* CSD field definitions */
+ 
+#define CSD_STRUCT_VER_1_0  0           /* Valid for system specification 1.0 - 1.2 */
+#define CSD_STRUCT_VER_1_1  1           /* Valid for system specification 1.4 - 2.2 */
+#define CSD_STRUCT_VER_1_2  2           /* Valid for system specification 3.1       */
+
+#define CSD_SPEC_VER_0      0           /* Implements system specification 1.0 - 1.2 */
+#define CSD_SPEC_VER_1      1           /* Implements system specification 1.4 */
+#define CSD_SPEC_VER_2      2           /* Implements system specification 2.0 - 2.2 */
+#define CSD_SPEC_VER_3      3           /* Implements system specification 3.1 */
+
+#endif  /* MMC_MMC_PROTOCOL_H */
+
diff -ruwN -X dontdiff linux-2.4.19/include/linux/mmc/mmc_ll.h linux-2.4.19-mmc1/include/linux/mmc/mmc_ll.h
--- linux-2.4.19/include/linux/mmc/mmc_ll.h	Wed Dec 31 19:00:00 1969
+++ linux-2.4.19-mmc1/include/linux/mmc/mmc_ll.h	Fri Aug  9 16:08:01 2002
@@ -0,0 +1,117 @@
+/*
+ * Header for MultiMediaCard (MMC)
+ *
+ * Copyright (c) 2002 Hewlett-Packard Company
+ *   
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *  
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *  
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Many thanks to Alessandro Rubini and Jonathan Corbet!
+ *
+ * Based strongly on code by:
+ *
+ * Author: Yong-iL Joh <tolkien@mizi.com>
+ * Date  : $Date: 2002/06/18 19:07:20 $ 
+ *
+ * Author:  Andrew Christian
+ *          15 May 2002
+ */
+
+#ifndef MMC_MMC_LL_H
+#define MMC_MMC_LL_H
+
+#include <linux/types.h>
+#include <linux/mmc/mmc_protocol.h>
+
+#ifdef __KERNEL__
+
+/* Error codes */
+enum mmc_result_t {
+	MMC_NO_RESPONSE        = -1,
+	MMC_NO_ERROR           = 0,
+	MMC_ERROR_OUT_OF_RANGE,
+	MMC_ERROR_ADDRESS,
+	MMC_ERROR_BLOCK_LEN,
+	MMC_ERROR_ERASE_SEQ,
+	MMC_ERROR_ERASE_PARAM,
+	MMC_ERROR_WP_VIOLATION,
+	MMC_ERROR_CARD_IS_LOCKED,
+	MMC_ERROR_LOCK_UNLOCK_FAILED,
+	MMC_ERROR_COM_CRC,
+	MMC_ERROR_ILLEGAL_COMMAND,
+	MMC_ERROR_CARD_ECC_FAILED,
+	MMC_ERROR_CC,
+	MMC_ERROR_GENERAL,
+	MMC_ERROR_UNDERRUN,
+	MMC_ERROR_OVERRUN,
+	MMC_ERROR_CID_CSD_OVERWRITE,
+	MMC_ERROR_STATE_MISMATCH,
+	MMC_ERROR_HEADER_MISMATCH,
+	MMC_ERROR_TIMEOUT,
+	MMC_ERROR_CRC,
+	MMC_ERROR_DRIVER_FAILURE,
+};
+
+struct mmc_request {
+	int               index;      /* Slot index - used for CS lines */
+	int               cmd;        /* Command to send */
+	u32               arg;        /* Argument to send */
+	enum mmc_rsp_t    rtype;      /* Response type expected */
+
+	/* Data transfer (these may be modified at the low level) */
+	u16               nob;        /* Number of blocks to transfer*/
+	u16               block_len;  /* Block length */
+	u8               *buffer;     /* Data buffer */
+
+	/* Results */
+	u8                response[18]; /* Buffer to store response - CRC is optional */
+	enum mmc_result_t result;
+};
+
+#define MMC_SDFLAG_SPI_MODE   (1<<0)    /* Can use SPI mode */
+#define MMC_SDFLAG_MMC_MODE   (1<<1)    /* Can use MMC mode */
+#define MMC_SDFLAG_SD_MODE    (1<<2)    /* Can use SD mode */
+#define MMC_SDFLAG_VOLTAGE    (1<<3)    /* Can change voltage range */
+
+struct module;
+
+struct mmc_slot_driver {
+	struct module  *owner;
+	char           *name;
+	u32             ocr;         /* Valid voltage ranges */
+	u32             flags;       /* Slot driver flags */
+
+	int  (*init)(void);   
+	void (*cleanup)(void);
+	int  (*is_empty)(int);
+	int  (*set_clock)(u32 rate);
+	void (*send_cmd)(struct mmc_request *);
+};
+
+/* Calls made by the hardware-specific slot driver code */
+extern int  mmc_register_slot_driver( struct mmc_slot_driver *, int );
+extern void mmc_unregister_slot_driver( struct mmc_slot_driver * );
+extern void mmc_cmd_complete( struct mmc_request * );
+extern void mmc_insert( int );
+extern void mmc_eject( int );
+
+#endif /* #ifdef __KERNEL__ */
+
+#endif /* MMC_MMC_LL_H */
+
diff -ruwN -X dontdiff linux-2.4.19/include/linux/mmc/mmc_protocol.h linux-2.4.19-mmc1/include/linux/mmc/mmc_protocol.h
--- linux-2.4.19/include/linux/mmc/mmc_protocol.h	Wed Dec 31 19:00:00 1969
+++ linux-2.4.19-mmc1/include/linux/mmc/mmc_protocol.h	Fri Aug  9 16:08:07 2002
@@ -0,0 +1,285 @@
+/*
+ * Header for MultiMediaCard (MMC)
+ *
+ * Copyright (c) 2002 Hewlett-Packard Company
+ *   
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *  
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *  
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Many thanks to Alessandro Rubini and Jonathan Corbet!
+ *
+ * Based strongly on code by:
+ *
+ * Author: Yong-iL Joh <tolkien@mizi.com>
+ * Date  : $Date: 2002/06/18 12:37:30 $ 
+ *
+ * Author:  Andrew Christian
+ *          15 May 2002
+ */
+
+#ifndef MMC_MMC_PROTOCOL_H
+#define MMC_MMC_PROTOCOL_H
+
+#include <linux/types.h>
+
+/* Standard MMC clock speeds */
+#define MMC_CLOCK_SLOW    400000      /* 400 kHz for initial setup */
+#define MMC_CLOCK_FAST  20000000      /* 20 MHz for maximum for normal operation */
+
+/* Extra MMC commands for state control */
+/* Use negative numbers to disambiguate */
+#define MMC_CIM_RESET            -1
+
+/* Standard MMC commands (3.1)           type  argument     response */
+   /* class 1 */
+#define	MMC_GO_IDLE_STATE         0   /* bc                          */
+#define MMC_SEND_OP_COND          1   /* bcr  [31:0] OCR         R3  */
+#define MMC_ALL_SEND_CID          2   /* bcr                     R2  */
+#define MMC_SET_RELATIVE_ADDR     3   /* ac   [31:16] RCA        R1  */
+#define MMC_SET_DSR               4   /* bc   [31:16] RCA            */
+#define MMC_SELECT_CARD           7   /* ac   [31:16] RCA        R1  */
+#define MMC_SEND_CSD              9   /* ac   [31:16] RCA        R2  */
+#define MMC_SEND_CID             10   /* ac   [31:16] RCA        R2  */
+#define MMC_READ_DAT_UNTIL_STOP  11   /* adtc [31:0] dadr        R1  */
+#define MMC_STOP_TRANSMISSION    12   /* ac                      R1b */
+#define MMC_SEND_STATUS	         13   /* ac   [31:16] RCA        R1  */
+#define MMC_GO_INACTIVE_STATE    15   /* ac   [31:16] RCA            */
+
+  /* class 2 */
+#define MMC_SET_BLOCKLEN         16   /* ac   [31:0] block len   R1  */
+#define MMC_READ_SINGLE_BLOCK    17   /* adtc [31:0] data addr   R1  */
+#define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
+
+  /* class 3 */
+#define MMC_WRITE_DAT_UNTIL_STOP 20   /* adtc [31:0] data addr   R1  */
+
+  /* class 4 */
+#define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  */
+#define MMC_WRITE_BLOCK          24   /* adtc [31:0] data addr   R1  */
+#define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
+#define MMC_PROGRAM_CID          26   /* adtc                    R1  */
+#define MMC_PROGRAM_CSD          27   /* adtc                    R1  */
+
+  /* class 6 */
+#define MMC_SET_WRITE_PROT       28   /* ac   [31:0] data addr   R1b */
+#define MMC_CLR_WRITE_PROT       29   /* ac   [31:0] data addr   R1b */
+#define MMC_SEND_WRITE_PROT      30   /* adtc [31:0] wpdata addr R1  */
+
+  /* class 5 */
+#define MMC_ERASE_GROUP_START    35   /* ac   [31:0] data addr   R1  */
+#define MMC_ERASE_GROUP_END      36   /* ac   [31:0] data addr   R1  */
+#define MMC_ERASE                37   /* ac                      R1b */
+
+  /* class 9 */
+#define MMC_FAST_IO              39   /* ac   <Complex>          R4  */
+#define MMC_GO_IRQ_STATE         40   /* bcr                     R5  */
+
+  /* class 7 */
+#define MMC_LOCK_UNLOCK          42   /* adtc                    R1b */
+
+  /* class 8 */
+#define MMC_APP_CMD              55   /* ac   [31:16] RCA        R1  */
+#define MMC_GEN_CMD              56   /* adtc [0] RD/WR          R1b */
+
+/* Don't change the order of these; they are used in dispatch tables */
+enum mmc_rsp_t {
+	RESPONSE_NONE   = 0,
+	RESPONSE_R1     = 1,
+	RESPONSE_R1B    = 2,
+	RESPONSE_R2_CID = 3,
+	RESPONSE_R2_CSD  = 4,
+	RESPONSE_R3      = 5,
+	RESPONSE_R4      = 6,
+	RESPONSE_R5      = 7
+};
+
+
+/*
+  MMC status in R1
+  Type
+  	e : error bit
+	s : status bit
+	r : detected and set for the actual command response
+	x : detected and set during command execution. the host must poll
+            the card by sending status command in order to read these bits.
+  Clear condition
+  	a : according to the card state
+	b : always related to the previous command. Reception of
+            a valid command will clear it (with a delay of one command)
+	c : clear by read
+ */
+
+#define R1_OUT_OF_RANGE		(1 << 31)	/* er, c */
+#define R1_ADDRESS_ERROR	(1 << 30)	/* erx, c */
+#define R1_BLOCK_LEN_ERROR	(1 << 29)	/* er, c */
+#define R1_ERASE_SEQ_ERROR      (1 << 28)	/* er, c */
+#define R1_ERASE_PARAM		(1 << 27)	/* ex, c */
+#define R1_WP_VIOLATION		(1 << 26)	/* erx, c */
+#define R1_CARD_IS_LOCKED	(1 << 25)	/* sx, a */
+#define R1_LOCK_UNLOCK_FAILED	(1 << 24)	/* erx, c */
+#define R1_COM_CRC_ERROR	(1 << 23)	/* er, b */
+#define R1_ILLEGAL_COMMAND	(1 << 22)	/* er, b */
+#define R1_CARD_ECC_FAILED	(1 << 21)	/* ex, c */
+#define R1_CC_ERROR		(1 << 20)	/* erx, c */
+#define R1_ERROR		(1 << 19)	/* erx, c */
+#define R1_UNDERRUN		(1 << 18)	/* ex, c */
+#define R1_OVERRUN		(1 << 17)	/* ex, c */
+#define R1_CID_CSD_OVERWRITE	(1 << 16)	/* erx, c, CID/CSD overwrite */
+#define R1_WP_ERASE_SKIP	(1 << 15)	/* sx, c */
+#define R1_CARD_ECC_DISABLED	(1 << 14)	/* sx, a */
+#define R1_ERASE_RESET		(1 << 13)	/* sr, c */
+#define R1_STATUS(x)            (x & 0xFFFFE000)
+#define R1_CURRENT_STATE(x)    	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
+#define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
+#define R1_APP_CMD		(1 << 7)	/* sr, c */
+
+enum card_state {
+	CARD_STATE_EMPTY = -1,
+	CARD_STATE_IDLE	 = 0,
+	CARD_STATE_READY = 1,
+	CARD_STATE_IDENT = 2,
+	CARD_STATE_STBY	 = 3,
+	CARD_STATE_TRAN	 = 4,
+	CARD_STATE_DATA	 = 5,
+	CARD_STATE_RCV	 = 6,
+	CARD_STATE_PRG	 = 7,
+	CARD_STATE_DIS	 = 8,
+};
+
+/* These are unpacked versions of the actual responses */
+
+struct mmc_response_r1 {
+	u8  cmd;
+	u32 status;
+};
+
+struct mmc_cid {
+	u8  mid;
+	u16 oid;
+	u8  pnm[7];   // Product name (we null-terminate)
+	u8  prv;
+	u32 psn;
+	u8  mdt;
+};
+
+struct mmc_csd {
+	u8  csd_structure;
+	u8  spec_vers;
+	u8  taac;
+	u8  nsac;
+	u8  tran_speed;
+	u16 ccc;
+	u8  read_bl_len;
+	u8  read_bl_partial;
+	u8  write_blk_misalign;
+	u8  read_blk_misalign;
+	u8  dsr_imp;
+	u16 c_size;
+	u8  vdd_r_curr_min;
+	u8  vdd_r_curr_max;
+	u8  vdd_w_curr_min;
+	u8  vdd_w_curr_max;
+	u8  c_size_mult;
+	union {
+		struct { /* MMC system specification version 3.1 */
+			u8  erase_grp_size;  
+			u8  erase_grp_mult; 
+		} v31;
+		struct { /* MMC system specification version 2.2 */
+			u8  sector_size;
+			u8  erase_grp_size;
+		} v22;
+	} erase;
+	u8  wp_grp_size;
+	u8  wp_grp_enable;
+	u8  default_ecc;
+	u8  r2w_factor;
+	u8  write_bl_len;
+	u8  write_bl_partial;
+	u8  file_format_grp;
+	u8  copy;
+	u8  perm_write_protect;
+	u8  tmp_write_protect;
+	u8  file_format;
+	u8  ecc;
+};
+
+struct mmc_response_r3 {  
+	u32 ocr;
+}; 
+
+#define MMC_VDD_145_150	0x00000001	/* VDD voltage 1.45 - 1.50 */
+#define MMC_VDD_150_155	0x00000002	/* VDD voltage 1.50 - 1.55 */
+#define MMC_VDD_155_160	0x00000004	/* VDD voltage 1.55 - 1.60 */
+#define MMC_VDD_160_165	0x00000008	/* VDD voltage 1.60 - 1.65 */
+#define MMC_VDD_165_170	0x00000010	/* VDD voltage 1.65 - 1.70 */
+#define MMC_VDD_17_18	0x00000020	/* VDD voltage 1.7 - 1.8 */
+#define MMC_VDD_18_19	0x00000040	/* VDD voltage 1.8 - 1.9 */
+#define MMC_VDD_19_20	0x00000080	/* VDD voltage 1.9 - 2.0 */
+#define MMC_VDD_20_21	0x00000100	/* VDD voltage 2.0 ~ 2.1 */
+#define MMC_VDD_21_22	0x00000200	/* VDD voltage 2.1 ~ 2.2 */
+#define MMC_VDD_22_23	0x00000400	/* VDD voltage 2.2 ~ 2.3 */
+#define MMC_VDD_23_24	0x00000800	/* VDD voltage 2.3 ~ 2.4 */
+#define MMC_VDD_24_25	0x00001000	/* VDD voltage 2.4 ~ 2.5 */
+#define MMC_VDD_25_26	0x00002000	/* VDD voltage 2.5 ~ 2.6 */
+#define MMC_VDD_26_27	0x00004000	/* VDD voltage 2.6 ~ 2.7 */
+#define MMC_VDD_27_28	0x00008000	/* VDD voltage 2.7 ~ 2.8 */
+#define MMC_VDD_28_29	0x00010000	/* VDD voltage 2.8 ~ 2.9 */
+#define MMC_VDD_29_30	0x00020000	/* VDD voltage 2.9 ~ 3.0 */
+#define MMC_VDD_30_31	0x00040000	/* VDD voltage 3.0 ~ 3.1 */
+#define MMC_VDD_31_32	0x00080000	/* VDD voltage 3.1 ~ 3.2 */
+#define MMC_VDD_32_33	0x00100000	/* VDD voltage 3.2 ~ 3.3 */
+#define MMC_VDD_33_34	0x00200000	/* VDD voltage 3.3 ~ 3.4 */
+#define MMC_VDD_34_35	0x00400000	/* VDD voltage 3.4 ~ 3.5 */
+#define MMC_VDD_35_36	0x00800000	/* VDD voltage 3.5 ~ 3.6 */
+#define MMC_CARD_BUSY	0x80000000	/* Card Power up status bit */
+
+
+/* CSD field definitions */
+ 
+#define CSD_STRUCT_VER_1_0  0           /* Valid for system specification 1.0 - 1.2 */
+#define CSD_STRUCT_VER_1_1  1           /* Valid for system specification 1.4 - 2.2 */
+#define CSD_STRUCT_VER_1_2  2           /* Valid for system specification 3.1       */
+
+#define CSD_SPEC_VER_0      0           /* Implements system specification 1.0 - 1.2 */
+#define CSD_SPEC_VER_1      1           /* Implements system specification 1.4 */
+#define CSD_SPEC_VER_2      2           /* Implements system specification 2.0 - 2.2 */
+#define CSD_SPEC_VER_3      3           /* Implements system specification 3.1 */
+
+
+
+#ifdef CONFIG_MMC_DEBUG
+#ifndef CONFIG_MMC_DEBUG_VERBOSE
+#define CONFIG_MMC_DEBUG_VERBOSE 3
+#endif
+extern int g_mmc_debug;
+#define DEBUG(n, args...)			\
+	if (n <=  g_mmc_debug) {	\
+		printk(KERN_INFO __FUNCTION__ args);	\
+	}
+#define START_DEBUG(n) do { if (n <= g_mmc_debug)
+#define END_DEBUG      } while (0)
+#else
+#define DEBUG(n, args...)
+#define START_DEBUG(n)
+#define END_DEBUG
+#endif /* CONFIG_MMC_DEBUG */
+
+#endif  /* MMC_MMC_PROTOCOL_H */
+
diff -ruwN -X dontdiff linux-2.4.19/include/linux/sysctl.h linux-2.4.19-mmc1/include/linux/sysctl.h
--- linux-2.4.19/include/linux/sysctl.h	Fri Aug  2 20:39:46 2002
+++ linux-2.4.19-mmc1/include/linux/sysctl.h	Fri Aug  9 15:54:57 2002
@@ -69,7 +69,8 @@
 /* CTL_BUS names: */
 enum
 {
-	BUS_ISA=1		/* ISA */
+	BUS_ISA=1,		/* ISA */
+	BUS_MMC=2		/* MultiMedia Card */
 };
 
 /* CTL_KERN names: */
