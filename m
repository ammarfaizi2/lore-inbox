Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVIJUea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVIJUea (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVIJUea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:34:30 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:11322 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932289AbVIJUe1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:34:27 -0400
Date: Sat, 10 Sep 2005 22:36:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 4/7] kbuild: fix split-include dependency
Message-ID: <20050910203605.GD29334@mars.ravnborg.org>
References: <20050910200347.GA3762@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910200347.GA3762@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting of autoconf.h requires that split-include was built before,
and
needs to be-re-done when split-include changes. This dependency was
previously missing. Additionally, since autoconf.h is (suppoosed to
be)
generated as a side effect of executing config targets, include/linux
should be created prior to running the respective sub-make.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

cd05e6bdc6001ac6e8ab13720693b7e1302d9848
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -382,6 +382,9 @@ RCS_TAR_IGNORE := --exclude SCCS --exclu
 scripts_basic:
 	$(Q)$(MAKE) $(build)=scripts/basic
 
+# To avoid any implicit rule to kick in, define an empty command.
+scripts/basic/%: scripts_basic ;
+
 .PHONY: outputmakefile
 # outputmakefile generate a Makefile to be placed in output directory, if
 # using a seperate output directory. This allows convinient use
@@ -444,9 +447,8 @@ ifeq ($(config-targets),1)
 include $(srctree)/arch/$(ARCH)/Makefile
 export KBUILD_DEFCONFIG
 
-config: scripts_basic outputmakefile FORCE
-	$(Q)$(MAKE) $(build)=scripts/kconfig $@
-%config: scripts_basic outputmakefile FORCE
+config %config: scripts_basic outputmakefile FORCE
+	$(Q)mkdir -p include/linux
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
 
 else
@@ -854,7 +856,7 @@ include/asm:
 
 # 	Split autoconf.h into include/linux/config/*
 
-include/config/MARKER: include/linux/autoconf.h
+include/config/MARKER: scripts/basic/split-include include/linux/autoconf.h
 	@echo '  SPLIT   include/linux/autoconf.h -> include/config/*'
 	@scripts/basic/split-include include/linux/autoconf.h include/config
 	@touch $@

