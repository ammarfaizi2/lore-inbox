Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287472AbSALVEc>; Sat, 12 Jan 2002 16:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287488AbSALVEQ>; Sat, 12 Jan 2002 16:04:16 -0500
Received: from dsl027-137-030.nyc1.dsl.speakeasy.net ([216.27.137.30]:41519
	"EHLO perl") by vger.kernel.org with ESMTP id <S287472AbSALVDw>;
	Sat, 12 Jan 2002 16:03:52 -0500
Date: Sat, 12 Jan 2002 21:03:51 +0000
To: linux-kernel@vger.kernel.org
Cc: xsdg@localhost.kernel.org
Subject: kernel 2.5.2-pre11 -- `rd_image_start' undeclared (PATCH)
Message-ID: <20020112210351.A653@216.254.117.126>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: xsdg <xsdg@openprojects.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In kernels 2.5.1 and 2.5.2-pre11, I encountered the error

make CFLAGS="-D__KERNEL__ -I/usr/src/11pre-2.5.2k/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  " -C  arch/i386/kernel
make[1]: Entering directory `/usr/src/11pre-2.5.2k/arch/i386/kernel'
gcc -D__KERNEL__ -I/usr/src/11pre-2.5.2k/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c -o setup.o setup.c
setup.c: In function `setup_arch':
setup.c:682: `rd_image_start' undeclared (first use in this function)
setup.c:682: (Each undeclared identifier is reported only once
setup.c:682: for each function it appears in.)
setup.c:683: `rd_prompt' undeclared (first use in this function)
setup.c:684: `rd_doload' undeclared (first use in this function)
make[1]: *** [setup.o] Error 1
make[1]: Leaving directory `/usr/src/11pre-2.5.2k/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

when make'ing bzImage with ramdisks enabled, but initrd disabled.  The attached
patch fixes that problem (by ungrouping ramdisk-related and initrd-enabled
variables in include/linux/blk.h).

	--xsdg
-- 
|---------------------------------------------------|
| Time flies like the wind, fruit flies like        |
|   bananas.                                        |
|---------------------------------------------------|
| http://xsdg.hypermart.net   xsdg@openprojects.net |
|---------------------------------------------------|

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="blk.h.patch"

--- include/linux/blk.h.orig	Sat Jan 12 17:38:39 2002
+++ include/linux/blk.h	Sat Jan 12 17:24:35 2002
@@ -22,12 +22,18 @@
 
 extern unsigned long initrd_start,initrd_end;
 extern int initrd_below_start_ok; /* 1 if it is not an error if initrd_start < memory_start */
+void initrd_init(void);
+
+#endif
+
+#ifdef CONFIG_BLK_DEV_RAM
+
 extern int rd_doload;		/* 1 = load ramdisk, 0 = don't load */
 extern int rd_prompt;		/* 1 = prompt for ramdisk, 0 = don't prompt */
 extern int rd_image_start;	/* starting block # of image */
-void initrd_init(void);
 
 #endif
+
 /*
  * end_request() and friends. Must be called with the request queue spinlock
  * acquired. All functions called within end_request() _must_be_ atomic.

--azLHFNyN32YCQGCU--
