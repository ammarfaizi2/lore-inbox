Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVAUVQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVAUVQX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVAUVQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:16:23 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:8141 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262506AbVAUVQO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:16:14 -0500
Message-ID: <41F17117.5030302@tiscali.de>
Date: Fri, 21 Jan 2005 22:16:07 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: linux-kernel@vger.kernel.org, linux@brodo.de,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [BUG?]: cpufreqency scaling - wrong frequency detected
References: <88056F38E9E48644A0F562A38C64FB6003D1BB0C@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6003D1BB0C@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:

>
>
>> -----Original Message-----
>> From: Matthias-Christian Ott [mailto:matthias.christian@tiscali.de]
>> Sent: Friday, January 21, 2005 9:34 AM
>> To: Matthias-Christian Ott
>> Cc: Pallipadi, Venkatesh; linux-kernel@vger.kernel.org;
>> linux@brodo.de; Nakajima, Jun; Zou, Nanhai
>> Subject: Re: [BUG?]: cpufreqency scaling - wrong frequency detected
>>
>> Matthias-Christian Ott wrote:
>>
>>>>
>>>>
>>> Hi!
>>> Cpufreq (with enabled debugging (not CONFIG_DEBUG_KERNEL)) doesn't
>>> display any additional messages. I'll compile it with
>>> CONFIG_DEBUG_KERNEL.
>>>
>>> Matthias-Christian Ott
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at http://www.tux.org/lkml/
>>>
>> Hi!
>> CONFIG_DEBUG_KERNEL doesn't display any additional messages. What do I
>> have activate to get such debugging messages:
>> dprintk("P4 - MSR_EBC_FREQUENCY_ID: 0x%x 0x%x\n", msr_lo, msr_hi);
>>
>> Matthias-Christian Ott
>>
>
> Enable CPU_FREQ_DEBUG and activate it.
> Thanks,
> Venki
>
> config CPU_FREQ_DEBUG
> bool "Enable CPUfreq debugging"
> depends on CPU_FREQ
> help
> Say Y here to enable CPUfreq subsystem (including drivers)
> debugging. You will need to activate it via the kernel
> command line by passing
> cpufreq.debug=<value>
>
> To get <value>, add
> 1 to activate CPUfreq core debugging,
> 2 to activate CPUfreq drivers debugging, and
> 4 to activate CPUfreq governor debugging
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
>
Hi!
I did had look at the Kconfig, sorry my mistake. I'm not a cpu expert 
but according to this code:

rdmsr(0x2c, msr_lo, msr_hi);

It reads the values from the MSR, but wrong. There's global variable 
cpu_khz (defined from the tsc functions 
[arch/i386/kernel/timers/timer_tsc.c]) which get's the correct value. 
Wouldn't it be easier to take this value, because the ACPI functions do 
the rest (acpi_processor_set_performance, acpi_cpufreq_target, etc.), 
give the parameters to the bios.

It's just a try to simplify it (my knowledge about the Kernel and CPU's 
is limited), but I think maybe it works (perhaps there's a problem with 
the "table entrys" [as I said my knowledge is limited]).

But here's the output:

cpufreq.debug=4:
userspace: managing cpu 0 stopped
performance: setting to 14600000 kHz because of event 1
performance: setting to 14600000 kHz because of event 3
performance: setting to 14600000 kHz because of event 3
performance: setting to 14600000 kHz because of event 3

cpufreq.debug=2:
acpi-cpufreq: acpi_cpufreq_init
acpi-cpufreq: acpi_cpufreq_cpu_init
acpi-cpufreq: acpi_processor_cpu_init_pdc
p4-clockmod: has errata -- disabling low frequencies
speedstep-lib: x86: f, model: 1
speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0x9201fc00 0x0
speedstep-lib: P4 - FSB 100000 kHz; Multiplier 146; Speed 14600000 kHz
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available

cpufreq.debug=1:
cpufreq-core: trying to register driver acpi-cpufreq
cpufreq-core: adding CPU 0
cpufreq-core: initialization failed
cpufreq-core: no CPU initialized for driver acpi-cpufreq
cpufreq-core: unregistering CPU 0
cpufreq-core: trying to register driver p4-clockmod
cpufreq-core: adding CPU 0
freq-table: setting show_table for cpu 0 to c0554aa0
freq-table: table entry 0 is invalid, skipping
freq-table: table entry 1 is invalid, skipping
freq-table: table entry 2: 3650000 kHz, 2 index
freq-table: table entry 3: 5475000 kHz, 3 index
freq-table: table entry 4: 7300000 kHz, 4 index
freq-table: table entry 5: 9125000 kHz, 5 index
freq-table: table entry 6: 10950000 kHz, 6 index
freq-table: table entry 7: 12775000 kHz, 7 index
freq-table: table entry 8: 14600000 kHz, 8 index
cpufreq-core: setting new policy for CPU 0: 3650000 - 14600000 kHz
freq-table: request for verification of policy (3650000 - 14600000 kHz) 
for cpu 0
freq-table: verification lead to (3650000 - 14600000 kHz) for cpu 0
freq-table: request for verification of policy (3650000 - 14600000 kHz) 
for cpu 0
freq-table: verification lead to (3650000 - 14600000 kHz) for cpu 0
cpufreq-core: new min and max freqs are 3650000 - 14600000 kHz
cpufreq-core: governor switch
cpufreq-core: __cpufreq_governor for CPU 0, event 1
cpufreq-core: governor: change or update limits
cpufreq-core: __cpufreq_governor for CPU 0, event 3
cpufreq-core: target for CPU 0: 14600000 kHz, relation 0
freq-table: request for target 14600000 kHz (relation: 0) for cpu 0
freq-table: target is 8 (14600000 kHz, 8)
cpufreq-core: initialization complete
cpufreq-core: driver p4-clockmod up and running
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
cpufreq-core: setting new policy for CPU 0: 3650000 - 14600000 kHz
freq-table: request for verification of policy (3650000 - 14600000 kHz) 
for cpu 0
freq-table: verification lead to (3650000 - 14600000 kHz) for cpu 0
freq-table: request for verification of policy (3650000 - 14600000 kHz) 
for cpu 0
freq-table: verification lead to (3650000 - 14600000 kHz) for cpu 0
cpufreq-core: new min and max freqs are 3650000 - 14600000 kHz
cpufreq-core: governor switch
cpufreq-core: __cpufreq_governor for CPU 0, event 2
cpufreq-core: __cpufreq_governor for CPU 0, event 1
cpufreq-core: target for CPU 0: 14600000 kHz, relation 1
freq-table: request for target 14600000 kHz (relation: 1) for cpu 0
freq-table: target is 8 (14600000 kHz, 8)
cpufreq-core: governor: change or update limits
cpufreq-core: __cpufreq_governor for CPU 0, event 3
cpufreq-core: target for CPU 0: 14600000 kHz, relation 1
freq-table: request for target 14600000 kHz (relation: 1) for cpu 0
freq-table: target is 8 (14600000 kHz, 8)
cpufreq-core: setting new policy for CPU 0: 3650000 - 14600000 kHz
freq-table: request for verification of policy (3650000 - 14600000 kHz) 
for cpu 0
freq-table: verification lead to (3650000 - 14600000 kHz) for cpu 0
freq-table: request for verification of policy (3650000 - 14600000 kHz) 
for cpu 0
freq-table: verification lead to (3650000 - 14600000 kHz) for cpu 0
cpufreq-core: new min and max freqs are 3650000 - 14600000 kHz
cpufreq-core: governor: change or update limits
cpufreq-core: __cpufreq_governor for CPU 0, event 3
cpufreq-core: target for CPU 0: 14600000 kHz, relation 1
freq-table: request for target 14600000 kHz (relation: 1) for cpu 0
freq-table: target is 8 (14600000 kHz, 8)
cpufreq-core: setting new policy for CPU 0: 9636000 - 14600000 kHz
freq-table: request for verification of policy (9636000 - 14600000 kHz) 
for cpu 0
freq-table: verification lead to (9636000 - 14600000 kHz) for cpu 0
freq-table: request for verification of policy (9636000 - 14600000 kHz) 
for cpu 0
freq-table: verification lead to (9636000 - 14600000 kHz) for cpu 0
cpufreq-core: new min and max freqs are 9636000 - 14600000 kHz
cpufreq-core: governor: change or update limits
cpufreq-core: __cpufreq_governor for CPU 0, event 3
cpufreq-core: target for CPU 0: 14600000 kHz, relation 1
freq-table: request for target 14600000 kHz (relation: 1) for cpu 0
freq-table: target is 8 (14600000 kHz, 8)

Sincerely
Matthias-Christian Ott
