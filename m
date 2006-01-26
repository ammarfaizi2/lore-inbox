Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWAZQrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWAZQrc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWAZQrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:47:32 -0500
Received: from fmr21.intel.com ([143.183.121.13]:46226 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751160AbWAZQrb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:47:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/2] _PPC frequency change issues
Date: Thu, 26 Jan 2006 08:47:00 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB600706F90C@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] _PPC frequency change issues
Thread-Index: AcYh2AlLexYcLgynTiGO5llVrul8VgAv+7aQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Thomas Renninger" <trenn@suse.de>, <cpufreq@lists.linux.org.uk>,
       "Dave Jones" <davej@redhat.com>
Cc: "Dominik Brodowski" <linux@brodo.de>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jan 2006 16:47:07.0411 (UTC) FILETIME=[24C82E30:01C62298]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Acked. 
Dave: can you please pick up these two patches.

Thanks,
Venki 

>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de] 
>Sent: Wednesday, January 25, 2006 9:51 AM
>To: cpufreq@lists.linux.org.uk; Pallipadi, Venkatesh
>Cc: Dominik Brodowski; Kernel Mailing List
>Subject: Re: [PATCH 1/2] _PPC frequency change issues
>
>On Tuesday 24 January 2006 17:35, Thomas Renninger wrote:
>> On Dell600/800 machines:
>>
>> When unplugging the AC adapter on these machines
>> following happens in BIOS:
>>
>> - ACPI processor event fired, frequencies get limited
>>  to the lowest one(600 MHz) and BIOS already sets lowest freq.
>> - when waiting about 10 seconds another ACPI processor  event
>>  is fired, and all frequencies are available again,
>>  highest freq(1700 MHz) is set.
>> - when plugging in ac adapter before waiting 10 seconds
>>  ACPI processor event is happening immediately and all
>>  frequencies are available again, highest freq(1700 MHz) is set.
>>
>>
>> I found these bugs in kernel:
>>
>> - speedstep centrino driver does not recognise that BIOS
>> changed the frequency behind it's back.
>> It tells you that 600 MHz are already set, and does not invoke
>> PRE/POST transition validation.  On next frequency settings,
>> the frequency is "out_of_sync" and
>> the validater assumes 600 MHz and the frequency stays there.
>>
>> Patch [1/2]
>>
>> - userspace governor is using its own cpufreq_policy struct and
>> forgets to set max_frequency there in 
>> cpufreq_governor_userspace(CPUFREQ_GOV_LIMITS) That results in
>> scaling_setspeed staying high in sysfs even the
>> frequency has been lowered on _PPC change.
>> When _PPC allows all frequencies again, the userspace governor
>> uses it's own policy_struct with the old max value again (now the
>> low one) and the frequency still stays at lowest frequency.
>> Also the userspace governor need not to hold it's own cpufreq_policy,
>> better make use of the global core policy, save some memory and
>> avoid to forget any struct member to be copied.
>>
>> Patch [2/2]
>>
>> I tested with ondemand and userspace governor on a speedstep-centrino
>> system, both governors had problems with but should work fine now,
>> whether _PPC (or whatever ACPI function) prechanges the freq or not.
>> The first patch fixes the ondemand governor working properly again,
>> the second is also needed to make the userspace governor 
>working on these
>> machines.
>>
>> Could someone please review and apply.
>>
>Corrected indentation and a whitespace...
>I also heard about weird behaviour on Dell Inspiron 8600 
>(1.5GHz Centrino) and 
>a Dell Latitude X1 when (un)plugging AC adapter, they probably 
>have the same 
>problem.
>
>Author: Thomas Renninger <trenn@suse.de>
>
>BIOS might change frequency behind our back
>when BIOS changes allowed frequencies via _PPC.
>in this case cpufreq core got out of sync.
>-> ask driver for current freq and notify
>  governors about a change
>
>cpufreq.c |   10 ++++++++++
>1 files changed, 10 insertions(+)
>
>Index: linux-2.6.15/drivers/cpufreq/cpufreq.c
>===================================================================
>--- linux-2.6.15.orig/drivers/cpufreq/cpufreq.c
>+++ linux-2.6.15/drivers/cpufreq/cpufreq.c
>@@ -1402,6 +1402,16 @@ int cpufreq_update_policy(unsigned int c
> 	policy.policy = data->user_policy.policy;
> 	policy.governor = data->user_policy.governor;
> 
>+	/* BIOS might change freq behind our back
>+	   -> ask driver for current freq and notify
>+	   governors about a change
>+	*/
>+	if (cpufreq_driver->get){
>+		policy.cur = cpufreq_driver->get(cpu);
>+		if (data->cur != policy.cur)
>+			cpufreq_out_of_sync(cpu, data->cur, policy.cur);
>+	}
>+
> 	ret = __cpufreq_set_policy(data, &policy);
> 
> 	up(&data->lock);
>
