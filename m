Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268902AbUH3TzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268902AbUH3TzA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268904AbUH3TyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:54:10 -0400
Received: from ppp-62-11-78-150.dialup.tiscali.it ([62.11.78.150]:8066 "EHLO
	zion.localdomain") by vger.kernel.org with ESMTP id S268902AbUH3Twl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:52:41 -0400
Subject: [patch 1/2] kbuild - Single_Linking_Step-uml-hook
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Mon, 30 Aug 2004 21:48:35 +0200
Message-Id: <20040830194835.DB80E7D85@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please note that this patch, even if UML-related, should be immediately
discussed for merging in mainline, if possible.

Patch purpose:
This patch adds the kbuild hooks needed to avoid the linking kludge which leaves
kbuild link vmlinux and then link it with libc inside linux. This kludge has the
big problem of making kallsyms break, since the kallsyms pass is done on a
completely different binary than the running one.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/Makefile |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff -puN Makefile~Single_Linking_Step-uml-hook Makefile
--- uml-linux-2.6.8.1/Makefile~Single_Linking_Step-uml-hook	2004-08-30 16:39:08.919429000 +0200
+++ uml-linux-2.6.8.1-paolo/Makefile	2004-08-30 16:39:08.922428544 +0200
@@ -507,20 +507,30 @@ libs-y		:= $(libs-y1) $(libs-y2)
 #       we cannot yet know if we will need to relink vmlinux.
 #	So we descend into init/ inside the rule for vmlinux again.
 head-y += $(HEAD)
-vmlinux-objs := $(head-y) $(init-y) $(core-y) $(libs-y) $(drivers-y) $(net-y)
+# If an arch (like UML) uses its own linking command for vmlinux, supply
+# it everything to avoid it forgetting some objects.
+vmlinux-init-objs := $(head-y) $(init-y)
+vmlinux-main-objs := $(core-y) $(libs-y) $(drivers-y) $(net-y)
+vmlinux-special-objs = $(filter .tmp_kallsyms%,$^)
+# List of dependencies for vmlinux
+vmlinux-objs := $(vmlinux-init-objs) $(vmlinux-main-objs)
 
 quiet_cmd_vmlinux__ = LD      $@
+#Allow UML to use gcc to link vmlinux.
+#The command below is parametrized enough that you will never change it;
+#but if you still want to change it, update every arch accordingly
+#(at least UML, maybe other ones will use it, too).
+ifeq ($(cmd_vmlinux__),)
 define cmd_vmlinux__
-	$(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) $(head-y) $(init-y) \
+	$(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) \
+	$(vmlinux-init-objs) \
 	--start-group \
-	$(core-y) \
-	$(libs-y) \
-	$(drivers-y) \
-	$(net-y) \
+	$(vmlinux-main-objs) \
 	--end-group \
-	$(filter .tmp_kallsyms%,$^) \
+	$(vmlinux-special-objs) \
 	-o $@
 endef
+endif
 
 #	set -e makes the rule exit immediately on error
 
@@ -541,6 +551,7 @@ endef
 do_system_map = $(NM) $(1) | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > $(2)
 
 LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds.s
+CFLAGS_vmlinux += -Wl,-T,arch/$(ARCH)/kernel/vmlinux.lds.s
 
 #	Generate section listing all symbols and add it into vmlinux
 #	It's a three stage process:
_
