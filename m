Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVDAKuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVDAKuf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 05:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVDAKuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 05:50:35 -0500
Received: from dea.vocord.ru ([217.67.177.50]:31115 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262699AbVDAKtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 05:49:45 -0500
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
	based on kenel connector.
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
In-Reply-To: <20050401023004.2a83dbe5.akpm@osdl.org>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	 <20050331162758.44aeaf44.akpm@osdl.org> <1112337814.9334.42.camel@uganda>
	 <20050331232625.09057712.akpm@osdl.org> <1112341514.9334.103.camel@uganda>
	 <20050331235927.6d104665.akpm@osdl.org> <1112345400.9334.157.camel@uganda>
	 <20050401012547.68c26523.akpm@osdl.org> <1112350615.9334.194.camel@uganda>
	 <20050401023004.2a83dbe5.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4tpgOyCOhIuGs44g/i+Y"
Organization: MIPT
Date: Fri, 01 Apr 2005 14:55:55 +0400
Message-Id: <1112352955.9334.225.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 14:49:17 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4tpgOyCOhIuGs44g/i+Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-01 at 02:30 -0800, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > > > keventd does very hard jobs on some of my test machines which=20
> > > > for example route big amount of traffic.
> > >=20
> > > As I said - that's going to cause _your_ kernel thread to be slowed d=
own as
> > > well.
> >=20
> > Yes, but it does not solve peak performance issues - all scheduled
> > jobs can run one after another which will decrease insert performance.
>=20
> Well the keventd handler would simply process all currently-queued
> messages.  It's not as if you'd only process one event per keventd callou=
t.

But that will hurt insert performance.
Processing all messages without splitting them up into pieces noticebly
slows insert operation down.

> > > I mean, it's just a choice between two ways of multiplexing the CPU. =
 One
> > > is via a context switch in schedule() and the other is via list trave=
rsal
> > > in run_workqueue().  The latter will be faster.
> >=20
> > But in case of separate thread one can control execution process,
> > if it will be called from work queue then insert requests=20
> > can appear one after another in a very interval,
> > so theirs processing will hurt insert performance.
>=20
> Why does insert performance matter so much?  These things still have to b=
e
> sent up to userspace.
>=20
> (please remind me why cbus exists, btw.  What functionality does it offer
> which the connector code doesn't?)

The main goal of CBUS is insert operation performance.
Anyone who wants to have maximum delivery speed should use direct
connector's
methods instead.

> > > > > Plus keventd is thread-per-cpu and quite possibly would be faster=
.
> > > >=20
> > > > I experimented with several usage cases for CBUS and it was proven=20
> > > > to be the fastest case when only one sending thread exists which ma=
nages
> > > > only very limited amount of messages at a time [like 10 in CBUS
> > > > currently]
> > >=20
> > > Maybe that's because the cbus data structures are insufficiently
> > > percpuified.  On really big machines that single kernel thread will b=
e a
> > > big bottleneck.
> >=20
> > It is not because of messages itself, but becouse of it's peaks,
> > if there is a peak then above mechanism will smooth it into
> > several pieces [for example 10 in each bundle, that value should be
> > changeable in run-time, will place it into TODO],
> > with keventd there is no guarantee that next peak will be processed
> > not just after the current one, but after some timeout.
>=20
> keventd should process all the currently-queued messages.  If messages ar=
e
> being queued quickly then that will be a lot of messages on each keventd
> callout.

But for maximum _insert_ operatios, none should process _all_ messages
at once,=20
even if there are many of them.
One needs to smooth peak message number into pieces and process each
piece after previous ane after some timeout.

> > > Introducing an up-to-ten millisecond latency seems a lot worse than s=
ome
> > > reduction in peak bandwidth - it's not as if pumping 100000 events/se=
c is a
> > > likely use case.  Using prepare_to_wait/finish_wait will provide some
> > > speedup in SMP environments due to reduced cacheline transfers.
> >=20
> > It is a question actually...
> > If we allow peak processing, then we _definitely_ will have insert=20
> > performance degradation, it was observed in my tests.
>=20
> I don't understand your terminology.  What is "peak processing" and how
> does it differ from maximum insertion rate?
>=20
> > The main goal of CBUS was exactly insert speed
>=20
> Why?

To allow connector usage in a really fast pathes.
If one cares about _delivery_ speed then one should use cn_netlink_send
().

> > - so
> > it somehow must smooth shape performance peaks, and thus
> > above budget was introdyced.
>=20
> An up-to-ten-millisecond latency between the kernel-side queueing of a
> message and the delivery of that message to userspace sounds like an
> awfully bad restriction to me.  Even one millisecond will have impact in
> some scenarios.

If you care about delivery speed stronger than insertion,=20
then you do not need to use CBUS, but cn_netlink_send() instead.

I will test smaller values, but doubt it will have better insert
performance.

> > It is similar to NAPI in some abstract way, but with different aims -=20
> > NAPI for speed improovement, but here we have peak smootheness.
> >=20
> > > > If too many deferred insert works will be called simultaneously
> > > > [which may happen with keventd] it will slow down insert operations
> > > > noticeably.
> > >=20
> > > What is a "deferred insert work"?  Insertion is always synchronous?
> >=20
> > Insert is synchronous in one CPU, but actuall message delivering is
> > deferred.
>=20
> OK, so why does it matter that "If too many deferred insert works will be
> called [which may happen with keventd] it will slow down insert operation=
s
> noticeably"?
>=20
> There's no point in being able to internally queue messages at a higher
> frequency than we can deliver them to userspace.  Confused.

Concider fork() connector - it is better for userspace
to return from system call as soon as possible, while information
delivering
about that event will be delayed.
Noone says that queueing is done in much higher rate then delivering,=20
it only shapes shart peaks when it is unacceptably to wait untill
delivery
is finished.

> > > > I did not try that case with the keventd but with one kernel thread=
=20
> > > > it was tested and showed worse performance.
> > >=20
> > > But your current implementation has only one kernel thread?
> >=20
> > It has a budget and timeout between each bundle processing.
> > keventd does not allow to create such a timeout between each bundle
> > processing.
>=20
> Yes, there's batching there.  But I don't understand why the ability to
> internally queue events at a high rate is so much more important than the
> latency which that batching will introduce.

With such mechanism we may use event notification in a really fast
pathes.
We always defer actuall work processing out from HW interrupts,=20
although for the task running from that interrupt it would be better
to steal the whole CPU and run there [in HW irq] until it finishes.

But if someone does not care about latencies it still may use=20
direct connector's method cn_netlink_send().

> (And keventd _does_ allow such batching.  schedule_delayed_work()).

And it is still unacceptible, since there may be too many events
delayed to the same time, so they all will be processed in the same
time,=20
which will hurt insert operation performance.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-4tpgOyCOhIuGs44g/i+Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTSi7IKTPhE+8wY0RAofPAJ4nOUOr2eCQZmjQOzp0cfsv/Nd80wCdFmQM
fDrYCf6rXTri3nXS+e7Ae7k=
=0FVO
-----END PGP SIGNATURE-----

--=-4tpgOyCOhIuGs44g/i+Y--

