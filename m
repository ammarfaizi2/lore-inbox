Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWFMHWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWFMHWT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 03:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932948AbWFMHWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 03:22:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:15580 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932553AbWFMHWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 03:22:18 -0400
Message-ID: <448E6798.3020104@fr.ibm.com>
Date: Tue, 13 Jun 2006 09:22:00 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
References: <20060609214024.2f7dd72c.akpm@osdl.org> <448DA5DD.203@fr.ibm.com> <Pine.LNX.4.64.0606121511090.21172@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606121511090.21172@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Mon, 12 Jun 2006, Cedric Le Goater wrote:
> 
>> Unable to handle kernel NULL pointer dereference at 0000000000000007 RIP:
>>  [<ffffffff8025b017>] dec_zone_page_state+0x1/0x5b
> 
> Seems that req->wb_page may be NULL.
> 
> This patch may fix it but we may miss an unstable page then. We may 
> have to move the decrement of NR_UNSTABLE to a different location when
> wb_page is still valid.
> 
> Index: linux-2.6.17-rc6-cl/fs/nfs/write.c
> ===================================================================
> --- linux-2.6.17-rc6-cl.orig/fs/nfs/write.c	2006-06-12 13:37:47.321243148 -0700
> +++ linux-2.6.17-rc6-cl/fs/nfs/write.c	2006-06-12 15:13:48.020908204 -0700
> @@ -1419,7 +1419,8 @@ static void nfs_commit_done(struct rpc_t
>  		nfs_mark_request_dirty(req);
>  	next:
>  		nfs_clear_page_writeback(req);
> -		dec_zone_page_state(req->wb_page, NR_UNSTABLE);
> +		if (req->wb_page)
> +			dec_zone_page_state(req->wb_page, NR_UNSTABLE);
>  	}
>  }

thanks for the patch ! I gave it a try but req->wb_page seems bogus ?



general protection fault: 0000 [1] SMP
last sysfs file: /class/vc/vcsa3/dev
CPU 1
Modules linked in: autofs4 nfs lockd sunrpc joydev sony_acpi button battery
ac uhci_hcd ehci_hcd tg3 sg ext3 jbd ata_piix libata
Pid: 2456, comm: rpciod/1 Not tainted 2.6.17-rc6-mm2 #2
RIP: 0010:[<ffffffff8025b017>]  [<ffffffff8025b017>]
dec_zone_page_state+0x1/0x5b
RSP: 0018:ffff81014022dda8  EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff810140419408 RCX: ffff810140419450
RDX: 0000000000000006 RSI: 0000000000000007 RDI: 6b6b6b6b6b6b6b6b
RBP: ffff81014022ddd8 R08: ffff81013ef08b70 R09: 0000000000000000
R10: ffff810140419408 R11: 0000000000000060 R12: ffff81013d7c2668
R13: ffff81013d7c2670 R14: 0000000000000283 R15: ffff81013d7c2670
FS:  0000000000000000(0000) GS:ffff810142c82238(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000703ba8 CR3: 000000013dd32000 CR4: 00000000000006e0
Process rpciod/1 (pid: 2456, threadinfo ffff81014022c000, task
ffff810140c8e0c0)
Stack:  ffff81014022ddd8 ffffffff880eab24 0000000000000000 ffff81013d7c2670
 ffff81013d7c2740 0000000000000000 ffff81014022ddf8 ffffffff880a5a51
 ffff81013d7c2670 ffff81013d7c2670
Call Trace:
 [<ffffffff880eab24>] :nfs:nfs_commit_done+0x191/0x19f
 [<ffffffff880a5a51>] :sunrpc:rpc_exit_task+0x2a/0x6c
 [<ffffffff880a5f98>] :sunrpc:__rpc_execute+0x99/0x1e0
 [<ffffffff880a60e8>] :sunrpc:rpc_async_schedule+0x9/0xb
 [<ffffffff8023c72e>] run_workqueue+0xa8/0xef
 [<ffffffff880a60df>] :sunrpc:rpc_async_schedule+0x0/0xb
 [<ffffffff8023c775>] worker_thread+0x0/0x12f
 [<ffffffff8023c871>] worker_thread+0xfc/0x12f
 [<ffffffff80225eca>] default_wake_function+0x0/0xf
 [<ffffffff80225eca>] default_wake_function+0x0/0xf
 [<ffffffff8023c775>] worker_thread+0x0/0x12f
 [<ffffffff8023f92c>] kthread+0xd0/0xfc
 [<ffffffff8020a33a>] child_rip+0x8/0x12
 [<ffffffff8023f85c>] kthread+0x0/0xfc
 [<ffffffff8020a332>] child_rip+0x0/0x12


Code: 48 0f b6 47 07 48 89 e5 4c 8b 0c c5 80 2b 80 80 9c 41 58 fa
RIP  [<ffffffff8025b017>] dec_zone_page_state+0x1/0x5b
 RSP <ffff81014022dda8>
