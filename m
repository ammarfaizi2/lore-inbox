Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbUKOIxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUKOIxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 03:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUKOIxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 03:53:23 -0500
Received: from fmr05.intel.com ([134.134.136.6]:39903 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261552AbUKOIxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 03:53:13 -0500
Subject: Re: [PATCH]eepro100 resume failure
From: Li Shaohua <shaohua.li@intel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1100508226.2936.11.camel@laptop.fenrus.org>
References: <1100507449.31599.9.camel@sli10-desk.sh.intel.com>
	 <1100508226.2936.11.camel@laptop.fenrus.org>
Content-Type: multipart/mixed; boundary="=-K3GhbEBzP+DZFLNcypwd"
Message-Id: <1100508410.32025.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 15 Nov 2004 16:46:50 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-K3GhbEBzP+DZFLNcypwd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-11-15 at 16:43, Arjan van de Ven wrote:
> >  
> > @@ -2337,7 +2337,12 @@ static int eepro100_resume(struct pci_de
> >  	struct speedo_private *sp = netdev_priv(dev);
> >  	long ioaddr = dev->base_addr;
> >  
> > +	pci_set_power_state(pdev, 0);
> >  	pci_restore_state(pdev);
> > +	if (pdev->is_enabled)
> > +		pci_enable_device(pdev);
> > +	if (pdev->is_busmaster)
> > +		pci_set_master(pdev);
> 
> this is wrong; the driver should KNOW the device is enabled; no reason
> to check for is_enabled. Same for is_busmaster...
Oh, yes. The check isn't required. Updated one.

Thanks,
Shaohua

---

 2.6-root/drivers/net/eepro100.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN drivers/net/eepro100.c~eepro100-pm drivers/net/eepro100.c
--- 2.6/drivers/net/eepro100.c~eepro100-pm	2004-11-15 16:06:22.500880880 +0800
+++ 2.6-root/drivers/net/eepro100.c	2004-11-15 16:40:47.211997080 +0800
@@ -2327,7 +2327,8 @@ static int eepro100_suspend(struct pci_d
 	netif_device_detach(dev);
 	outl(PortPartialReset, ioaddr + SCBPort);
 	
-	/* XXX call pci_set_power_state ()? */
+	pci_disable_device(pdev);
+	pci_set_power_state (pdev, 3);
 	return 0;
 }
 
@@ -2337,7 +2338,10 @@ static int eepro100_resume(struct pci_de
 	struct speedo_private *sp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
+	pci_set_power_state(pdev, 0);
 	pci_restore_state(pdev);
+	pci_enable_device(pdev);
+	pci_set_master(pdev);
 
 	if (!netif_running(dev))
 		return 0;
_


--=-K3GhbEBzP+DZFLNcypwd
Content-Disposition: attachment; filename=eepro100-pm.patch
Content-Type: text/x-patch; name=eepro100-pm.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit



---

 2.6-root/drivers/net/eepro100.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN drivers/net/eepro100.c~eepro100-pm drivers/net/eepro100.c
--- 2.6/drivers/net/eepro100.c~eepro100-pm	2004-11-15 16:06:22.500880880 +0800
+++ 2.6-root/drivers/net/eepro100.c	2004-11-15 16:40:47.211997080 +0800
@@ -2327,7 +2327,8 @@ static int eepro100_suspend(struct pci_d
 	netif_device_detach(dev);
 	outl(PortPartialReset, ioaddr + SCBPort);
 	
-	/* XXX call pci_set_power_state ()? */
+	pci_disable_device(pdev);
+	pci_set_power_state (pdev, 3);
 	return 0;
 }
 
@@ -2337,7 +2338,10 @@ static int eepro100_resume(struct pci_de
 	struct speedo_private *sp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
+	pci_set_power_state(pdev, 0);
 	pci_restore_state(pdev);
+	pci_enable_device(pdev);
+	pci_set_master(pdev);
 
 	if (!netif_running(dev))
 		return 0;
_

--=-K3GhbEBzP+DZFLNcypwd--

