Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVJZQun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVJZQun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 12:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVJZQun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 12:50:43 -0400
Received: from duke.math.cinvestav.mx ([148.247.14.23]:61956 "EHLO duke")
	by vger.kernel.org with ESMTP id S964816AbVJZQum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 12:50:42 -0400
Date: Wed, 26 Oct 2005 11:50:14 -0500
From: Yuri Vasilevski <yvasilev@duke.math.cinvestav.mx>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Daniel Drake <dsd@gentoo.org>
Subject: Patch that allows >=2.6.12 kernel to build on nls free systems
Message-ID: <20051026115014.2dbb0bfc@dune.math.cinvestav.mx>
X-Mailer: Sylpheed-Claws 1.9.15 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I made a patch that detects if libintl.h (needed for nls) is present on
the host system and if it's not, it nls support is disabled by
providing dummies for the used nls functions.

This way if there is nls support on the host system the *config targets
will build according to Arnaldo Carvalho de Melo's i18n modifications,
else it just uses the original English messages.

I have also made a bug report at kernel's bugzilla:
http://bugzilla.kernel.org/show_bug.cgi?id=5501
And there is a discussion about this problem in Gentoo's bugzilla:
http://bugs.gentoo.org/show_bug.cgi?id=99810

diff -Naur linux-2.6.14_rc2.orig/scripts/kconfig/Makefile linux-2.6.14_rc2/scripts/kconfig/Makefile
--- linux-2.6.14_rc2.orig/scripts/kconfig/Makefile	2005-11-06 04:13:01 +0000
+++ linux-2.6.14_rc2/scripts/kconfig/Makefile	2005-11-18 03:52:03 +0000
@@ -116,6 +116,15 @@
 clean-files	:= lkc_defs.h qconf.moc .tmp_qtcheck \
 		   .tmp_gtkcheck zconf.tab.c zconf.tab.h lex.zconf.c
 
+# Needed for systems without gettext
+KBUILD_HAVE_NLS := $(shell \
+     if echo "\#include <libint.h>" | $(HOSTCC) $(HOSTCFLAGS) -E - > /dev/null 2>&1 ; \
+     then echo yes ; \
+     else echo no ; fi)
+ifeq ($(KBUILD_HAVE_NLS),no)
+HOSTCFLAGS	+= -DKBUILD_NO_NLS
+endif
+
 # generated files seem to need this to find local include files
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
diff -Naur linux-2.6.14_rc2.orig/scripts/kconfig/lkc.h linux-2.6.14_rc2/scripts/kconfig/lkc.h
--- linux-2.6.14_rc2.orig/scripts/kconfig/lkc.h	2005-11-06 04:13:01 +0000
+++ linux-2.6.14_rc2/scripts/kconfig/lkc.h	2005-11-18 02:23:07 +0000
@@ -8,7 +8,13 @@
 
 #include "expr.h"
 
-#include <libintl.h>
+#ifndef KBUILD_NO_NLS
+# include <libintl.h>
+#else
+# define gettext(Msgid) ((const char *) (Msgid))
+# define textdomain(Domainname) ((const char *) (Domainname))
+# define bindtextdomain(Domainname, Dirname) ((const char *) (Dirname))
+#endif
 
 #ifdef __cplusplus
 extern "C" {


Yuri.

PS: Please CC me on replay as I'm not in the kernel mailing list.

