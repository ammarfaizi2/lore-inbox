Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262267AbSI1RBN>; Sat, 28 Sep 2002 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262251AbSI1RBM>; Sat, 28 Sep 2002 13:01:12 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:9
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262267AbSI1RBK>; Sat, 28 Sep 2002 13:01:10 -0400
Subject: Re: Sleeping function called from illegal context...
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, Andrew Morton <akpm@digeo.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1033207583.17777.28.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.10.10209272013370.13669-100000@master.linux-ide.org>
	 <1033207583.17777.28.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1033232764.23958.80.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 28 Sep 2002 13:06:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-28 at 06:06, Alan Cox wrote:

> Reminds me though Robert (and Jeff)
> 
> drivers/net/8390.c still needs ei_start_xmit fixing
> 
> pre-emption should be disabled between
> 
>        /* Mask interrupts from the ethercard.
>            SMP: We have to grab the lock here otherwise the IRQ handler
> 
> and
>        disable_irq_nosync(dev->irq);
> 
>         spin_lock(&ei_local->page_lock);

Sounds reasonable enough.  What about the attached patch?  If we flip
the order of the disable_irq and spin_lock, we do not need to actually
explicitly disable preemption... the lock will do that for us.

Is this safe?

This also has the general benefit of not spinning on the lock with the
irq disabled (same sort of downside has preempting with the irq
disabled).

	Robert Love

diff -urN linux-2.5.39/drivers/net/8390.c linux/drivers/net/8390.c
--- linux-2.5.39/drivers/net/8390.c	Fri Sep 27 17:49:05 2002
+++ linux/drivers/net/8390.c	Sat Sep 28 13:02:47 2002
@@ -243,9 +243,9 @@
 	}
 
 	/* Ugly but a reset can be slow, yet must be protected */
-		
-	disable_irq_nosync(dev->irq);
+
 	spin_lock(&ei_local->page_lock);
+	disable_irq_nosync(dev->irq);
 		
 	/* Try to restart the card.  Perhaps the user has fixed something. */
 	ei_reset_8390(dev);
@@ -286,10 +286,9 @@
 	/*
 	 *	Slow phase with lock held.
 	 */
-	 
-	disable_irq_nosync(dev->irq);
-	
+
 	spin_lock(&ei_local->page_lock);
+	disable_irq_nosync(dev->irq);
 	
 	ei_local->irqlock = 1;
 



