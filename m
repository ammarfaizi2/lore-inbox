Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269106AbUIRDAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269106AbUIRDAg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 23:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269107AbUIRDAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 23:00:34 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:44125 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269106AbUIRDA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 23:00:29 -0400
Message-ID: <9e47339104091720002071f0f8@mail.gmail.com>
Date: Fri, 17 Sep 2004 23:00:28 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Bob Gill <gillb4@telusplanet.net>
Subject: Re: [2.6.9-rc2-bk] Network-related panic on boot
Cc: "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095474316.5058.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1095459971.8786.14.camel@localhost.localdomain>
	 <20040917154942.39034b0c.davem@davemloft.net>
	 <1095474316.5058.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the same error. As far as I can tell it happens on Redhat
during the Checking for New Hardware" phase when the kernel is
modprobing/rmmod the modules to find out what hardware there is. If I
build the drivers in the problem goes away.


On Fri, 17 Sep 2004 20:25:16 -0600, Bob Gill <gillb4@telusplanet.net> wrote:
> On Fri, 2004-09-17 at 16:49, David S. Miller wrote:
> > Already fixed.  Patch below:
> OK, I might be missing some of the patch.  My net/ipv4/fib_semantics.c
> looks like this (from line 601 to 615):
>         new_info_hash = fib_hash_alloc(bytes);
>                new_laddrhash = fib_hash_alloc(bytes);
>                if (!new_info_hash || !new_laddrhash) {
>                        fib_hash_free(new_info_hash, bytes);
>                        fib_hash_free(new_laddrhash, bytes);
>                 } else {
>                         memset(new_info_hash, 0, bytes);
>                         memset(new_laddrhash, 0, bytes);
>                        fib_hash_move(new_info_hash, new_laddrhash,
> new_size);
>                        }
> 
>                if (!fib_hash_size)
>                        goto failure;
>        }
> 
> 
> ...and after rebuilding the kernel, I still get the following (similar,
> but different) error on boot:
> Enabling local filesystem quotas:                          [ OK ]
> Enabling swap space:                                       [ OK ]
> INIT: Entering runlevel: 5                                 [ OK ]
> Entering non-interactive startup
> Applying Intel IA32 Microcode update:                      [ OK ]
> Starting sysstat:                                          [ OK ]
> Starting readahead_early:                                  [ OK ]
> Checking for new hardware------------[ cut here ]------------
> kernel BUG at net/ipv4/fib_semantics.c:1039!
> invalid operand: 0000 [#1]
> PREEMPT
> Modules linked in: sis900 sg scsi_mod usblp ohci_hcd usbcore thermal
> processor fan button battery asus_acpi ac
> CPU:    0
> EIP:    0060:[<c029d318>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.9-rc2-bk3)
> EIP is at fib_sync_down+0x1b9/0x1c6
> eax: ffffffff   ebx: 00000000   ecx: c03375a0   edx: 00000000
> esi: 00000000   edi: 00000006   ebp: f796c138   esp: f79cfe38
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 2389, threadinfo=f79ce000 task=f7859560)
> Stack: 00000000 00000000 f796c138 ffffffff 00000000 f796c000 f796c000
> 00000006
>       f796c138 c029b7ba 00000000 f796c000 00000002 c033a55c c029b8dd
> f796c000
>       00000002 c033a55c f796c000 c0124c58 c033a55c 00000006 f796c000
> f796c000
> Call Trace:
> [<c029b7ba>] fib_disable_ip+0x23/0x4a
> [<c029b8dd>] fib_netdev_event+0x8a/0x99
> [<c0124c58>] notifier_call_chain+0x27/0x3e
> [<c025c505>] unregister_netdevice+0x15b/0x270
> [<c021e398>] unregister_netdev+0x18/0x24
> [<f8ad549e>] sis900_remove+0x85/0xc3 [sis900]
> [<c01bf5f9>] pci_device_remove+0x3b/0x3d
> [<c02078b5>] device_release_driver+0x64/0x66
> [<c02078d7>] driver_detatch+0x20/0x2e
> [<c0207ce4>] bus_remove_driver+0x4c/0x84
> [<c02081ac>] driver_unregister+0x13/0x28
> [<c01bf81d>] pci_unregister_driver+0x16/0x26
> [<f8ad567b>] sis900_cleanup_module+0xf/0x13 [sis900]
> [<c012d36a>] sys_delete_module+0x153/0x183
> [<c0142e77>] do_munmap+0x142/0x17f
> [<c0104019>] sysenter_past_esp+0x52/0x71
> Code: 4f 5c e9 78 ff ff ff e8 46 0f 01 00 eb e7 0f 0b 2d 04 57 a3 2d c0
> e9 16 ff ff ff 83 48 1c 01 83 44 24 10 01 8b 11 e9 b9 fe ff ff <0f> 0b
> 12 04 57 a3 2d c0 e9 77 fe ff ff 55 57 56 53 83 ec 10 8b
> 
> Updating /etc/fstab                                        [ OK ]
> Applying iptables firewall rules:                          [ OK ]
> Setting network parameters:                                [ OK ]
> Bringing up loopback interface:
> ...
> Am I missing part of the patch?
> 
> Bob
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



-- 
Jon Smirl
jonsmirl@gmail.com
