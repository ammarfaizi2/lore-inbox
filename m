Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266649AbSLJG2q>; Tue, 10 Dec 2002 01:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266652AbSLJG2q>; Tue, 10 Dec 2002 01:28:46 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:6356 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266649AbSLJG2o>;
	Tue, 10 Dec 2002 01:28:44 -0500
Date: Tue, 10 Dec 2002 17:35:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: [PATCH][COMPAT] consolidate sys32_times - architecture independent
Message-Id: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the next in the series.  This patch creates compat_sys_times and
a few more compability types.  Across all the architectures, the
diffstat looks like this:

 arch/ia64/ia32/ia32_entry.S       |    2 +-
 arch/ia64/ia32/sys_ia32.c         |   31 -------------------------------
 arch/mips64/kernel/linux32.c      |   29 -----------------------------
 arch/mips64/kernel/scall_o32.S    |    2 +-
 arch/parisc/kernel/sys_parisc32.c |   26 --------------------------
 arch/ppc64/kernel/misc.S          |    2 +-
 arch/ppc64/kernel/sys_ppc32.c     |   31 -------------------------------
 arch/s390x/kernel/entry.S         |    2 +-
 arch/s390x/kernel/linux32.c       |   30 ------------------------------
 arch/s390x/kernel/linux32.h       |    6 ++----
 arch/s390x/kernel/wrapper32.S     |    8 ++++----
 arch/sparc64/kernel/sys_sparc32.c |   30 ------------------------------
 arch/sparc64/kernel/systbls.S     |    2 +-
 arch/x86_64/ia32/ia32entry.S      |    2 +-
 arch/x86_64/ia32/sys_ia32.c       |   31 -------------------------------
 include/asm-ia64/compat.h         |    3 +++
 include/asm-ia64/ia32.h           |    8 +++-----
 include/asm-mips64/compat.h       |    3 +++
 include/asm-mips64/posix_types.h  |    3 ---
 include/asm-parisc/compat.h       |    3 +++
 include/asm-parisc/posix_types.h  |    3 ---
 include/asm-ppc64/compat.h        |    3 +++
 include/asm-ppc64/ppc32.h         |    6 ++----
 include/asm-s390x/compat.h        |    3 +++
 include/asm-sparc64/compat.h      |    3 +++
 include/asm-sparc64/posix_types.h |    2 --
 include/asm-sparc64/siginfo.h     |    6 ++++--
 include/asm-x86_64/compat.h       |    3 +++
 include/asm-x86_64/ia32.h         |    8 ++++----
 include/linux/compat.h            |   13 +++++++++++--
 kernel/compat.c                   |   20 ++++++++++++++++++++
 31 files changed, 77 insertions(+), 247 deletions(-)

This is the architecture independent part of the patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.base/include/linux/compat.h 2.5.51-32bit.1/include/linux/compat.h
--- 2.5.51-32bit.base/include/linux/compat.h	2002-12-10 15:10:40.000000000 +1100
+++ 2.5.51-32bit.1/include/linux/compat.h	2002-12-10 16:40:20.000000000 +1100
@@ -1,8 +1,8 @@
 #ifndef _LINUX_COMPAT_H
 #define _LINUX_COMPAT_H
 /*
- * These are the type definitions for the arhitecure sepcific
- * compatibility layer.
+ * These are the type definitions for the architecture specific
+ * syscall compatibility layer.
  */
 #include <linux/config.h>
 
@@ -10,6 +10,8 @@
 
 #include <asm/compat.h>
 
+#define compat_jiffies_to_clock_t(x)	((x) / (HZ / COMPAT_USER_HZ))
+
 struct compat_utimbuf {
 	compat_time_t		actime;
 	compat_time_t		modtime;
@@ -20,5 +22,12 @@
 	struct compat_timeval	it_value;
 };
 
+struct compat_tms {
+	compat_clock_t		tms_utime;
+	compat_clock_t		tms_stime;
+	compat_clock_t		tms_cutime;
+	compat_clock_t		tms_cstime;
+};
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff -ruN 2.5.51-32bit.base/kernel/compat.c 2.5.51-32bit.1/kernel/compat.c
--- 2.5.51-32bit.base/kernel/compat.c	2002-12-10 15:10:41.000000000 +1100
+++ 2.5.51-32bit.1/kernel/compat.c	2002-12-10 16:45:09.000000000 +1100
@@ -161,3 +161,23 @@
 		return -EFAULT;
 	return 0;
 }
+
+asmlinkage long compat_sys_times(struct compat_tms *tbuf)
+{
+	/*
+	 *	In the SMP world we might just be unlucky and have one of
+	 *	the times increment as we use it. Since the value is an
+	 *	atomically safe type this is just fine. Conceptually its
+	 *	as if the syscall took an instant longer to occur.
+	 */
+	if (tbuf) {
+		struct compat_tms tmp;
+		tmp.tms_utime = compat_jiffies_to_clock_t(current->utime);
+		tmp.tms_stime = compat_jiffies_to_clock_t(current->stime);
+		tmp.tms_cutime = compat_jiffies_to_clock_t(current->cutime);
+		tmp.tms_cstime = compat_jiffies_to_clock_t(current->cstime);
+		if (copy_to_user(tbuf, &tmp, sizeof(tmp)))
+			return -EFAULT;
+	}
+	return compat_jiffies_to_clock_t(jiffies);
+}
