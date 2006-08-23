Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965308AbWHWXec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965308AbWHWXec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWHWXec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:34:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965181AbWHWXeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:34:31 -0400
Date: Wed, 23 Aug 2006 16:34:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
Subject: Re: [RFC][PATCH] Manage jbd allocations from its own slabs
Message-Id: <20060823163410.d9af3baa.akpm@osdl.org>
In-Reply-To: <1156374495.30517.5.camel@dyn9047017100.beaverton.ibm.com>
References: <1156374495.30517.5.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 16:08:15 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> Hi,
> 
> Here is the fix to "bh: Ensure bh fits within a page" problem
> caused by JBD.
> 
> BTW, I realized that this problem can happen only with 1k, 2k
> filesystems - as 4k, 8k allocations disable slab debug 
> automatically. But for completeness, I created slabs for those
> also.
> 
> What do you think ? I ran basic tests and things are fine.
> 

Thanks for working on this.

> ...
>
>  /*
> + * jbd slab management: create 1k, 2k, 4k, 8k slabs and allocate
> + * frozen and commit buffers from these slabs.
> + *
> + * Reason for doing this is to avoid, SLAB_DEBUG - since it could
> + * cause bh to cross page boundary.
> + */
> +
> +static kmem_cache_t *jbd_slab[4];
> +static const char *jbd_slab_names[4] = {
> +	"jbd_1k",
> +	"jbd_2k",
> +	"jbd_4k",
> +	"jbd_8k",
> +};
> +
> +static void journal_destroy_jbd_slabs(void)
> +{
> +	int i;
> +
> +	for (i=0; i<4; i++) {
> +		if (jbd_slab[i])
> +			kmem_cache_destroy(jbd_slab[i]);
> +		jbd_slab[i] = NULL;
> +	}
> +}
> +
> +static int journal_init_jbd_slabs(void)
> +{
> +	int i = 0;
> +	int retval = 0;
> +
> +	for (i=0; i<4; i++) {
> +		unsigned long slab_size = 1024 << i;
> +		jbd_slab[i] = kmem_cache_create(jbd_slab_names[i],
> +					slab_size, slab_size,
> +					0, NULL, NULL);

OK, passing align=slab_size fixes the bug.

> +		if (jbd_slab[i] == 0) {
> +			journal_destroy_jbd_slabs();
> +			retval = -ENOMEM;
> +			printk(KERN_EMERG "JBD: no memory for jbd_slab cache\n");
> +			goto out;
> +		}
> +	}
> +out:
> +	return retval;
> +}

Do we have to create all four slabs up-front?  Perhaps we can defer that
until mount-time, after we have determined the filesystem's block size.

That way, most people's machines will only ever create a single slab cache:
jbd_4k.

> +static int jbd_find_slab_index(size_t size)
> +{
> +	int idx = 0;
> +
> +	switch (size) {
> +	case 1024:	idx = 0;
> +			break;
> +	case 2048:	idx = 1;
> +			break;
> +	case 4096:	idx = 2;
> +			break;
> +	case 8192:	idx = 3;
> +			break;
> +	default:	printk("JBD unknown slab size %ld\n", size);
> +			BUG();
> +	}
> +	return idx;
> +}

I'd suggest this function be changed to directly return a kmem_cache_t *.

> +void * jbd_slab_alloc(size_t size, gfp_t flags)
> +{
> +	int idx;
> +
> +	idx = jbd_find_slab_index(size);
> +	return kmem_cache_alloc(jbd_slab[idx], flags | __GFP_NOFAIL);
> +}
> +
> +void jbd_slab_free(void *ptr,  size_t size)
> +{
> +	int idx;
> +
> +	idx = jbd_find_slab_index(size);
> +	kmem_cache_free(jbd_slab[idx], ptr);
> +}

Then these become simpler.


