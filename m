Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVA2GDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVA2GDi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 01:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbVA2GDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 01:03:37 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:19124 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262857AbVA2GDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 01:03:25 -0500
Message-ID: <41FB2750.3050307@comcast.net>
Date: Sat, 29 Jan 2005 01:04:00 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Paulo Marques <pmarques@grupopie.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org> <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org> <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org> <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com> <1106856178.5624.128.camel@laptopd505.fenrus.org> <41F94B5A.2030301@comcast.net> <41FA74CA.2030303@grupopie.com> <20050128184234.GA24226@elte.hu>
In-Reply-To: <20050128184234.GA24226@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Ingo Molnar wrote:
> * Paulo Marques <pmarques@grupopie.com> wrote:
> 
> 
>>I really shouldn't feed the trolls, but this must be the most silly
>>piece of code I saw on this mailing list in a very long time (and
>>there have been some good examples over time).
> 
> 
> yeah.
> 
> 
>>The stack randomization doesn't prevent some sort of attacks (like
>>return into libc, etc.) and given a small randomization it might be
>>possible to write an exploit with a long sequence of NOP's and a
>>return address somewhere in there (the attacker wouldn't know exactly
>>where, but it wouldn't matter anyway). If we are able to write 'N'
>>NOP's then we get a 'N'/64k chance that the exploit works.
> 
> 
> yeah. NOP techniques can always be used to 'chop off bits' from any
> randomization, in case the address of the payload is not known. Both
> instruction NOPs for shellcode and 'parameter NOPs' ("././././" strings
> or "/bin/sh\0/bin/sh\0" strings) can be used.
> 
> but there is no fundamental theoretical difference between a 256 MB
> randomization (as PaX uses) and a 2 MB randomization (Fedora) in terms
> of characteristics: what is brute-force in one is brute-force in the
> other as well, with a factor of overhead difference of 128. (which makes
> the attack 128 times longer, but has no real difference to security.)
> 

You said:

  yeah. NOP techniques can always be used to 'chop off bits' from any
  randomization, in case the address of the payload is not known. Both
  instruction NOPs for shellcode and 'parameter NOPs' ("././././"
  strings or "/bin/sh\0/bin/sh\0" strings) can be used.

Bear with me here, I'm out of things I've studied and researched, so now
we're going to go into "junk coming out of my head."  It's either going
to be very painful, or very funny, or both at the same time.  No, I
don't care that I'm about to look like an ass.

You're starting with 64K of randomization, and moving to 2M later.  The
stack is how big?  4-8M?  I don't know, I'm guessing; I saw earlier some
code that said that the stack was defined as having at least 8M in some
header, which "should be enough for most people" so I assume it's almost
if not over 2M.

Cut off however much data you know is going to be pushed already (which
is what we've been calling 'the size of the stack'), compare that with
the randomization, if it's bigger than the randomization period, you
have chopped off all randomization.  If not, you've probably got better
than a 50-50.

Because the size of a 'bit' grows as your entropy grows, chopping 2 megs
off the randomization at 256M is significantly less than 1 bit (128M is
1 bit), while it's about 9 bits when considering 2 megs of randomization.

Short version:  I've got a better chance of finding an exploit that lets
me just knock-off a couple megs of randomization than I do of brute
forcing it.  I've got a WAY better chance of brute-forcing in one or two
tries if I can knock most of the randomization off.

> so the attempt of our beloved troll to paint 2 MB of randomization as
> 'weak' and 256 MB randomization as 'strong' is i believe misguided: both
> are 'weak' in most of the threat models! (and even for threat types
> where they might be considered 'strong' (e.g. whether a hole is suitable
> to feed a destructive worm), they'll both be considered 'strong'.)
> 

Let's look at GrSecurity's brute force deterrance real quick.  I know
you don't want to hear it, but maybe you should.

The basic idea, and it's an ugly one but you have to forgive people for
trying to do stupid shit like LET BROKEN CODE RUN SAFELY, is to detect a
segfault (jump into unmapped ram, probably miss due to ASLR) or PaX kill
(should also detect a SIGILL) and then flag the highest parent (who is
found via magic I won't get into here).

When flagged with this particular flag, all fork() calls are queued so
that one fork() occurs every 30 seconds.  This is annoying and ugly as
shit, but we're trying to do the unspeakable:  Make broken,
security-hole ridden code safe to run in a hostile environment.

Suddenly the 216 second cycle to brute force PaX' ASLR becomes something
like 3 weeks!  :)


This randomization, after accounting for knocking off all the bits we
can, may take two or three, maybe ten or twenty tries.  This is what,
300-600 oh hell TEN MINUTES.  Yes, you did better than 216 seconds.

When brad first tried to bash the concept of his brute force deterrance
through my head, I kept poking at the 30 second interval and the idea of
making about 200 connections BEFORE slamming the server.  The server
will wait about a minute or two before timing you out, so this is fine,
as it takes 3-4 seconds.  He eventually got it through my skull that you
can do the first 200 hits; but then every fork() afterwards is QUEUED,
not executed in batch every 30 seconds.

This makes a difference.  It means you get a little boost with huge
randomization, but not that much.  In your model, however, that "little
boost" is bigger than the period needed to take it down anyway, so you
can't even deploy competant and working brute force deterrance as is.


Let me give you a hint.  A good one for you this time, not "PaX is
better and this is why you suck."

http://lkml.org/lkml/2005/1/28/194

This thread has given some good insight here.  Particularly, Andy
pointed this out:

  The 4G/4G patches (google for the lwn.net overview) change this,
  introducing a TLB flush on every syscall.  Better for some things
  because you get more VA space, worse for most things because it's
  slower.  (But it's "lots better for a few" versus "a little worse for
  everybody", so the tradeoff is often worthwhile.)

http://lkml.org/lkml/2005/1/28/272

"Lots better for a few" "a little worse for everybody," sound familiar?
 Bigger randomization and most of the address-space reducing/fragmenting
changes we've had discussions/flames about in this thread have fit this
description in reverse.  "Lots worse for some" "a little better for
[almost] everybody."  But this lends a more important insight here.

Why not compromise, if possible?  256M of randomization, but move the
split up to 3.5/0.5 gig, if possible.  I seem to recall seeing an option
(though I think it was UML) to do 3.5/0.5 before; and I'm used to "a
little worse" meaning "microbenches say it's worse, but you won't notice
it," so perhaps this would be a good compromise.  How well tuned can
3G/1G be?  Come on, 1G is just a big friggin' even number.

And yes, I saw the AGP/PCI stuff in that thread, which is where the "if
possible" comments came from.

> (obligatory note: the randomization we can get on 64-bit VMs is
> different and probably completely adequate against all currently
> existing remote threats, and maybe even against most of the practical
> local threats.)

Yes.  PaX does 64GiB on 64 bit VMs I *think*, and it's a 1TiB physical
and 256TiB virtual address space, so 64GiB is about 2 bytes in
comparison?  :)  (again with the bits-get-bigger-as-you-add-more philosophy)

> 
> 	Ingo
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

iD8DBQFB+ydPhDd4aOud5P8RAkJGAJ49F/CiVaQ9nzYOJi1Yj4atEc9ZygCff4S5
ve3BdMmD5JfkKLq/pJ87xkA=
=iV8r
-----END PGP SIGNATURE-----
