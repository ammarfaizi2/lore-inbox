Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVC2K2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVC2K2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVC2K06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:26:58 -0500
Received: from dea.vocord.ru ([217.67.177.50]:60819 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262291AbVC2KYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:24:52 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Paul Jackson <pj@engr.sgi.com>
Cc: guillaume.thouvenin@bull.net, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, jlan@engr.sgi.com, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
In-Reply-To: <20050329004915.27cd0edf.pj@engr.sgi.com>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	 <20050328134242.4c6f7583.pj@engr.sgi.com> <1112079856.5243.24.camel@uganda>
	 <20050329004915.27cd0edf.pj@engr.sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nz6qBx8hv39reUed+f0q"
Organization: MIPT
Date: Tue, 29 Mar 2005 14:29:57 +0400
Message-Id: <1112092197.5243.80.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 29 Mar 2005 14:23:25 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nz6qBx8hv39reUed+f0q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-29 at 00:49 -0800, Paul Jackson wrote:
> Evgeniy wrote:
> > There is no overhead at all using CBUS.
>=20
> This is unlikely.  Very unlikely.
>=20
> Please understand that I am not trying to critique CBUS or connector in
> isolation, but rather trying to determine what mechanism is best suited
> for getting this accounting data written to disk, which is where I
> assume it has to go until some non-real time job gets around to
> analyzing it.  We already have the rest of the BSD Accounting
> information taking this batched up path directly to the disk.  There is
> nothing (that I know of) to be gained from delivering this new fork data
> with any higher quality of service, or to any other place.
>=20
> From what I can understand, correct me if I'm wrong, we have two
> alternatives in front of us (ignoring relayfs for a second):
>=20
>  1) Using fork_connector (presumably soon to include use of CBUS):
> 	- forking process enqueues data plus header for single fork

Here forking connector module "exits" and can handle next fork() on the
same CPU.
Different CPUs are handled independently due to per-cpu variables usage.

That is why it is very fast in "fast-path".

> 	- context switch
> 	- daemon process dequeues single fork data (is this a read or recv?)
> 	- daemon process mergers multiple fork data into single buffer
> 	- daemon process writes buffer for multiple forks (a write)
> 	- disk driver pushes buffer with data for multiple forks to disk

Not exactly.

 - context switch
 - CBUS daemon, which runs with +19 nice get a bunch [10 currently, nice
value and queue "length" are determined in experiments] of requests from
each CPU queue and send them using connector's cn_netlink_send.
 - cn_netlink_send reallocates a buffer for each message=20
[skb + allocation from 256-bytes pool in kmalloc],
walks through list of registered sockets and links given skb to the
requested socket queues.
 - context switch
 - userspace daemon is awakened from recv() syscall and does what it
want with provided data.
It can write it to disk, but may process in real-time or send to the
network.

The most expensive part is cn_netlink_send()/netlink_broadcast(),=20
with CBUS it is deferred to the safe time,
so fork() itself is not affected (it is only per-cpu locking + linking +
atomic allocation).
Since deferred message will be processed in "safe" time with low
priority, it should not=20
affect fork() too (but can).

>  2) Using a modified form of what BSD ACCOUNTING does now:
> 	- forking process appends single fork data to in-kernel buffer

It is not as simple.
It takes global locks several times, it access bunch of shared between
CPU data.
It calls ->stat() and ->write() which may sleep.

> 	- disk driver pushes buffer with data for multiple forks to disk


Here is the same deffering as in connector, only preparation is
different.
And acct.c preparation may sleep and works with shared objects and
locks,
so it is slower, but it has an advantage - data is already written to
the=20
storage.

> It seems to me to be rather unlikely that (1) is cheaper than (2).  It
> is no particular fault of connector or CBUS that this is so.  Even if
> there were no overhead at all using CBUS (which I don't believe), (1)
> still costs more, because it passes the data, with an added packet
> header, into a separate process, and into user space, before it is
> combined with other accounting information, and written back down into
> the kernel to go to the disk.

That work is deferred and does not affect in-kernel processes.
And why userspace fork connector should write data to the disk?
It can process it in-flight and write only results.
acct.c processing daemon needs to read data, i.e. transfer them from
kernelspace.
But again all that work is deferred and does not affect fork()
performance.

>=20
> > > ... The efficiency
> > > of getting this one extra <parent-pid, child-pid> out of the kernel
> > > seems to be one or two orders of magnitude worse than the rest of
> > > the accounting data.
> >=20
> > It can be easily changed.
> > One may send kernel/acct.c acct_t structure out of the kernel -=20
> > overhead will be the same: kmalloc probably will get new area from the
> > same 256-bytes pool, skb is still in cache.
>=20
> I have no idea what you just said.

Connector's overhead may come from memory allocation -=20
currently it calls alloc_skb(size, GFP_ATOMIC), skb allocation
calls kmem_cache_alloc() for skb itself and kmalloc() for
size + sizeof(struct skb_shared_info), which essentially=20
is allocation from the 256-bytes slab pool.

>=20
> > File writing accounting [kernel/acct.c] is slower,
>=20
> Sure file writing is slower than queuing on an internal list.  I don't
> care that getting the data where I want it is slower than getting it
> some other place that's only part way.

One needs to pay for speed.
In case of the acct.c price is high since writing is slow,=20
but one does not need to care about receiving part.
In the case of connector, price is low, but that requires
some additional process to fetch the data.

For some tasks one may be better than other, for others it is not.

> > and requires process' context to work with system calls.
>=20
> For some connector uses, that might matter.  For hooks in fork,
> that is no problem - we have all the process context one could
> want - two of them if that helps ;).
>
> > realyfs is interesting project, but it has different aims,=20
>=20
> That could well be ... I can't claim to know which of relayfs or
> connector would be better here, of the two.
>=20
>=20
> > while connector is purely control/notification mechanism
>=20
> However connector is, in this regard, overkill.  We don't need a single
> event notification mechanism here.  One of the key ways in which
> accounting such as this has historically minimized system load is to
> forgo any effort to provide any notification or data packet per event,
> and instead immediately work to batch the data up in bulk form, with one
> buffer containing the concatenated data for multiple events.  This
> amortizes the cost of almost all the handling, and of all the disk i/o,
> over many data collection events.  Correct me if I'm wrong, but
> fork_connector doesn't do this merging of events into a consolidated
> data buffer, so is at a distinct disadvantage, for this use, because the
> data merging is delayed, and a separate, user level process, is required
> to accomplish the merging and conversion to writable blocks of data
> suitable for storing on the disk.

It is design decision,=20
one may want to write all data even with slowdowning
the system, but later process it all at once,=20
but one may want to process it in real-time in small pieces and have
direct=20
vision of how the system behaves, and thus it requires very small
overhead.
Userspace fork connector daemon may send data to the network or transfer
it using some other mechanism without touching disk IO subsystem,
and it is faster than writing it disk, then reading it or may be
seeking,
and transfer again.

One instrument is better for one type of taks,=20
others are suitable for different.

> Nothing wrong with a good screwdriver.  But if you want to pound nails,
> hammers, even rocks, work better.

He-he, while you lift your rock hammer, others can finish all the work
with theirs small instruments. :)

> --=20
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.60=
0.0401
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-nz6qBx8hv39reUed+f0q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCSS4lIKTPhE+8wY0RAorbAJ9Icixyvp2tquxbrHjPX2sJCUBFYQCfRcAL
5lGgdX8xALX0FmGC2IdcEuE=
=wsLq
-----END PGP SIGNATURE-----

--=-nz6qBx8hv39reUed+f0q--

