Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbTBFDKX>; Wed, 5 Feb 2003 22:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbTBFDKW>; Wed, 5 Feb 2003 22:10:22 -0500
Received: from mnh-1-13.mv.com ([207.22.10.45]:1541 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265275AbTBFDJ3>;
	Wed, 5 Feb 2003 22:09:29 -0500
Message-Id: <200302060313.WAA04466@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Feb 2003 22:13:14 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/fixes-2.5

This fixes a number of UML bugs, including
	changed CONFIG_* usage in userspace files to avoid conflicting with
the host's autoconf.h
	fixed the time locking bug which was causing hangs under network load
	the mconsole and uml_switch protocols are now 64-bit clean
	some SMP fixes from Oleg Drokin
	mmap return values are checked correctly
	SA_SIGINFO signals are now delivered correctly
	skas mode now is protected against a tmpfs mount running out of space
	the UML main thread should no longer run kernel code
	fixed a couple of data corruption bugs

There are also a number of cleanups:
	the common portions of the linker scripts are now in a separate file,
included by both main scripts
	the Kconfig was extended and some missing includes added
	all initializers have been converted to C99
	dead code removal
	improved error messages
	more movement of mode-specific code to arch/um/kernel/{tt,skas}

				Jeff

 arch/um/Kconfig                           |   73 +++++++------
 arch/um/Makefile                          |   99 +++++++++++------
 arch/um/Makefile-skas                     |   20 +++
 arch/um/Makefile-tt                       |    7 +
 arch/um/defconfig                         |  128 +++++++++++-----------
 arch/um/drivers/chan_kern.c               |   36 +++---
 arch/um/drivers/chan_user.c               |    6 -
 arch/um/drivers/daemon_kern.c             |   42 +++----
 arch/um/drivers/daemon_user.c             |   21 +--
 arch/um/drivers/fd.c                      |   24 ++--
 arch/um/drivers/harddog_kern.c            |   16 +-
 arch/um/drivers/hostaudio_kern.c          |   28 ++---
 arch/um/drivers/line.c                    |   27 +++-
 arch/um/drivers/mcast_kern.c              |   38 +++---
 arch/um/drivers/mcast_user.c              |   16 +-
 arch/um/drivers/mconsole_kern.c           |   10 -
 arch/um/drivers/mmapper_kern.c            |   14 +-
 arch/um/drivers/net_kern.c                |   47 ++++----
 arch/um/drivers/null.c                    |   20 +--
 arch/um/drivers/pcap_kern.c               |   42 +++----
 arch/um/drivers/pcap_user.c               |   20 +--
 arch/um/drivers/port_kern.c               |  115 +++++++++++---------
 arch/um/drivers/port_user.c               |   65 ++++++-----
 arch/um/drivers/pty.c                     |   67 ++++--------
 arch/um/drivers/slip_kern.c               |   42 +++----
 arch/um/drivers/slip_user.c               |   16 +-
 arch/um/drivers/slirp_kern.c              |   38 +++---
 arch/um/drivers/slirp_user.c              |   16 +-
 arch/um/drivers/ssl.c                     |   74 ++++++-------
 arch/um/drivers/stdio_console.c           |   94 ++++++++--------
 arch/um/drivers/tty.c                     |   24 ++--
 arch/um/drivers/ubd_kern.c                |   17 +--
 arch/um/drivers/xterm.c                   |   44 ++++---
 arch/um/drivers/xterm_kern.c              |   14 +-
 arch/um/dyn.lds.S                         |  167 ++++++++++++++++++++++++++++++
 arch/um/include/choose-mode.h             |    6 -
 arch/um/include/frame.h                   |    4 
 arch/um/include/irq_user.h                |    2 
 arch/um/include/kern_util.h               |   10 -
 arch/um/include/mconsole.h                |   23 ++--
 arch/um/include/mode.h                    |    4 
 arch/um/include/os.h                      |   14 +-
 arch/um/include/signal_kern.h             |    6 -
 arch/um/include/skas_ptrace.h             |   36 ++++++
 arch/um/include/sysdep-i386/frame.h       |    3 
 arch/um/include/sysdep-i386/frame_kern.h  |   11 +
 arch/um/include/sysdep-i386/frame_user.h  |   23 ++--
 arch/um/include/sysdep-i386/ptrace.h      |  127 +++++++++++++---------
 arch/um/include/sysdep-i386/sigcontext.h  |   28 -----
 arch/um/include/sysdep-i386/syscalls.h    |    4 
 arch/um/include/time_user.h               |    4 
 arch/um/include/umid.h                    |    5 
 arch/um/include/uml_uaccess.h             |   28 +++++
 arch/um/include/user_util.h               |    5 
 arch/um/kernel/Makefile                   |   20 ---
 arch/um/kernel/frame.c                    |   23 +++-
 arch/um/kernel/frame_kern.c               |   49 +++++---
 arch/um/kernel/irq.c                      |    2 
 arch/um/kernel/irq_user.c                 |   30 ++---
 arch/um/kernel/ksyms.c                    |    5 
 arch/um/kernel/mem.c                      |   65 +++++++----
 arch/um/kernel/process_kern.c             |    4 
 arch/um/kernel/ptrace.c                   |    2 
 arch/um/kernel/sigio_user.c               |   41 +++----
 arch/um/kernel/signal_kern.c              |   36 ++----
 arch/um/kernel/skas/include/mode.h        |    7 -
 arch/um/kernel/skas/include/mode_kern.h   |    5 
 arch/um/kernel/skas/include/ptrace-skas.h |    2 
 arch/um/kernel/skas/include/skas.h        |   10 -
 arch/um/kernel/skas/include/skas_ptrace.h |   36 ------
 arch/um/kernel/skas/include/uaccess.h     |    3 
 arch/um/kernel/skas/mem.c                 |    5 
 arch/um/kernel/skas/mem_user.c            |    6 -
 arch/um/kernel/skas/process.c             |   41 ++++---
 arch/um/kernel/skas/process_kern.c        |   25 ++--
 arch/um/kernel/skas/sys-i386/sigcontext.c |   83 +++++++-------
 arch/um/kernel/skas/syscall_kern.c        |    2 
 arch/um/kernel/skas/syscall_user.c        |    5 
 arch/um/kernel/skas/tlb.c                 |   14 +-
 arch/um/kernel/skas/trap_user.c           |   27 ++--
 arch/um/kernel/sys_call_table.c           |    2 
 arch/um/kernel/tempfile.c                 |   23 +---
 arch/um/kernel/time.c                     |   13 +-
 arch/um/kernel/time_kern.c                |   18 +--
 arch/um/kernel/tlb.c                      |    6 +
 arch/um/kernel/trap_kern.c                |   10 +
 arch/um/kernel/trap_user.c                |   46 ++++----
 arch/um/kernel/tt/Makefile                |   17 ++-
 arch/um/kernel/tt/gdb.c                   |   18 +--
 arch/um/kernel/tt/gdb_kern.c              |    6 -
 arch/um/kernel/tt/include/mode.h          |    7 -
 arch/um/kernel/tt/include/mode_kern.h     |    2 
 arch/um/kernel/tt/include/ptrace-tt.h     |    2 
 arch/um/kernel/tt/include/tt.h            |    3 
 arch/um/kernel/tt/include/uaccess.h       |    4 
 arch/um/kernel/tt/mem.c                   |   26 ----
 arch/um/kernel/tt/mem_user.c              |   50 ++++++++
 arch/um/kernel/tt/process_kern.c          |   19 +--
 arch/um/kernel/tt/ptproxy/proxy.c         |   16 +-
 arch/um/kernel/tt/sys-i386/sigcontext.c   |    5 
 arch/um/kernel/tt/syscall_kern.c          |   17 +--
 arch/um/kernel/tt/syscall_user.c          |   11 -
 arch/um/kernel/tt/tlb.c                   |    2 
 arch/um/kernel/tt/trap_user.c             |   15 +-
 arch/um/kernel/tt/uaccess_user.c          |   42 -------
 arch/um/kernel/tt/unmap.c                 |   34 ++++++
 arch/um/kernel/uaccess_user.c             |   64 +++++++++++
 arch/um/kernel/um_arch.c                  |   19 ++-
 arch/um/kernel/umid.c                     |   16 +-
 arch/um/kernel/unmap.c                    |   34 ------
 arch/um/kernel/user_syms.c                |    9 -
 arch/um/kernel/user_util.c                |   25 ----
 arch/um/os-Linux/drivers/ethertap_kern.c  |   34 +++---
 arch/um/os-Linux/drivers/ethertap_user.c  |   16 +-
 arch/um/os-Linux/drivers/tuntap_kern.c    |   36 +++---
 arch/um/os-Linux/drivers/tuntap_user.c    |   16 +-
 arch/um/os-Linux/file.c                   |   21 ++-
 arch/um/os-Linux/process.c                |    2 
 arch/um/sys-i386/Makefile                 |    6 -
 arch/um/sys-i386/bugs.c                   |    2 
 arch/um/sys-i386/extable.c                |   30 +++++
 arch/um/sys-i386/fault.c                  |    2 
 arch/um/sys-i386/sigcontext.c             |    2 
 arch/um/sys-i386/util/mk_thread_kern.c    |    3 
 arch/um/uml.lds.S                         |   78 +-------------
 arch/um/util/mk_task_kern.c               |    2 
 include/asm-um/archparam-i386.h           |    2 
 include/asm-um/bug.h                      |   18 +++
 include/asm-um/common.lds.S               |   86 +++++++++++++++
 include/asm-um/page.h                     |   17 ---
 include/asm-um/pgtable.h                  |    3 
 include/asm-um/processor-i386.h           |    4 
 include/asm-um/ptrace-generic.h           |    5 
 include/asm-um/ptrace-i386.h              |    3 
 include/asm-um/ucontext.h                 |    6 +
 135 files changed, 1943 insertions(+), 1450 deletions(-)

ChangeSet@1.961, 2003-02-05 11:34:40-05:00, jdike@uml.karaya.com
  Merge

ChangeSet@1.956.1.7, 2003-02-05 10:24:48-05:00, jdike@uml.karaya.com
  Merged a conflict in ptrace.h.

ChangeSet@1.956.2.6, 2003-01-18 22:12:47-05:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/cleanup-2.5/
  into uml.karaya.com:/home/jdike/linux/2.5/cleanup-2.5

ChangeSet@1.960, 2003-01-18 21:50:59-05:00, jdike@uml.karaya.com
  Merge

ChangeSet@1.956.5.1, 2003-01-18 21:48:19-05:00, jdike@jdike.wstearns.org
  Fixed a conflict in the linker script.

ChangeSet@1.956.4.1, 2003-01-18 21:22:25-05:00, jdike@jdike.wstearns.org
  Fixed a conflict in the linker script.

ChangeSet@1.956.1.5, 2003-01-18 20:23:13-05:00, jdike@uml.karaya.com
  Changed some CONFIG_* symbols to UML_CONFIG_*.

ChangeSet@1.956.2.5, 2003-01-18 18:37:47-05:00, jdike@uml.karaya.com
  Replaced some CONFIG_* with UML_CONFIG_*.

ChangeSet@1.956.1.4, 2003-01-18 15:29:34-05:00, jdike@uml.karaya.com
  Fixed the time locking bug.
  The mconsole and switch protocols are now 64-bit clean.
  Fixed some smaller bugs.

ChangeSet@1.956.2.4, 2003-01-18 15:26:27-05:00, jdike@uml.karaya.com
  A bunch of minor changes ported up from 2.4.
  All userspace uses of CONFIG_* have been changed to UML_CONFIG_*
  to avoid conflicts with the host's config.
  os_open_file now has FD_CLOEXEC support.

ChangeSet@1.956.1.3, 2003-01-18 13:07:38-05:00, jdike@uml.karaya.com
  Ported a uml-config.h change from 2.4.

ChangeSet@1.956.2.3, 2003-01-18 13:06:39-05:00, jdike@uml.karaya.com
  Ported a cleanup from 2.4.

ChangeSet@1.959, 2003-01-17 22:32:31-05:00, jdike@uml.karaya.com
  Fixed dyn.lds.S to include common.lds.S.

ChangeSet@1.956.1.2, 2003-01-17 22:20:49-05:00, jdike@uml.karaya.com
  Some SMP fixes from Oleg.

ChangeSet@1.956.2.2, 2003-01-17 22:20:03-05:00, jdike@uml.karaya.com
  Correctly check the mmap return value.

ChangeSet@1.958, 2003-01-17 22:19:22-05:00, jdike@uml.karaya.com
  Some build changes for 2.5.59 and SMP.  Also cleanup of the linker
  scripts and Kconfig.

ChangeSet@1.956.2.1, 2003-01-17 12:02:05-05:00, jdike@uml.karaya.com
  Merged the vmlinux.lds.h changes.

ChangeSet@1.957, 2003-01-17 11:59:08-05:00, jdike@uml.karaya.com
  Merged the vmlinux.lds.h changes.

ChangeSet@1.914.12.2, 2003-01-16 16:52:16-05:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/fixes-2.5/
  into uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5

ChangeSet@1.914.10.5, 2003-01-16 16:31:28-05:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/cleanup-2.5/
  into uml.karaya.com:/home/jdike/linux/2.5/cleanup-2.5

ChangeSet@1.914.22.1, 2003-01-16 16:26:38-05:00, jdike@jdike.wstearns.org
  Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  into jdike.wstearns.org:/home/jdike/linux/fixes-2.5

ChangeSet@1.914.21.1, 2003-01-16 16:08:34-05:00, jdike@jdike.wstearns.org
  Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  into jdike.wstearns.org:/home/jdike/linux/cleanup-2.5

ChangeSet@1.914.19.1, 2003-01-16 15:35:43-05:00, jdike@uml.karaya.com
  Fixed a merge typo in Kconfig.

ChangeSet@1.914.10.4, 2003-01-16 15:26:33-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/build-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/cleanup-2.5

ChangeSet@1.914.11.2, 2003-01-16 15:21:14-05:00, jdike@uml.karaya.com
  Merge

ChangeSet@1.914.10.3, 2003-01-16 15:10:38-05:00, jdike@uml.karaya.com
  Fixed a conflict in Kconfig between Oleg's updates and the 
  existing changes.

ChangeSet@1.914.10.2, 2003-01-16 10:45:16-05:00, jdike@uml.karaya.com
  Added gpl_ksymtab and kallsyms sections to the linker scripts.

ChangeSet@1.914.18.1, 2003-01-16 10:44:25-05:00, jdike@uml.karaya.com
  Updates to bring UML up to 2.5.58.

ChangeSet@1.914.12.1, 2003-01-15 21:57:53-05:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/fixes-2.5/
  into uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5

ChangeSet@1.914.11.1, 2003-01-15 21:54:48-05:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/cleanup-2.5/
  into uml.karaya.com:/home/jdike/linux/2.5/cleanup-2.5

ChangeSet@1.838.129.1, 2002-12-29 21:37:02-05:00, jdike@uml.karaya.com
  Merge

ChangeSet@1.838.128.1, 2002-12-29 21:35:59-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5-linus

ChangeSet@1.838.127.1, 2002-12-29 21:28:59-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/build-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/build-2.5-linus

ChangeSet@1.838.126.2, 2002-12-29 20:37:16-05:00, jdike@uml.karaya.com
  Fixed a few problems in the last merge.

ChangeSet@1.838.126.1, 2002-12-29 20:05:55-05:00, jdike@uml.karaya.com
  Forward ported a number of bug fixes from 2.4, including SA_SIGINFO
  signal delivery, protecting skas mode against tmpfs running out of
  space, protecting the UML main thread against accidentally running
  kernel code, and a couple of data corruption bugs.

ChangeSet@1.838.118.6, 2002-12-29 18:46:34-05:00, jdike@uml.karaya.com
  Merged in the C99 initializer changes.

ChangeSet@1.838.124.1, 2002-12-29 18:31:34-05:00, jdike@uml.karaya.com
  Forward ported a bunch of cleanups from 2.4.  Improved error messages,
  slightly different formatting, removal of dead code, and some stray
  C99 initializer conversions.

ChangeSet@1.838.122.6, 2002-12-29 15:27:19-05:00, jdike@uml.karaya.com
  Fixed the archmrproper rule to not delete linker script sources.

ChangeSet@1.838.122.5, 2002-12-29 15:21:40-05:00, jdike@uml.karaya.com
  Fixed handling of the linker script.

ChangeSet@1.838.122.4, 2002-12-29 15:05:58-05:00, jdike@uml.karaya.com
  Pulled in a number of other fixes which were needed to bring the
  build up to date.

ChangeSet@1.838.122.3, 2002-12-29 12:10:51-05:00, jdike@uml.karaya.com
  Moved the segment remapping code under arch/um/kernel/tt.

ChangeSet@1.838.122.2, 2002-12-28 22:35:25-05:00, jdike@uml.karaya.com
  Moved skas_ptrace.h.

ChangeSet@1.838.122.1, 2002-12-28 22:06:40-05:00, jdike@uml.karaya.com
  Merged the 2.4 build changes which split the mode-specific stuff
  into separate Makefiles and add the ability to build a dynamically
  loaded binary.

ChangeSet@1.838.118.5, 2002-12-28 21:27:46-05:00, jdike@uml.karaya.com
  Missed an initializer in the ethertap backend.

ChangeSet@1.838.118.4, 2002-12-28 21:20:41-05:00, jdike@uml.karaya.com
  Converted a bunch of inititializers in the drivers that I missed.

ChangeSet@1.838.118.3, 2002-12-28 19:48:40-05:00, jdike@uml.karaya.com
  Converted a few more initializers I missed on the first pass.

ChangeSet@1.838.118.2, 2002-12-28 15:28:07-05:00, jdike@uml.karaya.com
  Converted all initializers over to C99 syntax.

ChangeSet@1.838.118.1, 2002-12-28 11:50:51-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/doc-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

ChangeSet@1.838.117.4, 2002-12-28 11:42:00-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/updates-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

ChangeSet@1.838.117.3, 2002-12-28 11:32:32-05:00, jdike@uml.karaya.com
  Fixed a merge conflict in port_kern.c

ChangeSet@1.838.117.1, 2002-12-28 11:12:47-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/mconfig-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

