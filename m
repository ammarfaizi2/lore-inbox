Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSFQMgl>; Mon, 17 Jun 2002 08:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSFQMgk>; Mon, 17 Jun 2002 08:36:40 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:11688 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S312601AbSFQMgi>;
	Mon, 17 Jun 2002 08:36:38 -0400
Date: Mon, 17 Jun 2002 14:32:52 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206171232.OAA00172@harpo.it.uu.se>
To: kai@tp1.ruhr-uni-bochum.de
Subject: 2.5.22 broke modversions
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something in the 2.5.22 Makefile/Rule.make changes broke
modversions on my P4 box. For some reason, a number of
exporting objects, including arch/i386/kernel/i386_ksyms,
weren't given -D__GENKSYMS__ at genksym-time, with the
effect that the resulting .ver files became empty, and the
kernel exported the symbols with unexpanded _R__ver_ suffixes.

Modversions worked in 2.5.21. I didn't see anything obvious
in patch-2.5.22 what could explain this, but I did notice a
tendency of touching files as a means of maintaining dependencies.
This may not actually work, unless you have a slow CPU or a
file system with millisecond or better st_mtime resolution --
most only maintain whole-second resolution st_mtimes.
(My modversions fix in the 2.4.0-test series, which moved the
modversions.h creation/update to a separate rule after make dep,
was due to this very problem.)

For now, I'm using the workaround below.

/Mikael

--- linux-2.5.22/Rules.make.~1~	Mon Jun 17 10:15:13 2002
+++ linux-2.5.22/Rules.make	Mon Jun 17 13:45:27 2002
@@ -147,7 +147,7 @@
 quiet_cmd_cc_ver_c = MKVER  include/linux/modules/$(RELDIR)/$*.ver
 define cmd_cc_ver_c
 	mkdir -p $(dir $@); \
-	$(CPP) $(c_flags) $< | $(GENKSYMS) $(genksyms_smp_prefix) \
+	$(CPP) $(c_flags) -D__GENKSYMS__ $< | $(GENKSYMS) $(genksyms_smp_prefix) \
 	  -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp; \
 	if [ ! -r $@ ] || cmp -s $@ $@.tmp; then \
 	  touch $(TOPDIR)/include/linux/modversions.h; \
