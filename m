Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbTBPMdP>; Sun, 16 Feb 2003 07:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbTBPMdP>; Sun, 16 Feb 2003 07:33:15 -0500
Received: from kim.it.uu.se ([130.238.12.178]:49545 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S266552AbTBPMdO>;
	Sun, 16 Feb 2003 07:33:14 -0500
Date: Sun, 16 Feb 2003 13:43:08 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200302161243.NAA18253@kim.it.uu.se>
To: pavel@suse.cz
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2003 13:05:16 +0100, Pavel Machek wrote:
>> --- linux-2.5.60/arch/i386/kernel/apm.c.~1~	2003-02-10 23:36:54.000000000 +0100
>> +++ linux-2.5.60/arch/i386/kernel/apm.c	2003-02-12 21:01:51.000000000 +0100
>> @@ -218,6 +218,7 @@
>>  #include <linux/time.h>
>>  #include <linux/sched.h>
>>  #include <linux/pm.h>
>> +#include <linux/device.h>
>>  #include <linux/kernel.h>
>>  #include <linux/smp.h>
>>  #include <linux/smp_lock.h>
>> @@ -1263,6 +1264,11 @@
>>  		}
>>  		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
>>  	}
>> +
>> +	device_suspend(3, SUSPEND_NOTIFY);
>> +	device_suspend(3, SUSPEND_SAVE_STATE);
>
>Comment these two lines... and all RESTORE_STATEs. System needs to be
>stopped in order for SAVE_STATE to work, and it is not in apm case.

What's the proper fix? apm must be able to initiate suspend & resume.

(This part is straight from your patch, BTW. I only rediffed and
and added #include <linux/device.h>.)

>> +static struct device_driver local_apic_nmi_driver = {
>> +	.name		= "local_apic_nmi",
>> +	.bus		= &system_bus_type,
>> +	.resume		= nmi_resume,
>> +	.suspend	= nmi_suspend,
>> +};
>
>Do you think it is neccessary to call it "*local_*apic_nmi_driver"? It
>seems way too long.

Local APIC != I/O APIC. I try to be a caretaker for the former,
so I dislike the ambiguous term "APIC".

>> +extern struct sys_device device_local_apic;
>> +
>> +static struct sys_device device_local_apic_nmi = {
>> +	.name		= "local_apic_nmi",
>> +	.id		= 0,
>> +	.dev		= {
>> +		.name	= "local_apic_nmi",
>> +		.driver	= &local_apic_nmi_driver,
>> +		.parent = &device_local_apic.dev,
>> +	},
>> +};
>
>Why did you convert device_apic_nmi to *sys_*device?

Otherwise the NMI watchdog device wouldn't show up in /sys.

>> +EXPORT_SYMBOL(nmi_watchdog);
>> +EXPORT_SYMBOL(disable_local_apic_nmi_watchdog);
>> +EXPORT_SYMBOL(enable_local_apic_nmi_watchdog);
>
>This is good, if we have disable_, we should have enable_, not setup_;
>but I killed _local_ part as it is way too long, then.

Note that there is also an I/O APIC NMI generator.
If you drop the "local" qualifier, things get ambiguous.

Although I find it ugly, I could accept "lapic" as a shorter
replacement for "local_apic" in identifiers.

/Mikael
