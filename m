Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbTBVDfR>; Fri, 21 Feb 2003 22:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267787AbTBVDfR>; Fri, 21 Feb 2003 22:35:17 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:12504 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S266323AbTBVDfQ>; Fri, 21 Feb 2003 22:35:16 -0500
Message-ID: <3E56F23F.5010808@quark.didntduck.org>
Date: Fri, 21 Feb 2003 22:45:03 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Better test for GCC alignment options
Content-Type: multipart/mixed;
 boundary="------------030303090301010302030502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030303090301010302030502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Do the test for -falign-xxx vs. -malign-xxx only once.

--
				Brian Gerst

--------------030303090301010302030502
Content-Type: text/plain;
 name="gcc-align-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc-align-1"

diff -urN linux-2.5.62-bk8/arch/i386/Makefile linux/arch/i386/Makefile
--- linux-2.5.62-bk8/arch/i386/Makefile	2003-02-21 20:45:05.000000000 -0500
+++ linux/arch/i386/Makefile	2003-02-21 22:34:09.000000000 -0500
@@ -27,6 +27,8 @@
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)
 
+align := $(subst -functions=0,,$(call check_gcc,-falign-functions=0,-malign-functions=0))
+
 cflags-$(CONFIG_M386)		+= -march=i386
 cflags-$(CONFIG_M486)		+= -march=i486
 cflags-$(CONFIG_M586)		+= -march=i586
@@ -37,15 +39,13 @@
 cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
 cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
 cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
-cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686 -malign-functions=4)
-cflags-$(CONFIG_MK8)		+= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 -malign-functions=4))
-cflags-$(CONFIG_MCRUSOE)	+= -march=i686
-cflags-$(CONFIG_MCRUSOE)	+= $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
+cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4)
+cflags-$(CONFIG_MK8)		+= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
+cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call check_gcc,-march=winchip-c6,-march=i586)
 cflags-$(CONFIG_MWINCHIP2)	+= $(call check_gcc,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MWINCHIP3D)	+= -march=i586
-cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486)
-cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
+cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)
 
 CFLAGS += $(cflags-y)

--------------030303090301010302030502--

