Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVADOn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVADOn6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVADOn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:43:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28428 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261660AbVADOnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:43:53 -0500
Date: Tue, 4 Jan 2005 14:43:50 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.6.10-bkcurr: major slab corruption preventing booting on ARM
Message-ID: <20050104144350.A22890@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've had a report from a fellow ARM hacker of their platform not
booting.  After they turned on slab debugging, they saw (pieced
together from a report on IRC):

Freeing init memory: 104K
run_init_process(/bin/bash)
Slab corruption: start=c0010934, len=160
Last user: [<c00adc54>](d_alloc+0x28/0x2d8)

I've just run up 2.6.10-bkcurr on a different ARM platform, and
encountered the following output.  It looks like there's serious
slab corruption issues in these kernels.

I'll dig a little further into the report below to see if there's
anything obvious.

Starting up networking
eth0: link down
eth0: link up, 10Mbps, half-duplex, lpa 0x0021
Starting network services
slab: Internal list corruption detected in cache 'buffer_head'(63), slabp c7912000(16). Hexdump:

000: 00 01 10 00 00 02 20 00 14 01 00 00 14 21 91 c7
010: 10 00 00 00 10 00 00 00 fe ff ff ff fe ff ff ff
020: fe ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff
030: fe ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff
040: fe ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff
050: fe ff ff ff fe ff ff ff 11 00 00 00 12 00 00 00
060: 13 00 00 00 14 00 00 00 15 00 00 00 16 00 00 00
070: 17 00 00 00 0a 60 6b 6b 19 00 00 00 1a 00 00 00
080: 1b 00 00 00 1c 00 00 00 1d 00 00 00 1e 00 00 00
090: 1f 00 00 00 20 00 00 00 21 00 00 00 22 00 00 00
0a0: 23 00 00 00 24 00 00 00 25 00 00 00 26 00 00 00
0b0: 27 00 00 00 28 00 00 00 29 00 00 00 2a 00 00 00
0c0: 2b 00 00 00 2c 00 00 00 2d 00 00 00 2e 00 00 00
0d0: 2f 00 00 00 30 00 00 00 31 00 00 00 32 00 00 00
0e0: 33 00 00 00 34 00 00 00 35 00 00 00 36 00 00 00
0f0: 37 00 00 00 38 00 00 00 39 00 00 00 3a 00 00 00
kernel BUG at /home/rmk/build/linux-v2.6-local/mm/slab.c:1977!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 817 [#1]
Modules linked in:
CPU: 0
PC is at __bug+0x40/0x54
LR is at 0x1
pc : [<c00263f8>]    lr : [<00000001>]    Not tainted
sp : c03c5ee4  ip : 60000093  fp : c03c5ef4
r10: 00000007  r9 : 00000000  r8 : c7912018
r7 : 00000000  r6 : c039e8e0  r5 : c7912000  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 000012f3  r0 : 00000001
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: 5717F  Table: 07A44000  DAC: 00000017
Process events/0 (pid: 3, stack limit = 0xc03c4190)
Stack: (0xc03c5ee4 to 0xc03c6000)
5ee0:          c7912114 c03c5f24 c03c5ef8 c005e66c c00263c8 c0399a28 00000007
5f00: c0399a18 c0399a28 c039e8e0 c023ee68 00000000 c023ee78 c03c5f44 c03c5f28
5f20: c005ef64 c005e5e0 c039e8e0 00000000 c039e950 00000001 c03c5f70 c03c5f48
5f40: c005f020 c005eee4 c038fea8 c023ee88 80000013 c038fea0 00000000 c038fe98
5f60: c005ef88 c03c5fc8 c03c5f74 c0048c14 c005ef98 ffffffff ffffffff 00000001
5f80: 00000000 c0035efc 00010000 00000000 00000000 c038d7c0 c0035efc 00100100
5fa0: 00200200 c03c4000 c03b3f34 c038fe98 c0048a4c fffffffc 00000000 c03c5ff4
5fc0: c03c5fcc c004d148 c0048a5c ffffffff ffffffff 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 c03c5ff8 c003b7b8 c004d0d4 00000000 00000000
Backtrace:
[<c00263b8>] (__bug+0x0/0x54) from [<c005e66c>] (free_block+0x9c/0x18c)
 r4 = C7912114
[<c005e5d0>] (free_block+0x0/0x18c) from [<c005ef64>] (drain_array_locked+0x90/0xb4)
[<c005eed4>] (drain_array_locked+0x0/0xb4) from [<c005f020>] (cache_reap+0x98/0x208)
 r7 = 00000001  r6 = C039E950  r5 = 00000000  r4 = C039E8E0
[<c005ef88>] (cache_reap+0x0/0x208) from [<c0048c14>] (worker_thread+0x1c8/0x258)
[<c0048a4c>] (worker_thread+0x0/0x258) from [<c004d148>] (kthread+0x84/0xb0)
[<c004d0c4>] (kthread+0x0/0xb0) from [<c003b7b8>] (do_exit+0x0/0x408)
 r8 = 00000000  r7 = 00000000  r6 = 00000000  r5 = 00000000
 r4 = 00000000
Code: 1b004cba e59f0014 eb004cb8 e3a03000 (e5833000)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
