Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132490AbQLQM6j>; Sun, 17 Dec 2000 07:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132460AbQLQM63>; Sun, 17 Dec 2000 07:58:29 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:61947 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132107AbQLQM6Q>; Sun, 17 Dec 2000 07:58:16 -0500
Message-ID: <3A3CB237.40160FA5@uow.edu.au>
Date: Sun, 17 Dec 2000 23:31:51 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [Fwd: [patch] call_usermodehelper]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I missed a certain mailing list on this one...

-------- Original Message --------
Subject: [patch] call_usermodehelper
Date: Sun, 17 Dec 2000 23:01:14 +1100
From: Andrew Morton <andrewm@uow.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
CC: David Brownell <david-b@pacbell.net>,Thomas Sailer <sailer@ife.ee.ethz.ch>,Keith Owens <kaos@ocs.com.au>,"linux-usb-devel@lists.sourceforge.net" <linux-usb-devel@lists.sourceforge.net>

Final installment...

This function has three modes:

* Synchronous.  The caller is blocked until error or termination of the
  subprocess.  Needed by baycomm_epp.c and, in the future, by
  request_module().

* Asynchronous with completion.  The completion is called when an error
  occurs or when the subprocess exits.  To be used by USB.

* Asynchronous with no completion (the "fingers crossed" mode).  Used
  by netdevices.

I've been very careful to ensure that the caller always knows whether
or not the subprocess ran, and whether or not it succeeded (exit code).
See the inline kernel-docs for details.

- baycom_epp.c has been changed to use call_usermodehelper() (Thomas
  has tested this - thanks!) and exec_usermodehelper() has been
  removed from the kernel API. It still exists, statically, for
  request_module().  I'll kill it completely post-2.4

- In the three places where call_usermodehelper() is called, the
  initialisation of the PATH and HOME environment variables
  has been removed.  It is the responsibility of the usermode
  process to initialise these.  This change was not made in
  baycom_epp.c - that might break an existing application.

  If someone wants to set up a system which has world-writable
  /usr/sbin, the kernel shouldn't prevent this by offering users
  subtle rootsploits.  I think.

  Keith, I think we should do this to modprobe post-2.4 as well:
  it won't have a $PATH or $HOME when it is launched.

- Asynchronous usage of call_usermodehelper() from interrupt
  context is permitted.

- Asynchronous mode is now fully async wrt vfork(), which
  fixes the lingering concerns over vfork() doing something
  which requires hotplugging and causing keventd deadlock.

- Synchronous use of call_usermodehelper() from within keventd
  deadlocks keventd.  Not recommended.  Use a completion or
  a standalone thread.

- When there is a completion outstanding we manage the caller's
  module refcount for them.  But the caller must still do things
  like not shut the hardware down or free resources if a completion
  is outstanding.  If call_usermodehelper() returned non-negative,
  the completion _will_ be called.  Promise.

- Created lib/misc.c as a placeholder for reusable boilerplate.

- ObBloatStatement - grows the image by 1.1k.  Sorry.

TODO:

- Infinite recursion protection in synchronous mode.  I think this
  can wait until request_module() is using call_usermodehelper().



--- linux-2.4.0-test13-pre2/include/linux/string.h	Sat Dec 16 23:59:50 2000
+++ linux-akpm/include/linux/string.h	Sun Dec 17 22:51:29 2000
@@ -13,7 +13,10 @@
 extern char * strtok(char *,const char *);
 extern char * strsep(char **,const char *);
 extern __kernel_size_t strspn(const char *,const char *);
-
+extern void *kmallocz(size_t size, int gfp_flags);
+extern char *kstrdup(const char *orig, int gfp_flags);
+extern char **kstrdup_vec(char **orig, int gfp_flags);
+extern void kstrfree_vec(char **vec);
 
 /*
  * Include machine specific inline routines
--- linux-2.4.0-test13-pre2/include/linux/kmod.h	Sat Dec 16 23:59:50 2000
+++ linux-akpm/include/linux/kmod.h	Sun Dec 17 22:51:29 2000
@@ -22,14 +22,31 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 
+struct module;
 #ifdef CONFIG_KMOD
 extern int request_module(const char * name);
 #else
 static inline int request_module(const char * name) { return -ENOSYS; }
 #endif
 
-extern int exec_usermodehelper(char *program_path, char *argv[], char *envp[]);
-extern int call_usermodehelper(char *path, char *argv[], char *envp[]);
+struct umh_control {
+	int synchronous;					/* Flag: make call_usermodehelper() block */
+	void (*completion)(void *completion_arg, int exit_code);/* Called when subprocess exits if non-NULL */
+	void *completion_arg;					/* Private to caller */
+	struct module *owner;
+};
+
+#define INIT_UMH_CONTROL(_synchronous, _completion, _completion_arg) {	\
+		synchronous:	(_synchronous),				\
+		completion:	(_completion),				\
+		completion_arg:	(_completion_arg),			\
+		owner:		THIS_MODULE,				\
+	}
+
+#define DEFINE_UMH_CONTROL(name, synchronous, completion, completion_arg)	\
+	struct umh_control name = INIT_UMH_CONTROL(synchronous, completion, completion_arg)
+
+extern int call_usermodehelper(char *path, char *argv[], char *envp[], struct umh_control *umh_c);
 
 #ifdef CONFIG_HOTPLUG
 extern char hotplug_path [];
--- linux-2.4.0-test13-pre2/lib/Makefile	Sat Dec 16 23:59:50 2000
+++ linux-akpm/lib/Makefile	Sun Dec 17 22:51:29 2000
@@ -10,7 +10,7 @@
 
 export-objs := cmdline.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o misc.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o
--- linux-2.4.0-test13-pre2/lib/misc.c	Thu Jan  1 00:00:00 1970
+++ linux-akpm/lib/misc.c	Sun Dec 17 22:51:29 2000
@@ -0,0 +1,94 @@
+/*
+ * linux/lib/misc.c
+ *
+ * Somewhere to put reusable things.
+ */
+
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+
+/**
+ * kmallocz - allocate some memory with kmalloc and zero it
+ * @size: number of bytes to allocate
+ * @gfp_flags: allocation mode for kmalloc()
+ *
+ * Returns a pointer to the newly allocated and cleared memory, or %NULL
+ * if the allocation failed.  The memory may be released with kfree().
+ */
+void *kmallocz(size_t size, int gfp_flags)
+{
+	void *ret = kmalloc(size, gfp_flags);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
+}
+EXPORT_SYMBOL(kmallocz);
+
+/**
+ * kstrdup - duplicate a string in kmalloced memory
+ * @orig: the string to duplicate
+ * @gfp_flags: allocation mode for kmalloc()
+ *
+ * Returns the copy, or %NULL on allocation failure.  The new string
+ * may be released with kfree().
+ */
+char *kstrdup(const char *orig, int gfp_flags)
+{
+	char *ret = kmalloc(strlen(orig) + 1, gfp_flags);
+	if (ret)
+		strcpy(ret, orig);
+	return ret;
+}
+EXPORT_SYMBOL(kstrdup);
+
+/**
+ * kstrdup_vec - copy a vector of strings
+ * @orig: null-terminated array of pointers to strings
+ * @gfp_flags: allocation mode for kmalloc()
+ *
+ * Returns a duplicated copy of the passed vector of strings.  Returns %NULL
+ * on allocation error.  The returned vector is null-terminated and may be
+ * released with kstrfree_vec().
+ */
+char **kstrdup_vec(char **orig, int gfp_flags)
+{
+	unsigned int nstrings, idx;
+	char **ret;
+
+	for (nstrings = 0; orig[nstrings] != 0; nstrings++)
+		;
+	ret = kmallocz((nstrings + 1) * sizeof(*ret), gfp_flags);
+	if (ret) {
+		for (idx = 0; idx < nstrings; idx++) {
+			ret[idx] = kstrdup(orig[idx], gfp_flags);
+			if (ret[idx] == 0) {
+				kstrfree_vec(ret);
+				ret = 0;
+				goto out;
+			}
+		}
+	}
+out:
+	return ret;
+}
+EXPORT_SYMBOL(kstrdup_vec);
+
+/**
+ * kstrfree_vec - release a vector of strings which was allocated with kstrdup_vec()
+ * @vec: address of the null-terminated vector
+ *
+ * Releases the strings via kfree() and then releases the containing vector itself.
+ * If @vec is %NULL no action is taken.
+ */
+void kstrfree_vec(char **vec)
+{
+	unsigned int idx = 0;
+
+	if (vec) {
+		while (vec[idx])
+			kfree(vec[idx++]);
+		kfree(vec);
+	}
+}
+EXPORT_SYMBOL(kstrfree_vec);
--- linux-2.4.0-test13-pre2/kernel/kmod.c	Sat Dec 16 23:59:50 2000
+++ linux-akpm/kernel/kmod.c	Sun Dec 17 22:51:29 2000
@@ -21,6 +21,8 @@
 #include <linux/unistd.h>
 #include <linux/kmod.h>
 #include <linux/smp_lock.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #include <asm/uaccess.h>
 
@@ -80,7 +82,7 @@
 	mntput(pwdmnt);
 }
 
-int exec_usermodehelper(char *program_path, char *argv[], char *envp[])
+static int exec_usermodehelper(char *program_path, char *argv[], char *envp[])
 {
 	int i;
 
@@ -231,6 +233,7 @@
 	}
 	return 0;
 }
+EXPORT_SYMBOL(request_module);
 #endif /* CONFIG_KMOD */
 
 
@@ -258,27 +261,91 @@
 #endif /* CONFIG_HOTPLUG */
 
 struct subprocess_info {
-	struct semaphore *sem;
+	struct tq_struct task_queue;
 	char *path;
 	char **argv;
 	char **envp;
-	pid_t retval;
+	struct semaphore *sem;		/* If this is non-zero we must wake the parent */
+	struct umh_control umh_c;
+	int *exit_code;
 };
 
 /*
- * This is the task which runs the usermode application
+ * Notify userspace, unblock the caller of call_usermodehelper
+ * and clean up.
  */
-static int ____call_usermodehelper(void *data)
+static void free_subprocess_info(struct subprocess_info *sub_info, int exit_code)
+{
+	if (sub_info->umh_c.completion) {
+		sub_info->umh_c.completion(sub_info->umh_c.completion_arg, exit_code);
+		if (sub_info->umh_c.owner)
+			__MOD_DEC_USE_COUNT(sub_info->umh_c.owner);
+	}
+	if (sub_info->sem) {
+		*sub_info->exit_code = exit_code;
+		up(sub_info->sem);
+	}
+	kstrfree_vec(sub_info->envp);
+	kstrfree_vec(sub_info->argv);
+	kfree(sub_info->path);
+	kfree(sub_info);
+}
+
+/*
+ * This thread becomes the usermode application
+ */
+static int ______call_usermodehelper(void *data)
 {
 	struct subprocess_info *sub_info = data;
-	int retval;
+	int retval = -EPERM;
 
-	retval = -EPERM;
 	if (current->fs->root)
 		retval = exec_usermodehelper(sub_info->path, sub_info->argv, sub_info->envp);
+	do_exit(retval);
+}
+
+/*
+ * This thread parents the usermode application.
+ */
+static int ____call_usermodehelper(void *data)
+{
+	struct subprocess_info *sub_info = data;
+	struct task_struct *curtask = current;
+	pid_t pid, pid2;
+	int ret = 0;
 
-	/* Exec failed? */
-	sub_info->retval = (pid_t)retval;
+	/*
+	 * CLONE_VFORK: wait until the usermode helper has execve'd successfully.
+	 * We need the data structures to stay around until that is done.
+	 * We really only need to do this for the asynchronous case.
+	 */
+	pid = kernel_thread(______call_usermodehelper, sub_info, CLONE_VFORK | SIGCHLD);
+	if (pid < 0) {
+		printk(KERN_ERR "call_usermodehelper(%s): vfork failed: %d\n", sub_info->path, pid);
+		ret = pid;
+		goto out;
+	}
+
+	if (sub_info->sem || sub_info->umh_c.completion) {
+		mm_segment_t fs = get_fs();
+
+		/* Block everything but SIGKILL/SIGSTOP */
+		spin_lock_irq(&curtask->sigmask_lock);
+		siginitsetinv(&curtask->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
+		recalc_sigpending(curtask);
+		spin_unlock_irq(&curtask->sigmask_lock);
+
+		set_fs(KERNEL_DS);
+		pid2 = waitpid(pid, &ret, __WALL);
+		set_fs(fs);
+		if (pid2 != pid) {
+			printk(KERN_ERR "call_usermodehelper(%s): waitpid failed: %d\n",
+				sub_info->path, pid2);
+			ret = (pid2 < 0) ? -errno : -1;
+		}
+	}
+out:
+	free_subprocess_info(sub_info, ret);
 	do_exit(0);
 }
 
@@ -290,14 +357,11 @@
 	struct subprocess_info *sub_info = data;
 	pid_t pid;
 
-	/*
-	 * CLONE_VFORK: wait until the usermode helper has execve'd successfully
-	 * We need the data structures to stay around until that is done.
-	 */
-	pid = kernel_thread(____call_usermodehelper, sub_info, CLONE_VFORK | SIGCHLD);
-	if (pid < 0)
-		sub_info->retval = pid;
-	up(sub_info->sem);
+	pid = kernel_thread(____call_usermodehelper, sub_info, SIGCHLD);
+	if (pid < 0) {
+		printk(KERN_ERR "call_usermodehelper(%s): fork failed: %d\n", sub_info->path, pid);
+		free_subprocess_info(sub_info, pid);
+	}
 }
 
 /**
@@ -305,42 +369,97 @@
  * @path: pathname for the application
  * @argv: null-terminated argument list
  * @envp: null-terminated environment list
+ * @umh_c: an &umh_control which controls call_usermodehelper()'s behaviour
+ *
+ * Runs a user-space application.  The application runs as a child of keventd.  It runs
+ * with full root capabilities.  If @umh_c->synchronous is true, call_usermodehelper() must be
+ * called from process context, and it will block the caller until the usermode application
+ * has exitted, or an error has occurred.
+ *
+ * If &umh_c is %NULL then the usermode helper is called asynchronously and no completion
+ * is performed.
  *
- * Runs a user-space application.  The application is started asynchronously.  It
- * runs as a child of keventd.  It runs with full root capabilities.  keventd silently
- * reaps the child when it exits.
+ * If @umh_c->synchronous is true and the usermode application was successfully launched,
+ * call_usermodehelper() returns the non-negative usermode application's exit code.
  *
- * Must be called from process context.  Returns zero on success, else a negative
- * error code.
+ * If @umh_c->synchronous is true and the usermode application was not successfully launched,
+ * call_usermodehelper() returns a negative error code.
+ *
+ * If @umh_c->synchronous is false, and call_usermodehelper() returns a negative error
+ * code then the usermode application could not be launched.
+ *
+ * If @umh_c->synchronous is false and call_usermodehelper() returns zero then the usermode
+ * application _may_ have been launched.  It is not possible for the caller to know
+ * the outcome until the completion routine (if requested) is called.
+ *
+ * If @umh_c->completion is non-zero, @umh_c->synchronous is false and if
+ * call_usermodehelper() returned zero, the completion routine will be called at some time
+ * in the future, within the context of keventd or a child of keventd.  The completion
+ * routine is passed @umh_c->completion_arg and `exit_code'.  If `exit_code' is negative,
+ * the usermode application was never launched.  If `exit_code' is non-negative then the
+ * usermode application did run and this is its exitcode.  If `exit_code' is non-negative
+ * then the completion routine may sleep.
+ *
+ * If @umh_c->synchronous is true then a completion function may not be used.
+ *
+ * If call_usermodehelper() was called from within a module then it raises your module
+ * reference count while the completion is pending, provided you correctly used the helper
+ * macros in kmod.h
  */
-int call_usermodehelper(char *path, char **argv, char **envp)
+int call_usermodehelper(char *path, char **argv, char **envp, struct umh_control *umh_c)
 {
+	struct subprocess_info *sub_info;
 	DECLARE_MUTEX_LOCKED(sem);
-	struct subprocess_info sub_info = {
-		sem:		&sem,
-		path:		path,
-		argv:		argv,
-		envp:		envp,
-		retval:		0,
-	};
-	struct tq_struct tqs = {
-		routine:	__call_usermodehelper,
-		data:		&sub_info,
-	};
+	int ret = -ENOMEM;
+	int gfp_flags = in_interrupt() ? GFP_ATOMIC : GFP_KERNEL;
 
-	if (path[0] == '\0')
-		goto out;
-
-	if (current_is_keventd()) {
-		/* We can't wait on keventd! */
-		__call_usermodehelper(&sub_info);
-	} else {
-		schedule_task(&tqs);
-		down(&sem);		/* Wait until keventd has started the subprocess */
+	sub_info = kmallocz(sizeof(*sub_info), gfp_flags);
+	if (sub_info == 0)
+		goto fail;
+
+	if (umh_c) {
+		sub_info->umh_c = *umh_c;
+		if (umh_c->synchronous) {
+			sub_info->exit_code = &ret;
+			sub_info->sem = &sem;
+			sub_info->umh_c.completion = 0;	/* No completion allowed */
+		}
+		if (	sub_info->umh_c.owner &&
+			sub_info->umh_c.completion &&
+			try_inc_mod_count(sub_info->umh_c.owner) == 0)
+			goto fail;
 	}
-out:
-	return sub_info.retval;
+
+	sub_info->path = kstrdup(path, gfp_flags);
+	if (sub_info->path == 0)
+		goto fail;
+
+	sub_info->argv = kstrdup_vec(argv, gfp_flags);
+	if (sub_info->argv == 0)
+		goto fail;
+
+	sub_info->envp = kstrdup_vec(envp, gfp_flags);
+	if (sub_info->envp == 0)
+		goto fail;
+
+	sub_info->task_queue.routine = __call_usermodehelper;
+	sub_info->task_queue.data = sub_info;
+	if (schedule_task(&sub_info->task_queue) == 0)
+		BUG();
+
+	/* We can't touch *sub_info from now on */
+
+	ret = 0;
+	if (umh_c && umh_c->synchronous)
+		down(&sem);
+	smp_mb();
+	return ret;
+fail:
+	sub_info->umh_c.completion = 0;		/* It could have been set, above */
+	free_subprocess_info(sub_info, ret);
+	return ret;
 }
+EXPORT_SYMBOL(call_usermodehelper);
 
 /*
  * This is for the serialisation of device probe() functions
@@ -357,11 +476,3 @@
 {
 	up(&dev_probe_sem);
 }
-
-EXPORT_SYMBOL(exec_usermodehelper);
-EXPORT_SYMBOL(call_usermodehelper);
-
-#ifdef CONFIG_KMOD
-EXPORT_SYMBOL(request_module);
-#endif
-
--- linux-2.4.0-test13-pre2/drivers/pci/pci.c	Sat Dec 16 23:59:50 2000
+++ linux-akpm/drivers/pci/pci.c	Sun Dec 17 22:51:29 2000
@@ -378,10 +378,6 @@
 	argv[i] = 0;
 
 	i = 0;
-	/* minimal command environment */
-	envp[i++] = "HOME=/";
-	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-	
 	/* other stuff we want to pass to /sbin/hotplug */
 	envp[i++] = class_id;
 	envp[i++] = id;
@@ -393,7 +389,7 @@
 		envp[i++] = "ACTION=remove";
 	envp[i] = 0;
 
-	call_usermodehelper (argv [0], argv, envp);
+	call_usermodehelper (argv [0], argv, envp, 0);
 }
 
 void
--- linux-2.4.0-test13-pre2/drivers/usb/usb.c	Sat Dec 16 23:59:51 2000
+++ linux-akpm/drivers/usb/usb.c	Sun Dec 17 22:51:29 2000
@@ -716,10 +716,6 @@
 	argv [1] = "usb";
 	argv [2] = 0;
 
-	/* minimal command environment */
-	envp [i++] = "HOME=/";
-	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-
 #ifdef	DEBUG
 	/* hint that policy agent should enter no-stdout debug mode */
 	envp [i++] = "DEBUG=kernel";
@@ -781,7 +777,7 @@
 	/* NOTE: user mode daemons can call the agents too */
 
 	dbg ("kusbd: %s %s %d", argv [0], verb, dev->devnum);
-	value = call_usermodehelper (argv [0], argv, envp);
+	value = call_usermodehelper (argv [0], argv, envp, 0);
 	kfree (buf);
 	kfree (envp);
 	if (value != 0)
--- linux-2.4.0-test13-pre2/drivers/net/hamradio/baycom_epp.c	Sat Dec 16 23:59:51 2000
+++ linux-akpm/drivers/net/hamradio/baycom_epp.c	Sun Dec 17 22:51:29 2000
@@ -375,15 +375,13 @@
 
 static char *envp[] = { "HOME=/", "TERM=linux", "PATH=/usr/bin:/bin", NULL };
 
-static int errno;
-
-static int exec_eppfpga(void *b)
+static int eppconfig(struct baycom_state *bc)
 {
-	struct baycom_state *bc = (struct baycom_state *)b;
 	char modearg[256];
 	char portarg[16];
         char *argv[] = { eppconfig_path, "-s", "-p", portarg, "-m", modearg, NULL};
         int i;
+	DEFINE_UMH_CONTROL(umh_c, 1, 0, 0);
 
 	/* set up arguments */
 	sprintf(modearg, "%sclk,%smodem,fclk=%d,bps=%d,divider=%d%s,extstat",
@@ -394,39 +392,13 @@
 	sprintf(portarg, "%ld", bc->pdev->port->base);
 	printk(KERN_DEBUG "%s: %s -s -p %s -m %s\n", bc_drvname, eppconfig_path, portarg, modearg);
 
-	i = exec_usermodehelper(eppconfig_path, argv, envp);
+	i = call_usermodehelper(eppconfig_path, argv, envp, &umh_c);
 	if (i < 0) {
                 printk(KERN_ERR "%s: failed to exec %s -s -p %s -m %s, errno = %d\n",
                        bc_drvname, eppconfig_path, portarg, modearg, i);
                 return i;
         }
         return 0;
-}
-
-
-/* eppconfig: called during ifconfig up to configure the modem */
-
-static int eppconfig(struct baycom_state *bc)
-{
-        int i, pid, r;
-	mm_segment_t fs;
-
-        pid = kernel_thread(exec_eppfpga, bc, CLONE_FS);
-        if (pid < 0) {
-                printk(KERN_ERR "%s: fork failed, errno %d\n", bc_drvname, -pid);
-                return pid;
-        }
-	fs = get_fs();
-        set_fs(KERNEL_DS);      /* Allow i to be in kernel space. */
-	r = waitpid(pid, &i, __WCLONE);
-	set_fs(fs);
-        if (r != pid) {
-                printk(KERN_ERR "%s: waitpid(%d) failed, returning %d\n",
-		       bc_drvname, pid, r);
-		return -1;
-        }
-	printk(KERN_DEBUG "%s: eppfpga returned %d\n", bc_drvname, i);
-	return i;
 }
 
 /* ---------------------------------------------------------------------- */
--- linux-2.4.0-test13-pre2/net/core/dev.c	Sat Dec 16 23:59:51 2000
+++ linux-akpm/net/core/dev.c	Sun Dec 17 22:51:29 2000
@@ -2746,13 +2746,10 @@
         argv[i] = 0;
 
 	i = 0;
-	/* minimal command environment */
-	envp [i++] = "HOME=/";
-	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	envp [i++] = ifname;
 	envp [i++] = action_str;
 	envp [i] = 0;
 	
-	return call_usermodehelper(argv [0], argv, envp);
+	return call_usermodehelper(argv [0], argv, envp, 0);
 }
 #endif
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
