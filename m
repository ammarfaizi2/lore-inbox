Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267096AbSK2QGm>; Fri, 29 Nov 2002 11:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267097AbSK2QGm>; Fri, 29 Nov 2002 11:06:42 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:18227
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267096AbSK2QGk>; Fri, 29 Nov 2002 11:06:40 -0500
Date: Fri, 29 Nov 2002 11:17:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [BUG][2.5.50] kallsyms dies badly with module
Message-ID: <Pine.LNX.4.50.0211291105440.14410-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,
	If kallsyms_lookup tries to get a symbol from tiglusb.c loaded as
a module it oopses.

sysrq T
...
tcsh          R current      0  1447   1445                     (NOTLB)
Call Trace:
 [<c0129ef1>] del_timer_sync+0x1/0x90
 [<c012a68f>] schedule_timeout+0x6f/0xc0
 [<c012a610>] process_timeout+0x0/0x10
 [<d0878ab4>] <1>Unable to handle kernel paging request at virtual address d086e4d8
 printing eip:
c013653c
*pde = 0fef4067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c013653c>]    Not tainted
EFLAGS: 00010286
EIP is at __print_symbol+0x3c/0x100
eax: 00000000   ebx: d0878ab4   ecx: ffffffff   edx: d087600c
esi: d086e4d8   edi: d086e4d8   ebp: ccf21c1c   esp: ccf21bec
ds: 0068   es: 0068   ss: 0068
Process tcsh (pid: 1447, threadinfo=ccf20000 task=cdebe120)
Stack: ffffc56e ccf21bec 00000e74 00000054 d087600c 0000000e ccf21c40 c0122d4c
       d0878ab4 d0878ab4 cdebe120 00000006 ccf21c40 c010a7a4 c046a0ef d0878ab4
       cdebe120 c011e5eb ccf21f04 c052b5d8 00000074 00000001 c026c28e 00000074
Call Trace:
 [<c0122d4c>] printk+0x18c/0x220
[<d0878ab4>] <1>Unable to handle kernel paging request at virtual address d086e4d8
 printing eip:

...

Until it finally deadlocks in the page fault handler. Basically it will
keep getting an invalid page fault on any of the driver's symbols. The
first oops was in strlen;

0xc013653c is in __print_symbol (include/asm/string.h:184).
179     #define __HAVE_ARCH_STRLEN
180     static inline size_t strlen(const char * s)
181     {
182     int d0;
183     register int __res;
184     __asm__ __volatile__(
185             "repne\n\t"
186             "scasb\n\t"
187             "notl %0\n\t"
188             "decl %0"

0xc0136537 <__print_symbol+55>: or     $0xffffffff,%ecx
0xc013653a <__print_symbol+58>: mov    %esi,%edi
0xc013653c <__print_symbol+60>: repnz scas %es:(%edi),%al
0xc013653e <__print_symbol+62>: not    %ecx

eax: 00000000   ebx: d0878ab4   ecx: ffffffff   edx: d087600c
esi: d086e4d8   edi: d086e4d8   ebp: ccf21c1c   esp: ccf21bec
ds: 0068   es: 0068   ss: 0068

nm -n of tiglusb.o is below, and according to a printk, tiglusb_open
starts at 0xd0928000;

         U copy_from_user
         U copy_to_user
         U __down_failed
         U __down_failed_interruptible
         U __might_sleep
         U no_llseek
         U printk
         U register_chrdev
         U schedule_timeout
         U sleep_on
         U sprintf
         U __this_module
         U unregister_chrdev
         U __up_wakeup
         U usb_bulk_msg
         U usb_clear_halt
         U usb_deregister
         U usb_register
         U usb_set_configuration
         U __wake_up
00000000 T __exitfn
00000000 T __initfn
00000000 D __module_name
00000000 r __module_usb_device_size
00000000 b tiglusb
00000000 t tiglusb_cleanup
00000000 t tiglusb_init
00000000 t tiglusb_open
00000000 d timeout
00000020 d tiglusb_fops
00000080 d tiglusb_ids
000000a8 d __module_usb_device_table
000000c0 d tiglusb_driver
00000120 t tiglusb_release
000001c0 t tiglusb_read
00000320 t tiglusb_write
00000480 t tiglusb_ioctl
00000500 b devfs_handle
000005d0 t tiglusb_probe
00000720 t tiglusb_disconnect
000007d0 t __constant_c_and_count_memset
0000085c t .text.lock.tiglusb


Any information on how to further debug this would be appreciated as i'm
not familiar with the kallsyms innards.

Cheers,
	Zwane
-- 
function.linuxpower.ca
