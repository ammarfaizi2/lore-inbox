Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbTAPDdL>; Wed, 15 Jan 2003 22:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTAPDdL>; Wed, 15 Jan 2003 22:33:11 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:44760 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265409AbTAPDdK>;
	Wed, 15 Jan 2003 22:33:10 -0500
Date: Thu, 16 Jan 2003 14:41:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx
Subject: [PATCH][COMPAT] compat_sys_sigpending and compat_sys_sigprocmask
 generic
Message-Id: <20030116144129.2251138d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch creates compat_sys_sigpending and compat_sys_sigprocmask
and removes all the arch specific versions.  It requires my previous
patch ("PATCH][COMPAT] compat_{old_}sigset_t").  The diffstat of
the entire patch is below, but here I have included only the generic
part.

 arch/ia64/ia32/ia32_entry.S       |    4 +-
 arch/ia64/ia32/ia32_signal.c      |    6 ----
 arch/ia64/ia32/sys_ia32.c         |    6 ----
 arch/mips64/kernel/scall_o32.S    |    4 +-
 arch/mips64/kernel/signal32.c     |   38 ----------------------------
 arch/parisc/kernel/signal32.c     |   51 --------------------------------------
 arch/parisc/kernel/syscall.S      |    4 +-
 arch/ppc64/kernel/misc.S          |    4 +-
 arch/ppc64/kernel/signal32.c      |   50 -------------------------------------
 arch/s390x/kernel/entry.S         |    4 +-
 arch/s390x/kernel/linux32.c       |   32 -----------------------
 arch/s390x/kernel/wrapper32.S     |   18 ++++++-------
 arch/sparc64/kernel/sys_sparc32.c |   32 -----------------------
 arch/sparc64/kernel/systbls.S     |    6 ++--
 arch/x86_64/ia32/ia32entry.S      |    4 +-
 arch/x86_64/ia32/sys_ia32.c       |   35 --------------------------
 kernel/compat.c                   |   44 ++++++++++++++++++++++++++++++++
 17 files changed, 67 insertions(+), 275 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.5/kernel/compat.c 2.5.58-32bit.6/kernel/compat.c
--- 2.5.58-32bit.5/kernel/compat.c	2003-01-09 16:24:07.000000000 +1100
+++ 2.5.58-32bit.6/kernel/compat.c	2003-01-16 11:26:43.000000000 +1100
@@ -4,7 +4,7 @@
  *  Kernel compatibililty routines for e.g. 32 bit syscall support
  *  on 64 bit kernels.
  *
- *  Copyright (C) 2002 Stephen Rothwell, IBM Corporation
+ *  Copyright (C) 2002-2003 Stephen Rothwell, IBM Corporation
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -15,6 +15,7 @@
 #include <linux/compat.h>
 #include <linux/errno.h>
 #include <linux/time.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 
@@ -166,3 +167,44 @@
 	}
 	return compat_jiffies_to_clock_t(jiffies);
 }
+
+/*
+ * Assumption: old_sigset_t and compat_old_sigset_t are both
+ * types that can be passed to put_user()/get_user().
+ */
+
+extern asmlinkage long sys_sigpending(old_sigset_t *);
+
+asmlinkage long compat_sys_sigpending(compat_old_sigset_t *set)
+{
+	old_sigset_t s;
+	long ret;
+	mm_segment_t old_fs = get_fs();
+
+	set_fs(KERNEL_DS);
+	ret = sys_sigpending(&s);
+	set_fs(old_fs);
+	if (ret == 0)
+		ret = put_user(s, set);
+	return ret;
+}
+
+extern asmlinkage long sys_sigprocmask(int, old_sigset_t *, old_sigset_t *);
+
+asmlinkage long compat_sys_sigprocmask(int how, compat_old_sigset_t *set,
+		compat_old_sigset_t *oset)
+{
+	old_sigset_t s;
+	long ret;
+	mm_segment_t old_fs;
+
+	if (set && get_user(s, set))
+		return -EFAULT;
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = sys_sigprocmask(how, set ? &s : NULL, oset ? &s : NULL);
+	set_fs(old_fs);
+	if (ret == 0)
+		ret = put_user(s, oset);
+	return ret;
+}
