Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUG1Th3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUG1Th3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 15:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUG1Th3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 15:37:29 -0400
Received: from av9-1-sn1.fre.skanova.net ([81.228.11.115]:59858 "EHLO
	av9-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262905AbUG1Th0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 15:37:26 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1
References: <20040728020444.4dca7e23.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Jul 2004 21:37:21 +0200
In-Reply-To: <20040728020444.4dca7e23.akpm@osdl.org>
Message-ID: <m3pt6fudn2.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm1/
[...]
> Changes since 2.6.8-rc1-mm1:
[...]
> +control-pktcdvd-with-an-auxiliary-character-device.patch
> +control-pktcdvd-with-an-auxiliary-character-device-fix.patch
> 
>  CDRW/DVDRW packet writing updates

The control-pktcdvd-with-an-auxiliary-character-device patch
introduced a door locking bug.

    pktsetup, mount, umount -> door remains locked.

The problem is that pktsetup opens the cdrom device in non-blocking
mode, which doesn't lock the door. mount then opens the cdrom device
again in blocking mode, which does lock the door. umount closes the
blocking mode open, but the door remains locked, because
cdrom.c:cdrom_release() only unlocks the door on the last release, it
doesn't care that the only remaining open is non-blocking.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/block/pktcdvd.c~packet-door-unlock drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-door-unlock	2004-07-26 17:36:21.425126472 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-07-26 17:36:21.442123888 +0200
@@ -1981,6 +1981,8 @@ static void pkt_release_dev(struct pktcd
 	if (flush && pkt_flush_cache(pd))
 		DPRINTK("pktcdvd: %s not flushing cache\n", pd->name);
 
+	pkt_lock_door(pd, 0);
+
 	q = bdev_get_queue(pd->bdev);
 	pkt_set_speed(pd, 0xffff, 0xffff);
 	spin_lock_irq(q->queue_lock);
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
