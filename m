Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSGGBwR>; Sat, 6 Jul 2002 21:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSGGBwQ>; Sat, 6 Jul 2002 21:52:16 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:59147 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314149AbSGGBwP>;
	Sat, 6 Jul 2002 21:52:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Albert Cranford <ac9410@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.25 remove unnecessary recompiles when changing EXTRAVERSION 
In-reply-to: Your message of "Sat, 06 Jul 2002 16:47:21 -0400."
             <3D275759.A0B105A8@bellsouth.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Jul 2002 11:54:40 +1000
Message-ID: <6291.1026006880@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jul 2002 16:47:21 -0400, 
Albert Cranford <ac9410@bellsouth.net> wrote:
>What do the changes to Makefile-2.5 look like for
>Kbuild-3.1 ?

This has had two minutes of testing.  Apply after core-21, it should
auto detect if the uts_release patch has been applied or not.  This
will be included in kbuild 2.5 once the uts_release.h patch is included
in 2.5.x, I am holding off in case the uts_release patch has to change.

Index: 18.99/Makefile-2.5
--- 18.99/Makefile-2.5 Fri, 05 Jul 2002 17:16:39 +1000 kaos (linux-2.4/E/d/40_Makefile-2 1.32.2.27.1.8 644)
+++ 18.99(w)/Makefile-2.5 Sun, 07 Jul 2002 11:52:02 +1000 kaos (linux-2.4/E/d/40_Makefile-2 1.32.2.27.1.8 644)
@@ -588,13 +588,24 @@ endif
 
 export KERNELRELEASE VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION USERVERSION
 
+# This code has to work on kernels with and without a separate uts_release.h.
+# If module.h still uses UTS_RELEASE then then assume that version.h must
+# include uts_release.h.
+
+ifneq ($(shell grep UTS_RELEASE $(KBUILD_SRCTREE_000)include/linux/module.h),)
+  include_uts_release	:= \#include <linux/uts_release.h>
+else
+  include_uts_release	:= /* uts_release.h is now handled separately */
+endif
+
 $(KBUILD_OBJTREE)include/linux/version.h: $(KBUILD_OBJTREE)A_version FORCE_BUILD
 	@cd $(KBUILD_OBJTREE)
 ifeq ($(KBUILD_WRITABLE),y)
 	@mkdir -p $(KBUILD_OBJTREE)include/linux
-	@(echo \#include \<linux/uts_release.h\> && \
+	@(echo '$(include_uts_release)' && \
 	  echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)` && \
-	  echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))' \
+	  echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))' && \
+	  echo '#define KERNEL_VERSION_STRING "$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)"' \
 	 ) > $(KBUILD_OBJTREE).tmp_version.h && \
 	 (cmp -s $(KBUILD_OBJTREE).tmp_version.h $@ || mv -f $(KBUILD_OBJTREE).tmp_version.h $@)
 endif

