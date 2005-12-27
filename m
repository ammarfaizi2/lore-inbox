Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVL0Fhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVL0Fhx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 00:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVL0Fhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 00:37:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:11938 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932139AbVL0Fhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 00:37:51 -0500
Date: Mon, 26 Dec 2005 21:35:26 -0800
From: Greg KH <greg@kroah.com>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: Yanmin Zhang <ymzhang@unix-os.sc.intel.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, linux-ia64@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH v2:3/3]Export cpu topology by sysfs
Message-ID: <20051227053526.GD25886@kroah.com>
References: <8126E4F969BA254AB43EA03C59F44E84044DE5EA@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E84044DE5EA@pdsmsx404>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2005 at 03:38:16PM +0800, Zhang, Yanmin wrote:
> >>> >>> +static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
> >>> >>> +		unsigned long action, void *hcpu)
> >>> >>> +{
> >>> >>> +	unsigned int cpu = (unsigned long)hcpu;
> >>> >>> +	struct sys_device *sys_dev;
> >>> >>> +
> >>> >>> +	sys_dev = get_cpu_sysdev(cpu);
> >>> >>> +	switch (action) {
> >>> >>> +		case CPU_ONLINE:
> >>> >>> +			topology_add_dev(sys_dev);
> >>> >>> +			break;
> >>> >>> +#ifdef	CONFIG_HOTPLUG_CPU
> >>> >>> +		case CPU_DEAD:
> >>> >>> +			topology_remove_dev(sys_dev);
> >>> >>> +			break;
> >>> >>> +#endif
> >>> >>
> >>> >>Why ifdef?  Isn't it safe to just always have this in?
> >>> If no ifdef here, gcc reported a compiling warning when I compiled it
> >>> on IA64 with CONFIG_HOTPLUG_CPU=n.
> >>
> >>Then you should probably go change it so that CPU_DEAD is defined on
> >>non-smp builds, otherwise the code gets quite messy like the above :)
> 
> Sorry. My previous explanation is confusing. It's a link warning on
> ia64. On ia64, the kernel vmlinux doesn't include section .exit.text,
> so ld will report a link warning when a function is in section
> .exit.text and another function (not in .exit.text) calls the first
> one. When CONFIG_HOTPLUG_CPU=n, function topology_remove_dev is in
> section .exit.text, but its caller topology_remove_dev is not in
> .exit.text.
> 
> i386 and x86_64 kernel vmlinux does include .exit.text and discard it
> only when running, so there is no such warning on i386/x86_64.
> 
> There is no other better approach to get rid of the warning unless we
> change arch/ia64/kernel/vmlinux.lds.S to keep all .exit.text in kernel
> image.

Or just move that function to not be __exit, as you are calling it from
an __init function.  That would be the best solution.

thanks,

greg k-h
