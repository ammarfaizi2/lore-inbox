Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTDDTEM (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263917AbTDDTEL (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:04:11 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.29]:9551 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263915AbTDDTDk (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 14:03:40 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] Backport of USB speedtouch driver to 2.4
Date: Fri, 4 Apr 2003 21:15:00 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304042115.00706.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the 2.5 crc library hasn't been backported
to the 2.4 tree yet, I included a crc routine in
the speedcrc files.


CREDITS                      |    8 
Documentation/Configure.help |   11 
MAINTAINERS                  |    8 
drivers/usb/Config.in        |    1 
drivers/usb/Makefile         |    5 
drivers/usb/speedcrc.c       |  124 +++
drivers/usb/speedcrc.h       |   28 
drivers/usb/speedtouch.c     | 1412 +++++++++++++++++++++++++++++++++++++++++++
8 files changed, 1597 insertions(+)


diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	Fri Apr  4 15:32:22 2003
+++ b/CREDITS	Fri Apr  4 15:32:22 2003
@@ -2667,6 +2667,14 @@
 E: gt8134b@prism.gatech.edu
 D: Dosemu
 
+N: Duncan Sands
+E: duncan.sands@wanadoo.fr
+W: http://topo.math.u-psud.fr/~sands
+D: Alcatel SpeedTouch USB driver
+S: 69 rue Dunois
+S: 75013 Paris
+S: France
+
 N: Hannu Savolainen
 E: hannu@opensound.com
 D: Maintainer of the sound drivers until 2.1.x days.
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Fri Apr  4 15:32:22 2003
+++ b/Documentation/Configure.help	Fri Apr  4 15:32:22 2003
@@ -14857,6 +14857,17 @@
   The module will be called dsbr100.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
+Alcatel Speedtouch USB support
+CONFIG_USB_SPEEDTOUCH
+  Say Y here if you have an Alcatel SpeedTouch USB or SpeedTouch 330
+  modem.  In order to use your modem you will need to install some user
+  space tools, see <http://www.linux-usb.org/SpeedTouch/> for details.
+
+  This code is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called speedtch.o. If you want to compile it as
+  a module, say M here and read <file:Documentation/modules.txt>.
+
 Always do synchronous disk IO for UBD
 CONFIG_BLK_DEV_UBD_SYNC
   The User-Mode Linux port includes a driver called UBD which will let
diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Fri Apr  4 15:32:22 2003
+++ b/MAINTAINERS	Fri Apr  4 15:32:22 2003
@@ -206,6 +206,14 @@
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
+ALCATEL SPEEDTOUCH USB DRIVER
+P:	Duncan Sands
+M:	duncan.sands@wanadoo.fr
+L:	linux-usb-users@lists.sourceforge.net
+L:	linux-usb-devel@lists.sourceforge.net
+W:	http://www.linux-usb.org/SpeedTouch/
+S:	Maintained
+
 ALTERA EPXA1/EPXA10 DEVELOPMENT BOARD PORT
 P:	Clive Davies
 M:	cdavies@altera.com
diff -Nru a/drivers/usb/Config.in b/drivers/usb/Config.in
--- a/drivers/usb/Config.in	Fri Apr  4 15:32:22 2003
+++ b/drivers/usb/Config.in	Fri Apr  4 15:32:22 2003
@@ -105,5 +105,6 @@
    dep_tristate '  Texas Instruments Graph Link USB (aka SilverLink) cable support' CONFIG_USB_TIGL $CONFIG_USB
    dep_tristate '  Tieman Voyager USB Braille display support (EXPERIMENTAL)' CONFIG_USB_BRLVGER $CONFIG_USB $CONFIG_EXPERIMENTAL
    dep_tristate '  USB LCD device support' CONFIG_USB_LCD $CONFIG_USB
+   dep_tristate '  Alcatel Speedtouch USB support' CONFIG_USB_SPEEDTOUCH $CONFIG_ATM $CONFIG_USB
 fi
 endmenu
diff -Nru a/drivers/usb/Makefile b/drivers/usb/Makefile
--- a/drivers/usb/Makefile	Fri Apr  4 15:32:22 2003
+++ b/drivers/usb/Makefile	Fri Apr  4 15:32:22 2003
@@ -19,6 +19,7 @@
 hid-objs		:= hid-core.o
 pwc-objs		:= pwc-if.o pwc-misc.o pwc-ctrl.o pwc-uncompress.o
 auerswald-objs		:= auerbuf.o auerchain.o auerchar.o auermain.o
+speedtch-objs		:= speedcrc.o speedtouch.o
 
 # Optional parts of multipart objects.
 
@@ -117,6 +118,7 @@
 obj-$(CONFIG_USB_AUERSWALD)	+= auerswald.o
 obj-$(CONFIG_USB_BRLVGER)	+= brlvger.o
 obj-$(CONFIG_USB_LCD)		+= usblcd.o
+obj-$(CONFIG_USB_SPEEDTOUCH)	+= speedtch.o
 
 # Object files in subdirectories
 mod-subdirs	:= serial host
@@ -147,3 +149,6 @@
 
 auerswald.o: $(auerswald-objs)
 	$(LD) -r -o $@ $(auerswald-objs)
+
+speedtch.o: $(speedtch-objs)
+	$(LD) -r -o $@ $(speedtch-objs)
diff -Nru a/drivers/usb/speedcrc.c b/drivers/usb/speedcrc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/usb/speedcrc.c	Fri Apr  4 15:32:22 2003
@@ -0,0 +1,124 @@
+/******************************************************************************
+ *  speedcrc.c  --  CRC library for use with speedtouch.
+ *
+ *  Copyright (C) 2000, Johan Verrept
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ *  more details.
+ *
+ *  You should have received a copy of the GNU General Public License along with
+ *  this program; if not, write to the Free Software Foundation, Inc., 59
+ *  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ ******************************************************************************/
+
+#include <stddef.h>
+
+/*
+ * CRC Routines from  net/wan/sbni.c)
+ * table generated by Rocksoft^tm Model CRC Algorithm Table Generation Program V1.0
+ */
+#define CRC32_REMAINDER CBF43926
+#define CRC32_INITIAL 0xffffffff
+unsigned long crc32tab[256] = {
+	0x00000000L, 0x04C11DB7L, 0x09823B6EL, 0x0D4326D9L,
+	0x130476DCL, 0x17C56B6BL, 0x1A864DB2L, 0x1E475005L,
+	0x2608EDB8L, 0x22C9F00FL, 0x2F8AD6D6L, 0x2B4BCB61L,
+	0x350C9B64L, 0x31CD86D3L, 0x3C8EA00AL, 0x384FBDBDL,
+	0x4C11DB70L, 0x48D0C6C7L, 0x4593E01EL, 0x4152FDA9L,
+	0x5F15ADACL, 0x5BD4B01BL, 0x569796C2L, 0x52568B75L,
+	0x6A1936C8L, 0x6ED82B7FL, 0x639B0DA6L, 0x675A1011L,
+	0x791D4014L, 0x7DDC5DA3L, 0x709F7B7AL, 0x745E66CDL,
+	0x9823B6E0L, 0x9CE2AB57L, 0x91A18D8EL, 0x95609039L,
+	0x8B27C03CL, 0x8FE6DD8BL, 0x82A5FB52L, 0x8664E6E5L,
+	0xBE2B5B58L, 0xBAEA46EFL, 0xB7A96036L, 0xB3687D81L,
+	0xAD2F2D84L, 0xA9EE3033L, 0xA4AD16EAL, 0xA06C0B5DL,
+	0xD4326D90L, 0xD0F37027L, 0xDDB056FEL, 0xD9714B49L,
+	0xC7361B4CL, 0xC3F706FBL, 0xCEB42022L, 0xCA753D95L,
+	0xF23A8028L, 0xF6FB9D9FL, 0xFBB8BB46L, 0xFF79A6F1L,
+	0xE13EF6F4L, 0xE5FFEB43L, 0xE8BCCD9AL, 0xEC7DD02DL,
+	0x34867077L, 0x30476DC0L, 0x3D044B19L, 0x39C556AEL,
+	0x278206ABL, 0x23431B1CL, 0x2E003DC5L, 0x2AC12072L,
+	0x128E9DCFL, 0x164F8078L, 0x1B0CA6A1L, 0x1FCDBB16L,
+	0x018AEB13L, 0x054BF6A4L, 0x0808D07DL, 0x0CC9CDCAL,
+	0x7897AB07L, 0x7C56B6B0L, 0x71159069L, 0x75D48DDEL,
+	0x6B93DDDBL, 0x6F52C06CL, 0x6211E6B5L, 0x66D0FB02L,
+	0x5E9F46BFL, 0x5A5E5B08L, 0x571D7DD1L, 0x53DC6066L,
+	0x4D9B3063L, 0x495A2DD4L, 0x44190B0DL, 0x40D816BAL,
+	0xACA5C697L, 0xA864DB20L, 0xA527FDF9L, 0xA1E6E04EL,
+	0xBFA1B04BL, 0xBB60ADFCL, 0xB6238B25L, 0xB2E29692L,
+	0x8AAD2B2FL, 0x8E6C3698L, 0x832F1041L, 0x87EE0DF6L,
+	0x99A95DF3L, 0x9D684044L, 0x902B669DL, 0x94EA7B2AL,
+	0xE0B41DE7L, 0xE4750050L, 0xE9362689L, 0xEDF73B3EL,
+	0xF3B06B3BL, 0xF771768CL, 0xFA325055L, 0xFEF34DE2L,
+	0xC6BCF05FL, 0xC27DEDE8L, 0xCF3ECB31L, 0xCBFFD686L,
+	0xD5B88683L, 0xD1799B34L, 0xDC3ABDEDL, 0xD8FBA05AL,
+	0x690CE0EEL, 0x6DCDFD59L, 0x608EDB80L, 0x644FC637L,
+	0x7A089632L, 0x7EC98B85L, 0x738AAD5CL, 0x774BB0EBL,
+	0x4F040D56L, 0x4BC510E1L, 0x46863638L, 0x42472B8FL,
+	0x5C007B8AL, 0x58C1663DL, 0x558240E4L, 0x51435D53L,
+	0x251D3B9EL, 0x21DC2629L, 0x2C9F00F0L, 0x285E1D47L,
+	0x36194D42L, 0x32D850F5L, 0x3F9B762CL, 0x3B5A6B9BL,
+	0x0315D626L, 0x07D4CB91L, 0x0A97ED48L, 0x0E56F0FFL,
+	0x1011A0FAL, 0x14D0BD4DL, 0x19939B94L, 0x1D528623L,
+	0xF12F560EL, 0xF5EE4BB9L, 0xF8AD6D60L, 0xFC6C70D7L,
+	0xE22B20D2L, 0xE6EA3D65L, 0xEBA91BBCL, 0xEF68060BL,
+	0xD727BBB6L, 0xD3E6A601L, 0xDEA580D8L, 0xDA649D6FL,
+	0xC423CD6AL, 0xC0E2D0DDL, 0xCDA1F604L, 0xC960EBB3L,
+	0xBD3E8D7EL, 0xB9FF90C9L, 0xB4BCB610L, 0xB07DABA7L,
+	0xAE3AFBA2L, 0xAAFBE615L, 0xA7B8C0CCL, 0xA379DD7BL,
+	0x9B3660C6L, 0x9FF77D71L, 0x92B45BA8L, 0x9675461FL,
+	0x8832161AL, 0x8CF30BADL, 0x81B02D74L, 0x857130C3L,
+	0x5D8A9099L, 0x594B8D2EL, 0x5408ABF7L, 0x50C9B640L,
+	0x4E8EE645L, 0x4A4FFBF2L, 0x470CDD2BL, 0x43CDC09CL,
+	0x7B827D21L, 0x7F436096L, 0x7200464FL, 0x76C15BF8L,
+	0x68860BFDL, 0x6C47164AL, 0x61043093L, 0x65C52D24L,
+	0x119B4BE9L, 0x155A565EL, 0x18197087L, 0x1CD86D30L,
+	0x029F3D35L, 0x065E2082L, 0x0B1D065BL, 0x0FDC1BECL,
+	0x3793A651L, 0x3352BBE6L, 0x3E119D3FL, 0x3AD08088L,
+	0x2497D08DL, 0x2056CD3AL, 0x2D15EBE3L, 0x29D4F654L,
+	0xC5A92679L, 0xC1683BCEL, 0xCC2B1D17L, 0xC8EA00A0L,
+	0xD6AD50A5L, 0xD26C4D12L, 0xDF2F6BCBL, 0xDBEE767CL,
+	0xE3A1CBC1L, 0xE760D676L, 0xEA23F0AFL, 0xEEE2ED18L,
+	0xF0A5BD1DL, 0xF464A0AAL, 0xF9278673L, 0xFDE69BC4L,
+	0x89B8FD09L, 0x8D79E0BEL, 0x803AC667L, 0x84FBDBD0L,
+	0x9ABC8BD5L, 0x9E7D9662L, 0x933EB0BBL, 0x97FFAD0CL,
+	0xAFB010B1L, 0xAB710D06L, 0xA6322BDFL, 0xA2F33668L,
+	0xBCB4666DL, 0xB8757BDAL, 0xB5365D03L, 0xB1F740B4L
+};
+
+#ifdef CRCASM
+
+unsigned long spdcrc32 (char *mem, int len, unsigned initial)
+{
+	unsigned crc, dummy_len;
+      __asm__ ("xorl %%eax,%%eax\n\t" "1:\n\t" "movl %%edx,%%eax\n\t" "shrl $16,%%eax\n\t" "lodsb\n\t" "xorb %%ah,%%al\n\t" "andl $255,%%eax\n\t" "shll $8,%%edx\n\t" "xorl (%%edi,%%eax,4),%%edx\n\t" "loop 1b":"=d" (crc),
+		 "=c"
+		 (dummy_len)
+      :	 "S" (mem), "D" (&crc32tab[0]), "1" (len), "0" (initial)
+      :	 "eax");
+	return crc;
+}
+
+#else
+
+#define CRC32(c,crc) (crc32tab[((size_t)(crc>>24) ^ (c)) & 0xff] ^ (((crc) << 8)))
+
+unsigned long spdcrc32 (char *mem, int len, unsigned initial)
+{
+	unsigned crc;
+	crc = initial;
+
+	for (; len; mem++, len--) {
+		crc = CRC32 (*mem, crc);
+	}
+	return (crc);
+}
+#endif
diff -Nru a/drivers/usb/speedcrc.h b/drivers/usb/speedcrc.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/usb/speedcrc.h	Fri Apr  4 15:32:22 2003
@@ -0,0 +1,28 @@
+#ifndef _SPEEDCRC_H_
+#define _SPEEDCRC_H_
+
+/******************************************************************************
+ *  speedcrc.h  --  CRC library for use with speedtouch.
+ *
+ *  Copyright (C) 2000, Johan Verrept
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ *  more details.
+ *
+ *  You should have received a copy of the GNU General Public License along with
+ *  this program; if not, write to the Free Software Foundation, Inc., 59
+ *  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ ******************************************************************************/
+
+unsigned long spdcrc32 (char *mem, int len, unsigned initial);
+#define crc32_be(crc, mem, len) spdcrc32(mem, len, crc);
+
+#endif				/* _SPEEDCRC_H_ */
diff -Nru a/drivers/usb/speedtouch.c b/drivers/usb/speedtouch.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/usb/speedtouch.c	Fri Apr  4 15:32:22 2003
@@ -0,0 +1,1412 @@
+/******************************************************************************
+ *  speedtouch.c  --  Alcatel SpeedTouch USB xDSL modem driver.
+ *
+ *  Copyright (C) 2001, Alcatel
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ *  more details.
+ *
+ *  You should have received a copy of the GNU General Public License along with
+ *  this program; if not, write to the Free Software Foundation, Inc., 59
+ *  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ ******************************************************************************/
+
+/*
+ *  Written by Johan Verrept (Johan.Verrept@advalvas.be)
+ *
+ *  1.5A:	- Backport of version for inclusion in 2.5 series kernel
+ *		- Modifications by Richard Purdie (rpurdie@rpsys.net)
+ *		- made compatible with kernel 2.5.6 onwards by changing
+ *		udsl_usb_send_data_context->urb to a pointer and adding code
+ *		to alloc and free it
+ *		- remove_wait_queue() added to udsl_atm_processqueue_thread()
+ *
+ *  1.5:	- fixed memory leak when atmsar_decode_aal5 returned NULL.
+ *		(reported by stephen.robinson@zen.co.uk)
+ *
+ *  1.4:	- changed the spin_lock() under interrupt to spin_lock_irqsave()
+ *		- unlink all active send urbs of a vcc that is being closed.
+ *
+ *  1.3.1:	- added the version number
+ *
+ *  1.3:	- Added multiple send urb support
+ *		- fixed memory leak and vcc->tx_inuse starvation bug
+ *		  when not enough memory left in vcc.
+ *
+ *  1.2:	- Fixed race condition in udsl_usb_send_data()
+ *  1.1:	- Turned off packet debugging
+ *
+ */
+
+#include <asm/semaphore.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/errno.h>
+#include <linux/proc_fs.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <asm/uaccess.h>
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/atm.h>
+#include <linux/atmdev.h>
+#include "speedcrc.h"
+
+/*
+#define DEBUG 1
+#define DEBUG_PACKET 1
+*/
+
+#include <linux/usb.h>
+
+
+#ifdef DEBUG_PACKET
+static int udsl_print_packet (const unsigned char *data, int len);
+#define PACKETDEBUG(arg...) udsl_print_packet (arg)
+#else
+#define PACKETDEBUG(arg...)
+#endif
+
+#define DRIVER_AUTHOR	"Johan Verrept, Johan.Verrept@advalvas.be"
+#define DRIVER_DESC	"Driver for the Alcatel SpeedTouch USB ADSL modem"
+#define DRIVER_VERSION	"1.5A"
+
+#define SPEEDTOUCH_VENDORID		0x06b9
+#define SPEEDTOUCH_PRODUCTID		0x4061
+
+#define UDSL_NUMBER_RCV_URBS		1
+#define UDSL_NUMBER_SND_URBS		1
+#define UDSL_NUMBER_SND_BUFS		(2*UDSL_NUMBER_SND_URBS)
+#define UDSL_RCV_BUFFER_SIZE		(1*64) /* ATM cells */
+#define UDSL_SND_BUFFER_SIZE		(1*64) /* ATM cells */
+/* max should be (1500 IP mtu + 2 ppp bytes + 32 * 5 cellheader overhead) for
+ * PPPoA and (1500 + 14 + 32*5 cellheader overhead) for PPPoE */
+#define UDSL_MAX_AAL5_MRU		2048
+
+#define UDSL_IOCTL_START		1
+#define UDSL_IOCTL_STOP			2
+
+/* endpoint declarations */
+
+#define UDSL_ENDPOINT_DATA_OUT		0x07
+#define UDSL_ENDPOINT_DATA_IN		0x87
+
+#define ATM_CELL_HEADER			(ATM_CELL_SIZE - ATM_CELL_PAYLOAD)
+
+#define hex2int(c) ( (c >= '0')&&(c <= '9') ?  (c - '0') : ((c & 0xf)+9) )
+
+/* usb_device_id struct */
+
+static struct usb_device_id udsl_usb_ids [] = {
+	{ USB_DEVICE (SPEEDTOUCH_VENDORID, SPEEDTOUCH_PRODUCTID) },
+	{ }			/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE (usb, udsl_usb_ids);
+
+/* context declarations */
+
+struct udsl_receiver {
+	struct list_head list;
+	struct sk_buff *skb;
+	struct urb *urb;
+	struct udsl_instance_data *instance;
+};
+
+struct udsl_send_buffer {
+	struct list_head list;
+	unsigned char *base;
+	unsigned char *free_start;
+	unsigned int free_cells;
+};
+
+struct udsl_sender {
+	struct list_head list;
+	struct udsl_send_buffer *buffer;
+	struct urb *urb;
+	struct udsl_instance_data *instance;
+};
+
+struct udsl_control {
+	struct atm_skb_data atm_data;
+	unsigned int num_cells;
+	unsigned int num_entire;
+	unsigned char cell_header [ATM_CELL_HEADER];
+	unsigned int pdu_padding;
+	unsigned char aal5_trailer [ATM_AAL5_TRAILER];
+};
+
+#define UDSL_SKB(x)		((struct udsl_control *)(x)->cb)
+
+struct udsl_vcc_data {
+	/* vpi/vci lookup */
+	struct list_head list;
+	short vpi;
+	int vci;
+	struct atm_vcc *vcc;
+
+	/* raw cell reassembly */
+	unsigned short mtu;
+	struct sk_buff *reasBuffer;
+};
+
+/*
+ * UDSL main driver data
+ */
+
+struct udsl_instance_data {
+	struct semaphore serialize;
+
+	/* usb device part */
+	struct usb_device *usb_dev;
+	char description [64];
+	int firmware_loaded;
+
+	/* atm device part */
+	struct atm_dev *atm_dev;
+	struct list_head vcc_list;
+
+	/* receiving */
+	struct udsl_receiver all_receivers [UDSL_NUMBER_RCV_URBS];
+
+	spinlock_t spare_receivers_lock;
+	struct list_head spare_receivers;
+
+	spinlock_t completed_receivers_lock;
+	struct list_head completed_receivers;
+
+	struct tasklet_struct receive_tasklet;
+
+	/* sending */
+	struct udsl_sender all_senders [UDSL_NUMBER_SND_URBS];
+	struct udsl_send_buffer all_buffers [UDSL_NUMBER_SND_BUFS];
+
+	struct sk_buff_head sndqueue;
+
+	spinlock_t send_lock;
+	struct list_head spare_senders;
+	struct list_head spare_buffers;
+
+	struct tasklet_struct send_tasklet;
+	struct sk_buff *current_skb;			/* being emptied */
+	struct udsl_send_buffer *current_buffer;	/* being filled */
+	struct list_head filled_buffers;
+};
+
+static const char udsl_driver_name [] = "speedtch";
+
+/*
+ * atm driver prototypes and structures
+ */
+
+static void udsl_atm_dev_close (struct atm_dev *dev);
+static int udsl_atm_open (struct atm_vcc *vcc, short vpi, int vci);
+static void udsl_atm_close (struct atm_vcc *vcc);
+static int udsl_atm_ioctl (struct atm_dev *dev, unsigned int cmd, void *arg);
+static int udsl_atm_send (struct atm_vcc *vcc, struct sk_buff *skb);
+static int udsl_atm_proc_read (struct atm_dev *atm_dev, loff_t *pos, char *page);
+
+static struct atmdev_ops udsl_atm_devops = {
+	dev_close:udsl_atm_dev_close,
+	open:udsl_atm_open,
+	close:udsl_atm_close,
+	ioctl:udsl_atm_ioctl,
+	send:udsl_atm_send,
+	proc_read:udsl_atm_proc_read,
+};
+
+/*
+ * usb driver prototypes and structures
+ */
+static void *udsl_usb_probe (struct usb_device *dev, unsigned int ifnum,
+			    const struct usb_device_id *id);
+static void udsl_usb_disconnect (struct usb_device *dev, void *ptr);
+static int udsl_usb_ioctl (struct usb_device *hub, unsigned int code, void *user_data);
+
+static struct usb_driver udsl_usb_driver = {
+	name:udsl_driver_name,
+	probe:udsl_usb_probe,
+	disconnect:udsl_usb_disconnect,
+	ioctl:udsl_usb_ioctl,
+	id_table:udsl_usb_ids,
+};
+
+
+/*************
+**  decode  **
+*************/
+
+static inline struct udsl_vcc_data *udsl_find_vcc (struct udsl_instance_data *instance, short vpi, int vci)
+{
+	struct udsl_vcc_data *vcc;
+
+	list_for_each_entry (vcc, &instance->vcc_list, list)
+		if ((vcc->vpi == vpi) && (vcc->vci == vci))
+			return vcc;
+	return NULL;
+}
+
+static struct sk_buff *udsl_decode_rawcell (struct udsl_instance_data *instance, struct sk_buff *skb, struct udsl_vcc_data **ctx)
+{
+	if (!instance || !skb || !ctx)
+		return NULL;
+	if (!skb->data || !skb->tail)
+		return NULL;
+
+	while (skb->len) {
+		unsigned char *cell = skb->data;
+		unsigned char *cell_payload;
+		struct udsl_vcc_data *vcc;
+		short vpi;
+		int vci;
+
+		vpi = ((cell[0] & 0x0f) << 4) | (cell[1] >> 4);
+		vci = ((cell[1] & 0x0f) << 12) | (cell[2] << 4) | (cell[3] >> 4);
+
+		dbg ("udsl_decode_rawcell (0x%p, 0x%p, 0x%p) called", instance, skb, ctx);
+		dbg ("udsl_decode_rawcell skb->data %p, skb->tail %p", skb->data, skb->tail);
+
+		/* here should the header CRC check be... */
+
+		if (!(vcc = udsl_find_vcc (instance, vpi, vci)))
+			dbg ("udsl_decode_rawcell: no vcc found for packet on vpi %d, vci %d", vpi, vci);
+		else {
+			dbg ("udsl_decode_rawcell found vcc %p for packet on vpi %d, vci %d", vcc, vpi, vci);
+
+			if (skb->len >= 53) {
+				cell_payload = cell + 5;
+
+				if (!vcc->reasBuffer)
+					vcc->reasBuffer = dev_alloc_skb (vcc->mtu);
+
+				/* if alloc fails, we just drop the cell. it is possible that we can still
+				 * receive cells on other vcc's
+				 */
+				if (vcc->reasBuffer) {
+					/* if (buffer overrun) discard received cells until now */
+					if ((vcc->reasBuffer->len) > (vcc->mtu - 48))
+						skb_trim (vcc->reasBuffer, 0);
+
+					/* copy data */
+					memcpy (vcc->reasBuffer->tail, cell_payload, 48);
+					skb_put (vcc->reasBuffer, 48);
+
+					/* check for end of buffer */
+					if (cell[3] & 0x2) {
+						struct sk_buff *tmp;
+
+						/* the aal5 buffer ends here, cut the buffer. */
+						/* buffer will always have at least one whole cell, so */
+						/* don't need to check return from skb_pull */
+						skb_pull (skb, 53);
+						*ctx = vcc;
+						tmp = vcc->reasBuffer;
+						vcc->reasBuffer = NULL;
+
+						dbg ("udsl_decode_rawcell returns ATM_AAL5 pdu 0x%p with length %d", tmp, tmp->len);
+						return tmp;
+					}
+				}
+				/* flush the cell */
+				/* buffer will always contain at least one whole cell, so don't */
+				/* need to check return value from skb_pull */
+				skb_pull (skb, 53);
+			} else {
+				/* If data is corrupt and skb doesn't hold a whole cell, flush the lot */
+				if (skb_pull (skb, 53) == NULL)
+					return NULL;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static struct sk_buff *udsl_decode_aal5 (struct udsl_vcc_data *ctx, struct sk_buff *skb)
+{
+	uint crc = 0xffffffff;
+	uint length, pdu_crc, pdu_length;
+
+	dbg ("udsl_decode_aal5 (0x%p, 0x%p) called", ctx, skb);
+
+	if (skb->len && (skb->len % 48))
+		return NULL;
+
+	length = (skb->tail[-6] << 8) + skb->tail[-5];
+	pdu_crc =
+	    (skb->tail[-4] << 24) + (skb->tail[-3] << 16) + (skb->tail[-2] << 8) + skb->tail[-1];
+	pdu_length = ((length + 47 + 8) / 48) * 48;
+
+	dbg ("udsl_decode_aal5: skb->len = %d, length = %d, pdu_crc = 0x%x, pdu_length = %d", skb->len, length, pdu_crc, pdu_length);
+
+	/* is skb long enough ? */
+	if (skb->len < pdu_length) {
+		if (ctx->vcc->stats)
+			atomic_inc (&ctx->vcc->stats->rx_err);
+		return NULL;
+	}
+
+	/* is skb too long ? */
+	if (skb->len > pdu_length) {
+		dbg ("udsl_decode_aal5: Warning: readjusting illegal size %d -> %d", skb->len, pdu_length);
+		/* buffer is too long. we can try to recover
+		 * if we discard the first part of the skb.
+		 * the crc will decide whether this was ok
+		 */
+		skb_pull (skb, skb->len - pdu_length);
+	}
+
+	crc = ~crc32_be (crc, skb->data, pdu_length - 4);
+
+	/* check crc */
+	if (pdu_crc != crc) {
+		dbg ("udsl_decode_aal5: crc check failed!");
+		if (ctx->vcc->stats)
+			atomic_inc (&ctx->vcc->stats->rx_err);
+		return NULL;
+	}
+
+	/* pdu is ok */
+	skb_trim (skb, length);
+
+	/* update stats */
+	if (ctx->vcc->stats)
+		atomic_inc (&ctx->vcc->stats->rx);
+
+	dbg ("udsl_decode_aal5 returns pdu 0x%p with length %d", skb, skb->len);
+	return skb;
+}
+
+
+/*************
+**  encode  **
+*************/
+
+static void udsl_groom_skb (struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	struct udsl_control *ctrl = UDSL_SKB (skb);
+	unsigned int i, zero_padding;
+	unsigned char zero = 0;
+	u32 crc;
+
+	ctrl->atm_data.vcc = vcc;
+	ctrl->cell_header [0] = vcc->vpi >> 4;
+	ctrl->cell_header [1] = (vcc->vpi << 4) | (vcc->vci >> 12);
+	ctrl->cell_header [2] = vcc->vci >> 4;
+	ctrl->cell_header [3] = vcc->vci << 4;
+	ctrl->cell_header [4] = 0xec;
+
+	ctrl->num_cells = (skb->len + ATM_AAL5_TRAILER + ATM_CELL_PAYLOAD - 1) / ATM_CELL_PAYLOAD;
+	ctrl->num_entire = skb->len / ATM_CELL_PAYLOAD;
+
+	zero_padding = ctrl->num_cells * ATM_CELL_PAYLOAD - skb->len - ATM_AAL5_TRAILER;
+
+	if (ctrl->num_entire + 1 < ctrl->num_cells)
+		ctrl->pdu_padding = zero_padding - (ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER);
+	else
+		ctrl->pdu_padding = zero_padding;
+
+	ctrl->aal5_trailer [0] = 0; /* UU = 0 */
+	ctrl->aal5_trailer [1] = 0; /* CPI = 0 */
+	ctrl->aal5_trailer [2] = skb->len >> 8;
+	ctrl->aal5_trailer [3] = skb->len;
+
+	crc = crc32_be (~0, skb->data, skb->len);
+	for (i = 0; i < zero_padding; i++)
+		crc = crc32_be (crc, &zero, 1);
+	crc = crc32_be (crc, ctrl->aal5_trailer, 4);
+	crc = ~crc;
+
+	ctrl->aal5_trailer [4] = crc >> 24;
+	ctrl->aal5_trailer [5] = crc >> 16;
+	ctrl->aal5_trailer [6] = crc >> 8;
+	ctrl->aal5_trailer [7] = crc;
+}
+
+static unsigned int udsl_write_cells (unsigned int howmany, struct sk_buff *skb, unsigned char **target_p)
+{
+	struct udsl_control *ctrl = UDSL_SKB (skb);
+	unsigned char *target = *target_p;
+	unsigned int nc, ne, i;
+
+	dbg ("udsl_write_cells: howmany=%u, skb->len=%d, num_cells=%u, num_entire=%u, pdu_padding=%u", howmany, skb->len, ctrl->num_cells, ctrl->num_entire, ctrl->pdu_padding);
+
+	nc = ctrl->num_cells;
+	ne = min (howmany, ctrl->num_entire);
+
+	for (i = 0; i < ne; i++) {
+		memcpy (target, ctrl->cell_header, ATM_CELL_HEADER);
+		target += ATM_CELL_HEADER;
+		memcpy (target, skb->data, ATM_CELL_PAYLOAD);
+		target += ATM_CELL_PAYLOAD;
+		__skb_pull (skb, ATM_CELL_PAYLOAD);
+	}
+
+	ctrl->num_entire -= ne;
+
+	if (!(ctrl->num_cells -= ne) || !(howmany -= ne))
+		goto out;
+
+	memcpy (target, ctrl->cell_header, ATM_CELL_HEADER);
+	target += ATM_CELL_HEADER;
+	memcpy (target, skb->data, skb->len);
+	target += skb->len;
+	__skb_pull (skb, skb->len);
+	memset (target, 0, ctrl->pdu_padding);
+	target += ctrl->pdu_padding;
+
+	if (--ctrl->num_cells) {
+		if (!--howmany) {
+			ctrl->pdu_padding = ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER;
+			goto out;
+		}
+
+		memcpy (target, ctrl->cell_header, ATM_CELL_HEADER);
+		target += ATM_CELL_HEADER;
+		memset (target, 0, ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER);
+		target += ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER;
+
+		if (--ctrl->num_cells)
+			BUG();
+	}
+
+	memcpy (target, ctrl->aal5_trailer, ATM_AAL5_TRAILER);
+	target += ATM_AAL5_TRAILER;
+	/* set pti bit in last cell */
+	*(target + 3 - ATM_CELL_SIZE) |= 0x2;
+
+out:
+	*target_p = target;
+	return nc - ctrl->num_cells;
+}
+
+
+/**************
+**  receive  **
+**************/
+
+static void udsl_complete_receive (struct urb *urb)
+{
+	struct udsl_instance_data *instance;
+	struct udsl_receiver *rcv;
+	unsigned long flags;
+
+	if (!urb || !(rcv = urb->context) || !(instance = rcv->instance)) {
+		dbg ("udsl_complete_receive: bad urb!");
+		return;
+	}
+
+	dbg ("udsl_complete_receive entered (urb 0x%p, status %d)", urb, urb->status);
+
+	/* may not be in_interrupt() */
+	spin_lock_irqsave (&instance->completed_receivers_lock, flags);
+	list_add_tail (&rcv->list, &instance->completed_receivers);
+	tasklet_schedule (&instance->receive_tasklet);
+	spin_unlock_irqrestore (&instance->completed_receivers_lock, flags);
+}
+
+static void udsl_process_receive (unsigned long data)
+{
+	struct udsl_instance_data *instance = (struct udsl_instance_data *) data;
+	struct udsl_receiver *rcv;
+	unsigned long flags;
+	unsigned char *data_start;
+	struct sk_buff *skb;
+	struct urb *urb;
+	struct udsl_vcc_data *atmsar_vcc = NULL;
+	struct sk_buff *new = NULL, *tmp = NULL;
+	int err;
+
+	dbg ("udsl_process_receive entered");
+
+	spin_lock_irqsave (&instance->completed_receivers_lock, flags);
+	while (!list_empty (&instance->completed_receivers)) {
+		rcv = list_entry (instance->completed_receivers.next, struct udsl_receiver, list);
+		list_del (&rcv->list);
+		spin_unlock_irqrestore (&instance->completed_receivers_lock, flags);
+
+		urb = rcv->urb;
+		dbg ("udsl_process_receive: got packet %p with length %d and status %d", urb, urb->actual_length, urb->status);
+
+		switch (urb->status) {
+		case 0:
+			dbg ("udsl_process_receive: processing urb with rcv %p, urb %p, skb %p", rcv, urb, rcv->skb);
+
+			/* update the skb structure */
+			skb = rcv->skb;
+			skb_trim (skb, 0);
+			skb_put (skb, urb->actual_length);
+			data_start = skb->data;
+
+			dbg ("skb->len = %d", skb->len);
+			PACKETDEBUG (skb->data, skb->len);
+
+			while ((new = udsl_decode_rawcell (instance, skb, &atmsar_vcc))) {
+				dbg ("(after cell processing)skb->len = %d", new->len);
+
+				tmp = new;
+				new = udsl_decode_aal5 (atmsar_vcc, new);
+
+				/* we can't send NULL skbs upstream, the ATM layer would try to close the vcc... */
+				if (new) {
+					dbg ("(after aal5 decap) skb->len = %d", new->len);
+					if (new->len && atm_charge (atmsar_vcc->vcc, new->truesize)) {
+						PACKETDEBUG (new->data, new->len);
+						atmsar_vcc->vcc->push (atmsar_vcc->vcc, new);
+					} else {
+						dbg
+						    ("dropping incoming packet : rx_inuse = %d, vcc->sk->rcvbuf = %d, skb->true_size = %d",
+						     atomic_read (&atmsar_vcc->vcc->rx_inuse),
+						     atmsar_vcc->vcc->sk->rcvbuf, new->truesize);
+						dev_kfree_skb (new);
+					}
+				} else {
+					dbg ("udsl_decode_aal5 returned NULL!");
+					dev_kfree_skb (tmp);
+				}
+			}
+
+			/* restore skb */
+			skb_push (skb, skb->data - data_start);
+
+			FILL_BULK_URB (urb,
+				       instance->usb_dev,
+				       usb_rcvbulkpipe (instance->usb_dev, UDSL_ENDPOINT_DATA_IN),
+				       (unsigned char *) rcv->skb->data,
+				       UDSL_RCV_BUFFER_SIZE * ATM_CELL_SIZE,
+				       udsl_complete_receive,
+				       rcv);
+			urb->transfer_flags |= USB_QUEUE_BULK;
+			if (!(err = usb_submit_urb (urb)))
+				break;
+			dbg ("udsl_process_receive: submission failed (%d)", err);
+			/* fall through */
+		default: /* error or urb unlinked */
+			dbg ("udsl_process_receive: adding to spare_receivers");
+			spin_lock_irqsave (&instance->spare_receivers_lock, flags);
+			list_add (&rcv->list, &instance->spare_receivers);
+			spin_unlock_irqrestore (&instance->spare_receivers_lock, flags);
+			break;
+		} /* switch */
+
+		spin_lock_irqsave (&instance->completed_receivers_lock, flags);
+	} /* while */
+	spin_unlock_irqrestore (&instance->completed_receivers_lock, flags);
+	dbg ("udsl_process_receive successful");
+}
+
+static void udsl_fire_receivers (struct udsl_instance_data *instance)
+{
+	struct list_head receivers, *pos, *n;
+	unsigned long flags;
+
+	INIT_LIST_HEAD (&receivers);
+
+	down (&instance->serialize);
+
+	spin_lock_irqsave (&instance->spare_receivers_lock, flags);
+	list_splice_init (&instance->spare_receivers, &receivers);
+	spin_unlock_irqrestore (&instance->spare_receivers_lock, flags);
+
+	list_for_each_safe (pos, n, &receivers) {
+		struct udsl_receiver *rcv = list_entry (pos, struct udsl_receiver, list);
+
+		dbg ("udsl_fire_receivers: firing urb %p", rcv->urb);
+
+		FILL_BULK_URB (rcv->urb,
+			       instance->usb_dev,
+			       usb_rcvbulkpipe (instance->usb_dev, UDSL_ENDPOINT_DATA_IN),
+			       (unsigned char *) rcv->skb->data,
+			       UDSL_RCV_BUFFER_SIZE * ATM_CELL_SIZE,
+			       udsl_complete_receive,
+			       rcv);
+		rcv->urb->transfer_flags |= USB_QUEUE_BULK;
+
+		if (usb_submit_urb (rcv->urb) < 0) {
+			dbg ("udsl_fire_receivers: submit failed!");
+			spin_lock_irqsave (&instance->spare_receivers_lock, flags);
+			list_move (pos, &instance->spare_receivers);
+			spin_unlock_irqrestore (&instance->spare_receivers_lock, flags);
+		}
+	}
+
+	up (&instance->serialize);
+}
+
+
+/***********
+**  send  **
+***********/
+
+static void udsl_complete_send (struct urb *urb)
+{
+	struct udsl_instance_data *instance;
+	struct udsl_sender *snd;
+	unsigned long flags;
+
+	if (!urb || !(snd = urb->context) || !(instance = snd->instance)) {
+		dbg ("udsl_complete_send: bad urb!");
+		return;
+	}
+
+	dbg ("udsl_complete_send entered (urb 0x%p, status %d)", urb, urb->status);
+
+	/* may not be in_interrupt() */
+	spin_lock_irqsave (&instance->send_lock, flags);
+	list_add (&snd->list, &instance->spare_senders);
+	list_add (&snd->buffer->list, &instance->spare_buffers);
+	tasklet_schedule (&instance->send_tasklet);
+	spin_unlock_irqrestore (&instance->send_lock, flags);
+}
+
+static void udsl_process_send (unsigned long data)
+{
+	struct udsl_send_buffer *buf;
+	int err;
+	unsigned long flags;
+	struct udsl_instance_data *instance = (struct udsl_instance_data *) data;
+	unsigned int num_written;
+	struct sk_buff *skb;
+	struct udsl_sender *snd;
+
+	dbg ("udsl_process_send entered");
+
+made_progress:
+	spin_lock_irqsave (&instance->send_lock, flags);
+	while (!list_empty (&instance->spare_senders)) {
+		if (!list_empty (&instance->filled_buffers)) {
+			buf = list_entry (instance->filled_buffers.next, struct udsl_send_buffer, list);
+			list_del (&buf->list);
+			dbg ("sending filled buffer (0x%p)", buf);
+		} else if ((buf = instance->current_buffer)) {
+			instance->current_buffer = NULL;
+			dbg ("sending current buffer (0x%p)", buf);
+		} else /* all buffers empty */
+			break;
+
+		snd = list_entry (instance->spare_senders.next, struct udsl_sender, list);
+		list_del (&snd->list);
+		spin_unlock_irqrestore (&instance->send_lock, flags);
+
+		snd->buffer = buf;
+	        FILL_BULK_URB (snd->urb,
+			       instance->usb_dev,
+			       usb_sndbulkpipe (instance->usb_dev, UDSL_ENDPOINT_DATA_OUT),
+			       buf->base,
+			       (UDSL_SND_BUFFER_SIZE - buf->free_cells) * ATM_CELL_SIZE,
+			       udsl_complete_send,
+			       snd);
+		snd->urb->transfer_flags |= USB_QUEUE_BULK;
+
+		dbg ("submitting urb 0x%p, contains %d cells", snd->urb, UDSL_SND_BUFFER_SIZE - buf->free_cells);
+
+		if ((err = usb_submit_urb(snd->urb)) < 0) {
+			dbg ("submission failed (%d)!", err);
+			spin_lock_irqsave (&instance->send_lock, flags);
+			list_add (&snd->list, &instance->spare_senders);
+			spin_unlock_irqrestore (&instance->send_lock, flags);
+			list_add (&buf->list, &instance->filled_buffers);
+			return;
+		}
+
+		spin_lock_irqsave (&instance->send_lock, flags);
+	} /* while */
+	spin_unlock_irqrestore (&instance->send_lock, flags);
+
+	if (!instance->current_skb && !(instance->current_skb = skb_dequeue (&instance->sndqueue))) {
+		dbg ("done - no more skbs");
+		return;
+	}
+
+	skb = instance->current_skb;
+
+	if (!(buf = instance->current_buffer)) {
+		spin_lock_irqsave (&instance->send_lock, flags);
+		if (list_empty (&instance->spare_buffers)) {
+			instance->current_buffer = NULL;
+			spin_unlock_irqrestore (&instance->send_lock, flags);
+			dbg ("done - no more buffers");
+			return;
+		}
+		buf = list_entry (instance->spare_buffers.next, struct udsl_send_buffer, list);
+		list_del (&buf->list);
+		spin_unlock_irqrestore (&instance->send_lock, flags);
+
+		buf->free_start = buf->base;
+		buf->free_cells = UDSL_SND_BUFFER_SIZE;
+
+		instance->current_buffer = buf;
+	}
+
+	num_written = udsl_write_cells (buf->free_cells, skb, &buf->free_start);
+
+	dbg ("wrote %u cells from skb 0x%p to buffer 0x%p", num_written, skb, buf);
+
+	if (!(buf->free_cells -= num_written)) {
+		list_add_tail (&buf->list, &instance->filled_buffers);
+		instance->current_buffer = NULL;
+		dbg ("queued filled buffer");
+	}
+
+	dbg ("buffer contains %d cells, %d left", UDSL_SND_BUFFER_SIZE - buf->free_cells, buf->free_cells);
+
+	if (!UDSL_SKB (skb)->num_cells) {
+		struct atm_vcc *vcc = UDSL_SKB (skb)->atm_data.vcc;
+
+		dbg ("discarding empty skb");
+		if (vcc->pop)
+			vcc->pop (vcc, skb);
+		else
+			kfree_skb (skb);
+		instance->current_skb = NULL;
+
+		if (vcc->stats)
+			atomic_inc (&vcc->stats->tx);
+	}
+
+	goto made_progress;
+}
+
+static void udsl_cancel_send (struct udsl_instance_data *instance, struct atm_vcc *vcc)
+{
+	unsigned long flags;
+	struct sk_buff *skb, *n;
+
+	dbg ("udsl_cancel_send entered");
+	spin_lock_irqsave (&instance->sndqueue.lock, flags);
+	for (skb = instance->sndqueue.next, n = skb->next; skb != (struct sk_buff *)&instance->sndqueue; skb = n, n = skb->next)
+		if (UDSL_SKB (skb)->atm_data.vcc == vcc) {
+			dbg ("popping skb 0x%p", skb);
+			__skb_unlink (skb, &instance->sndqueue);
+			if (vcc->pop)
+				vcc->pop (vcc, skb);
+			else
+				kfree_skb (skb);
+		}
+	spin_unlock_irqrestore (&instance->sndqueue.lock, flags);
+
+	tasklet_disable (&instance->send_tasklet);
+	if ((skb = instance->current_skb) && (UDSL_SKB (skb)->atm_data.vcc == vcc)) {
+		dbg ("popping current skb (0x%p)", skb);
+		instance->current_skb = NULL;
+		if (vcc->pop)
+			vcc->pop (vcc, skb);
+		else
+			kfree_skb (skb);
+	}
+	tasklet_enable (&instance->send_tasklet);
+	dbg ("udsl_cancel_send done");
+}
+
+static int udsl_atm_send (struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	struct udsl_instance_data *instance = vcc->dev->dev_data;
+
+	dbg ("udsl_atm_send called (skb 0x%p, len %u)", skb, skb->len);
+
+	if (!instance || !instance->usb_dev) {
+		dbg ("NULL data!");
+		return -ENODEV;
+	}
+
+	if (vcc->qos.aal != ATM_AAL5) {
+		dbg ("unsupported ATM type %d!", vcc->qos.aal);
+		return -EINVAL;
+	}
+
+	if (skb->len > ATM_MAX_AAL5_PDU) {
+		dbg ("packet too long (%d vs %d)!", skb->len, ATM_MAX_AAL5_PDU);
+		return -EINVAL;
+	}
+
+	PACKETDEBUG (skb->data, skb->len);
+
+	udsl_groom_skb (vcc, skb);
+	skb_queue_tail (&instance->sndqueue, skb);
+	tasklet_schedule (&instance->send_tasklet);
+
+	return 0;
+}
+
+
+/**********
+**  ATM  **
+**********/
+
+static void udsl_atm_dev_close (struct atm_dev *dev)
+{
+	struct udsl_instance_data *instance = dev->dev_data;
+
+	if (!instance) {
+		dbg ("udsl_atm_dev_close: NULL instance!");
+		return;
+	}
+
+	dbg ("udsl_atm_dev_close: queue has %u elements", instance->sndqueue.qlen);
+
+	dbg ("udsl_atm_dev_close: killing tasklet");
+	tasklet_kill (&instance->send_tasklet);
+	dbg ("udsl_atm_dev_close: freeing instance");
+	kfree (instance);
+	dev->dev_data = NULL;
+}
+
+static int udsl_atm_proc_read (struct atm_dev *atm_dev, loff_t *pos, char *page)
+{
+	struct udsl_instance_data *instance = atm_dev->dev_data;
+	int left = *pos;
+
+	if (!instance) {
+		dbg ("NULL instance!");
+		return -ENODEV;
+	}
+
+	if (!left--)
+		return sprintf (page, "%s\n", instance->description);
+
+	if (!left--)
+		return sprintf (page, "MAC: %02x:%02x:%02x:%02x:%02x:%02x\n",
+				atm_dev->esi[0], atm_dev->esi[1], atm_dev->esi[2],
+				atm_dev->esi[3], atm_dev->esi[4], atm_dev->esi[5]);
+
+	if (!left--)
+		return sprintf (page, "AAL5: tx %d ( %d err ), rx %d ( %d err, %d drop )\n",
+				atomic_read (&atm_dev->stats.aal5.tx),
+				atomic_read (&atm_dev->stats.aal5.tx_err),
+				atomic_read (&atm_dev->stats.aal5.rx),
+				atomic_read (&atm_dev->stats.aal5.rx_err),
+				atomic_read (&atm_dev->stats.aal5.rx_drop));
+
+	if (!left--) {
+		switch (atm_dev->signal) {
+		case ATM_PHY_SIG_FOUND:
+			sprintf (page, "Line up");
+			break;
+		case ATM_PHY_SIG_LOST:
+			sprintf (page, "Line down");
+			break;
+		default:
+			sprintf (page, "Line state unknown");
+			break;
+		}
+
+		if (instance->usb_dev) {
+			if (!instance->firmware_loaded)
+				strcat (page, ", no firmware\n");
+			else
+				strcat (page, ", firmware loaded\n");
+		} else
+			strcat (page, ", disconnected\n");
+
+		return strlen (page);
+	}
+
+	return 0;
+}
+
+static int udsl_atm_open (struct atm_vcc *vcc, short vpi, int vci)
+{
+	struct udsl_instance_data *instance = vcc->dev->dev_data;
+	struct udsl_vcc_data *new;
+
+	dbg ("udsl_atm_open called");
+
+	if (!instance || !instance->usb_dev) {
+		dbg ("NULL data!");
+		return -ENODEV;
+	}
+
+	if ((vpi == ATM_VPI_ANY) || (vci == ATM_VCI_ANY))
+		return -EINVAL;
+
+	/* only support AAL5 */
+	if (vcc->qos.aal != ATM_AAL5)
+		return -EINVAL;
+
+	if (!instance->firmware_loaded) {
+		dbg ("firmware not loaded!");
+		return -EAGAIN;
+	}
+
+	down (&instance->serialize); /* vs self, udsl_atm_close */
+
+	if (udsl_find_vcc (instance, vpi, vci)) {
+		up (&instance->serialize);
+		return -EADDRINUSE;
+	}
+
+	if (!(new = kmalloc (sizeof (struct udsl_vcc_data), GFP_KERNEL))) {
+		up (&instance->serialize);
+		return -ENOMEM;
+	}
+
+	memset (new, 0, sizeof (struct udsl_vcc_data));
+	new->vcc = vcc;
+	new->vpi = vpi;
+	new->vci = vci;
+	new->mtu = UDSL_MAX_AAL5_MRU;
+
+	vcc->dev_data = new;
+	vcc->vpi = vpi;
+	vcc->vci = vci;
+
+	tasklet_disable (&instance->receive_tasklet);
+	list_add (&new->list, &instance->vcc_list);
+	tasklet_enable (&instance->receive_tasklet);
+
+	set_bit (ATM_VF_ADDR, &vcc->flags);
+	set_bit (ATM_VF_PARTIAL, &vcc->flags);
+	set_bit (ATM_VF_READY, &vcc->flags);
+
+	up (&instance->serialize);
+
+	dbg ("Allocated new SARLib vcc 0x%p with vpi %d vci %d", new, vpi, vci);
+
+	udsl_fire_receivers (instance);
+
+	dbg ("udsl_atm_open successful");
+
+	MOD_INC_USE_COUNT;
+
+	return 0;
+}
+
+static void udsl_atm_close (struct atm_vcc *vcc)
+{
+	struct udsl_instance_data *instance = vcc->dev->dev_data;
+	struct udsl_vcc_data *vcc_data = vcc->dev_data;
+
+	dbg ("udsl_atm_close called");
+
+	if (!instance || !vcc_data) {
+		dbg ("NULL data!");
+		return;
+	}
+
+	dbg ("Deallocating SARLib vcc 0x%p with vpi %d vci %d", vcc_data, vcc_data->vpi, vcc_data->vci);
+
+	udsl_cancel_send (instance, vcc);
+
+	down (&instance->serialize); /* vs self, udsl_atm_open */
+
+	tasklet_disable (&instance->receive_tasklet);
+	list_del (&vcc_data->list);
+	tasklet_enable (&instance->receive_tasklet);
+
+	if (vcc_data->reasBuffer)
+		kfree_skb (vcc_data->reasBuffer);
+	vcc_data->reasBuffer = NULL;
+
+	kfree (vcc_data);
+	vcc->dev_data = NULL;
+
+	vcc->vpi = ATM_VPI_UNSPEC;
+	vcc->vci = ATM_VCI_UNSPEC;
+	clear_bit (ATM_VF_READY, &vcc->flags);
+	clear_bit (ATM_VF_PARTIAL, &vcc->flags);
+	clear_bit (ATM_VF_ADDR, &vcc->flags);
+
+	up (&instance->serialize);
+
+	MOD_DEC_USE_COUNT;
+
+	dbg ("udsl_atm_close successful");
+}
+
+static int udsl_atm_ioctl (struct atm_dev *dev, unsigned int cmd, void *arg)
+{
+	switch (cmd) {
+	case ATM_QUERYLOOP:
+		return put_user (ATM_LM_NONE, (int *) arg) ? -EFAULT : 0;
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+
+/**********
+**  USB  **
+**********/
+
+static int udsl_set_alternate (struct udsl_instance_data *instance)
+{
+	down (&instance->serialize); /* vs self */
+	if (!instance->firmware_loaded) {
+		int ret;
+
+		if ((ret = usb_set_interface (instance->usb_dev, 1, 1)) < 0) {
+			dbg ("usb_set_interface returned %d!", ret);
+			up (&instance->serialize);
+			return ret;
+		}
+		instance->firmware_loaded = 1;
+	}
+	up (&instance->serialize);
+	udsl_fire_receivers (instance);
+	return 0;
+}
+
+static int udsl_usb_ioctl (struct usb_device *dev, unsigned int code, void *user_data)
+{
+	struct usb_interface *intf = usb_ifnum_to_if (dev, 1);
+	struct udsl_instance_data *instance = intf->private_data;
+
+	dbg ("udsl_usb_ioctl entered");
+
+	if (!instance) {
+		dbg ("NULL instance!");
+		return -ENODEV;
+	}
+
+	switch (code) {
+	case UDSL_IOCTL_START:
+		instance->atm_dev->signal = ATM_PHY_SIG_FOUND;
+		return udsl_set_alternate (instance);
+	case UDSL_IOCTL_STOP:
+		instance->atm_dev->signal = ATM_PHY_SIG_LOST;
+		return 0;
+	default:
+		return -ENOTTY;
+	}
+}
+
+static void *udsl_usb_probe (struct usb_device *dev, unsigned int ifnum, const struct usb_device_id *id)
+{
+	struct udsl_instance_data *instance;
+	unsigned char mac_str [13];
+	int i, length;
+	char *buf;
+
+	dbg ("Trying device with Vendor=0x%x, Product=0x%x, ifnum %d",
+		dev->descriptor.idVendor, dev->descriptor.idProduct, ifnum);
+
+	if ((dev->descriptor.bDeviceClass != USB_CLASS_VENDOR_SPEC) ||
+	    (dev->descriptor.idVendor != SPEEDTOUCH_VENDORID) ||
+	    (dev->descriptor.idProduct != SPEEDTOUCH_PRODUCTID) || (ifnum != 1))
+		return NULL;
+
+	dbg ("Device Accepted");
+
+	/* instance init */
+	if (!(instance = kmalloc (sizeof (struct udsl_instance_data), GFP_KERNEL))) {
+		dbg ("No memory for Instance data!");
+		return NULL;
+	}
+
+	memset (instance, 0, sizeof (struct udsl_instance_data));
+
+	init_MUTEX (&instance->serialize);
+
+	instance->usb_dev = dev;
+
+	INIT_LIST_HEAD (&instance->vcc_list);
+
+	spin_lock_init (&instance->spare_receivers_lock);
+	INIT_LIST_HEAD (&instance->spare_receivers);
+
+	spin_lock_init (&instance->completed_receivers_lock);
+	INIT_LIST_HEAD (&instance->completed_receivers);
+
+	tasklet_init (&instance->receive_tasklet, udsl_process_receive, (unsigned long) instance);
+
+	skb_queue_head_init (&instance->sndqueue);
+
+	spin_lock_init (&instance->send_lock);
+	INIT_LIST_HEAD (&instance->spare_senders);
+	INIT_LIST_HEAD (&instance->spare_buffers);
+
+	tasklet_init (&instance->send_tasklet, udsl_process_send, (unsigned long) instance);
+	INIT_LIST_HEAD (&instance->filled_buffers);
+
+	/* receive init */
+	for (i = 0; i < UDSL_NUMBER_RCV_URBS; i++) {
+		struct udsl_receiver *rcv = &(instance->all_receivers[i]);
+
+		if (!(rcv->skb = dev_alloc_skb (UDSL_RCV_BUFFER_SIZE * ATM_CELL_SIZE))) {
+			dbg ("No memory for skb %d!", i);
+			goto fail;
+		}
+
+		if (!(rcv->urb = usb_alloc_urb (0))) {
+			dbg ("No memory for receive urb %d!", i);
+			goto fail;
+		}
+
+		rcv->instance = instance;
+
+		list_add (&rcv->list, &instance->spare_receivers);
+
+		dbg ("skb->truesize = %d (asked for %d)", rcv->skb->truesize, UDSL_RCV_BUFFER_SIZE * ATM_CELL_SIZE);
+	}
+
+	/* send init */
+	for (i = 0; i < UDSL_NUMBER_SND_URBS; i++) {
+		struct udsl_sender *snd = &(instance->all_senders[i]);
+
+		if (!(snd->urb = usb_alloc_urb (0))) {
+			dbg ("No memory for send urb %d!", i);
+			goto fail;
+		}
+
+		snd->instance = instance;
+
+		list_add (&snd->list, &instance->spare_senders);
+	}
+
+	for (i = 0; i < UDSL_NUMBER_SND_BUFS; i++) {
+		struct udsl_send_buffer *buf = &(instance->all_buffers[i]);
+
+		if (!(buf->base = kmalloc (UDSL_SND_BUFFER_SIZE * ATM_CELL_SIZE, GFP_KERNEL))) {
+			dbg ("No memory for send buffer %d!", i);
+			goto fail;
+		}
+
+		list_add (&buf->list, &instance->spare_buffers);
+	}
+
+	/* atm init */
+	if (!(instance->atm_dev = atm_dev_register (udsl_driver_name, &udsl_atm_devops, -1, 0))) {
+		dbg ("failed to register ATM device!");
+		goto fail;
+	}
+
+	instance->atm_dev->ci_range.vpi_bits = ATM_CI_MAX;
+	instance->atm_dev->ci_range.vci_bits = ATM_CI_MAX;
+	instance->atm_dev->signal = ATM_PHY_SIG_UNKNOWN;
+
+	/* tmp init atm device, set to 128kbit */
+	instance->atm_dev->link_rate = 128 * 1000 / 424;
+
+	/* set MAC address, it is stored in the serial number */
+	memset (instance->atm_dev->esi, 0, sizeof (instance->atm_dev->esi));
+	if (usb_string (dev, dev->descriptor.iSerialNumber, mac_str, sizeof (mac_str)) == 12)
+		for (i = 0; i < 6; i++)
+			instance->atm_dev->esi[i] = (hex2int (mac_str[i * 2]) * 16) + (hex2int (mac_str[i * 2 + 1]));
+
+	/* device description */
+	buf = instance->description;
+	length = sizeof (instance->description);
+
+	if ((i = usb_string (dev, dev->descriptor.iProduct, buf, length)) < 0)
+		goto finish;
+
+	buf += i;
+	length -= i;
+
+	i = snprintf (buf, length, " (");
+	buf += i;
+	length -= i;
+
+	if (length <= 0 || (i = usb_make_path (dev, buf, length)) < 0)
+		goto finish;
+
+	buf += i;
+	length -= i;
+
+	snprintf (buf, length, ")");
+
+finish:
+	/* ready for ATM callbacks */
+	instance->atm_dev->dev_data = instance;
+
+	return instance;
+
+fail:
+	for (i = 0; i < UDSL_NUMBER_SND_BUFS; i++)
+		kfree (instance->all_buffers[i].base);
+
+	for (i = 0; i < UDSL_NUMBER_SND_URBS; i++)
+		usb_free_urb (instance->all_senders[i].urb);
+
+	for (i = 0; i < UDSL_NUMBER_RCV_URBS; i++) {
+		struct udsl_receiver *rcv = &(instance->all_receivers[i]);
+
+		usb_free_urb (rcv->urb);
+
+		if (rcv->skb)
+			kfree_skb (rcv->skb);
+	}
+
+	kfree (instance);
+
+	return NULL;
+}
+
+static void udsl_usb_disconnect (struct usb_device *dev, void *ptr)
+{
+	struct udsl_instance_data *instance = ptr;
+	struct list_head *pos;
+	unsigned long flags;
+	unsigned int count = 0;
+	int result, i;
+
+	dbg ("disconnecting");
+
+	if (!instance) {
+		dbg ("NULL instance!");
+		return;
+	}
+
+	tasklet_disable (&instance->receive_tasklet);
+
+	/* receive finalize */
+	down (&instance->serialize); /* vs udsl_fire_receivers */
+	/* no need to take the spinlock */
+	list_for_each (pos, &instance->spare_receivers)
+		if (++count > UDSL_NUMBER_RCV_URBS)
+			panic (__FILE__ ": memory corruption detected at line %d!\n", __LINE__);
+	INIT_LIST_HEAD (&instance->spare_receivers);
+	up (&instance->serialize);
+
+	dbg ("udsl_usb_disconnect: flushed %u spare receivers", count);
+
+	count = UDSL_NUMBER_RCV_URBS - count;
+
+	for (i = 0; i < UDSL_NUMBER_RCV_URBS; i++)
+		if ((result = usb_unlink_urb (instance->all_receivers[i].urb)) < 0)
+			dbg ("udsl_usb_disconnect: usb_unlink_urb on receive urb %d returned %d", i, result);
+
+	/* wait for completion handlers to finish */
+	do {
+		unsigned int completed = 0;
+
+		spin_lock_irqsave (&instance->completed_receivers_lock, flags);
+		list_for_each (pos, &instance->completed_receivers)
+			if (++completed > count)
+				panic (__FILE__ ": memory corruption detected at line %d!\n", __LINE__);
+		spin_unlock_irqrestore (&instance->completed_receivers_lock, flags);
+
+		dbg ("udsl_usb_disconnect: found %u completed receivers", completed);
+
+		if (completed == count)
+			break;
+
+		yield ();
+	} while (1);
+
+	dbg ("udsl_usb_disconnect: flushing");
+	/* no need to take the spinlock */
+	INIT_LIST_HEAD (&instance->completed_receivers);
+
+	tasklet_enable (&instance->receive_tasklet);
+	tasklet_kill (&instance->receive_tasklet);
+
+	dbg ("udsl_usb_disconnect: freeing receivers");
+	for (i = 0; i < UDSL_NUMBER_RCV_URBS; i++) {
+		struct udsl_receiver *rcv = &(instance->all_receivers[i]);
+
+		usb_free_urb (rcv->urb);
+		kfree_skb (rcv->skb);
+	}
+
+	/* send finalize */
+	tasklet_disable (&instance->send_tasklet);
+
+	for (i = 0; i < UDSL_NUMBER_SND_URBS; i++)
+		if ((result = usb_unlink_urb (instance->all_senders[i].urb)) < 0)
+			dbg ("udsl_usb_disconnect: usb_unlink_urb on send urb %d returned %d", i, result);
+
+	/* wait for completion handlers to finish */
+	do {
+		count = 0;
+		spin_lock_irqsave (&instance->send_lock, flags);
+		list_for_each (pos, &instance->spare_senders)
+			if (++count > UDSL_NUMBER_SND_URBS)
+				panic (__FILE__ ": memory corruption detected at line %d!\n", __LINE__);
+		spin_unlock_irqrestore (&instance->send_lock, flags);
+
+		dbg ("udsl_usb_disconnect: found %u spare senders", count);
+
+		if (count == UDSL_NUMBER_SND_URBS)
+			break;
+
+		yield ();
+	} while (1);
+
+	dbg ("udsl_usb_disconnect: flushing");
+	/* no need to take the spinlock */
+	INIT_LIST_HEAD (&instance->spare_senders);
+	INIT_LIST_HEAD (&instance->spare_buffers);
+	instance->current_buffer = NULL;
+
+	tasklet_enable (&instance->send_tasklet);
+
+	dbg ("udsl_usb_disconnect: freeing senders");
+	for (i = 0; i < UDSL_NUMBER_SND_URBS; i++)
+		usb_free_urb (instance->all_senders[i].urb);
+
+	dbg ("udsl_usb_disconnect: freeing buffers");
+	for (i = 0; i < UDSL_NUMBER_SND_BUFS; i++)
+		kfree (instance->all_buffers[i].base);
+
+	instance->usb_dev = NULL;
+
+	/* atm finalize */
+	shutdown_atm_dev (instance->atm_dev); /* frees instance */
+}
+
+
+/***********
+**  init  **
+***********/
+
+static int __init udsl_usb_init (void)
+{
+	struct sk_buff *skb; /* dummy for sizeof */
+
+	dbg ("udsl_usb_init: driver version " DRIVER_VERSION);
+
+	if (sizeof (struct udsl_control) > sizeof (skb->cb)) {
+		printk (KERN_ERR __FILE__ ": unusable with this kernel!\n");
+		return -EIO;
+	}
+
+	return usb_register (&udsl_usb_driver);
+}
+
+static void __exit udsl_usb_cleanup (void)
+{
+	dbg ("udsl_usb_cleanup");
+
+	usb_deregister (&udsl_usb_driver);
+}
+
+module_init (udsl_usb_init);
+module_exit (udsl_usb_cleanup);
+
+MODULE_AUTHOR (DRIVER_AUTHOR);
+MODULE_DESCRIPTION (DRIVER_DESC);
+MODULE_LICENSE ("GPL");
+
+
+/************
+**  debug  **
+************/
+
+#ifdef DEBUG_PACKET
+static int udsl_print_packet (const unsigned char *data, int len)
+{
+	unsigned char buffer [256];
+	int i = 0, j = 0;
+
+	for (i = 0; i < len;) {
+		buffer[0] = '\0';
+		sprintf (buffer, "%.3d :", i);
+		for (j = 0; (j < 16) && (i < len); j++, i++) {
+			sprintf (buffer, "%s %2.2x", buffer, data[i]);
+		}
+		dbg ("%s", buffer);
+	}
+	return i;
+}
+#endif

