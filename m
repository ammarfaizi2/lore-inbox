Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUGMSxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUGMSxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 14:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUGMSxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 14:53:19 -0400
Received: from ultra1.eskimo.com ([204.122.16.64]:49417 "EHLO
	ultra1.eskimo.com") by vger.kernel.org with ESMTP id S265668AbUGMSxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 14:53:15 -0400
Date: Tue, 13 Jul 2004 11:53:08 -0700
From: Elladan <elladan@eskimo.com>
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040713185308.GA9541@eskimo.com>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org> <m1smc09p6m.fsf@ebiederm.dsl.xmission.com> <E1BjmAw-0005MS-00@bigred.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BjmAw-0005MS-00@bigred.inka.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 11:47:58PM +0200, Olaf Titz wrote:
> > For some of us who are extremely familiar with C your argument is
> > confusing.  You make statements that sound like they are about the
> > definition of the C programming language when in fact they are
> > criticism of a given C programming style.
> >
> > Since I am already making distinctions 0 as the integer value and
> > 0 as the pointer constant when 0 is implicitly introduced.  It is
> > really not confusing to me in the case of manifest constants.
> 
> So the real question is why C has no "null" token like Java or Pascal
> and re-uses the "0" token (which is really no token by itself but a
> numeric-constant token which happens to have a special value).
> 
> If your argument holds that "0" in a pointer context really is a
> special token like Java's "null" (which is explicitly defined by the
> standard as a pointer different from any other pointer) then it would
> be possible to implement a compiler which not only defines NULL to
> -1L, as someone mentioned here, but actually generates an all-ones bit
> pattern out of the constant 0 when used in a pointer context, yet
> generates an all-zeros bit pattern when used in an integer context.
> It also would have to implement the implicit null-comparison in a
> boolean context appropriately.

This indeed is possible, and has been implemented in the past.  Some
segmented architectures use different segments for different data types,
and a segment tag is part of the appropriate null pointer.  Also,
obviously, some pointer types are different widths on some
architectures.

The C languages was defined in such a way that it works fine on such an
architecture.  int *p = 0;  will always result in the appropriate null
pointer for integers.

The one exception is if you have a variadic function, in which case you
have to cast the null pointer to the right type, eg. 
printf("%s\n", (char*)0);

What's not allowed in conformant portable C is clearing pointers to null
using memset.  That just results in a zero bit pattern.

Eg.,

struct foo {
	int *bar;
} x;
memset(&x, 0, sizeof(x));

However, implicit initializers are valid, and will fill in pointer types
with the appropriate null value, eg:

struct foo {
	int *bar;
} x = {};

In addition, defining NULL as (void*)0 is completely broken.  A void*
null pointer is not valid as a null pointer for some other type - void*
is a transitional type, it simply holds the bit values of other pointers
so you can cast them back later.

-J
