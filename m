Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030675AbVIBE27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030675AbVIBE27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 00:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030676AbVIBE27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 00:28:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47815 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030675AbVIBE26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 00:28:58 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, ncunningham@cyclades.com,
       Meelis Roos <mroos@linux.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: reboot vs poweroff
References: <20050901062406.EBA5613D5B@rhn.tartu-labor>
	<1125557333.12996.76.camel@localhost>
	<Pine.SOC.4.61.0509011030430.3232@math.ut.ee>
	<4316F4E3.4030302@drzeus.cx> <1125578897.4785.23.camel@localhost>
	<m1fysoq0p7.fsf@ebiederm.dsl.xmission.com> <43171C02.30402@drzeus.cx>
	<m1aciwpvsz.fsf@ebiederm.dsl.xmission.com>
	<20050901202246.GB2027@openzaurus.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 01 Sep 2005 22:26:59 -0600
In-Reply-To: <20050901202246.GB2027@openzaurus.ucw.cz> (Pavel Machek's
 message of "Thu, 1 Sep 2005 22:22:47 +0200")
Message-ID: <m11x48p018.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>> 
>> Thanks.
>> 
>> This is clearly a code path I missed when I was fixing things.
>> 
>> When I made the final acpi change I checked for any other users
>> of device_suspend and it seems I was blind and missed this one.
>> Looking again...
>> 
>> The patch in the bug report looks correct.  However it is still
>> a little incomplete.  In particular the reboot notifier is not
>> being called, and since not everything has been converted into
>> using shutdown methods that could lead to some other inconsistent
>> behavior.
>> 
>> Does anyone have any problems with the patch below?
>> If not I will send this off to Linus..
>
> Yes. kernel_suspend is *way* too generic name.  kernel_suspend_off?
> kernel_powe_off_suspend?

Darn.  You have a point there.

>> @@ -420,6 +421,15 @@ void kernel_power_off(void)
>>  }
>>  EXPORT_SYMBOL_GPL(kernel_power_off);
>>  
>> +int kernel_suspend(void)
>> +{
>> +	notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
>> +	system_state = SYSTEM_POWER_OFF;
>> +	device_shutdown();
>> +	return pm_ops->enter(PM_SUSPEND_DISK);
>> +}
>> +EXPORT_SYMBOL_GPL(kernel_suspend);
>> +
>
> Are you sure pm_ops exists in !CONFIG_PM case?

Hmm.  Good point.  I hadn't considered that.  I am now certain
it only exists when CONFIG_PM is set.

Thinking about it more I probably want to simply have a
kernel_power_off_shutdown(); common factor and call
that instead of device_shutdown().

Ok some sleep and then I will see if I can better version of this
cleanup.

Eric
