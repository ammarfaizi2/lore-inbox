Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269050AbUI2VnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269050AbUI2VnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269068AbUI2VnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:43:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:21497 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S269065AbUI2Vmy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:42:54 -0400
Date: Wed, 29 Sep 2004 14:43:38 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       kraxel@bytesex.org
cc: Hanna Linder <hannal@us.ibm.com>
Subject: Re: [PATCH 2.6.9-rc2-mm4 bttv-driver.c][4/8] convert pci_find_device to pci_dev_present
Message-ID: <17920000.1096494218@w-hlinder.beaverton.ibm.com>
In-Reply-To: <20040929211135.GA24407@kroah.com>
References: <15470000.1096491322@w-hlinder.beaverton.ibm.com> <20040929220344.A17872@infradead.org> <20040929211135.GA24407@kroah.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, September 29, 2004 02:11:35 PM -0700 Greg KH <greg@kroah.com> wrote:
> On Wed, Sep 29, 2004 at 10:03:44PM +0100, Christoph Hellwig wrote:
>> On Wed, Sep 29, 2004 at 01:55:22PM -0700, Hanna Linder wrote:
>> > 
>> > As pci_find_device is going away need to replace it. This file did not use the dev returned
>> > from pci_find_device so is replaceable by pci_dev_present. I was not able to test it
>> > as I do not have the hardware.
>> 
>> I think this check should just go away completely.  
> 
> Good point.  Especially as pci_module_init() can never return -ENODEV
> anymore :)
> 
> Hanna, care to respin this patch?

Here it is, compile tested this time...

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

diff -Nrup linux-2.6.9-rc2-mm4cln/drivers/media/video/bttv-driver.c linux-2.6.9-rc2-mm4patch2/drivers/media/video/bttv-driver.c
--- linux-2.6.9-rc2-mm4cln/drivers/media/video/bttv-driver.c	2004-09-28 14:58:35.000000000 -0700
+++ linux-2.6.9-rc2-mm4patch2/drivers/media/video/bttv-driver.c	2004-09-29 14:30:38.000000000 -0700
@@ -4010,7 +4010,6 @@ static struct pci_driver bttv_pci_driver
 
 static int bttv_init_module(void)
 {
-	int rc;
 	bttv_num = 0;
 
 	printk(KERN_INFO "bttv: driver version %d.%d.%d loaded\n",
@@ -4033,13 +4032,7 @@ static int bttv_init_module(void)
 	bttv_check_chipset();
 
 	bus_register(&bttv_sub_bus_type);
-	rc = pci_module_init(&bttv_pci_driver);
-	if (-ENODEV == rc) {
-		/* plenty of people trying to use bttv for the cx2388x ... */
-		if (NULL != pci_find_device(0x14f1, 0x8800, NULL))
-			printk("bttv doesn't support your Conexant 2388x card.\n");
-	}
-	return rc;
+	return(pci_module_init(&bttv_pci_driver));
 }
 
 static void bttv_cleanup_module(void)


