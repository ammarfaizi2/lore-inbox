Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWAISXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWAISXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWAISXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:23:23 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:7096 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964909AbWAISXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:23:22 -0500
Message-ID: <43C2AA23.4060107@us.ibm.com>
Date: Mon, 09 Jan 2006 10:23:31 -0800
From: Vernon Mauery <vernux@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 24/24] ibmasm: convert to dynamic input_dev allocation
References: <20060107171559.593824000.dtor_core@ameritech.net> <20060107172102.339318000.dtor_core@ameritech.net>
In-Reply-To: <20060107172102.339318000.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> From: Vernon Mauery <vernux@us.ibm.com>,
> 
> Input: ibmasm - convert to dynamic input_dev allocation
> 
> Update the ibmasm driver to use the dynamic allocation of input_dev
> structs to work with the sysfs subsystem.
> 
> Vojtech: Fixed some problems/bugs in the patch.
> Dmitry: Fixed some more.
> 
> Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/misc/ibmasm/ibmasm.h |    6 +--
>  drivers/misc/ibmasm/remote.c |   82 +++++++++++++++++++++++++------------------
>  2 files changed, 51 insertions(+), 37 deletions(-)
> 

> Index: work/drivers/misc/ibmasm/remote.c
> ===================================================================
> --- work.orig/drivers/misc/ibmasm/remote.c
> +++ work/drivers/misc/ibmasm/remote.c

[snip]

>  
> -	input_register_device(&remote->mouse_dev);
> -	input_register_device(&remote->keybd_dev);
> +	error = input_register_device(mouse_dev);
> +	if (error)
> +		goto err_free_devices;
> +
> +	error = input_register_device(keybd_dev);
> +	if (error)
> +		goto err_unregister_mouse_dev;
> +
>  	enable_mouse_interrupts(sp);
>  
>  	printk(KERN_INFO "ibmasm remote responding to events on RSA card %d\n", sp->number);
>  
>  	return 0;
> +
> + err_unregister_mouse_dev:
> +	input_unregister_device(mouse_dev);

If I understand the API correctly now, shouldn't there be a
	mouse_dev = NULL;
right here to prevent the following input_free_device?

--Vernon

> + err_free_devices:
> +	input_free_device(mouse_dev);
> +	input_free_device(keybd_dev);
> +
> +	return error;
>  }
>  
>  void ibmasm_free_remote_input_dev(struct service_processor *sp)
>  {
>  	disable_mouse_interrupts(sp);
> -	input_unregister_device(&sp->remote->keybd_dev);
> -	input_unregister_device(&sp->remote->mouse_dev);
> -	kfree(sp->remote);
> +	input_unregister_device(sp->remote.mouse_dev);
> +	input_unregister_device(sp->remote.keybd_dev);
>  }
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

