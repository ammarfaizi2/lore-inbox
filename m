Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUHVFmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUHVFmh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 01:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUHVFmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 01:42:37 -0400
Received: from [24.68.24.66] ([24.68.24.66]:11136 "EHLO spitfire.gotdns.org")
	by vger.kernel.org with ESMTP id S266218AbUHVFme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 01:42:34 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] context-switching overhead in X, ioport(), 2.6.8.1
Date: Sat, 21 Aug 2004 22:42:30 -0700
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, rlrevell@joe-job.com
References: <20040821135516.GA3872@elte.hu> <20040821214632.62d58e40.davem@redhat.com>
In-Reply-To: <20040821214632.62d58e40.davem@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1994822.lSDL4Rctu0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408212242.33562.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1994822.lSDL4Rctu0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 21 August 2004 21:46, David S. Miller wrote:
> FWIW, I would recommend a sparse bitmap implementation for the
> ioport stuff.

The problem is that the sparse bitmap would have to be unpacked to the "den=
se"=20
bitmap that lives in the TSS on context switch. AFAICS, that would involve=
=20
walking the previous task's spare bitmap, clearing all the ports it had=20
access to, and then walking the next task's sparse bitmap and opening acces=
s=20
to its ports. I doubt this would be a big win over what Ingo says usually=20
reduces to a 128 byte or less memcpy(), especially when you consider the=20
added complexity.

The only big speedup I can see is in the case of only one task having anyth=
ing=20
set in its IO bitmap at all. I assume that most desktops running a single X=
=20
server fall in to this degenerate case, please correct me if I'm wrong. The=
re=20
we could simply set the TSS's io_bitmap_base to IO_BITMAP_OFFSET when=20
switching to the IO bitmap'ed task, and set it back to=20
INVALID_IO_BITMAP_OFFSET when we context switch away. That way the entire=20
thing is accomplished with a single 4-byte store per context switch until a=
=20
second IO bitmap'ed app is started, in which case we'd have to fall back to=
=20
memcpy()ing. Seems like too much complexity for what amounts to a=20
microoptimization, though.

BTW Ingo, have you looked at changing the almost identical code in=20
arch/x86-64? Or did it not get its bitmap expanded?

=2DRyan

--nextPart1994822.lSDL4Rctu0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBKDJJW4yVCW5p+qYRAjW1AKC8x8okaOvjEgcDRsEB6zRhPpNeKACfZwvs
GeQ39Oe5cgxha+ZxQ2QU3vI=
=F3fo
-----END PGP SIGNATURE-----

--nextPart1994822.lSDL4Rctu0--
