Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161173AbWF0Qi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWF0Qi2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWF0QiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:38:25 -0400
Received: from mail.suse.de ([195.135.220.2]:34006 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161173AbWF0Qh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:59 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 16/17] [PATCH] 64bit Resource: finally enable 64bit resource sizes
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:52 -0700
Message-Id: <11514260871162-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11514260843959-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com> <115142604066-git-send-email-greg@kroah.com> <11514260442539-git-send-email-greg@kroah.com> <11514260483754-git-send-email-greg@kroah.com> <11514260513485-git-send-email-greg@kroah.com> <11514260543854-git-send-email-greg@kroah.com> <11514260583661-git-send-email-greg@kroah.com> <11514260612035-git-send-email-greg@kroah.com> <11514260651070-git-send-email-greg@kroah.com> <11514260692919-git-send-email-greg@kroah.com> <11514260722341-git-send-email-greg@kroah.com> <11514260761750-git-send-email-greg@kroah.com> <115142608072-git-send-email-greg@kroah.com> <11514260843959-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Introduce the Kconfig entry and actually switch to a 64bit value, if
wanted, for resource_size_t.

Based on a patch series originally from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/i386/Kconfig     |    1 +
 include/linux/types.h |    7 ++++++-
 kernel/resource.c     |    8 +++-----
 mm/Kconfig            |    6 ++++++
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 47c08bc..7e46ad7 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -529,6 +529,7 @@ config X86_PAE
 	bool
 	depends on HIGHMEM64G
 	default y
+	select RESOURCES_64BIT
 
 # Common NUMA Features
 config NUMA
diff --git a/include/linux/types.h b/include/linux/types.h
index a021e15..3f23566 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -178,9 +178,14 @@ #endif
 #ifdef __KERNEL__
 typedef unsigned __bitwise__ gfp_t;
 
-typedef unsigned long resource_size_t;
+#ifdef CONFIG_RESOURCES_64BIT
+typedef u64 resource_size_t;
+#else
+typedef u32 resource_size_t;
 #endif
 
+#endif	/* __KERNEL__ */
+
 struct ustat {
 	__kernel_daddr_t	f_tfree;
 	__kernel_ino_t		f_tinode;
diff --git a/kernel/resource.c b/kernel/resource.c
index 54835c0..cc73029 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -23,20 +23,18 @@ #include <asm/io.h>
 
 struct resource ioport_resource = {
 	.name	= "PCI IO",
-	.start	= 0x0000,
+	.start	= 0,
 	.end	= IO_SPACE_LIMIT,
 	.flags	= IORESOURCE_IO,
 };
-
 EXPORT_SYMBOL(ioport_resource);
 
 struct resource iomem_resource = {
 	.name	= "PCI mem",
-	.start	= 0UL,
-	.end	= ~0UL,
+	.start	= 0,
+	.end	= -1,
 	.flags	= IORESOURCE_MEM,
 };
-
 EXPORT_SYMBOL(iomem_resource);
 
 static DEFINE_RWLOCK(resource_lock);
diff --git a/mm/Kconfig b/mm/Kconfig
index 66e65ab..e3644b0 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -145,3 +145,9 @@ config MIGRATION
 	  while the virtual addresses are not changed. This is useful for
 	  example on NUMA systems to put pages nearer to the processors accessing
 	  the page.
+
+config RESOURCES_64BIT
+	bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && EXPERIMENTAL)
+	default 64BIT
+	help
+	  This option allows memory and IO resources to be 64 bit.
-- 
1.4.0

