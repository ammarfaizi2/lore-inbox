Return-Path: <linux-kernel-owner+w=401wt.eu-S932594AbXAGPlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbXAGPlK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 10:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbXAGPlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:41:09 -0500
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:33366 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588AbXAGPlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:41:07 -0500
Date: Sun, 7 Jan 2007 10:40:45 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org
Subject: [PATCH] Common compat_sys_sysinfo (v2)
Message-ID: <20070107154045.GD3207@athena.road.mcmartin.ca>
References: <20070107144850.GB3207@athena.road.mcmartin.ca> <20070107151319.GA23478@infradead.org> <20070107152213.GC3207@athena.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107152213.GC3207@athena.road.mcmartin.ca>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/arch/ia64/ia32/ia32_entry.S b/arch/ia64/ia32/ia32_entry.S
index a32cd59..0a76de0 100644
--- a/arch/ia64/ia32/ia32_entry.S
+++ b/arch/ia64/ia32/ia32_entry.S
@@ -326,7 +326,7 @@ ia32_syscall_table:
 	data8 sys_ni_syscall
 	data8 compat_sys_wait4
 	data8 sys_swapoff	  /* 115 */
-	data8 sys32_sysinfo
+	data8 compat_sys_sysinfo 
 	data8 sys32_ipc
 	data8 sys_fsync
 	data8 sys32_sigreturn
diff --git a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
index 957681c..d430d36 100644
--- a/arch/ia64/ia32/sys_ia32.c
+++ b/arch/ia64/ia32/sys_ia32.c
@@ -2209,74 +2209,6 @@ sys32_fstat64 (unsigned int fd, struct stat64 __user *statbuf)
 	return ret;
 }
 
-struct sysinfo32 {
-	s32 uptime;
-	u32 loads[3];
-	u32 totalram;
-	u32 freeram;
-	u32 sharedram;
-	u32 bufferram;
-	u32 totalswap;
-	u32 freeswap;
-	u16 procs;
-	u16 pad;
-	u32 totalhigh;
-	u32 freehigh;
-	u32 mem_unit;
-	char _f[8];
-};
-
-asmlinkage long
-sys32_sysinfo (struct sysinfo32 __user *info)
-{
-	struct sysinfo s;
-	long ret, err;
-	int bitcount = 0;
-	mm_segment_t old_fs = get_fs();
-
-	set_fs(KERNEL_DS);
-	ret = sys_sysinfo((struct sysinfo __user *) &s);
-	set_fs(old_fs);
-	/* Check to see if any memory value is too large for 32-bit and
-	 * scale down if needed.
-	 */
-	if ((s.totalram >> 32) || (s.totalswap >> 32)) {
-		while (s.mem_unit < PAGE_SIZE) {
-			s.mem_unit <<= 1;
-			bitcount++;
-		}
-		s.totalram >>= bitcount;
-		s.freeram >>= bitcount;
-		s.sharedram >>= bitcount;
-		s.bufferram >>= bitcount;
-		s.totalswap >>= bitcount;
-		s.freeswap >>= bitcount;
-		s.totalhigh >>= bitcount;
-		s.freehigh >>= bitcount;
-	}
-
-	if (!access_ok(VERIFY_WRITE, info, sizeof(*info)))
-		return -EFAULT;
-
-	err  = __put_user(s.uptime, &info->uptime);
-	err |= __put_user(s.loads[0], &info->loads[0]);
-	err |= __put_user(s.loads[1], &info->loads[1]);
-	err |= __put_user(s.loads[2], &info->loads[2]);
-	err |= __put_user(s.totalram, &info->totalram);
-	err |= __put_user(s.freeram, &info->freeram);
-	err |= __put_user(s.sharedram, &info->sharedram);
-	err |= __put_user(s.bufferram, &info->bufferram);
-	err |= __put_user(s.totalswap, &info->totalswap);
-	err |= __put_user(s.freeswap, &info->freeswap);
-	err |= __put_user(s.procs, &info->procs);
-	err |= __put_user (s.totalhigh, &info->totalhigh);
-	err |= __put_user (s.freehigh, &info->freehigh);
-	err |= __put_user (s.mem_unit, &info->mem_unit);
-	if (err)
-		return -EFAULT;
-	return ret;
-}
-
 asmlinkage long
 sys32_sched_rr_get_interval (pid_t pid, struct compat_timespec __user *interval)
 {
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index b061c9a..c4a9cb7 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -193,50 +193,6 @@ sysn32_waitid(int which, compat_pid_t pid,
 	return ret;
 }
 
-struct sysinfo32 {
-        s32 uptime;
-        u32 loads[3];
-        u32 totalram;
-        u32 freeram;
-        u32 sharedram;
-        u32 bufferram;
-        u32 totalswap;
-        u32 freeswap;
-        u16 procs;
-	u32 totalhigh;
-	u32 freehigh;
-	u32 mem_unit;
-	char _f[8];
-};
-
-asmlinkage int sys32_sysinfo(struct sysinfo32 __user *info)
-{
-	struct sysinfo s;
-	int ret, err;
-	mm_segment_t old_fs = get_fs ();
-
-	set_fs (KERNEL_DS);
-	ret = sys_sysinfo((struct sysinfo __user *)&s);
-	set_fs (old_fs);
-	err = put_user (s.uptime, &info->uptime);
-	err |= __put_user (s.loads[0], &info->loads[0]);
-	err |= __put_user (s.loads[1], &info->loads[1]);
-	err |= __put_user (s.loads[2], &info->loads[2]);
-	err |= __put_user (s.totalram, &info->totalram);
-	err |= __put_user (s.freeram, &info->freeram);
-	err |= __put_user (s.sharedram, &info->sharedram);
-	err |= __put_user (s.bufferram, &info->bufferram);
-	err |= __put_user (s.totalswap, &info->totalswap);
-	err |= __put_user (s.freeswap, &info->freeswap);
-	err |= __put_user (s.procs, &info->procs);
-	err |= __put_user (s.totalhigh, &info->totalhigh);
-	err |= __put_user (s.freehigh, &info->freehigh);
-	err |= __put_user (s.mem_unit, &info->mem_unit);
-	if (err)
-		return -EFAULT;
-	return ret;
-}
-
 #define RLIM_INFINITY32	0x7fffffff
 #define RESOURCE32(x) ((x > RLIM_INFINITY32) ? RLIM_INFINITY32 : x)
 
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 34567d8..d2ce8f6 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -217,7 +217,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys32_gettimeofday
 	PTR	compat_sys_getrlimit		/* 6095 */
 	PTR	compat_sys_getrusage
-	PTR	sys32_sysinfo
+	PTR	compat_sys_sysinfo
 	PTR	compat_sys_times
 	PTR	sys32_ptrace
 	PTR	sys_getuid			/* 6100 */
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index e91379c..4b5c513 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -321,7 +321,7 @@ sys_call_table:
 	PTR	sys_ni_syscall			/* sys_vm86 */
 	PTR	compat_sys_wait4
 	PTR	sys_swapoff			/* 4115 */
-	PTR	sys32_sysinfo
+	PTR	compat_sys_sysinfo
 	PTR	sys32_ipc
 	PTR	sys_fsync
 	PTR	sys32_sigreturn
diff --git a/arch/parisc/kernel/sys_parisc32.c b/arch/parisc/kernel/sys_parisc32.c
index 29be437..ce3245f 100644
--- a/arch/parisc/kernel/sys_parisc32.c
+++ b/arch/parisc/kernel/sys_parisc32.c
@@ -579,70 +579,6 @@ asmlinkage int sys32_sendfile64(int out_fd, int in_fd, compat_loff_t __user *off
 }
 
 
-struct sysinfo32 {
-	s32 uptime;
-	u32 loads[3];
-	u32 totalram;
-	u32 freeram;
-	u32 sharedram;
-	u32 bufferram;
-	u32 totalswap;
-	u32 freeswap;
-	unsigned short procs;
-	u32 totalhigh;
-	u32 freehigh;
-	u32 mem_unit;
-	char _f[12];
-};
-
-/* We used to call sys_sysinfo and translate the result.  But sys_sysinfo
- * undoes the good work done elsewhere, and rather than undoing the
- * damage, I decided to just duplicate the code from sys_sysinfo here.
- */
-
-asmlinkage int sys32_sysinfo(struct sysinfo32 __user *info)
-{
-	struct sysinfo val;
-	int err;
-	unsigned long seq;
-
-	/* We don't need a memset here because we copy the
-	 * struct to userspace once element at a time.
-	 */
-
-	do {
-		seq = read_seqbegin(&xtime_lock);
-		val.uptime = jiffies / HZ;
-
-		val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
-		val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
-		val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
-
-		val.procs = nr_threads;
-	} while (read_seqretry(&xtime_lock, seq));
-
-
-	si_meminfo(&val);
-	si_swapinfo(&val);
-	
-	err = put_user (val.uptime, &info->uptime);
-	err |= __put_user (val.loads[0], &info->loads[0]);
-	err |= __put_user (val.loads[1], &info->loads[1]);
-	err |= __put_user (val.loads[2], &info->loads[2]);
-	err |= __put_user (val.totalram, &info->totalram);
-	err |= __put_user (val.freeram, &info->freeram);
-	err |= __put_user (val.sharedram, &info->sharedram);
-	err |= __put_user (val.bufferram, &info->bufferram);
-	err |= __put_user (val.totalswap, &info->totalswap);
-	err |= __put_user (val.freeswap, &info->freeswap);
-	err |= __put_user (val.procs, &info->procs);
-	err |= __put_user (val.totalhigh, &info->totalhigh);
-	err |= __put_user (val.freehigh, &info->freehigh);
-	err |= __put_user (val.mem_unit, &info->mem_unit);
-	return err ? -EFAULT : 0;
-}
-
-
 /* lseek() needs a wrapper because 'offset' can be negative, but the top
  * half of the argument has been zeroed by syscall.S.
  */
diff --git a/arch/parisc/kernel/syscall_table.S b/arch/parisc/kernel/syscall_table.S
index 701d66a..be8eb9a 100644
--- a/arch/parisc/kernel/syscall_table.S
+++ b/arch/parisc/kernel/syscall_table.S
@@ -197,7 +197,7 @@
 	/* struct rusage contains longs... */
 	ENTRY_COMP(wait4)
 	ENTRY_SAME(swapoff)		/* 115 */
-	ENTRY_DIFF(sysinfo)
+	ENTRY_COMP(sysinfo)
 	ENTRY_SAME(shutdown)
 	ENTRY_SAME(fsync)
 	ENTRY_SAME(madvise)
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 03a2a2f..673e8d9 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -198,73 +198,6 @@ static inline long put_tv32(struct compat_timeval __user *o, struct timeval *i)
 		 __put_user(i->tv_usec, &o->tv_usec)));
 }
 
-struct sysinfo32 {
-        s32 uptime;
-        u32 loads[3];
-        u32 totalram;
-        u32 freeram;
-        u32 sharedram;
-        u32 bufferram;
-        u32 totalswap;
-        u32 freeswap;
-        unsigned short procs;
-	unsigned short pad;
-	u32 totalhigh;
-	u32 freehigh;
-	u32 mem_unit;
-	char _f[20-2*sizeof(int)-sizeof(int)];
-};
-
-asmlinkage long compat_sys_sysinfo(struct sysinfo32 __user *info)
-{
-	struct sysinfo s;
-	int ret, err;
-	int bitcount=0;
-	mm_segment_t old_fs = get_fs ();
-	
-	/* The __user cast is valid due to set_fs() */
-	set_fs (KERNEL_DS);
-	ret = sys_sysinfo((struct sysinfo __user *)&s);
-	set_fs (old_fs);
-
-	/* Check to see if any memory value is too large for 32-bit and
-         * scale down if needed.
-         */
-	if ((s.totalram >> 32) || (s.totalswap >> 32)) {
-	    while (s.mem_unit < PAGE_SIZE) {
-		s.mem_unit <<= 1;
-		bitcount++;
-	    }
-	    s.totalram >>=bitcount;
-	    s.freeram >>= bitcount;
-	    s.sharedram >>= bitcount;
-	    s.bufferram >>= bitcount;
-	    s.totalswap >>= bitcount;
-	    s.freeswap >>= bitcount;
-	    s.totalhigh >>= bitcount;
-	    s.freehigh >>= bitcount;
-	}
-
-	err = put_user (s.uptime, &info->uptime);
-	err |= __put_user (s.loads[0], &info->loads[0]);
-	err |= __put_user (s.loads[1], &info->loads[1]);
-	err |= __put_user (s.loads[2], &info->loads[2]);
-	err |= __put_user (s.totalram, &info->totalram);
-	err |= __put_user (s.freeram, &info->freeram);
-	err |= __put_user (s.sharedram, &info->sharedram);
-	err |= __put_user (s.bufferram, &info->bufferram);
-	err |= __put_user (s.totalswap, &info->totalswap);
-	err |= __put_user (s.freeswap, &info->freeswap);
-	err |= __put_user (s.procs, &info->procs);
-	err |= __put_user (s.totalhigh, &info->totalhigh);
-	err |= __put_user (s.freehigh, &info->freehigh);
-	err |= __put_user (s.mem_unit, &info->mem_unit);
-	if (err)
-		return -EFAULT;
-	
-	return ret;
-}
-
 
 
 
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 5b33f82..88b5858 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -392,51 +392,6 @@ int cp_compat_stat(struct kstat *stat, struct compat_stat __user *statbuf)
 	return err;
 }
 
-struct sysinfo32 {
-        s32 uptime;
-        u32 loads[3];
-        u32 totalram;
-        u32 freeram;
-        u32 sharedram;
-        u32 bufferram;
-        u32 totalswap;
-        u32 freeswap;
-        unsigned short procs;
-	unsigned short pads;
-	u32 totalhigh;
-	u32 freehigh;
-	unsigned int mem_unit;
-        char _f[8];
-};
-
-asmlinkage long sys32_sysinfo(struct sysinfo32 __user *info)
-{
-	struct sysinfo s;
-	int ret, err;
-	mm_segment_t old_fs = get_fs ();
-	
-	set_fs (KERNEL_DS);
-	ret = sys_sysinfo((struct sysinfo __user *) &s);
-	set_fs (old_fs);
-	err = put_user (s.uptime, &info->uptime);
-	err |= __put_user (s.loads[0], &info->loads[0]);
-	err |= __put_user (s.loads[1], &info->loads[1]);
-	err |= __put_user (s.loads[2], &info->loads[2]);
-	err |= __put_user (s.totalram, &info->totalram);
-	err |= __put_user (s.freeram, &info->freeram);
-	err |= __put_user (s.sharedram, &info->sharedram);
-	err |= __put_user (s.bufferram, &info->bufferram);
-	err |= __put_user (s.totalswap, &info->totalswap);
-	err |= __put_user (s.freeswap, &info->freeswap);
-	err |= __put_user (s.procs, &info->procs);
-	err |= __put_user (s.totalhigh, &info->totalhigh);
-	err |= __put_user (s.freehigh, &info->freehigh);
-	err |= __put_user (s.mem_unit, &info->mem_unit);
-	if (err)
-		return -EFAULT;
-	return ret;
-}
-
 asmlinkage long sys32_sched_rr_get_interval(compat_pid_t pid,
 				struct compat_timespec __user *interval)
 {
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 71e54ef..9790129 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -517,10 +517,10 @@ sys32_swapoff_wrapper:
 	llgtr	%r2,%r2			# const char *
 	jg	sys_swapoff		# branch to system call
 
-	.globl	sys32_sysinfo_wrapper
-sys32_sysinfo_wrapper:
+	.globl	compat_sys_sysinfo_wrapper
+compat_sys_sysinfo_wrapper:
 	llgtr	%r2,%r2			# struct sysinfo_emu31 *
-	jg	sys32_sysinfo		# branch to system call
+	jg	compat_sys_sysinfo	# branch to system call
 
 	.globl	sys32_ipc_wrapper
 sys32_ipc_wrapper:
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index a4ceae3..a52c444 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -124,7 +124,7 @@ NI_SYSCALL							/* old "idle" system call */
 NI_SYSCALL							/* vm86old for i386 */
 SYSCALL(sys_wait4,sys_wait4,compat_sys_wait4_wrapper)
 SYSCALL(sys_swapoff,sys_swapoff,sys32_swapoff_wrapper)		/* 115 */
-SYSCALL(sys_sysinfo,sys_sysinfo,sys32_sysinfo_wrapper)
+SYSCALL(sys_sysinfo,sys_sysinfo,compat_sys_sysinfo_wrapper)
 SYSCALL(sys_ipc,sys_ipc,sys32_ipc_wrapper)
 SYSCALL(sys_fsync,sys_fsync,sys32_fsync_wrapper)
 SYSCALL(sys_sigreturn_glue,sys_sigreturn_glue,sys32_sigreturn_glue)
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
index e27cb71..7876a02 100644
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -459,70 +459,6 @@ asmlinkage long compat_sys_sysfs(int option, u32 arg1, u32 arg2)
 	return sys_sysfs(option, arg1, arg2);
 }
 
-struct sysinfo32 {
-        s32 uptime;
-        u32 loads[3];
-        u32 totalram;
-        u32 freeram;
-        u32 sharedram;
-        u32 bufferram;
-        u32 totalswap;
-        u32 freeswap;
-        unsigned short procs;
-	unsigned short pad;
-	u32 totalhigh;
-	u32 freehigh;
-	u32 mem_unit;
-	char _f[20-2*sizeof(int)-sizeof(int)];
-};
-
-asmlinkage long sys32_sysinfo(struct sysinfo32 __user *info)
-{
-	struct sysinfo s;
-	int ret, err;
-	int bitcount = 0;
-	mm_segment_t old_fs = get_fs ();
-	
-	set_fs(KERNEL_DS);
-	ret = sys_sysinfo((struct sysinfo __user *) &s);
-	set_fs(old_fs);
-	/* Check to see if any memory value is too large for 32-bit and
-         * scale down if needed.
-         */
-	if ((s.totalram >> 32) || (s.totalswap >> 32)) {
-		while (s.mem_unit < PAGE_SIZE) {
-			s.mem_unit <<= 1;
-			bitcount++;
-		}
-		s.totalram >>= bitcount;
-		s.freeram >>= bitcount;
-		s.sharedram >>= bitcount;
-		s.bufferram >>= bitcount;
-		s.totalswap >>= bitcount;
-		s.freeswap >>= bitcount;
-		s.totalhigh >>= bitcount;
-		s.freehigh >>= bitcount;
-	}
-
-	err = put_user (s.uptime, &info->uptime);
-	err |= __put_user (s.loads[0], &info->loads[0]);
-	err |= __put_user (s.loads[1], &info->loads[1]);
-	err |= __put_user (s.loads[2], &info->loads[2]);
-	err |= __put_user (s.totalram, &info->totalram);
-	err |= __put_user (s.freeram, &info->freeram);
-	err |= __put_user (s.sharedram, &info->sharedram);
-	err |= __put_user (s.bufferram, &info->bufferram);
-	err |= __put_user (s.totalswap, &info->totalswap);
-	err |= __put_user (s.freeswap, &info->freeswap);
-	err |= __put_user (s.procs, &info->procs);
-	err |= __put_user (s.totalhigh, &info->totalhigh);
-	err |= __put_user (s.freehigh, &info->freehigh);
-	err |= __put_user (s.mem_unit, &info->mem_unit);
-	if (err)
-		return -EFAULT;
-	return ret;
-}
-
 asmlinkage long compat_sys_sched_rr_get_interval(compat_pid_t pid, struct compat_timespec __user *interval)
 {
 	struct timespec t;
diff --git a/arch/sparc64/kernel/systbls.S b/arch/sparc64/kernel/systbls.S
index 9a80267..948b7d2 100644
--- a/arch/sparc64/kernel/systbls.S
+++ b/arch/sparc64/kernel/systbls.S
@@ -61,7 +61,7 @@ sys_call_table32:
 	.word sys32_epoll_wait, sys32_ioprio_set, sys_getppid, sys32_sigaction, sys_sgetmask
 /*200*/	.word sys32_ssetmask, sys_sigsuspend, compat_sys_newlstat, sys_uselib, compat_sys_old_readdir
 	.word sys32_readahead, sys32_socketcall, sys32_syslog, sys32_lookup_dcookie, sys32_fadvise64
-/*210*/	.word sys32_fadvise64_64, sys32_tgkill, sys32_waitpid, sys_swapoff, sys32_sysinfo
+/*210*/	.word sys32_fadvise64_64, sys32_tgkill, sys32_waitpid, sys_swapoff, compat_sys_sysinfo
 	.word sys32_ipc, sys32_sigreturn, sys_clone, sys32_ioprio_get, compat_sys_adjtimex
 /*220*/	.word sys32_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys32_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index b4aa875..5f32cf4 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -515,7 +515,7 @@ ia32_sys_call_table:
 	.quad sys32_vm86_warning	/* vm86old */ 
 	.quad compat_sys_wait4
 	.quad sys_swapoff		/* 115 */
-	.quad sys32_sysinfo
+	.quad compat_sys_sysinfo
 	.quad sys32_ipc
 	.quad sys_fsync
 	.quad stub32_sigreturn
diff --git a/arch/x86_64/ia32/sys_ia32.c b/arch/x86_64/ia32/sys_ia32.c
index c9bac3a..200fdde 100644
--- a/arch/x86_64/ia32/sys_ia32.c
+++ b/arch/x86_64/ia32/sys_ia32.c
@@ -523,72 +523,6 @@ sys32_sysfs(int option, u32 arg1, u32 arg2)
 	return sys_sysfs(option, arg1, arg2);
 }
 
-struct sysinfo32 {
-        s32 uptime;
-        u32 loads[3];
-        u32 totalram;
-        u32 freeram;
-        u32 sharedram;
-        u32 bufferram;
-        u32 totalswap;
-        u32 freeswap;
-        unsigned short procs;
-	unsigned short pad; 
-        u32 totalhigh;
-        u32 freehigh;
-        u32 mem_unit;
-        char _f[20-2*sizeof(u32)-sizeof(int)];
-};
-
-asmlinkage long
-sys32_sysinfo(struct sysinfo32 __user *info)
-{
-	struct sysinfo s;
-	int ret;
-	mm_segment_t old_fs = get_fs ();
-	int bitcount = 0;
-	
-	set_fs (KERNEL_DS);
-	ret = sys_sysinfo((struct sysinfo __user *)&s);
-	set_fs (old_fs);
-
-        /* Check to see if any memory value is too large for 32-bit and scale
-	 *  down if needed
-	 */
-	if ((s.totalram >> 32) || (s.totalswap >> 32)) {
-		while (s.mem_unit < PAGE_SIZE) {
-			s.mem_unit <<= 1;
-			bitcount++;
-		}
-		s.totalram >>= bitcount;
-		s.freeram >>= bitcount;
-		s.sharedram >>= bitcount;
-		s.bufferram >>= bitcount;
-		s.totalswap >>= bitcount;
-		s.freeswap >>= bitcount;
-		s.totalhigh >>= bitcount;
-		s.freehigh >>= bitcount;
-	}
-
-	if (!access_ok(VERIFY_WRITE, info, sizeof(struct sysinfo32)) ||
-	    __put_user (s.uptime, &info->uptime) ||
-	    __put_user (s.loads[0], &info->loads[0]) ||
-	    __put_user (s.loads[1], &info->loads[1]) ||
-	    __put_user (s.loads[2], &info->loads[2]) ||
-	    __put_user (s.totalram, &info->totalram) ||
-	    __put_user (s.freeram, &info->freeram) ||
-	    __put_user (s.sharedram, &info->sharedram) ||
-	    __put_user (s.bufferram, &info->bufferram) ||
-	    __put_user (s.totalswap, &info->totalswap) ||
-	    __put_user (s.freeswap, &info->freeswap) ||
-	    __put_user (s.procs, &info->procs) ||
-	    __put_user (s.totalhigh, &info->totalhigh) || 
-	    __put_user (s.freehigh, &info->freehigh) ||
-	    __put_user (s.mem_unit, &info->mem_unit))
-		return -EFAULT;
-	return 0;
-}
-                
 asmlinkage long
 sys32_sched_rr_get_interval(compat_pid_t pid, struct compat_timespec __user *interval)
 {
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index b0c4a05..8bdc929 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -309,6 +309,9 @@ static inline int __attribute__ ((format (printf, 1, 2))) pr_debug(const char *
 	(void)__tmp; \
 })
 
+struct sysinfo;
+extern int do_sysinfo(struct sysinfo *info);
+
 #endif /* __KERNEL__ */
 
 #define SI_LOAD_SHIFT	16
diff --git a/kernel/compat.c b/kernel/compat.c
index 6952dd0..cebb4c2 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -1016,3 +1016,69 @@ asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
 	return sys_migrate_pages(pid, nr_bits + 1, old, new);
 }
 #endif
+
+struct compat_sysinfo {
+	s32 uptime;
+	u32 loads[3];
+	u32 totalram;
+	u32 freeram;
+	u32 sharedram;
+	u32 bufferram;
+	u32 totalswap;
+	u32 freeswap;
+	u16 procs;
+	u16 pad;
+	u32 totalhigh;
+	u32 freehigh;
+	u32 mem_unit;
+	char _f[20-2*sizeof(u32)-sizeof(int)];
+};
+
+asmlinkage long
+compat_sys_sysinfo(struct compat_sysinfo __user *info)
+{
+	struct sysinfo s;
+
+	do_sysinfo(&s);
+
+	/* Check to see if any memory value is too large for 32-bit and scale
+	 *  down if needed
+	 */
+	if ((s.totalram >> 32) || (s.totalswap >> 32)) {
+		int bitcount = 0;
+
+		while (s.mem_unit < PAGE_SIZE) {
+			s.mem_unit <<= 1;
+			bitcount++;
+		}
+
+		s.totalram >>= bitcount;
+		s.freeram >>= bitcount;
+		s.sharedram >>= bitcount;
+		s.bufferram >>= bitcount;
+		s.totalswap >>= bitcount;
+		s.freeswap >>= bitcount;
+		s.totalhigh >>= bitcount;
+		s.freehigh >>= bitcount;
+	}
+
+	if (!access_ok(VERIFY_WRITE, info, sizeof(struct compat_sysinfo)) ||
+	    __put_user (s.uptime, &info->uptime) ||
+	    __put_user (s.loads[0], &info->loads[0]) ||
+	    __put_user (s.loads[1], &info->loads[1]) ||
+	    __put_user (s.loads[2], &info->loads[2]) ||
+	    __put_user (s.totalram, &info->totalram) ||
+	    __put_user (s.freeram, &info->freeram) ||
+	    __put_user (s.sharedram, &info->sharedram) ||
+	    __put_user (s.bufferram, &info->bufferram) ||
+	    __put_user (s.totalswap, &info->totalswap) ||
+	    __put_user (s.freeswap, &info->freeswap) ||
+	    __put_user (s.procs, &info->procs) ||
+	    __put_user (s.totalhigh, &info->totalhigh) ||
+	    __put_user (s.freehigh, &info->freehigh) ||
+	    __put_user (s.mem_unit, &info->mem_unit))
+		return -EFAULT;
+
+	return 0;
+}
+
diff --git a/kernel/timer.c b/kernel/timer.c
index c2a8ccf..28ca2d4 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1392,17 +1392,16 @@ asmlinkage long sys_gettid(void)
 }
 
 /**
- * sys_sysinfo - fill in sysinfo struct
+ * do_sysinfo - fill in sysinfo struct
  * @info: pointer to buffer to fill
  */ 
-asmlinkage long sys_sysinfo(struct sysinfo __user *info)
+int do_sysinfo(struct sysinfo *info)
 {
-	struct sysinfo val;
 	unsigned long mem_total, sav_total;
 	unsigned int mem_unit, bitcount;
 	unsigned long seq;
 
-	memset((char *)&val, 0, sizeof(struct sysinfo));
+	memset(info, 0, sizeof(struct sysinfo));
 
 	do {
 		struct timespec tp;
@@ -1422,17 +1421,17 @@ asmlinkage long sys_sysinfo(struct sysinfo __user *info)
 			tp.tv_nsec = tp.tv_nsec - NSEC_PER_SEC;
 			tp.tv_sec++;
 		}
-		val.uptime = tp.tv_sec + (tp.tv_nsec ? 1 : 0);
+		info->uptime = tp.tv_sec + (tp.tv_nsec ? 1 : 0);
 
-		val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
-		val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
-		val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
+		info->loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
+		info->loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
+		info->loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
 
-		val.procs = nr_threads;
+		info->procs = nr_threads;
 	} while (read_seqretry(&xtime_lock, seq));
 
-	si_meminfo(&val);
-	si_swapinfo(&val);
+	si_meminfo(info);
+	si_swapinfo(info);
 
 	/*
 	 * If the sum of all the available memory (i.e. ram + swap)
@@ -1443,11 +1442,11 @@ asmlinkage long sys_sysinfo(struct sysinfo __user *info)
 	 *  -Erik Andersen <andersee@debian.org>
 	 */
 
-	mem_total = val.totalram + val.totalswap;
-	if (mem_total < val.totalram || mem_total < val.totalswap)
+	mem_total = info->totalram + info->totalswap;
+	if (mem_total < info->totalram || mem_total < info->totalswap)
 		goto out;
 	bitcount = 0;
-	mem_unit = val.mem_unit;
+	mem_unit = info->mem_unit;
 	while (mem_unit > 1) {
 		bitcount++;
 		mem_unit >>= 1;
@@ -1459,22 +1458,31 @@ asmlinkage long sys_sysinfo(struct sysinfo __user *info)
 
 	/*
 	 * If mem_total did not overflow, multiply all memory values by
-	 * val.mem_unit and set it to 1.  This leaves things compatible
+	 * info->mem_unit and set it to 1.  This leaves things compatible
 	 * with 2.2.x, and also retains compatibility with earlier 2.4.x
 	 * kernels...
 	 */
 
-	val.mem_unit = 1;
-	val.totalram <<= bitcount;
-	val.freeram <<= bitcount;
-	val.sharedram <<= bitcount;
-	val.bufferram <<= bitcount;
-	val.totalswap <<= bitcount;
-	val.freeswap <<= bitcount;
-	val.totalhigh <<= bitcount;
-	val.freehigh <<= bitcount;
+	info->mem_unit = 1;
+	info->totalram <<= bitcount;
+	info->freeram <<= bitcount;
+	info->sharedram <<= bitcount;
+	info->bufferram <<= bitcount;
+	info->totalswap <<= bitcount;
+	info->freeswap <<= bitcount;
+	info->totalhigh <<= bitcount;
+	info->freehigh <<= bitcount;
+
+out:
+	return 0;
+}
+
+asmlinkage long sys_sysinfo(struct sysinfo __user *info)
+{
+	struct sysinfo val;
+
+	do_sysinfo(&val);
 
- out:
 	if (copy_to_user(info, &val, sizeof(struct sysinfo)))
 		return -EFAULT;
 
