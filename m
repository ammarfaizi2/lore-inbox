Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVFFSJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVFFSJh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 14:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVFFSJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 14:09:37 -0400
Received: from mail.velocity.net ([66.211.211.55]:6557 "EHLO mail.velocity.net")
	by vger.kernel.org with ESMTP id S261624AbVFFSFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 14:05:48 -0400
X-AV-Checked: Mon Jun  6 14:05:46 2005 clean
Subject: 2.6.11(.7-11) sync_page problem
From: Dale Blount <linux-kernel@dale.us>
To: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-FrYQcx4cjadGspcNEevR"
Date: Mon, 06 Jun 2005 14:05:46 -0400
Message-Id: <1118081146.12388.32.camel@dale.velocity.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FrYQcx4cjadGspcNEevR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey lists,

Not 100% sure this is NFS related, so I copied LKML.

A couple times a day I get an Apache process stuck in D state while
reading off of NFS.  I have adjusted Apache's NFS specific settings to
work around any apache-over-nfs bugs.  The directory which the locked-up
httpd process was serving from (/proc/$pid/cwd) isn't accessible VIA
bash either, so it looks to me like it's more an NFS client/server bug
rather than an Apache one.  A reboot is required to free the locked
process AFAIK.

Server: 2.6.11.5, nfs-utils 1.0.7
Client: 2.6.11(.7,.11), nfs-utils 1.0.7

The server also has various clients from 2.4.23 to 2.6.11.11 which all
seem to behave fine (however their workloads are different).  I've
noticed this happen with almost no load, to multiple occurrences with a
load of ~4.0 or so.


The clients (at least the 2.6 ones) are all connected to the same
network switch and mounted with the following: 

nfsserver:/nfsdir/home /home nfs
rw,v3,rsize=32768,wsize=32768,hard,intr,tcp,lock,addr=nfsserver 0 0


Attached is a SysRq process trace.

Thanks,

Dale

--=-FrYQcx4cjadGspcNEevR
Content-Disposition: attachment; filename=process_trace.txt
Content-Type: text/plain; name=process_trace.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

esp+0x52/0x75
sshd          S 00000004     0  1616   1521  1634               (NOTLB)
f585dd38 00000082 f585dd28 00000004 00000002 c034ff80 f5970dbc c1926530 
       c03527c0 f741e5c0 f5970d60 c03f452d c03b0452 f5970d60 c1810020 00000001 
       00000000 056e9f80 000f4207 00000001 f5e89a60 f5e89bb8 00000000 00000000 
Call Trace:
 [<c034ff80>] sock_def_readable+0x20/0xa0
 [<c03527c0>] skb_queue_tail+0x20/0x50
 [<c03f452d>] _read_unlock+0xd/0x30
 [<c03b0452>] unix_stream_sendmsg+0x1d2/0x420
 [<c03f3998>] schedule_timeout+0xb8/0xc0
 [<c034c512>] sock_sendmsg+0xf2/0x150
 [<c0131480>] prepare_to_wait+0x20/0x70
 [<c03b0ade>] unix_stream_data_wait+0x9e/0x110
 [<c01315b0>] autoremove_wake_function+0x0/0x60
 [<c03507e3>] alloc_skb+0x53/0x100
 [<c01315b0>] autoremove_wake_function+0x0/0x60
 [<c03f455f>] _spin_unlock_irqrestore+0xf/0x30
 [<c03b0e38>] unix_stream_recvmsg+0x2e8/0x4b0
 [<c03f452d>] _read_unlock+0xd/0x30
 [<c03b0452>] unix_stream_sendmsg+0x1d2/0x420
 [<c03f40e6>] _spin_lock+0x16/0x80
 [<c034c8a8>] sock_aio_read+0x108/0x120
 [<c0169050>] do_lookup+0x30/0xb0
 [<c015a429>] do_sync_read+0xc9/0x110
 [<c0163ea8>] cdev_get+0x68/0xe0
 [<c01315b0>] autoremove_wake_function+0x0/0x60
 [<c015a561>] vfs_read+0xf1/0x160
 [<c015a891>] sys_read+0x51/0x80
 [<c0102939>] sysenter_past_esp+0x52/0x75
sshd          S 00000004     0  1634   1616  1635               (NOTLB)
f5f4be84 00000082 f5f4be74 00000004 00000002 c16b4c40 c045da00 c1926530 
       000000d0 00000000 00000000 00000286 00000000 c03f455f c1810020 00000001 
       00000000 44903500 000f4696 00000001 f587aac0 f587ac18 c049e87c 00000000 
Call Trace:
 [<c03f455f>] _spin_unlock_irqrestore+0xf/0x30
 [<c03f3998>] schedule_timeout+0xb8/0xc0
 [<c03f455f>] _spin_unlock_irqrestore+0xf/0x30
 [<c025031b>] tty_ldisc_deref+0x7b/0xa0
 [<c03f455f>] _spin_unlock_irqrestore+0xf/0x30
 [<c0252b0f>] tty_poll+0x8f/0xf0
 [<c015b7c9>] fget+0x49/0x60
 [<c016f380>] do_select+0x2a0/0x2e0
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c016f68f>] sys_select+0x28f/0x540
 [<c03f44cd>] _spin_unlock+0xd/0x30
 [<c015a7eb>] vfs_write+0x10b/0x160
 [<c0102939>] sysenter_past_esp+0x52/0x75
bash          S 00000004     0  1635   1634  1664               (NOTLB)
f5879f1c 00000086 f5879f0c 00000004 00000002 f5a9d4ec 080eeb18 c1926530 
       f58cd080 3a4b0065 f7d3d0a0 f7d632c0 f7d632ec f5a9d4ec c1810020 00000001 
       00000000 8b411980 000f420c 00000001 f5fdf550 f5fdf6a8 f5879f64 00000000 
Call Trace:
 [<c011f30e>] do_wait+0x30e/0x4b0
 [<c0116b20>] default_wake_function+0x0/0x20
 [<c0116b20>] default_wake_function+0x0/0x20
 [<c0214552>] copy_to_user+0x42/0x60
 [<c011f59d>] sys_wait4+0x3d/0x50
 [<c011f5d5>] sys_waitpid+0x25/0x29
 [<c0102939>] sysenter_past_esp+0x52/0x75
su            S C181005C     0  1664   1635  1667               (NOTLB)
f5adbf1c 00000086 f7dbd550 c181005c 000f420d f5a5838c 0804d6b4 f7dbd550 
       f5a6e080 f7dbd550 f5ffea40 f7dbd550 00000000 c1810980 c1810020 00000001 
       00000000 1a206ac0 000f420d c181005c f7d3d0a0 f7d3d1f8 00000000 f7c29188 
Call Trace:
 [<c011f30e>] do_wait+0x30e/0x4b0
 [<c0116b20>] default_wake_function+0x0/0x20
 [<c0116b20>] default_wake_function+0x0/0x20
 [<c03f458e>] _spin_unlock_irq+0xe/0x30
 [<c0128312>] sigprocmask+0x72/0x100
 [<c011f59d>] sys_wait4+0x3d/0x50
 [<c011f5d5>] sys_waitpid+0x25/0x29
 [<c0102939>] sysenter_past_esp+0x52/0x75
bash          R running     0  1667   1664                     (NOTLB)
httpd         D 00000004     0  4666   1342          5087  1404 (NOTLB)
ec52dd18 00000082 ec52dd08 00000004 00000001 f5a687e0 ec18a454 c0458ba0 
       00000001 00000001 00000001 000001d2 00000000 c013e48c c1808020 00000000 
       00000000 357444c0 000f45b1 00000000 ee145040 ee145198 ee145040 00000000 
Call Trace:
 [<c013e48c>] __alloc_pages+0x17c/0x3e0
 [<c03f3868>] io_schedule+0x28/0x40
 [<c0138c15>] sync_page+0x35/0x60
 [<c03f455f>] _spin_unlock_irqrestore+0xf/0x30
 [<c03f3bc2>] __wait_on_bit_lock+0x42/0x70
 [<c0138be0>] sync_page+0x0/0x60
 [<c0131610>] wake_bit_function+0x0/0x60
 [<c013950d>] __lock_page+0x9d/0xc0
 [<c0131610>] wake_bit_function+0x0/0x60
 [<c0131610>] wake_bit_function+0x0/0x60
 [<c013956d>] find_get_page+0x3d/0x50
 [<c0139d47>] do_generic_mapping_read+0x3d7/0x690
 [<c013a2de>] __generic_file_aio_read+0x1de/0x250
 [<c013a000>] file_read_actor+0x0/0x100
 [<c013a3ab>] generic_file_aio_read+0x5b/0x80
 [<c01d25b1>] nfs_file_read+0x81/0xd0
 [<c015a429>] do_sync_read+0xc9/0x110
 [<c0164cd0>] cp_new_stat64+0xf0/0x100
 [<c01315b0>] autoremove_wake_function+0x0/0x60
 [<c0164d91>] sys_fstat64+0x31/0x40
 [<c015a5c5>] vfs_read+0x155/0x160
 [<c015a891>] sys_read+0x51/0x80
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5087   1342          5094  4666 (NOTLB)
ecd29d98 00000086 ecd29d88 00000004 00000002 f7cc8000 ecd29d54 c1926530 
       80000000 00000000 c0565200 f741eb00 00000000 c03733e0 c1810020 00000001 
       00000000 09ac8600 000f4696 00000000 ec3be060 ec3be1b8 00000000 00000000 
Call Trace:
 [<c03733e0>] ip_finish_output2+0x0/0x220
 [<c0203257>] sys_semtimedop+0x4a7/0x500
 [<c0350572>] sock_common_recvmsg+0x52/0x70
 [<c034c8a8>] sock_aio_read+0x108/0x120
 [<c013e0b1>] buffered_rmqueue+0xb1/0x230
 [<c015a429>] do_sync_read+0xc9/0x110
 [<c012094e>] local_bh_enable+0x2e/0x90
 [<c03f44cd>] _spin_unlock+0xd/0x30
 [<c015ca2b>] invalidate_inode_buffers+0x1b/0xa0
 [<c01678d8>] pipe_read+0x38/0x40
 [<c015a5c5>] vfs_read+0x155/0x160
 [<c0108f21>] sys_ipc+0x71/0x2a0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5094   1342          5100  5087 (NOTLB)
eb645f00 00000082 eb645ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ecee6060 00000010 c1810020 00000001 
       0001b207 42c67180 000f4696 c01248df ecee6060 ecee61b8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5100   1342          5113  5094 (NOTLB)
ec92bf00 00000082 ec92bef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ebbac530 00000010 c1810020 00000001 
       00000000 60cf6040 000f4693 c01248df ebbac530 ebbac688 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         X 00000004     0  5113   1342          5129  5100 (L-TLB)
ec3c5f7c 00000046 ec3c5f6c 00000004 00000002 f60a42e0 00000003 c1926530 
       f7cd5080 f5c7a4bc f7501ac0 f5fdf040 f5fdf040 f5fdf040 c1810020 00000001 
       00000000 27892d40 000f4696 f5fdf0e0 f5fdf040 f5fdf198 ec3c5f68 00000000 
Call Trace:
 [<c011e067>] do_exit+0x207/0x350
 [<c011e22e>] do_group_exit+0x3e/0xb0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5129   1342          5175  5113 (NOTLB)
ec0e5f00 00000086 ec0e5ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ec3bea80 00000010 c1810020 00000001 
       0001b207 2a4714c0 000f4696 c01248df ec3bea80 ec3bebd8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5175   1342          5245  5129 (NOTLB)
eb48ff00 00000086 eb48fef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 f5ffe530 00000010 c1810020 00000001 
       0001b207 abf93540 000f4694 c01248df f5ffe530 f5ffe688 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5245   1342          5427  5175 (NOTLB)
ea9b5d98 00000086 ea9b5d88 00000004 00000002 f7cc8000 ea9b5d54 c1926530 
       80000000 00000000 c0565200 f5b66180 00000000 c03733e0 c1810020 00000001 
       00000000 37ced380 000f4696 00000000 eb120570 eb1206c8 00000000 00000000 
Call Trace:
 [<c03733e0>] ip_finish_output2+0x0/0x220
 [<c0203257>] sys_semtimedop+0x4a7/0x500
 [<c0350572>] sock_common_recvmsg+0x52/0x70
 [<c034c8a8>] sock_aio_read+0x108/0x120
 [<c013e0b1>] buffered_rmqueue+0xb1/0x230
 [<c015a429>] do_sync_read+0xc9/0x110
 [<c012094e>] local_bh_enable+0x2e/0x90
 [<c03f44cd>] _spin_unlock+0xd/0x30
 [<c015ca2b>] invalidate_inode_buffers+0x1b/0xa0
 [<c01678d8>] pipe_read+0x38/0x40
 [<c015a5c5>] vfs_read+0x155/0x160
 [<c0108f21>] sys_ipc+0x71/0x2a0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5427   1342          5442  5245 (NOTLB)
eb12bd98 00000086 eb12bd88 00000004 00000002 f7cc8000 eb12bd54 c1926530 
       80000000 00000000 c0565200 f5b681a0 00000000 c03733e0 c1810020 00000001 
       00000000 dd07b0c0 000f4695 00000000 eeebb080 eeebb1d8 00000000 00000000 
Call Trace:
 [<c03733e0>] ip_finish_output2+0x0/0x220
 [<c0203257>] sys_semtimedop+0x4a7/0x500
 [<c0373110>] dst_output+0x0/0x20
 [<c0115c39>] find_busiest_group+0xc9/0x330
 [<c0116136>] load_balance_newidle+0x36/0xb0
 [<c01010ef>] __switch_to+0x2f/0x200
 [<c03f458e>] _spin_unlock_irq+0xe/0x30
 [<c0115287>] finish_task_switch+0x37/0x80
 [<c03f27ac>] schedule+0x37c/0xc00
 [<c03f455f>] _spin_unlock_irqrestore+0xf/0x30
 [<c0124a7b>] del_timer+0x6b/0x80
 [<c03f40e6>] _spin_lock+0x16/0x80
 [<c035018e>] sk_stop_timer+0x1e/0x30
 [<c03f434e>] _write_lock+0xe/0xa0
 [<c03b244e>] inet6_destroy_sock+0x6e/0x100
 [<c015ca2b>] invalidate_inode_buffers+0x1b/0xa0
 [<c01678d8>] pipe_read+0x38/0x40
 [<c015a5c5>] vfs_read+0x155/0x160
 [<c0108f21>] sys_ipc+0x71/0x2a0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5442   1342          5443  5427 (NOTLB)
ec3e1f00 00000082 ec3e1ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 f5e89040 00000010 c1810020 00000001 
       00000000 3a312d80 000f4696 c01248df f5e89040 f5e89198 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5443   1342          5457  5442 (NOTLB)
ebaa1f00 00000082 ebaa1ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ee145550 00000010 c1810020 00000001 
       0001b207 502f2c00 000f4695 c01248df ee145550 ee1456a8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5457   1342          5546  5443 (NOTLB)
eae7ff00 00000086 eae7fef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 eb120060 00000010 c1810020 00000001 
       00000000 eabd3640 000f4695 c01248df eb120060 eb1201b8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5546   1342          5553  5457 (NOTLB)
eaa8ff00 00000086 eaa8fef0 00000004 00000001 00000000 000000d0 c0458ba0 
       00000000 00000000 00000001 00000000 f7534570 00000010 c1808020 00000000 
       00000000 273ce200 000f4696 00000001 f7534570 f75346c8 f7de5718 00000000 
Call Trace:
 [<c03f3998>] schedule_timeout+0xb8/0xc0
 [<c03f40e6>] _spin_lock+0x16/0x80
 [<c034ceb6>] sock_poll+0x26/0x30
 [<c016f99b>] do_pollfd+0x5b/0xa0
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5553   1342          5569  5546 (NOTLB)
ea86ff00 00000082 ea86fef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 f5ffe020 00000010 c1810020 00000001 
       00000000 d48c7380 000f468c c01248df f5ffe020 f5ffe178 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5569   1342          5572  5553 (NOTLB)
ea451d98 00000086 ea451d88 00000004 00000002 f7cc8000 ea451d54 c1926530 
       80000000 00000000 c0565200 f54b13c0 00000000 c03733e0 c1810020 00000001 
       00000000 c0c70640 000f4695 00000000 ec3be570 ec3be6c8 00000000 00000000 
Call Trace:
 [<c03733e0>] ip_finish_output2+0x0/0x220
 [<c0203257>] sys_semtimedop+0x4a7/0x500
 [<c0350572>] sock_common_recvmsg+0x52/0x70
 [<c034c8a8>] sock_aio_read+0x108/0x120
 [<c013e0b1>] buffered_rmqueue+0xb1/0x230
 [<c015a429>] do_sync_read+0xc9/0x110
 [<c012094e>] local_bh_enable+0x2e/0x90
 [<c03f44cd>] _spin_unlock+0xd/0x30
 [<c015ca2b>] invalidate_inode_buffers+0x1b/0xa0
 [<c01678d8>] pipe_read+0x38/0x40
 [<c015a5c5>] vfs_read+0x155/0x160
 [<c0108f21>] sys_ipc+0x71/0x2a0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5572   1342          5574  5569 (NOTLB)
e90a7f00 00000082 e90a7ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 f587a5b0 00000010 c1810020 00000001 
       0001b207 8f998680 000f4693 c01248df f587a5b0 f587a708 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5574   1342          5584  5572 (NOTLB)
e925df00 00000082 e925def0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ed368550 00000010 c1810020 00000001 
       0001b207 9b580180 000f4694 c01248df ed368550 ed3686a8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5584   1342          5586  5574 (NOTLB)
e92cbf00 00000086 e92cbef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ebbac020 00000010 c1810020 00000001 
       00000000 c8682640 000f4695 c01248df ebbac020 ebbac178 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5586   1342          5620  5584 (NOTLB)
e8d29f00 00000086 e8d29ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ed368a60 00000010 c1810020 00000001 
       00000000 4b6a7800 000f4695 c01248df ed368a60 ed368bb8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5620   1342          5638  5586 (NOTLB)
ebc7dd98 00000086 ebc7dd88 00000004 00000002 f7cc8000 ebc7dd54 c1926530 
       80000000 00000000 c0565200 f61cc600 00000000 c03733e0 c1810020 00000001 
       00000000 00ac7240 000f4696 00000000 f5e79020 f5e79178 00000000 00000000 
Call Trace:
 [<c03733e0>] ip_finish_output2+0x0/0x220
 [<c0203257>] sys_semtimedop+0x4a7/0x500
 [<c0373110>] dst_output+0x0/0x20
 [<c0115c39>] find_busiest_group+0xc9/0x330
 [<c0116136>] load_balance_newidle+0x36/0xb0
 [<c01010ef>] __switch_to+0x2f/0x200
 [<c03f458e>] _spin_unlock_irq+0xe/0x30
 [<c0115287>] finish_task_switch+0x37/0x80
 [<c03f27ac>] schedule+0x37c/0xc00
 [<c03f455f>] _spin_unlock_irqrestore+0xf/0x30
 [<c0124a7b>] del_timer+0x6b/0x80
 [<c03f40e6>] _spin_lock+0x16/0x80
 [<c035018e>] sk_stop_timer+0x1e/0x30
 [<c03f434e>] _write_lock+0xe/0xa0
 [<c03b244e>] inet6_destroy_sock+0x6e/0x100
 [<c015ca2b>] invalidate_inode_buffers+0x1b/0xa0
 [<c01678d8>] pipe_read+0x38/0x40
 [<c015a5c5>] vfs_read+0x155/0x160
 [<c0108f21>] sys_ipc+0x71/0x2a0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5638   1342          5639  5620 (NOTLB)
ea957f00 00000086 ea957ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 f5f79080 00000010 c1810020 00000001 
       00000000 5c757c00 000f4693 c01248df f5f79080 f5f791d8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5639   1342          5640  5638 (NOTLB)
ea961f00 00000082 ea961ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ebbaca40 00000010 c1810020 00000001 
       00000000 247efa80 000f4696 c01248df ebbaca40 ebbacb98 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5640   1342          5674  5639 (NOTLB)
eaab3d98 00000086 eaab3d88 00000004 00000002 f7cc8000 eaab3d54 c1926530 
       80000000 00000000 c0565200 f5be5d40 00000000 c03733e0 c1810020 00000001 
       00000000 dbb7ff40 000f4695 00000000 eeebbaa0 eeebbbf8 00000000 00000000 
Call Trace:
 [<c03733e0>] ip_finish_output2+0x0/0x220
 [<c0203257>] sys_semtimedop+0x4a7/0x500
 [<c0373110>] dst_output+0x0/0x20
 [<c0115c39>] find_busiest_group+0xc9/0x330
 [<c0116136>] load_balance_newidle+0x36/0xb0
 [<c01010ef>] __switch_to+0x2f/0x200
 [<c03f458e>] _spin_unlock_irq+0xe/0x30
 [<c03f40e6>] _spin_lock+0x16/0x80
 [<c03f44cd>] _spin_unlock+0xd/0x30
 [<c014264e>] cache_alloc_refill+0x14e/0x260
 [<c03f27ac>] schedule+0x37c/0xc00
 [<c03f455f>] _spin_unlock_irqrestore+0xf/0x30
 [<c0124a7b>] del_timer+0x6b/0x80
 [<c03f40e6>] _spin_lock+0x16/0x80
 [<c035018e>] sk_stop_timer+0x1e/0x30
 [<c03f434e>] _write_lock+0xe/0xa0
 [<c03b244e>] inet6_destroy_sock+0x6e/0x100
 [<c015ca2b>] invalidate_inode_buffers+0x1b/0xa0
 [<c01678d8>] pipe_read+0x38/0x40
 [<c015a5c5>] vfs_read+0x155/0x160
 [<c0108f21>] sys_ipc+0x71/0x2a0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5674   1342          5678  5640 (NOTLB)
e8f8dd98 00000086 e8f8dd88 00000004 00000002 f7cc8000 e8f8dd54 c1926530 
       80000000 00000000 c0565200 f61f8b60 00000000 c03733e0 c1810020 00000001 
       00000000 c2be9080 000f4695 00000000 ecee6570 ecee66c8 00000000 00000000 
Call Trace:
 [<c03733e0>] ip_finish_output2+0x0/0x220
 [<c0203257>] sys_semtimedop+0x4a7/0x500
 [<c02c7581>] tulip_refill_rx+0xd1/0x100
 [<c02c7cc5>] tulip_interrupt+0x305/0x9f0
 [<c0350af1>] kfree_skbmem+0x21/0x30
 [<c0350baf>] __kfree_skb+0xaf/0x160
 [<c03571ca>] net_tx_action+0x4a/0x130
 [<c012094e>] local_bh_enable+0x2e/0x90
 [<c03f44cd>] _spin_unlock+0xd/0x30
 [<c015ca2b>] invalidate_inode_buffers+0x1b/0xa0
 [<c01678d8>] pipe_read+0x38/0x40
 [<c015a5c5>] vfs_read+0x155/0x160
 [<c0108f21>] sys_ipc+0x71/0x2a0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5678   1342          5679  5674 (NOTLB)
e9453f00 00000086 e9453ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 f5fa25b0 00000010 c1810020 00000001 
       00000000 d6e40900 000f4695 c01248df f5fa25b0 f5fa2708 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5679   1342          5681  5678 (NOTLB)
e8dd9d98 00000082 e8dd9d88 00000004 00000002 f7cc8000 e8dd9d54 c1926530 
       80000000 00000000 c0565200 f62196a0 00000000 c03733e0 c1810020 00000001 
       0001b207 e6fbe880 000f4695 00000000 f587a0a0 f587a1f8 00000000 00000000 
Call Trace:
 [<c03733e0>] ip_finish_output2+0x0/0x220
 [<c0203257>] sys_semtimedop+0x4a7/0x500
 [<c0350572>] sock_common_recvmsg+0x52/0x70
 [<c034c8a8>] sock_aio_read+0x108/0x120
 [<c013e0b1>] buffered_rmqueue+0xb1/0x230
 [<c015a429>] do_sync_read+0xc9/0x110
 [<c012094e>] local_bh_enable+0x2e/0x90
 [<c03f44cd>] _spin_unlock+0xd/0x30
 [<c015ca2b>] invalidate_inode_buffers+0x1b/0xa0
 [<c01678d8>] pipe_read+0x38/0x40
 [<c015a5c5>] vfs_read+0x155/0x160
 [<c0108f21>] sys_ipc+0x71/0x2a0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5681   1342          5682  5679 (NOTLB)
e9c77f00 00000086 e9c77ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ed368040 00000010 c1810020 00000001 
       00000000 deeff8c0 000f4695 c01248df ed368040 ed368198 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5682   1342          5683  5681 (NOTLB)
eaa41f00 00000086 eaa41ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 f74a0570 00000010 c1810020 00000001 
       00000000 eb098180 000f4695 c01248df f74a0570 f74a06c8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5683   1342          5684  5682 (NOTLB)
ebc01d98 00000082 ebc01d88 00000004 00000002 f7cc8000 ebc01d54 c1926530 
       80000000 00000000 c0565200 f4e32f20 00000000 c03733e0 c1810020 00000001 
       00000000 12bbdc00 000f4696 00000000 eeebb590 eeebb6e8 00000000 00000000 
Call Trace:
 [<c03733e0>] ip_finish_output2+0x0/0x220
 [<c0203257>] sys_semtimedop+0x4a7/0x500
 [<c0350572>] sock_common_recvmsg+0x52/0x70
 [<c034c8a8>] sock_aio_read+0x108/0x120
 [<c02c7581>] tulip_refill_rx+0xd1/0x100
 [<c02c7cc5>] tulip_interrupt+0x305/0x9f0
 [<c0350af1>] kfree_skbmem+0x21/0x30
 [<c0350baf>] __kfree_skb+0xaf/0x160
 [<c03571ca>] net_tx_action+0x4a/0x130
 [<c012094e>] local_bh_enable+0x2e/0x90
 [<c03f44cd>] _spin_unlock+0xd/0x30
 [<c015ca2b>] invalidate_inode_buffers+0x1b/0xa0
 [<c01678d8>] pipe_read+0x38/0x40
 [<c015a5c5>] vfs_read+0x155/0x160
 [<c0108f21>] sys_ipc+0x71/0x2a0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S C18084D4     0  5684   1342          5685  5683 (NOTLB)
effa7f00 00000082 f7534570 c18084d4 000f4696 00000000 000000d0 f7534570 
       00000000 f7534570 00000001 00000000 ecee6a80 00000010 c1808020 00000000 
       00000000 273ce200 000f4696 c18084d4 ecee6a80 ecee6bd8 00000000 00000286 
Call Trace:
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5685   1342          5686  5684 (NOTLB)
e932ff00 00000086 e932fef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ee145a60 00000010 c1810020 00000001 
       00000000 f9c26d40 000f4695 c01248df ee145a60 ee145bb8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5686   1342          5687  5685 (NOTLB)
eadb3d98 00000086 eadb3d88 00000004 00000002 f7cc8000 eadb3d54 c1926530 
       80000000 00000000 c0565200 f61cc600 00000000 c03733e0 c1810020 00000001 
       0001b207 e2373480 000f4695 00000000 f5f10a80 f5f10bd8 00000000 00000000 
Call Trace:
 [<c03733e0>] ip_finish_output2+0x0/0x220
 [<c0203257>] sys_semtimedop+0x4a7/0x500
 [<c0350572>] sock_common_recvmsg+0x52/0x70
 [<c034c8a8>] sock_aio_read+0x108/0x120
 [<c01010ef>] __switch_to+0x2f/0x200
 [<c03f434e>] _write_lock+0xe/0xa0
 [<c03b244e>] inet6_destroy_sock+0x6e/0x100
 [<c015ca2b>] invalidate_inode_buffers+0x1b/0xa0
 [<c01678d8>] pipe_read+0x38/0x40
 [<c015a5c5>] vfs_read+0x155/0x160
 [<c0108f21>] sys_ipc+0x71/0x2a0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5687   1342          5696  5686 (NOTLB)
ea80fd98 00000082 ea80fd88 00000004 00000002 f7cc8000 ea80fd54 c1926530 
       80000000 00000000 c0565200 f61f8ce0 00000000 c03733e0 c1810020 00000001 
       00000000 e227f240 000f4695 00000000 e8826a60 e8826bb8 00000000 00000000 
Call Trace:
 [<c03733e0>] ip_finish_output2+0x0/0x220
 [<c0203257>] sys_semtimedop+0x4a7/0x500
 [<c0350572>] sock_common_recvmsg+0x52/0x70
 [<c034c8a8>] sock_aio_read+0x108/0x120
 [<c01010ef>] __switch_to+0x2f/0x200
 [<c03f434e>] _write_lock+0xe/0xa0
 [<c03b244e>] inet6_destroy_sock+0x6e/0x100
 [<c015ca2b>] invalidate_inode_buffers+0x1b/0xa0
 [<c01678d8>] pipe_read+0x38/0x40
 [<c015a5c5>] vfs_read+0x155/0x160
 [<c0108f21>] sys_ipc+0x71/0x2a0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5696   1342          5697  5687 (NOTLB)
eed95f00 00000082 eed95ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 f5fa2ac0 00000010 c1810020 00000001 
       00000000 1a7b00c0 000f4695 c01248df f5fa2ac0 f5fa2c18 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5697   1342          5699  5696 (NOTLB)
ea6f1f00 00000086 ea6f1ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ead3aa80 00000010 c1810020 00000001 
       00000000 c30a5c00 000f4694 c01248df ead3aa80 ead3abd8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5699   1342          5700  5697 (NOTLB)
e9485f00 00000082 e9485ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ead3a060 00000010 c1810020 00000001 
       00000000 5502a280 000f4694 c01248df ead3a060 ead3a1b8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5700   1342          5701  5699 (NOTLB)
eace9f00 00000082 eace9ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 e8826040 00000010 c1810020 00000001 
       00000000 b8e7ddc0 000f4693 c01248df e8826040 e8826198 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5701   1342          5702  5700 (NOTLB)
ea985f00 00000086 ea985ef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ebf14aa0 00000010 c1810020 00000001 
       00000000 bb87c080 000f4694 c01248df ebf14aa0 ebf14bf8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5702   1342          5710  5701 (NOTLB)
eddcff00 00000082 eddcfef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 ebf14590 00000010 c1810020 00000001 
       00000000 e03faa40 000f4695 c01248df ebf14590 ebf146e8 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75
httpd         S 00000004     0  5710   1342                5702 (NOTLB)
ea6cff00 00000086 ea6cfef0 00000004 00000002 00000000 000000d0 c1926530 
       00000000 00000000 00000001 00000000 e9c57ac0 00000010 c1810020 00000001 
       00000000 cd792580 000f4695 c01248df e9c57ac0 e9c57c18 00000000 00000000 
Call Trace:
 [<c01248df>] __mod_timer+0x12f/0x170
 [<c03f394c>] schedule_timeout+0x6c/0xc0
 [<c0125460>] process_timeout+0x0/0x10
 [<c016fa93>] do_poll+0xb3/0xe0
 [<c016fc90>] sys_poll+0x1d0/0x230
 [<c016ef10>] __pollwait+0x0/0xd0
 [<c0102939>] sysenter_past_esp+0x52/0x75

--=-FrYQcx4cjadGspcNEevR--

