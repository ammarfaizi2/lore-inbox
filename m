Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVDAKL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVDAKL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 05:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVDAKL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 05:11:26 -0500
Received: from dea.vocord.ru ([217.67.177.50]:45019 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262685AbVDAKLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 05:11:10 -0500
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
	based on kenel connector.
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
In-Reply-To: <20050401012547.68c26523.akpm@osdl.org>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	 <20050331162758.44aeaf44.akpm@osdl.org> <1112337814.9334.42.camel@uganda>
	 <20050331232625.09057712.akpm@osdl.org> <1112341514.9334.103.camel@uganda>
	 <20050331235927.6d104665.akpm@osdl.org> <1112345400.9334.157.camel@uganda>
	 <20050401012547.68c26523.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-e5MR/ewWdmfqb1YLIMrr"
Organization: MIPT
Date: Fri, 01 Apr 2005 14:16:55 +0400
Message-Id: <1112350615.9334.194.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 14:10:24 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-e5MR/ewWdmfqb1YLIMrr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-01 at 01:25 -0800, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > On Thu, 2005-03-31 at 23:59 -0800, Andrew Morton wrote:
> > > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > >
> > > > On Thu, 2005-03-31 at 23:26 -0800, Andrew Morton wrote:
> > > > > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > > >
> > > > > > > > +static int cbus_event_thread(void *data)
> > > > > >  > > +{
> > > > > >  > > +	int i, non_empty =3D 0, empty =3D 0;
> > > > > >  > > +	struct cbus_event_container *c;
> > > > > >  > > +
> > > > > >  > > +	daemonize(cbus_name);
> > > > > >  > > +	allow_signal(SIGTERM);
> > > > > >  > > +	set_user_nice(current, 19);
> > > > > >  >=20
> > > > > >  > Please use the kthread api for managing this thread.
> > > > > >  >=20
> > > > > >  > Is a new kernel thread needed?
> > > > > >=20
> > > > > >  Logic behind cbus is following:=20
> > > > > >  1. make insert operation return as soon as possible,
> > > > > >  2. deferring actual message delivering to the safe time
> > > > > >=20
> > > > > >  That thread does second point.
> > > > >=20
> > > > > But does it need a new thread rather than using the existing keve=
ntd?
> > > >=20
> > > > Yes, it is much cleaner [especially from performance tuning point]=20
> > > > to use own kernel thread than pospone all work to the queued work.
> > > >=20
> > >=20
> > > Why?  Unless keventd is off doing something else (rare), it should be
> > > exactly equivalent.  And if keventd _is_ off doing something else the=
n that
> > > will slow down this kernel thread too, of course.
> >=20
> > keventd does very hard jobs on some of my test machines which=20
> > for example route big amount of traffic.
>=20
> As I said - that's going to cause _your_ kernel thread to be slowed down =
as
> well.

Yes, but it does not solve peak performance issues - all scheduled
jobs can run one after another which will decrease insert performance.

> I mean, it's just a choice between two ways of multiplexing the CPU.  One
> is via a context switch in schedule() and the other is via list traversal
> in run_workqueue().  The latter will be faster.

But in case of separate thread one can control execution process,
if it will be called from work queue then insert requests=20
can appear one after another in a very interval,
so theirs processing will hurt insert performance.

> > > Plus keventd is thread-per-cpu and quite possibly would be faster.
> >=20
> > I experimented with several usage cases for CBUS and it was proven=20
> > to be the fastest case when only one sending thread exists which manage=
s
> > only very limited amount of messages at a time [like 10 in CBUS
> > currently]
>=20
> Maybe that's because the cbus data structures are insufficiently
> percpuified.  On really big machines that single kernel thread will be a
> big bottleneck.

It is not because of messages itself, but becouse of it's peaks,
if there is a peak then above mechanism will smooth it into
several pieces [for example 10 in each bundle, that value should be
changeable in run-time, will place it into TODO],
with keventd there is no guarantee that next peak will be processed
not just after the current one, but after some timeout.

> > without direct awakening [that is why wake_up() is commented in
> > cbus_insert()].
>=20
> You mean the
>=20
> 	interruptible_sleep_on_timeout(&cbus_wait_queue, 10);
>=20
> ?  (That should be HZ/100, btw).
>=20
> That seems a bit kludgy - someone could queue 10000 messages in that time=
,
> although they'll probably run out of memory first, if it's doing
> GFP_ATOMIC.

GFP_ATOMIC issues will be resolved first.

> Introducing an up-to-ten millisecond latency seems a lot worse than some
> reduction in peak bandwidth - it's not as if pumping 100000 events/sec is=
 a
> likely use case.  Using prepare_to_wait/finish_wait will provide some
> speedup in SMP environments due to reduced cacheline transfers.

It is a question actually...
If we allow peak processing, then we _definitely_ will have insert=20
performance degradation, it was observed in my tests.
The main goal of CBUS was exactly insert speed - so
it somehow must smooth shape performance peaks, and thus
above budget was introdyced.
It is similar to NAPI in some abstract way, but with different aims -=20
NAPI for speed improovement, but here we have peak smootheness.

> > If too many deferred insert works will be called simultaneously
> > [which may happen with keventd] it will slow down insert operations
> > noticeably.
>=20
> What is a "deferred insert work"?  Insertion is always synchronous?

Insert is synchronous in one CPU, but actuall message delivering is
deferred.

> > I did not try that case with the keventd but with one kernel thread=20
> > it was tested and showed worse performance.
>=20
> But your current implementation has only one kernel thread?

It has a budget and timeout between each bundle processing.
keventd does not allow to create such a timeout between each bundle
processing.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-e5MR/ewWdmfqb1YLIMrr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTR+XIKTPhE+8wY0RAnb3AJsHYcaW6B/z656ow68o+W5cNtKUdQCfWip1
CnnQQrWlbZxcdPB3MQH+pys=
=e6zy
-----END PGP SIGNATURE-----

--=-e5MR/ewWdmfqb1YLIMrr--

