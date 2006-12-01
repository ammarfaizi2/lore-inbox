Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934424AbWLAIjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934424AbWLAIjg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 03:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967555AbWLAIjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 03:39:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:21649 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S934424AbWLAIjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 03:39:35 -0500
Date: Fri, 1 Dec 2006 09:39:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/4] [APIC] Allow disabling of UP APIC/IO-APIC by default, with command line option to turn it on.
Message-ID: <20061201083900.GA26703@elte.hu>
References: <11648607683157-git-send-email-bcollins@ubuntu.com> <11648607732981-git-send-email-bcollins@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11648607732981-git-send-email-bcollins@ubuntu.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ben Collins <bcollins@ubuntu.com> wrote:

> +config X86_UP_APIC_DEFAULT_OFF
> +	bool "APIC support on uniprocessors defaults to off"
> +	depends on X86_UP_APIC
> +	default n

'n' is the default

>  /*
>   * Knob to control our willingness to enable the local APIC.
> + * -2=default-disable, -1=force-disable, 1=force-enable, 0=automatic
>   */
> -static int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable */
> +static int enable_local_apic __initdata = (X86_APIC_DEFAULT_OFF ? -2 : 0);

i guess this begs for enums?

>  		if (enable_local_apic <= 0) {
> -			printk("Local APIC disabled by BIOS -- "
> +			printk("Local APIC disabled by BIOS (or by default) -- "
>  			       "you can enable it with \"lapic\"\n");

that message should be more intelligent, depending on whether the value 
is 0, -1 or -2.

> +	/* If local apic is off due to config_x86_apic_off option, jump
> +	 * out here. */

nitpick: proper comment style for new code is:

	/*
	 * If local APIC is off due to config_x86_apic_off option, jump
	 * out here.
	 */

> +	if (enable_local_apic < -1) {
> +		printk(KERN_INFO "Local APIC disabled by default -- "
> +		       "use 'lapic' to enable it.\n");
> +		return -1;
> +	}

this should be enable_local_apic == -2. (and should use the enum)

> -int skip_ioapic_setup;
> +int skip_ioapic_setup = X86_APIC_DEFAULT_OFF;

nitpick: should be X86_IOAPIC_DEFAULT_VALUE - if the config option is 
not set then this 'OFF' value will mean 'on' ...

> +static int __init parse_apic(char *arg)
> +{
> +	/* enable IO-APIC */
> +	enable_ioapic_setup();
> +	return 0;
> +}
> +early_param("apic", parse_apic);

that should be "ioapic", not "apic". The CPU has a piece of silicon 
called the "local APIC" - enabled via the 'lapic' option, and disabled 
via noapic. What the option above wants to enable is the IO-APIC in the 
chipset (a different piece of silicon) and the interrupt routing 
capabilities attached to it. That piece is what is causing the installer 
problems.

looks good in principle, but needs these cleanups.

	Ingo
