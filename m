Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVIZGt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVIZGt2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVIZGt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:49:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33992 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932416AbVIZGt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:49:27 -0400
Date: Mon, 26 Sep 2005 07:49:27 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: [PATCH] missing dependency on arm O= builds
Message-ID: <20050926064927.GO7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	arm maketools needs include/asm-arm in place in the build tree.
On normal builds it's always there, of course, but on O= it's created
(by generic code) too late - when we get to asm-offset.h.
	We used to get away with that by accident - creation of
include/asm-arm/arch symlink creates include/asm-arm and it happened
to go before maketools.  However, we did not have such dependency,
so that luck didn't last - now maketools is picked first and we are screwed.
	Both the symlink and maketools are prerequisites of the same
target (archprepare).  This fix is obvious - make the latter explicitly
depend on the former and be done with that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git5-uml-kconfig/arch/arm/Makefile RC14-rc2-git5-arm-makefiles/arch/arm/Makefile
--- RC14-rc2-git5-uml-kconfig/arch/arm/Makefile	2005-09-12 14:20:17.000000000 -0400
+++ RC14-rc2-git5-arm-makefiles/arch/arm/Makefile	2005-09-25 23:46:52.000000000 -0400
@@ -175,10 +175,10 @@
 endif
 	@touch $@
 
-archprepare: maketools include/asm-arm/.arch
+archprepare: maketools
 
 .PHONY: maketools FORCE
-maketools: include/linux/version.h FORCE
+maketools: include/linux/version.h include/asm-arm/.arch FORCE
 	$(Q)$(MAKE) $(build)=arch/arm/tools include/asm-arm/mach-types.h
 
 # Convert bzImage to zImage
