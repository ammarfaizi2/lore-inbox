Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbULaDhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbULaDhC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 22:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbULaDhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 22:37:02 -0500
Received: from scrye.com ([216.17.180.1]:56459 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S261828AbULaDgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 22:36:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Dec 2004 20:41:03 -0700
From: Kevin Fenzi <kevin@tummy.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: scripts/package/mkspec (2)
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Message-Id: <20041231034104.0BA3395DF8@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's another patch to mkspec. 
This one was coipied from the Fedora kernel spec file. 
(I'm not sure who to attibute it to. arjanv@redhat.com ? )

Currently when you do a 'make rpm' on a kernel.org kernel, and then
later want to build a non-included module, you have to have the entire
kernel source tree available to build against. 

This patch copies the needed files to
/lib/modules/<kernelversion>/build 
so you can build modules against that area instead of needing the
entire build tree available. 

Again, I use a fedora based setup, so I would be interested to hear if
this setup works ok for other systems. 

Comments?

kevin
--
diff -Nru linux-2.6.10.orig/scripts/package/mkspec linux-2.6.10/scripts/package/mkspec
--- linux-2.6.10.orig/scripts/package/mkspec    2004-12-24 14:33:49.000000000 -0700
+++ linux-2.6.10/scripts/package/mkspec 2004-12-30 20:31:33.954485598 -0700
@@ -70,6 +70,33 @@
 echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$KERNELRELEASE"

 echo 'cp .config $RPM_BUILD_ROOT'"/boot/config-$KERNELRELEASE"
+echo '    rm -f $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build'
+echo '    rm -f $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/source'
+echo '    mkdir -p $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build'
+echo '    (cd $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE ; ln -s build source)'
+echo '    # first copy everything'
+echo '    cp --parents `find  -type f -name Makefile -o -name "Kconfig*"` $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build'
+echo '    cp Module.symvers $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build'
+echo '    # then drop all but the needed Makefiles/Kconfig files'
+echo '    rm -rf $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/Documentation'
+echo '    rm -rf $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/scripts'
+echo '    rm -rf $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/include'
+echo '    cp arch/%{_arch}/kernel/asm-offsets.s $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/arch/%{_arch}/kernel || :'
+echo '    cp .config $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build'
+echo '    cp -a scripts $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build'
+echo '    cp -a arch/%{_arch}/scripts $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/arch/%{_arch} || :'
+echo '    cp -a arch/%{_arch}/*lds $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/arch/%{_arch}/|| :'
+echo '    rm -f $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/scripts/*.o'
+echo '    rm -f $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/scripts/*/*.o'
+echo '    mkdir -p $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/include'
+echo '    cd include'
+echo '    cp -a acpi config linux math-emu media net pcmcia rxrpc scsi sound video asm asm-generic$RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/include'
+echo '    cp -a `readlink asm` $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/include'
+echo '    # Make sure the Makefile and version.h have a matching timestamp so that'
+echo '    # external modules can be built'
+echo '    touch -r $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/Makefile $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/include/linux/version.h'
+echo '    touch -r $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/.config $RPM_BUILD_ROOT/lib/modules/$KERNELRELEASE/build/include/linux/autoconf.h'
+echo '    cd ..'
 echo ""
 echo "%clean"
 echo '#echo -rf $RPM_BUILD_ROOT'
