Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVC2IXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVC2IXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVC2IWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:22:14 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:5363 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262196AbVC2IPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:15:31 -0500
Message-ID: <42490E9C.3070900@comcast.net>
Date: Tue, 29 Mar 2005 03:15:24 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Brandon Hale <brandon@smarterits.com>, ubuntu-hardened@lists.ubuntu.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ubuntu-hardened] Re: Collecting NX information
References: <42484B13.4060408@comcast.net>	 <1112035059.6003.44.camel@laptopd505.fenrus.org>	 <4248520E.1070602@comcast.net>	 <1112036121.6003.46.camel@laptopd505.fenrus.org>	 <424857B0.4030302@comcast.net>	 <1112043246.10117.5.camel@localhost.localdomain>	 <4248828B.20708@comcast.net> <1112080581.6282.1.camel@laptopd505.fenrus.org>
In-Reply-To: <1112080581.6282.1.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
>>You need to consider that in the end I'd need PT_GNU_STACK to do
>>everything PaX wants
> 
> 
> why?
> Why not have independent flags for independent things?
> That way you have both cleanness of design and you don't break anything.
> 

Also, I should have pointed out that independent flags for each part of
this would require at the very least a 1 byte field per flag, totaling
6.  In practice, the fields are usually 1 processor word (4 or 8 bytes),
totalling 24 (or 48) bytes rather than 4 (or 8).

As these are all pretty much "control memory space related security
protections," convergence to a well-defined standard would be both clean
and non-stuff-breaking.  Now of course there's no standard, but several
things operating very similarly.  This gives us the opportunity to look
at how each reacts to each different proprietary marking, take the most
robust (which just happens to be PT_PAX_FLAGS, no flamewars please), and
define exactly what each setting controls.

I want something very well defined for PAGEEXEC (executable stack,
heap).  The MPROTECT setting should also be very well defined, which
will match with PaX because nobody else restricts mprotect().  EMUTRAMP
should be defined fairly loosely, but enough to say "stuff we can
predictably identify as exceptions to the rules are caught here."  All
of these alter the programming environment, so must be predictable to
the programmer; emutramp is a special case, which allows the programmer
to assume that he needs PAGEEXEC off while the administrator knows to
just EMUTRAMP in this case.

For the two randomizers, "sane for default" should define one and "not
sane for default" should define the other.  These have little to no
effect on most programs, VM space fragmentation aside.  We don't need to
define these too well, but enough to know what they're for.

SEGMEXEC is of course "nothing."  In truth, I want PaX to change to make
SEGMEXEC absolutely nothing unless PAGEEXEC is on, and only for x86.
This is because PAGEEXEC can be very clearly defined, and SEGMEXEC can
be defined as a specific modifier on PAGEEXEC.

Of course, the effect of any one of these being on is subject to
implementation; obviously if mprotect() restrictions aren't supported,
MPROTECT being on does nothing.  I doubt mainline and ES will take that
particular logic specifically, though either way I have no intention of
even trying to force them to.  EMUTRAMP, however, I hope would be able
to enhance mainline and ES both (that means Red Hat/Fedora) by allowing
some of the PT_GNU_STACK markings to come off.

In the future, an SeLinux hook should go into the pax_parse_elf_flags()
logic to allow SeLinux policy to control these settings for PaX,
mainline, and ES in one sweep:

+       /*Are these broke?  Then get out*/
+       if (0 > pax_check_flags(&pax_flags))
+               return -EINVAL;
+
(insert hook here)
+       /*Add to the memory manager flags*/
+       current->mm->flags |= pax_flags;


[...]

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCSQ6chDd4aOud5P8RAvr3AJ91i8c7W1CetmjWFGuItG6pCHEiigCbBfXb
H4RCVuOjFI71R45Q+TUw/AY=
=dLsN
-----END PGP SIGNATURE-----
