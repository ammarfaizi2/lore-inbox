Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVITSvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVITSvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVITSvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:51:06 -0400
Received: from ppp-62-11-78-183.dialup.tiscali.it ([62.11.78.183]:20160 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965084AbVITSvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:51:02 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/3] Kbuild: index asm-$(SUBARCH) headers for UML
Date: Tue, 20 Sep 2005 20:48:47 +0200
To: akpm@osdl.org
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Message-Id: <20050920184846.15031.75987.stgit@zion.home.lan>
In-Reply-To: <20050920184810.15031.14521.stgit@zion.home.lan>
References: <20050920184810.15031.14521.stgit@zion.home.lan>
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
--- a/Makefile
+++ b/Makefile
@@ -1191,6 +1191,17 @@ else
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
@@ -1206,7 +1217,7 @@ define all-sources
 	  find $(__srctree)include $(RCS_FIND_IGNORE) \
 	       \( -name config -o -name 'asm-*' \) -prune \
 	       -o -name '*.[chS]' -print; \
-	  for ARCH in $(ALLSOURCE_ARCHS) ; do \
+	  for ARCH in $(ALLINCLUDE_ARCHS) ; do \
 	       find $(__srctree)include/asm-$${ARCH} $(RCS_FIND_IGNORE) \
 	            -name '*.[chS]' -print; \
 	  done ; \

