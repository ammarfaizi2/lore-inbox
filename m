Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRCRBOQ>; Sat, 17 Mar 2001 20:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRCRBOG>; Sat, 17 Mar 2001 20:14:06 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:14004 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129116AbRCRBN5>; Sat, 17 Mar 2001 20:13:57 -0500
Message-ID: <3AB40C14.6E8A1BEB@uow.edu.au>
Date: Sun, 18 Mar 2001 12:15:00 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Subject: [patch] Secure Attention Key handling
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The do_SAK() function is called from within interrupt context.
It acquires several process-level spinlocks.  This can deadlock.
It is fairly trivial for an unprivileged user to deliberately
deadlock the kernel of a system which has SAK enabled.

So this patch moves do_SAK() into process context.  It does
a few other things:

- Creates some missing tq_struct initialisation macros

- In alloc_tty_struct(): once upon a time this function used
  get_free_page() to allocate the tty_struct.  Then Russell
  King made it use kmalloc() on achines with 16k and 32k
  page sizes to save a bit of RAM.  This patch makes it
  always use kmalloc().

- The tty_[un]register_devfs() functions are using several
  kbytes of kernel stack.  Jeff has fixed this in UML, so
  this patch merges those changes in.

- The locking rules for task_struct->files.file_lock, 
  task_struct.alloc_lock and tasklist_lock are undocumented
  and unclear.  It is also unclear what some of these locks
  are actually intended to protect. So I have reviewed the
  use of these locks and have defined and documented both
  their locking order, and the things which they are
  protecting.

- The patch instantiates Documentation/SAK.txt, and
  initialises it with semi-accurate mortonbabble.  Comments
  on the accuracy and completeness of this document would
  be appreciated.

Now, it's pretty obvious that nobody has been testing SAK. It
breaks lots of stuff.  Pressing the SAK key when using
a recent distribution from $(PROMINENT_DISRIBUTOR) instantly
kills little things like sshd, httpd, crond, inetd, lpd and
sendmail.  It also exposes bugs in gpm and vixie cron.
Workarounds are described in SAK.txt.

My recommendation to distributors is:

1: Test SAK.
2: When launching daemons from within your initscripts,
   ensure that the daemon's standard input is redirected
   to /dev/null.
3: Test SAK.


Can anyone tell me *why* our SAK implementation doesn't
meet C2 requirements?


Patch is against 2.4.2-ac20



--- linux-2.4.2-ac20/Documentation/SAK.txt	Thu Jan  1 00:00:00 1970
+++ ac/Documentation/SAK.txt	Sun Mar 18 11:52:13 2001
@@ -0,0 +1,87 @@
+Linux 2.4.2 Secure Attention Key (SAK) handling
+18 March 2001, Andrew Morton <andrewm@uow.edu.au>
+
+An operating system's Secure Attention Key is a security tool which is
+provided as protection against trojan password capturing programs.  It
+is an undefeatable way of killing all programs which could be
+masquerading as login applications.  Users need to be taught to enter
+this key sequence before they log in to the system.
+
+From the PC keyboard, Linux has two similar but different ways of
+providing SAK.  One is the ALT-SYSRQ-K sequence.  You shouldn't use
+this sequence.  It is only available if the kernel was compiled with
+sysrq support.
+
+The proper way of generating a SAK is to define the key sequence using
+`loadkeys'.  This will work whether or not sysrq support is compiled
+into the kernel.
+
+SAK works correctly when the keyboard is in raw mode.  This means that
+once defined, SAK will kill a running X server.  If the system is in
+run level 5, the X server will restart.  This is what you want to
+happen.
+
+What key sequence should you use? Well, CTRL-ALT-DEL is used to reboot
+the machine.  CTRL-ALT-BACKSPACE is magical to the X server.  We'll
+choose CTRL-ALT-PAUSE.
+
+In your rc.sysinit (or rc.local) file, add the command
+
+	echo "control alt keycode 101 = SAK" | /bin/loadkeys
+
+And that's it!  Only the superuser may reprogram the SAK key.
+
+
+NOTES
+=====
+
+1: Linux SAK is said to be not a "true SAK" as is required by
+   systems which implement C2 level security.  This author does not
+   know why.
+
+
+2: On the PC keyboard, SAK kills all applications which have
+   /dev/console opened.
+
+   Unfortunately this includes a number of things which you don't
+   actually want killed.  This is because these appliccaitons are
+   incorrectly holding /dev/console open.  Be sure to complain to your
+   Linux distributor about this!
+
+   You can identify processes which will be killed by SAK with the
+   command
+
+	# ls -l /proc/[0-9]*/fd/* | grep console
+	l-wx------    1 root     root           64 Mar 18 00:46 /proc/579/fd/0 -> /dev/console
+
+   Then:
+
+	# ps aux|grep 579
+	root       579  0.0  0.1  1088  436 ?        S    00:43   0:00 gpm -t ps/2
+
+   So `gpm' will be killed by SAK.  This is a bug in gpm.  It should
+   be closing standard input.  You can work around this by finding the
+   initscript which launches gpm and changing it thusly:
+
+   Old:
+
+	daemon gpm
+
+   New:
+
+	daemon gpm < /dev/null
+
+   Vixie cron also seems to have this problem, and needs the same treatment.
+
+   Also, one prominent Linux distribution has the following three
+   lines in its rc.sysinit and rc scripts:
+
+	exec 3<&0
+	exec 4>&1
+	exec 5>&2
+
+   These commands cause *all* daemons which are launched by the
+   initscripts to have file descriptors 3, 4 and 5 attached to
+   /dev/console.  So SAK kills them all.  You may simply delete these
+   lines.
+
--- linux-2.4.2-ac20/include/linux/tty.h	Tue Jan 30 18:24:56 2001
+++ ac/include/linux/tty.h	Sun Mar 18 11:57:25 2001
@@ -307,6 +307,8 @@
 	struct semaphore atomic_read;
 	struct semaphore atomic_write;
 	spinlock_t read_lock;
+	/* If the tty has a pending do_SAK, queue it here - akpm */
+	struct tq_struct SAK_tq;
 };
 
 /* tty magic number */
--- linux-2.4.2-ac20/include/linux/tqueue.h	Tue Jan 30 18:24:56 2001
+++ ac/include/linux/tqueue.h	Sun Mar 18 11:52:13 2001
@@ -42,6 +42,25 @@
 	void *data;			/* argument to function */
 };
 
+/*
+ * Emit code to initialise a tq_struct's routine and data pointers
+ */
+#define PREPARE_TQUEUE(_tq, _routine, _data)			\
+	do {							\
+		(_tq)->routine = _routine;			\
+		(_tq)->data = _data;				\
+	} while (0)
+
+/*
+ * Emit code to initialise all of a tq_struct
+ */
+#define INIT_TQUEUE(_tq, _routine, _data)			\
+	do {							\
+		INIT_LIST_HEAD(&(_tq)->list);			\
+		(_tq)->sync = 0;				\
+		PREPARE_TQUEUE((_tq), (_routine), (_data));	\
+	} while (0)
+
 typedef struct list_head task_queue;
 
 #define DECLARE_TASK_QUEUE(q)	LIST_HEAD(q)
--- linux-2.4.2-ac20/drivers/char/tty_io.c	Tue Mar 13 20:29:22 2001
+++ ac/drivers/char/tty_io.c	Sun Mar 18 12:10:28 2001
@@ -63,6 +63,9 @@
  *
  * Don't call close after a failed open.
  *	-- Maciej W. Rozycki <macro@ds2.pg.gda.pl>, 21-Jan-2001
+ *
+ * Move do_SAK() into process context.  Less stack use in devfs functions.
+ * alloc_tty_struct() always uses kmalloc() -- Andrew Morton <andrewm@uow.edu.eu> 17Mar01
  */
 
 #include <linux/config.h>
@@ -169,26 +172,19 @@
 #define MAX(a,b)	((a) < (b) ? (b) : (a))
 #endif
 
-static inline struct tty_struct *alloc_tty_struct(void)
+static struct tty_struct *alloc_tty_struct(void)
 {
 	struct tty_struct *tty;
 
-	if (PAGE_SIZE > 8192) {
-		tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
-		if (tty)
-			memset(tty, 0, sizeof(struct tty_struct));
-	} else
-		tty = (struct tty_struct *)get_zeroed_page(GFP_KERNEL);
-
+	tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
+	if (tty)
+		memset(tty, 0, sizeof(struct tty_struct));
 	return tty;
 }
 
 static inline void free_tty_struct(struct tty_struct *tty)
 {
-	if (PAGE_SIZE > 8192)
-		kfree(tty);
-	else
-		free_page((unsigned long) tty);
+	kfree(tty);
 }
 
 /*
@@ -1827,12 +1823,16 @@
  * Now, if it would be correct ;-/ The current code has a nasty hole -
  * it doesn't catch files in flight. We may send the descriptor to ourselves
  * via AF_UNIX socket, close it and later fetch from socket. FIXME.
+ *
+ * Nasty bug: do_SAK is being called in interrupt context.  This can
+ * deadlock.  We punt it up to process context.  AKPM - 16Mar2001
  */
-void do_SAK( struct tty_struct *tty)
+static void __do_SAK(void *arg)
 {
 #ifdef TTY_SOFT_SAK
 	tty_hangup(tty);
 #else
+	struct tty_struct *tty = arg;
 	struct task_struct *p;
 	int session;
 	int		i;
@@ -1855,7 +1855,6 @@
 		task_lock(p);
 		if (p->files) {
 			read_lock(&p->files->file_lock);
-			/* FIXME: p->files could change */
 			for (i=0; i < p->files->max_fds; i++) {
 				filp = fcheck_files(p->files, i);
 				if (filp && (filp->f_op == &tty_fops) &&
@@ -1873,6 +1872,19 @@
 }
 
 /*
+ * The tq handling here is a little racy - tty->SAK_tq may already be queued.
+ * But there's no mechanism to fix that without futzing with tqueue_lock.
+ * Fortunately we don't need to worry, because if ->SAK_tq is already queued,
+ * the values which we write to it will be identical to the values which it
+ * already has. --akpm
+ */
+void do_SAK(struct tty_struct *tty)
+{
+	PREPARE_TQUEUE(&tty->SAK_tq, __do_SAK, tty);
+	schedule_task(&tty->SAK_tq);
+}
+
+/*
  * This routine is called out of the software interrupt to flush data
  * from the flip buffer to the line discipline.
  */
@@ -1986,6 +1998,7 @@
 	sema_init(&tty->atomic_write, 1);
 	spin_lock_init(&tty->read_lock);
 	INIT_LIST_HEAD(&tty->tty_files);
+	INIT_TQUEUE(&tty->SAK_tq, 0, 0);
 }
 
 /*
@@ -1999,17 +2012,15 @@
 /*
  * Register a tty device described by <driver>, with minor number <minor>.
  */
-void tty_register_devfs (struct tty_driver *driver, unsigned int flags,
-			 unsigned int minor)
+void tty_register_devfs (struct tty_driver *driver, unsigned int flags, unsigned minor)
 {
 #ifdef CONFIG_DEVFS_FS
 	umode_t mode = S_IFCHR | S_IRUSR | S_IWUSR;
-	struct tty_struct tty;
+	kdev_t device = MKDEV (driver->major, minor);
+	int idx = minor - driver->minor_start;
 	char buf[32];
 
-	tty.driver = *driver;
-	tty.device = MKDEV (driver->major, minor);
-	switch (tty.device) {
+	switch (device) {
 		case TTY_DEV:
 		case PTMX_DEV:
 			mode |= S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
@@ -2030,7 +2041,8 @@
 	     (driver->major < UNIX98_PTY_SLAVE_MAJOR + UNIX98_NR_MAJORS) )
 		flags |= DEVFS_FL_CURRENT_OWNER;
 #  endif
-	devfs_register (NULL, tty_name (&tty, buf), flags | DEVFS_FL_DEFAULT,
+	sprintf(buf, driver->name, idx + driver->name_base);
+	devfs_register (NULL, buf, flags | DEVFS_FL_DEFAULT,
 			driver->major, minor, mode, &tty_fops, NULL);
 #endif /* CONFIG_DEVFS_FS */
 }
@@ -2039,14 +2051,11 @@
 {
 #ifdef CONFIG_DEVFS_FS
 	void * handle;
-	struct tty_struct tty;
+	int idx = minor - driver->minor_start;
 	char buf[32];
 
-	tty.driver = *driver;
-	tty.device = MKDEV(driver->major, minor);
-	
-	handle = devfs_find_handle (NULL, tty_name (&tty, buf),
-				    driver->major, minor,
+	sprintf(buf, driver->name, idx + driver->name_base);
+	handle = devfs_find_handle (NULL, buf, driver->major, minor,
 				    DEVFS_SPECIAL_CHR, 0);
 	devfs_unregister (handle);
 #endif /* CONFIG_DEVFS_FS */
@@ -2239,9 +2248,6 @@
  */
 void __init tty_init(void)
 {
-	if (sizeof(struct tty_struct) > PAGE_SIZE)
-		panic("size of tty structure > PAGE_SIZE!");
-
 	/*
 	 * dev_tty_driver and dev_console_driver are actually magic
 	 * devices which get redirected at open time.  Nevertheless,
--- linux-2.4.2-ac20/include/linux/sched.h	Tue Mar 13 20:29:29 2001
+++ ac/include/linux/sched.h	Sun Mar 18 11:57:31 2001
@@ -167,7 +167,7 @@
  */
 struct files_struct {
 	atomic_t count;
-	rwlock_t file_lock;
+	rwlock_t file_lock;	/* Protects all the below members.  Nests inside tsk->alloc_lock */
 	int max_fds;
 	int max_fdset;
 	int next_fd;
@@ -861,6 +861,7 @@
 	write_unlock_irq(&tasklist_lock);
 }
 
+/* Protects ->fs, ->files, ->mm, and synchronises with wait4().  Nests inside tasklist_lock */
 static inline void task_lock(struct task_struct *p)
 {
 	spin_lock(&p->alloc_lock);
--- linux-2.4.2-ac20/kernel/sched.c	Tue Mar 13 20:29:30 2001
+++ ac/kernel/sched.c	Sun Mar 18 11:52:13 2001
@@ -84,6 +84,8 @@
  *
  * If both locks are to be concurrently held, the runqueue_lock
  * nests inside the tasklist_lock.
+ *
+ * task->alloc_lock nests inside tasklist_lock.
  */
 spinlock_t runqueue_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;  /* inner */
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;	/* outer */
--- linux-2.4.2-ac20/Documentation/sysrq.txt	Tue Mar 13 20:29:20 2001
+++ ac/Documentation/sysrq.txt	Sun Mar 18 11:52:13 2001
@@ -30,6 +30,8 @@
            You send a BREAK, then within 5 seconds a command key. Sending
            BREAK twice is interpreted as a normal BREAK.
 
+On Mac   - Press 'Keypad+-F13-<command key>'
+
 On other - If you know of the key combos for other architectures, please
            let me know so I can add them to this section.
