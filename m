Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWENJlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWENJlt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 05:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWENJlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 05:41:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751190AbWENJls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 05:41:48 -0400
Date: Sun, 14 May 2006 02:38:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com, jesper.juhl@gmail.com
Subject: Re: [PATCH][resend] fix resource leak in pnp card_probe()
Message-Id: <20060514023833.649fde1d.akpm@osdl.org>
In-Reply-To: <200605132235.42338.jesper.juhl@gmail.com>
References: <200605132235.42338.jesper.juhl@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> (resend of patch already send once on 23/03-2006 
>   - still applies cleanly to latest -git)
> 
> 
> We can leak `clink' in drivers/pnp/card.c::card_probe()
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  drivers/pnp/card.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.16-mm1-orig/drivers/pnp/card.c	2006-03-26 13:43:38.000000000 +0200
> +++ linux-2.6.16-mm1/drivers/pnp/card.c	2006-03-26 15:45:00.000000000 +0200
> @@ -81,8 +81,10 @@ static int card_probe(struct pnp_card * 
>  				}
>  				kfree(clink);
>  			}
> -		} else
> +		} else {
> +			kfree(clink);
>  			return 1;
> +		}
>  	}
>  	return 0;
>  }

If !drv->probe then there's not much point in doing the kmalloc and then
immediately freeing it again.

Like this?

--- devel/drivers/pnp/card.c~pnp-card_probe-fix-memory-leak	2006-05-14 02:30:25.000000000 -0700
+++ devel-akpm/drivers/pnp/card.c	2006-05-14 02:36:24.000000000 -0700
@@ -60,30 +60,34 @@ static void card_remove_first(struct pnp
 	card_remove(dev);
 }
 
-static int card_probe(struct pnp_card * card, struct pnp_card_driver * drv)
+static int card_probe(struct pnp_card *card, struct pnp_card_driver *drv)
 {
-	const struct pnp_card_device_id *id = match_card(drv,card);
-	if (id) {
-		struct pnp_card_link * clink = pnp_alloc(sizeof(struct pnp_card_link));
-		if (!clink)
-			return 0;
-		clink->card = card;
-		clink->driver = drv;
-		clink->pm_state = PMSG_ON;
-		if (drv->probe) {
-			if (drv->probe(clink, id)>=0)
-				return 1;
-			else {
-				struct pnp_dev * dev;
-				card_for_each_dev(card, dev) {
-					if (dev->card_link == clink)
-						pnp_release_card_device(dev);
-				}
-				kfree(clink);
-			}
-		} else
-			return 1;
+	const struct pnp_card_device_id *id;
+	struct pnp_card_link *clink;
+	struct pnp_dev *dev;
+
+	if (!drv->probe)
+		return 0;
+	id = match_card(drv,card);
+	if (!id)
+		return 0;
+
+	clink = pnp_alloc(sizeof(*clink));
+	if (!clink)
+		return 0;
+	clink->card = card;
+	clink->driver = drv;
+	clink->pm_state = PMSG_ON;
+
+	if (drv->probe(clink, id) >= 0)
+		return 1;
+
+	/* Recovery */
+	card_for_each_dev(card, dev) {
+		if (dev->card_link == clink)
+			pnp_release_card_device(dev);
 	}
+	kfree(clink);
 	return 0;
 }
 
_

