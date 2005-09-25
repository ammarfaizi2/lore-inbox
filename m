Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbVIYPNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbVIYPNe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbVIYPNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:13:34 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:13748 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751512AbVIYPNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:13:33 -0400
Date: Sun, 25 Sep 2005 17:13:30 +0200
From: Harald Welte <laforge@gnumonks.org>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, vendor-sec@lst.de
Subject: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050925151330.GL731@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bdxr40zIsfYDFWP1"
Content-Disposition: inline
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.2 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi! I've been working on some userspace usb drivers in
	which I use the asynchronous usb devio URB delivery to usrerspace.
	There have always been some bug reports of kernel oopses while
	terminating a program that uses the driver. [...] 
	Content analysis details:   (0.2 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 TW_VF                  BODY: Odd Letter Triples with VF
	0.1 TW_EV                  BODY: Odd Letter Triples with EV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bdxr40zIsfYDFWP1
Content-Type: multipart/mixed; boundary="3vPM4r6bCybeb41V"
Content-Disposition: inline


--3vPM4r6bCybeb41V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've been working on some userspace usb drivers in which I use the
asynchronous usb devio URB delivery to usrerspace.

There have always been some bug reports of kernel oopses while
terminating a program that uses the driver.

Now I found out a way to relatively easy trigger that oops from pcscd
(part of pcsc-lite) on any kernel, at least tested with 2.6.8 to 2.6.14-rc2.

Call Trace:                                                                =
   =20
 [<c0103dbf>] show_stack+0x7f/0xa0
 [<c0103f60>] show_registers+0x160/0x1c0
 [<c0104156>] die+0xf6/0x1a0           =20
 [<c0112cd6>] do_page_fault+0x356/0x68f
 [<c01039bf>] error_code+0x4f/0x54    =20
 [<c0125fa9>] send_sig_info+0x39/0x80
 [<c023cfd9>] async_completed+0xa9/0xb0
 [<c0237e31>] usb_hcd_giveback_urb+0x31/0x80
 [<f8a21e84>] finish_urb+0x74/0x100 [ohci_hcd]
 [<f8a22f88>] finish_unlinks+0x2b8/0x2e0 [ohci_hcd]
 [<f8a23d1d>] ohci_irq+0x17d/0x190 [ohci_hcd]     =20
 [<c0237eb8>] usb_hcd_irq+0x38/0x70         =20
 [<c0139ab3>] handle_IRQ_event+0x33/0x70
 [<c0139bcd>] __do_IRQ+0xdd/0x150      =20
 [<c010551c>] do_IRQ+0x1c/0x30  =20
 [<c010388a>] common_interrupt+0x1a/0x20

So what do we learn from that?  That usb_hcd_giveback_urb() is called
=66rom in_interrupt() context and calls async_completed().=20

async_completed() calls send_sig_info(), which in turn does a
spin_lock(&tasklist_lock) to protect itself from task_struct->sighand
=66rom going away.  However, the call to
"spin_lock_irqsave(task_struct->sighand->siglock)" causes an oops,
because "sighand" has disappeared.

If a process issues an URB from userspace and (starts to) terminate
before the URB comes back, we run into the issue described above.  This
is because the urb saves a pointer to "current" when it is posted to the
device, but there's no guarantee that this pointer is still valid
afterwards. =20

This basically means that any userspace process with permissions to=20
any arbitrary USB device can Ooops any kernel.(!)

In fact, there are two separate issues:

1) the pointer to "current" can become invalid, since the task could be
   completely gone when the URB completion comes back from the device.
   This can be fixed by get_task_struct() / put_task_struct().

2) Even if the saved task pointer is still pointing to a valid task_struct,=
=20
   task_struct->sighand could have gone meanwhile.  Therefore, the USB
   async URB completion handler needs to reliably check whether
   task_struct->sighand is still valid or not.  In order to prevent a
   race with __exit_sighand(), it needs to grab a
   read_lock(&tasklist_lock).  This strategy seems to work, since the
   send_sig_info() code uses the same protection. =20
   However, we now need to export a __send_sig_info() function, one that
   expects to be called with read_lock(&tasklist_lock) already held by
   the caller.  It's ugly, but I doubt there is a less invasive
   solution.

Expected FAQ's:

a) Q: But grabbing references to "current" and delivering URB completion
      via signals is totally invalid and broken in may ways !
   A: Yes, but dozens of userspace apps/drivers rely on this broken API.
      As long as there's no new, sane, usbdevio2, we cannot just rip it
      out without a replacement.

b) Q: Why can't wa use the normal SIGIO mechanism?
   A: Because the usbdevio API needs to pass a __user pointer to the URB
      along the delivered signal.

c) Q: If this is a local DoS, why did you post it publicly?
   A: Because I've already informed linux-usb-devel in May.

I suggest this (or any other) fix to be applied to both 2.6.14 final and
the stable series.  I didn't yet investigate 2.4.x, but I think it is
likely to have the same problem.

Cheers,
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--3vPM4r6bCybeb41V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.12-rc2-usbdevio-asyncurb.patch"
Content-Transfer-Encoding: quoted-printable

[USBDEVIO] Fix user-triggerable Oops in usbdevio async URB completion

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

---
commit 9ad1a957d398111814a4a7e6ff0c5dcc1057f780
tree ef486dfd7ac02c1a18b04c35caaf10c5699f7bce
parent 5ad0f056192213b2f6ac9910f754be9e6abea574
author Harald Welte <laforge@hanuman.de.gnumonks.org> Sun, 25 Sep 2005 17:1=
2:38 +0200
committer Harald Welte <laforge@hanuman.de.gnumonks.org> Sun, 25 Sep 2005 1=
7:12:38 +0200

 drivers/usb/core/devio.c |   20 +++++++++++++++++++-
 include/linux/sched.h    |    1 +
 kernel/signal.c          |   30 ++++++++++++++++++++++--------
 3 files changed, 42 insertions(+), 9 deletions(-)

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
         struct dev_state *ps =3D as->ps;
         unsigned long flags;
        =20
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
=20
+/* get a completed URB from async list.  Task reference has already been
+ * dropped in async_complete() */
 static inline struct async *async_getcompleted(struct dev_state *ps)
 {
         unsigned long flags;
@@ -260,6 +269,7 @@ static inline struct async *async_getcom
         return as;
 }
=20
+/* find matching URB from pending list.  Drop refcount of task */
 static inline struct async *async_getpending(struct dev_state *ps, void __=
user *userurb)
 {
         unsigned long flags;
@@ -270,6 +280,7 @@ static inline struct async *async_getpen
 		if (as->userurb =3D=3D userurb) {
 			list_del_init(&as->asynclist);
 			spin_unlock_irqrestore(&ps->lock, flags);
+			put_task_struct(as->task);
 			return as;
 		}
         spin_unlock_irqrestore(&ps->lock, flags);
@@ -290,8 +301,15 @@ static void async_completed(struct urb *
 		sinfo.si_errno =3D as->urb->status;
 		sinfo.si_code =3D SI_ASYNCIO;
 		sinfo.si_addr =3D as->userurb;
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
=20
diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -999,6 +999,7 @@ extern void block_all_signals(int (*noti
 			      sigset_t *mask);
 extern void unblock_all_signals(void);
 extern void release_task(struct task_struct * p);
+extern int __send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int send_group_sig_info(int, struct siginfo *, struct task_struct *=
);
 extern int force_sigsegv(int, struct task_struct *);
diff --git a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1230,12 +1230,11 @@ static int kill_something_info(int sig,=20
  * These are for backward compatibility with the rest of the kernel source.
  */
=20
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
=20
+	spin_lock_irqsave(&p->sighand->siglock, flags);
+	ret =3D specific_send_sig_info(sig, info, p);
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
 	read_lock(&tasklist_lock); =20
-	spin_lock_irqsave(&p->sighand->siglock, flags);
-	ret =3D specific_send_sig_info(sig, info, p);
-	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	ret =3D __send_sig_info(sig, info, p);
 	read_unlock(&tasklist_lock);
 	return ret;
 }

--3vPM4r6bCybeb41V--

--bdxr40zIsfYDFWP1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDNr6aXaXGVTD0i/8RAu9FAKCbbV491NzCY42YTkXo7XSzbRRO1QCgnM2K
j+Ae+NblrsPc6Jy9ICWOtyw=
=Ldn9
-----END PGP SIGNATURE-----

--bdxr40zIsfYDFWP1--
