Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVLPOb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVLPOb2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVLPOb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:31:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35594 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932292AbVLPOb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:31:27 -0500
Date: Fri, 16 Dec 2005 14:31:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linh Dang <linhd@nortel.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051216143110.GC1222@flint.arm.linux.org.uk>
Mail-Followup-To: Linh Dang <linhd@nortel.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	David Howells <dhowells@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org,
	hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com> <11202.1134730942@warthog.cambridge.redhat.com> <43A2BAA7.5000807@yahoo.com.au> <20051216132123.GB1222@flint.arm.linux.org.uk> <wn564ppnohn.fsf@linhd-2.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wn564ppnohn.fsf@linhd-2.ca.nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 08:46:44AM -0500, Linh Dang wrote:
> 
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > On Sat, Dec 17, 2005 at 12:01:27AM +1100, Nick Piggin wrote:
> >> You were proposing a worse default, which is the reason I suggested
> >> it.
> >
> > I'd like to qualify that.  "for architectures with native cmpxchg".
> >
> > For general consumption (not specifically related to mutex stuff)...
> >
> > For architectures with llsc, sequences stuch as:
> >
> > 	load
> > 	modify
> > 	cmpxchg
> >
> > are inefficient because they have to be implemented as:
> >
> > 	load
> > 	modify
> > 	load
> > 	compare
> > 	store conditional
> >
> 
> I dont know what arch u have in mind but for ppc it is:
> 
>         load-reserve
>         modify
>         store-conditional
> 
> and NOT the sequence you show.

Wrong - because you haven't understood what I'm getting at.  If you're
using "cmpxchg" as the low level generic atomic operation (as in the
atomic_cmpxchg() function) then atomic_cmpxchg _has_ to be implemented
on llsc as:

	load (reserve if you need this detail)
	compare
	store conditional

So, let's illustrate this.  Let's say you want to atomically multiply
a value by N.

	do {
		old = atomic_read(&foo);
		new = old * N;
	} while(atomic_cmpxchg(&foo, old, new) != old);

For an architecture supporting cmpxchg, this becomes:

loop:	load foo => old
	new = old * N
	cmpxchg ret, old, new, foo
	compare ret & old
	if not equal goto loop

And for architectures with llsc, this becomes:

loop:	load foo => old
	new = old * N
loop2:	load locked foo => ret
	compare ret & old
	if equal store conditional new in foo
		if store failed because we lost the lock, goto loop2
	compare ret & old
	if not equal goto loop

Do you now see what I mean?  (yup, ARM is a llsc architecture.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
