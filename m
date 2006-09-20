Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWITQhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWITQhe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWITQhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:37:34 -0400
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:8386 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751818AbWITQhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:37:32 -0400
Date: Wed, 20 Sep 2006 12:37:29 -0400
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
Message-ID: <20060920163729.GA14961@Krystal>
References: <y0m4pv3ek49.fsf@ton.toronto.redhat.com> <20060919193623.GA9459@Krystal> <20060919194515.GB18646@redhat.com> <20060919202802.GB552@Krystal> <20060919210703.GD18646@redhat.com> <45106B20.6020600@opersys.com> <20060920132008.GF18646@redhat.com> <20060920133834.GB17032@Krystal> <20060920145739.GA8502@Krystal> <20060920155358.GH18646@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_Krystal-1758-1158770250-0001-2"
Content-Disposition: inline
In-Reply-To: <20060920155358.GH18646@redhat.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:06:49 up 28 days, 13:15,  5 users,  load average: 0.37, 0.27, 0.19
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-1758-1158770250-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Frank Ch. Eigler (fche@redhat.com) wrote:
> While varargs simplify some things, it sacrifices type-safety, in that
> a handler function would have to be varargs too.  For the systemtap
> marker prototype, parametrized variants use scores of (automatically
> generated) macros, with different arity/type permutations, each
> self-describing and type-safe.
>=20
The format string could be used to provide some kind of type safety : the
compiler will check that arguments match the format string provided. From t=
here,
a simple script can parse the format string and generate a function prototy=
pe
accordingly. Correct me if I am wrong, but I think that if the called funct=
ion
has the exact same parameter layout as the varargs caller stack, the functi=
on
call should work (without the called function having a variable arguments l=
ist).

> Regarding a marker variant that would require kprobes (inserting a
> labelled NOP or few), it may be an appropriate choice where dormant
> marker overhead must be minimal and robust parameter passing is less
> important.
>=20

I even came with the following idea :

Instead of using a test + conditional predicted branch, we could jump to an
address locate just after the probe.

  jmp to over_symbol address
call_symbol
  call function pointer
over_symbol

This way, we could have portable :
- direct inconditional jump to an address following the marked site when
  disabled
- Enable stack setup and function call by setting the function pointer and
  changing the jmp target to be "call_symbol"
- Enable "direct jump to arbitrary assembly" by setting the jump target to
  arbitrary code, where this code can end by jumping to over_symbol.

The generated binary on x86 looks like :

  10:   a1 24 00 00 00          mov    0x24,%eax
  15:   ff e0                   jmp    *%eax
  17:   c7 44 24 04 01 00 00    movl   $0x1,0x4(%esp)
  1e:   00=20
  1f:   c7 04 24 00 00 00 00    movl   $0x0,(%esp)
  26:   ff 15 1c 00 00 00       call   *0x1c

With those symbols :

f8875c08 b __mark_subsys_mark1_call     [test_mark]  (function pointer)
f8875620 d __mark_subsys_mark1_jump_call        [test_mark]
f8875624 d __mark_subsys_mark1_jump_over        [test_mark]

The macro doing that :

#define MARK_CALL(name, format, args...) \
        do {\
                __label__ call_label, over_label; \
                static void *__mark_##name##_jump_over \
                        asm ("__mark_"#name"_jump_over") =3D \
                        &&over_label; \
                static void *__mark_##name##_jump_call \
                                asm ("__mark_"#name"_jump_call") \
                                __attribute__((unused)) =3D  \
                                &&call_label; \
                static void (*__mark_##name##_call)(const char *fmt, ...) \
                        asm ("__mark_"#name"_call") =3D __mark_empty_functi=
on; \
                goto *__mark_##name##_jump_over; \
call_label: \
                (void) (__mark_##name##_call(format, ## args)); \
over_label: \
                do {} while(0); \
        } while(0)

A problem I saw in your approach was that there was no way to remove the
function pointer without taking the risk to break everything.

The solution I came up with is to set the function to an empty
__mark_empty_function when disabled, and set another function pointer to en=
able
it.

Any thoughts ?

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
=2Egpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-1758-1158770250-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFEW5JPyWo/juummgRApqXAKCiqIHh5AQcVtL3NMK6Bd94IkoRowCgl4Ez
wzgoppghfKMwBiZM5stMwIw=
=7jpT
-----END PGP SIGNATURE-----

--=_Krystal-1758-1158770250-0001-2--
