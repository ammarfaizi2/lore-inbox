Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVFLLYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVFLLYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVFLLWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:22:41 -0400
Received: from aun.it.uu.se ([130.238.12.36]:40420 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261945AbVFLLS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:18:58 -0400
Date: Sun, 12 Jun 2005 13:18:52 +0200 (MEST)
Message-Id: <200506121118.j5CBIqeL019723@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31 4/9] gcc4: fix undefined strcpy linkage errors
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc4 generates a few link-time errors like:

drivers/sound/sounddrivers.o(.text+0x1d2): In function `sound_insert_unit':
: undefined reference to `strcpy'
drivers/sound/sounddrivers.o(.text+0x7b92): In function `emu10k1_find_control_gpr':
: undefined reference to `strcpy'
make: *** [vmlinux] Error 1

This is because gcc4 by default rewrites trivial forms of
sprintf to equivalent uses of strcpy. The problem is that
the kernel's strcpy is an inline function, so there is no
strcpy symbol available at link-time.

The easiest fix is to use -fno-builtin-sprintf which prevents
gcc from doing this rewrite. This also works with older gcc
versions (tested 2.95.3).

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 Makefile |    1 +
 1 files changed, 1 insertion(+)

diff -rupN linux-2.4.31/Makefile linux-2.4.31.gcc4-undefined-strcpy-errors/Makefile
--- linux-2.4.31/Makefile	2005-06-01 18:02:21.000000000 +0200
+++ linux-2.4.31.gcc4-undefined-strcpy-errors/Makefile	2005-06-12 11:45:03.000000000 +0200
@@ -93,6 +93,7 @@ CPPFLAGS := -D__KERNEL__ -I$(HPATH)
 
 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
 	  -fno-strict-aliasing -fno-common
+CFLAGS += -fno-builtin-sprintf
 ifndef CONFIG_FRAME_POINTER
 CFLAGS += -fomit-frame-pointer
 endif
