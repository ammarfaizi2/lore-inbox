Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313242AbSDJPjC>; Wed, 10 Apr 2002 11:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313243AbSDJPjB>; Wed, 10 Apr 2002 11:39:01 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:14607 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S313242AbSDJPi7>;
	Wed, 10 Apr 2002 11:38:59 -0400
Date: Wed, 10 Apr 2002 17:38:58 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Reducing root filesystem
Message-ID: <20020410153858.GA8136@lug-owl.de>
Mail-Followup-To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <7CFD7CA8510CD6118F950002A519EA3001067D06@leonoid.in.ishoni.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-04-10 19:38:09 +0530, Amol Kumar Lad <amolk@ishoni.com>
wrote in message <7CFD7CA8510CD6118F950002A519EA3001067D06@leonoid.in.ishon=
i.com>:
> Hi,
>   I am porting Linux to an embedded system. Currently my rootfilesystem is
> around 2.5 MB (after keeping it to minimal and adding tools like busybox)=
. I
> want to furthur reduce it to say maximum of 1.5 MB.=20
> Please suggest some link/references where I can find the details to optim=
ise
> my root filesystem

I really can't help you with the root filesystem, but you can do sth
like this:


diff -Nur test-remove-me/linux-2.2.19-clean/Documentation/Configure.help li=
nux-schlecker-2.2.19/Documentation/Configure.help
--- test-remove-me/linux-2.2.19-clean/Documentation/Configure.help	Sun Mar =
25 18:37:29 2001
+++ linux-schlecker-2.2.19/Documentation/Configure.help	Mon Nov  5 12:42:46=
 2001
@@ -4942,6 +4942,14 @@
   important data. This is primarily of use to people trying to debug
   the middle and upper layers of the SCSI subsystem. If unsure, say N.
=20
+Smaller kernel by omitting most messages
+CONFIG_NO_PRINTK
+  Enabling this option will result in a smaller kernel by removing
+  most text strings. This is only useful for emdedded systems where
+  you've got to live with <=3D 4MB of RAM. I386-only for now...
+
+  If unsure, say no.
+
 Fibre Channel support
 CONFIG_FC4
   This is an experimental support for storage arrays connected to
@@ -210,5 +221,6 @@
=20
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Eleminate *most* printk()s' CONFIG_NO_PRINTK
 endmenu
=20
diff -Nur test-remove-me/linux-2.2.19-clean/arch/i386/kernel/head.S linux-s=
chlecker-2.2.19/arch/i386/kernel/head.S
--- test-remove-me/linux-2.2.19-clean/arch/i386/kernel/head.S	Sun Mar 25 18=
:31:45 2001
+++ linux-schlecker-2.2.19/arch/i386/kernel/head.S	Fri Nov  2 11:21:42 2001
@@ -315,7 +315,7 @@
 	movl %ax,%ds
 	movl %ax,%es
 	pushl $int_msg
-	call SYMBOL_NAME(printk)
+	call SYMBOL_NAME(real_printk)
 	popl %eax
 	popl %ds
 	popl %es
diff -Nur test-remove-me/linux-2.2.19-clean/include/asm-i386/system.h linux=
-schlecker-2.2.19/include/asm-i386/system.h
--- test-remove-me/linux-2.2.19-clean/include/asm-i386/system.h	Sun Mar 25 =
18:31:05 2001
+++ linux-schlecker-2.2.19/include/asm-i386/system.h	Mon Dec 17 14:32:03 20=
01
@@ -135,21 +135,15 @@
 	switch (size) {
 		case 1:
 			__asm__("xchgb %b0,%1"
-				:"=3Dq" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
+					:"+q" (x),"=3Dm" (*__xg(ptr)));
 			break;
 		case 2:
 			__asm__("xchgw %w0,%1"
-				:"=3Dr" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
+					:"+r" (x),"=3Dm" (*__xg(ptr)));
 			break;
 		case 4:
 			__asm__("xchgl %0,%1"
-				:"=3Dr" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
+					:"+r" (x), "=3Dm" (*__xg(ptr)));
 			break;
 	}
 	return x;
diff -Nur test-remove-me/linux-2.2.19-clean/include/linux/kernel.h linux-sc=
hlecker-2.2.19/include/linux/kernel.h
--- test-remove-me/linux-2.2.19-clean/include/linux/kernel.h	Sun Mar 25 18:=
31:03 2001
+++ linux-schlecker-2.2.19/include/linux/kernel.h	Fri Dec 14 14:53:14 2001
@@ -9,6 +9,7 @@
=20
 #include <stdarg.h>
 #include <linux/linkage.h>
+#include <linux/config.h>
=20
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
@@ -54,8 +55,16 @@
=20
 extern int session_of_pgrp(int pgrp);
=20
-asmlinkage int printk(const char * fmt, ...)
+asmlinkage int real_printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+
+#ifdef CONFIG_NO_PRINTK
+#	define printk(format, arg...) do {} while(0)
+#else
+#	define printk(format, arg...) real_printk(format, ## arg)
+#endif /* CONFIG_NO_PRINTK */
+
+#define oops_printk(format, arg...) real_printk(format, ## arg)
=20
 #if DEBUG
 #define pr_debug(fmt,arg...) \
diff -Nur test-remove-me/linux-2.2.19-clean/kernel/ksyms.c linux-schlecker-=
2.2.19/kernel/ksyms.c
--- test-remove-me/linux-2.2.19-clean/kernel/ksyms.c	Sun Mar 25 18:31:02 20=
01
+++ linux-schlecker-2.2.19/kernel/ksyms.c	Fri Dec 14 15:24:52 2001
@@ -357,7 +357,7 @@
=20
 /* misc */
 EXPORT_SYMBOL(panic);
-EXPORT_SYMBOL(printk);
+EXPORT_SYMBOL(real_printk);
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(vsprintf);
 EXPORT_SYMBOL(kdevname);
diff -Nur test-remove-me/linux-2.2.19-clean/kernel/printk.c linux-schlecker=
-2.2.19/kernel/printk.c
--- test-remove-me/linux-2.2.19-clean/kernel/printk.c	Sun Mar 25 18:31:02 2=
001
+++ linux-schlecker-2.2.19/kernel/printk.c	Fri Dec 14 14:52:50 2001
@@ -249,7 +249,7 @@
 	return do_syslog(type, buf, len);
 }
=20
-asmlinkage int printk(const char *fmt, ...)
+asmlinkage int real_printk(const char *fmt, ...)
 {
 	va_list args;
 	int i;




This is for i386, but it can be implemented like this for other
architectures. Please note:

	- The patch to system.h is only neccessary because gcc will
	  magically miscompile the code if there's no printk()
	  resulting (at least) in a broken DMA (de)registering
	  functions rendering the floppy.o module useless. Maybe
	  you don't need this patch. It was _not_ developed by
	  me but send by Momchil Velikov <velco@fadata.bg>.
	- In 2.4.x, EXPORT_SYMBOL((real)printk) is not in
	  kernel/ksyms.c, but in kernel/printk.c
	- BigFatWarning: It shouldn't be, but there might
	  be code fragments that do more than only printing
	  in a printk call (like 'printk(KERN_ERR "%d\n", a=3Dfunc(a))')
	  Things like this _will_ break!!!

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjy0XJEACgkQHb1edYOZ4bsxSgCfew49G/g0HVRGWcZj26NVj5lo
Kp0AnA8HcLeIsPJzyEIebMgAUhvPxrU0
=AGw6
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
