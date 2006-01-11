Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWAKPUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWAKPUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 10:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWAKPUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 10:20:51 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:38596 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750869AbWAKPUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 10:20:50 -0500
Date: Wed, 11 Jan 2006 08:20:50 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       lkml <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
Message-ID: <20060111152050.GC19769@parisc-linux.org>
References: <1135649077.17476.14.camel@sli10-desk.sh.intel.com> <20060103231304.56e3228b.akpm@osdl.org> <1136422680.30655.1.camel@sli10-desk.sh.intel.com> <20060110202841.GZ19769@parisc-linux.org> <1136942240.5750.35.camel@sli10-desk.sh.intel.com> <20060111012625.GA29108@kroah.com> <1136967502.5750.65.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136967502.5750.65.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 04:18:22PM +0800, Shaohua Li wrote:
> +static inline void pci_remove_saved_cap(struct pci_dev *pci_dev,
> +	struct pci_cap_saved_state *cap)
> +{
> +	struct pci_cap_saved_state *last;
> +	last = pci_dev->saved_cap_space;
> +	if (!last)
> +		return;
> +
> +	if (last == cap) {
> +		pci_dev->saved_cap_space = last->next;
> +		return;
> +	}
> +	while (last->next && last->next != cap)
> +		last = last->next;
> +	if (last->next)
> +		last->next = last->next->next;
> +}

I believe the more standard way of doing a singly-linked-list
delete looks like this:

{
        struct pci_cap_saved_state **lastp = &pci_dev->saved_cap_space;

        while (*lastp && *lastp != cap)
                lastp = &(*lastp)->next;
        if (*lastp)
                *lastp = (*lastp)->next;
}

untested, of course.
