Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266536AbUA3FSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUA3FQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:16:40 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:55428 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266524AbUA3FQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:16:00 -0500
Date: Fri, 30 Jan 2004 00:00:49 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.2-rc2
Message-ID: <20040130000049.GH12308@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040129235304.GA12308@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129235304.GA12308@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the matching code to ensure that all requested devices are
present on the card, even if they are in use.  It is necessary for some ALSA
drivers to work properly because early vendors would have different sets of
devices on the same card ids.  It is from Takashi Iwai <tiwai@suse.de>.

--- a/drivers/pnp/card.c	2004-01-09 07:00:03.000000000 +0000
+++ b/drivers/pnp/card.c	2004-01-29 22:06:22.000000000 +0000
@@ -26,8 +26,25 @@
 {
 	const struct pnp_card_device_id * drv_id = drv->id_table;
 	while (*drv_id->id){
-		if (compare_pnp_id(card->id,drv_id->id))
-			return drv_id;
+		if (compare_pnp_id(card->id,drv_id->id)) {
+			int i = 0;
+			for (;;) {
+				int found;
+				struct pnp_dev *dev;
+				if (i == PNP_MAX_DEVICES || ! *drv_id->devs[i].id)
+					return drv_id;
+				found = 0;
+				card_for_each_dev(card, dev) {
+					if (compare_pnp_id(dev->id, drv_id->devs[i].id)) {
+						found = 1;
+						break;
+					}
+				}
+				if (! found)
+					break;
+				i++;
+			}
+		}
 		drv_id++;
 	}
 	return NULL;
