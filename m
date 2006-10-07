Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWJGFGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWJGFGU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWJGFGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:06:19 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:48321 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751700AbWJGFGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:06:19 -0400
Subject: Re: [PATCH 3/9] sound/oss/msnd_pinnacle.c: ioremap balanced with
	iounmap
From: Amol Lad <amol@verismonetworks.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061006160324.142ccebf.akpm@osdl.org>
References: <1160113137.19143.140.camel@amol.verismonetworks.com>
	 <20061006160324.142ccebf.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 10:39:37 +0530
Message-Id: <1160197777.19143.157.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 16:03 -0700, Andrew Morton wrote:
> On Fri, 06 Oct 2006 11:08:57 +0530
> Amol Lad <amol@verismonetworks.com> wrote:
> 
> >  msnd_pinnacle.c |   10 ++++++++++
> 
> This driver fails to check that ioremap() actually succeeded.  Hence with
> this patch we can end up doing iounmap(NULL).
> 
Is this better ?

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 msnd_pinnacle.c |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/sound/oss/msnd_pinnacle.c linux-2.6.19-rc1/sound/oss/msnd_pinnacle.c
--- linux-2.6.19-rc1-orig/sound/oss/msnd_pinnacle.c	2006-09-21 10:15:52.000000000 +0530
+++ linux-2.6.19-rc1/sound/oss/msnd_pinnacle.c	2006-10-07 10:28:31.000000000 +0530
@@ -1441,6 +1441,10 @@ static int __init attach_multisound(void
 
 static void __exit unload_multisound(void)
 {
+	if (dev.base) {
+		iounmap(dev.base);
+		dev.base = NULL;
+	}
 	release_region(dev.io, dev.numio);
 	free_irq(dev.irq, &dev);
 	unregister_sound_mixer(dev.mixer_minor);
@@ -1884,30 +1888,38 @@ static int __init msnd_init(void)
 	printk(KERN_INFO LOGNAME ": %u byte audio FIFOs (x2)\n", dev.fifosize);
 	if ((err = msnd_fifo_alloc(&dev.DAPF, dev.fifosize)) < 0) {
 		printk(KERN_ERR LOGNAME ": Couldn't allocate write FIFO\n");
-		return err;
+		goto fail1;
 	}
 
 	if ((err = msnd_fifo_alloc(&dev.DARF, dev.fifosize)) < 0) {
 		printk(KERN_ERR LOGNAME ": Couldn't allocate read FIFO\n");
-		msnd_fifo_free(&dev.DAPF);
-		return err;
+		goto fail2;
 	}
 
 	if ((err = probe_multisound()) < 0) {
 		printk(KERN_ERR LOGNAME ": Probe failed\n");
-		msnd_fifo_free(&dev.DAPF);
-		msnd_fifo_free(&dev.DARF);
-		return err;
+		goto fail3;
 	}
 
 	if ((err = attach_multisound()) < 0) {
 		printk(KERN_ERR LOGNAME ": Attach failed\n");
-		msnd_fifo_free(&dev.DAPF);
-		msnd_fifo_free(&dev.DARF);
-		return err;
+		goto fail3;
 	}
 
 	return 0;
+
+fail3:
+	msnd_fifo_free(&dev.DARF);
+fail2:
+	msnd_fifo_free(&dev.DAPF);
+fail1:
+	if (dev.base) {
+		iounmap(dev.base);
+		dev.base = NULL;
+	}
+
+	return err;
+	
 }
 
 static void __exit msdn_cleanup(void)


