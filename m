Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbUKLKgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbUKLKgd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 05:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbUKLKgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 05:36:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14007 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262512AbUKLKfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 05:35:45 -0500
Subject: mkspec patch
From: Bastien Nocera <hadess@hadess.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 12 Nov 2004 10:35:34 +0000
Message-Id: <1100255735.18094.10.camel@bnocera.surrey.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As I was testing new kernels on some RH/FC machines, I realised that
there was quite a bit of work needed to update the grub.conf/lilo.conf
and the initrd. This patch fixes that, and also makes "make rpm" work on
x86_64 machines.

Please CC: me on the answer as I'm not on the list.

---
Bastien Nocera <hadess@hadess.net> 
Her vocabulary was as bad as, like, whatever. 

--- /usr/src/linux-2.4.21-22.EL/scripts/mkspec	2002-08-03 01:39:46.000000000 +0100
+++ mkspec	2004-10-26 10:38:01.000000000 +0100
@@ -11,6 +11,10 @@
 # That's the voodoo to see if it's a x86.
 ISX86=`arch | grep -ie i.86`
 if [ ! -z $ISX86 ]; then
+	ARCH=i386
+	PC=1
+elif [ `arch` = x86_64 ] ; then
+	ARCH=x86_64
 	PC=1
 else
 	PC=0
@@ -22,6 +26,28 @@
 
 PROVIDES="$PROVIDES kernel-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 
+# The scriptlets for RHEL and Fedora Core
+scriplets()
+{
+if [ ! -f /etc/redhat-release -a ! -f /etc/fedora-release ] ; then
+	return
+fi
+
+echo "%post"
+echo "cd /boot"
+echo "[ -x /usr/sbin/module_upgrade ] && /usr/sbin/module_upgrade"
+echo "[ -x /sbin/mkkerneldoth ] && /sbin/mkkerneldoth"
+echo "[ -x /sbin/new-kernel-pkg ] && /sbin/new-kernel-pkg --mkinitrd --depmod --install $VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo
+echo "%pre"
+echo "/sbin/modprobe loop 2> /dev/null > /dev/null  || :"
+echo 
+echo "%preun"
+echo "/sbin/modprobe loop 2> /dev/null > /dev/null  || :"
+echo "[ -x /sbin/new-kernel-pkg ] && /sbin/new-kernel-pkg --rminitrd --rmmoddep --remove $VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo
+}
+
 echo "Name: kernel"
 echo "Summary: The Linux Kernel"
 echo "Version: "$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION | sed -e "s/-//g"
@@ -58,7 +84,7 @@
 echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
 # And that's the second
 if [ $PC = 1 ]; then
-	echo 'cp arch/i386/boot/bzImage $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+	echo "cp arch/$ARCH/boot/bzImage $RPM_BUILD_ROOT/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 else
 	echo 'cp vmlinux $RPM_BUILD_ROOT'"/boot/vmlinux-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 fi
@@ -69,9 +95,11 @@
 echo "%clean"
 echo '#echo -rf $RPM_BUILD_ROOT'
 echo ""
+scriplets
 echo "%files"
 echo '%defattr (-, root, root)'
 echo "%dir /lib/modules"
 echo "/lib/modules/$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 echo "/boot/*"
 echo ""
+


