Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSL1PjX>; Sat, 28 Dec 2002 10:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266218AbSL1PjX>; Sat, 28 Dec 2002 10:39:23 -0500
Received: from mnh-1-01.mv.com ([207.22.10.33]:45316 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265096AbSL1Pez>;
	Sat, 28 Dec 2002 10:34:55 -0500
Message-Id: <200212281547.KAA02128@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow UML kernel to run in a separate host address space 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 10:47:10 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull either
	http://uml.bkbits.net/skas-2.5
or	http://jdike.stearns.org:5000/skas-2.5

This allows the UML kernel to run in a different address space from its
processes.  The benefits include better security and much improved performance.
This is a large patch, but
	it's all under arch/um and include/asm-um
	a lot of it is code movement

This is described fairly completely in
	http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&safe=off&selm=fa.ia69pmv.e4qnq1%40ifi.uio.no

				Jeff

 arch/um/Kconfig                           |    8 
 arch/um/Makefile                          |   77 ++--
 arch/um/Makefile-i386                     |    4 
 arch/um/drivers/chan_kern.c               |   66 +++
 arch/um/drivers/chan_user.c               |   33 -
 arch/um/drivers/fd.c                      |    6 
 arch/um/drivers/line.c                    |  108 +++++-
 arch/um/drivers/mconsole_kern.c           |   62 +++
 arch/um/drivers/null.c                    |    5 
 arch/um/drivers/port_kern.c               |   13 
 arch/um/drivers/port_user.c               |    9 
 arch/um/drivers/pty.c                     |   19 -
 arch/um/drivers/ssl.c                     |   36 +-
 arch/um/drivers/stdio_console.c           |   32 +
 arch/um/drivers/tty.c                     |    8 
 arch/um/drivers/ubd_kern.c                |   39 ++
 arch/um/drivers/xterm.c                   |    4 
 arch/um/include/chan_kern.h               |    3 
 arch/um/include/chan_user.h               |    4 
 arch/um/include/choose-mode.h             |   35 ++
 arch/um/include/debug.h                   |   26 -
 arch/um/include/frame.h                   |   18 -
 arch/um/include/kern.h                    |    2 
 arch/um/include/kern_util.h               |   28 -
 arch/um/include/line.h                    |   11 
 arch/um/include/mconsole_kern.h           |   16 
 arch/um/include/mem.h                     |    1 
 arch/um/include/mem_user.h                |   12 
 arch/um/include/mode.h                    |   30 +
 arch/um/include/mode_kern.h               |   30 +
 arch/um/include/os.h                      |    8 
 arch/um/include/sigcontext.h              |    2 
 arch/um/include/syscall_user.h            |   13 
 arch/um/include/sysdep-i386/checksum.h    |  217 ++++++++++++
 arch/um/include/sysdep-i386/frame_kern.h  |    9 
 arch/um/include/sysdep-i386/ptrace.h      |  109 ++++--
 arch/um/include/sysdep-i386/sigcontext.h  |   33 +
 arch/um/include/time_user.h               |    2 
 arch/um/include/um_mmu.h                  |   40 ++
 arch/um/include/um_uaccess.h              |   73 ++++
 arch/um/include/user_util.h               |   26 -
 arch/um/kernel/Makefile                   |   58 +--
 arch/um/kernel/checksum.c                 |   42 ++
 arch/um/kernel/exec_kern.c                |   64 ---
 arch/um/kernel/exec_user.c                |   49 --
 arch/um/kernel/frame.c                    |  204 ++++++-----
 arch/um/kernel/frame_kern.c               |   85 +++-
 arch/um/kernel/helper.c                   |    5 
 arch/um/kernel/init_task.c                |    2 
 arch/um/kernel/ksyms.c                    |   17 
 arch/um/kernel/mem.c                      |   71 +---
 arch/um/kernel/mem_user.c                 |   44 --
 arch/um/kernel/process.c                  |  136 +++++--
 arch/um/kernel/process_kern.c             |  477 +--------------------------
 arch/um/kernel/ptrace.c                   |   61 +++
 arch/um/kernel/reboot.c                   |   25 -
 arch/um/kernel/sigio_user.c               |   13 
 arch/um/kernel/signal_kern.c              |   19 -
 arch/um/kernel/signal_user.c              |    9 
 arch/um/kernel/skas/Makefile              |   24 +
 arch/um/kernel/skas/exec_kern.c           |   41 ++
 arch/um/kernel/skas/exec_user.c           |   61 +++
 arch/um/kernel/skas/include/mmu.h         |   27 +
 arch/um/kernel/skas/include/mode.h        |   34 +
 arch/um/kernel/skas/include/mode_kern.h   |   52 +++
 arch/um/kernel/skas/include/proc_mm.h     |   55 +++
 arch/um/kernel/skas/include/ptrace-skas.h |   57 +++
 arch/um/kernel/skas/include/skas.h        |   49 ++
 arch/um/kernel/skas/include/skas_ptrace.h |   36 ++
 arch/um/kernel/skas/include/uaccess.h     |  236 +++++++++++++
 arch/um/kernel/skas/mem.c                 |   35 ++
 arch/um/kernel/skas/mem_user.c            |   95 +++++
 arch/um/kernel/skas/mmu.c                 |   46 ++
 arch/um/kernel/skas/process.c             |  386 ++++++++++++++++++++++
 arch/um/kernel/skas/process_kern.c        |  195 +++++++++++
 arch/um/kernel/skas/sys-i386/Makefile     |   14 
 arch/um/kernel/skas/sys-i386/sigcontext.c |  114 ++++++
 arch/um/kernel/skas/syscall_kern.c        |   42 ++
 arch/um/kernel/skas/syscall_user.c        |   47 ++
 arch/um/kernel/skas/time.c                |   30 +
 arch/um/kernel/skas/tlb.c                 |  156 +++++++++
 arch/um/kernel/skas/trap_user.c           |   66 +++
 arch/um/kernel/skas/util/Makefile         |   10 
 arch/um/kernel/skas/util/mk_ptregs.c      |   50 ++
 arch/um/kernel/smp.c                      |   12 
 arch/um/kernel/sys_call_table.c           |   15 
 arch/um/kernel/syscall_kern.c             |  126 -------
 arch/um/kernel/syscall_user.c             |   79 ----
 arch/um/kernel/sysrq.c                    |    8 
 arch/um/kernel/time.c                     |   22 -
 arch/um/kernel/time_kern.c                |    3 
 arch/um/kernel/tlb.c                      |  225 +------------
 arch/um/kernel/trap_kern.c                |  361 +++------------------
 arch/um/kernel/trap_user.c                |  492 +---------------------------
 arch/um/kernel/tt/Makefile                |   20 +
 arch/um/kernel/tt/exec_kern.c             |   84 ++++
 arch/um/kernel/tt/exec_user.c             |   49 ++
 arch/um/kernel/tt/gdb.c                   |  278 ++++++++++++++++
 arch/um/kernel/tt/gdb_kern.c              |   40 ++
 arch/um/kernel/tt/include/debug.h         |   29 +
 arch/um/kernel/tt/include/mmu.h           |   23 +
 arch/um/kernel/tt/include/mode.h          |   35 ++
 arch/um/kernel/tt/include/mode_kern.h     |   53 +++
 arch/um/kernel/tt/include/ptrace-tt.h     |   26 +
 arch/um/kernel/tt/include/tt.h            |   45 ++
 arch/um/kernel/tt/include/uaccess.h       |  119 ++++++
 arch/um/kernel/tt/ksyms.c                 |   28 +
 arch/um/kernel/tt/mem.c                   |   77 ++++
 arch/um/kernel/tt/process_kern.c          |  513 ++++++++++++++++++++++++++++++
 arch/um/kernel/tt/ptproxy/Makefile        |   13 
 arch/um/kernel/tt/ptproxy/proxy.c         |  370 +++++++++++++++++++++
 arch/um/kernel/tt/ptproxy/ptproxy.h       |   61 +++
 arch/um/kernel/tt/ptproxy/ptrace.c        |  239 +++++++++++++
 arch/um/kernel/tt/ptproxy/sysdep.c        |   71 ++++
 arch/um/kernel/tt/ptproxy/sysdep.h        |   25 +
 arch/um/kernel/tt/ptproxy/wait.c          |   86 +++++
 arch/um/kernel/tt/ptproxy/wait.h          |   15 
 arch/um/kernel/tt/sys-i386/Makefile       |   14 
 arch/um/kernel/tt/sys-i386/sigcontext.c   |   59 +++
 arch/um/kernel/tt/syscall_kern.c          |  140 ++++++++
 arch/um/kernel/tt/syscall_user.c          |   90 +++++
 arch/um/kernel/tt/time.c                  |   28 +
 arch/um/kernel/tt/tlb.c                   |  226 +++++++++++++
 arch/um/kernel/tt/tracer.c                |  466 +++++++++++++++++++++++++++
 arch/um/kernel/tt/trap_user.c             |   58 +++
 arch/um/kernel/tt/uaccess_user.c          |  126 +++++++
 arch/um/kernel/uaccess_user.c             |  126 -------
 arch/um/kernel/um_arch.c                  |  119 +++---
 arch/um/kernel/umid.c                     |    6 
 arch/um/main.c                            |   64 ---
 arch/um/os-Linux/Makefile                 |    6 
 arch/um/os-Linux/drivers/Makefile         |    3 
 arch/um/os-Linux/process.c                |   42 ++
 arch/um/os-Linux/tty.c                    |    2 
 arch/um/ptproxy/Makefile                  |   10 
 arch/um/ptproxy/proxy.c                   |  370 ---------------------
 arch/um/ptproxy/ptproxy.h                 |   61 ---
 arch/um/ptproxy/ptrace.c                  |  238 -------------
 arch/um/ptproxy/sysdep.c                  |   71 ----
 arch/um/ptproxy/sysdep.h                  |   25 -
 arch/um/ptproxy/wait.c                    |   86 -----
 arch/um/ptproxy/wait.h                    |   15 
 arch/um/sys-i386/Makefile                 |   36 --
 arch/um/sys-i386/checksum.S               |  460 ++++++++++++++++++++++++++
 arch/um/sys-i386/ksyms.c                  |    3 
 arch/um/sys-i386/ldt.c                    |   69 +++-
 arch/um/sys-i386/ptrace.c                 |   57 ++-
 arch/um/sys-i386/ptrace_user.c            |    2 
 arch/um/sys-i386/sigcontext.c             |   39 --
 arch/um/sys-i386/util/mk_thread_kern.c    |   16 
 arch/um/sys-i386/util/mk_thread_user.c    |   32 +
 arch/um/uml.lds.S                         |    1 
 arch/um/util/Makefile                     |   11 
 arch/um/util/mk_constants_kern.c          |   24 +
 arch/um/util/mk_constants_user.c          |   28 +
 include/asm-um/a.out.h                    |    8 
 include/asm-um/checksum.h                 |    2 
 include/asm-um/mmu.h                      |   18 -
 include/asm-um/mmu_context.h              |   51 ++
 include/asm-um/page.h                     |    2 
 include/asm-um/processor-generic.h        |   39 +-
 include/asm-um/ptrace-generic.h           |    2 
 include/asm-um/uaccess.h                  |  100 -----
 163 files changed, 8121 insertions(+), 3588 deletions(-)

ChangeSet@1.865.24.3, 2002-12-17 02:55:00-05:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/skas-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/skas-2.5

ChangeSet@1.865.25.1, 2002-12-17 02:34:29-05:00, jdike@jdike.wstearns.org
  Merge

ChangeSet@1.865.24.2, 2002-12-17 02:21:56-05:00, jdike@uml.karaya.com
  Removed includes of Rules.mk.

ChangeSet@1.865.24.1, 2002-12-17 01:06:44-05:00, jdike@uml.karaya.com
  Merged the 2.5.52 Makefile changes.

ChangeSet@1.797.203.3, 2002-12-06 21:30:55-05:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/skas-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/skas-2.5

ChangeSet@1.797.203.2, 2002-12-06 21:25:54-05:00, jdike@uml.karaya.com
  Added a couple of includes as part of the 2.5.50 update.

ChangeSet@1.797.204.1, 2002-12-06 19:04:22-05:00, jdike@jdike.wstearns.org
  Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  into jdike.wstearns.org:/home/jdike/linux/skas-2.5

ChangeSet@1.797.203.1, 2002-12-06 18:14:59-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/skas-2.5

ChangeSet@1.797.139.7, 2002-11-25 22:07:47-05:00, jdike@uml.karaya.com
  Fixed a stupid compile bug.

ChangeSet@1.797.139.6, 2002-11-25 21:03:24-05:00, jdike@uml.karaya.com
  Small fixes to sync up the 2.4 and 2.5 pools.
  Also fixed a stupid signal handling bug.

ChangeSet@1.797.139.5, 2002-11-25 13:41:02-05:00, jdike@uml.karaya.com
  A whole lot of small changes to sync up the 2.4 and 2.5 pools
  somewhat.  Mostly whitespace changes, plus some code movement.
  Also added checksum.S to the repository, which I had somehow
  missed before.

ChangeSet@1.797.139.3, 2002-11-23 21:37:53-05:00, jdike@uml.karaya.com
  Merge

ChangeSet@1.797.139.2, 2002-11-23 19:25:48-05:00, jdike@uml.karaya.com
  Updated to 2.5.49, which involved fixing the calls to do_fork.

ChangeSet@1.797.72.14, 2002-11-23 16:49:59-05:00, jdike@uml.karaya.com
  Finished the skas merge by eliminating a syntax error, fixing the
  new compilation warnings, and fixing a call to handle_page_fault.

ChangeSet@1.797.72.13, 2002-11-22 21:47:15-05:00, jdike@uml.karaya.com
  Merged the rest of the skas changes.

ChangeSet@1.797.72.12, 2002-11-22 21:22:57-05:00, jdike@uml.karaya.com
  Fixed various build problems with the tlb.c merge.

ChangeSet@1.797.72.11, 2002-11-22 20:39:33-05:00, jdike@uml.karaya.com
  Merged the tlb.c changes from the skas patch.

ChangeSet@1.797.72.10, 2002-11-22 14:27:24-05:00, jdike@uml.karaya.com
  Minor build fixes to the last batch of skas merges.

ChangeSet@1.797.72.9, 2002-11-22 12:53:13-05:00, jdike@uml.karaya.com
  Merged a number of small skas changes.

ChangeSet@1.797.72.8, 2002-11-21 23:22:43-05:00, jdike@uml.karaya.com
  Some small build fixes to the IP checksum merge.

ChangeSet@1.797.71.4, 2002-11-21 23:21:41-05:00, jdike@uml.karaya.com
  Removed the checksum.S symlink from arch/um/sys-i386/Makefile.

ChangeSet@1.797.72.7, 2002-11-21 22:30:24-05:00, jdike@uml.karaya.com
  Merged the IP checksum changes from the skas code.

ChangeSet@1.797.72.6, 2002-11-21 22:26:06-05:00, jdike@uml.karaya.com
  Some minor build and compilation fixes to the copy_sc merge.

ChangeSet@1.797.72.5, 2002-11-21 22:00:31-05:00, jdike@uml.karaya.com
  Applied the sigcontext changes in the skas code.

ChangeSet@1.797.72.4, 2002-11-21 21:38:56-05:00, jdike@uml.karaya.com
  A number of small fixes for the uaccess merge.

ChangeSet@1.797.72.3, 2002-11-21 18:54:16-05:00, jdike@uml.karaya.com
  Added the uaccess changes from the skas merge.

ChangeSet@1.797.72.2, 2002-11-21 17:16:25-05:00, jdike@uml.karaya.com
  Resolved the conflict between the skas and get_config changes in
  line.h.

ChangeSet@1.797.80.17, 2002-11-21 14:59:43-05:00, jdike@uml.karaya.com
  Added skas/mem_user.c and tt/gdb.c

ChangeSet@1.797.80.16, 2002-11-21 14:48:11-05:00, jdike@uml.karaya.com
  Added a bunch of C files under arch/um/kernel/skas and 
  arch/um/kernel/tt.

ChangeSet@1.797.80.15, 2002-11-21 14:31:45-05:00, jdike@uml.karaya.com
  Added a batch of files under arch/um/kernel/skas.

ChangeSet@1.797.80.14, 2002-11-21 14:09:26-05:00, jdike@uml.karaya.com
  Added arch/um/include/mode_kern.h

ChangeSet@1.797.71.3, 2002-11-21 14:05:13-05:00, jdike@uml.karaya.com
  Changed the config to pull in zlib.

ChangeSet@1.797.80.13, 2002-11-21 13:23:40-05:00, jdike@uml.karaya.com
  Added the mode mmu.h and mode.h headers.

ChangeSet@1.797.80.12, 2002-11-21 13:15:09-05:00, jdike@uml.karaya.com
  Added mode.h, mk_constants_kern.c, mk_constants_user.c, and um_mmu.h

ChangeSet@1.797.80.11, 2002-11-21 12:58:41-05:00, jdike@uml.karaya.com
  Added ptrace-skas.h and ptrace-tt.h.

ChangeSet@1.797.80.10, 2002-11-21 12:52:36-05:00, jdike@uml.karaya.com
  Added arch/um/kernel/skas/util/*, which I missed somehow.

ChangeSet@1.797.80.9, 2002-11-20 23:04:22-05:00, jdike@uml.karaya.com
  Merged most of the rest of the skas changes.

ChangeSet@1.797.80.8, 2002-11-19 14:54:08-05:00, jdike@uml.karaya.com
  Declared mode_tt in user_util.h.

ChangeSet@1.797.80.7, 2002-11-19 14:53:18-05:00, jdike@uml.karaya.com
  Merged the skas exec reorg.

ChangeSet@1.797.80.6, 2002-11-19 13:47:41-05:00, jdike@uml.karaya.com
  Fixed a couple of buglets in the signal frame merge.

ChangeSet@1.797.80.5, 2002-11-19 00:54:26-05:00, jdike@uml.karaya.com
  Merged the signal frame cleanups and fixes from 2.4.

ChangeSet@1.797.80.4, 2002-11-19 00:47:18-05:00, jdike@uml.karaya.com
  Fixes to the last merge.

ChangeSet@1.797.80.3, 2002-11-19 00:13:26-05:00, jdike@uml.karaya.com
  Merged the os_kill_process and the driver from_user changes from
  the 2.4 pool.
  Also merged some other cleanups.

ChangeSet@1.797.80.2, 2002-11-18 23:28:32-05:00, jdike@uml.karaya.com
  Fixed the Makefiles so that the ptproxy move from arch/um/ptproxy
  to arch/um/kernel/tt/ptproxy works.

ChangeSet@1.797.80.1, 2002-11-18 22:47:18-05:00, jdike@uml.karaya.com
  Moved the ptproxy code from arch/um/ptproxy to 
  arch/um/kernel/tt/ptproxy.

ChangeSet@1.797.71.2, 2002-11-18 20:03:13-05:00, jdike@uml.karaya.com
  A few more fixes to get 2.4.48 to boot.

ChangeSet@1.797.72.1, 2002-11-18 15:57:40-05:00, jdike@uml.karaya.com
  Merged the get_config changes from 2.4.

ChangeSet@1.797.71.1, 2002-11-18 15:57:00-05:00, jdike@uml.karaya.com
  Updated to 2.5.48


