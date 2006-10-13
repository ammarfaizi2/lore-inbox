Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWJMRYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWJMRYP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWJMRYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:24:15 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:43994 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751411AbWJMRYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:24:14 -0400
Message-ID: <452FCBBB.8070909@comcast.net>
Date: Fri, 13 Oct 2006 13:24:11 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: andrew.j.wade@gmail.com
CC: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net> <200610122254.10578.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <452F2433.2010307@comcast.net> <200610131258.15451.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200610131258.15451.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Andrew James Wade wrote:
> On Friday 13 October 2006 01:29, John Richard Moser wrote:
>> True.  You can trick the MMU into faulting into the kernel (PaX does
>> this to apply non-executable pages-- pages, not halves of VM-- on x86),
> 
> Oooh, that is a neat hack!
> 

Yes, very neat  ;)

The way it works is pretty much that he has NX pages marked SUPERVISOR
so the userspace code can't put them in the TLB.  What happens on access is:

 - MMU cries, faults into kernel
 - Kernel examines nature of fault
   - If attempting to read/write, put the mapping in the DTLB for the
     process
   - If attempting to execute, KILL.
 - Application continues running if it was a data access.

As I understand it, this is about 7000 times slower than having a
hardware NX bit and an MMU that handles the event; but once the page is
in the DTLB the MMU doesn't complain any more until it's pushed out, so
the hit is minimal.  Wide memory access patterns that can push data out
of the TLB quickly and come back to it just as fast get a pretty
noticeable performance hit; but they're rare.

These days he's got the OpenBSD W^X/RedHat Exec Shield method in there
as well, so when possible the stack is made non-executable using
hardware and is completely exempt from these performance considerations.

- From what I hear, Linus isn't interested in either PTE hacks or segment
limit hacks, so old x86 will never have an NX bit (full like PaX or best
effort like Exec Shield) in the kernel.  Too bad; I'd really like to see
some enforcement of non-executable pages on good old x86 chips in mainline.

>> but it's orders of magnitude slower as I understand and the petty gains
>> you can get over the hardware MMU doing it are not going to outweigh it.
> 
> It's architecture-dependent; not all architectures are even capeable of
> walking the page table trees in hardware. They compensate with
> lightweight traps for TLB cache misses. 

The ones that can do it probably have hardware tuned enough that a
software implementation isn't going to outrun them, least of all not far
enough to overtake the weight of the traps that can be set up.  It's a
lovely area of theoretical hacks though, if you like coming up with
impractical "what kinds of nasty things can we do to the hardware"
ideas.  :)

> 
> Andrew Wade
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRS/LuQs1xW0HCTEFAQJHvw//TvBqPD8YlOqjCkgKEPSnCICuGE3LW8Yq
BKo1sSwdMnBW9b9IH3jlO3nKSG49MJvJnyQeb5OEzq0B0qHVct8z8ax80+XDbwWg
9FNo85SnAQMuAq9FxgHof9itja4eqgNOXwI1kib1OT5FAw/cINGxsWoSOTS5Ko4R
uAc74bbtoYACCvktKr9kpp/LSrctDtJ0ObaGpKO+rdi6023zGRF6IrIaI8GTAXIg
yoE0hue+eukKvDLCI7L6ZyIMH95mlKPBbsirhx1sVeXIfbDMNulyC56o9Bcs/QVi
oplLe7SEi67vCUslonbley/MG9b8cA2tT8YSAxJDTwfBgxKghY6mn5nRXxG/6UuG
6Zxbmfn4bhxPRpbVO8G+10WtfbxOlPpnHGaC1NCw7W+h/rMcUf3I/wkHJwtbkJG3
hfs6rOgSx72319kqT3eC/L0JUlBIOt0Z9hmVLkJAW85JAx2bfVSVrYCzhVzK1NFn
5v9RD1lRCuZDq72S14VaCcHcIwPuTBLIPklsQWy4XmDLtRQoOO1VVPgakB2Zs7h5
hURD7r8qXbWQj4XNCNb8ZOa3f36yAzqJNdE6fppZPAwWcT3kMMkWuUoslGMjrJfw
4nH37n0PrTnXusP1HyBjTzcGE2wSKbzreclHYWsbds3S5QIxFhqW6Qh6eFnTaawv
AAAxHihjHSg=
=uOEk
-----END PGP SIGNATURE-----
