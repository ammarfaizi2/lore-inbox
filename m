Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVASHy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVASHy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVASHxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:53:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51391 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261625AbVASHdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:19 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 20/29] x86_64-crashkernel
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-64-crashkernel-11061198971876@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
	<x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>
	<kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>
	<x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com>
	<x86-kexec-11061198971773@ebiederm.dsl.xmission.com>
	<x86-crashkernel-1106119897532@ebiederm.dsl.xmission.com>
	<x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com>
	<x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the x86_64 implementation of the crashkernel option.  It reserves
a window of memory very early in the bootup process, so we never use
it for anything but the kernel to switch to when the running
kernel panics.

In addition to reserving this memory a resource structure is registered
so looking at /proc/iomem it is clear what happened to that memory.

ISSUES:
Is it possible to implement this in a architecture generic way?
What should be done with architectures that always use an iommu and
thus don't report their RAM memory resources in /proc/iomem?


Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 e820.c  |    4 ++++
 setup.c |   27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/e820.c linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/x86_64/kernel/e820.c
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/e820.c	Tue Jan 18 22:44:10 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/x86_64/kernel/e820.c	Tue Jan 18 23:14:34 2005
@@ -10,6 +10,7 @@
 #include <linux/bootmem.h>
 #include <linux/ioport.h>
 #include <linux/string.h>
+#include <linux/kexec.h>
 #include <asm/page.h>
 #include <asm/e820.h>
 #include <asm/proto.h>
@@ -204,6 +205,9 @@
 			 */
 			request_resource(res, &code_resource);
 			request_resource(res, &data_resource);
+#ifdef CONFIG_KEXEC
+			request_resource(res, &crashk_res);
+#endif
 		}
 	}
 }
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/setup.c linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/x86_64/kernel/setup.c
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/setup.c	Fri Jan 14 04:32:23 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/x86_64/kernel/setup.c	Tue Jan 18 23:14:34 2005
@@ -40,6 +40,7 @@
 #include <linux/acpi.h>
 #include <linux/kallsyms.h>
 #include <linux/edd.h>
+#include <linux/kexec.h>
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -321,6 +322,27 @@
 		if (!memcmp(from, "noexec=", 7))
 			nonx_setup(from + 7);
 
+#ifdef CONFIG_KEXEC
+		/* crashkernel=size@addr specifies the location to reserve for
+		 * a crash kernel.  By reserving this memory we guarantee
+		 * that linux never set's it up as a DMA target.
+		 * Useful for holding code to do something appropriate
+		 * after a kernel panic.
+		 */
+		else if (!memcmp(from, "crashkernel=", 12)) {
+			unsigned long size, base;
+			size = memparse(from+12, &from);
+			if (*from == '@') {
+				base = memparse(from+1, &from);
+				/* FIXME: Do I want a sanity check 
+				 * to validate the memory range? 
+				 */
+				crashk_res.start = base;
+				crashk_res.end   = base + size - 1;
+			}
+		}
+#endif
+
 	next_char:
 		c = *(from++);
 		if (!c)
@@ -574,6 +596,11 @@
 			    (unsigned long)(end_pfn << PAGE_SHIFT));
 			initrd_start = 0;
 		}
+	}
+#endif
+#ifdef CONFIG_KEXEC
+	if (crashk_res.start != crashk_res.end) {
+		reserve_bootmem(crashk_res.start, crashk_res.end - crashk_res.start + 1);
 	}
 #endif
 	paging_init();
