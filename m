Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130721AbQKCPyQ>; Fri, 3 Nov 2000 10:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130723AbQKCPx4>; Fri, 3 Nov 2000 10:53:56 -0500
Received: from [62.172.234.2] ([62.172.234.2]:41352 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S130720AbQKCPxk>;
	Fri, 3 Nov 2000 10:53:40 -0500
Date: Fri, 3 Nov 2000 15:54:33 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Hans Reiser <hans@reiser.to>
cc: linux-kernel@vger.kernel.org
Subject: panic in reiserfs: _get_block_create_0 gets bh_result->b_data = NULL
In-Reply-To: <Pine.LNX.4.21.0011031431430.1019-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0011031549440.1019-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Simply starting the validation phase of SPEC SFS with NFS mounted reiserfs
filesystem panics as shown in the log below. A quick look at the source
suggests that _get_block_create_0() (and therefore, more generally,
reiserfs_get_block()) was passed a buffer head bh_result with ->b_data =
NULL. So, we panic at line 256 of fs/reiserfs/inode.c when doing:

memset (bh_result->b_data, 0, inode->i_sb->s_blocksize)

Is reiserfs supposed to be highmem-aware? I assume so.

Regards,
Tigran

root@hilbert:~# reiserfs: checking transaction log (device 08:11) ...
Using r5 hash to sort names
ReiserFS version 3.6.18

root@hilbert:~# free
             total       used       free     shared    buffers     cached
Mem:       6132516     347640    5784876          0      74252     238984
-/+ buffers/cache:      34404    6098112
Swap:      1847432          0    1847432
root@hilbert:~# Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
f88f9024
*pde = 3731a001
*pte = 00000000

Entering kdb (current=0xf72ba000, pid 492) on processor 2 Panic: Oops
due to panic @ 0xf88f9024
eax = 0x00000000 ebx = 0x00000400 ecx = 0x00000400 edx = 0x00001000 
esi = 0xf2608228 edi = 0x00000000 esp = 0xf72bbb64 eip = 0xf88f9024 
ebp = 0xf72bbc20 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010246 
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xf72bbb30
[2]kdb> ps
Task Addr    Pid     Parent  [*] cpu  State    Thread   Command
0xc7678000 00000001 00000000  0  002  stop  0xc7678350 init
0xc76e2000 00000002 00000001  0  003  stop  0xc76e2350 kswapd
0xc76e0000 00000003 00000001  0  000  stop  0xc76e0350 kreclaimd
0xc76de000 00000004 00000001  0  000  stop  0xc76de350 kflushd
0xc76dc000 00000005 00000001  0  001  stop  0xc76dc350 kupdate
0xf73b8000 00000428 00000001  0  001  stop  0xf73b8350 syslogd
0xf734c000 00000438 00000001  1  000  run   0xf734c350 klogd
0xf7304000 00000453 00000001  0  000  stop  0xf7304350 portmap
0xf7310000 00000471 00000001  0  002  stop  0xf7310350 rpc.rquotad
0xf7314000 00000481 00000001  0  002  stop  0xf7314350 rpc.mountd
0xf7308000 00000491 00000001  1  003  run   0xf7308350 nfsd
0xf72ba000 00000492 00000001  1  002  run   0xf72ba350*nfsd
0xf72b6000 00000493 00000492  0  002  stop  0xf72b6350 lockd
0xf72b4000 00000494 00000493  0  002  stop  0xf72b4350 rpciod
0xf72ae000 00000495 00000001  0  002  stop  0xf72ae350 nfsd
0xf72ac000 00000496 00000001  0  002  stop  0xf72ac350 nfsd
0xf72a4000 00000497 00000001  0  002  stop  0xf72a4350 nfsd
0xf729a000 00000498 00000001  0  002  stop  0xf729a350 nfsd
0xf7298000 00000499 00000001  0  000  stop  0xf7298350 nfsd
0xf728e000 00000500 00000001  0  002  stop  0xf728e350 nfsd
0xf7328000 00000515 00000001  0  000  stop  0xf7328350 rpc.statd
0xf7276000 00000541 00000001  0  003  stop  0xf7276350 xinetd
[2]more> 
0xf720e000 00000582 00000001  0  001  stop  0xf720e350 gpm
0xf7204000 00000597 00000001  0  001  stop  0xf7204350 crond
0xf754e000 00000619 00000001  0  001  stop  0xf754e350 mingetty
0xf72e0000 00000620 00000001  0  001  stop  0xf72e0350 mingetty
0xf7322000 00000621 00000001  0  000  stop  0xf7322350 mingetty
0xf71f0000 00000622 00000001  0  001  stop  0xf71f0350 mingetty
0xf71b4000 00000623 00000001  0  001  stop  0xf71b4350 login
0xf7176000 00000626 00000623  0  001  stop  0xf7176350 bash
0xf7110000 00000683 00000541  0  003  stop  0xf7110350 in.telnetd
0xf710a000 00000684 00000683  0  000  stop  0xf710a350 login
0xf70f2000 00000685 00000684  0  000  stop  0xf70f2350 bash
0xf2606000 00000720 00000001  1  001  run   0xf2606350 kreiserfsd
0xf2386000 00000725 00000541  0  003  stop  0xf2386350 in.telnetd
0xf22e8000 00000726 00000725  0  003  stop  0xf22e8350 login
0xf216a000 00000727 00000726  0  003  stop  0xf216a350 bash
[2]kdb> bt
    EBP       EIP         Function(args)
0xf72bbc20 0xf88f9024 [reiserfs]_get_block_create_0+0x258 (0xefc6c960, 0x0, 0xef511740, 0x4, 0x1)
                               reiserfs .text 0xf88f3060 0xf88f8dcc 0xf88f9264
0xf72bbdec 0xf88f955d [reiserfs]reiserfs_get_block+0x141 (0xefc6c960, 0x0, 0xef511740, 0x0)
                               reiserfs .text 0xf88f3060 0xf88f941c 0xf88fa5fc
0xf72bbe6c 0xc013a592 block_read_full_page+0x11a (0xc73704f0, 0xf88f941c)
                               kernel .text 0xc0100000 0xc013a478 0xc013a740
0xf72bbe7c 0xf88fc16d [reiserfs]reiserfs_readpage+0x11 (0x0, 0xc73704f0)
                               reiserfs .text 0xf88f3060 0xf88fc15c 0xf88fc174
0xf72bbea0 0xc012c1ea read_cache_page+0x9a (0xefc6c9fc, 0x0, 0xf88fc15c, 0x0)
                               kernel .text 0xc0100000 0xc012c150 0xc012c2b4
0xf72bbebc 0xc0146369 page_getlink+0x21 (0xef983e40, 0xf72bbed8, 0xf72ba000)
                               kernel .text 0xc0100000 0xc0146348 0xc01463fc
0xf72bbedc 0xc014641f page_readlink+0x23 (0xef983e40, 0xf72bc078, 0xfff)
                               kernel .text 0xc0100000 0xc01463fc 0xc014648c
0xf72bbf00 0xc01714a3 nfsd_readlink+0x6f (0xf72fd600, 0xf72fd204, 0xf72bc078, 0xf72fd294)
                               kernel .text 0xc0100000 0xc0171434 0xc01714c8
0xf72bbf2c 0xc0175837 nfsd3_proc_readlink+0xc7 (0xf72fd600, 0xf72fd400, 0xf72fd200)
                               kernel .text 0xc0100000 0xc0175770 0xc0175848
0xf72bbf4c 0xc016d309 nfsd_dispatch+0xc5 (0xf72fd600, 0xf72bc014)
                               kernel .text 0xc0100000 0xc016d244 0xc016d3a0
0xf72bbfa8 0xc0230bba svc_process+0x2ca (0xc77ee5e0, 0xf72fd600)
                               kernel .text 0xc0100000 0xc02308f0 0xc0230e20
[2]more> 
0xf72bbfec 0xc016d0c9 nfsd+0x1c1
                               kernel .text 0xc0100000 0xc016cf08 0xc016d244
           0xc010a76b kernel_thread+0x23
                               kernel .text 0xc0100000 0xc010a748 0xc010a780
[2]kdb> btp 492
    EBP       EIP         Function(args)
0x00000004 0xf88f9024 [reiserfs]_get_block_create_0+0x258 (0xefc6c960, 0x0, 0xef511740, 0x4, 0x1)
                               reiserfs .text 0xf88f3060 0xf88f8dcc 0xf88f9264
0xf72bbdec 0xf88f955d [reiserfs]reiserfs_get_block+0x141 (0xefc6c960, 0x0, 0xef511740, 0x0)
                               reiserfs .text 0xf88f3060 0xf88f941c 0xf88fa5fc
0xf72bbe6c 0xc013a592 block_read_full_page+0x11a (0xc73704f0, 0xf88f941c)
                               kernel .text 0xc0100000 0xc013a478 0xc013a740
0xf72bbe7c 0xf88fc16d [reiserfs]reiserfs_readpage+0x11 (0x0, 0xc73704f0)
                               reiserfs .text 0xf88f3060 0xf88fc15c 0xf88fc174
0xf72bbea0 0xc012c1ea read_cache_page+0x9a (0xefc6c9fc, 0x0, 0xf88fc15c, 0x0)
                               kernel .text 0xc0100000 0xc012c150 0xc012c2b4
0xf72bbebc 0xc0146369 page_getlink+0x21 (0xef983e40, 0xf72bbed8, 0xf72ba000)
                               kernel .text 0xc0100000 0xc0146348 0xc01463fc
0xf72bbedc 0xc014641f page_readlink+0x23 (0xef983e40, 0xf72bc078, 0xfff)
                               kernel .text 0xc0100000 0xc01463fc 0xc014648c
0xf72bbf00 0xc01714a3 nfsd_readlink+0x6f (0xf72fd600, 0xf72fd204, 0xf72bc078, 0xf72fd294)
                               kernel .text 0xc0100000 0xc0171434 0xc01714c8
0xf72bbf2c 0xc0175837 nfsd3_proc_readlink+0xc7 (0xf72fd600, 0xf72fd400, 0xf72fd200)
                               kernel .text 0xc0100000 0xc0175770 0xc0175848
0xf72bbf4c 0xc016d309 nfsd_dispatch+0xc5 (0xf72fd600, 0xf72bc014)
                               kernel .text 0xc0100000 0xc016d244 0xc016d3a0
0xf72bbfa8 0xc0230bba svc_process+0x2ca (0xc77ee5e0, 0xf72fd600)
                               kernel .text 0xc0100000 0xc02308f0 0xc0230e20
[2]more> 
0xf72bbfec 0xc016d0c9 nfsd+0x1c1
                               kernel .text 0xc0100000 0xc016cf08 0xc016d244
           0xc010a76b kernel_thread+0x23
                               kernel .text 0xc0100000 0xc010a748 0xc010a780
[2]kdb> r
eax = 0x00000000 ebx = 0x00000400 ecx = 0x00000400 edx = 0x00001000 
esi = 0xf2608228 edi = 0x00000000 esp = 0xf72bbb64 eip = 0xf88f9024 
ebp = 0xf72bbc20 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010246 
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xf72bbb30
[2]kdb> inode 0xefc6c960
struct inode at  0xefc6c960
 i_ino = 16 i_count = 1 i_dev = 0x811 i_size 15
 i_mode = 0xa1ff  i_nlink = 1  i_rdev = 0x0
 i_hash.nxt = 0xf7875398 i_hash.prv = 0xf7875398
 i_list.nxt = 0xefc6cae8 i_list.prv = 0xc030de10
 i_dentry.nxt = 0xef983e78 i_dentry.prv = 0xef983e78
 i_sb = 0xf72a6a00 i_op = 0xc030dd20 i_data = 0xefc6c9fc nrpages = 1
  fs specific info @ 0xefc6ca4c
[2]kdb> mdr 0xef511740 256
00000000000000000010000011080000000000000000000000000000000000000000000000000000401751ef000000000000000000000000f00437c73c9413c00000000000000000010000008c1751ef8c1751ef00000000000000000000000000000000a70517000010000007080000000000000708000019000000000000000000000000000000a01751ef000000000000000000000000b0745cc7949413c000000000382db80001000000ec1751efec1751ef00000000000000000000000000000000880517000010000007080000000000000708000019000000000000000000000000000000001851ef00000000000000000000000044695cc7949413c0
[2]kdb> md 0xef511740
0xef511740 00000000 00000000 00001000 00000811  ................
0xef511750 00000000 00000000 00000000 00000000  ................
0xef511760 00000000 00000000 ef511740 00000000  ........@.Qï....
0xef511770 00000000 00000000 c73704f0 c013943c  ........ð.7Ç<..À
0xef511780 00000000 00000000 00000001 ef51178c  ..............Qï
0xef511790 ef51178c 00000000 00000000 00000000  ..Qï............
0xef5117a0 00000000 001705a7 00001000 00000807  ....§...........
0xef5117b0 00000000 00000807 00000019 00000000  ................
[2]kdb> aha! bh_result->b_data = NULL!
aha! = 0x0000000a
[2]kdb> so, we panic in memset()
Unknown kdb command: 'so,'
[2]kdb> go

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
