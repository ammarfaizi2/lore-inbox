Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbUKDCG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUKDCG6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbUKDCFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:05:37 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:6548
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262059AbUKDB4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:56:01 -0500
Subject: [patch 19/20] uml: readd linux Makefile target - fixes to the old version.
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:59 +0100
Message-Id: <20041103231759.C564055C8D@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please CC me on replies).
We have readded the "linux" target which just creates a hardlink to vmlinux.
It was noted (sorry for forgetting who said this) that "make ARCH=um"
will leave an old "linux" file, since the target is not listed in .PHONY.

Using a symlink, instead of an hard link, was suggested because the hard link
does not get updated with make vmlinux. But mv linux $destpath (the most
meaningful installation command) is broken, so I instead added linux to .PHONY.
Obviously, linux will not be rebuilt on "make vmlinux ARCH=um", but this makes
sense (if people use the new way, don't use old tricks). Anyway, we remove
"linux" in any case.

Acked-by: Jeff Dike <jdike@addtoit.com>

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/Makefile |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff -puN arch/um/Makefile~uml-readd-linux-target-part2 arch/um/Makefile
--- vanilla-linux-2.6.9/arch/um/Makefile~uml-readd-linux-target-part2	2004-11-03 23:30:36.465715896 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/Makefile	2004-11-03 23:30:36.467715592 +0100
@@ -63,16 +63,18 @@ ifeq ($(CONFIG_MODE_SKAS), y)
 $(SYS_HEADERS) : $(ARCH_DIR)/include/skas_ptregs.h
 endif
 
+.PHONY: linux
+
 all: linux
 
 linux: vmlinux
-	$(RM) $@
-	ln $< $@
+	ln -f $< $@
 
 define archhelp
   echo '* linux		- Binary kernel image (./linux) - for backward'
-  echo '		   compatibility only: now you can simply run'
-  echo '		   the vmlinux binary you find in the kernel root.'
+  echo '		   compatibility only, this creates a hard link to the'
+  echo '		   real kernel binary, the the "vmlinux" binary you'
+  echo '		   find in the kernel root.'
 endef
 
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
@@ -118,7 +120,8 @@ define cmd_vmlinux__
 	-Wl,-T,$(vmlinux-lds) $(vmlinux-init) \
 	-Wl,--start-group $(vmlinux-main) -Wl,--end-group \
 	-L/usr/lib -lutil \
-	$(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) FORCE ,$^)
+	$(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) \
+	FORCE ,$^) ; rm -f linux
 endef
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
_
