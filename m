Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVCKMo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVCKMo5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 07:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVCKMo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 07:44:57 -0500
Received: from v-1635.easyco.net ([69.26.169.185]:11780 "EHLO
	mail.intworks.biz") by vger.kernel.org with ESMTP id S261392AbVCKMov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 07:44:51 -0500
Date: Fri, 11 Mar 2005 04:44:30 -0800 (PST)
From: jayalk@intworks.biz
To: Matthew Wilcox <matthew@wil.cx>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6.11.2 1/1] PCI Allow OutOfRange PIRQ table address
In-Reply-To: <20050310134219.GE21986@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0503110421050.30843@intworks.biz>
References: <200503101329.j2ADTZU0030146@intworks.biz>
 <20050310134219.GE21986@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, 10 Mar 2005, Matthew Wilcox wrote:
>> +extern unsigned int pirq_table_addr;
>
> Completely nitpicking, but I think this should be an unsigned long rather
> than an int -- physical addresses are normally expressed in terms of
> unsigned long.

Yup, good point, I'll fix that.

> Should we fall back to searching if someone's specified an address?  If not,
> it becomes even simpler:

I think it'd be a failsafe in the case where someone mistakenly copied
an incorrect or mistaken boot loader config. I'll add a warning in that case
so that the user can see that there's been a problem.

>>  	for(addr = (u8 *) __va(0xf0000); addr < (u8 *) __va(0x100000); addr += 16) {
>
> This loop would become:
>
> 	for (addr = 0xf0000; addr < 0x100000; addr += 16) {
>

I prefered the former since the __va conversion only gets done for those
initial addresses rather than throughout the loop. I think the
check_routing... should use va addr not phys, for subjective reasons, feels
cleaner, I guess. I'll deferr to whatever the norm is. Let me know.

Thanks for the feedback.

jayakumar

>
>
> On Thu, Mar 10, 2005 at 05:29:35AM -0800, jayalk@intworks.biz wrote:
>
> Nice work, I like it.  You could make it even prettier:
>
>> diff -uprN -X dontdiff linux-2.6.11.2-vanilla/arch/i386/pci/irq.c linux-2.6.11.2/arch/i386/pci/irq.c
>> --- linux-2.6.11.2-vanilla/arch/i386/pci/irq.c	2005-03-10 16:31:25.000000000 +0800
>> +++ linux-2.6.11.2/arch/i386/pci/irq.c	2005-03-10 20:43:02.479487640 +0800
>> @@ -58,6 +58,35 @@ struct irq_router_handler {
>>  int (*pcibios_enable_irq)(struct pci_dev *dev) = NULL;
>>
>>  /*
>> + *  Check passed address for the PCI IRQ Routing Table signature
>> + *  and perform checksum verification.
>> + */
>> +
>> +static inline struct irq_routing_table * __init pirq_check_routing_table(u8 *addr)
>> +{
>> +	struct irq_routing_table *rt;
>> +	int i;
>> +	u8 sum;
>> +
>> +	rt = (struct irq_routing_table *) addr;
>
> static inline struct irq_routing_table * __init pirq_check_routing_table(unsigned long phys)
> {
> 	struct irq_routing_table *rt = __va(phys);
> [...]
>
>> @@ -65,21 +94,16 @@ static struct irq_routing_table * __init
>>  {
>>  	u8 *addr;
>
> 	unsigned long addr;
>
>>  	struct irq_routing_table *rt;
>> -	int i;
>> -	u8 sum;
>>
>> +	if (pirq_table_addr) {
>> +		rt = pirq_check_routing_table((u8 *) __va(pirq_table_addr));
>> +		if (rt) {
>> +			return rt;
>> +		}
>> +	}
>
> 	if (pirq_table_addr) {
> 		rt = pirq_check_routing_table(pirq_table_addr);
> 		if (rt)
> 			return rt;
> 	}
>
> Should we fall back to searching if someone's specified an address?  If not,
> it becomes even simpler:
>
> 	if (pirq_table_addr) {
> 		return pirq_check_routing_table(pirq_table_addr);
> 	}
>
>>  	for(addr = (u8 *) __va(0xf0000); addr < (u8 *) __va(0x100000); addr += 16) {
>
> This loop would become:
>
> 	for (addr = 0xf0000; addr < 0x100000; addr += 16) {
>
>> @@ -27,6 +27,7 @@
>>  #define PCI_ASSIGN_ALL_BUSSES	0x4000
>>
>>  extern unsigned int pci_probe;
>> +extern unsigned int pirq_table_addr;
>
> Completely nitpicking, but I think this should be an unsigned long rather
> than an int -- physical addresses are normally expressed in terms of
> unsigned long.
>
>> +		pirqaddr=0xAAAAA	[IA-32] Specify the physical address
>> +					of the PIRQ table (normally generated
>> +					by the BIOS) if it is outside the .
>> +					F0000h-100000h range.
>
> And you even bothered to update the documentation!  This is definitely
> a cut above most of the patches I review ;-)
>
>
