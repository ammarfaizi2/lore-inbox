Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbTISTxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbTISTwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:52:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:33674 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261697AbTISTs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:48:56 -0400
Date: Fri, 19 Sep 2003 12:48:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 4/13] use cpu_relax() in busy loop
Message-ID: <20030919124845.A27079@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net> <20030918162748.F16499@osdlab.pdx.osdl.net> <20030918162930.G16499@osdlab.pdx.osdl.net> <20030918163156.H16499@osdlab.pdx.osdl.net> <1063956884.5394.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1063956884.5394.3.camel@laptop.fenrus.com>; from arjanv@redhat.com on Fri, Sep 19, 2003 at 09:34:44AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjanv@redhat.com) wrote:
> 
> mdelay ?

Yeah, good point.  For these subsecond pauses mdelay() makes more sense.
It'd be nice to get rid of long busy loops in general.  Thanks for taking
a look.

-chris

[PATCH 4/13] use mdelay() instead of busy loop

Replace busy loop with mdelay().

===== drivers/cdrom/sonycd535.c 1.39 vs edited =====
--- 1.39/drivers/cdrom/sonycd535.c	Tue Sep  9 07:41:30 2003
+++ edited/drivers/cdrom/sonycd535.c	Fri Sep 19 10:36:18 2003
@@ -129,6 +129,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #define REALLY_SLOW_IO
 #include <asm/system.h>
@@ -1520,13 +1521,12 @@
 
 	/* A negative sony535_irq_used will attempt an autoirq. */
 	if (sony535_irq_used < 0) {
-		unsigned long irq_mask, delay;
+		unsigned long irq_mask;
 
 		irq_mask = probe_irq_on();
 		enable_interrupts();
 		outb(0, read_status_reg);	/* does a reset? */
-		delay = jiffies + HZ/10;
-		while (time_before(jiffies, delay)) ;
+		mdelay(100);
 
 		sony535_irq_used = probe_irq_off(irq_mask);
 		disable_interrupts();

