Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbTBQIHS>; Mon, 17 Feb 2003 03:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbTBQIF5>; Mon, 17 Feb 2003 03:05:57 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:25246
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266938AbTBQIFM>; Mon, 17 Feb 2003 03:05:12 -0500
Date: Mon, 17 Feb 2003 03:13:34 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Anton Blanchard <anton@samba.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH][2.5][0/5] CPU Hotplug 2.5.61 update + fixes
Message-ID: <Pine.LNX.4.50.0302170229080.18087-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Makefile                       |    2 
 arch/i386/kernel/irq.c         |   18 +++
 arch/i386/kernel/process.c     |   39 +++++++-
 arch/i386/kernel/smp.c         |   18 +++
 arch/i386/kernel/smpboot.c     |   66 ++++++++++++--
 fs/buffer.c                    |   16 +++
 include/asm-generic/topology.h |    3 
 include/asm-i386/smp.h         |    4 
 include/linux/brlock.h         |    1 
 include/linux/mmzone.h         |    1 
 include/linux/sched.h          |    3 
 include/linux/smp.h            |   24 +----
 kernel/Makefile                |    3 
 kernel/cpu.c                   |  193 ++++++++++++++++++++++++++++++++++++++++-
 kernel/rcupdate.c              |   67 ++++++++++++++
 kernel/sched.c                 |  190 ++++++++++++++++++++++++++++++++--------
 kernel/softirq.c               |   70 +++++++++++++-
 kernel/timer.c                 |   39 ++++++++
 kernel/workqueue.c             |  137 +++++++++++++++++++++--------
 mm/slab.c                      |   39 ++++++++
 mm/vmscan.c                    |   44 +++++++++
 net/core/dev.c                 |   64 +++++++++++++
 22 files changed, 925 insertions(+), 116 deletions(-)

CPU Hotplug 2.5.61

changes from current cpu hotplug tree:

- fixed build for UP w/ CONFIG_HOTPLUG - Stephen Hemminger

kernel/rcupdate.c
- added RCU CPU_OFFLINE handling which moves all current and pending callbacks from the dying
  cpu to a global queue, which is cleared a callback at a time in the rcu_softirq path.
	function(s) added:
		rcu_move_batch
 
kernel/timer.c
- We now migrate timers from the dying cpu to the current one.
	function(s) added:
		migrate_timers_from

mm/slab.c
- Made timer deletion happen on the OFFLINE path and be carried out by the owning cpu

arch/i386/kernel/smpboot.c
- Removed dying cpu from irq_affinity masks in __cpu_die

arch/i386/kernel/irq.c
- Added helper to remove dying cpu from irq affinity masks, this is really a generic function
  and could be placed elsewhere given when we get a generic irq layer.
	function(s) added:
		migrate_irqs_from

All changes have been tested on 4 and 8way i386 (Courtesy of OSDL), although i'm not 
claiming stability at this stage (this is a review patch) we have managed 
to offline/online whilst doing a kernel compile (make -j8), however there 
are problems with the networking offline code which trigger when  
offlining cpus under load.

Problematic config options:
CONFIG_PREEMPT - causes premature scheduling

	Zwane
-- 
function.linuxpower.ca
