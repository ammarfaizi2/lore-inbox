Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267492AbTAQMuN>; Fri, 17 Jan 2003 07:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbTAQMuN>; Fri, 17 Jan 2003 07:50:13 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:3000 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267492AbTAQMuL>;
	Fri, 17 Jan 2003 07:50:11 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15911.64825.624251.707026@harpo.it.uu.se>
Date: Fri, 17 Jan 2003 13:55:21 +0100
To: kai@tp1.ruhr-uni-bochum.de
Subject: 2.5.59 vmlinux.lds.S change broke modules
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously today I wrote:
 > 2.5.59 with CONFIG_PACKET=m oopes when af_packet.ko is insmodded:
 > 
 > Unable to handle kernel paging request at virtual address 2220c021
 >  printing eip:
 > c0124011
 > *pde = 00000000
 > Oops: 0000
 > CPU:    0
 > EIP:    0060:[<c0124011>]    Not tainted
 > EFLAGS: 00010097
 > EIP is at __find_symbol+0x3d/0x7c
 > eax: c020f70e   ebx: 00000536   ecx: 00000000   edx: c028b600
 > esi: 2220c021   edi: e8889558   ebp: e8889558   esp: e67c5ecc
 > ds: 007b   es: 007b   ss: 0068
 > Process insmod (pid: 482, threadinfo=e67c4000 task=e6c80ce0)
 > Stack: e8888f34 e8889a40 00000038 e8883f50 c0124960 e8889558 e67c5ef4 00000001 
 >        e8888f34 e8889374 e67c5f28 c0124b2a e8883f50 00000016 e8889374 e8889558 
 >        e8889a40 e8883f50 0000000c 00000017 e8889a40 00000000 0000007c c01253a4 
 > Call Trace:
 >  [<c0124960>] resolve_symbol+0x20/0x4c
 >  [<c0124b2a>] simplify_symbols+0x82/0xe4
 >  [<c01253a4>] load_module+0x5c4/0x7ec
 >  [<c012562b>] sys_init_module+0x5f/0x194
 >  [<c0108887>] syscall_call+0x7/0xb

This oops occurs for every module, not just af_packet.ko, at
resolve_symbol()'s first call to __find_symbol().

What happens is that __find_symbol() oopses because the kernel's
symbol table is in la-la land. (Note the bogus kernel adress
2220c021 it tried to dereference above.)

Reverting 2.5.59's patch to arch/i386/vmlinux.lds.S cured the
problem and modules now load correctly for me.

I don't know if this is a problem also for non-i386 archs.

/Mikael
