Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161332AbWF0VtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161332AbWF0VtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161334AbWF0VtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:49:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43207 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161332AbWF0VtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:49:01 -0400
Date: Tue, 27 Jun 2006 14:52:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6]  EDAC PCI device to DEVICE cleanup
Message-Id: <20060627145225.054b1e63.akpm@osdl.org>
In-Reply-To: <20060626221558.11917.qmail@web50115.mail.yahoo.com>
References: <20060626221558.11917.qmail@web50115.mail.yahoo.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Thompson <norsk5@yahoo.com> wrote:
>
> From: Doug Thompson <norsk5@xmission.com>
> 
> Change MC drivers from using CVS revision strings for their version number,
> Now each driver has its own local string.
> 
> Remove some PCI dependencies from the core EDAC module.  
> Made the code 'struct device' centric instead of 'struct pci_dev'
> Most of the code changes here are from a patch by Dave Jiang.
> It may be best to eventually move the PCI-specific code into a separate source file.
> 
> ...
>
> --- linux-2.6.17-rc6.orig/drivers/edac/edac_mc.h	2006-06-12 18:17:17.000000000 -0600
> +++ linux-2.6.17-rc6/drivers/edac/edac_mc.h	2006-06-12 18:17:29.000000000 -0600
> @@ -88,6 +88,12 @@
>  #define PCI_VEND_DEV(vend, dev) PCI_VENDOR_ID_ ## vend, \
>  	PCI_DEVICE_ID_ ## vend ## _ ## dev
>  
> +#if defined(CONFIG_X86) && defined(CONFIG_PCI)
> +#define dev_name(dev) pci_name(to_pci_dev(dev))
> +#else
> +#define dev_name(dev) to_platform_device(dev)->name
> +#endif

This looks fishy.  pci_name() should work OK on non-x86?

> +static void do_pci_parity_check(void)
> +{
> +	unsigned long flags;
> +	int before_count;
> +
> +	debugf3("%s()\n", __func__);
> +
> +	if (!check_pci_parity)
> +		return;
> +
> +	before_count = atomic_read(&pci_parity_count);
> +
> +	/* scan all PCI devices looking for a Parity Error on devices and
> +	 * bridges
> +	 */
> +	local_irq_save(flags);
> +	edac_pci_dev_parity_iterator(edac_pci_dev_parity_test);
> +	local_irq_restore(flags);
> +
> +	/* Only if operator has selected panic on PCI Error */
> +	if (panic_on_pci_parity) {
> +		/* If the count is different 'after' from 'before' */
> +		if (before_count != atomic_read(&pci_parity_count))
> +			panic("EDAC: PCI Parity Error");
> +	}
> +}

What is the local_irq_save() attempting to do in there?  It won't provide
any locking-style coverage on SMP..

