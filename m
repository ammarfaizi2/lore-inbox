Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWAZQOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWAZQOS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWAZQOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:14:17 -0500
Received: from fmr21.intel.com ([143.183.121.13]:141 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S964782AbWAZQOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:14:17 -0500
Date: Thu, 26 Jan 2006 08:13:32 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ak@muc.de, ronald@hummelink.net,
       DiegoCG@teleline.es, venkatesh.pallipadi@intel.com,
       anil.s.keshavamurthy@intel.com
Subject: Re: Dont record local apic ids when they are disabled in MADT
Message-ID: <20060126081332.A13445@unix-os.sc.intel.com>
References: <20060126054842.A11917@unix-os.sc.intel.com> <200601261455.11981.ak@suse.de> <20060126061034.A12261@unix-os.sc.intel.com> <200601261534.55620.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200601261534.55620.ak@suse.de>; from ak@suse.de on Thu, Jan 26, 2006 at 03:34:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 03:34:54PM +0100, Andi Kleen wrote:
> 
> How? All the code who could do this is __init.

Where? all code that handles cpu hotplug is located in 
drivers/acpi/processor_core.c under #ifdef CONFIG_ACPI_HOTPLUG_CPU handles 
this.

Just to clarify when we say hotplug cpu support in kernel, today it means
logical cpu hotplug. I hope when physical hotplug is supported that 
platform will have supporting ACPI based or some equivalent implementation.

> 
> > (although i would say we tested this only on ia64 so far, the code is 
> > generic to x86_64 as well, but i havent gone around testing physical hotplug
> > via emulation patches we have internally)
> 
> I doubt it will work on x86-64.

In x86_64, we need to implement one mapping function acpi_map_lsapic()
defined in arch/i386/kernel/acpi/boot.c. Today this is only a stub
function. Its fully implemented for ia64. (As i mentioned this is 
untested yet, and needs some more code and test)

acpi_processor_hotadd_init() in processor_core.c also does arch_register_cpu()
to create appropriate sysfs entries in /sys/devices/system/cpu/cpuX

When a platform supports hotplug, the BIOS should support appropriate ACPI
methods, or some equilvalent to do similar things.
> 
> And you're breaking the CPU hotplug spec in Documentation/x86-64/cpu-hotplug-spec.
> I think the BIOS bugs need to be workarounded without breaking that.

ACPI spec states that if an entry is marked disabled, then dont use it at all.
We could use that to count the number of disabled CPUs in the system, which is 
an acceptable deviation from the real intent, but i dont think we can ask the 
BIOS to also have valid apic ids in them (especially platforms already 
released) 

Forcing even existing BIOSs to change wouldnt be nice.

Alternately you can add the counting of disabled CPUs logic only when 
CONFIG_ACPI_HOTPLUG_CPU is enabled, so it doesnt hurt existing platforms.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
