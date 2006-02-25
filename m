Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWBYEUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWBYEUr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWBYEUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:20:47 -0500
Received: from mx.pathscale.com ([64.160.42.68]:14258 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932604AbWBYEUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:20:47 -0500
Subject: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 20:20:50 -0800
Message-Id: <1140841250.2587.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, a regular wmb() is not sufficient to guarantee that
PCI writes have been flushed to the bus if write combining is in effect.

This change introduces a new macro, wc_wmb(), that makes this guarantee.

It does so by way of a new header file, <linux/system.h>.  This header
can be a site for oft-replicated code from <asm-*/system.h>, but isn't
just yet.

We also define a version of wc_wmb() with the required semantics
on x86_64.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r c89918da5f7b -r 94d372e00ccd include/asm-x86_64/system.h
--- a/include/asm-x86_64/system.h	Sat Feb 25 08:01:07 2006 +0800
+++ b/include/asm-x86_64/system.h	Fri Feb 24 20:15:07 2006 -0800
@@ -321,6 +321,8 @@ static inline unsigned long __cmpxchg(vo
 #define mb() 	asm volatile("mfence":::"memory")
 #define rmb()	asm volatile("lfence":::"memory")
 
+#define wc_wmb()	asm volatile("sfence" ::: "memory")
+
 #ifdef CONFIG_UNORDERED_IO
 #define wmb()	asm volatile("sfence" ::: "memory")
 #else
diff -r c89918da5f7b -r 94d372e00ccd include/linux/system.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/include/linux/system.h	Fri Feb 24 20:15:07 2006 -0800
@@ -0,0 +1,27 @@
+/*
+ * Copyright 2006 PathScale, Inc.  All Rights Reserved.
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
+ */
+
+#ifndef _LINUX_SYSTEM_H
+#define _LINUX_SYSTEM_H
+
+#include <asm/system.h>
+
+#ifndef wc_wmb
+#define wc_wmb() wmb()
+#endif
+
+#endif /* _LINUX_SYSTEM_H */


