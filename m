Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317931AbSHaTec>; Sat, 31 Aug 2002 15:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSHaTec>; Sat, 31 Aug 2002 15:34:32 -0400
Received: from ppp-217-133-221-247.dialup.tiscali.it ([217.133.221.247]:2434
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317931AbSHaTea>; Sat, 31 Aug 2002 15:34:30 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: trond.myklebust@fys.uio.no, Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-r40RLSMeqxyr1+gkFbhM"
X-Mailer: Ximian Evolution 1.0.5 
Date: 31 Aug 2002 21:38:51 +0200
Message-Id: <1030822731.1458.127.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-r40RLSMeqxyr1+gkFbhM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2002-08-31 at 21:36, Linus Torvalds wrote:
> 
> On 31 Aug 2002, Luca Barbieri wrote:
> >
> > But aren't credential changes supposed to be infrequent?
> > 
> > If so, isn't it faster to put the fields directly in task_struct, keep a
> > separate shared structure and copy them on kernel entry?
> 
> But that makes us copy them every time, even though they practically never 
> change.. Much better to only copy them in the extremely rare cases when 
> they do change.
Sorry, I have explained myself incorrectly.
When credentials are changed, the changing task walks the list of tasks
sharing credentials with him and sets the propagate_cred flag in their
thread_info's.
The assembly code at entry checks this.
It's just two instructions, one memory read:
cmpl $0, propagate_cred(%ebx)
jnz do_propagate_cred

We could use the flags field, but we need atomic and/or and we still
don't have them for all architectures.
We could even merge this with the syscall trace check (but that brings
more complexity to avoid races).

Then the rest of the code doesn't need to know at all that credentials
are shared and is simpler and faster.
We have however a larger penalty on credential change but, as you say,
that's extremely rare (well, perhaps not necessarily extremely, but
still rare).


--=-r40RLSMeqxyr1+gkFbhM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cRtLdjkty3ft5+cRArNpAKDYB3Lxl2WAmWZcmrAkIdrENEaE/wCeLAxy
UY8MNOFIemMnIsVuAU/M8sc=
=CUwb
-----END PGP SIGNATURE-----

--=-r40RLSMeqxyr1+gkFbhM--
