Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268072AbUJSGsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268072AbUJSGsb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 02:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUJSGsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 02:48:30 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:18333 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268072AbUJSGsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 02:48:23 -0400
To: sam@ravnborg.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Mon, 18 Oct 2004 23:48:22 -0700
Message-ID: <52is979pah.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH] ppc: fix build with O=$(output_dir)
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 19 Oct 2004 06:48:22.0543 (UTC) FILETIME=[A03859F0:01C4B5A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes to arch/ppc/boot/lib/Makefile cause

      CC      arch/ppc/boot/lib/../../../../lib/zlib_inflate/infblock.o
    Assembler messages:
    FATAL: can't create arch/ppc/boot/lib/../../../../lib/zlib_inflate/infblock.o: No such file or directory

when building a ppc kernel using O=$(output_dir) with CONFIG_ZLIB_INFLATE=n,
because the $(output_dir)/lib/zlib_inflate directory doesn't get created.

This patch, which makes arch/ppc/boot/lib/Makefile create the
directory if needed, is one fix for the problem.

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-2.6.9/arch/ppc/boot/lib/Makefile
===================================================================
--- linux-2.6.9.orig/arch/ppc/boot/lib/Makefile	2004-10-18 14:54:55.000000000 -0700
+++ linux-2.6.9/arch/ppc/boot/lib/Makefile	2004-10-18 23:41:28.000000000 -0700
@@ -4,7 +4,13 @@
 
 CFLAGS_kbd.o	+= -Idrivers/char
 
-lib-y := $(addprefix ../../../../lib/zlib_inflate/, \
+ZLIB_DIR := ../../../../lib/zlib_inflate/
+
+lib-y := $(addprefix $(ZLIB_DIR), \
            infblock.o infcodes.o inffast.o inflate.o inftrees.o infutil.o)
 lib-y += div64.o
 lib-$(CONFIG_VGA_CONSOLE) += vreset.o kbd.o
+
+ifneq ($(KBUILD_SRC),)
+_make_zlib_dir := $(shell [ -d $(obj)/$(ZLIB_DIR) ] || mkdir -p $(obj)/$(ZLIB_DIR) )
+endif
