Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWA3JEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWA3JEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWA3JEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:04:21 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:30916
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932139AbWA3JEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:04:07 -0500
Message-Id: <43DDE4AB.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 30 Jan 2006 10:04:27 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] consolidate command line escaping
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartAB89388B.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartAB89388B.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Jan Beulich <jbeulich@novell.com>

While the recent change to also escape # symbols when storing C-file
compilation command lines was helpful, it should be in effect for all
command lines, as much as the dollar escaping should be in effect for
C-source compilation commands. Additionally, for better readability and
maintenance, consolidating all the escaping (single quotes, dollars,
and now sharps) was also desirable.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>



--=__PartAB89388B.1__=
Content-Type: text/plain; name="linux-2.6.16-rc1-cmd-escape.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.16-rc1-cmd-escape.patch"

From: Jan Beulich <jbeulich@novell.com>

While the recent change to also escape # symbols when storing C-file
compilation command lines was helpful, it should be in effect for all
command lines, as much as the dollar escaping should be in effect for
C-source compilation commands. Additionally, for better readability and
maintenance, consolidating all the escaping (single quotes, dollars,
and now sharps) was also desirable.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc1/scripts/Kbuild.include 2.6.16-rc1-cmd-escape/scripts/Kbuild.include
--- /home/jbeulich/tmp/linux-2.6.16-rc1/scripts/Kbuild.include	2006-01-27 15:10:56.000000000 +0100
+++ 2.6.16-rc1-cmd-escape/scripts/Kbuild.include	2006-01-27 09:49:15.000000000 +0100
@@ -51,8 +51,7 @@ endef
 build := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.build obj
 
 # If quiet is set, only print short version of command
-cmd = @$(if $($(quiet)cmd_$(1)),\
-      echo '  $(call escsq,$($(quiet)cmd_$(1)))' &&) $(cmd_$(1))
+cmd = @$(echo-cmd) $(cmd_$(1))
 
 # Add $(obj)/ for paths that is not absolute
 objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
@@ -75,24 +74,24 @@ endif
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
 
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc1/scripts/Makefile.build 2.6.16-rc1-cmd-escape/scripts/Makefile.build
--- /home/jbeulich/tmp/linux-2.6.16-rc1/scripts/Makefile.build	2006-01-27 15:10:56.000000000 +0100
+++ 2.6.16-rc1-cmd-escape/scripts/Makefile.build	2006-01-25 09:55:53.000000000 +0100
@@ -177,12 +177,10 @@ cmd_modversions =							\
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
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc1/scripts/basic/fixdep.c 2.6.16-rc1-cmd-escape/scripts/basic/fixdep.c
--- /home/jbeulich/tmp/linux-2.6.16-rc1/scripts/basic/fixdep.c	2006-01-27 15:10:56.000000000 +0100
+++ 2.6.16-rc1-cmd-escape/scripts/basic/fixdep.c	2006-01-27 09:50:59.000000000 +0100
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

--=__PartAB89388B.1__=--
