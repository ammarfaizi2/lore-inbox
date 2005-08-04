Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVHDGBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVHDGBF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVHDGBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:01:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24783 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261836AbVHDGBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:01:04 -0400
Date: Wed, 3 Aug 2005 22:59:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI driver update part 1, add per-channel IPMB
 addresses
Message-Id: <20050803225954.27aa6ffd.akpm@osdl.org>
In-Reply-To: <42F14AC9.2060109@acm.org>
References: <42F14AC9.2060109@acm.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> wrote:
>
> ipmi-per-channel-slave-address.patch  unknown/unknown (13533 bytes)]

Could you fix up the mimetype, please?  It makes it hard for various email
clients.

> IPMI allows multiple IPMB channels on a single interface, and
> each channel might have a different IPMB address.  However, the
> driver has only one IPMB address that it uses for everything.
> This patch adds new IOCTLS and a new internal interface for
> setting per-channel IPMB addresses and LUNs.  New systems are
> coming out with support for multiple IPMB channels, and they
> are broken without this patch.
> 
> ...
> +	for (i=0; i<IPMI_MAX_CHANNELS; i++)

Preferred coding style is actually

	for (i = 0; i < IPMI_MAX_CHANNELS; i++)

but we've kinda lost that fight in drivers :(

> +#define IPMICTL_SET_MY_CHANNEL_ADDRESS_CMD _IOR(IPMI_IOC_MAGIC, 24, struct ipmi_channel_lun_address_set)
> +#define IPMICTL_GET_MY_CHANNEL_ADDRESS_CMD _IOR(IPMI_IOC_MAGIC, 25, struct ipmi_channel_lun_address_set)
> +#define IPMICTL_SET_MY_CHANNEL_LUN_CMD	   _IOR(IPMI_IOC_MAGIC, 26, struct ipmi_channel_lun_address_set)
> +#define IPMICTL_GET_MY_CHANNEL_LUN_CMD	   _IOR(IPMI_IOC_MAGIC, 27, struct ipmi_channel_lun_address_set)

Are these all OK wrt compat handling?

>  	case IPMICTL_SET_MY_ADDRESS_CMD:
>  	{
>  		unsigned int val;
> ...
>  	case IPMICTL_GET_MY_ADDRESS_CMD:
>  	{
> -		unsigned int val;
> +		unsigned int  val;
> +		unsigned char rval;
> ...
>  	case IPMICTL_GET_MY_LUN_CMD:
>  	{
> -		unsigned int val;
> +		unsigned int  val;
> +		unsigned char rval;
> +
> ...
> +	case IPMICTL_SET_MY_CHANNEL_ADDRESS_CMD:
> +	{
> +		struct ipmi_channel_lun_address_set val;
> ...
> +	case IPMICTL_GET_MY_CHANNEL_ADDRESS_CMD:
> +	{
> +		struct ipmi_channel_lun_address_set val;
> ...
> +	case IPMICTL_SET_MY_CHANNEL_LUN_CMD:
> +	{
> +		struct ipmi_channel_lun_address_set val;
> ...
> +	case IPMICTL_GET_MY_CHANNEL_LUN_CMD:
> +	{
> +		struct ipmi_channel_lun_address_set val;
> ...
>  	case IPMICTL_SET_TIMING_PARMS_CMD:
>  	{
>  		struct ipmi_timing_parms parms;
> 

Be aware that this function will use more stack space than it needs to: gcc
will create a separate stack slot for all the above locals.

Hence it would be better to declare them all at the start of the function. 
Faster, too - less dcache footprint.

Maybe not as nice from a purist point of view, but it does allow you to
lose those braces in the switch statement...
