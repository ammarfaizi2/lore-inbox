Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWALRHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWALRHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWALRHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:07:14 -0500
Received: from mx.pathscale.com ([64.160.42.68]:43711 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751230AbWALRHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:07:13 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 2] Add faster __iowrite32_copy routine for x86_64
X-Mercurial-Node: 30c7112c6e81a83a87f08bda2986ad3549d42855
Message-Id: <30c7112c6e81a83a87f0.1137085532@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1137085530@eng-12.pathscale.com>
Date: Thu, 12 Jan 2006 09:05:32 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, ak@suse.de
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, rdreier@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This assembly version is measurably faster than the generic version
in lib/iomap_copy.c.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r ec2b3675168a -r 30c7112c6e81 arch/x86_64/lib/Makefile
--- a/arch/x86_64/lib/Makefile	Thu Jan 12 09:03:37 2006 -0800
+++ b/arch/x86_64/lib/Makefile	Thu Jan 12 09:03:37 2006 -0800
@@ -4,7 +4,7 @@
 
 CFLAGS_csum-partial.o := -funroll-loops
 
-obj-y := io.o
+obj-y := io.o iomap_copy.o
 
 lib-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
 	usercopy.o getuser.o putuser.o  \
diff -r ec2b3675168a -r 30c7112c6e81 arch/x86_64/lib/iomap_copy.S
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/arch/x86_64/lib/iomap_copy.S	Thu Jan 12 09:03:37 2006 -0800
@@ -0,0 +1,26 @@
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
+/*
+ * override generic version in lib/iomap_copy.c
+ */
+ 	.globl __iowrite32_copy
+	.p2align 4
+__iowrite32_copy:
+	movl %edx,%ecx
+	rep movsd
+	ret
