Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271308AbUJVOxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271308AbUJVOxj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271326AbUJVOxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:53:39 -0400
Received: from 70-33-118-80.kaptech.net ([80.118.33.70]:11675 "EHLO
	master.lab.meiosys.com") by vger.kernel.org with ESMTP
	id S271308AbUJVOxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:53:22 -0400
Subject: Re: PROBLEM : Thread signal informations are not freed when it is
	execing.
From: Laurent Dufour <ldufour@meiosys.com>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200410220917.i9M9Ht3m025244@magilla.sf.frob.com>
References: <200410220917.i9M9Ht3m025244@magilla.sf.frob.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Z9sWpA5tv1Wb4mQhah+H"
Organization: Meiosys
Message-Id: <1098456754.6173.46.camel@soho.lab.meiosys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 22 Oct 2004 16:52:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z9sWpA5tv1Wb4mQhah+H
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Le ven 22/10/2004 =E0 11:17, Roland McGrath a =E9crit :
> I don't think these problems are still relevant to the current sources,
> though some of them might still occur in 2.6.9.  The fix I posted for the
> semantics bugs of exec vs pending signals makes de_thread not abandon the
> old signal_struct at all, so it holds on to all the data structures.  If
> you can reproduce any kind of leak using the code now in Linus's tree,
> please show me the details.

I didn't find the post you're talking about, but after reading 2.6.9
de_thread function, I didn't find major diff with previous release.=20
So I suppose that the leak is always present, and I have some details..

I wrote a new test case that works with 2.6.x kernel. I have run it on a
Fedora Core 2 node with a 2.6.8-1.521 kernel and also with the new 2.6.9
kernel, and it has also produce a leak in siqueue buffers. It can be
seen by looking at sigqueue cache info in /proc/slabinfo.

It seems that the bug is due to the call to
init_sigpending(&current->pending) at line 737 of de_thread.=20
It breaks the actual sigqueue pending list and all the linked entries
are lost. As a consequence, current->user->pending count is also not
updated.

Here is the new test case. Of course you have to compile it with
-lpthread flag.

/*
 * This small program generate a memory leak of signal info structure.
 *
 * The first time the test program is executed, it will send about 1024
 * signal depending of RLIMIT_SIGPENDING value (default is 1024).
 * Then it will exec itself and try to send signal again. That will
failed.
 *
 * After that, you will not be able to run it again since
user->sigpending
 * has raised the maximum value. But there is no active task with
pending
 * signals !!!
 *
 * You can also see in /proc/slabinfo that sigqueue pool was increase by
1024.
 * Theses siqueue entries are lost and user can't send signal with
signal info
 * anymore.
 *
 * WARNING : You have to reboot the node to restore sigqueue entries.
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

char *pname;

void *thread_fn(void * unused)
{
    sigset_t sset;
    int i;
    pthread_t me =3D pthread_self();

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
    printf("%d signals sent. Calling exec %s\n", i, pname);

    execlp(pname, pname, NULL);

    perror(pname);
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

    pname =3D argv[0];
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

    while(1) pause();
}

I hope that will help you.

Laurent.

--=-Z9sWpA5tv1Wb4mQhah+H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBeR6x/TZbDektYw4RAkeBAJ9CzXbaxtv5RpjiC/vuL1ESIjZTkwCdF2xA
R+/JQSFjenC+Xqw92pkWV9k=
=yz5k
-----END PGP SIGNATURE-----

--=-Z9sWpA5tv1Wb4mQhah+H--
