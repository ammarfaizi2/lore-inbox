Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWDTJxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWDTJxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWDTJxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:53:41 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:25234 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750800AbWDTJxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:53:39 -0400
Date: Thu, 20 Apr 2006 12:53:35 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org, torvalds@osdl.org
cc: agk@redhat.com, linux-kernel@vger.kernel.org
Subject: [PROBLEM] Device-mapper snapshot metadata userspace breakage
Message-ID: <Pine.LNX.4.58.0604201159350.29821@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus,

The commit aa14edeb994f8f7e223d02ad14780bf2fa719f6d "[PATCH] device-mapper 
snapshot: load metadata on creation" breaks userspace and is blocking us 
from moving to the 2.6.16 series kernel. Debian doesn't have the 
new required LVM version in stable yet. Is the change intentional?

The problem is that lvremove program hangs in 'D' state forever with the 
above commit for snapshots. I have included little more detail below.

				Pekka

[1.] One line summary of the problem:
[2.] Full description of the problem/report:
[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):

Linux version 2.6.16.9 (frank@susi) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 SMP Wed Apr 19 15:03:49 EEST 2006

[5.] Most recent kernel version which did not have the bug:

aa14edeb994f8f7e223d02ad14780bf2fa719f6d is first bad commit

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
[7.] A small shell script or example program which triggers the
     problem (if possible)

lvcreate -L100M -n foo vg_os
mkreiserfs -q /dev/vg_os/foo
lvcreate -s -L50M -n snap /dev/vg_os/foo
lvremove -f /dev/vg_os/snap

[8.] Environment

Debian 3.1 Sarge (stable)

[8.1.] Software (add the output of the ver_linux script here)

lvm2  2.01.04-5
device-mapper 1.01.00-4

[8.2.] Processor information (from /proc/cpuinfo):
[8.3.] Module information (from /proc/modules):
[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[8.5.] PCI information ('lspci -vvv' as root)
[8.6.] SCSI information (from /proc/scsi/scsi)
[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

echo t > /proc/sysreq-trigger

33a>] default_wake_function+0x0/0x12
 [reparent_to_init+270/384] reparent_to_init+0x10e/0x180
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [sigprocmask+71/198] sigprocmask+0x47/0xc6
 [nfsd+243/837] nfsd+0xf3/0x345
 [nfsd+0/837] nfsd+0x0/0x345
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
nfsd          S C011548D     0  3755      1          3756  3754 (L-TLB)
f4b0bf00 00000000 c18064e0 c011548d f7e6a550 c18064e0 00000001 00000011 
       00000000 00040001 00000e7f 00000286 00000286 f7e6a550 c18064e0 00000125 
       24041156 0000002c f7f49030 f7f49158 f4b0bf14 000525d4 f75d8918 f4287400 
Call Trace:
 [try_to_wake_up+666/769] try_to_wake_up+0x29a/0x301
 [schedule_timeout+86/170] schedule_timeout+0x56/0xaa
 [process_timeout+0/9] process_timeout+0x0/0x9
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [svc_recv+915/1200] svc_recv+0x393/0x4b0
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [reparent_to_init+270/384] reparent_to_init+0x10e/0x180
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [sigprocmask+71/198] sigprocmask+0x47/0xc6
 [nfsd+243/837] nfsd+0xf3/0x345
 [nfsd+0/837] nfsd+0x0/0x345
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
nfsd          S 0000008D     0  3756      1          3757  3755 (L-TLB)
f4689f00 00000000 c18064e0 0000008d 00000000 c16a9ea0 00000000 00000000 
       00000000 00000296 00000282 00000286 00000286 c0124c1d c18064e0 000000af 
       269b9727 0000008d f7e6a550 f7e6a678 f4689f14 0005c8bc f75d8918 f54eae00 
Call Trace:
 [lock_timer_base+36/73] lock_timer_base+0x24/0x49
 [schedule_timeout+86/170] schedule_timeout+0x56/0xaa
 [process_timeout+0/9] process_timeout+0x0/0x9
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [svc_recv+915/1200] svc_recv+0x393/0x4b0
 [svc_send+143/245] svc_send+0x8f/0xf5
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [sigprocmask+71/198] sigprocmask+0x47/0xc6
 [nfsd+243/837] nfsd+0xf3/0x345
 [nfsd+0/837] nfsd+0x0/0x345
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
nfsd          S 0000008D     0  3757      1          3758  3756 (L-TLB)
f4b13f00 f7e6a550 c1806520 0000008d 00000000 c1598900 00000000 00000000 
       00000000 269b9049 0000008d 00003518 00000000 f7e6a550 c18064e0 000005f6 
       269b9049 0000008d f7bb3a70 f7bb3b98 f4b13f14 0005c8bc f75d8918 f54ea800 
Call Trace:
 [schedule_timeout+86/170] schedule_timeout+0x56/0xaa
 [process_timeout+0/9] process_timeout+0x0/0x9
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [svc_recv+915/1200] svc_recv+0x393/0x4b0
 [svc_send+143/245] svc_send+0x8f/0xf5
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [sigprocmask+71/198] sigprocmask+0x47/0xc6
 [nfsd+243/837] nfsd+0xf3/0x345
 [nfsd+0/837] nfsd+0x0/0x345
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
lockd         S C1803060     0  3758      1          3763  3757 (L-TLB)
f4b11f18 00000000 c18064e0 c1803060 f7b371f0 f7f01550 f7b37030 f7f01550 
       f78bd040 f4b0df50 00000286 00000286 c0339d3e f7d58550 c18064e0 000002bc 
       240437ae 0000002c f7f01550 f7f01678 7fffffff f54ea160 f3f44a98 f54ea000 
Call Trace:
 [skb_dequeue+71/88] skb_dequeue+0x47/0x58
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [svc_reserve+92/116] svc_reserve+0x5c/0x74
 [svc_sock_release+202/380] svc_sock_release+0xca/0x17c
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [svc_recv+915/1200] svc_recv+0x393/0x4b0
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [lockd+252/552] lockd+0xfc/0x228
 [lockd+0/552] lockd+0x0/0x228
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
rpciod/0      S C04DA580     0  3759      6                1532 (L-TLB)
f4b0df50 00000000 c18064e0 c04da580 00000000 c04da580 00000086 f7b374b4 
       00000000 00000000 f4b0c000 f4b0c000 f7b37030 f7f01550 c18064e0 000000d6 
       24042cbb 0000002c f7b37030 f7b37158 f3f5aad4 f4b0df8c f3f5aacc f4b0c000 
Call Trace:
 [worker_thread+329/356] worker_thread+0x149/0x164
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [worker_thread+0/356] worker_thread+0x0/0x164
 [kthread+183/189] kthread+0xb7/0xbd
 [kthread+0/189] kthread+0x0/0xbd
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
rpc.mountd    S C043CD00     0  3763      1          3766  3758 (NOTLB)
f428de6c 00000000 c18064e0 c043cd00 00000010 c043d180 00000000 00000001 
       000000d0 f7fb2ec0 f428def8 f7dfe118 c013ec46 f7f78550 c18064e0 0000c4a0 
       25ced23b 0000002c f7df7a70 f7df7b98 7fffffff 00000020 00000005 00000005 
Call Trace:
 [__get_free_pages+56/78] __get_free_pages+0x38/0x4e
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [tcp_poll+45/373] tcp_poll+0x2d/0x175
 [sock_poll+35/43] sock_poll+0x23/0x2b
 [do_select+414/757] do_select+0x19e/0x2f5
 [__pollwait+0/199] __pollwait+0x0/0xc7
 [core_sys_select+493/790] core_sys_select+0x1ed/0x316
 [do_page_fault+394/1584] do_page_fault+0x18a/0x630
 [sys_select+184/392] sys_select+0xb8/0x188
 [detach_pid+21/90] detach_pid+0x15/0x5a
 [sys_setsid+153/199] sys_setsid+0x99/0xc7
 [syscall_call+7/11] syscall_call+0x7/0xb
qmail-send    S 00000044     0  3766      1  3768    3774  3763 (NOTLB)
f48ebe6c 00000000 c18064e0 00000044 c043d180 000000d0 f7f78550 c043c880 
       c013e96a 000200d0 00000000 00000282 00000282 c0124c1d c18064e0 00022b0a 
       2f4cfc90 0000002c f7f78550 f7f78678 f48ebe80 0001f1fb 00000009 00000009 
Call Trace:
 [__alloc_pages+86/762] __alloc_pages+0x56/0x2fa
 [lock_timer_base+36/73] lock_timer_base+0x24/0x49
 [schedule_timeout+86/170] schedule_timeout+0x56/0xaa
 [process_timeout+0/9] process_timeout+0x0/0x9
 [do_select+414/757] do_select+0x19e/0x2f5
 [__pollwait+0/199] __pollwait+0x0/0xc7
 [core_sys_select+493/790] core_sys_select+0x1ed/0x316
 [sys_select+184/392] sys_select+0xb8/0x188
 [do_gettimeofday+30/186] do_gettimeofday+0x1e/0xba
 [syscall_call+7/11] syscall_call+0x7/0xb
splogger      S C043CD00     0  3768   3766          3769       (NOTLB)
f48c3ebc 00000000 c18064e0 c043cd00 fffb5258 f7a0e9a8 f7b001d8 00000000 
       c033372f 00000000 ecc47780 bfdb8988 c0334ef4 ecc47780 c18064e0 00000467 
       2ef03c5f 0000002c f7dce030 f7dce158 f53f593c f53f58c8 f48c3ee4 f78a7000 
Call Trace:
 [sockfd_lookup+24/128] sockfd_lookup+0x18/0x80
 [sys_sendto+239/254] sys_sendto+0xef/0xfe
 [pipe_wait+119/146] pipe_wait+0x77/0x92
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [get_unused_fd+131/193] get_unused_fd+0x83/0xc1
 [pipe_readv+361/679] pipe_readv+0x169/0x2a7
 [unix_create+62/120] unix_create+0x3e/0x78
 [pipe_read+55/59] pipe_read+0x37/0x3b
 [vfs_read+164/367] vfs_read+0xa4/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
qmail-lspawn  S 00000044     0  3769   3766          3770  3768 (NOTLB)
ecc5fe6c 00000000 c18064e0 00000044 c043d180 000000d0 c1ba2a70 c043c880 
       c013e96a 000200d0 00000000 c043d180 00000044 f7faca70 c18064e0 00004267 
       2af5fac2 0000002c c1ba2a70 c1ba2b98 7fffffff 00000002 00000001 00000001 
Call Trace:
 [__alloc_pages+86/762] __alloc_pages+0x56/0x2fa
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [pipe_poll+60/179] pipe_poll+0x3c/0xb3
 [do_select+414/757] do_select+0x19e/0x2f5
 [__pollwait+0/199] __pollwait+0x0/0xc7
 [core_sys_select+493/790] core_sys_select+0x1ed/0x316
 [dnotify_parent+56/144] dnotify_parent+0x38/0x90
 [sys_select+184/392] sys_select+0xb8/0x188
 [sys_rt_sigprocmask+130/256] sys_rt_sigprocmask+0x82/0x100
 [syscall_call+7/11] syscall_call+0x7/0xb
qmail-rspawn  S 00000044     0  3770   3766          3771  3769 (NOTLB)
ecc61e6c 00000000 c18064e0 00000044 c043d180 000000d0 f7faca70 c043c880 
       c013e96a 000200d0 00000000 c043d180 00000044 f7858030 c18064e0 0000a14c 
       2af92141 0000002c f7faca70 f7facb98 7fffffff 00000002 00000001 00000001 
Call Trace:
 [__alloc_pages+86/762] __alloc_pages+0x56/0x2fa
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [pipe_poll+60/179] pipe_poll+0x3c/0xb3
 [do_select+414/757] do_select+0x19e/0x2f5
 [__pollwait+0/199] __pollwait+0x0/0xc7
 [core_sys_select+493/790] core_sys_select+0x1ed/0x316
 [dnotify_parent+56/144] dnotify_parent+0x38/0x90
 [sys_select+184/392] sys_select+0xb8/0x188
 [sys_rt_sigprocmask+130/256] sys_rt_sigprocmask+0x82/0x100
 [syscall_call+7/11] syscall_call+0x7/0xb
qmail-clean   S C043CD00     0  3771   3766                3770 (NOTLB)
ecc63ebc 00000000 c18064e0 c043cd00 fffb5110 b7e22000 c17e7640 b7e43000 
       c0146408 fffb5210 00000007 3f3b2067 00000000 f7f78550 c18064e0 00005585 
       2afa7755 0000002c f7858030 f7858158 f39ef63c f39ef5c8 ecc63ee4 ecc4de00 
Call Trace:
 [zap_pte_range+241/790] zap_pte_range+0xf1/0x316
 [pipe_wait+119/146] pipe_wait+0x77/0x92
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [unmap_vmas+236/474] unmap_vmas+0xec/0x1da
 [pipe_readv+361/679] pipe_readv+0x169/0x2a7
 [free_pgtables+98/157] free_pgtables+0x62/0x9d
 [pipe_read+55/59] pipe_read+0x37/0x3b
 [vfs_read+164/367] vfs_read+0xa4/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
tcpserver     S 00000000     0  3774      1          3775  3766 (NOTLB)
ecc67df8 00000000 c18064e0 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 c18064e0 0002f908 
       2cc67a96 0000002c f7f01030 f7f01158 7fffffff f516d280 ecc66000 7fffffff 
Call Trace:
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [inet_csk_wait_for_connect+224/228] inet_csk_wait_for_connect+0xe0/0xe4
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [inet_csk_accept+96/346] inet_csk_accept+0x60/0x15a
 [inet_accept+50/181] inet_accept+0x32/0xb5
 [sys_accept+163/323] sys_accept+0xa3/0x143
 [__handle_mm_fault+372/806] __handle_mm_fault+0x174/0x326
 [copy_from_user+70/124] copy_from_user+0x46/0x7c
 [sys_socketcall+201/596] sys_socketcall+0xc9/0x254
 [sys_rt_sigprocmask+130/256] sys_rt_sigprocmask+0x82/0x100
 [syscall_call+7/11] syscall_call+0x7/0xb
splogger      S 00000000     0  3775      1          3781  3774 (NOTLB)
ecc69ebc 00000000 c18064e0 00000000 00000000 f7a0e9a8 c1bf95cc f7a0e9a8 
       c013a337 f7a0e9ac 000000ca 00000001 c013b4a3 f7da9550 c18064e0 0005d7e8 
       2a01c323 0000002c f7e1f030 f7e1f158 f39ef37c f39ef308 ecc69ee4 f53c7c00 
Call Trace:
 [find_get_page+38/77] find_get_page+0x26/0x4d
 [filemap_nopage+455/915] filemap_nopage+0x1c7/0x393
 [pipe_wait+119/146] pipe_wait+0x77/0x92
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [pipe_readv+361/679] pipe_readv+0x169/0x2a7
 [pipe_read+55/59] pipe_read+0x37/0x3b
 [vfs_read+164/367] vfs_read+0xa4/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
sshd          S C043C880     0  3781      1  3892    3791  3775 (NOTLB)
f358de6c 00000000 c18064e0 c043c880 c013e96a 000200d0 00000000 c043d180 
       00000044 c013e6c2 00000010 c043d180 00000000 f7df7030 c18064e0 0000096f 
       646d434d 0000002d f7b4f030 f7b4f158 7fffffff 00000020 00000005 00000005 
Call Trace:
 [__alloc_pages+86/762] __alloc_pages+0x56/0x2fa
 [buffered_rmqueue+255/521] buffered_rmqueue+0xff/0x209
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [tcp_poll+45/373] tcp_poll+0x2d/0x175
 [sock_poll+35/43] sock_poll+0x23/0x2b
 [do_select+414/757] do_select+0x19e/0x2f5
 [__pollwait+0/199] __pollwait+0x0/0xc7
 [core_sys_select+493/790] core_sys_select+0x1ed/0x316
 [sys_select+184/392] sys_select+0xb8/0x188
 [filp_close+77/121] filp_close+0x4d/0x79
 [sys_close+109/139] sys_close+0x6d/0x8b
 [syscall_call+7/11] syscall_call+0x7/0xb
rpc.statd     S 00000000     0  3790      1          3794  3791 (NOTLB)
f48efe6c 00000000 c18064e0 00000000 00000010 c043d180 00000000 00000000 
       000000d0 f78d1b40 f48efef8 ecc7da98 c013ec46 f7da9030 c18064e0 00000a9e 
       39419075 0000002c f7f01a70 f7f01b98 7fffffff 00000080 00000007 00000007 
Call Trace:
 [__get_free_pages+56/78] __get_free_pages+0x38/0x4e
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [tcp_poll+45/373] tcp_poll+0x2d/0x175
 [sock_poll+35/43] sock_poll+0x23/0x2b
 [do_select+414/757] do_select+0x19e/0x2f5
 [__pollwait+0/199] __pollwait+0x0/0xc7
 [core_sys_select+493/790] core_sys_select+0x1ed/0x316
 [sys_select+184/392] sys_select+0xb8/0x188
 [filp_close+77/121] filp_close+0x4d/0x79
 [sys_close+109/139] sys_close+0x6d/0x8b
 [syscall_call+7/11] syscall_call+0x7/0xb
xinetd        S 00000044     0  3791      1          3790  3781 (NOTLB)
f3593e6c 00000000 c18064e0 00000044 c043d180 000000d0 f7b3b030 c043c880 
       c013e96a 000200d0 00000000 c043d180 00000044 c1ba2030 c18064e0 0000071c 
       4311db83 0000002c f7b3b030 f7b3b158 7fffffff 00000040 00000006 00000006 
Call Trace:
 [__alloc_pages+86/762] __alloc_pages+0x56/0x2fa
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [tcp_poll+45/373] tcp_poll+0x2d/0x175
 [sock_poll+35/43] sock_poll+0x23/0x2b
 [do_select+414/757] do_select+0x19e/0x2f5
 [__pollwait+0/199] __pollwait+0x0/0xc7
 [core_sys_select+493/790] core_sys_select+0x1ed/0x316
 [sys_select+184/392] sys_select+0xb8/0x188
 [sys_rt_sigprocmask+161/256] sys_rt_sigprocmask+0xa1/0x100
 [syscall_call+7/11] syscall_call+0x7/0xb
ntpd          S 00000086     0  3794      1          3797  3790 (NOTLB)
ecc6be6c 00000000 c18064e0 00000086 00000010 c043d180 00000000 bfde8ccc 
       000000d0 f78d1780 ecc6bef8 ecc7d298 c013ec46 c168dfe0 c18064e0 000004f8 
       7c67990d 0000008d f7b3ba70 f7b3bb98 7fffffff 00000200 00000009 00000009 
Call Trace:
 [__get_free_pages+56/78] __get_free_pages+0x38/0x4e
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [udp_poll+35/247] udp_poll+0x23/0xf7
 [sock_poll+35/43] sock_poll+0x23/0x2b
 [do_select+414/757] do_select+0x19e/0x2f5
 [__pollwait+0/199] __pollwait+0x0/0xc7
 [core_sys_select+493/790] core_sys_select+0x1ed/0x316
 [sys_select+184/392] sys_select+0xb8/0x188
 [sys_sigreturn+207/222] sys_sigreturn+0xcf/0xde
 [syscall_call+7/11] syscall_call+0x7/0xb
atd           S F3599F58     0  3797      1          3800  3794 (NOTLB)
f3599f08 00000000 c18064e0 f3599f58 c0131f1f f3599f58 c18080a8 c18080a8 
       c18080a0 c18080a0 f3599f58 00000282 c013203f f7dcaa70 c18064e0 0001262c 
       3b67181e 0000002c f7c4aa70 f7c4ab98 f3599f58 f3599f50 00000001 bfa66bf4 
Call Trace:
 [enqueue_hrtimer+110/170] enqueue_hrtimer+0x6e/0xaa
 [hrtimer_start+164/238] hrtimer_start+0xa4/0xee
 [schedule_hrtimer+66/146] schedule_hrtimer+0x42/0x92
 [hrtimer_nanosleep+111/288] hrtimer_nanosleep+0x6f/0x120
 [copy_to_user+66/92] copy_to_user+0x42/0x5c
 [sys_nanosleep+109/113] sys_nanosleep+0x6d/0x71
 [syscall_call+7/11] syscall_call+0x7/0xb
cron          S F3591F58     0  3800      1          3806  3797 (NOTLB)
f3591f08 00000000 c18064e0 f3591f58 c0131f1f f3591f58 c18080a8 c18080a8 
       c18080a0 c18080a0 f3591f58 00000282 c013203f f3591f58 c18064e0 000013d5 
       b436dad4 0000008a f7adb550 f7adb678 f3591f58 f3591f50 00000001 bf913314 
Call Trace:
 [enqueue_hrtimer+110/170] enqueue_hrtimer+0x6e/0xaa
 [hrtimer_start+164/238] hrtimer_start+0xa4/0xee
 [schedule_hrtimer+66/146] schedule_hrtimer+0x42/0x92
 [hrtimer_nanosleep+111/288] hrtimer_nanosleep+0x6f/0x120
 [copy_to_user+66/92] copy_to_user+0x42/0x5c
 [sys_nanosleep+109/113] sys_nanosleep+0x6d/0x71
 [syscall_call+7/11] syscall_call+0x7/0xb
getty         S 0000002C     0  3806      1          3807  3800 (NOTLB)
f35bde88 f7b3ba70 c1806520 0000002c 00000282 00000282 c011cd17 00000292 
       00000292 7b312279 0000002c 00063034 00000000 f7b3ba70 c18064e0 0000da3b 
       7b312279 0000002c f7d67550 f7d67678 7fffffff f7b5c000 f35bdf04 c1b7e800 
Call Trace:
 [release_console_sem+117/178] release_console_sem+0x75/0xb2
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [release_console_sem+117/178] release_console_sem+0x75/0xb2
 [con_flush_chars+70/72] con_flush_chars+0x46/0x48
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [read_chan+1265/1507] read_chan+0x4f1/0x5e3
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [tty_write+498/580] tty_write+0x1f2/0x244
 [tty_read+215/219] tty_read+0xd7/0xdb
 [dnotify_parent+56/144] dnotify_parent+0x38/0x90
 [vfs_read+164/367] vfs_read+0xa4/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
getty         S 00000000     0  3807      1          3808  3806 (NOTLB)
f35bfe88 00000000 c18064e0 00000000 00000282 00000282 c011cd17 0000001f 
       00000020 f7915000 00000020 c0275ea6 f7915000 00000020 c18064e0 000037fd 
       7c5b2524 0000002c f7f49550 f7f49678 7fffffff f35b2000 f35bff04 f3f7e000 
Call Trace:
 [release_console_sem+117/178] release_console_sem+0x75/0xb2
 [do_con_write+556/1414] do_con_write+0x22c/0x586
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [release_console_sem+117/178] release_console_sem+0x75/0xb2
 [con_flush_chars+70/72] con_flush_chars+0x46/0x48
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [read_chan+1265/1507] read_chan+0x4f1/0x5e3
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [tty_write+498/580] tty_write+0x1f2/0x244
 [tty_read+215/219] tty_read+0xd7/0xdb
 [dnotify_parent+56/144] dnotify_parent+0x38/0x90
 [vfs_read+164/367] vfs_read+0xa4/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
getty         S 0000002C     0  3808      1          3809  3807 (NOTLB)
f3401e88 f7f4fa70 c1806520 0000002c 00000282 00000282 c011cd17 0000001f 
       00000020 808604ad 0000002c 0001c416 00000000 f7f4fa70 c18064e0 00003131 
       808604ad 0000002c c1ba2030 c1ba2158 7fffffff f3423000 f3401f04 f39ec000 
Call Trace:
 [release_console_sem+117/178] release_console_sem+0x75/0xb2
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [release_console_sem+117/178] release_console_sem+0x75/0xb2
 [con_flush_chars+70/72] con_flush_chars+0x46/0x48
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [read_chan+1265/1507] read_chan+0x4f1/0x5e3
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [tty_write+498/580] tty_write+0x1f2/0x244
 [tty_read+215/219] tty_read+0xd7/0xdb
 [dnotify_parent+56/144] dnotify_parent+0x38/0x90
 [vfs_read+164/367] vfs_read+0xa4/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
getty         S 00000000     0  3809      1          3810  3808 (NOTLB)
f3403e88 00000000 c18064e0 00000000 00000282 00000282 c011cd17 0000001f 
       00000020 f7915a00 00000020 c0275ea6 f7915a00 00000020 c18064e0 00003242 
       7e244010 0000002c f7dca030 f7dca158 7fffffff f3425000 f3403f04 f3424000 
Call Trace:
 [release_console_sem+117/178] release_console_sem+0x75/0xb2
 [do_con_write+556/1414] do_con_write+0x22c/0x586
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [release_console_sem+117/178] release_console_sem+0x75/0xb2
 [con_flush_chars+70/72] con_flush_chars+0x46/0x48
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [read_chan+1265/1507] read_chan+0x4f1/0x5e3
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [tty_write+498/580] tty_write+0x1f2/0x244
 [tty_read+215/219] tty_read+0xd7/0xdb
 [dnotify_parent+56/144] dnotify_parent+0x38/0x90
 [vfs_read+164/367] vfs_read+0xa4/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
getty         S 00000000     0  3810      1          3811  3809 (NOTLB)
f3405e88 00000000 c18064e0 00000000 00000282 00000282 c011cd17 0000001f 
       00000020 f78a7400 00000020 c0275ea6 f78a7400 00000020 c18064e0 000030ab 
       8087bab4 0000002c f7f4fa70 f7f4fb98 7fffffff f342e000 f3405f04 f3427800 
Call Trace:
 [release_console_sem+117/178] release_console_sem+0x75/0xb2
 [do_con_write+556/1414] do_con_write+0x22c/0x586
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [release_console_sem+117/178] release_console_sem+0x75/0xb2
 [con_flush_chars+70/72] con_flush_chars+0x46/0x48
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [read_chan+1265/1507] read_chan+0x4f1/0x5e3
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [tty_write+498/580] tty_write+0x1f2/0x244
 [tty_read+215/219] tty_read+0xd7/0xdb
 [dnotify_parent+56/144] dnotify_parent+0x38/0x90
 [vfs_read+164/367] vfs_read+0xa4/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
getty         S 00000000     0  3811      1          3812  3810 (NOTLB)
f3407e88 00000000 c18064e0 00000000 00000282 00000282 c011cd17 0000001f 
       00000020 f7c22400 00000020 c0275ea6 f7c22400 00000020 c18064e0 00003069 
       824f4901 0000002c f7b4fa70 f7b4fb98 7fffffff f3990000 f3407f04 f3427000 
Call Trace:
 [release_console_sem+117/178] release_console_sem+0x75/0xb2
 [do_con_write+556/1414] do_con_write+0x22c/0x586
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [release_console_sem+117/178] release_console_sem+0x75/0xb2
 [con_flush_chars+70/72] con_flush_chars+0x46/0x48
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [read_chan+1265/1507] read_chan+0x4f1/0x5e3
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [tty_write+498/580] tty_write+0x1f2/0x244
 [tty_read+215/219] tty_read+0xd7/0xdb
 [dnotify_parent+56/144] dnotify_parent+0x38/0x90
 [vfs_read+164/367] vfs_read+0xa4/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
svscanboot    S 00000001     0  3812      1  3886          3811 (NOTLB)
f3409f14 00000000 c18064e0 00000001 c014786e fffb5718 00000007 3dcab065 
       00000000 c011a14b 00000000 00000000 00000012 f7aa0550 c18064e0 0000481d 
       4830e5ca 0000002c f7fa8a70 f7fa8b98 f7fa8b1c 00000001 fffffe00 f7fa8b1c 
Call Trace:
 [do_wp_page+458/949] do_wp_page+0x1ca/0x3b5
 [dup_mm+642/835] dup_mm+0x282/0x343
 [do_wait+407/943] do_wait+0x197/0x3af
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [sys_wait4+63/67] sys_wait4+0x3f/0x43
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [syscall_call+7/11] syscall_call+0x7/0xb
svscan        S F48E5F58     0  3886   3812  3888    3887       (NOTLB)
f48e5f08 00000000 c18064e0 f48e5f58 c0131f1f f48e5f58 c18080a8 c18080a8 
       c18080a0 c18080a0 f48e5f58 00000282 c013203f f48e5f58 c18064e0 00001edf 
       01bd5b23 0000008d f7aa0550 f7aa0678 f48e5f58 f48e5f50 00000001 bfa02364 
Call Trace:
 [enqueue_hrtimer+110/170] enqueue_hrtimer+0x6e/0xaa
 [hrtimer_start+164/238] hrtimer_start+0xa4/0xee
 [schedule_hrtimer+66/146] schedule_hrtimer+0x42/0x92
 [hrtimer_nanosleep+111/288] hrtimer_nanosleep+0x6f/0x120
 [copy_to_user+66/92] copy_to_user+0x42/0x5c
 [sys_nanosleep+109/113] sys_nanosleep+0x6d/0x71
 [syscall_call+7/11] syscall_call+0x7/0xb
readproctitle S 00000000     0  3887   3812                3886 (NOTLB)
f340bebc 00000000 c18064e0 00000000 00000000 f7a0e9a8 f7ab0b8c f7a0e9a8 
       c013a337 f7a0e9ac 000000ca 00000001 c013b4a3 f7a0e9a8 c18064e0 00058d76 
       48374c69 0000002c c1ba4550 c1ba4678 f53f50fc f53f5088 f340bee4 f53c7800 
Call Trace:
 [find_get_page+38/77] find_get_page+0x26/0x4d
 [filemap_nopage+455/915] filemap_nopage+0x1c7/0x393
 [pipe_wait+119/146] pipe_wait+0x77/0x92
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [pipe_readv+361/679] pipe_readv+0x169/0x2a7
 [pipe_read+55/59] pipe_read+0x37/0x3b
 [vfs_read+164/367] vfs_read+0xa4/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
supervise     S 0000002C     0  3888   3886  3890    3889       (NOTLB)
f35bbef0 f7b3b550 c1806520 0000002c c043d180 00000044 f35bbf24 00000010 
       c043d180 85e33e20 0000002c 000302c5 00000000 f7b3b550 c18064e0 00005567 
       85e33e20 0000002c f7b37550 f7b37678 f35bbf04 00012eda f35bbf48 f35bbfb0 
Call Trace:
 [schedule_timeout+86/170] schedule_timeout+0x56/0xaa
 [process_timeout+0/9] process_timeout+0x0/0x9
 [do_poll+216/296] do_poll+0xd8/0x128
 [do_sys_poll+280/456] do_sys_poll+0x118/0x1c8
 [copy_to_user+66/92] copy_to_user+0x42/0x5c
 [__pollwait+0/199] __pollwait+0x0/0xc7
 [sys_poll+90/94] sys_poll+0x5a/0x5e
 [syscall_call+7/11] syscall_call+0x7/0xb
supervise     S 00000000     0  3889   3886  3891          3888 (NOTLB)
f3981ef0 00000000 c18064e0 00000000 c043d180 00000044 f3981f24 00000010 
       c043d180 00000000 f3994240 00000282 00000282 c0124c1d c18064e0 0000404e 
       85e580de 0000002c f7b3b550 f7b3b678 f3981f04 00012eda f3981f48 f3981fb0 
Call Trace:
 [lock_timer_base+36/73] lock_timer_base+0x24/0x49
 [schedule_timeout+86/170] schedule_timeout+0x56/0xaa
 [process_timeout+0/9] process_timeout+0x0/0x9
 [do_poll+216/296] do_poll+0xd8/0x128
 [do_sys_poll+280/456] do_sys_poll+0x118/0x1c8
 [copy_to_user+66/92] copy_to_user+0x42/0x5c
 [__pollwait+0/199] __pollwait+0x0/0xc7
 [sys_poll+90/94] sys_poll+0x5a/0x5e
 [syscall_call+7/11] syscall_call+0x7/0xb
tinydns       S F7F54000     0  3890   3888                     (NOTLB)
f39b5c98 00000000 c18064e0 f7f54000 c035998a 80000000 00405d34 f42d6780 
       00000000 f45b5d80 f35af500 f45b5d80 f35af570 f7ba9a70 c18064e0 000000fe 
       0be0144a 0000008a f7fac550 f7fac678 7fffffff 00000000 00000000 f39b5d38 
Call Trace:
 [dst_output+0/20] dst_output+0x0/0x14
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [udp_sendmsg+738/1737] udp_sendmsg+0x2e2/0x6c9
 [prepare_to_wait_exclusive+32/104] prepare_to_wait_exclusive+0x20/0x68
 [wait_for_packet+192/296] wait_for_packet+0xc0/0x128
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [skb_recv_datagram+148/201] skb_recv_datagram+0x94/0xc9
 [udp_recvmsg+86/588] udp_recvmsg+0x56/0x24c
 [sock_common_recvmsg+87/114] sock_common_recvmsg+0x57/0x72
 [sock_recvmsg+254/281] sock_recvmsg+0xfe/0x119
 [do_journal_end+1670/2540] do_journal_end+0x686/0x9ec
 [wake_idle+20/173] wake_idle+0x14/0xad
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [copy_from_user+70/124] copy_from_user+0x46/0x7c
 [sys_recvfrom+180/275] sys_recvfrom+0xb4/0x113
 [pipe_writev+614/1022] pipe_writev+0x266/0x3fe
 [sys_socketcall+442/596] sys_socketcall+0x1ba/0x254
 [syscall_call+7/11] syscall_call+0x7/0xb
multilog      S 00000C42     0  3891   3889                     (NOTLB)
f35b9ebc 00000000 c18064e0 00000c42 0000005d 00009984 00000000 f7a0e9a8 
       c013a337 f7a0e9ac 00000292 00000292 c01451c7 c17c71c0 c18064e0 0000ad4f 
       0bdef86f 0000008a f7ba9a70 f7ba9b98 f53f551c f53f54a8 f35b9ee4 ecc4d000 
Call Trace:
 [find_get_page+38/77] find_get_page+0x26/0x4d
 [page_address+170/185] page_address+0xaa/0xb9
 [pipe_wait+119/146] pipe_wait+0x77/0x92
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [pipe_readv+361/679] pipe_readv+0x169/0x2a7
 [pipe_read+55/59] pipe_read+0x37/0x3b
 [vfs_read+164/367] vfs_read+0xa4/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
sshd          S 00001000     0  3892   3781  3895               (NOTLB)
f4b15d24 00000000 c18064e0 00001000 f4b15db0 00000001 00018030 00000001 
       00000000 00015ce8 00001000 f4b14000 f7f7a9f4 f7ba3a70 c18064e0 000000d9 
       666e40a4 0000002d f7f78030 f7f78158 7fffffff f7b35680 f7b356e0 7fffffff 
Call Trace:
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [__mark_inode_dirty+102/418] __mark_inode_dirty+0x66/0x1a2
 [prepare_to_wait+32/105] prepare_to_wait+0x20/0x69
 [unix_stream_data_wait+187/240] unix_stream_data_wait+0xbb/0xf0
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [dput+35/315] dput+0x23/0x13b
 [unix_stream_recvmsg+1060/1161] unix_stream_recvmsg+0x424/0x489
 [do_sock_read+149/157] do_sock_read+0x95/0x9d
 [sock_aio_read+149/153] sock_aio_read+0x95/0x99
 [chrdev_open+192/360] chrdev_open+0xc0/0x168
 [do_sync_read+203/273] do_sync_read+0xcb/0x111
 [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
 [vfs_read+352/367] vfs_read+0x160/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
sshd          R running     0  3895   3892  3896               (NOTLB)
bash          S 3DD2D067     0  3896   3895  3921               (NOTLB)
f3411f14 00000000 c18064e0 3dd2d067 c014786e fffb58a0 00000007 08114fc8 
       00000000 fffb8000 3dd2d025 00000000 00000012 c17c79c0 c18064e0 00002522 
       042726de 0000002e f7974550 f7974678 f79745fc 00000001 fffffe00 f79745fc 
Call Trace:
 [do_wp_page+458/949] do_wp_page+0x1ca/0x3b5
 [do_wait+407/943] do_wait+0x197/0x3af
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [copy_to_user+66/92] copy_to_user+0x42/0x5c
 [sys_wait4+63/67] sys_wait4+0x3f/0x43
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [syscall_call+7/11] syscall_call+0x7/0xb
screen        S BF8AC2E4     0  3921   3896  3922               (NOTLB)
f42fffb0 00000000 c18064e0 bf8ac2e4 f42fff6c 00000000 00000000 00000000 
       00000000 0000000f 00000000 08088705 f42fe000 c0125561 c18064e0 000007a2 
       53db4df9 0000008c f7ba9550 f7ba9678 bf8ad6b1 00000000 08088705 f42fe000 
Call Trace:
 [sys_alarm+63/100] sys_alarm+0x3f/0x64
 [sys_pause+20/26] sys_pause+0x14/0x1a
 [syscall_call+7/11] syscall_call+0x7/0xb
screen        S 0000008D     0  3922   3921  3923               (NOTLB)
f4041e6c c1b35030 c1806520 0000008d 00000044 00000286 00000286 c0265db8 
       f4589000 845c88b1 0000008d 00002633 00000000 c1b35030 c18064e0 00001036 
       845ce32d 0000008d f7fa8550 f7fa8678 7fffffff 00000200 00000009 00000009 
Call Trace:
 [tty_ldisc_try+61/74] tty_ldisc_try+0x3d/0x4a
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [tty_ldisc_deref+101/127] tty_ldisc_deref+0x65/0x7f
 [tty_poll+107/133] tty_poll+0x6b/0x85
 [do_select+414/757] do_select+0x19e/0x2f5
 [__pollwait+0/199] __pollwait+0x0/0xc7
 [core_sys_select+493/790] core_sys_select+0x1ed/0x316
 [tty_write+498/580] tty_write+0x1f2/0x244
 [dnotify_parent+56/144] dnotify_parent+0x38/0x90
 [sys_select+184/392] sys_select+0xb8/0x188
 [sys_write+81/128] sys_write+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
bash          S 0000002E     0  3923   3922  3955    3996       (NOTLB)
f4049f14 f7fa8550 c1806998 0000002e c014786e fffb5b68 00000007 0816dd88 
       00000000 eca5f16b 0000002e 00023d50 00000000 f7fa8550 c18064e0 0000341b 
       ecab3f46 0000002e f7bb3550 f7bb3678 f7bb35fc 00000001 fffffe00 f7bb35fc 
Call Trace:
 [do_wp_page+458/949] do_wp_page+0x1ca/0x3b5
 [do_wait+407/943] do_wait+0x197/0x3af
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [copy_to_user+66/92] copy_to_user+0x42/0x5c
 [sys_wait4+63/67] sys_wait4+0x3f/0x43
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [syscall_call+7/11] syscall_call+0x7/0xb
bash          S 00000089     0  3955   3923  4049               (NOTLB)
f46e5f14 f7fa8550 c1806998 00000089 c014786e fffb5a78 00000007 3d873065 
       00000000 bccdcc07 00000089 001523a2 00000000 f7fa8550 c18064e0 00001cdb 
       bcffdd10 00000089 f7aa0030 f7aa0158 f7aa00dc 00000001 fffffe00 f7aa00dc 
Call Trace:
 [do_wp_page+458/949] do_wp_page+0x1ca/0x3b5
 [do_wait+407/943] do_wait+0x197/0x3af
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [copy_to_user+66/92] copy_to_user+0x42/0x5c
 [sys_wait4+63/67] sys_wait4+0x3f/0x43
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [syscall_call+7/11] syscall_call+0x7/0xb
bash          S 0000007C     0  3996   3922          4050  3923 (NOTLB)
f4b47e88 f7fa8550 c1806998 0000007c 00000001 00000000 00000086 00000000 
       f4033938 78a1ec4c 0000007c 00001f12 00000000 f7fa8550 c18064e0 00000ce9 
       78a235e4 0000007c f7b37a70 f7b37b98 7fffffff f45f2000 f4b47f04 f48c9000 
Call Trace:
 [schedule_timeout+168/170] schedule_timeout+0xa8/0xaa
 [opost_block+136/291] opost_block+0x88/0x123
 [add_wait_queue+26/70] add_wait_queue+0x1a/0x46
 [read_chan+1265/1507] read_chan+0x4f1/0x5e3
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [tty_write+498/580] tty_write+0x1f2/0x244
 [tty_read+215/219] tty_read+0xd7/0xdb
 [dnotify_parent+56/144] dnotify_parent+0x38/0x90
 [vfs_read+164/367] vfs_read+0xa4/0x16f
 [sys_read+81/128] sys_read+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
lvremove      D F7D726C0     0  4049   3955                     (NOTLB)
f343fd84 00000000 c18064e0 f7d726c0 00001000 00000000 c179da60 00001000 
       00000000 f343fdec f343fdec 0000000c 00000001 c032c6cc c18064e0 0001d57c 
       0baed58c 0000008a f7dcea70 f7dceb98 c18064e0 f343fe50 00000010 f343fd90 
Call Trace:
 [dispatch_io+145/189] dispatch_io+0x91/0xbd
 [io_schedule+38/48] io_schedule+0x26/0x30
 [sync_io+133/237] sync_io+0x85/0xed
 [dm_io_sync_vm+67/75] dm_io_sync_vm+0x43/0x4b
 [vm_get_page+0/59] vm_get_page+0x0/0x3b
 [vm_next_page+0/26] vm_next_page+0x0/0x1a
 [chunk_io+80/84] chunk_io+0x50/0x54
 [read_header+43/130] read_header+0x2b/0x82
 [persistent_read_metadata+34/185] persistent_read_metadata+0x22/0xb9
 [kcopyd_client_create+164/192] kcopyd_client_create+0xa4/0xc0
 [read_snapshot_metadata+20/73] read_snapshot_metadata+0x14/0x49
 [snapshot_ctr+720/893] snapshot_ctr+0x2d0/0x37d
 [dm_table_add_target+271/431] dm_table_add_target+0x10f/0x1af
 [populate_table+125/210] populate_table+0x7d/0xd2
 [table_load+103/278] table_load+0x67/0x116
 [ctl_ioctl+232/315] ctl_ioctl+0xe8/0x13b
 [table_load+0/278] table_load+0x0/0x116
 [do_ioctl+111/150] do_ioctl+0x6f/0x96
 [vfs_ioctl+101/464] vfs_ioctl+0x65/0x1d0
 [sys_ioctl+69/106] sys_ioctl+0x45/0x6a
 [syscall_call+7/11] syscall_call+0x7/0xb
bash          S 0000008B     0  4050   3922  4082          3996 (NOTLB)
f34c1f14 f7fa8550 c1806998 0000008b c014786e fffb5b68 00000007 3cf8d065 
       00000000 4d83ca91 0000008b 001fa424 00000000 f7fa8550 c18064e0 000025bb 
       4dcebb1f 0000008b f7d67030 f7d67158 f7d670dc 00000001 fffffe00 f7d670dc 
Call Trace:
 [do_wp_page+458/949] do_wp_page+0x1ca/0x3b5
 [do_wait+407/943] do_wait+0x197/0x3af
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [copy_to_user+66/92] copy_to_user+0x42/0x5c
 [sys_wait4+63/67] sys_wait4+0x3f/0x43
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [syscall_call+7/11] syscall_call+0x7/0xb
bash          R running     0  4082   4050                     (NOTLB)


######################################################
# .config


#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.16.9+ibm+sysrq
# Wed Apr 19 14:57:46 2006
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
# CONFIG_LBD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=4
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_BKL is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x100000
# CONFIG_HOTPLUG_CPU is not set
CONFIG_DOUBLEFAULT=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
# CONFIG_IP_NF_CONNTRACK_NETLINK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_NETBIOS_NS is not set
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
# CONFIG_IP_NF_PPTP is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_MATCH_POLICY=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
# CONFIG_IP_NF_ARPTABLES is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
CONFIG_VLAN_8021Q=y
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_IPS=y
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
CONFIG_E100=m
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
# CONFIG_E1000_NAPI is not set
# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_TIGON3=m
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_WATCHDOG is not set
# CONFIG_IPMI_POWEROFF is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_RTC_X1205_I2C is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
CONFIG_IBM_ASM=y

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp852"
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=y
# CONFIG_CODA_FS_OLD_API is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=15
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=m
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y


[X.] Other notes, patches, fixes, workarounds:

