Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267487AbSKQLvo>; Sun, 17 Nov 2002 06:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbSKQLvo>; Sun, 17 Nov 2002 06:51:44 -0500
Received: from ppp-217-133-221-200.dialup.tiscali.it ([217.133.221.200]:3713
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S267487AbSKQLvn>; Sun, 17 Nov 2002 06:51:43 -0500
Subject: Re: [patch] threading fix, tid-2.5.47-A3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211171314200.7001-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0211171314200.7001-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-7ExARx0AVsh+gZTAEKkW"
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Nov 2002 12:57:53 +0100
Message-Id: <1037534273.1597.26.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7ExARx0AVsh+gZTAEKkW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> the attached patch
-> The patch that was meant to be attached :)

> the solution is to add a new syscall that sets the current->user_tid
> address. This new syscall is used by glibc's exec() implementation. =20
I don't understand this: why would glibc use it in exec()?

> Another change is to make CLONE_SETTID work even if CLONE_VM is not used.
> This means that the TID must be set in the child's address space, not in
> the parent's address space. I've also merged SETTID and CLEARTID, the two
> should always be used together by any new-style threading abstraction.
But this prevents using SETTID to get the tid in a
signal-handler-accessible place before a SIGCHLD can arrive, without
having to use sigprocmask.

How about renaming CLONE_SETTID to CLONE_SETTID_PARENT, leaving the
existing semantics alone, and adding a CLONE_SETTID (with a new value)
that sets the tid in the fork child?

This would require two separate tid pointers so that glibc could
implement a fork_get_pid(int* pid) setting pid in the parent vm and the
tid in struct pthread in the child.

Alternatively, if the fork child calls sys_set_tid_address on its own
right after creation, no modifications to clone are required (this is
what my sys_cleartid patch did).

BTW, user_tid needs to be cleared on exec, and I'm not sure if we are
doing this.


--=-7ExARx0AVsh+gZTAEKkW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA914RBdjkty3ft5+cRAoXpAJ9H86OF7lhCX1ON5w0dXHBz570l1gCfdvsO
0MvlMMSj98nPcjHf9VFbWe4=
=duVo
-----END PGP SIGNATURE-----

--=-7ExARx0AVsh+gZTAEKkW--
