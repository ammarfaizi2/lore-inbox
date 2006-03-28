Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWC1S3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWC1S3F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWC1S3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:29:05 -0500
Received: from smtp12.wanadoo.fr ([193.252.22.20]:42073 "EHLO
	smtp12.wanadoo.fr") by vger.kernel.org with ESMTP id S1751197AbWC1S3E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:29:04 -0500
X-ME-UUID: 20060328182901673.A44921C00091@mwinf1208.wanadoo.fr
Date: Tue, 28 Mar 2006 20:29:05 +0200
From: Thierry Godefroy <thgodef@nerim.net>
To: linux-kernel@vger.kernel.org
Subject: BUG in Linux 2.6.16/2.6.16.1 (compilation failure of third party
 software)
Message-Id: <20060328202905.18cb2cb0.thgodef@nerim.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.4; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paragon_NTFS_3.x.v5.1 fails to compile (with gcc v3.4.3) with the following
errors:

gcc -DMODULE  -fshort-wchar  -DUFSD_NTFS=1 -DUFSD_NTFS_SECURITY -DUFSD_NTFS_OBJECTID -DUFSD_NTFS_WRITE_ENABLE -DNDEBUG -DUFSD_DEVICE=ufsd -DUFSD_READONLY=0 -DKBUILD_BASENAME=_ufsdvfs_ -include fs_conf.h -pipe -Wall -fno-exceptions -Wno-multichar -Wstrict-prototypes -Wno-unknown-pragmas -mpreferred-stack-boundary=2 -march=k8 -I /usr/src/linux/include/asm/mach-default -g0 -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common    -c -I /usr/src/linux/include -I "/include" -I/include ufsdvfs.c -o objfre/vfs/ufsdvfs.o
In file included from /usr/src/linux/include/linux/rwsem.h:27,
                 from /usr/src/linux/include/asm/semaphore.h:42,
                 from /usr/src/linux/include/linux/sched.h:20,
                 from /usr/src/linux/include/linux/module.h:10,
                 from ufsdvfs.c:30:
/usr/src/linux/include/asm/rwsem.h: In function `__down_read':
/usr/src/linux/include/asm/rwsem.h:105: error: syntax error before "_ufsdvfs_"
/usr/src/linux/include/asm/rwsem.h: In function `__down_write':
/usr/src/linux/include/asm/rwsem.h:157: error: syntax error before "_ufsdvfs_"
/usr/src/linux/include/asm/rwsem.h: In function `__up_read':
/usr/src/linux/include/asm/rwsem.h:194: error: syntax error before "_ufsdvfs_"
/usr/src/linux/include/asm/rwsem.h:188: warning: unused variable `tmp'
/usr/src/linux/include/asm/rwsem.h: In function `__up_write':
/usr/src/linux/include/asm/rwsem.h:220: error: syntax error before "_ufsdvfs_"
/usr/src/linux/include/asm/rwsem.h: In function `__downgrade_write':
/usr/src/linux/include/asm/rwsem.h:245: error: syntax error before "_ufsdvfs_"
In file included from /usr/src/linux/include/linux/sched.h:20,
                 from /usr/src/linux/include/linux/module.h:10,
                 from ufsdvfs.c:30:
/usr/src/linux/include/asm/semaphore.h: In function `down':
/usr/src/linux/include/asm/semaphore.h:105: error: syntax error before "_ufsdvfs_"
/usr/src/linux/include/asm/semaphore.h: In function `down_interruptible':
/usr/src/linux/include/asm/semaphore.h:130: error: syntax error before "_ufsdvfs_"
/usr/src/linux/include/asm/semaphore.h: In function `down_trylock':
/usr/src/linux/include/asm/semaphore.h:155: error: syntax error before "_ufsdvfs_"
/usr/src/linux/include/asm/semaphore.h: In function `up':
/usr/src/linux/include/asm/semaphore.h:179: error: syntax error before "_ufsdvfs_"
ufsdvfs.c: In function `ufsd_readdir':
ufsdvfs.c:864: warning: implicit declaration of function `update_atime'
ufsdvfs.c: At top level:
ufsdvfs.c:2219: warning: initialization from incompatible pointer type
make: *** [objfre/vfs/ufsdvfs.o] Erreur 1

------

I tracked down the problem to a patch of include/linux/spinlock.h which was
introduced somewhere in 2.6.16:
diff -urN linux-2.6.15/include/linux/spinlock.h linux-2.6.16.1/include/linux/spinlock.h
gives:

--- linux-2.6.15/include/linux/spinlock.h       2006-03-28 19:52:29.000000000 +0200
+++ linux-2.6.16.1/include/linux/spinlock.h     2006-03-24 19:55:28.000000000 +0100
@@ -59,8 +59,7 @@
 /*
  * Must define these before including other files, inline functions need them
  */
-#define LOCK_SECTION_NAME                       \
-        ".text.lock." __stringify(KBUILD_BASENAME)
+#define LOCK_SECTION_NAME ".text.lock."KBUILD_BASENAME
 
 #define LOCK_SECTION_START(extra)               \
         ".subsection 1\n\t"                     \

Reverting this patch fixes the compilation problem.

Thierry Godefroy.

