Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTJVXel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 19:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbTJVXel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 19:34:41 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:12490 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261342AbTJVXeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 19:34:37 -0400
Date: Wed, 22 Oct 2003 16:34:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1403] New: 2.6.0-test8 oops: Unable to handle	kernel paging request - free_pages_bulk
Message-ID: <11820000.1066865680@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1403

           Summary: 2.6.0-test8 oops: Unable to handle kernel paging request
                    - free_pages_bulk
    Kernel Version: 2.6.0-test8
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: plars@austin.ibm.com
                CC: sglass@us.ibm.com


Distribution: RedHat 7.3
Hardware Environment: 
I'm including a little extra detail about the swap setup because it's different
than most people seem to have and may or may not be relevant.

8-way PIII-700
             total       used       free     shared    buffers     cached
Mem:      16281176     432284   15848892          0     124088      57900
-/+ buffers/cache:     250296   16030880
Swap:     14691152          0   14691152
Filename                        Type            Size    Used    Priority
/dev/sda3                       partition       1020116 0       -1
/dev/sda9                       partition       2048248 0       -2
/dev/sda5                       partition       2048248 0       -3
/dev/sda6                       partition       2048248 0       -4
/dev/sda7                       partition       2048248 0       -5
/dev/sda10                      partition       2048248 0       -6
/dev/sda11                      partition       1381548 0       -7
/dev/sda8                       partition       2048248 0       -8

Software Environment:
gcc 2.96, binutils 2.13.90

Problem Description:
I encountered the following oops and hang after 1 to 4 hours of running the test
proceedure described below.  I have encountered this on 2.6.0-test5, test7, and
test8.

Unable to handle kernel paging request at virtual address 00100104
 printing eip:
c0139e44
*pde = 123b6001
Oops: 0002 [#1]
CPU:    7
EIP:    0060:[<c0139e44>]    Not tainted
EFLAGS: 00010002
EIP is at free_pages_bulk+0x1a4/0x220
eax: 00100100   ebx: 0001a262   ecx: c14aa8e0   edx: 00200200
esi: 00006898   edi: c14aa8d8   ebp: fffffffe   esp: e0197d68
ds: 007b   es: 007b   ss: 0068
Process mmap3 (pid: 8059, threadinfo=e0196000 task=f6aa72f0)
Stack: 00000000 c14aa904 c038b8c8 00000002 c102c000 c038b8c8 00000082 ffffffff
       c040b268 0000000a 00000046 c012182b 00000046 0000001c 0bd15f60 e0197dd4
       c038b880 c150dedc c038bc00 00000282 c013a39a c038b6c0 0000000d c038bc10
Call Trace:
 [<c012182b>] do_softirq+0x6b/0xd0
 [<c013a39a>] free_hot_cold_page+0xba/0xf0
 [<c0109a1a>] apic_timer_interrupt+0x1a/0x20
 [<c013a8fb>] __pagevec_free+0x1b/0x30
 [<c013f43a>] release_pages+0x10a/0x150
 [<c0135c19>] remove_from_page_cache+0x29/0x30
 [<c013f49a>] __pagevec_release+0x1a/0x30
 [<c013fafe>] truncate_inode_pages+0xee/0x300
 [<c0143800>] unmap_page_range+0x60/0x80
 [<c016ad91>] generic_delete_inode+0x51/0xd0
 [<c016afa3>] iput+0x63/0x70
 [<c016840c>] dput+0x14c/0x180
 [<c01861d6>] ext3_release_file+0x16/0x50
 [<c0153dd7>] __fput+0xb7/0xe0
 [<c015278c>] filp_close+0x5c/0x70
 [<c01527f3>] sys_close+0x53/0x70
 [<c010902b>] syscall_call+0x7/0xb

Code: 89 50 04 89 02 c7 47 08 00 01 10 00 c7 41 04 00 02 20 00 83
Steps to reproduce:
I was running a vmm stress workload comprised of a subset of tests from LTP.  I
ran two copies of Pan (the ltp test driver) in parallel with the following tests.
First copy: mtest01 -p60 -w
This one is basically just a load generator for memory.  It allocates memory
until it hits 60% of the total memory (phys+swap) and writes to it.  This is
sufficient to ensure that swapping has occurred on this system.

Second copy:
   mmap1
   mmap2
   mmap3
   mallocstress

It always seems to be in mmap3 when it dies.  The mmap3 test does a lot of
map/write/unmaps of random sizes by multiple threads.

