Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267747AbTAIUiT>; Thu, 9 Jan 2003 15:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267746AbTAIUiT>; Thu, 9 Jan 2003 15:38:19 -0500
Received: from ppp-217-133-219-176.dialup.tiscali.it ([217.133.219.176]:63873
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S267772AbTAIUhW>; Thu, 9 Jan 2003 15:37:22 -0500
Date: Thu, 9 Jan 2003 21:38:54 +0100
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use %ebp rather than %ebx for thread_info pointer
Message-ID: <20030109203854.GA2952@ldb>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
References: <20030109194935.GA2098@ldb> <Pine.LNX.4.44.0301091216490.1890-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301091216490.1890-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hmm.. Did you check what fork
It only seems to use ret_from_fork, that sets up %ebp on its own.
> execve
Doesn't seem to use any function in entry.S
> vm86 do? I know at least the vm86() =20
> stuff sets up %ebx before calling the asm functions in entry.S, I bet=20
> those need to be changed to use %ebp too with something like this.

Right. This should fix it (compiles but untested):
--- arch/i386/kernel/vm86.c~    2003-01-02 04:21:07.000000000 +0100
+++ arch/i386/kernel/vm86.c     2003-01-09 21:24:58.000000000 +0100
@@ -298,9 +298,10 @@
        __asm__ __volatile__(
                "xorl %%eax,%%eax; movl %%eax,%%fs; movl %%eax,%%gs\n\t"
                "movl %0,%%esp\n\t"
+               "movl %1,%%ebp\n\t"
                "jmp resume_userspace"
                : /* no outputs */
-               :"r" (&info->regs), "b" (tsk->thread_info) : "ax");
+               :"r" (&info->regs), "r" (tsk->thread_info) : "ax");
        /* we never return here */
 }
 =20
@@ -311,8 +312,9 @@
        regs32 =3D save_v86_state(regs16);
        regs32->eax =3D retval;
        __asm__ __volatile__("movl %0,%%esp\n\t"
+               "movl %1,%%ebp\n\t"
                "jmp resume_userspace"
-               : : "r" (regs32), "b" (current_thread_info()));
+               : : "r" (regs32), "r" (current_thread_info()));
 }
 =20
 static inline void set_IF(struct kernel_vm86_regs * regs)


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Hd3ddjkty3ft5+cRAhqtAKCAEDn93oXmo7/S9AFztzlt7lqFJgCgyBDL
7Ze+A5XjW7eAOWzwtm2xYu8=
=K/9Q
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
