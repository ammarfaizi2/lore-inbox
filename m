Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbTIEJWl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 05:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTIEJWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 05:22:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13836 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262420AbTIEJWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 05:22:36 -0400
Date: Fri, 5 Sep 2003 10:22:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Move MODULE_ALIAS_LDISC to tty_ldisc.h
Message-ID: <20030905102231.D27623@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to build bk-curr from yesterday, I encounter the following:

  CC      drivers/input/serio/serport.o
drivers/input/serio/serport.c:27: parse error before numeric constant
drivers/input/serio/serport.c:27: warning: type defaults to `int' in declaration of `MODULE_ALIAS_LDISC'
drivers/input/serio/serport.c:27: warning: function declaration isn't a prototype
drivers/input/serio/serport.c:27: warning: data definition has no type or storage class

This seems to be defined in asm-i386/termios.h:

#define MODULE_ALIAS_LDISC(ldisc) \
        MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))

Why is this defined in the per-architecture asm/ header files rather
than the linux/ header files?  It surely can't be something which is
architecture specific.

Here's a patch which moves it to a more sensible location:

===== include/linux/tty_ldisc.h 1.3 vs edited =====
--- 1.3/include/linux/tty_ldisc.h	Wed Feb 19 02:59:04 2003
+++ edited/include/linux/tty_ldisc.h	Fri Sep  5 10:02:02 2003
@@ -138,4 +138,7 @@
 
 #define LDISC_FLAG_DEFINED	0x00000001
 
+#define MODULE_ALIAS_LDISC(ldisc) \
+	MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))
+
 #endif /* _LINUX_TTY_LDISC_H */
===== include/asm-i386/termios.h 1.4 vs edited =====
--- 1.4/include/asm-i386/termios.h	Thu Sep  4 07:40:16 2003
+++ edited/include/asm-i386/termios.h	Fri Sep  5 10:02:02 2003
@@ -102,8 +102,6 @@
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
 
-#define MODULE_ALIAS_LDISC(ldisc) \
-	MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))
 #endif	/* __KERNEL__ */
 
 #endif	/* _I386_TERMIOS_H */
===== include/asm-sparc/termios.h 1.6 vs edited =====
--- 1.6/include/asm-sparc/termios.h	Thu Sep  4 12:16:09 2003
+++ edited/include/asm-sparc/termios.h	Fri Sep  5 10:03:14 2003
@@ -169,9 +169,6 @@
 	0; \
 })
 
-#define MODULE_ALIAS_LDISC(ldisc) \
-	MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))
-
 #endif	/* __KERNEL__ */
 
 #endif /* _SPARC_TERMIOS_H */
===== include/asm-sparc64/termios.h 1.6 vs edited =====
--- 1.6/include/asm-sparc64/termios.h	Thu Sep  4 12:16:09 2003
+++ edited/include/asm-sparc64/termios.h	Fri Sep  5 10:03:14 2003
@@ -168,9 +168,6 @@
 	0; \
 })
 
-#define MODULE_ALIAS_LDISC(ldisc) \
-	MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))
-
 #endif	/* __KERNEL__ */
 
 #endif /* _SPARC64_TERMIOS_H */


-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core


