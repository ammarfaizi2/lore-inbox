Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWALCrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWALCrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWALCrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:47:33 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:37004 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964997AbWALCrd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:47:33 -0500
Date: Wed, 11 Jan 2006 19:47:32 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       lkml <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
Message-ID: <20060112024732.GE19769@parisc-linux.org>
References: <1135649077.17476.14.camel@sli10-desk.sh.intel.com> <20060103231304.56e3228b.akpm@osdl.org> <1136422680.30655.1.camel@sli10-desk.sh.intel.com> <20060110202841.GZ19769@parisc-linux.org> <1136942240.5750.35.camel@sli10-desk.sh.intel.com> <20060111012625.GA29108@kroah.com> <1136967502.5750.65.camel@sli10-desk.sh.intel.com> <20060111155142.GA19828@kroah.com> <1137033060.5750.68.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137033060.5750.68.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 10:30:59AM +0800, Shaohua Li wrote:

Did you not understand my comment about using the hlist functions?

> +struct pci_cap_saved_state {
> +	struct list_head next;

struct hlist_node list;

> +	char cap_nr;
> +	u32 data[0];
> +};

>  	u32		saved_config_space[16]; /* config space saved at suspend time */
> +	struct list_head saved_cap_space; /* extend config space saved at suspend */

struct hlist_head saved_cap_space;

BTW, the comment is confusing and wrong.  Extended config space is
0x100-0xfff.  How about simply:

/* Capabilities saved on suspend */

Or even omit it.  I think it's pretty obvious what "saved_cap_space" is.

> +static inline struct pci_cap_saved_state *pci_find_saved_cap(
> +	struct pci_dev *pci_dev,char cap)
> +{
> +	struct pci_cap_saved_state *tmp;
> +
> +	list_for_each_entry(tmp, &pci_dev->saved_cap_space, next) {

hlist_for_each_entry

> +		if (tmp->cap_nr == cap)
> +			return tmp;
> +	}
> +	return NULL;
> +}
> +
> +static inline void pci_add_saved_cap(struct pci_dev *pci_dev,
> +	struct pci_cap_saved_state *new_cap)
> +{
> +	list_add(&new_cap->next, &pci_dev->saved_cap_space);

hlist_add_head

> +}
> +
> +static inline void pci_remove_saved_cap(struct pci_cap_saved_state *cap)
> +{
> +	list_del(&cap->next);

hlist_del

> +}
> +
>  /*
>   *  For PCI devices, the region numbers are assigned this way:
>   *
> diff -puN drivers/pci/probe.c~msi_save_restore drivers/pci/probe.c
> --- linux-2.6.15-rc5/drivers/pci/probe.c~msi_save_restore	2006-01-12 10:12:00.000000000 +0800
> +++ linux-2.6.15-rc5-root/drivers/pci/probe.c	2006-01-12 10:12:55.000000000 +0800
> @@ -788,6 +788,7 @@ void __devinit pci_device_add(struct pci
>  	/* Fix up broken headers */
>  	pci_fixup_device(pci_fixup_header, dev);
>  
> +	INIT_LIST_HEAD(&dev->saved_cap_space);

and while you could use INIT_HLIST_HEAD, you shouldn't need to since an
empty hlist is NULL.
