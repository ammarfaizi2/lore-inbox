Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757488AbWK1WIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757488AbWK1WIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757484AbWK1WIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:08:43 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:62787 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1757481AbWK1WIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:08:42 -0500
Date: Tue, 28 Nov 2006 14:08:40 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, aia21@cantab.net
Subject: [PATCH 1/2] lib + ntfs: let modules force HWEIGHT
Message-Id: <20061128140840.f87540e8.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

NTFS (=m) uses hweight32(), but that function is only linked
into the kernel image if it is used inside the kernel image,
not in loadable modules.  Let modules force HWEIGHT to be
built into the kernel image.  Otherwise build fails:

  Building modules, stage 2.
  MODPOST 94 modules
WARNING: "hweight32" [fs/ntfs/ntfs.ko] undefined!

Yes, I'd certainly prefer for this to be more automated rather than
forced by each module that needs it.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 fs/Kconfig   |    1 +
 lib/Kconfig  |    8 ++++++++
 lib/Makefile |    1 +
 3 files changed, 10 insertions(+)

--- linux-2.6.19-rc6-git10.orig/fs/Kconfig
+++ linux-2.6.19-rc6-git10/fs/Kconfig
@@ -816,6 +816,7 @@ config FAT_DEFAULT_IOCHARSET
 config NTFS_FS
 	tristate "NTFS file system support"
 	select NLS
+	select FORCE_HWEIGHT
 	help
 	  NTFS is the file system of Microsoft Windows NT, 2000, XP and 2003.
 
--- linux-2.6.19-rc6-git10.orig/lib/Kconfig
+++ linux-2.6.19-rc6-git10/lib/Kconfig
@@ -97,4 +97,12 @@ config TEXTSEARCH_FSM
 config PLIST
 	boolean
 
+#
+# FORCE_HWEIGHT support is select-ed if needed,
+# so that loadable modules can cause the kernel to supply it
+# (and not be dropped from lib.a when not used in kernel image)
+#
+config FORCE_HWEIGHT
+	boolean
+
 endmenu
--- linux-2.6.19-rc6-git10.orig/lib/Makefile
+++ linux-2.6.19-rc6-git10/lib/Makefile
@@ -28,6 +28,7 @@ lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += f
 lib-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 obj-$(CONFIG_PLIST) += plist.o
+obj-$(CONFIG_FORCE_HWEIGHT) += hweight.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 obj-$(CONFIG_DEBUG_LIST) += list_debug.o
 


---
