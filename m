Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVAMShE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVAMShE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVAMSfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:35:22 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:37286 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261394AbVAMSaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:30:52 -0500
Message-ID: <41E6BE6B.6050400@comcast.net>
Date: Thu, 13 Jan 2005 13:31:07 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>  <20050112185133.GA10687@kroah.com>  <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>  <20050112161227.GF32024@logos.cnet>  <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>  <20050112205350.GM24518@redhat.com>  <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>  <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>  <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>  <20050113082320.GB18685@infradead.org>  <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Linus Torvalds wrote:
> 
> On Thu, 13 Jan 2005, Arjan van de Ven wrote:
> 
>>I think you are somewhat misguided on these: the randomisation done in
>>FC does NOT prohibit prelink for working, with the exception of special
>>PIE binaries. Does this destroy the randomisation? No: prelink *itself*
>>randomizes the addresses when creating it's prelink database
> 
> 
> There was a kernel-based randomization patch floating around at some 
> point, though. I think it's part of PaX. That's the one I hated. 
> 

PaX and Exec Shield both have them; personally I believe PaX is a more
mature technology, since it's 1) still actively developed, and 2) been
around since late 2000.  The rest of the community dissagrees with me of
course, but whatever; let's not get into PMS matches on whose junk is
better than whose.


> Although I haven't seen it in a long time, so you may well be right that 
> that one too is fine. 
> 
> My point was really more about the generic issue of me being two-faced: 
> I'll encourage people to do things that I don't actually like myself in 
> the standard kernel. 
> 
> I just think that forking at some levels is _good_. I like the fact that 
> different vendors have different objectives, and that there are things 
> like Immunix and PaX etc around.

I use the argument that the 2.6 development model being used as 'stable'
hurts this all the time, and people (not you Linus) have fed back to me
that "they should submit their patches to mainline then."

> Of course, the problem that sometimes 
> results in is the very fact that because I encourage others to have 
> special patches, they en dup not even trying to feed back _parts_ of them.
> 
> In this case I really believe that was the case. There are fixes in PaX
> that make sense for the standard kernel.

Yes, there's fixes that should go in to mainline often, aside from the
added functionality.  I think these should be split out and distributed
*shrug*

> But because not _all_ of PaX
> makes sense for the standard kernel,

Personally I believe it does, for social engineering reasons (encourage
software developers to be mindful of the more secure setting).  That
being said, every part of PaX is an option, so even if it went mainline,
it'd be disabled where inappropriate anyway.

> and because I will _not_ take their
> patch whole-sale, they apparently believe (incorrectly) that I wouldn't
> even take the non-intrusive fixes, and haven't really even tried to feed
> them back.
> 
> (Yes, Brad Spengler has talked to me about PaX, but never sent me 
> individual patches, for example. People seem to expect me to take all or 
> nothing - and there's a _lot_ of pretty extreme people out there that 
> expect everybody else to be as extreme as they are..)
> 

Things like PaX actually have to be taken all or nothing for a reason.
This doesn't mean they have to come with all the GrSecurity
enhancements; although those help as well.

PaX supplies two major components:  enhanced memory protections,
particularly using the PROT_EXEC marking (hardawer or otherwise); and
address space layout randomization.

For now I'll set aside the emulations on x86, but I'll cover that later.

First, let's look at ASLR.  ASLR can be defeated if you can inject code
to read (if I understand correctly) %efp and locate the global offset
table.  Thus, ASLR is pretty much useless.

If we look at executable space protections, the PROTECTIONS&(~PROT_EXEC)
can be changed by returning to mprotect();  since PaX restricts
mprotect(), you have to return to open() and write() and mmap(), but
same deal.  Either way, the memory space protections can be defeated by
ret2libc, so these are also pretty much useless.

Examining further, you should consider deploying ASLR in conjunction
with proper memory space protections.  In this situation, ASLR must be
defeated before the memory protections can be defeated; and the memory
protections must be defeated before you can defeat ASLR.  *->ASLR->NX->*
continuous circle.

This makes defeating the ASLR/NX combination a paradox; you can't have
both at the same time, you can't have one without the other.  The only
logical possibility is to do neither.  (it's actually possible to defeat
it, but only by completely random guessing and one hell of a stroke of luck)

Going back to the emulation, there's no NX protections without an NX
bit; so for any of this to have any point at all on x86--the most
popular desktop platform ATM--you need to emulate an NX bit.

I can see where you wouldn't want to put in a superpatch like PaX, and
I'm not saying you should jump up right now and go merge it with
mainline; but I feel it's important that you understand that each part
of PaX compliments the others to form a network of protections that
reciprocate upon eachother.  Each piece would fail without the others to
control their shortfallings; but together they've got everything pretty
well covered.

> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5r5qhDd4aOud5P8RAmemAJ0T3Eu32QxKp7npUeMLR+pMBbriQACfb3Uv
h7d+IiGyuaOTJkkoAfPJHX0=
=0eSC
-----END PGP SIGNATURE-----
