Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVFHSLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVFHSLq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 14:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVFHSLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 14:11:46 -0400
Received: from postino2.roma1.infn.it ([141.108.26.25]:34201 "EHLO
	postino2.roma1.infn.it") by vger.kernel.org with ESMTP
	id S261456AbVFHSLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 14:11:40 -0400
Message-ID: <42A734D8.5000909@roma1.infn.it>
Date: Wed, 08 Jun 2005 20:11:36 +0200
From: Davide Rossetti <davide.rossetti@roma1.infn.it>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karsten Keil <kkeil@suse.de>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix tulip suspend/resume
References: <20050606224645.GA23989@pingi3.kke.suse.de> <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org> <20050607025054.GC3289@neo.rr.com> <20050607105552.GA27496@pingi3.kke.suse.de> <20050607205800.GB8300@neo.rr.com> <20050608063940.GA31237@pingi3.kke.suse.de>
In-Reply-To: <20050608063940.GA31237@pingi3.kke.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.6.8.20
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Looks OK and also work on my HW.
>
>Andrew, can you please take this updated version, it is much cleaner and
>safer, because it handle the IRQ correctly.
>
>  
>
>>--- a/drivers/net/tulip/tulip_core.c	2005-05-27 22:06:00.000000000 -0400
>>+++ b/drivers/net/tulip/tulip_core.c	2005-06-07 16:34:13.641177456 -0400
>>@@ -1756,11 +1756,19 @@
>> {
>> 	struct net_device *dev = pci_get_drvdata(pdev);
>> 
>>-	if (dev && netif_running (dev) && netif_device_present (dev)) {
>>-		netif_device_detach (dev);
>>-		tulip_down (dev);
>>-		/* pci_power_off(pdev, -1); */
>>-	}
>>+	if (!dev)
>>+		return -EINVAL;
>>+
>>+	if (netif_running(dev))
>>+		tulip_down(dev);
>>+
>>+	netif_device_detach(dev);
>>+	pci_save_state(pdev);
>>+
>>+	free_irq(dev->irq, dev);
>>    
>>
isn't it safer to swap these last two guys ?? in theory there could be 
an IRQ betwen pci_save_state() and free_irq()...

>>+	pci_disable_device(pdev);
>>+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
>>+
>> 	return 0;
>> }
>> 
>>    
>>
regards

