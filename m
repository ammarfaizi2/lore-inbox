Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWGHAhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWGHAhi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWGHAhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:37:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:60661 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932460AbWGHAhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:37:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CZjUbqxDGmzw4gcfHerSyYu0CTTPwU2PeFfdlv4zpnP49ZiBrOfFEX25TxgYEsv6DlFRdutUWrGhv0lp9Vy4iOMaFFZB8gVotTrvNirkHncGshNKEWcnUybGvEv/HqQ4UbATimg9aB0XWZMVoo9yfONgXvqoXvQbb1lInpjZCWI=
Message-ID: <9e4733910607071737n1bd01042u92b895edaceb73db@mail.gmail.com>
Date: Fri, 7 Jul 2006 20:37:36 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Paul Fulghum" <paulkf@microgate.com>, "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH] Ref counting for tty_struct and some locking clean up
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes tty_mutex and replaces it with a ref counted
tty_struct. A new spinlock, tty_lock, serializes tty
creation/destruction. This code thoroughly audits everyone taking
references to tty_struct and tracks them. I have been running it
locally for a few days without any issues.

If there is a refcount problem it will trigger a WARN_ON. If you hit
one, defining DEBUG_TTY_REFCOUNT will provide plenty of debug info to
help locate the missing reference. I definitely found multiple locking
holes in the old tty_mutex code but they they look hard to hit.

This is just a first step, if this code proves to be stable I'll do
another round of cleanup. There is room for a lot more work to be
done. Ultimately there may not even be a need for a tty refcount if
everything is locked correctly. But that is a big step and we should
take some smaller ones first.

This is meant for mm until it gets some testing - I don't want to
break anyone's console. If gmail wraps it let me know and I'll send
you an attachment.

-- 
Jon Smirl
jonsmirl@gmail.com



diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index bfdb902..5c673e0 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -126,9 +126,8 @@ EXPORT_SYMBOL(tty_std_termios);

  LIST_HEAD(tty_drivers);			/* linked list of tty drivers */

-/* Semaphore to protect creating and releasing a tty. This is shared with
-   vt.c for deeply disgusting hack reasons */
-DEFINE_MUTEX(tty_mutex);
+/* Spinlock to protect creating and releasing a tty. */
+static DEFINE_SPINLOCK(tty_lock);

  #ifdef CONFIG_UNIX98_PTYS
  extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
@@ -158,21 +157,21 @@ static struct tty_struct *alloc_tty_stru
 {
  	struct tty_struct *tty;

-	tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
-	if (tty)
-		memset(tty, 0, sizeof(struct tty_struct));
+	tty = kmalloc(sizeof(*tty), GFP_KERNEL);
  	return tty;
 }

  static void tty_buffer_free_all(struct tty_struct *);

-static inline void free_tty_struct(struct tty_struct *tty)
+void free_tty_struct(struct tty_struct *tty)
 {
  	kfree(tty->write_buf);
  	tty_buffer_free_all(tty);
  	kfree(tty);
 }

+EXPORT_SYMBOL(free_tty_struct);
+
  #define TTY_NUMBER(tty) ((tty)->index + (tty)->driver->name_base)

  char *tty_name(struct tty_struct *tty, char *buf)
@@ -1090,7 +1089,7 @@ static void do_tty_hangup(void *data)
  	if (tty->session > 0) {
  		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
  			if (p->signal->tty == tty)
-				p->signal->tty = NULL;
+				tty_put(&p->signal->tty, 0, __FILE__, __LINE__);
 			if (!p->signal->leader)
 				continue;
  			group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
@@ -1184,11 +1183,9 @@ void disassociate_ctty(int on_exit)

 	lock_kernel();

-	mutex_lock(&tty_mutex);
  	tty = current->signal->tty;
  	if (tty) {
  		tty_pgrp = tty->pgrp;
-		mutex_unlock(&tty_mutex);
  		if (on_exit && tty->driver->type != TTY_DRIVER_TYPE_PTY)
  			tty_vhangup(tty);
 	} else {
@@ -1196,7 +1193,6 @@ void disassociate_ctty(int on_exit)
  			kill_pg(current->signal->tty_old_pgrp, SIGHUP, on_exit);
  			kill_pg(current->signal->tty_old_pgrp, SIGCONT, on_exit);
 		}
-		mutex_unlock(&tty_mutex);
 		unlock_kernel();	
 		return;
 	}
@@ -1206,8 +1202,6 @@ void disassociate_ctty(int on_exit)
  			kill_pg(tty_pgrp, SIGCONT, on_exit);
 	}

-	/* Must lock changes to tty_old_pgrp */
-	mutex_lock(&tty_mutex);
 	current->signal->tty_old_pgrp = 0;
  	tty->session = 0;
  	tty->pgrp = -1;
@@ -1215,10 +1209,9 @@ void disassociate_ctty(int on_exit)
  	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
 	do_each_task_pid(current->signal->session, PIDTYPE_SID, p) {
-		p->signal->tty = NULL;
+		tty_put(&p->signal->tty, 0, __FILE__, __LINE__);
 	} while_each_task_pid(current->signal->session, PIDTYPE_SID, p);
 	read_unlock(&tasklist_lock);
-	mutex_unlock(&tty_mutex);
 	unlock_kernel();
 }

@@ -1546,7 +1539,8 @@ static int init_dev(struct tty_driver *d
 		 * Everything allocated ... set up the o_tty structure.
 		 */
 		if (!(driver->other->flags & TTY_DRIVER_DEVPTS_MEM)) {
-			driver->other->ttys[idx] = o_tty;
+			driver->other->ttys[idx] = tty_get(o_tty,
+							__FILE__, __LINE__);
 		}
 		if (!*o_tp_loc)
 			*o_tp_loc = o_tp;
@@ -1559,8 +1553,8 @@ static int init_dev(struct tty_driver *d
 			o_tty->count++;

 		/* Establish the links in both directions */
-		tty->link   = o_tty;
-		o_tty->link = tty;
+		tty->link   = tty_get(o_tty, __FILE__, __LINE__);
+		o_tty->link = tty_get(tty, __FILE__, __LINE__);
 	}

 	/*
@@ -1569,7 +1563,7 @@ static int init_dev(struct tty_driver *d
 	 * there's no need to null out the local pointers.
 	 */
 	if (!(driver->flags & TTY_DRIVER_DEVPTS_MEM)) {
-		driver->ttys[idx] = tty;
+		driver->ttys[idx] = tty_get(tty, __FILE__, __LINE__);
 	}
 	
 	if (!*tp_loc)
@@ -1636,7 +1630,6 @@ fast_track:
 success:
  	*ret_tty = tty;
 	
-	/* All paths come through here to release the mutex */
 end_init:
  	return retval;

@@ -1644,10 +1637,10 @@ end_init:
 free_mem_out:
  	kfree(o_tp);
 	if (o_tty)
-		free_tty_struct(o_tty);
+		tty_put(&o_tty, 1, __FILE__, __LINE__);
  	kfree(ltp);
  	kfree(tp);
-	free_tty_struct(tty);
+	tty_put(&tty, 1, __FILE__, __LINE__);

 fail_no_mem:
 	module_put(driver->owner);
@@ -1674,7 +1667,8 @@ static void release_mem(struct tty_struc

  	if ((o_tty = tty->link) != NULL) {
  		if (!devpts)
-			o_tty->driver->ttys[idx] = NULL;
+			tty_put(&o_tty->driver->ttys[idx], 0,
+						__FILE__, __LINE__);
 		if (o_tty->driver->flags & TTY_DRIVER_RESET_TERMIOS) {
  			tp = o_tty->termios;
  			if (!devpts)
@@ -1691,11 +1685,14 @@ static void release_mem(struct tty_struc
 		file_list_lock();
 		list_del_init(&o_tty->tty_files);
 		file_list_unlock();
-		free_tty_struct(o_tty);
+		tty_put(&o_tty->link, 0, __FILE__, __LINE__);
+		tty_put(&tty->link, 0, __FILE__, __LINE__);
+		tty_put(&o_tty, 1, __FILE__, __LINE__);
 	}

  	if (!devpts)
-		tty->driver->ttys[idx] = NULL;
+		tty_put(&tty->driver->ttys[idx], 0,
+					 __FILE__, __LINE__);
  	if (tty->driver->flags & TTY_DRIVER_RESET_TERMIOS) {
  		tp = tty->termios;
  		if (!devpts)
@@ -1714,7 +1711,7 @@ static void release_mem(struct tty_struc
  	list_del_init(&tty->tty_files);
 	file_list_unlock();
  	module_put(tty->driver->owner);
-	free_tty_struct(tty);
+	tty_put(&tty, 1, __FILE__, __LINE__);
 }

 /*
@@ -1832,7 +1829,7 @@ #endif
  		/* Guard against races with tty->count changes elsewhere and
  		   opens on /dev/tty */
 		
-		mutex_lock(&tty_mutex);
+		spin_lock(&tty_lock);
  		tty_closing = tty->count <= 1;
 		o_tty_closing = o_tty &&
 			(o_tty->count <= (pty_master ? 1 : 0));
@@ -1861,9 +1858,9 @@ #endif
 		if (!do_sleep)
 			break;

+		spin_unlock(&tty_lock);
  		printk(KERN_WARNING "release_dev: %s: read/write wait queue "
  				    "active!\n", tty_name(tty, buf));
-		mutex_unlock(&tty_mutex);
 		schedule();
 	}	

@@ -1896,7 +1893,8 @@ #endif
 	 *    something that needs to be handled for hangups.
 	 */
  	file_kill(filp);
-	filp->private_data = NULL;
+	tty_put((struct tty_struct **)(&filp->private_data),
+					0, __FILE__, __LINE__);

 	/*
 	 * Perform some housekeeping before deciding whether to return.
@@ -1920,16 +1918,16 @@ #endif

 		read_lock(&tasklist_lock);
  		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
-			p->signal->tty = NULL;
+			tty_put(&p->signal->tty, 0, __FILE__, __LINE__);
  		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
 		if (o_tty)
 			do_each_task_pid(o_tty->session, PIDTYPE_SID, p) {
-				p->signal->tty = NULL;
+				tty_put(&p->signal->tty, 0, __FILE__, __LINE__);
 			} while_each_task_pid(o_tty->session, PIDTYPE_SID, p);
 		read_unlock(&tasklist_lock);
 	}

-	mutex_unlock(&tty_mutex);
+	spin_unlock(&tty_lock);

 	/* check whether both sides are closing ... */
 	if (!tty_closing || (o_tty && !o_tty_closing))
@@ -2034,11 +2032,11 @@ retry_open:
 	index  = -1;
 	retval = 0;
 	
-	mutex_lock(&tty_mutex);
-
+	spin_lock(&tty_lock);
+	
 	if (device == MKDEV(TTYAUX_MAJOR,0)) {
 		if (!current->signal->tty) {
-			mutex_unlock(&tty_mutex);
+			spin_unlock(&tty_lock);
 			return -ENXIO;
 		}
 		driver = current->signal->tty->driver;
@@ -2064,22 +2062,22 @@ #endif
 			noctty = 1;
 			goto got_driver;
 		}
-		mutex_unlock(&tty_mutex);
+		spin_unlock(&tty_lock);
 		return -ENODEV;
 	}

 	driver = get_tty_driver(device, &index);
 	if (!driver) {
-		mutex_unlock(&tty_mutex);
+		spin_unlock(&tty_lock);
 		return -ENODEV;
 	}
 got_driver:
 	retval = init_dev(driver, index, &tty);
-	mutex_unlock(&tty_mutex);
+	spin_unlock(&tty_lock);
 	if (retval)
 		return retval;

-	filp->private_data = tty;
+	filp->private_data = tty_get(tty, __FILE__, __LINE__);
 	file_move(filp, &tty->tty_files);
 	check_tty_count(tty, "tty_open");
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
@@ -2122,7 +2120,7 @@ #endif
 	    !current->signal->tty &&
 	    tty->session == 0) {
 	    	task_lock(current);
-		current->signal->tty = tty;
+		current->signal->tty = tty_get(tty, __FILE__, __LINE__);
 		task_unlock(current);
 		current->signal->tty_old_pgrp = 0;
 		tty->session = current->signal->session;
@@ -2161,15 +2159,15 @@ static int ptmx_open(struct inode * inod
 	}
 	up(&allocated_ptys_lock);

-	mutex_lock(&tty_mutex);
+	spin_lock(&tty_lock);
 	retval = init_dev(ptm_driver, index, &tty);
-	mutex_unlock(&tty_mutex);
+	spin_unlock(&tty_lock);
 	
 	if (retval)
 		goto out;

 	set_bit(TTY_PTY_LOCK, &tty->flags); /* LOCK THE SLAVE */
-	filp->private_data = tty;
+	filp->private_data = tty_get(tty, __FILE__, __LINE__);
 	file_move(filp, &tty->tty_files);

 	retval = -ENOMEM;
@@ -2359,14 +2357,14 @@ static int tiocsctty(struct tty_struct *

 			read_lock(&tasklist_lock);
 			do_each_task_pid(tty->session, PIDTYPE_SID, p) {
-				p->signal->tty = NULL;
+				tty_put(&p->signal->tty, 0, __FILE__, __LINE__);
 			} while_each_task_pid(tty->session, PIDTYPE_SID, p);
 			read_unlock(&tasklist_lock);
 		} else
 			return -EPERM;
 	}
 	task_lock(current);
-	current->signal->tty = tty;
+	current->signal->tty = tty_get(tty, __FILE__, __LINE__);
 	task_unlock(current);
 	current->signal->tty_old_pgrp = 0;
 	tty->session = current->signal->session;
@@ -2578,7 +2576,7 @@ int tty_ioctl(struct inode * inode, stru
 			if (current->signal->leader)
 				disassociate_ctty(0);
 			task_lock(current);
-			current->signal->tty = NULL;
+			tty_put(&current->signal->tty, 0, __FILE__, __LINE__);
 			task_unlock(current);
 			return 0;
 		case TIOCSCTTY:
@@ -2670,7 +2668,7 @@ #ifdef TTY_SOFT_SAK
 #else
 	struct tty_struct *tty = arg;
 	struct task_struct *g, *p;
-	int session;
+	pid_t session;
 	int		i;
 	struct file	*filp;
 	struct tty_ldisc *disc;
@@ -2914,6 +2912,11 @@ static void initialize_tty_struct(struct
 {
 	memset(tty, 0, sizeof(struct tty_struct));
 	tty->magic = TTY_MAGIC;
+	atomic_set(&tty->ref_count, 1);
+#ifdef DEBUG_TTY_REFCOUNT
+        printk("TTY ref count alloc: %p count %d\n",
+        		tty, atomic_read(&tty->ref_count));
+#endif		
 	tty_ldisc_assign(tty, tty_ldisc_get(N_TTY));
 	tty->pgrp = -1;
 	tty->overrun_time = jiffies;
diff --git a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
index a9247b5..97c36fc 100644
--- a/drivers/char/vc_screen.c
+++ b/drivers/char/vc_screen.c
@@ -474,14 +474,14 @@ static const struct file_operations vcs_

 static struct class *vc_class;

-void vcs_make_devfs(struct tty_struct *tty)
+void vcs_make_sysfs(struct tty_struct *tty)
 {
 	class_device_create(vc_class, NULL, MKDEV(VCS_MAJOR, tty->index + 1),
 			NULL, "vcs%u", tty->index + 1);
 	class_device_create(vc_class, NULL, MKDEV(VCS_MAJOR, tty->index + 129),
 			NULL, "vcsa%u", tty->index + 1);
 }
-void vcs_remove_devfs(struct tty_struct *tty)
+void vcs_remove_sysfs(struct tty_struct *tty)
 {
 	class_device_destroy(vc_class, MKDEV(VCS_MAJOR, tty->index + 1));
 	class_device_destroy(vc_class, MKDEV(VCS_MAJOR, tty->index + 129));
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index da7e66a..dd39020 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -128,8 +128,8 @@ #define CTRL_ALWAYS 0x0800f501	/* Cannot
 #define DEFAULT_BELL_PITCH	750
 #define DEFAULT_BELL_DURATION	(HZ/8)

-extern void vcs_make_devfs(struct tty_struct *tty);
-extern void vcs_remove_devfs(struct tty_struct *tty);
+extern void vcs_make_sysfs(struct tty_struct *tty);
+extern void vcs_remove_sysfs(struct tty_struct *tty);

 extern void console_map_init(void);
 #ifdef CONFIG_PROM_CONSOLE
@@ -2491,14 +2491,14 @@ static int con_open(struct tty_struct *t
 		if (ret == 0) {
 			struct vc_data *vc = vc_cons[currcons].d;
 			tty->driver_data = vc;
-			vc->vc_tty = tty;
+			vc->vc_tty = tty_get(tty, __FILE__, __LINE__);

 			if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
 				tty->winsize.ws_row = vc_cons[currcons].d->vc_rows;
 				tty->winsize.ws_col = vc_cons[currcons].d->vc_cols;
 			}
 			release_console_sem();
-			vcs_make_devfs(tty);
+			vcs_make_sysfs(tty);
 			return ret;
 		}
 	}
@@ -2510,30 +2510,25 @@ static int con_open(struct tty_struct *t
  * We take tty_mutex in here to prevent another thread from coming in
via init_dev
  * and taking a ref against the tty while we're in the process of forgetting
  * about it and cleaning things up.
- *
- * This is because vcs_remove_devfs() can sleep and will drop the BKL.
  */
 static void con_close(struct tty_struct *tty, struct file *filp)
 {
-	mutex_lock(&tty_mutex);
 	acquire_console_sem();
-	if (tty && tty->count == 1) {
+	if (tty && (tty->count == 1)) {
 		struct vc_data *vc = tty->driver_data;

 		if (vc)
-			vc->vc_tty = NULL;
+			tty_put(&vc->vc_tty, 0, __FILE__, __LINE__);
 		tty->driver_data = NULL;
 		release_console_sem();
-		vcs_remove_devfs(tty);
-		mutex_unlock(&tty_mutex);
+		vcs_remove_sysfs(tty);
 		/*
-		 * tty_mutex is released, but we still hold BKL, so there is
+		 * We still hold BKL, so there is
 		 * still exclusion against init_dev()
 		 */
 		return;
 	}
 	release_console_sem();
-	mutex_unlock(&tty_mutex);
 }

 static void vc_init(struct vc_data *vc, unsigned int rows,
diff --git a/drivers/net/ppp_async.c b/drivers/net/ppp_async.c
index 23659fd..d0e804c 100644
--- a/drivers/net/ppp_async.c
+++ b/drivers/net/ppp_async.c
@@ -165,7 +165,7 @@ ppp_asynctty_open(struct tty_struct *tty

 	/* initialize the asyncppp structure */
 	memset(ap, 0, sizeof(*ap));
-	ap->tty = tty;
+	ap->tty = tty_get(tty, __FILE__, __LINE__);
 	ap->mru = PPP_MRU;
 	spin_lock_init(&ap->xmit_lock);
 	spin_lock_init(&ap->recv_lock);
@@ -218,6 +218,7 @@ ppp_asynctty_close(struct tty_struct *tt
 	write_unlock_irq(&disc_data_lock);
 	if (ap == 0)
 		return;
+	tty_put(&ap->tty, 0, __FILE__, __LINE__);

 	/*
 	 * We have now ensured that nobody can start using ap from now
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index d5f636f..0b6e4e4 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1279,7 +1279,7 @@ static void uart_close(struct tty_struct
 	tty_ldisc_flush(tty);	
 	
 	tty->closing = 0;
-	state->info->tty = NULL;
+	tty_put(&state->info->tty, 0, __FILE__, __LINE__);

 	if (state->info->blocked_open) {
 		if (state->close_delay)
@@ -1375,6 +1375,7 @@ static void uart_hangup(struct tty_struc
 		uart_shutdown(state);
 		state->count = 0;
 		state->info->flags &= ~UIF_NORMAL_ACTIVE;
+		tty_put(&state->info->tty, 0, __FILE__, __LINE__);
 		state->info->tty = NULL;
 		wake_up_interruptible(&state->info->open_wait);
 		wake_up_interruptible(&state->info->delta_msr_wait);
@@ -1598,7 +1599,7 @@ static int uart_open(struct tty_struct *
 	tty->driver_data = state;
 	tty->low_latency = (state->port->flags & UPF_LOW_LATENCY) ? 1 : 0;
 	tty->alt_speed = 0;
-	state->info->tty = tty;
+	state->info->tty = tty_get(tty, __FILE__, __LINE__);

 	/*
 	 * If the port is in the middle of closing, bail out now.
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 3670d77..06e96df 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -451,7 +451,7 @@ static int acm_tty_open(struct tty_struc
 		rv = 0;

 	tty->driver_data = acm;
-	acm->tty = tty;
+	acm->tty = tty_get(tty, __FILE__, __LINE__);

 	/* force low_latency on so that our tty_push actually forces the data through,
 	   otherwise it is scheduled, and with high data rates data can get lost. */
@@ -519,6 +519,7 @@ static void acm_tty_close(struct tty_str
 		return;

 	nr = acm->rx_buflimit;
+	tty_put(&acm->tty, 0, __FILE__, __LINE__);
 	mutex_lock(&open_mutex);
 	if (!--acm->used) {
 		if (acm->dev) {
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index f7aef5b..74eb9de 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -177,7 +177,7 @@ int devpts_pty_new(struct tty_struct *tt
 	inode->i_gid = config.setgid ? config.gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	init_special_inode(inode, S_IFCHR|config.mode, device);
-	inode->u.generic_ip = tty;
+	inode->u.generic_ip = tty_get(tty, __FILE__, __LINE__);

 	dentry = get_node(number);
 	if (!IS_ERR(dentry) && !dentry->d_inode)
@@ -212,6 +212,8 @@ void devpts_pty_kill(int number)
 	if (!IS_ERR(dentry)) {
 		struct inode *inode = dentry->d_inode;
 		if (inode) {
+			tty_put((struct tty_struct **)(&inode->u.generic_ip),
+						 0, __FILE__, __LINE__);
 			inode->i_nlink--;
 			d_delete(dentry);
 			dput(dentry);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index b3b807e..f159a12 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -181,14 +181,15 @@ struct device;
  */
 struct tty_struct {
 	int	magic;
+	atomic_t ref_count;
 	struct tty_driver *driver;
 	int index;
 	struct tty_ldisc ldisc;
 	struct semaphore termios_sem;
 	struct termios *termios, *termios_locked;
 	char name[64];
-	int pgrp;
-	int session;
+	pid_t pgrp;
+	pid_t session;
 	unsigned long flags;
 	int count;
 	struct winsize winsize;
@@ -267,6 +268,44 @@ #define TTY_HUPPED 		18	/* Post driver->

 #define TTY_WRITE_FLUSH(tty) tty_write_flush((tty))

+#undef DEBUG_TTY_REFCOUNT
+static inline struct tty_struct *
+tty_get(struct tty_struct * tty, char *file, int line)
+{
+        if (tty) {
+                WARN_ON(!atomic_read(&tty->ref_count));
+                atomic_inc(&tty->ref_count);
+#ifdef DEBUG_TTY_REFCOUNT
+		printk("TTY ref count get: %s:%d %s %p count %d\n", file,
+			line, tty->name, tty, atomic_read(&tty->ref_count));
+#endif
+        }
+        return tty;
+}
+
+extern void free_tty_struct(struct tty_struct *tty);
+static inline void
+tty_put(struct tty_struct ** tty, int free_me, char *file, int line)
+{
+	int count;
+	
+        if (*tty) {
+        	count = atomic_dec_return(&(*tty)->ref_count);
+        	if (count == 0) {
+                	WARN_ON(!free_me);
+	                free_tty_struct(*tty);
+#ifdef DEBUG_TTY_REFCOUNT
+			printk("TTY ref count put freed: %s:%d %s %p\n",
+				file, line, (*tty)->name, *tty);
+	        } else {
+			printk("TTY ref count put: %s:%d %s %p count %d\n",
+				file, line, (*tty)->name, *tty, count);
+#endif
+        	}
+        	*tty = NULL;
+        }
+}
+
 extern void tty_write_flush(struct tty_struct *);

 extern struct termios tty_std_termios;
@@ -319,8 +358,6 @@ extern void tty_ldisc_put(int);
 extern void tty_wakeup(struct tty_struct *tty);
 extern void tty_ldisc_flush(struct tty_struct *tty);

-extern struct mutex tty_mutex;
-
 /* n_tty.c */
 extern struct tty_ldisc tty_ldisc_N_TTY;

diff --git a/kernel/exit.c b/kernel/exit.c
index 6664c08..a6cc755 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -108,6 +108,7 @@ static void __exit_signal(struct task_st
 		sig->nvcsw += tsk->nvcsw;
 		sig->nivcsw += tsk->nivcsw;
 		sig->sched_time += tsk->sched_time;
+		tty_put(&sig->tty, 0, __FILE__, __LINE__);
 		sig = NULL; /* Marker for below. */
 	}

@@ -391,9 +392,7 @@ void daemonize(const char *name, ...)
 	exit_mm(current);

 	set_special_pids(1, 1);
-	mutex_lock(&tty_mutex);
-	current->signal->tty = NULL;
-	mutex_unlock(&tty_mutex);
+	tty_put(&current->signal->tty, 0, __FILE__, __LINE__);

 	/* Block and flush all signals */
 	sigfillset(&blocked);
diff --git a/kernel/fork.c b/kernel/fork.c
index 56e4e07..90cc4e3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -43,6 +43,7 @@ #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/tty.h>

 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -856,6 +857,7 @@ static inline int copy_signal(unsigned l

 	sig->leader = 0;	/* session leadership doesn't inherit */
 	sig->tty_old_pgrp = 0;
+	sig->tty = NULL;

 	sig->utime = sig->stime = sig->cutime = sig->cstime = cputime_zero;
 	sig->nvcsw = sig->nivcsw = sig->cnvcsw = sig->cnivcsw = 0;
@@ -885,6 +887,7 @@ static inline int copy_signal(unsigned l
 void __cleanup_signal(struct signal_struct *sig)
 {
 	exit_thread_group_keys(sig);
+	tty_put(&sig->tty, 0, __FILE__, __LINE__);
 	kmem_cache_free(signal_cachep, sig);
 }

@@ -1227,7 +1230,8 @@ #endif
 			__ptrace_link(p, current->parent);

 		if (thread_group_leader(p)) {
-			p->signal->tty = current->signal->tty;
+			p->signal->tty = tty_get(current->signal->tty,
+						__FILE__, __LINE__);
 			p->signal->pgrp = process_group(current);
 			p->signal->session = current->signal->session;
 			attach_pid(p, PIDTYPE_PGID, process_group(p));
diff --git a/kernel/sys.c b/kernel/sys.c
index dbb3b9c..31f486a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1379,7 +1379,6 @@ asmlinkage long sys_setsid(void)
 	pid_t session;
 	int err = -EPERM;

-	mutex_lock(&tty_mutex);
 	write_lock_irq(&tasklist_lock);

 	/* Fail if I am already a session leader */
@@ -1399,12 +1398,11 @@ asmlinkage long sys_setsid(void)

 	group_leader->signal->leader = 1;
 	__set_special_pids(session, session);
-	group_leader->signal->tty = NULL;
+	tty_put(&group_leader->signal->tty, 0, __FILE__, __LINE__);
 	group_leader->signal->tty_old_pgrp = 0;
 	err = process_group(group_leader);
 out:
 	write_unlock_irq(&tasklist_lock);
-	mutex_unlock(&tty_mutex);
 	return err;
 }

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 24caaee..db53c4e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1638,7 +1638,8 @@ static inline void flush_unauthorized_fi
 			if (inode_has_perm(current, inode,
 					   FILE__READ | FILE__WRITE, NULL)) {
 				/* Reset controlling tty. */
-				current->signal->tty = NULL;
+				tty_put(&current->signal->tty, 0,
+						__FILE__, __LINE__);
 				current->signal->tty_old_pgrp = 0;
 			}
 		}
