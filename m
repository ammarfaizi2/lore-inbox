Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267143AbSLaDrK>; Mon, 30 Dec 2002 22:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267146AbSLaDrK>; Mon, 30 Dec 2002 22:47:10 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:1799 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267143AbSLaDrI>;
	Mon, 30 Dec 2002 22:47:08 -0500
Message-Id: <200212310349.WAA04750@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML bug fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Dec 2002 22:49:51 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull either
	http://uml.bkbits.net/fixes-2.5
or	http://jdike.stearns.org:5000/fixes-2.5

This patch fixes a bunch of UML bugs -
	crashes caused by excessive stack usage, plus assiciated cleanups
	SA_SIGINFO signal delivery is fixed, making JVMs run a lot better
	skas mode now has protection against tmpfs filling up
	the initial UML thread is protected against running kernel code
	a couple of data corruption bugs are fixed

				Jeff

 arch/um/drivers/port_kern.c               |   11 +-
 arch/um/include/frame.h                   |    4 
 arch/um/include/irq_user.h                |    2 
 arch/um/include/kern_util.h               |   10 +-
 arch/um/include/sysdep-i386/frame.h       |    3 
 arch/um/include/sysdep-i386/frame_kern.h  |   11 ++
 arch/um/include/sysdep-i386/frame_user.h  |   23 +++--
 arch/um/include/sysdep-i386/ptrace.h      |  123 ++++++++++++++++++------------
 arch/um/include/sysdep-i386/sigcontext.h  |   28 ------
 arch/um/include/sysdep-i386/syscalls.h    |    4 
 arch/um/include/uml_uaccess.h             |   28 ++++++
 arch/um/include/user_util.h               |    4 
 arch/um/kernel/Makefile                   |    9 --
 arch/um/kernel/frame.c                    |   20 +++-
 arch/um/kernel/frame_kern.c               |   49 ++++++++---
 arch/um/kernel/irq.c                      |    2 
 arch/um/kernel/irq_user.c                 |    2 
 arch/um/kernel/mem.c                      |   25 +++++-
 arch/um/kernel/process_kern.c             |    4 
 arch/um/kernel/signal_kern.c              |   24 +++--
 arch/um/kernel/skas/include/mode.h        |    7 -
 arch/um/kernel/skas/include/mode_kern.h   |    3 
 arch/um/kernel/skas/include/skas.h        |   10 +-
 arch/um/kernel/skas/mem.c                 |    5 -
 arch/um/kernel/skas/process.c             |   37 +++++----
 arch/um/kernel/skas/process_kern.c        |   25 ++----
 arch/um/kernel/skas/sys-i386/sigcontext.c |   83 ++++++++++----------
 arch/um/kernel/skas/syscall_kern.c        |    2 
 arch/um/kernel/skas/syscall_user.c        |    5 -
 arch/um/kernel/skas/tlb.c                 |    5 -
 arch/um/kernel/skas/trap_user.c           |   27 +++---
 arch/um/kernel/time_kern.c                |    8 +
 arch/um/kernel/trap_kern.c                |    7 -
 arch/um/kernel/trap_user.c                |   46 +++++------
 arch/um/kernel/tt/gdb.c                   |    6 -
 arch/um/kernel/tt/include/mode.h          |    7 -
 arch/um/kernel/tt/include/mode_kern.h     |    1 
 arch/um/kernel/tt/include/tt.h            |    3 
 arch/um/kernel/tt/include/uaccess.h       |    4 
 arch/um/kernel/tt/mem.c                   |   26 ------
 arch/um/kernel/tt/process_kern.c          |   17 ++--
 arch/um/kernel/tt/sys-i386/sigcontext.c   |    5 -
 arch/um/kernel/tt/syscall_kern.c          |   17 ++--
 arch/um/kernel/tt/syscall_user.c          |   11 +-
 arch/um/kernel/tt/trap_user.c             |   15 +--
 arch/um/kernel/tt/uaccess_user.c          |   42 ----------
 arch/um/kernel/uaccess_user.c             |   64 +++++++++++++++
 arch/um/kernel/user_syms.c                |    5 -
 arch/um/sys-i386/bugs.c                   |    2 
 arch/um/sys-i386/sigcontext.c             |    2 
 arch/um/util/mk_task_kern.c               |    2 
 include/asm-um/archparam-i386.h           |    2 
 include/asm-um/ptrace-generic.h           |    5 -
 include/asm-um/ptrace-i386.h              |    3 
 include/asm-um/ucontext.h                 |    6 +
 55 files changed, 507 insertions(+), 394 deletions(-)

ChangeSet@1.988, 2002-12-29 21:35:59-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5-linus

ChangeSet@1.951.9.3, 2002-12-29 20:37:16-05:00, jdike@uml.karaya.com
  Fixed a few problems in the last merge.

ChangeSet@1.951.9.2, 2002-12-29 20:05:55-05:00, jdike@uml.karaya.com
  Forward ported a number of bug fixes from 2.4, including SA_SIGINFO
  signal delivery, protecting skas mode against tmpfs running out of
  space, protecting the UML main thread against accidentally running
  kernel code, and a couple of data corruption bugs.

ChangeSet@1.951.9.1, 2002-12-28 11:50:51-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/doc-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

ChangeSet@1.951.8.4, 2002-12-28 11:42:00-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/updates-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

ChangeSet@1.951.8.3, 2002-12-28 11:32:32-05:00, jdike@uml.karaya.com
  Fixed a merge conflict in port_kern.c

ChangeSet@1.951.8.1, 2002-12-28 11:12:47-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/mconfig-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

