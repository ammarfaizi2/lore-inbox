Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937072AbWLFSdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937072AbWLFSdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937070AbWLFSdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:33:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55014 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937061AbWLFSdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:33:39 -0500
Date: Wed, 6 Dec 2006 10:33:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] Export current_is_keventd() for libphy 
In-Reply-To: <Pine.LNX.4.64.0612060955380.3542@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612061017220.3542@woody.osdl.org>
References: <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org> 
 <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
 <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
 <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
 <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
 <20061206075729.b2b6aa52.akpm@osdl.org>  <21690.1165426993@redhat.com>
 <Pine.LNX.4.64.0612060951150.3542@woody.osdl.org>
 <Pine.LNX.4.64.0612060955380.3542@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Linus Torvalds wrote:
> 
> Sadly, gcc doesn't do it in this case. Still, I'd rather keep the source 
> clean, and hope that the compiler improves eventually, than to make the 
> code uglier.

Actually, it's our own damn fault.

We've long had our arguments "const volatile" to test_bit(), which 
basically means that gcc can't do the optimization. Damn.

And they need to be "volatile" not because we _want_ the thing to be 
volaile, but because these things are occationally used on volatile 
objects (so if the function doesn't take a volatile pointer, it would 
warn).

That's why so many of these helper functions use "const volatile" 
pointers, which on the face of it would seem strange if you don't realize 
that it's more about a C type issue than about the _actual_ type being 
either "const" or "volatile".

Sad. I guess we could remove the "const volatile" from the _cast_, but the 
thing is, if the underlying object we're actually looking at really _is_ 
volatile, we shouldn't do that. GAAH.

Really sad. I doubt any of the callers actually want the "volatile" access 
at all. Things like <linux/page-flags.h> definitely _don't_ want it.

I suspect we should just face up to the fact that 

 (a) "volatile" on kernel data is basically always a bug, and you should 
     use locking. "volatile" doesn't help anything at all with memory 
     ordering and friends, so it's insane to think it "solves" anything on 
     its own.
 (b) on "iomem" pointers it does make sense, but those need special 
     accessor functions _anyway_, so things like test_bit() wouldn't work 
     on them.
 (c) if you spin on a value changing, you should use "cpu_relax()" or 
     "barrier()" anyway, which will force gcc to re-load any values from 
     memory over the loop.

and remove the "volatile" from all the bitop accessor functions.

Or at least from "test_bit()". It's not like it's synchronous _anyway_ 
(there's no memory barriers etc).

Hmm? Comments? linux-arch added to Cc, just in case people care (this 
particular thing is in <asm-*/bitops.h>, so it _is_ architecture- 
specific, but we should probably all agree on it first)

		Linus
