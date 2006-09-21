Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWIUVFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWIUVFN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWIUVFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:05:12 -0400
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:43442 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751556AbWIUVFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:05:10 -0400
Date: Thu, 21 Sep 2006 16:59:58 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Martin Bligh <mbligh@google.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe management)
Message-ID: <20060921205957.GA13175@Krystal>
References: <20060921160009.GA30115@Krystal> <20060921175648.GB22226@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_Krystal-4458-1158872398-0001-2"
Content-Disposition: inline
In-Reply-To: <20060921175648.GB22226@redhat.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:46:16 up 29 days, 17:54,  3 users,  load average: 0.03, 0.17, 0.20
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-4458-1158872398-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Frank Ch. Eigler (fche@redhat.com) wrote:
> Thank you for continuing on.
>=20
Thanks for the comments, see below :

> > +#define MARK_SYM(name) \
> > +		here: asm volatile \
> > +			(MARK_KPROBE_PREFIX#name " =3D %0" : : "m" (*&&here)); \
>=20
> Regarding MARK_SYM, if I read Ingo's message correctly, this is the
> only type of marker he believes is necessary, since it would put a
> place for kprobes to put a breakpoint.  FWIW, this still appears to be
> applicable only if the int3 overheads are tolerable, and if parameter
> data extraction is unnecessary or sufficiently robust "by accident".
>=20
I agree. And I don't see how the int3 approach fills the need of embedded
systems and high performance computing developers, so I think that a "call"
alternative, where the stack is set up by gcc itself, is worthy.
>=20
> Regarding:
>=20
> > +#define MARK_JUMP(name, format, args...) \
> > [...]
>=20
> All this leap/jump/branch elaboration may be based upon scanty
> benchmarks.  The plain conditional-indirect function call is already
> "fast", especially if its hosting compilation unit is compiled with
> -freorder-blocks.
>=20

Yes, I just wanted to show that there was some performance merits to this
technique, more benchmarks will be needed. The main problem I have seen with
your condition+call approach is that there is no safe way to remove the fun=
ction
pointer without causing a huge mess (null pointer dereference). This is why=
 I
thought of this alternative that has the abolity of keep a consistent execu=
tion
flow at _all_ times.

> Direct jumps to instrumentation are unlikely to be of a great deal of
> use, in that there would have to be some assembly-level code in
> between to save/restore affected registers.  Remember, ultimately the
> handler will be written in C.
>=20
Yup, I agree, but it's nice to have the ability to jump over inline functio=
ns :)

> Regarding use of an empty_function() sentinel instead of NULLs, it is
> worth measuring carefully whether a unconditional indirect call to
> such a dummy function is faster than a conditional indirect call.  It
> may have to be a per-architecture internal implementation option.
>=20
Yes, but you also have to take in account the stack setup cost. Idoubt that=
 it
will be faster than a jump, but this is worthy to test.

> Regarding varargs, I still believe that varargs have poorer
> type-safety.  Remember, it's not just type-safety at the marker site
> (which gcc's printf-format-checker could validate), but the handler's
> too.  I believe it is incorrect that a non-varargs function can always
> safely take a call from a varargs call - varargs changes the calling
> conventions.  This would mean that the handler would itself have to be
> varargs, with all the attendant run-time overheads.  (Plus the idea of
> using a build-time script to generate the non-verargs handlers from
> analyzing particular MARK() calls is itself probably a bit complex for
> its own good.)
>=20

Absolutely, you are right. Good catch! I am putting a asmlinkage prefix to =
the
probe function, which will make sure that every argument is passed on the s=
tack.

=46rom http://gcc.gnu.org/onlinedocs/gcc/Function-Attributes.html

"regparm (number)
    On the Intel 386, the regparm attribute causes the compiler to
    pass arguments number one to number if they are of integral type in
    registers EAX, EDX, and ECX instead of on the stack. Functions that
    take a variable number of arguments will continue to be passed all
    of their arguments on the stack.

    Beware that on some ELF systems this attribute is unsuitable for
    global functions in shared libraries with lazy binding (which is the
    default). Lazy binding will send the first call via resolving code
    in the loader, which might assume EAX, EDX and ECX can be clobbered,
    as per the standard calling conventions. Solaris 8 is affected by
    this. GNU systems with GLIBC 2.1 or higher, and FreeBSD, are believed
    to be safe since the loaders there save all registers. (Lazy binding
    can be disabled with the linker or the loader if desired, to avoid
    the problem.)"

so a regparm(0) seems like a good solution there.

> Regarding measurements in general, one must avoid being misled by
> microbenchmarks such as those that represent an extreme of caching
> friendliness.  It may be necessary to run large system-level tests to
> meaningfully compare alternatives.
>=20

Yes, the problem is that, after having ran such tests on a slower approach,=
 the
macrobenchmarks failed to show any difference. Yes, those tests should be d=
one,
but I don't expect any revelation from them.

>=20
> > +int marker_set_probe(const char *name, void (*probe)(const char *fmt, =
=2E..),
> > +			enum marker_type type);
> > +void marker_disable_probe(const char *name, void (*probe)(const char *=
fmt, ...),
> > +			enum marker_type type);
>=20
> I'm unclear about what a marker_type value represents.  Could you go
> over that again?
>=20

marker_type MARKER_CALL
  Sets the jump to a function call

marker_type MARKER_INLINE
  Sets the jump to the provided inline function

>=20
> > +static int marker_get_pointers(const char *name,
> > + [...]
> > +	ptrs->call =3D (void**)kallsyms_lookup_name(call_sym);
> > +	ptrs->jmpselect =3D (void**)kallsyms_lookup_name(jmpselect_sym);
> > +	ptrs->jmpcall =3D (void**)kallsyms_lookup_name(jmpcall_sym);
> > +	ptrs->jmpinline =3D (void**)kallsyms_lookup_name(jmpinline_sym);
> > +	ptrs->jmpover =3D (void**)kallsyms_lookup_name(jmpover_sym);
> > [...]
>=20
> I wonder whether, as for kprobes, it will be necessary to lock into
> memory a module containing an active marker.
>=20

Nope, as the module_exit _has_ to call marker_disable_probe and that
marker_disable_probe does a synchronize_sched(). Because the function call =
is
surrounded by preempt_disable(), there will be no execution stream within t=
he
function when the module will be unloaded.

Regards,

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
=2Egpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-4458-1158872398-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFEv1NPyWo/juummgRAviCAJ91SNtX+F1w2EmcrHVqxLrD2eS+AwCeNvaY
Tr5C0bSD6qI8p2q0aEDPdYY=
=IoR6
-----END PGP SIGNATURE-----

--=_Krystal-4458-1158872398-0001-2--
