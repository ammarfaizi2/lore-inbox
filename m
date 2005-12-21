Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVLUTRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVLUTRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVLUTRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:17:46 -0500
Received: from spirit.analogic.com ([204.178.40.4]:12555 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751163AbVLUTRp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:17:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051221190558.GD2361@parisc-linux.org>
X-OriginalArrivalTime: 21 Dec 2005 19:17:33.0941 (UTC) FILETIME=[32245A50:01C60663]
Content-class: urn:content-classes:message
Subject: Re: [PATCH 2/4] msi vector targeting abstractions
Date: Wed, 21 Dec 2005 14:17:32 -0500
Message-ID: <Pine.LNX.4.61.0512211410200.12572@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/4] msi vector targeting abstractions
Thread-Index: AcYGYzItaAO8sO0hTwOUVPbv6BtP1A==
References: <20051221184337.5003.85653.32527@attica.americas.sgi.com> <20051221184348.5003.7540.53186@attica.americas.sgi.com> <20051221190558.GD2361@parisc-linux.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Matthew Wilcox" <matthew@wil.cx>
Cc: "Mark Maule" <maule@sgi.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "Tony Luck" <tony.luck@intel.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Dec 2005, Matthew Wilcox wrote:

> On Wed, Dec 21, 2005 at 12:42:41PM -0600, Mark Maule wrote:
>>  {
>>  	struct msi_desc *entry;
>> -	struct msg_address address;
>> +	uint32_t address_hi, address_lo;
>
> Don't use uint32_t.  Use u32 instead.
a>

But uint32_t is a correct POSIX type. Why would you smear its
use in the kernel when, in fact, one is not allowed to mix/match
kernel and user headers so it's impossible to pollute namespace?

>> @@ -108,28 +125,38 @@
>>     		if (!(pos = pci_find_capability(entry->dev, PCI_CAP_ID_MSI)))
>>  			return;
>>
>> +		pci_read_config_dword(entry->dev, msi_upper_address_reg(pos),
>> +			&address_hi);
>>  		pci_read_config_dword(entry->dev, msi_lower_address_reg(pos),
>> -			&address.lo_address.value);
>> -		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
>> -		address.lo_address.value |= (cpu_physical_id(dest_cpu) <<
>> -									MSI_TARGET_CPU_SHIFT);
>> -		entry->msi_attrib.current_cpu = cpu_physical_id(dest_cpu);
>> +			&address_lo);
>> +
>> +		msi_callouts.msi_target(vector, dest_cpu,
>> +					&address_hi, &address_lo);
>> +
>> +		pci_write_config_dword(entry->dev, msi_upper_address_reg(pos),
>> +			address_hi);
>>  		pci_write_config_dword(entry->dev, msi_lower_address_reg(pos),
>> -			address.lo_address.value);
>> +			address_lo);
>
> But actually, I don't understand why you don't just pass a msg_address
> pointer to msi_target instead.
>
> (last two points apply throughtout this patch)
>
>>
>> +	(*msi_callouts.msi_teardown)(vector);
>> +
>
> Yuck.  There's a reason C allows you to call through function pointers as if
> they were functions.

The reason is to allow sloppy coding. The patch writer was properly
instructed to dereference function pointers. If you don't like
this "obviously correct" syntax there is no reason to force your
will on others.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
