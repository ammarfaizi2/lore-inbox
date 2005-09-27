Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbVI0M60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVI0M60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVI0M60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:58:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:31617 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964919AbVI0M60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:58:26 -0400
Date: Tue, 27 Sep 2005 05:57:55 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, Harald Welte <laforge@gnumonks.org>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       vendor-sec@lst.de, security@linux.kernel.org
Subject: Re: [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050927125755.GA10738@kroah.com>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <20050927080413.GA13149@kroah.com> <20050927124846.GA29649@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927124846.GA29649@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 01:48:46PM +0100, Christoph Hellwig wrote:
> On Tue, Sep 27, 2005 at 01:04:15AM -0700, Greg KH wrote:
> > First off, thanks for providing a patch for this problem, it is real,
> > and has been known for a while (thanks to your debugging :)
> > 
> > On Sun, Sep 25, 2005 at 05:13:30PM +0200, Harald Welte wrote:
> > > 
> > > I suggest this (or any other) fix to be applied to both 2.6.14 final and
> > > the stable series.  I didn't yet investigate 2.4.x, but I think it is
> > > likely to have the same problem.
> > 
> > I agree, but I think we need an EXPORT_SYMBOL_GPL() for your newly
> > exported symbol, otherwise the kernel will not build if you have USB
> > built as a module.
> 
> Where's the actual patch?  And no, we certainly shouldn't export anything
> to put a task_struct.

Earlier in this thread, on these mailing lists.

I've included it below too.

thanks,

greg k-h


From: Harald Welte <laforge@gnumonks.org>
Subject: USB: fix oops while completing async USB via usbdevio

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
   This can be fixed by get_task_struct() / put_task_struct().

2) Even if the saved task pointer is still pointing to a valid task_struct,
   task_struct->sighand could have gone meanwhile.  Therefore, the USB
   async URB completion handler needs to reliably check whether
   task_struct->sighand is still valid or not.  In order to prevent a
   race with __exit_sighand(), it needs to grab a
   read_lock(&tasklist_lock).  This strategy seems to work, since the
   send_sig_info() code uses the same protection.
   However, we now need to export a __send_sig_info() function, one that
   expects to be called with read_lock(&tasklist_lock) already held by the
   caller.  It's ugly, but I doubt there is a less invasive solution.

Signed-off-by: Harald Welte <laforge@gnumonks.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -44,6 +44,7 @@
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
 #include <linux/cdev.h>
+#include <linux/sched.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 #include <linux/moduleparam.h>
@@ -231,6 +232,10 @@ static inline void async_newpending(stru
         struct dev_state *ps = as->ps;
         unsigned long flags;
         
+	/* increase refcount to task, so our as->task pointer is still
+	 * valid when URB comes back -HW */
+	get_task_struct(current);
+
         spin_lock_irqsave(&ps->lock, flags);
         list_add_tail(&as->asynclist, &ps->async_pending);
         spin_unlock_irqrestore(&ps->lock, flags);
@@ -244,8 +249,12 @@ static inline void async_removepending(s
         spin_lock_irqsave(&ps->lock, flags);
         list_del_init(&as->asynclist);
         spin_unlock_irqrestore(&ps->lock, flags);
+
+	put_task_struct(as->task);
 }
 
+/* get a completed URB from async list.  Task reference has already been
+ * dropped in async_complete() */
 static inline struct async *async_getcompleted(struct dev_state *ps)
 {
         unsigned long flags;
@@ -260,6 +269,7 @@ static inline struct async *async_getcom
         return as;
 }
 
+/* find matching URB from pending list.  Drop refcount of task */
 static inline struct async *async_getpending(struct dev_state *ps, void __user *userurb)
 {
         unsigned long flags;
@@ -270,6 +280,7 @@ static inline struct async *async_getpen
 		if (as->userurb == userurb) {
 			list_del_init(&as->asynclist);
 			spin_unlock_irqrestore(&ps->lock, flags);
+			put_task_struct(as->task);
 			return as;
 		}
         spin_unlock_irqrestore(&ps->lock, flags);
@@ -290,8 +301,15 @@ static void async_completed(struct urb *
 		sinfo.si_errno = as->urb->status;
 		sinfo.si_code = SI_ASYNCIO;
 		sinfo.si_addr = as->userurb;
-		send_sig_info(as->signr, &sinfo, as->task);
+		read_lock(&tasklist_lock);
+		/* The task could be dying. We hold a reference to it,
+		 * but that doesn't prevent __exit_sighand() from zeroing
+		 * sighand -HW */
+		if (as->task->sighand)
+			__send_sig_info(as->signr, &sinfo, as->task);
+		read_unlock(&tasklist_lock);
 	}
+	put_task_struct(as->task);
         wake_up(&ps->wait);
 }
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -999,6 +999,7 @@ extern void block_all_signals(int (*noti
 			      sigset_t *mask);
 extern void unblock_all_signals(void);
 extern void release_task(struct task_struct * p);
+extern int __send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int send_group_sig_info(int, struct siginfo *, struct task_struct *);
 extern int force_sigsegv(int, struct task_struct *);
diff --git a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1230,12 +1230,11 @@ static int kill_something_info(int sig, 
  * These are for backward compatibility with the rest of the kernel source.
  */
 
-/*
- * These two are the most common entry points.  They send a signal
- * just to the specific thread.
- */
+
+/* This is send_sig_info() for callers that already hold the tasklist_lock.
+ * At the moment the only caller is USB devfio async URB delivery.  */
 int
-send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
+__send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
 	int ret;
 	unsigned long flags;
@@ -1247,6 +1246,23 @@ send_sig_info(int sig, struct siginfo *i
 	if (!valid_signal(sig))
 		return -EINVAL;
 
+	spin_lock_irqsave(&p->sighand->siglock, flags);
+	ret = specific_send_sig_info(sig, info, p);
+	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+
+	return ret;
+}
+
+/*
+ * These two are the most common entry points.  They send a signal
+ * just to the specific thread.
+ */
+
+int
+send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
+{
+	int ret;
+
 	/*
 	 * We need the tasklist lock even for the specific
 	 * thread case (when we don't need to follow the group
@@ -1254,9 +1270,7 @@ send_sig_info(int sig, struct siginfo *i
 	 * going away or changing from under us.
 	 */
 	read_lock(&tasklist_lock);  
-	spin_lock_irqsave(&p->sighand->siglock, flags);
-	ret = specific_send_sig_info(sig, info, p);
-	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	ret = __send_sig_info(sig, info, p);
 	read_unlock(&tasklist_lock);
 	return ret;
 }
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDNr6aXaXGVTD0i/8RAu9FAKCbbV491NzCY42YTkXo7XSzbRRO1QCgnM2K
j+Ae+NblrsPc6Jy9ICWOtyw=
=Ldn9
-----END PGP SIGNATURE-----

