Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272020AbRIVUJA>; Sat, 22 Sep 2001 16:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272062AbRIVUIu>; Sat, 22 Sep 2001 16:08:50 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:64774 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S272020AbRIVUIh>; Sat, 22 Sep 2001 16:08:37 -0400
Message-ID: <3BACEFD5.6EB51CA3@zip.com.au>
Date: Sat, 22 Sep 2001 13:08:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mario Vanoni <vanonim@dial.eunet.ch>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-pre13aa1 & 2.4.9-pre14: SMP + 3c59x: feature/bug?
In-Reply-To: <3BACF2E7.3AFC201E@dial.eunet.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Vanoni wrote:
> 
> Dual SMP PIII550 BX400 1024MB mem
> according "Documentation/Changes" all >= update.
> 
> Both kernels compiled *_without_* modules:
> lilo.conf with append="ether=0,0,3,eth0".
> Ethernet doesn't work anymore,
> with 2.2.19pre#aa#, 2.2.20pre#aa# perfect.
> 
> Both kernels compiled with 3c59x as module:
> modules.conf:
> alias eth0 3c59x
> options 3c59x options=3
> obviously without append in lilo.conf.
> Ethernet works as usual.
> 
> No difference on all other application.

Net drivers which use the new alloc_etherdev API do not
support the `ether=' kernel boot option.

Going back to the old init_etherdev() API will make it
work again.

--- linux-2.4.10-pre14/drivers/net/3c59x.c	Sat Sep 22 10:41:53 2001
+++ linux-akpm/drivers/net/3c59x.c	Sat Sep 22 12:59:07 2001
@@ -984,7 +984,7 @@ static int __devinit vortex_probe1(struc
 
 	print_name = pdev ? pdev->slot_name : "3c59x";
 
-	dev = alloc_etherdev(sizeof(*vp));
+	dev = init_etherdev(NULL, sizeof(*vp));
 	retval = -ENOMEM;
 	if (!dev) {
 		printk (KERN_ERR PFX "unable to allocate etherdev, aborting\n");
@@ -1328,9 +1328,6 @@ static int __devinit vortex_probe1(struc
  		pci_save_state(vp->pdev, vp->power_state);
  		acpi_set_WOL(dev);
 	}
-	retval = register_netdev(dev);
-	if (retval == 0)
-		return 0;
 
 free_ring:
 	pci_free_consistent(pdev,
@@ -1341,6 +1338,7 @@ free_ring:
 free_region:
 	if (vp->must_free_region)
 		release_region(ioaddr, vci->io_size);
+	unregister_netdevice(dev);
 	kfree (dev);
 	printk(KERN_ERR PFX "vortex_probe1 fails.  Returns %d\n", retval);
 out:
