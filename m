Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWIUE1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWIUE1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 00:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIUE1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 00:27:09 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:17844 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750789AbWIUE1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 00:27:08 -0400
X-IMAP-Sender: agriffis
Date: Thu, 21 Sep 2006 00:27:02 -0400
From: Aron Griffis <aron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Masatake YAMATO <jet@gyve.org>
Subject: Extend kbuild/defconfig tags support to exuberant ctags
Message-ID: <20060921042659.GA32242@fc.hp.com>
Mail-Followup-To: Aron Griffis <aron@hp.com>,
	linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
	Masatake YAMATO <jet@gyve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch extends kbuild/defconfig tags support to exuberant
ctags.  The previous support is only for emacs ctags/etags programs.

This patch also corrects the kconfig regex for the emacs invocation.
Previously it would miss some instances because it assumed /^config
instead of /^[ \t]*config

Signed-off-by: Aron Griffis <aron@hp.com>

diff -r dc1d277d06e0 -r 8bec009f95de Makefile
--- a/Makefile	Wed Sep 20 04:00:07 2006 +0000
+++ b/Makefile	Thu Sep 21 00:11:02 2006 -0400
@@ -1264,6 +1264,31 @@ define all-defconfigs
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
 
@@ -1277,31 +1302,16 @@ quiet_cmd_TAGS = MAKE   $@
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
