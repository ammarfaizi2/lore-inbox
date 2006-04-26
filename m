Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWDZNzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWDZNzS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWDZNzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:55:18 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:16182
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932448AbWDZNzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:55:17 -0400
Message-Id: <444F9814.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 26 Apr 2006 15:56:04 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] adjust outputmakefile rule
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the conditional of the outputmakefile rule to be evaluated entirely
in make, and to not touch the generated makefile when e.g. running
'make install' as root while the build was done as non-root. Also adjust
the comment describing this.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/Makefile 2.6.17-rc2-mkmakefile/Makefile
--- /home/jbeulich/tmp/linux-2.6.17-rc2/Makefile	2006-04-26 11:50:05.516723552 +0200
+++ 2.6.17-rc2-mkmakefile/Makefile	2006-04-24 12:28:36.000000000 +0200
@@ -344,16 +344,18 @@ scripts_basic:
 scripts/basic/%: scripts_basic ;
 
 PHONY += outputmakefile
-# outputmakefile generate a Makefile to be placed in output directory, if
-# using a seperate output directory. This allows convinient use
-# of make in output directory
+# outputmakefile generates a Makefile in the output directory, if
+# using a separate output directory. This allows convenient use
+# of make in the output directory.
 outputmakefile:
-	$(Q)if test ! $(srctree) -ef $(objtree); then \
-	$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile              \
-	    $(srctree) $(objtree) $(VERSION) $(PATCHLEVEL)         \
-	    > $(objtree)/Makefile;                                 \
-	    echo '  GEN    $(objtree)/Makefile';                   \
+ifneq ($(KBUILD_SRC),)
+	$(Q)if [ ! -r $(objtree)/Makefile -o -O $(objtree)/Makefile ]; then \
+	    echo '  GEN     $(objtree)/Makefile';                           \
+	    $(CONFIG_SHELL) $(srctree)/scripts/mkmakefile                   \
+		$(srctree) $(objtree) $(VERSION) $(PATCHLEVEL)              \
+		> $(objtree)/Makefile;                                      \
 	fi
+endif
 
 # To make sure we do not include .config for any of the *config targets
 # catch them early, and hand them over to scripts/kconfig/Makefile


