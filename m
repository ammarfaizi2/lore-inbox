Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRCKUvV>; Sun, 11 Mar 2001 15:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129137AbRCKUvL>; Sun, 11 Mar 2001 15:51:11 -0500
Received: from NEUROSIS.MIT.EDU ([18.243.0.82]:14464 "EHLO neurosis.mit.edu")
	by vger.kernel.org with ESMTP id <S129134AbRCKUuy>;
	Sun, 11 Mar 2001 15:50:54 -0500
Date: Sun, 11 Mar 2001 15:50:02 -0500
From: Jim Paris <jim@jtan.com>
To: linux-kernel@vger.kernel.org
Subject: Digiboard EPCA driver for 2.4
Message-ID: <20010311155002.A2511@neurosis.mit.edu>
Reply-To: jim@jtan.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Digiboard EPCA driver supplied with Linux 2.4.x didn't work for
me, so I took the latest Digi driver and patched it to make it 
work with 2.4 and devfs.  I'm sure that I managed to horribly 
break some stuff, but hey, it works for me.  The patch to their 
latest (4001450M) driver is included below, or, get the updated
driver from:

http://neurosis.mit.edu/~jim/epca/

-jim



diff -Naur epca-1.4.5-1/dl/Makefile epca-1.4.5.1-jim/dl/Makefile
--- epca-1.4.5-1/dl/Makefile	Fri Mar 24 15:33:25 2000
+++ epca-1.4.5.1-jim/dl/Makefile	Sun Mar 11 14:16:33 2001
@@ -1,14 +1,15 @@
 
+all: digiDload cxconf epcxconf
+
 digiDload: digiDload.c
-	cc -g -O2 -Wall digiDload.c -o digiDload
+	cc $(CFLAGS) -Wall digiDload.c -o digiDload
 
 cxconf:	epcxconf.c
-	cc -g -O2 epcxconf.c -o cxconf
+	cc $(CFLAGS) epcxconf.c -o cxconf
 
 epcxconf: epcxconf.c
-	cc -g -O2 epcxconf.c -o epcxconf -DEPCXCONF
+	cc $(CFLAGS) epcxconf.c -o epcxconf -DEPCXCONF
 clean:
 	rm -f *~ *.o epcxconf cxconf digiDload
 
-all: digiDload cxconf epcxconf
 
diff -Naur epca-1.4.5-1/dl/digiDload.c epca-1.4.5.1-jim/dl/digiDload.c
--- epca-1.4.5-1/dl/digiDload.c	Mon Apr 24 11:16:57 2000
+++ epca-1.4.5.1-jim/dl/digiDload.c	Sun Mar 11 14:40:22 2001
@@ -196,7 +196,16 @@
 typedef unsigned char unchar;
 extern int iopl( int level );
 
+#ifndef __KERNEL__
+/* 2.4 needs __KERNEL__ defined for tqueue.h */
+#define __KERNEL__
+#include <linux/tqueue.h>
+#undef __KERNEL__
+#else
+#include <linux/tqueue.h>
+#endif
 
+#include <linux/config.h>
 #include <stdio.h>
 #include <fcntl.h>
 #include <errno.h>
@@ -220,7 +229,7 @@
 
 #include <asm/io.h>
 #include <termio.h>
-#include <linux/tqueue.h>
+
 #include <sys/ioctl.h>
 
 #include "../drv/digi1.h"
@@ -240,15 +249,15 @@
 
 /* This is used to calculate the path to digiDload, for temp_name */
 
-#define DIRPATH "/etc/digiepca/"
+#define DIRPATH "/etc/digi/"
 
 /* C/X concentrator download image */
-char *cxcon_fname = "/etc/digiepca/cxcon.bin";
-char *epcxcon_fname = "/etc/digiepca/fxcon.bin";
+char *cxcon_fname = "/etc/digi/cxcon.bin";
+char *epcxcon_fname = "/etc/digi/fxcon.bin";
 
 /* C/X concentrator configuration */
-#define CXCONFIG "/etc/digiepca/cxconf.dat"
-#define EPCXCONFIG "/etc/digiepca/epcxconf.dat"
+#define CXCONFIG "/etc/digi/cxconf.dat"
+#define EPCXCONFIG "/etc/digi/epcxconf.dat"
 
 /* CX Concentrator configuration strings can be a maximum of 21 bytes long */
 #define CXCFGLEN 21
@@ -1119,7 +1128,7 @@
 	target_addr = fm->addr ;
 	temp_name = (char *)malloc((size_t)((strlen(fm->fname)) + strlen(DIRPATH))); 
 	*temp_name = 0; /* Make first character null; so strcat can work */
-	strcat(temp_name,"/etc/digiepca/");
+	strcat(temp_name,"/etc/digi/");
 	strcat(temp_name,fm->fname);	
 	if (verbose) {
 		mess(0, 1, "Downloading %s to %lx on %s\n", temp_name, (long) fm->addr, btypes[di->info_bdtype].desc );
@@ -1953,6 +1962,10 @@
  * Given an channel number, return the corresponding device's pathname
  */
 char *chan_to_path( int channo ) {
+
+#ifdef CONFIG_DEVFS_FS
+	sprintf(dev_path,"/dev/digi/%d",channo);
+#else
 	char bankname;
 	int offset;
 
@@ -1960,7 +1973,7 @@
 	bankname = epca_banknames[ channo/NDEV_MAJOR ];
 	offset = channo % NDEV_MAJOR;
 	sprintf( dev_path, "%s%s%c%d", BASENAME, TTY_BASENAME, bankname, offset );
-
+#endif
 	return( dev_path );
 
 }
@@ -1972,6 +1985,10 @@
  * numbers.
  */
 void make_nodes( int first, int num, int make ) {
+
+#ifndef CONFIG_DEVFS_FS
+	/* Only do this if we're not using DEVFS. */
+
 	int major = 0, minor = 0;
 	int mode = 0666 | S_IFCHR;
 	int channo, ret;
@@ -2014,12 +2031,18 @@
 		}
 		
 	}
+#endif
+
 }
 
 /* update_devs
  * unlink old and mkdev current device links
  */
 void update_devs() {
+
+#ifndef CONFIG_DEVFS_FS
+	/* Only do this if we're not using DEVFS. */
+
 	int crd, make;
 	// digiConfig creates nodes for the first 256 ports, others created here
 	//if( port_count > NDEV_MAJOR )
@@ -2040,6 +2063,7 @@
 		make_nodes( board[crd].digi_info.firstchan,
 		board[crd].digi_info.info_nports, make );
 	}
+#endif
 }
 
 void doargs( int ac, char *av[] ) {
@@ -2075,9 +2099,16 @@
 
 	doargs( argc, argv );
 
+
+#ifdef CONFIG_DEVFS_FS
+	if ((digiFD = open("/dev/digi/ctl", O_RDWR)) < 0 ) {
+		perror(" cannot open digi download device ");
+	}
+#else
 	if ((digiFD = open("/dev/digiCtl", O_RDWR)) < 0 ) {
 		perror(" cannot open digi download device ");
 	}
+#endif
 
 	if( init(digiFD) )
 		return( 1 );
diff -Naur epca-1.4.5-1/drv/Makefile epca-1.4.5.1-jim/drv/Makefile
--- epca-1.4.5-1/drv/Makefile	Wed Jun 28 15:10:15 2000
+++ epca-1.4.5.1-jim/drv/Makefile	Sun Mar 11 14:17:09 2001
@@ -1,5 +1,5 @@
 
-CFLAGS = -O2 -D__KERNEL__ -DMODULE -DLINUX -DKERNEL2_0 -Wall -I/usr/src/linux/include
+CFLAGS += -D__KERNEL__ -DMODULE -DLINUX -Wall -I/usr/src/linux/include
 LDFLAGS = -s -N 
 CC=cc
 
diff -Naur epca-1.4.5-1/drv/epca.c epca-1.4.5.1-jim/drv/epca.c
--- epca-1.4.5-1/drv/epca.c	Wed Jun 28 16:01:43 2000
+++ epca-1.4.5.1-jim/drv/epca.c	Sun Mar 11 14:57:16 2001
@@ -461,6 +461,9 @@
 	   were using it wrong in a few instances, and it was causing 
 	   problems in newer redhat versions.
 	-- Changed version number to 1.4.5-1
+March 11, 2001: jim@jtan.com
+	-- Support for 2.4 and devfs added by Jim Paris <jim@jtan.com>.
+	-- Changed version number to 1.4.5.1-jim
 -------------------------------------------------------------------------- */
 
 #ifdef MODULE
@@ -580,7 +583,7 @@
 #include "epcaconfig.h"
 /* ---------------------- Begin defines ------------------------ */
 
-#define VERSION            "1.4.5-1"
+#define VERSION            "1.4.5.1-jim"
 
 
 
@@ -624,7 +627,11 @@
 
 #ifdef KERNEL2_x
 static int pc_timeron = 0;
+#if LINUX_VERSION_CODE > 0x020400 
+static struct timer_list pc_timer = { {NULL, NULL}, 0, 0, 0};
+#else
 static struct timer_list pc_timer = {NULL, NULL, 0, 0, 0};
+#endif
 #endif /* KERNEL2_x */
 
 
@@ -803,7 +810,9 @@
 #ifdef KERNEL2_x
 static int get_termio(struct tty_struct *, struct termio *);
 static int pc_write(struct tty_struct *, int, const unsigned char *, int);
+#if LINUX_VERSION_CODE < 0x020400
 static void do_pc_bh(void);
+#endif
 int pc_init(void);
 #else
 static int pc_write(struct tty_struct *, int, unsigned char *, int);
@@ -842,8 +851,13 @@
 #ifdef KERNEL2_x
 #include <linux/proc_fs.h>
 
+#if LINUX_VERSION_CODE < 0x020400
 int
 epca_read_proc( char *buf, char **start, off_t offset, int len, int unused ){
+#else
+int epca_read_proc( char *buf, char **start, off_t offset, int len ){
+#endif
+
 	int crd;
 	
 	len=sprintf( buf, "\nEPCA Linux Driver Version %s\n",VERSION);
@@ -882,6 +896,7 @@
 	return len;
 }
 
+#if LINUX_VERSION_CODE < 0x020400
 struct proc_dir_entry epca_proc_entry = {
 	0,					/* low_ino: The inode -- dynamic */
 	4, "epca",			/* len of name and name */
@@ -891,6 +906,7 @@
 	NULL,				/* operations -- use default */
 	&epca_read_proc,	/* function used to read data */
 };
+#endif
 
 #endif /* KERNEL2_x */
 #endif /* CONFIG_PROC_FS */
@@ -1144,6 +1160,9 @@
 	-------------------------------------------------------------------------*/
 
 	ch->event |= 1 << event;
+
+#if LINUX_VERSION_CODE < 0x020400
+
 #if (LINUX_VERSION_CODE >= 0x020100)
 	queue_task(&ch->tqueue, &tq_epca);
 #else
@@ -1155,6 +1174,11 @@
 		can see.
 	-------------------------------------------------------------------*/
 	mark_bh(DIGI_BH);
+#else /* kernel 2.4 */
+	MOD_INC_USE_COUNT;
+	if(schedule_task(&ch->tqueue)==0) 
+	  MOD_DEC_USE_COUNT;
+#endif
 
 } /* End pc_sched_event */
 
@@ -1413,7 +1437,9 @@
 	---------------------------------------------------------------------- */
 
 	/* Prevent future Digi programmed interrupts from coming active */
+#if LINUX_VERSION_CODE < 0x020400
 	disable_bh(DIGI_BH);
+#endif
 
 	ch->asyncflags &= ~ASYNC_INITIALIZED;
 	restore_flags(flags);
@@ -2428,8 +2454,12 @@
 				} 
 
 				if( ch->tmp_buf ) {
+#if LINUX_VERSION_CODE < 0x020400
 					kfree_s(ch->tmp_buf, ch->txbufsize);
 					ch->tmp_buf = NULL;
+#else
+					kfree(ch->tmp_buf);
+#endif			      
 				}
 
 			}
@@ -2450,6 +2480,7 @@
 		}
 	}
 
+#if LINUX_VERSION_CODE < 0x020400
 	if (tty_unregister_driver(&pc_callout) ) {
 		epca_mess(KERN_WARNING, "cleanup_module failed to un-register pc_callout driver\n");
 	} else {
@@ -2460,6 +2491,7 @@
 		if( pc_callout.table )
 			vfree( pc_callout.table );
 	}
+#endif
 	if (tty_unregister_driver(&pc_info) )
 		epca_mess(KERN_WARNING, "cleanup_module failed to un-register pc_info driver\n");
 
@@ -2484,7 +2516,11 @@
 
 
 #ifdef CONFIG_PROC_FS
+#if LINUX_VERSION_CODE < 0x020400
 	proc_unregister( &proc_root, epca_proc_entry.low_ino);
+#else
+	remove_proc_entry("epca",NULL);
+#endif
 #endif /* CONFIG_PROC_FS */
 
 	// Free up the array of tty_driver arrays
@@ -2569,7 +2605,10 @@
 		memory.
 	------------------------------------------------------------------*/
 
-	ulong flags, save_loops_per_sec; 
+	ulong flags;
+#if LINUX_VERSION_CODE < 0x020400
+	ulong save_loops_per_sec;
+#endif 
 	int crd, bank;
 	struct board_info *bd;
 	unsigned char board_id = 0;
@@ -2754,8 +2793,12 @@
 	
 	memset(&lpc_driver, 0, sizeof(struct tty_driver));
 	lpc_driver.magic = TTY_DRIVER_MAGIC;
+#ifdef CONFIG_DEVFS_FS
+	lpc_driver.name="digi/%d";
+#else
 // Need to malloc memory for driver.name when used
 //lpc_driver.name =TTY_NAME;
+#endif
 	lpc_driver.major = DIGI_MAJOR; 
 //pc_driver.major = 0;
 	lpc_driver.minor_start = 0;
@@ -2797,6 +2840,9 @@
 	lpc_driver.unthrottle = pc_unthrottle;
 	lpc_driver.hangup = pc_hangup;
 
+#if LINUX_VERSION_CODE < 0x020400
+	/* Callout device is deprecated. */
+
 	pc_callout = lpc_driver;
 
 	pc_callout.name = "cud";
@@ -2805,9 +2851,14 @@
 	pc_callout.minor_start = 0;
 	pc_callout.init_termios.c_cflag = B9600 | CS8 | CREAD | CLOCAL | HUPCL;
 	pc_callout.subtype = SERIAL_TYPE_CALLOUT;
+#endif
 
 	pc_info = lpc_driver;
+#ifdef CONFIG_DEVFS_FS
+	pc_info.name = "digi/ctl";
+#else
 	pc_info.name = "digiCtl";
+#endif
 	pc_info.major = DIGIINFOMAJOR;
 	pc_info.minor_start = 0;
 	pc_info.init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL;
@@ -2818,6 +2869,18 @@
 	pc_info.num = 1;
 
 	for( bank=0; bank<n_banks; ++bank ) {
+#ifdef CONFIG_DEVFS_FS
+	  /* I have no use for this, so I didn't bother doing it. */
+	  /* I think the way it should work would be to allocate  */
+	  /* names like "/dev/digi/0/0", "/dev/digi/0/1",         */
+	  /* "/dev/digi/1/0", etc, where the first number is the  */
+          /* bank and the second is the device.  The bank number  */
+          /* would be omitted if there was only one.              */
+	  if(bank>0) {
+	    epca_mess(KERN_ERR,"Multiple banks with devfs unsupported\n");
+	    break;
+	  }
+#endif
 		if( bank >= (sizeof(TTY_BANKNAMES)-1) ) {
 			epca_mess( KERN_ERR,
 			"No more bank names available.  Ignoring banks >= %d\n", bank );
@@ -2842,6 +2905,7 @@
 		
 		// Allocate and initialize the driver name to include the
 		// current bank designator, e.g: first ttyD, then ttyE, then ttyF...
+#ifndef CONFIG_DEVFS_FS
 		if( !(pc_driver[bank]->name =
 		kmalloc(sizeof(TTY_NAME), GFP_ATOMIC)) ) {
 			epca_mess(KERN_ERR, "Couldn't malloc name space, bank:%d", bank);
@@ -2852,6 +2916,7 @@
 		strcpy( (char *)pc_driver[bank]->name, TTY_NAME );
 		*(((char *)pc_driver[bank]->name) + strlen(pc_driver[bank]->name)-1)
 		= epca_banknames[bank]; 
+#endif
 
 		// The first bank's major number is defined in <major.h>;
 		// subsequent banks' major numbers are allocated dynamically
@@ -2899,6 +2964,8 @@
 
 	}
 
+#if LINUX_VERSION_CODE < 0x020400
+	/* callout is deprecated, kill it already */
 
 	// Only bank 0 (up to first 256 units) have corresponding "cu" devices.
 	pc_callout.num = pc_driver[0]->num;
@@ -2931,6 +2998,8 @@
 		ret = -EPERM;
 		goto fail6;
 	}
+#endif /* LINUX_VERSION_CODE < 0x020400 */
+
 	if (tty_register_driver(&pc_info) < 0 ) {
 		epca_mess( KERN_ERR, "Couldn't register info device");
 		ret = -EPERM;
@@ -2941,8 +3010,10 @@
 	   loops_per_sec hasn't been set at this point :-(, so fake it out... 
 	   I set it, so that I can use the __delay() function.
 	------------------------------------------------------------------------ */
+#if LINUX_VERSION_CODE < 0x020400
 	save_loops_per_sec = loops_per_sec;
 	loops_per_sec = 13L * 500000L;
+#endif
 /*----------*/
 
 	save_flags(flags);
@@ -3125,9 +3196,10 @@
 
 	} /* End for each card */
 	restore_flags(flags);
+#if LINUX_VERSION_CODE < 0x020400
 	loops_per_sec = save_loops_per_sec;  /* reset it to what it should be */
-
 	init_bh(DIGI_BH, do_pc_bh);
+#endif
 	/* -------------------------------------------------------------------
 	   Start up the poller to check for events on all enabled boards
 	---------------------------------------------------------------------- */
@@ -3146,19 +3218,28 @@
 	/* -------------------------------------------------------------------
 	   Register /proc/epca
 	---------------------------------------------------------------------- */
+#if LINUX_VERSION_CODE < 0x020400
 #if LINUX_VERSION_CODE < 0x020200
+	/* up to 2.2 */
 	proc_register_dynamic( &proc_root, &epca_proc_entry);
-#else
+#else 
+	/* 2.2 only */
 	// proc_register() has dynamic allocation code built-in in 2.2 kernels
 	proc_register( &proc_root, &epca_proc_entry);
 #endif
+#else
+	/* 2.4+ */
+	if(!create_proc_info_entry("epca",0,NULL,epca_read_proc)) {
+	  printk(KERN_ERR "epca: register /proc/epca failed\n");
+	}
+#endif
 #endif /* CONFIG_PROC_FS */
 
 	/* Initialize KME waitqueues...CWS */
 	/* Only 2.2.x compat for now..gonna do 2.3.x in a bit.. */
 
 	for(itmp=0;itmp<num_cards;itmp++)	
-		boards[itmp].kme_wait = 0;
+	  memset(&boards[itmp].kme_wait,0,sizeof(boards[itmp].kme_wait));
 	
 return(0);
 
@@ -3168,12 +3249,15 @@
 // intentionally falls through to the code for earlier ones.
 // ("goto" has its uses!)
 fail7:
+#if LINUX_VERSION_CODE < 0x020400
 	if( tty_unregister_driver(&pc_callout) ) {
 		epca_mess( KERN_ERR,
 		"pc_init: Cannot unregister callout device\n" );
 	}
 fail6:
+#endif
 	bank = n_banks;	// This will be decremented at fail5
+#if LINUX_VERSION_CODE < 0x020400
 	if( pc_callout.termios_locked )
 		vfree( pc_callout.termios_locked );
 fail5B:
@@ -3182,6 +3266,7 @@
 fail5A:
 	if( pc_callout.termios )
 		vfree( pc_callout.termios );
+#endif
 fail5:
 	while( --bank >= 0 ) {
 		if( tty_unregister_driver(pc_driver[bank]) ) {
@@ -5811,6 +5896,8 @@
 
 /* --------------------- Begin do_pc_bh  ----------------------- */
 
+#if LINUX_VERSION_CODE < 0x020400
+
 #ifdef KERNEL2_x
 static void do_pc_bh(void)
 #else
@@ -5821,6 +5908,8 @@
 	run_task_queue(&tq_epca);
 
 } /* End do_pc_bh */
+
+#endif
 
 /* --------------------- Begin do_softint  ----------------------- */
 
diff -Naur epca-1.4.5-1/drv/epca.h epca-1.4.5.1-jim/drv/epca.h
--- epca-1.4.5-1/drv/epca.h	Fri Mar 24 14:44:18 2000
+++ epca-1.4.5.1-jim/drv/epca.h	Sun Mar 11 14:38:44 2001
@@ -282,8 +282,11 @@
  * (e.g: the 'D' in /dev/ttyD").  Since some letters are already reserved
  * (e.g: "ttyS*" is reserved for the internal serial ports), the available
  * letters are listed in order in TTY_BANKNAMES */
-#define TTY_BASENAME "tty"
+#ifdef CONFIG_DEVFS_FS
+#define TTY_NAME "digi/%d"
+#else
 #define TTY_NAME "ttyD"
+#endif
 /* Skip 'S' -- ttyS* reserved for built-in comm ports */
+#define TTY_BASENAME "tty"
 #define TTY_BANKNAMES "DEFGHIJKLMNOPQRTUVWXYZ"
-
