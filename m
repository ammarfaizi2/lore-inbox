Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVBPBIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVBPBIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 20:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVBPBIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 20:08:05 -0500
Received: from exosec.net1.nerim.net ([62.212.114.195]:15784 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S261400AbVBPBGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 20:06:10 -0500
Date: Wed, 16 Feb 2005 02:06:00 +0100
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com
Subject: [ANNOUNCE] kernel 2.4 hotfixes : 2.4.29-hf2
Message-ID: <20050216010600.GA15323@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

after a short discussion with Marcelo, we quickly agreed that a hotfix tree
would be a good thing for kernel 2.4, since a few months can separate two
stable releases. I offered to help in this area because I already have to
pick random patches from the BK changesets anyway, so the only additional
work will be to pack them in a more presentable way than what I can do just
for me. Marcelo offered to help me by telling me when he thinks that a
particular patch needs to be merged or excluded.

Overall, the patches included are classified in 6 categories :
  - security : fixes for security bugs in general
  - critical : fixes for problems leading to panic, or data corruption
  - major    : fixes for general system stability (oopses, memory leaks, ...)
  - minor    : fixes for erroneous behaviours in general.
  - build    : missing includes, Makefile bugs, etc... which prevents certain
               configurations from being built (here, we should often encounter
               Adrian Bunk's numerous patches :-))
  - documentation : configure.help and friends. Will most probably be fed by
                    Adrian's contributions too.

As much as possible, I will avoid changes in drivers because we all know that
in this area, a fix for one user breaks another one.

Anyway, all of those patches will be extracted from -BK. I'm not building a
parallel tree (I already have another one for that :-)). The main goal is
that the diff between this kernel and the next release should be smaller
than the diff between previous and next release.

Marcelo and I agreed on the "-hf" suffix (for "Hot Fix"). Two patches are
systematically provided, one with the version in the Makefile, and one
without. The goal is to ease both people using vanilla kernels in production
(who need to check the real version) and people who want a virgin kernel base
to apply external patches while limiting the number of rejects.

A tarball is also included with all the individual patches. A makefile relies
on the "CONTENTS" file itself to rebuild the patch against the kernel of your
choice. It is very easy to add/remove patches in the CONTENTS file, so I hope
it will be convenient enough for people who don't want to include minor or
documentation fixes for example. It is documented anyway.

I've started with 2.4.29 and released 2.4.29-hf2 a few days ago. In fact, I
was waiting for the site to migrate from home to my company (EXOSEC) to
benefit from more outgoing bandwidth, before sending this announce. Despite
this, I will try to stay up to date within the shortest time, and release
a new hotfix as soon as either something weird gets fixed, or Marcelo asks
me to do so. In any case, I'll do my best to send an announce here for new
releases.

The patches and tarballs are hosted here :

     http://linux.exosec.net/kernel/2.4-hf/

I'm open to comments, advices, critics, etc, but flames such as "you lose
your time" or "2.4 is dead" will feed /dev/null. One possible improvement
I have already identified would be to publish the work in progress so that
people could get fixes in real time, but if they really need so, they should
download from BK instead.

If this branch gets enough demand, I will maintain several previous versions
in parallel (eg: go back to 2.4.27).

In the mean time, please find here the CONTENTS file which details what
patches have been included and basically what they do.

Enjoy,
Willy



-->8-- CONTENTS file  : please remove it before replying.


1) Security fixes
=================
+ flash_erase-checks-cap_sys_admin-1                             (James Nelson)

  This patch adds CAP_SYS_ADMIN checks to the potentially dangerous ioctls
  FLASH_Erase and FLASH_Burn in the Cobalt LCD interface driver.

+ rw_verify_area-against-file-offset-overflow-2                (Linus Torvalds)

  backport 2.6 rw_verify_area() to check against file offset overflows 
  - Make generic rw_verify_area check against file offset overflows.
  - Add 'f_maxcount' to allow filesystems to set a per-file maximum IO size.
  - Rename "locks_verify_area()" to "rw_verify_area()" and clean up the
    arguments.

+ rw_verify_area-missing-f_maxcount-1                          (Solar Designer)

+ wireless-data-leak-1                                           (Chris Wright)

  There is a potential leak of kernel data to user space in private
  handler handling. Few drivers use that feature, there is no risk
  of crash or direct attack, so I would not worry about it.


2) Critical fixes
=================
+ panic-when-backing-up-lvm-snapshots-1                  (Heinz J. Mauelshagen)

  This patch fixes lvm-snap.c in order to avoid a list update on
  the snapshot exception hash happening while only holding a read
  lock as documented in Red Hat bugzilla #135266.


3) Major bug fixes
==================
+ oops-ata_to_sense_error-1                                       (Jeff Garzik)

  Fix an oops in ata_to_sense_error

+ lcd_ioctl-memory-leak-1                                        (James Nelson)

  This patch fixes a memory leak in the FLASH_Burn ioctl for the Cobalt LCD
  interface driver.

+ pkt_sched-netem-leaks-memory-1                            (Stephen Hemminger)

  Good catch.. netem needs to free skb's that are dropped due to loss
  simulation.

+ netlink-fix-nlmsg_goodsize-calculation-1                        (Thomas Graf)

  NLMSG_GOODSIZE specifies a good default size for the skb tailroom
  used in netlink messages when the size is unknown at the time of
  the allocation.
  
  The current value doesn't make much sense anymore because
  skb_shared_info isn't taken into account which means that
  depending on the architecture NLMSG_GOOSIZE can exceed PAGE_SIZE
  resulting in a waste of almost a complete page.
  
  Using SKB_MAXORDER solves this potential leak at the cost of
  slightly smaller but safer sizes for some architectures.
  
+ proc-kcore-memory-corruption-1                               (Ernie Petrides)

  A fairly nasty memory corruption potential exists when
  /proc/kcore is accessed and there are at least 62 vmalloc'd areas.
  (...)
  The fix is already in 2.6.

4) Minor bug fixes
==================
+ ppc32-tlb-miss-handler-1                        (Tom Rini / Joakim Tjernlund)

  There is a problem in the TLB Miss (and Error, as they jump to the Miss
  handler) handlers.  The problem is that when an app spans more than one L1
  entry, we don't have all of the correct information, and do_page_fault()
  things a protection fault happened, when it didn't really.  The fix for
  this is to modify the handlers slightly to force a TLB Error in this case.

+ rtnetlink-set-multi-flags-1                                     (Thomas Graf)

  Set NLM_F_MULTI for neighbour rtnetlink messages to userspace.

+ hiddev-busy-loop-1                                              (David Micon)

  In the loop, schedule() returns with the current state TASK_RUNNING,
  so at the next revolution it returns immediately, and the task sits
  there burning CPU.

+ msf-overflow-multisession-dvd-1                             (Luca Tettamanti)

  This a backport of my patch that went into 2.6.10. cdrom_read_toc
  (ide-cd.c) always reads the TOC using MSF format. If the last session
  of the disk starts beyond block 1152000 (LBA) there's an overflow in
  the MSF format and kernel complains:

      Unable to identify CD-ROM format.

  So read the multi-session TOC in LBA format in order to avoid an
  overflow in MSF format with multisession DVDs.

+ sparc64-signed-atomic-values-1               (David S. Miller / Hugh Daniels)

  Even though we declare these functions as returning a 32-bit signed
  integer, the sparc64 ABI states that such functions must properly
  sign-extend the return value to the full 64-bits.

+ kfree_skb-missing-memory-barrier-1                               (Herbert Xu)

  The bug is that in the case where we do the atomic_read()
  optimization, we need to make sure that reads of skb state
  later in __kfree_skb() processing (particularly the skb->list
  BUG check) are not reordered to occur before the counter
  read by the cpu.

+ net-put-barriers-around-dst-refcnt-1                             (Herbert Xu)

  In light of the recent discussion about sk_buff, I think we need
  the following patch for dst_entry.  This adds a memory barrier
  before dst_release drops the refcnt, and a read memory barrier
  before dst_destroy starts destroying the entry.

+ sparc64-atomic-and-bitops-fixes-1                           (David S. Miller)

  1) Correct memory barriers.  Routines not returning a value need
     no memory barriers, however routines returning values do need
     them.
  2) Actually implement non-atomic ext2 bitops.

+ sparc64-xchg-use-membars-1                                  (David S. Miller)

  [SPARC64]: Add missing membars for xchg() and cmpxchg().

+ sparc64-locks-use-membars-1                                 (David S. Miller)

  [SPARC64]: Add missing membars for xchg() and cmpxchg().
  read_unlock should order all previous memory operations
  before the atomic counter update to drop the lock.
  The debugging version of write_unlock had a similar error.

+ ipconfig-use-memmove-not-strcpy-1                            (Matthew Wilcox)

  strcpy is undefined if src and dest overlap.  That's clearly possible
  here with a sufficiently deep path on the server.  Use memmove instead.

+ sparc64-mask-32bits-stack-ptr-1                             (David S. Miller)

  [SPARC64]: Mask off stack ptr in alloc_user_space() for 32-bit.

+ i386-pci-irq-displays-wrong-pin-1                                (Mark Haigh)

  [PATCH] arch/i386/kernel/pci-irq.c: Wrong message output
  
  I'd submitted a patch earlier for this file, fixing a warning.  When I
  looked at it further, I noticed it can output an incorrect warning
  message under certain circumstances.  I've confirmed that this can and
  does happen in the wild:
  (...)  
  This patch also fixes the original warning:

+ lp_write-race-can-corrupt-data-1                            (Kenneth Sumrall)

  In lp_write(), copy_from_user() is called to copy data into a statically
  allocated kernel buffer before down_interruptible() is called.  If a
  second thread of execution comes in between the copy_from_user() and
  the down_interruptible() calls, silent data corruption could result.

  
5) Build fixes
==============
+ configure-mangles-hex-values-1                                 (Nick Pollitt)

  When doing a make oldconfig, the hex function strips the leading '0x'
  from hex values. The '0x' is needed in the final autoconf.h, and its
  absence causes the following problem.

+ sparc-membar-extra-semi-colons-1                               (Willy Tarreau)
+ sparc64-membar-extra-semi-colons-1                             (Willy Tarreau)

  Recent addition of smp_rmb() in kfree_skb() broke sparc{,64} build.


6) Documentation fixes
======================
none yet.

END.

