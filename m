Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286737AbRL1EHq>; Thu, 27 Dec 2001 23:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286743AbRL1EHg>; Thu, 27 Dec 2001 23:07:36 -0500
Received: from www.transvirtual.com ([206.14.214.140]:516 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S286737AbRL1EHZ>; Thu, 27 Dec 2001 23:07:25 -0500
Date: Thu, 27 Dec 2001 20:07:14 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] added consoel field to struct tty_driver
Message-ID: <Pine.LNX.4.10.10112271954520.25886-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   A have a new version of the console lock. The goal is to move
[acquire/release]_console_lock into the upper tty layers. This
way other TTY drivers besides the VT layer can take advanatge 
of it. Plus I like to make the lock per console device. Their is
no reason to block the serial console while say the frmaebuffer 
is drawing to the screen for a printk. 
   First I reworked my console lock thanks to Alan pointing out the
lp console issue. So now I have it handle 3 conditions:

1) Console by itself (i.e lp console). The console initializes the lock.

2) tty driver without a console. A lock in struct tty_driver is
   initialized. 

3) Hardware has both a console and a tty. Then the lock is shared between
   both struct tty_driver and struct console.  

This patch is pretty big so I had to break it up. The first patch below 
places a struct console field into struct tty_driver. Why? So code in
tty_io.c function tty_register_driver can test to see if a console is
associated with this tty device. If it is both structs point to the same
lock. Otherwise tty_register_driver will allocate a semaphore for us. 

This patch touches several serial drivers so if you have problems let me
know. I can update it. Please test since I like to include it in the
standard tree. 

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/arch/mips/au1000/common/serial.c linux/arch/mips/au1000/common/serial.c
--- linux-2.5.2-pre3/arch/mips/au1000/common/serial.c	Thu Dec 27 17:20:16 2001
+++ linux/arch/mips/au1000/common/serial.c	Thu Dec 27 19:11:30 2001
@@ -2606,7 +2606,9 @@
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
 	serial_driver.termios_locked = serial_termios_locked;
-
+#ifdef CONFIG_AU1000_SERIAL_CONSOLE
+        serial_driver.console = &sercons;
+#endif
 	serial_driver.open = rs_open;
 	serial_driver.close = rs_close;
 	serial_driver.write = rs_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/arch/mips/baget/vacserial.c linux/arch/mips/baget/vacserial.c
--- linux-2.5.2-pre3/arch/mips/baget/vacserial.c	Thu Dec 27 17:20:16 2001
+++ linux/arch/mips/baget/vacserial.c	Thu Dec 27 19:10:11 2001
@@ -2373,7 +2373,9 @@
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
 	serial_driver.termios_locked = serial_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+        serial_driver.console = &sercons;
+#endif
 	serial_driver.open = rs_open;
 	serial_driver.close = rs_close;
 	serial_driver.write = rs_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/arch/ppc/8260_io/uart.c linux/arch/ppc/8260_io/uart.c
--- linux-2.5.2-pre3/arch/ppc/8260_io/uart.c	Thu Dec 27 20:48:03 2001
+++ linux/arch/ppc/8260_io/uart.c	Thu Dec 27 20:47:16 2001
@@ -2290,7 +2290,9 @@
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
 	serial_driver.termios_locked = serial_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+        serial_driver.console = &sercons;
+#endif
 	serial_driver.open = rs_8xx_open;
 	serial_driver.close = rs_8xx_close;
 	serial_driver.write = rs_8xx_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/arch/ppc/8xx_io/uart.c linux/arch/ppc/8xx_io/uart.c
--- linux-2.5.2-pre3/arch/ppc/8xx_io/uart.c	Thu Dec 27 20:48:03 2001
+++ linux/arch/ppc/8xx_io/uart.c	Thu Dec 27 20:47:16 2001
@@ -2536,7 +2536,9 @@
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
 	serial_driver.termios_locked = serial_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+	serial_driver.console = &sercons;
+#endif
 	serial_driver.open = rs_8xx_open;
 	serial_driver.close = rs_8xx_close;
 	serial_driver.write = rs_8xx_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/char/amiserial.c linux/drivers/char/amiserial.c
--- linux-2.5.2-pre3/drivers/char/amiserial.c	Wed Dec 26 10:41:48 2001
+++ linux/drivers/char/amiserial.c	Thu Dec 27 19:27:09 2001
@@ -2143,7 +2143,9 @@
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
 	serial_driver.termios_locked = serial_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+        serial_driver.console = &sercons;
+#endif
 	serial_driver.open = rs_open;
 	serial_driver.close = rs_close;
 	serial_driver.write = rs_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/char/console.c linux/drivers/char/console.c
--- linux-2.5.2-pre3/drivers/char/console.c	Thu Dec 27 17:20:21 2001
+++ linux/drivers/char/console.c	Thu Dec 27 19:30:56 2001
@@ -2459,7 +2459,9 @@
 	console_driver.table = console_table;
 	console_driver.termios = console_termios;
 	console_driver.termios_locked = console_termios_locked;
-
+#ifdef CONFIG_VT_CONSOLE
+	console_driver.console = &vt_console_driver;
+#endif
 	console_driver.open = con_open;
 	console_driver.close = con_close;
 	console_driver.write = con_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/char/dz.c linux/drivers/char/dz.c
--- linux-2.5.2-pre3/drivers/char/dz.c	Thu Dec 27 17:20:21 2001
+++ linux/drivers/char/dz.c	Thu Dec 27 19:27:21 2001
@@ -67,7 +67,7 @@
 extern int (*prom_printf) (char *,...);
 #endif
 
-
+struct console dz_sercons;
 
 #include "dz.h"
 
@@ -1353,7 +1353,9 @@
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
 	serial_driver.termios_locked = serial_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+	serial_driver.console = &dz_sercons;
+#endif
 	serial_driver.open = dz_open;
 	serial_driver.close = dz_close;
 	serial_driver.write = dz_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/char/keyboard.c linux/drivers/char/keyboard.c
--- linux-2.5.2-pre3/drivers/char/keyboard.c	Thu Dec 27 17:20:21 2001
+++ linux/drivers/char/keyboard.c	Thu Dec 27 19:45:10 2001
@@ -67,8 +67,6 @@
 
 extern void ctrl_alt_del(void);
 
-struct console;
-
 /*
  * global state includes the following, and various static variables
  * in this module: prev_scancode, shift_state, diacr, npadch, dead_key_next.
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/char/serial.c linux/drivers/char/serial.c
--- linux-2.5.2-pre3/drivers/char/serial.c	Thu Dec 27 17:20:21 2001
+++ linux/drivers/char/serial.c	Thu Dec 27 19:35:57 2001
@@ -5408,7 +5408,9 @@
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
 	serial_driver.termios_locked = serial_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+	serial_driver.console = &sercons;
+#endif
 	serial_driver.open = rs_open;
 	serial_driver.close = rs_close;
 	serial_driver.write = rs_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/char/serial167.c linux/drivers/char/serial167.c
--- linux-2.5.2-pre3/drivers/char/serial167.c	Thu Dec 27 17:20:22 2001
+++ linux/drivers/char/serial167.c	Thu Dec 27 19:41:19 2001
@@ -103,6 +103,7 @@
 DECLARE_TASK_QUEUE(tq_cyclades);
 
 struct tty_driver cy_serial_driver, cy_callout_driver;
+static struct console sercons;
 extern int serial_console;
 static struct cyclades_port *serial_console_info = NULL;
 static unsigned int serial_console_cflag = 0;
@@ -2409,6 +2410,7 @@
     cy_serial_driver.table = serial_table;
     cy_serial_driver.termios = serial_termios;
     cy_serial_driver.termios_locked = serial_termios_locked;
+    cy_serial_driver.console = &sercons;
     cy_serial_driver.open = cy_open;
     cy_serial_driver.close = cy_close;
     cy_serial_driver.write = cy_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/char/serial_21285.c linux/drivers/char/serial_21285.c
--- linux-2.5.2-pre3/drivers/char/serial_21285.c	Thu Dec 27 17:20:22 2001
+++ linux/drivers/char/serial_21285.c	Thu Dec 27 19:42:56 2001
@@ -45,6 +45,7 @@
 
 static struct termios *rs285_termios[1];
 static struct termios *rs285_termios_locked[1];
+static struct console rs285_cons;
 
 static char wbuf[1000], *putp = wbuf, *getp = wbuf, x_char;
 static struct tty_struct *rs285_tty;
@@ -312,7 +313,9 @@
 	rs285_driver.table = rs285_table;
 	rs285_driver.termios = rs285_termios;
 	rs285_driver.termios_locked = rs285_termios_locked;
-
+#ifdef CONFIG_SERIAL_21285_CONSOLE
+	rs285_driver.console = &rs285_cons;
+#endif
 	rs285_driver.open = rs285_open;
 	rs285_driver.close = rs285_close;
 	rs285_driver.write = rs285_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/char/serial_amba.c linux/drivers/char/serial_amba.c
--- linux-2.5.2-pre3/drivers/char/serial_amba.c	Thu Dec 27 17:20:22 2001
+++ linux/drivers/char/serial_amba.c	Thu Dec 27 19:37:50 2001
@@ -1789,7 +1789,9 @@
 	ambanormal_driver.table = ambauart_table;
 	ambanormal_driver.termios = ambauart_termios;
 	ambanormal_driver.termios_locked = ambauart_termios_locked;
-
+#ifdef CONFIG_SERIAL_AMBA_CONSOLE
+	ambanormal_driver.console = &ambauart_cons;
+#endif
 	ambanormal_driver.open = ambauart_open;
 	ambanormal_driver.close = ambauart_close;
 	ambanormal_driver.write = ambauart_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/char/serial_tx3912.c linux/drivers/char/serial_tx3912.c
--- linux-2.5.2-pre3/drivers/char/serial_tx3912.c	Thu Dec 27 17:20:22 2001
+++ linux/drivers/char/serial_tx3912.c	Thu Dec 27 19:29:37 2001
@@ -854,7 +854,9 @@
 	rs_driver.table = rs_table;
 	rs_driver.termios = rs_termios;
 	rs_driver.termios_locked = rs_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+        rs_driver.console = &sercons;
+#endif
 	rs_driver.open	= rs_open;
 	rs_driver.close = gs_close;
 	rs_driver.write = gs_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/char/sh-sci.c linux/drivers/char/sh-sci.c
--- linux-2.5.2-pre3/drivers/char/sh-sci.c	Thu Dec 27 17:20:22 2001
+++ linux/drivers/char/sh-sci.c	Thu Dec 27 19:28:43 2001
@@ -1040,7 +1040,9 @@
 	sci_driver.table = sci_table;
 	sci_driver.termios = sci_termios;
 	sci_driver.termios_locked = sci_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+        sci_driver.console = &sercons;
+#endif
 	sci_driver.open	= sci_open;
 	sci_driver.close = gs_close;
 	sci_driver.write = gs_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/char/vme_scc.c linux/drivers/char/vme_scc.c
--- linux-2.5.2-pre3/drivers/char/vme_scc.c	Thu Dec 27 17:20:22 2001
+++ linux/drivers/char/vme_scc.c	Thu Dec 27 19:33:24 2001
@@ -92,10 +92,10 @@
 static void scc_break_ctl(struct tty_struct *tty, int break_state);
 
 static struct tty_driver scc_driver, scc_callout_driver;
-
 static struct tty_struct *scc_table[2] = { NULL, };
 static struct termios * scc_termios[2];
 static struct termios * scc_termios_locked[2];
+static struct console sercons;
 struct scc_port scc_ports[2];
 
 int scc_refcount;
@@ -145,7 +145,9 @@
 	scc_driver.table = scc_table;
 	scc_driver.termios = scc_termios;
 	scc_driver.termios_locked = scc_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+	scc_driver.console = &sercons;
+#endif
 	scc_driver.open	= scc_open;
 	scc_driver.close = gs_close;
 	scc_driver.write = gs_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/macintosh/macserial.c linux/drivers/macintosh/macserial.c
--- linux-2.5.2-pre3/drivers/macintosh/macserial.c	Thu Dec 27 17:20:22 2001
+++ linux/drivers/macintosh/macserial.c	Thu Dec 27 20:01:27 2001
@@ -2580,7 +2580,9 @@
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
 	serial_driver.termios_locked = serial_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+	serial_driver.console = &sercons;
+#endif
 	serial_driver.open = rs_open;
 	serial_driver.close = rs_close;
 	serial_driver.write = rs_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/s390/char/con3215.c linux/drivers/s390/char/con3215.c
--- linux-2.5.2-pre3/drivers/s390/char/con3215.c	Wed Dec 26 10:41:53 2001
+++ linux/drivers/s390/char/con3215.c	Thu Dec 27 19:54:14 2001
@@ -1145,7 +1145,9 @@
 	tty3215_driver.table = tty3215_table;
 	tty3215_driver.termios = tty3215_termios;
 	tty3215_driver.termios_locked = tty3215_termios_locked;
-
+#ifdef CONFIG_TN3215_CONSOLE
+	tty3215_driver.console = &con3215;
+#endif
 	tty3215_driver.open = tty3215_open;
 	tty3215_driver.close = tty3215_close;
 	tty3215_driver.write = tty3215_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/s390/char/tubtty.c linux/drivers/s390/char/tubtty.c
--- linux-2.5.2-pre3/drivers/s390/char/tubtty.c	Wed Dec 26 10:41:53 2001
+++ linux/drivers/s390/char/tubtty.c	Thu Dec 27 19:53:31 2001
@@ -53,6 +53,7 @@
 struct tty_struct *tty3270_table[TUBMAXMINS];
 struct termios *tty3270_termios[TUBMAXMINS];
 struct termios *tty3270_termios_locked[TUBMAXMINS];
+extern struct console tub3270_con;
 #ifdef CONFIG_TN3270_CONSOLE
 int con3270_major = -1;
 struct tty_driver con3270_driver;
@@ -94,7 +95,9 @@
 	td->table = tty3270_table;
 	td->termios = tty3270_termios;
 	td->termios_locked = tty3270_termios_locked;
-
+#ifdef CONFIG_TN3270_CONSOLE
+	td->console = &tub3270_con;
+#endif
 	td->open = tty3270_open;
 	td->close = tty3270_close;
 	td->write = tty3270_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/sbus/char/sab82532.c linux/drivers/sbus/char/sab82532.c
--- linux-2.5.2-pre3/drivers/sbus/char/sab82532.c	Thu Dec 27 17:20:22 2001
+++ linux/drivers/sbus/char/sab82532.c	Thu Dec 27 20:00:11 2001
@@ -2251,7 +2251,9 @@
 	serial_driver.table = sab82532_table;
 	serial_driver.termios = sab82532_termios;
 	serial_driver.termios_locked = sab82532_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+	serial_driver.console = &sab82532_console;
+#endif
 	serial_driver.open = sab82532_open;
 	serial_driver.close = sab82532_close;
 	serial_driver.write = sab82532_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/sbus/char/su.c linux/drivers/sbus/char/su.c
--- linux-2.5.2-pre3/drivers/sbus/char/su.c	Thu Dec 27 17:20:22 2001
+++ linux/drivers/sbus/char/su.c	Thu Dec 27 19:55:34 2001
@@ -2506,7 +2506,9 @@
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
 	serial_driver.termios_locked = serial_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+	serial_driver.console = &sercons;
+#endif
 	serial_driver.open = su_open;
 	serial_driver.close = su_close;
 	serial_driver.write = su_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/sbus/char/zs.c linux/drivers/sbus/char/zs.c
--- linux-2.5.2-pre3/drivers/sbus/char/zs.c	Thu Dec 27 17:20:22 2001
+++ linux/drivers/sbus/char/zs.c	Thu Dec 27 19:57:51 2001
@@ -2425,7 +2425,9 @@
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
 	serial_driver.termios_locked = serial_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+        serial_driver.console = &zs_console;
+#endif
 	serial_driver.open = zs_open;
 	serial_driver.close = zs_close;
 	serial_driver.write = zs_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/sgi/char/sgiserial.c linux/drivers/sgi/char/sgiserial.c
--- linux-2.5.2-pre3/drivers/sgi/char/sgiserial.c	Thu Dec 27 17:20:23 2001
+++ linux/drivers/sgi/char/sgiserial.c	Thu Dec 27 19:19:28 2001
@@ -98,6 +98,7 @@
 DECLARE_TASK_QUEUE(tq_serial);
 
 struct tty_driver serial_driver, callout_driver;
+struct console sgi_console_driver;
 struct console *sgisercon;
 static int serial_refcount;
 
@@ -1886,7 +1887,9 @@
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
 	serial_driver.termios_locked = serial_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+        serial_driver.console = &sgi_console_driver;
+#endif
 	serial_driver.open = rs_open;
 	serial_driver.close = rs_close;
 	serial_driver.write = rs_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/drivers/tc/zs.c linux/drivers/tc/zs.c
--- linux-2.5.2-pre3/drivers/tc/zs.c	Thu Dec 27 17:20:23 2001
+++ linux/drivers/tc/zs.c	Thu Dec 27 19:14:10 2001
@@ -1893,7 +1893,9 @@
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
 	serial_driver.termios_locked = serial_termios_locked;
-
+#ifdef CONFIG_SERIAL_CONSOLE
+        serial_driver.console = &sercons;
+#endif
 	serial_driver.open = rs_open;
 	serial_driver.close = rs_close;
 	serial_driver.write = rs_write;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-pre3/include/linux/tty_driver.h linux/include/linux/tty_driver.h
--- linux-2.5.2-pre3/include/linux/tty_driver.h	Wed Dec 26 10:42:26 2001
+++ linux/include/linux/tty_driver.h	Thu Dec 27 20:10:25 2001
@@ -130,6 +130,7 @@
 	struct termios init_termios; /* Initial termios */
 	int	flags;		/* tty driver flags */
 	int	*refcount;	/* for loadable tty drivers */
+	struct console *console;/* console attached to this tty hardware */
 	struct proc_dir_entry *proc_entry; /* /proc fs entry */
 	struct tty_driver *other; /* only used for the PTY driver */
 

