Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWD0LTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWD0LTv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWD0LTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:19:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:1379 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932470AbWD0LTu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:19:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JEdBBQGNEo3aP0uTbkJide/5l4+SVFgdX9yRbnIkAhreAmMbWr4TIs2pFa39LpBmpXdOtbH7arN9camcyCRydscFPkKJ5N8PpSXOjDja1ksNqy8HGzICSPHb+PDL1MUM7hm6kwIL/KWeRBIQoZvJt0fxnEjBfpsCG9ywxdlYML4=
Message-ID: <84144f020604270419s10696877he2ec27ae6d52e486@mail.gmail.com>
Date: Thu, 27 Apr 2006 14:19:49 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Or Gerlitz" <ogerlitz@voltaire.com>
Subject: Re: possible bug in kmem_cache related code
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       open-iscsi@googlegroups.com, clameter@sgi.com,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0604271138370.16357-101000@zuben>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.44.0604271138370.16357-101000@zuben>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/06, Or Gerlitz <ogerlitz@voltaire.com> wrote:
> With 2.6.17-rc3 I'm running into something which seems as a bug related
> to kmem_cache. Doing some allocations/deallocations from a kmem_cache and
> later attempting to destroy it yields the following message and trace

Tested on 2.6.16.7 and works ok. Christoph, could this be related to
the cache draining patches that went in 2.6.17-rc1?

                                                    Pekka

>
> ============================================================================
> slab error in kmem_cache_destroy(): cache `my_cache': Can't free all objects
>
> Call Trace: <ffffffff8106e46b>{kmem_cache_destroy+150}
>        <ffffffff88204033>{:my_kcache:kcache_cleanup_module+51}
>        <ffffffff81044cd3>{sys_delete_module+415} <ffffffff8112fb5b>{__up_write+20}
>        <ffffffff8105d42b>{sys_munmap+91} <ffffffff8100966a>{system_call+126}
>
> Failed to destroy cache
> ============================================================================
>
> I was hitting it as an Infiniband/iSCSI user as IB/iSCSI/SCSI code use
> kmem_caches, but since the failure happens on a code which works fine on
> 2.6.16 i have decided to try it with a synthetic module and had this hit...
>
> Below is a sample code that reproduces it, if i only do kmem_cache_create
> and later destroy it does not happen, attached is my .config please note
> that some of the CONFIG_DEBUG_ options are open.
>
> Please CC openib-general@openib.org at least with the resolution of the
> matter since it kind of hard to do testing over 2.6.17-rcX with this
> issue, the tests run fine but some modules are crashing on rmmod so a
> reboot it needed...
>
> thanks,
>
> Or.
>
> This is the related slab info line once the module is loaded
>
> my_cache  256    264    328   12    1 : tunables   32   16    8
> : slabdata     22     22      0 : globalstat     264    264    22    0
>
> --- /deb/null   1970-01-01 02:00:00.000000000 +0200
> +++ kcache/kcache.c     2006-04-27 10:43:18.000000000 +0300
> @@ -0,0 +1,61 @@
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +kmem_cache_t *cache;
> +
> +struct foo {
> +       char bar[300];
> +};
> +
> +
> +#define TRIES 256
> +
> +struct foo *foo_arr[TRIES];
> +
> +static int __init kcache_init_module(void)
> +{
> +       int i, j;
> +
> +       cache = kmem_cache_create("my_cache",
> +                                 sizeof (struct foo),
> +                                 0,
> +                                 SLAB_HWCACHE_ALIGN,
> +                                 NULL,
> +                                 NULL);
> +       if (!cache) {
> +               printk(KERN_ERR "couldn't create cache\n");
> +               goto error1;
> +       }
> +
> +       for (i = 0; i < TRIES; i++) {
> +               foo_arr[i] = kmem_cache_alloc(cache, GFP_KERNEL);
> +               if (foo_arr[i] == NULL) {
> +                       printk(KERN_ERR "couldn't allocate from cache\n");
> +                       goto error2;
> +               }
> +       }
> +
> +       return 0;
> +error2:
> +       for (j = 0; j < i; j++)
> +               kmem_cache_free(cache, foo_arr[j]);
> +error1:
> +       return -ENOMEM;
> +}
> +
> +static void __exit kcache_cleanup_module(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < TRIES; i++)
> +               kmem_cache_free(cache, foo_arr[i]);
> +
> +       if (kmem_cache_destroy(cache)) {
> +               printk(KERN_DEBUG "Failed to destroy cache\n");
> +       }
> +}
> +
> +MODULE_LICENSE("GPL");
> +
> +module_init(kcache_init_module);
> +module_exit(kcache_cleanup_module);
>
>
>
>
>
