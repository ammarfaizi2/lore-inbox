Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVB1NIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVB1NIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVB1NIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:08:50 -0500
Received: from lumumba.luc.ac.be ([193.190.9.252]:1293 "EHLO lumumba.luc.ac.be")
	by vger.kernel.org with ESMTP id S261584AbVB1NHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:07:44 -0500
Date: Mon, 28 Feb 2005 14:07:42 +0100
From: Panagiotis Issaris <takis@lumumba.luc.ac.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Possible AMD8111e free irq issue
Message-ID: <20050228140742.A29902@lumumba.luc.ac.be>
Reply-To: panagiotis.issaris@mech.kuleuven.ac.be
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems to me that if in the amd8111e_open() fuction dev->irq isn't
zero and the irq request succeeds it might not get released anymore.

Specifically, on failure of the amd8111e_restart() call the function
returns -ENOMEM without releasing the irq. The amd8111e_restart()
function can fail because of various pci_alloc_consistent() and
dev_alloc_skb() calls in amd8111e_init_ring() which is being
called by amd8111e_restart.

1374     if(dev->irq ==0 || request_irq(dev->irq, amd8111e_interrupt, SA_SHIRQ,
1375                      dev->name, dev))
1376         return -EAGAIN;
	
The patch applies to 2.6.11-rc5-bk2. 

If I'm right about the above, I'm not I'm not sure if the free_irq() should
happen before or after releasing the spinlock.

With friendly regards,
Takis

diff -uprN linux-2.6.11-rc5-bk2/drivers/net/amd8111e.c linux-2.6.11-rc5-bk2-pi/drivers/net/amd8111e.c
--- linux-2.6.11-rc5-bk2/drivers/net/amd8111e.c	2005-02-28 13:44:46.000000000 +0100
+++ linux-2.6.11-rc5-bk2-pi/drivers/net/amd8111e.c	2005-02-28 13:45:09.000000000 +0100
@@ -1381,6 +1381,8 @@ static int amd8111e_open(struct net_devi
 
 	if(amd8111e_restart(dev)){
 		spin_unlock_irq(&lp->lock);
+		if (dev->irq)
+			free_irq(dev->irq, dev);
 		return -ENOMEM;
 	}
 	/* Start ipg timer */


-- 
OpenPGP key: http://lumumba.luc.ac.be/takis/takis_public_key.txt
fingerprint: 6571 13A3 33D9 3726 F728  AA98 F643 B12E ECF3 E029
