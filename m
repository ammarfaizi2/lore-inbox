Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVCVMOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVCVMOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 07:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVCVMOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 07:14:37 -0500
Received: from fmr18.intel.com ([134.134.136.17]:31939 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261153AbVCVMOb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 07:14:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Date: Tue, 22 Mar 2005 20:13:13 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057501731439@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Thread-Index: AcUuzmZCC5QCVGVVQlK2s3YBI6SL1QACL7IA
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Andrew Morton" <akpm@osdl.org>, <rjw@sisk.pl>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 22 Mar 2005 12:13:14.0954 (UTC) FILETIME=[8637BAA0:01C52ED8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> > Yes, but it is needed. There are many drivers, and they look at
>> > numerical value of PMSG_*. I'm proceeding in steps. I hopefully
killed
>> > all direct accesses to the constants, and will switch constants to
>> > something else... But that is going to be tommorow (need some
sleep).
>> The patches are going to acquire correct PCI device sleep state for
>> suspend/resume. We discussed the issue several months ago. My plan is
we
>> first introduce 'platform_pci_set_power_state', then merge the
>> 'platform_pci_choose_state' patch after Pavel's pm_message_t
conversion
>> finished. Maybe Len mislead my comments.
>>
>> Anyway for the callback, my intend is platform_pci_choose_state
accept
>> the pm_message_t parameter, and it return an 'int', since platform
>> method possibly failed and then pci_choose_state translate the return
>> value to pci_power_t.
>
>You can't just retype around like that. You may want it take
>pci_power_t * as an argument, and then return 0/-ENODEV or something
>like that. But you can't retype between int and pm_message_t...
No, taking pci_power_t as an argument is meaningless. For ACPI, we
should know the exact sleep state, pm_message_t will tell us. But I'm ok
to let it return a pci_power_t, and the failure case returns -ENODEV.

>
>Plus that function should have a documentation somewhere!
I will add it.

>
>> > Could you just revert those two patches? First one is very
>> > wrong. Second one might be fixed, but... See comments below.
>> I think the platform_pci_set_power_state should be ok, did you see it
>> causes oops?
>
>No its just ugly and uses __force in "creative" way. That one can be
>recovered.
Do you mean this?

> +	static int state_conv[] = {
> +		[0] = 0,
> +		[1] = 1,
> +		[2] = 2,
> +		[3] = 3,
> +		[4] = 3
> +	};
> +	int acpi_state = state_conv[(int __force) state];

The table should be
		[PCI_D0] = 0,

I'm not sure, but then could we use state_conv[state] directly? It seems
wrong to me (the array accepts a pci_power_t as index?)

Thanks,
Shaohua
