Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269598AbUJVGOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269598AbUJVGOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 02:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269653AbUJVGL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 02:11:56 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:16362 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S269598AbUJSSOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:14:41 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: sam@ravnborg.org, akpm@osdl.org, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <52is979pah.fsf@topspin.com>
	<20041019164449.GF6298@smtp.west.cox.net>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 19 Oct 2004 11:14:38 -0700
In-Reply-To: <20041019164449.GF6298@smtp.west.cox.net> (Tom Rini's message
 of "Tue, 19 Oct 2004 09:44:49 -0700")
Message-ID: <521xfua835.fsf_-_@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH/take 2] ppc: fix build with O=$(output_dir)
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 19 Oct 2004 18:14:39.0802 (UTC) FILETIME=[7FC771A0:01C4B607]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH/take 2] ppc: fix build with O=$(output_dir)

OK, here's a patch that builds a separate copy for arch/ppc/boot/lib.

Recent changes to arch/ppc/boot/lib/Makefile cause

      CC      arch/ppc/boot/lib/../../../../lib/zlib_inflate/infblock.o
    Assembler messages:
    FATAL: can't create arch/ppc/boot/lib/../../../../lib/zlib_inflate/infblock.o: No such file or directory

when building a ppc kernel using O=$(output_dir) with CONFIG_ZLIB_INFLATE=n,
because the $(output_dir)/lib/zlib_inflate directory doesn't get created.

This patch, which uses the lib/zlib_inflate sources to build objects
in the arch/ppc/boot/lib/directory, is one fix for the problem.

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-2.6.9/arch/ppc/boot/lib/Makefile
===================================================================
--- linux-2.6.9.orig/arch/ppc/boot/lib/Makefile	2004-10-18 14:54:55.000000000 -0700
+++ linux-2.6.9/arch/ppc/boot/lib/Makefile	2004-10-19 11:10:07.000000000 -0700
@@ -4,7 +4,10 @@
 
 CFLAGS_kbd.o	+= -Idrivers/char
 
-lib-y := $(addprefix ../../../../lib/zlib_inflate/, \
-           infblock.o infcodes.o inffast.o inflate.o inftrees.o infutil.o)
-lib-y += div64.o
+ZLIB_OBJS := infblock.o infcodes.o inffast.o inflate.o inftrees.o infutil.o
+
+lib-y := $(ZLIB_OBJS) div64.o
 lib-$(CONFIG_VGA_CONSOLE) += vreset.o kbd.o
+
+$(addprefix $(obj)/, $(ZLIB_OBJS)): $(obj)/%.o: lib/zlib_inflate/%.c
+	$(call if_changed,cc_o_c)
