Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWJQVS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWJQVS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWJQVS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:18:58 -0400
Received: from mga03.intel.com ([143.182.124.21]:50008 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1750735AbWJQVS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:18:57 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,321,1157353200"; 
   d="scan'208"; a="132312664:sNHT29934016"
Message-ID: <45354850.6050900@intel.com>
Date: Tue, 17 Oct 2006 14:17:04 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Aleksey Gorelov <dared1st@yahoo.com>
CC: Ryan Richter <ryan@tau.solarneutrino.net>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org,
       auke-jan.h.kok@intel.com, Jesse Brandeburg <jesse.brandeburg@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2 / e1000?
References: <20061017205316.25914.qmail@web83109.mail.mud.yahoo.com>
In-Reply-To: <20061017205316.25914.qmail@web83109.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2006 21:18:55.0949 (UTC) FILETIME=[DA7B97D0:01C6F231]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksey Gorelov wrote:
> 
> --- Ryan Richter <ryan@tau.solarneutrino.net> wrote:
>> 2.6.19-rc1-git9 doesn't work any better for me.  I haven't tried
>> unloading the e1000 module yet.  Since I run the machine off an nfsroot,
>> it will require some creativity to test that.
>>
>> -ryan
> 
> You may try the following patch instead if it's easier for you. It'll likely break suspend stuff,
> but you won't need to play around with modules.
> 
> Aleks.
> 
> --- linux-2.6.19-rc2/drivers/net/e1000/e1000_main.c.orig	2006-10-17 13:36:06.000000000 -0700
> +++ linux-2.6.19-rc2/drivers/net/e1000/e1000_main.c	2006-10-17 13:36:50.000000000 -0700
> @@ -4847,6 +4847,7 @@
>  static void e1000_shutdown(struct pci_dev *pdev)
>  {
>  	e1000_suspend(pdev, PMSG_SUSPEND);
> +	pci_set_power_state(pdev, PCI_D0);
>  }
>  
>  #ifdef CONFIG_NET_POLL_CONTROLLER

I wouldn't do that like this, since e1000_suspend already does a pci_set_power_state() 
right before it exits, and doing two of those closely after another might result in an 
undetermined state.

I would be more interested in forcing D3 state instead of the current 
`pci_set_power_state(pdev, pci_choose_state(pdev, state));` in e1000_suspend, so can you 
try this instead?

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index ce0d35f..30ceeec 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -4793,7 +4793,7 @@ #endif

         pci_disable_device(pdev);

-       pci_set_power_state(pdev, pci_choose_state(pdev, state));
+       pci_set_power_state(pdev, PCI_D3hot);

         return 0;
  }


alternatively, you can try PCI_D3cold or PCI_D0, but setting the device to D0 is a 
no-op: the device is already in D0 at run-time, so that's silly.

In any case: this is not a driver bug, but really (unfortunately) a platform issue, so 
this fix is not suitable for general cases *at all*, and we'd have to validate this 
nasty workaround on all other chipsets that e1000 supports too, something that ain't 
going to happen I'm sure.

constructive: I've just spend some time working with e100+suspend+shutdown+netconsole, 
so I'll audit e1000 for that in the next few weeks and make sure that all works 
properly. Perhaps that yields something for you.

Cheers,

Auke
