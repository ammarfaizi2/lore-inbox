Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267626AbSLNQne>; Sat, 14 Dec 2002 11:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbSLNQne>; Sat, 14 Dec 2002 11:43:34 -0500
Received: from pop3.telefonica.net ([213.4.129.150]:2915 "EHLO
	telesmtp2.mail.isp") by vger.kernel.org with ESMTP
	id <S267626AbSLNQnd>; Sat, 14 Dec 2002 11:43:33 -0500
Subject: strange pthreads behaviour
From: =?ISO-8859-1?Q?Ra=FAl?= <raul.saura@telefonica.net>
To: linux-kernel@vger.kernel.org
Cc: rsaura@retevision.es
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-QKY83tJAR5VZfKTgZkkF"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Dec 2002 17:51:36 +0100
Message-Id: <1039884697.1094.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QKY83tJAR5VZfKTgZkkF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

I've encountered an extrange behaviour with pthreads in a piece of code
I'm developing for linux 2.4.18-18.8.0 (RH-8.0) glibc-2.2.93

Basically the app is an CORBA servant object (omniORB-4.0 based) that
maps some of the methods of the idl for the object on scripts or
executables.

I've considered POSIX semantics por signal delivery in MT
applications.

The app works this way:

1) SIGCHLD is blocked in main() thread first of all.
2) ORB threads are started (they should inherit SIGCHLD blocked)
3) on a request, one working-thread from the request broker will
eventually call spawn_script()
4) a sigmask with SIGCHLD unblocked is prepared for posterior usage on
pselect()
5) spawn_script() forks. If I am right the fork() from the thread will
create a brand new process with the only execution context of the
calling thread.
6) forked process execve()'s the script (after duping fd0 & 1 on a
pipe)
7) parent thread enters in a pselect() loop to read child's stdout from
the pipe.
8) the exit condition for the loop is raised when pselect() catches
SIGCHLD

The only point where SIGCHLD is unblocked is inside pselect() & calls to
spawn_script() are serialized using a global mutex. So I can ensure that
only the thread inside pselect() has SIGCHLD unblocked, so when the
child exits the notification will arrive to the correct thread on the
parent process. And, in fact, it seemed to work.

The problem is that execve() works only if called from the main()
thread. If called from another thread it blocks forever inside
sigsuspend().

The stack-trace for the process blocked on execve looks like:

__libc_start_main
main
Conector_i::leerFicheroPropiedades(char*)
spawn_script(const char*, char**, char***)
exevce
pthread_kill_other_threads_np
pthread_oneexit_process
_pthread_wait_for_restart_signal
sigsuspend

execve() is called from the fork()ed process so it should not have any
related thread.
There are no blocked signals when calling execve().

I've also tried the non-portable function
pthread_kill_other_threads_np() before execve() but
pthread_kill_other_threads_np() will also block on sigsuspend() with an
obviously similar stack-trace:

__libc_start_main
main
Conector_i::leerFicheroPropiedades(char*)
spawn_script(const char*, char**, char***)
pthread_kill_other_threads_np
pthread_oneexit_process
_pthread_wait_for_restart_signal
sigsuspend

Is this behaviour normal?=20
Why does the forked process block on
execve()/_pthread_wait_for_restart_signal()?

Thanks in advance.

	Raul Saura

PD: please CC the eventual asnwers to raul.saura@telefonica.net


--=-QKY83tJAR5VZfKTgZkkF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9+2GYJKQoKD6EdCgRAgszAJ9X2V6xRgyaToBFTwluCK73OFS75QCgpt0X
KsDnAK1NxDzD6nJCIwOdZUc=
=kRxp
-----END PGP SIGNATURE-----

--=-QKY83tJAR5VZfKTgZkkF--

