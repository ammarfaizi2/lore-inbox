Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUGaTYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUGaTYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 15:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUGaTYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 15:24:25 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:64233 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261234AbUGaTYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 15:24:23 -0400
Date: Sat, 31 Jul 2004 12:24:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][PPC32] Fix compilation with binutils-2.15
Message-ID: <20040731192421.GT16468@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ppc32 will not always compile with binutils-2.15.  The issue
is that binutils has become even more strict about which opcodes can be
used with which CPU flags.  The problem is that we have a number of
cases where we compile with altivec instructions (with runtime checks to
make sure we can actually run them) in code that's not altivec specific.
The fix for this is to always pass in -maltivec on CONFIG_6xx.  To do
this cleanly, we split our AFLAGS definition up into
aflags-$(CONFIG_FOO).

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.57/arch/ppc/Makefile	2004-07-28 21:58:36 -07:00
+++ edited/arch/ppc/Makefile	2004-07-31 12:16:29 -07:00
@@ -22,7 +22,7 @@
 
 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+= -Iarch/$(ARCH)
-AFLAGS		+= -Iarch/$(ARCH)
+aflags-y	+= -Iarch/$(ARCH)
 cflags-y	+= -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -Wno-uninitialized -mmultiple
 CPP		= $(CC) -E $(CFLAGS)
@@ -33,10 +33,16 @@
 cflags-y	+= -mstring
 endif
 
+aflags-$(CONFIG_4xx)		+= -m405
 cflags-$(CONFIG_4xx)		+= -Wa,-m405
+aflags-$(CONFIG_6xx)		+= -maltivec
+cflags-$(CONFIG_6xx)		+= -Wa,-maltivec
+aflags-$(CONFIG_E500)		+= -me500
 cflags-$(CONFIG_E500)		+= -Wa,-me500
+aflags-$(CONFIG_PPC64BRIDGE)	+= -mppc64bridge
 cflags-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
 
+AFLAGS += $(aflags-y)
 CFLAGS += $(cflags-y)
 
 head-y				:= arch/ppc/kernel/head.o

-- 
Tom Rini
http://gate.crashing.org/~trini/
