Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUIETnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUIETnh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 15:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUIETnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 15:43:37 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:1897 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266914AbUIETmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 15:42:21 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] uml-patch-2.6.7-2
Date: Sun, 5 Sep 2004 17:35:36 +0200
User-Agent: KMail/1.6.1
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
In-Reply-To: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408251746.53523.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IJzOBnp4suHb3Hq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_IJzOBnp4suHb3Hq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 05:00, gioved=EC 19 agosto 2004, Jeff Dike ha scritto:
> I've released a second 2.6.7 UML patch.  This is to push out the changes I
> have in order to give me a clean slate for the 2.6.8.1 UML.

About the patch (and even the 2.6.8.1-1 one), there are two problems:
* First, please do a "make clean" before releasing the patch. There are som=
e=20
binaries included in it! And also semaphore.c, which is a symlink normally.

* Second, why do you disable module support when compiling it, or anyhow ho=
w=20
could you succeed to build it? Starting from this patch (this bug is not=20
there in 2.6.7-1, and remains in 2.6.8.1-1) we have this line twice:

EXPORT_SYMBOL(os_ioctl_generic);

So it did not compile for me (I patched it, obviously). Patch attached -=20
uml-dup-sym.

Also, you must still export a tons of symbols, plus make hostfs depend on=20
externfs. Also, to avoid linking against libgcc_s.so and exporting some of=
=20
its symbols, which change, I made use of do_div for 64-bit division. For=20
this, see uml-export-Symbols.patch. It's only for 2.6 - for 2.4 it's a bit=
=20
more complex (a module export all its symbols in 2.4, but if you link=20
statically the code you must export the symbol by hand inside an EXPORT_OBJ=
;=20
and if you export a missing symbol you get a link time failure).

Btw, about the ->statfs op: you are missing some unsigned-ness for some=20
params, since sector_t, used in kstatfs, is unsigned. Do you want them fixe=
d?

* About filehandle_switch: you deleted a line (probably by mistake). Reread=
=20
more carefully the separate patches you get with quilt: when you see the=20
other attached patch (uml-restore-lost-code.patch), you'll agree with me.

Also, what you say about the patch is not correct: filehandle_switch has=20
almost just a cosmetic effect (there is a change from os_open_file to=20
open_file for new_mm mode, and nothing else). I've attached the 2.4.26-2 pa=
rt=20
which is more actually the filehandle_switch part (it's not a perfect one, =
it=20
contains some unrelated changes, but anyway you can fix it).

However, IMHO, since you cannot close and reopen a pipe, it's braindead tha=
t=20
the switch_pipe[] array is an array of filehandles. You must obviously use=
=20
the make_pipe() API to call reclaim_fds() if needed, but making it return=20
filehandles is useless. They are never added onto the list, also, so they=20
never become reclaimable. But about the filehandle abstraction, I have a lo=
t=20
of doubts, for which I'll write a separate mail. I like the idea, but not t=
he=20
current implementation.
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729










--Boundary-00=_IJzOBnp4suHb3Hq
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-dup-sym.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="uml-dup-sym.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.7-paolo/arch/um/kernel/ksyms.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN arch/um/kernel/ksyms.c~uml-dup-sym arch/um/kernel/ksyms.c
--- uml-linux-2.6.7/arch/um/kernel/ksyms.c~uml-dup-sym	2004-08-24 19:19:38.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/ksyms.c	2004-08-24 19:19:51.000000000 +0200
@@ -73,7 +73,6 @@ EXPORT_SYMBOL(os_read_file);
 EXPORT_SYMBOL(os_write_file);
 EXPORT_SYMBOL(os_seek_file);
 EXPORT_SYMBOL(os_lock_file);
-EXPORT_SYMBOL(os_ioctl_generic);
 EXPORT_SYMBOL(os_pipe);
 EXPORT_SYMBOL(os_file_type);
 EXPORT_SYMBOL(os_file_mode);
_

--Boundary-00=_IJzOBnp4suHb3Hq
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-restore-lost-code.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="uml-restore-lost-code.patch"


This line of code was unbelievably lost somehow in the "filehandle_switch" patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.7-paolo/arch/um/kernel/smp.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN arch/um/kernel/smp.c~uml-restore-lost-code arch/um/kernel/smp.c
--- uml-linux-2.6.7/arch/um/kernel/smp.c~uml-restore-lost-code	2004-08-25 16:33:28.274244752 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/smp.c	2004-08-25 16:33:28.276244448 +0200
@@ -119,6 +119,7 @@ static struct task_struct *idle_thread(i
 	idle_threads[cpu] = new_task;
 	CHOOSE_MODE(os_write_file(new_task->thread.mode.tt.switch_pipe[1], &c, 
 				  sizeof(c)),
+			({ panic("skas mode doesn't support SMP"); }));
 	wake_up_forked_process(new_task);
 	return(new_task);
 }
_

--Boundary-00=_IJzOBnp4suHb3Hq
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="filehandle-expand-and-use-for-tt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="filehandle-expand-and-use-for-tt.patch"

diff -u um/arch/um/include/filehandle.h um/arch/um/include/filehandle.h
--- um/arch/um/include/filehandle.h	2004-05-06 22:10:45.000000000 -0400
+++ um/arch/um/include/filehandle.h	2004-07-16 10:58:27.000000000 -0400
@@ -21,6 +21,7 @@
 extern struct file_handle bad_filehandle;
 
 extern int open_file(char *name, struct openflags flags, int mode);
+extern void *open_dir(char *file);
 extern int open_filehandle(char *name, struct openflags flags, int mode, 
 			   struct file_handle *fh);
 extern int read_file(struct file_handle *fh, unsigned long long offset, 
@@ -34,6 +35,7 @@
 			   char *(name_proc)(struct inode *),
 			   struct inode *inode);
 extern int filehandle_fd(struct file_handle *fh);
+extern int make_pipe(struct file_handle *fhs);
 
 #endif
 
diff -u um/arch/um/include/os.h um/arch/um/include/os.h
--- um/arch/um/include/os.h	2004-04-28 03:33:40.000000000 -0400
+++ um/arch/um/include/os.h	2004-06-29 08:42:03.000000000 -0400
@@ -175,7 +175,7 @@
 extern int os_link_file(const char *to, const char *from);
 extern int os_make_dir(const char *dir, int mode);
 extern int os_remove_dir(const char *dir);
-extern int os_make_dev(const char *name, int mode, int dev);
+extern int os_make_dev(const char *name, int mode, int major, int minor);
 extern int os_shutdown_socket(int fd, int r, int w);
 extern void os_close_file(int fd);
 extern int os_rcv_fd(int fd, int *helper_pid_out);
diff -u um/arch/um/include/user_util.h um/arch/um/include/user_util.h
--- um/arch/um/include/user_util.h	2004-03-02 07:51:02.000000000 -0500
+++ um/arch/um/include/user_util.h	2004-06-30 22:33:58.000000000 -0400
@@ -73,7 +73,6 @@
 extern void tracer_panic(char *msg, ...);
 extern char *get_umid(int only_if_set);
 extern void do_longjmp(void *p, int val);
-extern void suspend_new_thread(int fd);
 extern int detach(int pid, int sig);
 extern int attach(int pid);
 extern void kill_child_dead(int pid);
diff -u um/arch/um/kernel/filehandle.c um/arch/um/kernel/filehandle.c
--- um/arch/um/kernel/filehandle.c	2004-05-08 19:56:34.000000000 -0400
+++ um/arch/um/kernel/filehandle.c	2004-07-16 10:49:54.000000000 -0400
@@ -46,6 +46,26 @@
 	return(fd);
 }
 
+void *open_dir(char *file)
+{
+	void *dir;
+	int err;
+
+	dir = os_open_dir(file, &err);
+	if(dir != NULL)
+		return(dir);
+	if(err != -EMFILE)
+		return(ERR_PTR(err));
+
+	reclaim_fds();
+
+	dir = os_open_dir(file, &err);
+	if(dir == NULL)
+		dir = ERR_PTR(err);
+
+	return(dir);
+}
+
 void not_reclaimable(struct file_handle *fh)
 {
 	char *name;
@@ -103,6 +123,7 @@
 		return(fd);
 
 	fh->fd = fd;
+	is_reclaimable(fh, fh->get_name, fh->inode);
 
 	return(0);
 }
@@ -118,6 +139,16 @@
 	return(fh->fd);
 }
 
+static void init_fh(struct file_handle *fh, int fd, struct openflags flags)
+{
+	flags.c = 0;
+	*fh = ((struct file_handle) { .list	= LIST_HEAD_INIT(fh->list),
+				      .fd	= fd,
+				      .get_name	= NULL,
+				      .inode	= NULL,
+				      .flags	= flags });
+}
+
 int open_filehandle(char *name, struct openflags flags, int mode, 
 		    struct file_handle *fh)
 {
@@ -127,13 +158,7 @@
 	if(fd < 0)
 		return(fd);
 
-	flags.c = 0;
-	*fh = ((struct file_handle) { .list	= LIST_HEAD_INIT(fh->list),
-				      .fd	= fd,
-				      .get_name	= NULL,
-				      .inode	= NULL,
-				      .flags	= flags });
-
+	init_fh(fh, fd, flags);
 	return(0);
 }
 
@@ -174,7 +199,8 @@
 	if(err)
 		return(err);
 
-	err = os_seek_file(fh->fd, offset);
+	if(offset != -1)
+		err = os_seek_file(fh->fd, offset);
 	if(err)
 		return(err);
 
@@ -192,6 +218,26 @@
 	return(os_truncate_fd(fh->fd, size));
 }
 
+int make_pipe(struct file_handle *fhs)
+{
+	int fds[2], err;
+
+	err = os_pipe(fds, 1, 1);
+	if(err && (err != -EMFILE))
+		return(err);
+
+	if(err){
+		reclaim_fds();
+		err = os_pipe(fds, 1, 1);
+	}
+	if(err)
+		return(err);
+
+	init_fh(&fhs[0], fds[0], OPENFLAGS());
+	init_fh(&fhs[1], fds[1], OPENFLAGS());
+	return(0);
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -u um/arch/um/kernel/process.c um/arch/um/kernel/process.c
--- um/arch/um/kernel/process.c	2004-04-05 20:01:08.000000000 -0400
+++ um/arch/um/kernel/process.c	2004-06-30 22:33:15.000000000 -0400
@@ -130,16 +130,6 @@
 	return(arg.pid);
 }
 
-void suspend_new_thread(int fd)
-{
-	char c;
-
-	os_stop_process(os_getpid());
-
-	if(os_read_file(fd, &c, sizeof(c)) != sizeof(c))
-		panic("read failed in suspend_new_thread");
-}
-
 static int ptrace_child(void *arg)
 {
 	int pid = os_getpid();
diff -u um/arch/um/kernel/smp.c um/arch/um/kernel/smp.c
--- um/arch/um/kernel/smp.c	2003-11-15 02:59:25.000000000 -0500
+++ um/arch/um/kernel/smp.c	2004-07-13 15:23:07.000000000 -0400
@@ -168,8 +168,9 @@
 	new_task->processor = cpu;
 	new_task->cpus_allowed = 1 << cpu;
 	new_task->cpus_runnable = new_task->cpus_allowed;
-	CHOOSE_MODE(os_write_file(new_task->thread.mode.tt.switch_pipe[1], &c, 
-			  sizeof(c)),
+	CHOOSE_MODE(({ struct file_handle *pipe;
+	               pipe = new_task->thread.mode.tt.switch_pipe;
+		       write_file(&pipe[1], -1, &c, sizeof(c)); }),
 		    ({ panic("skas mode doesn't support SMP"); }));
 	return(new_task->thread.mode.tt.extern_pid);
 }
diff -u um/arch/um/kernel/tt/process_kern.c um/arch/um/kernel/tt/process_kern.c
--- um/arch/um/kernel/tt/process_kern.c	2004-04-04 19:15:42.000000000 -0400
+++ um/arch/um/kernel/tt/process_kern.c	2004-07-14 18:38:31.000000000 -0400
@@ -6,6 +6,7 @@
 #include "linux/sched.h"
 #include "linux/signal.h"
 #include "linux/kernel.h"
+#include "linux/slab.h"
 #include "asm/system.h"
 #include "asm/pgalloc.h"
 #include "asm/ptrace.h"
@@ -22,10 +23,12 @@
 #include "mode.h"
 #include "init.h"
 #include "tt.h"
+#include "filehandle.h"
 
 void *_switch_to_tt(void *prev, void *next)
 {
 	struct task_struct *from, *to;
+	struct file_handle *pipe;
 	unsigned long flags;
 	int err, vtalrm, alrm, prof, cpu;
 	char c;
@@ -55,7 +58,8 @@
 	set_current(to);
 
 	reading = 0;
-	err = os_write_file(to->thread.mode.tt.switch_pipe[1], &c, sizeof(c));
+	pipe = to->thread.mode.tt.switch_pipe;
+	err = write_file(&pipe[1], -1, &c, sizeof(c));
 	if(err != sizeof(c))
 		panic("write of switch_pipe failed, err = %d", -err);
 
@@ -63,7 +67,8 @@
 	if(from->state == TASK_ZOMBIE)
 		os_kill_process(os_getpid(), 0);
 
-	err = os_read_file(from->thread.mode.tt.switch_pipe[0], &c, sizeof(c));
+	pipe = from->thread.mode.tt.switch_pipe;
+	err = read_file(&pipe[0], -1, &c, sizeof(c));
 	if(err != sizeof(c))
 		panic("read of switch_pipe failed, errno = %d", -err);
 
@@ -104,14 +109,28 @@
 
 void exit_thread_tt(void)
 {
-	os_close_file(current->thread.mode.tt.switch_pipe[0]);
-	os_close_file(current->thread.mode.tt.switch_pipe[1]);
+	struct file_handle *pipe = current->thread.mode.tt.switch_pipe;
+
+	close_file(&pipe[0]);
+	close_file(&pipe[1]);
+	kfree(pipe);
+}
+
+static void suspend_new_thread(struct file_handle *fh)
+{
+	char c;
+
+	os_stop_process(os_getpid());
+
+	if(read_file(fh, -1, &c, sizeof(c)) != sizeof(c))
+		panic("read failed in suspend_new_thread");
 }
 
 extern void schedule_tail(struct task_struct *prev);
 
 static void new_thread_handler(int sig)
 {
+	struct file_handle *pipe;
 	unsigned long disable;
 	int (*fn)(void *);
 	void *arg;
@@ -124,7 +143,8 @@
 		(1 << (SIGIO - 1)) | (1 << (SIGPROF - 1));
 	SC_SIGMASK(UPT_SC(&current->thread.regs.regs)) &= ~disable;
 
-	suspend_new_thread(current->thread.mode.tt.switch_pipe[0]);
+	pipe = current->thread.mode.tt.switch_pipe;
+	suspend_new_thread(&pipe[0]);
 
 	init_new_thread_signals(1);
 	enable_timer();
@@ -183,8 +203,10 @@
 
 static void finish_fork_handler(int sig)
 {
+	struct file_handle *pipe = current->thread.mode.tt.switch_pipe;
+
 	UPT_SC(&current->thread.regs.regs) = (void *) (&sig + 1);
-	suspend_new_thread(current->thread.mode.tt.switch_pipe[0]);
+	suspend_new_thread(&pipe[0]);
 	
 	init_new_thread_signals(1);
 	enable_timer();
@@ -215,6 +237,30 @@
 	return(0);
 }
 
+struct file_handle *make_switch_pipe(void)
+{
+	struct file_handle *pipe;
+	int err;
+
+	pipe = kmalloc(sizeof(struct file_handle [2]), GFP_KERNEL);
+	if(pipe == NULL){
+		pipe = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	err = make_pipe(pipe);
+	if(err)
+		goto out_free;
+
+ out:
+	return(pipe);
+
+ out_free:
+	kfree(pipe);
+	pipe = ERR_PTR(err);
+	goto out;
+}
+
 int copy_thread_tt(int nr, unsigned long clone_flags, unsigned long sp,
 		   unsigned long stack_top, struct task_struct * p, 
 		   struct pt_regs *regs)
@@ -230,17 +276,18 @@
 		p->thread.request.u.thread = current->thread.request.u.thread;
 	}
 
-	err = os_pipe(p->thread.mode.tt.switch_pipe, 1, 1);
-	if(err < 0){
-		printk("copy_thread : pipe failed, err = %d\n", -err);
-		return(err);
+	p->thread.mode.tt.switch_pipe = make_switch_pipe();
+	if(IS_ERR(p->thread.mode.tt.switch_pipe)){
+		err = PTR_ERR(p->thread.mode.tt.switch_pipe);
+		goto out;
 	}
 
 	stack = alloc_stack(0, 0);
 	if(stack == 0){
 		printk(KERN_ERR "copy_thread : failed to allocate "
 		       "temporary stack\n");
-		return(-ENOMEM);
+		err = -ENOMEM;
+		goto out_close;
 	}
 
 	clone_flags &= CLONE_VM;
@@ -250,7 +297,8 @@
 	if(new_pid < 0){
 		printk(KERN_ERR "copy_thread : clone failed - errno = %d\n", 
 		       -new_pid);
-		return(new_pid);
+		err = new_pid;
+		goto out_stack;
 	}
 
 	if(current->thread.forking){
@@ -264,10 +312,25 @@
 	current->thread.request.op = OP_FORK;
 	current->thread.request.u.fork.pid = new_pid;
 	os_usr1_process(os_getpid());
+
+	/* Enable the signal and then disable it to ensure that it is handled
+	 * here, and nowhere else.
+	 */
 	change_sig(SIGUSR1, 1);
 
 	change_sig(SIGUSR1, 0);
-	return(0);
+	err = 0;
+
+ out:
+	return(err);
+
+ out_stack:
+	free_stack(stack, 0);
+ out_close:
+	close_file(&((struct file_handle *) p->thread.mode.tt.switch_pipe)[0]);
+	close_file(&((struct file_handle *) p->thread.mode.tt.switch_pipe)[1]);
+	kfree(p->thread.mode.tt.switch_pipe);
+	goto out;
 }
 
 void reboot_tt(void)
@@ -476,15 +539,22 @@
 	return(0);
 }
 
+/* This is static rather than kmalloced because this happens before kmalloc
+ * is initialized.  Also, it is always needed, so might as well be static on
+ * this ground.
+ */
+static struct file_handle init_switch_pipe[2];
+
 void set_init_pid(int pid)
 {
 	int err;
 
 	init_task.thread.mode.tt.extern_pid = pid;
-	err = os_pipe(init_task.thread.mode.tt.switch_pipe, 1, 1);
-	if(err)	
-		panic("Can't create switch pipe for init_task, errno = %d", 
-		      -err);
+
+	err = make_pipe(init_switch_pipe);
+	if(err)
+		panic("set_init_pid - make_pipe failed, errno = %d", err);
+	init_task.thread.mode.tt.switch_pipe = init_switch_pipe;
 }
 
 int singlestepping_tt(void *t)
diff -u um/arch/um/os-Linux/file.c um/arch/um/os-Linux/file.c
--- um/arch/um/os-Linux/file.c	2004-05-08 19:56:16.000000000 -0400
+++ um/arch/um/os-Linux/file.c	2004-07-16 11:15:52.000000000 -0400
@@ -10,6 +10,7 @@
 #include <signal.h>
 #include <utime.h>
 #include <dirent.h>
+#include <linux/kdev_t.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/socket.h>
@@ -244,7 +245,8 @@
 
 	if((fcntl(master, F_SETFL, flags | O_NONBLOCK | O_ASYNC) < 0) ||
 	   (fcntl(master, F_SETOWN, os_getpid()) < 0)){
-		printk("fcntl F_SETFL or F_SETOWN failed, errno = %d\n", errno);
+		printk("fcntl F_SETFL or F_SETOWN failed, errno = %d\n", 
+		       errno);
 		return(-errno);
 	}
 
@@ -341,7 +343,7 @@
 	void *dir;
 
 	dir = opendir(path);
-	*err_out = errno;
+	*err_out = -errno;
 	return(dir);
 }
 
@@ -841,11 +843,11 @@
 	return(0);
 }
 
-int os_make_dev(const char *name, int mode, int dev)
+int os_make_dev(const char *name, int mode, int major, int minor)
 {
 	int err;
 
-	err = mknod(name, mode, dev);
+	err = mknod(name, mode, MKDEV(major, minor));
 	if(err)
 		return(-errno);
 
diff -u um/arch/um/os-Linux/process.c um/arch/um/os-Linux/process.c
--- um/arch/um/os-Linux/process.c	2004-01-10 06:53:44.000000000 -0500
+++ um/arch/um/os-Linux/process.c	2004-07-13 14:03:32.000000000 -0400
@@ -15,9 +15,12 @@
 #define ARBITRARY_ADDR -1
 #define FAILURE_PID    -1
 
+#define STAT_PATH_LEN sizeof("/proc/#######/stat\0")
+#define COMM_SCANF "%*[^)])"
+
 unsigned long os_process_pc(int pid)
 {
-	char proc_stat[sizeof("/proc/#####/stat\0")], buf[256];
+	char proc_stat[STAT_PATH_LEN], buf[256];
 	unsigned long pc;
 	int fd, err;
 
@@ -37,9 +40,9 @@
 	}
 	os_close_file(fd);
 	pc = ARBITRARY_ADDR;
-	if(sscanf(buf, "%*d %*s %*c %*d %*d %*d %*d %*d %*d %*d %*d "
+	if(sscanf(buf, "%*d " COMM_SCANF " %*c %*d %*d %*d %*d %*d %*d %*d "
 		  "%*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d "
-		  "%*d %*d %*d %*d %ld", &pc) != 1){
+		  "%*d %*d %*d %*d %*d %lu", &pc) != 1){
 		printk("os_process_pc - couldn't find pc in '%s'\n", buf);
 	}
 	return(pc);
@@ -47,7 +50,7 @@
 
 int os_process_parent(int pid)
 {
-	char stat[sizeof("/proc/nnnnn/stat\0")];
+	char stat[STAT_PATH_LEN];
 	char data[256];
 	int parent, n, fd;
 
@@ -69,8 +72,7 @@
 	}
 
 	parent = FAILURE_PID;
-	/* XXX This will break if there is a space in the command */
-	n = sscanf(data, "%*d %*s %*c %d", &parent);
+	n = sscanf(data, "%*d " COMM_SCANF " %*c %d", &parent);
 	if(n != 1) 
 		printk("Failed to scan '%s'\n", data);
 
diff -u um/include/asm-um/processor-generic.h um/include/asm-um/processor-generic.h
--- um/include/asm-um/processor-generic.h	2004-05-11 18:18:07.000000000 -0400
+++ um/include/asm-um/processor-generic.h	2004-07-13 15:05:30.000000000 -0400
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2000 - 2004 Jeff Dike (jdike@addtoit.com)
  * Licensed under the GPL
  */
 
@@ -41,7 +41,14 @@
 		struct {
 			int extern_pid;
 			int tracing;
-			int switch_pipe[2];
+			/* XXX This is really two filehandles, but they contain
+			 * lists, and list.h includes processor.h through
+			 * prefetch.h before defining struct list, so this
+			 * makes the lists' sizes unknown at this point.
+			 * So, this is a void *, and allocated separately.
+			 * Check to see if this is fixed in 2.6.
+			 */
+			void *switch_pipe;
 			int singlestep_syscall;
 			int vm_seq;
 		} tt;

--Boundary-00=_IJzOBnp4suHb3Hq
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-export-Symbols.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-export-Symbols.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.7-paolo/arch/um/Kconfig             |    1 
 uml-linux-2.6.7-paolo/arch/um/kernel/filehandle.c |   10 ++++++++
 uml-linux-2.6.7-paolo/arch/um/kernel/irq.c        |    2 +
 uml-linux-2.6.7-paolo/arch/um/kernel/ksyms.c      |   26 +++++++++++++++++++++-
 uml-linux-2.6.7-paolo/arch/um/kernel/physmem.c    |    5 ++++
 uml-linux-2.6.7-paolo/fs/hostfs/externfs.c        |    7 +++++
 uml-linux-2.6.7-paolo/fs/hostfs/host_file.c       |   20 ++++++++++++++++
 uml-linux-2.6.7-paolo/fs/hostfs/host_fs.c         |    7 +----
 uml-linux-2.6.7-paolo/fs/hostfs/humfs.c           |   21 +++++++++++++----
 uml-linux-2.6.7-paolo/fs/hostfs/meta_fs.c         |    5 ++--
 10 files changed, 91 insertions(+), 13 deletions(-)

diff -puN arch/um/kernel/ksyms.c~uml-export-Symbols arch/um/kernel/ksyms.c
--- uml-linux-2.6.7/arch/um/kernel/ksyms.c~uml-export-Symbols	2004-08-26 22:35:34.435732872 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/ksyms.c	2004-08-26 22:35:34.467728008 +0200
@@ -21,6 +21,7 @@
 #include "user_util.h"
 #include "mem_user.h"
 #include "os.h"
+#include "aio.h"
 #include "helper.h"
 
 EXPORT_SYMBOL(stop);
@@ -48,6 +49,7 @@ EXPORT_SYMBOL(to_virt);
 EXPORT_SYMBOL(mode_tt);
 EXPORT_SYMBOL(handle_page_fault);
 EXPORT_SYMBOL(find_iomem);
+EXPORT_SYMBOL(uml_strdup);
 
 #ifdef CONFIG_MODE_TT
 EXPORT_SYMBOL(strncpy_from_user_tt);
@@ -81,16 +83,38 @@ EXPORT_SYMBOL(os_flush_stdout);
 EXPORT_SYMBOL(os_close_file);
 EXPORT_SYMBOL(os_set_fd_async);
 EXPORT_SYMBOL(os_set_fd_block);
-EXPORT_SYMBOL(helper_wait);
+EXPORT_SYMBOL(os_remove_dir);
+EXPORT_SYMBOL(os_remove_file);
 EXPORT_SYMBOL(os_shutdown_socket);
 EXPORT_SYMBOL(os_create_unix_socket);
 EXPORT_SYMBOL(os_connect_socket);
 EXPORT_SYMBOL(os_accept_connection);
 EXPORT_SYMBOL(os_ioctl_generic);
 EXPORT_SYMBOL(os_rcv_fd);
+EXPORT_SYMBOL(os_truncate_fd);
+EXPORT_SYMBOL(os_fd_size);
+EXPORT_SYMBOL(os_close_dir);
+EXPORT_SYMBOL(os_make_dev);
+EXPORT_SYMBOL(os_stat_filesystem);
+EXPORT_SYMBOL(os_move_file);
+EXPORT_SYMBOL(os_read_symlink);
+EXPORT_SYMBOL(os_link_file);
+EXPORT_SYMBOL(os_make_dir);
+EXPORT_SYMBOL(os_make_symlink);
+EXPORT_SYMBOL(os_set_file_time);
+EXPORT_SYMBOL(os_truncate_file);
+EXPORT_SYMBOL(os_set_file_owner);
+EXPORT_SYMBOL(os_set_file_perms);
+EXPORT_SYMBOL(os_lstat_file);
+EXPORT_SYMBOL(os_tell_dir);
+EXPORT_SYMBOL(os_read_dir);
+EXPORT_SYMBOL(os_seek_dir);
+EXPORT_SYMBOL(submit_aio);
+
 EXPORT_SYMBOL(run_helper);
 EXPORT_SYMBOL(start_thread);
 EXPORT_SYMBOL(dump_thread);
+EXPORT_SYMBOL(helper_wait);
 
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
diff -puN arch/um/os-Linux/user_syms.c~uml-export-Symbols arch/um/os-Linux/user_syms.c
diff -puN arch/um/os-Linux/aio.c~uml-export-Symbols arch/um/os-Linux/aio.c
diff -puN arch/um/kernel/irq.c~uml-export-Symbols arch/um/kernel/irq.c
--- uml-linux-2.6.7/arch/um/kernel/irq.c~uml-export-Symbols	2004-08-26 22:35:34.438732416 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/irq.c	2004-08-26 22:35:34.467728008 +0200
@@ -437,6 +437,8 @@ int um_request_irq(unsigned int irq, int
 		err = activate_fd(irq, fd, type, dev_id);
 	return(err);
 }
+EXPORT_SYMBOL(um_request_irq);
+EXPORT_SYMBOL(reactivate_fd);
 
 /* this was setup_x86_irq but it seems pretty generic */
 int setup_irq(unsigned int irq, struct irqaction * new)
diff -puN arch/um/kernel/physmem.c~uml-export-Symbols arch/um/kernel/physmem.c
--- uml-linux-2.6.7/arch/um/kernel/physmem.c~uml-export-Symbols	2004-08-26 22:35:34.439732264 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/physmem.c	2004-08-26 22:35:34.468727856 +0200
@@ -8,6 +8,7 @@
 #include "linux/slab.h"
 #include "linux/vmalloc.h"
 #include "linux/bootmem.h"
+#include "linux/module.h"
 #include "asm/types.h"
 #include "asm/pgtable.h"
 #include "kern_util.h"
@@ -229,6 +230,10 @@ void physmem_forget_descriptor(int fd)
 	kfree(desc);
 }
 
+EXPORT_SYMBOL(physmem_forget_descriptor);
+EXPORT_SYMBOL(physmem_remove_mapping);
+EXPORT_SYMBOL(physmem_subst_mapping);
+
 void arch_free_page(struct page *page, int order)
 {
 	void *virt;
diff -puN fs/hostfs/externfs.c~uml-export-Symbols fs/hostfs/externfs.c
--- uml-linux-2.6.7/fs/hostfs/externfs.c~uml-export-Symbols	2004-08-26 22:35:34.440732112 +0200
+++ uml-linux-2.6.7-paolo/fs/hostfs/externfs.c	2004-08-26 22:35:34.468727856 +0200
@@ -1190,6 +1190,7 @@ char *host_root_filename(char *mount_arg
 
 	return(uml_strdup(root));
 }
+EXPORT_SYMBOL(host_root_filename);
 
 static int externfs_fill_sb(struct super_block *sb, void *data, int silent)
 {
@@ -1286,6 +1287,7 @@ int register_externfs(char *name, struct
  out:
 	return(err);
 }
+EXPORT_SYMBOL(register_externfs);
 
 void unregister_externfs(char *name)
 {
@@ -1304,6 +1306,11 @@ void unregister_externfs(char *name)
 	up(&externfs_sem);
 	printk("Unregister_externfs - filesystem '%s' not found\n", name);
 }
+EXPORT_SYMBOL(unregister_externfs);
+
+EXPORT_SYMBOL(init_externfs);
+EXPORT_SYMBOL(inode_externfs_info);
+EXPORT_SYMBOL(inode_name_prefix);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN fs/hostfs/humfs.c~uml-export-Symbols fs/hostfs/humfs.c
--- uml-linux-2.6.7/fs/hostfs/humfs.c~uml-export-Symbols	2004-08-26 22:35:34.441731960 +0200
+++ uml-linux-2.6.7-paolo/fs/hostfs/humfs.c	2004-08-26 22:35:34.469727704 +0200
@@ -12,9 +12,11 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/kdev_t.h>
+#include <linux/module.h>
 #include "linux/init.h"
 #include "linux/workqueue.h"
 #include <asm/irq.h>
+#include <asm/div64.h>
 #include "hostfs.h"
 #include "mem.h"
 #include "os.h"
@@ -320,8 +322,6 @@ static int init_humfs_aio(void)
 	return(0);
 }
 
-__initcall(init_humfs_aio);
-
 static int humfs_aio(enum aio_type type, int fd, unsigned long long offset,
 		     char *buf, int len, int real_len,
 		     void (*completion)(char *, int, void *), void *arg)
@@ -669,6 +669,7 @@ struct humfs *inode_humfs_info(struct in
 {
 	return(container_of(inode_externfs_info(inode), struct humfs, ext));
 }
+EXPORT_SYMBOL(inode_humfs_info);
 
 static int humfs_rename_file(char *from, char *to, struct externfs_data *ed)
 {
@@ -705,9 +706,16 @@ static int humfs_stat_fs(long *bsize_out
 	if(err)
 		return(err);
 
+#if 0
 	*blocks_out = mount->total / *bsize_out;
 	*bfree_out = (mount->total - mount->used) / *bsize_out;
-	*bavail_out = (mount->total - mount->used) / *bsize_out;
+#endif
+	*blocks_out = mount->total;
+	*bfree_out = (mount->total - mount->used);
+	do_div(blocks_out, *bsize_out);
+	do_div(bfree_out, *bsize_out);
+
+	*bavail_out = *bfree_out;
 	return(0);
 }
 
@@ -766,6 +774,7 @@ void register_meta(struct humfs_meta_ops
 	list_add(&ops->list, &metas);
 	up(&meta_sem);
 }
+EXPORT_SYMBOL(register_meta);
  
 void unregister_meta(struct humfs_meta_ops *ops)
 {
@@ -773,6 +782,7 @@ void unregister_meta(struct humfs_meta_o
 	list_del(&ops->list);
 	up(&meta_sem);
 }
+EXPORT_SYMBOL(unregister_meta);
  
 static struct humfs *read_superblock(char *root)
 {
@@ -1003,6 +1013,7 @@ struct externfs_mount_ops humfs_mount_op
 
 static int __init init_humfs(void)
 {
+	init_humfs_aio();
 	return(register_externfs("humfs", &humfs_mount_ops));
 }
 
@@ -1011,8 +1022,8 @@ static void __exit exit_humfs(void)
 	unregister_externfs("humfs");
 }
 
-__initcall(init_humfs);
-__exitcall(exit_humfs);
+module_init(init_humfs);
+module_exit(exit_humfs);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN fs/hostfs/host_file.c~uml-export-Symbols fs/hostfs/host_file.c
--- uml-linux-2.6.7/fs/hostfs/host_file.c~uml-export-Symbols	2004-08-26 22:35:34.442731808 +0200
+++ uml-linux-2.6.7-paolo/fs/hostfs/host_file.c	2004-08-26 22:35:34.469727704 +0200
@@ -9,6 +9,7 @@
 #include "linux/types.h"
 #include "linux/slab.h"
 #include "linux/fs.h"
+#include "linux/module.h"
 #include "asm/fcntl.h"
 #include "hostfs.h"
 #include "filehandle.h"
@@ -430,6 +431,25 @@ int generic_host_truncate_file(struct fi
 	return(truncate_file(fh, size));
 }
 
+EXPORT_SYMBOL(free_path);
+EXPORT_SYMBOL(generic_host_read_dir);
+EXPORT_SYMBOL(get_path);
+EXPORT_SYMBOL(host_create_file);
+EXPORT_SYMBOL(host_file_type);
+EXPORT_SYMBOL(host_link_file);
+EXPORT_SYMBOL(host_make_dir);
+EXPORT_SYMBOL(host_make_symlink);
+EXPORT_SYMBOL(host_open_dir);
+EXPORT_SYMBOL(host_open_file);
+EXPORT_SYMBOL(host_read_link);
+EXPORT_SYMBOL(host_remove_dir);
+EXPORT_SYMBOL(host_rename_file);
+EXPORT_SYMBOL(host_root_filename);
+EXPORT_SYMBOL(host_set_attr);
+EXPORT_SYMBOL(host_stat_file);
+EXPORT_SYMBOL(host_stat_fs);
+EXPORT_SYMBOL(host_unlink_file);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -puN arch/um/kernel/filehandle.c~uml-export-Symbols arch/um/kernel/filehandle.c
--- uml-linux-2.6.7/arch/um/kernel/filehandle.c~uml-export-Symbols	2004-08-26 22:35:34.443731656 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/filehandle.c	2004-08-26 22:35:34.470727552 +0200
@@ -8,6 +8,7 @@
 #include "linux/spinlock.h"
 #include "linux/fs.h"
 #include "linux/errno.h"
+#include "linux/module.h"
 #include "filehandle.h"
 #include "os.h"
 #include "kern_util.h"
@@ -65,6 +66,7 @@ void *open_dir(char *file)
 
 	return(dir);
 }
+EXPORT_SYMBOL(open_dir);
 
 void not_reclaimable(struct file_handle *fh)
 {
@@ -87,6 +89,7 @@ void not_reclaimable(struct file_handle 
 		spin_unlock(&open_files_lock);
 	}
 }
+EXPORT_SYMBOL(not_reclaimable);
 
 void is_reclaimable(struct file_handle *fh, char *(name_proc)(struct inode *),
 		    struct inode *inode)
@@ -98,6 +101,7 @@ void is_reclaimable(struct file_handle *
 	list_add(&fh->list, &open_files);
 	spin_unlock(&open_files_lock);
 }
+EXPORT_SYMBOL(is_reclaimable);
 
 static int active_handle(struct file_handle *fh)
 {
@@ -138,6 +142,7 @@ int filehandle_fd(struct file_handle *fh
 
 	return(fh->fd);
 }
+EXPORT_SYMBOL(filehandle_fd);
 
 static void init_fh(struct file_handle *fh, int fd, struct openflags flags)
 {
@@ -161,6 +166,7 @@ int open_filehandle(char *name, struct o
 	init_fh(fh, fd, flags);
 	return(0);
 }
+EXPORT_SYMBOL(open_filehandle);
 
 int close_file(struct file_handle *fh)
 {
@@ -173,6 +179,7 @@ int close_file(struct file_handle *fh)
 	fh->fd = -1;
 	return(0);
 }
+EXPORT_SYMBOL(close_file);
 
 int read_file(struct file_handle *fh, unsigned long long offset, char *buf,
 	      int len)
@@ -189,6 +196,7 @@ int read_file(struct file_handle *fh, un
 
 	return(os_read_file(fh->fd, buf, len));
 }
+EXPORT_SYMBOL(read_file);
 
 int write_file(struct file_handle *fh, unsigned long long offset, 
 	       const char *buf, int len)
@@ -206,6 +214,7 @@ int write_file(struct file_handle *fh, u
 
 	return(os_write_file(fh->fd, buf, len));
 }
+EXPORT_SYMBOL(write_file);
 
 int truncate_file(struct file_handle *fh, unsigned long long size)
 {
@@ -217,6 +226,7 @@ int truncate_file(struct file_handle *fh
 
 	return(os_truncate_fd(fh->fd, size));
 }
+EXPORT_SYMBOL(truncate_file);
 
 int make_pipe(struct file_handle *fhs)
 {
diff -puN arch/um/Kconfig~uml-export-Symbols arch/um/Kconfig
--- uml-linux-2.6.7/arch/um/Kconfig~uml-export-Symbols	2004-08-26 22:35:34.463728616 +0200
+++ uml-linux-2.6.7-paolo/arch/um/Kconfig	2004-08-26 22:35:34.470727552 +0200
@@ -83,6 +83,7 @@ config EXTERNFS
 
 config HOSTFS
 	tristate "Host filesystem"
+	depends on EXTERNFS
 	help
         While the User-Mode Linux port uses its own root file system for
         booting and normal file access, this module lets the UML user
diff -puN fs/hostfs/host_fs.c~uml-export-Symbols fs/hostfs/host_fs.c
--- uml-linux-2.6.7/fs/hostfs/host_fs.c~uml-export-Symbols	2004-08-26 22:35:34.464728464 +0200
+++ uml-linux-2.6.7-paolo/fs/hostfs/host_fs.c	2004-08-26 22:35:34.470727552 +0200
@@ -11,6 +11,7 @@
 #include "linux/init.h"
 #include "linux/fs.h"
 #include "linux/stat.h"
+#include "linux/module.h"
 #include "hostfs.h"
 #include "kern.h"
 #include "init.h"
@@ -21,6 +22,7 @@
 /* Changed in hostfs_args before the kernel starts running */
 static char *jail_dir = "/";
 int append = 0;
+EXPORT_SYMBOL(append);
 
 static int __init hostfs_args(char *options, int *add)
 {
@@ -446,14 +448,9 @@ static void __exit exit_hostfs(void)
 	unregister_externfs("hostfs");
 }
 
-__initcall(init_hostfs);
-__exitcall(exit_hostfs);
-
-#if 0
 module_init(init_hostfs)
 module_exit(exit_hostfs)
 MODULE_LICENSE("GPL");
-#endif
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN fs/hostfs/meta_fs.c~uml-export-Symbols fs/hostfs/meta_fs.c
--- uml-linux-2.6.7/fs/hostfs/meta_fs.c~uml-export-Symbols	2004-08-26 22:35:34.465728312 +0200
+++ uml-linux-2.6.7-paolo/fs/hostfs/meta_fs.c	2004-08-26 22:35:34.471727400 +0200
@@ -5,6 +5,7 @@
 
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include "hostfs.h"
 #include "metadata.h"
 #include "kern_util.h"
@@ -505,8 +506,8 @@ static void __exit exit_meta_fs(void)
 	unregister_meta(&hum_fs_meta_fs_ops);
 }
 
-__initcall(init_meta_fs);
-__exitcall(exit_meta_fs);
+module_init(init_meta_fs);
+module_exit(exit_meta_fs);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
_

--Boundary-00=_IJzOBnp4suHb3Hq--

