Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUDFLJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263767AbUDFLJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:09:11 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:48091 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263769AbUDFLEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:04:54 -0400
Date: Tue, 06 Apr 2004 20:04:49 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: [RFC] readX_check() - Interface for PCI-X error recovery
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux IA64 Mailing List <linux-ia64@vger.kernel.org>
Cc: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Message-id: <0HVQ0051BXG19H@fjmail506.fjmail.jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: EdMax Ver2.85.5F
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,


This is a request for comments.

We are considering about PCI-X error recovery.

What we deal as a problem here is that there is some cases that 
a PCI error which is recoverable by a device driver is only passed to 
a kernel but not to the driver, and that it results a system down 
because the kernel cannot determine a relevant driver which should 
recover the error.
For example, in the case of PCI-X on ia64, PCI write error is recoverable 
because the error is recorded in a status register, and the proper driver 
can read the register after its transaction. However, PCI read error 
become a system down because the error cause a MCA(Machine Check Abort) 
interruption to the kernel instantly, but the kernel has no idea.


We have post our ideas for this recovery before now.
This time, we accede to Linus's idea and reconsider our interfaces.

 Seto: "[RFC] How drivers notice a HW error?" (readX_check() I/F)
   http://marc.theaimsgroup.com/?l=linux-kernel&m=106992207709400&w=2

 Ishii: "[RFC/PATCH, 1/4] readX_check() performance evaluation"
   http://marc.theaimsgroup.com/?l=linux-kernel&m=107525559029806&w=2

 Linus: "Re: [RFC/PATCH, 2/4] readX_check() performance evaluation"
   http://marc.theaimsgroup.com/?l=linux-kernel&m=107525904702681&w=2


We are supposing the use of these interfaces will be in some fundamental 
drivers such as for SCSI or NIC, and now we are working for implementation.

We would appreciate if you point us any problem of this or something you 
noticed about this.


Thanks,

H.Seto

-----

Abstract is as following:


- Resources newly required:

    on struct device:
	error flag
	list of recoverable physical address regions
	pointer to host bridge of the device

    on per_cpu:
	list of currently checking devices


- Interfaces newly required:

    clear_pcix_errors(dev)
	Clear the error flag of the dev, and start to check the device.
	This also clears the status register of its host bridge.

    readX_check(dev,vaddr)
	Read a register of the device mapped to vaddr, and check errors 
	if possible(This is depending on its architecture. In the case of 
	ia64, we can generate a MCA from an error by simple operation to 
	test the read data.)
	If any error happen on the recoverable region, set the error flag.

    read_pcix_errors(dev)
	Return whether here was an error or not referring the error flag in 
	struct device and the status register of the host bridge, and stop 
	checking of the device.

    register_pcix_region(dev,paddr,len)
    unregister_pcix_region(dev)
	Register/Unregister a physical address region that the driver can 
	recover. This function would be in the init/cleanup of the driver.


- Flow

  xx_probe(dev, ...)
  {
    ..
	register_pcix_region(dev,paddr,len);
    ..
  }

  xx_intr()
  {
	spin_lock_irqsave();		/* disable interrupt & preemption */

	clear_pcix_errors(dev);		/* clear error flag */
	{
	  ..
	    x = readX_check(dev, vaddr);
	  ..
	}
	error = read_pcix_errors(dev);	/* read error flag */
	if (error)
		recovery_or_offline(dev);

	spin_lock_irqrestore();		/* enable interrupt & preemption */
  }

  xx_remove()
  {
    ..
	unregister_pcix_region(dev) ;
    ..
  }


- Note

    on clear_pcix_errors():
	If the status of the host bridge indicates an error when it let be 
	clear, it should be cleared after setting each flags of all devices 
	under the bridge. This is for other clear-read block on other cpu.

    on ia64:
	We can generate a MCA from a poisoned data synchronously in 
	readX_check(), so it is required a MCA handler to check the error 
	and deal error flags in struct device.

    on ia32:
	Since ia32's MCE(Machine Check Exception) is asynchronous, it's 
	hard to check errors in readX_check(). So we check it by reading 
	the status register of host bridge in read_pcix_errors().

    on other arch:
	if it is not possible on the arch, do like:
	#ifndef CONFIG_PCI_RECOVERY
	  #define clear_pcix_errors(dev) do { } while (0)
	  #define read_pcix_errors(dev)  (0)
	#endif


