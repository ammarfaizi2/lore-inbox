Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVATQKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVATQKz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVATQI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:08:58 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:51728 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S262181AbVATQHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:07:36 -0500
Subject: [patch 1/1] kbuild: no redundant srctree in tags file
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, sam@ravnborg.org
From: blaisorblade@yahoo.it
Date: Thu, 20 Jan 2005 17:19:47 +0100
Message-Id: <20050120161948.43FF722157@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Sam Ravnborg <sam@ravnborg.org>

Avoid cluttering the tags/TAGS generated file with $(srctree) in the paths if
this is not needed.

This has two advantages:

* 1) Saving about 20M on the size of the resulting tags file (which are used
currently to store the absolute path of the file names rather than the
relative one) when KBUILD_OUTPUT is not set.

* 2)  Keeping the tags file valid when the directory is renamed.

No change is done for who does make tags O=..., if this is wanted (I would
find that incommodous and non-typical for a developer, but anyway I've not
ruined functionality in that case).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/Makefile |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff -puN Makefile~kbuild-no-redundant-srctree-in-tags-file Makefile
--- linux-2.6.11/Makefile~kbuild-no-redundant-srctree-in-tags-file	2005-01-19 20:09:07.000000000 +0100
+++ linux-2.6.11-paolo/Makefile	2005-01-19 20:09:07.000000000 +0100
@@ -1133,20 +1133,30 @@ endif # KBUILD_EXTMOD
 # Generate tags for editors
 # ---------------------------------------------------------------------------
 
+#We want __srctree to totally vanish out when KBUILD_OUTPUT is not set
+#(which is the most common case IMHO) to avoid unneeded clutter in the big tags file.
+#Adding $(srctree) adds about 20M on i386 to the size of the output file!
+
+ifeq ($(KBUILD_OUTPUT),)
+__srctree =
+else
+__srctree = $(srctree)/
+endif
+
 define all-sources
-	( find $(srctree) $(RCS_FIND_IGNORE) \
+	( find $(__srctree) $(RCS_FIND_IGNORE) \
 	       \( -name include -o -name arch \) -prune -o \
 	       -name '*.[chS]' -print; \
-	  find $(srctree)/arch/$(ARCH) $(RCS_FIND_IGNORE) \
+	  find $(__srctree)arch/$(ARCH) $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
-	  find $(srctree)/security/selinux/include $(RCS_FIND_IGNORE) \
+	  find $(__srctree)security/selinux/include $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
-	  find $(srctree)/include $(RCS_FIND_IGNORE) \
+	  find $(__srctree)include $(RCS_FIND_IGNORE) \
 	       \( -name config -o -name 'asm-*' \) -prune \
 	       -o -name '*.[chS]' -print; \
-	  find $(srctree)/include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
+	  find $(__srctree)include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
-	  find $(srctree)/include/asm-generic $(RCS_FIND_IGNORE) \
+	  find $(__srctree)include/asm-generic $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print )
 endef
 
_
