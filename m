Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279874AbRJ3FWY>; Tue, 30 Oct 2001 00:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279873AbRJ3FWN>; Tue, 30 Oct 2001 00:22:13 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:13584 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279872AbRJ3FWF>; Tue, 30 Oct 2001 00:22:05 -0500
Message-ID: <3BDE37FC.BBF70C5D@zip.com.au>
Date: Mon, 29 Oct 2001 21:17:48 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: eepro100 quirk with APM suspend on Dell laptops
In-Reply-To: <E15yQd9-0005Rm-00@hoffman.vilain.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> 
> Hi there,
> 
> With the earlier discussion about the eepro100 vs the e100, and with
> hotplug PCI going into the -ac series kernel, I think it's topical I
> discuss an APM related quirk.
> 
> If you buy a Dell Inspiron with the inbuilt ethernet option, you get a PCI
> eepro100.  If you suspend and resume, however, the card seems to be in a
> funny state that an rmmod/modprobe won't fix.
> 
> I worked around the problem, by adding to the APM config this pre-suspend
> action:
> 
>   ifdown eth0
>   rmmod eepro100
> 
> And to the resume action:
> 
>   setpci -s8:4 4=17 5=1 c=8 d=20 11=f0 12=ff 13=fb \
>                14=c1 15=dc 1a=e0 1b=fb 33=fc 3c=b

Heh.  That's inventive.

Does the following (untested) patch fix it?




--- linux-2.4.14-pre5/drivers/net/eepro100.c	Tue Oct  9 21:31:38 2001
+++ linux-akpm/drivers/net/eepro100.c	Mon Oct 29 21:15:52 2001
@@ -497,6 +497,9 @@ struct speedo_private {
 	unsigned short phy[2];				/* PHY media interfaces available. */
 	unsigned short advertising;			/* Current PHY advertised caps. */
 	unsigned short partner;				/* Link partner caps. */
+#ifdef CONFIG_PM
+	u32 pm_state[16];
+#endif
 };
 
 /* The parameters for a CmdConfigure operation.
@@ -2160,8 +2163,11 @@ static void set_rx_mode(struct net_devic
 static int eepro100_suspend(struct pci_dev *pdev, u32 state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
+	struct speedo_private *sp = (struct speedo_private *)dev->priv;
 	long ioaddr = dev->base_addr;
 
+	pci_save_state(pdev, sp->pm_state);
+
 	if (!netif_running(dev))
 		return 0;
 
@@ -2177,6 +2183,8 @@ static int eepro100_resume(struct pci_de
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct speedo_private *sp = (struct speedo_private *)dev->priv;
 	long ioaddr = dev->base_addr;
+
+	pci_restore_state(pdev, sp->pm_state);
 
 	if (!netif_running(dev))
 		return 0;
