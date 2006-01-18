Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWARIgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWARIgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWARIgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:36:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57905 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030190AbWARIga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:36:30 -0500
Date: Wed, 18 Jan 2006 09:37:21 +0100
From: Jens Axboe <axboe@suse.de>
To: jeffrey.t.kirsher@intel.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] e1000 C style badness
Message-ID: <20060118083721.GA4222@suse.de>
References: <20060118080738.GD3945@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118080738.GD3945@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Seems e1000 has even bigger problems than just C style badness in the
newest -git after the e1000 updates. diff of kernel boot messages from
e1000:

-Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
+Intel(R) PRO/1000 Network Driver - version 6.3.9-k2
 Copyright (c) 1999-2005 Intel Corporation.
 ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
 PCI: Setting latency timer of device 0000:02:00.0 to 64
+e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
00:0c:f1:ff:92:b8
 e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection

It sends/receives 5 packages, but the dhcp request never succeeds. If I
down the interface, it oopses (nvidia module is loaded, however it bombs
in the same way without it). If I revert just the e1000 updates, my
system work fine (typing this message from it).

Unable to handle kernel NULL pointer dereference at 0000000000000160 RIP: 
<ffffffff80319d0b>{skb_drop_fraglist+20}
PGD 0 
Oops: 0000 [1] SMP 
CPU 1 
Modules linked in: nvidia
Pid: 2806, comm: dhcpcd Tainted: P      2.6.16-rc1 #15
RIP: 0010:[<ffffffff80319d0b>] <ffffffff80319d0b>{skb_drop_fraglist+20}
RSP: 0018:ffff81003a39fce8  EFLAGS: 00010206
RAX: ffff81003c8dce80 RBX: ffff81003e28ec80 RCX: 0000000000000002
RDX: 0000000000000800 RSI: 000000003e32c012 RDI: 0000000000000160
RBP: ffff81003f33a1c0 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff81003f345000 R14: ffff81003f011000 R15: ffff81003a162610
FS:  00002aff325eab00(0000) GS:ffff81003f2ce440(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000160 CR3: 000000003a617000 CR4: 00000000000006e0
Process dhcpcd (pid: 2806, threadinfo ffff81003a39e000, task ffff81003f22eea0)
Stack: ffff81003e28ec80 ffffffff80319dc4 0000000000000000 ffff81003e28ec80 
       ffff81003f33a1c0 ffffffff80319de2 ffffc20000036000 ffffffff80293534 
       ffff81003a39fd56 ffff81003f011500 
Call Trace: <ffffffff80319dc4>{skb_release_data+136}
       <ffffffff80319de2>{kfree_skbmem+9} <ffffffff80293534>{e1000_clean_rx_ring+137}
       <ffffffff80293696>{e1000_clean_all_rx_rings+32} <ffffffff80297c85>{e1000_down+279}
       <ffffffff802983d5>{e1000_close+21} <ffffffff8031cf11>{dev_close+85}
       <ffffffff8031cd1a>{dev_change_flags+97} <ffffffff80352f1e>{inet_ioctl+0}
       <ffffffff803528d8>{devinet_ioctl+542} <ffffffff80314a86>{sock_ioctl+500}
       <ffffffff80173f45>{do_ioctl+33} <ffffffff801741c9>{vfs_ioctl+570}
       <ffffffff8017421e>{sys_ioctl+60} <ffffffff8010a81e>{system_call+126}

Code: 48 8b 1f 8b 87 ac 00 00 00 ff c8 75 05 0f ae e8 eb 0e f0 ff 
RIP <ffffffff80319d0b>{skb_drop_fraglist+20} RSP <ffff81003a39fce8>
CR2: 0000000000000160
 
-- 
Jens Axboe

