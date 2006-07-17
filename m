Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWGQS24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWGQS24 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWGQS24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:28:56 -0400
Received: from dvhart.com ([64.146.134.43]:39604 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751136AbWGQS2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:28:55 -0400
Message-ID: <44BBD6E2.6020309@mbligh.org>
Date: Mon, 17 Jul 2006 14:28:50 -0400
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: [Bugme-new] [Bug 6853] New: NFS-stress triggers Kernel BUG
 at	mm/truncate.c:76]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please cc: JF@vanbaarlen.demon.nl, and bugme-daemon@bugzilla.kernel.org
on all replies.

http://bugzilla.kernel.org/show_bug.cgi?id=6853

            Summary: NFS-stress triggers Kernel BUG at mm/truncate.c:76
     Kernel Version: 2.6.17.6, x86_64
             Status: NEW
           Severity: normal
              Owner: trond.myklebust@fys.uio.no
          Submitter: JF@vanbaarlen.demon.nl


Running a machine with 8 dualcore Opterons 875 (16cores total), which 
makes it
far more sensitive to locking-, timing- and racing bugs than the average 
linux-
machine.
Running a multi-threaded app (16 threads) that reads small portions of data
from a large file (stored on remote server, accessed over NFS-udp), and 
write
back to another file - same NFS-share. System crashes really hard (beyond
softwatchdog- and oops-recovery) anywhere between 1 and 15 minutes.

On 2.6.15.x, problem appeared first, was fixed by kernelpatches to 
file.c and
pagelist.c.

Went to 2.6.17.6 for the much improved multi-dualcore support, same problem
appeared - unfortunately the original patch is integrated already, so it 
must
be something else this time.

Kernel does not OOPS, but it locks up - on all CPUs, according to the logs.

Kernel BUG at mm/truncate.c:76
invalid opcode: 0000 [1] SMP
CPU 14
Modules linked in: nfs netconsole sch_sfq cls_u32 sch_tbf sch_prio
iptable_filter ip_tables x_tables nfsd exportfs lockd 8250 seri
al_core ipv6 parport_pc lp parport autofs4 sunrpc w83627hf_wdt 
binfmt_misc xfs
dm_mod video button battery ac ohci1394 ieee1394 oh
ci_hcd ehci_hcd i2c_nforce2 i2c_core tg3 floppy ide_cd cdrom
Pid: 8086, comm: dipfilter.x Not tainted 2.6.17.6 #1
RIP: 0010:[<ffffffff8025eb96>] 
<ffffffff8025eb96>{invalidate_complete_page+86}
RSP: 0018:ffff810393c09ca8  EFLAGS: 00010002
RAX: 0000000000000825 RBX: ffff8105ff8d86f0 RCX: ffff8103f271bb08
RDX: 0000000000000000 RSI: ffff810393c09c48 RDI: ffff8103f271bd88
RBP: ffff8103f271bd70 R08: 0000000000000001 R09: 000000000000002c
R10: 000000000000002c R11: ffff8105f8a26240 R12: ffff810393c09e08
R13: 0000000000000000 R14: ffff8103f271bd70 R15: 00000000000d1a2c
FS:  00002accace13dc0(0000) GS:ffff810e001bd9c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002b050fbff000 CR3: 0000000ff7c21000 CR4: 00000000000006e0
Process dipfilter.x (pid: 8086, threadinfo ffff810393c08000, task
ffff8103f8b70280)
Stack: 00000000000d1a2b ffff8105ff8d86f0 0000000000000000 ffffffff8025f0c0
        0000000000000000 00000000f271bc28 0000000000000000 ffffffffffffffff
        000000000000000e 0000000000000000
Call Trace: <ffffffff8025f0c0>{invalidate_inode_pages2_range+320}
        <ffffffff882042d9>{:nfs:nfs_revalidate_mapping+105}
        <ffffffff88202e29>{:nfs:nfs_file_write+169} <ffffffff8027d710>
{do_sync_write+208}
        <ffffffff802424e0>{autoremove_wake_function+0} <ffffffff80227a00>
{default_wake_function+0}
        <ffffffff8027d80f>{vfs_write+191} <ffffffff8027d9a3>{sys_write+83}
        <ffffffff80209c06>{system_call+126}
Code: 0f 0b 68 dc f2 46 80 c2 4c 00 48 89 df e8 18 74 ff ff f0 81
RIP <ffffffff8025eb96>{invalidate_complete_page+86} RSP <ffff810393c09ca8>
  NMI Watchdog detected LOCKUP on CPU 10
CPU 10
Modules linked in: nfs netconsole sch_sfq cls_u32 sch_tbf sch_prio
iptable_filter ip_tables x_tables nfsd exportfs lockd 8250 seri
al_core ipv6 parport_pc lp parport autofs4 sunrpc w83627hf_wdt 
binfmt_misc xfs
dm_mod video button battery ac ohci1394 ieee1394 oh
ci_hcd ehci_hcd i2c_nforce2 i2c_core tg3 floppy ide_cd cdrom
Pid: 8106, comm: dipfilter.x Not tainted 2.6.17.6 #1
RIP: 0010:[<ffffffff80309579>] <ffffffff80309579>{__read_lock_failed+5}
RSP: 0018:ffff8103f8647c08  EFLAGS: 00000097
RAX: ffff8103f271bd88 RBX: 00000000000d2431 RCX: ffff8103f8647d58
RDX: 0000000000000000 RSI: 00000000000d2431 RDI: ffff8103f271bd88
RBP: ffff8103f271bd70 R08: ffff8103f8646000 R09: 00000000ffffffff
R10: 00000000d2864068 R11: 0000000000000001 R12: ffff8103f271bd70
R13: 0000000000001000 R14: 0000000000001000 R15: ffff8103f8e83be8
FS:  00002b15cc9e2dc0(0000) GS:ffff810a0016ad40(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fff0b64dbd8 CR3: 0000000393c21000 CR4: 00000000000006e0
Process dipfilter.x (pid: 8106, threadinfo ffff8103f8646000, task
ffff8103f8645820)
Stack: ffffffff8044802a ffffffff802569b5 ffff8103f271bd70 ffff810bff67f678
        00000000000d2431 ffffffff80256f7d ffffffff804479ec 0000000000000000
        0000000000000000 00000000d2438000
Call Trace: <ffffffff8044802a>{.text.lock.spinlock+83}
        <ffffffff802569b5>{find_get_page+21} <ffffffff80256f7d>
{do_generic_mapping_read+397}
        <ffffffff804479ec>{__up_wakeup+53} 
<ffffffff80257360>{file_read_actor+0}
        <ffffffff802591e9>{__generic_file_aio_read+425} <ffffffff802593f4>
{generic_file_aio_read+52}
        <ffffffff88202aba>{:nfs:nfs_file_read+170} <ffffffff8027d490>
{do_sync_read+208}
        <ffffffff802424e0>{autoremove_wake_function+0} <ffffffff80227a00>
{default_wake_function+0}
        <ffffffff8027d58c>{vfs_read+188} <ffffffff8027d913>{sys_read+83}
        <ffffffff80209c06>{system_call+126}

Code: 83 38 01 78 f9 f0 ff 08 0f 88 ed ff ff ff c3 90 90 90 90 90
console shuts up ...
  NMI Watchdog detected LOCKUP on CPU 0
<and so on for all CPUs>

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


