Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271478AbTGQOwh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271476AbTGQOwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:52:37 -0400
Received: from franka.aracnet.com ([216.99.193.44]:55962 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S271478AbTGQOwU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:52:20 -0400
Date: Thu, 17 Jul 2003 08:06:56 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 934] New: NFS client getting repeated kernel bugs with mm/slab.c:1696 
Message-ID: <16970000.1058454416@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=934

           Summary: NFS client getting repeated kernel bugs with
                    mm/slab.c:1696
    Kernel Version: 2.6.0-test1
            Status: NEW
          Severity: normal
             Owner: trond.myklebust@fys.uio.no
         Submitter: robbiew@us.ibm.com


Distribution:SuSE 8.0

Hardware Environment:
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 864.111
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1708.03

256 Mb of RAM
512 Mb of Swap Space


Software Environment:
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11z
mount                  2.11z
module-init-tools      2.4.12
e2fsprogs              1.26
jfsutils               1.0.15
xfsprogs               2.0.0
quota-tools            3.03.
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23  
2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 3.1.5
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
nfs-utils              1.0.4
No Modules Loaded


Problem Description: While performing the test scenario described at 
http://ltp.sf.net, I receive the following kernel BUG over 100 times on the 
client.  I realize if I turn off Kernel Debugging I won't receive these 
messages.  However, I believe these reported BUGS are causing the errors I get 
when I attempt to remove the created files and filesystems over NFS. Here is 
the bug:
=========================================
kernel BUG at mm/slab.c:1696!
invalid operand: 0000 [#101]
CPU:    0
EIP:    0060:[<c0130da8>]    Not tainted
EFLAGS: 00010016
EIP is at cache_alloc_refill+0x114/0x2d0
eax: 002158c3   ebx: 00000006   ecx: cfdacf50   edx: cfdacf68
esi: 00000002   edi: 00000010   ebp: ca227ce8   esp: ca227cb4
ds: 007b   es: 007b   ss: 0068
Process fsstress (pid: 1736, threadinfo=ca226000 task=cab559c0)
Stack: 00000000 cfdacf3c 00000282 ca227cd0 00000006 cf402f20 ca227e8c 00000000
       cfdacf48 cfdacf50 00200200 cfdacf68 cfda8948 ca227d0c c0131224 cfdacf3c
       000000d0 00000000 cf772124 cfe8da30 ca227d90 00000000 ca227d1c c019729f
Call Trace:
 [<c0131224>] kmem_cache_alloc+0x4c/0x118
 [<c019729f>] nfs_alloc_inode+0x13/0x3c
 [<c01544d6>] alloc_inode+0x16/0x148
 [<c0154e22>] get_new_inode+0x12/0xc4
 [<c015515d>] iget5_locked+0x7d/0x88
 [<c0195ffc>] nfs_find_actor+0x0/0xb0
 [<c01960ac>] nfs_init_locked+0x0/0x3c
 [<c0196193>] __nfs_fhget+0x5f/0x328
 [<c0195ffc>] nfs_find_actor+0x0/0xb0
 [<c01960ac>] nfs_init_locked+0x0/0x3c
 [<c019612b>] nfs_fhget+0x43/0x4c
 [<c0193eaf>] nfs_instantiate+0x57/0xac
 [<c019418f>] nfs_mkdir+0x9f/0xe0
 [<c01537d5>] d_alloc+0x19/0x1c0
 [<c01941ff>] nfs_rmdir+0x2f/0x70
 [<c014b866>] permission+0x26/0x3c
 [<c014d171>] vfs_mkdir+0x71/0x9c
 [<c014d229>] sys_mkdir+0x8d/0xd4
 [<c010a773>] syscall_call+0x7/0xb

Code: 0f 0b a0 06 67 8f 39 c0 8b 55 f8 8b 04 82 83 f8 ff 75 d5 8b
=========================================
I attached a dump of fs/nfs/inode.o and mm/slab.o also.

Steps to reproduce: Execute to the testplan described at http://ltp.sf.net


