Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967279AbWKYWoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967279AbWKYWoO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 17:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967281AbWKYWoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 17:44:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:38072 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S967279AbWKYWoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 17:44:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Ek1Er0Bv4eirUWVup9DS1AckObq81YyueWX8hd/ouJImk2MB8IwfefseOL6q4iztOAhTo5E/STTddO+h3bQZYuGKNt6oHS0kYC6aq1qiqKYnmfdfo1k9vTXfHO7MqLejp2gz3z1M/4kNFPHOPEYp7AbaDfzKCgePZABSwW7Up14=
Date: Sat, 25 Nov 2006 23:43:58 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: kronos.it@gmail.com, Chris Snook <csnook@redhat.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] atl1: Revised Attansic L1 ethernet driver
Message-ID: <20061125224358.GA29403@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121202541.GA23036@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Luca Tettamanti <kronos.it@gmail.com> ha scritto:
> Chris Snook <csnook@redhat.com> ha scritto:
>> 
>> I've been working on this with Jay since his initial submission.  Thanks 
>> to everyone who has provided feedback on the resubmit.  We're currently 
>> quite short on actual testers, since the chip only seems to be on Asus 
>> M2V motherboards at present.  Please let me and Jay know if you have one 
>> of these boards and would like to test and/or have encountered bugs.
> 
> Asus P5B-E also has L1 chip. I'll get the board in a few days and I'll
> test whatever patch you throw at me ;)

Got the board, done some basic testing: so far so good :)

The controller also supports MSI and (at least with my chipset - G965)
it works fine:

218:      80649          0   PCI-MSI-edge      eth1

which is nice, otherwise it ends up sharing the IRQ with SATA and USB.

I also have a small patch:

On probe failure and on removal the device should be disabled:

Signed-Off-By: Luca Tettamanti <kronos.it@gmail.com> 

---
 drivers/net/atl1/atl1_main.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/atl1/atl1_main.c b/drivers/net/atl1/atl1_main.c
index 167e28c..4883111 100644
--- a/drivers/net/atl1/atl1_main.c
+++ b/drivers/net/atl1/atl1_main.c
@@ -2224,14 +2224,14 @@ static int __devinit at_probe(struct pci
 			printk(KERN_DEBUG 
 				"%s: no usable DMA configuration, aborting\n",
  				at_driver_name);
-			return err;
+			goto err_dma;
 		}
 		pci_using_64 = false;
 	}
 	/* Mark all PCI regions associated with PCI device 
 	 * pdev as being reserved by owner at_driver_name */
 	if ((err = pci_request_regions(pdev, at_driver_name)))
-		return err;
+		goto err_request_regions;
 	/* Enables bus-mastering on the device and calls 
 	 * pcibios_set_master to do the needed arch specific settings */
 	pci_set_master(pdev);
@@ -2384,6 +2384,9 @@ static int __devinit at_probe(struct pci
 	free_netdev(netdev);
       err_alloc_etherdev:
 	pci_release_regions(pdev);
+      err_request_regions:
+      err_dma:
+	pci_disable_device(pdev);
 	return err;
 }
 
@@ -2410,6 +2413,7 @@ static void __devexit at_remove(struct p
 	iounmap(adapter->hw.hw_addr);
 	pci_release_regions(pdev);
 	free_netdev(netdev);
+	pci_disable_device(pdev);
 }
 
 static int at_suspend(struct pci_dev *pdev, pm_message_t state)


Luca
-- 
Not an editor command: Wq
