Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVCIXyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVCIXyz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVCIXwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:52:55 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:19726 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262142AbVCIXqF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:46:05 -0500
Message-Id: <200503100216.j2A2GcDN015243@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: torvalds@osdl.org
cc: Rob Landley <rob@landley.net>, Blaisorblade <blaisorblade@yahoo.it>,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/9] UML - Remove build dependency on perl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Mar 2005 21:16:38 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To quote .config into config.c for building the result into the code, use sed
instead of perl, as requested by one "embedded" UML user (which notes that 
perl is a big requirement, while busybox provides sed which is used in this 
patch).

I've tested that there are only cosmethical differences in the produced
config.c file, which don't change at all the result (i.e. "a" is replaced by
"" "a" at the beginning, which is non-significant).

Reported by, and initial patch provided by, Rob Landley.
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/Makefile	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/Makefile	2005-03-08 22:19:21.000000000 -0500
@@ -4,7 +4,7 @@
 #
 
 extra-y := vmlinux.lds
-clean-files := vmlinux.lds.S
+clean-files := vmlinux.lds.S config.tmp
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
@@ -34,11 +34,25 @@
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(USER_CFLAGS) $(CFLAGS_$(notdir $@)) -c -o $@ $<
 
-QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
+targets += config.c
 
-quiet_cmd_quote = QUOTE   $@
-cmd_quote = $(PERL) -e $(QUOTE) < $< > $@
+# Be careful with the below Sed code - sed is pitfall-rich!
+# We use sed to lower build requirements, for "embedded" builders for instance.
 
-targets += config.c
-$(obj)/config.c : $(src)/config.c.in $(TOPDIR)/.config FORCE
-	$(call if_changed,quote)
+$(obj)/config.tmp: $(objtree)/.config FORCE
+	$(call if_changed,quote1)
+
+quiet_cmd_quote1 = QUOTE   $@
+      cmd_quote1 = sed -e 's/"/\\"/g' -e 's/^/"/' -e 's/$$/\\n"/' \
+		   $< > $@
+
+$(obj)/config.c: $(src)/config.c.in $(obj)/config.tmp FORCE
+	$(call if_changed,quote2)
+
+quiet_cmd_quote2 = QUOTE   $@
+      cmd_quote2 = sed -e '/CONFIG/{'          \
+		  -e 's/"CONFIG"\;/""/'        \
+		  -e 'r $(obj)/config.tmp'     \
+		  -e 'a""\;'                   \
+		  -e '}'                       \
+		  $< > $@

