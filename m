Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbUBJBxt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 20:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUBJBxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 20:53:49 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:1665 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S265476AbUBJBxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 20:53:46 -0500
Subject: Re: oops in old isdn4linux and 2.6.2-rc3 (was in -rc2 too)
From: David Woodhouse <dwmw2@infradead.org>
To: Karsten Keil <kkeil@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1076328820.11882.27.camel@imladris.demon.co.uk>
References: <401E4A80.4050907@web.de>
	 <20040202195139.GB2534@pingi3.kke.suse.de>
	 <1076328820.11882.27.camel@imladris.demon.co.uk>
Content-Type: text/plain
Message-Id: <1076378022.11882.80.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Tue, 10 Feb 2004 01:53:42 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-09 at 12:13 +0000, David Woodhouse wrote:
> Dies horribly upon an incoming v.110 call though...

> NMI Watchdog detected LOCKUP on CPU1, eip f8a5cd65, registers:
> CPU:    1
> EIP:    0060:[<f8a5cd65>]    Not tainted
> EFLAGS: 00000086
> EIP is at .text.lock.hfc_pci+0xfb/0x186 [hisax]

This is line 1391 of hfc_pci.c, in hfcpci_l2l1().
It's trying to relock &bcs->cs->lock which is evidently already locked.

This is because isdn_v110_stat_callback() is being called with the
spinlock held when we've transmitted a skb... and it's trying to
transmit another immediately.

> eax: f6531000   ebx: 00000120   ecx: 00000000   edx: f6288a40
> esi: f6531614   edi: f652ac00   ebp: f6288a40   esp: f7f81b40
> ds: 007b   es: 007b   ss: 0068
> Process events/1 (pid: 7, threadinfo=f7f80000 task=f7f94ce0)
> Stack: f6288800 00000028 c0224fea 00000097 f6531210 f652ac00 00000028 f6288800
>        f8a533e6 f652ac00 00000120 f6288a40 0000003c 00000020 f75b7810 f6d52000
>        f6288800 00000000 00000001 f89fb58f 00000000 00000001 00000001 f6288800
> Call Trace:
	<hfcpci_l2l1>
>  [<f8a533e6>] HiSax_writebuf_skb+0x156/0x230 [hisax]
>  [<f89fb58f>] isdn_v110_stat_callback+0x2bf/0x330 [isdn]
>  [<f89fc57e>] isdn_status_callback+0x76e/0x8e0 [isdn]
>  [<f89fc09c>] isdn_status_callback+0x28c/0x8e0 [isdn]
>  [<f8a52231>] ll_writewakeup+0x61/0xa0 [hisax]
>  [<f8a5af40>] hfcpci_fill_fifo+0x4e0/0x6a0 [hisax]
>  [<f8a5c2d2>] hfcpci_send_data+0x22/0x50 [hisax]
>  [<f8a5c5d5>] hfcpci_l2l1+0xa5/0x200 [hisax]
>  [<f8a533e6>] HiSax_writebuf_skb+0x156/0x230 [hisax]
>  [<f89fb3dc>] isdn_v110_stat_callback+0x10c/0x330 [isdn]
>  [<f89fc109>] isdn_status_callback+0x2f9/0x8e0 [isdn]

I'm going to try an _evil_ hack like this...

--- drivers/isdn/hisax/hfc_pci.c.orig	2004-02-10 01:49:49.278608994 +0000
+++ drivers/isdn/hisax/hfc_pci.c	2004-02-10 01:50:15.404811276 +0000
@@ -597,7 +597,7 @@
 	u_char new_f1, *src, *dst;
 	unsigned short *z1t, *z2t;
 
-	if (!bcs->tx_skb)
+	if (!bcs->tx_skb && !(bcs->tx_skb = skb_dequeue(&bcs->squeue)))
 		return;
 	if (bcs->tx_skb->len <= 0)
 		return;
@@ -1388,7 +1388,13 @@
 
 	switch (pr) {
 		case (PH_DATA | REQUEST):
-			spin_lock_irqsave(&bcs->cs->lock, flags);
+			local_irq_save(flags);
+			if (!spin_trylock(&bcs->cs->lock)) {
+				/* Possible recursion. Queue it and return */
+				local_irq_restore(flags);
+				skb_queue_tail(&bcs->squeue, skb);
+				break;
+			}
 			if (bcs->tx_skb) {
 				skb_queue_tail(&bcs->squeue, skb);
 			} else {


-- 
dwmw2


