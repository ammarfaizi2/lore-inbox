Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131330AbRCHLhW>; Thu, 8 Mar 2001 06:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131333AbRCHLhN>; Thu, 8 Mar 2001 06:37:13 -0500
Received: from 13dyn210.delft.casema.net ([212.64.76.210]:35596 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131330AbRCHLhB>; Thu, 8 Mar 2001 06:37:01 -0500
Message-Id: <200103081136.MAA19995@cave.bitwizard.nl>
Subject: SX driver patch.
To: alan@lxorguk.ukuu.org.uk
Date: Thu, 8 Mar 2001 12:36:32 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM984051392-17746-0_
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM984051392-17746-0_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Alan,

A client noted that we forgot to implement breaks in the SX
driver. Turns out to be easy. Moreover... I actually tested this
patch!  (Somehow the Makefile entry for SX got stomped on, that's
fixed here too.)

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

--ELM984051392-17746-0_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=sx-2.2.19-pre16.diff
Content-Description: /usr/src/sx-2.2.19-pre16.diff
Content-Transfer-Encoding: 7bit

diff -ur linux-2.2.19-pre16.clean/drivers/char/Makefile linux-2.2.19-pre16.sx/drivers/char/Makefile
--- linux-2.2.19-pre16.clean/drivers/char/Makefile	Thu Mar  8 12:30:33 2001
+++ linux-2.2.19-pre16.sx/drivers/char/Makefile	Thu Mar  8 12:31:22 2001
@@ -200,7 +200,13 @@
   endif
 endif
 
-obj-$(CONFIG_SX) += sx.o generic_serial.o
+ifeq ($(CONFIG_SX),y)
+O_OBJS += sx.o generic_serial.o
+else
+  ifeq ($(CONFIG_SX),m)
+  M_OBJS += sx.o generic_serial.o
+  endif
+endif
 
 ifeq ($(CONFIG_RIO),y)
 O_OBJS += rio/rio.o generic_serial.o
diff -ur linux-2.2.19-pre16.clean/drivers/char/sx.c linux-2.2.19-pre16.sx/drivers/char/sx.c
--- linux-2.2.19-pre16.clean/drivers/char/sx.c	Thu Jan  4 16:27:07 2001
+++ linux-2.2.19-pre16.sx/drivers/char/sx.c	Thu Mar  8 12:31:22 2001
@@ -1799,6 +1799,20 @@
 }
 
 
+static void sx_break (struct tty_struct * tty, int flag)
+{
+	struct sx_port *port = tty->driver_data;
+	int rv;
+
+	if (flag) 
+		rv = sx_send_command (port, HS_START, -1, HS_IDLE_BREAK);
+	else 
+		rv = sx_send_command (port, HS_STOP, -1, HS_IDLE_OPEN);
+	if (rv != 1) printk (KERN_ERR "sx: couldn't send break (%x).\n",
+			read_sx_byte (port->board, CHAN_OFFSET (port, hi_hstat)));
+}
+
+
 static int sx_ioctl (struct tty_struct * tty, struct file * filp, 
                      unsigned int cmd, unsigned long arg)
 {
@@ -1867,7 +1881,6 @@
 			sx_reconfigure_port(port);
 		}
 		break;
-
 	default:
 		rc = -ENOIOCTLCMD;
 		break;
@@ -2247,6 +2260,7 @@
 	sx_driver.table = sx_table;
 	sx_driver.termios = sx_termios;
 	sx_driver.termios_locked = sx_termios_locked;
+	sx_driver.break_ctl = sx_break;
 
 	sx_driver.open	= sx_open;
 	sx_driver.close = gs_close;

--ELM984051392-17746-0_--
