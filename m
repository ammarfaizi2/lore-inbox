Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280656AbRKNPpU>; Wed, 14 Nov 2001 10:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280660AbRKNPpF>; Wed, 14 Nov 2001 10:45:05 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:36359 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id <S280656AbRKNPoq>; Wed, 14 Nov 2001 10:44:46 -0500
Message-ID: <00df01c16d23$b409ab20$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <tytso@mit.edu>, <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Fw: [Patch] Some updates to serial-5.05
Date: Wed, 14 Nov 2001 10:47:44 -0500
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Stuart MacDonald" <stuartm@connecttech.com>
> Patches for are for serial-5.05. Descriptions are listed in order of
> application.

Same patches, attached inline to avoid OE mangling.

Apologies,
..Stu

> Tested with 2.2.0 - 2.2.20 and 2.4.0 - 2.4.14 (except 2.4.11).
>
> patch-kernel: Adds 485 ioctls to the kernel proper
>
> patch-serial-485: Adds 485 line mode switiching functionality to the
> serial driver. Note: this is not 485 protocol-level support, but
> electrical-level support.
>
> patch-serial-16850: Adds detection of the XR16C2850.
>
> patch-serial-fctr: Fixes a bug where serial-5.05 wasn't preserving an
> important bit in the fctr register when setting fifo triggers.
>
> patch-serial-devfs: Driver now reports the /dev entries in a manner
> consistent with how they are created. Yes, we have had customers who
> were thrown off by the discrepancy between ttyS00 and ttyS0.
>
> patch-serial-24x: serial-5.05 now finds our MULTISERIAL class boards.
> Also adds serial_compat.h for all 2.4.x kernels I've tested it with.
> This is necessary to compile in 2.4.x kernels.
>
> patch-serial-22x: Fixes serial_compat.h to work correctly. Pci #ifdefs
> used to be added based on whether the vendor id was defined or not.
> This doesn't work when a single device identifier is missing, but the
> vendor id exists. All pci defines are now checked one at a time. Yes
> this makes the source bigger and the compile longer, but it is the
> correct general way.
>
> patch-serial-init: Fixes the serial driver to not have the multiple
> rs_init() problem on the affected kernels. At the moment, this is
> 2.2.18, 19 and 20.

--- kernel ---

diff -ru linux-2.2.14/include/asm-i386/ioctls.h
linux-2214/include/asm-i386/ioctls.h
--- linux-2.2.14/include/asm-i386/ioctls.h Fri Jul 24 14:10:16 1998
+++ linux-2214/include/asm-i386/ioctls.h Thu Jul 13 12:25:52 2000
@@ -68,6 +68,14 @@
 #define TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
 #define TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */

+#define TIOCSER485SET 0x54A0 /* Set the 485 line mode */
+#define TIOCSER485GET 0x54A1 /* Get the 485 line mode */
+
+#define TIOCSER485NOT_INITED  0
+#define TIOCSER485FULLDUPLEX  1
+#define TIOCSER485HALFDUPLEX  2
+#define TIOCSER485SLAVEMULTIPLEX 3
+
 /* Used for packet mode */
 #define TIOCPKT_DATA   0
 #define TIOCPKT_FLUSHREAD  1

--- 485 ---

diff -ru serial-5.05/serial.c serial-5.05-485/serial.c
--- serial-5.05/serial.c Thu Sep 14 12:40:26 2000
+++ serial-5.05-485/serial.c Wed Jun 27 19:18:37 2001
@@ -1405,6 +1405,9 @@
   */
  mod_timer(&serial_timer, jiffies + 2*HZ/100);

+ if (state->lmode_fn)
+  (state->lmode_fn)(state, TIOCSER485SET, NULL);
+
  /*
   * Set up the tty->alt_speed kludge
   */
@@ -2511,6 +2514,7 @@
       unsigned int cmd, unsigned long arg)
 {
  struct async_struct * info = (struct async_struct *)tty->driver_data;
+ struct serial_state * state = info->state;
  struct async_icount cprev, cnow; /* kernel counter temps */
  struct serial_icounter_struct icount;
  unsigned long flags;
@@ -2568,6 +2572,13 @@
      (tmp ? CLOCAL : 0));
    return 0;
 #endif
+  case TIOCSER485GET:
+  case TIOCSER485SET:
+   if (state->lmode_fn)
+    return (state->lmode_fn)(state, cmd,
+       (unsigned int *) arg);
+   else
+    return -EINVAL;
   case TIOCMGET:
    return get_modem_info(info, (unsigned int *) arg);
   case TIOCMBIS:
@@ -3957,6 +3968,7 @@
   if (line < 0)
    break;
   rs_table[line].baud_base = base_baud;
+  rs_table[line].lmode_fn = board->lmode_fn;
  }
 }
 #endif /* ENABLE_SERIAL_PCI || ENABLE_SERIAL_PNP */
@@ -4176,6 +4188,121 @@
  return 0;
 }

+/*
+ * cti485 does the work. _2 and _4 do checking for the hybrid boards.
+ * They rely on the fact that the ports will start at a 256 aligned
+ * address to calculate which port on the board it is.
+ */
+int pci_cti485(struct serial_state *state, int ioctl, unsigned int *value)
{
+ struct async_struct *info;
+ unsigned char port_offset;
+ unsigned char portmask;
+ unsigned char txctl_offset;
+ unsigned char rxctl_offset;
+ unsigned char differ_offset;
+ unsigned char bits;
+ unsigned long flags;
+
+ if (ioctl == TIOCSER485GET)
+  return put_user(state->lmode, value);
+
+ info = state->info;
+ port_offset = state->port % 0x100;
+ portmask = 1 << port_offset / 0x08;
+ txctl_offset = 0x6c - port_offset;
+ rxctl_offset = 0x70 - port_offset;
+
+ save_flags(flags); cli();
+ if (value)
+  state->lmode = *value;
+ else if (state->lmode == TIOCSER485NOT_INITED) {
+  differ_offset = 0x74 - port_offset;
+  bits = serial_in(info, differ_offset);
+  switch (bits) {
+   case 0x03:
+    state->lmode = TIOCSER485SLAVEMULTIPLEX;
+    break;
+   default:
+    state->lmode = TIOCSER485FULLDUPLEX;
+    break;
+  }
+ }
+ bits = serial_in(info, txctl_offset);
+ switch (state->lmode) {
+  default:
+  case TIOCSER485FULLDUPLEX:
+   bits &= ~portmask;
+   serial_out(info, txctl_offset, bits);
+
+   bits = serial_in(info, rxctl_offset);
+   bits |= portmask;
+   serial_out(info, rxctl_offset, bits);
+
+   serial_out(info, UART_LCR, 0xbf);
+   bits = serial_in(info, UART_FCTR);
+   bits &= ~UART_FCTR_TX_INT;
+   serial_out(info, UART_FCTR, bits);
+   serial_out(info, UART_LCR, 0);
+
+   restore_flags(flags);
+   return put_user(1, value);
+  case TIOCSER485HALFDUPLEX:
+   bits |= portmask;
+   serial_out(info, txctl_offset, bits);
+
+   bits = serial_in(info, rxctl_offset);
+   bits &= ~portmask;
+   serial_out(info, rxctl_offset, bits);
+
+   serial_out(info, UART_LCR, 0xbf);
+   bits = serial_in(info, UART_FCTR);
+   bits |= UART_FCTR_TX_INT;
+   serial_out(info, UART_FCTR, bits);
+   serial_out(info, UART_LCR, 0);
+
+   restore_flags(flags);
+   return put_user(1, value);
+  case TIOCSER485SLAVEMULTIPLEX:
+   bits |= portmask;
+   serial_out(info, txctl_offset, bits);
+
+   bits = serial_in(info, rxctl_offset);
+   bits |= portmask;
+   serial_out(info, rxctl_offset, bits);
+
+   serial_out(info, UART_LCR, 0xbf);
+   bits = serial_in(info, UART_FCTR);
+   bits |= UART_FCTR_TX_INT;
+   serial_out(info, UART_FCTR, bits);
+   serial_out(info, UART_LCR, 0);
+
+   restore_flags(flags);
+   return put_user(1, value);
+ }
+
+ restore_flags(flags);
+ return -EINVAL;
+}
+
+int pci_cti485_4(struct serial_state *state, int ioctl, unsigned int
*value) {
+ int port = state->port;
+ int board_num = (port % 0x100) / 0x08;
+
+ if (board_num < 4)
+  return -ENOSYS;
+
+ return pci_cti485(state, ioctl, value);
+}
+
+int pci_cti485_2(struct serial_state *state, int ioctl, unsigned int
*value) {
+ int port = state->port;
+ int board_num = (port % 0x100) / 0x08;
+
+ if (board_num < 2)
+  return -ENOSYS;
+
+ return pci_cti485(state, ioctl, value);
+}

 /*
  * This is the configuration table for all of the PCI serial boards
@@ -4217,35 +4344,43 @@
  { PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
   PCI_SUBVENDOR_ID_CONNECT_TECH,
   PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485,
-  SPCI_FL_BASE1, 8, 921600 },
+  SPCI_FL_BASE1, 8, 921600,
+  0, 0, NULL, 0, pci_cti485 },
  { PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
   PCI_SUBVENDOR_ID_CONNECT_TECH,
   PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_4_4,
-  SPCI_FL_BASE1, 8, 921600 },
+  SPCI_FL_BASE1, 8, 921600,
+  0, 0, NULL, 0, pci_cti485_4 },
  { PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
   PCI_SUBVENDOR_ID_CONNECT_TECH,
   PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485,
-  SPCI_FL_BASE1, 4, 921600 },
+  SPCI_FL_BASE1, 4, 921600,
+  0, 0, NULL, 0, pci_cti485 },
  { PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
   PCI_SUBVENDOR_ID_CONNECT_TECH,
   PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485_2_2,
-  SPCI_FL_BASE1, 4, 921600 },
+  SPCI_FL_BASE1, 4, 921600,
+  0, 0, NULL, 0, pci_cti485_2 },
  { PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
   PCI_SUBVENDOR_ID_CONNECT_TECH,
   PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_485,
-  SPCI_FL_BASE1, 2, 921600 },
+  SPCI_FL_BASE1, 2, 921600,
+  0, 0, NULL, 0, pci_cti485 },
  { PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
   PCI_SUBVENDOR_ID_CONNECT_TECH,
   PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_2_6,
-  SPCI_FL_BASE1, 8, 921600 },
+  SPCI_FL_BASE1, 8, 921600,
+  0, 0, NULL, 0, pci_cti485_2 },
  { PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
   PCI_SUBVENDOR_ID_CONNECT_TECH,
   PCI_SUBDEVICE_ID_CONNECT_TECH_BH081101V1,
-  SPCI_FL_BASE1, 8, 921600 },
+  SPCI_FL_BASE1, 8, 921600,
+  0, 0, NULL, 0, pci_cti485 },
  { PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
   PCI_SUBVENDOR_ID_CONNECT_TECH,
   PCI_SUBDEVICE_ID_CONNECT_TECH_BH041101V1,
-  SPCI_FL_BASE1, 4, 921600 },
+  SPCI_FL_BASE1, 4, 921600,
+  0, 0, NULL, 0, pci_cti485 },
  { PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_U530,
   PCI_ANY_ID, PCI_ANY_ID,
   SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 1, 115200 },
diff -ru serial-5.05/serialP.h serial-5.05-485/serialP.h
--- serial-5.05/serialP.h Tue Jul 25 23:39:02 2000
+++ serial-5.05-485/serialP.h Wed Jun 27 19:10:27 2001
@@ -51,6 +51,8 @@
  struct termios  normal_termios;
  struct termios  callout_termios;
  int io_type;
+ int (*lmode_fn)(struct serial_state *state, int ioctl, unsigned int
*value);
+ int lmode;
  struct async_struct *info;
 };

@@ -153,6 +155,7 @@
  int (*init_fn)(struct pci_dev *dev, struct pci_board *board,
    int enable);
  int first_uart_offset;
+ int (*lmode_fn)(struct serial_state *state, int ioctl, unsigned int
*value);
 };

 struct pci_board_inst {

--- 16580 ---

diff -ru serial-5.05-485/serial.c serial-5.05-16850/serial.c
--- serial-5.05-485/serial.c Wed Jun 27 19:18:37 2001
+++ serial-5.05-16850/serial.c Wed Jun 27 19:22:36 2001
@@ -3548,8 +3548,12 @@
   * We check for a XR16C850 by setting DLL and DLM to 0, and
   * then reading back DLL and DLM.  If DLM reads back 0x10,
   * then the UART is a XR16C850 and the DLL contains the chip
-  * revision.  If DLM reads back 0x14, then the UART is a
-  * XR16C854.
+  * revision. If DLM reads back 0x12, then the UART is a
+  * XR16C2850. If DLM reads back 0x14, then the UART is a
+  * XR16C854 or XR16C864. All are functionally equivalent; in
+  * terms of this driver (some are dual or quad uart chips, but
+  * this driver addresses them on a per port basis anyway, so
+  * that only matters to the hardware designers).
   *
   */
  serial_outp(info, UART_LCR, UART_LCR_DLAB);
@@ -3558,7 +3562,7 @@
  state->revision = serial_inp(info, UART_DLL);
  scratch = serial_inp(info, UART_DLM);
  serial_outp(info, UART_LCR, 0);
- if (scratch == 0x10 || scratch == 0x14) {
+ if (scratch == 0x10 || scratch == 0x12 || scratch == 0x14) {
   state->type = PORT_16850;
   return;
  }

--- fctr ---

diff -ru serial-5.05-16850/serial.c serial-5.05-fctr/serial.c
--- serial-5.05-16850/serial.c Tue Oct 23 17:24:58 2001
+++ serial-5.05-fctr/serial.c Tue Oct 23 17:41:20 2001
@@ -1230,11 +1230,17 @@
    * For a XR16C850, we need to set the trigger levels
    */
   if (state->type == PORT_16850) {
-   serial_outp(info, UART_FCTR, UART_FCTR_TRGD |
-     UART_FCTR_RX);
+   unsigned char fctr;
+
+   fctr = serial_inp(info, UART_FCTR);
+   fctr |= UART_FCTR_TRGD;
+
+   fctr &= ~UART_FCTR_TX;
+   serial_outp(info, UART_FCTR, fctr);
    serial_outp(info, UART_TRG, UART_TRG_96);
-   serial_outp(info, UART_FCTR, UART_FCTR_TRGD |
-     UART_FCTR_TX);
+
+   fctr |= UART_FCTR_TX;
+   serial_outp(info, UART_FCTR, fctr);
    serial_outp(info, UART_TRG, UART_TRG_96);
   }
   serial_outp(info, UART_LCR, 0);

--- devfs ---

diff -ru serial-5.05-fctr/serial.c serial-5.05-devfs/serial.c
--- serial-5.05-fctr/serial.c Tue Oct 23 17:41:20 2001
+++ serial-5.05-devfs/serial.c Tue Oct 23 17:44:23 2001
@@ -5397,7 +5397,7 @@
       && (state->flags & ASYNC_AUTO_IRQ)
       && (state->port != 0))
    state->irq = detect_uart_irq(state);
-  printk(KERN_INFO "ttyS%02d%s at 0x%04lx (irq = %d) is a %s\n",
+  printk(KERN_INFO "ttyS%d%s at 0x%04lx (irq = %d) is a %s\n",
          state->line + SERIAL_DEV_OFFSET,
          (state->flags & ASYNC_FOURPORT) ? " FourPort" : "",
          state->port, state->irq,
@@ -5504,7 +5504,7 @@
  if ((state->flags & ASYNC_AUTO_IRQ) && CONFIGURED_SERIAL_PORT(state))
   state->irq = detect_uart_irq(state);

-       printk(KERN_INFO "ttyS%02d at %s 0x%04lx (irq = %d) is a %s\n",
+       printk(KERN_INFO "ttyS%d at %s 0x%04lx (irq = %d) is a %s\n",
        state->line + SERIAL_DEV_OFFSET,
        state->iomem_base ? "iomem" : "port",
        state->iomem_base ? (unsigned long)state->iomem_base :

--- 24x ---

diff -ru serial-5.05-devfs/serial.c serial-5.05-24x/serial.c
--- serial-5.05-devfs/serial.c Tue Oct 23 17:44:23 2001
+++ serial-5.05-24x/serial.c Tue Oct 23 17:49:08 2001
@@ -216,7 +216,7 @@
  * All of the compatibilty code so we can compile serial.c against
  * older kernels is hidden in serial_compat.h
  */
-#if defined(LOCAL_HEADERS) || (LINUX_VERSION_CODE < 0x020317) /* 2.3.23 */
+#if defined(LOCAL_HEADERS) || (LINUX_VERSION_CODE <= 0x02040E) /* 2.4.14 */
 #include "serial_compat.h"
 #endif

@@ -4800,6 +4800,8 @@
 static struct pci_device_id serial_pci_tbl[] __devinitdata = {
        { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
   PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00, },
+       { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+  PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00, },
        { 0, }
 };

diff -ru serial-5.05-devfs/serial_compat.h serial-5.05-24x/serial_compat.h
--- serial-5.05-devfs/serial_compat.h Thu Sep 14 11:16:06 2000
+++ serial-5.05-24x/serial_compat.h Tue Oct 23 17:50:59 2001
@@ -276,6 +276,10 @@
  * Some PCI identifiers which might not be in pci.h
  */

+#ifndef PCI_CLASS_COMMUNICATION_MULTISERIAL
+#define PCI_CLASS_COMMUNICATION_MULTISERIAL 0x0702
+#endif
+
 #ifndef PCI_VENDOR_ID_V3
 #define PCI_VENDOR_ID_V3  0x11b0
 #define PCI_DEVICE_ID_V3_V960  0x0001

--- 22x ---

diff -ru serial-5.05-24x/serial_compat.h serial-5.05-22x/serial_compat.h
--- serial-5.05-24x/serial_compat.h Wed Oct 24 21:37:56 2001
+++ serial-5.05-22x/serial_compat.h Wed Oct 24 21:46:56 2001
@@ -279,212 +279,360 @@
 #ifndef PCI_CLASS_COMMUNICATION_MULTISERIAL
 #define PCI_CLASS_COMMUNICATION_MULTISERIAL 0x0702
 #endif
-
 #ifndef PCI_VENDOR_ID_V3
 #define PCI_VENDOR_ID_V3  0x11b0
+#endif
+#ifndef PCI_DEVICE_ID_V3_V960
 #define PCI_DEVICE_ID_V3_V960  0x0001
+#endif
+#ifndef PCI_DEVICE_ID_V3_V350
 #define PCI_DEVICE_ID_V3_V350  0x0001
+#endif
+#ifndef PCI_DEVICE_ID_V3_V961
 #define PCI_DEVICE_ID_V3_V961  0x0002
+#endif
+#ifndef PCI_DEVICE_ID_V3_V351
 #define PCI_DEVICE_ID_V3_V351  0x0002
 #endif
-
 #ifndef PCI_VENDOR_ID_SEALEVEL
 #define PCI_VENDOR_ID_SEALEVEL  0x135e
+#endif
+#ifndef PCI_DEVICE_ID_SEALEVEL_U530
 #define PCI_DEVICE_ID_SEALEVEL_U530 0x7101
+#endif
+#ifndef PCI_DEVICE_ID_SEALEVEL_UCOMM2
 #define PCI_DEVICE_ID_SEALEVEL_UCOMM2 0x7201
+#endif
+#ifndef PCI_DEVICE_ID_SEALEVEL_UCOMM422
 #define PCI_DEVICE_ID_SEALEVEL_UCOMM422 0x7402
+#endif
+#ifndef PCI_DEVICE_ID_SEALEVEL_UCOMM232
 #define PCI_DEVICE_ID_SEALEVEL_UCOMM232 0x7202
+#endif
+#ifndef PCI_DEVICE_ID_SEALEVEL_COMM4
 #define PCI_DEVICE_ID_SEALEVEL_COMM4 0x7401
+#endif
+#ifndef PCI_DEVICE_ID_SEALEVEL_COMM8
 #define PCI_DEVICE_ID_SEALEVEL_COMM8 0x7801
 #endif
-
 #ifndef PCI_SUBVENDOR_ID_CONNECT_TECH
 #define PCI_SUBVENDOR_ID_CONNECT_TECH   0x12c4
+#endif
+#ifndef PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232
 #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232  0x0001
+#endif
+#ifndef PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232
 #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232  0x0002
+#endif
+#ifndef PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232
 #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232  0x0003
+#endif
+#ifndef PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485
 #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485  0x0004
+#endif
+#ifndef PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_4_4
 #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_4_4 0x0005
+#endif
+#ifndef PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485
 #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485  0x0006
+#endif
+#ifndef PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485_2_2
 #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485_2_2 0x0007
+#endif
+#ifndef PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_485
 #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_485  0x0008
+#endif
+#ifndef PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_2_6
 #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_2_6 0x0009
+#endif
+#ifndef PCI_SUBDEVICE_ID_CONNECT_TECH_BH081101V1
 #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH081101V1 0x000A
+#endif
+#ifndef PCI_SUBDEVICE_ID_CONNECT_TECH_BH041101V1
 #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH041101V1 0x000B
 #endif
-
 #ifndef PCI_SUBVENDOR_ID_KEYSPAN
 #define PCI_SUBVENDOR_ID_KEYSPAN    0x11a9
+#endif
+#ifndef PCI_SUBDEVICE_ID_KEYSPAN_SX2
 #define PCI_SUBDEVICE_ID_KEYSPAN_SX2   0x5334
 #endif
-
 #ifndef PCI_DEVICE_ID_PLX_GTEK_SERIAL2
 #define PCI_DEVICE_ID_PLX_GTEK_SERIAL2 0xa001
 #endif
-
 #ifndef PCI_DEVICE_ID_PLX_SPCOM200
 #define PCI_DEVICE_ID_PLX_SPCOM200 0x1103
 #endif
-
 #ifndef PCI_DEVICE_ID_PLX_SPCOM800
 #define PCI_DEVICE_ID_PLX_SPCOM800 0x1076
 #endif
-
 #ifndef PCI_VENDOR_ID_PLX_ROMULUS
 #define PCI_VENDOR_ID_PLX_ROMULUS 0x106a
 #endif
-
 #ifndef PCI_DEVICE_ID_PLX_SPCOM800
 #define PCI_DEVICE_ID_PLX_SPCOM800 0x1076
 #endif
-
 #ifndef PCI_DEVICE_ID_PLX_1077
 #define PCI_DEVICE_ID_PLX_1077  0x1077
 #endif
-
 #ifndef PCI_VENDOR_ID_TITAN
 #define PCI_VENDOR_ID_TITAN  0x14D2
+#endif
+#ifndef PCI_DEVICE_ID_TITAN_100
 #define PCI_DEVICE_ID_TITAN_100  0xA001
+#endif
+#ifndef PCI_DEVICE_ID_TITAN_200
 #define PCI_DEVICE_ID_TITAN_200  0xA005
+#endif
+#ifndef PCI_DEVICE_ID_TITAN_400
 #define PCI_DEVICE_ID_TITAN_400  0xA003
+#endif
+#ifndef PCI_DEVICE_ID_TITAN_800B
 #define PCI_DEVICE_ID_TITAN_800B 0xA004
 #endif
-
 #ifndef PCI_VENDOR_ID_PANACOM
 #define PCI_VENDOR_ID_PANACOM             0x14d4
+#endif
+#ifndef PCI_DEVICE_ID_PANACOM_QUADMODEM
 #define PCI_DEVICE_ID_PANACOM_QUADMODEM   0x0400
+#endif
+#ifndef PCI_DEVICE_ID_PANACOM_DUALMODEM
 #define PCI_DEVICE_ID_PANACOM_DUALMODEM   0x0402
 #endif
-
 #ifndef PCI_SUBVENDOR_ID_CHASE_PCIFAST
 #define PCI_SUBVENDOR_ID_CHASE_PCIFAST  0x12E0
+#endif
+#ifndef PCI_SUBDEVICE_ID_CHASE_PCIFAST4
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST4  0x0031
+#endif
+#ifndef PCI_SUBDEVICE_ID_CHASE_PCIFAST8
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST8  0x0021
+#endif
+#ifndef PCI_SUBDEVICE_ID_CHASE_PCIFAST16
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST16 0x0011
+#endif
+#ifndef PCI_SUBDEVICE_ID_CHASE_PCIFAST16FMC
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST16FMC 0x0041
+#endif
+#ifndef PCI_SUBVENDOR_ID_CHASE_PCIRAS
 #define PCI_SUBVENDOR_ID_CHASE_PCIRAS  0x124D
+#endif
+#ifndef PCI_SUBDEVICE_ID_CHASE_PCIRAS4
 #define PCI_SUBDEVICE_ID_CHASE_PCIRAS4  0xF001
+#endif
+#ifndef PCI_SUBDEVICE_ID_CHASE_PCIRAS8
 #define PCI_SUBDEVICE_ID_CHASE_PCIRAS8  0xF010
 #endif
-
 #ifndef PCI_VENDOR_ID_QUATECH
 #define PCI_VENDOR_ID_QUATECH  0x135C
+#endif
+#ifndef PCI_DEVICE_ID_QUATECH_QSC100
 #define PCI_DEVICE_ID_QUATECH_QSC100 0x0010
+#endif
+#ifndef PCI_DEVICE_ID_QUATECH_DSC100
 #define PCI_DEVICE_ID_QUATECH_DSC100 0x0020
+#endif
+#ifndef PCI_DEVICE_ID_QUATECH_DSC200
 #define PCI_DEVICE_ID_QUATECH_DSC200 0x0030
+#endif
+#ifndef PCI_DEVICE_ID_QUATECH_QSC200
 #define PCI_DEVICE_ID_QUATECH_QSC200 0x0040
+#endif
+#ifndef PCI_DEVICE_ID_QUATECH_ESC100D
 #define PCI_DEVICE_ID_QUATECH_ESC100D 0x0050
+#endif
+#ifndef PCI_DEVICE_ID_QUATECH_ESC100M
 #define PCI_DEVICE_ID_QUATECH_ESC100M 0x0060
 #endif
-
 #ifndef PCI_VENDOR_ID_ROCKWELL
 #define PCI_VENDOR_ID_ROCKWELL  0x127A
 #endif
-
 #ifndef PCI_VENDOR_ID_USR
 #define PCI_VENDOR_ID_USR  0x12B9
 #endif
-
 #ifndef PCI_SUBDEVICE_ID_SPECIALIX_SPEED4
 #define PCI_SUBDEVICE_ID_SPECIALIX_SPEED4 0xa004
 #endif
-
 #ifndef PCI_VENDOR_ID_OXSEMI
 #define PCI_VENDOR_ID_OXSEMI            0x1415
+#endif
+#ifndef PCI_DEVICE_ID_OXSEMI_16PCI954
 #define PCI_DEVICE_ID_OXSEMI_16PCI954   0x9501
 #endif
-
 #ifndef PCI_DEVICE_ID_OXSEMI_16PCI952
 #define PCI_DEVICE_ID_OXSEMI_16PCI952 0x950A
+#endif
+#ifndef PCI_DEVICE_ID_OXSEMI_16PCI95N
 #define PCI_DEVICE_ID_OXSEMI_16PCI95N 0x9511
 #endif
-
 #ifndef PCI_VENDOR_ID_LAVA
 #define PCI_VENDOR_ID_LAVA  0x1407
 #endif
-
 #ifndef PCI_DEVICE_ID_LAVA_DSERIAL
 #define PCI_DEVICE_ID_LAVA_DSERIAL 0x0100 /* 2x 16550 */
+#endif
+#ifndef PCI_DEVICE_ID_LAVA_QUATRO_A
 #define PCI_DEVICE_ID_LAVA_QUATRO_A 0x0101 /* 2x 16550, half of 4 port */
+#endif
+#ifndef PCI_DEVICE_ID_LAVA_QUATRO_B
 #define PCI_DEVICE_ID_LAVA_QUATRO_B 0x0102 /* 2x 16550, half of 4 port */
+#endif
+#ifndef PCI_DEVICE_ID_LAVA_PORT_PLUS
 #define PCI_DEVICE_ID_LAVA_PORT_PLUS 0x0200 /* 2x 16650 */
+#endif
+#ifndef PCI_DEVICE_ID_LAVA_QUAD_A
 #define PCI_DEVICE_ID_LAVA_QUAD_A 0x0201 /* 2x 16650, half of 4 port */
+#endif
+#ifndef PCI_DEVICE_ID_LAVA_QUAD_B
 #define PCI_DEVICE_ID_LAVA_QUAD_B 0x0202 /* 2x 16650, half of 4 port */
+#endif
+#ifndef PCI_DEVICE_ID_LAVA_SSERIAL
 #define PCI_DEVICE_ID_LAVA_SSERIAL 0x0500 /* 1x 16550 */
+#endif
+#ifndef PCI_DEVICE_ID_LAVA_PORT_650
 #define PCI_DEVICE_ID_LAVA_PORT_650 0x0600 /* 1x 16650 */
 #endif
-
 #ifndef PCI_VENDOR_ID_TIMEDIA
 #define PCI_VENDOR_ID_TIMEDIA  0x1409
+#endif
+#ifndef PCI_DEVICE_ID_TIMEDIA_1889
 #define PCI_DEVICE_ID_TIMEDIA_1889 0x7168
-#endif
-
+#endif
 #ifndef PCI_VENDOR_ID_SIIG
 #define PCI_VENDOR_ID_SIIG  0x131f
 #endif
-
 #ifndef PCI_DEVICE_ID_SIIG_1S_10x_550
 #define PCI_DEVICE_ID_SIIG_1S_10x_550  0x1000
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_1S_10x_650
 #define PCI_DEVICE_ID_SIIG_1S_10x_650  0x1001
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_1S_10x_850
 #define PCI_DEVICE_ID_SIIG_1S_10x_850  0x1002
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2S_10x_550
 #define PCI_DEVICE_ID_SIIG_2S_10x_550  0x1030
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2S_10x_650
 #define PCI_DEVICE_ID_SIIG_2S_10x_650  0x1031
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2S_10x_850
 #define PCI_DEVICE_ID_SIIG_2S_10x_850  0x1032
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_4S_10x_550
 #define PCI_DEVICE_ID_SIIG_4S_10x_550  0x1050
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_4S_10x_650
 #define PCI_DEVICE_ID_SIIG_4S_10x_650  0x1051
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_4S_10x_850
 #define PCI_DEVICE_ID_SIIG_4S_10x_850  0x1052
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_1S_20x_550
 #define PCI_DEVICE_ID_SIIG_1S_20x_550  0x2000
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_1S_20x_650
 #define PCI_DEVICE_ID_SIIG_1S_20x_650  0x2001
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_1S_20x_850
 #define PCI_DEVICE_ID_SIIG_1S_20x_850  0x2002
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2S_20x_550
 #define PCI_DEVICE_ID_SIIG_2S_20x_550  0x2030
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2S_20x_650
 #define PCI_DEVICE_ID_SIIG_2S_20x_650  0x2031
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2S_20x_850
 #define PCI_DEVICE_ID_SIIG_2S_20x_850  0x2032
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_4S_20x_550
 #define PCI_DEVICE_ID_SIIG_4S_20x_550  0x2050
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_4S_20x_650
 #define PCI_DEVICE_ID_SIIG_4S_20x_650  0x2051
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_4S_20x_850
 #define PCI_DEVICE_ID_SIIG_4S_20x_850  0x2052
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_1S1P_10x_550
 #define PCI_DEVICE_ID_SIIG_1S1P_10x_550 0x1010
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_1S1P_10x_650
 #define PCI_DEVICE_ID_SIIG_1S1P_10x_650 0x1011
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_1S1P_10x_850
 #define PCI_DEVICE_ID_SIIG_1S1P_10x_850 0x1012
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2S1P_10x_550
 #define PCI_DEVICE_ID_SIIG_2S1P_10x_550 0x1034
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2S1P_10x_650
 #define PCI_DEVICE_ID_SIIG_2S1P_10x_650 0x1035
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2S1P_10x_850
 #define PCI_DEVICE_ID_SIIG_2S1P_10x_850 0x1036
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2P1S_20x_550
 #define PCI_DEVICE_ID_SIIG_2P1S_20x_550 0x2040
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2P1S_20x_650
 #define PCI_DEVICE_ID_SIIG_2P1S_20x_650 0x2041
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2P1S_20x_850
 #define PCI_DEVICE_ID_SIIG_2P1S_20x_850 0x2042
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_1S1P_20x_550
 #define PCI_DEVICE_ID_SIIG_1S1P_20x_550 0x2010
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_1S1P_20x_650
 #define PCI_DEVICE_ID_SIIG_1S1P_20x_650 0x2011
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_1S1P_20x_850
 #define PCI_DEVICE_ID_SIIG_1S1P_20x_850 0x2012
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2S1P_20x_550
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_550 0x2060
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2S1P_20x_650
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_650 0x2061
+#endif
+#ifndef PCI_DEVICE_ID_SIIG_2S1P_20x_850
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_850 0x2062
 #endif
-
 #ifndef PCI_VENDOR_ID_COMPUTONE
 #define PCI_VENDOR_ID_COMPUTONE   0x8e0e
 #endif
-
 #ifndef PCI_DEVICE_ID_COMPUTONE_PG
 #define PCI_DEVICE_ID_COMPUTONE_PG  0x0302
+#endif
+#ifndef PCI_SUBVENDOR_ID_COMPUTONE
 #define PCI_SUBVENDOR_ID_COMPUTONE  0x8e0e
+#endif
+#ifndef PCI_SUBDEVICE_ID_COMPUTONE_PG4
 #define PCI_SUBDEVICE_ID_COMPUTONE_PG4 0x0001
+#endif
+#ifndef PCI_SUBDEVICE_ID_COMPUTONE_PG8
 #define PCI_SUBDEVICE_ID_COMPUTONE_PG8 0x0002
+#endif
+#ifndef PCI_SUBDEVICE_ID_COMPUTONE_PG6
 #define PCI_SUBDEVICE_ID_COMPUTONE_PG6 0x0003
 #endif
-
 #ifndef PCI_DEVICE_ID_ATT_VENUS_MODEM
-#define PCI_DEVICE_ID_ATT_VENUS_MODEM 0x480
+#define PCI_DEVICE_ID_ATT_VENUS_MODEM 0x0480
 #endif
-
 #ifndef PCI_VENDOR_ID_MORETON
 #define PCI_VENDOR_ID_MORETON  0x15aa
+#endif
+#ifndef PCI_DEVICE_ID_RASTEL_2PORT
 #define PCI_DEVICE_ID_RASTEL_2PORT 0x2000
 #endif
-
 #ifndef PCI_DEVICE_ID_DCI_PCCOM8
 #define PCI_DEVICE_ID_DCI_PCCOM8 0x0002
 #endif
-
 #ifndef PCI_VENDOR_ID_SGI
 #define PCI_VENDOR_ID_SGI  0x10a9
+#endif
+#ifndef PCI_DEVICE_ID_SGI_IOC3
 #define PCI_DEVICE_ID_SGI_IOC3  0x0003
 #endif

--- init ---

diff -ru serial-5.05-22x/serial_compat.h serial-5.05-init/serial_compat.h
--- serial-5.05-22x/serial_compat.h Thu Nov  1 16:20:53 2001
+++ serial-5.05-init/serial_compat.h Mon Nov  5 23:58:50 2001
@@ -191,6 +191,16 @@


 /*
+ * 2.2.18-20 have buggy tty_init()s. They incorrectly leave in the call
+ * to rs_init, which has been moved to the __initcall method. Here we
+ * compensate.
+ */
+#if defined(module_init) && ((LINUX_VERSION_CODE >= 0x020212) &&
(LINUX_VERSION_CODE <= 0x020214))
+#undef module_init
+#undef module_exit
+#endif
+
+/*
  * Compatibility with the new module_init() code
  */
 #ifndef module_init

--- end of patches ---


