Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTE1AZy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 20:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbTE1AZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 20:25:53 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6664 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S264464AbTE1AZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 20:25:50 -0400
Date: Wed, 28 May 2003 02:38:51 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Willy Tarreau <willy@w.ods.org>, Jason Papadopoulos <jasonp@boo.net>,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Message-ID: <20030528003851.GA540@alpha.home.local>
References: <5.2.1.1.2.20030526232835.00a468e0@boo.net> <20030527045302.GA545@alpha.home.local> <20030527134017.B3408@jurassic.park.msu.ru> <20030527123152.GA24849@alpha.home.local> <20030527180403.A2292@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527180403.A2292@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Tue, May 27, 2003 at 06:04:03PM +0400, Ivan Kokshaysky wrote:
> Can you (and Jason) try this patch with CONFIG_IDEDMA_PCI_AUTO=y?

Well, I tried to reboot (blindly, only with a keyboard attached) on the
new kernel, but it behave the same way : "boot -fl 1" (1 is the new kernel)
does a few disk accesses to load the kernel, then hangs, while "0" boots
correctly, so I'm sure my keyboard is correctly plugged and I don't mistype.

Sorry Ivan for such a miserable report, but I couldn't plug either a VT or a
VGA display. I will retry -rc5 (or -rc6) ASAP, but for now I'm going to bed.

Marcelo, the AHA29160 on this system (alpha) spurts lots of debug messages
"blk: queue 0xffff..." at boot with the version in -rc3. Justin pointed me
to drivers/block/ll_rw_blk.c:268 which is responsible for the message. It's
marked as debug, but no KERN_XXX prefix is used. So I think that either
KERN_DEBUG should be added, or the message should simply disappear, since it
sends garbage on the screen which makes SCSI detection a bit hard to read.

Here are two quickly written, completely untested patch proposals.
Please note that this code has not changed since 2.4.20 (which I never tested
on this machine).

Regards,
Willy

######## the most correct one ? ########

--- ./drivers/block/ll_rw_blk.c	Fri May  9 21:33:10 2003
+++ /tmp/ll_rw_blk.c-debug	Wed May 28 02:33:05 2003
@@ -265,7 +265,7 @@
 	 */
 	if (dma_addr != BLK_BOUNCE_HIGH && q != old_q) {
 		old_q = q;
-		printk("blk: queue %p, ", q);
+		printk(KERN_DEBUG "blk: queue %p, ", q);
 		if (dma_addr == BLK_BOUNCE_ANY)
 			printk("no I/O memory limit\n");
 		else


##### this one hides the message. Note that it may lead to a warning
##### with mb defined but not used !

--- ./drivers/block/ll_rw_blk.c	Fri May  9 21:33:10 2003
+++ /tmp/ll_rw_blk.c-nomsg	Wed May 28 02:32:50 2003
@@ -265,12 +265,14 @@
 	 */
 	if (dma_addr != BLK_BOUNCE_HIGH && q != old_q) {
 		old_q = q;
+#ifdef BLK_QUEUE_DEBUG
 		printk("blk: queue %p, ", q);
 		if (dma_addr == BLK_BOUNCE_ANY)
 			printk("no I/O memory limit\n");
 		else
 			printk("I/O limit %luMb (mask 0x%Lx)\n", mb,
 			       (long long) dma_addr);
+#endif
 	}
 
 	q->bounce_pfn = bounce_pfn;


