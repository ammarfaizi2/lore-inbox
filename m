Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbTGBQNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbTGBQNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:13:31 -0400
Received: from franka.aracnet.com ([216.99.193.44]:57564 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265091AbTGBQN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:13:29 -0400
Date: Wed, 02 Jul 2003 09:27:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 863] New: cat /proc/buddyinfo + netstat -a kills machine
Message-ID: <25670000.1057163262@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: cat /proc/buddyinfo + netstat -a kills machine
    Kernel Version: 2.5.73-bk10
            Status: NEW
          Severity: blocking
             Owner: akpm@digeo.com
         Submitter: slpratt@us.ibm.com


Distribution:SLES
Hardware Environment:8way 900Mhz PIII

Problem Description:
on 2.5.73-bk10 as well as 2.5.73-mm3, issuing netsta -a followed by cat
/proc/buddy infor causes segfaults and locks up the system.

Repeated issuing of netstat -a prodices the following trap:

Unable to handle kernel paging request at virtual address 00c1a000
 printing eip:
c01405ed
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c01405ed>]    Not tainted
EFLAGS: 00010086
EIP is at kfree+0x3d/0x70
eax: 00000001   ebx: 00c1a000   ecx: f65b85c0   edx: c19f6009
esi: 00000100   edi: 00000206   ebp: f57c9720   esp: f5b13f4c
ds: 007b   es: 007b   ss: 0068
Process netstat (pid: 2545, threadinfo=f5b12000 task=f58bb960)
Stack: f68fd438 00000000 f68fd420 f65b85c0 f6caead0 c0173fd5 00000100 f65b85c0
       f65b85c0 f7fdeb60 f6caead0 c0156c21 f6caead0 f65b85c0 f65b85c0 0805f038
       f6aaf440 00000000 c01552a9 f65b85c0 f6aaf440 f65b85c0 0805f038 0805f038
Call Trace:
 [<c0173fd5>] seq_release_private+0x25/0x48
 [<c0156c21>] __fput+0xb1/0xc0
 [<c01552a9>] filp_close+0x99/0xd0
 [<c015533e>] sys_close+0x5e/0x80
 [<c010afdf>] syscall_call+0x7/0xb

Cating of /proc/buddy info produces:
<1>Unable to handle kernel paging request at virtual address 08c19ec0
 printing eip:
c013d5e0
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c013d5e0>]    Not tainted
EFLAGS: 00010006
EIP is at frag_show+0xd0/0x140
eax: 08c19ec0   ebx: c047e3f8   ecx: 08c19ec0   edx: c19f6009
esi: 000006b7   edi: c047e1f8   ebp: c047e3f8   esp: f60b7f0c
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 5355, threadinfo=f60b6000 task=f52aa0c0)
Stack: f68fd520 c041caa6 00000000 c041ca07 00000078 00000000 00000206 c047e180
       c047c980 f68fd520 c047c980 00000000 c01737a2 f68fd520 c047c980 00002000
       f68fd538 00000000 c014a082 f6ba1dc0 00000000 00000000 00000000 c66d5a20
Call Trace:
 [<c01737a2>] seq_read+0x102/0x300
 [<c014a082>] do_brk+0x142/0x220
 [<c0155b4e>] vfs_read+0xbe/0x130
 [<c0155df2>] sys_read+0x42/0x70
 [<c010afdf>] syscall_call+0x7/0xb

Code: 8b 01 89 ca 46 89 c1 0f 18 00 90 39 da 75 f1 c7 44 24 04 a6
 /autobench/scripts/getsysinfo: line 133:  5355 Segmentation fault      cat
/proc/buddyinfo >
$2/proc/buddyinfo.$1$RUN_SUFFIX


Steps to reproduce:
run netstat -a a few times until it traps.  then cat /proc/buddyinfo and hte
system will be locked up.

