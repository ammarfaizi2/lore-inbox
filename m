Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbTFMTja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265503AbTFMTja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:39:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:65200 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265500AbTFMTjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:39:07 -0400
Date: Fri, 13 Jun 2003 12:52:39 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Rocketport changes for 2.5.70-bk
Message-ID: <20030613195239.GB1260@kroah.com>
References: <20030613195214.GA1260@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613195214.GA1260@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1308, 2003/06/13 12:36:16-07:00, Kurt.Robideau@comtrol.com

[PATCH] Rocket patch against 2.5.70-bk18

Here is rocket driver patch against 2.5.70-bk18.  Changes are:

-  Removed non-GPL license text from headers
-  Removed check_region()/request_region() raciness
-  Made the driver a >2.5 driver only (as you had suggested)


 drivers/char/rocket.c     |  287 +++++-----------------------------------------
 drivers/char/rocket.h     |   24 ---
 drivers/char/rocket_int.h |   46 -------
 drivers/pci/pci.ids       |    2 
 include/linux/pci_ids.h   |    2 
 5 files changed, 44 insertions(+), 317 deletions(-)


diff -Nru a/drivers/char/rocket.c b/drivers/char/rocket.c
--- a/drivers/char/rocket.c	Fri Jun 13 12:49:06 2003
+++ b/drivers/char/rocket.c	Fri Jun 13 12:49:06 2003
@@ -40,23 +40,12 @@
  */
 
 /****** Defines ******/
-#include <linux/config.h>
-#include <linux/version.h>
-
 #ifdef PCI_NUM_RESOURCES
 #define PCI_BASE_ADDRESS(dev, r) ((dev)->resource[r].start)
 #else
 #define PCI_BASE_ADDRESS(dev, r) ((dev)->base_address[r])
 #endif
 
-#ifndef VERSION_CODE
-#  define VERSION_CODE(vers,rel,seq) ( ((vers)<<16) | ((rel)<<8) | (seq) )
-#endif
-
-#if LINUX_VERSION_CODE < VERSION_CODE(2,2,9)	/*  No version < 2.2 */
-#  error "This kernel is too old: not supported by this file"
-#endif
-
 #define ROCKET_PARANOIA_CHECK
 #define ROCKET_DISABLE_SIMUSAGE
 
@@ -72,45 +61,12 @@
 #undef REV_PCI_ORDER
 #undef ROCKET_DEBUG_IO
 
-/*   CAUTION!!!!!  The TIME_STAT Function relies on the Pentium 64 bit
- *    register.  For various reasons related to 1.2.13, the test for this
- *    register is omitted from this driver.  If you are going to enable
- *    this option, make sure you are running a Pentium CPU and that a
- *    cat of /proc/cpuinfo shows ability TS Counters as Yes.  Warning part
- *    done, don't cry to me if you enable this options and things won't
- *    work.  If it gives you any problems, then disable the option.  The code
- *    in this function is pretty straight forward, if it breaks on your
- *    CPU, there is probably something funny about your CPU.
- */
-
-#undef TIME_STAT		/* For performing timing statistics on driver. */
-			/* Produces printks, one every TIME_COUNTER loops, eats */
-			/* some of your CPU time.  Good for testing or */
-			/* other checking, otherwise, leave it undefed */
-			/* Doug Ledford */
-#define TIME_STAT_CPU 100	/* This needs to be set to your processor speed */
-			       /* For example, 100Mhz CPU, set this to 100 */
-#define TIME_COUNTER 180000	/* This is how many iterations to run before */
-			      /* performing the printk statements.   */
-			      /* 6000 = 1 minute, 360000 = 1 hour, etc. */
-			      /* Since time_stat is long long, this */
-			      /* Can be really high if you want :)  */
-#undef TIME_STAT_VERBOSE	/* Undef this if you want a terse log message. */
-
-#if LINUX_VERSION_CODE < VERSION_CODE(2,4,0)
-#define TTY_DRIVER_NO_DEVFS 0
-#endif
-
 #define POLL_PERIOD HZ/100	/*  Polling period .01 seconds (10ms) */
 
 /****** Kernel includes ******/
 
 #ifdef MODVERSIONS
-#if LINUX_VERSION_CODE < VERSION_CODE(2,5,00)
-#include <linux/modversions.h>
-#else
 #include <config/modversions.h>
-#endif
 #endif				
 
 #include <linux/module.h>
@@ -118,13 +74,7 @@
 #include <linux/major.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
-
-#if LINUX_VERSION_CODE < VERSION_CODE(2,4,0)
-#include <linux/malloc.h>
-#else
 #include <linux/slab.h>
-#endif
-
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
@@ -153,20 +103,8 @@
 #include "rocket_int.h"
 #include "rocket.h"
 
-#ifdef LOCAL_ROCKET_H
-#include "version.h"
-#else
-#define ROCKET_VERSION "2.08"
-#define ROCKET_DATE "02-June-2003"
-#endif				/* LOCAL_ROCKET_H */
-
-/*
- * All of the compatibilty code so we can compile serial.c against
- * older kernels is hidden in rocket_compat.h
- */
-#if defined(LOCAL_ROCKET_H) || (LINUX_VERSION_CODE < VERSION_CODE(2,3,23))
-#include "rocket_compat.h"
-#endif
+#define ROCKET_VERSION "2.09"
+#define ROCKET_DATE "12-June-2003"
 
 /****** RocketPort Local Variables ******/
 
@@ -205,13 +143,6 @@
 static rocketModel_t rocketModel[NUM_BOARDS];
 static int max_board;
 
-#ifdef TIME_STAT
-static unsigned long long time_stat;
-static unsigned long time_stat_short;
-static unsigned long time_stat_long;
-static unsigned long time_counter;
-#endif
-
 /*
  * The following arrays define the interrupt bits corresponding to each AIOP.
  * These bits are different between the ISA and regular PCI boards and the
@@ -241,7 +172,7 @@
 static unsigned long nextLineNumber;
 
 /*****  RocketPort Static Prototypes   *********/
-static int __init init_ISA(int i, int *reserved_controller);
+static int __init init_ISA(int i);
 static void rp_wait_until_sent(struct tty_struct *tty, int timeout);
 static void rp_flush_buffer(struct tty_struct *tty);
 static void rmSpeakerReset(CONTROLLER_T * CtlP, unsigned long model);
@@ -564,16 +495,6 @@
 	unsigned char AiopMask;
 	Word_t bit;
 
-#ifdef TIME_STAT
-	unsigned long low = 0, high = 0, loop_time;
-	unsigned long long time_stat_tmp = 0, time_stat_tmp2 = 0;
-
-      __asm__(".byte 0x0f,0x31":"=a"(low), "=d"(high));
-	time_stat_tmp = high;
-	time_stat_tmp <<= 32;
-	time_stat_tmp += low;
-#endif				/* TIME_STAT */
-
 	/*  Walk through all the boards (ctrl's) */
 	for (ctrl = 0; ctrl < max_board; ctrl++) {
 		if (rcktpt_io_addr[ctrl] <= 0)
@@ -635,48 +556,6 @@
 	 */
 	if (atomic_read(&rp_num_ports_open))
 		mod_timer(&rocket_timer, jiffies + POLL_PERIOD);
-
-#ifdef TIME_STAT
-      __asm__(".byte 0x0f,0x31":"=a"(low), "=d"(high));
-	time_stat_tmp2 = high;
-	time_stat_tmp2 <<= 32;
-	time_stat_tmp2 += low;
-	time_stat_tmp2 -= time_stat_tmp;
-	time_stat += time_stat_tmp2;
-	if (time_counter == 0)
-		time_stat_short = time_stat_long = time_stat_tmp2;
-	else {
-		if (time_stat_tmp2 < time_stat_short)
-			time_stat_short = time_stat_tmp2;
-		else if (time_stat_tmp2 > time_stat_long)
-			time_stat_long = time_stat_tmp2;
-	}
-	if (++time_counter == TIME_COUNTER) {
-		loop_time =
-		    (unsigned
-		     long) (((unsigned long) (time_stat >> 32) *
-			     ((unsigned long) (0xffffffff) /
-			      (TIME_STAT_CPU * TIME_COUNTER))) +
-			    ((unsigned long) time_stat /
-			     (TIME_STAT_CPU * TIME_COUNTER)));
-#ifdef TIME_STAT_VERBOSE
-		printk(KERN_INFO "rp_do_poll: Interrupt Timings\n");
-		printk(KERN_INFO "     %5ld iterations; %ld us min,\n",
-		       (long) TIME_COUNTER,
-		       (time_stat_short / TIME_STAT_CPU));
-		printk(KERN_INFO "     %5ld us max, %ld us average per iteration.\n",
-		       (time_stat_long / TIME_STAT_CPU), loop_time);
-		printk(KERN_INFO "We want to use < 5,000 us for an iteration.\n");
-#else				/* TIME_STAT_VERBOSE */
-		printk(KERN_INFO "rp: %ld loops: %ld min, %ld max, %ld us/loop.\n",
-		       (long) TIME_COUNTER,
-		       (time_stat_short / TIME_STAT_CPU),
-		       (time_stat_long / TIME_STAT_CPU), loop_time);
-#endif				/* TIME_STAT_VERBOSE */
-		time_counter = time_stat = 0;
-		time_stat_short = time_stat_long = 0;
-	}
-#endif				/* TIME_STAT */
 }
 
 /*
@@ -762,10 +641,8 @@
 	spin_lock_init(&info->slock);
 	sema_init(&info->write_sem, 1);
 	rp_table[line] = info;
-#if LINUX_VERSION_CODE > VERSION_CODE(2,5,0)
 	if (pci_dev)
 		tty_register_device(rocket_driver, line, &pci_dev->dev);
-#endif
 }
 
 /*
@@ -1039,12 +916,7 @@
 	CHANNEL_t *cp;
 	unsigned long page;
 
-#if LINUX_VERSION_CODE > VERSION_CODE(2,5,0)
 	line = TTY_GET_LINE(tty);
-#else
-	line = MINOR(tty->device) - TTY_DRIVER_MINOR_START(tty);
-#endif
-
 	if ((line < 0) || (line >= MAX_RP_PORTS) || ((info = rp_table[line]) == NULL))
 		return -ENXIO;
 
@@ -1070,9 +942,6 @@
 	info->tty = tty;
 
 	if (info->count++ == 0) {
-#if ((LINUX_VERSION_CODE < VERSION_CODE(2,5,0)) && defined(MODULE))
-		MOD_INC_USE_COUNT;
-#endif
 		atomic_inc(&rp_num_ports_open);
 
 #ifdef ROCKET_DEBUG_OPEN
@@ -1254,10 +1123,6 @@
 	info->flags &= ~(ROCKET_INITIALIZED | ROCKET_CLOSING | ROCKET_NORMAL_ACTIVE);
 	tty->closing = 0;
 	wake_up_interruptible(&info->close_wait);
-
-#if ((LINUX_VERSION_CODE < VERSION_CODE(2,5,0)) && defined(MODULE))
-	MOD_DEC_USE_COUNT;
-#endif
 	atomic_dec(&rp_num_ports_open);
 
 #ifdef ROCKET_DEBUG_OPEN
@@ -1406,8 +1271,6 @@
 	return 0;
 }
 
-#if LINUX_VERSION_CODE > VERSION_CODE(2,5,0)
-
 /*
  *  Returns the state of the serial modem control lines.  These next 2 functions 
  *  are the way kernel versions > 2.5 handle modem control lines rather than IOCTLs.
@@ -1450,8 +1313,6 @@
 	return 0;
 }
 
-#endif /*  Linux > 2.5 */
-
 static int get_config(struct r_port *info, struct rocket_config *retinfo)
 {
 	struct rocket_config tmp;
@@ -1781,12 +1642,8 @@
 	rp_flush_buffer(tty);
 	if (info->flags & ROCKET_CLOSING)
 		return;
-	if (info->count) {
-#if ((LINUX_VERSION_CODE < VERSION_CODE(2,5,0)) && defined(MODULE))
-		MOD_DEC_USE_COUNT;
-#endif
+	if (info->count) 
 		atomic_dec(&rp_num_ports_open);
-	}
 	clear_bit((info->aiop * 8) + info->chan, (void *) &xmit_flags[info->board]);
 
 	info->count = 0;
@@ -2344,17 +2201,9 @@
 	for (aiop = 0; aiop < max_num_aiops; aiop++)
 		ctlp->AiopNumChan[aiop] = ports_per_aiop;
 
-#if LINUX_VERSION_CODE < VERSION_CODE(2,3,99)
-	printk(KERN_INFO "Comtrol PCI controller #%d ID 0x%x found at 0x%lx, "
-	       "%d AIOP(s) (%s)\n", i, dev->device, rcktpt_io_addr[i],
-	       num_aiops, rocketModel[i].modelString);
-#else
-	printk
-	    ("Comtrol PCI controller #%d ID 0x%x found in bus:slot:fn %s at address %04lx, "
+	printk("Comtrol PCI controller #%d ID 0x%x found in bus:slot:fn %s at address %04lx, "
 	     "%d AIOP(s) (%s)\n", i, dev->device, dev->slot_name,
 	     rcktpt_io_addr[i], num_aiops, rocketModel[i].modelString);
-#endif
-
 	printk(KERN_INFO "Installing %s, creating /dev/ttyR%d - %ld\n",
 	       rocketModel[i].modelString,
 	       rocketModel[i].startingPortNumber,
@@ -2391,9 +2240,6 @@
 	return (1);
 }
 
-#if LINUX_VERSION_CODE > VERSION_CODE(2,3,99)	/*  Linux version 2.4 and greater */
-
-
 /*
  *  Probes for PCI cards, inits them if found
  *  Input:   board_found = number of ISA boards already found, or the
@@ -2413,51 +2259,6 @@
 	return (count);
 }
 
-#else				/*  Linux version 2.2 */
-
-/*
- *  Linux 2.2 pci_find_device() does not allow a search of all devices for a certain vendor,
- *  you have to try each device ID.  Comtrol device ID's are 0x0000 -0x000F for the original
- *  boards.  Newer board are 0x08xx (see upci_ids[]).
- */
-static int __init init_PCI(int boards_found)
-{
-	int j, count = 0;
-	struct pci_dev *dev = NULL;
-
-	static int upci_ids[] = {
-		PCI_DEVICE_ID_URP32INTF,
-		PCI_DEVICE_ID_URP8INTF,
-		PCI_DEVICE_ID_URP16INTF,
-		PCI_DEVICE_ID_CRP16INTF,
-		PCI_DEVICE_ID_URP8OCTA,
-		PCI_DEVICE_ID_UPCI_RM3_8PORT,
-		PCI_DEVICE_ID_UPCI_RM3_4PORT
-	};
-
-#define NUM_UPCI_IDS	(sizeof(upci_ids) / sizeof(upci_ids[0]))
-
-	/*  Try finding devices with PCI ID's 0x0000 - 0x000F */
-	for (j = 0; j < 16; j++) {
-		while ((dev = pci_find_device(PCI_VENDOR_ID_RP, j, dev))) {
-			register_PCI(count + boards_found, dev);
-			count++;
-		}
-	}
-
-	/*  Now try finding the UPCI devices,  which have PCI ID's 0x0800 - 0x080F */
-	for (j = 0; j < NUM_UPCI_IDS; j++) {
-		while ((dev =
-			pci_find_device(PCI_VENDOR_ID_RP, upci_ids[j], dev))) {
-			register_PCI(count + boards_found, dev);
-			count++;
-		}
-	}
-	return (count);
-}
-
-#endif				/*  Linux version 2.2/2.4 */
-
 #endif				/* CONFIG_PCI */
 
 /*
@@ -2465,7 +2266,7 @@
  *  Input:   i = the board number to look for
  *  Returns: 1 if board found, 0 else
  */
-static int __init init_ISA(int i, int *reserved_controller)
+static int __init init_ISA(int i)
 {
 	int num_aiops, num_chan = 0, total_num_chan = 0;
 	int aiop, chan;
@@ -2473,20 +2274,16 @@
 	CONTROLLER_t *ctlp;
 	char *type_string;
 
-	if (rcktpt_io_addr[i] == 0 || controller == 0)
+	/*  If io_addr is zero, no board configured */
+	if (rcktpt_io_addr[i] == 0)
 		return (0);
 
-	if (check_region(rcktpt_io_addr[i], 64)) {
-		printk(KERN_INFO "RocketPort board address 0x%lx in use...\n", rcktpt_io_addr[i]);
+	/*  Reserve the IO region */
+	if (!request_region(rcktpt_io_addr[i], 64, "Comtrol RocketPort")) {
+		printk(KERN_INFO "Unable to reserve IO region for configured ISA RocketPort at address 0x%lx, board not installed...\n", rcktpt_io_addr[i]);
 		rcktpt_io_addr[i] = 0;
 		return (0);
 	}
-	if (rcktpt_io_addr[i] + 0x40 == controller) {
-		*reserved_controller = 1;
-		request_region(rcktpt_io_addr[i], 68, "Comtrol RocketPort");
-	} else {
-		request_region(rcktpt_io_addr[i], 64, "Comtrol RocketPort");
-	}
 
 	ctlp = sCtlNumToCtlPtr(i);
 
@@ -2522,24 +2319,22 @@
 	for (aiop = 0; aiop < MAX_AIOPS_PER_BOARD; aiop++)
 		aiopio[aiop] = rcktpt_io_addr[i] + (aiop * 0x400);
 
-	num_aiops =
-	    sInitController(ctlp, i, controller + (i * 0x400), aiopio,  MAX_AIOPS_PER_BOARD, 0, FREQ_DIS, 0);
+	num_aiops = sInitController(ctlp, i, controller + (i * 0x400), aiopio,  MAX_AIOPS_PER_BOARD, 0, FREQ_DIS, 0);
 
 	if (ctlp->boardType == ROCKET_TYPE_PC104) {
 		sEnAiop(ctlp, 2);	/* only one AIOPIC, but these */
 		sEnAiop(ctlp, 3);	/* CSels used for other stuff */
 	}
 
+	/*  If something went wrong initing the AIOP's release the ISA IO memory */
 	if (num_aiops <= 0) {
-		if (rcktpt_io_addr[i] + 0x40 == controller) {
-			*reserved_controller = 0;
-			release_region(rcktpt_io_addr[i], 68);
-		} else {
-			release_region(rcktpt_io_addr[i], 64);
-		}
+		release_region(rcktpt_io_addr[i], 64);
 		rcktpt_io_addr[i] = 0;
 		return (0);
 	}
+  
+	rocketModel[i].startingPortNumber = nextLineNumber;
+
 	for (aiop = 0; aiop < num_aiops; aiop++) {
 		sResetAiopByNum(ctlp, aiop);
 		sEnAiop(ctlp, aiop);
@@ -2565,9 +2360,9 @@
 	rocketModel[i].numPorts = total_num_chan;
 	rocketModel[i].model = MODEL_ISA;
 
-	printk(KERN_INFO "Comtrol ISA controller #%d found at 0x%lx, "
-	       "%d AIOPs %s\n", i, rcktpt_io_addr[i], num_aiops,
-	       type_string);
+	printk(KERN_INFO "RocketPort ISA card #%d found at 0x%lx - %d AIOPs %s\n", 
+	       i, rcktpt_io_addr[i], num_aiops, type_string);
+
 	printk(KERN_INFO "Installing %s, creating /dev/ttyR%d - %ld\n",
 	       rocketModel[i].modelString,
 	       rocketModel[i].startingPortNumber,
@@ -2595,10 +2390,8 @@
 	.break_ctl = rp_break,
 	.send_xchar = rp_send_xchar,
 	.wait_until_sent = rp_wait_until_sent,
-#if (LINUX_VERSION_CODE > VERSION_CODE(2,5,0))
 	.tiocmget = rp_tiocmget,
 	.tiocmset = rp_tiocmset,
-#endif /* Kernel > 2.5 */
 };
 
 /*
@@ -2607,7 +2400,6 @@
 int __init rp_init(void)
 {
 	int retval, pci_boards_found, isa_boards_found, i;
-	int reserved_controller = 0;
 
 	printk(KERN_INFO "RocketPort device driver module, version %s, %s\n",
 	       ROCKET_VERSION, ROCKET_DATE);
@@ -2634,12 +2426,20 @@
 	nextLineNumber = 0;
 	memset(rocketModel, 0, sizeof (rocketModel));
 
-	if (board1 && controller == 0)
-		controller = board1 + 0x40;
+	/*
+	 *  If board 1 is non-zero, there is at least one ISA configured.  If controller is 
+	 *  zero, use the default controller IO address of board1 + 0x40.
+	 */
+	if (board1) {
+		if (controller == 0)
+			controller = board1 + 0x40;
+	} else {
+		controller = 0;  /*  Used as a flag, meaning no ISA boards */
+	}
 
-	if (controller && check_region(controller, 4)) {
-		printk(KERN_INFO "Controller IO addresses in use, unloading driver.\n");
-		put_tty_driver(rocket_driver);
+	/*  If an ISA card is configured, reserve the 4 byte IO space for the Mudbac controller */
+	if (controller && (!request_region(controller, 4, "Comtrol RocketPort"))) {
+		printk(KERN_INFO "Unable to reserve IO region for first configured ISA RocketPort controller 0x%lx.  Driver exiting \n", controller);
 		return -EBUSY;
 	}
 
@@ -2663,9 +2463,7 @@
 	 * driver with the tty layer.
 	 */
 
-#if (LINUX_VERSION_CODE > VERSION_CODE(2,5,0))
 	rocket_driver->owner = THIS_MODULE;
-#endif /* Kernel > 2.5 */
 	rocket_driver->flags = TTY_DRIVER_NO_DEVFS;
 	rocket_driver->devfs_name = "tts/R";
 	rocket_driver->name = "ttyR";
@@ -2701,7 +2499,7 @@
 	pci_boards_found = 0;
 
 	for (i = 0; i < NUM_BOARDS; i++) {
-		if (init_ISA(i, &reserved_controller))
+		if (init_ISA(i))
 			isa_boards_found++;
 	}
 
@@ -2720,13 +2518,6 @@
 		return -ENXIO;
 	}
 
-	if (isa_boards_found) {
-		if (reserved_controller == 0)
-			request_region(controller, 4, "Comtrol RocketPort");
-	} else {
-		controller = 0;
-	}
-
 	return 0;
 }
 
@@ -2736,7 +2527,6 @@
 {
 	int retval;
 	int i;
-	int released_controller = 0;
 
 	del_timer_sync(&rocket_timer);
 
@@ -2754,14 +2544,9 @@
 	for (i = 0; i < NUM_BOARDS; i++) {
 		if (rcktpt_io_addr[i] <= 0 || is_PCI[i])
 			continue;
-		if (rcktpt_io_addr[i] + 0x40 == controller) {
-			released_controller++;
-			release_region(rcktpt_io_addr[i], 68);
-		} else {
-			release_region(rcktpt_io_addr[i], 64);
-		}
+		release_region(rcktpt_io_addr[i], 64);
 	}
-	if (controller && released_controller == 0)
+	if (controller)
 		release_region(controller, 4);
 }
 #endif
diff -Nru a/drivers/char/rocket.h b/drivers/char/rocket.h
--- a/drivers/char/rocket.h	Fri Jun 13 12:49:06 2003
+++ b/drivers/char/rocket.h	Fri Jun 13 12:49:06 2003
@@ -1,29 +1,9 @@
 /*
- * rocket.h --- the exported interface of the rocket driver to
- * its configuration program.
+ * rocket.h --- the exported interface of the rocket driver to its configuration program.
  *
  * Written by Theodore Ts'o, Copyright 1997.
+ * Copyright 1997 Comtrol Corporation. 
  *
- * Copyright 1994, 1997, 2003 Comtrol Corporation.    All Rights Reserved.
- * 
- * The following source code is subject to Comtrol Corporation's
- * Developer's License Agreement.
- * 
- * This source code is protected by United States copyright law and 
- * international copyright treaties.
- * 
- * This source code may only be used to develop software products that
- * will operate with Comtrol brand hardware.
- * 
- * You may not reproduce nor distribute this source code in its original
- * form but must produce a derivative work which includes portions of
- * this source code only.
- * 
- * The portions of this source code which you use in your derivative
- * work must bear Comtrol's copyright notice:
- * 
- * 		Copyright 1994 Comtrol Corporation.
- * 
  */
 
 /*  Model Information Struct */
diff -Nru a/drivers/char/rocket_int.h b/drivers/char/rocket_int.h
--- a/drivers/char/rocket_int.h	Fri Jun 13 12:49:06 2003
+++ b/drivers/char/rocket_int.h	Fri Jun 13 12:49:06 2003
@@ -2,26 +2,7 @@
  * rocket_int.h --- internal header file for rocket.c
  *
  * Written by Theodore Ts'o, Copyright 1997.
- *
- * Copyright 1994, 1997, 2003 Comtrol Corporation.    All Rights Reserved.
- * 
- * The following source code is subject to Comtrol Corporation's
- * Developer's License Agreement.
- * 
- * This source code is protected by United States copyright law and 
- * international copyright treaties.
- * 
- * This source code may only be used to develop software products that
- * will operate with Comtrol brand hardware.
- * 
- * You may not reproduce nor distribute this source code in its original
- * form but must produce a derivative work which includes portions of
- * this source code only.
- * 
- * The portions of this source code which you use in your derivative
- * work must bear Comtrol's copyright notice:
- * 
- * 		Copyright 1994 Comtrol Corporation.
+ * Copyright 1997 Comtrol Corporation.  
  * 
  */
 
@@ -98,17 +79,9 @@
 #define sInW(a) (inw_p(a))
 #endif				/* ROCKET_DEBUG_IO */
 
-/* This is used to move arrays of bytes so byte swapping isn't
- * appropriate.  On Linux 2.3 and above outsw is the same as
- * outsw_ns, but we use the old form for compatibility with
- * old kernels. */
-#if  defined(__BIG_ENDIAN) && (LINUX_VERSION_CODE < VERSION_CODE(2,3,0))
-#define sOutStrW(port, addr, count) if (count) outsw_ns(port, addr, count)
-#define sInStrW(port, addr, count) if (count) insw_ns(port, addr, count)
-#else
+/* This is used to move arrays of bytes so byte swapping isn't appropriate. */
 #define sOutStrW(port, addr, count) if (count) outsw(port, addr, count)
 #define sInStrW(port, addr, count) if (count) insw(port, addr, count)
-#endif
 
 #define CTL_SIZE 8
 #define AIOP_CTL_SIZE 4
@@ -1318,11 +1291,7 @@
 /* Compact PCI device */ 
 #define PCI_DEVICE_ID_CRP16INTF		0x0903	/* Rocketport Compact PCI 16 port w/external I/F */
 
-/*  Taking care of some kernel incompatibilities... */
-#if LINUX_VERSION_CODE > VERSION_CODE(2,5,68)
-
 #define TTY_GET_LINE(t) t->index
-
 #define TTY_DRIVER_MINOR_START(t) t->driver->minor_start
 #define TTY_DRIVER_SUBTYPE(t) t->driver->subtype
 #define TTY_DRIVER_NAME(t) t->driver->name
@@ -1330,15 +1299,4 @@
 #define TTY_DRIVER_FLUSH_BUFFER_EXISTS(t) t->driver->flush_buffer
 #define TTY_DRIVER_FLUSH_BUFFER(t) t->driver->flush_buffer(t)
 
-#else
 
-#define TTY_GET_LINE(t) minor(t->device) - TTY_DRIVER_MINOR_START(t)
-
-#define TTY_DRIVER_MINOR_START(t) t->driver.minor_start
-#define TTY_DRIVER_SUBTYPE(t) t->driver.subtype
-#define TTY_DRIVER_NAME(t) t->driver.name
-#define TTY_DRIVER_NAME_BASE(t) t->driver.name_base
-#define TTY_DRIVER_FLUSH_BUFFER_EXISTS(t) t->driver.flush_buffer
-#define TTY_DRIVER_FLUSH_BUFFER(t) t->driver.flush_buffer(t)
-
-#endif
diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Fri Jun 13 12:49:06 2003
+++ b/drivers/pci/pci.ids	Fri Jun 13 12:49:06 2003
@@ -3752,6 +3752,8 @@
 	0005  Rocketport 8 port w/octa cable
 	0006  Rocketport 8 port w/RJ11 connectors
 	0007  Rocketport 4 port w/RJ11 connectors
+	0008  Rocketport 8 port w/ DB78 SNI (Siemens) connector
+	0009  Rocketport 16 port w/ DB78 SNI (Siemens) connector
 	000a  Rocketport Plus 4 port
 	000b  Rocketport Plus 8 port
 	000c  RocketModem 6 port
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Fri Jun 13 12:49:06 2003
+++ b/include/linux/pci_ids.h	Fri Jun 13 12:49:06 2003
@@ -1399,6 +1399,8 @@
 #define PCI_DEVICE_ID_RP8OCTA		0x0005
 #define PCI_DEVICE_ID_RP8J		0x0006
 #define PCI_DEVICE_ID_RP4J		0x0007
+#define PCI_DEVICE_ID_RP8SNI		0x0008	
+#define PCI_DEVICE_ID_RP16SNI		0x0009	
 #define PCI_DEVICE_ID_RPP4		0x000A
 #define PCI_DEVICE_ID_RPP8		0x000B
 #define PCI_DEVICE_ID_RP8M		0x000C
