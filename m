Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUIVOmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUIVOmL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 10:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUIVOmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 10:42:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:28033 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265909AbUIVOmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 10:42:04 -0400
Date: Wed, 22 Sep 2004 07:41:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rainer Weikusat <rainer.weikusat@sncag.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rainer Weikusat <rweikusat@sncag.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Implementation defined behaviour in read_write.c
In-Reply-To: <87k6umetg1.fsf@farside.sncag.com>
Message-ID: <Pine.LNX.4.58.0409220731080.25656@ppc970.osdl.org>
References: <878yb5ey11.fsf@farside.sncag.com> <1095764243.30748.55.camel@localhost.localdomain>
 <87k6umetg1.fsf@farside.sncag.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Sep 2004, Rainer Weikusat wrote:
> 
> 	6.3.1.3 Signed and unsigned integers
> 
> 	When a value with integer type is converted to another integer
> 	type other than _Bool, if the value can be represented by the
> 	new type, it is unchanged.
> 
> 	[...]
> 
> 	Otherwise, the new type is signed and the value cannot be
> 	represented in it; either the result is implementation-defined
> 	or an implementation-defined signal is raised.
> 
> The requirement for implementation defined is that the implementation
> documents the behaviour (which gcc at least up to 3.4.4 doesn't).

They don't, because they do the only thing they _can_ do. Bit-for-bit copy 
of a 2's complement value. Anything else would be basically impossible for 
an optimizing compiler to do unless it actively _tried_ to screw the user 
over. In other words, you're likely to see something else only on a C 
simulator interface that does strict conformance testing (as opposed to 
test for working).

And you are correct to point out the difference between implementation- 
defined and un-defined. Implementation-defined means that it has some 
well-defined semantics, and quite frankly, Linux _does_ depend on 2's 
complement. I don't expect to ever see anything else (where "ever" is a 
long time, although obviously not really "forever"), but if we do, we'll 
have to consider that architecture something very special indeed.

> This
> not a problem with the current compiler, but I happen to know by
> coincedence that some people of unknown relations to the gcc team
> (like the person who wrote this advisory:
> <URL:http://cert.uni-stuttgart.de/advisories/c-integer-overflow.php>)
> would like to turn it into a problem, because they strongly believe it
> is "the right thing to do"

There are tons of people who have theoretical concerns that they try to
push on the real world. Too many of them have talked to the gcc people,
but I think the gcc people are basically sane. So I wouldn't worry _too_ 
much.

That said, there are other cases where signed integer arithmetic should be 
avoided. The signed<->unsigned conversions are safe due to their 
implementation-defined behaviour (and only one sane way to do them), but 
there _are_ cases like signed integer overflow that really is undefined, 
and where a compiler can actually generate code that differs because it 
"knows" that signed integers cannot overflow.

However, in this case that is not what is happening in read_write.c. All 
the arithmetic is done in proper unsigned types, and only the last check 
is done with a (well-defined) signed conversion.

Btw, to see other places where we do depend on this 2's complement 
behaviour, just look at "time_before()" and friends.

		Linus
