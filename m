Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268302AbRG3DsH>; Sun, 29 Jul 2001 23:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268305AbRG3Dr6>; Sun, 29 Jul 2001 23:47:58 -0400
Received: from rj.SGI.COM ([204.94.215.100]:25480 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S268302AbRG3Drr>;
	Sun, 29 Jul 2001 23:47:47 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <laughing@shared-source.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac3 
In-Reply-To: Your message of "Mon, 30 Jul 2001 01:22:06 +0100."
             <20010730012205.A10865@lightning.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Jul 2001 13:47:22 +1000
Message-ID: <16378.996464842@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 01:22:06 +0100, 
Alan Cox <laughing@shared-source.org> wrote:
>2.4.7-ac3
>o	Add "make rpm" target				(me)

Cleanups for make rpm.

Index: 7.25/Makefile
--- 7.25/Makefile Mon, 30 Jul 2001 11:50:08 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.9.1.1.1.47.1.15 644)
+++ 7.25(w)/Makefile Mon, 30 Jul 2001 13:37:56 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.9.1.1.1.47.1.15 644)
@@ -236,7 +236,8 @@ MRPROPER_FILES = \
 	.menuconfig.log \
 	include/asm \
 	.hdepend scripts/mkdep scripts/split-include scripts/docproc \
-	$(TOPDIR)/include/linux/modversions.h
+	$(TOPDIR)/include/linux/modversions.h \
+	kernel.spec
 # directories removed with 'make mrproper'
 MRPROPER_DIRS = \
 	include/config \
@@ -521,19 +522,23 @@ scripts/split-include: scripts/split-inc
 #
 #	If you do a make spec before packing the tarball you can rpm -ta it
 #
-spec:
+spec:	newversion
 	. scripts/mkspec >kernel.spec
 
 #
 #	Build a tar ball , generate an rpm from it and pack the result
-#	There arw two bits of magic here
+#	There are two bits of magic here
 #	1) The use of /. to avoid tar packing just the symlink
 #	2) Removing the .dep files as they have source paths in them that
 #	   will become invalid
 #
-rpm:	clean newversion spec
-	find . \( -size 0 -o -name .depend \) -type f -print | xargs rm -f
+rpm:	clean spec
+	find . \( -size 0 -o -name .depend -o -name .hdepend \) -type f -print | xargs rm -f
+	set -e; \
 	cd $(TOPDIR)/.. ; \
+	rm -f $(KERNELPATH) ; \
 	ln -s $(TOPDIR) $(KERNELPATH) ; \
 	tar cvfz $(KERNELPATH).tar.gz $(KERNELPATH)/. ; \
-	rpm -ta $(TOPDIR)/../$(KERNELPATH).tar.gz
+	rm $(TOPDIR)/kernel.spec; \
+	rpm -ta $(TOPDIR)/../$(KERNELPATH).tar.gz; \
+	rm $(KERNELPATH);
Index: 7.25/scripts/mkspec
--- 7.25/scripts/mkspec Mon, 30 Jul 2001 11:50:08 +1000 kaos (linux-2.4/J/e/9_mkspec 1.1 644)
+++ 7.25(w)/scripts/mkspec Mon, 30 Jul 2001 13:29:12 +1000 kaos (linux-2.4/J/e/9_mkspec 1.1 644)
@@ -6,6 +6,7 @@
 #	The only gothic bit here is redefining install_post to avoid 
 #	stripping the symbols from files in the kernel which we want
 #
+set -e
 echo "Name: kernel"
 echo "Summary: The Linux Kernel"
 echo "Version: "$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION | sed -e "s/-//"
@@ -33,8 +34,7 @@ echo "%install"
 echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
 echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
 echo 'cp arch/i386/boot/bzImage $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
-echo 'cp System.map
-$RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 echo ""
 echo "%clean"
 echo '#echo -rf $RPM_BUILD_ROOT'

