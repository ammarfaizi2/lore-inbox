Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbUKDCu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbUKDCu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUKDCDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:03:32 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:3732
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262056AbUKDBzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:50 -0500
Subject: [patch 04/20] uml: fix symbol conflict in linking
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:23 +0100
Message-Id: <20041103231723.BF97C363A8@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since arch/um/kernel/tt/unmap_fin.o is linked statically, it could contain
some symbols also contained in the rest of vmlinux; on some systems, this
actually happens (due to some glibc differences).

Since that file *must* be linked statically and then relinked (its code must
remap the whole .text area except the section it is contained in during UML
startup), we cannot change this. So, we use objcopy to turn all symbols into
local ones except for switcheroo(), which is the only function actually
defined in the source (the other ones are brought in during linking).

This shouldn't hurt other systems, while improving the behaviour on affected
ones (there is still another issue I'm trying to fix). And it is logically
always needed (i.e., without this UML has just happened to work until now).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/Makefile |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/um/kernel/tt/Makefile~uml-link-fix-symbol-conflict arch/um/kernel/tt/Makefile
--- vanilla-linux-2.6.9/arch/um/kernel/tt/Makefile~uml-link-fix-symbol-conflict	2004-11-03 23:44:57.575807264 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/Makefile	2004-11-03 23:44:57.577806960 +0100
@@ -4,6 +4,7 @@
 #
 
 extra-y := unmap_fin.o
+clean-files := unmap_tmp.o
 
 obj-y = exec_kern.o exec_user.o gdb.o ksyms.o mem.o mem_user.o process_kern.o \
 	syscall_kern.o syscall_user.o time.o tlb.o tracer.o trap_user.o \
@@ -20,10 +21,9 @@ UNMAP_CFLAGS := $(patsubst -fprofile-arc
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
 
-$(O_TARGET) : $(obj)/unmap_fin.o
-
 $(obj)/unmap.o: $(src)/unmap.c
 	$(CC) $(UNMAP_CFLAGS) -c -o $@ $<
 
-$(obj)/unmap_fin.o : $(src)/unmap.o
-	ld -r -o $@ $< -lc -L/usr/lib
+$(obj)/unmap_fin.o : $(obj)/unmap.o
+	ld -r -o $(obj)/unmap_tmp.o  $< -lc -L/usr/lib
+	objcopy $(obj)/unmap_tmp.o $@ -G switcheroo
_
