Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbRHFKSR>; Mon, 6 Aug 2001 06:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267850AbRHFKSI>; Mon, 6 Aug 2001 06:18:08 -0400
Received: from sunny-legacy.pacific.net.au ([210.23.129.40]:11764 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S267844AbRHFKR7>; Mon, 6 Aug 2001 06:17:59 -0400
Subject: Re: [LONGish] Brief analysis of VMAs (was: /proc/<n>/maps getting
	_VERY_ long
From: David Luyer <david_luyer@pacific.net.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 06 Aug 2001 20:18:06 +1000
Message-Id: <997093086.7179.21.camel@typhaon>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Aug 2001 21:43:27 +1200, Chris Wedgwood wrote:
> It appears mozilla, that super lean, super fast and very stable
> web-browser mostly grows using brk with fairly small increments (under
> 64K) as it reads data in form various places --- and from several
> threads at a time.... and lots of small allocates appears to be a
> "Very Bad Thing".  A couple of people sent me examples of other
> applications that cause problems too, for example David Luyer sent me
> the map for evolution-mail which is some new "fangled pointy-clicky
> Gnome super-widget-enhanced" mail application --- perhaps that also
> grows memory slowly (I don't have an strace of it, so this is just
> speculation).

Well I've straced it a bit (in fact it's stracing as I wrote
this e-mail -- this is evolution-mail which is the mail component
of the evolution suite) and the story is:

 * lots of brk()s but they simply grow the one vma, no problem
 * lots of 4kb old_mmap/munmap repeated over and over, just keeps
   reallocating the same block, no problem
 * and then this...

7179  old_mmap(NULL, 2097152, PROT_NONE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0 <unfinished ...>
7159  --- SIGRT_0 (Real-time signal 0) ---
7179  <... old_mmap resumed> )          = 0x40ef1000
7179  munmap(0x40ef1000, 61440)         = 0
7179  munmap(0x41000000, 987136)        = 0

Translation:

"give me 2Mb"
"now lets get rid of this non-virtual-page-aligned crap"
"now lets split up this 1Mb"

I have no idea how sensible or illogical that is, though.

7179  mprotect(0x40f00000, 32768, PROT_READ|PROT_WRITE) = 0
7179  mprotect(0x40f08000, 4096, PROT_READ|PROT_WRITE) = 0
7179  mprotect(0x40f09000, 4096, PROT_READ|PROT_WRITE) = 0
7179  mprotect(0x40f0a000, 4096, PROT_READ|PROT_WRITE) = 0
7245  mprotect(0x40f0b000, 8192, PROT_READ|PROT_WRITE) = 0
7245  mprotect(0x40f0d000, 4096, PROT_READ|PROT_WRITE) = 0
7245  mprotect(0x40f0e000, 4096, PROT_READ|PROT_WRITE) = 0
7245  mprotect(0x40f0f000, 4096, PROT_READ|PROT_WRITE) = 0
7245  mprotect(0x40f10000, 4096, PROT_READ|PROT_WRITE) = 0
7245  mprotect(0x40f11000, 4096, PROT_READ|PROT_WRITE) = 0
7245  mprotect(0x40f12000, 4096, PROT_READ|PROT_WRITE) = 0
7245  mprotect(0x40f13000, 4096, PROT_READ|PROT_WRITE) = 0
7245  mprotect(0x40f14000, 4096, PROT_READ|PROT_WRITE) = 0
7245  mprotect(0x40f15000, 8192, PROT_READ|PROT_WRITE) = 0

Here are some "why aren't these merged?" mappings:

40f00000-40f08000 rw-p 0000f000 00:00 0
40f08000-40f09000 rw-p 00017000 00:00 0
40f09000-40f0a000 rw-p 00018000 00:00 0
40f0a000-40f0b000 rw-p 00019000 00:00 0
40f0b000-40f0d000 rw-p 0001a000 00:00 0
40f0d000-40f0e000 rw-p 0001c000 00:00 0
40f0e000-40f0f000 rw-p 0001d000 00:00 0
40f0f000-40f10000 rw-p 0001e000 00:00 0
40f10000-40f11000 rw-p 0001f000 00:00 0
40f11000-40f12000 rw-p 00020000 00:00 0
40f12000-40f13000 rw-p 00021000 00:00 0
40f13000-40f14000 rw-p 00022000 00:00 0
40f14000-40f15000 rw-p 00023000 00:00 0
40f15000-40f17000 rw-p 00024000 00:00 0
40f17000-41000000 ---p 00026000 00:00 0

So the problem is that it's saying "make me a big chunk of memory"
and then gradually "releasing" the memory into use, and releasing
the memory into use is fragmenting up the vmas.

> BUT, glibc doesn't always have consistent use, as I mentioned about,
> it will often do
>
>        mmap( .... PROT_FOO ... )
>        munmap ( some of the above )           [optional]
>        for( ... )
>                mprotect ( PROT_BAR ... )
>
>        which means the simple logic above cannot coalesce things.

Yes, that's what's happening above.  And it's what's causing the
splits in the vmas.  So basically evolution-mail is doing exactly what
your test program was doing, and causing exactly the same thing.

Seems strange that glibc would do this unless there was some performance
reason on past kernels to do it?

> VMware (capatalisation?) also causes large numbers of vmas, but my
> attempts to get Xfree86, gimp or gcc (when compiling C code) to do so
> were unsuccessful, all showed little if any ability to merge vmas.
> Compiling a large c++ application might show some gains here, but I
> don't have anything large enough to try.

I'd expect VMware and WINE will use large numbers of mappings and
trying to prevent it is likely to be futile.  But things like Mozilla
and Evolution should be fixable, well down to the 200-ish mappings
required by the number of libraries they use at least...

David.
-- 
David Luyer                                     Phone:   +61 3 9674 7525
Engineering Projects Manager   P A C I F I C    Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T   Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                      NASDAQ:  PCNTF
