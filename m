Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbSLDH1M>; Wed, 4 Dec 2002 02:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbSLDH1M>; Wed, 4 Dec 2002 02:27:12 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:32392 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266257AbSLDH0Z>;
	Wed, 4 Dec 2002 02:26:25 -0500
Date: Wed, 4 Dec 2002 18:33:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, anton@samba.org, davem@redhat.com, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
Message-Id: <20021204183313.4282f40e.sfr@canb.auug.org.au>
In-Reply-To: <20021204180224.406d143c.sfr@canb.auug.org.au>
References: <20021204180224.406d143c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2002 18:02:24 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Below is the generic part of the start of the compatibility syscall layer.
> I think I have made it generic enough that each architecture can define
> what compatibility means.

Across all the arhitectures, the diffstat of the patch so far looks
like this:

 arch/ia64/Kconfig                  |    5 
 arch/ia64/ia32/ia32_entry.S        |    8 -
 arch/ia64/ia32/ia32_signal.c       |    5 
 arch/ia64/ia32/sys_ia32.c          |  186 ++++----------------------
 arch/mips64/Kconfig                |    5 
 arch/mips64/kernel/ioctl32.c       |    8 -
 arch/mips64/kernel/linux32.c       |  168 ++---------------------
 arch/mips64/kernel/scall_o32.S     |    8 -
 arch/mips64/kernel/signal32.c      |    3 
 arch/parisc/Kconfig                |    5 
 arch/parisc/kernel/binfmt_elf32.c  |   10 -
 arch/parisc/kernel/ioctl32.c       |    7 
 arch/parisc/kernel/signal32.c      |    3 
 arch/parisc/kernel/sys32.h         |    5 
 arch/parisc/kernel/sys_parisc32.c  |  195 +++++----------------------
 arch/ppc64/Kconfig                 |    4 
 arch/ppc64/kernel/binfmt_elf32.c   |   18 --
 arch/ppc64/kernel/ioctl32.c        |   12 -
 arch/ppc64/kernel/misc.S           |    8 -
 arch/ppc64/kernel/signal32.c       |   11 -
 arch/ppc64/kernel/sys32.S          |    4 
 arch/ppc64/kernel/sys_ppc32.c      |  262 ++++++++-----------------------------
 arch/s390x/Kconfig                 |    5 
 arch/s390x/kernel/binfmt_elf32.c   |   14 -
 arch/s390x/kernel/entry.S          |    8 -
 arch/s390x/kernel/ioctl32.c        |    5 
 arch/s390x/kernel/linux32.c        |  240 ++++++++-------------------------
 arch/s390x/kernel/linux32.h        |    6 
 arch/s390x/kernel/wrapper32.S      |   34 ++--
 arch/sparc64/Kconfig               |    5 
 arch/sparc64/kernel/binfmt_elf32.c |   18 --
 arch/sparc64/kernel/ioctl32.c      |   12 -
 arch/sparc64/kernel/signal32.c     |    3 
 arch/sparc64/kernel/sys32.S        |    4 
 arch/sparc64/kernel/sys_sparc32.c  |  225 +++++++------------------------
 arch/sparc64/kernel/sys_sunos32.c  |   20 +-
 arch/sparc64/kernel/systbls.S      |   12 -
 arch/sparc64/solaris/misc.c        |    7 
 arch/sparc64/solaris/socket.c      |    5 
 arch/x86_64/Kconfig                |    5 
 arch/x86_64/ia32/ia32_binfmt.c     |   14 -
 arch/x86_64/ia32/ia32_ioctl.c      |   12 -
 arch/x86_64/ia32/ia32entry.S       |    8 -
 arch/x86_64/ia32/ipc32.c           |   35 ++--
 arch/x86_64/ia32/socket32.c        |    9 -
 arch/x86_64/ia32/sys_ia32.c        |  214 ++----------------------------
 fs/open.c                          |   18 +-
 include/asm-ia64/compat.h          |   19 ++
 include/asm-ia64/ia32.h            |    8 -
 include/asm-mips64/compat.h        |   18 ++
 include/asm-mips64/posix_types.h   |    3 
 include/asm-mips64/stat.h          |    7 
 include/asm-parisc/compat.h        |   18 ++
 include/asm-parisc/posix_types.h   |    3 
 include/asm-ppc64/compat.h         |   18 ++
 include/asm-ppc64/ppc32.h          |   12 -
 include/asm-s390x/compat.h         |   18 ++
 include/asm-sparc64/compat.h       |   18 ++
 include/asm-sparc64/posix_types.h  |    3 
 include/asm-sparc64/signal.h       |    3 
 include/asm-sparc64/stat.h         |    7 
 include/asm-x86_64/compat.h        |   18 ++
 include/asm-x86_64/ia32.h          |    3 
 include/asm-x86_64/socket32.h      |    8 -
 include/linux/compat.h             |   29 ++++
 include/linux/time.h               |    2 
 kernel/Makefile                    |    1 
 kernel/compat.c                    |  114 ++++++++++++++++
 kernel/timer.c                     |   32 ++--
 69 files changed, 777 insertions(+), 1463 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
