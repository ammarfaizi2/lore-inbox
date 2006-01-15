Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751896AbWAOLTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbWAOLTb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 06:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWAOLTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 06:19:31 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:17419 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751896AbWAOLTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 06:19:30 -0500
Date: Sun, 15 Jan 2006 12:19:22 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ren? Rebe <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
Subject: Re: kbuild / KERNELRELEASE not rebuild correctly anymore
Message-ID: <20060115111922.GA13673@mars.ravnborg.org>
References: <200601151051.14827.rene@exactcode.de> <20060115100530.GB8195@mars.ravnborg.org> <200601151141.30876.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601151141.30876.rene@exactcode.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 11:41:30AM +0100, Ren? Rebe wrote:
> >
> > So the real fix is to error out when .kernelrelease does not exists.
> > See attached patch.
> 
> You expect us to run make prepare before make menuconfig or simillar?
> That sounds a bit odd ...

The kernelrelease depends on the actual configuration.
So without having completed the make *config step kbuild cannot tell the
correct kernelrelease.

Now with the patch attached to last mail kbuild will now error out in
case there is no valid kernelrelease. Thats obviously only a hack, since
we need to error out when .config has been updated and the new
kernelrelease has not been created.

Maybe the better approach would be always to create the .kernelrelease
file as part of the configuration - based on the principle of least
suprise.
See attached patch.

	Sam
	
diff --git a/Makefile b/Makefile
index deedaf7..4ab0141 100644
--- a/Makefile
+++ b/Makefile
@@ -433,6 +433,7 @@ export KBUILD_DEFCONFIG
 config %config: scripts_basic outputmakefile FORCE
 	$(Q)mkdir -p include/linux
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
+	$(Q)$(MAKE) .kernelrelease
 
 else
 # ===========================================================================
@@ -783,12 +784,13 @@ endif
 localver-full = $(localver)$(localver-auto)
 
 # Store (new) KERNELRELASE string in .kernelrelease
+quiet_cmd_kernelrelease = GEN     $@
+      cmd_kernelrelease = rm -f $@; echo $(kernelrelease) > $@
+
 kernelrelease = \
        $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(localver-full)
 .kernelrelease: FORCE
-	$(Q)rm -f .kernelrelease
-	$(Q)echo $(kernelrelease) > .kernelrelease
-	$(Q)echo "  Building kernel $(kernelrelease)"
+	$(call cmd,kernelrelease)
 
 
 # Things we need to do before we recursively start building the kernel
@@ -808,6 +810,7 @@ kernelrelease = \
 # 1) Check that make has not been executed in the kernel src $(srctree)
 # 2) Create the include2 directory, used for the second asm symlink
 prepare3: .kernelrelease
+	$(Q)echo "  Building kernel $(kernelrelease)"
 ifneq ($(KBUILD_SRC),)
 	@echo '  Using $(srctree) as source for kernel'
 	$(Q)if [ -f $(srctree)/.config ]; then \
@@ -1301,7 +1304,8 @@ checkstack:
 	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
 
 kernelrelease:
-	@echo $(KERNELRELEASE)
+	$(if $(wildcard .kernelrelease), $(Q)echo $(KERNELRELEASE), \
+	$(error kernelrelease not valid - run 'make *config' to update it))
 kernelversion:
 	@echo $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
