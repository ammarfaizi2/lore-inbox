Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUHGMMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUHGMMX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 08:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUHGMMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 08:12:23 -0400
Received: from [80.190.193.18] ([80.190.193.18]:9930 "EHLO mx.vsadmin.de")
	by vger.kernel.org with ESMTP id S261763AbUHGMMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 08:12:19 -0400
From: Stefan Meyknecht <sm0407@nurfuerspam.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] cdrom: MO-drive open write fix (trivial)
Date: Sat, 7 Aug 2004 14:12:17 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200408061833.30751.sm0407@nurfuerspam.de> <20040806220654.5e857bed.akpm@osdl.org> <20040807083835.GA24860@suse.de>
In-Reply-To: <20040807083835.GA24860@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408071412.17411.sm0407@nurfuerspam.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
> drive. If you could look into why that isn't set for your mo device
> and send a patch for that, it would be much better.

Assuming mo devices can do random writing, how about this patch:

--- linux/drivers/cdrom/cdrom.c.orig	2004-08-07 14:02:28.958908544 +0200
+++ linux/drivers/cdrom/cdrom.c	2004-08-07 13:58:29.306167698 +0200
@@ -833,8 +833,11 @@ static int cdrom_open_write(struct cdrom
 	if (!cdrom_is_mrw(cdi, &mrw_write))
 		mrw = 1;
 
-	(void) cdrom_is_random_writable(cdi, &ram_write);
-
+	if (CDROM_CAN(CDC_MO_DRIVE))
+		ram_write = 1;
+	else
+		(void) cdrom_is_random_writable(cdi, &ram_write);
+	
 	if (mrw)
 		cdi->mask &= ~CDC_MRW;
 	else
@@ -855,7 +858,7 @@ static int cdrom_open_write(struct cdrom
 	else if (CDROM_CAN(CDC_DVD_RAM))
 		ret = cdrom_dvdram_open_write(cdi);
  	else if (CDROM_CAN(CDC_RAM) &&
- 		 !CDROM_CAN(CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_MRW))
+ 		 !CDROM_CAN(CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_MRW|CDC_MO_DRIVE))
  		ret = cdrom_ram_open_write(cdi);
 	else if (CDROM_CAN(CDC_MO_DRIVE))
 		ret = mo_open_write(cdi);

-- 
Stefan Meyknecht
stefan at meyknecht dot org
