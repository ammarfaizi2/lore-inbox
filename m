Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S129550AbQJEQTi>; Thu, 5 Oct 2000 12:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129500AbQJEQT2>; Thu, 5 Oct 2000 12:19:28 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:23408 "EHLO mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP id <S129134AbQJEQTQ>; Thu, 5 Oct 2000 12:19:16 -0400
Date: Thu, 5 Oct 2000 11:03:50 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Torben Mathiasen <torben@kernel.dk>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tlan timer fix on tytso's list.
In-Reply-To: <20001005172502.A4900@torben>
Message-ID: <Pine.LNX.3.96.1001005110214.19266A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As tigran mentions, you should not explicitly zero static vars.

You need to ask yourself if TLAN will -ever- be used in a hotplug
situation, ie. do you find TLAN hardware on CardBus or PCMCIA cards?

If no, you should:

        s/__devinit/__init/
        s/__devexit/__exit/
 
If yes, you have some small bugs...
 
* tlan_remove_one should be __devexit.  Plain 'ole __exit drops the code
from the static kernel image... which is very bad if you have a hotplug
TLAN which gets removed during the lifetime of the kernel.
 
* return value from pci_module_init and TLan_EisaProbe is never checked.
If you don't care about the return value, just remove 'rc' var.
 
* tlan_init_one is marked __devinit and TLan_probe1 is marked __init.
If you have hotplug devices, and you insert one after booting,
TLan_probe1 has already been dropped from the kernel image.  Oops!
 
* You do not need to memset(,0,) for TLanPrivateInfo.  init_etherdev
does this for you.
 
* if pci_enable_device fails, you do not clean up.  memory leak.
 
* does TLan_EisaProbe work?  It looks like request_region may be called
twice for the same I/O region, once in TLan_EisaProbe, and once in
TLan_Init (via TLan_probe1).
 
* The following change reverts a bugfix!  You should return the
request_irq error return as the current code does:
 
        if ( err ) {
                printk(KERN_ERR "TLAN:  Cannot open %s because IRQ %d is already in use.\n", dev->name, dev->irq );
                MOD_DEC_USE_COUNT;
-               return err;
+               return -EAGAIN;
        }
 
* You should call netif_wake_queue in TLan_tx_timeout, not
netif_start_queue.  (some other net drivers need updating for this, too)
Alarm clock
You have new mail in /var/spool/mail/jgarzik unnecesary change:
mandrakesoft:~$
-void TLan_PhyMonitor( struct net_device *dev )
+void TLan_PhyMonitor( struct net_device *data )
 {
+       struct net_device *dev = (struct net_device *)data;
        TLanPrivateInfo *priv = (TLanPrivateInfo *) dev->priv;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
