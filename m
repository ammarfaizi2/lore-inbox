Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbUEFLXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUEFLXO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 07:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUEFLXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 07:23:14 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:52581
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261998AbUEFLXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 07:23:09 -0400
Message-Id: <s09a2e2c.054@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Thu, 06 May 2004 13:23:24 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: sys_ioctl export consolidation
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we noted that sys_ioctl is not currently being exported for ia64
to be used in the 32-bit emulation routines I'd like to suggest the
following patch, which, instead of making this available in another
individual architecture, exports the symbol whenever CONFIG_COMPAT is
defined (legal users should be a subset of
[un]register_ioctl32_conversion users, which is scoped by the same
config option).

Regards, Jan

compat-sys_ioctl-export.patch:
diff -aur linux-2.6.5/arch/ppc64/kernel/ppc_ksyms.c
linux-2.6.5-ioctl/arch/ppc64/kernel/ppc_ksyms.c
--- linux-2.6.5/arch/ppc64/kernel/ppc_ksyms.c	2004-04-04
05:36:26.000000000 +0200
+++ linux-2.6.5-ioctl/arch/ppc64/kernel/ppc_ksyms.c	2004-05-06
13:07:28.000000000 +0200
@@ -49,7 +49,6 @@
 int abs(int);
 
 EXPORT_SYMBOL(do_signal);
-EXPORT_SYMBOL(sys_ioctl);
 
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(pci_io_base);
diff -aur linux-2.6.5/arch/s390/kernel/s390_ksyms.c
linux-2.6.5-ioctl/arch/s390/kernel/s390_ksyms.c
--- linux-2.6.5/arch/s390/kernel/s390_ksyms.c	2004-04-04
05:37:25.000000000 +0200
+++ linux-2.6.5-ioctl/arch/s390/kernel/s390_ksyms.c	2004-05-06
13:07:07.000000000 +0200
@@ -95,4 +95,3 @@
 EXPORT_SYMBOL_NOVERS(do_call_softirq);
 EXPORT_SYMBOL(sys_wait4);
 EXPORT_SYMBOL(cpcmd);
-EXPORT_SYMBOL(sys_ioctl);
diff -aur linux-2.6.5/arch/x86_64/kernel/x8664_ksyms.c
linux-2.6.5-ioctl/arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.6.5/arch/x86_64/kernel/x8664_ksyms.c	2004-04-04
05:36:25.000000000 +0200
+++ linux-2.6.5-ioctl/arch/x86_64/kernel/x8664_ksyms.c	2004-05-06
13:06:39.000000000 +0200
@@ -220,7 +220,5 @@
 EXPORT_SYMBOL_GPL(flush_tlb_all);
 #endif
 
-EXPORT_SYMBOL(sys_ioctl);
-
 EXPORT_SYMBOL(memcpy_toio);
 EXPORT_SYMBOL(memcpy_fromio);
diff -aur linux-2.6.5/fs/ioctl.c linux-2.6.5-ioctl/fs/ioctl.c
--- linux-2.6.5/fs/ioctl.c	2004-04-04 05:36:26.000000000 +0200
+++ linux-2.6.5-ioctl/fs/ioctl.c	2004-05-06 13:05:56.000000000
+0200
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/file.h>
@@ -132,3 +133,6 @@
 out:
 	return error;
 }
+#ifdef CONFIG_COMPAT
+EXPORT_SYMBOL(sys_ioctl)
+#endif

