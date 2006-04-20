Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWDTKP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWDTKP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWDTKP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:15:59 -0400
Received: from smtp13.wanadoo.fr ([193.252.22.54]:27833 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S1750831AbWDTKP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:15:57 -0400
X-ME-UUID: 20060420101551164.280EB7000095@mwinf1304.wanadoo.fr
Date: Thu, 20 Apr 2006 12:14:48 +0200
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com, linux-alpha@vger.kernel.org
Subject: Re: class_device_add error in SCSI with 2.6.17-rc2-g52824b6b
Message-ID: <20060420101448.GA20087@localhost>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
	linux-alpha@vger.kernel.org
References: <20060419213129.GA9148@localhost> <20060419215803.6DE5BDBA1@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060419215803.6DE5BDBA1@gherkin.frus.com>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 04:58:03PM -0500, Bob Tracy wrote:
> Similar error previously reported by me for 2.6.17-rc1, except sda got
> added fine: error occurred when attempting to add/register sdb. 
> Thankfully, you were able to append a trace...

In my case, I was able to solve the problem by replacing this call at
line 1648 in drivers/scsi/sd.c (patch attached):
strncpy(sdkp->cdev.class_id, sdp->sdev_gendev.bus_id, BUS_ID_SIZE);

by

snprintf(sdkp->cdev.class_id, BUS_ID_SIZE, "%s", sdp->sdev_gendev.bus_id);

Then it works.

While debugging the whole thing, I was printk'ing the value of
sdkp->cdev.class_id right after the strncpy call and here's what I
getting (basically only the first 4 chars + final \0): 
"0:0:"

So I guess the strncpy routine on alpha is fscked up or gcc is doing
something crazy. The function is under arch/alpha/lib/strncpy.S, time to
learn assembly.


--- linux-2.6/drivers/scsi/sd.c	2006-03-28 13:28:24.000000000 +0200
+++ linux-2.6-mat/drivers/scsi/sd.c	2006-04-20 12:12:36.000000000 +0200
@@ -1645,7 +1645,8 @@
 	class_device_initialize(&sdkp->cdev);
 	sdkp->cdev.dev = &sdp->sdev_gendev;
 	sdkp->cdev.class = &sd_disk_class;
-	strncpy(sdkp->cdev.class_id, sdp->sdev_gendev.bus_id, BUS_ID_SIZE);
+	snprintf(sdkp->cdev.class_id, BUS_ID_SIZE, "%s",
+		sdp->sdev_gendev.bus_id);
 
 	if (class_device_add(&sdkp->cdev))
 		goto out_put;


-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr
    "Le disparu, si l'on vénère sa mémoire, est plus présent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exupéry, Citadelle --

