Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUFXVr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUFXVr2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265676AbUFXVqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:46:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:53412 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265774AbUFXVpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:45:05 -0400
Date: Thu, 24 Jun 2004 14:45:55 -0700
From: Greg KH <gregkh@us.ibm.com>
To: Vernon Mauery <vernux@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Pat Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Jess Botts <botts@us.ibm.com>
Subject: Re: [PATCH] acpiphp extension for 2.6.7
Message-ID: <20040624214555.GA1800@us.ibm.com>
References: <1087934028.2068.57.camel@bluerat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087934028.2068.57.camel@bluerat>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.7-bk6 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 12:53:49PM -0700, Vernon Mauery wrote:
> According to the specification, ACPI does not have a standard way of
> querying or manipulating the attention LED of hotplug slots.  Here is a
> patch that allows for device specific ACPI code to be registered with
> the acpiphp driver as callbacks for setting/getting the status of the
> attention LED.

The LED stuff looks good (few minor comments below), but the ACPI table
info should be moved to the ACPI core to provide this to all ACPI tables
in the /sys/firmware/acpi tree.

> +static struct acpiphp_attention_info attention_info;

This should just be a pointer, not the whole structure.  Then just set
it to whatever pointer is passed to you from the module.

> +/**
> +    * acpiphp_register_attention_info - set attention LED callback
> +    *
> +    * this is used to register a hardware specific acpi driver
> +    * that manipulates the attention LED.  All the fields in
> +    * info must be set.
> +    *
> +    */
> +int acpiphp_register_attention_info(struct acpiphp_attention_info *info)
> +{
> +	int retval = 0;
> +	unsigned long flags;
> +
> +	if (!info || !info->owner || !info->set_attn || !info->get_attn)
> +		retval = -1;
> +	else {
> +		spin_lock_irqsave(&attn_info_lock, flags);

Why lock here?  What could race?

And why the irqsave lock?

> +		if (!attention_info.owner)
> +			memcpy(&attention_info, info,
> +					sizeof(struct acpiphp_attention_info));
> +		spin_unlock_irqrestore(&attn_info_lock, flags);
> +	}
> +	return retval;
> +}
> +
> +
> +/**
> + * acpiphp_unregister_attention_info - unset attention LED callback
> + *
> + * this is used to un-register a hardware specific acpi driver
> + * that manipulates the attention LED.  Both fields must
> + * match the current attention info to reset it.
> + *
> + */
> +int acpiphp_unregister_attention_info(struct acpiphp_attention_info *info)
> +{
> +	int retval = 0;
> +	unsigned long flags;
> +
> +	if (!info || !info->owner || !info->set_attn || !info->get_attn)
> +		retval = -1;
> +	else {
> +		spin_lock_irqsave(&attn_info_lock, flags);
> +		if (memcmp(&attention_info, info, 
> +				sizeof(struct acpiphp_attention_info)) == 0)
> +			memset(&attention_info, 0,
> +					sizeof(struct acpiphp_attention_info));
> +		else
> +			retval = -1;
> +		spin_unlock_irqrestore(&attn_info_lock, flags);
> +	}
> +	return retval;
> +}
> +
> +
>  /**
>   * enable_slot - power on and enable a slot
>   * @hotplug_slot: slot to enable
> @@ -120,29 +184,33 @@
>  /**
>   * set_attention_status - set attention LED
>   *
> - * TBD:
>   * ACPI doesn't have known method to manipulate
> - * attention status LED.
> + * attention status LED, so we use a callback that
> + * was registered with us.  This allows hardware specific
> + * ACPI implementations to blink the light for us.
>   *
>   */
> -static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
> +static int set_attention_status (struct hotplug_slot *hotplug_slot, u8 status)
>  {
> +	int retval = -1;
> +	unsigned long flags;
> +	struct acpiphp_attention_info info;
> +
>  	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
>  
> -	switch (status) {
> -		case 0:
> -			/* FIXME turn light off */
> -			hotplug_slot->info->attention_status = 0;
> -			break;
> -
> -		case 1:
> -		default:
> -			/* FIXME turn light on */
> -			hotplug_slot->info->attention_status = 1;
> -			break;
> +	spin_lock_irqsave(&attn_info_lock, flags);
> +	memcpy(&info, &attention_info, sizeof(struct acpiphp_attention_info));
> +	spin_unlock_irqrestore(&attn_info_lock, flags);

Again, why lock?  And why copy the whole structure?  And it's on the
stack, which isn't very nice.  Same comment applies to the get_
function.

> +
> +	if (info.set_attn && try_module_get(info.owner)) {
> +		retval = info.set_attn(hotplug_slot, status);
> +		module_put(info.owner);
>  	}
>  
> -	return 0;
> +	if (!retval)
> +		hotplug_slot->info->attention_status = (status) ? 1 : 0;

Why change the value based on the return value of the call?  This
shouldn't be set at all.

thanks,

greg k-h
