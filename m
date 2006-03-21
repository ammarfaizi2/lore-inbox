Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751653AbWCUQiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbWCUQiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWCUQip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:38:45 -0500
Received: from cantor2.suse.de ([195.135.220.15]:39642 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751652AbWCUQiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:38:11 -0500
From: Andreas Schwab <schwab@suse.de>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Mark Maule <maule@sgi.com>, Tony Luck <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
References: <20060321143444.9913.48372.11324@lnx-maule.americas.sgi.com>
	<20060321143449.9913.55794.57267@lnx-maule.americas.sgi.com>
	<442029EA.9020900@ce.jp.nec.com>
X-Yow: I have no actual hairline...
Date: Tue, 21 Mar 2006 17:38:08 +0100
In-Reply-To: <442029EA.9020900@ce.jp.nec.com> (Jun'ichi Nomura's message of
	"Tue, 21 Mar 2006 11:29:30 -0500")
Message-ID: <jebqvzhhxr.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jun'ichi Nomura" <j-nomura@ce.jp.nec.com> writes:

> Hi Mark,
>
> Mark Maule wrote:
>> Index: linux-2.6.16/include/asm-ia64/msi.h
>> ===================================================================
>> --- linux-2.6.16.orig/include/asm-ia64/msi.h	2006-03-19 23:53:29.000000000 -0600
>> +++ linux-2.6.16/include/asm-ia64/msi.h	2006-03-20 14:50:53.331368084 -0600
>> @@ -14,4 +14,16 @@
>>  #define ack_APIC_irq		ia64_eoi
>>  #define MSI_TARGET_CPU_SHIFT	4
>>  
>> +extern struct msi_ops msi_apic_ops;
>> +
>> +static inline int msi_arch_init(void)
>> +{
>> +	if (platform_msi_init)
>> +		return platform_msi_init();
>> +
>> +	/* default ops for most ia64 platforms */
>> +	msi_register(&msi_apic_ops);
>> +	return 0;
>> +}
>> +
>>  #endif /* ASM_MSI_H */
>
> It turned out that the above code breaks configs other
> than CONFIG_IA64_SN and CONFIG_IA64_GENERIC.
> e.g. CONFIG_IA64_DIG.
>
> In file included from /build/16.msi/drivers/pci/msi.h:71,
>                  from /build/16.msi/drivers/pci/msi.c:24:
> include2/asm/msi.h: In function `msi_arch_init':
> include2/asm/msi.h:22: error: called object is not a function
> make[3]: *** [drivers/pci/msi.o] Error 1
>
> Something like below might fix this problem:
>   if (platform_msi_init) {
>       ia64_mv_msi_init_t *fn = platform_msi_init;
>       return (*fn)();
>   }

platform_msi_init should have the right type in the first place,
ie. defined to ((ia64_mv_msi_init_t*)NULL) instead of just NULL.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
