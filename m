Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264061AbUFQWfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUFQWfO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 18:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUFQWfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 18:35:14 -0400
Received: from mail.dif.dk ([193.138.115.101]:5056 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264061AbUFQWeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 18:34:50 -0400
Date: Fri, 18 Jun 2004 00:33:55 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Eberhard Moenkeberg <emoenke@gwdg.de>,
       Eric van der Maarel <H.T.M.v.d.Maarel@marin.nl>
Subject: Re: [PATCH] check_/request_region fixes & request for enlightenment
In-Reply-To: <Pine.LNX.4.60.0406172036001.3926@poirot.grange>
Message-ID: <Pine.LNX.4.56.0406180007530.15935@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0406162245320.11954@jjulnx.backbone.dif.dk>
 <Pine.LNX.4.60.0406172036001.3926@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First of all, thank you Guennadi - that was exactely the kind of response
I was hoping for.


On Thu, 17 Jun 2004, Guennadi Liakhovetski wrote:

> On Wed, 16 Jun 2004, Jesper Juhl wrote:
>
> > in the isp16.c case the region is free'ed in isp16_exit(), but one thing I
>
> That looks like a bug - release_region() without request_region().
>
Since check_region is now request_region I assume things are now OK..?


> No. You pass the same address and size you used to request the region.
>
And release_region() handles the rest - understood.


> You also have to release_region() in all failure-cases in the

That makes perfect sense, should have figured that out myself, thank you.


> isp16_init(). Also, I think, if the region is busy you should return
> -EBUSY, but there I am not too sure.
>
I agree, signalling that a needed resource is busy makes more sense than
I/O error. But, I'll leave the original return value alone right now until
I get comments from someone else on that as I'm also not too sure.

How does a patch like this look to you?
It's a little cluttered since I desided to also clean the pointless
parentheses out of the return statements in the same go...

--- linux-2.6.7-orig/drivers/cdrom/isp16.c	2004-06-16 07:20:04.000000000 +0200
+++ linux-2.6.7/drivers/cdrom/isp16.c	2004-06-17 22:41:06.000000000 +0200
@@ -118,17 +118,18 @@ int __init isp16_init(void)

 	if (!strcmp(isp16_cdrom_type, "noisp16")) {
 		printk("ISP16: no cdrom interface configured.\n");
-		return (0);
+		return 0;
 	}

-	if (check_region(ISP16_IO_BASE, ISP16_IO_SIZE)) {
+	if (!request_region(ISP16_IO_BASE, ISP16_IO_SIZE, "isp16")) {
 		printk("ISP16: i/o ports already in use.\n");
-		return (-EIO);
+		return -EIO;
 	}

 	if ((isp16_type = isp16_detect()) < 0) {
 		printk("ISP16: no cdrom interface found.\n");
-		return (-EIO);
+		release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
+		return -EIO;
 	}

 	printk(KERN_INFO
@@ -148,27 +149,29 @@ int __init isp16_init(void)
 	else {
 		printk("ISP16: %s not supported by cdrom interface.\n",
 		       isp16_cdrom_type);
-		return (-EIO);
+		release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
+		return -EIO;
 	}

 	if (isp16_cdi_config(isp16_cdrom_base, expected_drive,
 			     isp16_cdrom_irq, isp16_cdrom_dma) < 0) {
 		printk
 		    ("ISP16: cdrom interface has not been properly configured.\n");
-		return (-EIO);
+		release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
+		return -EIO;
 	}
 	printk(KERN_INFO
 	       "ISP16: cdrom interface set up with io base 0x%03X, irq %d, dma %d,"
 	       " type %s.\n", isp16_cdrom_base, isp16_cdrom_irq,
 	       isp16_cdrom_dma, isp16_cdrom_type);
-	return (0);
+	return 0;
 }

 static short __init isp16_detect(void)
 {

 	if (isp16_c929__detect() >= 0)
-		return (2);
+		return 2;
 	else
 		return (isp16_c928__detect());
 }
@@ -206,7 +209,7 @@ static short __init isp16_c928__detect(v
 			ISP16_OUT(ISP16_C928__ENABLE_PORT, enable_cdrom);
 		} else {	/* bits are not the same */
 			ISP16_OUT(ISP16_CTRL_PORT, ctrl);
-			return (i);	/* -> not detected: possibly incorrect conclusion */
+			return i;	/* -> not detected: possibly incorrect conclusion */
 		}
 	} else if (enable_cdrom == 0x20)
 		i = 0;
@@ -215,7 +218,7 @@ static short __init isp16_c928__detect(v

 	ISP16_OUT(ISP16_CTRL_PORT, ctrl);

-	return (i);
+	return i;
 }

 static short __init isp16_c929__detect(void)
@@ -236,12 +239,12 @@ static short __init isp16_c929__detect(v
 	tmp = ISP16_IN(ISP16_CTRL_PORT);

 	if (tmp != 2)		/* isp16 with 82C929 not detected */
-		return (-1);
+		return -1;

 	/* restore ctrl port value */
 	ISP16_OUT(ISP16_CTRL_PORT, ctrl);

-	return (2);
+	return 2;
 }

 static short __init
@@ -272,7 +275,7 @@ isp16_cdi_config(int base, u_char drive_
 		printk
 		    ("ISP16: base address 0x%03X not supported by cdrom interface.\n",
 		     base);
-		return (-1);
+		return -1;
 	}
 	switch (irq) {
 	case 0:
@@ -303,7 +306,7 @@ isp16_cdi_config(int base, u_char drive_
 	default:
 		printk("ISP16: irq %d not supported by cdrom interface.\n",
 		       irq);
-		return (-1);
+		return -1;
 	}
 	switch (dma) {
 	case 0:
@@ -312,7 +315,7 @@ isp16_cdi_config(int base, u_char drive_
 	case 1:
 		printk("ISP16: dma 1 cannot be used by cdrom interface,"
 		       " due to conflict with the sound card.\n");
-		return (-1);
+		return -1;
 		break;
 	case 3:
 		dma_code = ISP16_DMA_3;
@@ -329,7 +332,7 @@ isp16_cdi_config(int base, u_char drive_
 	default:
 		printk("ISP16: dma %d not supported by cdrom interface.\n",
 		       dma);
-		return (-1);
+		return -1;
 	}

 	if (drive_type != ISP16_SONY && drive_type != ISP16_PANASONIC0 &&
@@ -339,7 +342,7 @@ isp16_cdi_config(int base, u_char drive_
 		printk
 		    ("ISP16: drive type (code 0x%02X) not supported by cdrom"
 		     " interface.\n", drive_type);
-		return (-1);
+		return -1;
 	}

 	/* set type of interface */
@@ -354,7 +357,7 @@ isp16_cdi_config(int base, u_char drive_
 	i = ISP16_IN(ISP16_IO_SET_PORT) & ISP16_IO_SET_MASK;	/* keep some bits */
 	ISP16_OUT(ISP16_IO_SET_PORT, i | base_code | irq_code | dma_code);

-	return (0);
+	return 0;
 }

 void __exit isp16_exit(void)


Or maybe something like this is better, to just have a single exit point?
The code is shorter this way, and there's less chance if error if one
wants to update the return value (only one place to edit)... Which one is
the prefered approach?


--- linux-2.6.7-orig/drivers/cdrom/isp16.c	2004-06-16 07:20:04.000000000 +0200
+++ linux-2.6.7/drivers/cdrom/isp16.c	2004-06-18 00:09:49.000000000 +0200
@@ -118,17 +118,17 @@ int __init isp16_init(void)

 	if (!strcmp(isp16_cdrom_type, "noisp16")) {
 		printk("ISP16: no cdrom interface configured.\n");
-		return (0);
+		return 0;
 	}

-	if (check_region(ISP16_IO_BASE, ISP16_IO_SIZE)) {
+	if (!request_region(ISP16_IO_BASE, ISP16_IO_SIZE, "isp16")) {
 		printk("ISP16: i/o ports already in use.\n");
-		return (-EIO);
+		goto out;
 	}

 	if ((isp16_type = isp16_detect()) < 0) {
 		printk("ISP16: no cdrom interface found.\n");
-		return (-EIO);
+		goto cleanup_out;
 	}

 	printk(KERN_INFO
@@ -148,27 +148,32 @@ int __init isp16_init(void)
 	else {
 		printk("ISP16: %s not supported by cdrom interface.\n",
 		       isp16_cdrom_type);
-		return (-EIO);
+		goto cleanup_out;
 	}

 	if (isp16_cdi_config(isp16_cdrom_base, expected_drive,
 			     isp16_cdrom_irq, isp16_cdrom_dma) < 0) {
 		printk
 		    ("ISP16: cdrom interface has not been properly configured.\n");
-		return (-EIO);
+		goto cleanup_out;
 	}
 	printk(KERN_INFO
 	       "ISP16: cdrom interface set up with io base 0x%03X, irq %d, dma %d,"
 	       " type %s.\n", isp16_cdrom_base, isp16_cdrom_irq,
 	       isp16_cdrom_dma, isp16_cdrom_type);
-	return (0);
+	return 0;
+
+cleanup_out:
+	release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
+out:
+	return -EIO;
 }

 static short __init isp16_detect(void)
 {

 	if (isp16_c929__detect() >= 0)
-		return (2);
+		return 2;
 	else
 		return (isp16_c928__detect());
 }
@@ -206,7 +211,7 @@ static short __init isp16_c928__detect(v
 			ISP16_OUT(ISP16_C928__ENABLE_PORT, enable_cdrom);
 		} else {	/* bits are not the same */
 			ISP16_OUT(ISP16_CTRL_PORT, ctrl);
-			return (i);	/* -> not detected: possibly incorrect conclusion */
+			return i;	/* -> not detected: possibly incorrect conclusion */
 		}
 	} else if (enable_cdrom == 0x20)
 		i = 0;
@@ -215,7 +220,7 @@ static short __init isp16_c928__detect(v

 	ISP16_OUT(ISP16_CTRL_PORT, ctrl);

-	return (i);
+	return i;
 }

 static short __init isp16_c929__detect(void)
@@ -236,12 +241,12 @@ static short __init isp16_c929__detect(v
 	tmp = ISP16_IN(ISP16_CTRL_PORT);

 	if (tmp != 2)		/* isp16 with 82C929 not detected */
-		return (-1);
+		return -1;

 	/* restore ctrl port value */
 	ISP16_OUT(ISP16_CTRL_PORT, ctrl);

-	return (2);
+	return 2;
 }

 static short __init
@@ -272,7 +277,7 @@ isp16_cdi_config(int base, u_char drive_
 		printk
 		    ("ISP16: base address 0x%03X not supported by cdrom interface.\n",
 		     base);
-		return (-1);
+		return -1;
 	}
 	switch (irq) {
 	case 0:
@@ -303,7 +308,7 @@ isp16_cdi_config(int base, u_char drive_
 	default:
 		printk("ISP16: irq %d not supported by cdrom interface.\n",
 		       irq);
-		return (-1);
+		return -1;
 	}
 	switch (dma) {
 	case 0:
@@ -312,7 +317,7 @@ isp16_cdi_config(int base, u_char drive_
 	case 1:
 		printk("ISP16: dma 1 cannot be used by cdrom interface,"
 		       " due to conflict with the sound card.\n");
-		return (-1);
+		return -1;
 		break;
 	case 3:
 		dma_code = ISP16_DMA_3;
@@ -329,7 +334,7 @@ isp16_cdi_config(int base, u_char drive_
 	default:
 		printk("ISP16: dma %d not supported by cdrom interface.\n",
 		       dma);
-		return (-1);
+		return -1;
 	}

 	if (drive_type != ISP16_SONY && drive_type != ISP16_PANASONIC0 &&
@@ -339,7 +344,7 @@ isp16_cdi_config(int base, u_char drive_
 		printk
 		    ("ISP16: drive type (code 0x%02X) not supported by cdrom"
 		     " interface.\n", drive_type);
-		return (-1);
+		return -1;
 	}

 	/* set type of interface */
@@ -354,7 +359,7 @@ isp16_cdi_config(int base, u_char drive_
 	i = ISP16_IN(ISP16_IO_SET_PORT) & ISP16_IO_SET_MASK;	/* keep some bits */
 	ISP16_OUT(ISP16_IO_SET_PORT, i | base_code | irq_code | dma_code);

-	return (0);
+	return 0;
 }

 void __exit isp16_exit(void)


I've added the original author as well as the NON-IDE/NON-SCSI CDROM
DRIVER maintainer Eberhard Moenkeberg to the CC list - hoping for more
comments :)


Regarding trm290;

> trm290_init_one
>    ide_setup_pci_device
>
> first calls
>
>      do_ide_setup_pci_device
>        ide_pci_setup_ports
>          d->init_hwif(hwif) = init_hwif_trm290
>            ***check_region***
>
> then it calls
>
>      probe_hwif_init
>        probe_hwif
>          ide_hwif_request_regions
>

Perfect. That plus your clarifying text was just the explanation I needed.
I'll get to work on a revised patch for trm290 - and I'll post that in a
sepperate thread (I'll CC you (Guennadi) on that if you don't mind?).


--
Jesper Juhl <juhl-lkml@dif.dk>

