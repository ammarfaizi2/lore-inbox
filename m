Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267194AbSK3AhF>; Fri, 29 Nov 2002 19:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267195AbSK3AhF>; Fri, 29 Nov 2002 19:37:05 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:34176 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S267194AbSK3AhE>; Fri, 29 Nov 2002 19:37:04 -0500
Date: Sat, 30 Nov 2002 11:44:13 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 / compiling with frame pointers doesn't
Message-ID: <20021130004413.GB3831@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As near as I can tell, compiling with frame pointers turned on doesn't
do anything. I had a quick look around in the Makefiles and found that
the test for CONFIG_FRAME_POINTER happens -before- the .config is
actually loaded, thereby resulting in it never being defined and so
-fomit-frame-pointer is always included.

Now I'm not too sure as the whole Makefile structure in the linux kernel
but the way I fixed this was by moving the test block down to be below
.config getting loaded rather then moving the .config load section up.
Not sure which is preferrable but here's my patch.

--- Makefile.old	Sat Nov 30 11:43:08 2002
+++ Makefile	Thu Nov 28 22:56:02 2002
@@ -169,9 +169,6 @@
 CPPFLAGS	:= -D__KERNEL__ -Iinclude
 CFLAGS 		:= $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
 	  	   -fno-strict-aliasing -fno-common
-ifndef CONFIG_FRAME_POINTER
-CFLAGS		+= -fomit-frame-pointer
-endif
 AFLAGS		:= -D__ASSEMBLY__ $(CPPFLAGS)
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
@@ -221,6 +218,10 @@
 
 -include .config
 
+endif
+
+ifndef CONFIG_FRAME_POINTER
+CFLAGS		+= -fomit-frame-pointer
 endif
 
 include arch/$(ARCH)/Makefile

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
