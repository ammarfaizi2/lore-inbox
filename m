Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131104AbQKIOlG>; Thu, 9 Nov 2000 09:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131107AbQKIOk4>; Thu, 9 Nov 2000 09:40:56 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:39429 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S131104AbQKIOks>; Thu, 9 Nov 2000 09:40:48 -0500
Date: Thu, 9 Nov 2000 17:39:20 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: axp-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001109173920.A3205@jurassic.park.msu.ru>
In-Reply-To: <20001101153420.A2823@jurassic.park.msu.ru> <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net> <20001108142513.A5244@jurassic.park.msu.ru> <20001108093744.D27324@twiddle.net> <20001109010336.A1367@jurassic.park.msu.ru> <20001108154811.A28101@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001108154811.A28101@twiddle.net>; from rth@twiddle.net on Wed, Nov 08, 2000 at 03:48:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 03:48:11PM -0800, Richard Henderson wrote:
> Whee!  We're back in Bootsville.

Cool!
Meanwhile this base/limit stuff got confirmation :-)
Here is a patch against bridges-2.4.0t11-rth.

Ivan.

--- 2.4.0t11p1/drivers/pci/setup-bus.c	Wed Nov  8 19:44:42 2000
+++ linux/drivers/pci/setup-bus.c	Thu Nov  9 15:11:01 2000
@@ -88,14 +88,14 @@ pbus_assign_resources_sorted(struct pci_
 	ranges->io_end += io_reserved;
 	ranges->mem_end += mem_reserved;
 
-	/* ??? How to turn off a bus from responding to, say, I/O at
-	   all if there are no I/O ports behind the bus?  Turning off
-	   PCI_COMMAND_IO doesn't seem to do the job.  So we must
-	   allow for at least one unit.  */
-	if (ranges->io_end == ranges->io_start)
-		ranges->io_end += 1;
-	if (ranges->mem_end == ranges->mem_start)
-		ranges->mem_end += 1;
+	/* Interesting case is when, say, io_end == io_start, i.e.
+	   there is no I/O behind the bridge at all. We initialize
+	   the bridge with base=io_start and limit=io_end-1, so
+	   in this case we'll have base > limit. According to
+	   the `PCI-to-PCI Bridge Architecture Specification', this
+	   means that the bridge will not forward any I/O transactions
+	   from the primary bus to the secondary bus and will forward
+	   all I/O transactions upstream. Exactly what we want.  */
 
 	ranges->io_end = ROUND_UP(ranges->io_end, 4*1024);
 	ranges->mem_end = ROUND_UP(ranges->mem_end, 1024*1024);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
