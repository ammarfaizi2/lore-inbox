Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVAaWKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVAaWKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVAaWKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:10:38 -0500
Received: from mout2.freenet.de ([194.97.50.155]:32722 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261396AbVAaWKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:10:10 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [RFC] "biological parent" pid
Date: Mon, 31 Jan 2005 23:09:46 +0100
User-Agent: KMail/1.7.2
References: <Pine.LNX.4.53.0501311923440.18039@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0501311923440.18039@gockel.physik3.uni-rostock.de>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6593828.JJ2hQNaWbr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501312309.57464.mbuesch@freenet.de>
X-Warning: freenet.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6593828.JJ2hQNaWbr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Tim Schmielau <tim@physik3.uni-rostock.de>:
> The ppid of a process is not really helpful if I want to reconstruct the=
=20
> real history of processes on a machine, since it may become 1 when the
> parent dies and the process is reparented to init.
>=20
> I am not aware of concepts in Linux or other unices that apply to this
> case. So I made up the "biological parent pid" bioppid (in contrast to the
> adoptive parents pid) that just never changes.
> Any user of it must of course remember that it doesn't need to be a valid=
=20
> pid anymore or might even belong to a different process that was forked i=
n=20
> the meantime. bioppid only had to be a valid pid at time btime (it's
> a (btime, pid) pair that unambiguously identifies a process).
>=20
> Comments? (other that I just broke /proc/nnn/status parsing once again :-)

Eh, I can't see how this bioppid would be useful.
Help me. Examples?

> Tim
>=20
>=20
> --- linux-2.6.10/include/linux/sched.h	2004-12-24 22:33:59.000000000 +0100
> +++ linux-2.6.10-ppid/include/linux/sched.h	2005-01-31 19:20:00.000000000=
 +0100
> @@ -556,6 +556,7 @@ struct task_struct {
>  	unsigned did_exec:1;
>  	pid_t pid;
>  	pid_t tgid;
> +	pid_t bioppid;                  /* biological parents */
>  	/*=20
>  	 * pointers to (original) parent process, youngest child, younger sibli=
ng,
>  	 * older sibling, respectively.  (p->father can be replaced with=20
>=20
> --- linux-2.6.10/kernel/fork.c	2004-12-24 22:33:59.000000000 +0100
> +++ linux-2.6.10-ppid/kernel/fork.c	2005-01-31 18:15:39.000000000 +0100
> @@ -889,6 +889,7 @@ static task_t *copy_process(unsigned lon
>  	p->tgid =3D p->pid;
>  	if (clone_flags & CLONE_THREAD)
>  		p->tgid =3D current->tgid;
> +	p->bioppid =3D current->pid;
> =20
>  	if ((retval =3D security_task_alloc(p)))
>  		goto bad_fork_cleanup_policy;
>=20
> --- linux-2.6.10/fs/proc/array.c	2004-12-24 22:35:00.000000000 +0100
> +++ linux-2.6.10-ppid/fs/proc/array.c	2005-01-31 18:19:02.000000000 +0100
> @@ -165,6 +165,7 @@ static inline char * task_state(struct t
>  		"Tgid:\t%d\n"
>  		"Pid:\t%d\n"
>  		"PPid:\t%d\n"
> +		"BioPPid:\t%d\n"
>  		"TracerPid:\t%d\n"
>  		"Uid:\t%d\t%d\t%d\t%d\n"
>  		"Gid:\t%d\t%d\t%d\t%d\n",
> @@ -172,6 +173,7 @@ static inline char * task_state(struct t
>  		(p->sleep_avg/1024)*100/(1020000000/1024),
>  	       	p->tgid,
>  		p->pid, pid_alive(p) ? p->group_leader->real_parent->tgid : 0,
> +		p->bioppid,
>  		pid_alive(p) && p->ptrace ? p->parent->pid : 0,
>  		p->uid, p->euid, p->suid, p->fsuid,
>  		p->gid, p->egid, p->sgid, p->fsgid);
>=20
> --- linux-2.6.10/kernel/acct.c	2004-12-24 22:34:58.000000000 +0100
> +++ linux-2.6.10-ppid/kernel/acct.c	2005-01-31 18:19:35.000000000 +0100
> @@ -446,7 +446,7 @@ static void do_acct_process(long exitcod
>  #endif
>  #if ACCT_VERSION=3D=3D3
>  	ac.ac_pid =3D current->tgid;
> -	ac.ac_ppid =3D current->parent->tgid;
> +	ac.ac_ppid =3D current->bioppid;
>  #endif
> =20
>  	read_lock(&tasklist_lock);	/* pin current->signal */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
>=20

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]



--nextPart6593828.JJ2hQNaWbr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB/qy1FGK1OIvVOP4RAsX0AKCYmGK4/mE2j5cC+EfO1tatnG2JdQCfbw1q
0SkFv7crBm8SOalV1UgBHBg=
=e1s0
-----END PGP SIGNATURE-----

--nextPart6593828.JJ2hQNaWbr--
