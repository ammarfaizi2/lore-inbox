Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVHSTxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVHSTxA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 15:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbVHSTxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 15:53:00 -0400
Received: from pop.gmx.de ([213.165.64.20]:52625 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965116AbVHSTw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 15:52:59 -0400
X-Authenticated: #1725425
Date: Fri, 19 Aug 2005 21:51:16 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, afleming@freescale.com
Subject: Re: 2.6.13-rc6-mm1 - OOPS in drivers/net/phy
Message-Id: <20050819215116.55365a0a.Ballarin.Marc@gmx.de>
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
the changes to drivers/net/phy in git-netdev-all.patch have some issues:

1) phy.c (libphy.ko) lacks MODULE_LICENCE(GPL), but uses GPL-only
exports

2) after fixing this (or when compiling statically) it causes the following
OOPS (new in rc6-mm1):

Badness in kref_get at lib/kref.c:32
 [<c0103b17>] dump_stack+0x17/0x20
 [<c01c4456>] kref_get+0x46/0x50
 [<c01c3a92>] kobject_get+0x12/0x20
 [<c02364e6>] get_bus+0x16/0x30
 [<c0236389>] bus_add_driver+0x19/0xc0
 [<c0236d1a>] driver_register+0x2a/0x40
 [<f18d3159>] phy_driver_register+0x49/0x90 [libphy]
 [<f080400e>] phy_init+0xe/0x40 [libphy]
 [<c0134fa9>] sys_init_module+0x149/0x1f0
 [<c0102c6b>] sysenter_past_esp+0x54/0x75
---------------------------
| preempt count: 00000000 ]
---------------------------

Badness in kref_get at lib/kref.c:32
 [<c0103b17>] dump_stack+0x17/0x20
 [<c01c4456>] kref_get+0x46/0x50
 [<c01c3a92>] kobject_get+0x12/0x20
 [<c01c3788>] kobject_init+0x28/0x40
 [<c01c38ec>] kobject_register+0x1c/0x70
 [<c02363c4>] bus_add_driver+0x54/0xc0
 [<c0236d1a>] driver_register+0x2a/0x40
 [<f18d3159>] phy_driver_register+0x49/0x90 [libphy]
 [<f080400e>] phy_init+0xe/0x40 [libphy]
 [<c0134fa9>] sys_init_module+0x149/0x1f0
 [<c0102c6b>] sysenter_past_esp+0x54/0x75
---------------------------
| preempt count: 00000000 ]
---------------------------

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01c3894
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
last sysfs file: /class/vc/vcs3/dev
Modules linked in: libphy snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd snd_page_alloc ntfs vfat fat reiser4 zlib_deflate zlib_inflate usb_storage loop acpi_cpufreq yealink usbhid joydev acpi_sbs i2c_acpi_ec bcm4400 ehci_hcd uhci_hcd usbcore intel_agp agpgart psmouse
CPU:    0
EIP:    0060:[<c01c3894>]    Not tainted VLI
EFLAGS: 00010292   (2.6.13-rc6-mm1-laptop) 
EIP is at kobject_add+0x94/0xd0
eax: f18d4140   ebx: f18d406c   ecx: 00000000   edx: f18d4088
esi: ffffffea   edi: f18d4148   ebp: ed089f14   esp: ed089f08
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 8250, threadinfo=ed088000 task=efd7c690)
Stack: f18d406c ffffffea f18d40e0 ed089f30 c01c38f3 ed089f44 00000000 f18d4058 
       f18d4058 f18d406c ed089f54 c02363c4 f18d406c c0315706 f18d338f 00000000 
       f18d4058 0805b198 f18d40dc ed089f70 c0236d1a 00000000 00000011 0000000b 
Call Trace:
 [<c0103aea>] show_stack+0x7a/0x90
 [<c0103c78>] show_registers+0x158/0x1c0
 [<c0103e85>] die+0xf5/0x180
 [<c02ee4c4>] do_page_fault+0x2a4/0x59d
 [<c0103777>] error_code+0x4f/0x54
 [<c01c38f3>] kobject_register+0x23/0x70
 [<c02363c4>] bus_add_driver+0x54/0xc0
 [<c0236d1a>] driver_register+0x2a/0x40
 [<f18d3159>] phy_driver_register+0x49/0x90 [libphy]
 [<f080400e>] phy_init+0xe/0x40 [libphy]
 [<c0134fa9>] sys_init_module+0x149/0x1f0
 [<c0102c6b>] sysenter_past_esp+0x54/0x75
---------------------------
| preempt count: 00000002 ]
| 2 level deep critical section nesting:
----------------------------------------
.. [<c01c387e>] .... kobject_add+0x7e/0xd0
.....[<c01c38f3>] ..   ( <= kobject_register+0x23/0x70)
.. [<c0103dc8>] .... die+0x38/0x180
.....[<c02ee4c4>] ..   ( <= do_page_fault+0x2a4/0x59d)

Code: 74 e2 89 f8 e8 ce 02 00 00 eb d9 b8 01 00 00 00 e8 12 4d 00 00 85 ff 74 36 8b 43 28 8d 53 1c 83 c0 08 89 43 1c 8b 48 04 89 50 04 <89> 11 89 4a 04 b8 01 00 00 00 e8 4d 4d 00 00 b8 00 e0 ff ff 21 
 <3>BUG: modprobe[8250] exited with nonzero preempt_count 1!
---------------------------
| preempt count: 00000001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<c01c387e>] .... kobject_add+0x7e/0xd0
.....[<c01c38f3>] ..   ( <= kobject_register+0x23/0x70)

