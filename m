Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVDEVCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVDEVCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVDEVA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:00:27 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:687
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262015AbVDEU64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:58:56 -0400
Date: Tue, 5 Apr 2005 13:57:37 -0700
From: "David S. Miller" <davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Subject: [PATCH] Fix compat stat handling on sparc64
Message-Id: <20050405135737.0a413358.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The compat layer on sparc64 was not filling in the nanosecond
fields in properly for 32-bit compat tasks.  This caused things
like the test-utime.c test to fail in the libc sources.

A problem still remains for native 64-bit binaries.  Like Alpha
the normal stat structure doesn't have the nanosecond fields
so I have to add in the stat64 syscall entry points in the 64-bit
syscall table then add the necessary libc magic.

Signed-off-by: David S. Miller <davem@davemloft.net>

===== arch/sparc64/kernel/sys_sparc32.c 1.118 vs edited =====
--- 1.118/arch/sparc64/kernel/sys_sparc32.c	2005-03-21 09:56:06 -08:00
+++ edited/arch/sparc64/kernel/sys_sparc32.c	2005-04-05 12:38:54 -07:00
@@ -352,11 +352,11 @@
 	err |= put_user(old_encode_dev(stat->rdev), &statbuf->st_rdev);
 	err |= put_user(stat->size, &statbuf->st_size);
 	err |= put_user(stat->atime.tv_sec, &statbuf->st_atime);
-	err |= put_user(0, &statbuf->__unused1);
+	err |= put_user(stat->atime.tv_nsec, &statbuf->st_atime_nsec);
 	err |= put_user(stat->mtime.tv_sec, &statbuf->st_mtime);
-	err |= put_user(0, &statbuf->__unused2);
+	err |= put_user(stat->mtime.tv_nsec, &statbuf->st_mtime_nsec);
 	err |= put_user(stat->ctime.tv_sec, &statbuf->st_ctime);
-	err |= put_user(0, &statbuf->__unused3);
+	err |= put_user(stat->ctime.tv_nsec, &statbuf->st_ctime_nsec);
 	err |= put_user(stat->blksize, &statbuf->st_blksize);
 	err |= put_user(stat->blocks, &statbuf->st_blocks);
 	err |= put_user(0, &statbuf->__unused4[0]);
===== include/asm-sparc64/compat.h 1.19 vs edited =====
--- 1.19/include/asm-sparc64/compat.h	2005-02-17 21:53:03 -08:00
+++ edited/include/asm-sparc64/compat.h	2005-04-05 12:37:58 -07:00
@@ -51,11 +51,11 @@
 	compat_dev_t	st_rdev;
 	compat_off_t	st_size;
 	compat_time_t	st_atime;
-	u32		__unused1;
+	u32		st_atime_nsec;
 	compat_time_t	st_mtime;
-	u32		__unused2;
+	u32		st_mtime_nsec;
 	compat_time_t	st_ctime;
-	u32		__unused3;
+	u32		st_ctime_nsec;
 	compat_off_t	st_blksize;
 	compat_off_t	st_blocks;
 	u32		__unused4[2];
