Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157672-8093>; Mon, 11 Jan 1999 02:20:14 -0500
Received: by vger.rutgers.edu id <154101-8093>; Mon, 11 Jan 1999 00:44:22 -0500
Received: from noc.nyx.net ([206.124.29.3]:1180 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <156919-8100>; Sun, 10 Jan 1999 18:42:49 -0500
Date: Sun, 10 Jan 1999 16:37:17 -0700 (MST)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199901102337.QAA05245@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Sun Jan 10 16:37:17 1999, Sender=colin, Recipient=, Valsender=colin@localhost
To: sct@redhat.com
Subject: Re: tiny patch, reduces kernel memory usage
Cc: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

Stephen Tweedie wrote:
> The unused field needs to go.  Fine.  The map_nr field is needed to
> avoid a division when we try to find a page number from a struct page.

Um, it's a division by a constant, which GCC optimizes to a multiply.
GCC also knows that the division must have no remainder, so it can do even
better than the usual case.)

For example,
struct x {
	unsigned c[13];
};

unsigned foo (struct x *p1, struct x *p2)
{
	return p2-p1;
}

On an x86 with egcc -O2 -fomit-frame-pointer produces:
foo:
	movl 8(%esp),%eax
	subl 4(%esp),%eax
	imull $-991146299,%eax,%eax
	sarl $2,%eax
	ret

A multiply is not a trivial cost, but it's cheaper than a divide.
(And depending on the multiplier, GCC can optimize it further into
a series of shifts and adds.)

Any odd number x has a multiplicative inverse y such that
(x*y) == 1 (mod 2^32).  Thus, (k*x)*y == k*(x*y) == k (mod 2^32).hC
and multiplying by y is the same as dividing by x.

And may number at all can be broken down into an odd number and
a power of two, where division is a simple shift.
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
