Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291333AbSBRTeK>; Mon, 18 Feb 2002 14:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290974AbSBRTcY>; Mon, 18 Feb 2002 14:32:24 -0500
Received: from mx2.elte.hu ([157.181.151.9]:27084 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282843AbSBRT3p>;
	Mon, 18 Feb 2002 14:29:45 -0500
Date: Mon, 18 Feb 2002 22:27:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, akpm <akpm@zip.com.au>,
        rsf <rsf@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
        phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: [patch] simpler 'highpte' design.
Message-ID: <Pine.LNX.4.33.0202182118090.10402-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0202182219541.11933@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We'd like to propose the following, simpler 'highpte' design:

  http://redhat.com/~mingo/highpte-patches/setup-highmem-2.5.5-A0
  http://redhat.com/~mingo/highpte-patches/uvirt-to-kva-2.5.5-A0
  http://redhat.com/~mingo/highpte-patches/highpte-2.5.5-A0

(the highpte-2.5.5-A0 patch is the 'interesting' patch.)

the underlying issue is the following: on 32-bit x86 systems with lots of
RAM and lots of processes, the total size of process pagetables can be
very high. Until now, the VM allocated pagetables in the so-called lowmem
pool, which has a maximum size of 1 GB. So on 32 GB systems it can happen
that the system becomes limited by this 1 GB pool. This problem has been
seen in practice on enterprise-size Linux systems. Hence these patches
that allow the pagetables to reside in the 'highmem' area as well.

why did we write a new patch? There are a number of fundamental
differences between Andrea's patch and our highpte patch:

- we never kmap() deep within the VM, accessing pte's.

  In this design it's not allowed to kmap() ptes. No blocking, no
  spinlocking.

  kmap() is deadlock land for any serious load, and it also creates
  nasty dependencies - who wants to squeeze 32GB of RAM into a tiny kmap
  window. kmap() was implemented by me and i never wanted it to have any
  bigger role. The global spinlock, the seldom tested 'out of kmap
  entries' case all point in the direction of unrobustness. kmap() is
  unavoidable in a few places, but we do not want to depend on it too
  much.

- we do not put kernel-VM ptes into highmem.

  the 'upper 1 GB' (default VM split) kernel pagetables are shared by
  every process in the system, thus there is just no point in complicating
  (and slowing down) the directly mapped portion of the VM. Look at how
  low impact our patch has on the arch/i386 tree.

  kernel-space VM and user-space VM access can be separated very cleanly
  in 99% of the cases. But the user-space pte mapping functions work for
  the kernel-space pagetables as well - since the kernel-space TLBs are in
  lowmem, they will work automatically, this covers the remaining 1%.

- safe interface migration.

  this patch removes pte_offset() which becomes pte_offset_map(). Patches
  and modules that are not updated to the new mechanizm will fail
  safely at compile-time. This also makes it easier to identify the places
  that need fixing.

  also, due to the fact that the mapping of ptes cannot block in this
  design, all the pmd_page_under_lock() and pmd_page2_under_lock()
  complexity visible in Andrea's patch becomes unnecessery.

- no 'kmap series' complexity.

  since the patch does not depend on the kmap series stuff for
  performance, that portion can be omitted. I'd like to have persistent
  kmaps be used very carefully, and only in clear, highlevel cases such as
  read(). kmap() bugs have a track record of being found very slowly,
  this is mostly due to the relative rarity of truly big highmem systems.

[ - configurability.

  minor nit: Andrea's latest patch ties highmem-ptes to CONFIG_HIGHMEM.
  This is no big issue. Our patch defines 5 highmem variants:

       "off           CONFIG_NOHIGHMEM
        4GB           CONFIG_HIGHMEM4G
        4GB-highpte   CONFIG_HIGHMEM4G_HIGHPTE
        64GB          CONFIG_HIGHMEM64G
        64GB-highpte  CONFIG_HIGHMEM64G_HIGHPTE

  which is more correct IMO - people who eg. use their RAM to fill the
  pagecache should have the option to disable pte-mapping.

  (if anyone is wondering why 4G_HIGHPTE exists, we have seen
   production 4G_HIGH systems hitting the 1 GB pagetable size
   limit as well ...) ]

[ - the removal of pte/pmd/pgd quicklists.

  While not directly connected to highpte's, i think a per-CPU page-pool
  will solve most of the needs here. The pgd quicklist was disabled in the
  base kernel because it showed weird problems. It always looked a bit
  fragile that we had all these special pools for ptes, pmds and pgds. But
  this issue is clearly separate and should be addressed in a separate
  patch. ]

please take a look at our patch, and see the fundamental simplicity of it.
The patch in essence makes 'pte access' a slightly more expensive
instruction on CONFIG_HIGHPTE systems - no locking and no blocking is
involved. I very strongly believe that we want to have this kind of
simplicity on the lowest level of our VM: when accessing the pte's.

testing status: i iterated through the following test-matrix:

                   nohighmem  4GB  4GB-highpte  64GB  64GB-highpte
 UP-preempt on         x       x       x         x        x
 UP-preempt off        x       x       x         x        x
 SMP-preempt on        x       x       x         x        x
 SMP-preempt off       x       x       x         x        x

all 20 kernels compile & boot just fine kernel 2.5.5-pre1 + the 3 patches.
I've done VM stresstesting as well, on 64GB-highpte-preempt-SMP and
nohighmem-nopreempt-UP (the two opposite points in the complexity
spectrum). I've also tested some kernels inbetween. (4GB-highpte-SMP for
example.) The Rik-VM based variant of the patch has seen a few hours of
Cerberus testing as well, and has proven to be robust. The patch is
absolutely preemption-safe.

(note that the debugging helpers so far caught all the bugs one can make
while converting non-mapped pte code to mapped pte code.)

Comments?

	Ingo

ps.

[ I'd like to specify the directions in which blame can go: the
uvirt-to-kva-2.5.5-A0 cleanup patch was written by Arjan (merged to
2.5.5-pre1 by me), the setup-highmem-2.5.5-A0 patch was written by me, and
the highpte-2.5.5-A0 patch was designed by Arjan and myself and
implemented mostly by myself. Testing and cleanup was done by both of us.]


