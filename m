Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262750AbRE3MLg>; Wed, 30 May 2001 08:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262751AbRE3ML1>; Wed, 30 May 2001 08:11:27 -0400
Received: from pD9004ADD.dip.t-dialin.net ([217.0.74.221]:57314 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S262750AbRE3MLG>;
	Wed, 30 May 2001 08:11:06 -0400
Message-ID: <3B14E340.F1B19CA6@pcsystems.de>
Date: Wed, 30 May 2001 14:10:40 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ PATCH ]: disable pcspeaker kernel: 2.4.2 - 2.4.5
Content-Type: multipart/mixed;
 boundary="------------98D16A434A8C0FAC87A59F77"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------98D16A434A8C0FAC87A59F77
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



Hello!

As I read that Alan and Linus are more than busy,
I just retry sending the patch to the list.

The patch allows you to switch off the builtin pc speaker
with sysctl options. No program will then be able to
beep under Linux, nor under X neither in the console.

Normally the speaker keeps enabled, unless you

echo 0 > /proc/sys/kernel/pcspeaker

With all values != 0 it is turned on (documented is 1).

The support is included for i386, ia64, alpha, mips and mips64.

It is tested under i386 with several kernels / machines.
No problem occurs.
The code should not make any problems on the other
processors, but I would be nice if I could get feedback
from people using this on alpha,...

I (and maybe others ?) would be happy if someone
applies the patch to 2.4.6.

Thank you,

Nico

P.S.: I also attached an init script. This is from the clinux
distrubtion
and has to be changed to run without /etc/sys/combined and
/etc/sys/boot/kernelsettings.
If somebody is interested, I can send him/her the /etc/sys/ files.



--------------98D16A434A8C0FAC87A59F77
Content-Type: text/plain; charset=us-ascii;
 name="set_pcspeaker"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="set_pcspeaker"

#!/bin/sh
# 
# Author: Nico Schottelius <nico AT schottelius DOT org>
# Date: 15th of May 2k+1
# Last Changed: 15th of May 2k+1
# Comment: Sub script of kernel/ settings script. Set pcspeaker on/off
#

. /etc/sys/combined
. /etc/sys/boot/kernelsettings

case "$1" in
    on)		$SYS_ECHO -n "$SET $PC_SPEAKER_TEXT $WILL_TEXT "
		echo 1 > $PC_SPEAKER_FILE
		$SYS_ECHO $ON
		;;
    off)	$SYS_ECHO -n "$SET $PC_SPEAKER_TEXT $WILL_TEXT "
		echo 0 > $PC_SPEAKER_FILE
		$SYS_ECHO $OFF
              	;;

    status)	$SYS_ECHO -n "$STATUS $PC_SPEAKER_TEXT $IS_TEXT "
    		if [ `cat $PC_SPEAKER_FILE` -eq 0 ]; then
			$SYS_ECHO $OFF
		else
			$SYS_ECHO $ON
		fi
    		;;
    *)		$SYS_ECHO  "$USAGE $0 {on|off|status}"
		exit 1
esac

exit 0



--------------98D16A434A8C0FAC87A59F77
Content-Type: text/plain; charset=us-ascii;
 name="pc_speaker.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pc_speaker.patch"

diff -u --recursive linux-2.4.5/Documentation/Configure.help linux-2.4.5-nc/Documentation/Configure.help
--- linux-2.4.5/Documentation/Configure.help	Tue May 29 17:56:15 2001
+++ linux-2.4.5-nc/Documentation/Configure.help	Mon May 28 19:23:47 2001
@@ -333,6 +333,23 @@
 
   Most users will answer N here.
 
+Disables the PC or internal speaker
+CONFIG_DISABLE_PC_SPEAKER
+  Whenever you don't want your computer to be able to beep,
+  choose this option. Actually, choosing this will still not
+  disable the speaker, you have to use sysctl for this:
+
+     echo 0 > /proc/sys/kernel/pcspeaker # disable speaker
+
+     echo 1 > /proc/sys/kernel/pcspeaker # enable speaker (default)
+
+  Attention: This will not catch the beeps made directly by the
+  BIOS (mostly this happens when using a notebook and pressing
+  special key codes). To disable this "BIOS-beep" enter the
+  BIOS and change it there.
+
+  If you are unsure, say N.
+
 Network Block Device support
 CONFIG_BLK_DEV_NBD
   Saying Y here will allow your computer to be a client for network
diff -u --recursive linux-2.4.5/arch/alpha/config.in linux-2.4.5-nc/arch/alpha/config.in
--- linux-2.4.5/arch/alpha/config.in	Tue May 29 17:56:15 2001
+++ linux-2.4.5-nc/arch/alpha/config.in	Tue May 29 18:37:02 2001
@@ -240,6 +240,11 @@
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 tristate 'Kernel support for Linux/Intel ELF binaries' CONFIG_BINFMT_EM86
 source drivers/parport/Config.in
+
+if [ "$CONFIG_SYSCTL" = "y" ]; then
+   bool '  Disable the PC-Speaker' CONFIG_DISABLE_PC_SPEAKER
+fi
+
 endmenu
 
 source drivers/mtd/Config.in
diff -u --recursive linux-2.4.5/arch/arm/config.in linux-2.4.5-nc/arch/arm/config.in
--- linux-2.4.5/arch/arm/config.in	Tue May 29 17:55:36 2001
+++ linux-2.4.5-nc/arch/arm/config.in	Tue May 29 18:49:17 2001
@@ -372,6 +372,12 @@
    source net/ax25/Config.in
 
    source net/irda/Config.in
+
+if [ "$CONFIG_SYSCTL" = "y" ]; then
+   bool '  Disable the PC-Speaker' CONFIG_DISABLE_PC_SPEAKER
+fi
+
 fi
 
 mainmenu_option next_comment
diff -u --recursive linux-2.4.5/arch/i386/config.in linux-2.4.5-nc/arch/i386/config.in
--- linux-2.4.5/arch/i386/config.in	Tue May 29 17:56:16 2001
+++ linux-2.4.5-nc/arch/i386/config.in	Tue May 29 18:36:20 2001
@@ -258,6 +258,10 @@
    bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
 fi
 
+if [ "$CONFIG_SYSCTL" = "y" ]; then
+   bool '  Disable the PC-Speaker' CONFIG_DISABLE_PC_SPEAKER
+fi
+
 endmenu
 
 source drivers/mtd/Config.in
diff -u --recursive linux-2.4.5/arch/ia64/config.in linux-2.4.5-nc/arch/ia64/config.in
--- linux-2.4.5/arch/ia64/config.in	Tue May 29 17:55:36 2001
+++ linux-2.4.5-nc/arch/ia64/config.in	Tue May 29 18:41:58 2001
@@ -137,6 +137,10 @@
 
 fi # !HP_SIM
 
+if [ "$CONFIG_SYSCTL" = "y" ]; then
+   bool '  Disable the PC-Speaker' CONFIG_DISABLE_PC_SPEAKER
+fi
+
 endmenu
 
 if [ "$CONFIG_NET" = "y" ]; then
diff -u --recursive linux-2.4.5/arch/mips/config.in linux-2.4.5-nc/arch/mips/config.in
--- linux-2.4.5/arch/mips/config.in	Tue May 29 17:55:37 2001
+++ linux-2.4.5-nc/arch/mips/config.in	Tue May 29 18:43:56 2001
@@ -180,6 +180,11 @@
 #	bool ' Access.Bus support' CONFIG_ACCESSBUS
 #    fi
 fi
+
+if [ "$CONFIG_SYSCTL" = "y" ]; then
+   bool '  Disable the PC-Speaker' CONFIG_DISABLE_PC_SPEAKER
+fi
+
 endmenu
 
 if [ "$CONFIG_ISA" = "y" ]; then
diff -u --recursive linux-2.4.5/arch/mips64/config.in linux-2.4.5-nc/arch/mips64/config.in
--- linux-2.4.5/arch/mips64/config.in	Tue May 29 17:55:38 2001
+++ linux-2.4.5-nc/arch/mips64/config.in	Tue May 29 18:44:27 2001
@@ -113,6 +113,10 @@
 fi
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
+if [ "$CONFIG_SYSCTL" = "y" ]; then
+   bool '  Disable the PC-Speaker' CONFIG_DISABLE_PC_SPEAKER
+fi
+
 endmenu
 
 mainmenu_option next_comment
diff -u --recursive linux-2.4.5/arch/sh/config.in linux-2.4.5-nc/arch/sh/config.in
--- linux-2.4.5/arch/sh/config.in	Tue May 29 17:55:38 2001
+++ linux-2.4.5-nc/arch/sh/config.in	Tue May 29 18:50:45 2001
@@ -141,6 +141,10 @@
 
 source drivers/parport/Config.in
 
+if [ "$CONFIG_SYSCTL" = "y" ]; then
+   bool '  Disable the PC-Speaker' CONFIG_DISABLE_PC_SPEAKER
+fi
+
 endmenu
 
 source drivers/mtd/Config.in
diff -u --recursive linux-2.4.5/drivers/char/vt.c linux-2.4.5-nc/drivers/char/vt.c
--- linux-2.4.5/drivers/char/vt.c	Fri Feb  9 20:30:22 2001
+++ linux-2.4.5-nc/drivers/char/vt.c	Wed May  9 23:47:36 2001
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
diff -u --recursive linux-2.4.5/include/linux/sysctl.h linux-2.4.5-nc/include/linux/sysctl.h
--- linux-2.4.5/include/linux/sysctl.h	Tue May 29 17:56:29 2001
+++ linux-2.4.5-nc/include/linux/sysctl.h	Mon May 28 19:24:08 2001
@@ -118,7 +118,8 @@
 	KERN_SHMPATH=48,	/* string: path to shm fs */
 	KERN_HOTPLUG=49,	/* string: path to hotplug policy agent */
 	KERN_IEEE_EMULATION_WARNINGS=50, /* int: unimplemented ieee instructions */
-	KERN_S390_USER_DEBUG_LOGGING=51  /* int: dumps of user faults */
+	KERN_S390_USER_DEBUG_LOGGING=51,  /* int: dumps of user faults */
+	KERN_DISABLE_PC_SPEAKER=52 /* int: speaker on or off */
 };
 
 
diff -u --recursive linux-2.4.5/kernel/sys.c linux-2.4.5-nc/kernel/sys.c
--- linux-2.4.5/kernel/sys.c	Tue May 29 17:55:59 2001
+++ linux-2.4.5-nc/kernel/sys.c	Wed May  9 23:45:26 2001
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
diff -u --recursive linux-2.4.5/kernel/sysctl.c linux-2.4.5-nc/kernel/sysctl.c
--- linux-2.4.5/kernel/sysctl.c	Tue May 29 17:55:59 2001
+++ linux-2.4.5-nc/kernel/sysctl.c	Wed May  9 23:44:30 2001
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


--------------98D16A434A8C0FAC87A59F77--

