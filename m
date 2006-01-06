Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752173AbWAFFF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbWAFFF3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 00:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbWAFFF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 00:05:29 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:3813 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1752173AbWAFFF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 00:05:28 -0500
Date: Fri, 6 Jan 2006 06:05:27 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux/spinlock_api_up.h has incomplete definitions
Message-ID: <Pine.LNX.4.60.0601060527110.31782@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="546507526-2142816764-1136523348=:31782"
Content-ID: <Pine.LNX.4.60.0601060559290.31782@kepler.fjfi.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--546507526-2142816764-1136523348=:31782
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.60.0601060559291.31782@kepler.fjfi.cvut.cz>

Hi,

linux/spinlock_api_up.h uses local_bh_disable() in definition of=20
__LOCK_BH(lock) for instance, but it doesn't include linux/interrupt.h, in=
=20
which the local_bh_disable() is defined. So when you compile for instance=
=20
the net/ipv4/ipvs/ip_vs_sched.c or ip_vs_est.c (which doesn't include=20
linux/interrupt.h in any direct or indirect way) in a UP configuration,=20
you get an unresolved symbol in the resulting objects (though=20
local_bh_disable() is just a macro).

However when I tried to include the linux/interrupt.h directly in the=20
linux/spinlock.h or linux/spinlock_api_up.h, nothing is able to compile=20
with following complaints:

-----------------------------------------------------------
In file included from include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:7,
                 from include/linux/interrupt.h:11,
                 from include/linux/spinlock.h:56,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/irq.h:79: error: expected specifier-qualifier-list before=20
`spinlock_t'
In file included from include/asm/vsyscall.h:4,
                 from include/asm/fixmap.h:18,
                 from include/asm/apic.h:6,
                 from include/asm/hardirq.h:8,
                 from include/linux/hardirq.h:7,
                 from include/linux/interrupt.h:11,
                 from include/linux/spinlock.h:56,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/seqlock.h:35: error: expected specifier-qualifier-list before=
 `spinlock_t'
include/linux/seqlock.h: In function `write_seqloc':
include/linux/seqlock.h:52: warning: implicit declaration of function `spin=
_lock'
include/linux/seqlock.h:52: error: `seqlock_' has no member named `lock'
include/linux/seqlock.h: In function `write_sequnloc':
include/linux/seqlock.h:61: warning: implicit declaration of function `spin=
_unlock'
include/linux/seqlock.h:61: error: `seqlock_' has no member named `lock'
include/linux/seqlock.h: In function `write_tryseqloc':
include/linux/seqlock.h:66: warning: implicit declaration of function `spin=
_trylock'
include/linux/seqlock.h:66: error: =E2=80=98seqlock_t=E2=80=99 has no membe=
r name`lock'
make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
------------------------------------------------------------

So I'm not quite sure how to fix this best. But I think that ideally all=20
publically used includes should be self sufficient and include all stuff=20
they use.

Martin

P.S.: I'm not really sure who's the maintainer of the spinlocks, and=20
though to whom should I direct this bugreport.
P.P.S.: I also filed it as bug #5840.
--546507526-2142816764-1136523348=:31782--
