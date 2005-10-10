Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVJJRom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVJJRom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVJJRom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:44:42 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:4538 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751089AbVJJRol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:44:41 -0400
Date: Mon, 10 Oct 2005 19:44:29 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       security@linux.kernel.org, vendor-sec@lst.de
Subject: Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20051010174429.GH5627@rama>
References: <20050927160029.GA20466@master.mivlgu.local> <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local> <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org> <20050930104749.GN4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org> <20050930184433.GF16352@shell0.pdx.osdl.net> <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org> <20050930220808.GE4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509301514190.3378@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0509301514190.3378@g5.osdl.org>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2005 at 03:16:28PM -0700, Linus Torvalds wrote:
>=20
>=20
> On Sat, 1 Oct 2005, Harald Welte wrote:
> >=20
> > please find the patch below.  It compiles, but I didn't yet have the
> > time to verify it makes the bug disappear and the async urb delivery is
> > still working.
>=20
> No, you can't re-use "check_kill_permissions()" like this, even though I=
=20
> do understand the appeal.
>=20
> The generic kill permissions check things like the current session, and=
=20
> whether the caller has extra permissions, neither of which is sensible in=
=20
> the context of "group_send_sig_info_as_uid()". So you do need to write ou=
t=20
> the uid/euid checks separately, and have a different function for this=20
> thing.

Sorry, I've been busy, mostly with the annual netfilter developer
workshop. What about the following proposed fix:

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

---
commit c630b8abcd6aa848c2b2b2e546820fa0a7dd0736
tree 0b48db1d918299cc07311b01b2a2dbc8c592a852
parent e759eaa9e9e92330c5fcfd760d767d4f39375a03
author Harald Welte <laforge@netfilter.org> Mon, 10 Oct 2005 19:42:46 +0200
committer Harald Welte <laforge@netfilter.org> Mon, 10 Oct 2005 19:42:46 +0=
200

 drivers/usb/core/devio.c |   12 +++++++++---
 include/linux/sched.h    |    1 +
 kernel/signal.c          |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)

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
=20
 /*************************************************************************=
****/
@@ -58,7 +60,8 @@ static struct class *usb_device_class;
 struct async {
 	struct list_head asynclist;
 	struct dev_state *ps;
-	struct task_struct *task;
+	pid_t pid;
+	pid_t uid, euid;
 	unsigned int signr;
 	unsigned int ifnum;
 	void __user *userbuffer;
@@ -290,7 +293,8 @@ static void async_completed(struct urb *
 		sinfo.si_errno =3D as->urb->status;
 		sinfo.si_code =3D SI_ASYNCIO;
 		sinfo.si_addr =3D as->userurb;
-		send_sig_info(as->signr, &sinfo, as->task);
+		kill_proc_info_as_uid(as->signr, &sinfo, as->pid, as->uid,=20
+				      as->euid);
 	}
         wake_up(&ps->wait);
 }
@@ -988,7 +992,9 @@ static int proc_do_submiturb(struct dev_
 		as->userbuffer =3D NULL;
 	as->signr =3D uurb->signr;
 	as->ifnum =3D ifnum;
-	as->task =3D current;
+	as->pid =3D current->pid;
+	as->uid =3D current->uid;
+	as->euid =3D current->euid;
 	if (!(uurb->endpoint & USB_DIR_IN)) {
 		if (copy_from_user(as->urb->transfer_buffer, uurb->buffer, as->urb->tran=
sfer_buffer_length)) {
 			free_async(as);
diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1018,6 +1018,7 @@ extern int force_sig_info(int, struct si
 extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
 extern int kill_pg_info(int, struct siginfo *, pid_t);
 extern int kill_proc_info(int, struct siginfo *, pid_t);
+extern int kill_proc_info_as_uid(int, struct siginfo *, pid_t, pid_t, pid_=
t);
 extern void do_notify_parent(struct task_struct *, int);
 extern void force_sig(int, struct task_struct *);
 extern void force_sig_specific(int, struct task_struct *);
diff --git a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1193,6 +1193,40 @@ kill_proc_info(int sig, struct siginfo *
 	return error;
 }
=20
+/* like kill_proc_info(), but doesn't use uid/euid of "current" */
+int
+kill_proc_info_as_uid(int sig, struct siginfo *info, pid_t pid,
+		      pid_t uid, pid_t euid)
+{
+	int ret =3D -EINVAL;
+	struct task_struct *p;
+
+	if (!valid_signal(sig))
+		return ret;
+
+	read_lock(&tasklist_lock);
+	p =3D find_task_by_pid(pid);
+	if (!p) {
+		ret =3D -ESRCH;
+		goto out_unlock;
+	}
+	if ((!info || ((unsigned long)info !=3D 1 &&
+			(unsigned long)info !=3D 2 && SI_FROMUSER(info)))
+	    && (euid ^ p->suid) && (euid ^ p->uid)
+	    && (uid ^ p->suid) && (uid ^ p->uid)) {
+		ret =3D -EPERM;
+		goto out_unlock;
+	}
+	if (sig && p->sighand) {
+		unsigned long flags;
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		ret =3D __group_send_sig_info(sig, info, p);
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	}
+out_unlock:
+	read_unlock(&tasklist_lock);
+	return ret;
+}
=20
 /*
  * kill_something_info() interprets pid in interesting ways just like kill=
(2).

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDSqh9XaXGVTD0i/8RAs+1AKCEwjwG66UYZ8U7xRGgvsQXoZJ4LwCeMAIb
gH1kow6iAuw484VxMjQcepw=
=r+GK
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
