Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVASRXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVASRXi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVASRVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:21:38 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:17618 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261784AbVASRUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:20:36 -0500
Message-ID: <41EE96E7.3000004@comcast.net>
Date: Wed, 19 Jan 2005 12:20:39 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu>
In-Reply-To: <20050119103020.GA4417@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Ingo Molnar wrote:
> * John Richard Moser <nigelenki@comcast.net> wrote:
> 
> 
>>>There was a kernel-based randomization patch floating around at some 
>>>point, though. I think it's part of PaX. That's the one I hated. 
>>
>>PaX and Exec Shield both have them; personally I believe PaX is a more
>>mature technology, since it's 1) still actively developed, and 2) been
>>around since late 2000.  The rest of the community dissagrees with me
>>of course, [...]
> 
> 
> might this disagreement be based on the fact that exec-shield _is_ being
> actively developed and is in active use in Fedora/RHEL, and that split
> out portions of exec-shield (e.g. flexmmap, PT_GNU_STACK, NX) are
> already in the upstream kernel?
> 

ES has been actively developed since it was poorly implemented in 2003.
 PaX has been actively developed since it was poorly implemented in
2000.  PaX has had about 4 times longer to go from a poor
proof-of-concept NX emulation patch based on the plex86 announcement to
a full featured security system, and is written by a competant security
developer rather than a competant scheduler developer.

Split-out portions of PaX (and of ES) don't make sense.  ASLR can be
evaded pretty easily:  inject code, read %efp, find the GOT, read
addresses.  The NX protections can be evaded by using ret2libc.  on x86,
you need emulation to make an NX bit or the NX protections are useless.
 So every part prevents every other part from being pushed gently aside.

PT_GNU_STACK annoys me :P  I'm more interested in 1) PaX' full set of
markings (-ps for NX, -m for mprotect(), r for randmmap, x for
randexec), 2) getting rid of the need for anything but -m, and 3)
eliminating relocations.  Sometimes they don't patch GLIBC here and
Firefox won't load flash or Java because they're PT_GNU_STACK and don't
really need it (the java executables are marked, but the java plug-in
doesn't need PT_GNU_STACK).

I guess it works on Exec Shield, but it frightens me that I have to
audit every library an executable uses for a PT_GNU_STACK marking to see
if it has an executable stack.

> (but no doubt PaX is fine and protects against exploits at least as
> effectively as (and in some cases more effectively than) exec-shield, so
> you've definitely not made a bad choice.)
> 

Either or if it stops an exploit; there's no "stopping an exploit
better," just stopping more of them and having fewer loopholes.  As I
understand, ES' NX approximation fails if you relieve protections on a
higher mapping-- which confuses me, isn't vsyscall() a high-address
executable mapping, which would disable NX protection for the full
address space?

PaX disables vsyscall when using PAGEEXEC on x86 because (since 2.6.6 or
so) pipacs uses the same method as ExecShield as a best-effort, falling
back to kernel-assisted MMU walking if that fails.  Wasted effort with
vsyscall.

PaX though gives me powerful, flexible administrative control over
executable space protections as a privileged resource.
mprotect(PROT_EXEC|PROT_WRITE) isn't something normal programs need; so
it's not something I allow everyone to do.

Aside from that, I just trust the PaX developer more.  He's already got
a more developed product; he's a security developer instead of a
scheduler developer; and he reads CPU manuals for breakfast.  I think a
lot of PaX is developed without real hardware-- I know he at least
doesn't have an AMD64 (which is what I use PaX on-- and yes I use the
regression tests), and he does a fine job anyway.  This indicates to me
that this is a serious project with someone who knows what he's doing,
so I trust it more.

> 	Ingo
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7pbmhDd4aOud5P8RAuV2AJ44dE9gvqZ9xwfENaWA6Hm81ALcfQCaA7mk
QFZejeyBBLd1sdtSj3o4Avk=
=hNuJ
-----END PGP SIGNATURE-----
