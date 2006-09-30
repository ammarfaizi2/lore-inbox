Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWI3InZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWI3InZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWI3InY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:43:24 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:9422 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751152AbWI3InY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:43:24 -0400
In-Reply-To: <20060929001657.6EFE667B8F@ozlabs.org>
References: <20060929001657.6EFE667B8F@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <65FA7A1D-5D74-4ABA-9985-2DB78ABC8685@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Preliminary MPIC MSI backend
Date: Sat, 30 Sep 2006 10:43:20 +0200
To: Michael Ellerman <michael@ellerman.id.au>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A pretty hackish MPIC backend, just enough to flesh out the design.
> Based on code from Segher.

It's pretty alright, and very hackish ;-)  I'll sign off on it,
but some comments...

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

> +static int msi_mpic_check(struct pci_dev *pdev, int num,
> +			struct msix_entry *entries, int type)
> +{
> +	/* The irq allocator needs more work to support MSI-X/multi-MSI */
> +	if (type == PCI_CAP_ID_MSIX || num != 1)
> +		return 1;

I never tested any MSI-X, so maybe keep MSI-X disabled completely
for now?

> +static int msi_mpic_alloc(struct pci_dev *pdev, int num,
> +			struct msix_entry *entries, int type)
> +{
> +	irq_hw_number_t hwirq;
> +	unsigned int virq;
> +
> +	/* We need a smarter allocator for MSI-X/multi-MSI */
> +	hwirq = irq_map[pdev->irq].hwirq;
> +	hwirq += 100;

Yep, that's the main problem with this code.  A sanity check to
make sure the number isn't >= 120 would be good, too.

> +	set_irq_type(virq, IRQ_TYPE_EDGE_RISING);

I also had some code to show MSI IRQs as "MSI" instead of "EDGE"
in /proc/interrupts, maybe you want to add a generic version of
that?  Or maybe you have, and I judt didn't see it.

> +static int msi_mpic_setup_msi_msg(struct pci_dev *pdev,
> +		struct msix_entry *entry, struct msi_msg *msg, int type)
> +{
> +	msg->address_lo = 0xfee00000;	/* XXX What is this value? */
> +	msg->address_hi = 0;
> +	msg->data = pdev->irq | 0x8000;

Lose the | 0x8000 part, that was an old experiment to work around
U3/U4 MPIC brokenness (and it didn't work).

> +static int msi_mpic_init(void)
> +{
> +	/* XXX Do this in mpic_init ? */
> +	pr_debug("mpic_msi_init: Registering MPIC MSI ops.\n");
> +	ppc_md.get_msi_ops = mpic_get_msi_ops;

It's best to do this in the platform code I think.


Segher

