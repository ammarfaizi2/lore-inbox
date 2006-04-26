Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWDZA1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWDZA1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 20:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWDZA1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 20:27:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:12188 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932308AbWDZA1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 20:27:41 -0400
Date: Tue, 25 Apr 2006 17:26:28 -0700
From: Greg KH <greg@kroah.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [patch 1/2] kref: detect kref_put() with unreferenced object
Message-ID: <20060426002628.GB24343@kroah.com>
References: <20060425082137.028875000@localhost.localdomain> <20060425082359.767915000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425082359.767915000@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 04:21:38PM +0800, Akinobu Mita wrote:
> This patch adds warning to detect kref_put() with unreferenced object.
> 
> The idea of detection kref_put() with unreferenced object was stolen
> from BUG_ON()es in blocks/ll_rw_blk.c and fs/bio.c
> 
> ll_rw_blk.c:    BUG_ON(atomic_read(&ioc->refcount) == 0);
> 
> bio.c:          BIO_BUG_ON(!atomic_read(&bio->bi_cnt));
> 
> But the kref counter usually does not fall to zero. Because kref is
> trying to reduce the number of atomic_dec_and_test()
> 
> So this patch also set kref counter to zero here:
> 
> +	if (atomic_read(&kref->refcount) == 1)
> +		atomic_set(&kref->refcount, 0);

I really don't see how this is going to make it easier to debug
anything.  Remember, when a kref goes to 0, it is automatically freed.
So any code that tries to use it afterward just dies a horrible death,
if CONFIG_DEBUG_SLAB is enabled.

And please be careful, you can't replace all usages of atomic_t counters
in the kernel with krefs...

thanks,

greg k-h
