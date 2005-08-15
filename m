Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVHOMlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVHOMlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 08:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVHOMlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 08:41:07 -0400
Received: from [195.113.161.147] ([195.113.161.147]:25776 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1750714AbVHOMlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 08:41:06 -0400
Date: Mon, 15 Aug 2005 14:41:05 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: LKML <linux-kernel@vger.kernel.org>
Cc: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH] broken error path in drivers/pnp/card.c
Message-ID: <Pine.LNX.4.61.0508151436360.9682@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	it seems that the error path in pnp_request_card_device() is
broken (one variable is left initialized and the semaphore is not 
unlocked). The bellow patch should fix it.

Signed-off-by: Jaroslav Kysela <perex@suse.cz>


diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
--- a/drivers/pnp/card.c
+++ b/drivers/pnp/card.c
@@ -312,6 +312,8 @@ found:
 	if (drv->link.driver.probe) {
 		if (drv->link.driver.probe(&dev->dev)) {
 			dev->dev.driver = NULL;
+			dev->card_link = NULL;
+			up_write(&dev->dev.bus->subsys.rwsem);
 			return NULL;
 		}
 	}

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
