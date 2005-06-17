Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVFQA0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVFQA0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 20:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVFQA0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 20:26:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.173]:10714 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261870AbVFQA0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 20:26:08 -0400
Message-Id: <13345630.1118967959638.JavaMail.servlet@kundenserver>
From: "Arnd Bergmann <arnd@arndb.de>" <arndb@onlinehome.de>
To: <arnd@arndb.de>
To: <akpm@osdl.org>
To: <linux-kernel@vger.kernel.org>
To: <eranian@hpl.hp.com>
To: <davidm@hpl.hp.com>
To: <juhl-lkml@dif.dk>
Subject: Re: [resend][PATCH] avoid signed vs unsigned comparison in
 efi_range_is_wc()
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_101_28108894.1118967959637"
X-Priority: 3
X-Binford: 6100 (more power)
X-Mailer: Webmail
X-Originating-From: 26879984
X-Routing: DE
X-Message-Id: <26879984$1118967959637172.23.4.15918122243@pustefix159.kundenserver.de--1705901592>
Date: Fri, 17 Jun 2005 02:25:59 +0200
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.159
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_101_28108894.1118967959637
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jesper wrote:

>> Jesper, are you interested in my stuff
>
>Certainly.
>

Ok, here is the warning level patch for reference. I'm sending the rest of my stuff
to you off-list since it is rather largish and I don't have a working mail client
on this machine.

      Arnd <><
------=_Part_101_28108894.1118967959637
Content-Type: application/octet-stream; name=warn-levels.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=warn-levels.diff

[PATCH] kbuild: selectable warning levels

This introduces four different levels of compiler warnings to the
kernel build environment. The idea is to enable developers to get the
extra static code checks that newer gcc versions provide without
annoying users with false positives.

I have tested this with gcc versions 2.95 through 4.0 on i386 as
well as some cross builds for x86_64, ppc64 and s390. The conditional
warning settings are needed to get some of the options that pre-4.0
compilers don't support.

I have not tested this at all with non-GNU compilers, so it
probably is not ready for inclusion in -mm at this point.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linus-2.6/Makefile
===================================================================
--- linus-2.6.orig/Makefile	2005-06-17 00:57:11.000000000 +0200
+++ linus-2.6/Makefile	2005-06-17 01:54:36.000000000 +0200
@@ -348,8 +348,7 @@
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
-CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
-	  	   -fno-strict-aliasing -fno-common \
+CFLAGS 		:= -fno-strict-aliasing -fno-common \
 		   -ffreestanding
 AFLAGS		:= -D__ASSEMBLY__
 
@@ -533,11 +532,46 @@
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
 
+# standard warnings
+CWARN_LESS         += -Wall -Wstrict-prototypes -Wno-trigraphs
 # warn about C99 declaration after statement
-CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
+CWARN_LESS         += $(call cc-option,-Wdeclaration-after-statement,)
+CWARN_LESS_COND    +=
+ifdef CONFIG_WARN_ERROR
+CWARN_LESS         += -Werror
+endif
+ifdef CONFIG_WARN_LESS
+CWARN_LESS         += -Wno-deprecated-declarations
+CWARN_LESS_COND    += -Wno-pointer-sign
+CFLAGS             += $(CWARN_LESS) $(call cc-option,$(CWARN_LESS_COND),)
+endif
+
+# warn about common problems
+CWARN_NORMAL       += $(CWARN_LESS) -Winline -Wcast-align -Wundef -Wformat
+CWARN_NORMAL       += -Wmissing-noreturn
+CWARN_NORMAL_COND  += $(CWARN_LESS_COND) -Wdisabled-optimization
+CWARN_NORMAL_COND  += -Wmissing-format-attribute -Wendif-labels
+ifdef CONFIG_WARN_NORMAL
+CWARN_NORMAL_COND  += -Wno-pointer-sign
+CFLAGS             += $(CWARN_NORMAL) $(call cc-option,$(CWARN_NORMAL_COND),)
+endif
 
-# disable pointer signedness warnings in gcc 4.0
-CFLAGS += $(call cc-option,-Wno-pointer-sign,)
+# these can get rather noisy
+CWARN_MORE         += $(CWARN_NORMAL) -Wredundant-decls -Wnested-externs
+CWARN_MORE         += -Wmissing-prototypes -Wwrite-strings -Wshadow
+CWARN_MORE_COND    += $(CWARN_NORMAL_COND)
+ifdef CONFIG_WARN_MORE
+CFLAGS             += $(CWARN_MORE) $(call cc-option,$(CWARN_MORE_COND),)
+endif
+
+# these usually don't do any good
+CWARN_TOOMUCH      += $(CWARN_MORE) -Waggregate-return -Wsign-compare
+CWARN_TOOMUCH      += -W -Wlarger-than-8192 -Wconversion -Wbad-function-cast
+CWARN_TOOMUCH      += -Wcast-qual
+CWARN_TOOMUCH_COND += $(CWARN_MORE_COND) -Wpadded -Wpacked -Wunreachable-code
+ifdef CONFIG_WARN_TOOMUCH
+CFLAGS             += $(CWARN_TOOMUCH) $(call cc-option,$(CWARN_TOOMUCH_COND),)
+endif
 
 # Default kernel image to build when no specific target is given.
 # KBUILD_IMAGE may be overruled on the commandline or
Index: linus-2.6/lib/Kconfig.debug
===================================================================
--- linus-2.6.orig/lib/Kconfig.debug	2005-06-17 00:57:11.000000000 +0200
+++ linus-2.6/lib/Kconfig.debug	2005-06-17 01:52:22.000000000 +0200
@@ -159,3 +159,49 @@
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.
 
+choice
+	prompt "Compiler warning level"
+	default WARN_NORMAL
+	help
+	  Select how much the compiler should warn about kernel code.
+	  If unsure, select "Normal".
+
+config WARN_LESS
+	bool "Minimal"
+	help
+	  In minimal warning mode, only the traditional -Wall warnings are
+	  enabled, with the exception of deprecated interfaces. For common
+	  configurations, there ought to be no warnings at this level.
+	  Select this if you also want to built with -Werror.
+
+config WARN_NORMAL
+	bool "Normal"
+	help
+	  The normal warning level will warn about some common problems that
+	  may need to be fixed up. If you are maintaining code that is
+	  warned about at this level, you should try to fix that.
+
+config WARN_MORE
+	bool "More"
+	help
+	  Select "More" to enable some warnings that are rather noisy for
+	  existing parts of the kernel. This is most useful to check new code
+	  before it is submitted for inclusion.
+
+config WARN_TOOMUCH
+	bool "All"
+	help
+	  Enabling all warnings will create many warnings about good code that
+	  becomes less readable if you try to work around the warning. Patches
+	  to shut up warnings at this level are likely to be rejected unless
+	  they fix real problems.
+
+endchoice
+
+config WARN_ERROR
+	bool "Make all build warnings errors"
+	depends on WARN_LESS
+	help
+	  When this option is enabled, all compiler warnings are turned into
+	  errors, making it impossible to build the kernel while some warnings
+	  are left.

------=_Part_101_28108894.1118967959637--

