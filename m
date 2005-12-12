Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVLLAqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVLLAqt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 19:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbVLLAqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 19:46:32 -0500
Received: from w241.dkm.cz ([62.24.88.241]:5268 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750957AbVLLAqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 19:46:06 -0500
From: Petr Baudis <pasky@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] [kbuild] Possibility to sanely link against off-directory .so
Date: Mon, 12 Dec 2005 01:46:04 +0100
To: zippel@linux-m68k.org
Cc: sam@ravnborg.org, kbuild-devel@lists.sourceforge.net
Message-Id: <20051212004603.31263.12201.stgit@machine.or.cz>
In-Reply-To: <20051212004159.31263.89669.stgit@machine.or.cz>
References: <20051212004159.31263.89669.stgit@machine.or.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces two special variables which make it actually possible
to link something against .so being built in another directory. The
variable $(<foo>-linkobjs) allows the user to specify additional objects
to link <foo> against, while not creating any dependencies of <foo> on the
objects.

I need this in order to link scripts/lxdialog/liblxdialog.so from
scripts/kconfig (I'll be able to build that lib thanks to the previous
patch and the actual change to make it a library will follow in the next
patch).

On 6 Nov 2002 Sam Ravnborg <sam@ravnborg.org> disputed this approach,
saying that such an extra complexity will bog the whole kernel build, but
this involves only the host tools build and there I think the extra penalty
is negligible. Also, .so has two users instead of a single one now, so it's
not that easy to use his suggested approach to offload the functionality to
the leaf makefiles.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 scripts/Makefile.host |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index ff1b54d..1161f4c 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -34,7 +34,12 @@
 # liblxdialog-objs := checklist.o util.o
 # Will create a "standalone" liblxdialog.so library in the directory,
 # not linked against anything (useful when you want to link something
-# to it later).
+# to it later). To link the library from another directory, do:
+# hostprogs-y    := mconf
+# mconf-objs     := mconf.o
+# mconf-linkobjs := ../lxdialog/liblxdialog.so
+# This will prevent kbuild from trying to build ../lxdialog/liblxdialog.so
+# from scripts/kconfig nor make mconf depend on it.
 
 __hostprogs := $(sort $(hostprogs-y)$(hostprogs-m))
 
@@ -116,6 +121,7 @@ $(host-csingle): %: %.c FORCE
 quiet_cmd_host-cmulti	= HOSTLD  $@
       cmd_host-cmulti	= $(HOSTCC) $(HOSTLDFLAGS) -o $@ \
 			  $(addprefix $(obj)/,$($(@F)-objs)) \
+			  $(addprefix $(obj)/,$($(@F)-linkobjs)) \
 			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
 $(host-cmulti): %: $(host-cobjs) $(host-cshlib) FORCE
 	$(call if_changed,host-cmulti)

