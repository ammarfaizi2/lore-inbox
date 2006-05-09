Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWEIHwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWEIHwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 03:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWEIHwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 03:52:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12416 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751436AbWEIHwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 03:52:39 -0400
Date: Tue, 9 May 2006 00:49:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <jbeulich@novell.com>
Cc: kristen.c.accardi@intel.com, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Pcihpd-discuss] [PATCH] correct pciehp init recovery
Message-Id: <20060509004958.28b2b243.akpm@osdl.org>
In-Reply-To: <44575154.76E4.0078.0@novell.com>
References: <445249FE.76E4.0078.0@novell.com>
	<1146245903.25490.10.camel@whizzy>
	<44575154.76E4.0078.0@novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <jbeulich@novell.com> wrote:
>
> >>> Kristen Accardi <kristen.c.accardi@intel.com> 28.04.06 19:38 >>>
> >On Fri, 2006-04-28 at 16:59 +0200, Jan Beulich wrote:
> >> Clean up the recovery path from errors during pcie_init().
> >> 
> >It's possible that this driver never actually requested an irq if was in
> >poll mode.  Then you will call free_irq, when what you really want to do
> >is kill the timer that may have been started. 
> 
> Thanks for pointing this out, here's the updated patch:
> 
> Clean up the recovery path from errors during pcie_init().
> 

Well, it does more than clean things up.  It fixes bugs.

Could we have a more accurate and complete changelog please?

> 
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
> @@ -1548,6 +1548,21 @@ int pcie_init(struct controller * ctrl, 
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
> +	if (pciehp_poll_mode)
> +		del_timer_sync(&php_ctlr->int_poll_timer);
> +	else
> +		free_irq(php_ctlr->irq, ctrl);
> +
>  abort_free_ctlr:
>  	pcie_cap_base = saved_cap_base;
>  	kfree(php_ctlr);
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
