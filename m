Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbULaD3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbULaD3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 22:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbULaD3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 22:29:10 -0500
Received: from scrye.com ([216.17.180.1]:41355 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S261602AbULaD3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 22:29:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Dec 2004 20:33:20 -0700
From: Kevin Fenzi <kevin@tummy.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: scripts/package/mkspec
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Message-Id: <20041231033323.1CBB4CB130@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a patch against 2.6.10's mkspec script. 
This patch adds %post and a %preun sections to the rpm spec that
mkspec generates for the kernel (for 'make rpm'). 

So, after installing the kernel rpm it checks for /sbin/mkinitrd and
makes an initrd file for the newly installed kernel rpm. It also
checks for a /sbin/new-kernel-package command and runs it on the new
kernel if it exists to add the new kernel/initrd to grub/lilo. 

For preun, before the kernel rpm is removed, /sbin/new-kernel-package
is called to remove the kernel from the lilo or grub config and to
remove the initrd (if any). 

I am using Fedora Core based machines, so I don't know how well these
translate to {mandrake|suse|connectiva|others}. Anyone using those
systems care to comment?

This patch works fine for me on Fedora based systems, and shouldn't
harm any machines without /sbin/mkinitrd and
/sbin/new-kernel-package. 

Comments?

kevin
--
diff -Nru linux-2.6.10.orig/scripts/package/mkspec linux-2.6.10/scripts/package/mkspec
--- linux-2.6.10.orig/scripts/package/mkspec    2004-12-24 14:33:49.000000000 -0700
+++ linux-2.6.10/scripts/package/mkspec 2004-12-30 20:19:04.954634842 -0700
@@ -73,6 +73,14 @@
 echo ""
 echo "%clean"
 echo '#echo -rf $RPM_BUILD_ROOT'
+
+echo "%post"
+echo '[ -x /sbin/mkinitrd ] && /sbin/mkinitrd /boot/initrd-'"$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"'.img '"$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo '[ -x /sbin/new-kernel-pkg ] && /sbin/new-kernel-pkg --install --initrdfile=/boot/initrd-'"$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"'.img --make-default '"$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo ""
+echo "%preun"
+echo '[ -x /sbin/new-kernel-pkg ] && /sbin/new-kernel-pkg --remove '"$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+
 echo ""
 echo "%files"
 echo '%defattr (-, root, root)'
