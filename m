Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261450AbSJIH7M>; Wed, 9 Oct 2002 03:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSJIH7L>; Wed, 9 Oct 2002 03:59:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13835 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261450AbSJIH7K>; Wed, 9 Oct 2002 03:59:10 -0400
Date: Wed, 9 Oct 2002 09:04:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?Nicol=E1s_Lichtmaier?= <nick@technisys.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 does not build: 8250.c: icount has incomplete type.
Message-ID: <20021009090444.A18753@flint.arm.linux.org.uk>
References: <3DA3DFE5.5060507@technisys.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA3DFE5.5060507@technisys.com.ar>; from nick@technisys.com.ar on Wed, Oct 09, 2002 at 04:51:01AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 04:51:01AM -0300, Nicolás Lichtmaier wrote:
>     gcc -Wp,-MD,drivers/serial/.8250.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
> -DMODULE   -DKBUILD_BASENAME=8250 -DEXPORT_SYMTAB  -c -o
> drivers/serial/8250.o drivers/serial/8250.c
> In file included from drivers/serial/8250.c:34:
> include/linux/serialP.h:50: field `icount' has incomplete type
> make[3]: *** [drivers/serial/8250.o] Error 1
> make[2]: *** [drivers/serial] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory `/home/nick/soft/linux-2.5.41'
> make: *** [stamp-build] Error 2

This should fix it.  Committing and sending this patch is currently
waiting on Hu Gang to confirm that the second hunk fixes his problem.

I'm working towards getting rid of serialP.h in 8250.c; its been the
cause of several problems that have configuration-specific thus far.
We really shouldn't need anything from that header.

===== drivers/serial/8250.c 1.13 vs edited =====
--- 1.13/drivers/serial/8250.c	Sun Oct  6 00:01:53 2002
+++ edited/drivers/serial/8250.c	Wed Oct  9 09:00:53 2002
@@ -31,8 +31,8 @@
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/serial_reg.h>
-#include <linux/serialP.h>
 #include <linux/serial.h>
+#include <linux/serialP.h>
 #include <linux/delay.h>
 
 #include <asm/io.h>
@@ -1635,7 +1635,7 @@
 	if (up->port.type != PORT_RSA && res_rsa)
 		release_resource(res_rsa);
 
-	if (up->port.type == PORT_UNKNOWN)
+	if (up->port.type == PORT_UNKNOWN && res_std)
 		release_resource(res_std);
 }
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

