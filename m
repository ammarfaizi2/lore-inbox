Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267515AbSLEVgF>; Thu, 5 Dec 2002 16:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267514AbSLEVfY>; Thu, 5 Dec 2002 16:35:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:28299 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267433AbSLEVeQ>; Thu, 5 Dec 2002 16:34:16 -0500
Message-ID: <3DEFC6BF.1080104@us.ibm.com>
Date: Thu, 05 Dec 2002 13:35:59 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] fix broken topology functions
References: <3DEE959F.7080600@us.ibm.com> <20021205002023.GC9882@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Wed, Dec 04, 2002 at 03:54:07PM -0800, Matthew Dobson wrote:
> 
>>Linus,
>>	The register_(node|memblk)_driver functions are broken.  Pat Mochel 
>>recently updated sysfs to make sure that when you register a driver that 
>>it's associated devclass is already registered.  The way node/memblk 
>>registration is done now is backwards and causes panic's on NUMA 
>>systems.  Please apply this patch to fix it.
>>Cheers!
> 
> 
> That didn't check the return value of devclass_register():
> 
> 
> 
> Reorder devclass_register() and driver_register() so these things
> stop oopsing.

Even better.  Thanks Bill!

Cheers!

-Matt


> 
>  memblk.c |    4 ++--
>  node.c   |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> 
> diff -urpN mm1-2.5.50/drivers/base/memblk.c mm1-2.5.50-1/drivers/base/memblk.c
> --- mm1-2.5.50/drivers/base/memblk.c	2002-11-27 14:36:23.000000000 -0800
> +++ mm1-2.5.50-1/drivers/base/memblk.c	2002-12-04 12:53:59.000000000 -0800
> @@ -49,7 +49,7 @@ int __init register_memblk(struct memblk
>  
>  static int __init register_memblk_type(void)
>  {
> -	driver_register(&memblk_driver);
> -	return devclass_register(&memblk_devclass);
> +	int error = devclass_register(&memblk_devclass);
> +	return error ? error : driver_register(&memblk_driver);
>  }
>  postcore_initcall(register_memblk_type);
> diff -urpN mm1-2.5.50/drivers/base/node.c mm1-2.5.50-1/drivers/base/node.c
> --- mm1-2.5.50/drivers/base/node.c	2002-11-27 14:35:50.000000000 -0800
> +++ mm1-2.5.50-1/drivers/base/node.c	2002-12-04 12:53:05.000000000 -0800
> @@ -93,7 +93,7 @@ int __init register_node(struct node *no
>  
>  static int __init register_node_type(void)
>  {
> -	driver_register(&node_driver);
> -	return devclass_register(&node_devclass);
> +	int error = devclass_register(&node_devclass);
> +	return error ? error : driver_register(&node_driver);
>  }
>  postcore_initcall(register_node_type);
> 


