Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTJIUXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTJIUXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:23:47 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34493 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262424AbTJIUXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:23:44 -0400
Date: Thu, 09 Oct 2003 13:23:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: olh@suse.de
Subject: [Bug 1338] New: 2.6.0-test7 oops in proc_pid_stat
Message-ID: <40180000.1065730990@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1338

           Summary: 2.6.0-test7 oops in proc_pid_stat
    Kernel Version: 2.6.0-test7
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: olh@suse.de


Distribution: SuSE SLES8 i386
Hardware Environment: IBM Blade center, 2 xeon cpus, 2.4Ghz, 512MB
Software Environment:gcc3.2.2
Problem Description:

pstree -V
pstree (psmisc) 21.3

Unable to handle kernel NULL pointer dereference at virtual address 0000003c

virtual address is always the same.
oops one, reported to the lkml:

Linux version 2.6.0-test7 (olaf@zert152) (gcc version 3.2.2) #2 SMP Thu Oct 9 08:49:29 CEST 2003

Unable to handle kernel NULL pointer dereference at virtual address 0000003c
 printing eip:
c018a322
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c018a322>]    Not tainted
EFLAGS: 00010246
EIP is at proc_pid_stat+0x92/0x510
eax: 00000000   ebx: df2b0d80   ecx: 00000000   edx: c038afcc
esi: 00000000   edi: df2b0d80   ebp: 00000000   esp: ce85de3c
ds: 007b   es: 007b   ss: 0068
Process pstree (pid: 3518, threadinfo=ce85c000 task=dbb38c80)
Stack: df94b900 c034f440 00000dad df6b5bda 00000053 00000d99 00000419 00000419
       0000040d 00000419 00000100 00000086 000000e0 00000106 00000284 00000000
       cf6419b4 cf641940 ce136006 c0187ce8 df2b0d80 cf641940 ce85df38 dffd3820
Call Trace:
 [<c0187ce8>] pid_revalidate+0x28/0xd0
 [<c0170300>] dput+0x30/0x1b0
 [<c0140ac3>] buffered_rmqueue+0xc3/0x150
 [<c0140c00>] __alloc_pages+0xb0/0x350
 [<c0187174>] proc_info_read+0x74/0x160
 [<c015904e>] vfs_read+0xbe/0x130
 [<c01592f2>] sys_read+0x42/0x70
 [<c010b52f>] syscall_call+0x7/0xb

Code: 8b 48 3c 85 c9 74 40 8b 81 98 00 00 00 89 84 24 d4 00 00 00

config is all static. I was reading a CD in the foreground and 2 rpm
builds in the background.


another one after reboot:

Unable to handle kernel NULL pointer dereference at virtual address 0000003c
 printing eip:
c018a322
*pde = 00000000
Oops: 0000 [#3]
CPU:    1
EIP:    0060:[<c018a322>]    Not tainted
EFLAGS: 00010246
EIP is at proc_pid_stat+0x92/0x510
eax: 00000000   ebx: df8798e0   ecx: 00000000   edx: c038afcc
esi: 00000000   edi: df8798e0   ebp: 00000000   esp: ca841e3c
ds: 007b   es: 007b   ss: 0068
Process pstree (pid: 2218, threadinfo=ca840000 task=df58d9a0)
Stack: d0301000 c034f440 000008a9 df879bda 0000005a 00000899 00000419 00000419
       0000040d 00000419 00000104 0000001e 00000000 00000090 00000000 00000000
       00000000 00000000 00000000 00000022 00000009 00000000 00000000 001efdc0
Call Trace:
 [<c0140ac3>] buffered_rmqueue+0xc3/0x150
 [<c0140c00>] __alloc_pages+0xb0/0x350
 [<c0187174>] proc_info_read+0x74/0x160
 [<c015904e>] vfs_read+0xbe/0x130
 [<c01592f2>] sys_read+0x42/0x70
 [<c010b52f>] syscall_call+0x7/0xb

Code: 8b 48 3c 85 c9 74 40 8b 81 98 00 00 00 89 84 24 d4 00 00 00


Anton Blanchard sees the same on ppc64, but I dont have details.

Steps to reproduce:
'it happens' after maybe 6 hours uptime.
system is busy building packages in the background, pstree calls are part of the build process management.
There is a while loop to read from the USB cdrom ( the reason why I did boot 2.6):

screen  -S cdtest -- sh -c 'for i in `seq 0 420` `seq 0 420` ; do date; umount -v /media/cdrom ; mount -v /media/cdrom ; find /media/cdrom -type f -print0 | xargs -0 --verbose -n1 cat > /dev/null || break ; done &>log'


