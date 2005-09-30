Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVI3RlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVI3RlZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVI3RlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:41:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44765 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964774AbVI3RlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:41:24 -0400
Date: Fri, 30 Sep 2005 10:40:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hendrik Visage <hvjunk@gmail.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org, ionut@badula.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Starfire (Adaptec) kernel 2.6.13+ panics on AMD64 NFS server
Message-Id: <20050930104046.4685e975.akpm@osdl.org>
In-Reply-To: <d93f04c70509300901s3836b8afw4792d16c589b4fc4@mail.gmail.com>
References: <d93f04c70509292036x269df799y7b51c5be9c3356d6@mail.gmail.com>
	<20050929211649.69eaddee.akpm@osdl.org>
	<d93f04c70509300901s3836b8afw4792d16c589b4fc4@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hendrik Visage <hvjunk@gmail.com> wrote:
>
> On 9/30/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> > The starfire changes in 2.6.12->2.6.13 look fairly innocuous.  Need that
> > trace, please.
> 
> See attached :)
> 

It helps, thanks.


> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at net/core/dev.c:1099
> invalid operand: 0000 [1] PREEMPT 
> CPU 0 
> Modules linked in: nvidia nfsd exportfs lockd sunrpc rfcomm l2cap hci_usb bluetooth starfire mii snd_ac97_bus soundcore snd_page_alloc forcedeth i2c_nforce2 dm_mirror dm_mod sbp2 ohci1394 ieee1394 ohci_hcd uhci_hcd usb_storage usbhid ehci_hcd usbcore
> Pid: 11252, comm: nfsd Tainted: P      2.6.14-rc2 #3
> RIP: 0010:[<ffffffff802cc7ed>] <ffffffff802cc7ed>{skb_checksum_help+157}
> RSP: 0000:ffff81003a0bd998  EFLAGS: 00010246
> RAX: ffff81003ff01624 RBX: ffff81003ca7f180 RCX: 00000000b7e42194
> RDX: 00000000b7e42194 RSI: ffff81003ff01624 RDI: ffff81003b026080
> RBP: ffff81003a0bd9b8 R08: 0000000000000000 R09: 0000000000000004
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ffff81003ca7f180 R15: ffff81003d462218
> FS:  00002aaaaade6ae0(0000) GS:ffffffff804fe800(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00002aaaaaac2000 CR3: 000000003d5a2000 CR4: 00000000000006e0
> Process nfsd (pid: 11252, threadinfo ffff81003a0bc000, task ffff81003e0ed0c0)
> Stack: ffffffff804cd720 ffff81003d462000 ffff81003d4623e0 ffff81003ca7f180 
>        ffff81003a0bda08 ffffffff88104944 ffff81003d462218 000000013a2a8600 
>        ffff81003d462000 ffff81003d462000 
> Call Trace:<ffffffff88104944>{:starfire:start_tx+164} <ffffffff802db0fc>{qdisc_restart+268}
>        <ffffffff802ccad0>{dev_queue_xmit+288} <ffffffff802d29b0>{neigh_resolve_output+672}
>        <ffffffff802ebb27>{ip_finish_output+455} <ffffffff802ec5ff>{ip_fragment+863}
>        <ffffffff802eb960>{ip_finish_output+0} <ffffffff802eca6c>{ip_output+108}


yep, there's something wrong with the skb which starfire fed into
skb_checksum_help().

	offset = skb->tail - skb->h.raw;
	if (offset <= 0)
		BUG();

And that's a post-2.6.12 driver change.  You can probably work around
it by deleting the #define ZEROCOPY line.
