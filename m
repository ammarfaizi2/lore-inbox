Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269187AbUIYCq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269187AbUIYCq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 22:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269192AbUIYCq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 22:46:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:38878 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269187AbUIYCqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 22:46:37 -0400
Date: Fri, 24 Sep 2004 19:46:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 8/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation,
 cleanups and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409242059420.5443@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0409241930510.2317@ppc970.osdl.org>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241714190.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0409240926580.32117@ppc970.osdl.org>
 <Pine.LNX.4.60.0409242059420.5443@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Sep 2004, Anton Altaparmakov wrote:

> On Fri, 24 Sep 2004, Linus Torvalds wrote:
> > 
> > Btw, Al is fixing this. We'll make enum's properly typed, rather than just 
> > plain integers. It's not traditional C behaviour, but it gives you better 
> > type safety, and Al points out that other C compilers (the Plan 9 one, to 
> > be specific) have done the same thing for similar reasons.

Well, when I said "Al is fixing this", I lied.

I just fixed it myself. 

> This is good news.  Once that is done I will be very happy to go back to 
> using enums as I also agree that they can and in this case do look a 
> lot nicer...

Try the current sparse, I think it should work for you.

So if you make an enum where the initializer expression is a little-endian 
expression, the type of that (single) enumerator will be little-endian.

HOWEVER, the type of an enum _variable_ will still be just "int". So

	enum myenum {
		one = 1ULL,
		two = 2,
	};

has the strange behaviour that if you use "one" in an expression, it will
have the type "unsigned long long", but if you use a "enum myenum" entry
(even if it has the value "1"), it will be an "int":

	sizeof(one) == 8
	sizeof(enum myenum) == 4

So I would stronly suggest (and I may make sparse warn) against using
non-integertyped enum values with any enum that actually has any backing
store (ie if you ever use a variable of type "enum myenum", that would
result in a warning - you can really just use the values "one" and "two"
directly).

Note that gcc has some similarly strange behaviour wrt enum types that
depends on the _values_ of the enum entries themselves, and that can
result in serious problems if you declare the enum in a different place
from where you defined the values. Again, those problems only happen for
enums that actually get used with backing store (as opposed to just
readable compile-time constants).

		Linus
