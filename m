Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWFQSWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWFQSWl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWFQSWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:22:41 -0400
Received: from mms3.broadcom.com ([216.31.210.19]:18438 "EHLO
	MMS3.broadcom.com") by vger.kernel.org with ESMTP id S1750778AbWFQSWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:22:40 -0400
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Subject: Re: tg3 timeouts with 2.6.17-rc6
From: "Michael Chan" <mchan@broadcom.com>
To: "David Miller" <davem@davemloft.net>
cc: jk@blackdown.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <1551EAE59135BE47B544934E30FC4FC041BD1E@NT-IRVA-0751.brcm.ad.broadcom.com>
References: <1551EAE59135BE47B544934E30FC4FC041BD1E@NT-IRVA-0751.brcm.ad.broadcom.com>
Date: Sat, 17 Jun 2006 11:23:28 -0700
Message-ID: <1150568608.26368.49.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006061709; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230342E34343934343644322E303030462D412D;
 ENG=IBF; TS=20060617182229; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006061709_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 688A97EF09K6496353-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-16 at 20:37 -0700, Michael Chan wrote:
> David Miller wrote:
> 
> > From: "Michael Chan" <mchan@broadcom.com>
> > Date: Fri, 16 Jun 2006 18:27:32 -0700
> > 
> > > In the meantime, I wonder if we should disable TSO by default on the
> > > 5780 chip for 2.6.17.
> > 
> > Sounds reasonable.  Would we disable it for all chips that set
> > TG3_FLG2_5780_CLASS or a specific variant?
> > 
> Yes, let's disable it for all TG3_FLG2_5780_CLASS chips for now
> until we figure out what's going on.

David, Here's the patch if you haven't already made one:

[TG3]: Disable TSO by default on 5780 class chips.

Disable TSO by default on 5780, 5714, and 5715 chips for now while we
investigate the reported tx timeouts by Juergen Kreileder.  Thanks to
Juergen for reporting the problem.

Update version to 3.60.

Signed-off-by: Michael Chan <mchan@broadcom.com>


diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
index 862c226..607d87e 100644
--- a/drivers/net/tg3.c
+++ b/drivers/net/tg3.c
@@ -69,8 +69,8 @@
 
 #define DRV_MODULE_NAME		"tg3"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"3.59"
-#define DRV_MODULE_RELDATE	"June 8, 2006"
+#define DRV_MODULE_VERSION	"3.60"
+#define DRV_MODULE_RELDATE	"June 17, 2006"
 
 #define TG3_DEF_MAC_MODE	0
 #define TG3_DEF_RX_MODE		0
@@ -11385,7 +11385,11 @@ static int __devinit tg3_init_one(struct
 	 * Firmware TSO on older chips gives lower performance, so it
 	 * is off by default, but can be enabled using ethtool.
 	 */
-	if (tp->tg3_flags2 & TG3_FLG2_HW_TSO)
+	/* Disable TSO by default on all 5780 class chips because
+	 * of reported tx timeouts.
+	 */
+	if ((tp->tg3_flags2 & TG3_FLG2_HW_TSO) &&
+	   !(tp->tg3_flags2 & TG3_FLG2_5780_CLASS))
 		dev->features |= NETIF_F_TSO;
 
 #endif


