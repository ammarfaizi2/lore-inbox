Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319459AbSH3AGn>; Thu, 29 Aug 2002 20:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319466AbSH3AGn>; Thu, 29 Aug 2002 20:06:43 -0400
Received: from ppp-217-133-223-7.dialup.tiscali.it ([217.133.223.7]:32680 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S319459AbSH3AGm>;
	Thu, 29 Aug 2002 20:06:42 -0400
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
From: Luca Barbieri <ldb@ldb.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1030663955.1327.27.camel@irongate.swansea.linux.org.uk>
References: <1030506106.1489.27.camel@ldb>  <20020828121129.A35@toy.ucw.cz>
	<1030663192.1326.20.camel@irongate.swansea.linux.org.uk> 
	<1030663772.1491.107.camel@ldb> 
	<1030663955.1327.27.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-RZV3Zv0oIlWdhq92TtDM"
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Aug 2002 02:10:56 +0200
Message-Id: <1030666256.1491.143.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RZV3Zv0oIlWdhq92TtDM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2002-08-30 at 01:32, Alan Cox wrote:
> On Fri, 2002-08-30 at 00:29, Luca Barbieri wrote:
> > Worked around by making sure all other processors are stopped (iret is
> > serializing) sending IPIs if they are not already spinning on the fixup
> > lock. See patch #2.
> 
> what happens we you do a fixup and the fixup occurs in an IPI handler
> (eg a cross CPU tlb flush).
Why should something bad happen in this case? (unless it happens in the
IPI handler for the SMP lock vector, but I've duplicated the spinlock
and apic-ack code to avoid using the fixups).

I've just noticed another problem instead: we might have a CPU waiting
with interrupts disabled for the CPU executing the fixup.
This could be fixed by waiting for a limited amount of iterations and
then emulating the instruction, but it makes the code even uglier.

We might get deadlocks on NMIs but that would also happen if we e.g. get
a memory parity NMI inside printk (deadlock on logbuf_lock). Should both
bugs be fixed?

> > > For the other fixups though you -have- to do them before you
> > > run the code. That isnt hard (eg sparc btfixup). You generate a list of
> > > the addresses in a segment, patch them all and let the init freeup blow 
> > > the table away
> > Is doing them at runtime with the aforementioned workaround fine?
> 
> Is doing them all in the beginning not somewhat saner and more
> debuggable.
That wouldn't work for compiler-generated prefetches (unless you
preprocess the compiler output) and would enlarge the kernel.
However, it would be significantly cleaner.

> The only reason to do it at runtime is hotplugging a less
> capable CPU. I have a suggestion for that case which is that we don't
> bother about it 8)
Even if we fixup at runtime this won't work since we the fixed up
instructions won't fault.
To handle this, we would need to keep the table around, stop CPUs and
fixup.
Anyway this scenario is quite unlikely.


--=-RZV3Zv0oIlWdhq92TtDM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9brgQdjkty3ft5+cRAlSAAKDFXz05Ssm93mUOaDqaynVzL/qUDwCbBZZY
8MUuYDOpV2Kun8IZzC0CVFk=
=/mxj
-----END PGP SIGNATURE-----

--=-RZV3Zv0oIlWdhq92TtDM--
