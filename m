Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVF1F0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVF1F0C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVF1F0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:26:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261195AbVF1FZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:25:44 -0400
Date: Mon, 27 Jun 2005 22:24:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk,
       ncunningham@cyclades.com, ak@muc.de, pavel@ucw.cz
Subject: Re: [PATCH]MTRR suspend/resume cleanup
Message-Id: <20050627222444.370457d4.akpm@osdl.org>
In-Reply-To: <1119936124.3158.9.camel@linux-hp.sh.intel.com>
References: <1119936124.3158.9.camel@linux-hp.sh.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> wrote:
>
> Hi,
> There has been some discuss about solving the SMP MTRR suspend/resume
> breakage, but I didn't find a patch for it. This is an intent for it.
> The basic idea is moving mtrr initializing into cpu_identify for all APs
> (so it works for cpu hotplug). For BP, restore_processor_state is
> responsible for restoring MTRR.

> @@ -332,6 +332,7 @@ int mtrr_add_page(unsigned long base, un
>  
>  	error = -EINVAL;
>  
> +	lock_cpu_hotplug();
>  	/*  Search for existing MTRR  */
>  	down(&main_lock);
>  	for (i = 0; i < num_var_ranges; ++i) {
	
Is this new locking?  If so, please describe it.

> +
> +static int __init mtrr_init_finialize(void)
> +{
> +	if (!mtrr_if)
> +		return 0;
> +	if (use_intel())
> +		mtrr_state_warn();
> +	else
> +	/* The CPUs haven't MTRR and seemes not support SMP. They have specific
> +	 * drivers, we use a tricky method to support suspend/resume for them
> +	 * TBD: is there any system with such CPU which supports suspend/resume?
> +	 * if no, we should remove the code.
> +	 */
> +		sysdev_driver_register(&cpu_sysdev_class,
> +			&mtrr_sysdev_driver);
> +	return 0;
> +}

That's pretty hard to read.  Braces will improve it:

	if (use_intel()) {
		mtrr_state_warn();
	} else {
		/*
		 * The CPUs haven't MTRR and seemes not support SMP. They have
		 * specific drivers, we use a tricky method to support
		 * suspend/resume for them.
		 * TBD: is there any system with such CPU which supports
		 * suspend/resume?  If no, we should remove the code.
		 */
		sysdev_driver_register(&cpu_sysdev_class,
			&mtrr_sysdev_driver);
	}

> +#ifdef CONFIG_MTRR
> +extern int mtrr_ap_init(void);
> +extern int mtrr_bp_init(void);
> +#else
> +#define mtrr_ap_init()
> +#define mtrr_bp_init()
> +#endif

If this works, it means we're always ignoring the return values and these
things should return void.

Otherwise the !CONFIG_MTRR stubs should be returning an integer.  So we
need either:

#ifdef CONFIG_MTRR
extern void mtrr_ap_init(void);
extern void mtrr_bp_init(void);
#else
#define mtrr_ap_init()	do {} while (0)		(or static inlines)
#define mtrr_bp_init()	do {} while (0)
#endif

or

#ifdef CONFIG_MTRR
extern int mtrr_ap_init(void);
extern int mtrr_bp_init(void);
#else
static inline int mtrr_ap_init(void) { return 0; }
static inline int mtrr_bp_init(void) { return 0; }
#endif


> +#ifdef CONFIG_MTRR
> +extern int mtrr_ap_init(void);
> +extern int mtrr_bp_init(void);
> +#else
> +#define mtrr_ap_init()
> +#define mtrr_bp_init();
> +#endif

Ditto.


