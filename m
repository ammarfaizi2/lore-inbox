Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTBIL42>; Sun, 9 Feb 2003 06:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbTBIL42>; Sun, 9 Feb 2003 06:56:28 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:58703
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267222AbTBIL4Z>; Sun, 9 Feb 2003 06:56:25 -0500
Date: Sun, 9 Feb 2003 07:05:00 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][0/15] smp_call_function_on_cpu w/ removal of unused
 parameter
Message-ID: <Pine.LNX.4.50.0302090323280.2812-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patches introduce smp_call_function_on_cpu which
provides a facility for sending IPIs to a group or single cpu encapsulated
within a bitmask, this function could be used trigger remote cpus to 
modify percpu data in order to maintain local modification mandates for 
lockless algorithms, although perhaps not in a real hotpath due to 
contention for the call_lock and dependency on IPI performance on a 
specific architecture.

At present there are a number of arch specific functions which achieve 
the same effect, the name was lifted from Alpha. As per Manfred's request 
i have also taken the liberty of removing the nonatomic/retry parameter 
from smp_call_function since it's used as 'nonatomic' on a number of 
architectures and used as 'retry' on others whilst not actually doing much 
on a majority of said architectures.

The patches have been acked by some arch maintainers with no contest 
otherwise when i originally posted. If a particular arch maintainer notes 
breakage in my implementation please point it out and i'll do the grunt 
work.

Thanks,
	Zwane

 arch/alpha/kernel/core_marvel.c         |    1 
 arch/alpha/kernel/smp.c                 |   67 ++++++----------------
 arch/i386/kernel/cpu/mcheck/non-fatal.c |    2 
 arch/i386/kernel/cpu/mtrr/main.c        |    2 
 arch/i386/kernel/cpuid.c                |    2 
 arch/i386/kernel/io_apic.c              |    4 -
 arch/i386/kernel/ldt.c                  |    2 
 arch/i386/kernel/microcode.c            |    2 
 arch/i386/kernel/msr.c                  |    4 -
 arch/i386/kernel/reboot.c               |    2 
 arch/i386/kernel/smp.c                  |   64 +++++++++++++++++++--
 arch/i386/kernel/sysenter.c             |    2 
 arch/i386/mach-voyager/voyager_smp.c    |    8 +-
 arch/i386/mm/pageattr.c                 |    2 
 arch/i386/oprofile/nmi_int.c            |    8 +-
 arch/ia64/kernel/palinfo.c              |    2 
 arch/ia64/kernel/perfmon.c              |    2 
 arch/ia64/kernel/smp.c                  |   57 ++++++++++++-------
 arch/ia64/kernel/smpboot.c              |    2 
 arch/mips/kernel/smp.c                  |   54 ++++++++++++++++--
 arch/mips64/kernel/smp.c                |   74 +++++++++++++++++++++---
 arch/parisc/kernel/cache.c              |    2 
 arch/parisc/kernel/irq.c                |    6 +-
 arch/parisc/kernel/smp.c                |   91 ++++++++++++++++++++++++++----
 arch/parisc/mm/init.c                   |    2 
 arch/ppc/kernel/smp.c                   |   86 +++++++++++++++++++++++++++-
 arch/ppc64/kernel/smp.c                 |   95 ++++++++++++++++++++++++++++++--
 arch/s390/kernel/smp.c                  |   75 ++++++++++++++++++++++---
 arch/s390x/kernel/smp.c                 |   69 ++++++++++++++++++++---
 arch/sparc64/kernel/smp.c               |   64 ++++++++++++++++++++-
 arch/um/kernel/smp.c                    |   39 ++++++++++++-
 arch/x86_64/kernel/bluesmoke.c          |    2 
 arch/x86_64/kernel/cpuid.c              |    2 
 arch/x86_64/kernel/io_apic.c            |    2 
 arch/x86_64/kernel/ldt.c                |    2 
 arch/x86_64/kernel/msr.c                |    4 -
 arch/x86_64/kernel/reboot.c             |    2 
 arch/x86_64/kernel/smp.c                |   65 ++++++++++++++++++++-
 arch/x86_64/mm/pageattr.c               |    2 
 drivers/char/agp/agp.h                  |    2 
 drivers/s390/char/sclp.c                |    2 
 drivers/s390/net/iucv.c                 |    4 -
 fs/buffer.c                             |    2 
 include/asm-alpha/smp.h                 |    7 --
 include/asm-ia64/smp.h                  |    2 
 include/asm-parisc/cacheflush.h         |    7 --
 include/linux/smp.h                     |   12 +++-
 mm/slab.c                               |    2 
 48 files changed, 818 insertions(+), 195 deletions(-)
