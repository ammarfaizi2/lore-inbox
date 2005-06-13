Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVFMUv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVFMUv7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVFMUv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:51:59 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:37001 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261300AbVFMUvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:51:20 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: =?utf-8?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050613183719.GA8653@gmail.com>
References: <20050530150950.GA14351@gmail.com>
	 <1117467248.4913.9.camel@mulgrave> <20050530160147.GD14351@gmail.com>
	 <1117477040.4913.12.camel@mulgrave> <20050530190716.GA9239@gmail.com>
	 <1118081857.5045.49.camel@mulgrave> <20050607085710.GB9230@gmail.com>
	 <1118590709.4967.6.camel@mulgrave> <20050613145000.GA12057@gmail.com>
	 <1118674783.5079.9.camel@mulgrave>  <20050613183719.GA8653@gmail.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 15:50:47 -0500
Message-Id: <1118695847.5079.41.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 20:37 +0200, =?utf-8?Q?Gr=E9goire?= Favre wrote:
> target1:0:1: SC IS ffff81003fca89c0
> 
>  target1:0:1: scsirate IS 0xf, min_period is 9
> 
>  target1:0:1: asynchronous.
> 
>   Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R08
> 
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> 
>  target1:0:1: Beginning Domain Validation
> 
>  target1:0:1: Domain Validation skipping write tests
> 
>  target1:0:1: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)

OK, this is what tells me there's an error in the bios reading routines
for ultra cards.

Can you try this (it should apply straight on your currently patched
2.6.12-rc6 tree)... hopefully I've been more careful in the bios reading
routines for the ultra (and fast) cards.

Thanks,

James

diff -u b/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- b/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -622,26 +622,37 @@
 
 	dev_printk(KERN_ERR, &starget->dev, "SC IS %p\n", sc);
 	if (sc) {
+		int maxsync = AHC_SYNCRATE_DT;
+		int ultra = 0;
+		int flags = sc->device_flags[target_offset];
+
+		if (ahc->flags & AHC_NEWEEPROM_FMT) {
+		    if (flags & CFSYNCHISULTRA)
+			ultra = 1;
+		} else if (flags & CFULTRAEN)
+			ultra = 1;
+		/* AIC nutcase; 10MHz appears as ultra = 1, CFXFER = 0x04
+		 * change it to ultra=0, CFXFER = 0 */
+		if(ultra && (flags & CFXFER) == 0x04) {
+			dev_printk(KERN_ERR, &starget->dev, "10MHz, flags 0x%x\n", flags);
+			ultra = 0;
+			flags &= ~CFXFER;
+		}
+	    
 		if ((ahc->features & AHC_ULTRA2) != 0) {
-			scsirate = sc->device_flags[target_offset] & CFXFER;
-			dev_printk(KERN_ERR, &starget->dev, "ULTRA2\n");
+			scsirate = (flags & CFXFER) | ultra ? 0x8 : 0;
+			dev_printk(KERN_ERR, &starget->dev, "ULTRA2, flags 0x%x\n", flags);
 		} else {
-			scsirate = (sc->device_flags[target_offset] & CFXFER) << 4;
-			if (sc->device_flags[target_offset] & CFSYNCH)
-				scsirate |= SOFS;
+			scsirate = (flags & CFXFER) << 4;
+			maxsync = ultra ? AHC_SYNCRATE_ULTRA : 
+				AHC_SYNCRATE_FAST;
 		}
-		if (sc->device_flags[target_offset] & CFWIDEB) {
-			scsirate |= WIDEXFER;
-			spi_max_width(starget) = 1;
-		} else
-			spi_max_width(starget) = 0;
-		spi_min_period(starget) = 
-			ahc_find_period(ahc, scsirate, AHC_SYNCRATE_DT);
-		dev_printk(KERN_ERR, &starget->dev, "scsirate IS 0x%x, min_period is %d\n", scsirate, spi_min_period(starget));
-		if (spi_min_period(starget) == 0)
-			/* This means async, so set offset to zero */
+		spi_max_width(starget) = (flags & CFWIDEB) ? 1 : 0;
+		if (!(flags & CFSYNCH))
 			spi_max_offset(starget) = 0;
-		
+		spi_min_period(starget) = 
+			ahc_find_period(ahc, scsirate, maxsync);
+		dev_printk(KERN_ERR, &starget->dev, "scsirate IS 0x%x, min_period is %d, flags 0x%x\n", scsirate, spi_min_period(starget), flags);
 
 		tinfo = ahc_fetch_transinfo(ahc, channel, ahc->our_id,
 					    starget->id, &tstate);



