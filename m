Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWFHNjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWFHNjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 09:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWFHNjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 09:39:22 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:53214 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964839AbWFHNjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 09:39:20 -0400
Message-ID: <44882787.20901@jp.fujitsu.com>
Date: Thu, 08 Jun 2006 22:35:03 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 3/4] Make Intel e1000 driver legacy I/O port free
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com> <448644A2.7000208@jp.fujitsu.com> <448818BB.6020503@garzik.org>
In-Reply-To: <448818BB.6020503@garzik.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Thank you for reviewing.

Jeff Garzik wrote:
> Kenji Kaneshige wrote:
> 

(snip.)

>>+	INTEL_E1000_ETHERNET_DEVICE(0x1099, E1000_NO_IOPORT),
>>+	INTEL_E1000_ETHERNET_DEVICE(0x109A, E1000_NO_IOPORT),
>>+	INTEL_E1000_ETHERNET_DEVICE(0x10B5, E1000_NO_IOPORT),
>>+	INTEL_E1000_ETHERNET_DEVICE(0x10B9, 0),
>> 	/* required last entry */
>> 	{0,}
>> };
> 
> 
> Why change all the entries?  I would just change the ones with flags...
> 

I'm sorry. I don't understand what you mean. Could you tell me
how should I change?


>>@@ -621,7 +621,14 @@
>> 	int i, err, pci_using_dac;
>> 	uint16_t eeprom_data;
>> 	uint16_t eeprom_apme_mask = E1000_EEPROM_APME;
>>-	if ((err = pci_enable_device(pdev)))
>>+	int bars;
>>+
>>+	if (ent->driver_data & E1000_NO_IOPORT)
>>+		bars = pci_select_bars(pdev, IORESOURCE_MEM);
>>+	else
>>+		bars = pci_select_bars(pdev, IORESOURCE_MEM | IORESOURCE_IO);
>>+
>>+	if ((err = pci_enable_device_bars(pdev, bars)))
>> 		return err;
> 
> 
> NAK, this is an obvious regression.
> 
> pci_enable_device() also powers up the device, and enables irq delivery
> (on e.g. cardbus), and is allowed to do other platform-specific device
> bring-up tasks.
> 

No, those tasks are done through pci_enable_device_bars() called from
pci_enable_device() actually. In addition, I made small changes to
pci_enable_device() and pci_enable_device_bars() in another patch ([PATCH 1/4]).
Now pci_enable_device_bars() just call pci_enable_device_bars() like below:

int
pci_enable_device(struct pci_dev *dev)
{
        int err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
        if (err)
                return err;
        return 0;
}

Please see the following URL about this another patch.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0606.0/1726.html

Thanks,
Kenji Kaneshige

