Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWC2AjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWC2AjA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWC2Ai7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:38:59 -0500
Received: from mga05.intel.com ([192.55.52.89]:33336 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750705AbWC2Ai7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:38:59 -0500
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,140,1141632000"; 
   d="scan'208"; a="16822849:sNHT41648036689"
Date: Tue, 28 Mar 2006 16:16:24 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Some section mismatch in acpi_processor_power_init on ia64 build
Message-ID: <20060328161624.A31861@unix-os.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0613EDAB@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0613EDAB@scsmsx401.amr.corp.intel.com>; from tony.luck@intel.com on Tue, Mar 28, 2006 at 03:09:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 03:09:36PM -0800, Luck, Tony wrote:
> I've only just noticed these warnings when building ia64 !SMP or
> !HOTPLUG_CPU
> kernels:
> 
> WARNING: drivers/acpi/processor.o - Section mismatch: reference to
> .init.data: from .text between 'acpi_processor_power_init' (at offset
> 0x5040) and 'acpi_processor_power_exit'
> WARNING: drivers/acpi/processor.o - Section mismatch: reference to
> .init.data: from .text between 'acpi_processor_power_init' (at offset
> 0x5050) and 'acpi_processor_power_exit'
> 
> According to git bisect, they began with Matt Domsch's "ia64: use i386
> dmi_scan.c"
> patch (commit 3ed3bce8), but it appears that the real issue may be
> further back when
> Ashok Raj marked processor_power_dmi_table as __cpuinitdata in 7ded5689
> with a
> cryptic comment by AK (Andi Kleen?):
>   /* Actually this shouldn't be __cpuinitdata, would be better to fix
> the
>      callers to only run once -AK */
> 
> -Tony

Humm.. originally they were marked as __initdata, but for CPU hotplug we call it
when processor gets hot plugged. So i changed it to __cpuinitdata so that when we use
cpu hotplug they stay resident.

the only reference is to that table is from acpi_processor_power_init(), that gets called 
currently only from acpi_processor_start().

the code is either compiled in kernel (which means it will be all thrown after free
init mem if !HOTPLUG_CPU) or if this is a module code, then __initdata/cpuinit doesnt 
make a difference.

possibly acpi_processor_start(), acpi_processor_power_init() etc should also be
__cpuinit, which would make the warning go away. 

Are there any others i missed Andi? maybe this is a general watch out comment, but 
he knows better.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
