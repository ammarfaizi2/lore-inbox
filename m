Return-Path: <linux-kernel-owner+w=401wt.eu-S932814AbXASRPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932814AbXASRPN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932821AbXASRPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:15:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39713 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932814AbXASRPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:15:11 -0500
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: can someone explain "inline" once and for all?
References: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Fri, 19 Jan 2007 15:15:03 -0200
In-Reply-To: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6> (Robert P. J. Day's message of "Fri\, 19 Jan 2007 06\:56\:54 -0500 \(EST\)")
Message-ID: <orzm8f9bvs.fsf@redhat.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 19, 2007, "Robert P. J. Day" <rpjday@mindspring.com> wrote:

>   first, there appear to be three possible ways of specifying an
> inline routine in the kernel source:

inline, __inline and __inline__ are equivalent as far as GCC is
concerned, as you've already figured out.

> i vaguely recall that this has something to do with a distinction
> between C99 inline and gcc inline

I suspect you're thinking of a different issue.

In C99, static inline means the same as in GNU89, non-static
non-extern inline means 'use this definition, that does not define
objects with static storage nor references identifiers with internal
linkage, for inlining or for a local definition, but make calls to it
fast and don't generate any out-of-line definition', and extern inline
means 'compile this code into a global out-of-line function, but also
inline it wherever it makes sense'.

In GNU89, static inline means 'compile this code into a local
out-of-line function if needed, but also inline it wherever it makes
sense', non-static non-extern inline means 'compile this code into a
global out-of-line function, but also inline it wherever it makes
sense', and extern inline means 'use this definition for inlining, but
don't generate any out-of-line definition; because either I have a
non-inline definition in this or in another translation unit, or I
want undefined-symbol errors at link time if inlining fails.'

So you see that the meaning of extern inline and non-extern inline are
also reversed comparing GNU89 with C99.  That's quite unfortunate,
and GNU libc went to some trouble to encapsulate the intended inline
meaning into preprocessor macros even in user headers, such that the
intended meaning is obtained regardless of the compiler version.

Fortunately, static inline is probably the most useful and thus common
case anyway.  Other constructs will work as in GNU89 up to GCC 4.3,
even with -std=c99, but the meaning of inline in C99 and GNU99 is
intended to be fixed to the C99 semantics in GCC 4.4, according to
http://gcc.gnu.org/ml/gcc/2006-11/msg00006.html

That's still a long way ahead (the 4.3 development cycle has just
started), but it wouldn't hurt to start fixing incompatibilities
sooner rather than later, and coming up with a clean and uniform set
of inline macros that express intended meaning for the kernel to use.

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
FSF Latin America Board Member         http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
