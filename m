Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVBXPj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVBXPj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVBXPhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:37:10 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:50308 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262411AbVBXP0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:26:36 -0500
Subject: [RFC][PATCH 3/3] Kdump: Export crash notes section address through
	sysfs
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-ge599eTn16xzb8vVQ3AW"
Organization: 
Message-Id: <1109261865.5148.819.camel@terminator.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Feb 2005 21:47:46 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ge599eTn16xzb8vVQ3AW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-ge599eTn16xzb8vVQ3AW
Content-Disposition: attachment; filename=kexec-x86-exports-thru-sysfs.patch
Content-Type: text/plain; name=kexec-x86-exports-thru-sysfs.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


o Following patch exports kexec global variable "crash_notes" to user space
  through sysfs as kernel attribute in /sys/kernel.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
---

 linux-2.6.11-rc4-mm1-maneesh/arch/i386/kernel/crash.c |    2 --
 linux-2.6.11-rc4-mm1-maneesh/include/asm-i386/kexec.h |    5 +++++
 linux-2.6.11-rc4-mm1-maneesh/kernel/ksysfs.c          |   13 +++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff -puN kernel/ksysfs.c~kexec-exports-thru-sysfs kernel/ksysfs.c
--- linux-2.6.11-rc4-mm1/kernel/ksysfs.c~kexec-exports-thru-sysfs	2005-02-24 13:49:27.953186392 +0530
+++ linux-2.6.11-rc4-mm1-maneesh/kernel/ksysfs.c	2005-02-24 13:49:27.969183960 +0530
@@ -15,6 +15,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
+#include <asm/kexec.h>
+
 #define KERNEL_ATTR_RO(_name) \
 static struct subsys_attribute _name##_attr = __ATTR_RO(_name)
 
@@ -30,6 +32,14 @@ static ssize_t hotplug_seqnum_show(struc
 KERNEL_ATTR_RO(hotplug_seqnum);
 #endif
 
+#ifdef CONFIG_KEXEC
+static ssize_t crash_notes_show(struct subsystem *subsys, char *page)
+{
+	return sprintf(page, "%p\n", (void *)crash_notes);
+}
+KERNEL_ATTR_RO(crash_notes);
+#endif
+
 decl_subsys(kernel, NULL, NULL);
 EXPORT_SYMBOL_GPL(kernel_subsys);
 
@@ -37,6 +47,9 @@ static struct attribute * kernel_attrs[]
 #ifdef CONFIG_HOTPLUG
 	&hotplug_seqnum_attr.attr,
 #endif
+#ifdef CONFIG_KEXEC
+	&crash_notes_attr.attr,
+#endif
 	NULL
 };
 
diff -puN include/asm-i386/kexec.h~kexec-exports-thru-sysfs include/asm-i386/kexec.h
--- linux-2.6.11-rc4-mm1/include/asm-i386/kexec.h~kexec-exports-thru-sysfs	2005-02-24 13:49:27.957185784 +0530
+++ linux-2.6.11-rc4-mm1-maneesh/include/asm-i386/kexec.h	2005-02-24 13:49:27.970183808 +0530
@@ -25,4 +25,9 @@
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_386
 
+#define MAX_NOTE_BYTES 1024
+typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
+
+extern note_buf_t crash_notes[];
+
 #endif /* _I386_KEXEC_H */
diff -puN arch/i386/kernel/crash.c~kexec-exports-thru-sysfs arch/i386/kernel/crash.c
--- linux-2.6.11-rc4-mm1/arch/i386/kernel/crash.c~kexec-exports-thru-sysfs	2005-02-24 13:49:27.960185328 +0530
+++ linux-2.6.11-rc4-mm1-maneesh/arch/i386/kernel/crash.c	2005-02-24 13:49:27.970183808 +0530
@@ -26,8 +26,6 @@
 #include <asm/apic.h>
 #include <mach_ipi.h>
 
-#define MAX_NOTE_BYTES 1024
-typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
 
 note_buf_t crash_notes[NR_CPUS];
 
_
-- 

--=-ge599eTn16xzb8vVQ3AW--

