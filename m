Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTFJVHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTFJVGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:06:46 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:35421 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264037AbTFJVEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:04:51 -0400
Date: Tue, 10 Jun 2003 14:14:40 -0700
From: Andrew Morton <akpm@digeo.com>
To: Simon Fowler <simon@himi.org>
Cc: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk radeonfb oops on boot.
Message-Id: <20030610141440.26fad221.akpm@digeo.com>
In-Reply-To: <20030610130204.GC27768@himi.org>
References: <20030610061654.GB25390@himi.org>
	<20030610130204.GC27768@himi.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 21:18:32.0876 (UTC) FILETIME=[D8B32EC0:01C32F95]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Fowler <simon@himi.org> wrote:
>
> On Tue, Jun 10, 2003 at 04:16:54PM +1000, Simon Fowler wrote:
> > I've started seeing a hard lockup on boot with my Fujitsu Lifebook
> > p2120 laptop, with a radeon mobility M6 LY, when using a Linus bk
> > kernel as of 2003-06-09 (possibly earlier - the last kernel I've
> > tested is bk as of 2003-06-04). lspci lists this hardware:
> > 
> I've narrowed the start of the problem down: 2.5.70-bk13 works,
> -bk14 oopses. 

That's funny.  bk13->bk14 was almost all arm stuff.  diffstat below.

It might be worth reverting this chunk, see if that fixes it:

--- b/drivers/char/mem.c        Thu Jun  5 23:36:40 2003
+++ b/drivers/char/mem.c        Sun Jun  8 05:02:24 2003
@@ -716 +716 @@
-__initcall(chr_dev_init);
+subsys_initcall(chr_dev_init);


 Documentation/DocBook/kernel-api.tmpl       |    3 
 Documentation/kbuild/makefiles.txt          |   32 
 arch/alpha/kernel/asm-offsets.c             |    1 
 arch/alpha/kernel/head.S                    |    3 
 arch/alpha/kernel/traps.c                   |   80 
 arch/alpha/lib/csum_partial_copy.c          |    4 
 arch/alpha/lib/memmove.S                    |    9 
 b/Documentation/DocBook/Makefile            |   48 
 b/MAINTAINERS                               |   42 
 b/Makefile                                  |    2 
 b/arch/alpha/kernel/systbls.S               |    1 
 b/arch/arm26/ACKNOWLEDGEMENTS               |   27 
 b/arch/arm26/Config.help                    |  387 +++
 b/arch/arm26/Kconfig                        |  572 ++++
 b/arch/arm26/Makefile                       |  126 +
 b/arch/arm26/boot/Makefile                  |   69 
 b/arch/arm26/boot/compressed/Makefile       |   50 
 b/arch/arm26/boot/compressed/head.S         |  517 ++++
 b/arch/arm26/boot/compressed/hw-bse.c       |   74 
 b/arch/arm26/boot/compressed/ll_char_wr.S   |  162 +
 b/arch/arm26/boot/compressed/misc.c         |  316 ++
 b/arch/arm26/boot/compressed/ofw-shark.c    |  258 ++
 b/arch/arm26/boot/compressed/uncompress.h   |  111 
 b/arch/arm26/boot/compressed/vmlinux.lds.in |   60 
 b/arch/arm26/boot/install.sh                |   62 
 b/arch/arm26/config.in                      |  151 +
 b/arch/arm26/defconfig                      |  367 ++
 b/arch/arm26/kernel/Makefile                |   18 
 b/arch/arm26/kernel/arch.c                  |   30 
 b/arch/arm26/kernel/armksyms.c              |  233 +
 b/arch/arm26/kernel/asm-offsets.c           |   64 
 b/arch/arm26/kernel/compat.c                |  174 +
 b/arch/arm26/kernel/dma.c                   |  302 ++
 b/arch/arm26/kernel/ecard.c                 |  899 +++++++
 b/arch/arm26/kernel/entry.S                 |  982 +++++++
 b/arch/arm26/kernel/fiq.c                   |  202 +
 b/arch/arm26/kernel/init_task.c             |   41 
 b/arch/arm26/kernel/irq.c                   |  705 +++++
 b/arch/arm26/kernel/process.c               |  414 +++
 b/arch/arm26/kernel/ptrace.c                |  747 ++++++
 b/arch/arm26/kernel/ptrace.h                |   13 
 b/arch/arm26/kernel/semaphore.c             |  215 +
 b/arch/arm26/kernel/setup.c                 |  581 ++++
 b/arch/arm26/kernel/signal.c                |  542 ++++
 b/arch/arm26/kernel/sys_arm.c               |  283 ++
 b/arch/arm26/kernel/time-acorn.c            |   69 
 b/arch/arm26/kernel/time.c                  |  202 +
 b/arch/arm26/kernel/traps.c                 |  553 ++++
 b/arch/arm26/lib/Makefile                   |   31 
 b/arch/arm26/lib/ashldi3.c                  |   61 
 b/arch/arm26/lib/ashrdi3.c                  |   61 
 b/arch/arm26/lib/backtrace.S                |  145 +
 b/arch/arm26/lib/changebit.S                |   28 
 b/arch/arm26/lib/clearbit.S                 |   31 
 b/arch/arm26/lib/copy_page.S                |   62 
 b/arch/arm26/lib/csumipv6.S                 |   32 
 b/arch/arm26/lib/csumpartial.S              |  130 +
 b/arch/arm26/lib/csumpartialcopy.S          |   52 
 b/arch/arm26/lib/csumpartialcopygeneric.S   |  352 ++
 b/arch/arm26/lib/csumpartialcopyuser.S      |  115 
 b/arch/arm26/lib/delay.S                    |   57 
 b/arch/arm26/lib/ecard.S                    |   41 
 b/arch/arm26/lib/findbit.S                  |   67 
 b/arch/arm26/lib/floppydma.S                |   32 
 b/arch/arm26/lib/gcclib.h                   |   21 
 b/arch/arm26/lib/getuser.S                  |  111 
 b/arch/arm26/lib/io-acorn.S                 |   71 
 b/arch/arm26/lib/io-readsb.S                |  116 
 b/arch/arm26/lib/io-readsl-armv3.S          |   78 
 b/arch/arm26/lib/io-readsw-armv3.S          |  107 
 b/arch/arm26/lib/io-writesb.S               |  122 
 b/arch/arm26/lib/io-writesl.S               |   56 
 b/arch/arm26/lib/io-writesw-armv3.S         |  127 +
 b/arch/arm26/lib/kbd.c                      |  279 ++
 b/arch/arm26/lib/lib1funcs.S                |  314 ++
 b/arch/arm26/lib/longlong.h                 |  184 +
 b/arch/arm26/lib/lshrdi3.c                  |   61 
 b/arch/arm26/lib/memchr.S                   |   25 
 b/arch/arm26/lib/memcpy.S                   |  318 ++
 b/arch/arm26/lib/memset.S                   |   80 
 b/arch/arm26/lib/memzero.S                  |   80 
 b/arch/arm26/lib/muldi3.c                   |   77 
 b/arch/arm26/lib/putuser.S                  |  108 
 b/arch/arm26/lib/setbit.S                   |   29 
 b/arch/arm26/lib/strchr.S                   |   25 
 b/arch/arm26/lib/strrchr.S                  |   25 
 b/arch/arm26/lib/testchangebit.S            |   29 
 b/arch/arm26/lib/testclearbit.S             |   29 
 b/arch/arm26/lib/testsetbit.S               |   29 
 b/arch/arm26/lib/uaccess-kernel.S           |  173 +
 b/arch/arm26/lib/uaccess-user.S             |  718 +++++
 b/arch/arm26/lib/ucmpdi2.c                  |   51 
 b/arch/arm26/lib/udivdi3.c                  |  242 +
 b/arch/arm26/machine/Makefile               |   12 
 b/arch/arm26/machine/arch.c                 |   36 
 b/arch/arm26/machine/dma.c                  |  215 +
 b/arch/arm26/machine/head.S                 |   93 
 b/arch/arm26/machine/irq.c                  |  165 +
 b/arch/arm26/machine/oldlatches.c           |   72 
 b/arch/arm26/machine/small_page.c           |  191 +
 b/arch/arm26/mm/Makefile                    |   12 
 b/arch/arm26/mm/extable.c                   |   40 
 b/arch/arm26/mm/fault.c                     |  318 ++
 b/arch/arm26/mm/fault.h                     |    5 
 b/arch/arm26/mm/init.c                      |  401 +++
 b/arch/arm26/mm/mm-memc.c                   |  204 +
 b/arch/arm26/mm/proc-funcs.S                |  359 ++
 b/arch/arm26/nwfpe/ARM-gcc.h                |  120 
 b/arch/arm26/nwfpe/ChangeLog                |   83 
 b/arch/arm26/nwfpe/Makefile                 |   15 
 b/arch/arm26/nwfpe/double_cpdo.c            |  288 ++
 b/arch/arm26/nwfpe/entry.S                  |  114 
 b/arch/arm26/nwfpe/extended_cpdo.c          |  273 ++
 b/arch/arm26/nwfpe/fpa11.c                  |  221 +
 b/arch/arm26/nwfpe/fpa11.h                  |   87 
 b/arch/arm26/nwfpe/fpa11.inl                |   51 
 b/arch/arm26/nwfpe/fpa11_cpdo.c             |  117 
 b/arch/arm26/nwfpe/fpa11_cpdt.c             |  368 ++
 b/arch/arm26/nwfpe/fpa11_cprt.c             |  289 ++
 b/arch/arm26/nwfpe/fpmodule.c               |  182 +
 b/arch/arm26/nwfpe/fpmodule.h               |   47 
 b/arch/arm26/nwfpe/fpmodule.inl             |   84 
 b/arch/arm26/nwfpe/fpopcode.c               |  148 +
 b/arch/arm26/nwfpe/fpopcode.h               |  372 +++
 b/arch/arm26/nwfpe/fpsr.h                   |  108 
 b/arch/arm26/nwfpe/milieu.h                 |   48 
 b/arch/arm26/nwfpe/single_cpdo.c            |  255 ++
 b/arch/arm26/nwfpe/softfloat-macros         |  740 ++++++
 b/arch/arm26/nwfpe/softfloat-specialize     |  366 ++
 b/arch/arm26/nwfpe/softfloat.c              | 3439 ++++++++++++++++++++++++++++
 b/arch/arm26/nwfpe/softfloat.h              |  232 +
 b/arch/arm26/vmlinux-armo.lds.in            |  128 +
 b/arch/arm26/vmlinux.lds.S                  |   12 
 b/drivers/char/mem.c                        |    2 
 b/include/asm-alpha/ptrace.h                |   11 
 b/include/asm-alpha/unistd.h                |    3 
 b/include/asm-arm26/a.out.h                 |   38 
 b/include/asm-arm26/arch.h                  |   62 
 b/include/asm-arm26/assembler.h             |  106 
 b/include/asm-arm26/atomic.h                |  115 
 b/include/asm-arm26/bitops.h                |  349 ++
 b/include/asm-arm26/bug.h                   |   21 
 b/include/asm-arm26/bugs.h                  |   15 
 b/include/asm-arm26/byteorder.h             |   24 
 b/include/asm-arm26/cache.h                 |   19 
 b/include/asm-arm26/cacheflush.h            |   44 
 b/include/asm-arm26/calls.h                 |  262 ++
 b/include/asm-arm26/checksum.h              |  158 +
 b/include/asm-arm26/constants.h             |   29 
 b/include/asm-arm26/current.h               |   15 
 b/include/asm-arm26/delay.h                 |   34 
 b/include/asm-arm26/div64.h                 |   14 
 b/include/asm-arm26/dma.h                   |  184 +
 b/include/asm-arm26/ecard.h                 |  291 ++
 b/include/asm-arm26/elf.h                   |   77 
 b/include/asm-arm26/errno.h                 |    6 
 b/include/asm-arm26/fcntl.h                 |   86 
 b/include/asm-arm26/fiq.h                   |   37 
 b/include/asm-arm26/floppy.h                |  141 +
 b/include/asm-arm26/fpstate.h               |   29 
 b/include/asm-arm26/hardirq.h               |   93 
 b/include/asm-arm26/hardware.h              |  109 
 b/include/asm-arm26/hdreg.h                 |   15 
 b/include/asm-arm26/ian_char.h              |   79 
 b/include/asm-arm26/ide.h                   |   75 
 b/include/asm-arm26/io.h                    |  419 +++
 b/include/asm-arm26/ioc.h                   |   72 
 b/include/asm-arm26/ioctl.h                 |   74 
 b/include/asm-arm26/ioctls.h                |   81 
 b/include/asm-arm26/ipc.h                   |   28 
 b/include/asm-arm26/ipcbuf.h                |   29 
 b/include/asm-arm26/irq.h                   |   50 
 b/include/asm-arm26/irqchip.h               |  118 
 b/include/asm-arm26/keyboard.h.old          |   78 
 b/include/asm-arm26/kmap_types.h            |   12 
 b/include/asm-arm26/leds.h                  |   51 
 b/include/asm-arm26/limits.h                |   11 
 b/include/asm-arm26/linkage.h               |    7 
 b/include/asm-arm26/linux_logo.h            |   19 
 b/include/asm-arm26/locks.h                 |  161 +
 b/include/asm-arm26/mach-types.h            |   36 
 b/include/asm-arm26/map.h                   |   24 
 b/include/asm-arm26/mc146818rtc.h           |   28 
 b/include/asm-arm26/memory.h                |  101 
 b/include/asm-arm26/mman.h                  |   41 
 b/include/asm-arm26/mmu.h                   |    9 
 b/include/asm-arm26/mmu_context.h           |   51 
 b/include/asm-arm26/module.h                |   12 
 b/include/asm-arm26/msgbuf.h                |   31 
 b/include/asm-arm26/namei.h                 |   25 
 b/include/asm-arm26/oldlatches.h            |   37 
 b/include/asm-arm26/page.h                  |  115 
 b/include/asm-arm26/param.h                 |   37 
 b/include/asm-arm26/parport.h               |   18 
 b/include/asm-arm26/pci.h                   |    5 
 b/include/asm-arm26/percpu.h                |    6 
 b/include/asm-arm26/pgalloc.h               |   70 
 b/include/asm-arm26/pgtable.h               |  298 ++
 b/include/asm-arm26/poll.h                  |   25 
 b/include/asm-arm26/posix_types.h           |   81 
 b/include/asm-arm26/proc-fns.h              |   49 
 b/include/asm-arm26/processor.h             |  121 
 b/include/asm-arm26/procinfo.h              |   56 
 b/include/asm-arm26/ptrace.h                |  103 
 b/include/asm-arm26/resource.h              |   47 
 b/include/asm-arm26/rmap.h                  |   66 
 b/include/asm-arm26/scatterlist.h           |   26 
 b/include/asm-arm26/segment.h               |   11 
 b/include/asm-arm26/semaphore-helper.h      |   84 
 b/include/asm-arm26/semaphore.h             |  128 +
 b/include/asm-arm26/sembuf.h                |   25 
 b/include/asm-arm26/serial.h                |   65 
 b/include/asm-arm26/setup.h                 |  205 +
 b/include/asm-arm26/shmbuf.h                |   42 
 b/include/asm-arm26/shmparam.h              |   15 
 b/include/asm-arm26/sigcontext.h            |   33 
 b/include/asm-arm26/siginfo.h               |    6 
 b/include/asm-arm26/signal.h                |  201 +
 b/include/asm-arm26/sizes.h                 |   52 
 b/include/asm-arm26/smp.h                   |   10 
 b/include/asm-arm26/socket.h                |   64 
 b/include/asm-arm26/sockios.h               |   12 
 b/include/asm-arm26/softirq.h               |   20 
 b/include/asm-arm26/spinlock.h              |    6 
 b/include/asm-arm26/stat.h                  |   79 
 b/include/asm-arm26/statfs.h                |   25 
 b/include/asm-arm26/string.h                |   43 
 b/include/asm-arm26/suspend.h               |    4 
 b/include/asm-arm26/sysirq.h                |   61 
 b/include/asm-arm26/system.h                |  204 +
 b/include/asm-arm26/termbits.h              |  170 +
 b/include/asm-arm26/termios.h               |  108 
 b/include/asm-arm26/thread_info.h           |  144 +
 b/include/asm-arm26/timex.h                 |   31 
 b/include/asm-arm26/tlb.h                   |   62 
 b/include/asm-arm26/tlbflush.h              |   70 
 b/include/asm-arm26/topology.h              |    6 
 b/include/asm-arm26/types.h                 |   59 
 b/include/asm-arm26/uaccess-asm.h           |  151 +
 b/include/asm-arm26/uaccess.h               |  260 ++
 b/include/asm-arm26/ucontext.h              |   12 
 b/include/asm-arm26/unaligned.h             |  118 
 b/include/asm-arm26/uncompress.h            |  111 
 b/include/asm-arm26/unistd.h                |  481 +++
 b/include/asm-arm26/user.h                  |   84 
 b/include/asm-arm26/xor.h                   |  141 +
 b/include/linux/zconf.h                     |    2 
 b/include/linux/zlib.h                      |   18 
 b/include/linux/zutil.h                     |    9 
 b/lib/zlib_deflate/deflate.c                |   72 
 b/lib/zlib_deflate/deftree.c                |   88 
 b/lib/zlib_inflate/infblock.c               |   20 
 b/lib/zlib_inflate/infcodes.c               |   10 
 b/lib/zlib_inflate/inffast.c                |   45 
 b/lib/zlib_inflate/inflate.c                |   34 
 b/lib/zlib_inflate/inftrees.c               |   23 
 b/lib/zlib_inflate/infutil.c                |    4 
 drivers/net/sis900.c                        |   72 
 include/asm-alpha/string.h                  |    1 
 include/asm-alpha/uaccess.h                 |   69 
 include/asm-alpha/unaligned.h               |    2 
 kernel/kmod.c                               |    2 
 lib/zlib_inflate/inffixed.h                 |    8 
 scripts/docproc.c                           |    2 
 scripts/kernel-doc                          |   15 
 265 files changed, 34906 insertions(+), 359 deletions(-)

