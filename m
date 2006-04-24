Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWDXVW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWDXVW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWDXVW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:22:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38057 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751277AbWDXVW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:22:57 -0400
Date: Mon, 24 Apr 2006 14:22:52 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC 2/2] warn on shared edge-triggered irq
Message-ID: <20060424142252.0a2f235a@localhost.localdomain>
In-Reply-To: <20060424141926.3872f921@localhost.localdomain>
References: <20060424114105.113eecac@localhost.localdomain>
	<Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604241203130.3701@g5.osdl.org>
	<1145908402.3116.63.camel@laptopd505.fenrus.org>
	<20060424201646.GA23517@devserv.devel.redhat.com>
	<1145911417.3116.69.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0604241354200.3701@g5.osdl.org>
	<20060424141926.3872f921@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Put out a warning if setting up shared irq that is edge triggered.
If this happens, interrupts can be lost, but perhaps it is laptop
with unused device, so let it go till later.


--- irq.orig/kernel/irq/manage.c
+++ irq/kernel/irq/manage.c
@@ -234,6 +234,9 @@ int setup_irq(unsigned int irq, struct i
 			desc->handler->startup(irq);
 		else
 			desc->handler->enable(irq);
+	} else if (!(desc->status & IRQ_LEVEL)) {
+		printk(KERN_CRIT "Irq %d (%s) is shared but not level triggered\n",
+		       irq, desc->handler->typename);
 	}
 	spin_unlock_irqrestore(&desc->lock,flags);
 
