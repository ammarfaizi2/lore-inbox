Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbTCJIl2>; Mon, 10 Mar 2003 03:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262778AbTCJIl1>; Mon, 10 Mar 2003 03:41:27 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2052 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262749AbTCJIeD>;
	Mon, 10 Mar 2003 03:34:03 -0500
Date: Sun, 9 Mar 2003 23:23:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       ak@suse.de
Subject: ioctl32 cleanup -- x86-64 version
Message-ID: <20030309222332.GA26538@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

x86-64 parts.
							Pavel


--- clean/arch/x86_64/ia32/ia32_ioctl.c	2003-03-06 23:25:21.000000000 +0100
+++ linux/arch/x86_64/ia32/ia32_ioctl.c	2003-03-06 23:27:37.000000000 +0100
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
--- clean/arch/x86_64/ia32/ia32entry.S	2003-02-18 12:24:31.000000000 +0100
+++ linux/arch/x86_64/ia32/ia32entry.S	2003-03-06 22:12:04.000000000 +0100
@@ -254,7 +254,7 @@
 	.quad sys_acct
 	.quad sys_umount			/* new_umount */
 	.quad ni_syscall			/* old lock syscall holder */
-	.quad sys32_ioctl
+	.quad compact_sys_ioctl
 	.quad sys32_fcntl64		/* 55 */
 	.quad ni_syscall			/* old mpx syscall holder */
 	.quad sys_setpgid

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
