Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266220AbSKEEUc>; Mon, 4 Nov 2002 23:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265279AbSKEEUc>; Mon, 4 Nov 2002 23:20:32 -0500
Received: from modemcable074.85-202-24.mtl.mc.videotron.ca ([24.202.85.74]:35848
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266220AbSKEEU0>; Mon, 4 Nov 2002 23:20:26 -0500
Date: Mon, 4 Nov 2002 23:27:28 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Russell King <rmk@arm.linux.org.uk>
Subject: 2.5.45 odd deref in serial_in 
Message-ID: <Pine.LNX.4.44.0211042323410.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only modifications to this code are a slightly hacked up nmi watchdog 
timer.

Unable to handle kernel paging request at virtual address 81acc58
 printing eip:
c023b42f
*pde = 00000000
Oops: 0000
 
CPU:    0
EIP:    0060:[<c023b42f>]    Not tainted
EFLAGS: 00010293
EIP is at serial_in+0x1f/0x60
eax: 00000000   ebx: 81acc5f0   ecx: 00000000   edx: 00000005
esi: 000026e9   edi: c065a6e0   ebp: c06242ae   esp: c1471ebc
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=c1470000 task=c7f9e040)
Stack: 00000020 c023d9d8 c065a6e0 00000005 00000008 00000000 0000001d c05c0 
       0000001d c06242a6 00000b23 c0121459 c05c0880 c06242a6 0000001d 00000 
       00000b43 00000296 c0121541 00000b26 00000b43 00000006 00000b43 c1470 
Call Trace:
 [<c023d9d8>] serial8250_console_write+0x68/0x1f0
 [<c0121459>] __call_console_drivers+0x49/0x50
 [<c0121541>] call_console_drivers+0x71/0x100
 [<c012196d>] release_console_sem+0xbd/0x170
 [<c01217cc>] printk+0x18c/0x220
 [<c01170d5>] nmi_add_task+0xc5/0xe0
 [<c01177e0>] nmi_watchdog_tick+0x0/0x120
 [<c01050a1>] init+0x71/0x1a0
 [<c0105030>] init+0x0/0x1a0
 [<c0105030>] init+0x0/0x1a0
 [<c0105030>] init+0x0/0x1a0
 [<c01072b5>] kernel_thread_helper+0x5/0x10

Code: 8b 43 08 01 c2 ec 25 ff 00 00 00 5b c3 8d 74 26 00 68 ad 00 
 <0>Kernel panic: Attempted to kill init!

(gdb) list *serial_in+0x1f
0xc023b42f is in serial_in (include/asm/io.h:371).
366     } \
367     static inline void ins##bwl(int port, void *addr, unsigned long count) { \
368             __asm__ __volatile__("rep; ins" #bwl : "+D"(addr), "+c"(count) : "d"(port)); \
369     }
370
371     BUILDIO(b,b,char)
372     BUILDIO(w,w,short)
373     BUILDIO(l,,int)
374
375     #endif

0xc023b428 <serial_in+24>:      je     0xc023b461 <serial_in+81>
0xc023b42a <serial_in+26>:      cmp    $0x2,%eax
0xc023b42d <serial_in+29>:      je     0xc023b440 <serial_in+48>
0xc023b42f <serial_in+31>:      mov    0x8(%ebx),%eax
0xc023b432 <serial_in+34>:      add    %eax,%edx
0xc023b434 <serial_in+36>:      in     (%dx),%al

eax: 00000000   ebx: 81acc5f0   ecx: 00000000   edx: 00000005

...
	default:
		return inb(up->port.iobase + offset); <--
	}
}

-- 
function.linuxpower.ca

