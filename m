Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUDSUC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUDSUC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:02:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:12210 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261815AbUDSUCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:02:24 -0400
Date: Mon, 19 Apr 2004 12:56:47 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Roman Medina <roman@rs-labs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.26 doesn't compile? ("error: `__cmpxchg' previously defined
 here")
Message-Id: <20040419125647.2b19e83e.rddunlap@osdl.org>
In-Reply-To: <lq8880hq37q1b4ffpmn7idvj8gcqps5iqo@4ax.com>
References: <31145.194.224.100.28.1082362588.squirrel@194.224.100.28>
	<20040419102710.06bcdf9a.rddunlap@osdl.org>
	<lq8880hq37q1b4ffpmn7idvj8gcqps5iqo@4ax.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004 21:09:19 +0200 Roman Medina wrote:

| On Mon, 19 Apr 2004 10:27:10 -0700, you wrote:
| 
| >| make[3]: Entering directory `/usr/src/linux-2.4.26/drivers/char/drm'
| >| gcc -D__KERNEL__ -I/usr/src/linux-2.4.26/include -Wall -Wstrict-prototypes
| >| -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
| >| -pipe -mpreferred-stack-boundary=2 -march=i386 -DMODULE -DMODVERSIONS
| >| -include /usr/src/linux-2.4.26/include/linux/modversions.h  -nostdinc
| >| -iwithprefix include -DKBUILD_BASENAME=gamma_drv  -c -o gamma_drv.o
| >| gamma_drv.c
| >| In file included from gamma_drv.c:34:
| >| drmP.h:180: error: redefinition of `__cmpxchg'
| >| /usr/src/linux-2.4.26/include/asm/system.h:245: error: `__cmpxchg'
| >| previously defined here
| >| make[3]: *** [gamma_drv.o] Error 1
| >| make[3]: Leaving directory `/usr/src/linux-2.4.26/drivers/char/drm'
| >| make[2]: *** [_modsubdir_drm] Error 2
| >| make[2]: Leaving directory `/usr/src/linux-2.4.26/drivers/char'
| >| make[1]: *** [_modsubdir_char] Error 2
| >| make[1]: Leaving directory `/usr/src/linux-2.4.26/drivers'
| >| make: *** [_mod_drivers] Error 2
| >| 
| >| Any ideas?
| >
| >Sure, build for more than CONFIG_M386=y.
| >I.e., build for a Pentium III etc. and it should work.
| 
| Thanks a lot, Randy. It worked :-) But I'm wondering why the same
| config compiled perfectly on 2.4.25 and backwards. Which changes
| affect this issue?

That would be this changeset:
http://linux.bkbits.net:8080/linux-2.4/diffs/include/asm-i386/system.h@1.16?nav=index.html|src/|src/include|src/include/asm-i386|hist/include/asm-i386/system.h


This patch (below) works for me with your original i386 .config file.

--
~Randy


// linux-2.4.26
// drmP.h doesn't need local cmpxchg() and __cmpxchg();


diffstat:=
 drivers/char/drm/drmP.h |   34 ++--------------------------------
 1 files changed, 2 insertions(+), 32 deletions(-)


diff -Naurp ./drivers/char/drm/drmP.h~cmpxchg_notlocal ./drivers/char/drm/drmP.h
--- ./drivers/char/drm/drmP.h~cmpxchg_notlocal	2004-04-19 11:07:10.000000000 -0700
+++ ./drivers/char/drm/drmP.h	2004-04-19 13:02:55.000000000 -0700
@@ -52,6 +52,7 @@
 #include <linux/version.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>	/* For (un)lock_kernel */
+#include <linux/system.h>	/* for cmpxchg() */
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #if defined(__alpha__) || defined(__powerpc__)
@@ -174,38 +175,7 @@ __cmpxchg(volatile void *ptr, unsigned l
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
-#elif __i386__
-static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
-				      unsigned long new, int size)
-{
-	unsigned long prev;
-	switch (size) {
-	case 1:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 2:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 4:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	}
-	return old;
-}
-
-#define cmpxchg(ptr,o,n)						\
-  ((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),		\
-				 (unsigned long)(n),sizeof(*(ptr))))
-#endif /* i386 & alpha */
+#endif /* alpha */
 #endif
 #define __REALLY_HAVE_SG	(__HAVE_SG)
 
