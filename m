Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWHOUYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWHOUYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 16:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWHOUYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 16:24:13 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:29365 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750826AbWHOUYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 16:24:12 -0400
Message-Id: <200608152023.k7FKNbco009918@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] const struct tty_operations
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Aug 2006 16:23:37 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of an SMP cleanliness pass over UML, I consted a bunch of
structures in order to not have to document their locking.  One of
these structures was a struct tty_operations.  In order to const it in
UML without introducing compiler complaints, the declaration of
tty_set_operations needs to be changed, and then all of its callers
need to be fixed.

This patch declares all struct tty_operations in the tree as const.
In all cases, they are static and used only as input to
tty_set_operations.  As an extra check, I ran an i386 allyesconfig
build which produced no extra warnings.

53 drivers are affected.  I checked the history of a bunch of them,
and in most cases, there have been only a handful of maintenance
changes in the last six months.  serial_core.c was the busiest one
that I looked at.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/drivers/char/tty_io.c
===================================================================
--- linux-2.6.17.orig/drivers/char/tty_io.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/tty_io.c	2006-08-15 16:17:53.000000000 -0400
@@ -3011,7 +3011,8 @@ void put_tty_driver(struct tty_driver *d
 	kfree(driver);
 }
 
-void tty_set_operations(struct tty_driver *driver, struct tty_operations *op)
+void tty_set_operations(struct tty_driver *driver,
+			const struct tty_operations *op)
 {
 	driver->open = op->open;
 	driver->close = op->close;
Index: linux-2.6.17/include/linux/tty_driver.h
===================================================================
--- linux-2.6.17.orig/include/linux/tty_driver.h	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/include/linux/tty_driver.h	2006-08-15 12:53:39.000000000 -0400
@@ -219,7 +219,8 @@ extern struct list_head tty_drivers;
 
 struct tty_driver *alloc_tty_driver(int lines);
 void put_tty_driver(struct tty_driver *driver);
-void tty_set_operations(struct tty_driver *driver, struct tty_operations *op);
+void tty_set_operations(struct tty_driver *driver,
+			const struct tty_operations *op);
 
 /* tty driver magic number */
 #define TTY_DRIVER_MAGIC		0x5402
Index: linux-2.6.17/arch/alpha/kernel/srmcons.c
===================================================================
--- linux-2.6.17.orig/arch/alpha/kernel/srmcons.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/arch/alpha/kernel/srmcons.c	2006-08-15 12:53:39.000000000 -0400
@@ -229,7 +229,7 @@ srmcons_close(struct tty_struct *tty, st
 
 static struct tty_driver *srmcons_driver;
 
-static struct tty_operations srmcons_ops = {
+static const struct tty_operations srmcons_ops = {
 	.open		= srmcons_open,
 	.close		= srmcons_close,
 	.write		= srmcons_write,
Index: linux-2.6.17/arch/ia64/hp/sim/simserial.c
===================================================================
--- linux-2.6.17.orig/arch/ia64/hp/sim/simserial.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/arch/ia64/hp/sim/simserial.c	2006-08-15 12:53:39.000000000 -0400
@@ -940,7 +940,7 @@ static inline void show_serial_version(v
 	printk(KERN_INFO " no serial options enabled\n");
 }
 
-static struct tty_operations hp_ops = {
+static const struct tty_operations hp_ops = {
 	.open = rs_open,
 	.close = rs_close,
 	.write = rs_write,
Index: linux-2.6.17/arch/ppc/4xx_io/serial_sicc.c
===================================================================
--- linux-2.6.17.orig/arch/ppc/4xx_io/serial_sicc.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/arch/ppc/4xx_io/serial_sicc.c	2006-08-15 12:53:39.000000000 -0400
@@ -1720,7 +1720,7 @@ static int siccuart_open(struct tty_stru
     return 0;
 }
 
-static struct tty_operations sicc_ops = {
+static const struct tty_operations sicc_ops = {
 	.open = siccuart_open,
 	.close = siccuart_close,
 	.write = siccuart_write,
Index: linux-2.6.17/arch/um/drivers/line.c
===================================================================
--- linux-2.6.17.orig/arch/um/drivers/line.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/arch/um/drivers/line.c	2006-08-15 16:17:58.000000000 -0400
@@ -642,9 +642,9 @@ int line_remove(struct line *lines, unsi
 }
 
 struct tty_driver *line_register_devfs(struct lines *set,
-			 struct line_driver *line_driver,
-			 struct tty_operations *ops, struct line *lines,
-			 int nlines)
+				       struct line_driver *line_driver,
+				       const struct tty_operations *ops,
+				       struct line *lines, int nlines)
 {
 	int i;
 	struct tty_driver *driver = alloc_tty_driver(nlines);
Index: linux-2.6.17/arch/v850/kernel/memcons.c
===================================================================
--- linux-2.6.17.orig/arch/v850/kernel/memcons.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/arch/v850/kernel/memcons.c	2006-08-15 12:53:39.000000000 -0400
@@ -104,7 +104,7 @@ int memcons_tty_chars_in_buffer (struct 
 	return 0;
 }
 
-static struct tty_operations ops = {
+static const struct tty_operations ops = {
 	.open = memcons_tty_open,
 	.write = memcons_tty_write,
 	.write_room = memcons_tty_write_room,
Index: linux-2.6.17/arch/v850/kernel/simcons.c
===================================================================
--- linux-2.6.17.orig/arch/v850/kernel/simcons.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/arch/v850/kernel/simcons.c	2006-08-15 12:53:39.000000000 -0400
@@ -77,7 +77,7 @@ int simcons_tty_chars_in_buffer (struct 
 	return 0;
 }
 
-static struct tty_operations ops = {
+static const struct tty_operations ops = {
 	.open = simcons_tty_open,
 	.write = simcons_tty_write,
 	.write_room = simcons_tty_write_room,
Index: linux-2.6.17/arch/xtensa/platform-iss/console.c
===================================================================
--- linux-2.6.17.orig/arch/xtensa/platform-iss/console.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/arch/xtensa/platform-iss/console.c	2006-08-15 12:53:39.000000000 -0400
@@ -191,7 +191,7 @@ static int rs_read_proc(char *page, char
 }
 
 
-static struct tty_operations serial_ops = {
+static const struct tty_operations serial_ops = {
 	.open = rs_open,
 	.close = rs_close,
 	.write = rs_write,
Index: linux-2.6.17/drivers/char/amiserial.c
===================================================================
--- linux-2.6.17.orig/drivers/char/amiserial.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/amiserial.c	2006-08-15 12:53:39.000000000 -0400
@@ -1958,7 +1958,7 @@ static void show_serial_version(void)
 }
 
 
-static struct tty_operations serial_ops = {
+static const struct tty_operations serial_ops = {
 	.open = rs_open,
 	.close = rs_close,
 	.write = rs_write,
Index: linux-2.6.17/drivers/char/cyclades.c
===================================================================
--- linux-2.6.17.orig/drivers/char/cyclades.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/cyclades.c	2006-08-15 12:53:39.000000000 -0400
@@ -5205,7 +5205,7 @@ done:
     extra ports are ignored.
  */
 
-static struct tty_operations cy_ops = {
+static const struct tty_operations cy_ops = {
     .open = cy_open,
     .close = cy_close,
     .write = cy_write,
Index: linux-2.6.17/drivers/char/epca.c
===================================================================
--- linux-2.6.17.orig/drivers/char/epca.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/epca.c	2006-08-15 12:53:39.000000000 -0400
@@ -1125,7 +1125,7 @@ static void __exit epca_module_exit(void
 
 module_exit(epca_module_exit);
 
-static struct tty_operations pc_ops = {
+static const struct tty_operations pc_ops = {
 	.open = pc_open,
 	.close = pc_close,
 	.write = pc_write,
Index: linux-2.6.17/drivers/char/esp.c
===================================================================
--- linux-2.6.17.orig/drivers/char/esp.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/esp.c	2006-08-15 12:53:39.000000000 -0400
@@ -2376,7 +2376,7 @@ static inline int autoconfig(struct esp_
 	return (port_detected);
 }
 
-static struct tty_operations esp_ops = {
+static const struct tty_operations esp_ops = {
 	.open = esp_open,
 	.close = rs_close,
 	.write = rs_write,
Index: linux-2.6.17/drivers/char/hvc_console.c
===================================================================
--- linux-2.6.17.orig/drivers/char/hvc_console.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/hvc_console.c	2006-08-15 12:53:39.000000000 -0400
@@ -696,7 +696,7 @@ int khvcd(void *unused)
 	return 0;
 }
 
-static struct tty_operations hvc_ops = {
+static const struct tty_operations hvc_ops = {
 	.open = hvc_open,
 	.close = hvc_close,
 	.write = hvc_write,
Index: linux-2.6.17/drivers/char/hvcs.c
===================================================================
--- linux-2.6.17.orig/drivers/char/hvcs.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/hvcs.c	2006-08-15 12:53:39.000000000 -0400
@@ -1306,7 +1306,7 @@ static int hvcs_chars_in_buffer(struct t
 	return hvcsd->chars_in_buffer;
 }
 
-static struct tty_operations hvcs_ops = {
+static const struct tty_operations hvcs_ops = {
 	.open = hvcs_open,
 	.close = hvcs_close,
 	.hangup = hvcs_hangup,
Index: linux-2.6.17/drivers/char/hvsi.c
===================================================================
--- linux-2.6.17.orig/drivers/char/hvsi.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/hvsi.c	2006-08-15 12:53:39.000000000 -0400
@@ -1130,7 +1130,7 @@ static int hvsi_tiocmset(struct tty_stru
 }
 
 
-static struct tty_operations hvsi_ops = {
+static const struct tty_operations hvsi_ops = {
 	.open = hvsi_open,
 	.close = hvsi_close,
 	.write = hvsi_write,
Index: linux-2.6.17/drivers/char/ip2/ip2main.c
===================================================================
--- linux-2.6.17.orig/drivers/char/ip2/ip2main.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/ip2/ip2main.c	2006-08-15 12:53:39.000000000 -0400
@@ -457,7 +457,7 @@ cleanup_module(void)
 }
 #endif /* MODULE */
 
-static struct tty_operations ip2_ops = {
+static const struct tty_operations ip2_ops = {
 	.open            = ip2_open,
 	.close           = ip2_close,
 	.write           = ip2_write,
Index: linux-2.6.17/drivers/char/isicom.c
===================================================================
--- linux-2.6.17.orig/drivers/char/isicom.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/isicom.c	2006-08-15 12:53:39.000000000 -0400
@@ -1550,7 +1550,7 @@ static void isicom_unregister_ioregion(s
 	board->base = 0;
 }
 
-static struct tty_operations isicom_ops = {
+static const struct tty_operations isicom_ops = {
 	.open			= isicom_open,
 	.close			= isicom_close,
 	.write			= isicom_write,
Index: linux-2.6.17/drivers/char/istallion.c
===================================================================
--- linux-2.6.17.orig/drivers/char/istallion.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/istallion.c	2006-08-15 12:53:39.000000000 -0400
@@ -4654,7 +4654,7 @@ static int stli_memioctl(struct inode *i
 	return rc;
 }
 
-static struct tty_operations stli_ops = {
+static const struct tty_operations stli_ops = {
 	.open = stli_open,
 	.close = stli_close,
 	.write = stli_write,
Index: linux-2.6.17/drivers/char/moxa.c
===================================================================
--- linux-2.6.17.orig/drivers/char/moxa.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/moxa.c	2006-08-15 12:53:39.000000000 -0400
@@ -280,7 +280,7 @@ static int moxa_get_serial_info(struct m
 static int moxa_set_serial_info(struct moxa_str *, struct serial_struct __user *);
 static void MoxaSetFifo(int port, int enable);
 
-static struct tty_operations moxa_ops = {
+static const struct tty_operations moxa_ops = {
 	.open = moxa_open,
 	.close = moxa_close,
 	.write = moxa_write,
Index: linux-2.6.17/drivers/char/mxser.c
===================================================================
--- linux-2.6.17.orig/drivers/char/mxser.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/mxser.c	2006-08-15 12:53:39.000000000 -0400
@@ -453,7 +453,7 @@ static int CheckIsMoxaMust(int io)
 
 /* above is modified by Victor Yu. 08-15-2002 */
 
-static struct tty_operations mxser_ops = {
+static const struct tty_operations mxser_ops = {
 	.open = mxser_open,
 	.close = mxser_close,
 	.write = mxser_write,
Index: linux-2.6.17/drivers/char/pcmcia/synclink_cs.c
===================================================================
--- linux-2.6.17.orig/drivers/char/pcmcia/synclink_cs.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/pcmcia/synclink_cs.c	2006-08-15 12:53:39.000000000 -0400
@@ -3010,7 +3010,7 @@ static struct pcmcia_driver mgslpc_drive
 	.resume		= mgslpc_resume,
 };
 
-static struct tty_operations mgslpc_ops = {
+static const struct tty_operations mgslpc_ops = {
 	.open = mgslpc_open,
 	.close = mgslpc_close,
 	.write = mgslpc_write,
Index: linux-2.6.17/drivers/char/pty.c
===================================================================
--- linux-2.6.17.orig/drivers/char/pty.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/pty.c	2006-08-15 12:53:39.000000000 -0400
@@ -224,7 +224,7 @@ static void pty_set_termios(struct tty_s
         tty->termios->c_cflag |= (CS8 | CREAD);
 }
 
-static struct tty_operations pty_ops = {
+static const struct tty_operations pty_ops = {
 	.open = pty_open,
 	.close = pty_close,
 	.write = pty_write,
Index: linux-2.6.17/drivers/char/rio/rio_linux.c
===================================================================
--- linux-2.6.17.orig/drivers/char/rio/rio_linux.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/rio/rio_linux.c	2006-08-15 12:53:39.000000000 -0400
@@ -727,7 +727,7 @@ static struct vpd_prom *get_VPD_PROM(str
 	return &vpdp;
 }
 
-static struct tty_operations rio_ops = {
+static const struct tty_operations rio_ops = {
 	.open = riotopen,
 	.close = gs_close,
 	.write = gs_write,
Index: linux-2.6.17/drivers/char/riscom8.c
===================================================================
--- linux-2.6.17.orig/drivers/char/riscom8.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/riscom8.c	2006-08-15 12:53:39.000000000 -0400
@@ -1597,7 +1597,7 @@ static void do_softint(void *private_)
 	}
 }
 
-static struct tty_operations riscom_ops = {
+static const struct tty_operations riscom_ops = {
 	.open  = rc_open,
 	.close = rc_close,
 	.write = rc_write,
Index: linux-2.6.17/drivers/char/rocket.c
===================================================================
--- linux-2.6.17.orig/drivers/char/rocket.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/rocket.c	2006-08-15 12:53:39.000000000 -0400
@@ -2334,7 +2334,7 @@ static int __init init_ISA(int i)
 	return (1);
 }
 
-static struct tty_operations rocket_ops = {
+static const struct tty_operations rocket_ops = {
 	.open = rp_open,
 	.close = rp_close,
 	.write = rp_write,
Index: linux-2.6.17/drivers/char/ser_a2232.c
===================================================================
--- linux-2.6.17.orig/drivers/char/ser_a2232.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/ser_a2232.c	2006-08-15 12:53:39.000000000 -0400
@@ -661,7 +661,7 @@ static void a2232_init_portstructs(void)
 	}
 }
 
-static struct tty_operations a2232_ops = {
+static const struct tty_operations a2232_ops = {
 	.open = a2232_open,
 	.close = gs_close,
 	.write = gs_write,
Index: linux-2.6.17/drivers/char/serial167.c
===================================================================
--- linux-2.6.17.orig/drivers/char/serial167.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/serial167.c	2006-08-15 12:53:39.000000000 -0400
@@ -2158,7 +2158,7 @@ mvme167_serial_console_setup(int cflag)
 					rcor >> 5, rbpr);
 } /* serial_console_init */
 
-static struct tty_operations cy_ops = {
+static const struct tty_operations cy_ops = {
 	.open = cy_open,
 	.close = cy_close,
 	.write = cy_write,
Index: linux-2.6.17/drivers/char/specialix.c
===================================================================
--- linux-2.6.17.orig/drivers/char/specialix.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/specialix.c	2006-08-15 12:53:39.000000000 -0400
@@ -2372,7 +2372,7 @@ static void do_softint(void *private_)
 	func_exit();
 }
 
-static struct tty_operations sx_ops = {
+static const struct tty_operations sx_ops = {
 	.open  = sx_open,
 	.close = sx_close,
 	.write = sx_write,
Index: linux-2.6.17/drivers/char/stallion.c
===================================================================
--- linux-2.6.17.orig/drivers/char/stallion.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/stallion.c	2006-08-15 12:53:39.000000000 -0400
@@ -2993,7 +2993,7 @@ static int stl_memioctl(struct inode *ip
 	return(rc);
 }
 
-static struct tty_operations stl_ops = {
+static const struct tty_operations stl_ops = {
 	.open = stl_open,
 	.close = stl_close,
 	.write = stl_write,
Index: linux-2.6.17/drivers/char/sx.c
===================================================================
--- linux-2.6.17.orig/drivers/char/sx.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/sx.c	2006-08-15 12:53:39.000000000 -0400
@@ -2226,7 +2226,7 @@ static int probe_si (struct sx_board *bo
 	return 1;
 }
 
-static struct tty_operations sx_ops = {
+static const struct tty_operations sx_ops = {
 	.break_ctl = sx_break,
 	.open	= sx_open,
 	.close = gs_close,
Index: linux-2.6.17/drivers/char/synclink.c
===================================================================
--- linux-2.6.17.orig/drivers/char/synclink.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/synclink.c	2006-08-15 12:53:39.000000000 -0400
@@ -4360,7 +4360,7 @@ static struct mgsl_struct* mgsl_allocate
 
 }	/* end of mgsl_allocate_device()*/
 
-static struct tty_operations mgsl_ops = {
+static const struct tty_operations mgsl_ops = {
 	.open = mgsl_open,
 	.close = mgsl_close,
 	.write = mgsl_write,
Index: linux-2.6.17/drivers/char/synclink_gt.c
===================================================================
--- linux-2.6.17.orig/drivers/char/synclink_gt.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/synclink_gt.c	2006-08-15 12:53:39.000000000 -0400
@@ -3434,7 +3434,7 @@ static void __devexit remove_one(struct 
 {
 }
 
-static struct tty_operations ops = {
+static const struct tty_operations ops = {
 	.open = open,
 	.close = close,
 	.write = write,
Index: linux-2.6.17/drivers/char/synclinkmp.c
===================================================================
--- linux-2.6.17.orig/drivers/char/synclinkmp.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/synclinkmp.c	2006-08-15 12:53:39.000000000 -0400
@@ -3929,7 +3929,7 @@ void device_init(int adapter_num, struct
 	}
 }
 
-static struct tty_operations ops = {
+static const struct tty_operations ops = {
 	.open = open,
 	.close = close,
 	.write = write,
Index: linux-2.6.17/drivers/char/viocons.c
===================================================================
--- linux-2.6.17.orig/drivers/char/viocons.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/viocons.c	2006-08-15 12:53:39.000000000 -0400
@@ -1077,7 +1077,7 @@ static int send_open(HvLpIndex remoteLp,
 			0, 0, 0, 0);
 }
 
-static struct tty_operations serial_ops = {
+static const struct tty_operations serial_ops = {
 	.open = viotty_open,
 	.close = viotty_close,
 	.write = viotty_write,
Index: linux-2.6.17/drivers/char/vme_scc.c
===================================================================
--- linux-2.6.17.orig/drivers/char/vme_scc.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/vme_scc.c	2006-08-15 12:53:39.000000000 -0400
@@ -113,7 +113,7 @@ static struct real_driver scc_real_drive
 };
 
 
-static struct tty_operations scc_ops = {
+static const struct tty_operations scc_ops = {
 	.open	= scc_open,
 	.close = gs_close,
 	.write = gs_write,
Index: linux-2.6.17/drivers/char/vt.c
===================================================================
--- linux-2.6.17.orig/drivers/char/vt.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/char/vt.c	2006-08-15 12:53:39.000000000 -0400
@@ -2639,7 +2639,7 @@ static int __init con_init(void)
 }
 console_initcall(con_init);
 
-static struct tty_operations con_ops = {
+static const struct tty_operations con_ops = {
 	.open = con_open,
 	.close = con_close,
 	.write = con_write,
Index: linux-2.6.17/drivers/isdn/capi/capi.c
===================================================================
--- linux-2.6.17.orig/drivers/isdn/capi/capi.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/isdn/capi/capi.c	2006-08-15 12:53:39.000000000 -0400
@@ -1298,7 +1298,7 @@ static int capinc_tty_read_proc(char *pa
 
 static struct tty_driver *capinc_tty_driver;
 
-static struct tty_operations capinc_ops = {
+static const struct tty_operations capinc_ops = {
 	.open = capinc_tty_open,
 	.close = capinc_tty_close,
 	.write = capinc_tty_write,
Index: linux-2.6.17/drivers/isdn/gigaset/interface.c
===================================================================
--- linux-2.6.17.orig/drivers/isdn/gigaset/interface.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/isdn/gigaset/interface.c	2006-08-15 12:53:39.000000000 -0400
@@ -134,7 +134,7 @@ static int  if_tiocmset(struct tty_struc
 static int  if_write(struct tty_struct *tty,
 		     const unsigned char *buf, int count);
 
-static struct tty_operations if_ops = {
+static const struct tty_operations if_ops = {
 	.open =			if_open,
 	.close =		if_close,
 	.ioctl =		if_ioctl,
Index: linux-2.6.17/drivers/isdn/i4l/isdn_tty.c
===================================================================
--- linux-2.6.17.orig/drivers/isdn/i4l/isdn_tty.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/isdn/i4l/isdn_tty.c	2006-08-15 12:53:39.000000000 -0400
@@ -1860,7 +1860,7 @@ modem_write_profile(atemu * m)
 		send_sig(SIGIO, dev->profd, 1);
 }
 
-static struct tty_operations modem_ops = {
+static const struct tty_operations modem_ops = {
         .open = isdn_tty_open,
 	.close = isdn_tty_close,
 	.write = isdn_tty_write,
Index: linux-2.6.17/drivers/s390/char/con3215.c
===================================================================
--- linux-2.6.17.orig/drivers/s390/char/con3215.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/s390/char/con3215.c	2006-08-15 12:53:39.000000000 -0400
@@ -1103,7 +1103,7 @@ tty3215_start(struct tty_struct *tty)
 	}
 }
 
-static struct tty_operations tty3215_ops = {
+static const struct tty_operations tty3215_ops = {
 	.open = tty3215_open,
 	.close = tty3215_close,
 	.write = tty3215_write,
Index: linux-2.6.17/drivers/s390/char/sclp_tty.c
===================================================================
--- linux-2.6.17.orig/drivers/s390/char/sclp_tty.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/s390/char/sclp_tty.c	2006-08-15 12:53:39.000000000 -0400
@@ -711,7 +711,7 @@ static struct sclp_register sclp_input_e
 	.receiver_fn = sclp_tty_receiver
 };
 
-static struct tty_operations sclp_ops = {
+static const struct tty_operations sclp_ops = {
 	.open = sclp_tty_open,
 	.close = sclp_tty_close,
 	.write = sclp_tty_write,
Index: linux-2.6.17/drivers/s390/char/sclp_vt220.c
===================================================================
--- linux-2.6.17.orig/drivers/s390/char/sclp_vt220.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/s390/char/sclp_vt220.c	2006-08-15 12:53:39.000000000 -0400
@@ -655,7 +655,7 @@ __sclp_vt220_init(int early)
 	return 0;
 }
 
-static struct tty_operations sclp_vt220_ops = {
+static const struct tty_operations sclp_vt220_ops = {
 	.open = sclp_vt220_open,
 	.close = sclp_vt220_close,
 	.write = sclp_vt220_write,
Index: linux-2.6.17/drivers/s390/char/tty3270.c
===================================================================
--- linux-2.6.17.orig/drivers/s390/char/tty3270.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/s390/char/tty3270.c	2006-08-15 12:53:39.000000000 -0400
@@ -1738,7 +1738,7 @@ tty3270_ioctl(struct tty_struct *tty, st
 	return kbd_ioctl(tp->kbd, file, cmd, arg);
 }
 
-static struct tty_operations tty3270_ops = {
+static const struct tty_operations tty3270_ops = {
 	.open = tty3270_open,
 	.close = tty3270_close,
 	.write = tty3270_write,
Index: linux-2.6.17/drivers/sbus/char/aurora.c
===================================================================
--- linux-2.6.17.orig/drivers/sbus/char/aurora.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/sbus/char/aurora.c	2006-08-15 12:53:39.000000000 -0400
@@ -2187,7 +2187,7 @@ static void do_softint(void *private_)
 #endif
 }
 
-static struct tty_operations aurora_ops = {
+static const struct tty_operations aurora_ops = {
 	.open  = aurora_open,
 	.close = aurora_close,
 	.write = aurora_write,
Index: linux-2.6.17/drivers/serial/68328serial.c
===================================================================
--- linux-2.6.17.orig/drivers/serial/68328serial.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/serial/68328serial.c	2006-08-15 12:53:39.000000000 -0400
@@ -1378,7 +1378,7 @@ void startup_console(void)
 #endif /* CONFIG_PM_LEGACY */
 
 
-static struct tty_operations rs_ops = {
+static const struct tty_operations rs_ops = {
 	.open = rs_open,
 	.close = rs_close,
 	.write = rs_write,
Index: linux-2.6.17/drivers/serial/68360serial.c
===================================================================
--- linux-2.6.17.orig/drivers/serial/68360serial.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/serial/68360serial.c	2006-08-15 12:53:39.000000000 -0400
@@ -2424,7 +2424,7 @@ long console_360_init(long kmem_start, l
 */
 static	int	baud_idx;
 
-static struct tty_operations rs_360_ops = {
+static const struct tty_operations rs_360_ops = {
 	.owner = THIS_MODULE,
 	.open = rs_360_open,
 	.close = rs_360_close,
Index: linux-2.6.17/drivers/serial/crisv10.c
===================================================================
--- linux-2.6.17.orig/drivers/serial/crisv10.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/serial/crisv10.c	2006-08-15 12:53:39.000000000 -0400
@@ -4825,7 +4825,7 @@ show_serial_version(void)
 
 /* rs_init inits the driver at boot (using the module_init chain) */
 
-static struct tty_operations rs_ops = {
+static const struct tty_operations rs_ops = {
 	.open = rs_open,
 	.close = rs_close,
 	.write = rs_write,
Index: linux-2.6.17/drivers/serial/mcfserial.c
===================================================================
--- linux-2.6.17.orig/drivers/serial/mcfserial.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/serial/mcfserial.c	2006-08-15 12:53:39.000000000 -0400
@@ -1666,7 +1666,7 @@ static void show_serial_version(void)
 	printk(mcfrs_drivername);
 }
 
-static struct tty_operations mcfrs_ops = {
+static const struct tty_operations mcfrs_ops = {
 	.open = mcfrs_open,
 	.close = mcfrs_close,
 	.write = mcfrs_write,
Index: linux-2.6.17/drivers/serial/serial_core.c
===================================================================
--- linux-2.6.17.orig/drivers/serial/serial_core.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/serial/serial_core.c	2006-08-15 12:53:39.000000000 -0400
@@ -2097,7 +2097,7 @@ uart_configure_port(struct uart_driver *
 	}
 }
 
-static struct tty_operations uart_ops = {
+static const struct tty_operations uart_ops = {
 	.open		= uart_open,
 	.close		= uart_close,
 	.write		= uart_write,
Index: linux-2.6.17/drivers/tc/zs.c
===================================================================
--- linux-2.6.17.orig/drivers/tc/zs.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/tc/zs.c	2006-08-15 12:53:39.000000000 -0400
@@ -1701,7 +1701,7 @@ static void __init probe_sccs(void)
 	spin_unlock_irqrestore(&zs_lock, flags);
 }
 
-static struct tty_operations serial_ops = {
+static const struct tty_operations serial_ops = {
 	.open = rs_open,
 	.close = rs_close,
 	.write = rs_write,
Index: linux-2.6.17/drivers/usb/class/cdc-acm.c
===================================================================
--- linux-2.6.17.orig/drivers/usb/class/cdc-acm.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/usb/class/cdc-acm.c	2006-08-15 12:53:39.000000000 -0400
@@ -1120,7 +1120,7 @@ static struct usb_driver acm_driver = {
  * TTY driver structures.
  */
 
-static struct tty_operations acm_ops = {
+static const struct tty_operations acm_ops = {
 	.open =			acm_tty_open,
 	.close =		acm_tty_close,
 	.write =		acm_tty_write,
Index: linux-2.6.17/drivers/usb/gadget/serial.c
===================================================================
--- linux-2.6.17.orig/drivers/usb/gadget/serial.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/usb/gadget/serial.c	2006-08-15 12:53:39.000000000 -0400
@@ -271,7 +271,7 @@ static unsigned int use_acm = GS_DEFAULT
 
 
 /* tty driver struct */
-static struct tty_operations gs_tty_ops = {
+static const struct tty_operations gs_tty_ops = {
 	.open =			gs_open,
 	.close =		gs_close,
 	.write =		gs_write,
Index: linux-2.6.17/drivers/usb/serial/usb-serial.c
===================================================================
--- linux-2.6.17.orig/drivers/usb/serial/usb-serial.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/drivers/usb/serial/usb-serial.c	2006-08-15 12:53:39.000000000 -0400
@@ -1013,7 +1013,7 @@ void usb_serial_disconnect(struct usb_in
 	dev_info(dev, "device disconnected\n");
 }
 
-static struct tty_operations serial_ops = {
+static const struct tty_operations serial_ops = {
 	.open =			serial_open,
 	.close =		serial_close,
 	.write =		serial_write,
Index: linux-2.6.17/net/bluetooth/rfcomm/tty.c
===================================================================
--- linux-2.6.17.orig/net/bluetooth/rfcomm/tty.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/net/bluetooth/rfcomm/tty.c	2006-08-15 12:53:39.000000000 -0400
@@ -992,7 +992,7 @@ static int rfcomm_tty_tiocmset(struct tt
 
 /* ---- TTY structure ---- */
 
-static struct tty_operations rfcomm_ops = {
+static const struct tty_operations rfcomm_ops = {
 	.open			= rfcomm_tty_open,
 	.close			= rfcomm_tty_close,
 	.write			= rfcomm_tty_write,
Index: linux-2.6.17/net/irda/ircomm/ircomm_tty.c
===================================================================
--- linux-2.6.17.orig/net/irda/ircomm/ircomm_tty.c	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/net/irda/ircomm/ircomm_tty.c	2006-08-15 12:53:39.000000000 -0400
@@ -79,7 +79,7 @@ static struct tty_driver *driver;
 
 hashbin_t *ircomm_tty = NULL;
 
-static struct tty_operations ops = {
+static const struct tty_operations ops = {
 	.open            = ircomm_tty_open,
 	.close           = ircomm_tty_close,
 	.write           = ircomm_tty_write,
Index: linux-2.6.17/arch/um/include/line.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/line.h	2006-08-15 12:53:33.000000000 -0400
+++ linux-2.6.17/arch/um/include/line.h	2006-08-15 16:17:58.000000000 -0400
@@ -91,10 +91,9 @@ extern int line_setup_irq(int fd, int in
 			  void *data);
 extern void line_close_chan(struct line *line);
 extern struct tty_driver * line_register_devfs(struct lines *set,
-				struct line_driver *line_driver,
-				struct tty_operations *driver,
-				struct line *lines,
-				int nlines);
+					       struct line_driver *line_driver,
+					       const struct tty_operations *driver,
+					       struct line *lines, int nlines);
 extern void lines_init(struct line *lines, int nlines, struct chan_opts *opts);
 extern void close_lines(struct line *lines, int nlines);
 

