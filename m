Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWD1R2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWD1R2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWD1R2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:28:51 -0400
Received: from mga03.intel.com ([143.182.124.21]:27440 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751429AbWD1R2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:28:50 -0400
X-IronPort-AV: i="4.04,164,1144047600"; 
   d="scan'208"; a="29156525:sNHT50452787"
Subject: Re: [Pcihpd-discuss] [PATCH] correct pciehp init recovery
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Jan Beulich <jbeulich@novell.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <445249FE.76E4.0078.0@novell.com>
References: <445249FE.76E4.0078.0@novell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Apr 2006 10:38:23 -0700
Message-Id: <1146245903.25490.10.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 28 Apr 2006 17:28:49.0086 (UTC) FILETIME=[35E67DE0:01C66AE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 16:59 +0200, Jan Beulich wrote:
> Clean up the recovery path from errors during pcie_init().
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> 
> diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/drivers/pci/hotplug/pciehp_hpc.c
> 2.6.17-rc3-pciehp-init-recovery/drivers/pci/hotplug/pciehp_hpc.c
> --- /home/jbeulich/tmp/linux-2.6.17-rc3/drivers/pci/hotplug/pciehp_hpc.c	2006-04-27 17:49:41.000000000 +0200
> +++ 2.6.17-rc3-pciehp-init-recovery/drivers/pci/hotplug/pciehp_hpc.c	2006-04-28 09:20:55.000000000 +0200
> @@ -1474,7 +1474,7 @@ int pcie_init(struct controller * ctrl, 
>  	rc = hp_register_read_word(pdev, SLOT_CTRL(ctrl->cap_base), temp_word);
>  	if (rc) {
>  		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
> -		goto abort_free_ctlr;
> +		goto abort_free_irq;
>  	}
>  

It's possible that this driver never actually requested an irq if was in
poll mode.  Then you will call free_irq, when what you really want to do
is kill the timer that may have been started. 



>  	intr_enable = intr_enable | PRSN_DETECT_ENABLE;
> @@ -1500,19 +1500,19 @@ int pcie_init(struct controller * ctrl, 
>  	rc = hp_register_write_word(pdev, SLOT_CTRL(ctrl->cap_base), temp_word);
>  	if (rc) {
>  		err("%s : hp_register_write_word SLOT_CTRL failed\n", __FUNCTION__);
> -		goto abort_free_ctlr;
> +		goto abort_free_irq;
>  	}
>  	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), slot_status);
>  	if (rc) {
>  		err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
> -		goto abort_free_ctlr;
> +		goto abort_disable_intr;
>  	}
>  	
>  	temp_word =  0x1F; /* Clear all events */
>  	rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), temp_word);
>  	if (rc) {
>  		err("%s : hp_register_write_word SLOT_STATUS failed\n", __FUNCTION__);
> -		goto abort_free_ctlr;
> +		goto abort_disable_intr;
>  	}
>  	
>  	if (pciehp_force) {
> @@ -1521,7 +1521,7 @@ int pcie_init(struct controller * ctrl, 
>  	} else {
>  		rc = pciehp_get_hp_hw_control_from_firmware(ctrl->pci_dev);
>  		if (rc)
> -			goto abort_free_ctlr;
> +			goto abort_disable_intr;
>  	}
>  
>  	/*  Add this HPC instance into the HPC list */
> @@ -1548,6 +1548,18 @@ int pcie_init(struct controller * ctrl, 
>  	return 0;
>  
>  	/* We end up here for the many possible ways to fail this API.  */
> +abort_disable_intr:
> +	rc = hp_register_read_word(pdev, SLOT_CTRL(ctrl->cap_base), temp_word);
> +	if (!rc) {
> +		temp_word &= ~(intr_enable | HP_INTR_ENABLE);
> +		rc = hp_register_write_word(pdev, SLOT_CTRL(ctrl->cap_base), temp_word);
> +	}
> +	if (rc)
> +		err("%s : disabling interrupts failed\n", __FUNCTION__);
> +
> +abort_free_irq:
> +	free_irq(php_ctlr->irq, ctrl);
> +
>  abort_free_ctlr:
>  	pcie_cap_base = saved_cap_base;
>  	kfree(php_ctlr);
> 
> 
> 
> 
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Pcihpd-discuss mailing list
> Pcihpd-discuss@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/pcihpd-discuss
