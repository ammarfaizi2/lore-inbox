Return-Path: <linux-kernel-owner+w=401wt.eu-S1030201AbXADTmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbXADTmw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbXADTmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:42:52 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:4368 "EHLO
	outbound0.mx.meer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030201AbXADTmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:42:51 -0500
X-Greylist: delayed 5202 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 14:42:51 EST
Subject: [PATCH] kbuild: move tags from ARCH and include/ ahead of drivers
From: Don Mullis <dwm@meer.net>
To: lkml <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Cc: kai <kai@germaschewski.name>, sam <sam@ravnborg.org>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 10:14:52 -0800
Message-Id: <1167934492.2668.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move tags extracted from the ARCH and include/ sub-trees ahead of
those from device drivers, so that the former will appear first
during searches. 

Saves user time during interactive searches for certain patterns
that happen to find unwanted matches in driver files.

Example in emacs:
	 "M-x find-tag PAGE_SIZE"
	 "M-1 M-." (repeated until definition from asm-i386/page.h appears)

Signed-off-by: Don Mullis <dwm@meer.net>
---
Tested with emacs/etags/ctags v22.0.92 by:
 1) running `make TAGS`, `make tags` with and without patch (ARCH=i386).
 2) verifying improved behavior of tag definition searching with
   "M-x find-tag PAGE_SIZE", "M-1 M-." in emacs

 Makefile |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: linux-2.6.19/Makefile
===================================================================
--- linux-2.6.19.orig/Makefile
+++ linux-2.6.19/Makefile
@@ -1292,10 +1292,7 @@ endif
 ALLSOURCE_ARCHS := $(ARCH)
 
 define find-sources
-        ( find $(__srctree) $(RCS_FIND_IGNORE) \
-	       \( -name include -o -name arch \) -prune -o \
-	       -name $1 -print; \
-	  for ARCH in $(ALLSOURCE_ARCHS) ; do \
+        ( for ARCH in $(ALLSOURCE_ARCHS) ; do \
 	       find $(__srctree)arch/$${ARCH} $(RCS_FIND_IGNORE) \
 	            -name $1 -print; \
 	  done ; \
@@ -1309,7 +1306,11 @@ define find-sources
 	            -name $1 -print; \
 	  done ; \
 	  find $(__srctree)include/asm-generic $(RCS_FIND_IGNORE) \
-	       -name $1 -print )
+	       -name $1 -print; \
+	  find $(__srctree) $(RCS_FIND_IGNORE) \
+	       \( -name include -o -name arch \) -prune -o \
+	       -name $1 -print; \
+	  )
 endef
 
 define all-sources


