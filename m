Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVLUNZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVLUNZq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVLUNZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:25:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58118 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932407AbVLUNZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:25:44 -0500
Date: Wed, 21 Dec 2005 14:25:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Nils Meyer <meyer@work.de>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [2.6 patch] drivers/net/sungem.c: gem_remove_one mustn't be __devexit
Message-ID: <20051221132543.GG5359@stusta.de>
References: <200512211323.19242.meyer@work.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512211323.19242.meyer@work.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 01:23:18PM +0100, Nils Meyer wrote:

> Hi,

Hi Nils,

> When compiling 2.6.15-rc6 or 2.6.14.4 on my sparc I get the following error:
> 
> local symbol 0: discarded in section `.exit.text' from drivers/built-in.o [*]
> 
> After calling scripts/reference_discarded.pl it gives me the following error:
> 
> Error: ./drivers/net/sungem.o .init.text refers to 0000000000000448 
> R_SPARC_WDISP30   .exit.text
>...

thanks for this report.

The untested patch below should fix this bug (I'm assuming your .config 
hasn't set CONFIG_HOTPLUG).

It's a real problem that these bugs have become runtime errors in
kernel 2.6 on i386 instead of link errors as they were in kernel 2.4 on 
i386 (and are still in kernel kernel 2.6 on some other architectures 
like sparc64) resulting in fewer people noticing them.  :-(

> kind regards
> Nils Meyer

cu
Adrian


<--  snip  -->


gem_remove_one() is called from the __devinit gem_init_one().

Therefore, gem_remove_one() mustn't be __devexit.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc6/drivers/net/sungem.c.old	2005-12-21 14:02:51.000000000 +0100
+++ linux-2.6.15-rc6/drivers/net/sungem.c	2005-12-21 14:03:37.000000000 +0100
@@ -2907,7 +2907,7 @@
 	return 0;
 }
 
-static void __devexit gem_remove_one(struct pci_dev *pdev)
+static void gem_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
@@ -3181,7 +3181,7 @@
 	.name		= GEM_MODULE_NAME,
 	.id_table	= gem_pci_tbl,
 	.probe		= gem_init_one,
-	.remove		= __devexit_p(gem_remove_one),
+	.remove		= gem_remove_one,
 #ifdef CONFIG_PM
 	.suspend	= gem_suspend,
 	.resume		= gem_resume,

