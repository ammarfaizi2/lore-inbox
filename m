Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbTIVUe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263278AbTIVUe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:34:56 -0400
Received: from verein.lst.de ([212.34.189.10]:23459 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263272AbTIVUeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:34:36 -0400
Date: Mon, 22 Sep 2003 22:34:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] switch remaining serial drivers to initcalls
Message-ID: <20030922203429.GA30303@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All drivers that compile on ppc with CONFIG_ISA set (= all but
some m68-only drivers), I looked at the compile warnings very
closely and there are no new warnings or even errors this time :)

drivers/char/Makefile needed to be reordered big time to keep
the intialization order the same.


--- 1.28/arch/ppc/8260_io/uart.c	Fri Sep 12 18:26:50 2003
+++ edited/arch/ppc/8260_io/uart.c	Mon Sep 22 11:53:59 2003
@@ -18,10 +18,6 @@
  * It still needs lots of work........When it was easy, I included code
  * to support the SCCs.
  * Only the SCCs support modem control, so that is not complete either.
- *
- * This module exports the following rs232 io functions:
- *
- *	int rs_8xx_init(void);
  */
 
 #include <linux/config.h>
@@ -2507,7 +2503,7 @@
 /*
  * The serial driver boot-time initialization code!
  */
-int __init rs_8xx_init(void)
+static int __init rs_8xx_init(void)
 {
 	struct serial_state * state;
 	ser_info_t	*info;
@@ -2867,6 +2863,7 @@
 	}
 	return 0;
 }
+module_init(rs_8xx_init);
 
 /* This must always be called before the rs_8xx_init() function, otherwise
  * it blows away the port control information.
--- 1.32/arch/ppc/8xx_io/uart.c	Fri Sep 12 18:26:50 2003
+++ edited/arch/ppc/8xx_io/uart.c	Mon Sep 22 11:53:59 2003
@@ -12,10 +12,6 @@
  * It still needs lots of work........When it was easy, I included code
  * to support the SCCs, but this has never been tested, nor is it complete.
  * Only the SCCs support modem control, so that is not complete either.
- *
- * This module exports the following rs232 io functions:
- *
- *	int rs_8xx_init(void);
  */
 
 #include <linux/config.h>
@@ -2499,7 +2495,7 @@
 /*
  * The serial driver boot-time initialization code!
  */
-int __init rs_8xx_init(void)
+static int __init rs_8xx_init(void)
 {
 	struct serial_state * state;
 	ser_info_t	*info;
@@ -2846,6 +2842,7 @@
 
 	return 0;
 }
+module_init(rs_8xx_init);
 
 /* This must always be called before the rs_8xx_init() function, otherwise
  * it blows away the port control information.
--- 1.59/drivers/char/Makefile	Sun Sep 21 23:50:34 2003
+++ edited/drivers/char/Makefile	Mon Sep 22 12:04:31 2003
@@ -9,38 +9,39 @@
 
 obj-y	 += mem.o random.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o
 
-obj-$(CONFIG_VT) += vt_ioctl.o vc_screen.o consolemap.o consolemap_deftbl.o selection.o keyboard.o
-obj-$(CONFIG_HW_CONSOLE) += vt.o defkeymap.o
-obj-$(CONFIG_MAGIC_SYSRQ) += sysrq.o
-obj-$(CONFIG_ATARI_DSP56K) += dsp56k.o
-obj-$(CONFIG_ROCKETPORT) += rocket.o
-obj-$(CONFIG_MOXA_SMARTIO) += mxser.o
-obj-$(CONFIG_MOXA_INTELLIO) += moxa.o
-obj-$(CONFIG_DIGI) += pcxx.o
-obj-$(CONFIG_DIGIEPCA) += epca.o
-obj-$(CONFIG_CYCLADES) += cyclades.o
-obj-$(CONFIG_STALLION) += stallion.o
-obj-$(CONFIG_ISTALLION) += istallion.o
-obj-$(CONFIG_COMPUTONE) += ip2.o ip2main.o
-obj-$(CONFIG_RISCOM8) += riscom8.o
-obj-$(CONFIG_ISI) += isicom.o
-obj-$(CONFIG_ESPSERIAL) += esp.o
-obj-$(CONFIG_SYNCLINK) += synclink.o
-obj-$(CONFIG_SYNCLINKMP) += synclinkmp.o
-obj-$(CONFIG_N_HDLC) += n_hdlc.o
-obj-$(CONFIG_SPECIALIX) += specialix.o
+obj-$(CONFIG_VT)		+= vt_ioctl.o vc_screen.o consolemap.o \
+				   consolemap_deftbl.o selection.o keyboard.o
+obj-$(CONFIG_HW_CONSOLE)	+= vt.o defkeymap.o
+obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
+obj-$(CONFIG_ESPSERIAL)		+= esp.o
+obj-$(CONFIG_MVME147_SCC)	+= generic_serial.o vme_scc.o
+obj-$(CONFIG_MVME162_SCC)	+= generic_serial.o vme_scc.o
+obj-$(CONFIG_BVME6000_SCC)	+= generic_serial.o vme_scc.o
+obj-$(CONFIG_SERIAL_TX3912)	+= generic_serial.o serial_tx3912.o
+obj-$(CONFIG_ROCKETPORT)	+= rocket.o
+obj-$(CONFIG_SERIAL167)		+= serial167.o
+obj-$(CONFIG_CYCLADES)		+= cyclades.o
+obj-$(CONFIG_STALLION)		+= stallion.o
+obj-$(CONFIG_ISTALLION)		+= istallion.o
+obj-$(CONFIG_DIGI)		+= pcxx.o
+obj-$(CONFIG_DIGIEPCA)		+= epca.o
+obj-$(CONFIG_SPECIALIX)		+= specialix.o
+obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
+obj-$(CONFIG_A2232)		+= ser_a2232.o generic_serial.o
+obj-$(CONFIG_ATARI_DSP56K)	+= dsp56k.o
+obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
+obj-$(CONFIG_COMPUTONE)		+= ip2.o ip2main.o
+obj-$(CONFIG_RISCOM8)		+= riscom8.o
+obj-$(CONFIG_ISI)		+= isicom.o
+obj-$(CONFIG_SYNCLINK)		+= synclink.o
+obj-$(CONFIG_SYNCLINKMP)	+= synclinkmp.o
+obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
 obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
-obj-$(CONFIG_A2232) += ser_a2232.o generic_serial.o
-obj-$(CONFIG_SX) += sx.o generic_serial.o
-obj-$(CONFIG_RIO) += rio/ generic_serial.o
-obj-$(CONFIG_SH_SCI) += sh-sci.o generic_serial.o
-obj-$(CONFIG_SERIAL167) += serial167.o
-obj-$(CONFIG_MVME147_SCC) += generic_serial.o vme_scc.o
-obj-$(CONFIG_MVME162_SCC) += generic_serial.o vme_scc.o
-obj-$(CONFIG_BVME6000_SCC) += generic_serial.o vme_scc.o
-obj-$(CONFIG_SERIAL_TX3912) += generic_serial.o serial_tx3912.o
-obj-$(CONFIG_HVC_CONSOLE) += hvc_console.o
-obj-$(CONFIG_RAW_DRIVER) += raw.o
+obj-$(CONFIG_SX)		+= sx.o generic_serial.o
+obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
+obj-$(CONFIG_SH_SCI)		+= sh-sci.o generic_serial.o
+obj-$(CONFIG_HVC_CONSOLE)	+= hvc_console.o
+obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 
 obj-$(CONFIG_PRINTER) += lp.o
 obj-$(CONFIG_TIPAR) += tipar.o
--- 1.29/drivers/char/cyclades.c	Mon Sep  1 01:14:39 2003
+++ edited/drivers/char/cyclades.c	Mon Sep 22 21:53:23 2003
@@ -5433,7 +5433,7 @@
     .read_proc = cyclades_get_proc_info,
 };
 
-int __init
+static int __init
 cy_init(void)
 {
   struct cyclades_port  *info;
@@ -5660,13 +5660,10 @@
     
 } /* cy_init */
 
-#ifdef MODULE
-void
+static void __exit
 cy_cleanup_module(void)
 {
-    int i;
-    int e1, e2;
-    unsigned long flags;
+    int i, e1;
 
 #ifndef CONFIG_CYZ_INTR
     if (cyz_timeron){
@@ -5702,11 +5699,10 @@
     }
 } /* cy_cleanup_module */
 
-/* Module entry-points */
 module_init(cy_init);
 module_exit(cy_cleanup_module);
 
-#else /* MODULE */
+#ifndef MODULE
 /* called by linux/init/main.c to parse command line options */
 void
 cy_setup(char *str, int *ints)
--- 1.7/drivers/char/ip2.c	Mon Jul 14 15:47:09 2003
+++ edited/drivers/char/ip2.c	Mon Sep 22 11:54:01 2003
@@ -34,8 +34,6 @@
 static int io[IP2_MAX_BOARDS]= { 0, 0, 0, 0 };
 static int irq[IP2_MAX_BOARDS] = { -1, -1, -1, -1 }; 
 
-#ifdef MODULE
-
 static int poll_only = 0;
 
 MODULE_AUTHOR("Doug McNash");
@@ -48,48 +46,20 @@
 MODULE_PARM_DESC(poll_only,"Do not use card interrupts");
 
 
-//======================================================================
-int
-init_module(void)
+static int __init ip2_init(void)
 {
-	int rc;
-
-	MOD_INC_USE_COUNT;	// hold till done 
-		
 	if( poll_only ) {
 		/* Hard lock the interrupts to zero */
 		irq[0] = irq[1] = irq[2] = irq[3] = 0;
 	}
 
-	rc = ip2_loadmain(io,irq,(unsigned char *)fip_firm,sizeof(fip_firm));
-	// The call to lock and load main, create dep 
-
-	MOD_DEC_USE_COUNT;	//done - kerneld now can unload us
-	return rc;
-}
-
-//======================================================================
-int
-ip2_init(void)
-{
-	// call to this is in tty_io.c so we need this
-	return 0;
-}
-
-//======================================================================
-void
-cleanup_module(void) 
-{
+	return ip2_loadmain(io,irq,(unsigned char *)fip_firm,sizeof(fip_firm));
 }
+module_init(ip2_init);
 
 MODULE_LICENSE("GPL");
 
-#else	// !MODULE 
-
-#ifndef NULL
-# define NULL		((void *) 0)
-#endif
-
+#ifndef MODULE
 /******************************************************************************
  *	ip2_setup:
  *		str: kernel command line string
@@ -136,15 +106,5 @@
 	}
 	return 1;
 }
-
-int
-ip2_init(void) {
-	return ip2_loadmain(io,irq,(unsigned char *)fip_firm,sizeof(fip_firm));
-}
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,13))
 __setup("ip2=", ip2_setup);
-__initcall(ip2_init);
-#endif
-
 #endif /* !MODULE */
--- 1.25/drivers/char/moxa.c	Tue Jun 24 03:43:58 2003
+++ edited/drivers/char/moxa.c	Mon Sep 22 21:55:08 2003
@@ -189,7 +189,6 @@
 
 static int verbose = 0;
 static int ttymajor = MOXAMAJOR;
-#ifdef MODULE
 /* Variables for insmod */
 static int baseaddr[] 	= 	{0, 0, 0, 0};
 static int type[]	=	{0, 0, 0, 0};
@@ -204,8 +203,6 @@
 MODULE_PARM(ttymajor, "i");
 MODULE_PARM(verbose, "i");
 
-#endif				//MODULE
-
 static struct tty_driver *moxaDriver;
 static struct moxa_str moxaChannels[MAX_PORTS];
 static unsigned char *moxaXmitBuff;
@@ -215,8 +212,6 @@
 static struct timer_list moxaEmptyTimer[MAX_PORTS];
 static struct semaphore moxaBuffSem;
 
-int moxa_init(void);
-
 /*
  * static functions:
  */
@@ -278,42 +273,6 @@
 static int moxa_set_serial_info(struct moxa_str *, struct serial_struct *);
 static void MoxaSetFifo(int port, int enable);
 
-#ifdef MODULE
-int init_module(void)
-{
-	int ret;
-
-	if (verbose)
-		printk("Loading module moxa ...\n");
-	ret = moxa_init();
-	if (verbose)
-		printk("Done\n");
-	return (ret);
-}
-
-void cleanup_module(void)
-{
-	int i;
-
-	if (verbose)
-		printk("Unloading module moxa ...\n");
-
-	if (moxaTimer_on)
-		del_timer(&moxaTimer);
-
-	for (i = 0; i < MAX_PORTS; i++)
-		if (moxaEmptyTimer_on[i])
-			del_timer(&moxaEmptyTimer[i]);
-
-	if (tty_unregister_driver(moxaDriver))
-		printk("Couldn't unregister MOXA Intellio family serial driver\n");
-	put_tty_driver(moxaDriver);
-	if (verbose)
-		printk("Done\n");
-
-}
-#endif
-
 static struct tty_operations moxa_ops = {
 	.open = moxa_open,
 	.close = moxa_close,
@@ -332,7 +291,7 @@
 	.hangup = moxa_hangup,
 };
 
-int moxa_init(void)
+static int __init moxa_init(void)
 {
 	int i, n, numBoards;
 	struct moxa_str *ch;
@@ -478,6 +437,31 @@
 
 	return (0);
 }
+
+static void __exit moxa_exit(void)
+{
+	int i;
+
+	if (verbose)
+		printk("Unloading module moxa ...\n");
+
+	if (moxaTimer_on)
+		del_timer(&moxaTimer);
+
+	for (i = 0; i < MAX_PORTS; i++)
+		if (moxaEmptyTimer_on[i])
+			del_timer(&moxaEmptyTimer[i]);
+
+	if (tty_unregister_driver(moxaDriver))
+		printk("Couldn't unregister MOXA Intellio family serial driver\n");
+	put_tty_driver(moxaDriver);
+	if (verbose)
+		printk("Done\n");
+
+}
+
+module_init(moxa_init);
+module_exit(moxa_exit);
 
 static int moxa_get_PCI_conf(struct pci_dev *p, int board_type, moxa_board_conf * board)
 {
--- 1.20/drivers/char/pcxx.c	Mon Sep  1 01:14:07 2003
+++ edited/drivers/char/pcxx.c	Mon Sep 22 11:54:01 2003
@@ -200,13 +200,7 @@
 	}
 }
 
-/*****************************************************************************/
-
-#ifdef MODULE
-
-/*****************************************************************************/
-
-static void pcxe_cleanup()
+static void __exit pcxe_cleanup(void)
 {
 
 	unsigned long	flags;
@@ -232,7 +226,6 @@
  */
 module_init(pcxe_init);
 module_cleanup(pcxe_cleanup);
-#endif
 
 static inline struct channel *chan(register struct tty_struct *tty)
 {
@@ -1018,6 +1011,9 @@
 }
 #endif
 
+module_init(pcxe_init)
+module_exit(pcxe_exit)
+
 static struct tty_operations pcxe_ops = {
 	.open = pcxe_open,
 	.close = pcxe_close,
@@ -1040,7 +1036,7 @@
  * function to initialize the driver with the given parameters, which are either
  * the default values from this file or the parameters given at boot.
  */
-int __init pcxe_init(void)
+static int __init pcxe_init(void)
 {
 	ulong memory_seg=0, memory_size=0;
 	int lowwater, enabled_cards=0, i, crd, shrinkmem=0, topwin = 0xff00L, botwin=0x100L;
--- 1.22/drivers/char/pty.c	Thu Sep  4 08:40:19 2003
+++ edited/drivers/char/pty.c	Mon Sep 22 11:54:01 2003
@@ -313,7 +313,7 @@
 	.set_termios = pty_set_termios,
 };
 
-int __init pty_init(void)
+static int __init pty_init(void)
 {
 	/* Traditional BSD devices */
 
@@ -414,3 +414,4 @@
 #endif
 	return 0;
 }
+module_init(pty_init);
--- 1.17/drivers/char/ser_a2232.c	Tue Sep  2 20:09:41 2003
+++ edited/drivers/char/ser_a2232.c	Mon Sep 22 11:54:01 2003
@@ -122,8 +122,6 @@
 /* Initialize and register TTY drivers. */
 /* returns 0 IFF successful */
 static int a2232_init_drivers(void); 
-/* Initialize all A2232 boards; main entry point. */
-int a2232board_init(void);
 
 /* BEGIN GENERIC_SERIAL PROTOTYPES */
 static void a2232_disable_tx_interrupts(void *ptr);
@@ -720,7 +718,7 @@
 	return 0;
 }
 
-int a2232board_init(void)
+static int __init a2232board_init(void)
 {
 	struct zorro_dev *z;
 
@@ -813,13 +811,7 @@
 	return 0;
 }
 
-#ifdef MODULE
-int init_module(void)
-{
-	return a2232board_init();
-}
-
-void cleanup_module(void)
+static void __exit a2232board_exit(void)
 {
 	int i;
 
@@ -831,8 +823,9 @@
 	put_tty_driver(a2232_driver);
 	free_irq(IRQ_AMIGA_VERTB, a2232_driver_ID);
 }
-#endif
-/***************************** End of Functions *********************/
+
+module_init(a2232board_init);
+module_exit(a2232board_exit);
 
 MODULE_AUTHOR("Enver Haase");
 MODULE_DESCRIPTION("Amiga A2232 multi-serial board driver");
===== drivers/char/serial167.c 1.29 vs edited =====
--- 1.29/drivers/char/serial167.c	Wed Jun 11 21:32:37 2003
+++ edited/drivers/char/serial167.c	Mon Sep 22 11:54:01 2003
@@ -23,10 +23,6 @@
  *
  * This version does not support shared irq's.
  *
- * This module exports the following rs232 io functions:
- *   int cy_init(void);
- *   int  cy_open(struct tty_struct *tty, struct file *filp);
- *
  * $Log: cyclades.c,v $
  * Revision 1.36.1.4  1995/03/29  06:14:14  bentson
  * disambiguate between Cyclom-16Y and Cyclom-32Ye;
@@ -2321,7 +2317,7 @@
     If there are more cards with more ports than have been statically
     allocated above, a warning is printed and the extra ports are ignored.
  */
-int
+static int __init
 serial167_init(void)
 {
   struct cyclades_port *info;
@@ -2496,6 +2492,8 @@
     put_tty_driver(cy_serial_driver);
     return ret;
 } /* serial167_init */
+
+module_init(serial167_init);
 
 
 #ifdef CYCLOM_SHOW_STATUS
===== drivers/char/serial_tx3912.c 1.18 vs edited =====
--- 1.18/drivers/char/serial_tx3912.c	Wed Jun 11 21:32:37 2003
+++ edited/drivers/char/serial_tx3912.c	Mon Sep 22 11:54:01 2003
@@ -812,7 +812,7 @@
 }
 
 
-void __init tx3912_rs_init(void)
+static void __init tx3912_rs_init(void)
 {
 	int rc;
 
@@ -877,6 +877,7 @@
 
 	func_exit();
 }
+module_init(tx3912_rs_init);
 
 /*
  * Begin serial console routines
===== drivers/char/specialix.c 1.25 vs edited =====
--- 1.25/drivers/char/specialix.c	Sun Sep 21 23:50:35 2003
+++ edited/drivers/char/specialix.c	Mon Sep 22 21:54:55 2003
@@ -1362,7 +1362,6 @@
 	int error;
 	struct specialix_port * port;
 	struct specialix_board * bp;
-	unsigned long flags;
 	
 	board = SX_BOARD(tty->index);
 
@@ -2205,7 +2204,7 @@
 /* 
  * This routine must be called by kernel at boot time 
  */
-int specialix_init(void) 
+static int __init specialix_init(void) 
 {
 	int i;
 	int found = 0;
@@ -2263,7 +2262,6 @@
 	return 0;
 }
 
-#ifdef MODULE
 int iobase[SX_NBOARD]  = {0,};
 
 int irq [SX_NBOARD] = {0,};
@@ -2280,7 +2278,7 @@
  * only use 4 different interrupts. 
  *
  */
-int init_module(void) 
+static int __init specialix_init_module(void) 
 {
 	int i;
 
@@ -2294,8 +2292,7 @@
 	return specialix_init();
 }
 	
-
-void cleanup_module(void)
+static void __exit specialix_exit_module(void)
 {
 	int i;
 	
@@ -2308,6 +2305,8 @@
 #endif
 	
 }
-#endif /* MODULE */
+
+module_init(specialix_init_module);
+module_exit(specialix_exit_module);
 
 MODULE_LICENSE("GPL");
--- 1.121/drivers/char/tty_io.c	Sun Sep 21 23:50:34 2003
+++ edited/drivers/char/tty_io.c	Mon Sep 22 12:12:40 2003
@@ -138,12 +138,7 @@
 int tty_ioctl(struct inode * inode, struct file * file,
 	      unsigned int cmd, unsigned long arg);
 static int tty_fasync(int fd, struct file * filp, int on);
-extern int vme_scc_init (void);
-extern int serial167_init(void);
-extern int rs_8xx_init(void);
-extern void tub3270_init(void);
 extern void rs_360_init(void);
-extern void tx3912_rs_init(void);
 
 static struct tty_struct *alloc_tty_struct(void)
 {
@@ -2464,53 +2459,6 @@
 	tty_add_class_device ("tty0", MKDEV(TTY_MAJOR, 0), NULL);
 
 	vty_init();
-#endif
-
-#ifdef CONFIG_ESPSERIAL  /* init ESP before rs, so rs doesn't see the port */
-	espserial_init();
-#endif
-#if defined(CONFIG_MVME162_SCC) || defined(CONFIG_BVME6000_SCC) || defined(CONFIG_MVME147_SCC)
-	vme_scc_init();
-#endif
-#ifdef CONFIG_SERIAL_TX3912
-	tx3912_rs_init();
-#endif
-#ifdef CONFIG_ROCKETPORT
-	rp_init();
-#endif
-#ifdef CONFIG_SERIAL167
-	serial167_init();
-#endif
-#ifdef CONFIG_CYCLADES
-	cy_init();
-#endif
-#ifdef CONFIG_STALLION
-	stl_init();
-#endif
-#ifdef CONFIG_ISTALLION
-	stli_init();
-#endif
-#ifdef CONFIG_DIGI
-	pcxe_init();
-#endif
-#ifdef CONFIG_DIGIEPCA
-	pc_init();
-#endif
-#ifdef CONFIG_SPECIALIX
-	specialix_init();
-#endif
-#if (defined(CONFIG_8xx) || defined(CONFIG_8260))
-	rs_8xx_init();
-#endif /* CONFIG_8xx */
-	pty_init();
-#ifdef CONFIG_MOXA_INTELLIO
-	moxa_init();
-#endif	
-#ifdef CONFIG_TN3270
-	tub3270_init();
-#endif
-#ifdef CONFIG_A2232
-	a2232board_init();
 #endif
 	return 0;
 }
--- 1.24/drivers/char/vme_scc.c	Wed Jun 11 21:32:38 2003
+++ edited/drivers/char/vme_scc.c	Mon Sep 22 11:54:01 2003
@@ -396,14 +396,10 @@
 #endif
 
 
-int vme_scc_init(void)
+static int vme_scc_init(void)
 {
 	int res = -ENODEV;
-	static int called = 0;
 
-	if (called)
-		return res;
-	called = 1;
 #ifdef CONFIG_MVME147_SCC
 	if (MACH_IS_MVME147)
 		res = mvme147_scc_init();
@@ -418,6 +414,8 @@
 #endif
 	return res;
 }
+
+module_init(vme_scc_init);
 
 
 /*---------------------------------------------------------------------------
--- 1.29/drivers/macintosh/macserial.c	Tue Jun 17 13:57:19 2003
+++ edited/drivers/macintosh/macserial.c	Mon Sep 22 11:54:01 2003
@@ -2490,8 +2490,7 @@
 	.read_proc = macserial_read_proc,
 };
 
-/* rs_init inits the driver */
-int macserial_init(void)
+static int macserial_init(void)
 {
 	int channel, i;
 	struct mac_serial *info;
--- 1.13/drivers/s390/char/tuball.c	Wed Jun 11 21:32:58 2003
+++ edited/drivers/s390/char/tuball.c	Mon Sep 22 11:54:01 2003
@@ -74,8 +74,6 @@
 	  0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
 	  0xf8, 0xf9, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f };
 
-int tub3270_init(void);
-
 #ifndef MODULE
 
 /*
@@ -193,31 +191,18 @@
 	return rc;
 }
 #endif /* CONFIG_TN3270_CONSOLE */
-#else /* If generated as a MODULE */
-/*
- * module init:  find tubes; get a major nbr
- */
-int
-init_module(void)
-{
-	if (tubnummins != 0) {
-		printk(KERN_ERR "EEEK!!  Tube driver cobbigling!!\n");
-		return -1;
-	}
-	return tub3270_init();
-}
+#endif
 
 /*
  * remove driver:  unregister the major number
  */
-void
-cleanup_module(void)
+static void __exit
+tub3270_exit(void)
 {
 	fs3270_fini();
 	tty3270_fini();
 	tubfiniminors();
 }
-#endif /* Not a MODULE or a MODULE */
 
 static int
 tub3270_is_ours(s390_dev_info_t *dp)
@@ -232,12 +217,19 @@
 /*
  * tub3270_init() called by kernel or module initialization
  */
-int
+static int __init
 tub3270_init(void)
 {
 	s390_dev_info_t d;
 	int i, rc;
 
+#ifdef MODULE
+	if (tubnummins != 0) {
+		printk(KERN_ERR "EEEK!!  Tube driver cobbigling!!\n");
+		return -1;
+	}
+#endif
+
 	/*
 	 * Copy and correct ebcdic - ascii translate tables
 	 */
@@ -624,3 +616,6 @@
 		tubirqs = NULL;
 	}
 }
+
+module_init(tub3270_init);
+module_exit(tub3270_exit);
--- 1.21/include/linux/tty.h	Sun Sep 21 23:50:34 2003
+++ edited/include/linux/tty.h	Mon Sep 22 11:57:53 2003
@@ -348,23 +348,7 @@
 extern int kmsg_redirect;
 
 extern void console_init(void);
-
-extern int lp_init(void);
-extern int pty_init(void);
-extern int mxser_init(void);
-extern int moxa_init(void);
-extern int ip2_init(void);
-extern int pcxe_init(void);
-extern int pc_init(void);
 extern int vcs_init(void);
-extern int rp_init(void);
-extern int cy_init(void);
-extern int stl_init(void);
-extern int stli_init(void);
-extern int specialix_init(void);
-extern int espserial_init(void);
-extern int macserial_init(void);
-extern int a2232board_init(void);
 
 extern int tty_paranoia_check(struct tty_struct *tty, struct inode *inode,
 			      const char *routine);
