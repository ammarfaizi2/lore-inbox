Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311594AbSCTOb0>; Wed, 20 Mar 2002 09:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311593AbSCTObQ>; Wed, 20 Mar 2002 09:31:16 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:39870 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S292385AbSCTObE>; Wed, 20 Mar 2002 09:31:04 -0500
Date: Wed, 20 Mar 2002 15:01:12 +0100
From: Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>
Message-Id: <200203201401.g2KE1Cs00998@orion.steiner.local>
To: garloff@suse.de, Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>
Cc: linux-kernel@vger.kernel.org, Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: SCSI-Problem with AM53C974
In-Reply-To: <20020318123038.B19273@gum01m.etpnet.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.dev.kernel, Kurt Garloff wrote:

>Can you try the attached patch please? Patch is against 2.4.18.
>
>It makes the AM53C974 driver register its IO-space and will make detection
>fail, if there are no adapters found with available IO-space.
>
>The tmscsim driver (which I maintain) does already register its IO space
>correctly, so this patch should make sure that not both of them try to drive
>the same piece of hardware.
>
>Please report back, whether it works, so I can ask Marcelo to include it.

OK, I found a littler bug in it, that's why on my first try it didn't
work. There was a "!" missing in the if statement whether the region is
free. So the driver failed if the region was free and succeeded if it was
busy.

But now it seems to work well, so including it in the kernel would be
great.

CU
Marion Steiner



Here the corrected patch:

--- linux-2.4.18.ipt_fixes2.ix86/drivers/scsi/AM53C974.c.orig   Sun Sep 30 21:26:07 2001
+++ linux-2.4.18.ipt_fixes2.ix86/drivers/scsi/AM53C974.c        Mon Mar 18 11:59:31 2002
@@ -732,6 +732,12 @@
        hostdata->disconnecting = 0;
        hostdata->dma_busy = 0;
 
+       if (!request_region (instance->io_port, 128, "AM53C974")) {
+               printk ("AM53C974 (scsi%d): Could not get IO region %04lx. Detaching ...\n",
+                       instance->host_no, instance->io_port);
+               scsi_unregister(instance);
+               return 0;
+       }
 /* Set up an interrupt handler if we aren't already sharing an IRQ
with another board */
        for (search = first_host;
             search && (((the_template != NULL) && (search->hostt !=
the_template)) ||
@@ -2441,6 +2447,7 @@
 static int AM53C974_release(struct Scsi_Host *shp)
 {
        free_irq(shp->irq, shp);
+       release_region(shp->io_port, 128);
        scsi_unregister(shp);
        return 0;
 }
 
