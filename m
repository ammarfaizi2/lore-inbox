Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130881AbQKHJkY>; Wed, 8 Nov 2000 04:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbQKHJkP>; Wed, 8 Nov 2000 04:40:15 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:61958 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S130881AbQKHJkJ>; Wed, 8 Nov 2000 04:40:09 -0500
Date: Wed, 8 Nov 2000 01:39:31 -0800
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: axp-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001108013931.A26972@twiddle.net>
In-Reply-To: <20001101153420.A2823@jurassic.park.msu.ru> <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001106192930.A837@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii

[ For l-k, the issue is that pci-pci bridges and the devices behind
  them are not initialized properly.  There are a number of Alphas
  whose built-in scsi controlers are behind such a bridge preventing
  these machines from booting at all.  Ivan provided an initial 
  patch to solve this issue.  ]

I've not gotten a chance to try this on the rawhide yet,
but I did give it a whirl on my up1000, which does have
an agp bridge that acts like a pci bridge.

Notable changes from your patch:

  * Use kmalloc, not vmalloc.  (ouch!)
  * Replace cropped found_vga detection code.
  * Handle bridges with empty I/O (or MEM) ranges.
  * Collect the proper width of the bus range.


r~

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Description: diff vs bridges-2.4.0t10
Content-Disposition: attachment; filename=y

diff -rup linux/drivers/pci/setup-bus.c 2.4.0-11-1/drivers/pci/setup-bus.c
--- linux/drivers/pci/setup-bus.c	Wed Nov  8 01:24:16 2000
+++ 2.4.0-11-1/drivers/pci/setup-bus.c	Wed Nov  8 01:04:17 2000
@@ -20,7 +20,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/cache.h>
-#include <linux/vmalloc.h>
+#include <linux/slab.h>
 
 
 #define DEBUG_CONFIG 1
@@ -56,31 +56,50 @@ pbus_assign_resources_sorted(struct pci_
 			mem_reserved += 32*1024*1024;
 			continue;
 		}
+
+		if (dev->class >> 8 == PCI_CLASS_DISPLAY_VGA)
+			found_vga = 1;
+
 		pdev_sort_resources(dev, &head_io, IORESOURCE_IO);
 		pdev_sort_resources(dev, &head_mem, IORESOURCE_MEM);
 	}
+
 	for (list = head_io.next; list;) {
 		res = list->res;
 		idx = res - &list->dev->resource[0];
-		if (pci_assign_resource(list->dev, idx) == 0)
+		if (pci_assign_resource(list->dev, idx) == 0
+		    && ranges->io_end < res->end)
 			ranges->io_end = res->end;
 		tmp = list;
 		list = list->next;
-		vfree(tmp);
+		kfree(tmp);
 	}
 	for (list = head_mem.next; list;) {
 		res = list->res;
 		idx = res - &list->dev->resource[0];
-		if (pci_assign_resource(list->dev, idx) == 0)
+		if (pci_assign_resource(list->dev, idx) == 0
+		    && ranges->mem_end < res->end)
 			ranges->mem_end = res->end;
 		tmp = list;
 		list = list->next;
-		vfree(tmp);
+		kfree(tmp);
 	}
+
 	ranges->io_end += io_reserved;
 	ranges->mem_end += mem_reserved;
+
+	/* ??? How to turn off a bus from responding to, say, I/O at
+	   all if there are no I/O ports behind the bus?  Turning off
+	   PCI_COMMAND_IO doesn't seem to do the job.  So we must
+	   allow for at least one unit.  */
+	if (ranges->io_end == ranges->io_start)
+		ranges->io_end += 1;
+	if (ranges->mem_end == ranges->mem_start)
+		ranges->mem_end += 1;
+
 	ranges->io_end = ROUND_UP(ranges->io_end, 4*1024);
 	ranges->mem_end = ROUND_UP(ranges->mem_end, 1024*1024);
+
 	return found_vga;
 }
 
diff -rup linux/drivers/pci/setup-res.c 2.4.0-11-1/drivers/pci/setup-res.c
--- linux/drivers/pci/setup-res.c	Wed Nov  8 01:24:16 2000
+++ 2.4.0-11-1/drivers/pci/setup-res.c	Wed Nov  8 00:21:13 2000
@@ -22,10 +22,10 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/cache.h>
-#include <linux/vmalloc.h>
+#include <linux/slab.h>
 
 
-#define DEBUG_CONFIG 0
+#define DEBUG_CONFIG 1
 #if DEBUG_CONFIG
 # define DBGC(args)     printk args
 #else
@@ -146,7 +146,7 @@ pdev_sort_resources(struct pci_dev *dev,
 			if (ln)
 				size = ln->res->end - ln->res->start;
 			if (r->end - r->start > size) {
-				tmp = vmalloc(sizeof(*tmp));
+				tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
 				tmp->next = ln;
 				tmp->res = r;
 				tmp->dev = dev;

--azLHFNyN32YCQGCU
Content-Type: application/octet-stream
Content-Description: diff vs test11-1
Content-Disposition: attachment; filename="bridges-2.4.0t11-rth.gz"
Content-Transfer-Encoding: base64

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
Uw5+ybn/F0+J7UG4ZgAA

--azLHFNyN32YCQGCU--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
