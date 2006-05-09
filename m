Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWEIRDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWEIRDG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWEIRDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:03:06 -0400
Received: from ns1.suse.de ([195.135.220.2]:37283 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750720AbWEIRDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:03:05 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 26/35] Add Xen subarch reboot support
Date: Tue, 9 May 2006 19:02:30 +0200
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085158.282993000@sous-sol.org>
In-Reply-To: <20060509085158.282993000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091902.31327.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +++ linus-2.6/drivers/xen/core/reboot.c
> @@ -0,0 +1,232 @@
> +#define __KERNEL_SYSCALLS__
> +#include <linux/version.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/unistd.h>
> +#include <linux/module.h>
> +#include <linux/reboot.h>
> +#include <linux/sysrq.h>
> +#include <linux/stringify.h>
> +#include <linux/syscalls.h>
> +#include <linux/cpu.h>
> +#include <linux/kthread.h>

Do you really need all these includes?

> +#if defined(__i386__) || defined(__x86_64__)

aka CONFIG_X86

> +/*
> + * Power off function, if any
> + */
> +void (*pm_power_off)(void);
> +EXPORT_SYMBOL(pm_power_off);
> +#endif
> +
> +extern void ctrl_alt_del(void);


That should be in some header

> +
> +/* Ignore multiple shutdown requests. */
> +static int shutting_down = SHUTDOWN_INVALID;
> +static void __shutdown_handler(void *unused);
> +static DECLARE_WORK(shutdown_work, __shutdown_handler, NULL);
> +
> +static int shutdown_process(void *__unused)
> +{
> +	static char *envp[] = { "HOME=/", "TERM=linux",
> +				"PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
> +	static char *poweroff_argv[] = { "/sbin/poweroff", NULL };

This should be configurable, probably in a sysctl

> +
> +	if ((shutting_down == SHUTDOWN_POWEROFF) ||
> +	    (shutting_down == SHUTDOWN_HALT)) {
> +		if (execve(poweroff_argv[0], poweroff_argv, envp) < 0) {
> +			sys_reboot(LINUX_REBOOT_MAGIC1,
> +				   LINUX_REBOOT_MAGIC2,
> +				   LINUX_REBOOT_CMD_POWER_OFF,
> +				   NULL);
> +		}
> +	}
> +
> +	shutting_down = SHUTDOWN_INVALID; /* could try again */
> +
> +	return 0;
> +}
> +
> +static void __shutdown_handler(void *unused)
> +{
> +	int err = 0;
> +
> +	if (shutting_down != SHUTDOWN_SUSPEND)


The whole shutting_down handling looks racy. Probably needs some locking?

-Andi
