Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758919AbWK2WyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758919AbWK2WyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758910AbWK2WyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:54:17 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:56081 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1758919AbWK2WyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:54:16 -0500
Message-ID: <456E0F92.2010200@shadowen.org>
Date: Wed, 29 Nov 2006 22:54:10 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Kay Sievers <kay.sievers@vrfy.org>
CC: Greg KH <greg@kroah.com>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm2
References: <20061128020246.47e481eb.akpm@osdl.org>	 <200611281235.45087.m.kozlowski@tuxland.pl>	 <20061128223058.GC16152@kroah.com> <1164791161.3613.106.camel@pim.off.vrfy.org>
In-Reply-To: <1164791161.3613.106.camel@pim.off.vrfy.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers wrote:
> On Tue, 2006-11-28 at 14:30 -0800, Greg KH wrote:
>> On Tue, Nov 28, 2006 at 12:35:43PM +0100, Mariusz Kozlowski wrote:
>>> Hello,
>>>
>>> 	When CONFIG_MODULE_UNLOAD is not set then this happens:
>>>
>>>   CC      kernel/module.o
>>> kernel/module.c:852: error: `initstate' undeclared here (not in a function)
>>> kernel/module.c:852: error: initializer element is not constant
>>> kernel/module.c:852: error: (near initialization for `modinfo_attrs[2]')
>>> make[1]: *** [kernel/module.o] Error 1
>>> make: *** [kernel] Error 2
>>>
>>> Reference to 'initstate' should stay under #ifdef CONFIG_MODULE_UNLOAD
>>> as its definition I guess.
>>>
>>> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
>>>
>>> --- linux-2.6.19-rc6-mm2-a/kernel/module.c      2006-11-28 12:17:09.000000000 +0100
>>> +++ linux-2.6.19-rc6-mm2-b/kernel/module.c      2006-11-28 12:05:01.000000000 +0100
>>> @@ -849,8 +849,8 @@ static inline void module_unload_init(st
>>>  static struct module_attribute *modinfo_attrs[] = {
>>>         &modinfo_version,
>>>         &modinfo_srcversion,
>>> -       &initstate,
>>>  #ifdef CONFIG_MODULE_UNLOAD
>>> +       &initstate,
>>>         &refcnt,
>>>  #endif
>> Kay, is this correct?  I think we still need this information exported
>> to userspace, even if we can't unload modules, right?
> 
> Yes, instead we should move the attribute out of the ifdef, so
> it will be there, even when modules can't be unloaded.
> 
> Thanks,
> Kay

You here say move the attribute, but the patch here just adds it.  Is
this right??  Looking at whats there before this patch it appears to
duplicate the code from inside the #ifdef, so we have two copies when
CONFIG_MODULE_UNLOAD is defined.

> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index f016656..0648f5d 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -811,9 +811,34 @@ static inline void module_unload_init(st
>  }
>  #endif /* CONFIG_MODULE_UNLOAD */
>  
> +static ssize_t show_initstate(struct module_attribute *mattr,
> +			   struct module *mod, char *buffer)
> +{
> +	const char *state = "unknown";
> +
> +	switch (mod->state) {
> +	case MODULE_STATE_LIVE:
> +		state = "live";
> +		break;
> +	case MODULE_STATE_COMING:
> +		state = "coming";
> +		break;
> +	case MODULE_STATE_GOING:
> +		state = "going";
> +		break;
> +	}
> +	return sprintf(buffer, "%s\n", state);
> +}
> +
> +static struct module_attribute initstate = {
> +	.attr = { .name = "initstate", .mode = 0444, .owner = THIS_MODULE },
> +	.show = show_initstate,
> +};
> +
>  static struct module_attribute *modinfo_attrs[] = {
>  	&modinfo_version,
>  	&modinfo_srcversion,
> +	&initstate,
>  #ifdef CONFIG_MODULE_UNLOAD
>  	&refcnt,
>  #endif

-apw
