Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVAaR2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVAaR2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVAaR2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:28:41 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:14526 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261271AbVAaR1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:27:37 -0500
Message-ID: <41FE6ABE.8060909@comcast.net>
Date: Mon, 31 Jan 2005 12:28:30 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux@horizon.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050131105538.9149.qmail@science.horizon.com>
In-Reply-To: <20050131105538.9149.qmail@science.horizon.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



linux@horizon.com wrote:
>>Why not compromise, if possible?  256M of randomization, but move the
>>split up to 3.5/0.5 gig, if possible.  I seem to recall seeing an option
>>(though I think it was UML) to do 3.5/0.5 before; and I'm used to "a
>>little worse" meaning "microbenches say it's worse, but you won't notice
>>it," so perhaps this would be a good compromise.  How well tuned can
>>3G/1G be?  Come on, 1G is just a big friggin' even number.
> 
> 
> Ah, grasshopper, so much you have to learn...

I'm always learning, that's why I'm not stupid.  I hate dumb people who
just sit around and go "what?"  "OK it works like--"  "shut up I don't
care!  . . . . wut now?"

> In particular, prople these days are more likely to want to move the
> split DOWN rather than UP.
> 
> First point: it is important that the split happens at an "even" boundary
> for the highest-level page table.  This makes it as simple as possible to
> copy the shared global pages into each process' page tables.
> 
> On typical x86, each table is 1024 entries long, so the top table maps
> 4G/1024 = 4M sections.
> 
> However, with PAE (Physical Address Extensions), a 32-bit page table
> entry is no longer enough to hold the 36-bit physical address.  Instead,
> the entries are 64 bits long, so only 512 fit into a page.  With a
> 4K page and 18 more bits from page tables, two levels will map only
> 30 bits of the 32-bit virtual address space.  So Intel added a small,
> 4-entry third-level page table.
> 

Interesting.

> With PAE, you are indeed limited to 1G boundaries.  (Unless you want to
> seriously overhaul mm setup and teardown.)
> 

Yiiiiii x.x

> 
> Secondly, remember that, unless you want to pay a performance penalty
> for enabling one of the highmem options, you have to fit ALL of physical
> memory, PLUS memory-mapped IO (say around 128M) into the kernel's portion
> of the address space.  512M of kernel space isn't enough unless you have
> less than 512M (like 384M) of memory to keep track of.
> 
> That is getting less common, *especially* on servers.  (Which are
> presumably an important target audience for buffer overflow defenses.)
> 

Semantics, you can skip this but here's my understanding about the
situation:

ASLR is a code injection/ret2libc exploit defense, not a buffer overflow
bug defense.  True buffer overflow defense occurs in userspace.

ASLR and proper NX protections provide a more wide-ranged defense which
stops format string and heap/stack buffer overflow based attacks (and
possibly others) from using ret2libc or code injection exploits.

Stack based buffer overflow protection is available in userspace and
actually prevents some things not protected by kernel-level protections.
 ProPolice for example protects local pointers and local variables;
sometimes changing the contents of a variable (say a filename, or an
integer containing an encoded IP address) can give you a quick and dirty
information leak.

All defenses are important everywhere, not just on servers; although
they're probably less important on internal servers behind your
firewall/IDS/security net/DMZ because you need an insider to access
those, which often means someone skilled enough or with enough info
(passwords, etc) to bypass your security anyway (not that you shouldn't
make the best effort possible to stop them).

Some people don't agree with me (in fact I'm probably alone in this line
of thinking), but I'm of the persuasion that the best protection is most
important on the desktop; and second but roughly equal on exposed
servers (web/ftp servers).

This is because attackers can use desktops as drones, and they're very
exposed due to web browsers, ftp clients, IM clients, and P2P apps, not
to mention tons of other stuff that comes in contact with foreign data.
 Web servers have a few choice daemons, so there's a much smaller
codebase touching things that come from outside, meaning less of a
chance of an open bug touching the outside world.

Anyway, that's my rant :)

> 
> Indeed, if you have a lot of RAM and you don't have a big database that
> needs tons of virtual address space, it's usually worth moving the
> split DOWN.
> 

Or you have a big database that wants tons of virtual address space and
so you buy an amd64.  ;)

> 
> Now, what about the case where you have gobs of RAM and need a highmem
> option anyway?  Well, there's a limit to what you can use high mem for.
> Application memory and page cache, yes.  Kernel data structures, no.
> You can't use it for dcache or inodes or network sockets or page
> tables or the struct page array.
> 

o.o

> And the mem_map array of struct pages (on x86, it's 32 bytes per page,
> or 1/128 of physical memory; 32M for a 4G machine) is a fixed overhead
> that's subtracted before you even start.  Fully-populated 64G x86
> machines need 512M of mem_map, and the remaining space isn't enough to
> really run well in.
> 
> If you crunch kernel lowmem too tightly, that becomes the
> performance-limiting resource.
> 

ok so short version:  You don't need the VA on a low-end system, you
can't have the VA on a high-end system.  Solution:  Buy a 64 bit system.

> 
> Anyway, the split between user and kernel address space is mandated
> by:
> - Kernel space wants to be as bit as physical RAM if possible, or not
>   more than 10x smaller if not.
> - User space really depends on the application, but larger than 2-3x
>   physical memory is pointless, as trying to actually use it all will
>   swap you to death.
> 
> So for 1G of physical RAM, 3G:1G is pretty close to perfect.  It was
> NOT pulled out of a hat.  Depending on your applications, you may be
> able to get away with a smaller user virtual address space, which could
> allow you to work with more RAM without needing to slow the kernel with
> highmem code.
> 
> 
> 
> You'll find another discussion of the issues at
> http://kerneltrap.org/node/2450
> http://lwn.net/Articles/75174/
> 
> Finally, could I suggest a little more humility when addressing the
> assembled linux-kernel developers?  I've seen Linus have to eat his
> words a time or two, and I know I can't do as well.
> http://marc.theaimsgroup.com/?m=91723854823435
> 

I've been somewhat unfriendly, and should have approached things a
little more calmly; but I still hold firm on my assertions.  My attitude
may have been wrong, but I'm pretty sure everything I said was right.
(I know I got something wrong, but I'm not sure if it was on here, and
I'm pretty sure I fired off the erratta after finding my mistake.)

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB/mq9hDd4aOud5P8RAjtvAJ0V5ofEhFwBLMHDZDynNWXuWe8M+wCfdDIy
hhAvW7ijrWhqXmW8FkMx2II=
=SvU6
-----END PGP SIGNATURE-----
