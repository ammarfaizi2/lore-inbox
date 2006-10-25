Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422774AbWJYQ1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422774AbWJYQ1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 12:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423092AbWJYQ1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 12:27:50 -0400
Received: from mga03.intel.com ([143.182.124.21]:50551 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1422774AbWJYQ1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 12:27:50 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,357,1157353200"; 
   d="scan'208"; a="135749946:sNHT1387604442"
Message-ID: <453F8FEA.7040909@intel.com>
Date: Wed, 25 Oct 2006 09:25:14 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Damien Wyart <damien.wyart@free.fr>
CC: Jean Delvare <khali@linux-fr.org>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: Linux 2.6.19-rc3
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061025132534.df8466c0.khali@linux-fr.org> <20061025120155.GA2436@localhost.localdomain>
In-Reply-To: <20061025120155.GA2436@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2006 16:27:27.0484 (UTC) FILETIME=[75D99BC0:01C6F852]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damien Wyart wrote:
>>> Auke Kok (1):
>>>       e100: fix reboot -f with netconsole enabled
> 
> * Jean Delvare <khali@linux-fr.org> [2006-10-25 13:25]: This one breaks
>> power-off and reboot on my laptop (thanks to git bisect for isolating
>> it). The shutdown freezes after "Shutdown: hda" or "Rebooting".
>> SysRq-p says the CPU is idle. If you need additional information on my
>> config or want me to do more tests, just ask.
> 
> This has already been discussed, a fix has been posted (see recent
> netdev messages) and should be pulled soon into mainline (I guess).
> 

for those interested, here's the fix (which is already pushed to jgarzik)

Cheers,

Auke


diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index d4a2572..815eb29 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -2719,7 +2719,10 @@ static int e100_suspend(struct pci_dev *
  	struct net_device *netdev = pci_get_drvdata(pdev);
  	struct nic *nic = netdev_priv(netdev);

-	netif_poll_disable(nic->netdev);
+#ifdef CONFIG_E100_NAPI
+	if (netif_running(netdev))
+		netif_poll_disable(nic->netdev);
+#endif
  	del_timer_sync(&nic->watchdog);
  	netif_carrier_off(nic->netdev);

@@ -2763,7 +2766,10 @@ static void e100_shutdown(struct pci_dev
  	struct net_device *netdev = pci_get_drvdata(pdev);
  	struct nic *nic = netdev_priv(netdev);

-	netif_poll_disable(nic->netdev);
+#ifdef CONFIG_E100_NAPI
+	if (netif_running(netdev))
+		netif_poll_disable(nic->netdev);
+#endif
  	del_timer_sync(&nic->watchdog);
  	netif_carrier_off(nic->netdev);
