Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264741AbSJOUdv>; Tue, 15 Oct 2002 16:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264742AbSJOUdv>; Tue, 15 Oct 2002 16:33:51 -0400
Received: from jdike.solana.com ([198.99.130.100]:10369 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S264741AbSJOUdr>;
	Tue, 15 Oct 2002 16:33:47 -0400
Message-Id: <200210152042.g9FKgMS15717@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML SMP support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Oct 2002 16:42:22 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/smp-2.5

This adds SMP support to UML.  All global data owned by UML is now either
locked or is commented as to why no locking is needed.  All interrupts
are currently handled by CPU 0.  The special handling of the timer interrupt
is now gone.

				Jeff


 arch/um/config.in                |    5 +
 arch/um/drivers/chan_user.c      |    2 
 arch/um/drivers/harddog_kern.c   |    4 
 arch/um/drivers/hostaudio_kern.c |    1 
 arch/um/drivers/line.c           |   22 ++++-
 arch/um/drivers/mconsole_kern.c  |   28 +++++-
 arch/um/drivers/mconsole_user.c  |   10 +-
 arch/um/drivers/mmapper_kern.c   |    3 
 arch/um/drivers/net_kern.c       |   23 ++++-
 arch/um/drivers/port_kern.c      |   13 ++-
 arch/um/drivers/ssl.c            |    5 -
 arch/um/drivers/stdio_console.c  |    9 ++
 arch/um/drivers/ubd_kern.c       |  147 ++++++++++++++++++++++++----------
 arch/um/drivers/ubd_user.c       |    4 
 arch/um/drivers/xterm.c          |    1 
 arch/um/include/2_5compat.h      |    2 
 arch/um/include/irq_user.h       |    4 
 arch/um/include/kern_util.h      |   10 --
 arch/um/include/mconsole.h       |    2 
 arch/um/include/sigio.h          |    2 
 arch/um/include/time_user.h      |    6 -
 arch/um/kernel/exec_kern.c       |    3 
 arch/um/kernel/exitcode.c        |    3 
 arch/um/kernel/frame.c           |    4 
 arch/um/kernel/helper.c          |    1 
 arch/um/kernel/initrd_kern.c     |    1 
 arch/um/kernel/irq.c             |   29 ++++++
 arch/um/kernel/irq_user.c        |  162 ++++++++++++++++++++++++++-----------
 arch/um/kernel/mem.c             |   45 +++++++---
 arch/um/kernel/mem_user.c        |    5 -
 arch/um/kernel/process.c         |   14 +--
 arch/um/kernel/process_kern.c    |   53 +++++++++---
 arch/um/kernel/sigio_kern.c      |   13 +++
 arch/um/kernel/sigio_user.c      |   59 ++++++++++---
 arch/um/kernel/signal_user.c     |   27 +++---
 arch/um/kernel/smp.c             |  167 ++++++++++++++++++---------------------
 arch/um/kernel/syscall_kern.c    |   15 ++-
 arch/um/kernel/syscall_user.c    |   13 ---
 arch/um/kernel/time.c            |   44 +++-------
 arch/um/kernel/time_kern.c       |   31 ++++++-
 arch/um/kernel/trap_kern.c       |   15 ++-
 arch/um/kernel/trap_user.c       |   79 +++++++-----------
 arch/um/kernel/tty_log.c         |    4 
 arch/um/kernel/um_arch.c         |   29 +++---
 arch/um/kernel/umid.c            |    4 
 arch/um/kernel/user_util.c       |    1 
 arch/um/main.c                   |   13 ++-
 arch/um/ptproxy/proxy.c          |    6 -
 arch/um/sys-i386/bugs.c          |    1 
 arch/um/sys-i386/ptrace_user.c   |    1 
 arch/um/sys-ppc/miscthings.c     |    3 
 arch/um/uml.lds.S                |    3 
 include/asm-um/cache.h           |    3 
 include/asm-um/smp.h             |   17 +++
 include/asm-um/thread_info.h     |    4 
 55 files changed, 774 insertions(+), 401 deletions(-)

ChangeSet@1.786, 2002-10-15 11:21:41-04:00, jdike@uml.karaya.com
  Fixed some locking bugs spotted by Oleg Drokin.

ChangeSet@1.785, 2002-10-14 18:51:59-04:00, jdike@uml.karaya.com
  Fixed the non-SMP build.

ChangeSet@1.784, 2002-10-14 11:31:46-04:00, jdike@uml.karaya.com
  config.in now defines CONFIG_NR_CPUS.

ChangeSet@1.783, 2002-10-14 09:53:55-04:00, jdike@uml.karaya.com
  This is the merge of the initial 2.4 SMP support.
  Locking was added where necessary.
  All processors take timer interrupts, but only CPU 0 calls the timer
  IRQ.  The others just call update_process_times to keep the
  accounting straight.
  The timer interrupt is blocked along with the other signals.

