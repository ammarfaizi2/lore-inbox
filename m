Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUHMTsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUHMTsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267357AbUHMTs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:48:29 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:4906 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267168AbUHMTnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:43:37 -0400
Date: Fri, 13 Aug 2004 21:45:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [2/12] kbuild/sparc: Use new generic mksysmap script to generate System.map
Message-ID: <20040813194554.GB10556@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040813192804.GA10486@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813192804.GA10486@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/08 09:34:43+02:00 sam@mars.ravnborg.org 
#   kbuild/sparc: Use new generic mksysmap script to generate System.map
#   
#   o Introduced usage of the mksysmap script.
#   o Improved the non-verbose output to look like this:
#     BTFIX   arch/sparc/boot/btfix.S
#     AS      arch/sparc/boot/btfix.o
#     LD      arch/sparc/boot/image
#     SYSMAP  arch/sparc/boot/System.map
#   
#   o No longer generate System.map for each build
#   o Use normal AS rule to compile btfix.S
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/mksysmap
#   2004/08/08 09:34:27+02:00 sam@mars.ravnborg.org +1 -1
#   Three, not four underscores
# 
# arch/sparc/boot/Makefile
#   2004/08/08 09:34:27+02:00 sam@mars.ravnborg.org +32 -8
#   Use the new mksysmap script
#   Do not generate System.map for every build
#   Use normal AS rule for btfix.S
# 
diff -Nru a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
--- a/arch/sparc/boot/Makefile	2004-08-13 21:09:21 +02:00
+++ b/arch/sparc/boot/Makefile	2004-08-13 21:09:21 +02:00
@@ -8,27 +8,51 @@
 ELFTOAOUT	:= elftoaout
 
 host-progs	:= piggyback btfixupprep
-targets		:= tftpboot.img btfix.o btfix.s image
+targets		:= tftpboot.img btfix.o btfix.S image
 
 quiet_cmd_elftoaout	= ELFTOAOUT $@
       cmd_elftoaout	= $(ELFTOAOUT) $(obj)/image -o $@
-quiet_cmd_piggy		= PIGGY $@
+quiet_cmd_piggy		= PIGGY   $@
       cmd_piggy		= $(obj)/piggyback $@ $(obj)/System.map $(ROOT_IMG)
-quiet_cmd_btfix		= BTFIX $@
+quiet_cmd_btfix		= BTFIX   $@
       cmd_btfix		= $(OBJDUMP) -x vmlinux | $(obj)/btfixupprep > $@
+quiet_cmd_sysmap        = SYSMAP  $(obj)/System.map
+      cmd_sysmap        = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
+quiet_cmd_image = LD      $@
+      cmd_image = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_$(@F)) -o $@
+
+define rule_image
+	$(if $($(quiet)cmd_image),               \
+	  echo '  $($(quiet)cmd_image)' &&)      \
+	  $(cmd_image);                          \
+	$(if $($(quiet)cmd_sysmap),              \
+	  echo '  $($(quiet)cmd_sysmap)' &&)  \
+	$(cmd_sysmap) $@ $(obj)/System.map;      \
+	if [ $$? -ne 0 ]; then                   \
+		rm -f $@;                        \
+		/bin/false;                      \
+	fi;                                      \
+	echo 'cmd_$@ := $(cmd_image)' > $(@D)/.$(@F).cmd
+endef
 
 BTOBJS := $(HEAD_Y) $(INIT_Y)
 BTLIBS := $(CORE_Y) $(LIBS_Y) $(DRIVERS_Y) $(NET_Y)
-LDFLAGS_image := -T arch/sparc/kernel/vmlinux.lds.s $(BTOBJS) --start-group $(BTLIBS) --end-group $(kallsyms.o)
+LDFLAGS_image := -T arch/sparc/kernel/vmlinux.lds.s $(BTOBJS) \
+                  --start-group $(BTLIBS) --end-group \
+                  $(kallsyms.o) $(obj)/btfix.o
 
-# Actual linking
+# Link the final image including btfixup'ed symbols.
+# This is a replacement for the link done in the top-level Makefile.
+# Note: No dependency on the prerequisite files since that would require
+# make to try check if they are updated - and due to changes
+# in gcc options (path for example) this would result in
+# these files being recompiled for each build.
 $(obj)/image: $(obj)/btfix.o FORCE
-	$(call if_changed,ld)
-	$(NM) $@ | grep -v  '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > $(obj)/System.map
+	$(call if_changed_rule,image)
 
 $(obj)/tftpboot.img: $(obj)/piggyback $(obj)/System.map $(obj)/image FORCE
 	$(call if_changed,elftoaout)
 	$(call if_changed,piggy)
 
-$(obj)/btfix.s: $(obj)/btfixupprep vmlinux FORCE
+$(obj)/btfix.S: $(obj)/btfixupprep vmlinux FORCE
 	$(call if_changed,btfix)
diff -Nru a/scripts/mksysmap b/scripts/mksysmap
--- a/scripts/mksysmap	2004-08-13 21:09:21 +02:00
+++ b/scripts/mksysmap	2004-08-13 21:09:21 +02:00
@@ -18,7 +18,7 @@
 # they are used by the sparc BTFIXUP logic - and is assumed to be undefined.
 
 
-if [ "`$NM -u $1 | grep -v ' ____'`" != "" ]; then
+if [ "`$NM -u $1 | grep -v ' ___'`" != "" ]; then
 	echo "$1: error: undefined symbol(s) found:"
 	$NM -u $1 | grep -v ' ___'
 	exit 1
