Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWCMSKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWCMSKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWCMSKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:10:48 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:2061 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932249AbWCMSKn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:10:43 -0500
Date: Mon, 13 Mar 2006 10:10:41 -0800
Message-Id: <200603131810.k2DIAf6O005733@zach-dev.vmware.com>
Subject: [RFC, PATCH 15/24] i386 Vmi apic header
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:10:41.0761 (UTC) FILETIME=[7091C510:01C646C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move APIC read / write accessors to sub-arch layer.  Note that we
don't bother to implement apic_write_atomic any different, as it
is only present to work around old processor erratums (Pentium
Processor Spec update 11AP), and VMI kernels do not offer support
for this class of processor.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Daniel Arai <arai@vmware.com>

Index: linux-2.6.16-rc5/include/asm-i386/apic.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/apic.h	2006-03-10 12:55:07.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/apic.h	2006-03-10 13:03:37.000000000 -0800
@@ -7,6 +7,7 @@
 #include <asm/apicdef.h>
 #include <asm/processor.h>
 #include <asm/system.h>
+#include <mach_apicops.h>
 
 #define Dprintk(x...)
 
@@ -45,25 +46,6 @@ static inline void lapic_enable(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
-/*
- * Basic functions accessing APICs.
- */
-
-static __inline void apic_write(unsigned long reg, unsigned long v)
-{
-	*((volatile unsigned long *)(APIC_BASE+reg)) = v;
-}
-
-static __inline void apic_write_atomic(unsigned long reg, unsigned long v)
-{
-	xchg((volatile unsigned long *)(APIC_BASE+reg), v);
-}
-
-static __inline unsigned long apic_read(unsigned long reg)
-{
-	return *((volatile unsigned long *)(APIC_BASE+reg));
-}
-
 static __inline__ void apic_wait_icr_idle(void)
 {
 	while ( apic_read( APIC_ICR ) & APIC_ICR_BUSY )
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_apicops.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/mach_apicops.h	2006-03-10 13:03:37.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_apicops.h	2006-03-10 13:03:37.000000000 -0800
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to arai@vmware.com
+ *
+ */
+
+/*
+ * VMI implementation for basic functions accessing APICs.  Calls into VMI
+ * to perform operations.
+ */
+
+#ifndef __ASM_MACH_APICOPS_H
+#define __ASM_MACH_APICOPS_H
+
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <vmi.h>
+
+static inline void apic_write(unsigned long reg, unsigned long value)
+{
+        void *addr = (void *)(APIC_BASE + reg);
+	vmi_wrap_call(
+		APICWrite, "movl %1, (%0)",
+		VMI_NO_OUTPUT,
+		2, XCONC(VMI_IREG1(addr), VMI_IREG2(value)),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+#define apic_write_atomic(r,v) apic_write(r,v)
+
+static inline unsigned long apic_read(unsigned long reg)
+{
+	unsigned long value;
+        void *addr = (void *)(APIC_BASE + reg);
+	vmi_wrap_call(
+		APICRead, "movl (%0), %%eax",
+		VMI_OREG1(value),
+		1,VMI_IREG1(addr),
+		VMI_CLOBBER(ONE_RETURN));
+	return value;
+}
+
+
+#endif /* CONFIG_X86_LOCAL_APIC */
+
+#endif /* __ASM_MACH_APICOPS_H */
Index: linux-2.6.16-rc5/include/asm-i386/mach-default/mach_apicops.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-default/mach_apicops.h	2006-03-10 13:03:37.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-default/mach_apicops.h	2006-03-10 16:00:13.000000000 -0800
@@ -0,0 +1,29 @@
+/*
+ * Basic functions accessing APICs.
+ * These may optionally be overridden by the subarchitecture in
+ * mach_apicops.h.
+ */
+
+#ifndef __ASM_MACH_APICOPS_H
+#define __ASM_MACH_APICOPS_H
+
+
+#ifdef CONFIG_X86_LOCAL_APIC
+
+static __inline void apic_write(unsigned long reg, unsigned long v)
+{
+	*((volatile unsigned long *)(APIC_BASE+reg)) = v;
+}
+
+static __inline void apic_write_atomic(unsigned long reg, unsigned long v)
+{
+	xchg((volatile unsigned long *)(APIC_BASE+reg), v);
+}
+static __inline unsigned long apic_read(unsigned long reg)
+{
+	return *((volatile unsigned long *)(APIC_BASE+reg));
+}
+
+#endif /* CONFIG_X86_LOCAL_APIC */
+
+#endif /* __ASM_MACH_APICOPS_H */
