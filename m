Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVK2DD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVK2DD5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 22:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVK2DD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 22:03:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932336AbVK2DD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 22:03:56 -0500
Date: Mon, 28 Nov 2005 19:02:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, acpi-devel@lists.sourceforge.net, len.brown@intel.com,
       nando@ccrma.Stanford.EDU, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Message-Id: <20051128190253.1b7068d6.akpm@osdl.org>
In-Reply-To: <1133232503.6328.18.camel@localhost.localdomain>
References: <20051115090827.GA20411@elte.hu>
	<1132336954.20672.11.camel@cmn3.stanford.edu>
	<1132350882.6874.23.camel@mindpipe>
	<1132351533.4735.37.camel@cmn3.stanford.edu>
	<20051118220755.GA3029@elte.hu>
	<1132353689.4735.43.camel@cmn3.stanford.edu>
	<1132367947.5706.11.camel@localhost.localdomain>
	<20051124150731.GD2717@elte.hu>
	<1132952191.24417.14.camel@localhost.localdomain>
	<20051126130548.GA6503@elte.hu>
	<1133232503.6328.18.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> This patch creates a directory in /sys/kernel called idle.
>

At no point do you appear to explain _why_ the kernel needs this feature?

> ...
> -		pm_idle = pm_idle_save;
> +		int tries = 0;
> +		int ret;
> +		set_idle(NULL);
> +		do {
> +			if ((ret = unregister_idle(PM_IDLE_NAME)) == 0)
> +				break;
> +			/*
> +			 * for some reason the idle function is being used.
> +			 * Wait a little and then try again.
> +			 */
> +			if (ret == -EINVAL) {
> +				printk(KERN_WARNING
> +				       "ACPI idle function never registered?\n");
> +				break;
> +			}
> +			yield();
> +		} while (tries++ < 10);

The use of yield() could be problematic - its semantics are rather
ill-defined.  Maybe msleep(1) or something?

What's this loop here for anyway?  Looks kludgy.

> +		if (tries > 10) {
> +			printk(KERN_WARNING
> +			       "Unable to unresgister ACPI idle function\n");

tpyo

> +	memset(&idle_kobj, 0, sizeof(idle_kobj));

There are several memsets of statically allocated structures which are
already all-zero.

