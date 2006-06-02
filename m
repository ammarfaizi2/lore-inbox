Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWFBVXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWFBVXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWFBVXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:23:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:32417 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030293AbWFBVXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:23:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:from:x-x-sender:to:cc:subject:message-id:references:mime-version:content-type;
        b=qDAPfoaGMFFYSTiLDhJTkkeg6TMAhgFoSRSS7Az+MNyD/zUrnw9HB9kXfA9ZVIxJrgcclZQGL98tWWgO2xPjjS0d3ayZgM+BIUcrsOLCDutn310e63zLSv0SVyXsbAUacSEoo4h/HvC+vTHfNLH2SCpXPVE4wsY9HnB191sIkig=
Date: Fri, 2 Jun 2006 23:23:52 +0100 (BST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@localhost
To: linux-kernel@vger.kernel.org
cc: Ingo Molnar <mingo@elte.hu>
Subject: [patch 5/5] [PREEMPT_RT] Changing interrupt handlers from running
 in thread to hardirq and back runtime.
Message-ID: <Pine.LNX.4.64.0606022322230.9307@localhost>
References: <20060602165336.147812000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make lpptest more compliant with the request_irq() interface. I don't think
the driver should set or remove flags on it's own!

Index: linux-2.6.16-rt23.spin_mutex/drivers/char/lpptest.c
===================================================================
--- linux-2.6.16-rt23.spin_mutex.orig/drivers/char/lpptest.c
+++ linux-2.6.16-rt23.spin_mutex/drivers/char/lpptest.c
@@ -150,13 +150,13 @@ static int __init lpptest_init (void)
  		return -EAGAIN;
  	}

-	if (request_irq (LPPTEST_IRQ, lpptest_irq, 0, "lpptest", dev_id)) {
-		printk (KERN_WARNING "lpptest: irq %d in use. Unload parport module!\n", LPPTEST_IRQ);
+	if (request_irq (LPPTEST_IRQ, lpptest_irq, SA_NODELAY | SA_INTERRUPT,
+			 "lpptest", dev_id)) {
+		printk (KERN_WARNING "lpptest: irq %d in use. "
+			"Unload parport module!\n", LPPTEST_IRQ);
  		unregister_chrdev(LPPTEST_CHAR_MAJOR, LPPTEST_DEVICE_NAME);
  		return -EAGAIN;
  	}
-	irq_desc[LPPTEST_IRQ].status |= IRQ_NODELAY;
-	irq_desc[LPPTEST_IRQ].action->flags |= SA_NODELAY | SA_INTERRUPT;

  	INIT_PORT();
  	ENABLE_IRQ();

--
