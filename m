Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265745AbUFRXXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbUFRXXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbUFRXUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:20:47 -0400
Received: from mail.dif.dk ([193.138.115.101]:32168 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262138AbUFRXPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:15:11 -0400
Date: Sat, 19 Jun 2004 01:14:10 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Eberhard Moenkeberg <emoenke@gwdg.de>,
       Eric van der Maarel <H.T.M.v.d.Maarel@marin.nl>
Subject: Re: [PATCH] check_/request_region fixes & request for enlightenment
In-Reply-To: <Pine.LNX.4.60.0406182021200.7426@poirot.grange>
Message-ID: <Pine.LNX.4.56.0406190104030.17899@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0406162245320.11954@jjulnx.backbone.dif.dk>
 <Pine.LNX.4.60.0406172036001.3926@poirot.grange>
 <Pine.LNX.4.56.0406180007530.15935@jjulnx.backbone.dif.dk>
 <Pine.LNX.4.60.0406182021200.7426@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Guennadi,

Thank you for reviewing this (and for all your helpful info).


Andrew,

Would you accept the following patch to convert check_region to
request_region and clean up some parentheses in return statements for
drivers/cdrom/isp16.c ?
I've left Guennadi Liakhovetski's comments on my previous version below,
and only changes I've made since then is a small addition to the comment
at the top of the file about the changes made.
I don't have hardware to do thorough testing, but I've done what testing I
can; it compiles without errors or warnings, and nothing blows up when
attempting to load the module (except that it fails, of course, due to
missing hardware) and I've read through it several times, and to the best
of my knowledge it should be correct.


On Fri, 18 Jun 2004, Guennadi Liakhovetski wrote:

> On Fri, 18 Jun 2004, Jesper Juhl wrote:
>
> >> That looks like a bug - release_region() without request_region().
> >>
> > Since check_region is now request_region I assume things are now OK..?
>
> Yep.
>
> > Or maybe something like this is better, to just have a single exit point?
> > The code is shorter this way, and there's less chance if error if one
> > wants to update the return value (only one place to edit)... Which one is
> > the prefered approach?
>
> I think, it is the preferred way. At least I don't see anything else
> obviously wrong there:-)
>
> Guennadi
>

Here's my final version of the patch (against 2.6.7) :

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-orig/drivers/cdrom/isp16.c	2004-06-16 07:20:04.000000000 +0200
+++ linux-2.6.7/drivers/cdrom/isp16.c	2004-06-19 01:05:35.000000000 +0200
@@ -16,6 +16,10 @@
  *			   module_init & module_exit.
  *			   Torben Mathiasen <tmm@image.dk>
  *
+ *     19 June 2004     -- check_region() converted to request_region()
+ *                         and return statement cleanups.
+ *                         Jesper Juhl <juhl-lkml@dif.dk>
+ *
  *    Detect cdrom interface on ISP16 sound card.
  *    Configure cdrom interface.
  *
@@ -118,17 +122,17 @@ int __init isp16_init(void)

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
@@ -148,27 +152,32 @@ int __init isp16_init(void)
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
@@ -206,7 +215,7 @@ static short __init isp16_c928__detect(v
 			ISP16_OUT(ISP16_C928__ENABLE_PORT, enable_cdrom);
 		} else {	/* bits are not the same */
 			ISP16_OUT(ISP16_CTRL_PORT, ctrl);
-			return (i);	/* -> not detected: possibly incorrect conclusion */
+			return i;	/* -> not detected: possibly incorrect conclusion */
 		}
 	} else if (enable_cdrom == 0x20)
 		i = 0;
@@ -215,7 +224,7 @@ static short __init isp16_c928__detect(v

 	ISP16_OUT(ISP16_CTRL_PORT, ctrl);

-	return (i);
+	return i;
 }

 static short __init isp16_c929__detect(void)
@@ -236,12 +245,12 @@ static short __init isp16_c929__detect(v
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
@@ -272,7 +281,7 @@ isp16_cdi_config(int base, u_char drive_
 		printk
 		    ("ISP16: base address 0x%03X not supported by cdrom interface.\n",
 		     base);
-		return (-1);
+		return -1;
 	}
 	switch (irq) {
 	case 0:
@@ -303,7 +312,7 @@ isp16_cdi_config(int base, u_char drive_
 	default:
 		printk("ISP16: irq %d not supported by cdrom interface.\n",
 		       irq);
-		return (-1);
+		return -1;
 	}
 	switch (dma) {
 	case 0:
@@ -312,7 +321,7 @@ isp16_cdi_config(int base, u_char drive_
 	case 1:
 		printk("ISP16: dma 1 cannot be used by cdrom interface,"
 		       " due to conflict with the sound card.\n");
-		return (-1);
+		return -1;
 		break;
 	case 3:
 		dma_code = ISP16_DMA_3;
@@ -329,7 +338,7 @@ isp16_cdi_config(int base, u_char drive_
 	default:
 		printk("ISP16: dma %d not supported by cdrom interface.\n",
 		       dma);
-		return (-1);
+		return -1;
 	}

 	if (drive_type != ISP16_SONY && drive_type != ISP16_PANASONIC0 &&
@@ -339,7 +348,7 @@ isp16_cdi_config(int base, u_char drive_
 		printk
 		    ("ISP16: drive type (code 0x%02X) not supported by cdrom"
 		     " interface.\n", drive_type);
-		return (-1);
+		return -1;
 	}

 	/* set type of interface */
@@ -354,7 +363,7 @@ isp16_cdi_config(int base, u_char drive_
 	i = ISP16_IN(ISP16_IO_SET_PORT) & ISP16_IO_SET_MASK;	/* keep some bits */
 	ISP16_OUT(ISP16_IO_SET_PORT, i | base_code | irq_code | dma_code);

-	return (0);
+	return 0;
 }

 void __exit isp16_exit(void)


--
Jesper Juhl <juhl-lkml@dif.dk>

