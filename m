Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262776AbTDASiK>; Tue, 1 Apr 2003 13:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262778AbTDASiJ>; Tue, 1 Apr 2003 13:38:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:36493 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262776AbTDASiF>; Tue, 1 Apr 2003 13:38:05 -0500
Message-ID: <3E89DC6F.8050702@us.ibm.com>
Date: Tue, 01 Apr 2003 10:37:35 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (2.5.66-mm2) War on warnings
References: <19200000.1049210557@[10.10.2.4]> <20030401152703.GA21986@gtf.org> <25070000.1049213622@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>drivers/base/node.c: In function `register_node_type':
>>>drivers/base/node.c:96: warning: suggest parentheses around assignment used as truth value
>>>drivers/base/memblk.c: In function `register_memblk_type':
>>>drivers/base/memblk.c:54: warning: suggest parentheses around assignment used as truth value
>>>
>>>Bah.
>>>
>>>--- linux-2.5.66-mm2/drivers/base/node.c	2003-04-01 06:40:02.000000000 -0800
>>>+++ 2.5.66-mm2/drivers/base/node.c	2003-04-01 06:37:32.000000000 -0800
>>>@@ -93,7 +93,7 @@ int __init register_node_type(void)
>>> {
>>> 	int error;
>>> 	if (!(error = devclass_register(&node_devclass)))
>>>-		if (error = driver_register(&node_driver))
>>>+		if ((error = driver_register(&node_driver)))
>>> 			devclass_unregister(&node_devclass);
>>
>>Personally, I feel statements like these are prone to continual error
>>and confusion.  I would prefer to break each test like this out into
>>separate assignment and test statements.  Combining them decreases
>>readability, while saving a paltry few extra bytes of source code.
>>
>>Sure, the gcc warning is silly, but the code is a bit obtuse too.
> 
> 
> True, I agree with this in general, and I think Andrew does too, from
> previous comments. I was just being lazy ;-) More appropriate patch below.
> Compile tested, but not run.
> 
> M.

Shouldn't there be an accompanying change to drivers/base/cpu.c?  I had 
sent a patch that fixed all three, I believe.  Did the cpu changes get 
dropped?

-Matt

> 
> diff -urpN -X /home/fletch/.diff.exclude mm2/drivers/base/memblk.c mm2-warnfix/drivers/base/memblk.c
> --- mm2/drivers/base/memblk.c	Tue Apr  1 08:05:55 2003
> +++ mm2-warnfix/drivers/base/memblk.c	Tue Apr  1 08:08:36 2003
> @@ -50,9 +50,13 @@ int __init register_memblk(struct memblk
>  int __init register_memblk_type(void)
>  {
>  	int error;
> -	if (!(error = devclass_register(&memblk_devclass)))
> -		if (error = driver_register(&memblk_driver))
> +
> +	error = devclass_register(&memblk_devclass);
> +	if (!error) {
> +		error = driver_register(&memblk_driver);
> +		if (error)
>  			devclass_unregister(&memblk_devclass);
> +	}
>  	return error;
>  }
>  postcore_initcall(register_memblk_type);
> diff -urpN -X /home/fletch/.diff.exclude mm2/drivers/base/node.c mm2-warnfix/drivers/base/node.c
> --- mm2/drivers/base/node.c	Tue Apr  1 08:05:55 2003
> +++ mm2-warnfix/drivers/base/node.c	Tue Apr  1 08:07:36 2003
> @@ -92,9 +92,13 @@ int __init register_node(struct node *no
>  int __init register_node_type(void)
>  {
>  	int error;
> -	if (!(error = devclass_register(&node_devclass)))
> -		if (error = driver_register(&node_driver))
> +	
> +	error = devclass_register(&node_devclass);
> +	if (!error) {
> +		error = driver_register(&node_driver);
> +		if (error)
>  			devclass_unregister(&node_devclass);
> +	}
>  	return error;
>  }
>  postcore_initcall(register_node_type);
> 
> 


