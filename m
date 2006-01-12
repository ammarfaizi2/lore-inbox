Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWALAbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWALAbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWALAak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:30:40 -0500
Received: from mx.pathscale.com ([64.160.42.68]:55510 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964857AbWALAai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:30:38 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
X-Mercurial-Node: f03a807a80b8bc45bf911e7e679fc59a729a6b87
Message-Id: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1137025774@eng-12.pathscale.com>
Date: Wed, 11 Jan 2006 16:29:36 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: rdreier@cisco.com, ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce an x86_64-specific __raw_memcpy_toio32 routine.  This is
measurably faster than the generic version in lib/raw_memcpy_io.c.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r cd6d8a62dad5 -r f03a807a80b8 arch/x86_64/lib/Makefile
--- a/arch/x86_64/lib/Makefile	Wed Jan 11 16:25:30 2006 -0800
+++ b/arch/x86_64/lib/Makefile	Wed Jan 11 16:26:59 2006 -0800
@@ -4,7 +4,7 @@
 
 CFLAGS_csum-partial.o := -funroll-loops
 
-obj-y := io.o
+obj-y := io.o raw_memcpy_io.o
 
 lib-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
 	usercopy.o getuser.o putuser.o  \
diff -r cd6d8a62dad5 -r f03a807a80b8 arch/x86_64/lib/raw_memcpy_io.S
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/arch/x86_64/lib/raw_memcpy_io.S	Wed Jan 11 16:26:59 2006 -0800
@@ -0,0 +1,29 @@
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
+ * override generic version in lib/raw_memcpy_io.c
+ */
+ 	.globl __raw_memcpy_toio32
+__raw_memcpy_toio32:
+	movl %edx,%ecx
+	shrl $1,%ecx
+	andl $1,%edx
+	rep movsq
+	movl %edx,%ecx
+	rep movsd
+	ret
