Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264347AbTLES4f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTLES4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:56:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16061 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264347AbTLESyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:54:52 -0500
Message-ID: <3FD0D469.3070504@pobox.com>
Date: Fri, 05 Dec 2003 13:54:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] net driver fixes
References: <20031205183037.GA8536@gtf.org>
In-Reply-To: <20031205183037.GA8536@gtf.org>
Content-Type: multipart/mixed;
 boundary="------------010807080603020208040805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010807080603020208040805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Linus, please do a
> 
> 	bk pull bk://gkernel.bkbits.net/net-drivers-2.5
> 
> This will update the following files:
> 
>  drivers/net/pci-skeleton.c |    7 ---
>  drivers/net/pcnet32.c      |    2 
>  drivers/net/r8169.c        |    4 -
>  drivers/net/sis190.c       |    4 -
>  drivers/net/typhoon.c      |   97 ++++++++++++++++++++++++++++++++++++---------
>  5 files changed, 78 insertions(+), 36 deletions(-)


So following that email... you just wanna truncate this patch -- snip 
the typhoon portion and apply the rest?

--------------010807080603020208040805
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"


This will update the following files:

 drivers/net/pci-skeleton.c |    7 ---
 drivers/net/pcnet32.c      |    2 
 drivers/net/r8169.c        |    4 -
 drivers/net/sis190.c       |    4 -

through these ChangeSets:

<jgarzik@redhat.com> (03/12/05 1.1499)
   [netdrvr pcnet32] fix oops on unload
   
   Driver was calling pci_unregister_driver for each _device_, and then
   again at the end of the module unload routine.  Remove the call that's
   inside the loop, pci_unregister_driver should only be called once.
   
   Caught by Don Fry (and many others)

<viro@parcelfarce.linux.theplanet.co.uk> (03/12/03 1.1496.1.9)
   [netdrvr] remove manual driver poisoning of net_device
   
   Such poisoning can cause oopses either because the refcount is not
   zero when the poisoning occurs, or due to kernel debugging options
   being enabled.


diff -Nru a/drivers/net/pci-skeleton.c b/drivers/net/pci-skeleton.c
--- a/drivers/net/pci-skeleton.c	Fri Dec  5 13:22:32 2003
+++ b/drivers/net/pci-skeleton.c	Fri Dec  5 13:22:32 2003
@@ -864,13 +864,6 @@
 
 	pci_release_regions (pdev);
 
-#ifndef NETDRV_NDEBUG
-	/* poison memory before freeing */
-	memset (dev, 0xBC,
-		sizeof (struct net_device) +
-		sizeof (struct netdrv_private));
-#endif /* NETDRV_NDEBUG */
-
 	free_netdev (dev);
 
 	pci_set_drvdata (pdev, NULL);
diff -Nru a/drivers/net/pcnet32.c b/drivers/net/pcnet32.c
--- a/drivers/net/pcnet32.c	Fri Dec  5 13:22:32 2003
+++ b/drivers/net/pcnet32.c	Fri Dec  5 13:22:32 2003
@@ -1766,8 +1766,6 @@
 	next_dev = lp->next;
 	unregister_netdev(pcnet32_dev);
 	release_region(pcnet32_dev->base_addr, PCNET32_TOTAL_SIZE);
-	if (lp->pci_dev)
-	    pci_unregister_driver(&pcnet32_driver);
 	pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
 	free_netdev(pcnet32_dev);
 	pcnet32_dev = next_dev;
diff -Nru a/drivers/net/r8169.c b/drivers/net/r8169.c
--- a/drivers/net/r8169.c	Fri Dec  5 13:22:32 2003
+++ b/drivers/net/r8169.c	Fri Dec  5 13:22:32 2003
@@ -642,10 +642,6 @@
 	iounmap(tp->mmio_addr);
 	pci_release_regions(pdev);
 
-	// poison memory before freeing 
-	memset(dev, 0xBC,
-	       sizeof (struct net_device) + sizeof (struct rtl8169_private));
-
 	pci_disable_device(pdev);
 	free_netdev(dev);
 	pci_set_drvdata(pdev, NULL);
diff -Nru a/drivers/net/sis190.c b/drivers/net/sis190.c
--- a/drivers/net/sis190.c	Fri Dec  5 13:22:32 2003
+++ b/drivers/net/sis190.c	Fri Dec  5 13:22:32 2003
@@ -703,10 +703,6 @@
 	iounmap(tp->mmio_addr);
 	pci_release_regions(pdev);
 
-	// poison memory before freeing 
-	memset(dev, 0xBC,
-	       sizeof (struct net_device) + sizeof (struct sis190_private));
-
 	free_netdev(dev);
 	pci_set_drvdata(pdev, NULL);
 }

--------------010807080603020208040805--

