Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVA3ANW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVA3ANW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 19:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVA3ANW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 19:13:22 -0500
Received: from quark.didntduck.org ([69.55.226.66]:62955 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261610AbVA3ANQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 19:13:16 -0500
Message-ID: <41FC2693.6060601@didntduck.org>
Date: Sat, 29 Jan 2005 19:13:07 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: "Paul `Rusty' Russell" <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] micro optimization in kernel/params.c; don't call to_module_kobject
 before we really have to.
References: <Pine.LNX.4.62.0501300024110.2829@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0501300024110.2829@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> In kernel/params.c::module_attr_show and 
> kernel/params.c::module_attr_store we call to_module_kobject() and save 
> the result in a local variable right before a conditional statement that 
> does not depend on the call to to_module_kobject() and may cause the 
> function to return. If the function returns before we use the result of 
> to_module_kobject() then the call is just a waste of time. 
> The patch moves the call to to_module_kobject() down just before it is 
> actually used, thus we save a call to the function in a few cases. I doubt 
> this is in any way measurable, but I see no reason to not move the call - 
> it should be an infinitesimal improvement with no ill sideeffects.
> Please consider applying.
> 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.11-rc2-bk7-orig/kernel/params.c linux-2.6.11-rc2-bk7/kernel/params.c
> --- linux-2.6.11-rc2-bk7-orig/kernel/params.c	2005-01-29 23:54:53.000000000 +0100
> +++ linux-2.6.11-rc2-bk7/kernel/params.c	2005-01-30 00:27:08.000000000 +0100
> @@ -625,11 +625,12 @@ static ssize_t module_attr_show(struct k
>  	int ret;
>  
>  	attribute = to_module_attr(attr);
> -	mk = to_module_kobject(kobj);
>  
>  	if (!attribute->show)
>  		return -EPERM;
>  
> +	mk = to_module_kobject(kobj);
> +
>  	if (!try_module_get(mk->mod))
>  		return -ENODEV;
>  
> @@ -649,11 +650,12 @@ static ssize_t module_attr_store(struct 
>  	int ret;
>  
>  	attribute = to_module_attr(attr);
> -	mk = to_module_kobject(kobj);
>  
>  	if (!attribute->store)
>  		return -EPERM;
>  
> +	mk = to_module_kobject(kobj);
> +
>  	if (!try_module_get(mk->mod))
>  		return -ENODEV;
>  
> 
> 
> 

I'd bet that the compiler already reorders the assignment since there is 
no side effect to to_module_kobject().  Even with a patch like this you 
can't control exactly when the assignment is done.  There may not even 
be an assignment, since mk is a constant offset of kobj.

--
				Brian Gerst
