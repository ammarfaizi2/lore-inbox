Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268966AbUJUNJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268966AbUJUNJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUJUNIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:08:14 -0400
Received: from 70-33-118-80.kaptech.net ([80.118.33.70]:38860 "EHLO
	master.lab.meiosys.com") by vger.kernel.org with ESMTP
	id S268594AbUJUNBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:01:53 -0400
Subject: PROBLEM : Thread signal informations are not freed when it is
	execing.
From: Laurent Dufour <ldufour@meiosys.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-06hRJUohYPorMrCB+HxX"
Organization: Meiosys
Message-Id: <1098363723.27235.103.camel@soho.lab.meiosys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 21 Oct 2004 15:02:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-06hRJUohYPorMrCB+HxX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

It seems that under specific circumstances...

[1] Thread signal informations are not freed when it is execing.

[2] If a thread calling exec has pending signals with signal
informations then this signal informations are unlinked but not freed.=20

It is easy to detect it with previous kernel 2.4.x because of rtsig-nr
sysctl value (see [6]).

On kernel 2.4 the result is that no RT signal information can be sent
when rtsig-nr reach is max value. On 2.6 kernels it can't be seen but
allocated memory is never freed.

Problem seems to be due to the call at init_sigpending at the end of
de_thread because it reset signal list without freeing linked items.
Perhaps it should be better to use flush_sigqueue.

In 2.6 kernel by reading de_thread function, it seems that problem still
exists.

[3] de_thread, pending signals, exec

[4] 2.4.21 but it seems also applicable to 2.6.8.1

[5] NA

[6] This small test cannot be run on 2.6 kernel because
"kernel.rtsig-nr" sysctl value doesn't exist anymore. But memory leak
seems to be still present in 2.6.8.1 kernel.

/*
 * This small program generate a memory leak of signal info structure.
 * It can't not be run on new kernel (2.6.x) because rtsig-nr doesn't
 * exist anymore but it seems that leak is still present in 2.6 kernels.
 *
 * The first time the test program is executed, it will set rtsig-nr to
 * it maximum (1024 is the default for kernel.rtsig-max).
 * Then no process can sent signal with information associated.
 * You can verify this by running test program again, it will say that
 * no signal can be sent (pthread_kill will return EAGAIN error).
 *
 * WARNING : You have to reboot the node to reset rtsig-nr value.
 *
 * Laurent Dufour <ldufour@meiosys.com>
 */

#define _GNU_SOURCE
#include <pthread.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <signal.h>

#define SIGNAL	SIGRTMAX

void *thread_fn(void * unused)
{
    sigset_t sset;
    int i;
    pthread_t me =3D pthread_self();
   =20
    /* printf("thread %p started\n", pthread_self()); */

    sigemptyset(&sset);
    sigaddset(&sset, SIGNAL);
    if (pthread_sigmask(SIG_BLOCK, &sset, NULL)) {
	perror("pthread_sigmask");
	exit(1);
    }
   =20
    i=3D0;
    while(1) {
	int err =3D pthread_kill(me, SIGNAL);
	if (err) {
	    if (!i) {
		printf("no signal sent, pthread_kill : %s\n",
		       strerror(err));
		exit(1);
	    }
	    break;
	}
	i++;
    }
    /* printf("%d signal sent.\n", i);*/

    printf("After thread is execing :");
    execlp("sysctl", "sysctl", "kernel.rtsig-nr", NULL);

    perror("execlp");
   =20
    exit(1);
}

void sig_handler(int signal, siginfo_t *info, void * unused)
{
    /* It should never be called since signal is blocked. */
    printf("thread %p catch signal %s\n",
	   pthread_self(), strsignal(signal));
}

int main(int argc, char **argv)
{
    pthread_t thread;
    struct sigaction act;

    setbuf(stdout,NULL);

    printf("Before thread's execing : ");
    system("sysctl kernel.rtsig-nr");
   =20
    act.sa_sigaction =3D sig_handler;
    sigemptyset(&act.sa_mask);
    act.sa_flags =3D SA_RESTART | SA_NOMASK | SA_SIGINFO;
    if (sigaction(SIGNAL, &act, NULL)) {
	perror("sigaction");
	exit(1);
    }
       =20
    if (pthread_create(&thread, NULL, thread_fn, NULL)) {
	perror("pthread_create");
	exit(1);
    }

    /* printf("wait for thread call exec...\n"); */
    while(1) pause();
}


[7] environnement doesn't seems to have any impact.

[8] Hope that helps.


--=-06hRJUohYPorMrCB+HxX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBd7NL/TZbDektYw4RAkVLAJ9yU3CxqYLsjPEtUBFovDNfMEZtOQCeM3Zo
1trzg8igKwIQoy4Sp0pdZ2Q=
=j05J
-----END PGP SIGNATURE-----

--=-06hRJUohYPorMrCB+HxX--
