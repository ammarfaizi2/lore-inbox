Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWHHSkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWHHSkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWHHSkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:40:20 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:30432 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S965027AbWHHSkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:40:18 -0400
Date: Tue, 8 Aug 2006 20:39:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       ebiederm@xmission.com
Subject: Re: [PATCH] CONFIG_RELOCATABLE modpost fix
Message-ID: <20060808183954.GA8300@mars.ravnborg.org>
References: <20060808083307.391.45887.sendpatchset@cherry.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808083307.391.45887.sendpatchset@cherry.local>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 05:32:11PM +0900, Magnus Damm wrote:
> CONFIG_RELOCATABLE modpost fix
> 
> Run modpost on vmlinux regardless of CONFIG_MODULES.
Below is my take on this one.
- Dropped -rR since this is default now
- Dropped subdir- assignment in scripts/Makefile since it is redundant
- Always pass vmlinux ti modpost so we have full updated info
- Print out number of modules being mod posted to distingush from
  vmlinux one
- use vmlinux as target name to enable nicer quiet command print

	Sam

diff --git a/Makefile b/Makefile
index 72ef9f6..6b86f4e 100644
--- a/Makefile
+++ b/Makefile
@@ -724,6 +724,7 @@ endif # ifdef CONFIG_KALLSYMS
 # vmlinux image - including updated kernel symbols
 vmlinux: $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) $(kallsyms.o) FORCE
 	$(call if_changed_rule,vmlinux__)
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost $@
 	$(Q)rm -f .old_version
 
 # The actual objects are generated when descending, 
diff --git a/scripts/Makefile b/scripts/Makefile
index d531a1f..ea41de8 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -19,7 +19,7 @@ # The following hostprogs-y programs are
 hostprogs-y += unifdef
 
 subdir-$(CONFIG_MODVERSIONS) += genksyms
-subdir-$(CONFIG_MODULES)     += mod
+subdir-y                     += mod
 
 # Let clean descend into subdirs
 subdir-	+= basic kconfig package
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 0a64688..9137df2 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -51,19 +51,25 @@ _modpost: $(modules)
 
 # Step 2), invoke modpost
 #  Includes step 3,4
-quiet_cmd_modpost = MODPOST
+quiet_cmd_modpost = MODPOST $(words $(filter-out vmlinux FORCE, $^)) modules
       cmd_modpost = scripts/mod/modpost            \
         $(if $(CONFIG_MODVERSIONS),-m)             \
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a,)  \
 	$(if $(KBUILD_EXTMOD),-i,-o) $(kernelsymfile) \
 	$(if $(KBUILD_EXTMOD),-I $(modulesymfile)) \
 	$(if $(KBUILD_EXTMOD),-o $(modulesymfile)) \
-	$(filter-out FORCE,$^)
+	$(wildcard vmlinux) $(filter-out FORCE,$^)
 
 PHONY += __modpost
-__modpost: $(wildcard vmlinux) $(modules:.ko=.o) FORCE
+__modpost: $(modules:.ko=.o) FORCE
 	$(call cmd,modpost)
 
+quiet_cmd_kernel-mod = MODPOST $@
+      cmd_kernel-mod = $(cmd_modpost)
+
+vmlinux: FORCE
+	$(call cmd,kernel-mod)
+
 # Declare generated files as targets for modpost
 $(symverfile):         __modpost ;
 $(modules:.ko=.mod.c): __modpost ;
