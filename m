Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUCYSi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 13:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUCYSi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 13:38:27 -0500
Received: from fmr06.intel.com ([134.134.136.7]:57837 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263519AbUCYSiR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 13:38:17 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: RE[PATCH]2.6.5-rc2 MSI Support for IA64
Date: Thu, 25 Mar 2004 10:35:30 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240405818C@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE[PATCH]2.6.5-rc2 MSI Support for IA64
Thread-Index: AcQSQAjl0lIyvon2TTOEyIfyG8KojQAVw0rg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: <davidm@napali.hpl.hp.com>, <jgarzik@pobox.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
       <greg@kroah.com>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 25 Mar 2004 18:35:31.0342 (UTC) FILETIME=[F3D54AE0:01C41297]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane, 

Thanks for your comments. Please let us know what you think of our
comments below:

On Thursday, March 25 Zwane wrote:
> Hi Long,
>
> On Wed, 24 Mar 2004, long wrote:
>
>> 1. Both you and David Mosberger agreed on consolidating the vector
>> allocators as assign_irq_vector(AUTO_ASSIGN) has the same semantics
>> as ia64_alloc_vector(). This patch converts the existing uses of
>> ia64_alloc_vector() to assign_irq_vector(AUTO_ASSIGN).
>>
>> 2. Regarding vector allocation, assign_irq_vector() in existing
>> drivers/pci/msi.c only allocate 166 vectors before going -ENOSPC.
>> This patch modifies the existing function assign_irq_vector() in
>> drivers/pci/msi.c to maximize the number of allocated vectors to
>> 188 before going -ENOSPC.
>
>Nice, i believe that's the maximum.

Thanks for this comment.

>>  static spinlock_t msi_lock = SPIN_LOCK_UNLOCKED;
>>  static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
>
>(tiny nit) We actually don't need the initialiser there.
>
>>  static kmem_cache_t* msi_cachep;
>>
>>  static int pci_msi_enable = 1;
>> -static int nr_alloc_vectors = 0;
>> +static int last_alloc_vector = 0;
>>  static int nr_released_vectors = 0;
>>  static int nr_reserved_vectors = NR_HP_RESERVED_VECTORS;
>>  static int nr_msix_devices = 0;
>
>ditto for all those other statics.

For readability and maintaining purpose, we prefer to have these static
variables defined to their initial states. 

>> +#ifndef CONFIG_IA64
>>  int assign_irq_vector(int irq)
>>  {
>
>We could define this as a weak function with arch override.

Agree. We are thinking of replacing the semantics of assign_irq_vector() 
in existing arch/i386/kernel/io_apic.c with the semantics of 
assign_irq_vector() in drivers/pci/msi.c. With this way, 

+#ifndef CONFIG_IA64
int assign_irq_vector(int irq)
{

is no longer required. If inputs from lkml agree with this approach, 
then we will make the change accordingly.

>> -static inline void restore_ioapic_irq_handler(int irq) {}
>> +static inline int pci_vector_resources(int last, int nr_released)
>> +{
>> +	int count = nr_released;
>> +
>> +#ifndef CONFIG_IA64
>> +	int next = last;
>> +	int offset = (last % 8);
>> +
>> +	while (next < FIRST_SYSTEM_VECTOR) {
>> +		next += 8;
>> +		if (next == SYSCALL_VECTOR)
>> +			continue;
>> +		count++;
>> +		if (next >= FIRST_SYSTEM_VECTOR) {
>> +			if (offset%8) {
>> +				next = FIRST_DEVICE_VECTOR + offset;
>> +				offset++;
>> +				continue;
>> +			}
>> +			count--;
>> +		}
>> +	}
>>  #else
>> -extern void restore_ioapic_irq_handler(int irq);
>> + 	count += (LAST_DEVICE_VECTOR - last);
>>  #endif
>> +
>> +	return count;
>> +}
>
>Can't this (for the !ia64 case) be replaced with;
>
>static int pci_vector_resources(int last, int nr_released)
>{
>	int count = nr_released;
>#ifndef CONFIG_IA64
>	/* subtract 1 for reserved SYSCALL_VECTOR within
>	 * the device vector range
>	 */
>	count = ((FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR) - 1) - nr_released;
>#else
>	count += (LAST_DEVICE_VECTOR - last);
>#endif
>	return count;
>}
>
>current pci_vector_resources() returns strange values when say, last
>vector was 0x39 and nr_released was 2, semantically, shouldn't the return
>value be 187?

Glad you pointed it out. I think the function name pci_vector_resources() 
has a little confusion. The purpose of this function is to return the number
of vectors currently avaiable in the system for any new allocations, not 
already in use. First argument, last, indicates the last vector already 
assigned and second argument, nr_released, indicates the number of vectors
released by devices being hot-removed. 

Regarding your example, the last assigned vector is 0x39, the 
return should be 187 (vectors left available for new allocation) if 
nr_released was 0 (no device is hot-removed). If the device, which claims
vector 0x39 was hot-removed, then nr_released was 1; as a result, 
pci_vector_resources() returns 188. The case of nr_released of 2 was 
impossible. If you think of the better name for this function, we are glad 
to rename it. Please let's know what you think.

Thanks,
Long
