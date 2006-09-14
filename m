Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWINPrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWINPrm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWINPrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:47:42 -0400
Received: from tomts40.bellnexxia.net ([209.226.175.97]:60879 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750878AbWINPrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:47:41 -0400
Date: Thu, 14 Sep 2006 11:47:36 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>
Subject: Re: [PATCH 4/11] LTTng-core 0.5.108 : core
Message-ID: <20060914154736.GA28799@Krystal>
References: <20060914034308.GE2194@Krystal> <20060914074306.GQ17042@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_Krystal-21075-1158248856-0001-2"
Content-Disposition: inline
In-Reply-To: <20060914074306.GQ17042@admingilde.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 09:04:03 up 22 days, 10:12,  7 users,  load average: 2.63, 2.26, 1.74
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-21075-1158248856-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Martin Waitz (tali@admingilde.org) wrote:
> hoi :)
>=20
> On Wed, Sep 13, 2006 at 11:43:08PM -0400, Mathieu Desnoyers wrote:
> > +int ltt_module_register(enum ltt_module_function name, void *function,
> > +		struct module *owner)
> > +{
> > +	int ret =3D 0;
> > +=09
> > +	/* Protect these operations by disallowing them when tracing is
> > +	 * active */
> > +	if(ltt_traces.num_active_traces) {
> > +		ret =3D -EBUSY;
> > +		goto end;
> > +	}
>=20
> what would happen otherwise?
> can it happen that someone enables tracing between this check and
> the rest of the function?
=20
The ltt-statedump module was still in my FIXME list. Let's address it.

In _ltt_trace_start, we have a try_module_get(ltt_statedump_owner) to make =
sure
the module does not vanish when we try to call its functions. Then, in
ltt_trace_start, we have a call to ltt_statedump_functor(trace), which uses
functions in ltt-statedump (the code of this module is stripped from
lttng-core). However, if ltt-statedump is not loaded when the try_module_get
is first done, and only then is the functor is called, the module could
vanish while the functor is executed.

Note that the ltt_traces.num_active_traces modifications only happen when t=
he
ltt_traces_sem mutex is taken.

However, this scenario is possible (which is bad) :

CPU 0                                          CPU 1
ltt_trace_start                                ltt_trace_stop
  _ltt_trace_start : inc num_active_traces
                                               _ltt_trace_stop : dec
                                                           num_active_traces
  call statedump functor
                                               unload ltt-statedump

A possible solution to this problem would be to increment the ltt-statedump
reference count just around the function call :
in ltt_trace_start :=20

if(!try_module_get(ltt_statedump_owner)) {
  error handling...
} else {
  ltt_statedump_functor(trace);
  module_put(ltt_statedump_owner);
}

And inside the ltt-statedump module, we need to make sure the kthread that =
is
created exits before the functor returns. The side effect of this approach =
is
that the lttctl control program will block until the end of state dump upon
trace start. As it is not a problem, I will fix the code accordingly : remo=
ve
the kthread.

Now for the ltt-filter module (which is not implemented yet) : as its funct=
ion
pointer will be called in the tracing critical path, we cannot afford to
increment the module reference counter each time. This is why we have to co=
mbine
making sure that the num_active_traces count is 0 and waiting for each trac=
ing
code to finish (all uses of ltt-filter are surrounded by preempt_disable : =
the
waiting is done by synchronize_sched() while the ltt_traces_sem is taken, s=
o no
one can increment the num_active_traces).

The ltt-filter-control module (which is not implemented yet) is not a probl=
em :
it is surrounded by try_module_get/module_put and does not depend on the tr=
aces
being active or not.

The ltt-relay module is also protected by a mechanism similar to ltt-filter=
=2E It
is necessary because the function pointer is on the critical path.

So, to answer your question : the if(ltt_traces.num_active_traces) check is
only necessary to make sure that the filter module is not unloaded when a
trace is active. However, adding a simple synchronize_sched() to
ltt_module_unregister will fix this issue and add the ability to
register/unregister a filter module when tracing is active.

I will remove this superfluous check in the next version.


> > +	new_trace->transport =3D transport;
> > +	new_trace->ops =3D &transport->ops;
> > +
> > +	err =3D -new_trace->ops->create_dirs(new_trace);
>               ^ typo or intentional?
>=20
>=20

ltt_trace_create has a stardard of positive error values when
ltt_relay_create_dirs has negative error values, without any need to do so.=
 Good
catch :) It will be fixed in the next version.


Thanks for the comments!

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
=2Egpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-21075-1158248856-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFCXmYPyWo/juummgRAkovAJ4kLFz+XEvasfX+p6tJoJKrLCr9XwCfRXTT
Y4M6gJ51p5viqI/INZKTb2g=
=kcz1
-----END PGP SIGNATURE-----

--=_Krystal-21075-1158248856-0001-2--
