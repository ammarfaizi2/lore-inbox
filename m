Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265770AbSKFQ03>; Wed, 6 Nov 2002 11:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSKFQ03>; Wed, 6 Nov 2002 11:26:29 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:49908 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265770AbSKFQ0Q>; Wed, 6 Nov 2002 11:26:16 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, gerg@snapgear.com
Subject: Console init revamp.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Nov 2002 16:32:42 +0000
Message-ID: <8025.1036600362@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes all the #ifdef'd calls to initialise individual consoles in 
con_init(), and replaces them with a mechanism akin to initcalls. 

I've fixed all the vmlinux.lds.S files except uCLinux. Greg, how about some 
appropriate #includes to reduce the duplication there?

===== drivers/char/tty_io.c 1.44 vs edited =====
--- 1.44/drivers/char/tty_io.c	Sat Oct 12 02:12:11 2002
+++ edited/drivers/char/tty_io.c	Wed Nov  6 16:18:58 2002
@@ -112,7 +112,15 @@
 #define TTY_PARANOIA_CHECK 1
 #define CHECK_TTY_COUNT 1
 
-struct termios tty_std_termios;		/* for the benefit of tty drivers  */
+struct termios tty_std_termios = {	/* for the benefit of tty drivers  */
+	.c_iflag = ICRNL | IXON,
+	.c_oflag = OPOST | ONLCR,
+	.c_cflag = B38400 | CS8 | CREAD | HUPCL,
+	.c_lflag = ISIG | ICANON | ECHO | ECHOE | ECHOK |
+		   ECHOCTL | ECHOKE | IEXTEN,
+	.c_cc = INIT_C_CC
+};
+
 LIST_HEAD(tty_drivers);			/* linked list of tty drivers */
 struct tty_ldisc ldiscs[NR_LDISCS];	/* line disc dispatch table	*/
 
@@ -140,24 +148,12 @@
 	      unsigned int cmd, unsigned long arg);
 static int tty_fasync(int fd, struct file * filp, int on);
 extern int vme_scc_init (void);
-extern long vme_scc_console_init(void);
 extern int serial167_init(void);
-extern long serial167_console_init(void);
-extern void console_8xx_init(void);
 extern int rs_8xx_init(void);
-extern void mac_scc_console_init(void);
-extern void hwc_console_init(void);
 extern void hwc_tty_init(void);
-extern void con3215_init(void);
 extern void tty3215_init(void);
-extern void tub3270_con_init(void);
 extern void tub3270_init(void);
-extern void uart_console_init(void);
-extern void sgi_serial_console_init(void);
-extern void sci_console_init(void);
-extern void tx3912_console_init(void);
 extern void tx3912_rs_init(void);
-extern void hvc_console_init(void);
 
 #ifndef MIN
 #define MIN(a,b)	((a) < (b) ? (a) : (b))
@@ -2157,82 +2153,24 @@
  */
 void __init console_init(void)
 {
+	initcall_t *call;
+
 	/* Setup the default TTY line discipline. */
-	memset(ldiscs, 0, sizeof(ldiscs));
 	(void) tty_register_ldisc(N_TTY, &tty_ldisc_N_TTY);
 
 	/*
-	 * Set up the standard termios.  Individual tty drivers may 
-	 * deviate from this; this is used as a template.
-	 */
-	memset(&tty_std_termios, 0, sizeof(struct termios));
-	memcpy(tty_std_termios.c_cc, INIT_C_CC, NCCS);
-	tty_std_termios.c_iflag = ICRNL | IXON;
-	tty_std_termios.c_oflag = OPOST | ONLCR;
-	tty_std_termios.c_cflag = B38400 | CS8 | CREAD | HUPCL;
-	tty_std_termios.c_lflag = ISIG | ICANON | ECHO | ECHOE | ECHOK |
-		ECHOCTL | ECHOKE | IEXTEN;
-
-	/*
 	 * set up the console device so that later boot sequences can 
 	 * inform about problems etc..
 	 */
 #ifdef CONFIG_EARLY_PRINTK
 	disable_early_printk();
 #endif
-#ifdef CONFIG_VT
-	con_init();
-#endif
-#ifdef CONFIG_AU1000_SERIAL_CONSOLE
-	au1000_serial_console_init();
-#endif
-#ifdef CONFIG_SERIAL_CONSOLE
-#if (defined(CONFIG_8xx) || defined(CONFIG_8260))
-	console_8xx_init();
-#elif defined(CONFIG_MAC_SERIAL)
- 	mac_scc_console_init();
-#elif defined(CONFIG_PARISC)
-	pdc_console_init();
-#elif defined(CONFIG_SERIAL)
-	serial_console_init();
-#endif /* CONFIG_8xx */
-#ifdef CONFIG_SGI_SERIAL
-	sgi_serial_console_init();
-#endif
-#if defined(CONFIG_MVME162_SCC) || defined(CONFIG_BVME6000_SCC) || defined(CONFIG_MVME147_SCC)
-	vme_scc_console_init();
-#endif
-#if defined(CONFIG_SERIAL167)
-	serial167_console_init();
-#endif
-#if defined(CONFIG_SH_SCI)
-	sci_console_init();
-#endif
-#endif
-#ifdef CONFIG_TN3270_CONSOLE
-	tub3270_con_init();
-#endif
-#ifdef CONFIG_TN3215
-	con3215_init();
-#endif
-#ifdef CONFIG_HWC
-        hwc_console_init();
-#endif
-#ifdef CONFIG_STDIO_CONSOLE
-	stdio_console_init();
-#endif
-#ifdef CONFIG_SERIAL_CORE_CONSOLE
-	uart_console_init();
-#endif
-#ifdef CONFIG_ARC_CONSOLE
-	arc_console_init();
-#endif
-#ifdef CONFIG_SERIAL_TX3912_CONSOLE
-	tx3912_console_init();
-#endif
-#ifdef CONFIG_HVC_CONSOLE
-	hvc_console_init();
-#endif
+
+	call = &__con_initcall_start;
+	while (call < &__con_initcall_end) {
+		(*call)();
+		call++;
+	};
 }
 
 static struct tty_driver dev_tty_driver, dev_syscons_driver;
===== drivers/serial/core.c 1.17 vs edited =====
--- 1.17/drivers/serial/core.c	Sat Nov  2 16:52:24 2002
+++ edited/drivers/serial/core.c	Wed Nov  6 16:19:03 2002
@@ -1827,42 +1827,6 @@
 
 	return 0;
 }
-
-extern void ambauart_console_init(void);
-extern void anakin_console_init(void);
-extern void clps711xuart_console_init(void);
-extern void rs285_console_init(void);
-extern void sa1100_rs_console_init(void);
-extern void serial8250_console_init(void);
-extern void uart00_console_init(void);
-
-/*
- * Central "initialise all serial consoles" container.  Needs to be killed.
- */
-void __init uart_console_init(void)
-{
-#ifdef CONFIG_SERIAL_AMBA_CONSOLE
-	ambauart_console_init();
-#endif
-#ifdef CONFIG_SERIAL_ANAKIN_CONSOLE
-	anakin_console_init();
-#endif
-#ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
-	clps711xuart_console_init();
-#endif
-#ifdef CONFIG_SERIAL_21285_CONSOLE
-	rs285_console_init();
-#endif
-#ifdef CONFIG_SERIAL_SA1100_CONSOLE
-	sa1100_rs_console_init();
-#endif
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	serial8250_console_init();
-#endif
-#ifdef CONFIG_SERIAL_UART00_CONSOLE
-	uart00_console_init();
-#endif
-}
 #endif /* CONFIG_SERIAL_CORE_CONSOLE */
 
 #ifdef CONFIG_PM
===== drivers/char/amiserial.c 1.10 vs edited =====
--- 1.10/drivers/char/amiserial.c	Mon Jul 22 14:42:36 2002
+++ edited/drivers/char/amiserial.c	Wed Nov  6 16:18:57 2002
@@ -2322,10 +2322,11 @@
 /*
  *	Register console.
  */
-void __init serial_console_init(void)
+static void __init amiserial_console_init(void)
 {
 	register_console(&sercons);
 }
+console_initcall(amiserial_console_init);
 #endif
 
 MODULE_LICENSE("GPL");
===== drivers/char/decserial.c 1.2 vs edited =====
--- 1.2/drivers/char/decserial.c	Tue Feb  5 07:45:05 2002
+++ edited/drivers/char/decserial.c	Wed Nov  6 16:18:57 2002
@@ -75,7 +75,7 @@
 /* serial_console_init handles the special case of starting
  *   up the console on the serial port
  */
-void __init serial_console_init(void)
+static void __init decserial_console_init(void)
 {
 #if defined(CONFIG_ZS) && defined(CONFIG_DZ)
     if (IOASIC)
@@ -94,5 +94,6 @@
 
 #endif
 }
+console_initcall(decserial_console_init);
 
 #endif
===== drivers/char/hvc_console.c 1.9 vs edited =====
--- 1.9/drivers/char/hvc_console.c	Sun Sep 15 19:35:38 2002
+++ edited/drivers/char/hvc_console.c	Wed Nov  6 16:18:57 2002
@@ -348,11 +348,12 @@
 	index:		-1,
 };
 
-int __init hvc_console_init(void)
+static int __init hvc_console_init(void)
 {
 	register_console(&hvc_con_driver);
 	return 0;
 }
+console_initcall(hvc_console_init);
 
 module_init(hvc_init);
 module_exit(hvc_exit);
===== drivers/char/serial167.c 1.12 vs edited =====
--- 1.12/drivers/char/serial167.c	Mon Oct  7 19:39:20 2002
+++ edited/drivers/char/serial167.c	Wed Nov  6 16:18:58 2002
@@ -2836,7 +2836,7 @@
 };
 
 
-void __init serial167_console_init(void)
+static void __init serial167_console_init(void)
 {
 	if (vme_brdtype == VME_TYPE_MVME166 ||
 			vme_brdtype == VME_TYPE_MVME167 ||
@@ -2845,6 +2845,7 @@
 		register_console(&sercons);
 	}
 }
+console_initcall(serial167_console_init);
 
 #ifdef CONFIG_REMOTE_DEBUG
 void putDebugChar (int c)
===== drivers/char/serial_tx3912.c 1.6 vs edited =====
--- 1.6/drivers/char/serial_tx3912.c	Tue Sep 10 10:10:44 2002
+++ edited/drivers/char/serial_tx3912.c	Wed Nov  6 16:18:58 2002
@@ -1054,9 +1054,10 @@
 	index:    -1
 };
 
-void __init tx3912_console_init(void)
+static void __init tx3912_console_init(void)
 {
 	register_console(&sercons);
 }
+console_initcall(tx3912_console_init);
 
 #endif
===== drivers/char/sh-sci.c 1.11 vs edited =====
--- 1.11/drivers/char/sh-sci.c	Tue Oct  1 17:10:55 2002
+++ edited/drivers/char/sh-sci.c	Wed Nov  6 16:18:58 2002
@@ -1275,7 +1275,7 @@
 extern void sh_console_unregister (void);
 #endif
 
-void __init sci_console_init(void)
+static void __init sci_console_init(void)
 {
 	register_console(&sercons);
 #ifdef CONFIG_SH_EARLY_PRINTK
@@ -1285,4 +1285,6 @@
 	sh_console_unregister();
 #endif
 }
+console_initcall(sci_console_init);
+
 #endif /* CONFIG_SERIAL_CONSOLE */
===== drivers/char/vme_scc.c 1.8 vs edited =====
--- 1.8/drivers/char/vme_scc.c	Tue Oct 22 21:51:04 2002
+++ edited/drivers/char/vme_scc.c	Wed Nov  6 16:18:58 2002
@@ -1103,7 +1103,7 @@
 };
 
 
-void __init vme_scc_console_init(void)
+static void __init vme_scc_console_init(void)
 {
 	if (vme_brdtype == VME_TYPE_MVME147 ||
 			vme_brdtype == VME_TYPE_MVME162 ||
@@ -1112,4 +1112,4 @@
 			vme_brdtype == VME_TYPE_BVME6000)
 		register_console(&sercons);
 }
-
+console_initcall(vme_scc_console_init);
===== drivers/char/vt.c 1.20 vs edited =====
--- 1.20/drivers/char/vt.c	Tue Oct  1 17:56:05 2002
+++ edited/drivers/char/vt.c	Wed Nov  6 16:18:58 2002
@@ -2435,7 +2435,7 @@
 struct tty_driver console_driver;
 static int console_refcount;
 
-void __init con_init(void)
+static void __init con_init(void)
 {
 	const char *display_desc = NULL;
 	unsigned int currcons = 0;
@@ -2484,6 +2484,7 @@
 	register_console(&vt_console_driver);
 #endif
 }
+console_initcall(con_init);
 
 int __init vty_init(void)
 {
===== drivers/macintosh/macserial.c 1.10 vs edited =====
--- 1.10/drivers/macintosh/macserial.c	Mon Oct  7 19:39:20 2002
+++ edited/drivers/macintosh/macserial.c	Wed Nov  6 16:18:58 2002
@@ -3088,10 +3088,12 @@
 /*
  *	Register console.
  */
-void __init mac_scc_console_init(void)
+static void __init mac_scc_console_init(void)
 {
 	register_console(&sercons);
 }
+console_initcall(mac_scc_console_init);
+
 #endif /* ifdef CONFIG_SERIAL_CONSOLE */
 
 #ifdef CONFIG_KGDB
===== drivers/s390/char/con3215.c 1.9 vs edited =====
--- 1.9/drivers/s390/char/con3215.c	Wed Oct  9 15:01:20 2002
+++ edited/drivers/s390/char/con3215.c	Wed Nov  6 16:18:59 2002
@@ -1052,7 +1052,7 @@
  * 3215 console initialization code called from console_init().
  * NOTE: This is called before kmalloc is available.
  */
-void __init con3215_init(void)
+static void __init con3215_init(void)
 {
 #ifdef CONFIG_TN3215_CONSOLE
 	raw3215_info *raw;
@@ -1126,6 +1126,7 @@
 	}
 #endif
 }
+console_initcall(con3215_init);
 
 /*
  * 3215 tty registration code called from tty_init().
===== drivers/s390/char/hwc_con.c 1.5 vs edited =====
--- 1.5/drivers/s390/char/hwc_con.c	Thu Jun  6 22:29:46 2002
+++ edited/drivers/s390/char/hwc_con.c	Wed Nov  6 16:18:59 2002
@@ -73,7 +73,7 @@
 
 #endif
 
-void __init 
+static void __init 
 hwc_console_init (void)
 {
 	if (!MACHINE_HAS_HWC)
@@ -90,3 +90,4 @@
 
 	return;
 }
+console_initcall(hwc_console_init);
===== drivers/s390/char/tuball.c 1.8 vs edited =====
--- 1.8/drivers/s390/char/tuball.c	Wed Oct  9 15:01:46 2002
+++ edited/drivers/s390/char/tuball.c	Wed Nov  6 16:18:59 2002
@@ -131,7 +131,7 @@
 #else
 #define tub3270_con_devno console_device
 
-void __init tub3270_con_init(void)
+static void __init tub3270_con_init(void)
 {
 	tub3270_con_bcb.bc_len = 65536;
 	if (!CONSOLE_IS_3270)
@@ -140,6 +140,8 @@
 		tub3270_con_bcb.bc_len);
 	register_console(&tub3270_con);
 }
+console_initcall(tub3270_con_init);
+
 #endif
 
 static kdev_t
===== drivers/serial/21285.c 1.10 vs edited =====
--- 1.10/drivers/serial/21285.c	Sat Nov  2 14:11:04 2002
+++ edited/drivers/serial/21285.c	Wed Nov  6 16:19:00 2002
@@ -471,11 +471,12 @@
 	.index		= -1,
 };
 
-void __init rs285_console_init(void)
+static void __init rs285_console_init(void)
 {
 	serial21285_setup_ports();
 	register_console(&serial21285_console);
 }
+console_initcall(rs283_console_init);
 
 #define SERIAL_21285_CONSOLE	&serial21285_console
 #else
===== drivers/serial/8250.c 1.22 vs edited =====
--- 1.22/drivers/serial/8250.c	Sat Nov  2 16:47:18 2002
+++ edited/drivers/serial/8250.c	Wed Nov  6 16:19:00 2002
@@ -1908,11 +1908,12 @@
 	.index		= -1,
 };
 
-void __init serial8250_console_init(void)
+static void __init serial8250_console_init(void)
 {
 	serial8250_isa_init_ports();
 	register_console(&serial8250_console);
 }
+console_initcall(serial8250_console_init);
 
 #define SERIAL8250_CONSOLE	&serial8250_console
 #else
===== drivers/serial/amba.c 1.12 vs edited =====
--- 1.12/drivers/serial/amba.c	Mon Nov  4 14:58:44 2002
+++ edited/drivers/serial/amba.c	Wed Nov  6 16:19:01 2002
@@ -693,10 +693,11 @@
 	.index		= -1,
 };
 
-void __init ambauart_console_init(void)
+static void __init ambauart_console_init(void)
 {
 	register_console(&amba_console);
 }
+console_initcall(ambauart_console_init);
 
 #define AMBA_CONSOLE	&amba_console
 #else
===== drivers/serial/anakin.c 1.9 vs edited =====
--- 1.9/drivers/serial/anakin.c	Mon Nov  4 14:58:44 2002
+++ edited/drivers/serial/anakin.c	Wed Nov  6 16:19:01 2002
@@ -478,11 +478,12 @@
 	.index		= -1,
 };
 
-void __init
+static void __init
 anakin_console_init(void)
 {
 	register_console(&anakin_console);
 }
+console_initcall(anakin_console_init);
 
 #define ANAKIN_CONSOLE		&anakin_console
 #else
===== drivers/serial/clps711x.c 1.9 vs edited =====
--- 1.9/drivers/serial/clps711x.c	Mon Nov  4 14:58:45 2002
+++ edited/drivers/serial/clps711x.c	Wed Nov  6 16:19:02 2002
@@ -553,10 +553,11 @@
 	.index		= -1,
 };
 
-void __init clps711xuart_console_init(void)
+static void __init clps711xuart_console_init(void)
 {
 	register_console(&clps711x_console);
 }
+console_initcall(clps711xuart_console_init);
 
 #define CLPS711X_CONSOLE	&clps711x_console
 #else
===== drivers/serial/sa1100.c 1.12 vs edited =====
--- 1.12/drivers/serial/sa1100.c	Sat Nov  2 14:11:05 2002
+++ edited/drivers/serial/sa1100.c	Wed Nov  6 16:19:03 2002
@@ -813,11 +813,12 @@
 	.index		= -1,
 };
 
-void __init sa1100_rs_console_init(void)
+static void __init sa1100_rs_console_init(void)
 {
 	sa1100_init_ports();
 	register_console(&sa1100_console);
 }
+console_initcall(sa1100_rs_console_init);
 
 #define SA1100_CONSOLE	&sa1100_console
 #else
===== drivers/serial/uart00.c 1.7 vs edited =====
--- 1.7/drivers/serial/uart00.c	Mon Nov  4 14:58:45 2002
+++ edited/drivers/serial/uart00.c	Wed Nov  6 16:19:04 2002
@@ -628,10 +628,11 @@
 	.index		= 0,
 };
 
-void __init uart00_console_init(void)
+static void __init uart00_console_init(void)
 {
 	register_console(&uart00_console);
 }
+console_initcall(uart00_console_init);
 
 #define UART00_CONSOLE	&uart00_console
 #else
===== drivers/sgi/char/sgiserial.c 1.6 vs edited =====
--- 1.6/drivers/sgi/char/sgiserial.c	Mon Oct  7 19:39:20 2002
+++ edited/drivers/sgi/char/sgiserial.c	Wed Nov  6 16:19:04 2002
@@ -2269,8 +2269,10 @@
 /*
  *	Register console.
  */
-void __init sgi_serial_console_init(void)
+static void __init sgi_serial_console_init(void)
 {
 	register_console(&sgi_console_driver);
 }
+console_initcall(sgi_serial_console_init);
+
 __initcall(rs_init);
===== include/linux/init.h 1.16 vs edited =====
--- 1.16/include/linux/init.h	Sat Oct 26 01:17:41 2002
+++ edited/include/linux/init.h	Wed Nov  6 16:19:04 2002
@@ -49,6 +49,7 @@
 typedef void (*exitcall_t)(void);
 
 extern initcall_t __initcall_start, __initcall_end;
+extern initcall_t __con_initcall_start, __con_initcall_end;
 
 /* initcalls are now grouped by functionality into separate 
  * subsections. Ordering inside the subsections is determined
@@ -72,6 +73,9 @@
 
 #define __exitcall(fn)								\
 	static exitcall_t __exitcall_##fn __exit_call = fn
+
+#define console_initcall(fn) \
+	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".con_initcall.init")))=fn
 
 /*
  * Used for kernel command line parameter setup
===== arch/alpha/vmlinux.lds.S 1.12 vs edited =====
--- 1.12/arch/alpha/vmlinux.lds.S	Tue Nov  5 16:08:10 2002
+++ edited/arch/alpha/vmlinux.lds.S	Wed Nov  6 16:18:52 2002
@@ -73,6 +73,12 @@
 	__initramfs_end = .;
   }
 
+  .con_initcall.init ALIGN(8): {
+	__con_initcall_start = .;
+	*(.con_initcall.init)
+	__con_initcall_end = .;
+  }
+
   .data.percpu ALIGN(64): {
 	__per_cpu_start = .;
 	*(.data.percpu)
===== arch/arm/vmlinux-armo.lds.in 1.10 vs edited =====
--- 1.10/arch/arm/vmlinux-armo.lds.in	Sun Oct 20 01:10:46 2002
+++ edited/arch/arm/vmlinux-armo.lds.in	Wed Nov  6 16:18:52 2002
@@ -35,6 +35,9 @@
 			*(.initcall6.init)
 			*(.initcall7.init)
 		__initcall_end = .;
+		__con_initcall_start = .;
+			*(.con_initcall.init)
+		__con_initcall_end = .;
 		. = ALIGN(32768);
 		__init_end = .;
 	}
===== arch/arm/vmlinux-armv.lds.in 1.14 vs edited =====
--- 1.14/arch/arm/vmlinux-armv.lds.in	Tue Nov  5 17:12:16 2002
+++ edited/arch/arm/vmlinux-armv.lds.in	Wed Nov  6 16:22:05 2002
@@ -35,6 +35,9 @@
 			*(.initcall6.init)
 			*(.initcall7.init)
 		__initcall_end = .;
+		__con_initcall_start = .;
+			*(.con_initcall.init)
+		__con_initcall_end = .;
 		. = ALIGN(32);
 		__initramfs_start = .;
 			usr/built-in.o(.init.ramfs)
===== arch/cris/vmlinux.lds.S 1.12 vs edited =====
--- 1.12/arch/cris/vmlinux.lds.S	Wed Sep 18 00:37:53 2002
+++ edited/arch/cris/vmlinux.lds.S	Wed Nov  6 16:18:53 2002
@@ -73,7 +73,12 @@
 		*(.initcall6.init);
 		*(.initcall7.init);
 		__initcall_end = .;
-
+	}
+	.con_initcall.init : {
+		__con_initcall_start = .;
+		*(.con_initcall.init)
+		__con_initcall_end = .;
+	
 		/* We fill to the next page, so we can discard all init
 		   pages without needing to consider what payload might be
 		   appended to the kernel image.  */
===== arch/i386/vmlinux.lds.S 1.19 vs edited =====
--- 1.19/arch/i386/vmlinux.lds.S	Mon Nov  4 22:04:41 2002
+++ edited/arch/i386/vmlinux.lds.S	Wed Nov  6 16:21:25 2002
@@ -77,6 +77,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
===== arch/ia64/vmlinux.lds.S 1.17 vs edited =====
--- 1.17/arch/ia64/vmlinux.lds.S	Fri Nov  1 05:45:22 2002
+++ edited/arch/ia64/vmlinux.lds.S	Wed Nov  6 16:18:53 2002
@@ -114,6 +114,10 @@
 		*(.initcall7.init)
 	}
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : AT(ADDR(.con_initcall.init) - PAGE_OFFSET)
+	{ *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(PAGE_SIZE);
   __init_end = .;
 
===== arch/m68k/vmlinux-std.lds 1.9 vs edited =====
--- 1.9/arch/m68k/vmlinux-std.lds	Wed Oct 23 17:34:05 2002
+++ edited/arch/m68k/vmlinux-std.lds	Wed Nov  6 16:18:54 2002
@@ -58,6 +58,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(8192);
   __init_end = .;
 
===== arch/m68k/vmlinux-sun3.lds 1.6 vs edited =====
--- 1.6/arch/m68k/vmlinux-sun3.lds	Wed Oct 23 17:34:05 2002
+++ edited/arch/m68k/vmlinux-sun3.lds	Wed Nov  6 16:18:54 2002
@@ -54,6 +54,9 @@
 		*(.initcall7.init)
 	}
 	__initcall_end = .;
+	__con_initcall_start = .;
+	.con_initcall.init : { *(.con_initcall.init) }
+	__con_initcall_end = .;
 	. = ALIGN(8192);
 	__init_end = .;
 	.init.task : { *(init_task) }
===== arch/mips/vmlinux.lds.S 1.4 vs edited =====
--- 1.4/arch/mips/vmlinux.lds.S	Wed Sep 18 00:38:49 2002
+++ edited/arch/mips/vmlinux.lds.S	Wed Nov  6 16:18:54 2002
@@ -54,6 +54,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(4096);	/* Align double page for init_task_union */
   __init_end = .;
 
===== arch/mips/arc/arc_con.c 1.1 vs edited =====
--- 1.1/arch/mips/arc/arc_con.c	Tue Feb  5 18:12:45 2002
+++ edited/arch/mips/arc/arc_con.c	Wed Nov  6 16:18:54 2002
@@ -63,7 +63,8 @@
  *    Register console.
  */
 
-void __init arc_console_init(void)
+static void __init arc_console_init(void)
 {
 	register_console(&arc_cons);
 }
+console_initcall(arc_console_init);
===== arch/mips/au1000/common/serial.c 1.4 vs edited =====
--- 1.4/arch/mips/au1000/common/serial.c	Tue Sep 17 18:26:46 2002
+++ edited/arch/mips/au1000/common/serial.c	Wed Nov  6 16:18:55 2002
@@ -3054,10 +3054,11 @@
 /*
  *	Register console.
  */
-void __init au1000_serial_console_init(void)
+static void __init au1000_serial_console_init(void)
 {
 	register_console(&sercons);
 }
+console_initcall(au1000_serial_console_init);
 #endif
 
 /*
===== arch/mips64/vmlinux.lds.S 1.4 vs edited =====
--- 1.4/arch/mips64/vmlinux.lds.S	Sat Aug 17 04:08:39 2002
+++ edited/arch/mips64/vmlinux.lds.S	Wed Nov  6 16:18:55 2002
@@ -50,6 +50,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(4096);	/* Align double page for init_task_union */
   __init_end = .;
 
===== arch/parisc/vmlinux.lds.S 1.6 vs edited =====
--- 1.6/arch/parisc/vmlinux.lds.S	Mon Oct 28 10:32:57 2002
+++ edited/arch/parisc/vmlinux.lds.S	Wed Nov  6 16:18:55 2002
@@ -79,6 +79,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
===== arch/ppc/vmlinux.lds.S 1.12 vs edited =====
--- 1.12/arch/ppc/vmlinux.lds.S	Fri Oct 18 13:24:04 2002
+++ edited/arch/ppc/vmlinux.lds.S	Wed Nov  6 16:18:55 2002
@@ -112,6 +112,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
===== arch/ppc/8xx_io/uart.c 1.16 vs edited =====
--- 1.16/arch/ppc/8xx_io/uart.c	Wed Sep 18 07:26:40 2002
+++ edited/arch/ppc/8xx_io/uart.c	Wed Nov  6 16:18:55 2002
@@ -2522,12 +2522,11 @@
 /*
  *	Register console.
  */
-long __init console_8xx_init(long kmem_start, long kmem_end)
+static void __init console_8xx_init(long kmem_start, long kmem_end)
 {
 	register_console(&sercons);
-	return kmem_start;
 }
-
+console_initcall(console_8xx_init);
 #endif
 
 /* Index in baud rate table of the default console baud rate.
===== arch/ppc64/vmlinux.lds.S 1.6 vs edited =====
--- 1.6/arch/ppc64/vmlinux.lds.S	Tue Sep 17 23:58:28 2002
+++ edited/arch/ppc64/vmlinux.lds.S	Wed Nov  6 16:18:55 2002
@@ -110,6 +110,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
===== arch/s390/vmlinux.lds.S 1.4 vs edited =====
--- 1.4/arch/s390/vmlinux.lds.S	Wed Oct  9 15:01:28 2002
+++ edited/arch/s390/vmlinux.lds.S	Wed Nov  6 16:18:55 2002
@@ -64,6 +64,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(256);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
===== arch/s390x/vmlinux.lds.S 1.4 vs edited =====
--- 1.4/arch/s390x/vmlinux.lds.S	Wed Oct  9 15:01:28 2002
+++ edited/arch/s390x/vmlinux.lds.S	Wed Nov  6 16:18:55 2002
@@ -64,6 +64,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(256);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
===== arch/sh/vmlinux.lds.S 1.6 vs edited =====
--- 1.6/arch/sh/vmlinux.lds.S	Fri May 10 18:24:46 2002
+++ edited/arch/sh/vmlinux.lds.S	Wed Nov  6 16:18:56 2002
@@ -74,6 +74,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   __machvec_start = .;
   .machvec.init : { *(.machvec.init) }
   __machvec_end = .;
===== arch/sparc/vmlinux.lds.S 1.9 vs edited =====
--- 1.9/arch/sparc/vmlinux.lds.S	Tue Nov  5 15:52:17 2002
+++ edited/arch/sparc/vmlinux.lds.S	Wed Nov  6 16:21:10 2002
@@ -56,6 +56,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
===== arch/sparc64/vmlinux.lds.S 1.10 vs edited =====
--- 1.10/arch/sparc64/vmlinux.lds.S	Tue Nov  5 15:50:52 2002
+++ edited/arch/sparc64/vmlinux.lds.S	Wed Nov  6 16:21:17 2002
@@ -57,6 +57,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(8192); 
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
===== arch/um/drivers/stdio_console.c 1.3 vs edited =====
--- 1.3/arch/um/drivers/stdio_console.c	Wed Oct 16 02:44:46 2002
+++ edited/arch/um/drivers/stdio_console.c	Wed Nov  6 16:18:57 2002
@@ -185,12 +185,13 @@
 					       console_device, console_setup,
 					       CON_PRINTBUFFER);
 
-void stdio_console_init(void)
+static void __init stdio_console_init(void)
 {
 	INIT_LIST_HEAD(&vts[0].chan_list);
 	list_add(&init_console_chan.list, &vts[0].chan_list);
 	register_console(&stdiocons);
 }
+console_initcall(stdio_console_init);
 
 static int console_chan_setup(char *str)
 {
===== arch/x86_64/vmlinux.lds.S 1.7 vs edited =====
--- 1.7/arch/x86_64/vmlinux.lds.S	Mon Oct 21 14:47:25 2002
+++ edited/arch/x86_64/vmlinux.lds.S	Wed Nov  6 16:18:57 2002
@@ -98,6 +98,9 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }

--
dwmw2


