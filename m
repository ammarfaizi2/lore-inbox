Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbTBSTgS>; Wed, 19 Feb 2003 14:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTBSTgS>; Wed, 19 Feb 2003 14:36:18 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:60177 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263760AbTBSTgD>;
	Wed, 19 Feb 2003 14:36:03 -0500
Date: Wed, 19 Feb 2003 11:39:07 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] klibc for 2.5.62
Message-ID: <20030219193907.GA17248@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Finally, here's the klibc addition against the latest 2.5.62 bk kernel
tree.  I'd like to thank Jeff Garzik, Peter Anvin, Russell King, and Kai
Germaschews for doing all of this work.  I've merely taken their code
tweaked a few things and placed it in a repository to pull from.  Thanks
also to Arnd Bergmann for finding a few nasty bugs by getting the s390
code to build and run properly.

Right now, klibc is built and a small sample program is added to the
initramfs image that is linked against klibc.  I've backed out Kai's
CONFIG_INITRAMFS and root filesystem mounting code, if you look at the
changesets below.  No new functionality is added to the kernel, yet :)

There might be a few problems when building on non-i386 platforms, but
I'm available (and so is Kai) to help fix up any problems found.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/klibc-2.5


Due to the size of some of these patches, I've placed them all at:
	kernel.org/pub/linux/kernel/people/gregkh/klibc/klibc-*2.5.62*

thanks,

greg k-h

 usr/lib/socketcommon.h                          |   25 
 usr/lib/syscommon.h                             |   29 
 Makefile                                        |   84 
 init/Kconfig                                    |   10 
 init/Makefile                                   |    7 
 init/do_mounts.c                                |    6 
 init/main.c                                     |   22 
 scripts/Makefile                                |    5 
 scripts/Makefile.build                          |    6 
 scripts/Makefile.clean                          |   11 
 scripts/Makefile.lib                            |    3 
 scripts/Makefile.user                           |  209 +
 usr/Makefile                                    |   54 
 usr/gen_init_cpio.c                             |   95 
 usr/lib/CAVEATS                                 |   51 
 usr/lib/MCONFIG                                 |   88 
 usr/lib/Makefile                                |  293 +
 usr/lib/README                                  |   57 
 usr/lib/SOCKETCALLS                             |   21 
 usr/lib/SYSCALLS                                |  146 
 usr/lib/__shared_init.c                         |   56 
 usr/lib/__signal.c                              |   22 
 usr/lib/__static_init.c                         |   40 
 usr/lib/abort.c                                 |   19 
 usr/lib/alarm.c                                 |   29 
 usr/lib/arch/README                             |   67 
 usr/lib/arch/alpha/MCONFIG                      |   17 
 usr/lib/arch/alpha/Makefile.inc                 |   93 
 usr/lib/arch/alpha/README-gcc                   |   23 
 usr/lib/arch/alpha/crt0.S                       |   21 
 usr/lib/arch/alpha/divide.c                     |   57 
 usr/lib/arch/alpha/include/klibc/archsetjmp.h   |   24 
 usr/lib/arch/alpha/include/klibc/archsys.h      |   53 
 usr/lib/arch/alpha/include/machine/asm.h        |   44 
 usr/lib/arch/alpha/pipe.c                       |   28 
 usr/lib/arch/alpha/setjmp.S                     |   61 
 usr/lib/arch/arm/MCONFIG                        |   26 
 usr/lib/arch/arm/Makefile.inc                   |   31 
 usr/lib/arch/arm/crt0.S                         |   25 
 usr/lib/arch/arm/include/klibc/archsetjmp.h     |   14 
 usr/lib/arch/arm/include/klibc/archsys.h        |   12 
 usr/lib/arch/arm/setjmp-arm.S                   |   40 
 usr/lib/arch/arm/setjmp-thumb.S                 |   58 
 usr/lib/arch/cris/MCONFIG                       |   11 
 usr/lib/arch/cris/Makefile.inc                  |   10 
 usr/lib/arch/cris/include/klibc/archsys.h       |   12 
 usr/lib/arch/i386/MCONFIG                       |   24 
 usr/lib/arch/i386/Makefile.inc                  |   27 
 usr/lib/arch/i386/crt0.S                        |   33 
 usr/lib/arch/i386/exits.S                       |   45 
 usr/lib/arch/i386/include/klibc/archsetjmp.h    |   19 
 usr/lib/arch/i386/include/klibc/archsys.h       |   96 
 usr/lib/arch/i386/include/klibc/diverr.h        |   16 
 usr/lib/arch/i386/libgcc/__ashldi3.S            |   29 
 usr/lib/arch/i386/libgcc/__ashrdi3.S            |   29 
 usr/lib/arch/i386/libgcc/__lshrdi3.S            |   29 
 usr/lib/arch/i386/libgcc/__muldi3.S             |   34 
 usr/lib/arch/i386/libgcc/__negdi2.S             |   21 
 usr/lib/arch/i386/setjmp.S                      |   58 
 usr/lib/arch/i386/socketcall.S                  |   38 
 usr/lib/arch/ia64/MCONFIG                       |   11 
 usr/lib/arch/ia64/Makefile.inc                  |   10 
 usr/lib/arch/ia64/include/klibc/archsys.h       |   12 
 usr/lib/arch/m68k/MCONFIG                       |   11 
 usr/lib/arch/m68k/Makefile.inc                  |   10 
 usr/lib/arch/m68k/include/klibc/archsys.h       |   12 
 usr/lib/arch/mips/MCONFIG                       |   18 
 usr/lib/arch/mips/Makefile.inc                  |   24 
 usr/lib/arch/mips/crt0.S                        |   25 
 usr/lib/arch/mips/include/klibc/archsetjmp.h    |   39 
 usr/lib/arch/mips/include/klibc/archsys.h       |   12 
 usr/lib/arch/mips/include/machine/asm.h         |   11 
 usr/lib/arch/mips/include/sgidefs.h             |   20 
 usr/lib/arch/mips/pipe.S                        |   16 
 usr/lib/arch/mips/setjmp.S                      |   82 
 usr/lib/arch/mips/vfork.S                       |   19 
 usr/lib/arch/mips64/MCONFIG                     |   11 
 usr/lib/arch/mips64/Makefile.inc                |   10 
 usr/lib/arch/mips64/include/klibc/archsys.h     |   12 
 usr/lib/arch/parisc/MCONFIG                     |   11 
 usr/lib/arch/parisc/Makefile.inc                |   10 
 usr/lib/arch/parisc/include/klibc/archsys.h     |   12 
 usr/lib/arch/ppc/MCONFIG                        |   11 
 usr/lib/arch/ppc/Makefile.inc                   |   15 
 usr/lib/arch/ppc/crt0.S                         |   29 
 usr/lib/arch/ppc/include/klibc/archsetjmp.h     |   36 
 usr/lib/arch/ppc/include/klibc/archsys.h        |   55 
 usr/lib/arch/ppc/setjmp.S                       |   35 
 usr/lib/arch/ppc64/MCONFIG                      |   11 
 usr/lib/arch/ppc64/Makefile.inc                 |   10 
 usr/lib/arch/ppc64/crt0.S                       |   38 
 usr/lib/arch/ppc64/include/klibc/archsys.h      |   52 
 usr/lib/arch/s390/MCONFIG                       |   13 
 usr/lib/arch/s390/Makefile.inc                  |   16 
 usr/lib/arch/s390/crt0.S                        |   25 
 usr/lib/arch/s390/include/klibc/archsetjmp.h    |   15 
 usr/lib/arch/s390/include/klibc/archsys.h       |   41 
 usr/lib/arch/s390/setjmp.S                      |   32 
 usr/lib/arch/s390x/MCONFIG                      |   13 
 usr/lib/arch/s390x/Makefile.inc                 |   16 
 usr/lib/arch/s390x/crt0.S                       |   21 
 usr/lib/arch/s390x/include/klibc/archsetjmp.h   |   15 
 usr/lib/arch/s390x/include/klibc/archsys.h      |   41 
 usr/lib/arch/s390x/setjmp.S                     |   36 
 usr/lib/arch/sh/MCONFIG                         |   11 
 usr/lib/arch/sh/Makefile.inc                    |   10 
 usr/lib/arch/sh/include/klibc/archsys.h         |   12 
 usr/lib/arch/sparc/MCONFIG                      |   18 
 usr/lib/arch/sparc/Makefile.inc                 |   44 
 usr/lib/arch/sparc/crt0.S                       |    2 
 usr/lib/arch/sparc/crt0i.S                      |  100 
 usr/lib/arch/sparc/divrem.m4                    |  276 +
 usr/lib/arch/sparc/include/klibc/archsetjmp.h   |   16 
 usr/lib/arch/sparc/include/klibc/archsys.h      |   65 
 usr/lib/arch/sparc/include/machine/asm.h        |  192 +
 usr/lib/arch/sparc/include/machine/frame.h      |  138 
 usr/lib/arch/sparc/include/machine/trap.h       |  141 
 usr/lib/arch/sparc/setjmp.S                     |   38 
 usr/lib/arch/sparc/smul.S                       |  160 
 usr/lib/arch/sparc/umul.S                       |  193 +
 usr/lib/arch/sparc64/MCONFIG                    |   21 
 usr/lib/arch/sparc64/Makefile.inc               |   13 
 usr/lib/arch/sparc64/crt0.S                     |    2 
 usr/lib/arch/sparc64/include/klibc/archsetjmp.h |   16 
 usr/lib/arch/sparc64/include/klibc/archsys.h    |  157 
 usr/lib/arch/sparc64/setjmp.S                   |   55 
 usr/lib/arch/x86_64/MCONFIG                     |   16 
 usr/lib/arch/x86_64/Makefile.inc                |   16 
 usr/lib/arch/x86_64/crt0.S                      |   22 
 usr/lib/arch/x86_64/exits.S                     |   35 
 usr/lib/arch/x86_64/include/klibc/archsetjmp.h  |   21 
 usr/lib/arch/x86_64/include/klibc/archsys.h     |   32 
 usr/lib/arch/x86_64/setjmp.S                    |   54 
 usr/lib/assert.c                                |   13 
 usr/lib/atexit.c                                |   10 
 usr/lib/atexit.h                                |   19 
 usr/lib/atoi.c                                  |    3 
 usr/lib/atol.c                                  |    3 
 usr/lib/atoll.c                                 |    3 
 usr/lib/atox.c                                  |   14 
 usr/lib/brk.c                                   |   24 
 usr/lib/bsd_signal.c                            |   11 
 usr/lib/calloc.c                                |   21 
 usr/lib/closelog.c                              |   18 
 usr/lib/creat.c                                 |   12 
 usr/lib/ctypes.c                                |  281 +
 usr/lib/exec_l.c                                |   57 
 usr/lib/execl.c                                 |    8 
 usr/lib/execle.c                                |    8 
 usr/lib/execlp.c                                |    8 
 usr/lib/execlpe.c                               |    8 
 usr/lib/execv.c                                 |   13 
 usr/lib/execvp.c                                |   13 
 usr/lib/execvpe.c                               |   73 
 usr/lib/exitc.c                                 |   36 
 usr/lib/fdatasync.c                             |   15 
 usr/lib/fgetc.c                                 |   20 
 usr/lib/fgets.c                                 |   33 
 usr/lib/fopen.c                                 |   46 
 usr/lib/fork.c                                  |   29 
 usr/lib/fprintf.c                               |   19 
 usr/lib/fputc.c                                 |   14 
 usr/lib/fputs.c                                 |   15 
 usr/lib/fread.c                                 |   35 
 usr/lib/fread2.c                                |   13 
 usr/lib/fwrite.c                                |   35 
 usr/lib/fwrite2.c                               |   13 
 usr/lib/getcwd.c                                |   15 
 usr/lib/getdomainname.c                         |   25 
 usr/lib/getenv.c                                |   22 
 usr/lib/gethostname.c                           |   25 
 usr/lib/getopt.c                                |   74 
 usr/lib/getpriority.c                           |   25 
 usr/lib/globals.c                               |   10 
 usr/lib/include/alloca.h                        |   13 
 usr/lib/include/arpa/inet.h                     |   24 
 usr/lib/include/assert.h                        |   22 
 usr/lib/include/bits32/bitsize/limits.h         |   14 
 usr/lib/include/bits32/bitsize/stddef.h         |   18 
 usr/lib/include/bits32/bitsize/stdint.h         |   34 
 usr/lib/include/bits32/bitsize/stdintconst.h    |   18 
 usr/lib/include/bits32/bitsize/stdintlimits.h   |   22 
 usr/lib/include/bits64/bitsize/limits.h         |   14 
 usr/lib/include/bits64/bitsize/stddef.h         |   13 
 usr/lib/include/bits64/bitsize/stdint.h         |   36 
 usr/lib/include/bits64/bitsize/stdintconst.h    |   18 
 usr/lib/include/bits64/bitsize/stdintlimits.h   |   22 
 usr/lib/include/ctype.h                         |  117 
 usr/lib/include/dirent.h                        |   20 
 usr/lib/include/elf.h                           |   12 
 usr/lib/include/endian.h                        |   41 
 usr/lib/include/errno.h                         |    8 
 usr/lib/include/fcntl.h                         |   11 
 usr/lib/include/grp.h                           |   13 
 usr/lib/include/inttypes.h                      |  226 +
 usr/lib/include/klibc/compiler.h                |   61 
 usr/lib/include/klibc/diverr.h                  |   16 
 usr/lib/include/klibc/extern.h                  |   14 
 usr/lib/include/limits.h                        |   40 
 usr/lib/include/net/if.h                        |    1 
 usr/lib/include/net/if_arp.h                    |    1 
 usr/lib/include/net/if_ether.h                  |    1 
 usr/lib/include/net/if_packet.h                 |    1 
 usr/lib/include/netinet/in.h                    |   29 
 usr/lib/include/netinet/in6.h                   |   10 
 usr/lib/include/netinet/ip.h                    |   13 
 usr/lib/include/netinet/tcp.h                   |   11 
 usr/lib/include/netinet/udp.h                   |   19 
 usr/lib/include/poll.h                          |   16 
 usr/lib/include/sched.h                         |   23 
 usr/lib/include/setjmp.h                        |   43 
 usr/lib/include/signal.h                        |   72 
 usr/lib/include/stdarg.h                        |   14 
 usr/lib/include/stddef.h                        |   24 
 usr/lib/include/stdint.h                        |  113 
 usr/lib/include/stdio.h                         |  109 
 usr/lib/include/stdlib.h                        |   94 
 usr/lib/include/string.h                        |   37 
 usr/lib/include/sys/dirent.h                    |   13 
 usr/lib/include/sys/fsuid.h                     |   14 
 usr/lib/include/sys/ioctl.h                     |   14 
 usr/lib/include/sys/klog.h                      |   24 
 usr/lib/include/sys/mman.h                      |   21 
 usr/lib/include/sys/module.h                    |  158 
 usr/lib/include/sys/mount.h                     |   55 
 usr/lib/include/sys/param.h                     |   11 
 usr/lib/include/sys/reboot.h                    |   25 
 usr/lib/include/sys/resource.h                  |   15 
 usr/lib/include/sys/select.h                    |   13 
 usr/lib/include/sys/socket.h                    |   50 
 usr/lib/include/sys/socketcalls.h               |   28 
 usr/lib/include/sys/stat.h                      |   23 
 usr/lib/include/sys/syscall.h                   |   15 
 usr/lib/include/sys/time.h                      |   16 
 usr/lib/include/sys/times.h                     |   14 
 usr/lib/include/sys/types.h                     |  131 
 usr/lib/include/sys/uio.h                       |   15 
 usr/lib/include/sys/utime.h                     |   10 
 usr/lib/include/sys/utsname.h                   |   23 
 usr/lib/include/sys/vfs.h                       |   14 
 usr/lib/include/sys/wait.h                      |   19 
 usr/lib/include/syslog.h                        |   53 
 usr/lib/include/termios.h                       |   86 
 usr/lib/include/time.h                          |   14 
 usr/lib/include/unistd.h                        |  106 
 usr/lib/include/utime.h                         |   15 
 usr/lib/inet/inet_addr.c                        |   14 
 usr/lib/inet/inet_aton.c                        |   23 
 usr/lib/inet/inet_ntoa.c                        |   19 
 usr/lib/inet/inet_ntop.c                        |   52 
 usr/lib/inet/inet_pton.c                        |   74 
 usr/lib/interp.S                                |   11 
 usr/lib/isatty.c                                |   21 
 usr/lib/libgcc/__divdi3.c                       |   29 
 usr/lib/libgcc/__divsi3.c                       |   29 
 usr/lib/libgcc/__moddi3.c                       |   29 
 usr/lib/libgcc/__modsi3.c                       |   29 
 usr/lib/libgcc/__udivdi3.c                      |   13 
 usr/lib/libgcc/__udivmoddi4.c                   |   32 
 usr/lib/libgcc/__udivmodsi4.c                   |   32 
 usr/lib/libgcc/__udivsi3.c                      |   13 
 usr/lib/libgcc/__umoddi3.c                      |   16 
 usr/lib/libgcc/__umodsi3.c                      |   16 
 usr/lib/llseek.c                                |   34 
 usr/lib/lrand48.c                               |   42 
 usr/lib/makeerrlist.pl                          |   80 
 usr/lib/malloc.c                                |  192 +
 usr/lib/malloc.h                                |   51 
 usr/lib/memccpy.c                               |   23 
 usr/lib/memchr.c                                |   18 
 usr/lib/memcmp.c                                |   19 
 usr/lib/memcpy.c                                |   29 
 usr/lib/memmem.c                                |   44 
 usr/lib/memmove.c                               |   34 
 usr/lib/memset.c                                |   30 
 usr/lib/memswap.c                               |   23 
 usr/lib/mmap.c                                  |   51 
 usr/lib/nice.c                                  |   22 
 usr/lib/onexit.c                                |   39 
 usr/lib/pause.c                                 |   21 
 usr/lib/perror.c                                |   12 
 usr/lib/printf.c                                |   19 
 usr/lib/pty.c                                   |   31 
 usr/lib/puts.c                                  |   13 
 usr/lib/qsort.c                                 |   42 
 usr/lib/raise.c                                 |   11 
 usr/lib/readdir.c                               |   66 
 usr/lib/realloc.c                               |   49 
 usr/lib/reboot.c                                |   15 
 usr/lib/recv.c                                  |   11 
 usr/lib/sbrk.c                                  |   23 
 usr/lib/seed48.c                                |   19 
 usr/lib/select.c                                |    9 
 usr/lib/send.c                                  |   11 
 usr/lib/setegid.c                               |   10 
 usr/lib/setenv.c                                |  124 
 usr/lib/seteuid.c                               |   10 
 usr/lib/setpgrp.c                               |   10 
 usr/lib/setresgid.c                             |   29 
 usr/lib/setresuid.c                             |   30 
 usr/lib/sha1hash.c                              |  319 +
 usr/lib/sigaction.c                             |   19 
 usr/lib/siglist.c                               |  115 
 usr/lib/siglongjmp.c                            |   16 
 usr/lib/signal.c                                |   11 
 usr/lib/sigpending.c                            |   19 
 usr/lib/sigprocmask.c                           |   19 
 usr/lib/sigsuspend.c                            |   19 
 usr/lib/sleep.c                                 |   20 
 usr/lib/snprintf.c                              |   16 
 usr/lib/socketcalls.pl                          |   75 
 usr/lib/socketcalls/socketcommon.h              |   25 
 usr/lib/socketcommon.h                          |   25 
 usr/lib/sprintf.c                               |   18 
 usr/lib/srand48.c                               |   16 
 usr/lib/sscanf.c                                |   17 
 usr/lib/strcat.c                                |   11 
 usr/lib/strchr.c                                |   16 
 usr/lib/strcmp.c                                |   20 
 usr/lib/strcpy.c                                |   20 
 usr/lib/strdup.c                                |   17 
 usr/lib/strerror.c                              |   25 
 usr/lib/strlen.c                                |   14 
 usr/lib/strncat.c                               |   11 
 usr/lib/strncmp.c                               |   20 
 usr/lib/strncpy.c                               |   22 
 usr/lib/strntoimax.c                            |   13 
 usr/lib/strntoumax.c                            |   75 
 usr/lib/strrchr.c                               |   18 
 usr/lib/strsep.c                                |   21 
 usr/lib/strspn.c                                |   67 
 usr/lib/strstr.c                                |   10 
 usr/lib/strtoimax.c                             |    3 
 usr/lib/strtok.c                                |   16 
 usr/lib/strtol.c                                |    3 
 usr/lib/strtoll.c                               |    3 
 usr/lib/strtoul.c                               |    3 
 usr/lib/strtoull.c                              |    3 
 usr/lib/strtoumax.c                             |    3 
 usr/lib/strtox.c                                |   13 
 usr/lib/syscalls.pl                             |   84 
 usr/lib/syscalls/syscommon.h                    |   29 
 usr/lib/syscommon.h                             |   29 
 usr/lib/syslog.c                                |   68 
 usr/lib/tests/getenvtest.c                      |   26 
 usr/lib/tests/getopttest.c                      |   31 
 usr/lib/tests/hello.c                           |    7 
 usr/lib/tests/idtest.c                          |   14 
 usr/lib/tests/malloctest.c                      | 4145 ++++++++++++++++++++++++
 usr/lib/tests/memstrtest.c                      |   29 
 usr/lib/tests/microhello.c                      |    9 
 usr/lib/tests/minihello.c                       |    7 
 usr/lib/tests/minips.c                          |  452 ++
 usr/lib/tests/nfs_no_rpc.c                      |  538 +++
 usr/lib/tests/setjmptest.c                      |   36 
 usr/lib/tests/testrand48.c                      |   19 
 usr/lib/tests/testvsnp.c                        |  115 
 usr/lib/time.c                                  |   27 
 usr/lib/umount.c                                |   12 
 usr/lib/unsetenv.c                              |   40 
 usr/lib/usleep.c                                |   15 
 usr/lib/utime.c                                 |   30 
 usr/lib/vfprintf.c                              |   26 
 usr/lib/vprintf.c                               |   11 
 usr/lib/vsnprintf.c                             |  433 ++
 usr/lib/vsprintf.c                              |   11 
 usr/lib/vsscanf.c                               |  365 ++
 usr/lib/wait.c                                  |   12 
 usr/lib/wait3.c                                 |   12 
 usr/lib/waitpid.c                               |   12 
 usr/root/Makefile                               |    8 
 usr/root/hello                                  |binary
 usr/root/hello.c                                |   21 
 usr/root/init.c                                 |  442 --
 374 files changed, 18437 insertions(+), 677 deletions(-)
-----

ChangeSet@1.994, 2003-02-19 11:21:54-08:00, arnd@bergmann-dalldorf.de
  [PATCH] KLIBC: fix for non-i386 build
  
  I just tried building on s390x and only needed this trivial fix. Unfortunately,
  2.5.61 does not boot on s390x yet, so I could not do run-time tests.

 usr/lib/socketcalls.pl |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.990.1.4, 2003-02-19 10:39:00-08:00, greg@kroah.com
  Cset exclude: kai@tp1.ruhr-uni-bochum.de|ChangeSet|20030217001132|22043

 init/Kconfig        |   10 -
 init/Makefile       |    7 
 init/do_mounts.c    |    6 
 init/main.c         |   22 --
 scripts/Makefile    |    3 
 usr/Makefile        |    2 
 usr/gen_init_cpio.c |    2 
 usr/root/Makefile   |    5 
 usr/root/init.c     |  442 ----------------------------------------------------
 9 files changed, 10 insertions(+), 489 deletions(-)
------

ChangeSet@1.990.1.3, 2003-02-19 10:37:44-08:00, greg@kroah.com
  KLIBC: fix up some type errors that were highlighted by the posix timer changes.

 usr/lib/include/sys/types.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)
------

ChangeSet@1.990.1.2, 2003-02-19 10:35:46-08:00, greg@kroah.com
  KLIBC: delete usr/root/hello
  
  We don't need binaries in the kernel source tree :)

 usr/root/hello |binary
 1 files changed
------

ChangeSet@1.990.1.1, 2003-02-19 09:01:31-08:00, greg@kroah.com
  merge

 Makefile         |   39 ++++++++++++++++++++++++++++++++++++---
 scripts/Makefile |    2 +-
 2 files changed, 37 insertions(+), 4 deletions(-)
------

ChangeSet@1.914.161.13, 2003-02-16 18:57:52-06:00, kai@tp1.ruhr-uni-bochum.de
  Merge tp1.ruhr-uni-bochum.de:/scratch/kai/kernel/v2.5/linux-2.5
  into tp1.ruhr-uni-bochum.de:/scratch/kai/kernel/v2.5/linux-2.5.klibc

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.914.157.11, 2003-02-16 18:11:32-06:00, kai@tp1.ruhr-uni-bochum.de
  klibc: Move mounting of the root filesystem into userspace
  
  When selecting CONFIG_INITRAMFS, init/do_mounts.c is not compiled anymore,
  and it's task is taken over by a small /sbin/init running in initramfs.
  
  However, this is a proof of concept only, the userspace code only handles
  mounting a local filesystem, no support for nfs / initrd / devfs yet.

 init/Kconfig        |   10 +
 init/Makefile       |    7 
 init/do_mounts.c    |    6 
 init/main.c         |   22 ++
 scripts/Makefile    |    4 
 usr/Makefile        |    2 
 usr/gen_init_cpio.c |    2 
 usr/root/Makefile   |    5 
 usr/root/init.c     |  442 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 489 insertions(+), 11 deletions(-)
------

ChangeSet@1.914.157.10, 2003-02-16 18:06:13-06:00, kai@tp1.ruhr-uni-bochum.de
  klibc: Silence too ambitious warnings
  
  gcc complained about unused function parameters and things, that's just
  a little too much.

 Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.914.157.9, 2003-02-15 23:33:21-06:00, kai@tp1.ruhr-uni-bochum.de
  klibc: Stop on error when building the CPIO
  
  gen_init_cpio still referenced hello in usr/hello_world, but I put it
  into usr/root. This is now corrected, however it also pointed out the
  common problem that the error code of gen_init_cpio is ignored since
  it's output is piped to gzip. To fix that, make the generation of the
  .cpio.gz a two step process.

 usr/Makefile        |   24 +++++++++++++++++-------
 usr/gen_init_cpio.c |    2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)
------

ChangeSet@1.914.157.8, 2003-02-15 23:24:10-06:00, arndb@de.ibm.com
  klibc: gen_init_cpio file generation fix
  
  I found what kept initramfs from working here: While creating
  of initramfs_data.cpio.gz, the padding between a file header
  and the file contents was wrong, which can be verified by
  unpacking the archive by hand.

 usr/gen_init_cpio.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.914.157.7, 2003-02-15 23:21:47-06:00, greg@kroah.com
  klibc: add file support to gen_init_cpio.c

 usr/gen_init_cpio.c |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+)
------

ChangeSet@1.914.157.6, 2003-02-15 23:20:13-06:00, kai@tp1.ruhr-uni-bochum.de
  klibc: Fix the "hello" example (for real)
  
  Greg's fix used fwrite on a file descriptor obtained from open(), which
  only works by luck, since for klibc FILE * == fd.
  
  Use standard C lib functions for open/close.

 usr/root/hello.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.914.157.5, 2003-02-15 23:16:53-06:00, kai@tp1.ruhr-uni-bochum.de
  klibc: Fix a compiler warning

 usr/lib/sha1hash.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.914.157.4, 2003-02-15 23:11:51-06:00, greg@kroah.com
  klibc: fix up the hello_world example
  
  stdout doesn't go anywhere useful when spawned from the kernel :)

 usr/root/hello.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)
------

ChangeSet@1.914.157.3, 2003-02-15 23:09:41-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/klibc: Integrate klibc into the build.
  
  Basically, add a scripts/Makefile.user, which does similar things to
  scripts/Makefile.build, but compiles userspace for the target instead.
  
  It's tested for a static klibc on i386, building the shared lib works, too,
  but is not further integrated.
  
  This patch also adds gregkh's hello test program, which works as well.

 usr/lib/socketcommon.h             |   25 ----
 usr/lib/syscommon.h                |   29 -----
 Makefile                           |   39 ++++++
 scripts/Makefile.build             |    6 -
 scripts/Makefile.clean             |   11 +
 scripts/Makefile.lib               |    3 
 scripts/Makefile.user              |  209 +++++++++++++++++++++++++++++++++++++
 usr/Makefile                       |   28 ++++
 usr/lib/MCONFIG                    |   39 +++---
 usr/lib/Makefile                   |  159 ++++++++++++++--------------
 usr/lib/socketcalls.pl             |   11 +
 usr/lib/socketcalls/socketcommon.h |   25 ++++
 usr/lib/syscalls.pl                |   12 +-
 usr/lib/syscalls/syscommon.h       |   29 +++++
 usr/root/Makefile                  |    3 
 usr/root/hello                     |binary
 usr/root/hello.c                   |    8 +
 17 files changed, 471 insertions(+), 165 deletions(-)
------

ChangeSet@1.914.157.2, 2003-02-15 16:55:46-06:00, kai@tp1.ruhr-uni-bochum.de
  klibc: Merge klibc-0.77
  
  That's just a cp -r klibc-0.77/klibc/* linux/usr/lib

 usr/lib/CAVEATS                                 |   51 
 usr/lib/MCONFIG                                 |   49 
 usr/lib/Makefile                                |  134 
 usr/lib/README                                  |   57 
 usr/lib/SOCKETCALLS                             |   21 
 usr/lib/SYSCALLS                                |  146 
 usr/lib/__shared_init.c                         |   56 
 usr/lib/__signal.c                              |   22 
 usr/lib/__static_init.c                         |   40 
 usr/lib/abort.c                                 |   19 
 usr/lib/alarm.c                                 |   29 
 usr/lib/arch/README                             |   67 
 usr/lib/arch/alpha/MCONFIG                      |   17 
 usr/lib/arch/alpha/Makefile.inc                 |   93 
 usr/lib/arch/alpha/README-gcc                   |   23 
 usr/lib/arch/alpha/crt0.S                       |   21 
 usr/lib/arch/alpha/divide.c                     |   57 
 usr/lib/arch/alpha/include/klibc/archsetjmp.h   |   24 
 usr/lib/arch/alpha/include/klibc/archsys.h      |   53 
 usr/lib/arch/alpha/include/machine/asm.h        |   44 
 usr/lib/arch/alpha/pipe.c                       |   28 
 usr/lib/arch/alpha/setjmp.S                     |   61 
 usr/lib/arch/arm/MCONFIG                        |   26 
 usr/lib/arch/arm/Makefile.inc                   |   31 
 usr/lib/arch/arm/crt0.S                         |   25 
 usr/lib/arch/arm/include/klibc/archsetjmp.h     |   14 
 usr/lib/arch/arm/include/klibc/archsys.h        |   12 
 usr/lib/arch/arm/setjmp-arm.S                   |   40 
 usr/lib/arch/arm/setjmp-thumb.S                 |   58 
 usr/lib/arch/cris/MCONFIG                       |   11 
 usr/lib/arch/cris/Makefile.inc                  |   10 
 usr/lib/arch/cris/include/klibc/archsys.h       |   12 
 usr/lib/arch/i386/MCONFIG                       |   24 
 usr/lib/arch/i386/Makefile.inc                  |   27 
 usr/lib/arch/i386/crt0.S                        |   33 
 usr/lib/arch/i386/exits.S                       |   45 
 usr/lib/arch/i386/include/klibc/archsetjmp.h    |   19 
 usr/lib/arch/i386/include/klibc/archsys.h       |   96 
 usr/lib/arch/i386/include/klibc/diverr.h        |   16 
 usr/lib/arch/i386/libgcc/__ashldi3.S            |   29 
 usr/lib/arch/i386/libgcc/__ashrdi3.S            |   29 
 usr/lib/arch/i386/libgcc/__lshrdi3.S            |   29 
 usr/lib/arch/i386/libgcc/__muldi3.S             |   34 
 usr/lib/arch/i386/libgcc/__negdi2.S             |   21 
 usr/lib/arch/i386/setjmp.S                      |   58 
 usr/lib/arch/i386/socketcall.S                  |   38 
 usr/lib/arch/ia64/MCONFIG                       |   11 
 usr/lib/arch/ia64/Makefile.inc                  |   10 
 usr/lib/arch/ia64/include/klibc/archsys.h       |   12 
 usr/lib/arch/m68k/MCONFIG                       |   11 
 usr/lib/arch/m68k/Makefile.inc                  |   10 
 usr/lib/arch/m68k/include/klibc/archsys.h       |   12 
 usr/lib/arch/mips/MCONFIG                       |   18 
 usr/lib/arch/mips/Makefile.inc                  |   24 
 usr/lib/arch/mips/crt0.S                        |   25 
 usr/lib/arch/mips/include/klibc/archsetjmp.h    |   39 
 usr/lib/arch/mips/include/klibc/archsys.h       |   12 
 usr/lib/arch/mips/include/machine/asm.h         |   11 
 usr/lib/arch/mips/include/sgidefs.h             |   20 
 usr/lib/arch/mips/pipe.S                        |   16 
 usr/lib/arch/mips/setjmp.S                      |   82 
 usr/lib/arch/mips/vfork.S                       |   19 
 usr/lib/arch/mips64/MCONFIG                     |   11 
 usr/lib/arch/mips64/Makefile.inc                |   10 
 usr/lib/arch/mips64/include/klibc/archsys.h     |   12 
 usr/lib/arch/parisc/MCONFIG                     |   11 
 usr/lib/arch/parisc/Makefile.inc                |   10 
 usr/lib/arch/parisc/include/klibc/archsys.h     |   12 
 usr/lib/arch/ppc/MCONFIG                        |   11 
 usr/lib/arch/ppc/Makefile.inc                   |   15 
 usr/lib/arch/ppc/crt0.S                         |   29 
 usr/lib/arch/ppc/include/klibc/archsetjmp.h     |   36 
 usr/lib/arch/ppc/include/klibc/archsys.h        |   55 
 usr/lib/arch/ppc/setjmp.S                       |   35 
 usr/lib/arch/ppc64/MCONFIG                      |   11 
 usr/lib/arch/ppc64/Makefile.inc                 |   10 
 usr/lib/arch/ppc64/crt0.S                       |   38 
 usr/lib/arch/ppc64/include/klibc/archsys.h      |   52 
 usr/lib/arch/s390/MCONFIG                       |   13 
 usr/lib/arch/s390/Makefile.inc                  |   16 
 usr/lib/arch/s390/crt0.S                        |   25 
 usr/lib/arch/s390/include/klibc/archsetjmp.h    |   15 
 usr/lib/arch/s390/include/klibc/archsys.h       |   41 
 usr/lib/arch/s390/setjmp.S                      |   32 
 usr/lib/arch/s390x/MCONFIG                      |   13 
 usr/lib/arch/s390x/Makefile.inc                 |   16 
 usr/lib/arch/s390x/crt0.S                       |   21 
 usr/lib/arch/s390x/include/klibc/archsetjmp.h   |   15 
 usr/lib/arch/s390x/include/klibc/archsys.h      |   41 
 usr/lib/arch/s390x/setjmp.S                     |   36 
 usr/lib/arch/sh/MCONFIG                         |   11 
 usr/lib/arch/sh/Makefile.inc                    |   10 
 usr/lib/arch/sh/include/klibc/archsys.h         |   12 
 usr/lib/arch/sparc/MCONFIG                      |   18 
 usr/lib/arch/sparc/Makefile.inc                 |   44 
 usr/lib/arch/sparc/crt0.S                       |    2 
 usr/lib/arch/sparc/crt0i.S                      |  100 
 usr/lib/arch/sparc/divrem.m4                    |  276 +
 usr/lib/arch/sparc/include/klibc/archsetjmp.h   |   16 
 usr/lib/arch/sparc/include/klibc/archsys.h      |   65 
 usr/lib/arch/sparc/include/machine/asm.h        |  192 +
 usr/lib/arch/sparc/include/machine/frame.h      |  138 
 usr/lib/arch/sparc/include/machine/trap.h       |  141 
 usr/lib/arch/sparc/setjmp.S                     |   38 
 usr/lib/arch/sparc/smul.S                       |  160 
 usr/lib/arch/sparc/umul.S                       |  193 +
 usr/lib/arch/sparc64/MCONFIG                    |   21 
 usr/lib/arch/sparc64/Makefile.inc               |   13 
 usr/lib/arch/sparc64/crt0.S                     |    2 
 usr/lib/arch/sparc64/include/klibc/archsetjmp.h |   16 
 usr/lib/arch/sparc64/include/klibc/archsys.h    |  157 
 usr/lib/arch/sparc64/setjmp.S                   |   55 
 usr/lib/arch/x86_64/MCONFIG                     |   16 
 usr/lib/arch/x86_64/Makefile.inc                |   16 
 usr/lib/arch/x86_64/crt0.S                      |   22 
 usr/lib/arch/x86_64/exits.S                     |   35 
 usr/lib/arch/x86_64/include/klibc/archsetjmp.h  |   21 
 usr/lib/arch/x86_64/include/klibc/archsys.h     |   32 
 usr/lib/arch/x86_64/setjmp.S                    |   54 
 usr/lib/assert.c                                |   13 
 usr/lib/atexit.c                                |   10 
 usr/lib/atexit.h                                |   19 
 usr/lib/atoi.c                                  |    3 
 usr/lib/atol.c                                  |    3 
 usr/lib/atoll.c                                 |    3 
 usr/lib/atox.c                                  |   14 
 usr/lib/brk.c                                   |   24 
 usr/lib/bsd_signal.c                            |   11 
 usr/lib/calloc.c                                |   21 
 usr/lib/closelog.c                              |   18 
 usr/lib/creat.c                                 |   12 
 usr/lib/ctypes.c                                |  281 +
 usr/lib/exec_l.c                                |   57 
 usr/lib/execl.c                                 |    8 
 usr/lib/execle.c                                |    8 
 usr/lib/execlp.c                                |    8 
 usr/lib/execlpe.c                               |    8 
 usr/lib/execv.c                                 |   13 
 usr/lib/execvp.c                                |   13 
 usr/lib/execvpe.c                               |   73 
 usr/lib/exitc.c                                 |   36 
 usr/lib/fdatasync.c                             |   15 
 usr/lib/fgetc.c                                 |   20 
 usr/lib/fgets.c                                 |   33 
 usr/lib/fopen.c                                 |   46 
 usr/lib/fork.c                                  |   29 
 usr/lib/fprintf.c                               |   19 
 usr/lib/fputc.c                                 |   14 
 usr/lib/fputs.c                                 |   15 
 usr/lib/fread.c                                 |   35 
 usr/lib/fread2.c                                |   13 
 usr/lib/fwrite.c                                |   35 
 usr/lib/fwrite2.c                               |   13 
 usr/lib/getcwd.c                                |   15 
 usr/lib/getdomainname.c                         |   25 
 usr/lib/getenv.c                                |   22 
 usr/lib/gethostname.c                           |   25 
 usr/lib/getopt.c                                |   74 
 usr/lib/getpriority.c                           |   25 
 usr/lib/globals.c                               |   10 
 usr/lib/include/alloca.h                        |   13 
 usr/lib/include/arpa/inet.h                     |   24 
 usr/lib/include/assert.h                        |   22 
 usr/lib/include/bits32/bitsize/limits.h         |   14 
 usr/lib/include/bits32/bitsize/stddef.h         |   18 
 usr/lib/include/bits32/bitsize/stdint.h         |   34 
 usr/lib/include/bits32/bitsize/stdintconst.h    |   18 
 usr/lib/include/bits32/bitsize/stdintlimits.h   |   22 
 usr/lib/include/bits64/bitsize/limits.h         |   14 
 usr/lib/include/bits64/bitsize/stddef.h         |   13 
 usr/lib/include/bits64/bitsize/stdint.h         |   36 
 usr/lib/include/bits64/bitsize/stdintconst.h    |   18 
 usr/lib/include/bits64/bitsize/stdintlimits.h   |   22 
 usr/lib/include/ctype.h                         |  117 
 usr/lib/include/dirent.h                        |   20 
 usr/lib/include/elf.h                           |   12 
 usr/lib/include/endian.h                        |   41 
 usr/lib/include/errno.h                         |    8 
 usr/lib/include/fcntl.h                         |   11 
 usr/lib/include/grp.h                           |   13 
 usr/lib/include/inttypes.h                      |  226 +
 usr/lib/include/klibc/compiler.h                |   61 
 usr/lib/include/klibc/diverr.h                  |   16 
 usr/lib/include/klibc/extern.h                  |   14 
 usr/lib/include/limits.h                        |   40 
 usr/lib/include/net/if.h                        |    1 
 usr/lib/include/net/if_arp.h                    |    1 
 usr/lib/include/net/if_ether.h                  |    1 
 usr/lib/include/net/if_packet.h                 |    1 
 usr/lib/include/netinet/in.h                    |   29 
 usr/lib/include/netinet/in6.h                   |   10 
 usr/lib/include/netinet/ip.h                    |   13 
 usr/lib/include/netinet/tcp.h                   |   11 
 usr/lib/include/netinet/udp.h                   |   19 
 usr/lib/include/poll.h                          |   16 
 usr/lib/include/sched.h                         |   23 
 usr/lib/include/setjmp.h                        |   43 
 usr/lib/include/signal.h                        |   72 
 usr/lib/include/stdarg.h                        |   14 
 usr/lib/include/stddef.h                        |   24 
 usr/lib/include/stdint.h                        |  113 
 usr/lib/include/stdio.h                         |  109 
 usr/lib/include/stdlib.h                        |   94 
 usr/lib/include/string.h                        |   37 
 usr/lib/include/sys/dirent.h                    |   13 
 usr/lib/include/sys/fsuid.h                     |   14 
 usr/lib/include/sys/ioctl.h                     |   14 
 usr/lib/include/sys/klog.h                      |   24 
 usr/lib/include/sys/mman.h                      |   21 
 usr/lib/include/sys/module.h                    |  158 
 usr/lib/include/sys/mount.h                     |   55 
 usr/lib/include/sys/param.h                     |   11 
 usr/lib/include/sys/reboot.h                    |   25 
 usr/lib/include/sys/resource.h                  |   15 
 usr/lib/include/sys/select.h                    |   13 
 usr/lib/include/sys/socket.h                    |   50 
 usr/lib/include/sys/socketcalls.h               |   28 
 usr/lib/include/sys/stat.h                      |   23 
 usr/lib/include/sys/syscall.h                   |   15 
 usr/lib/include/sys/time.h                      |   16 
 usr/lib/include/sys/times.h                     |   14 
 usr/lib/include/sys/types.h                     |  126 
 usr/lib/include/sys/uio.h                       |   15 
 usr/lib/include/sys/utime.h                     |   10 
 usr/lib/include/sys/utsname.h                   |   23 
 usr/lib/include/sys/vfs.h                       |   14 
 usr/lib/include/sys/wait.h                      |   19 
 usr/lib/include/syslog.h                        |   53 
 usr/lib/include/termios.h                       |   86 
 usr/lib/include/time.h                          |   14 
 usr/lib/include/unistd.h                        |  106 
 usr/lib/include/utime.h                         |   15 
 usr/lib/inet/inet_addr.c                        |   14 
 usr/lib/inet/inet_aton.c                        |   23 
 usr/lib/inet/inet_ntoa.c                        |   19 
 usr/lib/inet/inet_ntop.c                        |   52 
 usr/lib/inet/inet_pton.c                        |   74 
 usr/lib/interp.S                                |   11 
 usr/lib/isatty.c                                |   21 
 usr/lib/libgcc/__divdi3.c                       |   29 
 usr/lib/libgcc/__divsi3.c                       |   29 
 usr/lib/libgcc/__moddi3.c                       |   29 
 usr/lib/libgcc/__modsi3.c                       |   29 
 usr/lib/libgcc/__udivdi3.c                      |   13 
 usr/lib/libgcc/__udivmoddi4.c                   |   32 
 usr/lib/libgcc/__udivmodsi4.c                   |   32 
 usr/lib/libgcc/__udivsi3.c                      |   13 
 usr/lib/libgcc/__umoddi3.c                      |   16 
 usr/lib/libgcc/__umodsi3.c                      |   16 
 usr/lib/llseek.c                                |   34 
 usr/lib/lrand48.c                               |   42 
 usr/lib/makeerrlist.pl                          |   80 
 usr/lib/malloc.c                                |  192 +
 usr/lib/malloc.h                                |   51 
 usr/lib/memccpy.c                               |   23 
 usr/lib/memchr.c                                |   18 
 usr/lib/memcmp.c                                |   19 
 usr/lib/memcpy.c                                |   29 
 usr/lib/memmem.c                                |   44 
 usr/lib/memmove.c                               |   34 
 usr/lib/memset.c                                |   30 
 usr/lib/memswap.c                               |   23 
 usr/lib/mmap.c                                  |   51 
 usr/lib/nice.c                                  |   22 
 usr/lib/onexit.c                                |   39 
 usr/lib/pause.c                                 |   21 
 usr/lib/perror.c                                |   12 
 usr/lib/printf.c                                |   19 
 usr/lib/pty.c                                   |   31 
 usr/lib/puts.c                                  |   13 
 usr/lib/qsort.c                                 |   42 
 usr/lib/raise.c                                 |   11 
 usr/lib/readdir.c                               |   66 
 usr/lib/realloc.c                               |   49 
 usr/lib/reboot.c                                |   15 
 usr/lib/recv.c                                  |   11 
 usr/lib/sbrk.c                                  |   23 
 usr/lib/seed48.c                                |   19 
 usr/lib/select.c                                |    9 
 usr/lib/send.c                                  |   11 
 usr/lib/setegid.c                               |   10 
 usr/lib/setenv.c                                |  124 
 usr/lib/seteuid.c                               |   10 
 usr/lib/setpgrp.c                               |   10 
 usr/lib/setresgid.c                             |   29 
 usr/lib/setresuid.c                             |   30 
 usr/lib/sha1hash.c                              |  317 +
 usr/lib/sigaction.c                             |   19 
 usr/lib/siglist.c                               |  115 
 usr/lib/siglongjmp.c                            |   16 
 usr/lib/signal.c                                |   11 
 usr/lib/sigpending.c                            |   19 
 usr/lib/sigprocmask.c                           |   19 
 usr/lib/sigsuspend.c                            |   19 
 usr/lib/sleep.c                                 |   20 
 usr/lib/snprintf.c                              |   16 
 usr/lib/socketcalls.pl                          |   62 
 usr/lib/socketcommon.h                          |   25 
 usr/lib/sprintf.c                               |   18 
 usr/lib/srand48.c                               |   16 
 usr/lib/sscanf.c                                |   17 
 usr/lib/strcat.c                                |   11 
 usr/lib/strchr.c                                |   16 
 usr/lib/strcmp.c                                |   20 
 usr/lib/strcpy.c                                |   20 
 usr/lib/strdup.c                                |   17 
 usr/lib/strerror.c                              |   25 
 usr/lib/strlen.c                                |   14 
 usr/lib/strncat.c                               |   11 
 usr/lib/strncmp.c                               |   20 
 usr/lib/strncpy.c                               |   22 
 usr/lib/strntoimax.c                            |   13 
 usr/lib/strntoumax.c                            |   75 
 usr/lib/strrchr.c                               |   18 
 usr/lib/strsep.c                                |   21 
 usr/lib/strspn.c                                |   67 
 usr/lib/strstr.c                                |   10 
 usr/lib/strtoimax.c                             |    3 
 usr/lib/strtok.c                                |   16 
 usr/lib/strtol.c                                |    3 
 usr/lib/strtoll.c                               |    3 
 usr/lib/strtoul.c                               |    3 
 usr/lib/strtoull.c                              |    3 
 usr/lib/strtoumax.c                             |    3 
 usr/lib/strtox.c                                |   13 
 usr/lib/syscalls.pl                             |   72 
 usr/lib/syscommon.h                             |   29 
 usr/lib/syslog.c                                |   68 
 usr/lib/tests/getenvtest.c                      |   26 
 usr/lib/tests/getopttest.c                      |   31 
 usr/lib/tests/hello.c                           |    7 
 usr/lib/tests/idtest.c                          |   14 
 usr/lib/tests/malloctest.c                      | 4145 ++++++++++++++++++++++++
 usr/lib/tests/memstrtest.c                      |   29 
 usr/lib/tests/microhello.c                      |    9 
 usr/lib/tests/minihello.c                       |    7 
 usr/lib/tests/minips.c                          |  452 ++
 usr/lib/tests/nfs_no_rpc.c                      |  538 +++
 usr/lib/tests/setjmptest.c                      |   36 
 usr/lib/tests/testrand48.c                      |   19 
 usr/lib/tests/testvsnp.c                        |  115 
 usr/lib/time.c                                  |   27 
 usr/lib/umount.c                                |   12 
 usr/lib/unsetenv.c                              |   40 
 usr/lib/usleep.c                                |   15 
 usr/lib/utime.c                                 |   30 
 usr/lib/vfprintf.c                              |   26 
 usr/lib/vprintf.c                               |   11 
 usr/lib/vsnprintf.c                             |  433 ++
 usr/lib/vsprintf.c                              |   11 
 usr/lib/vsscanf.c                               |  365 ++
 usr/lib/wait.c                                  |   12 
 usr/lib/wait3.c                                 |   12 
 usr/lib/waitpid.c                               |   12 
 354 files changed, 17793 insertions(+)
------

