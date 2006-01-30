Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWA3Saj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWA3Saj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWA3Saj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:30:39 -0500
Received: from mail.timesys.com ([65.117.135.102]:33929 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP
	id S1751288AbWA3Sai convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:30:38 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [PATCH] kconfig: detect if -lintl is needed when linking conf,mconf
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Date: Mon, 30 Jan 2006 13:26:47 -0500
Message-ID: <3D848382FB72E249812901444C6BDB1D0908A150@exchange.timesys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] kconfig: detect if -lintl is needed when linking conf,mconf
Thread-Index: AcYlyrrm7grohq4SRDiUSkJEoPJ/EA==
From: "Robb, Sam" <sam.robb@timesys.com>
To: <zippel@linux-m68k.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  On a system where libintl.h is present, but the NLS functionality is
supplied by a separate library instead of the system C library, an attempt
to "make config" or "make menuconfig" will fail with link errors, ex:

  scripts/kconfig/mconf.o:mconf.c:(.text+0xf63): undefined reference to
    `_libintl_gettext'

  This patch attempts to correct the problem by detecting whether or not
NLS support requires linking with libintl.

Signed-off-by: Samuel J Robb <sam.robb@timesys.com>

---

--- linux-2.6.15.1/scripts/kconfig/Makefile.orig        2006-01-25 14:55:22.926372900 -0500
+++ linux-2.6.15.1/scripts/kconfig/Makefile     2006-01-30 12:51:04.551596200 -0500
@@ -122,7 +122,17 @@ KBUILD_HAVE_NLS := $(shell \
      then echo yes ; \
      else echo no ; fi)
 ifeq ($(KBUILD_HAVE_NLS),no)
-HOSTCFLAGS     += -DKBUILD_NO_NLS
+  HOSTCFLAGS   += -DKBUILD_NO_NLS
+else
+  KBUILD_NEED_LINTL := $(shell \
+    if echo -e "\#include <libintl.h>\nint main(int a, char** b) { gettext(\"\"); return 0; }\n" | \
+      $(HOSTCC) $(HOSTCFLAGS) -x c - > /dev/null 2>&1 ; \
+    then echo no ; \
+    else echo yes ; fi)
+  ifeq ($(KBUILD_NEED_LINTL),yes)
+    HOSTLOADLIBES_conf += -lintl
+    HOSTLOADLIBES_mconf        += -lintl
+  endif
 endif
 
 # generated files seem to need this to find local include files
