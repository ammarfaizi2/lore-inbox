Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVC2HJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVC2HJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVC2HJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:09:03 -0500
Received: from dea.vocord.ru ([217.67.177.50]:58299 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262381AbVC2G6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:58:31 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Paul Jackson <pj@engr.sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>, akpm@osdl.org,
       greg@kroah.com, linux-kernel@vger.kernel.org, jlan@engr.sgi.com,
       efocht@hpce.nec.com, linuxram@us.ibm.com, gh@us.ibm.com,
       elsa-devel@lists.sourceforge.net
In-Reply-To: <20050328134242.4c6f7583.pj@engr.sgi.com>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	 <20050328134242.4c6f7583.pj@engr.sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-drN6FlnjfUN/TNS4h/zK"
Organization: MIPT
Date: Tue, 29 Mar 2005 11:04:16 +0400
Message-Id: <1112079856.5243.24.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 29 Mar 2005 10:57:45 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-drN6FlnjfUN/TNS4h/zK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-03-28 at 13:42 -0800, Paul Jackson wrote:
> Guillaume wrote:
> >   The lmbench shows that the overhead (the construction and the sending
> > of the message) in the fork() routine is around 7%.
>=20
> Thanks for including the numbers.  The 7% seems a bit costly, for a bit
> more accounting information.  Perhaps dean's suggestion, to not use
> ascii, will help.  I hope so, though I doubt it will make a huge
> difference.  Was this 7% loss with or without a user level program
> consuming the sent messages?  I would think that the number of interest
> would include a minimal consumer task.

There is no overhead at all using CBUS.
On my old P2/256mb SMP machine it took about 950 usec=20
to create+exit process both with fork connector turned on and=20
without it even compiled.
Direct connector's method call took about 1000-1100 usec.
Current fork connector does not use CBUS [yet, I hope].

> I don't see a good reason to make fork_connector() inline.  Since it
> calls other subroutines and is not just a few lines, perhaps better to
> make it a real routine, so we can see it in "nm --print-size" output and
> debug stacks.
>=20
> Having the "#ifdef CONFIG_FORK_CONNECTOR" chunk of code right in fork.c
> seems unfortunate.  Can the real fork_connector() be put elsewhere, and
> the ifdef put in a header file that makes it a no-op if not configured,
> or simply a function declaration, if configured?
>=20
> What's the status of the connector driver patch?  I perhaps wasn't
> paying close enough attention, but all I see of it now is a couple of
> patches sent to lkml, from Evgeniy Polyakov, in September and January.
> I don't see it in my copies of *-mm or recent Linus bk trees.  Am I
> missing something?

It was dropped from -mm tree, since bk tree where it lives=20
was in maintenance mode.
I think connector will be appeared in the next -mm release.

> This still seems to me like more apparatus than is desirable, just to
> get another form of session id, as best as I can figure it.  However
> we've already been there, and apparently my concerns were not
> persuasive.  If one does go down this path, then using this connector
> patch is a good an alternative as any I know of.  Well, that or relayfs.
> My uneducated assumption is that relayfs might at least batch data
> packets up into big buffer chunks better, but someone more knowledgeable
> than me needs to consider that.
>=20
> It's a little sad, when almost all the required accounting information
> comes out in packed 64 byte records, carefully buffered and sent in
> big chunks, to minimize per-task costs.  Then this one extra detail,
> of <parent-pid, child-pid> requires an entire netlink packet of
> its own of what size -- another 50 or 100 bytes?  Is this packet
> received as a separate data packet, on its own recv(2) system call,
> by the user task, not in a big block of packets?  The efficiency
> of getting this one extra <parent-pid, child-pid> out of the kernel
> seems to be one or two orders of magnitude worse than the rest of
> the accounting data.

It can be easily changed.
One may send kernel/acct.c acct_t structure out of the kernel -=20
overhead will be the same: kmalloc probably will get new area from the
same 256-bytes pool, skb is still in cache.

> =3D=3D=3D
>=20
> Hmmm ... perhaps one could add a _second_ accounting file, cutting and
> pasting code in kernel/acct.c and enabling writing additional
> information to that second file, using the same mechanisms as now used
> for the primary file.  Use a more extensible record format for the
> second file (say start each record with a magic cookie, a byte record
> type and a byte record length, then that many bytes).  That way, we have
> an escape valve for adding additional record types in the future.
> And that way we can efficiently write short records, with just say
> a couple of interesting values, and minimal overhead.
>=20
> Don't worry if the magic cookie appears as part of the raw data.  If one
> has to resync such a data stream, one can look for a series of records,
> each starting with the magic cookie, sensible record type byte, and a
> length that ends right at the next such valid record.  The occassional
> duplication of the same cookie within the data stream would not thwart a
> resync for long.  And the main purpose of the magic cookie is to make
> sure you are still in sync, not reverting to garbage-in, garbage-out,
> mode.  Almost any magic value other than 0x0000 will suffice for that
> purpose.
>=20
> I just ran a silly little test on my PC desktop Linux box, scanning
> /proc/kcore.  The _least_ common 2 byte word seen was 0x2B91, with 31
> instances in a half-billion words scanned, so I nominate that value for
> the magic cookie ;).
>=20
> The key reason that it might make sense here to adapt the existing
> accounting file direct write mechanism, rather than using "connector" or
> "relayfs", is that we really do want to get this data to disk initially.
> Relayfs is optimized for getting alot of data to a user daemon, and the
> connector for sending smaller packets of data to a user daemon.  But
> accounting processing is sometimes done out of a cron job off-hours.
> During the day (the busy hours) you might just want to stash the stuff
> with as little performance impact is possible.  If one can avoid _any_
> other task having to context switch in, in order to get this data on its
> way, that is a huge win.

File writing accounting [kernel/acct.c] is slower, it takes global
locks=20
and requires process' context to work with system calls.
realyfs is interesting project, but it has different aims,=20
as far as I can see, - it is created for transferring huge amounts of
data,
and it is succeded in it, while connector is purely
control/notification=20
mechanism, for example, for gathering short-living per-process
accounting data.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-drN6FlnjfUN/TNS4h/zK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCSP3wIKTPhE+8wY0RAnEKAJ46PqRPM8vIv9Htz4SunOmPIsmUNQCfR0Xg
JZewspdMEAyPKxt92JQqBec=
=a5Qx
-----END PGP SIGNATURE-----

--=-drN6FlnjfUN/TNS4h/zK--

