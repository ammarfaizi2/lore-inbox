Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbSJ3Doq>; Tue, 29 Oct 2002 22:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSJ3Doq>; Tue, 29 Oct 2002 22:44:46 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:40346 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S262107AbSJ3Dop>; Tue, 29 Oct 2002 22:44:45 -0500
Message-ID: <3DBF572D.1030801@quark.didntduck.org>
Date: Tue, 29 Oct 2002 22:51:09 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] factor common GCC options check
References: <3DBF4ED4.3060203@quark.didntduck.org> <3DBF51B7.5070906@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------090306000609090303070206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090306000609090303070206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Revised patch:
Make the test for supported GCC options into a macro, and add new checks 
for -march={winchip-c6,winchip2,c3}.

--
				Brian Gerst

--------------090306000609090303070206
Content-Type: text/plain;
 name="checkgcc-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="checkgcc-2"

diff -urN linux-2.5.44-bk4/arch/i386/Makefile linux/arch/i386/Makefile
--- linux-2.5.44-bk4/arch/i386/Makefile	Tue Oct 29 21:24:37 2002
+++ linux/arch/i386/Makefile	Tue Oct 29 22:43:49 2002
@@ -22,24 +22,26 @@
 
 CFLAGS += -pipe
 
+check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
 # prevent gcc from keeping the stack 16 byte aligned
-CFLAGS += $(shell if $(CC) -mpreferred-stack-boundary=2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mpreferred-stack-boundary=2"; fi)
+CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)
 
 cflags-$(CONFIG_M386)		+= -march=i386
 cflags-$(CONFIG_M486)		+= -march=i486
 cflags-$(CONFIG_M586)		+= -march=i586
 cflags-$(CONFIG_M586TSC)	+= -march=i586
-cflags-$(CONFIG_M586MMX)	+= $(shell if $(CC) -march=pentium-mmx -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=pentium-mmx"; else echo "-march=i586"; fi) 
+cflags-$(CONFIG_M586MMX)	+= $(call check_gcc,-march=pentium-mmx,-march=i586)
 cflags-$(CONFIG_M686)		+= -march=i686
-cflags-$(CONFIG_MPENTIUMIII)	+= $(shell if $(CC) -march=pentium3 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=pentium3"; else echo "-march=i686"; fi) 
-cflags-$(CONFIG_MPENTIUM4)	+= $(shell if $(CC) -march=pentium4 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=pentium4"; else echo "-march=i686"; fi) 
-cflags-$(CONFIG_MK6)		+= $(shell if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi)
-cflags-$(CONFIG_MK7)		+= $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
+cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
+cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
+cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
+cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686 -malign-functions=4)
 cflags-$(CONFIG_MCRUSOE)	+= -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0
-cflags-$(CONFIG_MWINCHIPC6)	+= -march=i586
-cflags-$(CONFIG_MWINCHIP2)	+= -march=i586
+cflags-$(CONFIG_MWINCHIPC6)	+= $(call check_gcc,-march=winchip-c6,-march=i586)
+cflags-$(CONFIG_MWINCHIP2)	+= $(call check_gcc,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MWINCHIP3D)	+= -march=i586
-cflags-$(CONFIG_MCYRIXIII)	+= -march=i586
+cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i586)
 
 CFLAGS += $(cflags-y)
 

--------------090306000609090303070206--

