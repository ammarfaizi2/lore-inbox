Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263159AbTCLNjY>; Wed, 12 Mar 2003 08:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263177AbTCLNjY>; Wed, 12 Mar 2003 08:39:24 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:14603 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263159AbTCLNjX>; Wed, 12 Mar 2003 08:39:23 -0500
Message-Id: <200303121340.h2CDe3u30029@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "David Shirley" <dave@cs.curtin.edu.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Help, eth0: transmit timed out!
Date: Wed, 12 Mar 2003 15:37:08 +0200
X-Mailer: KMail [version 1.3.2]
References: <041b01c2e86a$870822f0$64070786@synack>
In-Reply-To: <041b01c2e86a$870822f0$64070786@synack>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 March 2003 07:23, David Shirley wrote:
> Hi All,
>
> Just installed Redhat 7.3 on an Athlon 2000 system (2.4.20).
>
> We have a 3c905c network card, and when I try copying files from an
> nfs mount I get this in the logs:
>
Mar 12 13:15:11 ark kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar 12 13:15:11 ark kernel: eth0: transmit timed out, tx_status 00 status e000.
Mar 12 13:15:11 ark kernel:   diagnostics: net 0cc6 media 8880 dma 000000a0.
Mar 12 13:15:11 ark kernel:   Flags; bus-master 1, dirty 4048(0) current 4064(0)
Mar 12 13:15:11 ark kernel:   Transmit list fffffff8 vs. f7ea9200.
Mar 12 13:15:11 ark kernel:   0: @f7ea9200  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   1: @f7ea9240  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   2: @f7ea9280  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   3: @f7ea92c0  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   4: @f7ea9300  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   5: @f7ea9340  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   6: @f7ea9380  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   7: @f7ea93c0  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   8: @f7ea9400  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   9: @f7ea9440  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   10: @f7ea9480  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   11: @f7ea94c0  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   12: @f7ea9500  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   13: @f7ea9540  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   14: @f7ea9580  length 800000b6 status 800000b6
Mar 12 13:15:11 ark kernel:   15: @f7ea95c0  length 800000b6 status 800000b6
Mar 12 13:15:11 ark kernel: eth0: Resetting the Tx ring pointer.
>
> Usually the machine freezes up after this, and I can't ping it,

Drivers tend to be less stable that core kernel. Maybe there's
a bug in 3c59x.c network card driver. You may read the code
and start putting some printks there, especially in error
paths.

Say, "Resetting the Tx ring pointer" comes from
vortex_tx_timeout(struct net_device *dev), and looking at that code
you may notice that resetting is done without disabling interrupts.
I know nil about low-level network driver stuff, but

                printk(KERN_DEBUG "%s: Resetting the Tx ring pointer.\n", dev->name);
                if (vp->cur_tx - vp->dirty_tx > 0  &&  inl(ioaddr + DownListPtr) == 0)
                        outl(vp->tx_ring_dma + (vp->dirty_tx % TX_RING_SIZE) * sizeof(struct boom_tx_desc),
                                 ioaddr + DownListPtr);
                if (vp->cur_tx - vp->dirty_tx < TX_RING_SIZE)
===>                    netif_wake_queue (dev);
                if (vp->drv_flags & IS_BOOMERANG)
                        outb(PKT_BUF_SZ>>8, ioaddr + TxFreeThreshold);
                outw(DownUnstall, ioaddr + EL3_CMD);

looks a bit strange. I'd move netif_wake_queue() below the out()s
and encased out()s in IRQ disabled region.

Or some such.

Whee, this module can talk a lot, see:
MODULE_PARM_DESC(debug, "3c59x debug level (0-6)");

;)
--
vda
