Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWGYC12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWGYC12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 22:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWGYC12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 22:27:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4321 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932409AbWGYC11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 22:27:27 -0400
Date: Mon, 24 Jul 2006 19:27:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: petero2@telia.com, arjan@linux.intel.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [patch] lockdep: annotate pktcdvd natural device hierarchy
Message-Id: <20060724192718.547a836e.akpm@osdl.org>
In-Reply-To: <44BA1609.9050305@free.fr>
References: <448875D1.5080905@free.fr>
	<448D84C0.1070400@linux.intel.com>
	<m3sllxtfbf.fsf@telia.com>
	<1151000451.3120.56.camel@laptopd505.fenrus.org>
	<m3u05kqvla.fsf@telia.com>
	<1152884770.3159.37.camel@laptopd505.fenrus.org>
	<m3odvrc2vo.fsf@telia.com>
	<1152947098.3114.9.camel@laptopd505.fenrus.org>
	<44B8C506.1000009@free.fr>
	<m3ac7b6spp.fsf@telia.com>
	<44BA1609.9050305@free.fr>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul 2006 12:33:45 +0200
Laurent Riffard <laurent.riffard@free.fr> wrote:

> 
> Thank you Peter, the above patch removed the "possible recursive 
> locking detected" message. 
> 
> Now, I've got a new one (will this thread never end ?):
> 
> pktcdvd: writer pktcdvd0 mapped to hdc
> INFO: trying to register non-static key.
> the code is fine but needs lockdep annotation.
> turning off the locking correctness validator.
>  [<c0104db5>] show_trace+0xd/0x10
>  [<c0104dd1>] dump_stack+0x19/0x1c
>  [<c012c2e1>] __lock_acquire+0x10f/0x9a5
>  [<c012cbd7>] lock_acquire+0x60/0x80
>  [<c0292131>] _spin_lock_irq+0x1f/0x2e
>  [<c028fe86>] wait_for_completion+0x29/0xe5
>  [<e1136299>] pkt_generic_packet+0x1bb/0x1e8 [pktcdvd]
>  [<e113671a>] pkt_get_disc_info+0x3d/0x77 [pktcdvd]
>  [<e113836f>] pkt_open+0xc3/0xbf4 [pktcdvd]
>  [<c0159c36>] do_open+0xa1/0x3bd
>  [<c015a179>] blkdev_open+0x1f/0x48
>  [<c0151c87>] __dentry_open+0xb8/0x186
>  [<c0151dc3>] nameidata_to_filp+0x1c/0x2e
>  [<c0151e03>] do_filp_open+0x2e/0x35
>  [<c0152ce1>] do_sys_open+0x40/0xbb
>  [<c0152d88>] sys_open+0x16/0x18
>  [<c0102c2d>] sysenter_past_esp+0x56/0x8d

I assume this:

--- a/drivers/block/pktcdvd.c~pktcdvd-lockdep-fixes-fix
+++ a/drivers/block/pktcdvd.c
@@ -348,7 +348,7 @@ static int pkt_generic_packet(struct pkt
 	char sense[SCSI_SENSE_BUFFERSIZE];
 	request_queue_t *q;
 	struct request *rq;
-	DECLARE_COMPLETION(wait);
+	DECLARE_COMPLETION_ONSTACK(wait);
 	int err = 0;
 
 	q = bdev_get_queue(pd->bdev);
_

will shut that up.

Arjan, do we still need
lockdep-annotate-pktcdvd-natural-device-hierarchy.patch?

And could you please take a look at Peter's block_dev.c changes?  Closely,
please - it'd be nice to get this right one of these days ;)

