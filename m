Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264612AbRFPLcz>; Sat, 16 Jun 2001 07:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264613AbRFPLcp>; Sat, 16 Jun 2001 07:32:45 -0400
Received: from nova.math.tau.ac.il ([132.67.128.249]:35085 "EHLO tau.ac.il")
	by vger.kernel.org with ESMTP id <S264612AbRFPLcf>;
	Sat, 16 Jun 2001 07:32:35 -0400
Date: Sat, 16 Jun 2001 14:32:48 +0300
From: Yedidya Bar-david <didi@tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: VSTATUS and VDISCARD (^T and ^O) for linux
Message-ID: <20010616143248.A7875@nova.math.tau.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

The attached patch gives VSTATUS and VDISCARD characters recognition
to linux. In short, this means that pressing ^O will discard all
output to tty until another character is pressed, and ^T will output
a status line.

I use linux for 7+ years now, but this is my first kernel patch
(and first post to lkml), so it's not very polished (yet!), but it
works (at least for me). It's against 2.4.4+badmem patch, but
should apply cleanly to 2.4.5 too (I simply havn't yet checked
if there is badmem for 2.4.5, which I unfortunately need).

Some notes/questions:
1. Is there any special reason why such a thing isn't already in
linux? Or simply nobody needed it yet?
2. I was for 4 years a VMS sysmgr, and got used to ^T and ^O.
Only recently I found out these things are documented and work also
in some unices. The glibc docs say only BSD and GNU, but at
least VDISCARD is defined (but not implemented) in linux for
a long time.
3. There is no way (yet) to control these things from userland.
That is, libc and stty (maybe other). This will probably be
non-trivial and take me some more time, and worse, might need
a recompilation of many binaries. I looked at that only a bit.
4. In the status line, I wanted to see how much IO was done.
VMS prints the number of IO operations made, which, at least for
me, is not too much meaningful. BSD doesn't print any IO.
The patch counts the number of bytes that passed through sys_read
and sys_write, and keeps them in a new field I added to task_struct.
Is this a Bad Thing?
Of course, this is only a start. I should also count bytes going
through sys_send*, sys_recv*, maybe others. Still, it's already
very useful, as most progams use read/write even on sockets.
5. I copied some things from other files. e.g. LOAD_INT,LOAD_FRAC
from proc/proc_misc.c, vsize calculation from proc/array.c. Should
I have put them in public (include/linux/xxx.h) places?
6. I use a 64 byte buffer on the stack. I hope it is not considered
too big (I saw other functions do that). But it is too small for
e.g. the command name, so I print it directly, which can take a
long time on a slow tty (during which the task might finish?).
Should I task_lock/task_unlock around?
Or should I alloc a bigger buffer? and how (vmalloc, get_free_page)?
7. I currently based the output on that of *BSD, with changes.
It is:
<hostname> load:<loadavg> cmd:<cmd> pid:<pid> <usertime>u <systime>s \
vsz:<vsize>k rss:<rss>k io:<io>k
e.g.
pinky load:0.22 cmd:cat pid:1311 0.00u 0.00s vsz:1216k rss:384k io:1k
Comments, anyone?
8. It is currently only for i386. I don't mind patching all the
archs, but I can't test on most of them (I have some access to
mips and alpha, but havn't tried that on them).
I do not realy understand why should such things be arch specific.
And they are! e.g. NCCS is 19 for most archs, but 23 for mips and
mips64 and 17 for sparc and sparc64. Can anyone explain, please?


I hope people will find it useful (as I do), and when it matures will
make it into the official kernel.
It will also be available from <http://www.cs.tau.ac.il/~didi>.

Also, I am not subscribed to lkml, so please CC: me when you
reply. Thanks.

	didi


diff -u -r linux-2.4.4-badmem/drivers/char/n_tty.c linux-2.4.4-badmem-ctrl-t/drivers/char/n_tty.c
--- linux-2.4.4-badmem/drivers/char/n_tty.c	Fri Apr  6 10:42:55 2001
+++ linux-2.4.4-badmem-ctrl-t/drivers/char/n_tty.c	Fri Jun 15 22:51:18 2001
@@ -45,6 +45,8 @@
 #include <asm/system.h>
 #include <asm/bitops.h>
 
+#include <linux/utsname.h>
+
 #define CONSOLE_DEV MKDEV(TTY_MAJOR,0)
 #define SYSCONS_DEV  MKDEV(TTYAUX_MAJOR,1)
 
@@ -502,9 +504,95 @@
 	wake_up_interruptible(&tty->read_wait);
 }
 
+#define LOAD_INT(x) ((x) >> FSHIFT)
+#define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
+
+static inline void echo_string(char *s, struct tty_struct *tty)
+{
+	while (*s)
+		echo_char(*(s++), tty);
+}
+
+static inline void n_tty_print_status(struct tty_struct *tty)
+{
+	int a;
+	char buf[64];
+	struct task_struct *p, *task=0;
+	struct mm_struct *mm;
+	unsigned long vsize = 0, rss = 0;
+
+	/* Hostname */
+	sprintf(buf, "%s", system_utsname.nodename);
+	echo_string(buf, tty);
+
+	/* Load average */
+	echo_string(" load:", tty);
+	a = avenrun[0] + (FIXED_1/200);
+	sprintf(buf, " %d:%02d", LOAD_INT(a), LOAD_FRAC(a));
+	echo_string(buf, tty);
+
+	/* Choose a task to print status about */
+	for_each_task(p) {
+		if (p->pgrp == tty->pgrp)
+			task = p;
+	}
+	if (!task) {
+		echo_string("Can't find task!", tty);
+		opost('\n', tty);
+		return;
+	}
+
+	/* Command name */
+	echo_string("  cmd: ", tty);
+	echo_string(task->comm, tty);
+
+	/* PID */
+	sprintf(buf, " %d ", task->pid);
+	echo_string(buf, tty);
+
+	/* User time */
+	sprintf(buf, " %ld.%02ldu", task->times.tms_utime / 100,
+			task->times.tms_utime % 100);
+	echo_string(buf, tty);
+
+	/* System time */
+	sprintf(buf, " %ld.%02lds", task->times.tms_stime / 100,
+			task->times.tms_stime % 100);
+	echo_string(buf, tty);
+
+	/* Mem usage - mostly copied from fs/proc/array.c - vsize */
+	task_lock(task);
+	mm = task->mm;
+	if (mm) {
+		struct vm_area_struct *vma;
+		atomic_inc(&mm->mm_users);
+		down_read(&mm->mmap_sem);
+		vma = mm->mmap;
+		while (vma) {
+			vsize += vma->vm_end - vma->vm_start;
+			vma = vma->vm_next;
+		}
+		rss = mm ? mm->rss : 0;
+		up_read(&mm->mmap_sem);
+		mmput(mm);
+	}
+	task_unlock(task);
+	sprintf(buf, "  vsz%ldk rss%ldk", vsize >> 10, rss << (PAGE_SHIFT-10));
+	echo_string(buf, tty);
+
+	/* Number of bytes IOed */
+	sprintf(buf, "  io%ldk", task->rw_bytes >> 10);
+	echo_string(buf, tty);
+
+	opost('\n', tty);
+}
+
 static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 {
 	unsigned long flags;
+	unsigned char discarding=tty->discard;
+
+	tty->discard = 0;
 
 	if (tty->raw) {
 		put_tty_queue(c, tty);
@@ -517,6 +605,17 @@
 		return;
 	}
 	
+	if (c == DISCARD_CHAR(tty) && L_IEXTEN(tty)) {
+		if (!discarding)
+			tty->discard = 1;
+		return;
+	}
+
+	if ( (c == STATUS_CHAR(tty)) && (tty->icanon) ) {
+		n_tty_print_status(tty);
+		return;
+	}
+
 	if (I_ISTRIP(tty))
 		c &= 0x7f;
 	if (I_IUCLC(tty) && L_IEXTEN(tty))
diff -u -r linux-2.4.4-badmem/drivers/char/tty_io.c linux-2.4.4-badmem-ctrl-t/drivers/char/tty_io.c
--- linux-2.4.4-badmem/drivers/char/tty_io.c	Thu Apr 26 17:35:49 2001
+++ linux-2.4.4-badmem-ctrl-t/drivers/char/tty_io.c	Sun May  6 00:53:04 2001
@@ -699,6 +699,9 @@
 {
 	ssize_t ret = 0, written = 0;
 	
+	if (tty->discard == 1) {
+		return count;
+	}
 	if (down_interruptible(&tty->atomic_write)) {
 		return -ERESTARTSYS;
 	}
diff -u -r linux-2.4.4-badmem/fs/read_write.c linux-2.4.4-badmem-ctrl-t/fs/read_write.c
--- linux-2.4.4-badmem/fs/read_write.c	Fri Feb  9 11:29:44 2001
+++ linux-2.4.4-badmem-ctrl-t/fs/read_write.c	Fri Jun 15 22:33:40 2001
@@ -138,6 +138,7 @@
 				DN_ACCESS);
 		fput(file);
 	}
+	current->rw_bytes+=ret;
 	return ret;
 }
 
@@ -165,6 +166,7 @@
 				DN_MODIFY);
 		fput(file);
 	}
+	current->rw_bytes+=ret;
 	return ret;
 }
 
diff -u -r linux-2.4.4-badmem/include/asm-i386/termbits.h linux-2.4.4-badmem-ctrl-t/include/asm-i386/termbits.h
--- linux-2.4.4-badmem/include/asm-i386/termbits.h	Thu Jan 20 22:05:26 2000
+++ linux-2.4.4-badmem-ctrl-t/include/asm-i386/termbits.h	Sun May  6 00:54:08 2001
@@ -35,6 +35,7 @@
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
diff -u -r linux-2.4.4-badmem/include/asm-i386/termios.h linux-2.4.4-badmem-ctrl-t/include/asm-i386/termios.h
--- linux-2.4.4-badmem/include/asm-i386/termios.h	Sat Feb  3 20:00:45 2001
+++ linux-2.4.4-badmem-ctrl-t/include/asm-i386/termios.h	Sun May  6 01:06:14 2001
@@ -61,10 +61,10 @@
 /*	intr=^C		quit=^\		erase=del	kill=^U
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
-	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	reprint=^R	discard=^O	werase=^W	lnext=^V
+	eol2=\0		status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff -u -r linux-2.4.4-badmem/include/linux/sched.h linux-2.4.4-badmem-ctrl-t/include/linux/sched.h
--- linux-2.4.4-badmem/include/linux/sched.h	Fri Apr 27 15:48:34 2001
+++ linux-2.4.4-badmem-ctrl-t/include/linux/sched.h	Fri Jun 15 22:12:16 2001
@@ -354,6 +354,7 @@
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
+	unsigned long rw_bytes; /* Number of read or written bytes */
 	int swappable:1;
 /* process credentials */
 	uid_t uid,euid,suid,fsuid;
diff -u -r linux-2.4.4-badmem/include/linux/tty.h linux-2.4.4-badmem-ctrl-t/include/linux/tty.h
--- linux-2.4.4-badmem/include/linux/tty.h	Mon Mar 26 15:48:11 2001
+++ linux-2.4.4-badmem-ctrl-t/include/linux/tty.h	Sun May  6 01:06:14 2001
@@ -179,6 +179,7 @@
 #define WERASE_CHAR(tty) ((tty)->termios->c_cc[VWERASE])
 #define LNEXT_CHAR(tty)	((tty)->termios->c_cc[VLNEXT])
 #define EOL2_CHAR(tty) ((tty)->termios->c_cc[VEOL2])
+#define STATUS_CHAR(tty) ((tty)->termios->c_cc[VSTATUS])
 
 #define _I_FLAG(tty,f)	((tty)->termios->c_iflag & (f))
 #define _O_FLAG(tty,f)	((tty)->termios->c_oflag & (f))
@@ -291,6 +292,7 @@
 	 */
 	unsigned int column;
 	unsigned char lnext:1, erasing:1, raw:1, real_raw:1, icanon:1;
+	unsigned char discard:1;
 	unsigned char closing:1;
 	unsigned short minimum_to_wake;
 	unsigned overrun_time;
diff -u -r linux-2.4.4-badmem/kernel/fork.c linux-2.4.4-badmem-ctrl-t/kernel/fork.c
--- linux-2.4.4-badmem/kernel/fork.c	Thu Apr 26 06:11:17 2001
+++ linux-2.4.4-badmem-ctrl-t/kernel/fork.c	Fri Jun 15 22:25:49 2001
@@ -665,6 +665,8 @@
 	p->exit_signal = clone_flags & CSIGNAL;
 	p->pdeath_signal = 0;
 
+	p->rw_bytes = 0;
+
 	/*
 	 * Give the parent's dynamic priority entirely to the child.  The
 	 * total amount of dynamic priorities in the system doesn't change
