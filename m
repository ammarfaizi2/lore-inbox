Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWAKFaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWAKFaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 00:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWAKFaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 00:30:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:27111 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932291AbWAKFaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 00:30:16 -0500
Date: Tue, 10 Jan 2006 21:29:25 -0800
From: Greg KH <greg@kroah.com>
To: liyu <liyu@ccoss.com.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] HID device simple driver interface.
Message-ID: <20060111052925.GB3455@kroah.com>
References: <43BC8B8A.8080704@ccoss.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BC8B8A.8080704@ccoss.com.cn>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 10:59:22AM +0800, liyu wrote:
> =====================
> HID device simple driver interface
> =====================
>   
> Goal:
> ----------------
> 
>        Let us write HID device driver more easier.
> 
> 
> Basic idea:
> ---------------     
> 
>        Under current HID device driver development technique, We need 
> write one new interrupt handler to report event to input subsystem as 
> long as one new HID device come. However, the most of them have only 
> some extended keys, I think it seem break a fly on the wheel, which 
> write one new interrupt handler for this reason,
>        My idea is reuse the interrupt handler in hid-core.c. so we 
> write driver for new simple HID device will be more easier, and need not 
> touch hid core.
>        In essence, this interface just are some hooks in HID core.

Vojtech, what do you think?

> Limitation:
> ----------------        
> 
>        The driver use this simple interface only can work with one 
> device at same time. In most time, this just is not a problem. if you 
> are going to make your driver can work with a bundle of devices at same 
> time, the I am sorry, this simple interface can not help you, and I am 
> afraid that driver is not one simple driver. Of course, any improvement 
> on this patch is welcome :)

But there can be many different devices of the same type, right?  And
many different drivers all using this same interface, right?  It doesn't
look that hard to have any limitation for this.


> +static void
> +hidinput_simple_device_bind_foreach(void)
> +{
> +	struct hidinput_simple_device *simple=0;
> +	struct matched_device *matched=0;
> +        struct list_head *simple_node;
> +        struct list_head *matched_node;
> +        struct hid_device *hid;

You have tabs and spaces mixed together in lots of places in your patch,
please fix them all to be just tabs.

> +	hid = usb_get_intfdata(matched->intf);        

You also have a lot of lines that add trailing spaces, please fix that.

> +        if ((simple->connect && 0==simple->connect(hid)) || !simple->connect) {

Why compare to 0?  !simple->connect(hid) is the same, right?

> +        if (!simple || !simple->name || simple->intf)
> +                return -1;

Return proper negative error numbers please.

> +        device_busy:
> +        spin_lock(&simple_lock);                	
> +      	list_add(&simple->node, &simple_devices_list);
> +        spin_unlock(&simple_lock);                	                        	
> +        return 1;

Should be a negative error number, not 1.


> +EXPORT_SYMBOL(hidinput_register_simple_device);

EXPORT_SYMBOL_GPL() for this and the other exports?

> @@ -471,7 +475,6 @@ struct hid_descriptor {
>  #define resolv_event(a,b)	do { } while (0)
>  #endif
>  
> -#endif
>  
>  #ifdef CONFIG_USB_HIDINPUT
>  /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
> @@ -515,3 +518,5 @@ static inline int hid_ff_event(struct hi
>  		return hid->ff_event(hid, input, type, code, value);
>  	return -ENOSYS;
>  }
> +
> +#endif


Why move the #endif?

> +/*
> + *  To give one simple device a configure usage chance.
> + * The most code of this function is copied from hidinput_connect()
> + */
> +void hidinput_simple_device_configure_usage(struct hid_device *hid)
> +{
> +	struct hid_report *report;
> +	int i, j, k;
> +	void (*do_usage)(struct hid_field *,   struct hid_usage *);
> +	
> +	if (!hid->simple)
> +		return;
> +	do_usage = 0;

Please run this through sparse and fix up the errors it produces (hint,
that should be NULL...)

> +struct nek4k_device {
> +	struct hidinput_simple_device device;
> +};

Why create your own structure?  You should be able to just use the
hidinput_simple_device instead, right?

> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15))
> +	struct input_dev *input = hidinput->input;
> +#else
> +	struct input_dev *input = &hidinput->input;
> +#endif

No #ifdefs for versions please.

thanks,

greg k-h
