Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265238AbUGLRrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUGLRrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUGLRrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:47:24 -0400
Received: from quechua.inka.de ([193.197.184.2]:30088 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265238AbUGLRrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:47:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org> <m1smc09p6m.fsf@ebiederm.dsl.xmission.com>
Organization: private Linux site, southern Germany
Date: Sun, 11 Jul 2004 23:47:58 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E1BjmAw-0005MS-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Only because the definition of the semantics of ``if'' is in terms of
> comparisons with ``0'',  and I am familiar enough with the C
> programming language that, that is how I read it.  It is still
> the case that because the comparison happens in pointer context the
> ``0'' referred  to is the null pointer constant.
>
> For some of us who are extremely familiar with C your argument is
> confusing.  You make statements that sound like they are about the
> definition of the C programming language when in fact they are
> criticism of a given C programming style.
>
> Since I am already making distinctions 0 as the integer value and
> 0 as the pointer constant when 0 is implicitly introduced.  It is
> really not confusing to me in the case of manifest constants.

So the real question is why C has no "null" token like Java or Pascal
and re-uses the "0" token (which is really no token by itself but a
numeric-constant token which happens to have a special value).

If your argument holds that "0" in a pointer context really is a
special token like Java's "null" (which is explicitly defined by the
standard as a pointer different from any other pointer) then it would
be possible to implement a compiler which not only defines NULL to
-1L, as someone mentioned here, but actually generates an all-ones bit
pattern out of the constant 0 when used in a pointer context, yet
generates an all-zeros bit pattern when used in an integer context.
It also would have to implement the implicit null-comparison in a
boolean context appropriately.

This probably would work with all programs which make a clear
distinction between pointers and integer values, but you have to be
really pedantic about these "stylistic" issues to always get it right
in C. (Worse in C++ where usage of NULL is discouraged, I've always
wondered about the reasons.)

The real problem, however, is that this "stylistic" issue may quickly
become a _correctness_ issue as soon as the actual bit pattern of a
pointer in memory is taken to have any meaning. I.e. it already starts
when you initialize a structure with memset().

And this is the reason why really strongly typed languages never allow
assignment of a pointer to or from any other data type. (Java is that
strict, Pascal has a possible backdoor in the "record case" structure
if implemented as overlays like C's unions but otherwise is as strict
too, not sure about Ada.)
_The bit pattern of a pointer must have no meaning to the program_.

To answer the question from the first paragraph, it is "because C does
_not_ strongly distinguish between pointer and non-pointer values".
And for this reason people have invented the NULL constant, and the
convention that
    "if (x)" means "if (x != 0)" in numeric context, and
    "if (x)" means "if (x != NULL)" in pointer context.

This resolves all the ambiguities and allows people to use C as a
strongly typed language, but can break with program(mer)s taking
pointers as equivalent to numbers.

Olaf

PS. I wonder how many bugs have been avoided in the Linux kernel by
this kind of style pedantery vs. how many bugs have crept into other
systems where people are more sloppy.

