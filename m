Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWEaO3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWEaO3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 10:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWEaO3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 10:29:14 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:11938 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S965032AbWEaO3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 10:29:13 -0400
Subject: Re: 2.6.17-rc5-mm1 - output of lock validator
From: Arjan van de Ven <arjan@linux.intel.com>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060531181926.51c4f4c5.pauldrynoff@gmail.com>
References: <20060530195417.e870b305.pauldrynoff@gmail.com>
	 <20060530132540.a2c98244.akpm@osdl.org>
	 <20060531181926.51c4f4c5.pauldrynoff@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 31 May 2006 16:28:59 +0200
Message-Id: <1149085739.3114.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 18:19 +0400, Paul Drynoff wrote:
> On Tue, 30 May 2006 13:25:40 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Tue, 30 May 2006 19:54:17 +0400
> > Paul Drynoff <pauldrynoff@gmail.com> wrote:
> > 
> > > During boot 2.6.17-rc5-mm1 I got such message:
> > > Uncompressing Linux... Ok, booting kernel.
> > > 
> > > And that's all, 2.6.17-rc5 booted successfully.
> > 
> > I'm not able to reproduce this with your .config.  Perhaps you could
> > disable kgdb, enable CONFIG_EARLY_PRINTK and boot with earlyprintk=vga (or,
> > better, earlyprintk=serial[,ttySn[,baudrate]]).
> > 
> > (you can get a nicer backtrace out gdb by simply using `bt', btw)
> 
> Thanks, `bt' help, the problem was "kgbd", I switch off it and all works fine now.
> 
> Here is output of "lock validator":
> 
> Linux version 2.6.17-rc5-mm1
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBTYPES:    8
> ... MAX_LOCK_DEPTH:          30
> ... MAX_LOCKDEP_KEYS:        2048
> ... TYPEHASH_SIZE:           1024
> ... MAX_LOCKDEP_ENTRIES:     8192
> ... MAX_LOCKDEP_CHAINS:      8192
> ... CHAINHASH_SIZE:          4096
>  memory used by lock dependency info: 696 kB
>  per task-struct memory footprint: 1080 bytes
> -------------------------------------------------------
> Good, all 210 testcases passed! |
> ---------------------------------
> 
> ============================
> [ BUG: illegal lock usage! ]
> ----------------------------
> illegal {hardirq-on-W} -> {in-hardirq-W} usage.
> dhclient/2176 [HC1[1]:SC0[1]:HE0:SE0] takes:
>  (&ei_local->page_lock){+...}, at: [<c035b822>] ei_interrupt+0x4a/0x2b4

does this fix it?

Make the ne2000 drivers use irqsave, they already disabled interrupts
generally so it is semi redundant, but it'll help the lock validator at
least...
(potential downside: the old code let the timer irq at least happen;
but... this is all really yukky code in the first place, someone
needs to modernize this at some point)
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 drivers/net/8390.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.17-rc5-mm1.5/drivers/net/8390.c
===================================================================
--- linux-2.6.17-rc5-mm1.5.orig/drivers/net/8390.c
+++ linux-2.6.17-rc5-mm1.5/drivers/net/8390.c
@@ -299,7 +299,7 @@ static int ei_start_xmit(struct sk_buff 
 	 
 	disable_irq_nosync(dev->irq);
 	
-	spin_lock(&ei_local->page_lock);
+	spin_lock_irqsave(&ei_local->page_lock, flags);
 	
 	ei_local->irqlock = 1;
 
@@ -335,7 +335,7 @@ static int ei_start_xmit(struct sk_buff 
 		ei_local->irqlock = 0;
 		netif_stop_queue(dev);
 		outb_p(ENISR_ALL, e8390_base + EN0_IMR);
-		spin_unlock(&ei_local->page_lock);
+		spin_unlock_irqrestore(&ei_local->page_lock, flags);
 		enable_irq(dev->irq);
 		ei_local->stat.tx_errors++;
 		return 1;
@@ -376,7 +376,7 @@ static int ei_start_xmit(struct sk_buff 
 	ei_local->irqlock = 0;
 	outb_p(ENISR_ALL, e8390_base + EN0_IMR);
 	
-	spin_unlock(&ei_local->page_lock);
+	spin_unlock_irqrestore(&ei_local->page_lock, flags);
 	enable_irq(dev->irq);
 
 	dev_kfree_skb (skb);

