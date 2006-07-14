Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422692AbWGNSBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422692AbWGNSBS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422693AbWGNSBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:01:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19406 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422692AbWGNSBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:01:17 -0400
Date: Fri, 14 Jul 2006 11:00:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: 2.6.18-rc1-mm2
Message-Id: <20060714110051.35902bfa.akpm@osdl.org>
In-Reply-To: <200607141336.08989.rjw@sisk.pl>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	<200607141336.08989.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006 13:36:08 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Unable to handle kernel NULL pointer dereference at 0000000000000038 RIP:
>  [<ffffffff8024a07b>] __lock_acquire+0x7b/0xd30
> PGD 0
> Oops: 0000 [1] PREEMPT
> last sysfs file: /devices/pci0000:00/0000:00:0a.0/subsystem_vendor
> CPU 0
> Modules linked in: ehci_hcd snd_page_alloc ip6t_REJECT xt_tcpudp i2c_nforce2 i2c_core ipt_REJECT xt_state ohci_hcd iptable_mangle iptable_n
> at ip_nat iptable_filter ip6table_mangle ip_conntrack ip_tables parport_pc lp ip6table_filter parport ip6_tables x_tables ipv6 dm_mod
> Pid: 110, comm: khubd Not tainted 2.6.18-rc1-mm2 #3
> RIP: 0010:[<ffffffff8024a07b>]  [<ffffffff8024a07b>] __lock_acquire+0x7b/0xd30
> RSP: 0018:ffff81005feb1c18  EFLAGS: 00010046
> RAX: 0000000000000002 RBX: 0000000000000246 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000030
> RBP: ffff81005feb1c88 R08: 0000000000000002 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8046e23f
> R13: 0000000000000000 R14: ffff81005fe92040 R15: 0000000000000030
> FS:  00002b0df5390b00(0000) GS:ffffffff808c0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000038 CR3: 000000005dc35000 CR4: 00000000000006e0
> Process khubd (pid: 110, threadinfo ffff81005feb0000, task ffff81005fe92040)
> Stack:  0000000000000000 ffff81005fe92040 ffff81005febe7a8 ffffffff80470079
>  0000000200000000 0000000000000000 ffffffff80470038 0000000000000246
>  ffff81005a701680 0000000000000246 ffffffff8046e23f 0000000000000002
> Call Trace:
>  [<ffffffff8024b0bb>] lock_acquire+0x8b/0xc0
>  [<ffffffff8047193f>] _spin_lock+0x2f/0x40
>  [<ffffffff8046e23f>] klist_remove+0x1f/0x50
>  [<ffffffff803b9817>] bus_remove_device+0xa7/0xe0
>  [<ffffffff803b80f9>] device_del+0x149/0x180
>  [<ffffffff803d2d95>] usb_disconnect+0x105/0x150
>  [<ffffffff803d5cc6>] hub_thread+0x616/0xfd0
>  [<ffffffff80243809>] kthread+0xd9/0x110
>  [<ffffffff8020a316>] child_rip+0x8/0x12

I seem to have made a programming mistake.


From: Andrew Morton <akpm@osdl.org>

device_attach() has tristate return-value semantics.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/base/bus.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff -puN drivers/base/bus.c~drivers-base-check-errors-fix drivers/base/bus.c
--- a/drivers/base/bus.c~drivers-base-check-errors-fix
+++ a/drivers/base/bus.c
@@ -401,8 +401,10 @@ int bus_attach_device(struct device * de
 
 	if (bus) {
 		ret = device_attach(dev);
-		if (ret == 0)
+		if (ret >= 0) {
 			klist_add_tail(&dev->knode_bus, &bus->klist_devices);
+			ret = 0;
+		}
 	}
 	return ret;
 }
@@ -571,6 +573,8 @@ static int __must_check bus_rescan_devic
 		ret = device_attach(dev);
 		if (dev->parent)
 			up(&dev->parent->sem);
+		if (ret > 0)
+			ret = 0;
 	}
 	return ret;
 }
_

