Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135210AbREESMM>; Sat, 5 May 2001 14:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135213AbREESMC>; Sat, 5 May 2001 14:12:02 -0400
Received: from s02.hamberger.co.at ([193.83.64.20]:33030 "EHLO
	khan.hamberger.loc") by vger.kernel.org with ESMTP
	id <S135210AbREESLy>; Sat, 5 May 2001 14:11:54 -0400
Message-ID: <3AF441C2.1E3A4D9C@tcp-ip.at>
Date: Sat, 05 May 2001 20:09:06 +0200
From: Thomas Warwaris <war@tcp-ip.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Restrict VT-Switching per VT
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

this patch on 2.4.4 adds the ability to turn VT-switching
on and off for each (existing) VT via ioctl().

It works exactly like the existing code by blocking
VT-switching to the blocked terminals.

It is a very nice feature to 'hide' VT's of users
allowing others to work with other VT's on the same
machine.

I am not on the kernel list. Pleas CC me followups
to war@tcp-ip.at

BTW: Thank you all for your work.

Thomas

diff -urN -X dontdiff linux-2.4.4.ori/include/linux/vt.h linux/include/linux/vt.h
--- linux-2.4.4.ori/include/linux/vt.h	Sat May  5 20:46:51 2001
+++ linux/include/linux/vt.h	Sat May  5 21:33:26 2001
@@ -50,5 +50,7 @@
 #define VT_RESIZEX      0x560A  /* set kernel's idea of screensize + more */
 #define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
 #define VT_UNLOCKSWITCH 0x560C  /* allow vt switching */
+#define VT_LOCKSWITCHTO 	0x560D  /* disallow vt switching to a vt*/
+#define VT_UNLOCKSWITCHTO 	0x560E  /* allow vt switching to a vt*/
 
 #endif /* _LINUX_VT_H */
diff -urN -X dontdiff linux-2.4.4.ori/drivers/char/vt.c linux/drivers/char/vt.c
--- linux-2.4.4.ori/drivers/char/vt.c	Fri Feb  9 20:30:22 2001
+++ linux/drivers/char/vt.c	Sat May  5 21:33:44 2001
@@ -7,6 +7,7 @@
  *  Dynamic keymap and string allocation - aeb@cwi.nl - May 1994
  *  Restrict VT switching via ioctl() - grif@cs.ucr.edu - Dec 1995
  *  Some code moved for less code duplication - Andi Kleen - Mar 1997
+ *  Restrict VT switching per VT - Thomas Warwaris - May 2001
  */
 
 #include <linux/config.h>
@@ -41,6 +42,7 @@
 #endif /* CONFIG_FB_COMPAT_XPMAC */
 
 char vt_dont_switch;
+char vt_dont_switch_to [MAX_NR_CONSOLES];
 extern struct tty_driver console_driver;
 
 #define VT_IS_IN_USE(i)	(console_driver.table[i] && console_driver.table[i]->count)
@@ -1047,6 +1049,16 @@
 		   return -EPERM;
 		vt_dont_switch = 0;
 		return 0;
+	case VT_LOCKSWITCHTO:
+		if (!suser())
+			return -EPERM;
+		vt_dont_switch_to[arg-1] = 1;
+		return 0;
+	case VT_UNLOCKSWITCHTO:
+		if (!suser())
+			return -EPERM;
+		vt_dont_switch_to[arg-1] = 0;
+		return 0;
 #ifdef CONFIG_FB_COMPAT_XPMAC
 	case VC_GETMODE:
 		{
@@ -1243,6 +1255,8 @@
 void change_console(unsigned int new_console)
 {
         if ((new_console == fg_console) || (vt_dont_switch))
+                return;
+        if ( vt_dont_switch_to[new_console] )
                 return;
         if (!vc_cons_allocated(new_console))
 		return;
