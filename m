Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVBGUKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVBGUKZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVBGUH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:07:56 -0500
Received: from EASTCAMPUS-THREE-FORTY-FOUR.MIT.EDU ([18.248.6.89]:2435 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261279AbVBGUGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 15:06:23 -0500
Date: Mon, 7 Feb 2005 15:01:13 -0500
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [bug] pnp_register_card_driver/pnp_unregister_card_driver
Message-ID: <20050207200113.GC3621@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	matthieu castet <castet.matthieu@free.fr>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <4207C29B.8030105@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4207C29B.8030105@free.fr>
User-Agent: Mutt/1.5.6+20040907i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 08:33:47PM +0100, matthieu castet wrote:
> Hi,
> 
> pnp_register_driver could fail and return <0 result, in this case the 
> driver shouldn't be pnp_unregister_driver.
> 
> But if you look in pnp_register_card_driver, the result isn't checked. 
> And it is always pnp_unregister_driver in pnp_unregister_card_driver.
> 
> I know that pnp_register_card_driver shouldn't fail in normal condition, 
> but who know...
> 
> 
> Matthieu

Yeah, you're right.  I'm probably going to do something like this.

--- a/drivers/pnp/card.c	2005-01-20 17:38:02.000000000 -0500
+++ b/drivers/pnp/card.c	2005-02-07 14:53:24.000000000 -0500
@@ -355,10 +355,12 @@
 	drv->link.probe = NULL;
 	drv->link.remove = &card_remove_first;
 
+	if ((count = pnp_register_driver(&drv->link) < 0))
+		return count;
+
 	spin_lock(&pnp_lock);
 	list_add_tail(&drv->global_list, &pnp_card_drivers);
 	spin_unlock(&pnp_lock);
-	pnp_register_driver(&drv->link);
 
 	list_for_each_safe(pos,temp,&pnp_cards){
 		struct pnp_card *card = list_entry(pos, struct pnp_card, global_list);

Thanks,
Adam
