Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbUB0PtY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 10:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbUB0PtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 10:49:24 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:43280 "EHLO
	usmimesweeper.bluearc.com") by vger.kernel.org with ESMTP
	id S262875AbUB0PtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 10:49:12 -0500
Message-ID: <AD4480A509455343AEFACCC231BA850FF0FF75@ukexchange>
From: Martin Dorey <mdorey@bluearc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: init_dev accesses out-of-bounds tty index
Date: Fri, 27 Feb 2004 15:49:09 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton asked:

> That's a weird address.  Could you please enable CONFIG_DEBUG_SLAB and
> CONFIG_DEBUG_PAGEALLOC, see if you can make it happen again?

This is the relevant section from my new .config:

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
# CONFIG_DEBUG_IOVIRT is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_FRAME_POINTER=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

Chris Wright asked:

> can you recreate this w/out nvidia?

I'm no longer tainted (thanks for telling me how, off-list).

The crash wasn't quite the same this time - in particular, ext3_permission
has disappeared - but it's still init_dev out of dput (at least, the first
oops is):

Feb 27 11:43:03 doozer automount[20392]: mount(bind): mounted
/u/u57/Engineering/tdexport/extracted/5309 type bind on /t/5309
Feb 27 11:43:20 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:43:25 doozer kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000009b
Feb 27 11:43:25 doozer kernel:  printing eip:
Feb 27 11:43:25 doozer kernel: c0247554
Feb 27 11:43:25 doozer kernel: *pde = 00000000
Feb 27 11:43:25 doozer kernel: Oops: 0000 [#1]
Feb 27 11:43:25 doozer kernel: CPU:    1
Feb 27 11:43:25 doozer kernel: EIP:    0060:[init_dev+33/1332]    Not
tainted
Feb 27 11:43:25 doozer kernel: EFLAGS: 00010246
Feb 27 11:43:25 doozer kernel: EIP is at init_dev+0x21/0x534
Feb 27 11:43:25 doozer kernel: eax: ffffffff   ebx: c42cfe9c   ecx: c046a65c
edx: ffffffff
Feb 27 11:43:25 doozer kernel: esi: ffffffff   edi: ed426f6c   ebp: eca73ed4
esp: eca73e88
Feb 27 11:43:25 doozer kernel: ds: 007b   es: 007b   ss: 0068
Feb 27 11:43:25 doozer kernel: Process sh (pid: 20418, threadinfo=eca72000
task=cb4a19d0)
Feb 27 11:43:25 doozer kernel: Stack: ffffffff c17125f0 c17125f0 00000000
eca73ec0 c011e3e7 00000000 eca73ec0 
Feb 27 11:43:25 doozer kernel:        c0174e43 c0553098 ed426000 c17125f0
00000000 00000000 eca73ee0 00000292 
Feb 27 11:43:25 doozer kernel:        c42cfe9c ffffffff ed426f6c eca73f08
c0248473 ffffffff ffffffff eca73ef4 
Feb 27 11:43:25 doozer kernel: Call Trace:
Feb 27 11:43:25 doozer kernel:  [__change_page_attr+36/456]
__change_page_attr+0x24/0x1c8
Feb 27 11:43:25 doozer kernel:  [dput+36/607] dput+0x24/0x25f
Feb 27 11:43:25 doozer kernel:  [tty_open+149/878] tty_open+0x95/0x36e
Feb 27 11:43:25 doozer kernel:  [cdev_get+91/185] cdev_get+0x5b/0xb9
Feb 27 11:43:25 doozer kernel:  [chrdev_open+301/698]
chrdev_open+0x12d/0x2ba
Feb 27 11:43:25 doozer kernel:  [chrdev_open+0/698] chrdev_open+0x0/0x2ba
Feb 27 11:43:25 doozer kernel:  [dentry_open+336/545]
dentry_open+0x150/0x221
Feb 27 11:43:25 doozer kernel:  [filp_open+93/95] filp_open+0x5d/0x5f
Feb 27 11:43:25 doozer kernel:  [sys_open+85/133] sys_open+0x55/0x85
Feb 27 11:43:25 doozer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 27 11:43:25 doozer kernel: 
Feb 27 11:43:25 doozer kernel: Code: 8b 86 9c 00 00 00 8b 1c 90 85 db 74 62
8b 83 a0 00 00 00 a9 
Feb 27 11:43:29 doozer kernel:  <1>Unable to handle kernel paging request at
virtual address f06db004
Feb 27 11:43:29 doozer kernel:  printing eip:
Feb 27 11:43:29 doozer kernel: c0248738
Feb 27 11:43:29 doozer kernel: *pde = 0055f067
Feb 27 11:43:29 doozer kernel: Oops: 0000 [#2]
Feb 27 11:43:29 doozer kernel: CPU:    1
Feb 27 11:43:29 doozer kernel: EIP:    0060:[tty_open+858/878]    Not
tainted
Feb 27 11:43:29 doozer kernel: EFLAGS: 00010286
Feb 27 11:43:29 doozer kernel: EIP is at tty_open+0x35a/0x36e
Feb 27 11:43:29 doozer kernel: eax: f06db000   ebx: c42cfe9c   ecx: fffffffa
edx: 00008802
Feb 27 11:43:29 doozer kernel: esi: 00000000   edi: cf363f6c   ebp: dfbfff08
esp: dfbffedc
Feb 27 11:43:29 doozer kernel: ds: 007b   es: 007b   ss: 0068
Feb 27 11:43:29 doozer kernel: Process sh (pid: 20435, threadinfo=dfbfe000
task=dccfc9d0)
Feb 27 11:43:29 doozer kernel: Stack: cf363000 dfbffef4 c011e73a 8802e8d5
00500000 00000000 c01674a0 c0520100 
Feb 27 11:43:29 doozer kernel:        c42cfe9c 00000000 dfbfe000 dfbfff30
c01670d2 c42cfe9c cf363f6c dfbfff30 
Feb 27 11:43:29 doozer kernel:        c0520100 cf363f6c cf363f6c c42cfe9c
c0166fa5 dfbfff50 c015ce54 c42cfe9c 
Feb 27 11:43:29 doozer kernel: Call Trace:
Feb 27 11:43:29 doozer kernel:  [kernel_map_pages+49/93]
kernel_map_pages+0x31/0x5d
Feb 27 11:43:29 doozer kernel:  [cdev_get+91/185] cdev_get+0x5b/0xb9
Feb 27 11:43:29 doozer kernel:  [chrdev_open+301/698]
chrdev_open+0x12d/0x2ba
Feb 27 11:43:29 doozer kernel:  [chrdev_open+0/698] chrdev_open+0x0/0x2ba
Feb 27 11:43:29 doozer kernel:  [dentry_open+336/545]
dentry_open+0x150/0x221
Feb 27 11:43:29 doozer kernel:  [filp_open+93/95] filp_open+0x5d/0x5f
Feb 27 11:43:29 doozer kernel:  [sys_open+85/133] sys_open+0x55/0x85
Feb 27 11:43:29 doozer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 27 11:43:29 doozer kernel: 
Feb 27 11:43:29 doozer kernel: Code: 8b 70 04 80 ce 08 8b 40 08 89 45 f0 89
57 18 e9 11 fd ff ff 
Feb 27 11:43:41 doozer kernel:  <1>Unable to handle kernel paging request at
virtual address f06db004
Feb 27 11:43:41 doozer kernel:  printing eip:
Feb 27 11:43:41 doozer kernel: c0248738
Feb 27 11:43:41 doozer kernel: *pde = 0055f067
Feb 27 11:43:41 doozer kernel: Oops: 0000 [#3]
Feb 27 11:43:41 doozer kernel: CPU:    0
Feb 27 11:43:41 doozer kernel: EIP:    0060:[tty_open+858/878]    Not
tainted
Feb 27 11:43:41 doozer kernel: EFLAGS: 00010286
Feb 27 11:43:41 doozer kernel: EIP is at tty_open+0x35a/0x36e
Feb 27 11:43:41 doozer kernel: eax: f06db000   ebx: c42cfe9c   ecx: fffffffa
edx: 00008802
Feb 27 11:43:41 doozer kernel: esi: 00000000   edi: f4824f6c   ebp: d4a2bf08
esp: d4a2bedc
Feb 27 11:43:41 doozer kernel: ds: 007b   es: 007b   ss: 0068
Feb 27 11:43:41 doozer kernel: Process sh (pid: 20447, threadinfo=d4a2a000
task=d22289d0)
Feb 27 11:43:41 doozer kernel: Stack: f4824000 d4a2bef4 c011e73a 8802e8d5
00500000 00000000 c01674a0 c0520100 
Feb 27 11:43:41 doozer kernel:        c42cfe9c 00000000 d4a2a000 d4a2bf30
c01670d2 c42cfe9c f4824f6c d4a2bf30 
Feb 27 11:43:41 doozer kernel:        c0520100 f4824f6c f4824f6c c42cfe9c
c0166fa5 d4a2bf50 c015ce54 c42cfe9c 
Feb 27 11:43:41 doozer kernel: Call Trace:
Feb 27 11:43:41 doozer kernel:  [kernel_map_pages+49/93]
kernel_map_pages+0x31/0x5d
Feb 27 11:43:41 doozer kernel:  [cdev_get+91/185] cdev_get+0x5b/0xb9
Feb 27 11:43:41 doozer kernel:  [chrdev_open+301/698]
chrdev_open+0x12d/0x2ba
Feb 27 11:43:41 doozer kernel:  [chrdev_open+0/698] chrdev_open+0x0/0x2ba
Feb 27 11:43:41 doozer kernel:  [dentry_open+336/545]
dentry_open+0x150/0x221
Feb 27 11:43:41 doozer kernel:  [filp_open+93/95] filp_open+0x5d/0x5f
Feb 27 11:43:41 doozer kernel:  [sys_open+85/133] sys_open+0x55/0x85
Feb 27 11:43:41 doozer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 27 11:43:41 doozer kernel: 
Feb 27 11:43:41 doozer kernel: Code: 8b 70 04 80 ce 08 8b 40 08 89 45 f0 89
57 18 e9 11 fd ff ff 
Feb 27 11:43:52 doozer kernel:  <7>request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:44:24 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:44:51 doozer automount[20463]: running expiration on path
/b/billboxblue2
Feb 27 11:44:51 doozer automount[20463]: expired /b/billboxblue2
Feb 27 11:44:56 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:45:01 doozer /USR/SBIN/CRON[20469]: (martind) CMD (ping -c 4 kenny
> /dev/null || ~/bin/doozer-to-kenny)
Feb 27 11:45:28 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:46:00 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:47:04 doozer last message repeated 2 times
Feb 27 11:47:32 doozer kernel: Unable to handle kernel paging request at
virtual address f06db004
Feb 27 11:47:32 doozer kernel:  printing eip:
Feb 27 11:47:32 doozer kernel: c0248738
Feb 27 11:47:32 doozer kernel: *pde = 0055f067
Feb 27 11:47:32 doozer kernel: Oops: 0000 [#4]
Feb 27 11:47:32 doozer kernel: CPU:    0
Feb 27 11:47:32 doozer kernel: EIP:    0060:[tty_open+858/878]    Not
tainted
Feb 27 11:47:32 doozer kernel: EFLAGS: 00010286
Feb 27 11:47:32 doozer kernel: EIP is at tty_open+0x35a/0x36e
Feb 27 11:47:32 doozer kernel: eax: f06db000   ebx: c42cfe9c   ecx: fffffffa
edx: 00008802
Feb 27 11:47:32 doozer kernel: esi: 00000000   edi: d8d5ff6c   ebp: d2229f08
esp: d2229edc
Feb 27 11:47:32 doozer kernel: ds: 007b   es: 007b   ss: 0068
Feb 27 11:47:32 doozer kernel: Process sh (pid: 20502, threadinfo=d2228000
task=da62e9d0)
Feb 27 11:47:32 doozer kernel: Stack: d8d5f000 d2229ef4 c011e73a 8802e8d5
00500000 00000000 c01674a0 c0520100 
Feb 27 11:47:32 doozer kernel:        c42cfe9c 00000000 d2228000 d2229f30
c01670d2 c42cfe9c d8d5ff6c d2229f30 
Feb 27 11:47:32 doozer kernel:        c0520100 d8d5ff6c d8d5ff6c c42cfe9c
c0166fa5 d2229f50 c015ce54 c42cfe9c 
Feb 27 11:47:32 doozer kernel: Call Trace:
Feb 27 11:47:32 doozer kernel:  [kernel_map_pages+49/93]
kernel_map_pages+0x31/0x5d
Feb 27 11:47:32 doozer kernel:  [cdev_get+91/185] cdev_get+0x5b/0xb9
Feb 27 11:47:32 doozer kernel:  [chrdev_open+301/698]
chrdev_open+0x12d/0x2ba
Feb 27 11:47:32 doozer kernel:  [chrdev_open+0/698] chrdev_open+0x0/0x2ba
Feb 27 11:47:32 doozer kernel:  [dentry_open+336/545]
dentry_open+0x150/0x221
Feb 27 11:47:32 doozer kernel:  [filp_open+93/95] filp_open+0x5d/0x5f
Feb 27 11:47:32 doozer kernel:  [sys_open+85/133] sys_open+0x55/0x85
Feb 27 11:47:32 doozer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 27 11:47:32 doozer kernel: 
Feb 27 11:47:32 doozer kernel: Code: 8b 70 04 80 ce 08 8b 40 08 89 45 f0 89
57 18 e9 11 fd ff ff 
Feb 27 11:47:36 doozer kernel:  <7>request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:48:08 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:48:13 doozer automount[20514]: running expiration on path /u/u57
Feb 27 11:48:13 doozer automount[20514]: expired /u/u57
Feb 27 11:48:30 doozer automount[20517]: running expiration on path /t/5309
Feb 27 11:48:30 doozer automount[20517]: expired /t/5309
Feb 27 11:48:40 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:49:12 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:49:44 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:49:51 doozer automount[20539]: running expiration on path
/b/billboxblue2
Feb 27 11:49:51 doozer automount[20539]: expired /b/billboxblue2
Feb 27 11:50:01 doozer /USR/SBIN/CRON[20541]: (martind) CMD (ping -c 4 kenny
> /dev/null || ~/bin/doozer-to-kenny)
Feb 27 11:50:16 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:50:48 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:51:52 doozer last message repeated 2 times
Feb 27 11:52:56 doozer last message repeated 2 times
Feb 27 11:53:01 doozer /USR/SBIN/CRON[20581]: (mail) CMD (  if [ -x
/usr/sbin/exim -a -f /etc/exim/exim.conf ]; then /usr/sbin/exim -q ; fi)
Feb 27 11:53:28 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:54:00 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:54:32 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:54:51 doozer automount[20605]: running expiration on path
/b/billboxblue2
Feb 27 11:54:51 doozer automount[20605]: expired /b/billboxblue2
Feb 27 11:55:01 doozer /USR/SBIN/CRON[20607]: (martind) CMD (ping -c 4 kenny
> /dev/null || ~/bin/doozer-to-kenny)
Feb 27 11:55:04 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:55:36 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:56:40 doozer last message repeated 2 times
Feb 27 11:56:47 doozer in.telnetd[20636]: connect from 10.1.2.50
Feb 27 11:57:12 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 27 11:57:15 doozer kernel: Unable to handle kernel paging request at
virtual address f06db004
Feb 27 11:57:15 doozer kernel:  printing eip:
Feb 27 11:57:15 doozer kernel: c0248738
Feb 27 11:57:15 doozer kernel: *pde = 0055f067
Feb 27 11:57:15 doozer kernel: Oops: 0000 [#5]
Feb 27 11:57:15 doozer kernel: CPU:    1
Feb 27 11:57:15 doozer kernel: EIP:    0060:[tty_open+858/878]    Not
tainted
Feb 27 11:57:15 doozer kernel: EFLAGS: 00010286
Feb 27 11:57:15 doozer kernel: EIP is at tty_open+0x35a/0x36e
Feb 27 11:57:15 doozer kernel: eax: f06db000   ebx: c42cfe9c   ecx: fffffffa
edx: 00008802
Feb 27 11:57:15 doozer kernel: esi: 00000000   edi: ee5b6f6c   ebp: da517f08
esp: da517edc
Feb 27 11:57:15 doozer kernel: ds: 007b   es: 007b   ss: 0068
Feb 27 11:57:15 doozer kernel: Process sh (pid: 20647, threadinfo=da516000
task=efe529d0)
Feb 27 11:57:15 doozer kernel: Stack: ee5b6000 da517ef4 c011e73a 8802e8d5
00500000 00000000 c01674a0 c0520100 
Feb 27 11:57:15 doozer kernel:        c42cfe9c 00000000 da516000 da517f30
c01670d2 c42cfe9c ee5b6f6c da517f30 
Feb 27 11:57:15 doozer kernel:        c0520100 ee5b6f6c ee5b6f6c c42cfe9c
c0166fa5 da517f50 c015ce54 c42cfe9c 
Feb 27 11:57:15 doozer kernel: Call Trace:
Feb 27 11:57:15 doozer kernel:  [kernel_map_pages+49/93]
kernel_map_pages+0x31/0x5d
Feb 27 11:57:15 doozer kernel:  [cdev_get+91/185] cdev_get+0x5b/0xb9
Feb 27 11:57:15 doozer kernel:  [chrdev_open+301/698]
chrdev_open+0x12d/0x2ba
Feb 27 11:57:15 doozer kernel:  [chrdev_open+0/698] chrdev_open+0x0/0x2ba
Feb 27 11:57:15 doozer kernel:  [dentry_open+336/545]
dentry_open+0x150/0x221
Feb 27 11:57:15 doozer kernel:  [filp_open+93/95] filp_open+0x5d/0x5f
Feb 27 11:57:15 doozer kernel:  [sys_open+85/133] sys_open+0x55/0x85
Feb 27 11:57:15 doozer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 27 11:57:15 doozer kernel: 
Feb 27 11:57:15 doozer kernel: Code: 8b 70 04 80 ce 08 8b 40 08 89 45 f0 89
57 18 e9 11 fd ff ff 
Feb 27 11:58:27 doozer syslogd 1.4.1#13: restart.

(gdb) x/10i init_dev
0xc0247533 <init_dev at drivers/char/tty_io.c:789>:     push   %ebp
0xc0247534 <init_dev+1 at drivers/char/tty_io.c:789>:   mov    %esp,%ebp
0xc0247536 <init_dev+3 at drivers/char/tty_io.c:789>:   push   %edi
0xc0247537 <init_dev+4 at drivers/char/tty_io.c:789>:   push   %esi
0xc0247538 <init_dev+5 at drivers/char/tty_io.c:789>:   push   %ebx
0xc0247539 <init_dev+6 at drivers/char/tty_io.c:789>:   sub    $0x40,%esp
0xc024753c <init_dev+9 at drivers/char/tty_io.c:793>:   movl
$0x0,0xffffffcc(%ebp)
0xc0247543 <init_dev+16 at drivers/char/tty_io.c:799>:  mov
0xc(%ebp),%eax
0xc0247546 <init_dev+19 at drivers/char/tty_io.c:789>:  mov
0x8(%ebp),%esi
0xc0247549 <init_dev+22 at drivers/char/tty_io.c:799>:  mov    %eax,(%esp,1)
(gdb) 
0xc024754c <init_dev+25 at drivers/char/tty_io.c:799>:  call   0xc0247505
<down_tty_sem at drivers/char/tty_io.c:765>
0xc0247551 <init_dev+30 at drivers/char/tty_io.c:802>:  mov
0xc(%ebp),%edx
0xc0247554 <init_dev+33 at drivers/char/tty_io.c:802>:  mov
0x9c(%esi),%eax

787     static int init_dev(struct tty_driver *driver, int idx,
788             struct tty_struct **ret_tty)
789     {
790             struct tty_struct *tty, *o_tty;
791             struct termios *tp, **tp_loc, *o_tp, **o_tp_loc;
792             struct termios *ltp, **ltp_loc, *o_ltp, **o_ltp_loc;
793             int retval=0;
794     
795             /* 
796              * Check whether we need to acquire the tty semaphore to
avoid
797              * race conditions.  For now, play it safe.
798              */
799             down_tty_sem(idx);
800     
801             /* check whether we're reopening an existing tty */
802             tty = driver->ttys[idx];
803             if (tty) goto fast_track;

I don't want to spam the list with another copy of all the info I posted
before, so I'll just note that this is kernel 2.6.2 compiled with gcc 3.3.3,
running Debian testing/unstable.

-- 


*********************************************************************
This e-mail and any attachment is confidential. It may only be read, copied and used by the intended recipient(s). If you are not the intended recipient(s), you may not copy, use, distribute, forward, store or disclose this e-mail or any attachment. If you are not the intended recipient(s) or have otherwise received this e-mail in error, you should destroy it and any attachment and notify the sender by reply e-mail or send a message to sysadmin@bluearc.com
*********************************************************************

