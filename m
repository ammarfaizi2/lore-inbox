Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263247AbTIAUAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 16:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTIAUAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 16:00:35 -0400
Received: from ee.oulu.fi ([130.231.61.23]:50361 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263247AbTIAUA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 16:00:27 -0400
Date: Mon, 1 Sep 2003 23:00:22 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: 2.4, b44 transmit timeout
Message-ID: <20030901200022.GA3070@ee.oulu.fi>
References: <20030901193235.GA8280@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20030901193235.GA8280@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 09:32:35PM +0200, Norbert Preining wrote:
> Hi!
> 
> I have the following problem since I switched from bcm4400 to the
> `in-kernel' driver b44:
> Sep  1 17:37:11 gandalf vmunix: b44: eth0: Link is up at 10 Mbps, half duplex.
> Sep  1 17:37:11 gandalf vmunix: b44: eth0: Flow control is off for TX and off for RX.
> Sep  1 17:37:16 gandalf vmunix: NETDEV WATCHDOG: eth0: transmit timed out
> Sep  1 17:37:16 gandalf vmunix: b44: eth0: transmit timed out, resetting
> Sep  1 17:37:17 gandalf vmunix: b44: eth0: Link is down.
> Sep  1 17:37:20 gandalf vmunix: b44: eth0: Link is up at 10 Mbps, half duplex.
> Sep  1 17:37:20 gandalf vmunix: b44: eth0: Flow control is off for TX and off for RX.
> 
> and so on. This didn't (and still does not) happen with the bcm4400
> (from debian sid bcm4400-source).
> 
> I compiled the kernel myself on debian/sid, it is a laptop (acer tm654).
> 
> If you need more information I will provide all I can do.
Argh, I had hoped the driver was BugFree (tm)!

Could you try adding some debug printk's to b44_tx and b44_start_xmit

say something like:

in b44_tx()
     for (cons = bp->tx_cons; cons != cur; cons = NEXT_TX(cons)) {
                struct ring_info *rp = &bp->tx_buffers[cons];
                struct sk_buff *skb = rp->skb;
+		printk(KERN_DEBUG "b44_tx cons: %d cur: %d skb: %p\n",cons,cur,skb);


and in b44_start_xmit something like:

        bp->tx_ring[entry].addr = cpu_to_le32((u32) mapping+bp->dma_offset);
+	printk(KERN_DEBUG "b44_start_xmit ctrl: %x addr: %p entry: %d skb: %p",bp->tx_ring[entry].ctrl,bp->tx_ring[entry].addr,entry,skb);

(that should hopefully be enough to see what's happening)

Also setting B44_FLAG_BUGGY_TXPTR and B44_FLAG_REORDER_BUG in
b44_get_invariants() might be worth a shot. I'm not sure where those 
flags came from, my A7V8X works fine without them and bcm4400 doesn't have
that stuff either.
