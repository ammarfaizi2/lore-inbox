Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262875AbVCPXza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbVCPXza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVCPXza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:55:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:41361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262875AbVCPXzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:55:19 -0500
Date: Wed, 16 Mar 2005 15:54:27 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: dilinger@debian.org, jgarzik@pobox.com, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       cliffw@osdl.org, tytso@mit.edu, rddunlap@osdl.org
Subject: [2/9] Possible AMD8111e free irq issue
Message-ID: <20050316235427.GA5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316235336.GY5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

---- 

From: Andres Salomon <dilinger@debian.org>

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

Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Naru a/drivers/net/amd8111e.c b/drivers/net/amd8111e.c
--- a/drivers/net/amd8111e.c	2005-03-09 20:29:47 -08:00
+++ b/drivers/net/amd8111e.c	2005-03-09 20:29:47 -08:00
@@ -1381,6 +1381,8 @@
 
 	if(amd8111e_restart(dev)){
 		spin_unlock_irq(&lp->lock);
+		if (dev->irq)
+			free_irq(dev->irq, dev);
 		return -ENOMEM;
 	}
 	/* Start ipg timer */
