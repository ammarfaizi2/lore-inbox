Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319500AbSH2Wy4>; Thu, 29 Aug 2002 18:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319521AbSH2Wxz>; Thu, 29 Aug 2002 18:53:55 -0400
Received: from ppp-217-133-223-7.dialup.tiscali.it ([217.133.223.7]:58322 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S319500AbSH2WxS>;
	Thu, 29 Aug 2002 18:53:18 -0400
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
From: Luca Barbieri <ldb@ldb.ods.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020828121129.A35@toy.ucw.cz>
References: <1030506106.1489.27.camel@ldb>  <20020828121129.A35@toy.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-IOujb7EJAiTOc6lsxo04"
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Aug 2002 00:57:35 +0200
Message-Id: <1030661855.1490.98.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IOujb7EJAiTOc6lsxo04
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > This patch implements a system that modifies the kernel code at runtime
> > depending on CPU features and SMPness.
> 
> Nice!
> > This patch requires the is_smp() patch I posted earlier and also
> > requires the new CPU selection code and the code that actually uses
> > both.
> > This code already exists, but needs a few adjustments so it may not
> > arrive immediately.
> > 
> > The code is invoked in the following ways:
> >         * Undefined exception handler: this is used to replace
> >           unsupported instructions with supported ones. Used for invlpg
> >           -> flushall, prefetchnta -> prefetch -> nop, *fence -> lock
> >           addl 0, (%esp), movntq -> movq
> >         * Int3 handler: this is used when a 1 byte opcode is desired.
> >           This is controlled by a config option so that debuggers and
> >           kprobe won't break. Used for lock/nop and APIC write
> 
> Why not do *everything* using int3 handler? It should simplify your code.
Because kdb, kgdb and kprobe want to use int3 so it must be used only if
the config option is enabled.

> Hooking on 'unknown instruction' should not be really neccessary if you
> replace all invlpgs (etc) with 0xcc...
It's better: first, if it is supported we have no faults.
Second, in some cases (e.g. movntq) it's not possible without adding
extra padding when using int xx (and int3 can't be used for the reason
above).

> > Unfortunately with this patch executing invalid code will cause the
> > processor to enter an infinite exception loop rather than panic. Fixing
> > this is not trivial for SMP+preempt so it's not done at the moment.
> 
> Using 0xcc for everything should fix that, right?
Not possible. See above.

This could be fixed by checking whether the opcode is not one generated
or recognized by the dynamic fixup code, assuming that nothing else can
change the code.
However, this fails to detect "impossible" cases like cpus that should
understand prefetches but that don't.


--=-IOujb7EJAiTOc6lsxo04
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9bqbfdjkty3ft5+cRApzeAJ0YJAbikV8OcJ6FCzpfwYdp7OmgCwCg0Rmq
v1dc44R1ZcWOthg4mZ1vfTg=
=6w4p
-----END PGP SIGNATURE-----

--=-IOujb7EJAiTOc6lsxo04--
