Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752084AbWCBXcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbWCBXcy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbWCBXcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:32:54 -0500
Received: from fmr19.intel.com ([134.134.136.18]:27560 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752084AbWCBXcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:32:53 -0500
Subject: Re: [Pcihpd-discuss] [patch] pci hotplug: add common
	acpi	functions to core
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com
In-Reply-To: <44066401.3070207@jp.fujitsu.com>
References: <1141174017.28842.6.camel@whizzy>
	 <44050A17.9030506@jp.fujitsu.com> <1141252941.13333.31.camel@whizzy>
	 <44066401.3070207@jp.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Mar 2006 15:38:31 -0800
Message-Id: <1141342711.913.10.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 02 Mar 2006 23:32:43.0325 (UTC) FILETIME=[9A9336D0:01C63E51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 12:18 +0900, Kenji Kaneshige wrote:
> Kristen Accardi wrote:
> > On Wed, 2006-03-01 at 11:42 +0900, Kenji Kaneshige wrote:
> > 
> >>Hi Kristen,
> >>
> >>Here is one more comment.
> >>
> >>
> >>>+void acpi_get_hp_params_from_firmware(struct pci_dev *dev,
> >>>+		struct hotplug_params *hpp)
> >>>+{
> >>>+	acpi_status status = AE_NOT_FOUND;
> >>>+	struct pci_dev *pdev = dev;
> >>>+
> >>>+	/*
> >>>+	 * _HPP settings apply to all child buses, until another _HPP is
> >>>+	 * encountered. If we don't find an _HPP for the input pci dev,
> >>>+	 * look for it in the parent device scope since that would apply to
> >>>+	 * this pci dev. If we don't find any _HPP, use hardcoded defaults
> >>>+	 */
> >>>+	while (pdev && (ACPI_FAILURE(status))) {
> >>>+		acpi_handle handle = DEVICE_ACPI_HANDLE(&(pdev->dev));
> >>>+		if (!handle)
> >>>+			break;
> >>>+		status = acpi_run_hpp(handle, hpp);
> >>>+		if (!(pdev->bus->parent))
> >>>+			break;
> >>>+		/* Check if a parent object supports _HPP */
> >>>+		pdev = pdev->bus->parent->self;
> >>>+	}
> >>>+}
> >>>+EXPORT_SYMBOL_GPL(acpi_get_hp_params_from_firmware);
> >>
> >>I think the acpi_get_hp_params_from_firmware() function assumes that
> >>users set default hpp parameters into *hpp before calling this function.
> >>I think it is very hard for new users of the function to notice it, so
> >>I think this assumption should be removed.
> >>
> >>Thanks,
> >>Kenji Kaneshige
> >>
> > 
> > 
> > Are you suggesting that we have the defaults set within this function?
> > I would like to change acpiphp to use the same functions to get hpp
> > values eventually (in a different patch), but I notice that acpiphp sets
> > the default cache line size to 8, while shpchp sets the default cache
> > line size to 16.  So it seems like it would be better to allow drivers
> > to set the default themselves, unless one of these drivers is doing the
> > wrong thing and using the wrong default value.
> > 
> 
> The other options are:
> 
>     (a) Leave the code as it is, and put the comments to indicate users
>         how to use this function. That is, users have to set defaults
>         before calling this function, otherwise the parameters returned
>         from the function would be undefined.
> 
>     (b) Change the return value to let users know whether _HPP parameters
>         were successfully parsed.
> 
> I'd prefer (b).
> I'm attaching the sample patch for (b), though I've not tested it at all.
> This patch is against 2.6.16-rc5-mm1 with the following patches applied
> 
>     - shpchp: cleanup bus speed handling
>     - acpiphp: Scan slots under the nested P2P bridge
>     - Your set of patches
> 
> Thanks,
> Kenji Kaneshige
> 

Kenji,
Thanks for the feedback, I will implement (b) as part of my next patch
which also incorporates all the other feedback I've gotten - coming
hopefully tomorrow or so.

Kristen

