Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbTL0XSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 18:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTL0XSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 18:18:09 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:34704 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264879AbTL0XSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 18:18:06 -0500
Subject: Problem with dev_kfree_skb_any() in 2.6.0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1072567054.4112.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 28 Dec 2003 10:17:34 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting Ooops reports with sungem. The problem is that in the PM
code (and possibly other exceptional code path), it will clean the rings
at non interrupt time but with a spinlock_irq held.

it uses dev_kfree_skb_any() which does:

static inline void dev_kfree_skb_any(struct sk_buff *skb)
{
        if (in_irq())
                dev_kfree_skb_irq(skb);
        else
                dev_kfree_skb(skb);
}

However, in_irq() seem to only catch real IRQ time, so I end up calling
dev_kfree_skb(), which triggers the following BUG() in local_bh_enable()
        WARN_ON(irqs_disabled());

We should probably fix dev_kfree_skb_any() ? Still ugly imho though...

-        if (in_irq())
+        if (in_irq() || irqs_disabled())


Ben.


