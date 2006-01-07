Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWAGFBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWAGFBf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 00:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWAGFBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 00:01:35 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:54876 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030350AbWAGFBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 00:01:35 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vernon Mauery <vernux@us.ibm.com>
Subject: Re: dynamic input_dev allocation for ibmasm driver
Date: Sat, 7 Jan 2006 00:01:32 -0500
User-Agent: KMail/1.8.3
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Max Asbock <amax@us.ibm.com>
References: <43BF0463.7010700@us.ibm.com>
In-Reply-To: <43BF0463.7010700@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601070001.33125.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 18:59, Vernon Mauery wrote:
> This patch updates the ibmasm driver to use the dynamic allocation of input_dev
> structs to work with the sysfs subsystem.  I have tested it on my machine and it
> seems to work fine.
> 
> Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
> 
>  ibmasm.h |    6 ++---
>  remote.c |   72 ++++++++++++++++++++++++++++++++++-----------------------------
>  2 files changed, 42 insertions(+), 36 deletions(-)
> 
> 
...
> -	input_register_device(&remote->mouse_dev);
> -	input_register_device(&remote->keybd_dev);
> +	if ((ret = input_register_device(mouse_dev)))
> +		goto error_alloc;
> +	if ((ret = input_register_device(keybd_dev)))
> +		goto error_alloc;
> +
> +	sp->remote.mouse_dev = mouse_dev;
> +	sp->remote.keybd_dev = keybd_dev;
>  	enable_mouse_interrupts(sp);
>  
>  	printk(KERN_INFO "ibmasm remote responding to events on RSA card %d\n", sp->number);
>  
>  	return 0;
> +
> +error_alloc:
> +	input_free_device(mouse_dev);
> +	input_free_device(keybd_dev);
> +	return ret;

Error handling is rotten here. If 2nd input_register_device fails you will
whack fully registered remote->mouse_dev. You are missing call to
input_unregister_device() there.

Please fix it up and send it my way - I'll add it to the input tree.

Thanks!

-- 
Dmitry
