Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWITO5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWITO5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 10:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWITO5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 10:57:42 -0400
Received: from tomts22.bellnexxia.net ([209.226.175.184]:29945 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751588AbWITO5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 10:57:41 -0400
Date: Wed, 20 Sep 2006 10:57:39 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: Re: [PATCH] Linux Kernel Markers 0.2 for Linux 2.6.17
Message-ID: <20060920145739.GA8502@Krystal>
References: <20060919183447.GA16095@Krystal> <y0m4pv3ek49.fsf@ton.toronto.redhat.com> <20060919193623.GA9459@Krystal> <20060919194515.GB18646@redhat.com> <20060919202802.GB552@Krystal> <20060919210703.GD18646@redhat.com> <45106B20.6020600@opersys.com> <20060920132008.GF18646@redhat.com> <20060920133834.GB17032@Krystal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_Krystal-25586-1158764259-0001-2"
Content-Disposition: inline
In-Reply-To: <20060920133834.GB17032@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:56:07 up 28 days, 12:04,  2 users,  load average: 0.33, 0.21, 0.12
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-25586-1158764259-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Frank,

Here is a revised proposal (just the marker.h). Do you have ideas on how we=
 can
export the function symbol ? (is it necessary ?)

Any thoughts ?

----- BEGIN -----


#include <asm/marker.h>

#ifdef CONFIG_MARK_SYMBOL
#define MARK_SYM(name) \
        do  { \
                __asm__ ( "__mark_kprobe_" #name ":" ); \
        } while(0)
#else=20
#define MARK_SYM(name)
#endif


#ifdef CONFIG_MARK_CALL
#define MARK_CALL(name, format, args...) \
        do {\
                static void (*__mark_call_##name##_)(const char *fmt, ...) \
                        asm ("__mark_call_"#name); \
                if (unlikely (__mark_call_##name##_)) \
                        (void) (__mark_call_##name##_(format, ## args)); \
        } while(0)
#else
#define MARK_CALL(name, format, args...)
#endif

#define MARK(name, format, args...) \
        do { \
                __mark_check_format(format, ## args); \
                MARK_SYM(name); \
                MARK_CALL(name, format, ## args); \
        } while(0)

static inline __attribute__ ((format (printf, 1, 2)))
void __mark_check_format(const char *fmt, ...)
{ }


---- END ----



* Mathieu Desnoyers (compudj@krystal.dyndns.org) wrote:
> * Frank Ch. Eigler (fche@redhat.com) wrote:
> > Hi -
> >=20
> > > > [...]  For the static part of the instrumentation, a
> > > > marker that could be hooked up to either type of probing system was
> > > > desirable, which implies some sort of run-time changeability.
> > >=20
> > > Ok. So if I get what you're saying here, you'd like to be able to
> > > overload a marker?=20
> >=20
> > Sort of.  Remember, we discussed markers as *marking* places and
> > things, with the intent that they be decoupled from the actual
> > *action* that is taken when the marker is hit.
> >=20
> > > Can you suggest a macro that can do what you'd like. [...]
> >=20
> > Compare the kind of marker I showed at OLS and presently supported by
> > systemtap.  Its unparametrized version looks like this:
> >=20
> > #define STAP_MARK(name) do { \
> >    static void (*__mark_##name##_)(); \
> >    if (unlikely (__mark_##name##_)) \
> >    (void) (__mark_##name##_()); \
> > } while (0)
> >=20
> > A tracing/probing tool would hook up to a particular and specific
> > marker at run time by locating the __mark_NAME static variable (a
> > function pointer) in the data segment, for example using the ordinary
> > symbol table, and swapping into it the address of a compatible
> > back-end handler function.  When a particular tracing/probing session
> > ends, the function pointer is reset to null.
> >=20
> > Note that this technique:
> >=20
> > - operates at run time
> > - is portable
> > - in its parametrized variants, is type-safe
> > - does not require any future technology
> > - does impose some overhead even when a marker is not active
> >=20
> >=20
> Hi Frank,
>=20
> Yes, I think there is much to gain to switch from the 5 nops "jumpprobe" =
to
> this scheme. In its parametrized variant, the jump will probably jump ove=
r a
> stack setup and function call. Do you think I should simply switch from t=
he
> 5 nops marker to this technique ? I guess the performance impact of a
> predicted branch will be similar to 5 nops anyway...
>=20
> The clear advantage I see in the parametrized variant is that the paramet=
ers
> will be ready for the called function : it makes it trivial to access any
> variable from the traced function.
>=20
> Mathieu
>=20
>=20
> OpenPGP public key:              http://krystal.dyndns.org:8080/key/compu=
dj.gpg
> Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=
=20


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
=2Egpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-25586-1158764259-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFEVbjPyWo/juummgRAl0sAKCrL24wZwt1Dp/3zEXvFxLj1SmG/ACgn37z
qlSddrYODkzFKWJ0+OBIeIM=
=YhF2
-----END PGP SIGNATURE-----

--=_Krystal-25586-1158764259-0001-2--
