Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWCVGht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWCVGht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWCVGht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:37:49 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:10371 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750891AbWCVGhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:47 -0500
Message-Id: <20060322063802.797884000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:31:07 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 27/35] Add nosegneg capability to the vsyscall page notes
Content-Disposition: inline; filename=26-i386-vsyscall-note
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "nosegneg" fake capabilty to the vsyscall page notes. This is
used by the runtime linker to select a glibc version which then
disables negative-offset accesses to the thread-local segment via
%gs. These accesses require emulation in Xen (because segments are
truncated to protect the hypervisor address space) and avoiding them
provides a measurable performance boost.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/vsyscall-note.S |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+)

--- xen-subarch-2.6.orig/arch/i386/kernel/vsyscall-note.S
+++ xen-subarch-2.6/arch/i386/kernel/vsyscall-note.S
@@ -3,6 +3,7 @@
  * Here we can supply some information useful to userland.
  */
 
+#include <linux/config.h>
 #include <linux/uts.h>
 #include <linux/version.h>
 
@@ -23,3 +24,31 @@
 	ASM_ELF_NOTE_BEGIN(".note.kernel-version", "a", UTS_SYSNAME, 0)
 	.long LINUX_VERSION_CODE
 	ASM_ELF_NOTE_END
+
+#ifdef CONFIG_XEN
+/*
+ * Add a special note telling glibc's dynamic linker a fake hardware
+ * flavor that it will use to choose the search path for libraries in the
+ * same way it uses real hardware capabilities like "mmx".
+ * We supply "nosegneg" as the fake capability, to indicate that we
+ * do not like negative offsets in instructions using segment overrides,
+ * since we implement those inefficiently.  This makes it possible to
+ * install libraries optimized to avoid those access patterns in someplace
+ * like /lib/i686/tls/nosegneg.  Note that an /etc/ld.so.conf.d/file
+ * corresponding to the bits here is needed to make ldconfig work right.
+ * It should contain:
+ *	hwcap 0 nosegneg
+ * to match the mapping of bit to name that we give here.
+ */
+#define NOTE_KERNELCAP_BEGIN(ncaps, mask) \
+	ASM_ELF_NOTE_BEGIN(".note.kernelcap", "a", "GNU", 2) \
+	.long ncaps, mask
+#define NOTE_KERNELCAP(bit, name) \
+	.byte bit; .asciz name
+#define NOTE_KERNELCAP_END ASM_ELF_NOTE_END
+
+NOTE_KERNELCAP_BEGIN(1, 1)
+NOTE_KERNELCAP(1, "nosegneg")
+NOTE_KERNELCAP_END
+#endif
+

--
