Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbUL1PQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbUL1PQY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 10:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbUL1PQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 10:16:23 -0500
Received: from mercure.inha.fr ([194.214.199.252]:28890 "EHLO mercure.inha.fr")
	by vger.kernel.org with ESMTP id S261783AbUL1PPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 10:15:46 -0500
Message-ID: <41D178A0.7080001@inha.fr>
Date: Tue, 28 Dec 2004 16:15:44 +0100
From: Gildas LE NADAN <gildas.le-nadan@inha.fr>
Organization: Institut National d'Histoire de l'Art (INHA)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: unkillable processes using samba, xfs and lvm2 snapshots (k 2.6.10)
 [includes backtrace]
References: <41D14251.4030704@inha.fr> <20041228113946.GA10807@outpost.ds9a.nl>
In-Reply-To: <20041228113946.GA10807@outpost.ds9a.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  >>I experience hangs on samba processes on a filer using xfs over lvm2 as
>>data partitions, when there is active snapshots of the xfs partitions.
> 
> A trick is to enable alt-sysrq and press alt-sysrq-t (I think) which spams
> your syslog with backtraces of all processes currently running, including
> the ones stuck in 'D' state (ps aux | grep " D ").
> 
> If you isolate these backtraces and send them to this list, they will enable
> developers to help you. Make sure you add 'includes backtrace' in your
> Subject.

OK, this is what I get after provoking the problem on the test server 
(copying 1Go of data is enough to trigger the problem) :

# ps afx | grep smbd
  2279 ?        Ss     0:00 /usr/sbin/smbd -D
  2288 ?        S      0:00  \_ /usr/sbin/smbd -D
  2447 ?        D      0:01  \_ /usr/sbin/smbd -D
  2487 pts/0    S+     0:00  |               \_ grep smbd
#  killall -9 smbd
# ps afx | grep smbd
  2554 pts/0    S+     0:00  |               \_ grep smbd
  2447 ?        D      0:01 /usr/sbin/smbd -D


I did a "echo t > /proc/sysrq-trigger" and tried to clean the resulting 
logs a bit before sending. Hope this gives enough info, otherwise I kept 
the whole log so I can send whatever part is needed

  SysRq : Show State
                                                 sibling
    task             PC      pid father child younger older
  ...
xfslogd/0     S 00000004     0   218     11           220   216 (L-TLB)
  f7eecf44 00000046 f7eecf34 00000004 00000002 f60ef53c c0427ba0 f60ef5a8
         00000282 c01017cc 00000000 f7f28974 f7f2896c 00000000 c170f020 
00000000
         00000c41 ff6027e0 00000005 00000286 f7eb9530 f7eb96b0 f7eecf94 
00000002
  Call Trace:
   [__up+28/32] __up+0x1c/0x20
   [worker_thread+565/608] worker_thread+0x235/0x260
   [pagebuf_iodone_work+0/80] pagebuf_iodone_work+0x0/0x50
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [worker_thread+0/608] worker_thread+0x0/0x260
   [kthread+186/192] kthread+0xba/0xc0
   [kthread+0/192] kthread+0x0/0xc0
   [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
  xfslogd/1     S 00000004     0   219     10           221   217 (L-TLB)
  f7c82f44 00000046 f7c82f30 00000004 00000001 ffffffff f7eb9020 35a49146
         00000000 f7eb9020 c170f020 f7eb9020 00000000 c1717a00 c1717020 
00000001
         000008ae 0395f3e5 00000000 c171705c f7c7e020 f7c7e1a0 00000001 
f7f289dc
  Call Trace:
   [worker_thread+565/608] worker_thread+0x235/0x260
   [schedule+1132/3360] schedule+0x46c/0xd20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [worker_thread+0/608] worker_thread+0x0/0x260
   [kthread+186/192] kthread+0xba/0xc0
   [kthread+0/192] kthread+0x0/0xc0
   [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
  xfslogd/2     S 00000004     0   220     11           222   218 (L-TLB)
  f7eedf44 00000046 f7eedf34 00000004 00000004 00000000 f7c1f020 c01f4a99
         f714b13c 00000000 00000000 f7f28a74 f7f28a6c 00000000 c171f020 
00000002
         00000d47 6261fbfd 00000074 00000286 f7eb9020 f7eb91a0 f7eedf94 
00000008
  Call Trace:
   [xfs_buf_iodone_callbacks+361/368] xfs_buf_iodone_callbacks+0x169/0x170
   [worker_thread+565/608] worker_thread+0x235/0x260
   [pagebuf_iodone_work+0/80] pagebuf_iodone_work+0x0/0x50
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [worker_thread+0/608] worker_thread+0x0/0x260
   [kthread+186/192] kthread+0xba/0xc0
   [kthread+0/192] kthread+0x0/0xc0
   [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
  xfslogd/3     S 00000004     0   221     10           223   219 (L-TLB)
  f7c84f44 00000046 f7c84f34 00000004 00000003 ffffffff f7c27a40 35a47b19
         00000000 03969a3b 03969a3b 00000000 f7c84f28 c0116200 c1727020 
00000003
         00000ef7 0396cbec 00000000 00000286 f7c83a40 f7c83bc0 f7c84f94 
00000004
  Call Trace:
   [activate_task+144/176] activate_task+0x90/0xb0
   [worker_thread+565/608] worker_thread+0x235/0x260
   [schedule+1132/3360] schedule+0x46c/0xd20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [worker_thread+0/608] worker_thread+0x0/0x260
   [kthread+186/192] kthread+0xba/0xc0
   [kthread+0/192] kthread+0x0/0xc0
   [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
  xfsdatad/0    S 00000004     0   222     11           224   220 (L-TLB)
  f7f06f44 00000046 f7f06f30 00000004 00000002 ffffffff f7c83530 35a48050
         00000000 f7c83530 c1717020 f7c83530 00000000 c170fa00 c170f020 
00000000
         00000897 0397ce5a 00000000 c170f05c f7f05a40 f7f05bc0 00000002 
f7f28550
  Call Trace:
   [worker_thread+565/608] worker_thread+0x235/0x260
   [schedule+1132/3360] schedule+0x46c/0xd20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [worker_thread+0/608] worker_thread+0x0/0x260
   [kthread+186/192] kthread+0xba/0xc0
   [kthread+0/192] kthread+0x0/0xc0
   [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
  xfsdatad/1    S 00000004     0   223     10           225   221 (L-TLB)
  f7c85f44 00000046 f7c85f30 00000004 00000001 ffffffff f7f05530 35a47efe
         00000000 f7f05530 c170f020 f7f05530 00000000 c1717a00 c1717020 
00000001
         000008f9 0398532d 00000000 c171705c f7c83530 f7c836b0 00000001 
f7f285d0
  Call Trace:
   [worker_thread+565/608] worker_thread+0x235/0x260
   [schedule+1132/3360] schedule+0x46c/0xd20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [worker_thread+0/608] worker_thread+0x0/0x260
   [kthread+186/192] kthread+0xba/0xc0
   [kthread+0/192] kthread+0x0/0xc0
   [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
  xfsdatad/2    S 00000004     0   224     11           903   222 (L-TLB)
  f7f07f44 00000046 f7f07f34 00000004 00000004 ffffffff f7c1f020 35a493ed
         00000000 03985b99 03985b99 00000000 f7f07f28 c0116200 c171f020 
00000002
         00000d7c 03988e25 00000000 00000286 f7f05530 f7f056b0 f7f07f94 
00000008
  Call Trace:
   [activate_task+144/176] activate_task+0x90/0xb0
   [worker_thread+565/608] worker_thread+0x235/0x260
   [schedule+1132/3360] schedule+0x46c/0xd20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [worker_thread+0/608] worker_thread+0x0/0x260
   [kthread+186/192] kthread+0xba/0xc0
   [kthread+0/192] kthread+0x0/0xc0
   [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
  xfsdatad/3    S 00000004     0   225     10           902   223 (L-TLB)
  f7c87f44 00000046 f7c87f34 00000004 00000003 ffffffff f7c27a40 35a49032
         00000000 0398e44a 0398e44a 00000000 f7c87f28 c0116200 c1727020 
00000003
         000010b0 0399175f 00000000 00000286 f7c83020 f7c831a0 f7c87f94 
00000004
  Call Trace:
   [activate_task+144/176] activate_task+0x90/0xb0
   [worker_thread+565/608] worker_thread+0x235/0x260
   [schedule+1132/3360] schedule+0x46c/0xd20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [worker_thread+0/608] worker_thread+0x0/0x260
   [kthread+186/192] kthread+0xba/0xc0
   [kthread+0/192] kthread+0x0/0xc0
   [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
  xfsbufd       S 00000004     0   226      1           815   213 (L-TLB)
  f7f08f78 00000046 f7f08f68 00000004 00000001 00000000 f7c1f530 c02c1edb
         f7f70e64 00000000 f7eaa944 c0264f5f 00000004 c04f99e8 c1717020 
00000001
         00000134 6d117e89 0000009e c0125879 f7f05020 f7f051a0 00000000 
00000001
  Call Trace:
   [elv_next_request+27/256] elv_next_request+0x1b/0x100
   [kobject_put+31/48] kobject_put+0x1f/0x30
   [__mod_timer+249/320] __mod_timer+0xf9/0x140
   [schedule_timeout+117/208] schedule_timeout+0x75/0xd0
   [process_timeout+0/16] process_timeout+0x0/0x10
   [dm_unplug_all+39/64] dm_unplug_all+0x27/0x40
   [blk_backing_dev_unplug+0/32] blk_backing_dev_unplug+0x0/0x20
   [pagebuf_daemon+118/512] pagebuf_daemon+0x76/0x200
   [pagebuf_daemon+0/512] pagebuf_daemon+0x0/0x200
   [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
...
  xfssyncd      S 00000004     0  1361      1          1362  1360 (L-TLB)
  f756ef74 00000046 f756ef64 00000004 00000002 f5735568 c0427ba0 f5735568
         f756ef2c 0000022e 00000031 f714be3c f5735568 00000000 c170f020 
00000000
         000034a1 58c63e72 00000098 c0125879 f6fb6a40 f6fb6bc0 00000000 
00000002
  Call Trace:
   [__mod_timer+249/320] __mod_timer+0xf9/0x140
   [schedule_timeout+117/208] schedule_timeout+0x75/0xd0
   [process_timeout+0/16] process_timeout+0x0/0x10
   [xfssyncd+134/480] xfssyncd+0x86/0x1e0
   [xfssyncd+0/480] xfssyncd+0x0/0x1e0
   [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
  xfssyncd      S 00000004     0  1362      1          2233  1361 (L-TLB)
  f6accf74 00000046 f6accf64 00000004 00000002 f60f4360 c0427ba0 f60efc3c
         c050ad58 c023a3ee 00000031 f60efc3c f6d6ccd0 00000000 c170f020 
00000000
         00001568 6080d951 00000098 c0125879 f6a95530 f6a956b0 00000000 
00000002
  Call Trace:
   [pagebuf_rele+46/240] pagebuf_rele+0x2e/0xf0
   [__mod_timer+249/320] __mod_timer+0xf9/0x140
   [schedule_timeout+117/208] schedule_timeout+0x75/0xd0
   [process_timeout+0/16] process_timeout+0x0/0x10
   [xfssyncd+134/480] xfssyncd+0x86/0x1e0
   [xfssyncd+0/480] xfssyncd+0x0/0x1e0
   [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
...
  smbd          S 00000004     0  2279      1  2288    2285  2277 (NOTLB)
  f5110ea4 00000082 f5110e90 00000004 00000002 c013ed74 f6770020 c042cd80
         000000d0 f6770020 c1717020 f6770020 00000000 c170fa00 c170f020 
00000000
         0000b4c6 78f5a598 0000006d c170f05c f779a530 f779a6b0 00000002 
f5d37028
  Call Trace:
   [__alloc_pages+484/928] __alloc_pages+0x1e4/0x3a0
   [schedule_timeout+199/208] schedule_timeout+0xc7/0xd0
   [tcp_poll+52/400] tcp_poll+0x34/0x190
   [handle_mm_fault+344/384] handle_mm_fault+0x158/0x180
   [add_wait_queue+29/80] add_wait_queue+0x1d/0x50
   [pipe_poll+52/128] pipe_poll+0x34/0x80
   [do_select+401/736] do_select+0x191/0x2e0
   [__pollwait+0/208] __pollwait+0x0/0xd0
   [sys_select+731/1456] sys_select+0x2db/0x5b0
   [syscall_call+7/11] syscall_call+0x7/0xb
...
  smbd          D 00000004     0  2447   2279                2288 (NOTLB)
  f6736bbc 00000082 f6736bac 00000004 00000002 00000000 c0427ba0 00000000
         f6770020 c0118350 00000000 00000000 c17ff080 00000007 c170f020 
00000000
         00008e96 5602776d 00000071 00000000 f6770020 f67701a0 c023a197 
00000002
  Call Trace:
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [pagebuf_associate_memory+103/400] pagebuf_associate_memory+0x67/0x190
   [schedule_timeout+199/208] schedule_timeout+0xc7/0xd0
   [xlog_sync+630/1216] xlog_sync+0x276/0x4c0
   [xlog_state_release_iclog+91/272] xlog_state_release_iclog+0x5b/0x110
   [add_wait_queue_exclusive+26/80] add_wait_queue_exclusive+0x1a/0x50
   [xlog_state_sync+602/656] xlog_state_sync+0x25a/0x290
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [xlog_assign_tail_lsn+73/128] xlog_assign_tail_lsn+0x49/0x80
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [xfs_log_force+132/144] xfs_log_force+0x84/0x90
   [xfs_trans_commit+631/1008] xfs_trans_commit+0x277/0x3f0
   [xfs_trans_dup+191/208] xfs_trans_dup+0xbf/0xd0
   [xfs_itruncate_finish+593/1072] xfs_itruncate_finish+0x251/0x430
   [xfs_setattr+3578/4128] xfs_setattr+0xdfa/0x1020
   [linvfs_setattr+258/384] linvfs_setattr+0x102/0x180
   [kmem_cache_alloc+114/192] kmem_cache_alloc+0x72/0xc0
   [linvfs_setattr+0/384] linvfs_setattr+0x0/0x180
   [notify_change+334/400] notify_change+0x14e/0x190
   [do_truncate+147/208] do_truncate+0x93/0xd0
   [fget+73/96] fget+0x49/0x60
   [sys_ftruncate64+204/304] sys_ftruncate64+0xcc/0x130
   [sys_open+108/144] sys_open+0x6c/0x90
   [syscall_call+7/11] syscall_call+0x7/0xb
