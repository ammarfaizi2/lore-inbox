Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269361AbUIIHha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269361AbUIIHha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 03:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269364AbUIIHha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 03:37:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3227 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269361AbUIIHh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 03:37:28 -0400
Date: Thu, 9 Sep 2004 09:35:23 +0200
From: Jens Axboe <axboe@suse.de>
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/1] uml:fix ubd deadlock on SMP
Message-ID: <20040909073523.GH1737@suse.de>
References: <20040908172503.384144933@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908172503.384144933@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08 2004, blaisorblade_spam@yahoo.it wrote:
> diff -puN arch/um/drivers/ubd_kern.c~uml-fix-ubd-deadlock arch/um/drivers/ubd_kern.c
> --- uml-linux-2.6.8.1/arch/um/drivers/ubd_kern.c~uml-fix-ubd-deadlock	2004-09-08 19:04:27.662926344 +0200
> +++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c	2004-09-08 19:05:36.700431048 +0200
> @@ -54,6 +54,7 @@
>  #include "mem.h"
>  #include "mem_kern.h"
>  
> +/*This is the queue lock. FIXME: make it per-UBD device.*/
>  static spinlock_t ubd_io_lock = SPIN_LOCK_UNLOCKED;
>  static spinlock_t ubd_lock = SPIN_LOCK_UNLOCKED;

probably not worth it to make it per-device. doing so should be a simple
search-replace job, though.

> @@ -396,14 +397,16 @@ int thread_fd = -1;
>   */
>  int intr_count = 0;
>  
> -static void ubd_finish(struct request *req, int error)
> +static inline void __ubd_finish(struct request *req, int error, int lock)
>  {
>  	int nsect;
>  
>  	if(error){
> - 		spin_lock(&ubd_io_lock);
> +		if (lock)
> +			spin_lock(&ubd_io_lock);
>  		end_request(req, 0);
> - 		spin_unlock(&ubd_io_lock);
> +		if (lock)
> +			spin_unlock(&ubd_io_lock);

In general, doing it this way is throwned upon. Either split the
function, or just make the callers acquire the lock if they have to.

-- 
Jens Axboe

