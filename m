Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSGCUMt>; Wed, 3 Jul 2002 16:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSGCUMs>; Wed, 3 Jul 2002 16:12:48 -0400
Received: from mako.theneteffect.com ([63.97.58.10]:30994 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S317091AbSGCUMr>; Wed, 3 Jul 2002 16:12:47 -0400
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200207032015.PAA23765@mako.theneteffect.com>
Subject: Re: eth0: memory shortage
To: Teodor.Iacob@astral.kappa.ro (Teodor Iacob)
Date: Wed, 3 Jul 2002 15:15:12 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020703190931.GA13103@linux.kappa.ro> from "Teodor Iacob" at Jul 03, 2002 10:09:31 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I keep getting these messages (like about twice a day) in the messages:
> eth0: memory shortage
> eth0: memory shortage
> eth1: memory shortage
> eth1: memory shortage
> 
> 
> Any idea what could be the reason behind this?

Well this message is coming from drivers/net/3c59x.c in a bit of code that
goes:

/* Refill the Rx ring buffers. */
        for (; vp->cur_rx - vp->dirty_rx > 0; vp->dirty_rx++) {
                struct sk_buff *skb;
                entry = vp->dirty_rx % RX_RING_SIZE;
                if (vp->rx_skbuff[entry] == NULL) {
                        skb = dev_alloc_skb(PKT_BUF_SZ);
                        if (skb == NULL) {
                                static unsigned long last_jif;
                                if ((jiffies - last_jif) > 10 * HZ) {
                                        printk(KERN_WARNING "%s: memory shortage
\n", dev->name);
                                        last_jif = jiffies;
                                }
                                if ((vp->cur_rx - vp->dirty_rx) == RX_RING_SIZE)
                                        mod_timer(&vp->rx_oom_timer, RUN_AT(HZ *
 1));
                                break;                  /* Bad news!  */
                        }


So basically it looks like it is taking much longer to refill rx ring buffers
than it should.

On past 2.4 kernels I recall the eepro100 would report a message of "out
of resources" and the fix suggested there was to increase the values in
/proc/sys/vm/freepages.  Perhaps it's a similar issue with the 3c59x ??

Perhaps one of the guru's could comment?

	M
