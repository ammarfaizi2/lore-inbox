Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266361AbUBLG4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 01:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266365AbUBLG4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 01:56:53 -0500
Received: from defout.telus.net ([199.185.220.240]:37114 "EHLO
	priv-edtnes46.telusplanet.net") by vger.kernel.org with ESMTP
	id S266361AbUBLG4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 01:56:50 -0500
Subject: [2.6.3-rc2 bk] ieee1394 oops on bootup
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076569092.3550.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 11 Feb 2004 23:58:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I tried your suggestion (but without success).
I built 2.6.3-rc2-bk1 (and on boot I get the badness message).  I backed
up /lib/modules/2.6.3-rc2-bk1/modules.dep and deleted all of the 1394
references from it.  I then booted 2.6.3-rc2-bk1 (no error messages but
no 1394 modules either).  Since insmod/modprobe/depmod will tell you no
1394 modules exist (at this point), I copied modules.dep.bak to
modules.dep (and then ran modprobe ohci1394).  Unfortunately, I got:
ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[9] 
MMIO=[eb005000-eb0057ff]  Max Packet=[2048]
Badness in kobject_get at lib/kobject.c:431
Call Trace:
[<c0192f22>] kobject_get+0x4c/0x4e
[<c01d775e>] get_device+0x18/0x21
[<c01d82af>] bus_for_each_dev+0x63/0xba
[<f8c9401e>] nodemgr_node_probe+0x4d/0x124 [ieee1394]
[<f8c93ee7>] nodemgr_probe_ne_cb+0x0/0x8d [ieee1394]
[<f8c94463>] nodemgr_host_thread+0x17d/0x1a1 [ieee1394]
[<f8c942e6>] nodemgr_host_thread+0x0/0x1a1 [ieee1394]
[<c0107255>] kernel_thread_helper+0x5/0xb

Unable to handle kernel paging request at virtual address b828ec83
printing eip:
b828ec83
*pde = 00000000
modprobe: FATAL: Module sbp2 already in kernel.
Oops: 0000 [#1]
ieee1394.agent[2413]: ... can't load module sbp2
kernel: CPU:    0
ieee1394.agent[2413]: missing kernel or user mode driver sbp2
kernel: EIP:    0060:[<b828ec83>]    Not tainted
EFLAGS: 00010282
EIP is at 0xb828ec83
eax: b828ec83   ebx: f8c9d3c4   ecx: f75d7f9c   edx: 00000000
esi: f8c938ff   edi: 00000000   ebp: f8c92669   esp: f75d7f40
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 2411, threadinfo=f75d6000 task=f725e080)
Stack: c0192fbc f8c9d3c4 f8c9d3a0 f8c9d3a8 f8c9d300 f70bf244 c01d82cc
f8c9d3c4
       f75d7f9c f8c9d34c 00000000 f70bf23c f75d7f9c f7155398 f75d7f9c
f8c9401e
       f8c9d300 f70bf23c f75d7f9c f8c93ee7 00000004 f8c9cd40 f75cc000
f7155398
Call Trace:
[<c0192fbc>] kobject_cleanup+0x98/0x9a
[<c01d82cc>] bus_for_each_dev+0x80/0xba
[<f8c9401e>] nodemgr_node_probe+0x4d/0x124 [ieee1394]
[<f8c93ee7>] nodemgr_probe_ne_cb+0x0/0x8d [ieee1394]
[<f8c94463>] nodemgr_host_thread+0x17d/0x1a1 [ieee1394]
[<f8c942e6>] nodemgr_host_thread+0x0/0x1a1 [ieee1394]
[<c0107255>] kernel_thread_helper+0x5/0xb

Code:  Bad EIP value.
<6>sbp2: $Rev: 1096 $ Ben Collins <bcollins@debian.org>


The only really weird thing is that I prefer to keep things as modular
as possible (and if for whatever reason initrd-yadda.img isn't created
after the kernel compile, I run mkinitrd myself).  Here, the messages
are telling me that sbp2 is already in the kernel (and so sbp2 can't be
loaded), but my build script shows:CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
and when I look in /lib/modules/`uname -r`/kernel/drivers/ie* I get
sbp2.ko along with everything else.  I double checked that the line
loading sbp2 was not in the version of modules.dep that I booted with
(and that it was in the one I finally loaded the 1394 modules with). 
The system seems to be confused as to whether sbp2 is compiled into the
kernel or available as a module.  The logic race theory was a good test,
but I still get an Oops when loading modules long after boot time
(sorry).  

Bob

