Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266031AbUGBBbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266031AbUGBBbz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 21:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUGBBbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 21:31:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:43658 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266114AbUGBBbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 21:31:36 -0400
Date: Thu, 1 Jul 2004 18:29:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: karim@opersys.com
Cc: peterm@redhat.com, faith@redhat.com, davidm@hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       ray.lanza@hp.com, trz@us.ibm.com, richardj_moore@uk.ibm.com,
       bob@watson.ibm.com, michel.dagenais@polymtl.ca
Subject: Re: [PATCH] IA64 audit support
Message-Id: <20040701182954.43351d36.akpm@osdl.org>
In-Reply-To: <40E4B20F.8010503@opersys.com>
References: <200406301556.i5UFuGg8009251@redrum.boston.redhat.com>
	<20040701124644.5e301ca0.akpm@osdl.org>
	<40E4B20F.8010503@opersys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour <karim@opersys.com> wrote:
>
> 
> Here's what I was trying to say:
> 
> Andrew Morton wrote:
> > It's nice and simple.
> 
> I, and quite a few other folks, have been trying to get the Linux Trace Toolkit
> in the kernel for the past 5 years and the code being added is almost identical
> to what the audit patch adds, yet we've always got reponses such "this is
> bloated" and Linus told us that he didn't see the use of this kind of stuff.

The auditing framework was quite unintrusive:

 arch/i386/kernel/entry.S         |    6 
 arch/i386/kernel/ptrace.c        |   10 
 arch/ppc64/kernel/entry.S        |   15 
 arch/ppc64/kernel/ptrace.c       |   29 +
 arch/x86_64/ia32/ia32entry.S     |   18 
 arch/x86_64/kernel/entry.S       |   21 
 arch/x86_64/kernel/ptrace.c      |   30 +
 fs/namei.c                       |   15 
 include/asm-i386/thread_info.h   |    6 
 include/asm-ppc64/thread_info.h  |    3 
 include/asm-x86_64/thread_info.h |    5 
 include/linux/audit.h            |  211 ++++++++
 include/linux/fs.h               |   14 
 include/linux/netlink.h          |    1 
 include/linux/sched.h            |    3 
 init/Kconfig                     |   20 
 kernel/Makefile                  |    2 
 kernel/audit.c                   |  825 ++++++++++++++++++++++++++++++++++
 kernel/auditsc.c                 |  922 +++++++++++++++++++++++++++++++++++++++
 kernel/fork.c                    |   10 
 security/selinux/avc.c           |  168 +++----
 security/selinux/include/avc.h   |    7 
 security/selinux/ss/services.c   |    2 
 23 files changed, 2199 insertions(+), 144 deletions(-)

It treads on fork.c and namei.c only, really.

Whereas LTT:

 Makefile                     |    1 
 arch/i386/config.in          |    2 
 arch/i386/kernel/entry.S     |   10 
 arch/i386/kernel/irq.c       |    6 
 arch/i386/kernel/process.c   |    6 
 arch/i386/kernel/sys_i386.c  |    4 
 arch/i386/kernel/traps.c     |  106 +++
 arch/i386/mm/fault.c         |   11 
 arch/mips/config.in          |    2 
 arch/mips/ddb5476/irq.c      |   10 
 arch/mips/kernel/irq.c       |   10 
 arch/mips/kernel/scall_o32.S |   38 +
 arch/mips/kernel/time.c      |    4 
 arch/mips/kernel/traps.c     |  131 +++-
 arch/mips/kernel/unaligned.c |   13 
 arch/mips/mm/fault.c         |   15 
 arch/ppc/config.in           |    2 
 arch/ppc/kernel/entry.S      |   38 +
 arch/ppc/kernel/irq.c        |    6 
 arch/ppc/kernel/misc.S       |    4 
 arch/ppc/kernel/process.c    |   15 
 arch/ppc/kernel/syscalls.c   |    4 
 arch/ppc/kernel/time.c       |    6 
 arch/ppc/kernel/traps.c      |   87 ++
 arch/ppc/mm/fault.c          |   16 
 arch/s390/config.in          |    2 
 arch/s390/kernel/entry.S     |   18 
 arch/s390/kernel/process.c   |    5 
 arch/s390/kernel/sys_s390.c  |    3 
 arch/s390/kernel/traps.c     |  118 +++
 arch/s390/mm/fault.c         |   12 
 arch/sh/config.in            |    3 
 arch/sh/kernel/entry.S       |   42 +
 arch/sh/kernel/irq.c         |   14 
 arch/sh/kernel/process.c     |   13 
 arch/sh/kernel/sys_sh.c      |    4 
 arch/sh/kernel/traps.c       |   88 ++
 arch/sh/lib/checksum.S       |    1 
 arch/sh/mm/fault.c           |   15 
 drivers/Makefile             |    1 
 drivers/input/mousedev.c     |    1 
 drivers/s390/s390io.c        |    3 
 drivers/s390/s390mach.c      |   12 
 drivers/trace/Config.help    |   36 +
 drivers/trace/Config.in      |    4 
 drivers/trace/Makefile       |   17 
 drivers/trace/tracer.c       | 1382 +++++++++++++++++++++++++++++++++++++++++++
 drivers/trace/tracer.h       |  275 ++++++++
 fs/buffer.c                  |    4 
 fs/exec.c                    |    7 
 fs/ioctl.c                   |    6 
 fs/open.c                    |   10 
 fs/read_write.c              |   44 +
 fs/select.c                  |   10 
 include/linux/trace.h        |  433 +++++++++++++
 ipc/msg.c                    |    3 
 ipc/sem.c                    |    2 
 ipc/shm.c                    |    3 
 kernel/Makefile              |    6 
 kernel/exit.c                |    6 
 kernel/fork.c                |    5 
 kernel/itimer.c              |    5 
 kernel/sched.c               |    6 
 kernel/signal.c              |    4 
 kernel/softirq.c             |   16 
 kernel/timer.c               |    4 
 kernel/trace.c               |  692 +++++++++++++++++++++
 mm/filemap.c                 |    4 
 mm/memory.c                  |    4 
 mm/page_alloc.c              |    6 
 mm/swap_state.c              |    5 
 net/core/dev.c               |    7 
 net/socket.c                 |   10 
 73 files changed, 3901 insertions(+), 17 deletions(-)

adds hooks all over the place.

The security code adds hooks everywhere too, but those deliver end-user
functionality rather than being purely a developer support tool.

Developer support tools are good, but are not as persuasive as end-user
features.  Because the audience is smaller, and developers know how to
apply patches and rebuild stuff.

> Have we simply not figured out the secret handshake?

It's a balance between (ongoing maintenance cost multiplied by the number of
impacted developers) versus (additional functionality multiplied by the
number of users who benefit from it).  To my mind, LTT (and kgdb and various
other developer-support things) don't offer good ratios here.

> I'd really like to have some advice here since I believe we have tried every
> trick in the book: posting the patches for review, asking kernel developers for
> input, porting the patches to multiple architectures, modulirizing the system,
> etc.

If it could use kprobes hooks that'd be neat.  kprobes is low-impact.
