Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbUKGULY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbUKGULY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 15:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUKGULY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 15:11:24 -0500
Received: from mail.murom.net ([213.177.124.17]:56458 "EHLO mail.murom.net")
	by vger.kernel.org with ESMTP id S261599AbUKGULA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 15:11:00 -0500
Date: Sun, 7 Nov 2004 23:10:15 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jason Baron <jbaron@redhat.com>
Cc: Krzysztof Taraszka <dzimi@pld-linux.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Update termios to use per tty semaphore (backport from 2.6.x)
Message-ID: <20041107201015.GB2345@sirius.home>
References: <200410311053.34927.dzimi@pld-linux.org> <Pine.LNX.4.44.0411020958460.8117-100000@dhcp83-105.boston.redhat.com> <20041107200601.GA2345@sirius.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20041107200601.GA2345@sirius.home>
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.753,
	required 6, autolearn=not spam, AWL 0.15, BAYES_10 -0.91)
X-MailScanner-From: vsu@altlinux.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is a 2.4.x backport of the termios locking changes made in 2.6.x:

#   2004/10/02 15:46:35-07:00 alan@lxorguk.ukuu.org.uk=20
#   [PATCH] Update termios to use per tty semaphore
#  =20
#   This makes the agreed change of termios locking to be semaphore based
#   sleep locking. This is needed for USB in particular as it has to use
#   messaging to issue terminal mode changes.
#  =20
#   This code passes Torvalds test grades 0, 1 and 2 (it looks ok, it
#   compiles and it booted). It does mean that a driver cannot take an
#   atomic peek at termios data during an interrupt. Nobody seems to be
#   doing this although some of the driver receive paths for line
#   disciplines will eventually want to (n_tty currently doesn't do this
#   locked on the receive path). Since the ldisc is given a chance to copy
#   any essential bits on the ->set_termios path this seems not to be a
#   problem.

--- kernel-source-2.4.27/include/linux/tty.h.termios	2004-10-31 18:07:10 +0=
300
+++ kernel-source-2.4.27/include/linux/tty.h	2004-10-31 20:23:38 +0300
@@ -261,6 +261,7 @@ struct tty_struct {
 	int	magic;
 	struct tty_driver driver;
 	struct tty_ldisc ldisc;
+	struct semaphore termios_sem;
 	struct termios *termios, *termios_locked;
 	int pgrp;
 	int session;
--- kernel-source-2.4.27/drivers/char/tty_io.c.termios	2004-10-31 18:04:37 =
+0300
+++ kernel-source-2.4.27/drivers/char/tty_io.c	2004-10-31 20:26:13 +0300
@@ -118,8 +118,6 @@ extern void disable_early_printk(void);
 #define TTY_PARANOIA_CHECK 1
 #define CHECK_TTY_COUNT 1
=20
-/* Lock for tty_termios changes - private to tty_io/tty_ioctl */
-spinlock_t tty_termios_lock =3D SPIN_LOCK_UNLOCKED;
 struct termios tty_std_termios;		/* for the benefit of tty drivers  */
 struct tty_driver *tty_drivers;		/* linked list of tty drivers */
=20
@@ -269,10 +267,9 @@ static int check_tty_count(struct tty_st
=20
 static void tty_set_termios_ldisc(struct tty_struct *tty, int num)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&tty_termios_lock, flags);
+	down(&tty->termios_sem);
 	tty->termios->c_line =3D num;
-	spin_unlock_irqrestore(&tty_termios_lock, flags);
+	up(&tty->termios_sem);
 }
=20
 /*
@@ -803,10 +800,9 @@ void do_tty_hangup(void *data)
=20
 	if (tty->driver.flags & TTY_DRIVER_RESET_TERMIOS)
 	{
-		unsigned long flags;
-		spin_lock_irqsave(&tty_termios_lock, flags);
+		down(&tty->termios_sem);
                 *tty->termios =3D tty->driver.init_termios;
-		spin_unlock_irqrestore(&tty_termios_lock, flags);
+		up(&tty->termios_sem);
 	}
=20
 	/* Defer ldisc switch */
@@ -2452,6 +2448,7 @@ static void initialize_tty_struct(struct
 	tty->flip.tqueue.routine =3D flush_to_ldisc;
 	tty->flip.tqueue.data =3D tty;
 	init_MUTEX(&tty->flip.pty_sem);
+	init_MUTEX(&tty->termios_sem);
 	init_waitqueue_head(&tty->write_wait);
 	init_waitqueue_head(&tty->read_wait);
 	tty->tq_hangup.routine =3D do_tty_hangup;
--- kernel-source-2.4.27/drivers/char/tty_ioctl.c.termios	2004-10-31 18:04:=
37 +0300
+++ kernel-source-2.4.27/drivers/char/tty_ioctl.c	2004-10-31 20:31:47 +0300
@@ -29,8 +29,6 @@
=20
 #undef	DEBUG
=20
-extern spinlock_t tty_termios_lock;
-
 /*
  * Internal flag options for termios setting behavior
  */
@@ -99,7 +97,6 @@ static void change_termios(struct tty_st
 	int canon_change;
 	struct termios old_termios =3D *tty->termios;
 	struct tty_ldisc *ld;
-	unsigned long flags;
=20
 	/*
 	 *      Perform the actual termios internal changes under lock.
@@ -107,7 +104,7 @@ static void change_termios(struct tty_st
=20
 	/* FIXME: we need to decide on some locking/ordering semantics
 	   for the set_termios notification eventually */
-	spin_lock_irqsave(&tty_termios_lock, flags);
+	down(&tty->termios_sem);
=20
 	*tty->termios =3D *new_termios;
 	unset_locked_termios(tty->termios, &old_termios, tty->termios_locked);
@@ -147,8 +144,7 @@ static void change_termios(struct tty_st
 			(ld->set_termios)(tty, &old_termios);
 		tty_ldisc_deref(ld);
 	}
-	spin_unlock_irqrestore(&tty_termios_lock, flags);
-
+	up(&tty->termios_sem);
 }
=20
 static int set_termios(struct tty_struct * tty, unsigned long arg, int opt)
@@ -244,13 +240,13 @@ static int get_sgttyb(struct tty_struct=20
 	struct sgttyb tmp;
 	unsigned long flags;
=20
-	spin_lock_irqsave(&tty_termios_lock, flags);
+	down(&tty->termios_sem);
 	tmp.sg_ispeed =3D 0;
 	tmp.sg_ospeed =3D 0;
 	tmp.sg_erase =3D tty->termios->c_cc[VERASE];
 	tmp.sg_kill =3D tty->termios->c_cc[VKILL];
 	tmp.sg_flags =3D get_sgflags(tty);
-	spin_unlock_irqrestore(&tty_termios_lock, flags);
+	up(&tty->termios_sem);
=20
 	return copy_to_user(sgttyb, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
@@ -286,19 +282,18 @@ static int set_sgttyb(struct tty_struct=20
 	int retval;
 	struct sgttyb tmp;
 	struct termios termios;
-	unsigned long flags;
=20
 	retval =3D tty_check_change(tty);
 	if (retval)
 		return retval;
 	if (copy_from_user(&tmp, sgttyb, sizeof(tmp)))
 		return -EFAULT;
-	spin_lock_irqsave(&tty_termios_lock, flags);
+	down(&tty->termios_sem);
 	termios =3D  *tty->termios;
 	termios.c_cc[VERASE] =3D tmp.sg_erase;
 	termios.c_cc[VKILL] =3D tmp.sg_kill;
 	set_sgflags(&termios, tmp.sg_flags);
-	spin_unlock_irqrestore(&tty_termios_lock, flags);
+	up(&tty->termios_sem);
 	change_termios(tty, &termios);
 	return 0;
 }
@@ -533,11 +528,11 @@ int n_tty_ioctl(struct tty_struct * tty,
 		case TIOCSSOFTCAR:
 			if (get_user(arg, (unsigned int *) arg))
 				return -EFAULT;
-			spin_lock_irqsave(&tty_termios_lock, flags);
+			down(&tty->termios_sem);
 			tty->termios->c_cflag =3D
 				((tty->termios->c_cflag & ~CLOCAL) |
 				 (arg ? CLOCAL : 0));
-			spin_unlock_irqrestore(&tty_termios_lock, flags);
+			up(&tty->termios_sem);
 			return 0;
 		default:
 			return -ENOIOCTLCMD;
--- kernel-source-2.4.27/Documentation/tty.txt.termios	2004-10-31 18:04:36 =
+0300
+++ kernel-source-2.4.27/Documentation/tty.txt	2004-10-31 20:23:38 +0300
@@ -158,8 +158,8 @@ write_room()	-	Return the number of char
=20
 ioctl()		-	Called when an ioctl may be for the driver
=20
-set_termios()	-	Called on termios change, may get parallel calls,
-			may block for now (may change that)
+set_termios()	-	Called on termios change, serialized against
+			itself by a semaphore. May sleep.
=20
 set_ldisc()	-	Notifier for discipline change. At the point this=20
 			is done the discipline is not yet usable. Can now

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBjoEnW82GfkQfsqIRAmbfAJ9pZxKj9w+DTl8Hf29PlGIzfWWAwQCggQDs
RV2eN2s7ylE98dvZugbPvw0=
=MZYp
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
