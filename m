Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268599AbRGZR45>; Thu, 26 Jul 2001 13:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268598AbRGZR4r>; Thu, 26 Jul 2001 13:56:47 -0400
Received: from [145.254.150.141] ([145.254.150.141]:6404 "HELO
	ozean.schottelius.org") by vger.kernel.org with SMTP
	id <S268607AbRGZR4k>; Thu, 26 Jul 2001 13:56:40 -0400
Message-ID: <3B6059A2.8199CCA4@pcsystems.de>
Date: Thu, 26 Jul 2001 19:55:46 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Control PCSPEAKER (forgot the patch .. .)
Content-Type: multipart/mixed;
 boundary="------------706FC8DD27B3AD01E10CD66B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.
--------------706FC8DD27B3AD01E10CD66B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here's it actually!

Nico

--------------706FC8DD27B3AD01E10CD66B
Content-Type: text/plain; charset=us-ascii;
 name="patch-control-pcspeacker"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-control-pcspeacker"

--- linux-7/kernel/sysctl.c	Tue Jul 24 18:50:16 2001
+++ linux/kernel/sysctl.c	Tue Jul 24 19:07:06 2001
@@ -16,6 +16,7 @@
  *  Wendling.
  * The list_for_each() macro wasn't appropriate for the sysctl loop.
  *  Removed it and replaced it with older style, 03/23/00, Bill Wendling
+ * disable pc_speaker support, 24th of July 2001, Nico Schottelius
  */
 
 #include <linux/config.h>
@@ -47,6 +48,7 @@
 extern int max_threads;
 extern int nr_queued_signals, max_queued_signals;
 extern int sysrq_enabled;
+extern int pcspeaker_enabled; /* don't waste ram unless really needed */
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -212,6 +214,9 @@
 	 0444, NULL, &proc_dointvec},
 	{KERN_RTSIGMAX, "rtsig-max", &max_queued_signals, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+	{KERN_DISABLE_PC_SPEAKER, "pcspeaker", &pcspeaker_enabled, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+
 #ifdef CONFIG_SYSVIPC
 	{KERN_SHMMAX, "shmmax", &shm_ctlmax, sizeof (size_t),
 	 0644, NULL, &proc_doulongvec_minmax},
--- linux-7/kernel/sys.c	Tue Jul 24 18:50:16 2001
+++ linux/kernel/sys.c	Tue Jul 24 19:07:49 2001
@@ -40,6 +40,12 @@
 
 int C_A_D = 1;
 
+/*
+ * whether to enable or disable the pcspeaker. default is to enable it.
+ */
+
+int pcspeaker_enabled = 1;
+
 
 /*
  *	Notifier list for kernel code which wants to be called
--- linux-7/include/linux/sysctl.h	Tue Jul 24 18:50:18 2001
+++ linux/include/linux/sysctl.h	Tue Jul 24 19:08:45 2001
@@ -118,7 +118,8 @@
 	KERN_SHMPATH=48,	/* string: path to shm fs */
 	KERN_HOTPLUG=49,	/* string: path to hotplug policy agent */
 	KERN_IEEE_EMULATION_WARNINGS=50, /* int: unimplemented ieee instructions */
-	KERN_S390_USER_DEBUG_LOGGING=51  /* int: dumps of user faults */
+	KERN_S390_USER_DEBUG_LOGGING=51,  /* int: dumps of user faults */
+	KERN_DISABLE_PC_SPEAKER=52 /* int: pcspeaker on or off */
 };
 
 
--- linux-7/drivers/char/vt.c	Tue Jul 24 18:51:34 2001
+++ linux/drivers/char/vt.c	Tue Jul 24 19:10:15 2001
@@ -7,6 +7,7 @@
  *  Dynamic keymap and string allocation - aeb@cwi.nl - May 1994
  *  Restrict VT switching via ioctl() - grif@cs.ucr.edu - Dec 1995
  *  Some code moved for less code duplication - Andi Kleen - Mar 1997
+ *  Added ability to disable the pc speaker - nico@schottelius.org - May 2001
  */
 
 #include <linux/config.h>
@@ -40,6 +41,8 @@
 #include <asm/vc_ioctl.h>
 #endif /* CONFIG_FB_COMPAT_XPMAC */
 
+extern int pcspeaker_enabled; /* disable/enable the pcspeaker */
+
 char vt_dont_switch;
 extern struct tty_driver console_driver;
 
@@ -112,6 +115,10 @@
 	unsigned int count = 0;
 	unsigned long flags;
 
+	/* is the pcspeaker enabled or disabled ? 0=disabled,1=enabled */
+	if(!pcspeaker_enabled)
+		return;
+
 	if (hz > 20 && hz < 32767)
 		count = 1193180 / hz;
 	
@@ -137,7 +144,7 @@
 	return;
 }
 
-#else
+#else /* else of machine check */
 
 void
 _kd_mksound(unsigned int hz, unsigned int ticks)

--------------706FC8DD27B3AD01E10CD66B--

