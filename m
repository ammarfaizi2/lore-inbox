Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266240AbUGUGXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUGUGXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 02:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUGUGXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 02:23:33 -0400
Received: from 209-87-233-98.storm.ca ([209.87.233.98]:33685 "EHLO
	ottawa.interneqc.com") by vger.kernel.org with ESMTP
	id S266240AbUGUGXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 02:23:23 -0400
Date: Wed, 21 Jul 2004 02:14:18 -0400
From: Greg KH <greg@kroah.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] kref shrinkage patches -- 1 of 2 -- kref shrinkage
Message-ID: <20040721061418.GB18787@kroah.com>
References: <20040720122307.GA1235@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720122307.GA1235@obelix.in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 05:53:11PM +0530, Ravikiran G Thirumalai wrote:
> Greg,
> Here's the first step towards getting to kref_get_rcu :)
> This patch is to shrink the kref object by removing the 
> function pointer 'release' from the kref object, and modifying
> kref_init and kref_put interfaces so that kref_init will not take
> the release pointer anymore and kref_put will.  Patch will probably talk
> better.

Nice patches, I've applied them with a few tweaks, as noted below.

> Just had a question about definition of kref_get though, 
> why does it need to return struct kref * ? struct kref * is anywayz 
> being passed to it, hence the caller has it anywayz -- so it doesn't 
> value add anything afaics (but i might have limited vision so pls correct me)

Consistancy with other "get" and "put" functions.  It's quite common to
do:
	have_this_foo(foo_get(foo));

or:
	foo_to_send_off = foo_get(foo);

> In fact, I see that the scsi applications  of kref have code like
> 
> <quote drivers/scsi/sd.c>
> 
>         if (!kref_get(&sdkp->kref))
>                 goto out_sdkp;
> 
> </>

Heh, yeah, that's just dumb, as that failure will never happen :)


> diff -ruN -X dontdiff2 linux-2.6.7/include/linux/kref.h kref-2.6.7/include/linux/kref.h
> --- linux-2.6.7/include/linux/kref.h	2004-06-16 10:48:59.000000000 +0530
> +++ kref-2.6.7/include/linux/kref.h	2004-07-20 12:53:24.226739304 +0530
> @@ -8,6 +8,9 @@
>   * Copyright (C) 2002-2003 Patrick Mochel <mochel@osdl.org>
>   * Copyright (C) 2002-2003 Open Source Development Labs
>   *
> + * 07/2004 - struct kref shrinkage by Ravikiran Thirumalai <kiran@in.ibm.com>
> + * Copyright (C) 2004 IBM Corp.
> + *
>   * This file is released under the GPLv2.
>   *
>   */

This is not needed.  First off, the Copyright statement for IBM is
already included in this file, for this same year, above these lines.
Also, we are not including file history in the files themselves, that's
what Changelog comments are for (which scale much better over time.)

> @@ -44,14 +42,17 @@
>  /**
>   * kref_put - decrement refcount for object.
>   * @kref: object.
> - *
> - * Decrement the refcount, and if 0, call kref->release().
> + * @release: pointer to the function that will clean up the object
> + *	     when the last reference to the object is released.
> + *	     This pointer is required.
> + * Decrement the refcount, and if 0, call release().
>   */

The extra blank line in tha comment was needed for docbook to work
properly, last time I checked.

> -void kref_put(struct kref *kref)
> +void kref_put(struct kref *kref, void (*release) (struct kref *kref))
>  {
> +	WARN_ON(release == NULL);

I also added a check here to test if release == kfree to catch people
like the s390 developers who want to do nasty hacks :)

thanks,

greg k-h
