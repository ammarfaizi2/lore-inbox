Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUBJTsd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUBJTsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:48:33 -0500
Received: from defout.telus.net ([199.185.220.240]:12956 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S266195AbUBJTsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:48:00 -0500
Subject: [BUG] Badness in kobject_get at lib/kobject.c:431  kernel 2.6.3-rc2
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076442552.2965.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 10 Feb 2004 12:49:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  Dmesg gives the following when booting 2.6.3-rc2:
ieee1394: Host added: ID:BUS[0-02:1023]  GUID[001106001a250051]
Badness in kobject_get at lib/kobject.c:431
Call Trace:
 [<c0192f22>] kobject_get+0x4c/0x4e
 [<c01d775e>] get_device+0x18/0x21
 [<c01d82af>] bus_for_each_dev+0x63/0xba
 [<f89fd01e>] nodemgr_node_probe+0x4d/0x124 [ieee1394]
 [<f89fcee7>] nodemgr_probe_ne_cb+0x0/0x8d [ieee1394]
 [<f89fd463>] nodemgr_host_thread+0x17d/0x1a1 [ieee1394]
 [<f89fd2e6>] nodemgr_host_thread+0x0/0x1a1 [ieee1394]
 [<c0107255>] kernel_thread_helper+0x5/0xb
                                                                                                                             
Unable to handle kernel paging request at virtual address b828ec83
 printing eip:
b828ec83
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<b828ec83>]    Tainted: P
EFLAGS: 00010282
EIP is at 0xb828ec83
eax: b828ec83   ebx: f8a063c4   ecx: f768ff9c   edx: 00000000
esi: f89fc8ff   edi: 00000000   ebp: f89fb669   esp: f768ff40
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 763, threadinfo=f768e000 task=f6e94cc0)
Stack: c0192fbc f8a063c4 f8a063a0 f8a063a8 f8a06300 f75ce244 c01d82cc
f8a063c4
       f768ff9c f8a0634c 00000000 f75ce23c f768ff9c f6e3bf18 f768ff9c
f89fd01e
       f8a06300 f75ce23c f768ff9c f89fcee7 00000004 f8a05d40 f6e18000
f6e3bf18
Call Trace:
 [<c0192fbc>] kobject_cleanup+0x98/0x9a
 [<c01d82cc>] bus_for_each_dev+0x80/0xba
 [<f89fd01e>] nodemgr_node_probe+0x4d/0x124 [ieee1394]
 [<f89fcee7>] nodemgr_probe_ne_cb+0x0/0x8d [ieee1394]
 [<f89fd463>] nodemgr_host_thread+0x17d/0x1a1 [ieee1394]
 [<f89fd2e6>] nodemgr_host_thread+0x0/0x1a1 [ieee1394]
 [<c0107255>] kernel_thread_helper+0x5/0xb
                                                                                                                             
Code:  Bad EIP value.
 <6>sbp2: $Rev: 1096 $ Ben Collins <bcollins@debian.org>


I'm running Fedora Core1 (updated with yum).  I haven't seen any other
problems like this on LKML and 2.6.3-rc1-bk2 works fine.  lsmod shows:
scsi_mod               96056  5 sd_mod,sr_mod,ide_scsi,sbp2,sg
and
ieee1394               67376  3 raw1394,sbp2,ohci1394
and the system doesn't stall on this, but firewire devices are not
present.  

/var/log/messages shows:
Feb 10 11:55:35 localhost kernel: eth0: SiS 900 PCI Fast Ethernet at
0xe000, IRQ 11, 00:50:2c:02:96:89.
Feb 10 11:55:35 localhost kernel: kudzu: numerical sysctl 1 49 is
obsolete.
Feb 10 11:55:35 localhost kernel: Badness in kobject_get at
lib/kobject.c:431
Feb 10 11:55:35 localhost kernel: Call Trace:
Feb 10 11:55:35 localhost kernel:  [<c0192f22>] kobject_get+0x4c/0x4e
Feb 10 11:55:35 localhost kernel:  [<c01d775e>] get_device+0x18/0x21
Feb 10 11:55:35 localhost kernel:  [<c01d82af>]
bus_for_each_dev+0x63/0xba
Feb 10 11:55:35 localhost kernel:  [<f89fd01e>]
nodemgr_node_probe+0x4d/0x124 [ieee1394]
Feb 10 11:55:35 localhost kernel:  [<f89fcee7>]
nodemgr_probe_ne_cb+0x0/0x8d [ieee1394]
Feb 10 11:55:35 localhost kernel:  [<f89fd463>]
nodemgr_host_thread+0x17d/0x1a1 [ieee1394]
Feb 10 11:55:35 localhost kernel:  [<f89fd2e6>]
nodemgr_host_thread+0x0/0x1a1 [ieee1394]
Feb 10 11:55:35 localhost kernel:  [<c0107255>]
kernel_thread_helper+0x5/0xb
Feb 10 11:55:35 localhost kernel:
Feb 10 11:55:35 localhost kernel: Unable to handle kernel paging request
at virtual address b828ec83
Feb 10 11:55:35 localhost kernel:  printing eip:
Feb 10 11:55:35 localhost kernel: b828ec83
Feb 10 11:55:35 localhost kernel: *pde = 00000000
Feb 10 11:55:35 localhost kernel: Oops: 0000 [#1]
Feb 10 11:55:35 localhost kernel: CPU:    0
Feb 10 11:55:35 localhost kernel: EIP:    0060:[<b828ec83>]    Tainted:
P
Feb 10 11:55:35 localhost kernel: EFLAGS: 00010282
Feb 10 11:55:35 localhost kernel: EIP is at 0xb828ec83
Feb 10 11:55:35 localhost kernel: eax: b828ec83   ebx: f8a063c4   ecx:
f768ff9c   edx: 00000000
Feb 10 11:55:35 localhost kernel: esi: f89fc8ff   edi: 00000000   ebp:
f89fb669   esp: f768ff40
Feb 10 11:55:35 localhost kernel: ds: 007b   es: 007b   ss: 0068
Feb 10 11:55:35 localhost kernel: Process knodemgrd_0 (pid: 763,
threadinfo=f768e000 task=f6e94cc0)
Feb 10 11:55:35 localhost kernel: Stack: c0192fbc f8a063c4 f8a063a0
f8a063a8 f8a06300 f75ce244 c01d82cc f8a063c4
Feb 10 11:55:35 localhost kernel:        f768ff9c f8a0634c 00000000
f75ce23c f768ff9c f6e3bf18 f768ff9c f89fd01e
Feb 10 11:55:35 localhost kernel:        f8a06300 f75ce23c f768ff9c
f89fcee7 00000004 f8a05d40 f6e18000 f6e3bf18
Feb 10 11:55:35 localhost kernel: Call Trace:
Feb 10 11:55:35 localhost kernel:  [<c0192fbc>]
kobject_cleanup+0x98/0x9a
Feb 10 11:55:35 localhost kernel:  [<c01d82cc>]
bus_for_each_dev+0x80/0xba
Feb 10 11:55:35 localhost kernel:  [<f89fd01e>]
nodemgr_node_probe+0x4d/0x124 [ieee1394]
Feb 10 11:55:35 localhost kernel:  [<f89fcee7>]
nodemgr_probe_ne_cb+0x0/0x8d [ieee1394]
Feb 10 11:55:35 localhost kernel:  [<f89fd463>]
nodemgr_host_thread+0x17d/0x1a1 [ieee1394]
Feb 10 11:55:35 localhost kernel:  [<f89fd2e6>]
nodemgr_host_thread+0x0/0x1a1 [ieee1394]
Feb 10 11:55:35 localhost kernel:  [<c0107255>]
kernel_thread_helper+0x5/0xb
Feb 10 11:55:35 localhost kernel:
Feb 10 11:55:35 localhost kernel: Code:  Bad EIP value.
Feb 10 11:55:35 localhost kernel:  <6>sbp2: $Rev: 1096 $ Ben Collins
<bcollins@debian.org>
Feb 10 11:55:35 localhost kernel: ip_tables: (C) 2000-2002 Netfilter
core team
Feb 10 11:55:35 localhost autofs: automount startup succeeded
...
For more information, please mail me back as I'm not on the list.
TIA,

Bob

