Return-Path: <linux-kernel-owner+w=401wt.eu-S1751654AbXAUVYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbXAUVYl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 16:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbXAUVYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 16:24:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:37309 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbXAUVYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 16:24:40 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=gUoe74rcFGvPoeT3azqJms4nw0uUICfa0jrAc4zgwdnuMOt6j3D9kOSPC9KE8xAx4DJYbjZEDVRipt1oqIYlwwc2YIJWuAnMG1X/OjOvJP0PBOMsZGr5Tqowa4Ksizndj2rjlk0aWy8QW8prIz/KDTnmjmcs1K1htgRsmEVTOMM=
Date: Sun, 21 Jan 2007 21:22:09 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrei Popa <andrei.popa@i-neo.ro>
Cc: linux-kernel@vger.kernel.org, nigel@suspend2.net
Subject: Re: [BUG] eth0 appers many times in /proc/interrupts after resume
Message-ID: <20070121212209.GB8958@slug>
References: <1167520557.2566.23.camel@nigel.suspend2.net> <1167571281.7175.1.camel@localhost> <1167599458.2662.8.camel@nigel.suspend2.net> <1167605481.12328.0.camel@localhost> <1167607994.2662.39.camel@nigel.suspend2.net> <1167644970.7142.6.camel@localhost> <1168317278.6948.9.camel@nigel.suspend2.net> <1168448689.7430.1.camel@localhost> <1168463852.3205.1.camel@nigel.suspend2.net> <1169407062.1932.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169407062.1932.4.camel@localhost>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2007 at 09:17:41PM +0200, Andrei Popa wrote:
> It's the 10th resume and in /proc/interrupts eth0 appers 10 times.
> 
Hi,

The e100_resume() function should be calling netif_device_detach and
free_irq. Could you try the following (compile tested) patch?

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index 2fe0445..0c376e4 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -2671,6 +2671,7 @@ static int e100_suspend(struct pci_dev *pdev, pm_message_t state)
 	del_timer_sync(&nic->watchdog);
 	netif_carrier_off(nic->netdev);
 
+	netif_device_detach(netdev);
 	pci_save_state(pdev);
 
 	if ((nic->flags & wol_magic) | e100_asf(nic)) {
@@ -2682,6 +2683,7 @@ static int e100_suspend(struct pci_dev *pdev, pm_message_t state)
 	}
 
 	pci_disable_device(pdev);
+	free_irq(pdev->irq, netdev);
 	pci_set_power_state(pdev, PCI_D3hot);
 
 	return 0;
