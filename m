Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264044AbUEHSka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbUEHSka (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 14:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbUEHSk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 14:40:29 -0400
Received: from topper.inf.ed.ac.uk ([129.215.32.40]:49121 "EHLO
	topper.inf.ed.ac.uk") by vger.kernel.org with ESMTP id S264044AbUEHSkO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 14:40:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16541.10632.528036.544259@toolo.inf.ed.ac.uk>
Date: Sat, 8 May 2004 19:40:08 +0100
From: Julian Bradfield <jcb@inf.ed.ac.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hang with 2.4.26 copying to loopback device
In-Reply-To: <20040504011947.GC8028@logos.cnet>
References: <16534.48421.296794.467014@toolo.inf.ed.ac.uk>
	<20040504011947.GC8028@logos.cnet>
X-Mailer: VM 7.18 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Please prepare a more complete report with alt+sysrq+p and alt+sysrq+t 
>output if possible. Attaching a serial console to the box is 
>very helpful if you dont want to copy the output by hand.

Hm. I don't have suitable cable to hand, and I can't afford at present
to keep crashing my laptop. However, it appears that the problem can
be reproduced under UML. So here's what happens there:

Setup: kernel 2.4.26 with UML patches, running with a small Debian
root file system (with devfs). Networked via tun/tap.

First, remote nfs file system mounted by:
mount -o nolock iseo.lan:/BACKUPS /mnt/iseo

Then:
losetup /dev/loop/0 /mnt/iseo/jcb/feijoa/home.LOOPBACK
this last being a file of 6GB in size.

Then
mke2fs /dev/loop/0
(which is pretty slow under UML, talking NFS over wi-fi!).
This succeeds.

Then
mount /dev/loop/0 /mnt/loop

Finally
dd if=/dev/zero of=/mnt/loop/zeroes

After a minute or two, the virtual machine hangs.

Sysrq p and t output:

SysRq : Show Regs

EIP: 0023:[<a0199b91>] CPU: 0 Not tainted ESP: 002b:a0217f44 EFLAGS:
00000286
    Not tainted
EAX: fffffffc EBX: a0217f58 ECX: 00000000 EDX: a0214000
ESI: a0214000 EDI: a0214000 EBP: a0217f60 DS: 002b ES: 002b
Call Trace: [<a01d9f1d>] [<a01daa9a>] [<a00f8a91>] [<a01d6dcc>]
[<a011e382>] 
   [<a011dbc7>] [<a0120000>] [<a00dabbe>] [<a00dadcf>] [<a00db57e>]
   [<a00e5fe6>] 
   [<a00e270d>] [<a0184cd8>] [<a0199b91>] [<a00e17de>] [<a0023569>]
   [<a00ddaf0>] 
   [<a00ddae6>] [<a0006f63>] [<a01d9fe3>] [<a000c4de>] [<a000253d>]
   [<a00e57c0>] 
   [<a00e4701>] [<a00e5848>] [<a00e26f0>] [<a019bd0a>] [<a00e46d0>] 
SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S A019B024  8588     1      0   144
(NOTLB)
keventd       S A019B024 13252     2      1             3
(L-TLB)
ksoftirqd_CPU S A019B024 11612     3      1             4     2
(L-TLB)
kswapd        D A019B024 10768     4      1             5     3
(L-TLB)
bdflush       S A019B024 11308     5      1             6     4
(L-TLB)
kupdated      S A019B024 11164     6      1             7     5
(L-TLB)
scsi_eh_0     S A019B024 13224     7      1             8     6
(L-TLB)
mtdblockd     S A019B024 13316     8      1            99     7
(L-TLB)
syslogd       S A019B024 10404    99      1           102     8
(NOTLB)
klogd         D A019B024 11356   102      1           110    99
(NOTLB)
inetd         S A019B024  3196   110      1           115   102
(NOTLB)
atd           S A019B024 11628   115      1           118   110
(NOTLB)
cron          S A019B024 10716   118      1           121   115
(NOTLB)
bash          S A019B024  8812   121      1   155     122   118
(NOTLB)
bash          D A019B024     0   122      1           123   121
(NOTLB)
getty         S A019B024  2424   123      1           124   122
(NOTLB)
getty         S A019B024  1044   124      1           139   123
(NOTLB)
rpciod        D A019B024 10132   139      1           144   124
(L-TLB)
loop0         D A019B024 10284   144      1                 139
(L-TLB)
dd            D A019B024  8700   155    121
(NOTLB)


A few minutes later, even more tasks were in disk wait:

SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          D A019B024  8588     1      0   144
(NOTLB)
keventd       S A019B024 13252     2      1             3
(L-TLB)
ksoftirqd_CPU S A019B024 11612     3      1             4     2
(L-TLB)
kswapd        D A019B024 10768     4      1             5     3
(L-TLB)
bdflush       S A019B024 11308     5      1             6     4
(L-TLB)
kupdated      S A019B024 11164     6      1             7     5
(L-TLB)
scsi_eh_0     S A019B024 13224     7      1             8     6
(L-TLB)
mtdblockd     S A019B024 13316     8      1            99     7
(L-TLB)
syslogd       D A019B024 10404    99      1           102     8
(NOTLB)
klogd         D A019B024 11356   102      1           110    99
(NOTLB)
inetd         S A019B024  3196   110      1           115   102
(NOTLB)
atd           S A019B024 11628   115      1           118   110
(NOTLB)
cron          S A019B024 10716   118      1           121   115
(NOTLB)
bash          S A019B024  8812   121      1   155     122   118
(NOTLB)
bash          D A019B024     0   122      1           123   121
(NOTLB)
getty         S A019B024  2424   123      1           124   122
(NOTLB)
getty         S A019B024  1044   124      1           139   123
(NOTLB)
rpciod        D A019B024 10132   139      1           144   124
(L-TLB)
loop0         D A019B024 10284   144      1                 139
(L-TLB)
dd            D A019B024  8700   155    121
(NOTLB)



If I go in with gdb, then all the stuck threads say they're at
0xa019b024 in read () at stats.c:181
181                     remove_proc_entry("net/rpc", 0);

For example, the  dd  process itself says:
(gdb) att 10575
Attaching to program: /scratch/jcb/UML/linux-2.4.26/linux, process
10575
0xa019b024 in read () at stats.c:181
181                     remove_proc_entry("net/rpc", 0);
(gdb) where
#0  0xa019b024 in read () at stats.c:181
#1  0xa1268000 in ?? ()
#2  0xa00ebe71 in os_read_file (fd=64, buf=0xa12ef8cf, len=1) at
#file.c:354
#3  0xa00e3df3 in _switch_to_tt (prev=0xa12ec000, next=0x40)
    at process_kern.c:66


