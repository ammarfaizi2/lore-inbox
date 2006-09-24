Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWIXVSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWIXVSN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWIXVSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:18:00 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:16604 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932125AbWIXVNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:10 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 16/28] kbuild: create output directory for hostprogs with O=.. build
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:12 +0200
Message-Id: <11591327063034-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1159132705363-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

hostprogs-y only supported creating output directory for the final
program. Extend this to also cover the situation where a .o
file (used when host program is made from compositie objects) is
locate in another directory.
First user of this is the built-in lxdialog that.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/Makefile.host |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 060f4c5..d74dd0f 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -32,11 +32,6 @@ # Note: Shared libraries consisting of C
 
 __hostprogs := $(sort $(hostprogs-y) $(hostprogs-m))
 
-# hostprogs-y := tools/build may have been specified. Retreive directory
-host-objdirs := $(foreach f,$(__hostprogs), $(if $(dir $(f)),$(dir $(f))))
-host-objdirs := $(strip $(sort $(filter-out ./,$(host-objdirs))))
-
-
 # C code
 # Executables compiled from a single .c file
 host-csingle	:= $(foreach m,$(__hostprogs),$(if $($(m)-objs),,$(m)))
@@ -65,6 +60,21 @@ host-cobjs	:= $(filter-out %.so,$(host-c
 #Object (.o) files used by the shared libaries
 host-cshobjs	:= $(sort $(foreach m,$(host-cshlib),$($(m:.so=-objs))))
 
+# output directory for programs/.o files
+# hostprogs-y := tools/build may have been specified. Retreive directory
+host-objdirs := $(foreach f,$(__hostprogs), $(if $(dir $(f)),$(dir $(f))))
+# directory of .o files from prog-objs notation
+host-objdirs += $(foreach f,$(host-cmulti),                  \
+                    $(foreach m,$($(f)-objs),                \
+                        $(if $(dir $(m)),$(dir $(m)))))
+# directory of .o files from prog-cxxobjs notation
+host-objdirs += $(foreach f,$(host-cxxmulti),                  \
+                    $(foreach m,$($(f)-cxxobjs),                \
+                        $(if $(dir $(m)),$(dir $(m)))))
+
+host-objdirs := $(strip $(sort $(filter-out ./,$(host-objdirs))))
+
+
 __hostprogs     := $(addprefix $(obj)/,$(__hostprogs))
 host-csingle	:= $(addprefix $(obj)/,$(host-csingle))
 host-cmulti	:= $(addprefix $(obj)/,$(host-cmulti))
@@ -75,6 +85,7 @@ host-cshlib	:= $(addprefix $(obj)/,$(hos
 host-cshobjs	:= $(addprefix $(obj)/,$(host-cshobjs))
 host-objdirs    := $(addprefix $(obj)/,$(host-objdirs))
 
+$(warning host-objdirs=$(host-objdirs))
 obj-dirs += $(host-objdirs)
 
 #####
-- 
1.4.1

