Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262220AbSJKALT>; Thu, 10 Oct 2002 20:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262235AbSJKALT>; Thu, 10 Oct 2002 20:11:19 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:34008 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262220AbSJKAJh>;
	Thu, 10 Oct 2002 20:09:37 -0400
Date: Thu, 10 Oct 2002 17:15:22 -0700
To: irda-users@lists.sourceforge.net, Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : ir254_donauboe-2.diff
Message-ID: <20021011001521.GC6645@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir254_donauboe-2.diff :
---------------------
	        <Following patch from Martin Lucina & Christian Gennerat>
	o [FEATURE] Rewrite of the toshoboe driver using documentation
	o [FEATURE] Support Donau oboe chipsets.
	o [FEATURE] FIR support
	o [CORRECT] Probe chip before opening
	o [FEATURE] suspend/resume support
	o [FEATURE] Numerous other improvements/cleanups
	o [CORRECT] (me) Remove save_flags()/cli() for spinlock
		<Currently, we keep the old toshoboe driver around>
	o [FEATURE] Config.help for ma600 driver (unrelated ;-)



diff -u -p -r --new-file linux/drivers/net/irda.d2/Config.help linux/drivers/net/irda/Config.help
--- linux/drivers/net/irda.d2/Config.help	Wed Sep 11 15:26:05 2002
+++ linux/drivers/net/irda/Config.help	Thu Sep 12 11:08:22 2002
@@ -55,12 +55,22 @@ CONFIG_NSC_FIR
   <file:Documentation/modules.txt>.  The module will be called
   nsc-ircc.o.
 
-CONFIG_TOSHIBA_FIR
+CONFIG_TOSHIBA_OLD
   Say Y here if you want to build support for the Toshiba Type-O IR
   chipset.  This chipset is used by the Toshiba Libretto 100CT, and
-  many more laptops.  If you want to compile it as a module, say M
-  here and read <file:Documentation/modules.txt>.  The module will be
-  called toshoboe.o.
+  many more laptops. This driver is obsolete, will no more be
+  maintained and will be removed in favor of the new driver.
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.
+  The module will be called toshoboe.o.
+
+CONFIG_TOSHIBA_FIR
+  Say Y here if you want to build support for the Toshiba Type-O IR
+  and Donau oboe chipsets. These chipsets are used by the Toshiba
+  Libretto 100/110CT, Tecra 8100, Portege 7020 and many more laptops.
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.
+  The module will be called donauboe.o.
 
 CONFIG_SMC_IRCC_FIR
   Say Y here if you want to build support for the SMC Infrared
@@ -165,3 +175,18 @@ CONFIG_ACT200L_DONGLE
   the normal 9-pin serial port connector, and can currently only be
   used by IrTTY. To activate support for ACTiSYS IR-200L dongles
   you will have to start irattach like this: "irattach -d act200l".
+
+Mobile Action MA600 dongle (Experimental)
+CONFIG_MA600_DONGLE
+  Say Y here if you want to build support for the Mobile Action MA600
+  dongle.  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  The MA600 dongle attaches to
+  the normal 9-pin serial port connector, and can currently only be
+  tested on IrCOMM.  To activate support for MA600 dongles you will
+  have to insert "irattach -d ma600" in the /etc/irda/drivers script.
+  Note: irutils 0.9.15 requires no modification. irutils 0.9.9 needs
+  modification. For more information, download the following tar gzip
+  file.
+
+  There is a pre-compiled module on
+  <http://engsvr.ust.hk/~eetwl95/download/ma600-2.4.x.tar.gz>
diff -u -p -r --new-file linux/drivers/net/irda.d2/Config.in linux/drivers/net/irda/Config.in
--- linux/drivers/net/irda.d2/Config.in	Wed Sep 11 15:29:10 2002
+++ linux/drivers/net/irda/Config.in	Thu Sep 12 11:07:17 2002
@@ -28,6 +28,7 @@ comment 'FIR device drivers'
 dep_tristate 'IrDA USB dongles (EXPERIMENTAL)' CONFIG_USB_IRDA $CONFIG_IRDA $CONFIG_USB $CONFIG_EXPERIMENTAL
 dep_tristate 'NSC PC87108/PC87338' CONFIG_NSC_FIR  $CONFIG_IRDA
 dep_tristate 'Winbond W83977AF (IR)' CONFIG_WINBOND_FIR $CONFIG_IRDA
+dep_tristate 'Toshiba Type-O IR Port (old driver)' CONFIG_TOSHIBA_OLD $CONFIG_IRDA
 dep_tristate 'Toshiba Type-O IR Port' CONFIG_TOSHIBA_FIR $CONFIG_IRDA
 if [ "$CONFIG_EXPERIMENTAL" != "n" ]; then
 dep_tristate 'SMC IrCC (EXPERIMENTAL)' CONFIG_SMC_IRCC_FIR $CONFIG_IRDA
diff -u -p -r --new-file linux/drivers/net/irda.d2/Makefile linux/drivers/net/irda/Makefile
--- linux/drivers/net/irda.d2/Makefile	Wed Sep 11 15:26:05 2002
+++ linux/drivers/net/irda/Makefile	Thu Sep 12 11:07:17 2002
@@ -13,7 +13,8 @@ obj-$(CONFIG_USB_IRDA)		+= irda-usb.o
 obj-$(CONFIG_NSC_FIR)		+= nsc-ircc.o
 obj-$(CONFIG_WINBOND_FIR)	+= w83977af_ir.o
 obj-$(CONFIG_SA1100_FIR)	+= sa1100_ir.o
-obj-$(CONFIG_TOSHIBA_FIR)	+= toshoboe.o
+obj-$(CONFIG_TOSHIBA_OLD)	+= toshoboe.o
+obj-$(CONFIG_TOSHIBA_FIR)	+= donauboe.o
 obj-$(CONFIG_SMC_IRCC_FIR)	+= smc-ircc.o	irport.o
 obj-$(CONFIG_ALI_FIR)		+= ali-ircc.o
 obj-$(CONFIG_VLSI_FIR)		+= vlsi_ir.o
diff -u -p -r --new-file linux/drivers/net/irda.d2/donauboe.c linux/drivers/net/irda/donauboe.c
--- linux/drivers/net/irda.d2/donauboe.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/donauboe.c	Thu Sep 12 11:07:17 2002
@@ -0,0 +1,1850 @@
+/*****************************************************************
+ *
+ * Filename:		donauboe.c
+ * Version: 		2.17
+ * Description:   Driver for the Toshiba OBOE (or type-O or 701)
+ *                FIR Chipset, also supports the DONAUOBOE (type-DO
+ *                or d01) FIR chipset which as far as I know is
+ *                register compatible.
+ * Status:        Experimental.
+ * Author:        James McKenzie <james@fishsoup.dhs.org>
+ * Created at:    Sat May 8  12:35:27 1999
+ * Modified:      Paul Bristow <paul.bristow@technologist.com>
+ * Modified:      Mon Nov 11 19:10:05 1999
+ * Modified:      James McKenzie <james@fishsoup.dhs.org>
+ * Modified:      Thu Mar 16 12:49:00 2000 (Substantial rewrite)
+ * Modified:      Sat Apr 29 00:23:03 2000 (Added DONAUOBOE support)
+ * Modified:      Wed May 24 23:45:02 2000 (Fixed chipio_t structure)
+ * Modified: 2.13 Christian Gennerat <christian.gennerat@polytechnique.org>
+ * Modified: 2.13 dim jan 07 21:57:39 2001 (tested with kernel 2.4 & irnet/ppp)
+ * Modified: 2.14 Christian Gennerat <christian.gennerat@polytechnique.org>
+ * Modified: 2.14 lun fev 05 17:55:59 2001 (adapted to patch-2.4.1-pre8-irda1)
+ * Modified: 2.15 Martin Lucina <mato@kotelna.sk>
+ * Modified: 2.15 Fri Jun 21 20:40:59 2002 (sync with 2.4.18, substantial fixes)
+ * Modified: 2.16 Martin Lucina <mato@kotelna.sk>
+ * Modified: 2.16 Sat Jun 22 18:54:29 2002 (fix freeregion, default to verbose)
+ * Modified: 2.17 Christian Gennerat <christian.gennerat@polytechnique.org>
+ * Modified: 2.17 jeu sep 12 08:50:20 2002 (save_flags();cli(); replaced by spinlocks)
+ *
+ *     Copyright (c) 1999 James McKenzie, All Rights Reserved.
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     Neither James McKenzie nor Cambridge University admit liability nor
+ *     provide warranty for any of this software. This material is
+ *     provided "AS-IS" and at no charge.
+ *
+ *     Applicable Models : Libretto 100/110CT and many more.
+ *     Toshiba refers to this chip as the type-O IR port,
+ *     or the type-DO IR port.
+ *
+ ********************************************************************/
+
+/* Look at toshoboe.h (currently in include/net/irda) for details of */
+/* Where to get documentation on the chip         */
+
+
+static char *rcsid =
+  "$Id: donauboe.c V2.17 jeu sep 12 08:50:20 2002 $";
+
+/* See below for a description of the logic in this driver */
+
+/* Is irda_crc16_table[] exported? not yet */
+/* define this if you get errors about multiple defns of irda_crc16_table */
+#undef CRC_EXPORTED
+
+/* User servicable parts */
+/* Enable the code which probes the chip and does a few tests */
+/* Probe code is very useful for understanding how the hardware works */
+/* Use it with various combinations of TT_LEN, RX_LEN */
+/* Strongly recomended, disable if the probe fails on your machine */
+/* and send me <james@fishsoup.dhs.org> the output of dmesg */
+#define DO_PROBE 1
+
+/* Trace Transmit ring, interrupts, Receive ring or not ? */
+#define PROBE_VERBOSE 1
+
+/* Debug option, examine sent and received raw data */
+/* Irdadump is better, but does not see all packets. enable it if you want. */
+#undef DUMP_PACKETS
+
+/* MIR mode has not been tested. Some behaviour is different */
+/* Seems to work against an Ericsson R520 for me. -Martin */
+#define USE_MIR
+
+/* Schedule back to back hardware transmits wherever possible, otherwise */
+/* we need an interrupt for every frame, unset if oboe works for a bit and */
+/* then hangs */
+#define OPTIMIZE_TX
+
+/* Set the number of slots in the rings */
+/* If you get rx/tx fifo overflows at high bitrates, you can try increasing */
+/* these */
+
+#define RING_SIZE (OBOE_RING_SIZE_RX8 | OBOE_RING_SIZE_TX8)
+#define TX_SLOTS    8
+#define RX_SLOTS    8
+
+
+/* Less user servicable parts below here */
+
+/* Test, Transmit and receive buffer sizes, adjust at your peril */
+/* remarks: nfs usually needs 1k blocks */
+/* remarks: in SIR mode, CRC is received, -> RX_LEN=TX_LEN+2 */
+/* remarks: test accepts large blocks. Standard is 0x80 */
+/* When TT_LEN > RX_LEN (SIR mode) data is stored in successive slots. */
+/* When 3 or more slots are needed for each test packet, */
+/* data received in the first slots is overwritten, even */
+/* if OBOE_CTL_RX_HW_OWNS is not set, without any error! */
+#define TT_LEN      0x80
+#define TX_LEN      0xc00
+#define RX_LEN      0xc04
+/* Real transmitted length (SIR mode) is about 14+(2%*TX_LEN) more */
+/* long than user-defined length (see async_wrap_skb) and is less then 4K */
+/* Real received length is (max RX_LEN) differs from user-defined */
+/* length only b the CRC (2 or 4 bytes) */
+#define BUF_SAFETY  0x7a
+#define RX_BUF_SZ   (RX_LEN)
+#define TX_BUF_SZ   (TX_LEN+BUF_SAFETY)
+
+
+/* Logic of the netdev part of this driver                             */
+
+/* The RX ring is filled with buffers, when a packet arrives           */
+/* it is DMA'd into the buffer which is marked used and RxDone called  */
+/* RxDone forms an skb (and checks the CRC if in SIR mode) and ships   */
+/* the packet off upstairs */
+
+/* The transmitter on the oboe chip can work in one of two modes       */
+/* for each ring->tx[] the transmitter can either                      */
+/* a) transmit the packet, leave the trasmitter enabled and proceed to */
+/*    the next ring                                                    */
+/* OR                                                                  */
+/* b) transmit the packet, switch off the transmitter and issue TxDone */
+
+/* All packets are entered into the ring in mode b), if the ring was   */
+/* empty the transmitter is started.                                   */
+
+/* If OPTIMIZE_TX is defined then in TxDone if the ring contains       */
+/* more than one packet, all but the last are set to mode a) [HOWEVER  */
+/* the hardware may not notice this, this is why we start in mode b) ] */
+/* then restart the transmitter                                        */
+
+/* If OPTIMIZE_TX is not defined then we just restart the transmitter  */
+/* if the ring isn't empty */
+
+/* Speed changes are delayed until the TxRing is empty                 */
+/* mtt is handled by generating packets with bad CRCs, before the data */
+
+/* TODO: */
+/* check the mtt works ok      */
+/* finish the watchdog         */
+
+/* No user servicable parts below here */
+
+#define STATIC static
+
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/rtnetlink.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+
+#include <net/irda/wrapper.h>
+#include <net/irda/irda.h>
+//#include <net/irda/irmod.h>
+//#include <net/irda/irlap_frame.h>
+#include <net/irda/irda_device.h>
+#include <net/irda/crc.h>
+
+#include "donauboe.h"
+
+#define INB(port)       inb_p(port)
+#define OUTB(val,port)  outb_p(val,port)
+#define OUTBP(val,port) outb_p(val,port)
+
+#define PROMPT  OUTB(OBOE_PROMPT_BIT,OBOE_PROMPT);
+
+#if PROBE_VERBOSE
+#define PROBE_DEBUG(args...) (printk (args))
+#else
+#define PROBE_DEBUG(args...) ;
+#endif
+
+/* Set the DMA to be byte at a time */
+#define CONFIG0H_DMA_OFF OBOE_CONFIG0H_RCVANY
+#define CONFIG0H_DMA_ON_NORX CONFIG0H_DMA_OFF| OBOE_CONFIG0H_ENDMAC
+#define CONFIG0H_DMA_ON CONFIG0H_DMA_ON_NORX | OBOE_CONFIG0H_ENRX
+
+static struct pci_device_id toshoboe_pci_tbl[] __initdata = {
+	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIR701, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_FIRD01, PCI_ANY_ID, PCI_ANY_ID, },
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, toshoboe_pci_tbl);
+
+#define DRIVER_NAME "toshoboe"
+static char *driver_name = DRIVER_NAME;
+
+static int max_baud = 4000000;
+static int do_probe = DO_PROBE;
+
+
+/**********************************************************************/
+/* Fcs code */
+
+#ifdef CRC_EXPORTED
+extern __u16 const irda_crc16_table[];
+#else
+static __u16 const irda_crc16_table[256] = {
+  0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
+  0x8c48, 0x9dc1, 0xaf5a, 0xbed3, 0xca6c, 0xdbe5, 0xe97e, 0xf8f7,
+  0x1081, 0x0108, 0x3393, 0x221a, 0x56a5, 0x472c, 0x75b7, 0x643e,
+  0x9cc9, 0x8d40, 0xbfdb, 0xae52, 0xdaed, 0xcb64, 0xf9ff, 0xe876,
+  0x2102, 0x308b, 0x0210, 0x1399, 0x6726, 0x76af, 0x4434, 0x55bd,
+  0xad4a, 0xbcc3, 0x8e58, 0x9fd1, 0xeb6e, 0xfae7, 0xc87c, 0xd9f5,
+  0x3183, 0x200a, 0x1291, 0x0318, 0x77a7, 0x662e, 0x54b5, 0x453c,
+  0xbdcb, 0xac42, 0x9ed9, 0x8f50, 0xfbef, 0xea66, 0xd8fd, 0xc974,
+  0x4204, 0x538d, 0x6116, 0x709f, 0x0420, 0x15a9, 0x2732, 0x36bb,
+  0xce4c, 0xdfc5, 0xed5e, 0xfcd7, 0x8868, 0x99e1, 0xab7a, 0xbaf3,
+  0x5285, 0x430c, 0x7197, 0x601e, 0x14a1, 0x0528, 0x37b3, 0x263a,
+  0xdecd, 0xcf44, 0xfddf, 0xec56, 0x98e9, 0x8960, 0xbbfb, 0xaa72,
+  0x6306, 0x728f, 0x4014, 0x519d, 0x2522, 0x34ab, 0x0630, 0x17b9,
+  0xef4e, 0xfec7, 0xcc5c, 0xddd5, 0xa96a, 0xb8e3, 0x8a78, 0x9bf1,
+  0x7387, 0x620e, 0x5095, 0x411c, 0x35a3, 0x242a, 0x16b1, 0x0738,
+  0xffcf, 0xee46, 0xdcdd, 0xcd54, 0xb9eb, 0xa862, 0x9af9, 0x8b70,
+  0x8408, 0x9581, 0xa71a, 0xb693, 0xc22c, 0xd3a5, 0xe13e, 0xf0b7,
+  0x0840, 0x19c9, 0x2b52, 0x3adb, 0x4e64, 0x5fed, 0x6d76, 0x7cff,
+  0x9489, 0x8500, 0xb79b, 0xa612, 0xd2ad, 0xc324, 0xf1bf, 0xe036,
+  0x18c1, 0x0948, 0x3bd3, 0x2a5a, 0x5ee5, 0x4f6c, 0x7df7, 0x6c7e,
+  0xa50a, 0xb483, 0x8618, 0x9791, 0xe32e, 0xf2a7, 0xc03c, 0xd1b5,
+  0x2942, 0x38cb, 0x0a50, 0x1bd9, 0x6f66, 0x7eef, 0x4c74, 0x5dfd,
+  0xb58b, 0xa402, 0x9699, 0x8710, 0xf3af, 0xe226, 0xd0bd, 0xc134,
+  0x39c3, 0x284a, 0x1ad1, 0x0b58, 0x7fe7, 0x6e6e, 0x5cf5, 0x4d7c,
+  0xc60c, 0xd785, 0xe51e, 0xf497, 0x8028, 0x91a1, 0xa33a, 0xb2b3,
+  0x4a44, 0x5bcd, 0x6956, 0x78df, 0x0c60, 0x1de9, 0x2f72, 0x3efb,
+  0xd68d, 0xc704, 0xf59f, 0xe416, 0x90a9, 0x8120, 0xb3bb, 0xa232,
+  0x5ac5, 0x4b4c, 0x79d7, 0x685e, 0x1ce1, 0x0d68, 0x3ff3, 0x2e7a,
+  0xe70e, 0xf687, 0xc41c, 0xd595, 0xa12a, 0xb0a3, 0x8238, 0x93b1,
+  0x6b46, 0x7acf, 0x4854, 0x59dd, 0x2d62, 0x3ceb, 0x0e70, 0x1ff9,
+  0xf78f, 0xe606, 0xd49d, 0xc514, 0xb1ab, 0xa022, 0x92b9, 0x8330,
+  0x7bc7, 0x6a4e, 0x58d5, 0x495c, 0x3de3, 0x2c6a, 0x1ef1, 0x0f78
+};
+#endif
+
+STATIC int
+toshoboe_checkfcs (unsigned char *buf, int len)
+{
+  int i;
+  union
+  {
+    __u16 value;
+    __u8 bytes[2];
+  }
+  fcs;
+
+  fcs.value = INIT_FCS;
+
+  for (i = 0; i < len; ++i)
+    fcs.value = irda_fcs (fcs.value, *(buf++));
+
+  return (fcs.value == GOOD_FCS);
+}
+
+/***********************************************************************/
+/* Generic chip handling code */
+#ifdef DUMP_PACKETS
+static unsigned char dump[50];
+STATIC void 
+_dumpbufs (unsigned char *data, int len, char tete)
+{
+int i,j;
+char head=tete;
+for (i=0;i<len;i+=16) {
+    for (j=0;j<16 && i+j<len;j++) { sprintf(&dump[3*j],"%02x.",data[i+j]); }
+    dump [3*j]=0;
+    IRDA_DEBUG (2, "%c%s\n",head , dump);
+    head='+'; 
+    }
+}
+#endif
+
+/* Dump the registers */
+STATIC void
+toshoboe_dumpregs (struct toshoboe_cb *self)
+{
+  __u32 ringbase;
+
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  ringbase = INB (OBOE_RING_BASE0) << 10;
+  ringbase |= INB (OBOE_RING_BASE1) << 18;
+  ringbase |= INB (OBOE_RING_BASE2) << 26;
+
+  printk (KERN_ERR DRIVER_NAME ": Register dump:\n");
+  printk (KERN_ERR "Interrupts: Tx:%d Rx:%d TxUnder:%d RxOver:%d Sip:%d\n",
+          self->int_tx, self->int_rx, self->int_txunder, self->int_rxover,
+          self->int_sip);
+  printk (KERN_ERR "RX %02x TX %02x RingBase %08x\n",
+          INB (OBOE_RXSLOT), INB (OBOE_TXSLOT), ringbase);
+  printk (KERN_ERR "RING_SIZE %02x IER %02x ISR %02x\n",
+          INB (OBOE_RING_SIZE), INB (OBOE_IER), INB (OBOE_ISR));
+  printk (KERN_ERR "CONFIG1 %02x STATUS %02x\n",
+          INB (OBOE_CONFIG1), INB (OBOE_STATUS));
+  printk (KERN_ERR "CONFIG0 %02x%02x ENABLE %02x%02x\n",
+          INB (OBOE_CONFIG0H), INB (OBOE_CONFIG0L),
+          INB (OBOE_ENABLEH), INB (OBOE_ENABLEL));
+  printk (KERN_ERR "NEW_PCONFIG %02x%02x CURR_PCONFIG %02x%02x\n",
+          INB (OBOE_NEW_PCONFIGH), INB (OBOE_NEW_PCONFIGL),
+          INB (OBOE_CURR_PCONFIGH), INB (OBOE_CURR_PCONFIGL));
+  printk (KERN_ERR "MAXLEN %02x%02x RXCOUNT %02x%02x\n",
+          INB (OBOE_MAXLENH), INB (OBOE_MAXLENL),
+          INB (OBOE_RXCOUNTL), INB (OBOE_RXCOUNTH));
+
+  if (self->ring)
+    {
+      int i;
+      ringbase = virt_to_bus (self->ring);
+      printk (KERN_ERR "Ring at %08x:\n", ringbase);
+      printk (KERN_ERR "RX:");
+      for (i = 0; i < RX_SLOTS; ++i)
+        printk (" (%d,%02x)",self->ring->rx[i].len,self->ring->rx[i].control);
+      printk ("\n");
+      printk (KERN_ERR "TX:");
+      for (i = 0; i < RX_SLOTS; ++i)
+        printk (" (%d,%02x)",self->ring->tx[i].len,self->ring->tx[i].control);
+      printk ("\n");
+    }
+}
+
+/*Don't let the chip look at memory */
+STATIC void
+toshoboe_disablebm (struct toshoboe_cb *self)
+{
+  __u8 command;
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  pci_read_config_byte (self->pdev, PCI_COMMAND, &command);
+  command &= ~PCI_COMMAND_MASTER;
+  pci_write_config_byte (self->pdev, PCI_COMMAND, command);
+
+}
+
+/* Shutdown the chip and point the taskfile reg somewhere else */
+STATIC void
+toshoboe_stopchip (struct toshoboe_cb *self)
+{
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  /*Disable interrupts */
+  OUTB (0x0, OBOE_IER);
+  /*Disable DMA, Disable Rx, Disable Tx */
+  OUTB (CONFIG0H_DMA_OFF, OBOE_CONFIG0H);
+  /*Disable SIR MIR FIR, Tx and Rx */
+  OUTB (0x00, OBOE_ENABLEH);
+  /*Point the ring somewhere safe */
+  OUTB (0x3f, OBOE_RING_BASE2);
+  OUTB (0xff, OBOE_RING_BASE1);
+  OUTB (0xff, OBOE_RING_BASE0);
+
+  OUTB (RX_LEN >> 8, OBOE_MAXLENH);
+  OUTB (RX_LEN & 0xff, OBOE_MAXLENL);
+
+  /*Acknoledge any pending interrupts */
+  OUTB (0xff, OBOE_ISR);
+
+  /*Why */
+  OUTB (OBOE_ENABLEH_PHYANDCLOCK, OBOE_ENABLEH);
+
+  /*switch it off */
+  OUTB (OBOE_CONFIG1_OFF, OBOE_CONFIG1);
+
+  toshoboe_disablebm (self);
+}
+
+/* Transmitter initialization */
+STATIC void
+toshoboe_start_DMA (struct toshoboe_cb *self, int opts)
+{
+  OUTB (0x0, OBOE_ENABLEH);
+  OUTB (CONFIG0H_DMA_ON | opts,  OBOE_CONFIG0H);
+  OUTB (OBOE_ENABLEH_PHYANDCLOCK, OBOE_ENABLEH);
+  PROMPT;
+}
+
+/*Set the baud rate */
+STATIC void
+toshoboe_setbaud (struct toshoboe_cb *self)
+{
+  __u16 pconfig = 0;
+  __u8 config0l = 0;
+
+  IRDA_DEBUG (2, "%s(%d/%d)\n", __FUNCTION__, self->speed, self->io.speed);
+
+  switch (self->speed)
+    {
+    case 2400:
+    case 4800:
+    case 9600:
+    case 19200:
+    case 38400:
+    case 57600:
+    case 115200:
+#ifdef USE_MIR
+    case 1152000:
+#endif
+    case 4000000:
+      break;
+    default:
+
+      printk (KERN_ERR DRIVER_NAME ": switch to unsupported baudrate %d\n",
+              self->speed);
+      return;
+    }
+
+  switch (self->speed)
+    {
+      /* For SIR the preamble is done by adding XBOFs */
+      /* to the packet */
+      /* set to filtered SIR mode, filter looks for BOF and EOF */
+    case 2400:
+      pconfig |= 47 << OBOE_PCONFIG_BAUDSHIFT;
+      pconfig |= 25 << OBOE_PCONFIG_WIDTHSHIFT;
+      break;
+    case 4800:
+      pconfig |= 23 << OBOE_PCONFIG_BAUDSHIFT;
+      pconfig |= 25 << OBOE_PCONFIG_WIDTHSHIFT;
+      break;
+    case 9600:
+      pconfig |= 11 << OBOE_PCONFIG_BAUDSHIFT;
+      pconfig |= 25 << OBOE_PCONFIG_WIDTHSHIFT;
+      break;
+    case 19200:
+      pconfig |= 5 << OBOE_PCONFIG_BAUDSHIFT;
+      pconfig |= 25 << OBOE_PCONFIG_WIDTHSHIFT;
+      break;
+    case 38400:
+      pconfig |= 2 << OBOE_PCONFIG_BAUDSHIFT;
+      pconfig |= 25 << OBOE_PCONFIG_WIDTHSHIFT;
+      break;
+    case 57600:
+      pconfig |= 1 << OBOE_PCONFIG_BAUDSHIFT;
+      pconfig |= 25 << OBOE_PCONFIG_WIDTHSHIFT;
+      break;
+    case 115200:
+      pconfig |= 0 << OBOE_PCONFIG_BAUDSHIFT;
+      pconfig |= 25 << OBOE_PCONFIG_WIDTHSHIFT;
+      break;
+    default:
+      /*Set to packet based reception */
+      OUTB (RX_LEN >> 8, OBOE_MAXLENH);
+      OUTB (RX_LEN & 0xff, OBOE_MAXLENL);
+      break;
+    }
+
+  switch (self->speed)
+    {
+    case 2400:
+    case 4800:
+    case 9600:
+    case 19200:
+    case 38400:
+    case 57600:
+    case 115200:
+      config0l = OBOE_CONFIG0L_ENSIR;
+      if (self->async)
+        {
+          /*Set to character based reception */
+          /*System will lock if MAXLEN=0 */
+          /*so have to be careful */
+          OUTB (0x01, OBOE_MAXLENH);
+          OUTB (0x01, OBOE_MAXLENL);
+          OUTB (0x00, OBOE_MAXLENH);
+        }
+      else
+        {
+          /*Set to packet based reception */
+          config0l |= OBOE_CONFIG0L_ENSIRF;
+          OUTB (RX_LEN >> 8, OBOE_MAXLENH);
+          OUTB (RX_LEN & 0xff, OBOE_MAXLENL);
+        }
+      break;
+
+#ifdef USE_MIR
+      /* MIR mode */
+      /* Set for 16 bit CRC and enable MIR */
+      /* Preamble now handled by the chip */
+    case 1152000:
+      pconfig |= 0 << OBOE_PCONFIG_BAUDSHIFT;
+      pconfig |= 8 << OBOE_PCONFIG_WIDTHSHIFT;
+      pconfig |= 1 << OBOE_PCONFIG_PREAMBLESHIFT;
+      config0l = OBOE_CONFIG0L_CRC16 | OBOE_CONFIG0L_ENMIR;
+      break;
+#endif
+      /* FIR mode */
+      /* Set for 32 bit CRC and enable FIR */
+      /* Preamble handled by the chip */
+    case 4000000:
+      pconfig |= 0 << OBOE_PCONFIG_BAUDSHIFT;
+      /* Documentation says 14, but toshiba use 15 in their drivers */
+      pconfig |= 15 << OBOE_PCONFIG_PREAMBLESHIFT;
+      config0l = OBOE_CONFIG0L_ENFIR;
+      break;
+    }
+
+  /* Copy into new PHY config buffer */
+  OUTBP (pconfig >> 8, OBOE_NEW_PCONFIGH);
+  OUTB (pconfig & 0xff, OBOE_NEW_PCONFIGL);
+  OUTB (config0l, OBOE_CONFIG0L);
+
+  /* Now make OBOE copy from new PHY to current PHY */
+  OUTB (0x0, OBOE_ENABLEH);
+  OUTB (OBOE_ENABLEH_PHYANDCLOCK, OBOE_ENABLEH);
+  PROMPT;
+
+  /* speed change executed */
+  self->new_speed = 0;
+  self->io.speed = self->speed;
+}
+
+/*Let the chip look at memory */
+STATIC void
+toshoboe_enablebm (struct toshoboe_cb *self)
+{
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+  pci_set_master (self->pdev);
+}
+
+/*setup the ring */
+STATIC void
+toshoboe_initring (struct toshoboe_cb *self)
+{
+  int i;
+
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  for (i = 0; i < TX_SLOTS; ++i)
+    {
+      self->ring->tx[i].len = 0;
+      self->ring->tx[i].control = 0x00;
+      self->ring->tx[i].address = virt_to_bus (self->tx_bufs[i]);
+    }
+
+  for (i = 0; i < RX_SLOTS; ++i)
+    {
+      self->ring->rx[i].len = RX_LEN;
+      self->ring->rx[i].len = 0;
+      self->ring->rx[i].address = virt_to_bus (self->rx_bufs[i]);
+      self->ring->rx[i].control = OBOE_CTL_RX_HW_OWNS;
+    }
+}
+
+STATIC void
+toshoboe_resetptrs (struct toshoboe_cb *self)
+{
+  /* Can reset pointers by twidling DMA */
+  OUTB (0x0, OBOE_ENABLEH);
+  OUTBP (CONFIG0H_DMA_OFF, OBOE_CONFIG0H);
+  OUTB (OBOE_ENABLEH_PHYANDCLOCK, OBOE_ENABLEH);
+
+  self->rxs = inb_p (OBOE_RXSLOT) & OBOE_SLOT_MASK;
+  self->txs = inb_p (OBOE_TXSLOT) & OBOE_SLOT_MASK;
+}
+
+/* Called in locked state */
+STATIC void
+toshoboe_initptrs (struct toshoboe_cb *self)
+{
+
+  /* spin_lock_irqsave(self->spinlock, flags); */
+  /* save_flags (flags); */
+
+  /* Can reset pointers by twidling DMA */
+  toshoboe_resetptrs (self);
+
+  OUTB (0x0, OBOE_ENABLEH);
+  OUTB (CONFIG0H_DMA_ON, OBOE_CONFIG0H);
+  OUTB (OBOE_ENABLEH_PHYANDCLOCK, OBOE_ENABLEH);
+
+  self->txpending = 0;
+
+  /* spin_unlock_irqrestore(self->spinlock, flags); */
+  /* restore_flags (flags); */
+}
+
+/* Wake the chip up and get it looking at the rings */
+/* Called in locked state */
+STATIC void
+toshoboe_startchip (struct toshoboe_cb *self)
+{
+  __u32 physaddr;
+
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  toshoboe_initring (self);
+  toshoboe_enablebm (self);
+  OUTBP (OBOE_CONFIG1_RESET, OBOE_CONFIG1);
+  OUTBP (OBOE_CONFIG1_ON, OBOE_CONFIG1);
+
+  /* Stop the clocks */
+  OUTB (0, OBOE_ENABLEH);
+
+  /*Set size of rings */
+  OUTB (RING_SIZE, OBOE_RING_SIZE);
+
+  /*Acknoledge any pending interrupts */
+  OUTB (0xff, OBOE_ISR);
+
+  /*Enable ints */
+  OUTB (OBOE_INT_TXDONE  | OBOE_INT_RXDONE |
+        OBOE_INT_TXUNDER | OBOE_INT_RXOVER | OBOE_INT_SIP , OBOE_IER);
+
+  /*Acknoledge any pending interrupts */
+  OUTB (0xff, OBOE_ISR);
+
+  /*Set the maximum packet length to 0xfff (4095) */
+  OUTB (RX_LEN >> 8, OBOE_MAXLENH);
+  OUTB (RX_LEN & 0xff, OBOE_MAXLENL);
+
+  /*Shutdown DMA */
+  OUTB (CONFIG0H_DMA_OFF, OBOE_CONFIG0H);
+
+  /*Find out where the rings live */
+  physaddr = virt_to_bus (self->ring);
+
+  ASSERT ((physaddr & 0x3ff) == 0,
+          printk (KERN_ERR DRIVER_NAME "ring not correctly aligned\n");
+          return;);
+
+  OUTB ((physaddr >> 10) & 0xff, OBOE_RING_BASE0);
+  OUTB ((physaddr >> 18) & 0xff, OBOE_RING_BASE1);
+  OUTB ((physaddr >> 26) & 0x3f, OBOE_RING_BASE2);
+
+  /*Enable DMA controler in byte mode and RX */
+  OUTB (CONFIG0H_DMA_ON, OBOE_CONFIG0H);
+
+  /* Start up the clocks */
+  OUTB (OBOE_ENABLEH_PHYANDCLOCK, OBOE_ENABLEH);
+
+  /*set to sensible speed */
+  self->speed = 9600;
+  toshoboe_setbaud (self);
+  toshoboe_initptrs (self);
+}
+
+STATIC void
+toshoboe_isntstuck (struct toshoboe_cb *self)
+{
+}
+
+STATIC void
+toshoboe_checkstuck (struct toshoboe_cb *self)
+{
+  unsigned long flags;
+
+  if (0)
+    {
+      spin_lock_irqsave(&self->spinlock, flags);
+
+      /* This will reset the chip completely */
+      printk (KERN_ERR DRIVER_NAME ": Resetting chip\n");
+
+      toshoboe_stopchip (self);
+      toshoboe_startchip (self);
+      spin_unlock_irqrestore(&self->spinlock, flags);
+    }
+}
+
+/*Generate packet of about mtt us long */
+STATIC int
+toshoboe_makemttpacket (struct toshoboe_cb *self, void *buf, int mtt)
+{
+  int xbofs;
+
+  xbofs = ((int) (mtt/100)) * (int) (self->speed);
+  xbofs=xbofs/80000; /*Eight bits per byte, and mtt is in us*/
+  xbofs++;
+
+  IRDA_DEBUG (2, DRIVER_NAME 
+      ": generated mtt of %d bytes for %d us at %d baud\n"
+	  , xbofs,mtt,self->speed);
+
+  if (xbofs > TX_LEN)
+    {
+      printk (KERN_ERR DRIVER_NAME ": wanted %d bytes MTT but TX_LEN is %d\n",
+              xbofs, TX_LEN);
+      xbofs = TX_LEN;
+    }
+
+  /*xbofs will do for SIR, MIR and FIR,SIR mode doesn't generate a checksum anyway */
+  memset (buf, XBOF, xbofs);
+
+  return xbofs;
+}
+
+/***********************************************************************/
+/* Probe code */
+
+STATIC void
+toshoboe_dumptx (struct toshoboe_cb *self)
+{
+  int i;
+  PROBE_DEBUG(KERN_WARNING "TX:");
+  for (i = 0; i < RX_SLOTS; ++i)
+    PROBE_DEBUG(" (%d,%02x)",self->ring->tx[i].len,self->ring->tx[i].control);
+  PROBE_DEBUG(" [%d]\n",self->speed);
+}
+
+STATIC void
+toshoboe_dumprx (struct toshoboe_cb *self, int score)
+{
+  int i;
+  PROBE_DEBUG(" %d\nRX:",score);
+  for (i = 0; i < RX_SLOTS; ++i)
+    PROBE_DEBUG(" (%d,%02x)",self->ring->rx[i].len,self->ring->rx[i].control);
+  PROBE_DEBUG("\n");
+}
+
+static inline int
+stuff_byte (__u8 byte, __u8 * buf)
+{
+  switch (byte)
+    {
+    case BOF:                  /* FALLTHROUGH */
+    case EOF:                  /* FALLTHROUGH */
+    case CE:
+      /* Insert transparently coded */
+      buf[0] = CE;              /* Send link escape */
+      buf[1] = byte ^ IRDA_TRANS; /* Complement bit 5 */
+      return 2;
+      /* break; */
+    default:
+      /* Non-special value, no transparency required */
+      buf[0] = byte;
+      return 1;
+      /* break; */
+    }
+}
+
+STATIC int toshoboe_invalid_dev(int irq) 
+{
+  printk (KERN_WARNING DRIVER_NAME ": irq %d for unknown device.\n", irq);
+  return 1;
+}
+
+STATIC void
+toshoboe_probeinterrupt (int irq, void *dev_id, struct pt_regs *regs)
+{
+  struct toshoboe_cb *self = (struct toshoboe_cb *) dev_id;
+  __u8 irqstat;
+
+  if (self == NULL && toshoboe_invalid_dev(irq)) 
+    return;
+
+  irqstat = INB (OBOE_ISR);
+
+/* was it us */
+  if (!(irqstat & OBOE_INT_MASK))
+    return;
+
+/* Ack all the interrupts */
+  OUTB (irqstat, OBOE_ISR);
+
+  if (irqstat & OBOE_INT_TXDONE)
+    {
+      int txp;
+
+      self->int_tx++;
+      PROBE_DEBUG("T");
+
+      txp = INB (OBOE_TXSLOT) & OBOE_SLOT_MASK;
+      if (self->ring->tx[txp].control & OBOE_CTL_TX_HW_OWNS)
+        {
+          self->int_tx+=100;
+          PROBE_DEBUG("S");
+          toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX | OBOE_CONFIG0H_LOOP);
+        }
+    }
+
+  if (irqstat & OBOE_INT_RXDONE) {
+    self->int_rx++;
+    PROBE_DEBUG("R"); }
+  if (irqstat & OBOE_INT_TXUNDER) {
+    self->int_txunder++;
+    PROBE_DEBUG("U"); }
+  if (irqstat & OBOE_INT_RXOVER) {
+    self->int_rxover++;
+    PROBE_DEBUG("O"); }
+  if (irqstat & OBOE_INT_SIP) {
+    self->int_sip++;
+    PROBE_DEBUG("I"); }
+}
+
+STATIC int
+toshoboe_maketestpacket (unsigned char *buf, int badcrc, int fir)
+{
+  int i;
+  int len = 0;
+  union
+  {
+    __u16 value;
+    __u8 bytes[2];
+  }
+  fcs;
+
+  if (fir)
+    {
+      memset (buf, 0, TT_LEN);
+      return (TT_LEN);
+    }
+
+  fcs.value = INIT_FCS;
+
+  memset (buf, XBOF, 10);
+  len += 10;
+  buf[len++] = BOF;
+
+  for (i = 0; i < TT_LEN; ++i)
+    {
+      len += stuff_byte (i, buf + len);
+      fcs.value = irda_fcs (fcs.value, i);
+    }
+
+  len += stuff_byte (fcs.bytes[0] ^ badcrc, buf + len);
+  len += stuff_byte (fcs.bytes[1] ^ badcrc, buf + len);
+  buf[len++] = EOF;
+  len++;
+  return len;
+}
+
+STATIC int
+toshoboe_probefail (struct toshoboe_cb *self, char *msg)
+{
+  printk (KERN_ERR DRIVER_NAME "probe(%d) failed %s\n",self-> speed, msg);
+  toshoboe_dumpregs (self);
+  toshoboe_stopchip (self);
+  free_irq (self->io.irq, (void *) self);
+  return 0;
+}
+
+STATIC int
+toshoboe_numvalidrcvs (struct toshoboe_cb *self)
+{
+  int i, ret = 0;
+  for (i = 0; i < RX_SLOTS; ++i)
+    if ((self->ring->rx[i].control & 0xe0) == 0)
+      ret++;
+
+  return ret;
+}
+
+STATIC int
+toshoboe_numrcvs (struct toshoboe_cb *self)
+{
+  int i, ret = 0;
+  for (i = 0; i < RX_SLOTS; ++i)
+    if (!(self->ring->rx[i].control & OBOE_CTL_RX_HW_OWNS))
+      ret++;
+
+  return ret;
+}
+
+STATIC int
+toshoboe_probe (struct toshoboe_cb *self)
+{
+  int i, j, n;
+#ifdef USE_MIR
+  int bauds[] = { 9600, 115200, 4000000, 1152000 };
+#else
+  int bauds[] = { 9600, 115200, 4000000 };
+#endif
+  unsigned long flags;
+
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  if (request_irq (self->io.irq, toshoboe_probeinterrupt,
+                   self->io.irqflags, "toshoboe", (void *) self))
+    {
+      printk (KERN_ERR DRIVER_NAME ": probe failed to allocate irq %d\n",
+              self->io.irq);
+      return 0;
+    }
+
+  /* test 1: SIR filter and back to back */
+
+  for (j = 0; j < (sizeof (bauds) / sizeof (int)); ++j)
+    {
+      int fir = (j > 1);
+      toshoboe_stopchip (self);
+
+
+      spin_lock_irqsave(&self->spinlock, flags);
+      /*Address is already setup */
+      toshoboe_startchip (self);
+      self->int_rx = self->int_tx = 0;
+      self->speed = bauds[j];
+      toshoboe_setbaud (self);
+      toshoboe_initptrs (self);
+      spin_unlock_irqrestore(&self->spinlock, flags); 
+
+      self->ring->tx[self->txs].control =
+/*   (FIR only) OBOE_CTL_TX_SIP needed for switching to next slot */
+/*    MIR: all received data is stored in one slot */
+        (fir) ? OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_RTCENTX
+              : OBOE_CTL_TX_HW_OWNS ;
+      self->ring->tx[self->txs].len =
+        toshoboe_maketestpacket (self->tx_bufs[self->txs], 0, fir);
+      self->txs++;
+      self->txs %= TX_SLOTS;
+
+      self->ring->tx[self->txs].control =
+        (fir) ? OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_SIP
+              : OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_RTCENTX ;
+      self->ring->tx[self->txs].len =
+        toshoboe_maketestpacket (self->tx_bufs[self->txs], 0, fir);
+      self->txs++;
+      self->txs %= TX_SLOTS;
+
+      self->ring->tx[self->txs].control = 
+        (fir) ? OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_RTCENTX
+              : OBOE_CTL_TX_HW_OWNS ;
+      self->ring->tx[self->txs].len =
+        toshoboe_maketestpacket (self->tx_bufs[self->txs], 0, fir);
+      self->txs++;
+      self->txs %= TX_SLOTS;
+
+      self->ring->tx[self->txs].control =
+        (fir) ? OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_RTCENTX
+              | OBOE_CTL_TX_SIP     | OBOE_CTL_TX_BAD_CRC
+              : OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_RTCENTX ;
+      self->ring->tx[self->txs].len =
+        toshoboe_maketestpacket (self->tx_bufs[self->txs], 0, fir);
+      self->txs++;
+      self->txs %= TX_SLOTS;
+
+      toshoboe_dumptx (self);
+      /* Turn on TX and RX and loopback */
+      toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX | OBOE_CONFIG0H_LOOP);
+
+      i = 0;
+      n = fir ? 1 : 4;
+      while (toshoboe_numvalidrcvs (self) != n)
+        {
+          if (i > 4800)
+              return toshoboe_probefail (self, "filter test");
+          udelay ((9600*(TT_LEN+16))/self->speed);
+          i++;
+        }
+
+      n = fir ? 203 : 102;
+      while ((toshoboe_numrcvs(self) != self->int_rx) || (self->int_tx != n))
+        {
+          if (i > 4800)
+              return toshoboe_probefail (self, "interrupt test");
+          udelay ((9600*(TT_LEN+16))/self->speed);
+          i++;
+        }
+     toshoboe_dumprx (self,i);
+
+     }
+
+  /* test 2: SIR in char at a time */
+
+  toshoboe_stopchip (self);
+  self->int_rx = self->int_tx = 0;
+
+  spin_lock_irqsave(&self->spinlock, flags);
+  toshoboe_startchip (self);
+  spin_unlock_irqrestore(&self->spinlock, flags);
+
+  self->async = 1;
+  self->speed = 115200;
+  toshoboe_setbaud (self);
+  self->ring->tx[self->txs].control =
+    OBOE_CTL_TX_RTCENTX | OBOE_CTL_TX_HW_OWNS;
+  self->ring->tx[self->txs].len = 4;
+
+  ((unsigned char *) self->tx_bufs[self->txs])[0] = 'f';
+  ((unsigned char *) self->tx_bufs[self->txs])[1] = 'i';
+  ((unsigned char *) self->tx_bufs[self->txs])[2] = 's';
+  ((unsigned char *) self->tx_bufs[self->txs])[3] = 'h';
+  toshoboe_dumptx (self);
+  toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX | OBOE_CONFIG0H_LOOP);
+
+  i = 0;
+  while (toshoboe_numvalidrcvs (self) != 4)
+    {
+      if (i > 100)
+          return toshoboe_probefail (self, "Async test");
+      udelay (100);
+      i++;
+    }
+
+  while ((toshoboe_numrcvs (self) != self->int_rx) || (self->int_tx != 1))
+    {
+      if (i > 100)
+          return toshoboe_probefail (self, "Async interrupt test");
+      udelay (100);
+      i++;
+    }
+  toshoboe_dumprx (self,i);
+
+  self->async = 0;
+  self->speed = 9600;
+  toshoboe_setbaud (self);
+  toshoboe_stopchip (self);
+
+  free_irq (self->io.irq, (void *) self);
+
+  printk (KERN_WARNING DRIVER_NAME ": Self test passed ok\n");
+
+  return 1;
+}
+
+/******************************************************************/
+/* Netdev style code */
+
+/* Transmit something */
+STATIC int
+toshoboe_hard_xmit (struct sk_buff *skb, struct net_device *dev)
+{
+  struct toshoboe_cb *self;
+  __s32 speed;
+  int mtt, len, ctl;
+  unsigned long flags;
+  struct irda_skb_cb *cb = (struct irda_skb_cb *) skb->cb;
+
+  self = (struct toshoboe_cb *) dev->priv;
+
+  ASSERT (self != NULL, return 0; );
+
+  IRDA_DEBUG (1, "%s.tx:%x(%x)%x\n", __FUNCTION__ 
+      ,skb->len,self->txpending,INB (OBOE_ENABLEH));
+  if (!cb->magic) {
+      IRDA_DEBUG (2, "%s.Not IrLAP:%x\n", __FUNCTION__, cb->magic);
+#ifdef DUMP_PACKETS
+      _dumpbufs(skb->data,skb->len,'>'); 
+#endif
+    }
+
+  /* change speed pending, wait for its execution */
+  if (self->new_speed)
+      return -EBUSY;
+
+  /* device stopped (apm) wait for restart */
+  if (self->stopped)
+      return -EBUSY;
+
+  toshoboe_checkstuck (self);
+
+  /* Check if we need to change the speed */
+  /* But not now. Wait after transmission if mtt not required */
+  speed=irda_get_next_speed(skb);
+  if ((speed != self->io.speed) && (speed != -1))
+    {
+      spin_lock_irqsave(&self->spinlock, flags);
+
+      if (self->txpending || skb->len)
+        {
+          self->new_speed = speed;
+          IRDA_DEBUG (1, "%s: Queued TxDone scheduled speed change %d\n" ,
+		      __FUNCTION__, speed);
+          /* if no data, that's all! */
+          if (!skb->len) 
+            {
+	      spin_unlock_irqrestore(&self->spinlock, flags);
+              dev_kfree_skb (skb);
+              return 0;
+            }
+          /* True packet, go on, but */
+          /* do not accept anything before change speed execution */
+          netif_stop_queue(dev); 
+          /* ready to process TxDone interrupt */
+	  spin_unlock_irqrestore(&self->spinlock, flags);
+        }
+      else
+        { 
+          /* idle and no data, change speed now */
+          self->speed = speed;
+          toshoboe_setbaud (self);
+	  spin_unlock_irqrestore(&self->spinlock, flags);
+          dev_kfree_skb (skb);
+          return 0;
+        }
+
+    }
+
+  if ((mtt = irda_get_mtt(skb)))
+    {
+      /* This is fair since the queue should be empty anyway */
+      spin_lock_irqsave(&self->spinlock, flags);
+
+      if (self->txpending)
+        {
+	  spin_unlock_irqrestore(&self->spinlock, flags);
+          return -EBUSY;
+        }
+
+      /* If in SIR mode we need to generate a string of XBOFs */
+      /* In MIR and FIR we need to generate a string of data */
+      /* which we will add a wrong checksum to */
+
+      mtt = toshoboe_makemttpacket (self, self->tx_bufs[self->txs], mtt);
+      IRDA_DEBUG (1, "%s.mtt:%x(%x)%d\n", __FUNCTION__ 
+          ,skb->len,mtt,self->txpending);
+      if (mtt)
+        {
+          self->ring->tx[self->txs].len = mtt & 0xfff;
+
+          ctl = OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_RTCENTX;
+          if (INB (OBOE_ENABLEH) & OBOE_ENABLEH_FIRON)
+            {
+              ctl |= OBOE_CTL_TX_BAD_CRC | OBOE_CTL_TX_SIP ;
+            }
+#ifdef USE_MIR
+          else if (INB (OBOE_ENABLEH) & OBOE_ENABLEH_MIRON)
+            {
+              ctl |= OBOE_CTL_TX_BAD_CRC;
+            }
+#endif
+          self->ring->tx[self->txs].control = ctl;
+
+          OUTB (0x0, OBOE_ENABLEH);
+          /* It is only a timer. Do not send mtt packet outside! */
+          toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX | OBOE_CONFIG0H_LOOP);
+
+          self->txpending++;
+
+          self->txs++;
+          self->txs %= TX_SLOTS;
+
+        }
+      else
+        {
+          printk(KERN_ERR DRIVER_NAME ": problem with mtt packet - ignored\n");
+        }
+      spin_unlock_irqrestore(&self->spinlock, flags);
+    }
+
+#ifdef DUMP_PACKETS
+dumpbufs(skb->data,skb->len,'>'); 
+#endif
+
+  spin_lock_irqsave(&self->spinlock, flags);
+
+  if (self->ring->tx[self->txs].control & OBOE_CTL_TX_HW_OWNS)
+    {
+      IRDA_DEBUG (0, "%s.ful:%x(%x)%x\n", __FUNCTION__
+          ,skb->len, self->ring->tx[self->txs].control, self->txpending);
+      toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX);
+      spin_unlock_irqrestore(&self->spinlock, flags);
+      return -EBUSY;
+    }
+
+  if (INB (OBOE_ENABLEH) & OBOE_ENABLEH_SIRON)
+    {
+      len = async_wrap_skb (skb, self->tx_bufs[self->txs], TX_BUF_SZ);
+    }
+  else
+    {
+      len = skb->len;
+      memcpy (self->tx_bufs[self->txs], skb->data, len);
+    }
+  self->ring->tx[self->txs].len = len & 0x0fff;
+
+  /*Sometimes the HW doesn't see us assert RTCENTX in the interrupt code */
+  /*later this plays safe, we garuntee the last packet to be transmitted */
+  /*has RTCENTX set */
+
+  ctl = OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_RTCENTX;
+  if (INB (OBOE_ENABLEH) & OBOE_ENABLEH_FIRON)
+    {
+      ctl |= OBOE_CTL_TX_SIP ;
+    }
+  self->ring->tx[self->txs].control = ctl;
+
+  /* If transmitter is idle start in one-shot mode */
+
+  if (!self->txpending)
+      toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX);
+
+  self->txpending++;
+
+  self->txs++;
+  self->txs %= TX_SLOTS;
+
+  spin_unlock_irqrestore(&self->spinlock, flags);
+  dev_kfree_skb (skb);
+
+  return 0;
+}
+
+/*interrupt handler */
+STATIC void
+toshoboe_interrupt (int irq, void *dev_id, struct pt_regs *regs)
+{
+  struct toshoboe_cb *self = (struct toshoboe_cb *) dev_id;
+  __u8 irqstat;
+  struct sk_buff *skb = NULL;
+
+  if (self == NULL && toshoboe_invalid_dev(irq)) 
+    return;
+
+  irqstat = INB (OBOE_ISR);
+
+/* was it us */
+  if (!(irqstat & OBOE_INT_MASK))
+      return;
+
+/* Ack all the interrupts */
+  OUTB (irqstat, OBOE_ISR);
+
+  toshoboe_isntstuck (self);
+
+/* Txdone */
+  if (irqstat & OBOE_INT_TXDONE)
+    {
+      int txp, txpc;
+      int i;
+
+      txp = self->txpending;
+      self->txpending = 0;
+
+      for (i = 0; i < TX_SLOTS; ++i)
+        {
+          if (self->ring->tx[i].control & OBOE_CTL_TX_HW_OWNS)
+              self->txpending++;
+        }
+      IRDA_DEBUG (1, "%s.txd(%x)%x/%x\n", __FUNCTION__
+          ,irqstat,txp,self->txpending);
+
+      txp = INB (OBOE_TXSLOT) & OBOE_SLOT_MASK;
+
+      /* Got anything queued ? start it together */
+      if (self->ring->tx[txp].control & OBOE_CTL_TX_HW_OWNS)
+        {
+          txpc = txp;
+#ifdef OPTIMIZE_TX
+          while (self->ring->tx[txpc].control & OBOE_CTL_TX_HW_OWNS)
+            {
+              txp = txpc;
+              txpc++;
+              txpc %= TX_SLOTS;
+              self->stats.tx_packets++;
+              if (self->ring->tx[txpc].control & OBOE_CTL_TX_HW_OWNS)
+                  self->ring->tx[txp].control &= ~OBOE_CTL_TX_RTCENTX;
+            }
+          self->stats.tx_packets--;
+#else
+          self->stats.tx_packets++;
+#endif
+          toshoboe_start_DMA(self, OBOE_CONFIG0H_ENTX);
+        }
+
+      if ((!self->txpending) && (self->new_speed))
+        {
+          self->speed = self->new_speed;
+          IRDA_DEBUG (1, "%s: Executed TxDone scheduled speed change %d\n",
+		      __FUNCTION__, self->speed);
+          toshoboe_setbaud (self);
+        }
+
+      /* Tell network layer that we want more frames */
+      if (!self->new_speed)
+          netif_wake_queue(self->netdev);
+    }
+
+  if (irqstat & OBOE_INT_RXDONE)
+    {
+      while (!(self->ring->rx[self->rxs].control & OBOE_CTL_RX_HW_OWNS))
+        {
+          int len = self->ring->rx[self->rxs].len;
+          skb = NULL;
+          IRDA_DEBUG (3, "%s.rcv:%x(%x)\n", __FUNCTION__ 
+		      ,len,self->ring->rx[self->rxs].control);
+
+#ifdef DUMP_PACKETS
+dumpbufs(self->rx_bufs[self->rxs],len,'<');
+#endif
+
+          if (self->ring->rx[self->rxs].control == 0)
+            {
+              __u8 enable = INB (OBOE_ENABLEH);
+
+              /* In SIR mode we need to check the CRC as this */
+              /* hasn't been done by the hardware */
+              if (enable & OBOE_ENABLEH_SIRON)
+                {
+                  if (!toshoboe_checkfcs (self->rx_bufs[self->rxs], len))
+                      len = 0;
+                  /*Trim off the CRC */
+                  if (len > 1)
+                      len -= 2;
+                  else
+                      len = 0;
+                  IRDA_DEBUG (1, "%s.SIR:%x(%x)\n", __FUNCTION__, len,enable);
+                }
+
+#ifdef USE_MIR
+              else if (enable & OBOE_ENABLEH_MIRON)
+                {
+                  if (len > 1)
+                      len -= 2;
+                  else
+                      len = 0;
+                  IRDA_DEBUG (2, "%s.MIR:%x(%x)\n", __FUNCTION__, len,enable);
+                }
+#endif
+              else if (enable & OBOE_ENABLEH_FIRON)
+                {
+                  if (len > 3)
+                      len -= 4;   /*FIXME: check this */
+                  else
+                      len = 0;
+                  IRDA_DEBUG (1, "%s.FIR:%x(%x)\n", __FUNCTION__, len,enable);
+                }
+              else 
+                  IRDA_DEBUG (0, "%s.?IR:%x(%x)\n", __FUNCTION__, len,enable);
+
+              if (len)
+                {
+                  skb = dev_alloc_skb (len + 1);
+                  if (skb)
+                    {
+                      skb_reserve (skb, 1);
+
+                      skb_put (skb, len);
+                      memcpy (skb->data, self->rx_bufs[self->rxs], len);
+
+                      self->stats.rx_packets++;
+                      skb->dev = self->netdev;
+                      skb->mac.raw = skb->data;
+                      skb->protocol = htons (ETH_P_IRDA);
+                    }
+                  else
+                    {
+                      printk (KERN_INFO 
+                              "%s(), memory squeeze, dropping frame.\n",
+			      __FUNCTION__);
+                    }
+                }
+            }
+          else 
+            {
+            /* TODO: =========================================== */
+            /*  if OBOE_CTL_RX_LENGTH, our buffers are too small */
+            /* (MIR or FIR) data is lost. */
+            /* (SIR) data is splitted in several slots. */
+            /* we have to join all the received buffers received */
+            /*in a large buffer before checking CRC. */
+            IRDA_DEBUG (0, "%s.err:%x(%x)\n", __FUNCTION__
+                ,len,self->ring->rx[self->rxs].control);
+            }
+
+          self->ring->rx[self->rxs].len = 0x0;
+          self->ring->rx[self->rxs].control = OBOE_CTL_RX_HW_OWNS;
+
+          self->rxs++;
+          self->rxs %= RX_SLOTS;
+
+          if (skb)
+              netif_rx (skb);
+
+        }
+    }
+
+  if (irqstat & OBOE_INT_TXUNDER)
+    {
+      printk (KERN_WARNING DRIVER_NAME ": tx fifo underflow\n");
+    }
+  if (irqstat & OBOE_INT_RXOVER)
+    {
+      printk (KERN_WARNING DRIVER_NAME ": rx fifo overflow\n");
+    }
+/* This must be useful for something... */
+  if (irqstat & OBOE_INT_SIP)
+    {
+      self->int_sip++;
+      IRDA_DEBUG (1, "%s.sip:%x(%x)%x\n", __FUNCTION__
+	      ,self->int_sip,irqstat,self->txpending);
+    }
+}
+
+STATIC int
+toshoboe_net_init (struct net_device *dev)
+{
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  /* Setup to be a normal IrDA network device driver */
+  irda_device_setup (dev);
+
+  /* Insert overrides below this line! */
+  return 0;
+}
+
+STATIC int
+toshoboe_net_open (struct net_device *dev)
+{
+  struct toshoboe_cb *self;
+  unsigned long flags;
+
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  ASSERT (dev != NULL, return -1; );
+  self = (struct toshoboe_cb *) dev->priv;
+
+  ASSERT (self != NULL, return 0; );
+
+  if (self->async)
+    return -EBUSY;
+
+  if (self->stopped)
+    return 0;
+
+  if (request_irq (self->io.irq, toshoboe_interrupt,
+                   SA_SHIRQ | SA_INTERRUPT, dev->name, (void *) self))
+    {
+      return -EAGAIN;
+    }
+
+  spin_lock_irqsave(&self->spinlock, flags);
+  toshoboe_startchip (self);
+  spin_unlock_irqrestore(&self->spinlock, flags);
+
+  /* Ready to play! */
+  netif_start_queue(dev);
+
+  /*
+   * Open new IrLAP layer instance, now that everything should be
+   * initialized properly
+   */
+  self->irlap = irlap_open (dev, &self->qos, driver_name);
+
+  self->irdad = 1;
+
+  MOD_INC_USE_COUNT;
+
+  return 0;
+}
+
+STATIC int
+toshoboe_net_close (struct net_device *dev)
+{
+  struct toshoboe_cb *self;
+
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  ASSERT (dev != NULL, return -1; );
+  self = (struct toshoboe_cb *) dev->priv;
+
+  /* Stop device */
+  netif_stop_queue(dev);
+
+  /* Stop and remove instance of IrLAP */
+  if (self->irlap)
+    irlap_close (self->irlap);
+  self->irlap = NULL;
+
+  self->irdad = 0;
+
+  free_irq (self->io.irq, (void *) self);
+
+  if (!self->stopped)
+    {
+      toshoboe_stopchip (self);
+    }
+
+  MOD_DEC_USE_COUNT;
+
+  return 0;
+}
+
+/*
+ * Function toshoboe_net_ioctl (dev, rq, cmd)
+ *
+ *    Process IOCTL commands for this device
+ *
+ */
+STATIC int
+toshoboe_net_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
+{
+  struct if_irda_req *irq = (struct if_irda_req *) rq;
+  struct toshoboe_cb *self;
+  unsigned long flags;
+  int ret = 0;
+
+  ASSERT (dev != NULL, return -1; );
+
+  self = dev->priv;
+
+  ASSERT (self != NULL, return -1; );
+
+  IRDA_DEBUG (5, "%s(), %s, (cmd=0x%X)\n", __FUNCTION__, dev->name, cmd);
+
+  /* Disable interrupts & save flags */
+  spin_lock_irqsave(&self->spinlock, flags);
+
+  switch (cmd)
+    {
+    case SIOCSBANDWIDTH:       /* Set bandwidth */
+      /* This function will also be used by IrLAP to change the
+       * speed, so we still must allow for speed change within
+       * interrupt context.
+       */
+      IRDA_DEBUG (1, "%s(BANDWIDTH), %s, (%X/%ld\n", __FUNCTION__
+          ,dev->name, INB (OBOE_STATUS), irq->ifr_baudrate );
+      if (!in_interrupt () && !capable (CAP_NET_ADMIN))
+        return -EPERM;
+
+      /* self->speed=irq->ifr_baudrate; */
+      /* toshoboe_setbaud(self); */
+      /* Just change speed once - inserted by Paul Bristow */
+      self->new_speed = irq->ifr_baudrate;
+      break;
+    case SIOCSMEDIABUSY:       /* Set media busy */
+      IRDA_DEBUG (1, "%s(MEDIABUSY), %s, (%X/%x)\n", __FUNCTION__
+          ,dev->name, INB (OBOE_STATUS), capable (CAP_NET_ADMIN) );
+      if (!capable (CAP_NET_ADMIN))
+        return -EPERM;
+      irda_device_set_media_busy (self->netdev, TRUE);
+      break;
+    case SIOCGRECEIVING:       /* Check if we are receiving right now */
+      irq->ifr_receiving = (INB (OBOE_STATUS) & OBOE_STATUS_RXBUSY) ? 1 : 0;
+      IRDA_DEBUG (3, "%s(RECEIVING), %s, (%X/%x)\n", __FUNCTION__
+          ,dev->name, INB (OBOE_STATUS), irq->ifr_receiving );
+      break;
+    default:
+      IRDA_DEBUG (1, "%s(?), %s, (cmd=0x%X)\n", __FUNCTION__, dev->name, cmd);
+      ret = -EOPNOTSUPP;
+    }
+
+  spin_unlock_irqrestore(&self->spinlock, flags);
+  return ret;
+
+}
+
+MODULE_DESCRIPTION("Toshiba OBOE IrDA Device Driver");
+MODULE_AUTHOR("James McKenzie <james@fishsoup.dhs.org>");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM (max_baud, "i");
+MODULE_PARM_DESC(max_baud, "Maximum baud rate");
+
+MODULE_PARM (do_probe, "i");
+MODULE_PARM_DESC(do_probe, "Enable/disable chip probing and self-test");
+
+STATIC void
+toshoboe_close (struct pci_dev *pci_dev)
+{
+  int i;
+  struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
+
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  ASSERT (self != NULL, return; );
+
+  if (!self->stopped)
+    {
+      toshoboe_stopchip (self);
+    }
+
+  release_region (self->io.fir_base, self->io.fir_ext);
+
+  for (i = 0; i < TX_SLOTS; ++i)
+    {
+      kfree (self->tx_bufs[i]);
+      self->tx_bufs[i] = NULL;
+    }
+
+  for (i = 0; i < RX_SLOTS; ++i)
+    {
+      kfree (self->rx_bufs[i]);
+      self->rx_bufs[i] = NULL;
+    }
+
+  if (self->netdev)
+    {
+      /* Remove netdevice */
+      rtnl_lock ();
+      unregister_netdevice (self->netdev);
+      rtnl_unlock ();
+    }
+
+  kfree (self->ringbuf);
+  self->ringbuf = NULL;
+  self->ring = NULL;
+
+  return;
+}
+
+STATIC int
+toshoboe_open (struct pci_dev *pci_dev, const struct pci_device_id *pdid)
+{
+  struct toshoboe_cb *self;
+  struct net_device *dev;
+  int i = 0;
+  int ok = 0;
+  int err;
+
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  if ((err=pci_enable_device(pci_dev)))
+    return err;
+
+  self = kmalloc (sizeof (struct toshoboe_cb), GFP_KERNEL);
+
+  if (self == NULL)
+    {
+      printk (KERN_ERR DRIVER_NAME ": can't allocate memory for "
+              "IrDA control block\n");
+      return -ENOMEM;
+    }
+
+  memset (self, 0, sizeof (struct toshoboe_cb));
+
+  self->pdev = pci_dev;
+  self->base = pci_resource_start(pci_dev,0);
+
+  self->io.fir_base = self->base;
+  self->io.fir_ext = OBOE_IO_EXTENT;
+  self->io.irq = pci_dev->irq;
+  self->io.irqflags = SA_SHIRQ | SA_INTERRUPT;
+
+  self->speed = self->io.speed = 9600;
+  self->async = 0;
+
+  /* Lock the port that we need */
+  if (NULL==request_region (self->io.fir_base, self->io.fir_ext, driver_name))
+    {
+      printk (KERN_ERR DRIVER_NAME ": can't get iobase of 0x%03x\n"
+	      ,self->io.fir_base);
+      err = -EBUSY;
+      goto freeself;
+    }
+
+  spin_lock_init(&self->spinlock);
+  
+  irda_init_max_qos_capabilies (&self->qos);
+  self->qos.baud_rate.bits = 0;
+
+  if (max_baud >= 2400)
+    self->qos.baud_rate.bits |= IR_2400;
+  /*if (max_baud>=4800) idev->qos.baud_rate.bits|=IR_4800; */
+  if (max_baud >= 9600)
+    self->qos.baud_rate.bits |= IR_9600;
+  if (max_baud >= 19200)
+    self->qos.baud_rate.bits |= IR_19200;
+  if (max_baud >= 115200)
+    self->qos.baud_rate.bits |= IR_115200;
+#ifdef USE_MIR
+  if (max_baud >= 1152000)
+    {
+      self->qos.baud_rate.bits |= IR_1152000;
+      self->flags |= IFF_MIR;
+    }
+#endif
+  if (max_baud >= 4000000)
+    {
+      self->qos.baud_rate.bits |= (IR_4000000 << 8);
+      self->flags |= IFF_FIR;
+    }
+
+  /*FIXME: work this out... */
+  self->qos.min_turn_time.bits = 0xff;
+
+  irda_qos_bits_to_value (&self->qos);
+
+  self->flags = IFF_SIR | IFF_DMA | IFF_PIO;
+
+  /* Allocate twice the size to guarantee alignment */
+  self->ringbuf = (void *) kmalloc (OBOE_RING_LEN << 1, GFP_KERNEL);
+  if (!self->ringbuf)
+    {
+      printk (KERN_ERR DRIVER_NAME ": can't allocate DMA buffers\n");
+      err = -ENOMEM;
+      goto freeregion;
+    }
+
+  /*We need to align the taskfile on a taskfile size boundary */
+  {
+    __u32 addr;
+
+    addr = (__u32) self->ringbuf;
+    addr &= ~(OBOE_RING_LEN - 1);
+    addr += OBOE_RING_LEN;
+    self->ring = (struct OboeRing *) addr;
+  }
+
+  memset (self->ring, 0, OBOE_RING_LEN);
+  self->io.mem_base = (__u32) self->ring;
+
+  ok = 1;
+  for (i = 0; i < TX_SLOTS; ++i)
+    {
+      self->tx_bufs[i] = kmalloc (TX_BUF_SZ, GFP_KERNEL);
+      if (!self->tx_bufs[i])
+        ok = 0;
+    }
+
+  for (i = 0; i < RX_SLOTS; ++i)
+    {
+      self->rx_bufs[i] = kmalloc (RX_BUF_SZ, GFP_KERNEL);
+      if (!self->rx_bufs[i])
+        ok = 0;
+    }
+
+  if (!ok)
+    {
+      printk (KERN_ERR DRIVER_NAME ": can't allocate rx/tx buffers\n");
+      err = -ENOMEM;
+      goto freebufs;
+    }
+
+  if (do_probe)
+    if (!toshoboe_probe (self))
+      {
+        err = -ENODEV;
+        goto freebufs;
+      }
+
+  if (!(dev = dev_alloc ("irda%d", &err)))
+    {
+      printk (KERN_ERR DRIVER_NAME ": dev_alloc() failed\n");
+      err = -ENOMEM;
+      goto freebufs;
+    }
+
+  dev->priv = (void *) self;
+  self->netdev = dev;
+
+  printk (KERN_INFO "IrDA: Registered device %s\n", dev->name);
+
+  dev->init = toshoboe_net_init;
+  dev->hard_start_xmit = toshoboe_hard_xmit;
+  dev->open = toshoboe_net_open;
+  dev->stop = toshoboe_net_close;
+  dev->do_ioctl = toshoboe_net_ioctl;
+
+  rtnl_lock ();
+  err = register_netdevice (dev);
+  rtnl_unlock ();
+  if (err)
+    {
+      printk (KERN_ERR DRIVER_NAME ": register_netdev() failed\n");
+      err = -ENOMEM;
+      goto freebufs;
+    }
+
+  pci_set_drvdata(pci_dev,self);
+
+  printk (KERN_INFO DRIVER_NAME ": Using multiple tasks, version %s\n", rcsid);
+
+  return 0;
+
+freebufs:
+  for (i = 0; i < TX_SLOTS; ++i)
+    if (self->tx_bufs[i])
+      kfree (self->tx_bufs[i]);
+  for (i = 0; i < RX_SLOTS; ++i)
+    if (self->rx_bufs[i])
+      kfree (self->rx_bufs[i]);
+  kfree(self->ringbuf);
+
+freeregion:
+  release_region (self->io.fir_base, self->io.fir_ext);
+
+freeself:
+  kfree (self);
+
+  return err;
+}
+
+STATIC int
+toshoboe_gotosleep (struct pci_dev *pci_dev, u32 crap)
+{
+  struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
+  unsigned long flags;
+  int i = 10;
+
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  if (!self || self->stopped)
+    return 0;
+
+  if ((!self->irdad) && (!self->async))
+    return 0;
+
+/* Flush all packets */
+  while ((i--) && (self->txpending))
+    udelay (10000);
+
+  spin_lock_irqsave(&self->spinlock, flags);
+
+  toshoboe_stopchip (self);
+  self->stopped = 1;
+  self->txpending = 0;
+
+  spin_unlock_irqrestore(&self->spinlock, flags);
+  return 0;
+}
+
+STATIC int
+toshoboe_wakeup (struct pci_dev *pci_dev)
+{
+  struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
+  unsigned long flags;
+
+  IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
+
+  if (!self || !self->stopped)
+    return 0;
+
+  if ((!self->irdad) && (!self->async))
+    return 0;
+
+  spin_lock_irqsave(&self->spinlock, flags);
+
+  toshoboe_startchip (self);
+  self->stopped = 0;
+
+  netif_wake_queue(self->netdev);
+  spin_unlock_irqrestore(&self->spinlock, flags);
+  return 0;
+}
+
+static struct pci_driver toshoboe_pci_driver = {
+  name		: "toshoboe",
+  id_table	: toshoboe_pci_tbl,
+  probe		: toshoboe_open,
+  remove	: toshoboe_close,
+  suspend	: toshoboe_gotosleep,
+  resume	: toshoboe_wakeup 
+};
+
+int __init
+toshoboe_init (void)
+{
+  return pci_module_init(&toshoboe_pci_driver);
+}
+
+STATIC void __exit
+toshoboe_cleanup (void)
+{
+  pci_unregister_driver(&toshoboe_pci_driver);
+}
+
+module_init(toshoboe_init);
+module_exit(toshoboe_cleanup);
diff -u -p -r --new-file linux/drivers/net/irda.d2/donauboe.h linux/drivers/net/irda/donauboe.h
--- linux/drivers/net/irda.d2/donauboe.h	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/donauboe.h	Thu Sep 12 11:07:17 2002
@@ -0,0 +1,363 @@
+/*********************************************************************
+ *                
+ * Filename:      toshoboe.h
+ * Version:       2.16
+ * Description:   Driver for the Toshiba OBOE (or type-O or 701)
+ *                FIR Chipset, also supports the DONAUOBOE (type-DO
+ *                or d01) FIR chipset which as far as I know is
+ *                register compatible.
+ * Status:        Experimental.
+ * Author:        James McKenzie <james@fishsoup.dhs.org>
+ * Created at:    Sat May 8  12:35:27 1999
+ * Modified: 2.16 Martin Lucina <mato@kotelna.sk>
+ * Modified: 2.16 Sat Jun 22 18:54:29 2002 (sync headers)
+ * Modified: 2.17 Christian Gennerat <christian.gennerat@polytechnique.org>
+ * Modified: 2.17 jeu sep 12 08:50:20 2002 (add lock to be used by spinlocks)
+ * 
+ *     Copyright (c) 1999 James McKenzie, All Rights Reserved.
+ *      
+ *     This program is free software; you can redistribute it and/or 
+ *     modify it under the terms of the GNU General Public License as 
+ *     published by the Free Software Foundation; either version 2 of 
+ *     the License, or (at your option) any later version.
+ *  
+ *     Neither James McKenzie nor Cambridge University admit liability nor
+ *     provide warranty for any of this software. This material is 
+ *     provided "AS-IS" and at no charge.
+ * 
+ *     Applicable Models : Libretto 100/110CT and many more.
+ *     Toshiba refers to this chip as the type-O IR port,
+ *     or the type-DO IR port.
+ *
+ * IrDA chip set list from Toshiba Computer Engineering Corp.
+ * model			method	maker	controler		Version 
+ * Portege 320CT	FIR,SIR Toshiba Oboe(Triangle) 
+ * Portege 3010CT	FIR,SIR Toshiba Oboe(Sydney) 
+ * Portege 3015CT	FIR,SIR Toshiba Oboe(Sydney) 
+ * Portege 3020CT	FIR,SIR Toshiba Oboe(Sydney) 
+ * Portege 7020CT	FIR,SIR ?		?
+ * 
+ * Satell. 4090XCDT	FIR,SIR ?		?
+ * 
+ * Libretto 100CT	FIR,SIR Toshiba Oboe 
+ * Libretto 1000CT	FIR,SIR Toshiba Oboe 
+ * 
+ * TECRA750DVD		FIR,SIR Toshiba Oboe(Triangle)	REV ID=14h 
+ * TECRA780			FIR,SIR Toshiba Oboe(Sandlot)	REV ID=32h,33h 
+ * TECRA750CDT		FIR,SIR Toshiba Oboe(Triangle)	REV ID=13h,14h 
+ * TECRA8000		FIR,SIR Toshiba Oboe(ISKUR)		REV ID=23h 
+ * 
+ ********************************************************************/
+
+/* The documentation for this chip is allegedly released         */
+/* However I have not seen it, not have I managed to contact     */
+/* anyone who has. HOWEVER the chip bears a striking resemblence */
+/* to the IrDA controller in the Toshiba RISC TMPR3922 chip      */
+/* the documentation for this is freely available at             */
+/* http://www.toshiba.com/taec/components/Generic/TMPR3922.shtml */
+/* The mapping between the registers in that document and the    */
+/* Registers in the 701 oboe chip are as follows    */
+
+
+/* 3922 reg     701 regs, by bit numbers                        */
+/*               7- 0  15- 8  24-16  31-25                      */
+/* $28            0x0    0x1                                    */
+/* $2c                                     SEE NOTE 1           */
+/* $30            0x6    0x7                                    */
+/* $34            0x8    0x9               SEE NOTE 2           */
+/* $38           0x10   0x11                                    */
+/* $3C                   0xe               SEE NOTE 3           */
+/* $40           0x12   0x13                                    */
+/* $44           0x14   0x15                                    */
+/* $48           0x16   0x17                                    */
+/* $4c           0x18   0x19                                    */
+/* $50           0x1a   0x1b                                    */
+
+/* FIXME: could be 0x1b 0x1a here */
+
+/* $54           0x1d   0x1c                                    */
+/* $5C           0xf                       SEE NOTE 4           */
+/* $130                                    SEE NOTE 5           */
+/* $134                                    SEE NOTE 6           */
+/*                                                              */
+/* NOTES:                                                       */
+/* 1. The pointer to ring is packed in most unceremoniusly      */
+/*    701 Register      Address bits    (A9-A0 must be zero)    */
+/*            0x4:      A17 A16 A15 A14 A13 A12 A11 A10         */
+/*            0x5:      A25 A24 A23 A22 A21 A20 A19 A18         */
+/*            0x2:        0   0 A31 A30 A29 A28 A27 A26         */
+/*                                                              */
+/* 2. The M$ drivers do a write 0x1 to 0x9, however the 3922    */
+/*    documentation would suggest that a write of 0x1 to 0x8    */
+/*    would be more appropriate.                                */
+/*                                                              */
+/* 3. This assignment is tenuous at best, register 0xe seems to */
+/*    have bits arranged 0 0 0 R/W R/W R/W R/W R/W              */
+/*    if either of the lower two bits are set the chip seems to */
+/*    switch off                                                */
+/*                                                              */
+/* 4. Bits 7-4 seem to be different 4 seems just to be generic  */
+/*    receiver busy flag                                        */
+/*                                                              */
+/* 5. and 6. The IER and ISR have a different bit assignment    */
+/*    The lower three bits of both read back as ones            */
+/* ISR is register 0xc, IER is register 0xd                     */
+/*           7      6      5      4      3      2      1      0 */
+/* 0xc: TxDone RxDone TxUndr RxOver SipRcv      1      1      1 */
+/* 0xd: TxDone RxDone TxUndr RxOver SipRcv      1      1      1 */
+/* TxDone xmitt done (generated only if generate interrupt bit  */
+/*   is set in the ring)                                        */
+/* RxDone recv completed (or other recv condition if you set it */
+/*   up                                                         */
+/* TxUnder underflow in Transmit FIFO                           */
+/* RxOver  overflow in Recv FIFO                                */
+/* SipRcv  received serial gap  (or other condition you set)    */
+/* Interrupts are enabled by writing a one to the IER register  */
+/* Interrupts are cleared by writting a one to the ISR register */
+/*                                                              */
+/* 6. The remaining registers: 0x6 and 0x3 appear to be         */
+/*    reserved parts of 16 or 32 bit registersthe remainder     */
+/*    0xa 0xb 0x1e 0x1f could possibly be (by their behaviour)  */
+/*    the Unicast Filter register at $58.                       */
+/*                                                              */
+/* 7. While the core obviously expects 32 bit accesses all the  */
+/*    M$ drivers do 8 bit accesses, infact the Miniport ones    */
+/*    write and read back the byte serveral times (why?)        */
+
+
+#ifndef TOSHOBOE_H
+#define TOSHOBOE_H
+
+/* Registers */
+
+#define OBOE_IO_EXTENT	0x1f
+
+/*Receive and transmit slot pointers */
+#define OBOE_REG(i)	(i+(self->base))
+#define OBOE_RXSLOT	OBOE_REG(0x0)
+#define OBOE_TXSLOT	OBOE_REG(0x1)
+#define OBOE_SLOT_MASK	0x3f
+
+#define OBOE_TXRING_OFFSET		0x200
+#define OBOE_TXRING_OFFSET_IN_SLOTS	0x40
+
+/*pointer to the ring */
+#define OBOE_RING_BASE0	OBOE_REG(0x4)
+#define OBOE_RING_BASE1	OBOE_REG(0x5)
+#define OBOE_RING_BASE2	OBOE_REG(0x2)
+#define OBOE_RING_BASE3	OBOE_REG(0x3)
+
+/*Number of slots in the ring */
+#define OBOE_RING_SIZE  OBOE_REG(0x7)
+#define OBOE_RING_SIZE_RX4	0x00
+#define OBOE_RING_SIZE_RX8	0x01
+#define OBOE_RING_SIZE_RX16	0x03
+#define OBOE_RING_SIZE_RX32	0x07
+#define OBOE_RING_SIZE_RX64	0x0f
+#define OBOE_RING_SIZE_TX4	0x00
+#define OBOE_RING_SIZE_TX8	0x10
+#define OBOE_RING_SIZE_TX16	0x30
+#define OBOE_RING_SIZE_TX32	0x70
+#define OBOE_RING_SIZE_TX64	0xf0
+
+#define OBOE_RING_MAX_SIZE	64
+
+/*Causes the gubbins to re-examine the ring */
+#define OBOE_PROMPT	OBOE_REG(0x9)
+#define OBOE_PROMPT_BIT		0x1
+
+/* Interrupt Status Register */
+#define OBOE_ISR	OBOE_REG(0xc)
+/* Interrupt Enable Register */
+#define OBOE_IER	OBOE_REG(0xd)
+/* Interrupt bits for IER and ISR */
+#define OBOE_INT_TXDONE		0x80
+#define OBOE_INT_RXDONE		0x40
+#define OBOE_INT_TXUNDER	0x20
+#define OBOE_INT_RXOVER		0x10
+#define OBOE_INT_SIP		0x08
+#define OBOE_INT_MASK		0xf8
+
+/*Reset Register */
+#define OBOE_CONFIG1	OBOE_REG(0xe)
+#define OBOE_CONFIG1_RST	0x01
+#define OBOE_CONFIG1_DISABLE	0x02
+#define OBOE_CONFIG1_4		0x08
+#define OBOE_CONFIG1_8		0x08
+
+#define OBOE_CONFIG1_ON		0x8
+#define OBOE_CONFIG1_RESET	0xf
+#define OBOE_CONFIG1_OFF	0xe
+
+#define OBOE_STATUS	OBOE_REG(0xf)
+#define OBOE_STATUS_RXBUSY	0x10
+#define OBOE_STATUS_FIRRX	0x04
+#define OBOE_STATUS_MIRRX	0x02
+#define OBOE_STATUS_SIRRX	0x01
+
+
+/*Speed control registers */
+#define OBOE_CONFIG0L	OBOE_REG(0x10)
+#define OBOE_CONFIG0H	OBOE_REG(0x11)
+
+#define OBOE_CONFIG0H_TXONLOOP  0x80 /*Transmit when looping (dangerous) */
+#define OBOE_CONFIG0H_LOOP	0x40 /*Loopback Tx->Rx */
+#define OBOE_CONFIG0H_ENTX	0x10 /*Enable Tx */
+#define OBOE_CONFIG0H_ENRX	0x08 /*Enable Rx */
+#define OBOE_CONFIG0H_ENDMAC	0x04 /*Enable/reset* the DMA controller */
+#define OBOE_CONFIG0H_RCVANY	0x02 /*DMA mode 1=bytes, 0=dwords */
+
+#define OBOE_CONFIG0L_CRC16	0x80 /*CRC 1=16 bit 0=32 bit */
+#define OBOE_CONFIG0L_ENFIR	0x40 /*Enable FIR */
+#define OBOE_CONFIG0L_ENMIR	0x20 /*Enable MIR */
+#define OBOE_CONFIG0L_ENSIR	0x10 /*Enable SIR */
+#define OBOE_CONFIG0L_ENSIRF	0x08 /*Enable SIR framer */
+#define OBOE_CONFIG0L_SIRTEST	0x04 /*Enable SIR framer in MIR and FIR */
+#define OBOE_CONFIG0L_INVERTTX  0x02 /*Invert Tx Line */
+#define OBOE_CONFIG0L_INVERTRX  0x01 /*Invert Rx Line */
+
+#define OBOE_BOF	OBOE_REG(0x12)
+#define OBOE_EOF	OBOE_REG(0x13)
+
+#define OBOE_ENABLEL	OBOE_REG(0x14)
+#define OBOE_ENABLEH	OBOE_REG(0x15)
+
+#define OBOE_ENABLEH_PHYANDCLOCK	0x80 /*Toggle low to copy config in */
+#define OBOE_ENABLEH_CONFIGERR		0x40
+#define OBOE_ENABLEH_FIRON		0x20
+#define OBOE_ENABLEH_MIRON		0x10
+#define OBOE_ENABLEH_SIRON		0x08
+#define OBOE_ENABLEH_ENTX		0x04
+#define OBOE_ENABLEH_ENRX		0x02
+#define OBOE_ENABLEH_CRC16		0x01
+
+#define OBOE_ENABLEL_BROADCAST		0x01
+
+#define OBOE_CURR_PCONFIGL		OBOE_REG(0x16) /*Current config */
+#define OBOE_CURR_PCONFIGH		OBOE_REG(0x17)
+
+#define OBOE_NEW_PCONFIGL		OBOE_REG(0x18)
+#define OBOE_NEW_PCONFIGH		OBOE_REG(0x19)
+
+#define OBOE_PCONFIGH_BAUDMASK		0xfc
+#define OBOE_PCONFIGH_WIDTHMASK		0x04
+#define OBOE_PCONFIGL_WIDTHMASK		0xe0
+#define OBOE_PCONFIGL_PREAMBLEMASK	0x1f
+
+#define OBOE_PCONFIG_BAUDMASK		0xfc00
+#define OBOE_PCONFIG_BAUDSHIFT		10
+#define OBOE_PCONFIG_WIDTHMASK		0x04e0
+#define OBOE_PCONFIG_WIDTHSHIFT		5
+#define OBOE_PCONFIG_PREAMBLEMASK	0x001f
+#define OBOE_PCONFIG_PREAMBLESHIFT	0
+
+#define OBOE_MAXLENL			OBOE_REG(0x1a)
+#define OBOE_MAXLENH			OBOE_REG(0x1b)
+
+#define OBOE_RXCOUNTH			OBOE_REG(0x1c) /*Reset on recipt */
+#define OBOE_RXCOUNTL			OBOE_REG(0x1d) /*of whole packet */
+
+/* The PCI ID of the OBOE chip */
+#ifndef PCI_DEVICE_ID_FIR701
+#define PCI_DEVICE_ID_FIR701 	0x0701
+#endif
+
+#ifndef PCI_DEVICE_ID_FIRD01
+#define PCI_DEVICE_ID_FIRD01 	0x0d01
+#endif
+
+struct OboeSlot
+{
+  __u16 len;                    /*Tweleve bits of packet length */
+  __u8 unused;
+  __u8 control;                 /*Slot control/status see below */
+  __u32 address;                /*Slot buffer address */
+}
+__attribute__ ((packed));
+
+#define OBOE_NTASKS OBOE_TXRING_OFFSET_IN_SLOTS
+
+struct OboeRing
+{
+  struct OboeSlot rx[OBOE_NTASKS];
+  struct OboeSlot tx[OBOE_NTASKS];
+};
+
+#define OBOE_RING_LEN (sizeof(struct OboeRing))
+
+
+#define OBOE_CTL_TX_HW_OWNS	0x80 /*W/R This slot owned by the hardware */
+#define OBOE_CTL_TX_DISTX_CRC	0x40 /*W Disable CRC generation for [FM]IR */
+#define OBOE_CTL_TX_BAD_CRC     0x20 /*W Generate bad CRC */
+#define OBOE_CTL_TX_SIP		0x10   /*W Generate an SIP after xmittion */
+#define OBOE_CTL_TX_MKUNDER	0x08 /*W Generate an underrun error */
+#define OBOE_CTL_TX_RTCENTX	0x04 /*W Enable receiver and generate TXdone */
+     /*  After this slot is processed        */
+#define OBOE_CTL_TX_UNDER	0x01  /*R Set by hardware to indicate underrun */
+
+
+#define OBOE_CTL_RX_HW_OWNS	0x80 /*W/R This slot owned by hardware */
+#define OBOE_CTL_RX_PHYERR	0x40 /*R Decoder error on receiption */
+#define OBOE_CTL_RX_CRCERR	0x20 /*R CRC error only set for [FM]IR */
+#define OBOE_CTL_RX_LENGTH	0x10 /*R Packet > max Rx length  */
+#define OBOE_CTL_RX_OVER	0x08   /*R set to indicate an overflow */
+#define OBOE_CTL_RX_SIRBAD	0x04 /*R SIR had BOF in packet or ABORT sequence */
+#define OBOE_CTL_RX_RXEOF	0x02  /*R Finished receiving on this slot */
+
+
+struct toshoboe_cb
+{
+  struct net_device *netdev;    /* Yes! we are some kind of netdevice */
+  struct net_device_stats stats;
+  struct tty_driver ttydev;
+
+  struct irlap_cb *irlap;       /* The link layer we are binded to */
+
+  chipio_t io;                  /* IrDA controller information */
+  struct qos_info qos;          /* QoS capabilities for this device */
+
+  __u32 flags;                  /* Interface flags */
+
+  struct pci_dev *pdev;         /*PCI device */
+  int base;                     /*IO base */
+
+
+  int txpending;                /*how many tx's are pending */
+  int txs, rxs;                 /*Which slots are we at  */
+
+  int irdad;                    /*Driver under control of netdev end  */
+  int async;                    /*Driver under control of async end   */
+
+
+  int stopped;                  /*Stopped by some or other APM stuff */
+
+  int filter;                   /*In SIR mode do we want to receive
+                                   frames or byte ranges */
+
+  void *ringbuf;                /*The ring buffer */
+  struct OboeRing *ring;        /*The ring */
+
+  void *tx_bufs[OBOE_RING_MAX_SIZE]; /*The buffers   */
+  void *rx_bufs[OBOE_RING_MAX_SIZE];
+
+
+  int speed;                    /*Current setting of the speed */
+  int new_speed;                /*Set to request a speed change */
+
+/* The spinlock protect critical parts of the driver.
+ *	Locking is done like this :
+ *		spin_lock_irqsave(&self->spinlock, flags);
+ *	Releasing the lock :
+ *		spin_unlock_irqrestore(&self->spinlock, flags);
+ */
+  spinlock_t spinlock;		
+  /* Used for the probe and diagnostics code */
+  int int_rx;
+  int int_tx;
+  int int_txunder;
+  int int_rxover;
+  int int_sip;
+};
+
+
+#endif
