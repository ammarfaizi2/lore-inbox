Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVCJNma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVCJNma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 08:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVCJNma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 08:42:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56551 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261721AbVCJNmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 08:42:20 -0500
Date: Thu, 10 Mar 2005 13:42:19 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: jayalk@intworks.biz
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6.11.2 1/1] PCI Allow OutOfRange PIRQ table address
Message-ID: <20050310134219.GE21986@parcelfarce.linux.theplanet.co.uk>
References: <200503101329.j2ADTZU0030146@intworks.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503101329.j2ADTZU0030146@intworks.biz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 05:29:35AM -0800, jayalk@intworks.biz wrote:

Nice work, I like it.  You could make it even prettier:

> diff -uprN -X dontdiff linux-2.6.11.2-vanilla/arch/i386/pci/irq.c linux-2.6.11.2/arch/i386/pci/irq.c
> --- linux-2.6.11.2-vanilla/arch/i386/pci/irq.c	2005-03-10 16:31:25.000000000 +0800
> +++ linux-2.6.11.2/arch/i386/pci/irq.c	2005-03-10 20:43:02.479487640 +0800
> @@ -58,6 +58,35 @@ struct irq_router_handler {
>  int (*pcibios_enable_irq)(struct pci_dev *dev) = NULL;
>  
>  /*
> + *  Check passed address for the PCI IRQ Routing Table signature 
> + *  and perform checksum verification.
> + */
> +
> +static inline struct irq_routing_table * __init pirq_check_routing_table(u8 *addr)
> +{
> +	struct irq_routing_table *rt;
> +	int i;
> +	u8 sum;
> +
> +	rt = (struct irq_routing_table *) addr;

static inline struct irq_routing_table * __init pirq_check_routing_table(unsigned long phys)
{
	struct irq_routing_table *rt = __va(phys);
[...]

> @@ -65,21 +94,16 @@ static struct irq_routing_table * __init
>  {
>  	u8 *addr;

	unsigned long addr;

>  	struct irq_routing_table *rt;
> -	int i;
> -	u8 sum;
>  
> +	if (pirq_table_addr) {
> +		rt = pirq_check_routing_table((u8 *) __va(pirq_table_addr));
> +		if (rt) {
> +			return rt;
> +		}
> +	}

	if (pirq_table_addr) {
		rt = pirq_check_routing_table(pirq_table_addr);
		if (rt)
			return rt;
	}

Should we fall back to searching if someone's specified an address?  If not,
it becomes even simpler:

	if (pirq_table_addr) {
		return pirq_check_routing_table(pirq_table_addr);
	}

>  	for(addr = (u8 *) __va(0xf0000); addr < (u8 *) __va(0x100000); addr += 16) {

This loop would become:

	for (addr = 0xf0000; addr < 0x100000; addr += 16) {

> @@ -27,6 +27,7 @@
>  #define PCI_ASSIGN_ALL_BUSSES	0x4000
>  
>  extern unsigned int pci_probe;
> +extern unsigned int pirq_table_addr;

Completely nitpicking, but I think this should be an unsigned long rather
than an int -- physical addresses are normally expressed in terms of
unsigned long.

> +		pirqaddr=0xAAAAA	[IA-32] Specify the physical address
> +					of the PIRQ table (normally generated
> +					by the BIOS) if it is outside the .  
> +					F0000h-100000h range.

And you even bothered to update the documentation!  This is definitely
a cut above most of the patches I review ;-)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
