Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbUCMAPc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 19:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUCMAPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 19:15:32 -0500
Received: from fmr05.intel.com ([134.134.136.6]:45018 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262690AbUCMAPR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 19:15:17 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: RE[PATCH]2.6.4-rc3 MSI Support for IA64
Date: Fri, 12 Mar 2004 16:14:30 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502404058150@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE[PATCH]2.6.4-rc3 MSI Support for IA64
Thread-Index: AcQIiX+1TYuGVMgLTrOlHifwzmrz9wABGfqQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <davidm@napali.hpl.hp.com>, <grep@kroah.com>, <jgarzik@pobox.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>
X-OriginalArrivalTime: 13 Mar 2004 00:14:30.0953 (UTC) FILETIME=[27D0E190:01C40890]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Zwane Mwaikambo wrote:

>> diff -urN linux-2.6.4-rc3/arch/ia64/kernel/irq_ia64.c linux-2.6.4-rc3-msi/arch/ia64/kernel/irq_ia64.c
>> --- linux-2.6.4-rc3/arch/ia64/kernel/irq_ia64.c	2004-03-09 19:00:26.000000000 -0500
>> +++ linux-2.6.4-rc3-msi/arch/ia64/kernel/irq_ia64.c	2004-03-11 14:52:57.000000000 -0500
>> @@ -60,12 +60,18 @@
>>  int
>>  ia64_alloc_vector (void)
>>  {
>> +#ifdef CONFIG_PCI_USE_VECTOR
>> +	extern int assign_irq_vector(int irq);
>> +
>> +	return assign_irq_vector(AUTO_ASSIGN);
>> +#else
>>  	static int next_vector = IA64_FIRST_DEVICE_VECTOR;
>>
>>  	if (next_vector > IA64_LAST_DEVICE_VECTOR)
>>  		/* XXX could look for sharable vectors instead of panic'ing... */
>>  		panic("ia64_alloc_vector: out of interrupt vectors!");
>>  	return next_vector++;
>> +#endif
>>  }

>This one is slightly confusing readability wise since ia64 already does
>the vector based interrupt numbering. Perhaps CONFIG_PCI_USE_VECTOR should
>really be CONFIG_MSI but that's up to you.
 
Agree. Perhaps we should change CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI.

>I wonder if we could
>consolidate these vector allocators as assign_irq_vector(AUTO_ASSIGN) has
>the same semantics as ia64_alloc_vector() and the one for i386 is also
>almost the same as its MSI ilk.

Agree. Will look into a way to consolidate these vector allocators. 

>> +static inline int vector_resources(void)
>> +{
>> + 	int res;
>> +#ifndef CONFIG_IA64
>> + 	int i, repeat;
>> + 	for (i = NR_REPEATS; i > 0; i--) {
>> + 		if ((FIRST_DEVICE_VECTOR + i * 8) > FIRST_SYSTEM_VECTOR)
>> + 			continue;
>> + 		break;
>> + 	}
>> + 	i++;
>> + 	repeat = (FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR)/i;
>> + 	res = i * repeat - NR_RESERVED_VECTORS + 1;
>>  #else
>> -extern void restore_ioapic_irq_handler(int irq);
>> + 	res = LAST_DEVICE_VECTOR - FIRST_DEVICE_VECTOR - 1;
>>  #endif
>> +
>> + 	return res;
>> +}

>Is this supposed to return number of vectors available for external
>devices? Also regarding vector allocation, assign_irq_vector() in
>drivers/pci/msi.c only can allocate 166 vectors before going -ENOSPC is
>this intentional?

Yes, this serves to return number of vectors available for external 
devices. Regarding vector allocation, you bring up a very good point of 
why assign_irq_vector() in drivers/pci/msi.c allocates only 166 vectors 
before going -ENOSPC. We will look into a way to maximize number of 
vectors without crossing over FIRST_SYSTEM_VECTOR.

Thanks,
Long


