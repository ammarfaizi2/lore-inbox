Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275758AbRJBCCR>; Mon, 1 Oct 2001 22:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275770AbRJBCCJ>; Mon, 1 Oct 2001 22:02:09 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:53818 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S275758AbRJBCBv>; Mon, 1 Oct 2001 22:01:51 -0400
Subject: Re: [PATCH] Intel 830 support for agpgart
From: Robert Love <rml@tech9.net>
To: Christof Efkemann <efkemann@uni-bremen.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011002033227.6e047544.efkemann@uni-bremen.de>
In-Reply-To: <20011002033227.6e047544.efkemann@uni-bremen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.30.08.08 (Preview Release)
Date: 01 Oct 2001 22:02:08 -0400
Message-Id: <1001988137.2780.53.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-10-01 at 21:32, Christof Efkemann wrote:

> this patch for 2.4.10 adds support for the Intel i830 chipset to the agpgart
> module, thus eliminating the need for "agp_try_unsupported" with this chip.
> It seems to work fine on my Siemens Fujitsu notebook which has an ATI Radeon
> Mobility M6 graphics chip.
> I guess it should work for others too, maybe someone could try.

You don't need all that code.  If agp_try_unsupported works, then
intel_generic_setup works, so you don't need an intel_830_setup.

In other words, if agp_try_unsupported=1 makes everything OK, then you
just need to add the detection code.

Thus, the patch becomes the following.  Give that a try.


diff -ur linux-2.4.10.orig/drivers/char/Config.in linux/drivers/char/Config.in
--- linux-2.4.10.orig/drivers/char/Config.in    Sun Sep 23 18:52:38 2001
+++ linux/drivers/char/Config.in        Tue Oct  2 01:00:37 2001
@@ -205,7 +205,7 @@

dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
if [ "$CONFIG_AGP" != "n" ]; then
-   bool '  Intel 440LX/BX/GX and I815/I840/I850 support' CONFIG_AGP_INTEL
+   bool '  Intel 440LX/BX/GX and I815/I830/I840/I850 support' CONFIG_AGP_INTEL
    bool '  Intel I810/I815 (on-board) support' CONFIG_AGP_I810
    bool '  VIA chipset support' CONFIG_AGP_VIA
    bool '  AMD Irongate, 761, and 762 support' CONFIG_AGP_AMD
diff -ur linux-2.4.10.orig/drivers/char/agp/agp.h linux/drivers/char/agp/agp.h
--- linux-2.4.10.orig/drivers/char/agp/agp.h    Sun Sep 23 18:52:38 2001
+++ linux/drivers/char/agp/agp.h        Tue Oct  2 01:01:31 2001
@@ -166,6 +166,9 @@
#ifndef PCI_DEVICE_ID_INTEL_810_0
#define PCI_DEVICE_ID_INTEL_810_0       0x7120
#endif
+#ifndef PCI_DEVICE_ID_INTEL_830_0
+#define PCI_DEVICE_ID_INTEL_830_0      0x3575
+#endif
#ifndef PCI_DEVICE_ID_INTEL_840_0
#define PCI_DEVICE_ID_INTEL_840_0              0x1a21
#endif
diff -ur linux-2.4.10.orig/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- linux-2.4.10.orig/drivers/char/agp/agpgart_be.c     Sun Sep 23 18:52:38 2001
+++ linux/drivers/char/agp/agpgart_be.c Tue Oct  2 01:05:01 2001
@@ -387,7 +387,7 @@
/* 
  * Driver routines - start
  * Currently this module supports the following chipsets:
- * i810, i815, 440lx, 440bx, 440gx, i840, i850, via vp3, via mvp3,
+ * i810, i815, 440lx, 440bx, 440gx, i830, i840, i850, via vp3, via mvp3,
  * via kx133, via kt133, amd irongate, amd 761, amd 762, ALi M1541,
  * and generic support for the SiS chipsets.
  */
@@ -2976,6 +3041,12 @@
                "Intel",
                "i815",
                intel_generic_setup },
+       { PCI_DEVICE_ID_INTEL_830_0,
+               PCI_VENDOR_ID_INTEL,
+               INTEL_I830,
+               "Intel",
+               "i830",
+               intel_generic_setup },
        { PCI_DEVICE_ID_INTEL_840_0,
                PCI_VENDOR_ID_INTEL,
                INTEL_I840,
diff -ur linux-2.4.10.orig/include/linux/agp_backend.h linux/include/linux/agp_backend.h
--- linux-2.4.10.orig/include/linux/agp_backend.h       Sun Sep 23 18:52:38 2001
+++ linux/include/linux/agp_backend.h   Tue Oct  2 01:00:37 2001
@@ -46,6 +46,7 @@
        INTEL_GX,
        INTEL_I810,
        INTEL_I815,
+       INTEL_I830,
        INTEL_I840,
        INTEL_I850,
        VIA_GENERIC,




-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

