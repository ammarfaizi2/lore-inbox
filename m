Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264294AbTLPCIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 21:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTLPCIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 21:08:17 -0500
Received: from bdsl.66.14.75.66.gte.net ([66.14.75.66]:40858 "HELO
	smtp.qosmetrix.com") by vger.kernel.org with SMTP id S264294AbTLPCIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 21:08:09 -0500
From: niraj gupta <niraj_gupta@qosmetrix.com>
Organization: qosmetrix
To: linux-kernel@vger.kernel.org
Subject: 0n the heels on 10khz patch for 2.6 here is the patch for 2.4 hot of the press
Date: Mon, 15 Dec 2003 18:08:04 -0800
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ekm3/5EWnNh9Jsw"
Message-Id: <200312151808.04337.niraj_gupta@qosmetrix.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Ekm3/5EWnNh9Jsw
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



just wanted to thank Jean-Marc Valin for the 10khz patch, 
here is the patch for 2.4, it boots for me for 2.4G HT/SMP enabled CPU
but YMMV

i am not subscribed to the list so please cc me personally
if it were not for kerneltrap i would have never seen the original patch


thanks and enjoy
niraj

--Boundary-00=_Ekm3/5EWnNh9Jsw
Content-Type: text/x-diff;
  charset="us-ascii";
  name="10khz-2.4.22-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="10khz-2.4.22-1.patch"

diff -urN linux-2.4.22/arch/i386/kernel/apic.c 10klinux-2.4.22/arch/i386/kernel/apic.c
--- linux-2.4.22/arch/i386/kernel/apic.c	2003-06-13 07:51:29.000000000 -0700
+++ 10klinux-2.4.22/arch/i386/kernel/apic.c	2003-12-15 17:55:37.000000000 -0800
@@ -767,7 +767,7 @@
 	 * chipset timer can cause.
 	 */
 
-	} while (delta < 300);
+	} while (delta < 30);
 }
 
 /*
diff -urN linux-2.4.22/arch/i386/kernel/setup.c 10klinux-2.4.22/arch/i386/kernel/setup.c
--- linux-2.4.22/arch/i386/kernel/setup.c	2003-08-25 04:44:39.000000000 -0700
+++ 10klinux-2.4.22/arch/i386/kernel/setup.c	2003-12-15 17:55:37.000000000 -0800
@@ -3051,8 +3051,8 @@
 			seq_printf(m, " %s", x86_cap_flags[i]);
 
 	seq_printf(m, "\nbogomips\t: %lu.%02lu\n\n",
-		     c->loops_per_jiffy/(500000/HZ),
-		     (c->loops_per_jiffy/(5000/HZ)) % 100);
+                     HZ*(c->loops_per_jiffy>>3)/62500,
+                     (HZ*(c->loops_per_jiffy>>3)/625)%100);
 	return 0;
 }
 
diff -urN linux-2.4.22/arch/i386/kernel/smpboot.c 10klinux-2.4.22/arch/i386/kernel/smpboot.c
--- linux-2.4.22/arch/i386/kernel/smpboot.c	2003-08-25 04:44:39.000000000 -0700
+++ 10klinux-2.4.22/arch/i386/kernel/smpboot.c	2003-12-15 17:55:37.000000000 -0800
@@ -1164,8 +1164,8 @@
 				bogosum += cpu_data[cpu].loops_per_jiffy;
 		printk(KERN_INFO "Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
 			cpucount+1,
-			bogosum/(500000/HZ),
-			(bogosum/(5000/HZ))%100);
+		        HZ *(bogosum >>3)/62500,
+		        (HZ*(bogosum>>3)/625)%100);
 		Dprintk("Before bogocount - setting activated=1.\n");
 	}
 	smp_num_cpus = cpucount + 1;
diff -urN linux-2.4.22/drivers/char/dtlk.c 10klinux-2.4.22/drivers/char/dtlk.c
--- linux-2.4.22/drivers/char/dtlk.c	2001-09-13 15:21:32.000000000 -0700
+++ 10klinux-2.4.22/drivers/char/dtlk.c	2003-12-15 17:55:37.000000000 -0800
@@ -209,7 +209,7 @@
 				   up to 250 usec for the RDY bit to
 				   go nonzero. */
 				for (retries = 0;
-				     retries < loops_per_jiffy / (4000/HZ);
+                                     retries < HZ*(loops_per_jiffy>>5)/125;
 				     retries++)
 					if (inb_p(dtlk_port_tts) &
 					    TTS_WRITABLE)
diff -urN linux-2.4.22/drivers/char/ipmi/ipmi_msghandler.c 10klinux-2.4.22/drivers/char/ipmi/ipmi_msghandler.c
--- linux-2.4.22/drivers/char/ipmi/ipmi_msghandler.c	2003-06-13 07:51:33.000000000 -0700
+++ 10klinux-2.4.22/drivers/char/ipmi/ipmi_msghandler.c	2003-12-15 17:55:37.000000000 -0800
@@ -1742,7 +1742,7 @@
 
 /* Call every 100 ms. */
 #define IPMI_TIMEOUT_TIME	100
-#define IPMI_TIMEOUT_JIFFIES	(IPMI_TIMEOUT_TIME/(1000/HZ))
+#define IPMI_TIMEOUT_JIFFIES	((IPMI_TIMEOUT_TIME * HZ) / 1000)
 
 /* Request events from the queue every second.  Hopefully, in the
    future, IPMI will add a way to know immediately if an event is
diff -urN linux-2.4.22/include/linux/cyclades.h 10klinux-2.4.22/include/linux/cyclades.h
--- linux-2.4.22/include/linux/cyclades.h	2003-06-13 07:51:38.000000000 -0700
+++ 10klinux-2.4.22/include/linux/cyclades.h	2003-12-15 17:55:37.000000000 -0800
@@ -580,7 +580,7 @@
 	int			custom_divisor;
 	int                     x_char; /* to be pushed out ASAP */
 	int			close_delay;
-	unsigned short		closing_wait;
+	unsigned int		closing_wait;
 	unsigned long		event;
 	unsigned long		last_active;
 	int			count;	/* # of fd on device */
diff -urN linux-2.4.22/include/linux/generic_serial.h 10klinux-2.4.22/include/linux/generic_serial.h
--- linux-2.4.22/include/linux/generic_serial.h	2002-02-25 11:38:13.000000000 -0800
+++ 10klinux-2.4.22/include/linux/generic_serial.h	2003-12-15 17:55:37.000000000 -0800
@@ -46,7 +46,7 @@
   int                     blocked_open;
   struct tty_struct       *tty;
   int                     event;
-  unsigned short          closing_wait;
+  unsigned int            closing_wait;
   int                     close_delay;
   struct real_driver      *rd;
   int                     wakeup_chars;
diff -urN linux-2.4.22/include/linux/hayesesp.h 10klinux-2.4.22/include/linux/hayesesp.h
--- linux-2.4.22/include/linux/hayesesp.h	1999-05-12 13:27:37.000000000 -0700
+++ 10klinux-2.4.22/include/linux/hayesesp.h	2003-12-15 17:55:37.000000000 -0800
@@ -87,8 +87,8 @@
 	int			stat_flags;
 	int			custom_divisor;
 	int			close_delay;
-	unsigned short		closing_wait;
-	unsigned short		closing_wait2;
+	unsigned int		closing_wait;
+	unsigned int		closing_wait2;
 	int			IER; 	/* Interrupt Enable Register */
 	int			MCR; 	/* Modem control register */
 	unsigned long		event;
diff -urN linux-2.4.22/include/linux/isicom.h 10klinux-2.4.22/include/linux/isicom.h
--- linux-2.4.22/include/linux/isicom.h	2001-07-26 13:53:38.000000000 -0700
+++ 10klinux-2.4.22/include/linux/isicom.h	2003-12-15 17:55:37.000000000 -0800
@@ -147,7 +147,7 @@
 	int			close_delay;
 	unsigned short		channel;
 	unsigned short		status;
-	unsigned short		closing_wait;
+	unsigned int		closing_wait;
 	long 			session;
 	long			pgrp;
 	struct isi_board	* card;
diff -urN linux-2.4.22/include/linux/serial.h 10klinux-2.4.22/include/linux/serial.h
--- linux-2.4.22/include/linux/serial.h	2002-08-02 17:39:45.000000000 -0700
+++ 10klinux-2.4.22/include/linux/serial.h	2003-12-15 17:55:37.000000000 -0800
@@ -39,12 +39,12 @@
 	int	xmit_fifo_size;
 	int	custom_divisor;
 	int	baud_base;
-	unsigned short	close_delay;
+	unsigned int	close_delay;
 	char	io_type;
 	char	reserved_char[1];
 	int	hub6;
-	unsigned short	closing_wait; /* time to wait before closing */
-	unsigned short	closing_wait2; /* no longer used... */
+	unsigned int	closing_wait; /* time to wait before closing */
+	unsigned int	closing_wait2; /* no longer used... */
 	unsigned char	*iomem_base;
 	unsigned short	iomem_reg_shift;
 	unsigned int	port_high;
diff -urN linux-2.4.22/include/linux/serialP.h 10klinux-2.4.22/include/linux/serialP.h
--- linux-2.4.22/include/linux/serialP.h	2002-08-02 17:39:45.000000000 -0700
+++ 10klinux-2.4.22/include/linux/serialP.h	2003-12-15 17:55:37.000000000 -0800
@@ -45,8 +45,8 @@
 	int	count;
 	u8	*iomem_base;
 	u16	iomem_reg_shift;
-	unsigned short	close_delay;
-	unsigned short	closing_wait; /* time to wait before closing */
+	unsigned int	close_delay;
+	unsigned int	closing_wait; /* time to wait before closing */
 	struct async_icount	icount;	
 	struct termios		normal_termios;
 	struct termios		callout_termios;
@@ -69,8 +69,8 @@
 	int			quot;
 	int			x_char;	/* xon/xoff character */
 	int			close_delay;
-	unsigned short		closing_wait;
-	unsigned short		closing_wait2;
+	unsigned int		closing_wait;
+	unsigned int		closing_wait2;
 	int			IER; 	/* Interrupt Enable Register */
 	int			MCR; 	/* Modem control register */
 	int			LCR; 	/* Line control register */
diff -urN linux-2.4.22/include/linux/timex.h 10klinux-2.4.22/include/linux/timex.h
--- linux-2.4.22/include/linux/timex.h	2001-11-22 11:46:18.000000000 -0800
+++ 10klinux-2.4.22/include/linux/timex.h	2003-12-15 17:55:37.000000000 -0800
@@ -74,6 +74,12 @@
 # define SHIFT_HZ	9
 #elif HZ >= 768 && HZ < 1536
 # define SHIFT_HZ	10
+#elif HZ >= 1536 && HZ < 3072
+# define SHIFT_HZ	11
+#elif HZ >= 3072 && HZ < 6144
+# define SHIFT_HZ	12
+#elif HZ >= 6144 && HZ < 12288
+# define SHIFT_HZ	13
 #else
 # error You lose.
 #endif
diff -urN linux-2.4.22/include/net/irda/ircomm_tty.h 10klinux-2.4.22/include/net/irda/ircomm_tty.h
--- linux-2.4.22/include/net/irda/ircomm_tty.h	2003-08-25 04:44:44.000000000 -0700
+++ 10klinux-2.4.22/include/net/irda/ircomm_tty.h	2003-12-15 17:55:37.000000000 -0800
@@ -99,8 +99,8 @@
 	struct timer_list watchdog_timer;
 	struct tq_struct  tqueue;
 
-        unsigned short    close_delay;
-        unsigned short    closing_wait; /* time to wait before closing */
+        unsigned int      close_delay;
+        unsigned int      closing_wait; /* time to wait before closing */
 
 	long session;           /* Session of opening process */
 	long pgrp;		/* pgrp of opening process */
diff -urN linux-2.4.22/include/net/tcp.h 10klinux-2.4.22/include/net/tcp.h
--- linux-2.4.22/include/net/tcp.h	2003-08-25 04:44:44.000000000 -0700
+++ 10klinux-2.4.22/include/net/tcp.h	2003-12-15 17:55:37.000000000 -0800
@@ -375,8 +375,8 @@
    so that we select tick to get range about 4 seconds.
  */
 
-#if HZ <= 16 || HZ > 4096
-# error Unsupported: HZ <= 16 or HZ > 4096
+#if HZ <= 16 || HZ > 16384
+# error Unsupported: HZ <= 16 or HZ > 16384
 #elif HZ <= 32
 # define TCP_TW_RECYCLE_TICK (5+2-TCP_TW_RECYCLE_SLOTS_LOG)
 #elif HZ <= 64
@@ -391,8 +391,12 @@
 # define TCP_TW_RECYCLE_TICK (10+2-TCP_TW_RECYCLE_SLOTS_LOG)
 #elif HZ <= 2048
 # define TCP_TW_RECYCLE_TICK (11+2-TCP_TW_RECYCLE_SLOTS_LOG)
-#else
+#elif HZ <= 4096
 # define TCP_TW_RECYCLE_TICK (12+2-TCP_TW_RECYCLE_SLOTS_LOG)
+#elif HZ <= 8192
+# define TCP_TW_RECYCLE_TICK (13+2-TCP_TW_RECYCLE_SLOTS_LOG)
+#else
+# define TCP_TW_RECYCLE_TICK (14+2-TCP_TW_RECYCLE_SLOTS_LOG)
 #endif
 
 /*
diff -urN linux-2.4.22/init/main.c 10klinux-2.4.22/init/main.c
--- linux-2.4.22/init/main.c	2003-08-25 04:44:44.000000000 -0700
+++ 10klinux-2.4.22/init/main.c	2003-12-15 17:55:37.000000000 -0800
@@ -198,8 +198,8 @@
 
 /* Round the value and print it */	
 	printk("%lu.%02lu BogoMIPS\n",
-		loops_per_jiffy/(500000/HZ),
-		(loops_per_jiffy/(5000/HZ)) % 100);
+		HZ*(loops_per_jiffy>>3)/62500,
+		(HZ*(loops_per_jiffy>>3)/625)%100);
 }
 
 static int __init debug_kernel(char *str)
diff -urN linux-2.4.22/kernel/timer.c 10klinux-2.4.22/kernel/timer.c
--- linux-2.4.22/kernel/timer.c	2002-11-28 15:53:15.000000000 -0800
+++ 10klinux-2.4.22/kernel/timer.c	2003-12-15 17:55:37.000000000 -0800
@@ -430,7 +430,11 @@
 	if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
 	    ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
 	time_offset += ltemp;
-	time_adj = -ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+#if SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE > 0
+        time_adj = -ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+#else
+        time_adj = -ltemp >> (SHIFT_HZ + SHIFT_UPDATE - SHIFT_SCALE);
+#endif
     } else {
 	ltemp = time_offset;
 	if (!(time_status & STA_FLL))
@@ -438,7 +442,11 @@
 	if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
 	    ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
 	time_offset -= ltemp;
-	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+#if SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE > 0
+        time_adj = -ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+#else
+        time_adj = -ltemp >> (SHIFT_HZ + SHIFT_UPDATE - SHIFT_SCALE);
+#endif
     }
 
     /*

--Boundary-00=_Ekm3/5EWnNh9Jsw--

