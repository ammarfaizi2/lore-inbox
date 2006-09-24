Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWIXVTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWIXVTF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWIXVRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:17:53 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:18140 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932136AbWIXVNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:11 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Aron Griffis <aron@hp.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 23/28] kbuild: Extend kbuild/defconfig tags support to exuberant ctags
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:19 +0200
Message-Id: <11591327063625-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1159132706126-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org> <11591327061478-git-send-email-sam@ravnborg.org> <115913
 2706423-git-send-email-sam@ravnborg.org> <115913270694-git-send-email-sam@ravnborg.org> <1159132706126-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aron Griffis <aron@hp.com>

The following patch extends kbuild/defconfig tags support to exuberant
ctags.  The previous support is only for emacs ctags/etags programs.

This patch also corrects the kconfig regex for the emacs invocation.
Previously it would miss some instances because it assumed /^config
instead of /^[ \t]*config

Signed-off-by: Aron Griffis <aron@hp.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile |   44 +++++++++++++++++++++++++++-----------------
 1 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index cd50298..13bc589 100644
--- a/Makefile
+++ b/Makefile
@@ -1273,6 +1273,31 @@ define all-defconfigs
 	$(call find-sources,'defconfig')
 endef
 
+define xtags
+	if $1 --version 2>&1 | grep -iq exuberant; then \
+	    $(all-sources) | xargs $1 -a \
+		-I __initdata,__exitdata,__acquires,__releases \
+		-I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL \
+		--extra=+f --c-kinds=+px; \
+	    $(all-kconfigs) | xargs $1 -a \
+		--langdef=kconfig \
+		--language-force=kconfig \
+		--regex-kconfig='/^[[:blank:]]*config[[:blank:]]+([[:alnum:]_]+)/\1/'; \
+	    $(all-defconfigs) | xargs $1 -a \
+		--langdef=dotconfig \
+		--language-force=dotconfig \
+		--regex-dotconfig='/^#?[[:blank:]]*(CONFIG_[[:alnum:]_]+)/\1/'; \
+	elif $1 --version 2>&1 | grep -iq emacs; then \
+	    $(all-sources) | xargs $1 -a; \
+	    $(all-kconfigs) | xargs $1 -a \
+		--regex='/^[ \t]*config[ \t]+\([a-zA-Z0-9_]+\)/\1/'; \
+	    $(all-defconfigs) | xargs $1 -a \
+		--regex='/^#?[ \t]?\(CONFIG_[a-zA-Z0-9_]+\)/\1/'; \
+	else \
+	    $(all-sources) | xargs $1 -a; \
+	fi
+endef
+
 quiet_cmd_cscope-file = FILELST cscope.files
       cmd_cscope-file = (echo \-k; echo \-q; $(all-sources)) > cscope.files
 
@@ -1286,31 +1311,16 @@ cscope: FORCE
 quiet_cmd_TAGS = MAKE   $@
 define cmd_TAGS
 	rm -f $@; \
-	ETAGSF=`etags --version | grep -i exuberant >/dev/null &&     \
-                echo "-I __initdata,__exitdata,__acquires,__releases  \
-                      -I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL              \
-                      --extra=+f --c-kinds=+px"`;                     \
-                $(all-sources) | xargs etags $$ETAGSF -a;             \
-	if test "x$$ETAGSF" = x; then                                 \
-		$(all-kconfigs) | xargs etags -a                      \
-		--regex='/^config[ \t]+\([a-zA-Z0-9_]+\)/\1/';        \
-		$(all-defconfigs) | xargs etags -a                    \
-		--regex='/^#?[ \t]?\(CONFIG_[a-zA-Z0-9_]+\)/\1/';     \
-	fi
+	$(call xtags,etags)
 endef
 
 TAGS: FORCE
 	$(call cmd,TAGS)
 
-
 quiet_cmd_tags = MAKE   $@
 define cmd_tags
 	rm -f $@; \
-	CTAGSF=`ctags --version | grep -i exuberant >/dev/null &&     \
-                echo "-I __initdata,__exitdata,__acquires,__releases  \
-                      -I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL              \
-                      --extra=+f --c-kinds=+px"`;                     \
-                $(all-sources) | xargs ctags $$CTAGSF -a
+	$(call xtags,ctags)
 endef
 
 tags: FORCE
-- 
1.4.1

