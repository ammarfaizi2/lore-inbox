Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270629AbTGURfR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270627AbTGURfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:35:16 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:36869 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S270630AbTGURdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:33:38 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Javier Achirica <achirica@telefonica.net>
Subject: Re: [PATCH 2.5] fixes for airo.c
Date: Mon, 21 Jul 2003 19:49:29 +0200
User-Agent: KMail/1.5.2
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Mike Kershaw <dragorn@melchior.nerv-un.net>
References: <Pine.SOL.4.30.0307211252190.25549-100000@tudela.mad.ttd.net>
In-Reply-To: <Pine.SOL.4.30.0307211252190.25549-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307211949.30513.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon July 21 2003 13:00, Javier Achirica wrote:
> 
> Daniel,
> 
> Thank you for your patch. Some comments about it:
> 
> - I'd rather fix whatever is broken in the current code than going back to
> spinlocks, as they increase latency and reduce concurrency. In any case,
> please check your code. I've seen a spinlock in the interrupt handler that
> may lock the system.

but we need to protect from interrupts while accessing the card and waiting for
completion. semaphores don't protect you from that. spin_lock_irqsave does. the
spin_lock in the interrupt handler is there to protect from interrupts from
other processors in a SMP system (see Documentation/spinlocks.txt) and is btw.
a no-op on UP. and semaphores are quite heavy....

> - The fix for the transmit code you mention, is about fixing the returned
> value in case of error? If not, please explain it to me as I don't see any
> other changes.

fixes:
- return values
- when to free the skb, when not
- disabling the queues
- netif_wake_queue called from the interrupt handler only (and on the right
  net_device)
- i think the priv->xmit stuff and then the schedule_work is evil:
  if you return 0 from the dev->hard_start_xmit then the network layer assumes
  that the packet was kfree_skb()'ed (which does only frees the packet when the
  refcount drops to zero.) this is the cause for the keventd killing, for sure!

  if you return 0 you already kfree_skb()'ed the packet. and that's it.  


> - Where did you fix a buffer overflow?

-       for(s = &statr->beaconPeriod; s <= &statr->_reserved[9]; s++)
+       for(s = &statr->beaconPeriod; s <= &statr->_reserved1; s++)

...which you also fixed in your patchset. (which is harmless on little-endian
machines and evil on big-endian machines)


rgds
-daniel

> 
> I submitted to Jeff an updated version just before you sent your e-mail.
> It incorporates most of your fixes expect for the possible loop-forever.
> It's more stable that the one in the current kernel tree.
> 
> Javier Achirica
> 
> On Fri, 18 Jul 2003, Daniel Ritz wrote:
> 
> > in 2.4.20+ airo.c is broken and can even kill keventd. this patch fixes it:
> > - sane locking with spinlocks and irqs disabled instead of the buggy locking
> >   with semaphores
> > - fix transmit code
> > - safer unload ordering of disable irq, unregister_netdev, kfree
> > - fix possible loop-forever bug
> > - fix a buffer overflow
> >
> > a kernel 2.4 version of the patch is tested by some people with good results.
> > against 2.6.0-test1-bk. please apply.
> >
> >
> > rgds
> > -daniel
> 
> 

