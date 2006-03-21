Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWCUQhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWCUQhJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWCUQfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:35:47 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29708 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932416AbWCUQVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:11 -0500
Cc: Jan Beulich <jbeulich@novell.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 12/46] kbuild: consolidate command line escaping
In-Reply-To: <1142958055134-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <1142958055873-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While the recent change to also escape # symbols when storing C-file
compilation command lines was helpful, it should be in effect for all
command lines, as much as the dollar escaping should be in effect for
C-source compilation commands. Additionally, for better readability and
maintenance, consolidating all the escaping (single quotes, dollars,
and now sharps) was also desirable.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/Kbuild.include |   15 +++++++--------
 scripts/Makefile.build |    8 +++-----
 scripts/basic/fixdep.c |   14 ++------------
 3 files changed, 12 insertions(+), 25 deletions(-)

6176aa9ae4b83e1957d3031774f8a8e59ff97420
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 92ce94b..3e7e0b2 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -88,8 +88,7 @@ cc-ifversion = $(shell if [ $(call cc-ve
 build := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.build obj
 
 # If quiet is set, only print short version of command
-cmd = @$(if $($(quiet)cmd_$(1)),\
-      echo '  $(call escsq,$($(quiet)cmd_$(1)))' &&) $(cmd_$(1))
+cmd = @$(echo-cmd) $(cmd_$(1))
 
 # Add $(obj)/ for paths that is not absolute
 objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
@@ -112,24 +111,24 @@ endif
 echo-cmd = $(if $($(quiet)cmd_$(1)), \
 	echo '  $(call escsq,$($(quiet)cmd_$(1)))';)
 
+make-cmd = $(subst \#,\\\#,$(subst $$,$$$$,$(call escsq,$(cmd_$(1)))))
+
 # function to only execute the passed command if necessary
 # >'< substitution is for echo to work, >$< substitution to preserve $ when reloading .cmd file
 # note: when using inline perl scripts [perl -e '...$$t=1;...'] in $(cmd_xxx) double $$ your perl vars
 # 
 if_changed = $(if $(strip $? $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
 	@set -e; \
-	$(echo-cmd) \
-	$(cmd_$(1)); \
-	echo 'cmd_$@ := $(subst $$,$$$$,$(call escsq,$(cmd_$(1))))' > $(@D)/.$(@F).cmd)
+	$(echo-cmd) $(cmd_$(1)); \
+	echo 'cmd_$@ := $(make-cmd)' > $(@D)/.$(@F).cmd)
 
 # execute the command and also postprocess generated .d dependencies
 # file
 if_changed_dep = $(if $(strip $? $(filter-out FORCE $(wildcard $^),$^)\
 	$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),                  \
 	@set -e; \
-	$(echo-cmd) \
-	$(cmd_$(1)); \
-	scripts/basic/fixdep $(depfile) $@ '$(subst $$,$$$$,$(call escsq,$(cmd_$(1))))' > $(@D)/.$(@F).tmp; \
+	$(echo-cmd) $(cmd_$(1)); \
+	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(@D)/.$(@F).tmp; \
 	rm -f $(depfile); \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2737765..6ac96ea 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -178,12 +178,10 @@ cmd_modversions =							\
 endif
 
 define rule_cc_o_c
-	$(if $($(quiet)cmd_checksrc),echo '  $($(quiet)cmd_checksrc)';)   \
-	$(cmd_checksrc)							  \
-	$(if $($(quiet)cmd_cc_o_c),echo '  $(call escsq,$($(quiet)cmd_cc_o_c))';)  \
-	$(cmd_cc_o_c);							  \
+	$(call echo-cmd,checksrc) $(cmd_checksrc)			  \
+	$(call echo-cmd,cc_o_c) $(cmd_cc_o_c);				  \
 	$(cmd_modversions)						  \
-	scripts/basic/fixdep $(depfile) $@ '$(call escsq,$(cmd_cc_o_c))' > $(@D)/.$(@F).tmp;  \
+	scripts/basic/fixdep $(depfile) $@ '$(call make-cmd,cc_o_c)' > $(@D)/.$(@F).tmp;  \
 	rm -f $(depfile);						  \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd
 endef
diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 679124b..668a11a 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -132,20 +132,10 @@ void usage(void)
 
 /*
  * Print out the commandline prefixed with cmd_<target filename> :=
- * If commandline contains '#' escape with '\' so make to not see
- * the '#' as a start-of-comment symbol
- **/
+ */
 void print_cmdline(void)
 {
-	char *p = cmdline;
-
-	printf("cmd_%s := ", target);
-	for (; *p; p++) {
-		if (*p == '#')
-			printf("\\");
-		printf("%c", *p);
-	}
-	printf("\n\n");
+	printf("cmd_%s := %s\n\n", target, cmdline);
 }
 
 char * str_config  = NULL;
-- 
1.0.GIT


