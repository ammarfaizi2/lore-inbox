Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVF2ElD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVF2ElD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 00:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVF2ElD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 00:41:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:6050 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262277AbVF2Eko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 00:40:44 -0400
Subject: Re: [PATCH 10/13]: PCI Err: PPC64-specific recovery infrastructure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
In-Reply-To: <20050628235956.GA6455@austin.ibm.com>
References: <20050628235956.GA6455@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 14:34:53 +1000
Message-Id: <1120019694.5133.244.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 18:59 -0500, Linas Vepstas wrote:
>  
>  struct device_node {
>         char    *name;
> @@ -137,9 +138,13 @@ struct device_node {
>         int     devfn;                  /* for pci devices */
>         int     eeh_mode;               /* See eeh.h for possible
> EEH_MODEs */
>         int     eeh_config_addr;
> +       int   eeh_check_count;    /* number of times device driver
> ignored error */
> +       int   eeh_freeze_count;   /* number of times this device froze
> up. */
> +       int   eeh_is_bridge;      /* device is pci-to-pci bridge */
>         int     pci_ext_config_space;   /* for pci devices */
>         struct  pci_controller *phb;    /* for pci devices */
>         struct  iommu_table *iommu_table;       /* for phb's or
> bridges */
> +       u32      config_space[16]; /* saved PCI config space */
>  
>         struct  property *properties;
>         struct  device_node *parent;

Please, do not add crap to struct device_node. It's already bloated
enough and we intend to instead get rid of the stuff in there.

Do you actually need to save the config space at all ? Can't you just
use "assigned-address" property to fill up the BARs again ? As for the
other EEH things, well, we probably need to bite the bullet and do what
we talked about doing for a while, that is split the PCI related junk
out of struct device_node and into a separate structure. We could maybe
at first (to ease the transition) keep a pointer to it in device_node,
and we can create that structure early in pci_dn. That way, we only
really need to add gunk to PCI devices and not to all nodes. Same for
VIO actually.

Ben.


