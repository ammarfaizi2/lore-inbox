Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268646AbUJDVsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268646AbUJDVsU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUJDVre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:47:34 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:53181 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S268660AbUJDVnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:43:09 -0400
Subject: Re: [PATCH] set membase in serial8250_request_port
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041004220419.C21216@flint.arm.linux.org.uk>
References: <1096916062.4510.20.camel@tdi>
	 <20041004220419.C21216@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: LOSL
Date: Mon, 04 Oct 2004 15:43:03 -0600
Message-Id: <1096926184.4510.54.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 22:04 +0100, Russell King wrote:
> On Mon, Oct 04, 2004 at 12:54:22PM -0600, Alex Williamson wrote:
> > 
> >    I'm running into a problem that seems to be caused by this really old
> > changeset:
> > 
> > http://linux.bkbits.net:8080/linux-2.5/cset@3d9f67f2BWvXiLsZCFwD-8s_E9AN6A
> > 
> > When I run 'setserial /dev/ttyS1 uart 16450' on an ia64 system w/ MMIO
> > UARTs, I get a NAT consumption oops from the kernel.  The problem is
> > that this code path calls serial8250_release_port() where the membase
> > gets cleared.  However, the subsequent call to serial8250_request_port()
> > doesn't restore membase, causing a read from a bad address.  I don't see
> > many users of the UPF_IOREMAP flag, so I think the solution is to simply
> > make the remap case symmetric to the unmap case.  Patch below.  Thanks,
> 
> Mostly correct reasoning, but the solution is wrong.  Consider what
> happens if we call request_port where we have set mapbase and pre-
> initialised membase for a memory mapped port (eg, PCI card.)
> 
> This would cause us to re-ioremap the mapbase, which is wrong.  We
> must obey the UPF_IOREMAP flag here.  Note also that this fix you're
> reverting will break 8250 for PPC people...
> 
> Could you give further information about the problem you're seeing?
> Bear in mind that I know precisely zero about ia64 oopsen so you'll
> probably have to explain it to me in detail.

   Sure.  I've see the problem on any MMIO UART on my box:

# cat /proc/tty/driver/serial 
serinfo:1.0 driver revision:
0: uart:16550A mmio:0xFF5E0000 irq:49 tx:5327 rx:67 RTS|CTS|DTR|DSR|CD
1: uart:16550A mmio:0xFF5E2000 irq:66 tx:0 rx:0
2: uart:16550A mmio:0xF8031000 irq:64 tx:0 rx:0
3: uart:16550A mmio:0xF8030000 irq:64 tx:0 rx:0
4: uart:16550A mmio:0xF8030010 irq:64 tx:0 rx:0
5: uart:16550A mmio:0xF8030038 irq:64 tx:0 rx:0

The first 2 are dangling off a platform bus, not on PCI.  They're
discovered via the 8250_acpi code (or the first one may be found via the
pcdp setup).  The last 4 are in PCI space and handled by 8250_pci.

   Using setserial to poke the uart type on a devices produces something
like this:

# setserial /dev/ttyS2 uart 16450
setserial[1540]: NaT consumption 17179869216 [1]
Modules linked in:

Pid: 1540, CPU 1, comm:            setserial
psr : 0000101008026018 ifs : 8000000000000002 ip  : [<a0000001003035a0>]
Not 
tainted
ip is at __ia64_readb+0x0/0x20
unat: 0000000000000000 pfs : 0000000000000389 rsc : 0000000000000003
rnat: e0000001004ac458 bsps: e0000001004ac668 pr  : 0a40000000169969
ldrs: 0000000000000000 ccv : 0000000000000202 fpsr: 0009804c0270033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001003ab670 b6  : a000000100002d70 b7  : a0000001003035a0
f6  : 1003e6db6db6db6db6db7 f7  : 000000000000000000000
f8  : 1003e000000000000ef6a f9  : 1003e0000000000068be6
f10 : 1003e0000000051eb851f f11 : 1003e0000000000080000
r1  : a000000100ad35a0 r2  : 0000000000000000 r3  : a000000100a7da6b
r8  : a000000100a7da6a r9  : 0000000000000006 r10 : a000000100662cd0
r11 : 0000000000000002 r12 : e00000003bf27d70 r13 : e00000003bf20000
r14 : 0000000000000002 r15 : a000000100a7db55 r16 : 0000000000000002
r17 : a0000001008d6d60 r18 : 0000000000008f46 r19 : 0000000000000000
r20 : a0000001006bff58 r21 : a0000001003035a0 r22 : 0000000000000000
r23 : 0000000000000005 r24 : a0000001008eabb0 r25 : a000000100a7da58
r26 : a0000001008eaac0 r27 : a0000001008eaac0 r28 : e00000003bf27d88
r29 : e00000000310d028 r30 : 0000000000000001 r31 : e00000003bf27d84

Call Trace:
 [<a0000001000168e0>] show_stack+0x80/0xa0
                                sp=e00000003bf278c0 bsp=e00000003bf21310
 [<a000000100017140>] show_regs+0x7e0/0x800
                                sp=e00000003bf27a90 bsp=e00000003bf212b0
 [<a00000010003a8b0>] die+0x150/0x1c0
                                sp=e00000003bf27aa0 bsp=e00000003bf21270
 [<a00000010003a960>] die_if_kernel+0x40/0x60
                                sp=e00000003bf27aa0 bsp=e00000003bf21240
 [<a00000010003b570>] ia64_fault+0x150/0xa40
                                sp=e00000003bf27aa0 bsp=e00000003bf211f0
 [<a00000010000e7e0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003bf27ba0 bsp=e00000003bf211f0
 [<a0000001003035a0>] __ia64_readb+0x0/0x20
                                sp=e00000003bf27d70 bsp=e00000003bf211e0
 [<a0000001003ab670>] serial_in+0x210/0x220
                                sp=e00000003bf27d70 bsp=e00000003bf211a8
 [<a0000001003aea60>] serial8250_startup+0xc0/0x740
                                sp=e00000003bf27d70 bsp=e00000003bf21170
 [<a0000001003a3900>] uart_startup+0x240/0x440
                                sp=e00000003bf27d70 bsp=e00000003bf21120
 [<a0000001003a55d0>] uart_set_info+0x3f0/0xb40
                                sp=e00000003bf27d90 bsp=e00000003bf21038
 [<a0000001003a70b0>] uart_ioctl+0x2f0/0x3a0
                                sp=e00000003bf27e20 bsp=e00000003bf20fe8
 [<a000000100370500>] tty_ioctl+0x780/0xa20
                                sp=e00000003bf27e20 bsp=e00000003bf20f90
 [<a00000010014c430>] sys_ioctl+0x270/0x720
                                sp=e00000003bf27e20 bsp=e00000003bf20f00
 [<a00000010000e660>] ia64_ret_from_syscall+0x0/0x20
                                sp=e00000003bf27e30 bsp=e00000003bf20f00


   I instrumented serial_in/serial_out to see what what happening (this
time for ttyS1):

# setserial /dev/ttyS1 uart 16450
serial_out() -> writeb(0x1, 0xc0000000ff5e2002)
serial_out() -> writeb(0x7, 0xc0000000ff5e2002)
serial_out() -> writeb(0x0, 0xc0000000ff5e2002)
serial_in() -> readb(0xc0000000ff5e2005)
serial_in() -> readb(0xc0000000ff5e2000)
serial_in() -> readb(0xc0000000ff5e2002)
serial_in() -> readb(0xc0000000ff5e2006)
serial_in() -> readb(0xc0000000ff5e2005)
serial_out() -> writeb(0x3, 0xc0000000ff5e2003)
serial_out() -> writeb(0x8, 0xc0000000ff5e2004)
serial_out() -> writeb(0x5, 0xc0000000ff5e2001)
serial_in() -> readb(0xc0000000ff5e2005)
serial_in() -> readb(0xc0000000ff5e2000)
serial_in() -> readb(0xc0000000ff5e2002)
serial_in() -> readb(0xc0000000ff5e2006)
serial_out() -> writeb(0x5, 0xc0000000ff5e2001)
serial_out() -> writeb(0x93, 0xc0000000ff5e2003)
serial_out() -> writeb(0xc, 0xc0000000ff5e2000)
serial_out() -> writeb(0x0, 0xc0000000ff5e2001)
serial_out() -> writeb(0x13, 0xc0000000ff5e2003)
serial_out() -> writeb(0x1, 0xc0000000ff5e2002)
serial_out() -> writeb(0x81, 0xc0000000ff5e2002)
serial_out() -> writeb(0x8, 0xc0000000ff5e2004)
serial_out() -> writeb(0xb, 0xc0000000ff5e2004)
serial_out() -> writeb(0x8, 0xc0000000ff5e2004)
serial_out() -> writeb(0x0, 0xc0000000ff5e2001)
serial_out() -> writeb(0x0, 0xc0000000ff5e2004)
serial_in() -> readb(0xc0000000ff5e2003)
serial_out() -> writeb(0x13, 0xc0000000ff5e2003)
serial_out() -> writeb(0x1, 0xc0000000ff5e2002)
serial_out() -> writeb(0x7, 0xc0000000ff5e2002)
serial_out() -> writeb(0x0, 0xc0000000ff5e2002)
serial_in() -> readb(0xc0000000ff5e2000)
serial_in() -> readb(0x5)

   As you can see, we completely lost membase between the last 2 reads
and are only dealing with the offset.  This is what causes the stack
trace in the readb().  I suspect a PCI MMIO UART would fail just as
badly on other architectures as well.  Is PPC somehow dependent on the
UPF_IOREMAP flag, or would it be sufficient to check that membase is
NULL before calling ioremap?  I see exactly one instance of a driver
setting UPF_IOREMAP, which is why I took the path I did.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

