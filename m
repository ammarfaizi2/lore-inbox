Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWDEKvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWDEKvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 06:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWDEKvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 06:51:15 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:54287 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751192AbWDEKvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 06:51:15 -0400
Date: Wed, 5 Apr 2006 12:51:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: regression in kbiuld with O=
Message-ID: <20060405105107.GA22375@mars.ravnborg.org>
References: <20060404152430.GG27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404152430.GG27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 04:24:30PM +0100, Al Viro wrote:
> make O=../test kernel/sched.o produces kernel/sched.o is source tree
> now.  AFAICS, breakage started in 06300b21f4c79fd1578f4b7ca4b314fbab61a383
> (kbuild: support building individual files for external modules).

Fixed by patch below.
Tested with diverse combinations of separate outut directories and
external modules.
The target-dir variable was renamed to build-dir to better relect usage.
Also added dependency on prepare for %.ko targets so it can be used on
a cleaned tree.

	Sam

diff --git a/Makefile b/Makefile
index b401942..131950c 100644
--- a/Makefile
+++ b/Makefile
@@ -1275,40 +1275,43 @@ kernelversion:
 
 # Single targets
 # ---------------------------------------------------------------------------
-# The directory part is taken from first prerequisite, so this
-# works even with external modules
+# Single targets are compatible with:
+# - build whith mixed source and output
+# - build with separate output dir 'make O=...'
+# - external modules
+#
+#  target-dir => where to store outputfile
+#  build-dir  => directory in kernel source tree to use
+
+ifeq ($(KBUILD_EXTMOD),)
+        build-dir  = $(dir $@)
+        target-dir = $(dir $@)
+else
+        zap-slash=$(filter-out .,$(patsubst %/,%,$(dir $@)))
+        build-dir  = $(KBUILD_EXTMOD)$(if $(zap-slash),/$(zap-slash))
+        target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
+endif
+
 %.s: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.i: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.o: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.lst: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.s: %.S prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.o: %.S prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
-
-# For external modules we shall include any directory of the target,
-# but usual case there is no directory part.
-# make M=`pwd` module.o     => $(dir $@)=./
-# make M=`pwd` foo/module.o => $(dir $@)=foo/
-# make M=`pwd` /            => $(dir $@)=/
- 
-ifeq ($(KBUILD_EXTMOD),)
-        target-dir = $(@D)
-else
-        zap-slash=$(filter-out .,$(patsubst %/,%,$(dir $@)))
-        target-dir = $(KBUILD_EXTMOD)$(if $(zap-slash),/$(zap-slash))
-endif
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 
-/ %/:      scripts prepare FORCE
+# Modules
+/ %/: prepare scripts FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
-	$(build)=$(target-dir)
-%.ko: scripts FORCE
+	$(build)=$(build-dir)
+%.ko: prepare scripts FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
-	$(build)=$(target-dir) $(@:.ko=.o)
+	$(build)=$(build-dir) $(@:.ko=.o)
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
 # FIXME Should go into a make.lib or something 
