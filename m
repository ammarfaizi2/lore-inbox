Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264768AbUEOX6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbUEOX6t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 19:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUEOX6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 19:58:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:50571 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264768AbUEOX6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 19:58:46 -0400
Date: Sat, 15 May 2004 16:58:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Faik Uygur <faikuygur@tnn.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use idr_get_new to allocate a bus id in
 drivers/i2c/i2c-core.c
Message-Id: <20040515165812.7e771f20.akpm@osdl.org>
In-Reply-To: <20040515222632.GA7218@dsl.ttnet.net.tr>
References: <20040515222632.GA7218@dsl.ttnet.net.tr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Faik Uygur <faikuygur@tnn.net> wrote:
>
> Hi,
> 
> This patch uses idr_get_new to allocate a bus id while registering
> a new adapter.
> 

The IDR interface is a bit cumbersome.  Even though you called
idr_pre_get(), there's no guarantee that the memory which it preallocated
is still present when you call idr_get_new().

It's easily fixed though:


>  int i2c_add_adapter(struct i2c_adapter *adap)
>  {
> -	static int nr = 0;
> +	int id;
>  	struct list_head   *item;
>  	struct i2c_driver  *driver;
>  
> +	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) == 0)
> +		return -ENOMEM;
> +
>  	down(&core_lists);
>  
> -	adap->nr = nr++;
> +	id = idr_get_new(&i2c_adapter_idr, NULL);
> +	adap->nr =  id & MAX_ID_MASK;
>  	init_MUTEX(&adap->bus_lock);
>  	init_MUTEX(&adap->clist_lock);
>  	list_add_tail(&adap->list,&adapters);
> @@ -207,6 +213,9 @@
>  	/* wait for sysfs to drop all references */
>  	wait_for_completion(&adap->dev_released);
>  	wait_for_completion(&adap->class_dev_released);
> +
> +	/* free dynamically allocated bus id */
> +	idr_remove(&i2c_adapter_idr, adap->nr);
>  
>  	dev_dbg(&adap->dev, "adapter unregistered\n");

Just move the idr_pre_get() to after the down().  That way you know nobody
else will steal the preallocation.

Is the kernel likely to ever have so many bus IDs that we actually need
this patch?  Or do you specifically want first-fit-from-zero for some
reason?

