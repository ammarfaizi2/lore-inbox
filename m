Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030856AbWI0VKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030856AbWI0VKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030857AbWI0VKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:10:50 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:15987 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030856AbWI0VKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:10:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=YaqKs80IDLsf2O3w3Yh9qPnRP0gJQ0bRO9OyuxC8gkJmSmvZQskjkgI3h/JjCF7JUpFjT65AyVhxIDx1gtchcLyw84THwqrVQUMSEJ0fpDDaKm56YY7mJNkpzkuvOzBY8r6vGDImcbu/h8J1hIxIN27Z5h/GBBqTlfV9RHOS8pI=  ;
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.18] genirq: remove oops with fasteoi irq_chip descriptors
Date: Fri, 22 Sep 2006 06:43:07 -0700
User-Agent: KMail/1.7.1
Cc: tglx@linutronix.de, mingo@redhat.com
References: <200609220641.58938.david-b@pacbell.net>
In-Reply-To: <200609220641.58938.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609220643.07750.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The irq handler code can oops when used with an irq_chip with just
enable/disable/eoi methods, appropriate for handle_fasteoi_irq(),
either by (a) uninstalling, or (b) using it with a chained handler.

The problem was that the original code expected there would always
be mask/unmask/ack methods, and the fix is to instead use methods
which are always present and which more closely correspond to the
flag manipulation being done.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- d26.rc4test.orig/kernel/irq/chip.c	2006-09-21 16:41:11.000000000 -0700
+++ d26.rc4test/kernel/irq/chip.c	2006-09-21 18:04:07.000000000 -0700
@@ -482,10 +482,8 @@ __set_irq_handler(unsigned int irq,
 
 	/* Uninstall? */
 	if (handle == handle_bad_irq) {
-		if (desc->chip != &no_irq_chip) {
-			desc->chip->mask(irq);
-			desc->chip->ack(irq);
-		}
+		if (desc->chip != &no_irq_chip)
+			desc->chip->shutdown(irq);
 		desc->status |= IRQ_DISABLED;
 		desc->depth = 1;
 	}
@@ -495,7 +493,7 @@ __set_irq_handler(unsigned int irq,
 		desc->status &= ~IRQ_DISABLED;
 		desc->status |= IRQ_NOREQUEST | IRQ_NOPROBE;
 		desc->depth = 0;
-		desc->chip->unmask(irq);
+		desc->chip->startup(irq);
 	}
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
