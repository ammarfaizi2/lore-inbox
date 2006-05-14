Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWENJsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWENJsI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 05:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWENJsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 05:48:08 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:49350 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751388AbWENJsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 05:48:07 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@osdl.org>
cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       ambx1@neo.rr.com
Subject: Re: [PATCH][resend] fix resource leak in pnp card_probe() 
In-reply-to: Your message of "Sun, 14 May 2006 02:38:33 MST."
             <20060514023833.649fde1d.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 May 2006 19:48:09 +1000
Message-ID: <31862.1147600089@ocs3>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (on Sun, 14 May 2006 02:38:33 -0700) wrote:
>If !drv->probe then there's not much point in doing the kmalloc and then
>immediately freeing it again.
>
>Like this?
>
>--- devel/drivers/pnp/card.c~pnp-card_probe-fix-memory-leak	2006-05-14 02:30:25.000000000 -0700
>+++ devel-akpm/drivers/pnp/card.c	2006-05-14 02:36:24.000000000 -0700
>@@ -60,30 +60,34 @@ static void card_remove_first(struct pnp
> 	card_remove(dev);
> }
> 
>-static int card_probe(struct pnp_card * card, struct pnp_card_driver * drv)
>+static int card_probe(struct pnp_card *card, struct pnp_card_driver *drv)
> {
>-	const struct pnp_card_device_id *id = match_card(drv,card);
>-	if (id) {
>-		struct pnp_card_link * clink = pnp_alloc(sizeof(struct pnp_card_link));
>-		if (!clink)
>-			return 0;
>-		clink->card = card;
>-		clink->driver = drv;
>-		clink->pm_state = PMSG_ON;
>-		if (drv->probe) {
>-			if (drv->probe(clink, id)>=0)
>-				return 1;
>-			else {
>-				struct pnp_dev * dev;
>-				card_for_each_dev(card, dev) {
>-					if (dev->card_link == clink)
>-						pnp_release_card_device(dev);
>-				}
>-				kfree(clink);
>-			}
>-		} else
>-			return 1;
>+	const struct pnp_card_device_id *id;
>+	struct pnp_card_link *clink;
>+	struct pnp_dev *dev;
>+
>+	if (!drv->probe)
>+		return 0;
>+	id = match_card(drv,card);
>+	if (!id)
>+		return 0;
>+
>+	clink = pnp_alloc(sizeof(*clink));
>+	if (!clink)
>+		return 0;
>+	clink->card = card;
>+	clink->driver = drv;
>+	clink->pm_state = PMSG_ON;

Memory leak of clink on next test.

>+
>+	if (drv->probe(clink, id) >= 0)
>+		return 1;
>+
>+	/* Recovery */
>+	card_for_each_dev(card, dev) {
>+		if (dev->card_link == clink)
>+			pnp_release_card_device(dev);
> 	}
>+	kfree(clink);
> 	return 0;
> }

