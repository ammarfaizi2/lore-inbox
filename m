Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137083AbREKJHj>; Fri, 11 May 2001 05:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137085AbREKJH3>; Fri, 11 May 2001 05:07:29 -0400
Received: from pD9004B1A.dip.t-dialin.net ([217.0.75.26]:56290 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S137082AbREKJHZ>;
	Fri, 11 May 2001 05:07:25 -0400
Message-ID: <3AFBABB6.18CB3D3C@pcsystems.de>
Date: Fri, 11 May 2001 11:07:02 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: new patch: disable pcspeaker (complete)
Content-Type: multipart/mixed;
 boundary="------------E49A0C775DE42AA93E17244E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E49A0C775DE42AA93E17244E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



Hi guys!

Some of the people of the kernel mailing list told me to
build up the disable pcspeaker support with sysctl.

It is done and works perfectly!

Will you apply the patch to kernel 2.4.5 ?
If so, can anybody or can I change the config.in files ?

Regards,

Nico


ps-1: My mail route is currently broken. please resend emails
in the next days, whether some returned!
I am working on the line problem!


p.s.: overview:

1. Changed drivers/char/vt.c (diff attached)
2. Changed arch/{i386,alpha,ppc,arm,mips}/config.in :

if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
   bool '  Disable the PC-Speaker' CONFIG_DISABLE_PC_SPEAKER
fi

(should be the last item of the 'General Setup' Menu, I don't attach
diffs
for all those different config.in files)

3. support for sysctl: changes in kernel/{sys.c,sysctl.c} and
include/linux/
   sysctl.h (diffs attached)

4. wrote text for Configure.help:

(attached)


--------------E49A0C775DE42AA93E17244E
Content-Type: text/plain; charset=us-ascii;
 name="HELP_TEXT"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HELP_TEXT"

Disables the Internal (PC) speaker
CONFIG_DISABLE_PC_SPEAKER
  Whenever you don't want your computer to be able to beep, 
  choose this option. Actually, choosing this will still not
  disable the speaker, you have to use sysctl for this:

     echo 0 > /proc/sys/kernel/pcspeaker # disable speaker
     
     echo 1 > /proc/sys/kernel/pcspeaker # enable speaker (default)

  Attention: This will not catch the beeps made directly by the
  BIOS (mostly this happens when using a notebook and pressing 
  special key codes). To disable this "BIOS-beep" enter the
  BIOS and change it there.

  If you are unsure, say N to this.



--------------E49A0C775DE42AA93E17244E
Content-Type: text/plain; charset=us-ascii;
 name="PATCH"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PATCH"

--- kernel/sysctl.c-orig	Wed May  9 22:22:05 2001
+++ kernel/sysctl.c	Wed May  9 23:44:30 2001
@@ -16,6 +16,7 @@
  *  Wendling.
  * The list_for_each() macro wasn't appropriate for the sysctl loop.
  *  Removed it and replaced it with older style, 03/23/00, Bill Wendling
+ * disable pc_speaker support, 8th of May 2001, Nico Schottelius
  */
 
 #include <linux/config.h>
@@ -48,6 +49,10 @@
 extern int nr_queued_signals, max_queued_signals;
 extern int sysrq_enabled;
 
+#ifdef CONFIG_DISABLE_PC_SPEAKER
+extern int pcspeaker_enabled; /* don't waste ram unless really needed */
+#endif
+
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -212,6 +217,12 @@
 	 0444, NULL, &proc_dointvec},
 	{KERN_RTSIGMAX, "rtsig-max", &max_queued_signals, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+
+#ifdef CONFIG_DISABLE_PC_SPEAKER
+	{KERN_DISABLE_PC_SPEAKER, "pcspeaker", &pcspeaker_enabled, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+#endif
+
 #ifdef CONFIG_SYSVIPC
 	{KERN_SHMMAX, "shmmax", &shm_ctlmax, sizeof (size_t),
 	 0644, NULL, &proc_doulongvec_minmax},
--- kernel/sys.c-orig	Wed May  9 22:33:14 2001
+++ kernel/sys.c	Wed May  9 23:45:26 2001
@@ -40,6 +40,14 @@
 
 int C_A_D = 1;
 
+/*
+ * whether to enable or disable the pcspeaker. default is to enable it.
+ */
+
+#ifdef CONFIG_DISABLE_PC_SPEAKER
+int pcspeaker_enabled = 1;
+#endif 
+
 
 /*
  *	Notifier list for kernel code which wants to be called
--- include/linux/sysctl.h-orig	Wed May  9 22:29:22 2001
+++ include/linux/sysctl.h	Wed May  9 22:54:13 2001
@@ -118,7 +118,8 @@
 	KERN_SHMPATH=48,	/* string: path to shm fs */
 	KERN_HOTPLUG=49,	/* string: path to hotplug policy agent */
 	KERN_IEEE_EMULATION_WARNINGS=50, /* int: unimplemented ieee instructions */
-	KERN_S390_USER_DEBUG_LOGGING=51  /* int: dumps of user faults */
+	KERN_S390_USER_DEBUG_LOGGING=51,  /* int: dumps of user faults */
+	KERN_DISABLE_PC_SPEAKER=52 /* int: speaker on or off */
 };
 
 
--- drivers/char/vt.c-orig	Thu May  3 14:53:13 2001
+++ drivers/char/vt.c	Wed May  9 23:47:36 2001
@@ -7,6 +7,7 @@
  *  Dynamic keymap and string allocation - aeb@cwi.nl - May 1994
  *  Restrict VT switching via ioctl() - grif@cs.ucr.edu - Dec 1995
  *  Some code moved for less code duplication - Andi Kleen - Mar 1997
+ *  Added ability to disable the pc speaker - nico@schottelius.org - May 2001
  */
 
 #include <linux/config.h>
@@ -40,6 +41,10 @@
 #include <asm/vc_ioctl.h>
 #endif /* CONFIG_FB_COMPAT_XPMAC */
 
+#ifdef CONFIG_DISABLE_PC_SPEAKER
+extern int pcspeaker_enabled; /* disable the pcspeaker */
+#endif
+
 char vt_dont_switch;
 extern struct tty_driver console_driver;
 
@@ -112,6 +117,12 @@
 	unsigned int count = 0;
 	unsigned long flags;
 
+#ifdef CONFIG_DISABLE_PC_SPEAKER
+	/* is the pcspeaker enabled or disabled ? 0=disabled,1=enabled */
+	if(!pcspeaker_enabled)
+		return;
+#endif
+
 	if (hz > 20 && hz < 32767)
 		count = 1193180 / hz;
 	
@@ -137,7 +148,7 @@
 	return;
 }
 
-#else
+#else /* else of machine check */
 
 void
 _kd_mksound(unsigned int hz, unsigned int ticks)


--------------E49A0C775DE42AA93E17244E--

