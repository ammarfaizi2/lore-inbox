Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267480AbTBXVPQ>; Mon, 24 Feb 2003 16:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267482AbTBXVPQ>; Mon, 24 Feb 2003 16:15:16 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:2323 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267480AbTBXVPN>;
	Mon, 24 Feb 2003 16:15:13 -0500
Date: Mon, 24 Feb 2003 22:25:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, bugme-janitors@lists.osdl.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Subject: [PATCH] fix make rpm
Message-ID: <20030224212523.GA16164@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, bugme-janitors@lists.osdl.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please apply.

make rpm has been broken in several kernel versions, fix it.
Solves http://bugme.osdl.org/show_bug.cgi?id=373 which Paolo Ciarrocchi
pushed me to fix.

1) Moved make rpm to the noconfig section, thus allowing it to see
   the clean target.
2) Fixed the commandline for find
3) Use rpmbuild if present
4) In mkspec use the generic all target, and drop the dep target
   This made the build command arch independent

	Sam

===== Makefile 1.379 vs edited =====
--- 1.379/Makefile	Mon Feb 17 23:52:03 2003
+++ edited/Makefile	Mon Feb 24 20:46:48 2003
@@ -195,6 +195,7 @@
 noconfig_targets := xconfig menuconfig config oldconfig randconfig \
 		    defconfig allyesconfig allnoconfig allmodconfig \
 		    clean mrproper distclean \
+		    rpm \
 		    help tags TAGS cscope sgmldocs psdocs pdfdocs htmldocs \
 		    checkconfig checkhelp checkincludes
 
@@ -571,34 +572,6 @@
 	 echo "#endif" )
 endef
 
-# RPM target
-# ---------------------------------------------------------------------------
-
-#	If you do a make spec before packing the tarball you can rpm -ta it
-
-spec:
-	. scripts/mkspec >kernel.spec
-
-#	Build a tar ball, generate an rpm from it and pack the result
-#	There arw two bits of magic here
-#	1) The use of /. to avoid tar packing just the symlink
-#	2) Removing the .dep files as they have source paths in them that
-#	   will become invalid
-
-rpm:	clean spec
-	find . $(RCS_FIND_IGNORE) \
-		\( -size 0 -o -name .depend -o -name .hdepend\) \
-		-type f -print | xargs rm -f
-	set -e; \
-	cd $(TOPDIR)/.. ; \
-	ln -sf $(TOPDIR) $(KERNELPATH) ; \
-	tar -cvz $(RCS_TAR_IGNORE) -f $(KERNELPATH).tar.gz $(KERNELPATH)/. ; \
-	rm $(KERNELPATH) ; \
-	cd $(TOPDIR) ; \
-	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > .version ; \
-	rpm -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
-	rm $(TOPDIR)/../$(KERNELPATH).tar.gz
-
 else # ifdef include_config
 
 ifeq ($(filter-out $(noconfig_targets),$(MAKECMDGOALS)),)
@@ -630,7 +603,7 @@
 # ---------------------------------------------------------------------------
 
 .PHONY: oldconfig xconfig menuconfig config \
-	make_with_config
+	make_with_config rpm
 
 scripts/kconfig/conf scripts/kconfig/mconf scripts/kconfig/qconf: scripts/fixdep FORCE
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
@@ -762,6 +735,36 @@
 
 tags: FORCE
 	$(call cmd,tags)
+
+# RPM target
+# ---------------------------------------------------------------------------
+
+#	If you do a make spec before packing the tarball you can rpm -ta it
+
+spec:
+	. scripts/mkspec >kernel.spec
+
+#	Build a tar ball, generate an rpm from it and pack the result
+#	There arw two bits of magic here
+#	1) The use of /. to avoid tar packing just the symlink
+#	2) Removing the .dep files as they have source paths in them that
+#	   will become invalid
+
+rpm:	clean spec
+	find . $(RCS_FIND_IGNORE) \
+		\( -size 0 -o -name .depend -o -name .hdepend \) \
+		-type f -print | xargs rm -f
+	set -e; \
+	cd $(TOPDIR)/.. ; \
+	ln -sf $(TOPDIR) $(KERNELPATH) ; \
+	tar -cvz $(RCS_TAR_IGNORE) -f $(KERNELPATH).tar.gz $(KERNELPATH)/. ; \
+	rm $(KERNELPATH) ; \
+	cd $(TOPDIR) ; \
+	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > .version ; \
+	RPM=`which rpmbuild`; \
+	if [ -z "$$RPM" ]; then RPM=rpm; fi; \
+	$$RPM -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
+	rm $(TOPDIR)/../$(KERNELPATH).tar.gz
 
 # Brief documentation of the typical targets used
 # ---------------------------------------------------------------------------
===== scripts/mkspec 1.3 vs edited =====
--- 1.3/scripts/mkspec	Mon Oct  7 16:44:57 2002
+++ edited/scripts/mkspec	Mon Feb 24 21:24:56 2003
@@ -45,24 +45,18 @@
 echo "%setup -q"
 echo ""
 echo "%build"
-# This is the first 'disagreement' between x86 and other archs.
-if [ $PC = 1 ]; then 
-	echo "make oldconfig dep clean bzImage modules"
-else
-	echo "make oldconfig dep clean vmlinux modules"
-fi
-# Back on track
+echo "make clean oldconfig all"
 echo ""
 echo "%install"
 echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
 echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
-# And that's the second
+# This is the first disagreement between i386 and most others
 if [ $PC = 1 ]; then
 	echo 'cp arch/i386/boot/bzImage $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 else
 	echo 'cp vmlinux $RPM_BUILD_ROOT'"/boot/vmlinux-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 fi
-# Back on track, again
+# Back on track
 echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 echo 'cp .config $RPM_BUILD_ROOT'"/boot/config-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 echo ""
