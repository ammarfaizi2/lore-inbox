Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261947AbSIYJCa>; Wed, 25 Sep 2002 05:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261948AbSIYJCa>; Wed, 25 Sep 2002 05:02:30 -0400
Received: from dp.samba.org ([66.70.73.150]:40120 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261947AbSIYJCa>;
	Wed, 25 Sep 2002 05:02:30 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Make KBUILD_VERBOSE=0 work better under emacs
Date: Wed, 25 Sep 2002 19:07:28 +1000
Message-Id: <20020925090745.C44712C188@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"M-x compile" in emacs stars a compilation and can jump to the next
error.  With KBUILD_VERSBOSE=0 (as I have in my env, great work Kai)
it can't figure out the directory, since it doesn't see the make[XXX]
markers.

This makes it work (EMACS=t in the environment when using emacs to
compile).

Thanks!
Rusty.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.38/Rules.make working-2.5.38-gfpcheck/Rules.make
--- linux-2.5.38/Rules.make	Wed Sep 18 16:03:55 2002
+++ working-2.5.38-gfpcheck/Rules.make	Wed Sep 25 17:46:49 2002
@@ -517,6 +517,13 @@ ifneq ($(cmd_files),)
   include $(cmd_files)
 endif
 
+# Emacs compile mode works best with relative paths to find files (OK
+# if verbose, as it tracks the make[1] entries and exits, etc.)
+
+ifeq ($(EMACS)$(KBUILD_VERBOSE),t0)
+  filter-output = 2>&1 | sed 's \(^[^/][A-Za-z0-9_./-]*:[ 0-9]\) $(RELDIR)/\1 '
+endif
+
 # function to only execute the passed command if necessary
 
 if_changed = $(if $(strip $? \
@@ -536,7 +543,7 @@ if_changed_dep = $(if $(strip $? $(filte
 			  $(filter-out $(cmd_$@),$(cmd_$(1)))),\
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) \
-	$(cmd_$(1)); \
+	$(cmd_$(1)) $(filter-output); \
 	$(TOPDIR)/scripts/fixdep $(depfile) $@ $(TOPDIR) '$(cmd_$(1))' > $(@D)/.$(@F).tmp; \
 	rm -f $(depfile); \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)



--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
