Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263535AbUJ2U1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbUJ2U1z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbUJ2UYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:24:07 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:21534 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263521AbUJ2UMf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:12:35 -0400
Date: Sat, 30 Oct 2004 00:13:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.10-rc1-mm2
Message-ID: <20041029221307.GB11016@mars.ravnborg.org>
Mail-Followup-To: Doug Maxey <dwm@austin.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@ozlabs.org
References: <20041029014930.21ed5b9a.akpm@osdl.org> <200410291955.i9TJtfaj014056@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410291955.i9TJtfaj014056@falcon10.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 02:55:41PM -0500, Doug Maxey wrote:
> 
> Andrew, 
> 
> having some troubles on ppc64.  It looks like the changes in
> the scripts/Makefile.{clean,build} are expecting include/asm to
> exist in the source tree.  I don't see any related file except the
> include/asm-$ARCH/Kbuild

Fix attached.

	Sam

===== Makefile 1.546 vs edited =====
--- 1.546/Makefile	2004-10-27 23:00:25 +02:00
+++ edited/Makefile	2004-10-29 23:05:42 +02:00
@@ -761,7 +761,7 @@
 prepare1: prepare2 outputmakefile
 
 prepare0: prepare1 include/linux/version.h include/asm include/config/MARKER
-	$(Q)$(MAKE) $(build)=$(srctree)/include/asm
+	$(Q)$(MAKE) $(build)=include/asm-$(ARCH)
 ifneq ($(KBUILD_MODULES),)
 	$(Q)rm -rf $(MODVERDIR)
 	$(Q)mkdir -p $(MODVERDIR)
===== include/asm-i386/Kbuild 1.1 vs edited =====
--- 1.1/include/asm-i386/Kbuild	2004-10-27 23:06:50 +02:00
+++ edited/include/asm-i386/Kbuild	2004-10-29 01:44:08 +02:00
@@ -11,7 +11,7 @@
 always  := offsets.h
 targets := offsets.s
 
-CFLAGS_offsets.o := -I arch/i386/kernel
+CFLAGS_offsets.o := -Iarch/i386/kernel
 
 $(obj)/offsets.h: $(obj)/offsets.s FORCE
 	$(call filechk,gen-asm-offsets, < $<)
===== scripts/Makefile.build 1.51 vs edited =====
--- 1.51/scripts/Makefile.build	2004-10-27 22:49:53 +02:00
+++ edited/scripts/Makefile.build	2004-10-29 23:04:40 +02:00
@@ -10,7 +10,7 @@
 # Read .config if it exist, otherwise ignore
 -include .config
 
-include $(if $(wildcard $(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
+include $(if $(wildcard $(srctree)/$(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
 
 include scripts/Makefile.lib
 
===== scripts/Makefile.clean 1.17 vs edited =====
--- 1.17/scripts/Makefile.clean	2004-10-27 22:49:53 +02:00
+++ edited/scripts/Makefile.clean	2004-10-29 23:22:26 +02:00
@@ -7,7 +7,7 @@
 .PHONY: __clean
 __clean:
 
-include $(if $(wildcard $(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
+include $(if $(wildcard $(srctree)/$(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
 
 # Figure out what we need to build from the various variables
 # ==========================================================================
