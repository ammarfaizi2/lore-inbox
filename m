Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130891AbQKVBO1>; Tue, 21 Nov 2000 20:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131139AbQKVBOR>; Tue, 21 Nov 2000 20:14:17 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:12821 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130891AbQKVBNp>; Tue, 21 Nov 2000 20:13:45 -0500
Message-Id: <200011220043.LAA44236@clouds.melbourne.sgi.com>
X-Mailer: exmh version 2.0.2 2/24/98
To: linux-kernel@vger.kernel.org
X-URL: http://zoic.org/dxm
Subject: double page fault in 2.4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Nov 2000 11:43:11 +1100
From: Daniel Moore <dxm@clouds.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Running a 2.4.0-text 10 + XFS + CONFIG_HIGHMEM4GB kernel on a 
2p ia32 SMP box with 1Gb of memory, our XFS QA locks up the kernel 
fairly repeatably.

It takes quite a while to happen and doesn't appear to be related
to XFS. It also only happens when CONFIG_HIGHMEM4GB is enabled,
which suggests it's a highmem interraction. 

The problem appears to be a nested page fault while pulling in
a page from an exectuable on an ext2 partition.

I've attached a kdb backtrace. Does this ring any bells for
anyone?


[0]kdb> btp 5868
    EBP       EIP         Function(args)
0xf6945858 0xc0117638 schedule+0x42c (0xf6944000, 0xf6944000, 0xc01130bc)
                               kernel .text 0xc0100000 0xc011720c 0xc0117910
0xf6945880 0xc0107a84 __down+0x6c
                               kernel .text 0xc0100000 0xc0107a18 0xc0107adc
0xf6945894 0xc0107c27 __down_failed+0xb (0xf6944000, 0x0, 0xc01130bc, 
0xc01b2997, 0xf6d3213c)
                               kernel .text 0xc0100000 0xc0107c1c 0xc0107c30
           0xc01ff6f9 stext_lock+0x4d1
                               kernel .text.lock 0xc01ff228 0xc01ff228 
0xc02050e0
0xf6945938 0xc0113128 do_page_fault+0x6c (0xf6945948, 0x0, 0xf69459e0, 0x0, 
0xf69459dc)
                               kernel .text 0xc0100000 0xc01130bc 0xc01134f0
           0xc0109178 error_code+0x34
                               kernel .text 0xc0100000 0xc0109144 0xc0109180
Interrupt registers:
eax = 0x00000000 ebx = 0xf69459e0 ecx = 0x00000000 edx = 0xf69459dc 
esi = 0xf6c17de0 edi = 0xf69459dc esp = 0xf694597c eip = 0xc0159719 
ebp = 0xf6945a10 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010246 
xds = 0xf6940018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xf6945948
           0xc0159719 ext2_get_block+0x13d (0xf6d050e0, 0xc, 0xf6bac600, 0x0)
                               kernel .text 0xc0100000 0xc01595dc 0xc0159b04
0xf6945a90 0xc0136c12 block_read_full_page+0x11a (0xc20f4648, 0xc01595dc)
                               kernel .text 0xc0100000 0xc0136af8 0xc0136dc0
0xf6945aa0 0xc0159cf9 ext2_readpage+0x11 (0xf7429120, 0xc20f4648)
[0]more> 
                               kernel .text 0xc0100000 0xc0159ce8 0xc0159d00
0xf6945ac4 0xc01262b8 read_cluster_nonblocking+0x110 (0xf7429120, 0x2, 0x18)
                               kernel .text 0xc0100000 0xc01261a8 0xc01262fc
0xf6945b10 0xc0127956 filemap_nopage+0x26e (0xf7332120, 0x804b000, 0x1)
                               kernel .text 0xc0100000 0xc01276e8 0xc0127bb4
0xf6945b30 0xc01240ed do_no_page+0x51 (0xf6d32120, 0xf7332120, 0x804b6cc, 0x1, 
0xeb0cc12c)
                               kernel .text 0xc0100000 0xc012409c 0xc012414c
0xf6945b60 0xc0124254 handle_mm_fault+0x108 (0xf6d32120, 0xf7332120, 
0x804b6cc, 0x1, 0xf6944000)
                               kernel .text 0xc0100000 0xc012414c 0xc01242ec
0xf6945c14 0xc011322b do_page_fault+0x16f (0xf6945c24, 0x2, 0x934, 0x24d, 
0x24d)
                               kernel .text 0xc0100000 0xc01130bc 0xc01134f0
           0xc0109178 error_code+0x34
                               kernel .text 0xc0100000 0xc0109144 0xc0109180
Interrupt registers:
eax = 0x00000000 ebx = 0x00000934 ecx = 0x0000024d edx = 0x0000024d 
esi = 0x00000000 edi = 0x0804b6cc esp = 0xf6945c58 eip = 0xc01f8667 
ebp = 0xf6945c68 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010246 
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xf6945c24
           0xc01f8667 clear_user+0x37 (0x804b6cc, 0x934)
                               kernel .text 0xc0100000 0xc01f8630 0xc01f867c
0xf6945c78 0xc014f20e padzero+0x1e (0x804b6cc, 0x804b6cc, 0x804b910, 
0xc02c14b8, 0xc014f8f4)
                               kernel .text 0xc0100000 0xc014f1f0 0xc014f214
0xf6945e10 0xc0150364 load_elf_binary+0xa70 (0xf6945e68, 0xf6945fc4, 
0xf6945e68)
[0]more> 
                               kernel .text 0xc0100000 0xc014f8f4 0xc01504c8
0xf6945e48 0xc013e2b8 search_binary_handler+0x68 (0xf6945e68, 0xf6945fc4)
                               kernel .text 0xc0100000 0xc013e250 0xc013e400
0xf6945f9c 0xc013e548 do_execve+0x148 (0xf676f000, 0x80a9d38, 0x80a3c40, 
0xf6945fc4)
                               kernel .text 0xc0100000 0xc013e400 0xc013e59c
0xf6945fbc 0xc010795f sys_execve+0x2f (0x80a9ce0, 0x80a9d38, 0x80a3c40, 
0x80a9d38, 0x80a9ce0)
                               kernel .text 0xc0100000 0xc0107930 0xc010798c
           0xc0109047 system_call+0x33
                               kernel .text 0xc0100000 0xc0109014 0xc010904c


-----------------------------------------------------
 Daniel Moore                  dxm@sgi.com
 R&D Software Engineer         Phone: +61-3-98348209
 SGI Performance Tools Group   Fax:   +61-3-98132378
-----------------------------------------------------




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
