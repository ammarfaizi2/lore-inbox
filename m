Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268872AbTCCXPx>; Mon, 3 Mar 2003 18:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268874AbTCCXPx>; Mon, 3 Mar 2003 18:15:53 -0500
Received: from [195.39.17.254] ([195.39.17.254]:20996 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S268872AbTCCXPV>;
	Mon, 3 Mar 2003 18:15:21 -0500
Date: Tue, 4 Mar 2003 00:25:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       davem@redhat.com
Subject: sys32_ioctl -> compat_ioctl -- sparc64
Message-ID: <20030303232513.GA24047@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is sparc64-specific part. It removes hack where pointers to
functions were stored in 32bits, making ioctl table bigger, but I
guess that should not be a big problem (and can be fixed later).

							Pavel

--- clean/arch/sparc64/kernel/ioctl32.c	2003-03-03 23:33:48.000000000 +0100
+++ linux/arch/sparc64/kernel/ioctl32.c	2003-02-28 15:33:49.000000000 +0100
@@ -11,6 +11,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/compat.h>
+#include <linux/ioctl32.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -678,7 +679,7 @@
 	return (void *) (usp - len);
 }
 
-static int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct ifreq *u_ifreq64;
 	struct ifreq32 *u_ifreq32 = (struct ifreq32 *) arg;
@@ -4274,16 +4275,14 @@
 #define BNEPGETCONNLIST	_IOR('B', 210, int)
 #define BNEPGETCONNINFO	_IOR('B', 211, int)
 
-struct ioctl_trans {
-	unsigned int cmd;
-	unsigned int handler;
-	unsigned int next;
-};
+typedef int (* ioctl32_handler_t)(unsigned int, unsigned int, unsigned long, struct file *);
 
-#define COMPATIBLE_IOCTL(cmd) asm volatile(".word %0, sys_ioctl, 0" : : "i" (cmd));
-#define HANDLE_IOCTL(cmd,handler) asm volatile(".word %0, %1, 0" : : "i" (cmd), "i" (handler));
-#define IOCTL_TABLE_START void ioctl32_foo(void) { asm volatile(".data\nioctl_translations:");
-#define IOCTL_TABLE_END asm volatile("\nioctl_translations_end:\n\t.previous"); }
+#define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd),sys_ioctl)
+#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl32_handler_t)(handler), NULL },
+#define IOCTL_TABLE_START \
+	struct ioctl_trans ioctl_start[] = {
+#define IOCTL_TABLE_END \
+	}; struct ioctl_trans ioctl_end[0];
 
 IOCTL_TABLE_START
 /* List here exlicitly which ioctl's are known to have
@@ -5218,134 +5217,3 @@
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
 HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgetsize64)
 IOCTL_TABLE_END
-
-unsigned int ioctl32_hash_table[1024];
-
-static inline unsigned long ioctl32_hash(unsigned long cmd)
-{
-	return ((cmd >> 6) ^ (cmd >> 4) ^ cmd) & 0x3ff;
-}
-
-static void ioctl32_insert_translation(struct ioctl_trans *trans)
-{
-	unsigned long hash;
-	struct ioctl_trans *t;
-
-	hash = ioctl32_hash (trans->cmd);
-	if (!ioctl32_hash_table[hash])
-		ioctl32_hash_table[hash] = (u32)(long)trans;
-	else {
-		t = (struct ioctl_trans *)(long)ioctl32_hash_table[hash];
-		while (t->next)
-			t = (struct ioctl_trans *)(long)t->next;
-		trans->next = 0;
-		t->next = (u32)(long)trans;
-	}
-}
-
-static int __init init_sys32_ioctl(void)
-{
-	int i;
-	extern struct ioctl_trans ioctl_translations[], ioctl_translations_end[];
-
-	for (i = 0; &ioctl_translations[i] < &ioctl_translations_end[0]; i++)
-		ioctl32_insert_translation(&ioctl_translations[i]);
-	return 0;
-}
-
-__initcall(init_sys32_ioctl);
-
-static struct ioctl_trans *additional_ioctls;
-
-/* Always call these with kernel lock held! */
-
-int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *))
-{
-	int i;
-	if (!additional_ioctls) {
-		additional_ioctls = vmalloc(PAGE_SIZE);
-		if (!additional_ioctls)
-			return -ENOMEM;
-		memset(additional_ioctls, 0, PAGE_SIZE);
-	}
-	for (i = 0; i < PAGE_SIZE/sizeof(struct ioctl_trans); i++)
-		if (!additional_ioctls[i].cmd)
-			break;
-	if (i == PAGE_SIZE/sizeof(struct ioctl_trans))
-		return -ENOMEM;
-	additional_ioctls[i].cmd = cmd;
-	if (!handler)
-		additional_ioctls[i].handler = (u32)(long)sys_ioctl;
-	else
-		additional_ioctls[i].handler = (u32)(long)handler;
-	ioctl32_insert_translation(&additional_ioctls[i]);
-	return 0;
-}
-
-int unregister_ioctl32_conversion(unsigned int cmd)
-{
-	unsigned long hash = ioctl32_hash(cmd);
-	struct ioctl_trans *t, *t1;
-
-	t = (struct ioctl_trans *)(long)ioctl32_hash_table[hash];
-	if (!t) return -EINVAL;
-	if (t->cmd == cmd && t >= additional_ioctls &&
-	    (unsigned long)t < ((unsigned long)additional_ioctls) + PAGE_SIZE) {
-		ioctl32_hash_table[hash] = t->next;
-		t->cmd = 0;
-		t->next = 0;
-		return 0;
-	} else while (t->next) {
-		t1 = (struct ioctl_trans *)(long)t->next;
-		if (t1->cmd == cmd && t1 >= additional_ioctls &&
-		    (unsigned long)t1 < ((unsigned long)additional_ioctls) + PAGE_SIZE) {
-			t->next = t1->next;
-			t1->cmd = 0;
-			t1->next = 0;
-			return 0;
-		}
-		t = t1;
-	}
-	return -EINVAL;
-}
-
-asmlinkage int sys32_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct file * filp;
-	int error = -EBADF;
-	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
-	struct ioctl_trans *t;
-
-	filp = fget(fd);
-	if(!filp)
-		goto out2;
-
-	if (!filp->f_op || !filp->f_op->ioctl) {
-		error = sys_ioctl (fd, cmd, arg);
-		goto out;
-	}
-
-	t = (struct ioctl_trans *)(long)ioctl32_hash_table [ioctl32_hash (cmd)];
-
-	while (t && t->cmd != cmd)
-		t = (struct ioctl_trans *)(long)t->next;
-	if (t) {
-		handler = (void *)(long)t->handler;
-		error = handler(fd, cmd, arg, filp);
-	} else if (cmd >= SIOCDEVPRIVATE &&
-		   cmd <= (SIOCDEVPRIVATE + 15)) {
-		error = siocdevprivate_ioctl(fd, cmd, arg);
-	} else {
-		static int count;
-		if (++count <= 20)
-			printk("sys32_ioctl(%s:%d): Unknown cmd fd(%d) "
-			       "cmd(%08x) arg(%08x)\n",
-			       current->comm, current->pid,
-			       (int)fd, (unsigned int)cmd, (unsigned int)arg);
-		error = -EINVAL;
-	}
-out:
-	fput(filp);
-out2:
-	return error;
-}
--- clean/arch/sparc64/kernel/sparc64_ksyms.c	2003-03-03 23:33:49.000000000 +0100
+++ linux/arch/sparc64/kernel/sparc64_ksyms.c	2003-02-24 22:36:20.000000000 +0100
@@ -89,7 +89,7 @@
 extern int svr4_getcontext(svr4_ucontext_t *uc, struct pt_regs *regs);
 extern int svr4_setcontext(svr4_ucontext_t *uc, struct pt_regs *regs);
 extern int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
-extern int sys32_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
+extern int compat_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
 extern int (*handle_mathemu)(struct pt_regs *, struct fpustate *);
 extern long sparc32_open(const char * filename, int flags, int mode);
 extern int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *));
@@ -316,7 +316,7 @@
 EXPORT_SYMBOL(svr4_setcontext);
 EXPORT_SYMBOL(prom_cpu_nodes);
 EXPORT_SYMBOL(sys_ioctl);
-EXPORT_SYMBOL(sys32_ioctl);
+EXPORT_SYMBOL(compat_ioctl);
 EXPORT_SYMBOL(sparc32_open);
 #endif
 
--- clean/arch/sparc64/kernel/sunos_ioctl32.c	2003-03-03 23:33:49.000000000 +0100
+++ linux/arch/sparc64/kernel/sunos_ioctl32.c	2003-02-24 22:36:20.000000000 +0100
@@ -92,7 +92,7 @@
 
 extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 
-extern asmlinkage int sys32_ioctl(unsigned int, unsigned int, u32);
+extern asmlinkage int compat_ioctl(unsigned int, unsigned int, u32);
 extern asmlinkage int sys_setsid(void);
 
 asmlinkage int sunos_ioctl (int fd, u32 cmd, u32 arg)
@@ -127,39 +127,39 @@
 	}
 	switch(cmd) {
 	case _IOW('r', 10, struct rtentry32):
-		ret = sys32_ioctl(fd, SIOCADDRT, arg);
+		ret = compat_ioctl(fd, SIOCADDRT, arg);
 		goto out;
 	case _IOW('r', 11, struct rtentry32):
-		ret = sys32_ioctl(fd, SIOCDELRT, arg);
+		ret = compat_ioctl(fd, SIOCDELRT, arg);
 		goto out;
 
 	case _IOW('i', 12, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFADDR, arg);
+		ret = compat_ioctl(fd, SIOCSIFADDR, arg);
 		goto out;
 	case _IOWR('i', 13, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFADDR, arg);
+		ret = compat_ioctl(fd, SIOCGIFADDR, arg);
 		goto out;
 	case _IOW('i', 14, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFDSTADDR, arg);
+		ret = compat_ioctl(fd, SIOCSIFDSTADDR, arg);
 		goto out;
 	case _IOWR('i', 15, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFDSTADDR, arg);
+		ret = compat_ioctl(fd, SIOCGIFDSTADDR, arg);
 		goto out;
 	case _IOW('i', 16, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFFLAGS, arg);
+		ret = compat_ioctl(fd, SIOCSIFFLAGS, arg);
 		goto out;
 	case _IOWR('i', 17, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFFLAGS, arg);
+		ret = compat_ioctl(fd, SIOCGIFFLAGS, arg);
 		goto out;
 	case _IOW('i', 18, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFMEM, arg);
+		ret = compat_ioctl(fd, SIOCSIFMEM, arg);
 		goto out;
 	case _IOWR('i', 19, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFMEM, arg);
+		ret = compat_ioctl(fd, SIOCGIFMEM, arg);
 		goto out;
 
 	case _IOWR('i', 20, struct ifconf32):
-		ret = sys32_ioctl(fd, SIOCGIFCONF, arg);
+		ret = compat_ioctl(fd, SIOCGIFCONF, arg);
 		goto out;
 
 	case _IOW('i', 21, struct ifreq): /* SIOCSIFMTU */
@@ -170,32 +170,32 @@
 		goto out;
 
 	case _IOWR('i', 23, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFBRDADDR, arg);
+		ret = compat_ioctl(fd, SIOCGIFBRDADDR, arg);
 		goto out;
 	case _IOW('i', 24, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFBRDADDR, arg);
+		ret = compat_ioctl(fd, SIOCSIFBRDADDR, arg);
 		goto out;
 	case _IOWR('i', 25, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFNETMASK, arg);
+		ret = compat_ioctl(fd, SIOCGIFNETMASK, arg);
 		goto out;
 	case _IOW('i', 26, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFNETMASK, arg);
+		ret = compat_ioctl(fd, SIOCSIFNETMASK, arg);
 		goto out;
 	case _IOWR('i', 27, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFMETRIC, arg);
+		ret = compat_ioctl(fd, SIOCGIFMETRIC, arg);
 		goto out;
 	case _IOW('i', 28, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFMETRIC, arg);
+		ret = compat_ioctl(fd, SIOCSIFMETRIC, arg);
 		goto out;
 
 	case _IOW('i', 30, struct arpreq):
-		ret = sys32_ioctl(fd, SIOCSARP, arg);
+		ret = compat_ioctl(fd, SIOCSARP, arg);
 		goto out;
 	case _IOWR('i', 31, struct arpreq):
-		ret = sys32_ioctl(fd, SIOCGARP, arg);
+		ret = compat_ioctl(fd, SIOCGARP, arg);
 		goto out;
 	case _IOW('i', 32, struct arpreq):
-		ret = sys32_ioctl(fd, SIOCDARP, arg);
+		ret = compat_ioctl(fd, SIOCDARP, arg);
 		goto out;
 
 	case _IOW('i', 40, struct ifreq32): /* SIOCUPPER */
@@ -209,10 +209,10 @@
 		goto out;
 
 	case _IOW('i', 49, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCADDMULTI, arg);
+		ret = compat_ioctl(fd, SIOCADDMULTI, arg);
 		goto out;
 	case _IOW('i', 50, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCDELMULTI, arg);
+		ret = compat_ioctl(fd, SIOCDELMULTI, arg);
 		goto out;
 
 	/* FDDI interface ioctls, unsupported. */
@@ -246,7 +246,7 @@
 		ret = -EFAULT;
 		if(get_user(oldval, ptr))
 			goto out;
-		ret = sys32_ioctl(fd, cmd, arg);
+		ret = compat_ioctl(fd, cmd, arg);
 		__get_user(newval, ptr);
 		if(newval == -1) {
 			__put_user(oldval, ptr);
@@ -265,7 +265,7 @@
 		ret = -EFAULT;
 		if(get_user(oldval, ptr))
 			goto out;
-		ret = sys32_ioctl(fd, cmd, arg);
+		ret = compat_ioctl(fd, cmd, arg);
 		__get_user(newval, ptr);
 		if(newval == -1) {
 			__put_user(oldval, ptr);
@@ -277,7 +277,7 @@
 	}
 	};
 
-	ret = sys32_ioctl(fd, cmd, arg);
+	ret = compat_ioctl(fd, cmd, arg);
 	/* so stupid... */
 	ret = (ret == -EINVAL ? -EOPNOTSUPP : ret);
 out:
--- clean/arch/sparc64/kernel/systbls.S	2003-03-03 23:33:49.000000000 +0100
+++ linux/arch/sparc64/kernel/systbls.S	2003-02-24 22:36:21.000000000 +0100
@@ -29,7 +29,7 @@
 	.word sys_chown, sys_sync, sys_kill, compat_sys_newstat, sys32_sendfile
 /*40*/	.word compat_sys_newlstat, sys_dup, sys_pipe, compat_sys_times, sys_getuid
 	.word sys_umount, sys32_setgid16, sys32_getgid16, sys_signal, sys32_geteuid16
-/*50*/	.word sys32_getegid16, sys_acct, sys_nis_syscall, sys_getgid, sys32_ioctl
+/*50*/	.word sys32_getegid16, sys_acct, sys_nis_syscall, sys_getgid, compat_ioctl
 	.word sys_reboot, sys32_mmap2, sys_symlink, sys_readlink, sys32_execve
 /*60*/	.word sys_umask, sys_chroot, compat_sys_newfstat, sys_fstat64, sys_getpagesize
 	.word sys_msync, sys_vfork, sys32_pread64, sys32_pwrite64, sys_geteuid
--- clean/arch/sparc64/solaris/ioctl.c	2003-03-03 23:33:51.000000000 +0100
+++ linux/arch/sparc64/solaris/ioctl.c	2003-02-26 22:44:36.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/netdevice.h>
 #include <linux/mtio.h>
 #include <linux/time.h>
+#include <linux/compat.h>
 
 #include <net/sock.h>
 
@@ -35,7 +36,7 @@
 
 extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, 
 	unsigned long arg);
-extern asmlinkage int sys32_ioctl(unsigned int fd, unsigned int cmd,
+extern asmlinkage int compat_ioctl(unsigned int fd, unsigned int cmd,
 	u32 arg);
 asmlinkage int solaris_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
 
@@ -597,9 +598,9 @@
 {
 	switch (cmd & 0xff) {
 	case 10: /* SIOCADDRT */
-		return sys32_ioctl(fd, SIOCADDRT, arg);
+		return compat_ioctl(fd, SIOCADDRT, arg);
 	case 11: /* SIOCDELRT */
-		return sys32_ioctl(fd, SIOCDELRT, arg);
+		return compat_ioctl(fd, SIOCDELRT, arg);
 	}
 	return -ENOSYS;
 }
@@ -608,45 +609,45 @@
 {
 	switch (cmd & 0xff) {
 	case 12: /* SIOCSIFADDR */
-		return sys32_ioctl(fd, SIOCSIFADDR, arg);
+		return compat_ioctl(fd, SIOCSIFADDR, arg);
 	case 13: /* SIOCGIFADDR */
-		return sys32_ioctl(fd, SIOCGIFADDR, arg);
+		return compat_ioctl(fd, SIOCGIFADDR, arg);
 	case 14: /* SIOCSIFDSTADDR */
-		return sys32_ioctl(fd, SIOCSIFDSTADDR, arg);
+		return compat_ioctl(fd, SIOCSIFDSTADDR, arg);
 	case 15: /* SIOCGIFDSTADDR */
-		return sys32_ioctl(fd, SIOCGIFDSTADDR, arg);
+		return compat_ioctl(fd, SIOCGIFDSTADDR, arg);
 	case 16: /* SIOCSIFFLAGS */
-		return sys32_ioctl(fd, SIOCSIFFLAGS, arg);
+		return compat_ioctl(fd, SIOCSIFFLAGS, arg);
 	case 17: /* SIOCGIFFLAGS */
-		return sys32_ioctl(fd, SIOCGIFFLAGS, arg);
+		return compat_ioctl(fd, SIOCGIFFLAGS, arg);
 	case 18: /* SIOCSIFMEM */
-		return sys32_ioctl(fd, SIOCSIFMEM, arg);
+		return compat_ioctl(fd, SIOCSIFMEM, arg);
 	case 19: /* SIOCGIFMEM */
-		return sys32_ioctl(fd, SIOCGIFMEM, arg);
+		return compat_ioctl(fd, SIOCGIFMEM, arg);
 	case 20: /* SIOCGIFCONF */
-		return sys32_ioctl(fd, SIOCGIFCONF, arg);
+		return compat_ioctl(fd, SIOCGIFCONF, arg);
 	case 21: /* SIOCSIFMTU */
-		return sys32_ioctl(fd, SIOCSIFMTU, arg);
+		return compat_ioctl(fd, SIOCSIFMTU, arg);
 	case 22: /* SIOCGIFMTU */
-		return sys32_ioctl(fd, SIOCGIFMTU, arg);
+		return compat_ioctl(fd, SIOCGIFMTU, arg);
 	case 23: /* SIOCGIFBRDADDR */
-		return sys32_ioctl(fd, SIOCGIFBRDADDR, arg);
+		return compat_ioctl(fd, SIOCGIFBRDADDR, arg);
 	case 24: /* SIOCSIFBRDADDR */
-		return sys32_ioctl(fd, SIOCSIFBRDADDR, arg);
+		return compat_ioctl(fd, SIOCSIFBRDADDR, arg);
 	case 25: /* SIOCGIFNETMASK */
-		return sys32_ioctl(fd, SIOCGIFNETMASK, arg);
+		return compat_ioctl(fd, SIOCGIFNETMASK, arg);
 	case 26: /* SIOCSIFNETMASK */
-		return sys32_ioctl(fd, SIOCSIFNETMASK, arg);
+		return compat_ioctl(fd, SIOCSIFNETMASK, arg);
 	case 27: /* SIOCGIFMETRIC */
-		return sys32_ioctl(fd, SIOCGIFMETRIC, arg);
+		return compat_ioctl(fd, SIOCGIFMETRIC, arg);
 	case 28: /* SIOCSIFMETRIC */
-		return sys32_ioctl(fd, SIOCSIFMETRIC, arg);
+		return compat_ioctl(fd, SIOCSIFMETRIC, arg);
 	case 30: /* SIOCSARP */
-		return sys32_ioctl(fd, SIOCSARP, arg);
+		return compat_ioctl(fd, SIOCSARP, arg);
 	case 31: /* SIOCGARP */
-		return sys32_ioctl(fd, SIOCGARP, arg);
+		return compat_ioctl(fd, SIOCGARP, arg);
 	case 32: /* SIOCDARP */
-		return sys32_ioctl(fd, SIOCDARP, arg);
+		return compat_ioctl(fd, SIOCDARP, arg);
 	case 52: /* SIOCGETNAME */
 	case 53: /* SIOCGETPEER */
 		{
--- clean/arch/sparc64/solaris/timod.c	2003-03-03 23:33:51.000000000 +0100
+++ linux/arch/sparc64/solaris/timod.c	2003-02-26 22:45:01.000000000 +0100
@@ -29,8 +29,6 @@
 
 extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, 
 	unsigned long arg);
-extern asmlinkage int sys32_ioctl(unsigned int fd, unsigned int cmd,
-	u32 arg);
 asmlinkage int solaris_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
 
 static spinlock_t timod_pagelock = SPIN_LOCK_UNLOCKED;
 
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
