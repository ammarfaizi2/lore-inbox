Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136271AbRDVTH6>; Sun, 22 Apr 2001 15:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136274AbRDVTHk>; Sun, 22 Apr 2001 15:07:40 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23300 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136271AbRDVTHb>; Sun, 22 Apr 2001 15:07:31 -0400
Date: Sun, 22 Apr 2001 21:07:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "D . W . Howells" <dhowells@astarte.free-online.co.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dhowells@redhat.com,
        davem@redhat.com
Subject: Re: [PATCH] rw_semaphores, optimisations
Message-ID: <20010422210703.G10226@athlon.random>
In-Reply-To: <01042201272000.01091@orion.ddi.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <01042201272000.01091@orion.ddi.co.uk>; from dhowells@astarte.free-online.co.uk on Sun, Apr 22, 2001 at 01:27:20AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 22, 2001 at 01:27:20AM +0100, D . W . Howells wrote:
> This patch (made against linux-2.4.4-pre6) makes a number of changes to the
> rwsem implementation:
> 
>  (1) Fixes a subtle contention bug between up_write and the down_* functions.
> 
>  (2) Optimises the i386 fastpath implementation and changed the slowpath
>      implementation to aid it.
>      - The arch/i386/lib/rwsem.c is now gone.
>      - Better inline asm constraints have been applied.
> 
>  (3) Changed the sparc64 fastpath implementation to use revised slowpath
>      interface.
>      [Dave Miller: can you check this please]
> 
>  (4) Makes the generic spinlock implementation non-inline.
>      - lib/rwsem.c has been duplicated to lib/rwsem-spinlock.c and a
>        slightly different algorithm has been created. This one is simpler
>        since it does not have to use atomic operations on the counters as
>        all accesses to them are governed by a blanket spinlock.

I finally finished dropping the list_empty() check from my generic rwsemaphores.

The new behaviour of my rwsemaphores are:

-	max sleepers and max simultanous readers both downgraded to 2^(BITS_PER_LONG>>1) for
	higher performance in the fast path
-	up_* cannot be recalled from irq/softirq context anymore

I'm using this your latest patch on top of vanilla 2.4.4-pre6 to benchmark my
new generic rwsemaphores against yours.

To benchmark I'm using your tar.gz but I left my 50 seconds run of the rwtest
with many more readers and writers to stress it a bit more (I posted the
changes to the rwsem-rw.c test in the message where I reported the race in your
semaphores before pre6).

Here the results (I did two tries for every bench and btw the numbers are
quite stable as you can see).

rwsem-2.4.4-pre6 + my new generic rwsem (fast path in C inlined)

rw

reads taken: 6499121
writes taken: 3355701
reads taken: 6413447
writes taken: 3311328

r1

reads taken: 15218540
reads taken: 15203915

r2

reads taken: 5087253
reads taken: 5099084

ro

reads taken: 4274607
reads taken: 4280280

w1

writes taken: 14723159
writes taken: 14708296

wo

writes taken: 1778713
writes taken: 1776248

----------------------------------------------
rwsem-2.4.4-pre6 + my new generic rwsem with fast path out of line (fast path in C out of line)

rw

reads taken: 6116063
writes taken: 3157816
reads taken: 6248542
writes taken: 3226122

r1

reads taken: 14092045
reads taken: 14112771

r2

reads taken: 4002635
reads taken: 4006940

ro

reads taken: 4150747
reads taken: 4150279

w1

writes taken: 13655019
writes taken: 13639011

wo

writes taken: 1757065
writes taken: 1758623

----------------------------------------------
RWSEM_GENERIC_SPINLOCK y in rwsem-2.4.4-pre6 + your latest #try2 (fast path in C out of line)

rw

reads taken: 5872682
writes taken: 3032179
reads taken: 5892582
writes taken: 3042346

r1

reads taken: 13079190
reads taken: 13104405

r2

reads taken: 3907702
reads taken: 3906729

ro

reads taken: 3005924
reads taken: 3006690

w1

writes taken: 12581209
writes taken: 12570627

wo

writes taken: 1376782
writes taken: 1328468

----------------------------------------------
RWSEM_XCHGADD y in rwsem-2.4.4-pre6 + your latest #try2 (fast path in asm in line)

rw

reads taken: 5789650
writes taken: 2989604
reads taken: 5776594
writes taken: 2982812
r1

reads taken: 16935488
reads taken: 16930738

r2

reads taken: 5646446
reads taken: 5651600

ro

reads taken: 4952654
reads taken: 4956992

w1

writes taken: 15432874
writes taken: 15408684

wo

writes taken: 814131
writes taken: 815551

To make it more readable I plotted the numbers in a graph (attached).

So my new C based rw semaphores are faster than your C based semaphores in
all tests and they're even faster than your x86 asm inlined semaphores when
there's contention (however it's probably normal that with contention the asm
semaphores are slower so I'm not sure I can make the asm inlined semaphore
faster than yours).  I will try to boost my new rwsem with asm in the fast path
now (it won't be easy but possibly by only changing a few lines of the slow
path inside an #ifdef CONFIG_...) to see where can I go. Once I will have an
asm inlined fast path for >=486 integrated I will upload a patch but if you
want a patch now with only the new generic C implementation to verify the above
numbers let me know of course (ah and btw the machine is a 2-way PII 450mhz).

I think it's interesting also the comparison of my generic rwsem when inlined
and not inlined (first four columns). BTW, I also tried to move my only lock in
a separated cacheline (growing the size of the rwsem over 32bytes) and that
hurted a lot.

Note also the your wo results with your asm version (the one in pre6 + your
latest try#2) is scoring more than two times worse than my generic semaphores.

Andrea

--UHN/qo2QbUvPLonB
Content-Type: image/png
Content-Disposition: attachment; filename="rwsem.png"
Content-Transfer-Encoding: base64

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

--UHN/qo2QbUvPLonB--
