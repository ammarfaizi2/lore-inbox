Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315335AbSEGFKs>; Tue, 7 May 2002 01:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315339AbSEGFKr>; Tue, 7 May 2002 01:10:47 -0400
Received: from hst23-wan3-core-rs.sky.com.br ([200.255.78.23]:40711 "EHLO
	mx-03.sky.com.br") by vger.kernel.org with ESMTP id <S315335AbSEGFKq>;
	Tue, 7 May 2002 01:10:46 -0400
Subject: [PATCH] make rpm works on non-x86 platforms
From: Cesar Cardoso <cesarcardoso@skydome.net>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com, alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 (1.0.2-1) 
Date: 07 May 2002 02:10:38 -0300
Message-Id: <1020748240.1678.15.camel@zya.fudeba.int>
Mime-Version: 1.0
X-MDRemoteIP: 200.255.78.15
X-Return-Path: cesarcardoso@skydome.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: cesarcardoso@skydome.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small patch that we (my partners and I) at Opencon (a newly
formed Brazilian Free Software/Open Source consulting firm,
opencon@rio.skydome.net) made to let people using RPM on non-x86
architectures to compile their kernel with 'make rpm'.
It simply hacks the shell script at /usr/src/linux/scripts/mkspec - it
it finds a x86, it issues a 'make bzImage' and acts accordingly; if not,
it issues a 'make vmlinux'.
It's a simple hack, so please test it, especially on other
architectures. It worked on my PowerMac 5500 and one of my friends'
iBook.

Have fun.

- Cesar

---

*** /usr/src/linux/scripts/mkspec.old	Tue May  7 01:47:08 2002
--- /usr/src/linux/scripts/mkspec	Tue May  7 01:50:38 2002
***************
*** 7,10 ****
--- 7,20 ----
  #	stripping the symbols from files in the kernel which we want
  #
+ #	Patched for non-x86 by Opencon (L) 2002 <opencon@rio.skydome.net>
+ #
+ # That's the voodoo to see if it's a x86.
+ ISX86=`arch | grep -ie i.86`
+ if [ ! -z $ISX86 ]; then
+         PC=1
+ else
+         PC=0
+ fi
+ # starting to output the spec
  echo "Name: kernel"
  echo "Summary: The Linux Kernel"
***************
*** 29,38 ****
  echo ""
  echo "%build"
! echo "make oldconfig dep clean bzImage modules"
  echo ""
  echo "%install"
  echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
  echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
! echo 'cp arch/i386/boot/bzImage $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
  echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
  echo ""
--- 39,60 ----
  echo ""
  echo "%build"
! # This is the first 'disagreement' between x86 and other archs.
! if [ $PC = 1 ]; then 
! 	echo "make oldconfig dep clean bzImage modules"
! else
! 	echo "make oldconfig dep clean vmlinux modules"
! fi
! # Back on track
  echo ""
  echo "%install"
  echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
  echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
! # And that's the second
! if [ $PC = 1 ]; then
! 	echo 'cp arch/i386/boot/bzImage $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
! else
! 	echo 'cp vmlinux $RPM_BUILD_ROOT'"/boot/vmlinux-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
! fi
! # Back on track, again
  echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
  echo ""


