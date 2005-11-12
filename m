Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVKLSDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVKLSDX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVKLSCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:02:48 -0500
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]:7624 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932455AbVKLSC1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:02:27 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/9] Kbuild: index asm-$(SUBARCH) headers for UML
Date: Sat, 12 Nov 2005 19:07:12 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051112180711.20133.68166.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

In Uml, many definitions are borrowed from underlying subarch headers
(with #include <asm/arch/stuff.h>). And it has become annoying to keep switching
tag files all time, so by default index the underlying subarch headers too. Btw,
it adds negligible space to the tags file (less than 1M surely, IIRC it was
around 500k over 40M).

Finally, preserve the ALLSOURCE_ARCHS command line option (I hope) - if it is
set, it is used for headers too as before. But check my construct please, I
didn't test this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 Makefile |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 6d1f727..d1b6773 100644
--- a/Makefile
+++ b/Makefile
@@ -1192,6 +1192,17 @@ else
 __srctree = $(srctree)/
 endif
 
+ifeq ($(ALLSOURCE_ARCHS),)
+ifeq ($(ARCH),um)
+ALLINCLUDE_ARCHS := $(ARCH) $(SUBARCH)
+else
+ALLINCLUDE_ARCHS := $(ARCH)
+endif
+else
+#Allow user to specify only ALLSOURCE_PATHS on the command line, keeping existing behaviour.
+ALLINCLUDE_ARCHS := $(ALLSOURCE_ARCHS)
+endif
+
 ALLSOURCE_ARCHS := $(ARCH)
 
 define all-sources
@@ -1207,7 +1218,7 @@ define all-sources
 	  find $(__srctree)include $(RCS_FIND_IGNORE) \
 	       \( -name config -o -name 'asm-*' \) -prune \
 	       -o -name '*.[chS]' -print; \
-	  for ARCH in $(ALLSOURCE_ARCHS) ; do \
+	  for ARCH in $(ALLINCLUDE_ARCHS) ; do \
 	       find $(__srctree)include/asm-$${ARCH} $(RCS_FIND_IGNORE) \
 	            -name '*.[chS]' -print; \
 	  done ; \

