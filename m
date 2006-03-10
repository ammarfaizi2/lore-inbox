Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWCJHod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWCJHod (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 02:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbWCJHod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 02:44:33 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:35529
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751698AbWCJHoc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 02:44:32 -0500
Message-ID: <44112E4F.7020304@tglx.de>
Date: Fri, 10 Mar 2006 08:44:15 +0100
From: Jan Altenberg <tb10alj@tglx.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt patch-2.6.15-rt18 issues
References: <45924.195.245.190.93.1141647094.squirrel@www.rncbc.org>       <20060306132442.GA12359@elte.hu>    <4547.195.245.190.94.1141657830.squirrel@www.rncbc.org>    <440D54F2.2080009@tglx.de> <36944.195.245.190.93.1141734835.squirrel@www.rncbc.org>
In-Reply-To: <36944.195.245.190.93.1141734835.squirrel@www.rncbc.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> - The SLAB related usb-storage crash on disconnect is still there:

I'm facing the same problem with -rt21. Kernel config, lspci -vvx
and dmesg output can be downloaded from:
http://www.tglx.de/private/tb10alj/rt21/

Unplugging the USB device causes:

 slab error in kmem_cache_destroy(): cache `scsi_cmd_cache': Can't free all objects
  [<c0161576>] kmem_cache_destroy+0xe9/0x11c (8)
  [<c037eac7>] scsi_destroy_command_freelist+0x4b/0x79 (24)
  [<c037fa47>] scsi_host_dev_release+0x46/0x8c (24)
  [<c031559c>] device_release+0x1c/0x51 (16)
  [<c02814b7>] kobject_cleanup+0x98/0x9a (16)
  [<c02814b9>] kobject_release+0x0/0xa (12)
  [<c03cf161>] usb_stor_control_thread+0x0/0x1a8 (8)
  [<c0281e91>] kref_put+0x3d/0x80 (4)
  [<c02814e1>] kobject_put+0x1e/0x22 (24)
  [<c02814b9>] kobject_release+0x0/0xa (8)
  [<c03cf2f5>] usb_stor_control_thread+0x194/0x1a8 (4)
  [<c04a1091>] schedule+0x47/0x134 (36)
  [<c011cfeb>] complete+0x4c/0x75 (4)
  [<c0134bfd>] kthread+0xb1/0xb7 (36)
  [<c0134b4c>] kthread+0x0/0xb7 (32)
  [<c01013ed>] kernel_thread_helper+0x5/0xb (16)

After reconnecting:

 kmem_cache_create: duplicate cache scsi_cmd_cache
  [<c016112d>] kmem_cache_create+0x638/0x6ae (8)
  [<c01398f1>] _spin_lock_init+0x2f/0x33 (52)
  [<c037e9fd>] scsi_setup_command_freelist+0x8d/0x10c (24)
  [<c013965a>] __init_MUTEX+0x20/0x28 (40)
  [<c037fcc0>] scsi_host_alloc+0x233/0x360 (16)
  [<c03cfa82>] storage_probe+0x36/0x221 (52)
  [<c03b0bf0>] usb_probe_interface+0x7d/0xa8 (52)
  [<c0317251>] driver_probe_device+0x69/0xd0 (24)
  [<c03172b8>] __device_attach+0x0/0x5 (28)
  [<c0316921>] bus_for_each_drv+0x65/0x7b (8)
  [<c0317327>] device_attach+0x6a/0x6e (48)
  [<c03172b8>] __device_attach+0x0/0x5 (16)
  [<c0316a62>] bus_add_device+0x51/0xcc (12)
  [<c03159bb>] device_add+0x122/0x198 (32)
  [<c03b903f>] usb_set_configuration+0x2c3/0x430 (36)
  [<c03b3585>] usb_new_device+0xe4/0x19d (80)
  [<c03b46e2>] hub_port_connect_change+0x214/0x3df (40)
  [<c03b000a>] cdrom_get_last_written+0xca/0x136 (28)
  [<c03b4b72>] hub_events+0x2c5/0x427 (40)
  [<c03b4ceb>] hub_thread+0x17/0xea (52)
  [<c01350c1>] autoremove_wake_function+0x0/0x57 (12)
  [<c01350c1>] autoremove_wake_function+0x0/0x57 (32)
  [<c04a11dc>] preempt_schedule+0x5e/0x84 (20)
  [<c03b4cd4>] hub_thread+0x0/0xea (16)
  [<c0134bfd>] kthread+0xb1/0xb7 (4)
  [<c0134b4c>] kthread+0x0/0xb7 (32)
  [<c01013ed>] kernel_thread_helper+0x5/0xb (16)


Cheers,
JAN
