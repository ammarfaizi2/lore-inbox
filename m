Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbSJKPhE>; Fri, 11 Oct 2002 11:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262538AbSJKPhE>; Fri, 11 Oct 2002 11:37:04 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:37134 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S262536AbSJKPhB>; Fri, 11 Oct 2002 11:37:01 -0400
Date: Fri, 11 Oct 2002 09:38:57 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: arjanv@redhat.com, axboe@suse.de
Subject: Re: [PATCH] 2.5.41, cciss (3 of 3)
Message-ID: <20021011093857.A1211@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> On Fri, 2002-10-11 at 16:10, Stephen Cameron wrote:
[... a bogus patch involving a 20 second udelay ...]

> ugh 20 seconds udelay....
>
> why can't you sleep here ? [...]

No reason that I can see.  Thanks for pointing it out.
Is this better?  (I also changed the spaces to tabs 
while I was at it.)

-- steve

diff -urN linux-2.5.41/drivers/block/cciss.c linux-2.5.41-20sec/drivers/block/cciss.c
--- linux-2.5.41/drivers/block/cciss.c	Fri Oct 11 09:17:00 2002
+++ linux-2.5.41-20sec/drivers/block/cciss.c	Fri Oct 11 09:07:17 2002
@@ -1297,24 +1297,25 @@
 /*
  *   Wait polling for a command to complete.
  *   The memory mapped FIFO is polled for the completion.
- *   Used only at init time, interrupts disabled.
+ *   Used only at init time, interrupts from the HBA are disabled.
  */
 static unsigned long pollcomplete(int ctlr)
 {
-        unsigned long done;
-        int i;
+	unsigned long done;
+	int i;
+	DECLARE_WAIT_QUEUE_HEAD(polling_wqh);
 
-        /* Wait (up to 2 seconds) for a command to complete */
+	/* Wait (up to 20 seconds) for a command to complete */
 
-        for (i = 200000; i > 0; i--) {
-                done = hba[ctlr]->access.command_completed(hba[ctlr]);
-                if (done == FIFO_EMPTY) {
-                        udelay(10);     /* a short fixed delay */
-                } else
-                        return (done);
-        }
-        /* Invalid address to tell caller we ran out of time */
-        return 1;
+	for (i = 20 * HZ; i > 0; i--) {
+		done = hba[ctlr]->access.command_completed(hba[ctlr]);
+		if (done == FIFO_EMPTY)
+			interruptible_sleep_on_timeout(&polling_wqh, 1);
+		else
+			return (done);
+	}
+	/* Invalid address to tell caller we ran out of time */
+	return 1;
 }
 /*
  * Send a command to the controller, and wait for it to complete.  
