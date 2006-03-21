Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWCUQ2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWCUQ2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWCUQ2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:28:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17589 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030442AbWCUQ2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:28:01 -0500
Message-ID: <442029EA.9020900@ce.jp.nec.com>
Date: Tue, 21 Mar 2006 11:29:30 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Maule <maule@sgi.com>
CC: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>, gregkh@suse.de
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
References: <20060321143444.9913.48372.11324@lnx-maule.americas.sgi.com> <20060321143449.9913.55794.57267@lnx-maule.americas.sgi.com>
In-Reply-To: <20060321143449.9913.55794.57267@lnx-maule.americas.sgi.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Mark Maule wrote:
> Index: linux-2.6.16/include/asm-ia64/msi.h
> ===================================================================
> --- linux-2.6.16.orig/include/asm-ia64/msi.h	2006-03-19 23:53:29.000000000 -0600
> +++ linux-2.6.16/include/asm-ia64/msi.h	2006-03-20 14:50:53.331368084 -0600
> @@ -14,4 +14,16 @@
>  #define ack_APIC_irq		ia64_eoi
>  #define MSI_TARGET_CPU_SHIFT	4
>  
> +extern struct msi_ops msi_apic_ops;
> +
> +static inline int msi_arch_init(void)
> +{
> +	if (platform_msi_init)
> +		return platform_msi_init();
> +
> +	/* default ops for most ia64 platforms */
> +	msi_register(&msi_apic_ops);
> +	return 0;
> +}
> +
>  #endif /* ASM_MSI_H */

It turned out that the above code breaks configs other
than CONFIG_IA64_SN and CONFIG_IA64_GENERIC.
e.g. CONFIG_IA64_DIG.

In file included from /build/16.msi/drivers/pci/msi.h:71,
                 from /build/16.msi/drivers/pci/msi.c:24:
include2/asm/msi.h: In function `msi_arch_init':
include2/asm/msi.h:22: error: called object is not a function
make[3]: *** [drivers/pci/msi.o] Error 1

Something like below might fix this problem:
  if (platform_msi_init) {
      ia64_mv_msi_init_t *fn = platform_msi_init;
      return (*fn)();
  }

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
