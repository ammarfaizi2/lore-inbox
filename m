Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbRG2ATK>; Sat, 28 Jul 2001 20:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbRG2ATB>; Sat, 28 Jul 2001 20:19:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47622 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267384AbRG2ASu>; Sat, 28 Jul 2001 20:18:50 -0400
Subject: make rpm
To: linux-kernel@vger.kernel.org
Date: Sun, 29 Jul 2001 01:20:19 +0100 (BST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QeJf-0008O8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I've been meaning to do this one for a while and I now have it working so
that with my current -ac kernel working tree I can type

	make rpm

and out puts kernel-2.4.7ac3-1.i386.rpm

All this took was the pieces below.

Anyone care to knock up a "make dpkg" to go with it ?

Alan

---

#
# RPM target
#
#	If you do a make spec before packing the tarball you can rpm -ta it
#
spec:
 	. scripts/mkspec >kernel.spec

#
# 	Build a tar ball , generate an rpm from it and pack the result
# 	There arw two bits of magic here
#  	1) The use of /. to avoid tar packing just the symlink
# 	2) Removing the .dep files as they have source paths in them that
# 		will become invalid
#
rpm:    clean newversion spec
        find . \( -size 0 -o -name .depend \) -type f -print | xargs rm -f
        cd $(TOPDIR)/.. ; \
        ln -s $(TOPDIR) $(KERNELPATH) ; \
        tar cvfz $(KERNELPATH).tar.gz $(KERNELPATH)/. ; \
        rpm -ta $(TOPDIR)/../$(KERNELPATH).tar.gz


--

scripts/mkspec


#!/bin/sh
#
#	Output a simple RPM spec file that uses no fancy features requring
#	RPM v4. This is intended to work with any RPM distro.
#
#	The only gothic bit here is redefining install_post to avoid 
#	stripping the symbols from files in the kernel which we want
#
echo "Name: kernel"
echo "Summary: The Linux Kernel"
echo "Version: "$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION | sed -e "s/-//"
echo -n "Release: "
cat .version
echo "Copyright: GPL"
echo "Group: System Environment/Kernel"
echo "Vendor: The Linux Community"
echo "URL: http://www.kernel.org"
echo -n "Source: kernel-$VERSION.$PATCHLEVEL.$SUBLEVEL"
echo "$EXTRAVERSION.tar.gz" | sed -e "s/-//"
echo "BuildRoot: /var/tmp/%{name}-%{PACKAGE_VERSION}-root"
echo "%define __spec_install_post /usr/lib/rpm/brp-compress || :"
echo ""
echo "%description"
echo "The Linux Kernel, the operating system core itself"
echo ""
echo "%prep"
echo "%setup -q"
echo ""
echo "%build"
echo "make oldconfig dep clean bzImage modules"
echo ""
echo "%install"
echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib
$RPM_BUILD_ROOT/lib/modules'
echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
echo 'cp arch/i386/boot/bzImage
$RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
echo ""
echo "%clean"
echo '#echo -rf $RPM_BUILD_ROOT'
echo ""
echo "%files"
echo '%defattr (-, root, root)'
echo "%dir /lib/modules"
echo "/lib/modules/$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
echo ""
