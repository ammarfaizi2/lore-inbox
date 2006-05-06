Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWEFQFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWEFQFl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 12:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWEFQFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 12:05:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53135 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750910AbWEFQFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 12:05:40 -0400
Message-ID: <445CC949.7050900@redhat.com>
Date: Sat, 06 May 2006 09:05:29 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>,
       Val Henson <val.henson@intel.com>
Subject: Re: [patch 00/14] remap_file_pages protection support
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <200605030225.54598.blaisorblade@yahoo.it>
In-Reply-To: <200605030225.54598.blaisorblade@yahoo.it>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5ED527D14F8F39AC51F8CC70"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5ED527D14F8F39AC51F8CC70
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Blaisorblade wrote:
> I've not seen the numbers indeed, I've been told of a problem with a "c=
ustomer=20
> program" and Ingo connected my work with this problem. Frankly, I've be=
en=20
> always astonished about how looking up a 10-level tree can be slow. Poo=
r=20
> cache locality is the only thing that I could think about.

It might be good if I explain a bit how much we use mmap in libc.  The
numbers can really add up quickly.

- for each loaded DSO we might have up to 5 VMAs today:

   1. text segment, protection r-xp, normally never written to
   2. a gap, protection ---p (i.e., no access)
   3. a relro data segment, protectection r--p
   4. a data segment, protection rw-p
   5. a bss segment, anonymous memory

The first four are mapped from the file.  In fact, the first segment
"allocates" the entire address space of all segment, even if it's longer
than the file.

Then gap is done using mprotect(PROT_NONE).  Then the area for segment 3
and 4 is mapped in one mmap() call.  It's in the same file but the
offset used in the mmap is not the same as the same as the offset which
naturally is already established through the first  mmap.  I.e., if the
first mmap() would start at offset 0 and  continue for 1000 pages, the
gap might start at a, say, offset of 4 pages and continue for 500 pages.
 Then the "natural" offset of the first data page would be 504 pages but
the second mmap() call would in fact use the offset 4 because the text
and data segment are continuous in the _file_ (although not in memory).

Anyway, once relocations are done the protection of the relro segment is
changed, splitting the data segment in two.


So, for DSO loading there would be two steps of improvement:

1. if a mprotect() call wouldn't split the VMA we would have 3 VMAs in
the end instead of 5.  40% gain.

2. if I could use remap_file_pages() for the data segment mapping and
the call would allow changing the protection and it would not split the
VMAs, then we'd be down to 2 mappings.  60% down.



A second big VMA user are thread stacks.  I think the application which
was mentioned in this thread briefly used literally thousands of
threads.  Leaving aside the insanity of this (it's unfortunately how
many programmers work) this can create problems because we get at least
two (on IA-64 three) VMAs per thread.  I.e., thread stack allocation
works likes this:

1. allocate area big enough for stack and guard (we don't use automatic
growing, this cannot work)

2. change the protection of the guard end of the stack to PROT_NONE.

So, for say 1000 threads we'll end up with 2000 VMAs.  Threads are also
important to mention here because

- often they are short-lived and we have to recreate them often.  We
usually reuse stacks but only keep that much allocated memory around.
So more often than we like we actually free and later re-allocate stacks.=


- these thousands of stack VMAs are really used concurrently.  ALl
threads are woken over a period of time.


A third source of VMAs is anonymous memory allocation.  mmap is used in
the malloc implementation and directly in various places.  For
randomization reasons there isn't really much we can do here, we
shouldn't lump all these allocations together.


A fourth source of VMAs are the programs themselves which mmap files.
Often read-only mappings of many small files.


Put all this together and non-trivial apps as written today (I don't say
they are high-quality apps) can easily have a few thousand, maybe even
10,000 to 20,000 VMAs.  Firefox on my machine uses in the moment ~560
VMAs and this is with only a handful of threads.  Are these the numbers
the VM system is optimized for?  I think what our people running the
experiments at the customer site saw is that it's not.  The VMA
traversal showed up on the profile lists.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig5ED527D14F8F39AC51F8CC70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEXMlJ2ijCOnn/RHQRAjPCAJ9P0oot6XkHdZ1BuMPJiezwfKgrYgCgsbPb
BKqwL04nUxE9nhGTtLD0J1c=
=hNA4
-----END PGP SIGNATURE-----

--------------enig5ED527D14F8F39AC51F8CC70--
