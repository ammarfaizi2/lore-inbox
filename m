Return-Path: <linux-kernel-owner+w=401wt.eu-S1754169AbWLRPob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbWLRPob (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754171AbWLRPob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:44:31 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:46378 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170AbWLRPoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:44:30 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] OOPS: divide error while s2dsk (2.6.20-rc1-mm1)
Date: Mon, 18 Dec 2006 16:46:22 +0100
User-Agent: KMail/1.9.1
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       linux-pm@osdl.org
References: <4586797B.3080007@gmail.com>
In-Reply-To: <4586797B.3080007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612181646.23292.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 18 December 2006 12:20, Jiri Slaby wrote:
> Hi.
> 
> I got this oops while suspending:
> [  309.366557] Disabling non-boot CPUs ...
> [  309.386563] CPU 1 is now offline
> [  309.387625] CPU1 is down
> [  309.387704] Stopping tasks ... done.
> [  310.030991] Shrinking memory... -<0>divide error: 0000 [#1]
> [  310.456669] SMP
> [  310.456814] last sysfs file:
> /devices/pci0000:00/0000:00:1e.0/0000:02:08.0/eth0/statistics/collisions
> [  310.456919] Modules linked in: eth1394 floppy ohci1394 ide_cd ieee1394 cdrom
> [  310.457259] CPU:    0
> [  310.457260] EIP:    0060:[<c0150c9a>]    Not tainted VLI
> [  310.457261] EFLAGS: 00210246   (2.6.20-rc1-mm1 #207)
> [  310.457478] EIP is at shrink_slab+0x9e/0x169

Looks like we have a problem with slab shrinking here.

Could you please use gdb to check what exactly is at shrink_slab+0x9e?

> [  310.457548] eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
> [  310.457623] esi: 00000000   edi: c18fe500   ebp: f7b3fe3c   esp: f7b3fe08
> [  310.457696] ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
> [  310.457772] Process swsusp (pid: 3243, ti=f7b3e000 task=f756f030
> task.ti=f7b3e000)
> [  310.457845] Stack: c175d8a0 c175daa0 c175db00 00000000 00000000 c053cec0
> 000045ec 000000d0
> [  310.458286]        00000000 00000000 00001179 00001179 00000000 f7b3fe94
> c0151445 00000001
> [  310.458723]        f7b3fe64 00001df1 00000002 00000001 00000001 00038000
> 00000c79 0000117b
> [  310.459199] Call Trace:
> [  310.459334]  [<c0103f1b>] show_trace_log_lvl+0x1a/0x30
> [  310.459450]  [<c0103fd6>] show_stack_log_lvl+0xa5/0xca
> [  310.459562]  [<c01041ce>] show_registers+0x1d3/0x2b8
> [  310.459673]  [<c01043d4>] die+0x121/0x243
> [  310.459781]  [<c010456c>] do_trap+0x76/0x9c
> [  310.459892]  [<c0104bd8>] do_divide_error+0x94/0x9e
> [  310.460001]  [<c038a7e4>] error_code+0x7c/0x84
> [  310.460113]  [<c0151445>] shrink_all_memory+0x211/0x2eb
> [  310.460225]  [<c01418c1>] swsusp_shrink_memory+0x187/0x196
> [  310.460335]  [<c0141a07>] prepare_processes+0x35/0xc8
> [  310.460446]  [<c0141cce>] pm_suspend_disk+0xd/0x16f
> [  310.460558]  [<c0140c87>] enter_state+0x129/0x19b
> [  310.460668]  [<c0140d9c>] state_store+0xa3/0xac
> [  310.460777]  [<c0198ab0>] subsys_attr_store+0x20/0x25
> [  310.460889]  [<c0198b9f>] sysfs_write_file+0x97/0xd8
> [  310.460998]  [<c0165262>] vfs_write+0x8b/0x149
> [  310.461108]  [<c01658cb>] sys_write+0x3d/0x64
> [  310.461216]  [<c0102fe4>] syscall_call+0x7/0xb
> [  310.461328]  =======================
> [  310.461397] Code: 31 c0 ff 17 89 c3 8b 45 e4 31 d2 f7 77 0c f7 e3 89 45 d8 89
> 55 dc 89 d1 89 c6 31 d2 85 c9 74 09 89 c8 31 d2 f7 75 f0 89 c1 89 f0 <f7> 75 f0
> 89 ca 89 45 d8 89 55 dc 8b 45 d8 03 47 10 89 47 10 85
> [  310.464079] EIP: [<c0150c9a>] shrink_slab+0x9e/0x169 SS:ESP 0068:f7b3fe08
> [  310.464228]
> 
> swsusp script is something like this:
> echo platform > /sys/power/disk
> echo disk > /sys/power/state
> 
> regards,

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
