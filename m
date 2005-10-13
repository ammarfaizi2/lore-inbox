Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbVJMFwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVJMFwB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 01:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbVJMFwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 01:52:00 -0400
Received: from koto.vergenet.net ([210.128.90.7]:5868 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751400AbVJMFv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 01:51:59 -0400
Date: Thu, 13 Oct 2005 14:51:34 +0900
From: Horms <horms@verge.net.au>
To: Harald Welte <laforge@gnumonks.org>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, security@linux.kernel.org,
       vendor-sec@lst.de
Subject: Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20051013055132.GA4296@verge.net.au>
References: <20050927165206.GB20466@master.mivlgu.local> <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org> <20050930104749.GN4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org> <20050930184433.GF16352@shell0.pdx.osdl.net> <20051011094550.GI4290@rama>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051011094550.GI4290@rama>
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 11:45:51AM +0200, Harald Welte wrote:
> On Mon, Oct 10, 2005 at 11:07:45AM -0700, Chris Wright wrote:
> > * Harald Welte (laforge@gnumonks.org) wrote:
> > > diff --git a/kernel/signal.c b/kernel/signal.c
> > > --- a/kernel/signal.c
> > > +++ b/kernel/signal.c
> > > @@ -1193,6 +1193,40 @@ kill_proc_info(int sig, struct siginfo *
> > >  	return error;
> > >  }
> > >  
> > > +/* like kill_proc_info(), but doesn't use uid/euid of "current" */
> > 
> > Maybe additional comment reminding that you most likely don't want this
> > interface.
> > 
> > Also, looks like there's same issue again:

I know this patch is going to get rediffed before being applied to 
Linus's tree, but in case anyone cares, here is a version that hasn't
been mangled - all the copies I found on online archives seemed to
have some encoding junk in there.

I did this by hand, so an error may have crept in.
It seems to apply cleanly to 2.6.13 (and 2.6.12).
I haven't done any additional testing, 
like say trying to compile it.

-- 
Horms

Mh, didn't hit that bug since I don't use disconnect signals.  But it
looks like it has the same issue.

Please consider the patch below, it

1) changes pid_t to uid_t
2) exports the symbol
3) adresses the same task_struct referencing issue for disconnect
   signals

I hope this now finally is the last take ;)


[USBDEVIO] Fix Oops in usbdevio async URB completion (CAN-2005-3055)

If a process issues an URB from userspace and (starts to) terminate
before the URB comes back, we run into the issue described above.  This
is because the urb saves a pointer to "current" when it is posted to the
device, but there's no guarantee that this pointer is still valid
afterwards.

This basically means that any userspace process with permissions to
any arbitrary USB device can Ooops any kernel.(!)

In fact, there are two separate issues:

1) the pointer to "current" can become invalid, since the task could be
   completely gone when the URB completion comes back from the device.

2) Even if the saved task pointer is still pointing to a valid task_struct,
   task_struct->sighand could have gone meanwhile.  Therefore, the USB
   async URB completion handler needs to reliably check whether
   task_struct->sighand is still valid or not.  In order to prevent a
   race with __exit_sighand(), it needs to grab a
   read_lock(&tasklist_lock).  This strategy seems to work, since the
   send_sig_info() code uses the same protection.
   However, we now would need to export a __send_sig_info() function, one
   that expects to be called with read_lock(&tasklist_lock) already held by
   the caller.

So what we do instead, is to save the PID of the process, and introduce a
new kill_proc_info_as_uid() function.  Yes, pid's can and will wrap, so
this is just a short-term fix until usbfs2 will appear.

Signed-off-by: Harald Welte <laforge@gnumonks.org>

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -30,6 +30,8 @@
  *  Revision history
  *    22.12.1999   0.1   Initial release (split from proc_usb.c)
  *    04.01.2000   0.2   Turned into its own filesystem
+ *    30.09.2005   0.3   Fix user-triggerable oops in async URB delivery
+ *    			 (CAN-2005-3055)
  */

 /*****************************************************************************/
@@ -58,7 +60,8 @@ static struct class *usb_device_class;
 struct async {
 	struct list_head asynclist;
 	struct dev_state *ps;
-	struct task_struct *task;
+	pid_t pid;
+	uid_t uid, euid;
 	unsigned int signr;
 	unsigned int ifnum;
 	void __user *userbuffer;
@@ -290,7 +293,8 @@ static void async_completed(struct urb *
 		sinfo.si_errno = as->urb->status;
 		sinfo.si_code = SI_ASYNCIO;
 		sinfo.si_addr = as->userurb;
-		send_sig_info(as->signr, &sinfo, as->task);
+		kill_proc_info_as_uid(as->signr, &sinfo, as->pid, as->uid,
+				      as->euid);
 	}
         wake_up(&ps->wait);
 }
@@ -525,9 +529,11 @@ static int usbdev_open(struct inode *ino
 	INIT_LIST_HEAD(&ps->async_pending);
 	INIT_LIST_HEAD(&ps->async_completed);
 	init_waitqueue_head(&ps->wait);
-	ps->discsignr = 0;
-	ps->disctask = current;
-	ps->disccontext = NULL;
+	ps->disc.signr = 0;
+	ps->disc.pid = current->pid;
+	ps->disc.uid = current->uid;
+	ps->disc.euid = current->euid;
+	ps->disc.context = NULL;
 	ps->ifclaimed = 0;
 	wmb();
 	list_add_tail(&ps->list, &dev->filelist);
@@ -988,7 +994,9 @@ static int proc_do_submiturb(struct dev_
 		as->userbuffer = NULL;
 	as->signr = uurb->signr;
 	as->ifnum = ifnum;
-	as->task = current;
+	as->pid = current->pid;
+	as->uid = current->uid;
+	as->euid = current->euid;
 	if (!(uurb->endpoint & USB_DIR_IN)) {
 		if (copy_from_user(as->urb->transfer_buffer, uurb->buffer, as->urb->transfer_buffer_length)) {
 			free_async(as);
@@ -1203,8 +1211,8 @@ static int proc_disconnectsignal(struct
 		return -EFAULT;
 	if (ds.signr != 0 && (ds.signr < SIGRTMIN || ds.signr > SIGRTMAX))
 		return -EINVAL;
-	ps->discsignr = ds.signr;
-	ps->disccontext = ds.context;
+	ps->disc.signr = ds.signr;
+	ps->disc.context = ds.context;
 	return 0;
 }

diff --git a/drivers/usb/core/inode.c b/drivers/usb/core/inode.c
--- a/drivers/usb/core/inode.c
+++ b/drivers/usb/core/inode.c
@@ -708,12 +708,14 @@ void usbfs_remove_device(struct usb_devi
 		ds = list_entry(dev->filelist.next, struct dev_state, list);
 		wake_up_all(&ds->wait);
 		list_del_init(&ds->list);
-		if (ds->discsignr) {
+		if (ds->disc.signr) {
 			sinfo.si_signo = SIGPIPE;
 			sinfo.si_errno = EPIPE;
 			sinfo.si_code = SI_ASYNCIO;
-			sinfo.si_addr = ds->disccontext;
-			send_sig_info(ds->discsignr, &sinfo, ds->disctask);
+			sinfo.si_addr = ds->disc.context;
+			kill_proc_info_as_uid(ds->disc.signr, &sinfo,
+					      ds->disc.pid, ds->disc.uid,
+					      ds->disc.euid);
 		}
 	}
 	usbfs_update_special();
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -51,9 +51,12 @@ struct dev_state {
 	struct list_head async_pending;
 	struct list_head async_completed;
 	wait_queue_head_t wait;     /* wake up if a request completed */
-	unsigned int discsignr;
-	struct task_struct *disctask;
-	void __user *disccontext;
+	struct {
+		unsigned int signr;
+		pid_t pid;
+		uid_t uid, euid;
+		void __user *context;
+	} disc;
 	unsigned long ifclaimed;
 };

diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1018,6 +1018,7 @@ extern int force_sig_info(int, struct si
 extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
 extern int kill_pg_info(int, struct siginfo *, pid_t);
 extern int kill_proc_info(int, struct siginfo *, pid_t);
+extern int kill_proc_info_as_uid(int, struct siginfo *, pid_t, uid_t, uid_t);
 extern void do_notify_parent(struct task_struct *, int);
 extern void force_sig(int, struct task_struct *);
 extern void force_sig_specific(int, struct task_struct *);
diff --git a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1193,6 +1193,42 @@ kill_proc_info(int sig, struct siginfo *
 	return error;
 }

+/* This is like kill_proc_info(), but doesn't use uid/euid of "current".
+ * Most likely this function is not what you want, it was added as a special
+ * case for usbdevio */
+int
+kill_proc_info_as_uid(int sig, struct siginfo *info, pid_t pid,
+		      uid_t uid, uid_t euid)
+{
+	int ret = -EINVAL;
+	struct task_struct *p;
+
+	if (!valid_signal(sig))
+		return ret;
+
+	read_lock(&tasklist_lock);
+	p = find_task_by_pid(pid);
+	if (!p) {
+		ret = -ESRCH;
+		goto out_unlock;
+	}
+	if ((!info || ((unsigned long)info != 1 &&
+			(unsigned long)info != 2 && SI_FROMUSER(info)))
+	    && (euid ^ p->suid) && (euid ^ p->uid)
+	    && (uid ^ p->suid) && (uid ^ p->uid)) {
+		ret = -EPERM;
+		goto out_unlock;
+	}
+	if (sig && p->sighand) {
+		unsigned long flags;
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		ret = __group_send_sig_info(sig, info, p);
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	}
+out_unlock:
+	read_unlock(&tasklist_lock);
+	return ret;
+}

 /*
  * kill_something_info() interprets pid in interesting ways just like kill (2).
@@ -1974,6 +2010,7 @@ EXPORT_SYMBOL(flush_signals);
 EXPORT_SYMBOL(force_sig);
 EXPORT_SYMBOL(kill_pg);
 EXPORT_SYMBOL(kill_proc);
+EXPORT_SYMBOL_GPL(kill_proc_info_as_uid);
 EXPORT_SYMBOL(ptrace_notify);
 EXPORT_SYMBOL(send_sig);
 EXPORT_SYMBOL(send_sig_info);



