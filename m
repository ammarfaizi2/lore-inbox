Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVIJTGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVIJTGr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 15:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVIJTGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 15:06:47 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:40229 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1750725AbVIJTGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 15:06:46 -0400
Date: Sat, 10 Sep 2005 21:08:22 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: asm-offsets.h is generated in the source tree
Message-ID: <20050910190822.GA31478@mars.ravnborg.org>
References: <20050911012033.5632152f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911012033.5632152f.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 01:20:33AM +1000, Stephen Rothwell wrote:
> The latest Linus-git tree generates asm-offsets.h in the source tree even
> if you use O=... I don't know how to fix this, but it means that the
> source tree cannot be read only.

Fixed - patch appended.
[I also made an unrelated space fix in the same patch]

	Sam

kbuild: fix generic asm-offsets.h support

iThis fixes a bug where the generated asm-offsets.h file was saved in
the source tree even with make O=.
Thanks to Stephen Rothwell <sfr@canb.auug.org.au> for the report.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---
commit 8d36a62364b6b04dc7b0e9fe09f6968f4e5a1f0a
tree 10d5400d627236f7308f13238fa6559ccd9d79d1
parent 0a504f259c90fb41d3495d490fc9dbe2530c8749
author Sam Ravnborg <sam@mars.ravnborg.org> Sat, 10 Sep 2005 21:05:36 +0200
committer Sam Ravnborg <sam@mars.ravnborg.org> Sat, 10 Sep 2005 21:05:36 +0200

 Kbuild   |    5 +++--
 Makefile |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

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
