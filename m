Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKCOdp>; Fri, 3 Nov 2000 09:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbQKCOdf>; Fri, 3 Nov 2000 09:33:35 -0500
Received: from [62.172.234.2] ([62.172.234.2]:61664 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129076AbQKCOd0>;
	Fri, 3 Nov 2000 09:33:26 -0500
Date: Fri, 3 Nov 2000 14:34:08 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Hans Reiser <hans@reiser.to>
cc: linux-kernel@vger.kernel.org
Subject: panic in reiserfs in 2.4.0-test10, BUG at highmem.c:220
Message-ID: <Pine.LNX.4.21.0011031431430.1019-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Having tried the 2.4.0-test9 patch of reiserfs under 2.4.0-test10 I got
the following panic (see kdb session below). I was running bonnie on it
over NFS and at the same time running tar xIf linux-2.4.0-test10.tar.bz2
locally.

Regards,
Tigran

root@hilbert:~# reiserfs: checking transaction log (device 08:11) ...
Using r5 hash to sort names
ReiserFS version 3.6.18

root@hilbert:~# kernel BUG at highmem.c:220!

Entering kdb (current=0xf273c000, pid 1148) on processor 2 Panic: invalid operand
due to panic @ 0xc01359b1
eax = 0x0000001d ebx = 0x00000000 ecx = 0xc030af88 edx = 0xc0360440 
esi = 0xf273de48 edi = 0xf273db70 esp = 0xf273db00 eip = 0xc01359b1 
ebp = 0xf273db14 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010246 
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xf273dacc
[2]kdb> r
eax = 0x0000001d ebx = 0x00000000 ecx = 0xc030af88 edx = 0xc0360440 
esi = 0xf273de48 edi = 0xf273db70 esp = 0xf273db00 eip = 0xc01359b1 
ebp = 0xf273db14 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010246 
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xf273dacc
[2]kdb> bt
    EBP       EIP         Function(args)
0xf273db14 0xc01359b1 kunmap_high+0x2d
                               kernel .text 0xc0100000 0xc0135984 0xc0135a20
0xf273db88 0xf890be32 [reiserfs]indirect2direct+0x2c2 (0xf273dedc, 0xf270b4c0, 0xc73f8ce8, 0xf273de48, 0xf273de30)
                               reiserfs .text 0xf88f3060 0xf890bb70 0xf890be70
0xf273dbdc 0xf8909515 [reiserfs]maybe_indirect_to_direct+0x1f1 (0xf273dedc, 0xf270b4c0, 0xc73f8ce8, 0xf273de48, 0xf273de30)
                               reiserfs .text 0xf88f3060 0xf8909324 0xf8909520
0xf273ddd8 0xf890975e [reiserfs]reiserfs_cut_from_item+0xde (0xf273dedc, 0xf273de48, 0xf273de30, 0xf270b4c0, 0xc73f8ce8)
                               reiserfs .text 0xf88f3060 0xf8909680 0xf8909ac0
0xf273de88 0xf8909e5d [reiserfs]reiserfs_do_truncate+0x34d (0xf273dedc, 0xf270b4c0, 0xc73f8ce8, 0x1, 0xf8913384)
                               reiserfs .text 0xf88f3060 0xf8909b10 0xf8909f6c
0xf273def0 0xf88fb825 [reiserfs]reiserfs_truncate_file+0xad (0xf270b4c0, 0xf89134ec)
                               reiserfs .text 0xf88f3060 0xf88fb778 0xf88fb978
0xf273df60 0xf88fc6b9 [reiserfs]reiserfs_file_release+0x379 (0xf270b4c0, 0xf7184800)
                               reiserfs .text 0xf88f3060 0xf88fc340 0xf88fc714
0xf273df80 0xc0138599 fput+0x41 (0xf7184800, 0xf73c0400, 0x0, 0xf7184800, 0x0)
                               kernel .text 0xc0100000 0xc0138558 0xc0138648
0xf273dfa8 0xc013742e filp_close+0xb6 (0xf7184800, 0xf73c0400, 0xf273c000)
                               kernel .text 0xc0100000 0xc0137378 0xc013743c
0xf273dfbc 0xc013749f sys_close+0x63 (0x4, 0x806f700, 0x0, 0xbffffa0c, 0x0)
                               kernel .text 0xc0100000 0xc013743c 0xc01374b8
           0xc010c2bb system_call+0x33
                               kernel .text 0xc0100000 0xc010c288 0xc010c2c0
[2]more> 
[2]kdb> inode 0xf270b4c0
struct inode at  0xf270b4c0
 i_ino = 122 i_count = 1 i_dev = 0x811 i_size 4146
 i_mode = 0x81a4  i_nlink = 1  i_rdev = 0x0
 i_hash.nxt = 0xf26e5ce0 i_hash.prv = 0xf784f7d0
 i_list.nxt = 0xf26f7ac8 i_list.prv = 0xc030de10
 i_dentry.nxt = 0xf2706d78 i_dentry.prv = 0xf2706d78
 i_sb = 0xf4c72e00 i_op = 0xf8918e80 i_data = 0xf270b55c nrpages = 2
  fs specific info @ 0xf270b5ac
[2]kdb> page  0xc73f8ce8
struct page at 0xc73f8ce8
  next 0xc73f8d2c prev 0xf270b55c addr space 0xf270b55c index 1 (offset 0x1000)
  count 3 flags PG_locked PG_uptodate  PG_highmem virtual 0xfe187000
  buffers 0xf2a37780[2]kdb> 
[2]kdb> cpu 0

Entering kdb (current=0xc0326000, pid 0) on processor 0 due to cpu switch
[0]kdb> bt
    EBP       EIP         Function(args)
0xc0327fd0 0xc010a460 default_idle+0x30
                               kernel .text 0xc0100000 0xc010a430 0xc010a468
0xc0327fe4 0xc010a4d2 cpu_idle+0x42 (0x3)
                               kernel .text 0xc0100000 0xc010a490 0xc010a4e8
0xc0327ff8 0xc0328cd1 start_kernel+0x185
                               kernel .text.init 0xc0328000 0xc0328b4c 0xc0328cdc
[0]kdb> cpu 1

Entering kdb (current=0xc766a000, pid 0) on processor 1 due to cpu switch
[1]kdb> bt
    EBP       EIP         Function(args)
0xc766bfa4 0xc010a460 default_idle+0x30
                               kernel .text 0xc0100000 0xc010a430 0xc010a468
0xc766bfb8 0xc010a4d2 cpu_idle+0x42
                               kernel .text 0xc0100000 0xc010a490 0xc010a4e8
0xc766bfc0 0xc032d345 start_secondary+0x21
                               kernel .text.init 0xc0328000 0xc032d324 0xc032d34c
[1]kdb> cpu 3

Entering kdb (current=0xc767a000, pid 0) on processor 3 due to cpu switch
[3]kdb> bt
    EBP       EIP         Function(args)
0xc767bfa4 0xc010a460 default_idle+0x30
                               kernel .text 0xc0100000 0xc010a430 0xc010a468
0xc767bfb8 0xc010a4d2 cpu_idle+0x42
                               kernel .text 0xc0100000 0xc010a490 0xc010a4e8
0xc767bfc0 0xc032d345 start_secondary+0x21
                               kernel .text.init 0xc0328000 0xc032d324 0xc032d34c
[3]kdb> ps
Task Addr    Pid     Parent  [*] cpu  State    Thread   Command
0xc7678000 00000001 00000000  0  001  stop  0xc7678350 init
0xc76e2000 00000002 00000001  0  002  stop  0xc76e2350 kswapd
0xc76e0000 00000003 00000001  0  000  stop  0xc76e0350 kreclaimd
0xc76de000 00000004 00000001  0  000  stop  0xc76de350 kflushd
0xc76dc000 00000005 00000001  0  001  stop  0xc76dc350 kupdate
0xf73ca000 00000428 00000001  0  001  stop  0xf73ca350 syslogd
0xf7354000 00000438 00000001  0  002  run   0xf7354350 klogd
0xf743e000 00000453 00000001  0  003  stop  0xf743e350 portmap
0xf7302000 00000471 00000001  0  001  stop  0xf7302350 rpc.rquotad
0xf72fc000 00000481 00000001  0  002  stop  0xf72fc350 rpc.mountd
0xf7316000 00000491 00000001  0  000  stop  0xf7316350 nfsd
0xf7314000 00000492 00000001  0  003  stop  0xf7314350 nfsd
0xf72ec000 00000493 00000001  0  002  stop  0xf72ec350 nfsd
0xf72e4000 00000494 00000001  0  002  stop  0xf72e4350 nfsd
0xf72ba000 00000495 00000001  0  003  stop  0xf72ba350 nfsd
0xf72b2000 00000496 00000001  0  001  stop  0xf72b2350 nfsd
0xf72b0000 00000497 00000001  0  001  stop  0xf72b0350 nfsd
0xf72a6000 00000498 00000001  0  000  stop  0xf72a6350 nfsd
0xf72a4000 00000499 00000491  0  003  stop  0xf72a4350 lockd
0xf72a2000 00000500 00000499  0  003  stop  0xf72a2350 rpciod
0xf7332000 00000515 00000001  0  002  stop  0xf7332350 rpc.statd
0xf728c000 00000541 00000001  0  003  stop  0xf728c350 xinetd
[3]more> 
0xf724a000 00000582 00000001  0  002  stop  0xf724a350 gpm
0xf7230000 00000597 00000001  0  001  stop  0xf7230350 crond
0xf754e000 00000619 00000001  0  001  stop  0xf754e350 mingetty
0xf72f0000 00000620 00000001  0  002  stop  0xf72f0350 mingetty
0xf7214000 00000621 00000001  0  001  stop  0xf7214350 mingetty
0xf71d2000 00000622 00000001  0  003  stop  0xf71d2350 mingetty
0xf71d6000 00000623 00000001  0  001  stop  0xf71d6350 login
0xf71a0000 00000624 00000623  0  003  stop  0xf71a0350 bash
0xf717e000 00001108 00000541  0  000  stop  0xf717e350 in.telnetd
0xf715e000 00001109 00001108  0  000  stop  0xf715e350 login
0xf7116000 00001110 00001109  0  000  stop  0xf7116350 bash
0xf2a6a000 00001141 00000001  0  000  stop  0xf2a6a350 kreiserfsd
0xf273c000 00001148 00001110  1  002  run   0xf273c350 tar
0xf2732000 00001149 00001148  0  003  stop  0xf2732350 bzip2
[3]kdb> 
[3]kdb> cpu 2

Entering kdb (current=0xf273c000, pid 1148) on processor 2 due to cpu switch
[2]kdb> ps
Task Addr    Pid     Parent  [*] cpu  State    Thread   Command
0xc7678000 00000001 00000000  0  001  stop  0xc7678350 init
0xc76e2000 00000002 00000001  0  002  stop  0xc76e2350 kswapd
0xc76e0000 00000003 00000001  0  000  stop  0xc76e0350 kreclaimd
0xc76de000 00000004 00000001  0  000  stop  0xc76de350 kflushd
0xc76dc000 00000005 00000001  0  001  stop  0xc76dc350 kupdate
0xf73ca000 00000428 00000001  0  001  stop  0xf73ca350 syslogd
0xf7354000 00000438 00000001  0  002  run   0xf7354350 klogd
0xf743e000 00000453 00000001  0  003  stop  0xf743e350 portmap
0xf7302000 00000471 00000001  0  001  stop  0xf7302350 rpc.rquotad
0xf72fc000 00000481 00000001  0  002  stop  0xf72fc350 rpc.mountd
0xf7316000 00000491 00000001  0  000  stop  0xf7316350 nfsd
0xf7314000 00000492 00000001  0  003  stop  0xf7314350 nfsd
0xf72ec000 00000493 00000001  0  002  stop  0xf72ec350 nfsd
0xf72e4000 00000494 00000001  0  002  stop  0xf72e4350 nfsd
0xf72ba000 00000495 00000001  0  003  stop  0xf72ba350 nfsd
0xf72b2000 00000496 00000001  0  001  stop  0xf72b2350 nfsd
0xf72b0000 00000497 00000001  0  001  stop  0xf72b0350 nfsd
0xf72a6000 00000498 00000001  0  000  stop  0xf72a6350 nfsd
0xf72a4000 00000499 00000491  0  003  stop  0xf72a4350 lockd
0xf72a2000 00000500 00000499  0  003  stop  0xf72a2350 rpciod
0xf7332000 00000515 00000001  0  002  stop  0xf7332350 rpc.statd
0xf728c000 00000541 00000001  0  003  stop  0xf728c350 xinetd
[2]more> 
0xf724a000 00000582 00000001  0  002  stop  0xf724a350 gpm
0xf7230000 00000597 00000001  0  001  stop  0xf7230350 crond
0xf754e000 00000619 00000001  0  001  stop  0xf754e350 mingetty
0xf72f0000 00000620 00000001  0  002  stop  0xf72f0350 mingetty
0xf7214000 00000621 00000001  0  001  stop  0xf7214350 mingetty
0xf71d2000 00000622 00000001  0  003  stop  0xf71d2350 mingetty
0xf71d6000 00000623 00000001  0  001  stop  0xf71d6350 login
0xf71a0000 00000624 00000623  0  003  stop  0xf71a0350 bash
0xf717e000 00001108 00000541  0  000  stop  0xf717e350 in.telnetd
0xf715e000 00001109 00001108  0  000  stop  0xf715e350 login
0xf7116000 00001110 00001109  0  000  stop  0xf7116350 bash
0xf2a6a000 00001141 00000001  0  000  stop  0xf2a6a350 kreiserfsd
0xf273c000 00001148 00001110  1  002  run   0xf273c350*tar
0xf2732000 00001149 00001148  0  003  stop  0xf2732350 bzip2
[2]kdb> btp 1148
    EBP       EIP         Function(args)
0xc024fdc5 0xc01359b1 kunmap_high+0x2d
                               kernel .text 0xc0100000 0xc0135984 0xc0135a20
0xf273db88 0xf890be32 [reiserfs]indirect2direct+0x2c2 (0xf273dedc, 0xf270b4c0, 0xc73f8ce8, 0xf273de48, 0xf273de30)
                               reiserfs .text 0xf88f3060 0xf890bb70 0xf890be70
0xf273dbdc 0xf8909515 [reiserfs]maybe_indirect_to_direct+0x1f1 (0xf273dedc, 0xf270b4c0, 0xc73f8ce8, 0xf273de48, 0xf273de30)
                               reiserfs .text 0xf88f3060 0xf8909324 0xf8909520
0xf273ddd8 0xf890975e [reiserfs]reiserfs_cut_from_item+0xde (0xf273dedc, 0xf273de48, 0xf273de30, 0xf270b4c0, 0xc73f8ce8)
                               reiserfs .text 0xf88f3060 0xf8909680 0xf8909ac0
0xf273de88 0xf8909e5d [reiserfs]reiserfs_do_truncate+0x34d (0xf273dedc, 0xf270b4c0, 0xc73f8ce8, 0x1, 0xf8913384)
                               reiserfs .text 0xf88f3060 0xf8909b10 0xf8909f6c
0xf273def0 0xf88fb825 [reiserfs]reiserfs_truncate_file+0xad (0xf270b4c0, 0xf89134ec)
                               reiserfs .text 0xf88f3060 0xf88fb778 0xf88fb978
0xf273df60 0xf88fc6b9 [reiserfs]reiserfs_file_release+0x379 (0xf270b4c0, 0xf7184800)
                               reiserfs .text 0xf88f3060 0xf88fc340 0xf88fc714
0xf273df80 0xc0138599 fput+0x41 (0xf7184800, 0xf73c0400, 0x0, 0xf7184800, 0x0)
                               kernel .text 0xc0100000 0xc0138558 0xc0138648
0xf273dfa8 0xc013742e filp_close+0xb6 (0xf7184800, 0xf73c0400, 0xf273c000)
                               kernel .text 0xc0100000 0xc0137378 0xc013743c
0xf273dfbc 0xc013749f sys_close+0x63 (0x4, 0x806f700, 0x0, 0xbffffa0c, 0x0)
                               kernel .text 0xc0100000 0xc013743c 0xc01374b8
           0xc010c2bb system_call+0x33
                               kernel .text 0xc0100000 0xc010c288 0xc010c2c0
[2]more> 
[2]kdb> go
invalid operand: 0000
eth2: card reports no resources.
CPU:    2
EIP:    0010:[<c01359b1>]
EFLAGS: 00010246
eax: 0000001d   ebx: 00000000   ecx: c030af88   edx: c0360440
esi: f273de48   edi: f273db70   ebp: f273db14   esp: f273db00
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 1148, stackpage=f273d000)
Stack: c024fdc5 c024ff87 000000dc f273c000 f273de48 f273db88 f890be32 00000000 
       c73f8ce8 f270b4c0 00001001 00000000 00000001 00000000 f273c000 f273db70 
       00001000 00000000 00000038 fe187000 00001000 f4c72e00 0000006b 0000007a 
Call Trace: [<c024fdc5>] [<c024ff87>] [<f890be32>] [<fe187000>] [<f8909515>] [<f890975e>] [<f8909e5d>] 
       [<f88fb825>] [<f8913384>] [<f890ef9e>] [<f8917e6f>] [<f88fc6b9>] [<f89134ec>] [<f8917e6f>] [<c0138599>] 
       [<c013742e>] [<c013749f>] [<c010c2bb>] 
Code: 0f 0b 83 c4 0c 8d 83 00 00 00 02 c1 e8 0c c1 e0 02 ba 80 8d 

root@hilbert:~# 
root@hilbert:~# 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
