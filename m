Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135597AbRAVXb5>; Mon, 22 Jan 2001 18:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130615AbRAVXbr>; Mon, 22 Jan 2001 18:31:47 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:20049
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131022AbRAVXbe>; Mon, 22 Jan 2001 18:31:34 -0500
Date: Tue, 23 Jan 2001 00:31:27 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/aha1740.c: check request_region return code (241p9)
Message-ID: <20010123003127.G602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(I have not been able to determine a probable maintainer for this
code.)

The following patch makes drivers/scsi/aha1740.c use the return
code of request_region instead of check_region. The change
necessitated some changes to the folllowing error paths so I
changed those to be forwards gotos.

It applies cleanly against ac10 and 241p9.

Comments?


--- linux-ac10-clean/drivers/scsi/aha1740.c	Sun Nov 12 04:01:11 2000
+++ linux-ac10/drivers/scsi/aha1740.c	Sun Jan 21 23:35:39 2001
@@ -521,10 +521,10 @@
 	 * check/allocate region code, but this may change at some point,
 	 * so we go through the motions.
 	 */
-	if (check_region(slotbase, SLOTSIZE))  /* See if in use */
+	if (!request_region(slotbase, SLOTSIZE, "aha1740"))  /* See if in use */
 	    continue;
 	if (!aha1740_test_port(slotbase))
-	    continue;
+	    goto err_release;
 	aha1740_getconfig(slotbase,&irq_level,&translation);
 	if ((inb(G2STAT(slotbase)) &
 	     (G2STAT_MBXOUT|G2STAT_BUSY)) != G2STAT_MBXOUT)
@@ -538,15 +538,12 @@
 	DEB(printk("aha1740_detect: enable interrupt channel %d\n",irq_level));
 	if (request_irq(irq_level,aha1740_intr_handle,0,"aha1740",NULL)) {
 	    printk("Unable to allocate IRQ for adaptec controller.\n");
-	    continue;
+	    goto err_release;
 	}
 	shpnt = scsi_register(tpnt, sizeof(struct aha1740_hostdata));
 	if(shpnt == NULL)
-	{
-		free_irq(irq_level, NULL);
-		continue;
-	}
-	request_region(slotbase, SLOTSIZE, "aha1740");
+		goto err_free_irq;
+
 	shpnt->base = 0;
 	shpnt->io_port = slotbase;
 	shpnt->n_io_port = SLOTSIZE;
@@ -557,6 +554,12 @@
 	host->translation = translation;
 	aha_host[irq_level - 9] = shpnt;
 	count++;
+	continue;
+
+    err_free_irq:
+	free_irq(irq_level, NULL);
+    err_release:
+	release_region(slotbase, SLOTSIZE);
     }
     return count;
 }

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

We're going to turn this team around 360 degrees.
-Jason Kidd, upon his drafting to the Dallas Mavericks
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
