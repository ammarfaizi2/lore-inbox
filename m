Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268276AbTAMHRT>; Mon, 13 Jan 2003 02:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268277AbTAMHRT>; Mon, 13 Jan 2003 02:17:19 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:30421 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268276AbTAMHRD>; Mon, 13 Jan 2003 02:17:03 -0500
Date: Mon, 13 Jan 2003 08:25:39 +0100
From: Andi Kleen <ak@muc.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andi Kleen <ak@muc.de>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fixing the tty layer was Re: any chance of 2.6.0-test*?
Message-ID: <20030113072539.GA2197@averell>
References: <20030110165441$1a8a@gated-at.bofh.it> <20030110165505$38d9@gated-at.bofh.it> <20030112094007$1647@gated-at.bofh.it> <m3iswuk7xm.fsf_-_@averell.firstfloor.org> <20030113064131.GB14996@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113064131.GB14996@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 07:41:31AM +0100, Dipankar Sarma wrote:
> On Sun, Jan 12, 2003 at 09:59:15AM +0000, Andi Kleen wrote:
> > > I've looked into this, and wow, it's not a simple fix :(
> 
> Oh, yes, I have spent hours and hours trying to untangle tty locking
> and it isn't simple.

Oops. Could you quickly summarize your findings so far ?

> 
> > 
> > it has to be fixed for 2.6, no argument.
> > 
> > I took a look at it. I think the easiest strategy would be:
> > 
> > - Make sure all the process context code holds BKL
> > (most of it does, but not all - sometimes it is buggy like in 
> > disassociate_tty) 
> > I have some patches for that for tty_io.c at least
> 
> What does that BKL protect ? I can't seem to ever figure our if
> all the races are plugged or not.

Well, one has to start somewhere. Just starting by plugging most of the
obvious races, then the more subtle ones can be attacked later.

The idea of the BKL was to protect the protect context code against
itself (code lock) and also the few global data structures that 
are only accessed from process context (like the tty drivers list)


> 
> > 
> > The local_irq_save in there are buggy, they need to take 
> > a lock.
> 
> Also a locking model w.r.t. the serial drivers ?

It would be better to encapsulate the locking in the ndisc/tty layer
IMHO, otherwise too much code needs to be audited.

I have not studied the dependencies to low level serial in too close
detail, so I am not sure how difficult that is.

> 
> > 
> > - Audit the data structures that are touched by interrupts
> > and add spinlocks.
> > At least for n_tty.c probably just tty->read_lock needs to be 
> > extended.
> > Perhaps some can be just "fixed" by ignoring latency and pushing
> > softirq functions into keventd
> > (modern CPUs should be fast enough for that) 
> > 
> > - Possibly disable module unloading for ldiscs (seems to be rather broken,
> > although Rusty's new unload algorithm may avoid the worst - not completely
> > sure)
> > 
> > Probably all doable with some concentrated effort.
> > 
> > Anyone interested in helping ?
> 
> Yes, I would like to help out. I was hoping to help rewrite the whole
> thing in 2.7, but it needs help *now*. Perhaps I can take your list
> of things to do and fix them as a starting point ?

I attached my current patch, it isn't too well tested however and needs
more work.

Mostly just adds lock_kernel()s to the high level code so far and a few comments.

-Andi


diff -u linux-2.5.56-work/drivers/char/tty_io.c-o linux-2.5.56-work/drivers/char/tty_io.c
--- linux-2.5.56-work/drivers/char/tty_io.c-o	2003-01-02 05:13:12.000000000 +0100
+++ linux-2.5.56-work/drivers/char/tty_io.c	2003-01-12 12:47:19.000000000 +0100
@@ -114,7 +114,12 @@
 #define CHECK_TTY_COUNT 1
 
 struct termios tty_std_termios;		/* for the benefit of tty drivers  */
+
+/* protected by the BKL */
 LIST_HEAD(tty_drivers);			/* linked list of tty drivers */
+
+/* broken locking correctly (FIXME).
+   Due to static allocation races are relatively harmless. */
 struct tty_ldisc ldiscs[NR_LDISCS];	/* line disc dispatch table	*/
 
 #ifdef CONFIG_UNIX98_PTYS
@@ -281,6 +286,9 @@
 		sprintf(modname, "tty-ldisc-%d", ldisc);
 		request_module (modname);
 	}
+
+	/* module unload race with LDISCs here */
+
 	if (!(ldiscs[ldisc].flags & LDISC_FLAG_DEFINED))
 		return -EINVAL;
 
@@ -322,6 +330,7 @@
 
 /*
  * This routine returns a tty driver structure, given a device number
+ * Called with BKL held.
  */
 struct tty_driver *get_tty_driver(kdev_t device)
 {
@@ -350,14 +359,21 @@
  */
 int tty_check_change(struct tty_struct * tty)
 {
-	if (current->tty != tty)
+	lock_kernel(); 
+	if (current->tty != tty) { 
+		unlock_kernel();
 		return 0;
+	}
 	if (tty->pgrp <= 0) {
+		unlock_kernel();
 		printk(KERN_WARNING "tty_check_change: tty->pgrp <= 0!\n");
 		return 0;
 	}
-	if (current->pgrp == tty->pgrp)
+	if (current->pgrp == tty->pgrp) { 
+		unlock_kernel();
 		return 0;
+	}
+	unlock_kernel(); 
 	if (is_ignored(SIGTTOU))
 		return 0;
 	if (is_orphaned_pgrp(current->pgrp))
@@ -568,17 +584,19 @@
  *
  * The argument on_exit is set to 1 if called when a process is
  * exiting; it is 0 if called by the ioctl TIOCNOTTY.
+ * 
+ * Can be called without BKL from do_exit.
  */
 void disassociate_ctty(int on_exit)
 {
-	struct tty_struct *tty = current->tty;
+	struct tty_struct *tty;
 	struct task_struct *p;
 	struct list_head *l;
 	struct pid *pid;
 	int tty_pgrp = -1;
 
 	lock_kernel();
-
+	tty = current->tty;
 	if (tty) {
 		tty_pgrp = tty->pgrp;
 		if (on_exit && tty->driver.type != TTY_DRIVER_TYPE_PTY)
@@ -1284,6 +1302,8 @@
  *
  * The termios state of a pty is reset on first open so that
  * settings don't persist across reuse.
+ * 
+ * Called with BKL hold.
  */
 static int tty_open(struct inode * inode, struct file * filp)
 {
@@ -1340,6 +1360,7 @@
 				if (!init_dev(device, &tty)) goto ptmx_found; /* ok! */
 			}
 		}
+
 		return -EIO; /* no free ptys */
 	ptmx_found:
 		set_bit(TTY_PTY_LOCK, &tty->flags); /* LOCK THE SLAVE */
@@ -1389,6 +1410,7 @@
 #endif
 
 		release_dev(filp);
+
 		if (retval != -ERESTARTSYS)
 			return retval;
 		if (signal_pending(current))
@@ -1444,8 +1466,13 @@
 	if (tty_paranoia_check(tty, filp->f_dentry->d_inode->i_rdev, "tty_poll"))
 		return 0;
 
-	if (tty->ldisc.poll)
-		return (tty->ldisc.poll)(tty, filp, wait);
+	if (tty->ldisc.poll) { 
+		int ret;
+		lock_kernel();
+		ret = (tty->ldisc.poll)(tty, filp, wait);
+		unlock_kernel();
+		return ret;
+	}
 	return 0;
 }
 
@@ -1669,6 +1697,8 @@
 
 /*
  * Split this up, as gcc can choke on it otherwise..
+ * 
+ * Called with BKL hold.
  */
 int tty_ioctl(struct inode * inode, struct file * file,
 	      unsigned int cmd, unsigned long arg)
@@ -1919,7 +1949,7 @@
 		fp = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
 		tty->flip.buf_num = 0;
 
-		local_irq_save(flags); // FIXME: is this safe?
+		spin_lock_irqsave(&tty->read_lock, flags); 
 		tty->flip.char_buf_ptr = tty->flip.char_buf;
 		tty->flip.flag_buf_ptr = tty->flip.flag_buf;
 	} else {
@@ -1927,13 +1957,14 @@
 		fp = tty->flip.flag_buf;
 		tty->flip.buf_num = 1;
 
-		local_irq_save(flags); // FIXME: is this safe?
+		spin_lock_irqsave(&tty->read_lock, flags); 
 		tty->flip.char_buf_ptr = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
 		tty->flip.flag_buf_ptr = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
 	}
 	count = tty->flip.count;
 	tty->flip.count = 0;
-	local_irq_restore(flags); // FIXME: is this safe?
+	spin_unlock_irqrestore(&tty->read_lock, flags);  /* need more locking elsewhere */
+
 	
 	tty->ldisc.receive_buf(tty, cp, fp, count);
 }
@@ -2092,12 +2123,16 @@
 	int error;
         int i;
 
+	lock_kernel();
+
 	if (driver->flags & TTY_DRIVER_INSTALLED)
 		return 0;
 
 	error = register_chrdev(driver->major, driver->name, &tty_fops);
-	if (error < 0)
+	if (error < 0) { 
+		unlock_kernel();
 		return error;
+	}
 	else if(driver->major == 0)
 		driver->major = error;
 
@@ -2111,6 +2146,7 @@
 		    tty_register_device(driver, driver->minor_start + i);
 	}
 	proc_tty_register_driver(driver);
+	unlock_kernel();
 	return error;
 }
 
@@ -2125,9 +2161,12 @@
 	struct termios *tp;
 	const char *othername = NULL;
 	
-	if (*driver->refcount)
+	if (*driver->refcount)  /* needs to be atomic */ 
 		return -EBUSY;
 
+
+	lock_kernel();
+
 	list_for_each_entry(p, &tty_drivers, tty_drivers) {
 		if (p == driver)
 			found++;
@@ -2135,13 +2174,17 @@
 			othername = p->name;
 	}
 	
-	if (!found)
+	if (!found) {
+		unlock_kernel();
 		return -ENOENT;
+	}
 
 	if (othername == NULL) {
 		retval = unregister_chrdev(driver->major, driver->name);
-		if (retval)
+		if (retval) {
+			unlock_kernel();
 			return retval;
+		}
 	} else
 		register_chrdev(driver->major, othername, &tty_fops);
 
@@ -2166,6 +2209,7 @@
 		tty_unregister_device(driver, driver->minor_start + i);
 	}
 	proc_tty_unregister_driver(driver);
+	unlock_kernel();
 	return 0;
 }
 
diff -u linux-2.5.56-work/fs/proc/proc_tty.c-o linux-2.5.56-work/fs/proc/proc_tty.c
--- linux-2.5.56-work/fs/proc/proc_tty.c-o	2002-10-19 04:32:32.000000000 +0200
+++ linux-2.5.56-work/fs/proc/proc_tty.c	2003-01-12 15:54:52.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/tty.h>
+#include <linux/smp_lock.h>
 #include <asm/bitops.h>
 
 extern struct tty_ldisc ldiscs[];
@@ -39,6 +40,8 @@
 	char	range[20], deftype[20];
 	char	*type;
 
+	lock_kernel();
+
 	list_for_each_entry(p, &tty_drivers, tty_drivers) {
 		if (p->num > 1)
 			sprintf(range, "%d-%d", p->minor_start,
@@ -88,6 +91,9 @@
 			len = 0;
 		}
 	}
+
+	unlock_kernel();
+
 	if (!p)
 		*eof = 1;
 	if (off >= len+begin)
