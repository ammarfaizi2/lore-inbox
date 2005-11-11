Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVKKUnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVKKUnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVKKUnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:43:33 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:1160 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751184AbVKKUnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:43:32 -0500
From: Tom Rini <trini@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Message-Id: <20051111204331.11609.46440.sendpatchset@localhost.localdomain>
In-Reply-To: <20051111204312.11609.23222.sendpatchset@localhost.localdomain>
References: <20051111204312.11609.23222.sendpatchset@localhost.localdomain>
Subject: [PATCH 2.6.14-rt11 3/3] Fix ppc32 bootwrapper code for new zlib
Date: Fri, 11 Nov 2005 15:43:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the ppc32 bootwrapper code mirror what the ppc64 version does to
clean out locking, etc, from lib/zlib_inflate/

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

 arch/ppc/boot/lib/Makefile |   48 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

Index: linux-2.6.14/arch/ppc/boot/lib/Makefile
===================================================================
--- linux-2.6.14.orig/arch/ppc/boot/lib/Makefile
+++ linux-2.6.14/arch/ppc/boot/lib/Makefile
@@ -5,19 +5,49 @@
 CFLAGS_kbd.o	:= -Idrivers/char
 CFLAGS_vreset.o := -I$(srctree)/arch/ppc/boot/include
 
-zlib  := infblock.c infcodes.c inffast.c inflate.c inftrees.c infutil.c
-	 
-lib-y += $(zlib:.c=.o) div64.o
-lib-$(CONFIG_VGA_CONSOLE) += vreset.o kbd.o
-
+zlib       := infblock.c infcodes.c inffast.c inflate.c inftrees.c infutil.c
+zlibheader := infblock.h infcodes.h inffast.h inftrees.h infutil.h
+zliblinuxheader := zlib.h zconf.h zutil.h
+
+$(addprefix $(obj)/,$(zlib)): $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
+
+src-boot := div64.S
+src-boot += $(zlib)
+#src-boot := $(addprefix $(obj)/, $(src-boot))
+obj-boot := $(addsuffix .o, $(basename $(src-boot)))
 
-# zlib files needs header from their original place
-EXTRA_CFLAGS += -Ilib/zlib_inflate
+BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj) $(CFLAGS)
 
 quiet_cmd_copy_zlib = COPY    $@
-      cmd_copy_zlib = cat $< > $@
+      cmd_copy_zlib = sed "s@__attribute_used__@@;s@.include.<linux/module.h>@@;s@.include.<linux/spinlock.h>@@;s@.*spin.*lock.*@@;s@.*SPINLOCK.*@@;s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
+
+quiet_cmd_copy_zlibheader = COPY    $@
+      cmd_copy_zlibheader = sed "s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
+# stddef.h for NULL
+quiet_cmd_copy_zliblinuxheader = COPY    $@
+      cmd_copy_zliblinuxheader = sed "s@.include.<linux/string.h>@@;s@.include.<linux/errno.h>@@;s@<linux/kernel.h>@<stddef.h>@;s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
 
 $(addprefix $(obj)/,$(zlib)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
 	$(call cmd,copy_zlib)
 
-clean-files := $(zlib)
+$(addprefix $(obj)/,$(zlibheader)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
+	$(call cmd,copy_zlibheader)
+
+$(addprefix $(obj)/,$(zliblinuxheader)): $(obj)/%: $(srctree)/include/linux/%
+	$(call cmd,copy_zliblinuxheader)
+
+clean-files := $(zlib) $(zlibheader) $(zliblinuxheader)
+
+quiet_cmd_bootcc = BOOTCC  $@
+      cmd_bootcc = $(CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
+
+quiet_cmd_bootas = BOOTAS  $@
+      cmd_bootas = $(CC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
+
+$(patsubst %.c,%.o, $(filter %.c, $(src-boot))): %.o: %.c
+	$(call if_changed_dep,bootcc)
+$(patsubst %.S,%.o, $(filter %.S, $(src-boot))): %.o: %.S
+	$(call if_changed_dep,bootas)
+
+lib-y += $(obj-boot)
+lib-$(CONFIG_VGA_CONSOLE) += vreset.o kbd.o

-- 
Tom
