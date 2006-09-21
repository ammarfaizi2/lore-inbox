Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWIUR7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWIUR7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 13:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWIUR7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 13:59:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52402 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751404AbWIUR7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 13:59:23 -0400
Date: Thu, 21 Sep 2006 13:56:48 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
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
Message-ID: <20060921175648.GB22226@redhat.com>
References: <20060921160009.GA30115@Krystal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20060921160009.GA30115@Krystal>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi -

> Yet, again, a new version. I integrated a full probe management
> mechanism.  [...]

Thank you for continuing on.

> +#define MARK_SYM(name) \
> +		here: asm volatile \
> +			(MARK_KPROBE_PREFIX#name " = %0" : : "m" (*&&here)); \

Regarding MARK_SYM, if I read Ingo's message correctly, this is the
only type of marker he believes is necessary, since it would put a
place for kprobes to put a breakpoint.  FWIW, this still appears to be
applicable only if the int3 overheads are tolerable, and if parameter
data extraction is unnecessary or sufficiently robust "by accident".


Regarding:

> +#define MARK_JUMP(name, format, args...) \
> [...]

All this leap/jump/branch elaboration may be based upon scanty
benchmarks.  The plain conditional-indirect function call is already
"fast", especially if its hosting compilation unit is compiled with
-freorder-blocks.

Direct jumps to instrumentation are unlikely to be of a great deal of
use, in that there would have to be some assembly-level code in
between to save/restore affected registers.  Remember, ultimately the
handler will be written in C.

Regarding use of an empty_function() sentinel instead of NULLs, it is
worth measuring carefully whether a unconditional indirect call to
such a dummy function is faster than a conditional indirect call.  It
may have to be a per-architecture internal implementation option.

Regarding varargs, I still believe that varargs have poorer
type-safety.  Remember, it's not just type-safety at the marker site
(which gcc's printf-format-checker could validate), but the handler's
too.  I believe it is incorrect that a non-varargs function can always
safely take a call from a varargs call - varargs changes the calling
conventions.  This would mean that the handler would itself have to be
varargs, with all the attendant run-time overheads.  (Plus the idea of
using a build-time script to generate the non-verargs handlers from
analyzing particular MARK() calls is itself probably a bit complex for
its own good.)

Regarding measurements in general, one must avoid being misled by
microbenchmarks such as those that represent an extreme of caching
friendliness.  It may be necessary to run large system-level tests to
meaningfully compare alternatives.


> +int marker_set_probe(const char *name, void (*probe)(const char *fmt, ...),
> +			enum marker_type type);
> +void marker_disable_probe(const char *name, void (*probe)(const char *fmt, ...),
> +			enum marker_type type);

I'm unclear about what a merker_type value represents.  Could you go
over that again?


> +static int marker_get_pointers(const char *name,
> + [...]
> +	ptrs->call = (void**)kallsyms_lookup_name(call_sym);
> +	ptrs->jmpselect = (void**)kallsyms_lookup_name(jmpselect_sym);
> +	ptrs->jmpcall = (void**)kallsyms_lookup_name(jmpcall_sym);
> +	ptrs->jmpinline = (void**)kallsyms_lookup_name(jmpinline_sym);
> +	ptrs->jmpover = (void**)kallsyms_lookup_name(jmpover_sym);
> [...]

I wonder whether, as for kprobes, it will be necessary to lock into
memory a module containing an active marker.


- FChE

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFEtJgVZbdDOm/ZT0RAk9mAJ442kN2nNuTRqm9io4IL2RBMBxJJgCdH8jX
mBQPmm8Pkl/7cH6hqIyIYmY=
=f+L/
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
