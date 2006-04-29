Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWD2CvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWD2CvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 22:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWD2CvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 22:51:23 -0400
Received: from mga06.intel.com ([134.134.136.21]:25451 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932383AbWD2CvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 22:51:21 -0400
X-IronPort-AV: i="4.04,165,1144047600"; 
   d="scan'208"; a="29254994:sNHT19960269"
Subject: Re: [PATCH] PCI Error Recovery: e100 network device driver
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, john.ronciak@intel.com,
       jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com
In-Reply-To: <20060406222359.GA30037@austin.ibm.com>
References: <20060406222359.GA30037@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1146278903.4314.145.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Sat, 29 Apr 2006 10:48:23 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 06:24, Linas Vepstas wrote:
> Please apply and forward upstream.
> 
> --linas
> 
> [PATCH] PCI Error Recovery: e100 network device driver
> 
> Various PCI bus errors can be signaled by newer PCI controllers.  This
> patch adds the PCI error recovery callbacks to the intel ethernet e100
> device driver. The patch has been tested, and appears to work well.
> 
> Signed-off-by: Linas Vepstas <linas@linas.org>
> Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
I am enabling PCI-Express AER (Advanced Error Reporting) in kernel and
glad to see many drivers to support pci error handling.


> 
> ----
> 
>  drivers/net/e100.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 65 insertions(+)
> 
> Index: linux-2.6.17-rc1/drivers/net/e100.c
> ===================================================================
> --- linux-2.6.17-rc1.orig/drivers/net/e100.c	2006-04-05 09:56:06.000000000 -0500
> +++ linux-2.6.17-rc1/drivers/net/e100.c	2006-04-06 15:17:29.000000000 -0500
> @@ -2781,6 +2781,70 @@ static void e100_shutdown(struct pci_dev
>  }
>  
> 
> +/* ------------------ PCI Error Recovery infrastructure  -------------- */
> +/** e100_io_error_detected() is called when PCI error is detected */
> +static pci_ers_result_t e100_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
> +{
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +
> +	/* Same as calling e100_down(netdev_priv(netdev)), but generic */
> +	netdev->stop(netdev);
e100 stop method e100_close calls e100_down which would do IO. Does it
violate the rule defined in Documentation/pci-error-recovery.txt that
error_detected shouldn't do any IO?
Suggest to create a new function, such like e100_close_noreset.


> +
> +	/* Detach; put netif into state similar to hotplug unplug */
> +	netif_poll_enable(netdev);
> +	netif_device_detach(netdev);
> +
> +	/* Request a slot reset. */
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}
> +
> +/** e100_io_slot_reset is called after the pci bus has been reset.
> + *  Restart the card from scratch. */
> +static pci_ers_result_t e100_io_slot_reset(struct pci_dev *pdev)
> +{
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct nic *nic = netdev_priv(netdev);
> +
> +	if(pci_enable_device(pdev)) {
> +		printk(KERN_ERR "e100: Cannot re-enable PCI device after reset.\n");
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +	pci_set_master(pdev);
> +
> +	/* Only one device per card can do a reset */
> +	if (0 != PCI_FUNC (pdev->devfn))
> +		return PCI_ERS_RESULT_RECOVERED;
> +	e100_hw_reset(nic);
> +	e100_phy_init(nic);
Should pci_set_master be called after e100_hw_reset like in function
e100_probe?


> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +/** e100_io_resume is called when the error recovery driver
> + *  tells us that its OK to resume normal operation.
> + */
> +static void e100_io_resume(struct pci_dev *pdev)
> +{
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct nic *nic = netdev_priv(netdev);
> +
> +	/* ack any pending wake events, disable PME */
> +	pci_enable_wake(pdev, 0, 0);
> +
> +	netif_device_attach(netdev);
> +	if(netif_running(netdev)) {
> +		e100_open (netdev);
> +		mod_timer(&nic->watchdog, jiffies);
e100_open calls e100_up which already sets watchdog timer. Why to set
it again?

> +	}
> +}
> +
