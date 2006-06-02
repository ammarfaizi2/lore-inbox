Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWFBV6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWFBV6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWFBV6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:58:30 -0400
Received: from mga05.intel.com ([192.55.52.89]:61542 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030326AbWFBV6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:58:30 -0400
X-IronPort-AV: i="4.05,205,1146466800"; 
   d="scan'208"; a="46210695:sNHT25280381"
Date: Fri, 2 Jun 2006 14:55:13 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Ravinandan Arakali <Ravinandan.Arakali@neterion.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       leonid.grossman@neterion.com, ananda.raju@neterion.com,
       rapuru.sriram@neterion.com
Subject: Re: [PATCH 2.6.16.18] MSI: Proposed fix for MSI/MSI-X load failure
Message-ID: <20060602145512.A13024@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <Pine.GSO.4.10.10606021518500.9289-100000@guinness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.10.10606021518500.9289-100000@guinness>; from Ravinandan.Arakali@neterion.com on Fri, Jun 02, 2006 at 03:21:37PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 03:21:37PM -0400, Ravinandan Arakali wrote:
> 
> Symptoms:
> When a driver is loaded with MSI followed by MSI-X, the load fails indicating 
> that the MSI vector is still active. And vice versa.
> 
> Suspected rootcause:
> This happens inspite of driver calling free_irq() followed by 
> pci_disable_msi/pci_disable_msix. This appears to be a kernel bug 
> wherein the pci_disable_msi and pci_disable_msix calls do not 
> clear/unpopulate the msi_desc data structure that was populated 
> by pci_enable_msi/pci_enable_msix.
> 
The current MSI code actually does this deliberately, not by
accident. It's got a lot of complex code to track devices and
vectors and make sure an enable_msi -> disable -> enable sequence
gives a driver the same vector. It also has policies about
reserving vectors based on potential hotplug activity etc.
Frankly, I've never understood the need for such policies, and
am in the process of removing all of them.

> Proposed fix:
> Free the MSI vector in pci_disable_msi and all allocated MSI-X vectors 
> in pci_disable_msix.
> 
This will break the existing MSI policies. Once you take that away,
a whole lot of additional code and complexity can be removed too.
That's what I'm working on right now, but such a change is likely
too big for -stable.

So, I'm ok with this patch if it actually doesn't break MSI/MSI-X.
Did you try to repeatedly load/unload an MSI capable driver with
this patch? Did you repeatedly try to ifdown/ifup an Ethernet
driver that uses MSI? I'm not in a position to test this today, but
will try it out next week.

thanks,
Rajesh
