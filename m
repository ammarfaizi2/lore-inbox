Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSKRMnN>; Mon, 18 Nov 2002 07:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSKRMnN>; Mon, 18 Nov 2002 07:43:13 -0500
Received: from ppp-217-133-216-163.dialup.tiscali.it ([217.133.216.163]:6022
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S262415AbSKRMnM>; Mon, 18 Nov 2002 07:43:12 -0500
Subject: Re: [patch] threading fix, tid-2.5.47-A3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211181318280.1639-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0211181318280.1639-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-YlFHSGQIxOnWBV57dtEa"
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Nov 2002 13:50:03 +0100
Message-Id: <1037623803.1774.138.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YlFHSGQIxOnWBV57dtEa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> i'd just add MAP_DONTCOPY, and use a new non-MAP_DONTCOPY descriptor for
> the forked process. It's clearly possible with SETTID and SETTLS, nothing
> says that the new process must have the same TLS as the old one.
But it must have the same stack, and since you don't know which thread
is going to fork, the only way is to set MAP_DONTCOPY on everything and
then tell the kernel the ignore it at fork time.

An additional extension could be a MAP_THREAD flag that causes the vma
to be put in a linked list of vmas that are freed when the thread exits.

One would then use MAP_DONTCOPY | MAP_THREAD for the thread stacks
(maybe not setting MAP_THREAD unless there are a lot of thread, so that
an mmap doesn't have to be done for each pthread_create), only
MAP_DONTCOPY for the thread descriptors if they are
PTHREAD_CREATE_JOINABLE and MAP_DONTCOPY | MAP_THREAD if they are
PTHREAD_CREATE_DETACHED and then tell clone to copy the stack and
descriptor of the current process ignoring the MAP_DONTCOPY.

To do this, we need to add support for MAP_DONTCOPY and MAP_THREAD in
mmap and also in mprotect (by, for example, shifting the MAP_ flags 8
bit to the left and or'ing the PROT_ flags) and add a way to override
them at clone time.

For clone, it seems reasonable to implement this using an userspace
array pointed to by %ebp.
Array entries would contain a start address, an end address, a set of
flags to AND in mprotect format and a set of flags to XOR in mprotect
format (96 bits per entry if the mprotect flags fit in 16 bits).

The kernel mode implementation can do a normal copy of the vmas, then
scan the array and either remove, add or modify vmas to correct the copy
done before and finally setup pagetables based on the final vma tree.

All this can be further extended by adding support for memory allocation
and sharing memory rather than copy-on-writing it.


--=-YlFHSGQIxOnWBV57dtEa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA92OH7djkty3ft5+cRAoAaAJ0ZrITbWEGtX8V27qxO9FRaKuYpWwCfSzre
wk/FWcAJ+f9N2coaj7bSL7o=
=z3h4
-----END PGP SIGNATURE-----

--=-YlFHSGQIxOnWBV57dtEa--
