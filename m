Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292931AbSCIVJZ>; Sat, 9 Mar 2002 16:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292932AbSCIVJQ>; Sat, 9 Mar 2002 16:09:16 -0500
Received: from mercury.chembio.ntnu.no ([129.241.80.86]:42768 "EHLO
	mercury.chembio.ntnu.no") by vger.kernel.org with ESMTP
	id <S292931AbSCIVI6>; Sat, 9 Mar 2002 16:08:58 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] RPM build target fixes
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 09 Mar 2002 22:03:36 +0100
Message-ID: <m3u1rpa1xz.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Attached is a patch to make life easier for building RPMs from the
source.

Basically it adds:

* .spec files are named with version included
* a .spec file is placed in %_topdir/SPECS on sucessful build so you
  can do a rpm -bb kernel-x.y.z.spec to recreate the packages.
* a tarball with current source and config is placed in
  %_topdir/SOURCE after a sucessful build, and also contains a .spec
  file so anyone can do a rpm -ta tarball.tar.gz.
* a source RPM is left in %_topdir/SRPMS after a successful build.
* a binary RPM is left in %_topdir/RPMS/%_arch for easy install.

Created against 2.4.19-pre2-ac3, but should apply cleanly to any
2.4.18 or better.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=08-rpm-build-cleanup-2.4.19-pre2-ac3.patch
Content-Description: Quick hack for RPM build target

--- linux-2.4-clean/Makefile	Sat Mar  9 21:53:28 2002
+++ linux-2.4-ac/Makefile	Sat Mar  9 20:42:56 2002
@@ -522,7 +522,13 @@
 #	If you do a make spec before packing the tarball you can rpm -ta it
 #
 spec:
-	. scripts/mkspec >kernel.spec
+	RPMDIR=$(shell rpm --eval \%_topdir) ; \
+	[ -f $(TOPDIR)/kernel-*.spec ] && \
+		rm $(TOPDIR)/kernel-*.spec ; \
+	[ -f $$RPMDIR/SPECS/kernel-$(VERSION).$(PATCHLEVEL).*$(EXTRAVERSION).spec ] && \
+		rm $$RPMDIR/SPECS/kernel-$(VERSION).$(PATCHLEVEL).*$(EXTRAVERSION).spec ; \
+	. scripts/mkspec >$(TOPDIR)/kernel-$(KERNELRELEASE).spec ; \
+	. scripts/mkspec >$$RPMDIR/SPECS/kernel-$(KERNELRELEASE).spec ; 
 
 #
 #	Build a tar ball, generate an rpm from it and pack the result
@@ -533,12 +539,26 @@
 #
 rpm:	clean spec
 	find . \( -size 0 -o -name .depend -o -name .hdepend \) -type f -print | xargs rm -f
-	set -e; \
-	cd $(TOPDIR)/.. ; \
-	ln -sf $(TOPDIR) $(KERNELPATH) ; \
-	tar -cvz --exclude CVS -f $(KERNELPATH).tar.gz $(KERNELPATH)/. ; \
-	rm $(KERNELPATH) ; \
-	cd $(TOPDIR) ; \
-	. scripts/mkversion > .version ; \
-	rpm -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
-	rm $(TOPDIR)/../$(KERNELPATH).tar.gz
+	RPMDIR=$(shell rpm --eval \%_topdir) ; \
+	. scripts/mkversion > .version.tmp ; \
+	mv .version.tmp .version ; \
+        cd $$RPMDIR/SOURCES ; \
+        ln -sf $(TOPDIR) $(KERNELPATH) ; \
+        tar -cz --exclude CVS -f $$RPMDIR/SOURCES/$(KERNELPATH).tar.gz $(KERNELPATH)/. ; \
+        rm $(KERNELPATH) ; \
+        rm $(TOPDIR)/kernel-$(KERNELRELEASE).spec ; \
+        cd $(TOPDIR) ; \
+        rpm -ba $$RPMDIR/SPECS/kernel-$(KERNELRELEASE).spec ; \
+        if [ $$? -ne 0 ]; then \
+                RPMARCH=(shell rpm --eval \%_arch) ; \
+                [ -f $$RPMDIR/SPECS/kernel-$(KERNELRELEASE).spec ] && \
+                        rm $$RPMDIR/SPECS/kernel-$(KERNELRELEASE).spec ; \
+                [ -f $$RPMDIR/SRPMS/$(KERNELPATH).src.rpm ] && \
+                        rm $$RPMDIR/SRPMS/$(KERNELPATH).src.rpm ; \
+                [ -f $$RPMDIR/RPMS/$$RPMARCH/$(KERNELPATH).$$RPMARCH.rpm ] && \
+                        rm $$RPMDIR/RPMS/$$RPMARCH/$(KERNELPATH).$$RPMARCH.rpm ; \
+                [ -f $$RPMDIR/SOURCES/$(KERNELPATH).tar.gz ] && \
+                        rm $$RPMDIR/SOURCES/$(KERNELPATH).tar.gz ; \
+                [ -d $$RPMDIR/BUILD/$(KERNELPATH) ] && \
+                        rm -rf $$RPMDIR/BUILD/$(KERNELPATH) ; \
+        fi ;

--=-=-=


ttfn,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy

--=-=-=--
