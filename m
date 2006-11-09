Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965940AbWKIAhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965940AbWKIAhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 19:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965935AbWKIAhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 19:37:37 -0500
Received: from web25221.mail.ukl.yahoo.com ([217.146.176.207]:15038 "HELO
	web25221.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161777AbWKIAhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 19:37:37 -0500
Message-ID: <20061109003735.76755.qmail@web25221.mail.ukl.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=kJce9ESygJ4H9lhlnK8wrHL79ZtYyRaFDZHjN3FNj0QQNMm3O8KYuUgMCHR7x2Ek9kP8qpIsc6PYjeKe8D2JcRLrp4VhL1hQl8YltJ3QwXbh9vzWz5JhsO8jyd4F/nBZDgNrmXEufRg45H+pSIjui+xrFcDTSrodxkuwxsLK2Cw=;
X-YMail-OSG: Vr6ShNAVM1lIMA6sXPuGS0u0kIVCY9_8I3Cx.67Q282G5w2dJNT74McFa4gzGdPxnN5lSruvyLm5G71ccpSdlK2w8jAOtfx.xmgTTv_IkeWuKtKl3o.ZEHloS6BYUB.M.YiQYR3H
Date: Thu, 9 Nov 2006 01:37:35 +0100 (CET)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: slow UML on x86-64, soft lockups
To: Jeff Garzik <jeff@garzik.org>, Jeff Dike <jdike@addtoit.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4550FFFB.3000602@garzik.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-633010229-1163032655=:73868"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-633010229-1163032655=:73868
Content-Type: text/plain; charset=iso-8859-1
Content-Id: 
Content-Disposition: inline

Jeff Garzik <jeff@garzik.org> ha scritto:

> Recent 2.6.18 / 2.6.19-rc kernels run at the expected speed, on
> 32-bit 
> x86, with a Fedora Core 5 or 6 UML userland.  However, on 64-bit
> x86-64 
> with a 64-bit UML userland, the kernel is achingly slow.  It works,
> 
> but...  Login takes several minutes (via ssh from host or xterm 
> console), and soft lockup traces continually print to the screen
> (see 
> output below).  Once logged into, programs work, but again, very
> slowly. 
>   Commands which complete in under a second normally often takes
> minutes.
> 

> Any ideas?  I guess there is a bug in the 64-bit UML timer code?
Yes, there is. Jeff, after our discussion, did I send you the patch
for this (not sure whether tested, I haven't reproduced this bug yet,
but fairly obvious)?

It is attached but I'm answering from a webmail (it happens since I'm
so busy), so I decline responsibility for any MIME content (I'm
sorry, yes).

__________________________________________________
Do You Yahoo!?
Poco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da tanto spazio gratuito per i tuoi file e i messaggi 
http://mail.yahoo.it 
--0-633010229-1163032655=:73868
Content-Type: text/plain; name="fix-udelay.diff"
Content-Description: 2991312419-fix-udelay.diff
Content-Disposition: inline; filename="fix-udelay.diff"

Index: linux-2.6.git/arch/um/sys-i386/delay.c
===================================================================
--- linux-2.6.git.orig/arch/um/sys-i386/delay.c
+++ linux-2.6.git/arch/um/sys-i386/delay.c
@@ -27,14 +27,3 @@ void __udelay(unsigned long usecs)
 }
 
 EXPORT_SYMBOL(__udelay);
-
-void __const_udelay(unsigned long usecs)
-{
-	int i, n;
-
-	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-        for(i=0;i<n;i++)
-                cpu_relax();
-}
-
-EXPORT_SYMBOL(__const_udelay);
Index: linux-2.6.git/arch/um/sys-x86_64/delay.c
===================================================================
--- linux-2.6.git.orig/arch/um/sys-x86_64/delay.c
+++ linux-2.6.git/arch/um/sys-x86_64/delay.c
@@ -28,14 +28,3 @@ void __udelay(unsigned long usecs)
 }
 
 EXPORT_SYMBOL(__udelay);
-
-void __const_udelay(unsigned long usecs)
-{
-	unsigned long i, n;
-
-	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-        for(i=0;i<n;i++)
-                cpu_relax();
-}
-
-EXPORT_SYMBOL(__const_udelay);
Index: linux-2.6.git/include/asm-um/delay.h
===================================================================
--- linux-2.6.git.orig/include/asm-um/delay.h
+++ linux-2.6.git/include/asm-um/delay.h
@@ -1,9 +1,20 @@
 #ifndef __UM_DELAY_H
 #define __UM_DELAY_H
 
-#include "asm/arch/delay.h"
-#include "asm/archparam.h"
-
 #define MILLION 1000000
 
+/* Undefined on purpose */
+extern void __bad_udelay(void);
+extern void __bad_ndelay(void);
+
+extern void __udelay(unsigned long usecs);
+extern void __const_udelay(unsigned long usecs);
+extern void __delay(unsigned long loops);
+
+#define udelay(n) ((__builtin_constant_p(n) && (n) > 20000) ? \
+	__bad_udelay() : __udelay(n))
+
+/* It appears that ndelay is not used at all for UML. */
+#define ndelay(n) __bad_ndelay()
+
 #endif

--0-633010229-1163032655=:73868--
