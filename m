Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVIJUgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVIJUgd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVIJUgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:36:33 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:48283 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932291AbVIJUgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:36:32 -0400
Date: Sat, 10 Sep 2005 22:38:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 7/7] kbuild: fix generic asm-offsets.h support
Message-ID: <20050910203807.GG29334@mars.ravnborg.org>
References: <20050910200347.GA3762@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910200347.GA3762@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a bug where the generated asm-offsets.h file was saved in
the source tree even with make O=.
Thanks to Stephen Rothwell <sfr@canb.auug.org.au> for the report.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Kbuild   |    5 +++--
 Makefile |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

8d36a62364b6b04dc7b0e9fe09f6968f4e5a1f0a
diff --git a/Kbuild b/Kbuild
--- a/Kbuild
+++ b/Kbuild
@@ -4,7 +4,7 @@
 # 1) Generate asm-offsets.h
 
 #####
-# 1) Generate asm-offsets.h 
+# 1) Generate asm-offsets.h
 #
 
 offsets-file := include/asm-$(ARCH)/asm-offsets.h
@@ -22,6 +22,7 @@ sed-$(CONFIG_MIPS) := "/^@@@/s///p"
 
 quiet_cmd_offsets = GEN     $@
 define cmd_offsets
+	mkdir -p $(dir $@); \
 	cat $< | \
 	(set -e; \
 	 echo "#ifndef __ASM_OFFSETS_H__"; \
@@ -43,6 +44,6 @@ arch/$(ARCH)/kernel/asm-offsets.s: arch/
 	$(Q)mkdir -p $(dir $@)
 	$(call if_changed_dep,cc_s_c)
 
-$(srctree)/$(offsets-file): arch/$(ARCH)/kernel/asm-offsets.s Kbuild
+$(obj)/$(offsets-file): arch/$(ARCH)/kernel/asm-offsets.s Kbuild
 	$(call cmd,offsets)
 
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -814,7 +814,7 @@ ifneq ($(KBUILD_MODULES),)
 endif
 
 prepare0: prepare prepare1 FORCE
-	$(Q)$(MAKE) $(build)=$(srctree)
+	$(Q)$(MAKE) $(build)=.
 
 # All the preparing..
 prepare-all: prepare0

