Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTLJOkl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 09:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTLJOkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 09:40:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:47308 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262991AbTLJOkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 09:40:37 -0500
Date: Wed, 10 Dec 2003 08:40:11 -0600
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Problems with NFS while running SpecSFS with JFS filesystem and 2.6 kernel.
Message-ID: <20031210144011.GE708@dbz.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm doing some filesystem functional and performance testing using
the SpecSFS workload and I get an unusual problem when running the
benchmark with the JFS filesystem.  In the setup phase (creating
directories and workload files), it fail immediately after running out
of free pages.  I've turn on debugging on JFS, NFS and SFS and what I
see is this:

SpecSFS
	-It is always failing on a lookup.

	sfs30: initialize file_en.46399 (REG for IO)
	sfs30:lad_lookup: 401742ec[1004a920] file_en.46399
	sfs30:lad_create: 401742ec[1004a920] file_en.46399
	sfs30:lad_write: 401742ec[1004a920] 0 1048576
	lad_lookup(file_en.46410) NFS call failed : Permission denied
	sfs_mcr: sfs benchmark terminated with error status

JFS:
	-no problems here. Everything seems to work fine.

NFSD:
	-I dont see error on the debug output but I do see something
	 I found odd...

     >>>Dec  9 14:48:04 onus kernel: nfsd: LOOKUP(3)   20: 01000001 00420051 00000002 0000a17e 00009083 00000000 file_en.46340
     >>>Dec  9 14:48:04 onus kernel: nfsd: LOOKUP(3)   20: 01000001 00420051 00000002 0000a17e 00009083 00000000 file_en.46410
        Dec  9 14:48:04 onus kernel: nfsd: CREATE(3)   20: 01000001 00430061 00000002 0000a17d 000090be 00000000 file_en.46402
        Dec  9 14:48:04 onus kernel: nfsd: LOOKUP(3)   20: 01000001 00420031 00000002 0000a17c 00009109 00000000 file_en.46362
        Dec  9 14:48:04 onus kernel: nfsd: LOOKUP(3)   20: 01000001 004200e1 00000002 0000a1e0 000090ba 00000000 file_en.46241
        Dec  9 14:48:04 onus kernel: nfsd: LOOKUP(3)   20: 01000001 004200a1 00000002 0000a17b 00009099 00000000 file_en.46334
        Dec  9 14:48:04 onus kernel: nfsd: CREATE(3)   28: 01000002 004300c1 00000002 0000d219 0000c15e 0000a181 file_en.46340
        Dec  9 14:48:04 onus kernel: nfsd: CREATE(3)   20: 01000001 004200e1 00000002 0000a1e0 000090ba 00000000 file_en.46241
        Dec  9 14:48:04 onus kernel: nfsd: CREATE(3)   20: 01000001 00420031 00000002 0000a17c 00009109 00000000 file_en.46362
        Dec  9 14:48:04 onus kernel: nfsd: CREATE(3)   20: 01000001 004200a1 00000002 0000a17b 0000909a 00000000 file_en.46347
        Dec  9 14:48:04 onus kernel: nfsd: CREATE(3)   20: 01000001 004200a1 00000002 0000a17b 00009099 00000000 file_en.46334
        Dec  9 14:48:04 onus kernel: nfsd: LOOKUP(3)   20: 01000001 004100d1 00000002 0000a17f 000090db 00000000 file_en.46453
	
	Here I see two LOOKUP to two file (file_en.46340 and file_en.46410) 
	that have the same file handle.  The CREATE for the first file (file_en.46340)
	does finish sucesfully but the one for second file (file_en.46410) 
	never shows up.  Looking at the NFS ops that occurred before the failure
	it seem that duplicate SVCfh are do occured but there is always a CREATE 
	before the same SVCfh is reuse.


I've tested this with EXT2, EXT3, REISERFS, and XFS as well and JFS is 
the only one that shows this problem.  I've had some mail exchange with
Dave Kleikamp and since JFS doesn't seem to be reporting any problems he
is not entirely convince its a JFS problem.  

The other odd thing about the problem is that it is control by the amount 
of free pages on the system and it hits as soon as free pages run out.  I
have tested with 16Gb, 32Gb and 64Gb of memory with the problem taking 
longer to reproduce as I increase the Memory.

One time the machine actualy hung with the following errors when the error 
was about to happen.  Im not sure if this has anything to do with the other 
original problem.

cpu 2: Vector: 300 (Data Access) at [c000000ffb4b7690]
    pc: c0000000000b8810 (.clear_inode+0x60/0x100)
    lr: c0000000000b87c8 (.clear_inode+0x18/0x100)
    sp: c000000ffb4b7910
   msr: a000000000009032
   dar: 78
 dsisr: 200000
  current = 0xc000000ffb555100
  paca    = 0xc000000000594000
    pid   = 37, comm = kswapd0

c000000ffb4b7910  c0000000000b87c8  .clear_inode+0x18/0x100
c000000ffb4b7990  c0000000000ba284  .generic_forget_inode+0x1a4/0x1ec
c000000ffb4b7a30  c0000000000ba3a8  .iput+0xa4/0xf4
c000000ffb4b7ab0  c0000000000b60d0  .prune_dcache+0x25c/0x2fc
c000000ffb4b7b60  c0000000000b68c4  .shrink_dcache_memory+0x68/0x78
c000000ffb4b7be0  c00000000007d614  .shrink_slab+0x15c/0x1e4
c000000ffb4b7c90  c00000000007f744  .balance_pgdat+0x2d0/0x308
c000000ffb4b7d80  c00000000007f88c  .kswapd+0x110/0x120
c000000ffb4b7f90  c000000000017774  .kernel_thread+0x4c/0x68

Oops: Kernel access of bad area, sig: 11 [#1]
NIP: C0000000000B8810 XER: 0000000000000000 LR: C0000000000B87C8
REGS: c000000ffb4b7690 TRAP: 0300    Not tainted
MSR: a000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000000000000078, DSISR: 0000000000200000
TASK = c000000ffb555100[37] 'kswapd0'  CPU: 2
GPR00: 0000000000000010 C000000FFB4B7910 C00000000064B000 0000000000000000 
GPR04: 0000000000000003 0000000000000000 0000000000000000 C0000000004B10A0 
GPR08: C0000000006E18B8 0000000000000000 C00000059EE93D00 C0000006F9A482E8 
GPR12: 0000000024000024 C000000000594000 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 C000000FFB4B7F50 
GPR20: 0000000000000000 C000000FFB4B7E50 0000000000000000 0000000000000000 
GPR24: 0000000000000001 C0000000004B1048 0000000000000000 0000000000000000 
GPR28: C0000000006E18B8 C0000000004B10A0 C00000000056AEA8 C0000006F9A482D8 
NIP [c0000000000b8810] .clear_inode+0x60/0x100
Call Trace:
[c0000000000ba284] .generic_forget_inode+0x1a4/0x1ec
[c0000000000ba3a8] .iput+0xa4/0xf4
[c0000000000b60d0] .prune_dcache+0x25c/0x2fc
[c0000000000b68c4] .shrink_dcache_memory+0x68/0x78
[c00000000007d614] .shrink_slab+0x15c/0x1e4
[c00000000007f744] .balance_pgdat+0x2d0/0x308
[c00000000007f88c] .kswapd+0x110/0x120
[c000000000017774] .kernel_thread+0x4c/0x68
---------------------------------------------------------------------------

The machine I'm using is an old p660 with 8 RS64-IV proc running at 750MHz.
For IO, I am using 4 FAStT fiber-channel controllers and 8 fiber-channel 
adapters.  Linux sees 56 disk in total and each disk is actually a RAID5 
array of 5 disk.

The kernel is a BK test11 kernel from last week.  I have also seen this 
problem in test9 kernels as well.

Sorry for the long email....
Thanks

-JRS

