Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUE3KrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUE3KrS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 06:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUE3KrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 06:47:17 -0400
Received: from aun.it.uu.se ([130.238.12.36]:14767 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262079AbUE3KrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 06:47:12 -0400
Date: Sun, 30 May 2004 12:47:05 +0200 (MEST)
Message-Id: <200405301047.i4UAl5Wg003268@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: torvalds@osdl.org
Subject: [PATCH][2.6.7-rc2] gcc-3.4.0 warning in i386 __down_read_trylock()
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The i386 __down_read_trylock() code contains a "+m" asm
constraint, which triggers warnings from gcc-3.4.0:

  gcc -Wp,-MD,fs/xfs/.xfs_iget.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -msoft-float -mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=k8 -Iinclude/asm-i386/mach-default -O2 -fomit-frame-pointer -Wdeclaration-after-statement -Ifs/xfs -Ifs/xfs/linux-2.6 -funsigned-char   -DKBUILD_BASENAME=xfs_iget -DKBUILD_MODNAME=xfs -c -o fs/xfs/xfs_iget.o fs/xfs/xfs_iget.c
include/asm/rwsem.h: In function `xfs_ilock_nowait':
include/asm/rwsem.h:126: warning: read-write constraint does not allow a register
include/asm/rwsem.h:126: warning: read-write constraint does not allow a register
include/asm/rwsem.h:126: warning: read-write constraint does not allow a register
include/asm/rwsem.h:126: warning: read-write constraint does not allow a register

Fixed by the patch below.

/Mikael

diff -ruN linux-2.6.7-rc2/include/asm-i386/rwsem.h linux-2.6.7-rc2.gcc340-fixes/include/asm-i386/rwsem.h
--- linux-2.6.7-rc2/include/asm-i386/rwsem.h	2003-03-08 17:22:32.000000000 +0100
+++ linux-2.6.7-rc2.gcc340-fixes/include/asm-i386/rwsem.h	2004-05-30 11:39:07.000000000 +0200
@@ -134,8 +134,8 @@
 		"  jnz	     1b\n\t"
 		"2:\n\t"
 		"# ending __down_read_trylock\n\t"
-		: "+m"(sem->count), "=&a"(result), "=&r"(tmp)
-		: "i"(RWSEM_ACTIVE_READ_BIAS)
+		: "=m"(sem->count), "=&a"(result), "=&r"(tmp)
+		: "i"(RWSEM_ACTIVE_READ_BIAS), "m"(sem->count)
 		: "memory", "cc");
 	return result>=0 ? 1 : 0;
 }
