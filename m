Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSG1MvI>; Sun, 28 Jul 2002 08:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316397AbSG1MvI>; Sun, 28 Jul 2002 08:51:08 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:17934 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316161AbSG1MvH>;
	Sun, 28 Jul 2002 08:51:07 -0400
Date: Sun, 28 Jul 2002 15:02:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, torvlads@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Add new define do_cmd
Message-ID: <20020728150200.A8414@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While cleaning up the docbook makefile I missed a possibility
to adhere to KBUILD_VERBOSE. To do this I have now implemented
do_cmd in rules.make, for more general usage.

	Sam

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.477   -> 1.478  
#	          Rules.make	1.67    -> 1.68   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/28	sam@mars.ravnborg.org	1.478
# [PATCH] kbuild: Add new define do_cmd
# do_cmd is a nice shorthand when creating rules that in one line
# shall adhere to KBUILD_VERBOSE and make -s.
# So far the only user is the docbook makefile
# --------------------------------------------
#
diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Sun Jul 28 12:48:13 2002
+++ b/Rules.make	Sun Jul 28 12:48:13 2002
@@ -553,3 +553,22 @@
 # If quiet is set, only print short version of command
 
 cmd = @$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))' &&) $(cmd_$(1))
+
+# do_cmd is a shorthand used to support both compressed, verbose
+# and silent output in a single line.
+# Compared to cmd described avobe, do_cmd does no rely on any variables 
+# previously assigned a value.
+#
+# Usage $(call do_cmd,CMD   $@,cmd_to_execute bla bla)
+# Example:
+# $(call do_cmd,CP $@,cp -b $< $@)
+# make -s => nothing will be printed
+# make KBUILD_VERBOSE=1 => cp -b path/to/src.file path/to/dest.file
+# make KBUILD_VERBOSE=0 =>   CP path/to/dest.file
+define do_cmd
+        @$(if $(filter quiet_,$(quiet)), echo '  $(1)' &&,
+           $(if $(filter silent_,$(quiet)),,
+             echo "$(2)" &&)) \
+        $(2)
+endef
+
