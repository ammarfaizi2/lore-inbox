Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbTBTWXB>; Thu, 20 Feb 2003 17:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbTBTWXB>; Thu, 20 Feb 2003 17:23:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3338 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267081AbTBTWWk>; Thu, 20 Feb 2003 17:22:40 -0500
Date: Thu, 20 Feb 2003 23:31:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
       ak@suse.de, davem@redhat.com
Subject: ioctl32 consolidation
Message-ID: <20030220223119.GA18545@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Currently, 32-bit emulation in kernel has *5* copies, and its >1000
lines each. Plus, locking of all but x86-64 architectures is broken
(I'm told by andi ;-).

So, here's patch that starts sharing sys32_ioctl() [as a first step],
which should rmove locking problems.

I've done the work for x86-64 and sparc64; if it looks good I'll
attempt to do other architectures. [Unless maintainers prefer to do it
themselves: I don't have easy access to 64-bit machines besides
hammer.]

								Pavel

--- clean/arch/sparc64/kernel/ioctl32.c	2003-02-17 23:56:55.000000000 +0100
+++ linux-2.5.62/arch/sparc64/kernel/ioctl32.c	2003-02-20 22:18:29.000000000 +0100
@@ -677,7 +677,7 @@
 	return (void *) (usp - len);
 }
 
-static int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct ifreq *u_ifreq64;
 	struct ifreq32 *u_ifreq32 = (struct ifreq32 *) arg;
@@ -4264,16 +4264,10 @@
 	return sys_ioctl(fd, BLKGETSIZE64, arg);
 }
 
-struct ioctl_trans {
-	unsigned int cmd;
-	unsigned int handler;
-	unsigned int next;
-};
-
 #define COMPATIBLE_IOCTL(cmd) asm volatile(".word %0, sys_ioctl, 0" : : "i" (cmd));
 #define HANDLE_IOCTL(cmd,handler) asm volatile(".word %0, %1, 0" : : "i" (cmd), "i" (handler));
-#define IOCTL_TABLE_START void ioctl32_foo(void) { asm volatile(".data\nioctl_translations:");
-#define IOCTL_TABLE_END asm volatile("\nioctl_translations_end:\n\t.previous"); }
+#define IOCTL_TABLE_START void ioctl32_foo(void) { asm volatile(".data\n.global ioctl_start\nioctl_start:");
+#define IOCTL_TABLE_END asm volatile("\n.global ioctl_end\nioctl_end:\n\t.previous"); }
 
 IOCTL_TABLE_START
 /* List here exlicitly which ioctl's are known to have
@@ -5197,134 +5191,3 @@
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
--- clean/arch/sparc64/kernel/sparc64_ksyms.c	2003-02-17 23:56:49.000000000 +0100
+++ linux-2.5.62/arch/sparc64/kernel/sparc64_ksyms.c	2003-02-20 22:26:39.000000000 +0100
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
 
diff -ur clean/arch/sparc64/kernel/sunos_ioctl32.c linux-2.5.62/arch/sparc64/kernel/sunos_ioctl32.c
--- clean/arch/sparc64/kernel/sunos_ioctl32.c	2003-02-17 23:56:59.000000000 +0100
+++ linux-2.5.62/arch/sparc64/kernel/sunos_ioctl32.c	2003-02-20 22:22:54.000000000 +0100
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
diff -ur clean/arch/sparc64/kernel/systbls.S linux-2.5.62/arch/sparc64/kernel/systbls.S
--- clean/arch/sparc64/kernel/systbls.S	2003-02-17 23:56:13.000000000 +0100
+++ linux-2.5.62/arch/sparc64/kernel/systbls.S	2003-02-20 22:18:29.000000000 +0100
@@ -29,7 +29,7 @@
 	.word sys_chown, sys_sync, sys_kill, compat_sys_newstat, sys32_sendfile
 /*40*/	.word compat_sys_newlstat, sys_dup, sys_pipe, compat_sys_times, sys_getuid
 	.word sys_umount, sys32_setgid16, sys32_getgid16, sys_signal, sys32_geteuid16
-/*50*/	.word sys32_getegid16, sys_acct, sys_nis_syscall, sys_getgid, sys32_ioctl
+/*50*/	.word sys32_getegid16, sys_acct, sys_nis_syscall, sys_getgid, compat_ioctl
 	.word sys_reboot, sys32_mmap2, sys_symlink, sys_readlink, sys32_execve
 /*60*/	.word sys_umask, sys_chroot, compat_sys_newfstat, sys_fstat64, sys_getpagesize
 	.word sys_msync, sys_vfork, sys32_pread64, sys32_pwrite64, sys_geteuid
diff -ur clean/arch/x86_64/ia32/ia32_ioctl.c linux-2.5.62/arch/x86_64/ia32/ia32_ioctl.c
--- clean/arch/x86_64/ia32/ia32_ioctl.c	2003-02-17 23:56:15.000000000 +0100
+++ linux-2.5.62/arch/x86_64/ia32/ia32_ioctl.c	2003-02-20 22:18:30.000000000 +0100
@@ -680,7 +680,7 @@
 	return (void *)regs->rsp - len; 
 }
 
-static int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct ifreq *u_ifreq64;
 	struct ifreq32 *u_ifreq32 = (struct ifreq32 *) arg;
@@ -3578,18 +3578,12 @@
 	return err;
 } 
 
-struct ioctl_trans {
-	unsigned long cmd;
-	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
-	struct ioctl_trans *next;
-};
-
 #define REF_SYMBOL(handler) if (0) (void)handler;
 #define HANDLE_IOCTL2(cmd,handler) REF_SYMBOL(handler);  asm volatile(".quad %c0, " #handler ",0"::"i" (cmd)); 
 #define HANDLE_IOCTL(cmd,handler) HANDLE_IOCTL2(cmd,handler)
 #define COMPATIBLE_IOCTL(cmd) HANDLE_IOCTL(cmd,sys_ioctl)
-#define IOCTL_TABLE_START void ioctl_dummy(void) { asm volatile("\nioctl_start:\n\t" );
-#define IOCTL_TABLE_END  asm volatile("\nioctl_end:"); }
+#define IOCTL_TABLE_START void ioctl_dummy(void) { asm volatile("\n.global ioctl_start\nioctl_start:\n\t" );
+#define IOCTL_TABLE_END  asm volatile("\n.global ioctl_end;\nioctl_end:\n"); }
 
 IOCTL_TABLE_START
 /* List here explicitly which ioctl's are known to have
@@ -4432,217 +4426,3 @@
 HANDLE_IOCTL(MTRRIOC32_KILL_PAGE_ENTRY, mtrr_ioctl32)
 IOCTL_TABLE_END
 
-#define IOCTL_HASHSIZE 256
-struct ioctl_trans *ioctl32_hash_table[IOCTL_HASHSIZE];
-
-extern struct ioctl_trans ioctl_start[], ioctl_end[]; 
-
-extern struct ioctl_trans ioctl_start[], ioctl_end[]; 
-
-static inline unsigned long ioctl32_hash(unsigned long cmd)
-{
-	return (((cmd >> 6) ^ (cmd >> 4) ^ cmd)) % IOCTL_HASHSIZE;
-}
-
-static void ioctl32_insert_translation(struct ioctl_trans *trans)
-{
-	unsigned long hash;
-	struct ioctl_trans *t;
-
-	hash = ioctl32_hash (trans->cmd);
-	if (!ioctl32_hash_table[hash])
-		ioctl32_hash_table[hash] = trans;
-	else {
-		t = ioctl32_hash_table[hash];
-		while (t->next)
-			t = t->next;
-		trans->next = 0;
-		t->next = trans;
-	}
-}
-
-static int __init init_sys32_ioctl(void)
-{
-	int i;
-
-	for (i = 0; &ioctl_start[i] < &ioctl_end[0]; i++) {
-		if (ioctl_start[i].next != 0) { 
-			printk("ioctl translation %d bad\n",i); 
-			return -1;
-		}
-
-		ioctl32_insert_translation(&ioctl_start[i]);
-	}
-	return 0;
-}
-
-__initcall(init_sys32_ioctl);
-
-static struct ioctl_trans *ioctl_free_list;
-
-/* Never free them really. This avoids SMP races. With a Read-Copy-Update
-   enabled kernel we could just use the RCU infrastructure for this. */
-static void free_ioctl(struct ioctl_trans *t) 
-{ 
-	t->cmd = 0; 
-	mb();
-	t->next = ioctl_free_list;
-	ioctl_free_list = t;
-} 
-
-int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *))
-{
-	struct ioctl_trans *t;
-	unsigned long hash = ioctl32_hash(cmd);
-
-	lock_kernel(); 
-	for (t = (struct ioctl_trans *)ioctl32_hash_table[hash];
-	     t;
-	     t = t->next) { 
-		if (t->cmd == cmd) {
-			printk("Trying to register duplicated ioctl32 handler %x\n", cmd);
-			unlock_kernel();
-			return -EINVAL; 
-	}
-	} 
-
-	if (ioctl_free_list) { 
-		t = ioctl_free_list; 
-		ioctl_free_list = t->next; 
-	} else { 
-		t = kmalloc(sizeof(struct ioctl_trans), GFP_KERNEL); 
-		if (!t) { 
-			unlock_kernel();
-		return -ENOMEM;
-		}
-	}
-	
-	t->next = NULL;
-	t->cmd = cmd;
-	t->handler = handler; 
-	ioctl32_insert_translation(t);
-
-	unlock_kernel();
-	return 0;
-}
-
-static inline int builtin_ioctl(struct ioctl_trans *t)
-{ 
-	return t >= (struct ioctl_trans *)ioctl_start &&
-	       t < (struct ioctl_trans *)ioctl_end; 
-} 
-
-/* Problem: 
-   This function cannot unregister duplicate ioctls, because they are not
-   unique.
-   When they happen we need to extend the prototype to pass the handler too. */
-
-int unregister_ioctl32_conversion(unsigned int cmd)
-{
-	unsigned long hash = ioctl32_hash(cmd);
-	struct ioctl_trans *t, *t1;
-
-	lock_kernel(); 
-
-	t = (struct ioctl_trans *)ioctl32_hash_table[hash];
-	if (!t) { 
-		unlock_kernel();
-		return -EINVAL;
-	} 
-
-	if (t->cmd == cmd) { 
-		if (builtin_ioctl(t)) {
-			printk("%p tried to unregister builtin ioctl %x\n",
-			       __builtin_return_address(0), cmd);
-		} else { 
-		ioctl32_hash_table[hash] = t->next;
-			free_ioctl(t); 
-			unlock_kernel();
-		return 0;
-		}
-	} 
-	while (t->next) {
-		t1 = (struct ioctl_trans *)(long)t->next;
-		if (t1->cmd == cmd) { 
-			if (builtin_ioctl(t1)) {
-				printk("%p tried to unregister builtin ioctl %x\n",
-				       __builtin_return_address(0), cmd);
-				goto out;
-			} else { 
-			t->next = t1->next;
-				free_ioctl(t1); 
-				unlock_kernel();
-			return 0;
-		}
-		}
-		t = t1;
-	}
-	printk(KERN_ERR "Trying to free unknown 32bit ioctl handler %x\n", cmd);
- out:
-	unlock_kernel();
-	return -EINVAL;
-}
-
-EXPORT_SYMBOL(register_ioctl32_conversion); 
-EXPORT_SYMBOL(unregister_ioctl32_conversion); 
-
-asmlinkage long sys32_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
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
-	t = (struct ioctl_trans *)ioctl32_hash_table [ioctl32_hash (cmd)];
-
-	while (t && t->cmd != cmd)
-		t = (struct ioctl_trans *)t->next;
-	if (t) {
-		handler = t->handler;
-		error = handler(fd, cmd, arg, filp);
-	} else if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
-		error = siocdevprivate_ioctl(fd, cmd, arg);
-	} else {
-		static int count;
-		if (++count <= 50) { 
-			char buf[10];
-			char *path = (char *)__get_free_page(GFP_KERNEL), *fn = "?"; 
-
-			/* find the name of the device. */
-			if (path) {
-				struct file *f = fget(fd); 
-				if (f) {
-					fn = d_path(f->f_dentry, f->f_vfsmnt, 
-						    path, PAGE_SIZE);
-					fput(f);
-				}
-			}
-
-			sprintf(buf,"'%c'", (cmd>>24) & 0x3f); 
-			if (!isprint(buf[1]))
-			    sprintf(buf, "%02x", buf[1]);
-			printk("ioctl32(%s:%d): Unknown cmd fd(%d) "
-			       "cmd(%08x){%s} arg(%08x) on %s\n",
-			       current->comm, current->pid,
-			       (int)fd, (unsigned int)cmd, buf, (unsigned int)arg,
-			       fn);
-			if (path) 
-				free_page((unsigned long)path); 
-		}
-		error = -EINVAL;
-	}
-out:
-	fput(filp);
-out2:
-	return error;
-}
-
diff -ur clean/arch/x86_64/ia32/ia32entry.S linux-2.5.62/arch/x86_64/ia32/ia32entry.S
--- clean/arch/x86_64/ia32/ia32entry.S	2003-02-17 23:56:14.000000000 +0100
+++ linux-2.5.62/arch/x86_64/ia32/ia32entry.S	2003-02-20 22:18:30.000000000 +0100
@@ -254,7 +254,7 @@
 	.quad sys_acct
 	.quad sys_umount			/* new_umount */
 	.quad ni_syscall			/* old lock syscall holder */
-	.quad sys32_ioctl
+	.quad compat_ioctl
 	.quad sys32_fcntl64		/* 55 */
 	.quad ni_syscall			/* old mpx syscall holder */
 	.quad sys_setpgid
diff -ur clean/include/linux/ioctl32.h linux-2.5.62/include/linux/ioctl32.h
--- clean/include/linux/ioctl32.h	2003-02-17 23:55:50.000000000 +0100
+++ linux-2.5.62/include/linux/ioctl32.h	2003-02-20 22:18:30.000000000 +0100
@@ -19,5 +19,10 @@
 
 extern int unregister_ioctl32_conversion(unsigned int cmd);
 
+struct ioctl_trans {
+	unsigned long cmd;
+	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
+	struct ioctl_trans *next;
+};
 
 #endif
diff -ur clean/kernel/compat.c linux-2.5.62/kernel/compat.c
--- clean/kernel/compat.c	2003-02-17 23:56:15.000000000 +0100
+++ linux-2.5.62/kernel/compat.c	2003-02-20 22:18:30.000000000 +0100
@@ -18,6 +18,12 @@
 #include <linux/signal.h>
 #include <linux/sched.h>	/* for MAX_SCHEDULE_TIMEOUT */
 #include <linux/futex.h>	/* for FUTEX_WAIT */
+#include <linux/ioctl32.h>
+#include <linux/init.h>
+#include <linux/sockios.h>	/* for SIOCDEVPRIVATE */
+#include <linux/fs.h>
+#include <linux/smp_lock.h>
+#include <linux/ctype.h>
 
 #include <asm/uaccess.h>
 
@@ -226,3 +232,219 @@
 	}
 	return do_futex((unsigned long)uaddr, op, val, timeout);
 }
+
+/* ioctl32 stuff, used by sparc64, parisc, s390x, ppc64, x86_64 */
+
+#define IOCTL_HASHSIZE 256
+struct ioctl_trans *ioctl32_hash_table[IOCTL_HASHSIZE];
+
+extern struct ioctl_trans ioctl_start[], ioctl_end[]; 
+
+static inline unsigned long ioctl32_hash(unsigned long cmd)
+{
+	return (((cmd >> 6) ^ (cmd >> 4) ^ cmd)) % IOCTL_HASHSIZE;
+}
+
+static void ioctl32_insert_translation(struct ioctl_trans *trans)
+{
+	unsigned long hash;
+	struct ioctl_trans *t;
+
+	hash = ioctl32_hash (trans->cmd);
+	if (!ioctl32_hash_table[hash])
+		ioctl32_hash_table[hash] = trans;
+	else {
+		t = ioctl32_hash_table[hash];
+		while (t->next)
+			t = t->next;
+		trans->next = 0;
+		t->next = trans;
+	}
+}
+
+static int __init init_sys32_ioctl(void)
+{
+	int i;
+
+	for (i = 0; &ioctl_start[i] < &ioctl_end[0]; i++) {
+		if (ioctl_start[i].next != 0) { 
+			printk("ioctl translation %d bad\n",i); 
+			return -1;
+		}
+
+		ioctl32_insert_translation(&ioctl_start[i]);
+	}
+	return 0;
+}
+
+__initcall(init_sys32_ioctl);
+
+static struct ioctl_trans *ioctl_free_list;
+
+/* Never free them really. This avoids SMP races. With a Read-Copy-Update
+   enabled kernel we could just use the RCU infrastructure for this. */
+static void free_ioctl(struct ioctl_trans *t) 
+{ 
+	t->cmd = 0; 
+	mb();
+	t->next = ioctl_free_list;
+	ioctl_free_list = t;
+} 
+
+int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *))
+{
+	struct ioctl_trans *t;
+	unsigned long hash = ioctl32_hash(cmd);
+
+	lock_kernel(); 
+	for (t = (struct ioctl_trans *)ioctl32_hash_table[hash];
+	     t;
+	     t = t->next) { 
+		if (t->cmd == cmd) {
+			printk("Trying to register duplicated ioctl32 handler %x\n", cmd);
+			unlock_kernel();
+			return -EINVAL; 
+		}
+	} 
+
+	if (ioctl_free_list) { 
+		t = ioctl_free_list; 
+		ioctl_free_list = t->next; 
+	} else { 
+		t = kmalloc(sizeof(struct ioctl_trans), GFP_KERNEL); 
+		if (!t) { 
+			unlock_kernel();
+		return -ENOMEM;
+		}
+	}
+	
+	t->next = NULL;
+	t->cmd = cmd;
+	t->handler = handler; 
+	ioctl32_insert_translation(t);
+
+	unlock_kernel();
+	return 0;
+}
+
+static inline int builtin_ioctl(struct ioctl_trans *t)
+{ 
+	return t >= (struct ioctl_trans *)ioctl_start &&
+	       t < (struct ioctl_trans *)ioctl_end; 
+} 
+
+/* Problem: 
+   This function cannot unregister duplicate ioctls, because they are not
+   unique.
+   When they happen we need to extend the prototype to pass the handler too. */
+
+int unregister_ioctl32_conversion(unsigned int cmd)
+{
+	unsigned long hash = ioctl32_hash(cmd);
+	struct ioctl_trans *t, *t1;
+
+	lock_kernel(); 
+
+	t = (struct ioctl_trans *)ioctl32_hash_table[hash];
+	if (!t) { 
+		unlock_kernel();
+		return -EINVAL;
+	} 
+
+	if (t->cmd == cmd) { 
+		if (builtin_ioctl(t)) {
+			printk("%p tried to unregister builtin ioctl %x\n",
+			       __builtin_return_address(0), cmd);
+		} else { 
+		ioctl32_hash_table[hash] = t->next;
+			free_ioctl(t); 
+			unlock_kernel();
+		return 0;
+		}
+	} 
+	while (t->next) {
+		t1 = (struct ioctl_trans *)(long)t->next;
+		if (t1->cmd == cmd) { 
+			if (builtin_ioctl(t1)) {
+				printk("%p tried to unregister builtin ioctl %x\n",
+				       __builtin_return_address(0), cmd);
+				goto out;
+			} else { 
+			t->next = t1->next;
+				free_ioctl(t1); 
+				unlock_kernel();
+			return 0;
+			}
+		}
+		t = t1;
+	}
+	printk(KERN_ERR "Trying to free unknown 32bit ioctl handler %x\n", cmd);
+ out:
+	unlock_kernel();
+	return -EINVAL;
+}
+
+EXPORT_SYMBOL(register_ioctl32_conversion); 
+EXPORT_SYMBOL(unregister_ioctl32_conversion); 
+
+asmlinkage long compat_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	struct file * filp;
+	int error = -EBADF;
+	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
+	struct ioctl_trans *t;
+
+	filp = fget(fd);
+	if(!filp)
+		goto out2;
+
+	if (!filp->f_op || !filp->f_op->ioctl) {
+		error = sys_ioctl (fd, cmd, arg);
+		goto out;
+	}
+
+	t = (struct ioctl_trans *)ioctl32_hash_table [ioctl32_hash (cmd)];
+
+	while (t && t->cmd != cmd)
+		t = (struct ioctl_trans *)t->next;
+	if (t) {
+		handler = t->handler;
+		error = handler(fd, cmd, arg, filp);
+	} else if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
+		error = siocdevprivate_ioctl(fd, cmd, arg);
+	} else {
+		static int count;
+		if (++count <= 50) { 
+			char buf[10];
+			char *path = (char *)__get_free_page(GFP_KERNEL), *fn = "?"; 
+
+			/* find the name of the device. */
+			if (path) {
+				struct file *f = fget(fd); 
+				if (f) {
+					fn = d_path(f->f_dentry, f->f_vfsmnt, 
+						    path, PAGE_SIZE);
+					fput(f);
+				}
+			}
+
+			sprintf(buf,"'%c'", (cmd>>24) & 0x3f); 
+			if (!isprint(buf[1]))
+			    sprintf(buf, "%02x", buf[1]);
+			printk("ioctl32(%s:%d): Unknown cmd fd(%d) "
+			       "cmd(%08x){%s} arg(%08x) on %s\n",
+			       current->comm, current->pid,
+			       (int)fd, (unsigned int)cmd, buf, (unsigned int)arg,
+			       fn);
+			if (path) 
+				free_page((unsigned long)path); 
+		}
+		error = -EINVAL;
+	}
+out:
+	fput(filp);
+out2:
+	return error;
+}
+
+



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
