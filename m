Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266733AbSKOVUH>; Fri, 15 Nov 2002 16:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266746AbSKOVUH>; Fri, 15 Nov 2002 16:20:07 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:4624 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266733AbSKOVTo>;
	Fri, 15 Nov 2002 16:19:44 -0500
Date: Fri, 15 Nov 2002 22:25:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Nicolas Pitre <nico@cam.org>, Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
Message-ID: <20021115212517.GA10080@mars.ravnborg.org>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Steinmetz <ast@domdv.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021115145312.GA1320@mars.ravnborg.org> <Pine.LNX.3.96.1021115142113.10508E-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021115142113.10508E-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 02:29:54PM -0500, Bill Davidsen wrote:
> > I have explained how I would like it to work - any comments on that proposal?
> 
>   Same comment, I want (a) something which will remake everything
> including *versions.h to be sure I didn't mess anything up, and (b) as a
> but removed the editor and patch backup files ready for distribution. I
> don't want to lose the patch backup files (I care less about editor files,
> my chosen editor doesn't make them) but I want to be able to easily
> identify what has changed without keeping a full unmodified copy of the
> tree.
Here is first try:
- clean now deletes all generated files except .config + .config.old
- mrproper in addition to clean only deleted .config + .config.old
- distclean in addition ot mrproper deletes backupfiles as usual.

It does not break architectures but they are also affected by the fact that
clean has taken over the job from mrproper.
So archclean and archmrproper has become the same.

I have not changed what is deleted, the difference is that I have moved
even more to the clean stage.

Try with 
$make KBUILD_VERBOSE=0 distclean
and let me know if more info is required in the condensed format.

	Sam

===== Makefile 1.346 vs edited =====
--- 1.346/Makefile	Sat Nov  9 05:08:32 2002
+++ edited/Makefile	Fri Nov 15 22:15:29 2002
@@ -662,20 +662,17 @@
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Files removed with 'make clean'
-CLEAN_FILES += vmlinux System.map MC*
-
-# Files removed with 'make mrproper'
-MRPROPER_FILES += \
+CLEAN_FILES += vmlinux System.map MC* \
 	include/linux/autoconf.h include/linux/version.h \
 	.version .config .config.old config.in config.old \
 	.menuconfig.log \
 	include/asm \
 	.hdepend include/linux/modversions.h \
 	tags TAGS kernel.spec \
-	.tmp*
+	.tmp* $(MRPROPER_FILES)
 
 # Directories removed with 'make mrproper'
-MRPROPER_DIRS += \
+CLEAN_DIRS += $(MRPROPER_DIRS) \
 	.tmp_export-objs \
 	include/config \
 	include/linux/modules
@@ -687,27 +684,37 @@
 $(addprefix _clean_,$(clean-dirs)):
 	$(Q)$(MAKE) -f scripts/Makefile.clean obj=$(patsubst _clean_%,%,$@)
 
-quiet_cmd_rmclean = RM  $$(CLEAN_FILES)
-cmd_rmclean	  = rm -f $(CLEAN_FILES)
-clean: archclean $(addprefix _clean_,$(clean-dirs))
-	$(call cmd,rmclean)
-	@find . $(RCS_FIND_IGNORE) \
+quiet_cmd_rmclean  = CLEAN   $$(CLEAN_FILES)
+      cmd_rmclean  = rm -f    $(CLEAN_FILES)
+quiet_cmd_rmdclean = CLEAN   $$(CLEAN_DIRS)
+      cmd_rmdclean = rm -rf   $(CLEAN_DIRS)
+quiet_cmd_rmsclean = CLEAN   *.[oas] in the srctree
+      cmd_rmsclean = find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.[oas]' -o -name '.*.cmd' -o -name '.*.d' \
 		-o -name '.*.tmp' \) -type f -print | xargs rm -f
 
-# mrproper - delete configuration + modules + core files
+clean: archclean archmrproper $(addprefix _clean_,$(clean-dirs))
+	$(call cmd,rmclean)
+	$(call cmd,rmdclean)
+	$(call cmd,rmsclean)
+
+# mrproper - 'make clean' + delete configuration
 #
-quiet_cmd_mrproper = RM  $$(MRPROPER_DIRS) + $$(MRPROPER_FILES)
-cmd_mrproper = rm -rf $(MRPROPER_DIRS) && rm -f $(MRPROPER_FILES)
-mrproper distclean: clean archmrproper
-	@echo '  Making $@ in the srctree'
-	@find . $(RCS_FIND_IGNORE) \
+quiet_cmd_mrproper = RM      .config .config.old
+      cmd_mrproper = rm -rf .config .config.old
+mrproper: clean archmrproper
+	$(call cmd,mrproper)
+
+quiet_cmd_distclean = DISTCLEAN
+      cmd_distclean = find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
-		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
+		-o -name '*.bak' -o -name '\#*\#' -o -name '.*.orig' \
 	 	-o -name '.*.rej' -o -size 0 \
 		-o -name '*%' -o -name '.*.cmd' -o -name 'core' \) \
 		-type f -print | xargs rm -f
-	$(call cmd,mrproper)
+
+distclean: mrproper
+	$(call cmd,distclean)
 
 # Generate tags for editors
 # ---------------------------------------------------------------------------
@@ -750,8 +757,9 @@
 
 help:
 	@echo  'Cleaning targets:'
-	@echo  '  clean		- remove most generated files but keep the config'
-	@echo  '  mrproper	- remove all generated files + config + various backup files'
+	@echo  '  clean		- remove all generated files but keep the config'
+	@echo  '  mrproper	- clean + configuration is removed'
+	@echo  '  distclean     - mrproper + all editor and patch leftovers removed'
 	@echo  ''
 	@echo  'Configuration targets:'
 	@echo  '  oldconfig	- Update current config utilising a line-oriented program'
