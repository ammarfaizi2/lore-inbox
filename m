Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbVJELXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVJELXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbVJELXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:23:24 -0400
Received: from ozlabs.org ([203.10.76.45]:11145 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932623AbVJELXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:23:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17219.47007.44643.148022@cargo.ozlabs.ibm.com>
Date: Wed, 5 Oct 2005 21:23:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas <linas@austin.ibm.com>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] ppc64: EEH Avoid racing reports of errors
In-Reply-To: <20050930010038.GF6173@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com>
	<20050930010038.GF6173@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas writes:

> 06-eeh-report-race.patch

> +/** Mark all devices that are peers of this device as failed.
> + *  Mark the device driver too, so that it can see the failure
> + *  immediately; this is critical, since some drivers poll
> + *  status registers in interrupts ... If a driver is polling,
> + *  and the slot is frozen, then the driver can deadlock in
> + *  an interrupt context, which is bad.
> + */
> +
> +static inline void __eeh_mark_slot (struct device_node *dn)
> +{
> +	while (dn) {
> +		PCI_DN(dn)->eeh_mode |= EEH_MODE_ISOLATED;
> +
> +		if (dn->child)
> +			__eeh_mark_slot (dn->child);
> +		dn = dn->sibling;
> +	}
> +}

So this does the device node that we pass in, plus all the nodes that
come after it in its parent's list of children.  On that basis I
expected you to pass in the first child of the EADS bridge, but I see:

> +	pe_dn = find_device_pe (dn);
> +	__eeh_mark_slot (pe_dn);

My understanding is that pe_dn will end up pointing to the device node
for the EADS bridge.  Shouldn't you pass in pe_dn->child here, or
alternatively rearrange __eeh_mark_slot to do the node you give it
plus its children (recursively)?

Two other comments about __eeh_mark_slot: (1) despite the comment, the
function doesn't do anything to any pci_dev or pci_driver (not that it
should be touching any pci_driver), and (2) a recursive function can't
really be inline (unless gcc is smart enough to turn arbitrary
recursive functions into iterative functions, which I doubt :).

Regards,
Paul.
