Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTFPIvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTFPIvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:51:50 -0400
Received: from dp.samba.org ([66.70.73.150]:60578 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263631AbTFPIvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:51:48 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re-xmit: clean up overzealous deprecated warning
Date: Mon, 16 Jun 2003 19:05:21 +1000
Message-Id: <20030616090541.84B122C08A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Name: Fix overzealous check_region deprecation
Author: Rusty Russell
Status: Trivial

D: 1) We export __check_region, so making it __deprecated gives a spurious
D:    warning in kernel/ksyms.c.
D: 2) Other warnings refer to __check_region rather than check_region,
D:    which has confused some people.
D:
D: Make check_region an inline, not a macro, and deprecate *that*.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.70-bk16/include/linux/ioport.h working-2.5.70-bk16-check_region/include/linux/ioport.h
--- linux-2.5.70-bk16/include/linux/ioport.h	2003-03-25 12:17:30.000000000 +1100
+++ working-2.5.70-bk16-check_region/include/linux/ioport.h	2003-06-12 20:02:55.000000000 +1000
@@ -105,12 +105,15 @@ extern int allocate_resource(struct reso
 extern struct resource * __request_region(struct resource *, unsigned long start, unsigned long n, const char *name);
 
 /* Compatibility cruft */
-#define check_region(start,n)	__check_region(&ioport_resource, (start), (n))
 #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
-extern int __deprecated __check_region(struct resource *, unsigned long, unsigned long);
+extern int __check_region(struct resource *, unsigned long, unsigned long);
 extern void __release_region(struct resource *, unsigned long, unsigned long);
 
+static inline int __deprecated check_region(unsigned long s, unsigned long n)
+{
+	return __check_region(&ioport_resource, s, n);
+}
 #endif	/* _LINUX_IOPORT_H */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
