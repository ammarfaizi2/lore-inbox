Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSHJP3E>; Sat, 10 Aug 2002 11:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSHJP3E>; Sat, 10 Aug 2002 11:29:04 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:35342 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317056AbSHJP25>; Sat, 10 Aug 2002 11:28:57 -0400
Date: Sat, 10 Aug 2002 19:32:20 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.30] alpha: osf getrusage, readv, writev [8/10]
Message-ID: <20020810193220.G20534@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- osf_getrusage() updated for new utime/stime fields of the task_struct;
- compatibility wrappers for OSF/1 v4 readv/writev syscalls:
  forward port from 2.4.19.

Ivan.

--- 2.5.30/arch/alpha/kernel/osf_sys.c	Fri Aug  2 01:16:00 2002
+++ linux/arch/alpha/kernel/osf_sys.c	Thu Aug  8 19:28:01 2002
@@ -33,6 +33,7 @@
 #include <linux/file.h>
 #include <linux/types.h>
 #include <linux/ipc.h>
+#include <linux/namei.h>
 
 #include <asm/fpu.h>
 #include <asm/io.h>
@@ -956,6 +957,13 @@ static inline long put_it32(struct itime
 		 __put_user(i->it_value.tv_usec, &o->it_value.tv_usec)));
 }
 
+static inline void
+jiffies_to_timeval32(unsigned long jiffies, struct timeval32 *value)
+{
+	value->tv_usec = (jiffies % HZ) * (1000000L / HZ);
+	value->tv_sec = jiffies / HZ;
+}
+
 asmlinkage int osf_gettimeofday(struct timeval32 *tv, struct timezone *tz)
 {
 	if (tv) {
@@ -1163,32 +1171,24 @@ asmlinkage int osf_getrusage(int who, st
 	memset(&r, 0, sizeof(r));
 	switch (who) {
 	case RUSAGE_SELF:
-		r.ru_utime.tv_sec = CT_TO_SECS(current->times.tms_utime);
-		r.ru_utime.tv_usec = CT_TO_USECS(current->times.tms_utime);
-		r.ru_stime.tv_sec = CT_TO_SECS(current->times.tms_stime);
-		r.ru_stime.tv_usec = CT_TO_USECS(current->times.tms_stime);
+		jiffies_to_timeval32(current->utime, &r.ru_utime);
+		jiffies_to_timeval32(current->stime, &r.ru_stime);
 		r.ru_minflt = current->min_flt;
 		r.ru_majflt = current->maj_flt;
 		r.ru_nswap = current->nswap;
 		break;
 	case RUSAGE_CHILDREN:
-		r.ru_utime.tv_sec = CT_TO_SECS(current->times.tms_cutime);
-		r.ru_utime.tv_usec = CT_TO_USECS(current->times.tms_cutime);
-		r.ru_stime.tv_sec = CT_TO_SECS(current->times.tms_cstime);
-		r.ru_stime.tv_usec = CT_TO_USECS(current->times.tms_cstime);
+		jiffies_to_timeval32(current->cutime, &r.ru_utime);
+		jiffies_to_timeval32(current->cstime, &r.ru_stime);
 		r.ru_minflt = current->cmin_flt;
 		r.ru_majflt = current->cmaj_flt;
 		r.ru_nswap = current->cnswap;
 		break;
 	default:
-		r.ru_utime.tv_sec = CT_TO_SECS(current->times.tms_utime +
-					       current->times.tms_cutime);
-		r.ru_utime.tv_usec = CT_TO_USECS(current->times.tms_utime +
-						 current->times.tms_cutime);
-		r.ru_stime.tv_sec = CT_TO_SECS(current->times.tms_stime +
-					       current->times.tms_cstime);
-		r.ru_stime.tv_usec = CT_TO_USECS(current->times.tms_stime +
-						 current->times.tms_cstime);
+		jiffies_to_timeval32(current->utime + current->cutime,
+				   &r.ru_utime);
+		jiffies_to_timeval32(current->stime + current->cstime,
+				   &r.ru_stime);
 		r.ru_minflt = current->min_flt + current->cmin_flt;
 		r.ru_majflt = current->maj_flt + current->cmaj_flt;
 		r.ru_nswap = current->nswap + current->cnswap;
@@ -1390,3 +1390,44 @@ arch_get_unmapped_area(struct file *filp
 
 	return addr;
 }
+
+#ifdef CONFIG_OSF4_COMPAT
+extern ssize_t sys_readv(unsigned long, const struct iovec *, unsigned long);
+extern ssize_t sys_writev(unsigned long, const struct iovec *, unsigned long);
+
+/* Clear top 32 bits of iov_len in the user's buffer for
+   compatibility with old versions of OSF/1 where iov_len
+   was defined as int. */
+static int
+osf_fix_iov_len(const struct iovec *iov, unsigned long count)
+{
+	unsigned long i;
+
+	for (i = 0 ; i < count ; i++) {
+		int *iov_len_high = (int *)&iov[i].iov_len + 1;
+
+		if (put_user(0, iov_len_high))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+asmlinkage ssize_t
+osf_readv(unsigned long fd, const struct iovec * vector, unsigned long count)
+{
+	if (unlikely(personality(current->personality) == PER_OSF4))
+		if (osf_fix_iov_len(vector, count))
+			return -EFAULT;
+	return sys_readv(fd, vector, count);
+}
+
+asmlinkage ssize_t
+osf_writev(unsigned long fd, const struct iovec * vector, unsigned long count)
+{
+	if (unlikely(personality(current->personality) == PER_OSF4))
+		if (osf_fix_iov_len(vector, count))
+			return -EFAULT;
+	return sys_writev(fd, vector, count);
+}
+
+#endif
--- 2.5.30/arch/alpha/Config.help	Fri Aug  2 01:16:07 2002
+++ linux/arch/alpha/Config.help	Thu Aug  8 19:28:01 2002
@@ -438,6 +438,12 @@ CONFIG_BINFMT_AOUT
   because some crucial programs on your system might still be in A.OUT
   format.
 
+OSF/1 v4 readv/writev compatibility
+CONFIG_OSF4_COMPAT
+  Say Y if you are using OSF/1 binaries (like Netscape and Acrobat)
+  with v4 shared libraries freely available from Compaq. If you're
+  going to use shared libraries from Tru64 version 5.0 or later, say N.
+
 CONFIG_BINFMT_EM86
   Say Y here if you want to be able to execute Linux/Intel ELF
   binaries just like native Alpha binaries on your Alpha machine. For
--- 2.5.30/arch/alpha/kernel/entry.S	Fri Aug  2 01:16:00 2002
+++ linux/arch/alpha/kernel/entry.S	Thu Aug  8 19:28:01 2002
@@ -851,8 +851,13 @@ sys_call_table:
 	.quad osf_getrusage
 	.quad sys_getsockopt
 	.quad alpha_ni_syscall
+#ifdef CONFIG_OSF4_COMPAT
+	.quad osf_readv				/* 120 */
+	.quad osf_writev
+#else
 	.quad sys_readv				/* 120 */
 	.quad sys_writev
+#endif
 	.quad osf_settimeofday
 	.quad sys_fchown
 	.quad sys_fchmod
--- 2.5.30/arch/alpha/config.in	Fri Aug  2 01:16:14 2002
+++ linux/arch/alpha/config.in	Thu Aug  8 19:49:18 2002
@@ -264,6 +264,10 @@ if [ "$CONFIG_PROC_FS" != "n" ]; then
 fi
  
 tristate 'Kernel support for a.out (ECOFF) binaries' CONFIG_BINFMT_AOUT
+if [ "$CONFIG_BINFMT_AOUT" != "n" ]; then
+	bool '  OSF/1 v4 readv/writev compatibility' CONFIG_OSF4_COMPAT
+fi
+
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 tristate 'Kernel support for Linux/Intel ELF binaries' CONFIG_BINFMT_EM86
--- 2.5.30/include/linux/personality.h	Fri Aug  2 01:16:27 2002
+++ linux/include/linux/personality.h	Thu Aug  8 19:28:01 2002
@@ -62,6 +62,7 @@ enum {
 	PER_RISCOS =		0x000c,
 	PER_SOLARIS =		0x000d | STICKY_TIMEOUTS,
 	PER_UW7 =		0x000e | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
+	PER_OSF4 =		0x000f,			 /* OSF/1 v4 */
 	PER_MASK =		0x00ff,
 };
 
--- 2.5.30/include/asm-alpha/a.out.h	Fri Aug  2 01:16:12 2002
+++ linux/include/asm-alpha/a.out.h	Thu Aug  8 19:28:02 2002
@@ -95,8 +95,8 @@ struct exec
    Worse, we have to notice the start address before swapping to use
    /sbin/loader, which of course is _not_ a TASO application.  */
 #define SET_AOUT_PERSONALITY(BFPM, EX) \
-	set_personality (BFPM->sh_bang || EX.ah.entry < 0x100000000 \
-			 ? PER_LINUX_32BIT : PER_LINUX)
+	set_personality (((BFPM->sh_bang || EX.ah.entry < 0x100000000 \
+			   ? ADDR_LIMIT_32BIT : 0) | PER_OSF4))
 
 #define STACK_TOP \
   (current->personality & ADDR_LIMIT_32BIT ? 0x80000000 : 0x00120000000UL)
