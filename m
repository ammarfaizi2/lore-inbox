Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268503AbUIGTbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268503AbUIGTbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268289AbUIGTaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:30:00 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:57351 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268506AbUIGT3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:29:01 -0400
Date: Tue, 7 Sep 2004 23:29:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm4
Message-ID: <20040907212904.GA9416@mars.ravnborg.org>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <544180000.1094575502@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544180000.1094575502@[10.10.2.4]>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 09:45:02AM -0700, Martin J. Bligh wrote:
> Well, the good news is that it compiles now, and without forcing ACPI on.
> Yay!
> 
> On the downside, it seems to have a new error:
> 
> make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
> 
> which appears partway through make install, but only if you do "make -j32",
> not make -j.
Fixed by following patch:

	Sam

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/07 23:20:11+02:00 sam@mars.ravnborg.org 
#   kbuild: fix make -j N build
#   
#   Make did say:
#   make[1]: warning: jobserver unavailable: using -j1.
#   
#   Added '+' flag in relevant places to supress this warning.
#   Also removed some trailing tabs in same area spotted by Adrian Bunk <bunk@fs.tum.de>
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# Makefile
#   2004/09/07 23:19:54+02:00 sam@mars.ravnborg.org +6 -5
#   Add '+' to avoid '-j1' warning from make
#   Removed trailing tabs
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-09-07 23:28:03 +02:00
+++ b/Makefile	2004-09-07 23:28:03 +02:00
@@ -590,7 +590,7 @@
 	. $(srctree)/scripts/mkversion > .tmp_version;	\
 	mv -f .tmp_version .version;			\
 	$(MAKE) $(build)=init
-	
+
 # Generate System.map
 quiet_cmd_sysmap = SYSMAP 
       cmd_sysmap = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
@@ -600,11 +600,11 @@
 # Generate System.map and verify that the content is consistent
 
 define rule_vmlinux__
-	$(if $(CONFIG_KALLSYMS),,$(call cmd,vmlinux_version))
-	
+	$(if $(CONFIG_KALLSYMS),,+$(call cmd,vmlinux_version))
+
 	$(call cmd,vmlinux__)
 	$(Q)echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
-	
+
 	$(Q)$(if $($(quiet)cmd_sysmap),                 \
 	  echo '  $($(quiet)cmd_sysmap) System.map' &&) \
 	$(cmd_sysmap) $@ System.map;                    \
@@ -653,9 +653,10 @@
 endef
 
 # Update vmlinux version before link
+# Use + in front of this rule to silent warning about make -j1
 cmd_ksym_ld = $(cmd_vmlinux__)
 define rule_ksym_ld
-	$(call cmd,vmlinux_version)
+	+$(call cmd,vmlinux_version)
 	$(call cmd,vmlinux__)
 	$(Q)echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
 endef
