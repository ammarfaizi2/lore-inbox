Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWCAWgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWCAWgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWCAWgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:36:55 -0500
Received: from fmr17.intel.com ([134.134.136.16]:5279 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751099AbWCAWgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:36:54 -0500
Subject: Re: [Pcihpd-discuss] [patch] pci hotplug: add common acpi
	functions to core
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com
In-Reply-To: <44050A17.9030506@jp.fujitsu.com>
References: <1141174017.28842.6.camel@whizzy>
	 <44050A17.9030506@jp.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Mar 2006 14:42:21 -0800
Message-Id: <1141252941.13333.31.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 01 Mar 2006 22:36:37.0763 (UTC) FILETIME=[9A217530:01C63D80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 11:42 +0900, Kenji Kaneshige wrote:
> Hi Kristen,
> 
> Here is one more comment.
> 
> > +void acpi_get_hp_params_from_firmware(struct pci_dev *dev,
> > +		struct hotplug_params *hpp)
> > +{
> > +	acpi_status status = AE_NOT_FOUND;
> > +	struct pci_dev *pdev = dev;
> > +
> > +	/*
> > +	 * _HPP settings apply to all child buses, until another _HPP is
> > +	 * encountered. If we don't find an _HPP for the input pci dev,
> > +	 * look for it in the parent device scope since that would apply to
> > +	 * this pci dev. If we don't find any _HPP, use hardcoded defaults
> > +	 */
> > +	while (pdev && (ACPI_FAILURE(status))) {
> > +		acpi_handle handle = DEVICE_ACPI_HANDLE(&(pdev->dev));
> > +		if (!handle)
> > +			break;
> > +		status = acpi_run_hpp(handle, hpp);
> > +		if (!(pdev->bus->parent))
> > +			break;
> > +		/* Check if a parent object supports _HPP */
> > +		pdev = pdev->bus->parent->self;
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_get_hp_params_from_firmware);
> 
> I think the acpi_get_hp_params_from_firmware() function assumes that
> users set default hpp parameters into *hpp before calling this function.
> I think it is very hard for new users of the function to notice it, so
> I think this assumption should be removed.
> 
> Thanks,
> Kenji Kaneshige
> 

Are you suggesting that we have the defaults set within this function?
I would like to change acpiphp to use the same functions to get hpp
values eventually (in a different patch), but I notice that acpiphp sets
the default cache line size to 8, while shpchp sets the default cache
line size to 16.  So it seems like it would be better to allow drivers
to set the default themselves, unless one of these drivers is doing the
wrong thing and using the wrong default value.


