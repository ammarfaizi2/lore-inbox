Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVJQSxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVJQSxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVJQSxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:53:06 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:33487 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932251AbVJQSxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:53:05 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4353F290.10009@s5r6.in-berlin.de>
Date: Mon, 17 Oct 2005 20:50:56 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
CC: Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@osdl.org>,
       rob@janerob.com
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
References: <20051015185502.GA9940@plato.virtuousgeek.org> <20051017024219.08662190.akpm@osdl.org> <4353770F.3010605@s5r6.in-berlin.de> <200510170930.33530.jbarnes@virtuousgeek.org>
In-Reply-To: <200510170930.33530.jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.471) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
>>Jesse, what DMI_PRODUCT_NAME matches your laptop?
> 
> I'll have to check when I get home, is the relevant info from the "System 
> Information" section of the dmidecode output?

AFAICT yes. Although I wonder if there is a better suited part of the 
DMI table to look at. From what Rob posted, we could simply match 
{DMI_SYS_VENDOR, "TOSHIBA"} && {DMI_PRODUCT_VERSION, "PS5"} which 
probably catches all Satellite 5xxx's. I hope this isn't too general.

I also wonder how 1394 CardBus cards would react on this patch in 
affected Toshibas...

| +	toshiba = dmi_check_system(extra_init_dmi_table);
| +	if (toshiba) {
| +	        PRINT_G(KERN_INFO, "Toshiba %s detected, enabling extra 
initialization code",
| +			dmi_get_system_info(DMI_PRODUCT_NAME));
| +	        dev->current_state = 4;
| +		pci_read_config_word(dev, PCI_CACHE_LINE_SIZE, &toshiba_pcls);
| +	}
...
|	if (pci_enable_device(dev))
|  		FAIL(-ENXIO, "Failed to enable OHCI hardware");
...
| +	if (toshiba) {
| +	        mdelay(10);
| +	        pci_write_config_word(dev, PCI_CACHE_LINE_SIZE, toshiba_pcls);
| +	        pci_write_config_word(dev, PCI_INTERRUPT_LINE, dev->irq);
| +	        pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 
pci_resource_start(dev, 0));
| +	        pci_write_config_dword(dev, PCI_BASE_ADDRESS_1, 
pci_resource_start(dev, 1));
| +	}
...
|	pci_set_master(dev);

-- 
Stefan Richter
-=====-=-=-= =-=- =---=
http://arcgraph.de/sr/
