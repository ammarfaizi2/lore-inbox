Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbUL1XYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUL1XYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUL1XYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:24:48 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:5404 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261166AbUL1XYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:24:37 -0500
Date: Wed, 29 Dec 2004 00:26:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: kbuild: find stdarg.h in a new way
Message-ID: <20041228232609.GB29461@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stdarg.h is a compiler specific file.
Following patch is more explicit about how to find this file.
In this way we also share the definition with sparse.

	Sam



kbuild: Use -isystem `gcc --print-file-name=include`
   
   Using "-nostdinc -isystem `gcc --print-file-name=include" let
   us see full path to compiler specific files when compiling with make V=1
   Furthermore it lets us use same definition for sparse (CHECKFLAGS) and the kernel.
   Tested with gcc 3.3.4 only.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

   
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-12-29 00:21:09 +01:00
+++ b/Makefile	2004-12-29 00:21:09 +01:00
@@ -330,7 +330,10 @@
 KALLSYMS	= scripts/kallsyms
 PERL		= perl
 CHECK		= sparse
+
+NOSTDINC_FLAGS := -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__
+CHECKFLAGS     += $(NOSTDINC_FLAGS)
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
@@ -338,7 +341,6 @@
 CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=
 
-NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
 
 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	2004-12-29 00:21:09 +01:00
+++ b/scripts/Makefile.build	2004-12-29 00:21:09 +01:00
@@ -83,7 +83,6 @@
 
 # Linus' kernel sanity checking tool
 ifneq ($(KBUILD_CHECKSRC),0)
-  CHECKFLAGS += -I$(shell $(CC) -print-file-name=include)
   ifeq ($(KBUILD_CHECKSRC),2)
     quiet_cmd_force_checksrc = CHECK   $<
           cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
