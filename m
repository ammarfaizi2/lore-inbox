Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUDIRrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUDIRrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:47:37 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:11862 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261497AbUDIRra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:47:30 -0400
Date: Fri, 9 Apr 2004 19:52:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Marek Szuba <scriptkiddie@wp.pl>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: [2.6.5] A bunch of various minor bugs not fixed since 2.6.4
Message-ID: <20040409175253.GA19855@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Marek Szuba <scriptkiddie@wp.pl>, Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
References: <20040404151245.10d1ddd5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040404151245.10d1ddd5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In general - do not use the kernel headers from userland.
Most of the problems described here is due to wrong usage
of kernel header files.

If you need to use the kernel header files for normal day-to-day
work you have a misconfigured system.

And DO NOT put kernel src in /usr/src/linux - this is only asking 
for trouble.
Put it in /usr/src/linux-2.6.5 for example - with no symlinks to
/usr/src/linux

Some individual comments follows:

> 2. Platform-specific 'asm' symlink doesn't get created by 'make *config'
> I have got no idea how this could have slipped everyone's attention, but
> here it is:

make *config shall do minimal work, and is only supposed to create
.config. No side-effects such as crating a symlink.

> 3. 'make clean' seems to remove too much
> It seems some people cannot be satisfied... Before I complained about
> leftover junk, now I'm complaining about too few leftovers! Anyway, what
> goes away with 'clean' which I believe should only go away with
> 'mrproper':
>  - the include/asm symlink
>  - include/linux/autoconf.h
> Maybe there are more, but these are the two I have already found to
> cause software compilation errors when not present.

Point taken here. New cleaning style is:

clean: Leave enough to build external modules
mrproper: delete all generated files, including .config
distclean: Delete editor and patch backup files

If one needs to do the old trick:
save .config
make mrproper
restore .config

Then something is broken and needs fixing.

	Sam

--- linux-2.6.5/Makefile	2004-04-09 14:03:35.000000000 +0200
+++ mm3/Makefile	2004-04-09 19:39:02.000000000 +0200
@@ -767,36 +767,34 @@ endef
 
 ###
 # Cleaning is done on three levels.
-# make clean     Delete all automatically generated files, including
-#                tools and firmware.
-# make mrproper  Delete the current configuration, and related files
-#                Any core files spread around are deleted as well
+# make clean     Delete most generated files
+#                Leave enough to build external modules
+# make mrproper  Delete the current configuration, and all generated files
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Directories & files removed with 'make clean'
-CLEAN_DIRS  += $(MODVERDIR) include/config include2
-CLEAN_FILES +=	vmlinux System.map \
-		include/linux/autoconf.h include/linux/version.h \
-		include/asm include/linux/modversions.h \
-		kernel.spec .tmp*
+CLEAN_DIRS  += $(MODVERDIR)
+CLEAN_FILES +=	vmlinux System.map kernel.spec .tmp*
 
-# Files removed with 'make mrproper'
-MRPROPER_FILES += .version .config .config.old tags TAGS cscope*
+# Directories & files removed with 'make mrproper'
+MRPROPER_DIRS  += include/config include2
+MRPROPER_FILES += .version .config .config.old tags TAGS cscope* \
+		include/linux/autoconf.h include/linux/version.h \
+                include/asm include/linux/modversions.h \
 
 # clean - Delete all intermediate files
 #
-clean-dirs += $(addprefix _clean_,$(ALL_SUBDIRS) Documentation/DocBook scripts)
-.PHONY: $(clean-dirs) clean archclean mrproper archmrproper distclean
+clean-dirs = $(addprefix _clean_,$(ALL_SUBDIRS))
+.PHONY: $(clean-dirs) clean archclean
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
 clean:		rm-dirs  := $(wildcard $(CLEAN_DIRS))
-mrproper:	rm-dirs  := $(wildcard $(MRPROPER_DIRS))
 quiet_cmd_rmdirs = $(if $(rm-dirs),CLEAN   $(rm-dirs))
       cmd_rmdirs = rm -rf $(rm-dirs)
 
+
 clean:		rm-files := $(wildcard $(CLEAN_FILES))
-mrproper:	rm-files := $(wildcard $(MRPROPER_FILES))
 quiet_cmd_rmfiles = $(if $(rm-files),CLEAN   $(rm-files))
       cmd_rmfiles = rm -rf $(rm-files)
 
@@ -810,10 +808,23 @@ clean: archclean $(clean-dirs)
 
 # mrproper
 #
-distclean: mrproper
-mrproper: clean archmrproper
+mrproper:	rm-dirs  := $(wildcard $(MRPROPER_DIRS))
+mrproper:	rm-files := $(wildcard $(MRPROPER_FILES))
+
+mrproper-dirs = $(addprefix _mrproper_,Documentation/DocBook scripts)
+.PHONY: $(mrproper-dirs) mrproper archmrproper
+$(mrproper-dirs):
+	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
+
+mrproper: clean archmrproper $(mrproper-dirs)
 	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
+
+# distclean
+#
+.PHONY: distclean
+
+distclean: mrproper
 	@find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
