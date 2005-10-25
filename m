Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVJYWLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVJYWLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVJYWLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:11:18 -0400
Received: from [151.97.230.9] ([151.97.230.9]:41656 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932429AbVJYWLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:11:18 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 5/6] i386: use -mcpu, not -mtune, for GCCs older than 3.4
Date: Wed, 26 Oct 2005 00:13:27 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025221327.21106.79685.stgit@zion.home.lan>
In-Reply-To: <20051025221105.21106.95194.stgit@zion.home.lan>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I just noted that -mtune is used, which is only supported on recent GCCs; by
reading http://gcc.gnu.org/gcc-3.4/changes.html, you see "-mcpu has been renamed
to -mtune.", so for GCC < 3.4 we're not using any specific tuning in the
appropriate cases. However -mcpu is deprecated, so use -mtune when possible.

This was introduced by commit e9d4dce954a60dc23dd1d967766ca2347b780e54 of the
old tree (between 2.6.10-rc3 and 2.6.10) by Linus Torvalds, to remove the use of
 -march, since that could trigger gcc using SSE on its own. But no attention was
used about using -mcpu vs. -mtune.

And btw, the old 2.6.4 code (for instance) was:
cflags-$(CONFIG_MPENTIUMII)     += $(call check_gcc,-march=pentium2,-march=i686)
cflags-$(CONFIG_MPENTIUMIII)    += $(call check_gcc,-march=pentium3,-march=i686)
cflags-$(CONFIG_MPENTIUMM)      += $(call check_gcc,-march=pentium3,-march=i686)
cflags-$(CONFIG_MPENTIUM4)      += $(call check_gcc,-march=pentium4,-march=i686)

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/i386/Makefile.cpu |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/i386/Makefile.cpu b/arch/i386/Makefile.cpu
--- a/arch/i386/Makefile.cpu
+++ b/arch/i386/Makefile.cpu
@@ -1,6 +1,14 @@
 # CPU tuning section - shared with UML.
 # Must change only cflags-y (or [yn]), not CFLAGS! That makes a difference for UML.
 
+#-mtune exists since gcc 3.4, and some -mcpu flavors didn't exist in gcc 2.95.
+HAS_MTUNE	:= $(call cc-option-yn, -mtune=i386)
+ifeq ($(HAS_MTUNE),y)
+tune		= $(call cc-option,-mtune=$(1),)
+else
+tune		= $(call cc-option,-mcpu=$(1),)
+endif
+
 align := $(cc-option-align)
 cflags-$(CONFIG_M386)		+= -march=i386
 cflags-$(CONFIG_M486)		+= -march=i486
@@ -8,17 +16,17 @@ cflags-$(CONFIG_M586)		+= -march=i586
 cflags-$(CONFIG_M586TSC)	+= -march=i586
 cflags-$(CONFIG_M586MMX)	+= $(call cc-option,-march=pentium-mmx,-march=i586)
 cflags-$(CONFIG_M686)		+= -march=i686
-cflags-$(CONFIG_MPENTIUMII)	+= -march=i686 $(call cc-option,-mtune=pentium2)
-cflags-$(CONFIG_MPENTIUMIII)	+= -march=i686 $(call cc-option,-mtune=pentium3)
-cflags-$(CONFIG_MPENTIUMM)	+= -march=i686 $(call cc-option,-mtune=pentium3)
-cflags-$(CONFIG_MPENTIUM4)	+= -march=i686 $(call cc-option,-mtune=pentium4)
+cflags-$(CONFIG_MPENTIUMII)	+= -march=i686 $(call tune,pentium2)
+cflags-$(CONFIG_MPENTIUMIII)	+= -march=i686 $(call tune,pentium3)
+cflags-$(CONFIG_MPENTIUMM)	+= -march=i686 $(call tune,pentium3)
+cflags-$(CONFIG_MPENTIUM4)	+= -march=i686 $(call tune,pentium4)
 cflags-$(CONFIG_MK6)		+= -march=k6
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
 # They make zero difference whatsosever to performance at this time.
 cflags-$(CONFIG_MK7)		+= $(call cc-option,-march=athlon,-march=i686 $(align)-functions=4)
 cflags-$(CONFIG_MK8)		+= $(call cc-option,-march=k8,$(call cc-option,-march=athlon,-march=i686 $(align)-functions=4))
 cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
-cflags-$(CONFIG_MEFFICEON)	+= -march=i686 $(call cc-option,-mtune=pentium3) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
+cflags-$(CONFIG_MEFFICEON)	+= -march=i686 $(call tune,pentium3) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call cc-option,-march=winchip-c6,-march=i586)
 cflags-$(CONFIG_MWINCHIP2)	+= $(call cc-option,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MWINCHIP3D)	+= $(call cc-option,-march=winchip2,-march=i586)

