Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbUDGCJT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 22:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263450AbUDGCJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 22:09:19 -0400
Received: from palrel11.hp.com ([156.153.255.246]:25808 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263444AbUDGCJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 22:09:08 -0400
Date: Tue, 6 Apr 2004 19:08:43 -0700
From: Grant Grundler <iod00d@hp.com>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux IA64 Mailing List <linux-ia64@vger.kernel.org>,
       Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Subject: Re: [RFC] readX_check() - Interface for PCI-X error recovery
Message-ID: <20040407020843.GE10560@cup.hp.com>
References: <0HVQ0051BXG19H@fjmail506.fjmail.jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0HVQ0051BXG19H@fjmail506.fjmail.jp.fujitsu.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 08:04:49PM +0900, Hidetoshi Seto wrote:
...
> - Resources newly required:
> 
>     on struct device:
> 	error flag
> 	list of recoverable physical address regions

I think willy already pointed out the struct pci_dev->resources[] should point 
to MMIO adress ranges the PCI(-X) device "owns".

> 	pointer to host bridge of the device

ditto. I think willy meant walk pci_dev->bus->parent until bus->self
is NULL normally should work.

>     on per_cpu:
> 	list of currently checking devices

Why wouldn't this be per PCI host bus controller instead of per CPU?

I'm thinking SMP - any CPU could access any MMIO region.
How those MMIO addresses get routed depends on how PCI Host Bus
controllers are programmed. Ie Bridges have to route MMIO transactions
to children (PCI devices).

> - Interfaces newly required:
> 
>     clear_pcix_errors(dev)
> 	Clear the error flag of the dev, and start to check the device.
> 	This also clears the status register of its host bridge.
> 
>     readX_check(dev,vaddr)
> 	Read a register of the device mapped to vaddr, and check errors 
> 	if possible(This is depending on its architecture. In the case of 
> 	ia64, we can generate a MCA from an error by simple operation to 
> 	test the read data.)
> 	If any error happen on the recoverable region, set the error flag.
>
>     read_pcix_errors(dev)
> 	Return whether here was an error or not referring the error flag in 
> 	struct device and the status register of the host bridge, and stop 
> 	checking of the device.
> 
>     register_pcix_region(dev,paddr,len)
>     unregister_pcix_region(dev)
> 	Register/Unregister a physical address region that the driver can 
> 	recover. This function would be in the init/cleanup of the driver.

Could register/unregister functionality be part of the clear/read errors?

> 
> 
> - Flow
> 
>   xx_probe(dev, ...)
>   {
>     ..
> 	register_pcix_region(dev,paddr,len);
>     ..
>   }
> 
>   xx_intr()
>   {
> 	spin_lock_irqsave();		/* disable interrupt & preemption */
> 
> 	clear_pcix_errors(dev);		/* clear error flag */
> 	{
> 	  ..
> 	    x = readX_check(dev, vaddr);
> 	  ..
> 	}
> 	error = read_pcix_errors(dev);	/* read error flag */
> 	if (error)
> 		recovery_or_offline(dev);
> 
> 	spin_lock_irqrestore();		/* enable interrupt & preemption */

Holding the spinlock might not be realistic for most drivers
during a recovery - ie re-init the HW. I understand this is a
generic example but it's a bit too simple...


...
>     on other arch:
> 	if it is not possible on the arch, do like:
> 	#ifndef CONFIG_PCI_RECOVERY
> 	  #define clear_pcix_errors(dev) do { } while (0)
> 	  #define read_pcix_errors(dev)  (0)
> 	#endif

And need similar for the register/unregister/readX_check() calls.

thanks,
grant
