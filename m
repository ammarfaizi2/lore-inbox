Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUFOGsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUFOGsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 02:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbUFOGsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 02:48:43 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:51216 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265331AbUFOGsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 02:48:36 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: [patch 2.6.7-rc3] When two kallsyms passes are not enough
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Jun 2004 16:48:28 +1000
Message-ID: <11886.1087282108@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After knocking my head against a debug problem for an hour, I realised
that the addresses being reported by kallsyms did not match the
System.map.

Under some circumstances, kallsyms needs a third pass to get stable
data.  IA64, gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-24), GNU
ld version 2.14.90.0.4 20030523.  Linking .tmp_kallsyms2.o into vmlinux
can change the small data and bss sections (for no good reason) which
makes all the following addresses incorrect.  I strongly suspect yet
another non-deterministic linker bug.  And before H. J. Lu tells me to
upgrade the linker, upgrade is not an option for these builds, it needs
a check and a workaround.

This patch verifies that the kallsyms data is stable and aborts the
build if the kernel is still changing after the last kallsyms pass.  It
also adds CONFIG_KALLSYMS_EXTRA_PASS to do three passes instead of two,
the extra pass is optional because it is slow and should only be
selected when necessary.

Signed-off-by: Keith Owens <kaos@sgi.com>


Index: 2.6.7-rc3-pristine/Makefile
===================================================================
--- 2.6.7-rc3-pristine.orig/Makefile	Tue Jun  8 11:46:22 2004
+++ 2.6.7-rc3-pristine/Makefile	Tue Jun 15 16:21:38 2004
@@ -544,47 +544,70 @@ define rule_vmlinux__
 	echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
 endef
 
-define rule_vmlinux
-	$(rule_vmlinux__); \
-	$(NM) $@ | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
-endef
+do_system_map = $(NM) $(1) | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > $(2)
 
 LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds.s
 
 #	Generate section listing all symbols and add it into vmlinux
-#	It's a three stage process:
+#	It's a three or four stage process:
 #	o .tmp_vmlinux1 has all symbols and sections, but __kallsyms is
 #	  empty
 #	  Running kallsyms on that gives us .tmp_kallsyms1.o with
 #	  the right size
 #	o .tmp_vmlinux2 now has a __kallsyms section of the right size,
 #	  but due to the added section, some addresses have shifted
-#	  From here, we generate a correct .tmp_kallsyms2.o
-#	o The correct .tmp_kallsyms2.o is linked into the final vmlinux.
+#	  From here, we generate a .tmp_kallsyms2.o
+#	o .tmp_kallsyms2.o is linked into .tmp_vmlinux3.  On architectures
+#	  with small bss or data segments, this can shift the addresses of
+#	  the small segments, so generate .tmp_kallsyms3.o and link that
+#	  into the final vmlinux.  This stage is only executed when
+#	  CONFIG_KALLSYMS_EXTRA_PASS is defined, to avoid the extra (slow)
+#	  link step unless the user really needs it.
 
 ifdef CONFIG_KALLSYMS
 
-kallsyms.o := .tmp_kallsyms2.o
+ifdef CONFIG_KALLSYMS_EXTRA_PASS
+last_kallsyms := 3
+else
+last_kallsyms := 2
+endif
+
+kallsyms.o := .tmp_kallsyms$(last_kallsyms).o
+
+define rule_verify_kallsyms
+	$(call do_system_map, .tmp_vmlinux$(last_kallsyms), .tmp_System.map)
+	cmp -s System.map .tmp_System.map || \
+		(echo Inconsistent kallsyms data, try setting CONFIG_KALLSYMS_EXTRA_PASS ; rm .tmp_kallsyms* ; false)
+endef
 
 quiet_cmd_kallsyms = KSYM    $@
 cmd_kallsyms = $(NM) -n $< | $(KALLSYMS) $(foreach x,$(CONFIG_KALLSYMS_ALL),--all-symbols) > $@
 
-.tmp_kallsyms1.o .tmp_kallsyms2.o: %.o: %.S scripts FORCE
+.tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
 	$(call if_changed_dep,as_o_S)
 
 .tmp_kallsyms%.S: .tmp_vmlinux%
 	$(call cmd,kallsyms)
 
 .tmp_vmlinux1: $(vmlinux-objs) arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
-	+$(call if_changed_rule,vmlinux__)
+	$(call if_changed_rule,vmlinux__)
 
 .tmp_vmlinux2: $(vmlinux-objs) .tmp_kallsyms1.o arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
 	$(call if_changed_rule,vmlinux__)
 
+.tmp_vmlinux3: $(vmlinux-objs) .tmp_kallsyms2.o arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
+	$(call if_changed_rule,vmlinux__)
+
 endif
 
 #	Finally the vmlinux rule
 
+define rule_vmlinux
+	$(rule_vmlinux__); \
+	$(call do_system_map, $@, System.map)
+	$(rule_verify_kallsyms)
+endef
+
 vmlinux: $(vmlinux-objs) $(kallsyms.o) arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
 	$(call if_changed_rule,vmlinux)
 
@@ -796,7 +819,7 @@ endef
 # Directories & files removed with 'make clean'
 CLEAN_DIRS  += $(MODVERDIR)
 CLEAN_FILES +=	vmlinux System.map kernel.spec \
-                .tmp_kallsyms* .tmp_version .tmp_vmlinux*
+                .tmp_kallsyms* .tmp_version .tmp_vmlinux* .tmp_System.map
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include2
Index: 2.6.7-rc3-pristine/init/Kconfig
===================================================================
--- 2.6.7-rc3-pristine.orig/init/Kconfig	Tue Jun  8 11:47:43 2004
+++ 2.6.7-rc3-pristine/init/Kconfig	Tue Jun 15 16:21:38 2004
@@ -246,6 +246,17 @@ config KALLSYMS_ALL
 
 	   Say N.
 
+config KALLSYMS_EXTRA_PASS
+	bool "Do an extra kallsyms pass"
+	depends on KALLSYMS
+	help
+	   On some architectures that support small data or bss sections, you
+	   may need an extra kallsyms pass to get to a stable state where the
+	   data in the kallsyms tables actually matches the System.map.  If
+	   your build fails with inconsistent kallsyms data, select Y here,
+	   it will add an extra kallsyms and link pass to the build of vmlinux.
+	   Otherwise say N.
+
 config FUTEX
 	bool "Enable futex support" if EMBEDDED
 	default y

