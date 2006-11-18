Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753771AbWKRCIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbWKRCIP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 21:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753787AbWKRCIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 21:08:15 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:11164 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1753771AbWKRCIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 21:08:14 -0500
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for
	paravirtualizing critical operations
From: john stultz <johnstul@us.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1162376827.23462.5.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
	 <1162376827.23462.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 18:08:06 -0800
Message-Id: <1163815686.5374.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 21:27 +1100, Rusty Russell wrote:
> Create a paravirt.h header for all the critical operations which need
> to be replaced with hypervisor calls, and include that instead of
> defining native operations, when CONFIG_PARAVIRT.
> 
> This patch does the dumbest possible replacement of paravirtualized
> instructions: calls through a "paravirt_ops" structure.  Currently
> these are function implementations of native hardware: hypervisors
> will override the ops structure with their own variants.
> 
[snip]

> +struct paravirt_ops paravirt_ops = {
> +	.name = "bare hardware",
[snip]
> +	.get_wallclock = native_get_wallclock,
> +	.set_wallclock = native_set_wallclock,

[snip]

> --- /dev/null
> +++ b/include/asm-i386/time.h
> @@ -0,0 +1,41 @@
> +#ifndef _ASMi386_TIME_H
> +#define _ASMi386_TIME_H
> +
> +#include <linux/efi.h>
> +#include "mach_time.h"
> +
> +static inline unsigned long native_get_wallclock(void)
> +{
> +	unsigned long retval;
> +
> +	if (efi_enabled)
> +		retval = efi_get_time();
> +	else
> +		retval = mach_get_cmos_time();
> +
> +	return retval;
> +}
> +
> +static inline int native_set_wallclock(unsigned long nowtime)
> +{
> +	int retval;
> +
> +	if (efi_enabled)
> +		retval = efi_set_rtc_mmss(nowtime);
> +	else
> +		retval = mach_set_rtc_mmss(nowtime);
> +
> +	return retval;
> +}
> +
> +#ifdef CONFIG_PARAVIRT
> +#include <asm/paravirt.h>
> +#else /* !CONFIG_PARAVIRT */
> +
> +#define get_wallclock() native_get_wallclock()
> +#define set_wallclock(x) native_set_wallclock(x)


Could a better name then "get/set_wallclock" be used here? Its too vague
and would be easily confused with do_set/gettimeofday() functions.

My suggestion would be to use "persistent_clock" to describe the
battery-backed CMOS/hardware clock. (I assume that is what you intend
this paravirt_op to be, rather then get the high-resolution system
timeofday)

thanks
-john


