Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264118AbUCZSVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbUCZSVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:21:53 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:44466 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S264118AbUCZSTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:19:47 -0500
Date: Fri, 26 Mar 2004 19:19:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/7): core fixes.
Message-ID: <20040326181932.GB2523@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 core changes:
 - Fix return type of some system call functions (long vs. int).
 - Fix prototypes for compat system call handlers.
 - Correct some bugs in the compat system call wrappers.
 - Fix broken pointer arithmetic which causes problems with
   gcc 3.4 and -march=z990
 - Remove unnecessary #ifndef & optimize inline assemblies in spinlock.h.
 - Improve handling of deferred condition code 1.
 - New default configuration.

diffstat:
 arch/s390/defconfig               |   31 ++++++++++----
 arch/s390/kernel/compat_linux.c   |   84 +++++++++++++++++++-------------------
 arch/s390/kernel/compat_signal.c  |    4 -
 arch/s390/kernel/compat_wrapper.S |   33 +++++++-------
 arch/s390/kernel/process.c        |    8 +--
 arch/s390/kernel/ptrace.c         |    2 
 arch/s390/kernel/setup.c          |   12 ++---
 arch/s390/kernel/sys_s390.c       |   22 +++------
 drivers/s390/cio/device_fsm.c     |    8 +++
 include/asm-s390/spinlock.h       |   18 ++------
 include/asm-s390/unistd.h         |   19 +++-----
 11 files changed, 122 insertions(+), 119 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Thu Mar 11 03:55:43 2004
+++ linux-2.6-s390/arch/s390/defconfig	Fri Mar 26 18:25:12 2004
@@ -21,9 +21,11 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=17
-# CONFIG_IKCONFIG is not set
+CONFIG_HOTPLUG=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
 # CONFIG_EMBEDDED is not set
-# CONFIG_KALLSYMS is not set
+CONFIG_KALLSYMS=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_IOSCHED_NOOP=y
@@ -84,6 +86,7 @@
 # Generic Driver Options
 #
 # CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
 
 #
 # SCSI device support
@@ -110,6 +113,12 @@
 CONFIG_SCSI_LOGGING=y
 
 #
+# SCSI Transport Attributes
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+
+#
 # SCSI low-level drivers
 #
 # CONFIG_SCSI_AIC7XXX_OLD is not set
@@ -185,7 +194,6 @@
 # S/390 tape hardware support
 #
 CONFIG_S390_TAPE_34XX=m
-CONFIG_HOTPLUG=y
 
 #
 # Networking support
@@ -199,7 +207,7 @@
 # CONFIG_PACKET_MMAP is not set
 # CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
+CONFIG_NET_KEY=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
@@ -208,7 +216,6 @@
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
 # CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
@@ -222,11 +229,12 @@
 # CONFIG_DECNET is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_NETFILTER is not set
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
 
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
@@ -247,6 +255,7 @@
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
 # CONFIG_NET_SCH_HTB is not set
+# CONFIG_NET_SCH_HFSC is not set
 CONFIG_NET_SCH_CSZ=m
 CONFIG_NET_SCH_PRIO=m
 CONFIG_NET_SCH_RED=m
@@ -255,6 +264,7 @@
 CONFIG_NET_SCH_TBF=m
 CONFIG_NET_SCH_GRED=m
 CONFIG_NET_SCH_DSMARK=m
+# CONFIG_NET_SCH_DELAY is not set
 CONFIG_NET_QOS=y
 CONFIG_NET_ESTIMATOR=y
 CONFIG_NET_CLS=y
@@ -303,6 +313,7 @@
 #
 # CONFIG_TR is not set
 # CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # Wan interfaces
@@ -340,6 +351,8 @@
 # Bluetooth support
 #
 # CONFIG_BT is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # File systems
@@ -380,7 +393,6 @@
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 # CONFIG_DEVFS_FS is not set
-CONFIG_DEVPTS_FS=y
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
@@ -392,6 +404,7 @@
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
@@ -417,7 +430,7 @@
 CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=y
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -484,7 +497,9 @@
 # CONFIG_CRYPTO_AES is not set
 # CONFIG_CRYPTO_CAST5 is not set
 # CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_ARC4 is not set
 # CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
diff -urN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-s390/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	Fri Mar 26 18:24:53 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_linux.c	Fri Mar 26 18:25:12 2004
@@ -298,7 +298,7 @@
  *
  * This is really horribly ugly.
  */
-asmlinkage int sys32_ipc (u32 call, int first, int second, int third, u32 ptr)
+asmlinkage long sys32_ipc(u32 call, int first, int second, int third, u32 ptr)
 {
 	if(call >> 16) /* hack for backward compatibility */
 		return -EINVAL;
@@ -360,7 +360,7 @@
 	return -EINVAL;
 }
 
-asmlinkage int sys32_truncate64(const char * path, unsigned long high, unsigned long low)
+asmlinkage long sys32_truncate64(const char * path, unsigned long high, unsigned long low)
 {
 	if ((int)high < 0)
 		return -EINVAL;
@@ -368,7 +368,7 @@
 		return sys_truncate(path, (high << 32) | low);
 }
 
-asmlinkage int sys32_ftruncate64(unsigned int fd, unsigned long high, unsigned long low)
+asmlinkage long sys32_ftruncate64(unsigned int fd, unsigned long high, unsigned long low)
 {
 	if ((int)high < 0)
 		return -EINVAL;
@@ -479,7 +479,7 @@
 	return retval;
 }
 
-asmlinkage long sys32_readv(int fd, struct compat_iovec *vector, u32 count)
+asmlinkage long sys32_readv(int fd, struct compat_iovec *vector, unsigned long count)
 {
 	struct file *file;
 	long ret = -EBADF;
@@ -497,7 +497,7 @@
 	return ret;
 }
 
-asmlinkage long sys32_writev(int fd, struct compat_iovec *vector, u32 count)
+asmlinkage long sys32_writev(int fd, struct compat_iovec *vector, unsigned long count)
 {
 	struct file *file;
 	int ret = -EBADF;
@@ -549,7 +549,7 @@
 	return 0;
 }
 
-asmlinkage int old32_readdir(unsigned int fd, struct old_linux_dirent32 *dirent, unsigned int count)
+asmlinkage long old32_readdir(unsigned int fd, struct old_linux_dirent32 *dirent, unsigned int count)
 {
 	int error = -EBADF;
 	struct file * file;
@@ -611,7 +611,7 @@
 	return 0;
 }
 
-asmlinkage int sys32_getdents(unsigned int fd, struct linux_dirent32 *dirent, unsigned int count)
+asmlinkage long sys32_getdents(unsigned int fd, struct linux_dirent32 *dirent, unsigned int count)
 {
 	struct file * file;
 	struct linux_dirent32 * lastdirent;
@@ -706,10 +706,10 @@
 #define MAX_SELECT_SECONDS \
 	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
 
-asmlinkage int sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, u32 tvp_x)
+asmlinkage long sys32_select(int n, u32 *inp, u32 *outp, u32 *exp,
+				struct compat_timeval *tvp)
 {
 	fd_set_bits fds;
-	struct compat_timeval *tvp = (struct compat_timeval *)AA(tvp_x);
 	char *bits;
 	unsigned long nn;
 	long timeout;
@@ -914,7 +914,7 @@
 #define SMBFS_NAME	"smbfs"
 #define NCPFS_NAME	"ncpfs"
 
-asmlinkage int sys32_mount(char *dev_name, char *dir_name, char *type, unsigned long new_flags, u32 data)
+asmlinkage long sys32_mount(char *dev_name, char *dir_name, char *type, unsigned long new_flags, void *data)
 {
 	unsigned long type_page = 0;
 	unsigned long data_page = 0;
@@ -936,7 +936,7 @@
 	is_smb = !strcmp((char *)type_page, SMBFS_NAME);
 	is_ncp = !strcmp((char *)type_page, NCPFS_NAME);
 
-	err = copy_mount_stuff_to_kernel((const void *)AA(data), &data_page);
+	err = copy_mount_stuff_to_kernel(data, &data_page);
 	if (err)
 		goto type_out;
 
@@ -996,7 +996,7 @@
         char _f[8];
 };
 
-asmlinkage int sys32_sysinfo(struct sysinfo32 __user *info)
+asmlinkage long sys32_sysinfo(struct sysinfo32 __user *info)
 {
 	struct sysinfo s;
 	int ret, err;
@@ -1024,7 +1024,7 @@
 	return ret;
 }
 
-asmlinkage int sys32_sched_rr_get_interval(compat_pid_t pid,
+asmlinkage long sys32_sched_rr_get_interval(compat_pid_t pid,
 				struct compat_timespec __user *interval)
 {
 	struct timespec t;
@@ -1039,8 +1039,8 @@
 	return ret;
 }
 
-asmlinkage int sys32_rt_sigprocmask(int how, compat_sigset_t __user *set,
-			compat_sigset_t __user *oset, compat_size_t sigsetsize)
+asmlinkage long sys32_rt_sigprocmask(int how, compat_sigset_t __user *set,
+			compat_sigset_t __user *oset, size_t sigsetsize)
 {
 	sigset_t s;
 	compat_sigset_t s32;
@@ -1074,8 +1074,8 @@
 	return 0;
 }
 
-asmlinkage int sys32_rt_sigpending(compat_sigset_t __user *set,
-				compat_size_t sigsetsize)
+asmlinkage long sys32_rt_sigpending(compat_sigset_t __user *set,
+				size_t sigsetsize)
 {
 	sigset_t s;
 	compat_sigset_t s32;
@@ -1101,9 +1101,9 @@
 extern int
 copy_siginfo_to_user32(siginfo_t32 *to, siginfo_t *from);
 
-asmlinkage int
+asmlinkage long
 sys32_rt_sigtimedwait(compat_sigset_t *uthese, siginfo_t32 *uinfo,
-		      struct compat_timespec *uts, compat_size_t sigsetsize)
+		      struct compat_timespec *uts, size_t sigsetsize)
 {
 	int ret, sig;
 	sigset_t these;
@@ -1182,7 +1182,7 @@
 	return ret;
 }
 
-asmlinkage int
+asmlinkage long
 sys32_rt_sigqueueinfo(int pid, int sig, siginfo_t32 __user *uinfo)
 {
 	siginfo_t info;
@@ -1384,7 +1384,7 @@
  * sys32_execve() executes a new program after the asm stub has set
  * things up for us.  This should basically do what I want it to.
  */
-asmlinkage int
+asmlinkage long
 sys32_execve(struct pt_regs regs)
 {
         int error;
@@ -1412,14 +1412,14 @@
 
 #ifdef CONFIG_MODULES
 
-asmlinkage int
+asmlinkage long
 sys32_init_module(void __user *umod, unsigned long len,
 		const char __user *uargs)
 {
 	return sys_init_module(umod, len, uargs);
 }
 
-asmlinkage int
+asmlinkage long
 sys32_delete_module(const char __user *name_user, unsigned int flags)
 {
 	return sys_delete_module(name_user, flags);
@@ -1427,14 +1427,14 @@
 
 #else /* CONFIG_MODULES */
 
-asmlinkage int
+asmlinkage long
 sys32_init_module(void __user *umod, unsigned long len,
 		const char __user *uargs)
 {
 	return -ENOSYS;
 }
 
-asmlinkage int
+asmlinkage long
 sys32_delete_module(const char __user *name_user, unsigned int flags)
 {
 	return -ENOSYS;
@@ -1599,7 +1599,7 @@
 	return copy_to_user(res32, kres, sizeof(*res32)) ? -EFAULT : 0;
 }
 
-int asmlinkage sys32_nfsservctl(int cmd, struct nfsctl_arg32 *arg32, union nfsctl_res32 *res32)
+long asmlinkage sys32_nfsservctl(int cmd, struct nfsctl_arg32 *arg32, union nfsctl_res32 *res32)
 {
 	struct nfsctl_arg *karg = NULL;
 	union nfsctl_res *kres = NULL;
@@ -1667,7 +1667,7 @@
 
 extern struct timezone sys_tz;
 
-asmlinkage int sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
+asmlinkage long sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	if (tv) {
 		struct timeval ktv;
@@ -1696,7 +1696,7 @@
 	return 0;
 }
 
-asmlinkage int sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
+asmlinkage long sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	struct timespec kts;
 	struct timezone ktz;
@@ -1714,23 +1714,23 @@
 }
 
 /* These are here just in case some old sparc32 binary calls it. */
-asmlinkage int sys32_pause(void)
+asmlinkage long sys32_pause(void)
 {
 	current->state = TASK_INTERRUPTIBLE;
 	schedule();
 	return -ERESTARTNOHAND;
 }
 
-asmlinkage compat_ssize_t sys32_pread64(unsigned int fd, char *ubuf,
-				 compat_size_t count, u32 poshi, u32 poslo)
+asmlinkage long sys32_pread64(unsigned int fd, char *ubuf,
+				size_t count, u32 poshi, u32 poslo)
 {
 	if ((compat_ssize_t) count < 0)
 		return -EINVAL;
 	return sys_pread64(fd, ubuf, count, ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
-asmlinkage compat_ssize_t sys32_pwrite64(unsigned int fd, char *ubuf,
-				  compat_size_t count, u32 poshi, u32 poslo)
+asmlinkage long sys32_pwrite64(unsigned int fd, const char *ubuf,
+				size_t count, u32 poshi, u32 poslo)
 {
 	if ((compat_ssize_t) count < 0)
 		return -EINVAL;
@@ -1742,7 +1742,7 @@
 	return sys_readahead(fd, ((loff_t)AA(offhi) << 32) | AA(offlo), count);
 }
 
-asmlinkage int sys32_sendfile(int out_fd, int in_fd, compat_off_t *offset, s32 count)
+asmlinkage long sys32_sendfile(int out_fd, int in_fd, compat_off_t *offset, size_t count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
@@ -1761,7 +1761,7 @@
 	return ret;
 }
 
-asmlinkage int sys32_sendfile64(int out_fd, int in_fd, 
+asmlinkage long sys32_sendfile64(int out_fd, int in_fd, 
 				compat_loff_t *offset, s32 count)
 {
 	mm_segment_t old_fs = get_fs();
@@ -1798,7 +1798,7 @@
 
 extern int do_adjtimex(struct timex *);
 
-asmlinkage int sys32_adjtimex(struct timex32 *utp)
+asmlinkage long sys32_adjtimex(struct timex32 *utp)
 {
 	struct timex txc;
 	int ret;
@@ -1951,7 +1951,7 @@
 	return copy_to_user(ubuf,&tmp,sizeof(tmp)) ? -EFAULT : 0; 
 }
 
-asmlinkage long sys32_stat64(char * filename, struct stat64_emu31 * statbuf, long flags)
+asmlinkage long sys32_stat64(char * filename, struct stat64_emu31 * statbuf)
 {
 	struct kstat stat;
 	int ret = vfs_stat(filename, &stat);
@@ -1960,7 +1960,7 @@
 	return ret;
 }
 
-asmlinkage long sys32_lstat64(char * filename, struct stat64_emu31 * statbuf, long flags)
+asmlinkage long sys32_lstat64(char * filename, struct stat64_emu31 * statbuf)
 {
 	struct kstat stat;
 	int ret = vfs_lstat(filename, &stat);
@@ -1969,7 +1969,7 @@
 	return ret;
 }
 
-asmlinkage long sys32_fstat64(unsigned long fd, struct stat64_emu31 * statbuf, long flags)
+asmlinkage long sys32_fstat64(unsigned long fd, struct stat64_emu31 * statbuf)
 {
 	struct kstat stat;
 	int ret = vfs_fstat(fd, &stat);
@@ -2056,7 +2056,7 @@
 	return error;
 }
 
-asmlinkage compat_ssize_t sys32_read(unsigned int fd, char * buf, size_t count)
+asmlinkage long sys32_read(unsigned int fd, char * buf, size_t count)
 {
 	if ((compat_ssize_t) count < 0)
 		return -EINVAL; 
@@ -2064,7 +2064,7 @@
 	return sys_read(fd, buf, count);
 }
 
-asmlinkage compat_ssize_t sys32_write(unsigned int fd, char * buf, size_t count)
+asmlinkage long sys32_write(unsigned int fd, char * buf, size_t count)
 {
 	if ((compat_ssize_t) count < 0)
 		return -EINVAL; 
@@ -2072,7 +2072,7 @@
 	return sys_write(fd, buf, count);
 }
 
-asmlinkage int sys32_clone(struct pt_regs regs)
+asmlinkage long sys32_clone(struct pt_regs regs)
 {
         unsigned long clone_flags;
         unsigned long newsp;
diff -urN linux-2.6/arch/s390/kernel/compat_signal.c linux-2.6-s390/arch/s390/kernel/compat_signal.c
--- linux-2.6/arch/s390/kernel/compat_signal.c	Fri Mar 26 18:24:53 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_signal.c	Fri Mar 26 18:25:12 2004
@@ -161,7 +161,7 @@
         }
 }                                                         
 
-asmlinkage int
+asmlinkage long
 sys32_sigaction(int sig, const struct old_sigaction32 *act,
 		 struct old_sigaction32 *oact)
 {
@@ -254,7 +254,7 @@
 	return ret;
 }
 
-asmlinkage int
+asmlinkage long
 sys32_sigaltstack(const stack_t32 *uss, stack_t32 *uoss, struct pt_regs *regs)
 {
 	stack_t kss, koss;
diff -urN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-s390/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	Fri Mar 26 18:24:53 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_wrapper.S	Fri Mar 26 18:25:12 2004
@@ -126,7 +126,7 @@
 
 	.globl  sys32_alarm_wrapper 
 sys32_alarm_wrapper:
-	llgtr	%r2,%r2			# unsigned int
+	llgfr	%r2,%r2			# unsigned int
 	jg	sys_alarm		# branch to system call
 
 #sys32_pause_wrapper			# void 
@@ -203,7 +203,7 @@
 	.globl sys32_signal_wrapper
 sys32_signal_wrapper:
 	lgfr	%r2,%r2			# int 
-	llgfr	%r3,%r3			# __sighandler_t 
+	llgtr	%r3,%r3			# __sighandler_t
 	jg	sys_signal
 
 #sys32_geteuid16_wrapper		# void 
@@ -243,7 +243,7 @@
 
 	.globl  sys32_umask_wrapper 
 sys32_umask_wrapper:
-	lgfr	%r3,%r3			# int
+	lgfr	%r2,%r2			# int
 	jg	sys_umask		# branch to system call
 
 	.globl  sys32_chroot_wrapper 
@@ -273,6 +273,7 @@
 sys32_sigaction_wrapper:
 	lgfr	%r2,%r2			# int 
 	llgtr	%r3,%r3			# const struct old_sigaction *
+	llgtr	%r4,%r4			# struct old_sigaction32 *
 	jg	sys32_sigaction		# branch to system call
 
 	.globl  sys32_setreuid16_wrapper 
@@ -424,8 +425,8 @@
 	.globl  sys32_fchown16_wrapper 
 sys32_fchown16_wrapper:
 	llgfr	%r2,%r2			# unsigned int
-	llgtr	%r3,%r3			# __kernel_old_uid_emu31_t *
-	llgtr	%r4,%r4			# __kernel_old_gid_emu31_t *
+	llgfr	%r3,%r3			# compat_uid_t
+	llgfr	%r4,%r4			# compat_uid_t
 	jg	sys32_fchown16		# branch to system call
 
 	.globl  sys32_getpriority_wrapper 
@@ -523,7 +524,7 @@
 	lgfr	%r3,%r3			# int
 	lgfr	%r4,%r4			# int
 	lgfr	%r5,%r5			# int
-	llgtr	%r6,%r6			# void *
+	llgfr	%r6,%r6			# u32
 	jg	sys32_ipc		# branch to system call
 
 	.globl  sys32_fsync_wrapper 
@@ -580,9 +581,9 @@
 
 	.globl  sys32_quotactl_wrapper 
 sys32_quotactl_wrapper:
-	lgfr	%r2,%r2			# int
+	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# const char *
-	lgfr	%r4,%r4			# int
+	llgfr	%r4,%r4			# qid_t
 	llgtr	%r5,%r5			# caddr_t
 	jg	sys_quotactl		# branch to system call
 
@@ -664,14 +665,14 @@
 
 	.globl  sys32_readv_wrapper 
 sys32_readv_wrapper:
-	llgfr	%r2,%r2			# unsigned long
+	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# const struct iovec_emu31 *
 	llgfr	%r4,%r4			# unsigned long
 	jg	sys32_readv		# branch to system call
 
 	.globl  sys32_writev_wrapper 
 sys32_writev_wrapper:
-	llgfr	%r2,%r2			# unsigned long
+	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# const struct iovec_emu31 *
 	llgfr	%r4,%r4			# unsigned long
 	jg	sys32_writev		# branch to system call
@@ -830,6 +831,7 @@
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# old_sigset_emu31 *
 	llgtr	%r4,%r4			# old_sigset_emu31 *
+	llgfr	%r5,%r5			# size_t
 	jg	sys32_rt_sigprocmask	# branch to system call
 
 	.globl  sys32_rt_sigpending_wrapper 
@@ -917,15 +919,15 @@
 	.globl  sys32_truncate64_wrapper 
 sys32_truncate64_wrapper:
 	llgtr	%r2,%r2			# const char *
-	lgfr	%r3,%r3			# s32 
-	llgfr	%r4,%r4			# u32 
+	llgfr	%r3,%r3			# unsigned long
+	llgfr	%r4,%r4			# unsigned long
 	jg	sys32_truncate64	# branch to system call
 
 	.globl  sys32_ftruncate64_wrapper 
 sys32_ftruncate64_wrapper:
 	llgfr	%r2,%r2			# unsigned int
-	lgfr	%r3,%r3			# s32 
-	llgfr	%r4,%r4			# u32 
+	llgfr	%r3,%r3			# unsigned long
+	llgfr	%r4,%r4			# unsigned long
 	jg	sys32_ftruncate64	# branch to system call
 
 	.globl sys32_lchown_wrapper	
@@ -1064,14 +1066,12 @@
 sys32_stat64_wrapper:
 	llgtr	%r2,%r2			# char *
 	llgtr	%r3,%r3			# struct stat64 *
-	llgfr	%r4,%r4			# long
 	jg	sys32_stat64		# branch to system call
 
 	.globl	sys32_lstat64_wrapper
 sys32_lstat64_wrapper:
 	llgtr	%r2,%r2			# char *
 	llgtr	%r3,%r3			# struct stat64 *
-	llgfr	%r4,%r4			# long
 	jg	sys32_lstat64		# branch to system call
 
 	.globl	sys32_stime_wrapper
@@ -1088,7 +1088,6 @@
 sys32_fstat64_wrapper:
 	llgfr	%r2,%r2			# unsigned long
 	llgtr	%r3,%r3			# struct stat64 *
-	llgfr	%r4,%r4			# long
 	jg	sys32_fstat64		# branch to system call
 
 	.globl  compat_sys_futex_wrapper 
diff -urN linux-2.6/arch/s390/kernel/process.c linux-2.6-s390/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	Thu Mar 11 03:55:37 2004
+++ linux-2.6-s390/arch/s390/kernel/process.c	Fri Mar 26 18:25:12 2004
@@ -277,12 +277,12 @@
         return 0;
 }
 
-asmlinkage int sys_fork(struct pt_regs regs)
+asmlinkage long sys_fork(struct pt_regs regs)
 {
 	return do_fork(SIGCHLD, regs.gprs[15], &regs, 0, NULL, NULL);
 }
 
-asmlinkage int sys_clone(struct pt_regs regs)
+asmlinkage long sys_clone(struct pt_regs regs)
 {
         unsigned long clone_flags;
         unsigned long newsp;
@@ -308,7 +308,7 @@
  * do not have enough call-clobbered registers to hold all
  * the information you need.
  */
-asmlinkage int sys_vfork(struct pt_regs regs)
+asmlinkage long sys_vfork(struct pt_regs regs)
 {
 	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
 		       regs.gprs[15], &regs, 0, NULL, NULL);
@@ -317,7 +317,7 @@
 /*
  * sys_execve() executes a new program.
  */
-asmlinkage int sys_execve(struct pt_regs regs)
+asmlinkage long sys_execve(struct pt_regs regs)
 {
         int error;
         char * filename;
diff -urN linux-2.6/arch/s390/kernel/ptrace.c linux-2.6-s390/arch/s390/kernel/ptrace.c
--- linux-2.6/arch/s390/kernel/ptrace.c	Fri Mar 26 18:24:53 2004
+++ linux-2.6-s390/arch/s390/kernel/ptrace.c	Fri Mar 26 18:25:12 2004
@@ -616,7 +616,7 @@
 	return -EIO;
 }
 
-asmlinkage int
+asmlinkage long
 sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-s390/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	Thu Mar 11 03:55:22 2004
+++ linux-2.6-s390/arch/s390/kernel/setup.c	Fri Mar 26 18:25:12 2004
@@ -492,20 +492,20 @@
 #endif /* CONFIG_ARCH_S390X */
 	lc->restart_psw.mask = PSW_BASE_BITS;
 	lc->restart_psw.addr =
-		PSW_ADDR_AMODE + (unsigned long) restart_int_handler;
+		PSW_ADDR_AMODE | (unsigned long) restart_int_handler;
 	lc->external_new_psw.mask = PSW_KERNEL_BITS;
 	lc->external_new_psw.addr =
-		PSW_ADDR_AMODE + (unsigned long) ext_int_handler;
+		PSW_ADDR_AMODE | (unsigned long) ext_int_handler;
 	lc->svc_new_psw.mask = PSW_KERNEL_BITS;
-	lc->svc_new_psw.addr = PSW_ADDR_AMODE + (unsigned long) system_call;
+	lc->svc_new_psw.addr = PSW_ADDR_AMODE | (unsigned long) system_call;
 	lc->program_new_psw.mask = PSW_KERNEL_BITS;
 	lc->program_new_psw.addr =
-		PSW_ADDR_AMODE + (unsigned long)pgm_check_handler;
+		PSW_ADDR_AMODE | (unsigned long)pgm_check_handler;
 	lc->mcck_new_psw.mask = PSW_KERNEL_BITS;
 	lc->mcck_new_psw.addr =
-		PSW_ADDR_AMODE + (unsigned long) mcck_int_handler;
+		PSW_ADDR_AMODE | (unsigned long) mcck_int_handler;
 	lc->io_new_psw.mask = PSW_KERNEL_BITS;
-	lc->io_new_psw.addr = PSW_ADDR_AMODE + (unsigned long) io_int_handler;
+	lc->io_new_psw.addr = PSW_ADDR_AMODE | (unsigned long) io_int_handler;
 	lc->ipl_device = S390_lowcore.ipl_device;
 	lc->jiffy_timer = -1LL;
 	lc->kernel_stack = ((unsigned long) &init_thread_union) + THREAD_SIZE;
diff -urN linux-2.6/arch/s390/kernel/sys_s390.c linux-2.6-s390/arch/s390/kernel/sys_s390.c
--- linux-2.6/arch/s390/kernel/sys_s390.c	Fri Mar 26 18:24:53 2004
+++ linux-2.6-s390/arch/s390/kernel/sys_s390.c	Fri Mar 26 18:25:12 2004
@@ -32,17 +32,11 @@
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
 
-#ifndef CONFIG_ARCH_S390X
-#define __SYS_RETTYPE int
-#else
-#define __SYS_RETTYPE long
-#endif /* CONFIG_ARCH_S390X */
-
 /*
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way Unix traditionally does this, though.
  */
-asmlinkage __SYS_RETTYPE sys_pipe(unsigned long * fildes)
+asmlinkage long sys_pipe(unsigned long * fildes)
 {
 	int fd[2];
 	int error;
@@ -61,7 +55,7 @@
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
 {
-	__SYS_RETTYPE error = -EBADF;
+	long error = -EBADF;
 	struct file * file = NULL;
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
@@ -109,10 +103,10 @@
 	return error;
 }
 
-asmlinkage __SYS_RETTYPE old_mmap(struct mmap_arg_struct *arg)
+asmlinkage long old_mmap(struct mmap_arg_struct *arg)
 {
 	struct mmap_arg_struct a;
-	__SYS_RETTYPE error = -EFAULT;
+	long error = -EFAULT;
 
 	if (copy_from_user(&a, arg, sizeof(a)))
 		goto out;
@@ -133,7 +127,7 @@
 	struct timeval *tvp;
 };
 
-asmlinkage int old_select(struct sel_arg_struct *arg)
+asmlinkage long old_select(struct sel_arg_struct *arg)
 {
 	struct sel_arg_struct a;
 
@@ -182,7 +176,7 @@
  *
  * This is really horribly ugly.
  */
-asmlinkage __SYS_RETTYPE sys_ipc (uint call, int first, int second, 
+asmlinkage long sys_ipc (uint call, int first, int second, 
 				  unsigned long third, void *ptr)
 {
         struct ipc_kludge tmp;
@@ -246,7 +240,7 @@
 }
 
 #ifdef CONFIG_ARCH_S390X
-asmlinkage int s390x_newuname(struct new_utsname * name)
+asmlinkage long s390x_newuname(struct new_utsname * name)
 {
 	int ret = sys_newuname(name);
 
@@ -257,7 +251,7 @@
 	return ret;
 }
 
-asmlinkage int s390x_personality(unsigned long personality)
+asmlinkage long s390x_personality(unsigned long personality)
 {
 	int ret;
 
diff -urN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-s390/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	Fri Mar 26 18:24:55 2004
+++ linux-2.6-s390/drivers/s390/cio/device_fsm.c	Fri Mar 26 18:25:12 2004
@@ -731,6 +731,9 @@
 	    		(SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
 		if (cdev->handler)
 			cdev->handler (cdev, 0, irb);
+		if (irb->scsw.cc == 1)
+			/* Basic sense hasn't started. Try again. */
+			ccw_device_do_sense(cdev, irb);
 		return;
 	}
 	/* Add basic sense info to irb. */
@@ -828,6 +831,8 @@
 	    		(SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
 		if (cdev->handler)
 			cdev->handler (cdev, 0, irb);
+		if (irb->scsw.cc == 1)
+			goto call_handler;
 		return;
 	}
 	/*
@@ -841,6 +846,7 @@
 		}
 		return;
 	}
+call_handler:
 	/* Iff device is idle, reset timeout. */
 	sch = to_subchannel(cdev->dev.parent);
 	if (!stsch(sch->irq, &sch->schib))
@@ -908,6 +914,8 @@
 		/* Check for unsolicited interrupt. */
 		if (irb->scsw.stctl ==
 		    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS))
+			/* FIXME: we should restart stlck here, but this
+			 * is extremely unlikely ... */
 			goto out_wakeup;
 
 		ccw_device_accumulate_irb(cdev, irb);
diff -urN linux-2.6/include/asm-s390/spinlock.h linux-2.6-s390/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	Thu Mar 11 03:55:56 2004
+++ linux-2.6-s390/include/asm-s390/spinlock.h	Fri Mar 26 18:25:12 2004
@@ -35,13 +35,8 @@
  */
 
 typedef struct {
-#ifndef __s390x__
-	volatile unsigned long lock;
-} spinlock_t;
-#else /* __s390x__ */
 	volatile unsigned int lock;
 } __attribute__ ((aligned (4))) spinlock_t;
-#endif /* __s390x__ */
 
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
 #define spin_lock_init(lp) do { (lp)->lock = 0; } while(0)
@@ -80,11 +75,10 @@
 #else /* __s390x__ */
 	unsigned int result, reg;
 #endif /* __s390x__ */
-	__asm__ __volatile("    slr   %0,%0\n"
-			   "    basr  %1,0\n"
+	__asm__ __volatile("    basr  %1,0\n"
 			   "0:  cs    %0,%1,0(%3)"
-			   : "=&d" (result), "=&d" (reg), "=m" (lp->lock)
-			   : "a" (&lp->lock), "m" (lp->lock)
+			   : "=d" (result), "=&d" (reg), "=m" (lp->lock)
+			   : "a" (&lp->lock), "m" (lp->lock), "0" (0)
 			   : "cc", "memory" );
 	return !result;
 }
@@ -224,17 +218,15 @@
 	
 	__asm__ __volatile__(
 #ifndef __s390x__
-			     "   slr  %0,%0\n"
 			     "   lhi  %1,1\n"
 			     "   sll  %1,31\n"
 			     "   cs   %0,%1,0(%3)"
 #else /* __s390x__ */
-			     "   slgr  %0,%0\n"
 			     "   llihh %1,0x8000\n"
 			     "0: csg %0,%1,0(%3)\n"
 #endif /* __s390x__ */
-			     : "=&d" (result), "=&d" (reg), "=m" (rw->lock)
-			     : "a" (&rw->lock), "m" (rw->lock)
+			     : "=d" (result), "=&d" (reg), "=m" (rw->lock)
+			     : "a" (&rw->lock), "m" (rw->lock), "0" (0)
 			     : "cc", "memory" );
 	return result == 0;
 }
diff -urN linux-2.6/include/asm-s390/unistd.h linux-2.6-s390/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	Fri Mar 26 18:24:56 2004
+++ linux-2.6-s390/include/asm-s390/unistd.h	Fri Mar 26 18:25:12 2004
@@ -543,19 +543,14 @@
 	return sys_wait4(pid, wait_stat, flags, NULL);
 }
 struct mmap_arg_struct;
-asmlinkage long sys_mmap2(struct mmap_arg_struct *arg);
+asmlinkage long sys_mmap2(struct mmap_arg_struct __user *arg);
 
-asmlinkage int sys_execve(struct pt_regs regs);
-asmlinkage int sys_clone(struct pt_regs regs);
-asmlinkage int sys_fork(struct pt_regs regs);
-asmlinkage int sys_vfork(struct pt_regs regs);
-#ifndef CONFIG_ARCH_S390X
-#define __SYS_RETTYPE int
-#else
-#define __SYS_RETTYPE long
-#endif /* CONFIG_ARCH_S390X */
-asmlinkage __SYS_RETTYPE sys_pipe(unsigned long *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
+asmlinkage long sys_execve(struct pt_regs regs);
+asmlinkage long sys_clone(struct pt_regs regs);
+asmlinkage long sys_fork(struct pt_regs regs);
+asmlinkage long sys_vfork(struct pt_regs regs);
+asmlinkage long sys_pipe(unsigned long __user *fildes);
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
