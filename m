Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbVI3WIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbVI3WIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbVI3WIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:08:18 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:3463 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1030465AbVI3WIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:08:17 -0400
Date: Sat, 1 Oct 2005 00:08:09 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       security@linux.kernel.org, vendor-sec@lst.de
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050930220808.GE4168@sunbeam.de.gnumonks.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local> <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local> <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org> <20050930104749.GN4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org> <20050930184433.GF16352@shell0.pdx.osdl.net> <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsInuhHXRA2cfTGD"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FsInuhHXRA2cfTGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2005 at 12:27:04PM -0700, Linus Torvalds wrote:
>=20
>=20
> On Fri, 30 Sep 2005, Chris Wright wrote:
> >=20
> > Sorry, I missed the thread up to this, but this looks fundamentally
> > broken.  The kill_proc_info_as_uid() idea is not sufficient because more
> > than uid/euid are needed for permission check.  There's capabilities and
> > security labels.
>=20
> Not for this particular USB use, there isn't. Since you can only send a=
=20
> signal to yourself anyway, the uid/euid check is just testing that you're=
=20
> still who you were.

please find the patch below.  It compiles, but I didn't yet have the
time to verify it makes the bug disappear and the async urb delivery is
still working.

I'll try to report whether it's working tomorrow.

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
@@ -655,7 +655,8 @@ static int rm_from_queue(unsigned long m
  * Bad permissions for sending the signal
  */
 static int check_kill_permission(int sig, struct siginfo *info,
-				 struct task_struct *t)
+				 struct task_struct *t,
+				 pid_t uid, pid_t euid)
 {
 	int error =3D -EINVAL;
 	if (!valid_signal(sig))
@@ -665,8 +666,8 @@ static int check_kill_permission(int sig
 			(unsigned long)info !=3D 2 && SI_FROMUSER(info)))
 	    && ((sig !=3D SIGCONT) ||
 		(current->signal->session !=3D t->signal->session))
-	    && (current->euid ^ t->suid) && (current->euid ^ t->uid)
-	    && (current->uid ^ t->suid) && (current->uid ^ t->uid)
+	    && (euid ^ t->suid) && (euid ^ t->uid)
+	    && (uid ^ t->suid) && (uid ^ t->uid)
 	    && !capable(CAP_KILL))
 		return error;
=20
@@ -1132,7 +1133,24 @@ int group_send_sig_info(int sig, struct=20
 	unsigned long flags;
 	int ret;
=20
-	ret =3D check_kill_permission(sig, info, p);
+	ret =3D check_kill_permission(sig, info, p, current->uid, current->euid);
+	if (!ret && sig && p->sighand) {
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		ret =3D __group_send_sig_info(sig, info, p);
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	}
+
+	return ret;
+}
+
+static int group_send_sig_info_as_uid(int sig, struct siginfo *info,=20
+				      struct task_struct *p,=20
+				      pid_t uid, pid_t euid)
+{
+	unsigned long flags;
+	int ret;
+
+	ret =3D check_kill_permission(sig, info, p, current->uid, current->euid);
 	if (!ret && sig && p->sighand) {
 		spin_lock_irqsave(&p->sighand->siglock, flags);
 		ret =3D __group_send_sig_info(sig, info, p);
@@ -1192,6 +1210,22 @@ kill_proc_info(int sig, struct siginfo *
 	return error;
 }
=20
+/* like kill_proc_info(), but doesn't use uid/euid of "current" */
+int
+kill_proc_info_as_uid(int sig, struct siginfo *info, pid_t pid,
+		      pid_t uid, pid_t euid)
+{
+	int error;
+	struct task_struct *p;
+
+	read_lock(&tasklist_lock);
+	p =3D find_task_by_pid(pid);
+	error =3D -ESRCH;
+	if (p)
+		error =3D group_send_sig_info_as_uid(sig, info, p, uid, euid);
+	read_unlock(&tasklist_lock);
+	return error;
+}
=20
 /*
  * kill_something_info() interprets pid in interesting ways just like kill=
(2).
@@ -2290,7 +2324,8 @@ asmlinkage long sys_tgkill(int tgid, int
 	p =3D find_task_by_pid(pid);
 	error =3D -ESRCH;
 	if (p && (p->tgid =3D=3D tgid)) {
-		error =3D check_kill_permission(sig, &info, p);
+		error =3D check_kill_permission(sig, &info, p, current->uid,
+					      current->euid);
 		/*
 		 * The null signal is a permissions and process existence
 		 * probe.  No signal is actually delivered.
@@ -2330,7 +2365,8 @@ sys_tkill(int pid, int sig)
 	p =3D find_task_by_pid(pid);
 	error =3D -ESRCH;
 	if (p) {
-		error =3D check_kill_permission(sig, &info, p);
+		error =3D check_kill_permission(sig, &info, p, current->uid,
+					      current->euid);
 		/*
 		 * The null signal is a permissions and process existence
 		 * probe.  No signal is actually delivered.
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--FsInuhHXRA2cfTGD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDPbdIXaXGVTD0i/8RAv31AKCumKOf2g5mk9VDrbiY1Y5+/juwOACfRhQU
4QsSQyjrDsNaQj6fI2r+Sbo=
=juRP
-----END PGP SIGNATURE-----

--FsInuhHXRA2cfTGD--
