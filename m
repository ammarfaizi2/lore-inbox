Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVDAIp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVDAIp7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 03:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVDAIp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 03:45:59 -0500
Received: from dea.vocord.ru ([217.67.177.50]:55475 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261440AbVDAIpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 03:45:45 -0500
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
	based on kenel connector.
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
In-Reply-To: <20050331235927.6d104665.akpm@osdl.org>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	 <20050331162758.44aeaf44.akpm@osdl.org> <1112337814.9334.42.camel@uganda>
	 <20050331232625.09057712.akpm@osdl.org> <1112341514.9334.103.camel@uganda>
	 <20050331235927.6d104665.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Api1QmiVItZBpfO93CN0"
Organization: MIPT
Date: Fri, 01 Apr 2005 12:50:00 +0400
Message-Id: <1112345400.9334.157.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 12:44:26 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Api1QmiVItZBpfO93CN0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-31 at 23:59 -0800, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > On Thu, 2005-03-31 at 23:26 -0800, Andrew Morton wrote:
> > > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > >
> > > > > > +static int cbus_event_thread(void *data)
> > > >  > > +{
> > > >  > > +	int i, non_empty =3D 0, empty =3D 0;
> > > >  > > +	struct cbus_event_container *c;
> > > >  > > +
> > > >  > > +	daemonize(cbus_name);
> > > >  > > +	allow_signal(SIGTERM);
> > > >  > > +	set_user_nice(current, 19);
> > > >  >=20
> > > >  > Please use the kthread api for managing this thread.
> > > >  >=20
> > > >  > Is a new kernel thread needed?
> > > >=20
> > > >  Logic behind cbus is following:=20
> > > >  1. make insert operation return as soon as possible,
> > > >  2. deferring actual message delivering to the safe time
> > > >=20
> > > >  That thread does second point.
> > >=20
> > > But does it need a new thread rather than using the existing keventd?
> >=20
> > Yes, it is much cleaner [especially from performance tuning point]=20
> > to use own kernel thread than pospone all work to the queued work.
> >=20
>=20
> Why?  Unless keventd is off doing something else (rare), it should be
> exactly equivalent.  And if keventd _is_ off doing something else then th=
at
> will slow down this kernel thread too, of course.

keventd does very hard jobs on some of my test machines which=20
for example route big amount of traffic.

> Plus keventd is thread-per-cpu and quite possibly would be faster.

I experimented with several usage cases for CBUS and it was proven=20
to be the fastest case when only one sending thread exists which manages
only very limited amount of messages at a time [like 10 in CBUS
currently]
without direct awakening [that is why wake_up() is commented in
cbus_insert()].
If too many deferred insert works will be called simultaneously
[which may happen with keventd] it will slow down insert operations
noticeably.
I did not try that case with the keventd but with one kernel thread=20
it was tested and showed worse performance.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-Api1QmiVItZBpfO93CN0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTQs4IKTPhE+8wY0RAvjlAKCYsqKRpNZwrQO8aidkFLQ1OOvKxQCcCOZA
9F0kruTX9EHWH+5jIlKqSps=
=+1RT
-----END PGP SIGNATURE-----

--=-Api1QmiVItZBpfO93CN0--

