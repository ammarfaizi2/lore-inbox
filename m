Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132765AbRDXE5C>; Tue, 24 Apr 2001 00:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132772AbRDXE4y>; Tue, 24 Apr 2001 00:56:54 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:3099 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132765AbRDXE4p>; Tue, 24 Apr 2001 00:56:45 -0400
Date: Tue, 24 Apr 2001 06:56:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "D . W . Howells" <dhowells@astarte.free-online.co.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dhowells@redhat.com,
        davem@redhat.com
Subject: rwsem benchmark [was Re: [PATCH] rw_semaphores, optimisations try #3]
Message-ID: <20010424065633.A16845@athlon.random>
In-Reply-To: <01042321353400.00801@orion.ddi.co.uk> <20010423233435.N19938@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20010423233435.N19938@athlon.random>; from andrea@suse.de on Mon, Apr 23, 2001 at 11:34:35PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 23, 2001 at 11:34:35PM +0200, Andrea Arcangeli wrote:
> On Mon, Apr 23, 2001 at 09:35:34PM +0100, D . W . Howells wrote:
> > This patch (made against linux-2.4.4-pre6) makes a number of changes to the
> > rwsem implementation:
> > 
> >  (1) Everything in try #2
> > 
> > plus
> > 
> >  (2) Changes proposed by Linus for the generic semaphore code.
> > 
> >  (3) Ideas from Andrea and how he implemented his semaphores.
> 
> I benchmarked try3 on top of pre6 and I get this:
> 
> ----------------------------------------------
> RWSEM_GENERIC_SPINLOCK y in rwsem-2.4.4-pre6 + your latest #try3
> 
> rw
> 
> reads taken: 5842496
> writes taken: 3016649
> reads taken: 5823381
> writes taken: 3006773
> 
> r1
> 
> reads taken: 13309316
> reads taken: 13311722
> 
> r2
> 
> reads taken: 5010534
> reads taken: 5023185
> 
> ro
> 
> reads taken: 3850228
> reads taken: 3845954
> 
> w1
> 
> writes taken: 13012701
> writes taken: 13021716
> 
> wo
> 
> writes taken: 1825789
> writes taken: 1802560
> 
> ----------------------------------------------
> RWSEM_XCHGADD y in rwsem-2.4.4-pre6 + your latest #try3
> 
> rw
> 
> reads taken: 5789542
> writes taken: 2989478
> reads taken: 5801777
> writes taken: 2995669
> 
> r1
> 
> reads taken: 16922653
> reads taken: 16946132
> 
> r2
> 
> reads taken: 5650211
> reads taken: 5647272
> 
> ro
> 
> reads taken: 4956250
> reads taken: 4959828
> 
> w1
> 
> writes taken: 15431139
> writes taken: 15439790
> 
> wo
> 
> writes taken: 813756
> writes taken: 816005
> 
> graph updated attached. so in short my fast path is still quite faster (r1/w1),
> slow path is comparable now (I still win in all tests but wo which is probably
> the less interesting one in real life [write contention]). I still have room to
> improve the wo test [write contention] by spending more icache btw but it
> probably doesn't worth.

Ok I finished now my asm optimized rwsemaphores and I improved a little my
spinlock based one but without touching the icache usage.

Here it is the code against pre6 vanilla:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre6/rwsem-8

here the same but against David's try#2:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre6/rwsem-8-against-dh-try2

and here again the same but against David's latest try#3:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre6/rwsem-8-against-dh-try3

The main advantage of my rewrite are:

-	my x86 version is visibly faster than yours in the write fast path and it
	also saves icache because it's smaller (read fast path is reproducibly a bit faster too)

-	my spinlock version is visibly faster in both read and write fast path and still
	has smaller icache footprint (of course my version is completly out of line too
	and I'm comparing apples to apples)

-	at least to me the slow path of my code seems to be much simpler
	than yours (and I can actually understand it ;), for example I don't feel
	any need of any atomic exchange anywhere, I admit now comparing
	my code to yours I still don't know why you need it

-	the common code automatically extends itself to support 2^32 concurrent sleepers
	on 64bit archs

-	there is no code duplication at all in supporting xchgadd common code logic
	for other archs (and I prepared a skeleton to fill for the alpha)

Only disavantage is that sparc64 will have to fixup some bit again.

Here the numbers of the above patches on top of vanilla 2.4.4-pre6:

----------------------------------------------
RWSEM_XCHGADD y in rwsem-2.4.4-pre6 + my latest rwsem

rw

reads taken: 5736978
writes taken: 2962325
reads taken: 5799163
writes taken: 2994404

r1

reads taken: 17044842
reads taken: 17053405

r2

reads taken: 5603085
reads taken: 5601647

ro

reads taken: 4831655
reads taken: 4833518

w1

writes taken: 16064773
writes taken: 16037018

wo

writes taken: 860791
writes taken: 864103

----------------------------------------------
RWSEM_SPINLOCK y in rwsem-2.4.4-pre6 + my latest rwsem

rw

reads taken: 6061713
writes taken: 3129801
reads taken: 6099046
writes taken: 3148951

r1

reads taken: 14251500
reads taken: 14265389

r2

reads taken: 4972932
reads taken: 4936267

ro

reads taken: 4253814
reads taken: 4253432

w1

writes taken: 13652385
writes taken: 13632914

wo

writes taken: 1751857
writes taken: 1753608

I draw a graph with the above numbers compared to the previous quoted numbers I
generated a few hours ago with your latest try#3 (attached). (W1 and R1 are
respectively the benchmark of the write fast path and read fast path, only one
writer and only one reader and they're of course the most interesting ones)

So I'd suggest Linus to apply one of my above -8 patches for pre7. (I hope I
won't need any secondary try)

this is a diffstat of the rwsem-8 patch:

 arch/alpha/config.in              |    1 
 arch/alpha/kernel/alpha_ksyms.c   |    4 
 arch/arm/config.in                |    2 
 arch/cris/config.in               |    1 
 arch/i386/config.in               |    4 
 arch/ia64/config.in               |    1 
 arch/m68k/config.in               |    1 
 arch/mips/config.in               |    1 
 arch/mips64/config.in             |    1 
 arch/parisc/config.in             |    1 
 arch/ppc/config.in                |    1 
 arch/ppc/kernel/ppc_ksyms.c       |    2 
 arch/s390/config.in               |    1 
 arch/s390x/config.in              |    1 
 arch/sh/config.in                 |    1 
 arch/sparc/config.in              |    1 
 arch/sparc64/config.in            |    4 
 include/asm-alpha/compiler.h      |    9 -
 include/asm-alpha/rwsem_xchgadd.h |   27 +++
 include/asm-alpha/semaphore.h     |    2 
 include/asm-i386/rwsem.h          |  225 --------------------------------
 include/asm-i386/rwsem_xchgadd.h  |   93 +++++++++++++
 include/asm-sparc64/rwsem.h       |   35 ++---
 include/linux/compiler.h          |   13 +
 include/linux/rwsem-spinlock.h    |   57 --------
 include/linux/rwsem.h             |  106 ---------------
 include/linux/rwsem_spinlock.h    |   61 ++++++++
 include/linux/rwsem_xchgadd.h     |   96 +++++++++++++
 include/linux/sched.h             |    2 
 lib/Makefile                      |    6 
 lib/rwsem-spinlock.c              |  245 -----------------------------------
 lib/rwsem.c                       |  265 --------------------------------------
 lib/rwsem_spinlock.c              |  124 +++++++++++++++++
 lib/rwsem_xchgadd.c               |   88 ++++++++++++
 35 files changed, 531 insertions(+), 951 deletions(-)

Andrea

--M9NhX3UHpAaciwkO
Content-Type: image/png
Content-Disposition: attachment; filename="rwsem-8.png"
Content-Transfer-Encoding: base64

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
gg==

--M9NhX3UHpAaciwkO--
