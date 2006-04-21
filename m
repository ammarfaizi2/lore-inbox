Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWDUAr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWDUAr2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWDUAr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:47:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750879AbWDUAr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:47:26 -0400
Date: Thu, 20 Apr 2006 17:46:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, sct@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] FS-Cache: Generic filesystem caching facility
Message-Id: <20060420174622.6d7390d6.akpm@osdl.org>
In-Reply-To: <20060420165937.9968.57149.stgit@warthog.cambridge.redhat.com>
References: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
	<20060420165937.9968.57149.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> ...
>
> --- /dev/null
> +++ b/fs/fscache/cookie.c
> @@ -0,0 +1,1065 @@
> +/* cookie.c: general filesystem cache cookie management
> + *
> + * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include "fscache-int.h"
> +
> +static LIST_HEAD(fscache_cache_tag_list);
> +static LIST_HEAD(fscache_cache_list);
> +static LIST_HEAD(fscache_netfs_list);
> +static DECLARE_RWSEM(fscache_addremove_sem);
> +static struct fscache_cache_tag fscache_nomem_tag;
> +
> +kmem_cache_t *fscache_cookie_jar;
> +
> +static void fscache_withdraw_object(struct fscache_cache *cache,
> +				    struct fscache_object *object);
> +
> +static void __fscache_cookie_put(struct fscache_cookie *cookie);
> +
> +static inline void fscache_cookie_put(struct fscache_cookie *cookie)
> +{
> +#ifdef CONFIG_DEBUG_SLAB
> +	BUG_ON((atomic_read(&cookie->usage) & 0xffff0000) == 0x6b6b0000);
> +#endif

Interesting.  Perhaps a comment in there?

> +/*****************************************************************************/
> +/*
> + * look up a cache tag
> + */
> +struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
> +{
> +	struct fscache_cache_tag *tag, *xtag;
> +
> +	/* firstly check for the existence of the tag under read lock */
> +	down_read(&fscache_addremove_sem);
> +
> +	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
> +		if (strcmp(tag->name, name) == 0) {
> +			atomic_inc(&tag->usage);
> +			up_read(&fscache_addremove_sem);
> +			return tag;
> +		}
> +	}
> +
> +	up_read(&fscache_addremove_sem);
> +
> +	/* the tag does not exist - create a candidate */
> +	xtag = kmalloc(sizeof(*tag) + strlen(name) + 1, GFP_KERNEL);
> +	if (!xtag) {
> +		/* return a dummy tag if out of memory */
> +		up_read(&fscache_addremove_sem);

We already did an up_read().

> +/*****************************************************************************/
> +/*
> + * register a network filesystem for caching
> + */
> +int __fscache_register_netfs(struct fscache_netfs *netfs)
> +{
> +	struct fscache_netfs *ptr;
> +	int ret;
> +
> +	_enter("{%s}", netfs->name);
> +
> +	INIT_LIST_HEAD(&netfs->link);
> +
> +	/* allocate a cookie for the primary index */
> +	netfs->primary_index =
> +		kmem_cache_alloc(fscache_cookie_jar, SLAB_KERNEL);
> +
> +	if (!netfs->primary_index) {
> +		_leave(" = -ENOMEM");
> +		return -ENOMEM;
> +	}
> +
> +	/* initialise the primary index cookie */
> +	memset(netfs->primary_index, 0, sizeof(*netfs->primary_index));

We have kmem_cache_zalloc() now.

> +EXPORT_SYMBOL(__fscache_register_netfs);

This code exports a huge number of symbols.   Should they be non-GPL?

> +void fscache_withdraw_cache(struct fscache_cache *cache)
> +{
> +	struct fscache_object *object;
> +
> +	_enter("");
> +
> +	printk(KERN_NOTICE
> +	       "FS-Cache: Withdrawing cache \"%s\"\n",
> +	       cache->tag->name);
> +
> +	/* make the cache unavailable for cookie acquisition */
> +	down_write(&cache->withdrawal_sem);
> +
> +	down_write(&fscache_addremove_sem);
> +	list_del_init(&cache->link);
> +	cache->tag->cache = NULL;
> +	up_write(&fscache_addremove_sem);
> +
> +	/* mark all objects as being withdrawn */
> +	spin_lock(&cache->object_list_lock);
> +	list_for_each_entry(object, &cache->object_list, cache_link) {
> +		set_bit(FSCACHE_OBJECT_WITHDRAWN, &object->flags);
> +	}
> +	spin_unlock(&cache->object_list_lock);
> +
> +	/* make sure all pages pinned by operations on behalf of the netfs are
> +	 * written to disc */
> +	cache->ops->sync_cache(cache);
> +
> +	/* dissociate all the netfs pages backed by this cache from the block
> +	 * mappings in the cache */
> +	cache->ops->dissociate_pages(cache);
> +
> +	/* we now have to destroy all the active objects pertaining to this
> +	 * cache */
> +	spin_lock(&cache->object_list_lock);
> +
> +	while (!list_empty(&cache->object_list)) {
> +		object = list_entry(cache->object_list.next,
> +				    struct fscache_object, cache_link);
> +		list_del_init(&object->cache_link);
> +		spin_unlock(&cache->object_list_lock);
> +
> +		_debug("withdraw %p", object->cookie);
> +
> +		/* we've extracted an active object from the tree - now dispose
> +		 * of it */
> +		fscache_withdraw_object(cache, object);
> +
> +		spin_lock(&cache->object_list_lock);
> +	}

This looks livelockable.

> +	spin_unlock(&cache->object_list_lock);
> +
> +	fscache_release_cache_tag(cache->tag);
> +	cache->tag = NULL;
> +
> +	_leave("");
> +
> +} /* end fscache_withdraw_cache() */
> +
>
> ...
>
> +static struct fscache_object *fscache_lookup_object(struct fscache_cookie *cookie,
> +						    struct fscache_cache *cache)
> +{
> +	struct fscache_cookie *parent = cookie->parent;
> +	struct fscache_object *pobject, *object;
> +	struct hlist_node *_p;
> +
> +	_enter("{%s/%s},",
> +	       parent && parent->def ? parent->def->name : "",
> +	       cookie->def ? (char *) cookie->def->name : "<file>");
> +
> +	if (test_bit(FSCACHE_IOERROR, &cache->flags))
> +		return NULL;
> +
> +	/* see if we have the backing object for this cookie + cache immediately
> +	 * to hand
> +	 */
> +	object = NULL;
> +	hlist_for_each_entry(object, _p,
> +			     &cookie->backing_objects, cookie_link
> +			     ) {

That's really weird-looking.  How about

	hlist_for_each_entry(object, _p, &cookie->backing_objects, cookie_link){
		

> +	hlist_for_each_entry(pobject, _p,
> +			     &parent->backing_objects, cookie_link
> +			     ) {
> +		if (pobject->cache == cache)
> +			break;
> +	}

Ditto.

> +	if (!pobject) {
> +		/* we don't know about the parent object */
> +		up_read(&parent->sem);
> +		down_write(&parent->sem);
> +
> +		pobject = fscache_lookup_object(parent, cache);
> +		if (IS_ERR(pobject)) {
> +			up_write(&parent->sem);
> +			_leave(" = %ld [no ipobj]", PTR_ERR(pobject));
> +			return pobject;
> +		}
> +
> +		_debug("pobject=%p", pobject);
> +
> +		BUG_ON(pobject->cookie != parent);
> +
> +		downgrade_write(&parent->sem);
> +	}
> +
> +	/* now we can attempt to look up this object in the parent, possibly
> +	 * creating a representation on disc when we do so
> +	 */
> +	object = cache->ops->lookup_object(cache, pobject, cookie);
> +	up_read(&parent->sem);
> +
> +	if (IS_ERR(object)) {
> +		_leave(" = %ld [no obj]", PTR_ERR(object));
> +		return object;
> +	}
> +
> +	/* keep track of it */
> +	cache->ops->lock_object(object);
> +
> +	BUG_ON(!hlist_unhashed(&object->cookie_link));
> +
> +	/* attach to the cache's object list */
> +	if (list_empty(&object->cache_link)) {
> +		spin_lock(&cache->object_list_lock);
> +		list_add(&object->cache_link, &cache->object_list);
> +		spin_unlock(&cache->object_list_lock);
> +	}
> +
> +	/* attach to the cookie */
> +	object->cookie = cookie;
> +	atomic_inc(&cookie->usage);
> +	hlist_add_head(&object->cookie_link, &cookie->backing_objects);
> +
> +	/* done */
> +	cache->ops->unlock_object(object);

I assume ->lock_object() provides the locking for the hlist_add_head()?

> +	_leave(" = %p [new]", object);
> +	return object;
> +
> +} /* end fscache_lookup_object() */
>
> ...
>
> +/*
> + * update the index entries backing a cookie
> + */
> +void __fscache_update_cookie(struct fscache_cookie *cookie)
> +{
> +	struct fscache_object *object;
> +	struct hlist_node *_p;
> +
> +	if (cookie == FSCACHE_NEGATIVE_COOKIE) {
> +		_leave(" [no cookie]");
> +		return;
> +	}
> +
> +	_enter("{%s}", cookie->def->name);
> +
> +	BUG_ON(!cookie->def->get_aux);
> +
> +	down_write(&cookie->sem);
> +	down_read(&cookie->parent->sem);

That's a surprising locking order.  Normally things are parent-first.

> +	/* update the index entry on disc in each cache backing this cookie */
> +	hlist_for_each_entry(object, _p,
> +			     &cookie->backing_objects, cookie_link
> +			     ) {
> +		if (!test_bit(FSCACHE_IOERROR, &object->cache->flags))
> +			object->cache->ops->update_object(object);
> +	}
> +
> +	up_read(&cookie->parent->sem);
> +	up_write(&cookie->sem);
> +	_leave("");
> +
> +} /* end __fscache_update_cookie() */
> +
>
>...
>
> +int __fscache_pin_cookie(struct fscache_cookie *cookie)
> +{
> +	struct fscache_object *object;
> +	int ret;
> +
> +	_enter("%p", cookie);
> +
> +	if (hlist_empty(&cookie->backing_objects)) {
> +		_leave(" = -ENOBUFS");
> +		return -ENOBUFS;
> +	}
> +
> +	/* not supposed to use this for indexes */
> +	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
> +
> +	/* prevent the file from being uncached whilst we access it and exclude
> +	 * read and write attempts on pages
> +	 */
> +	down_write(&cookie->sem);
> +
> +	ret = -ENOBUFS;
> +	if (!hlist_empty(&cookie->backing_objects)) {
> +		/* get and pin the backing object */
> +		object = hlist_entry(cookie->backing_objects.first,
> +				     struct fscache_object, cookie_link);
> +
> +		if (test_bit(FSCACHE_IOERROR, &object->cache->flags))
> +			goto out;
> +
> +		if (!object->cache->ops->pin_object) {
> +			ret = -EOPNOTSUPP;
> +			goto out;
> +		}
> +
> +		/* prevent the cache from being withdrawn */
> +		if (down_read_trylock(&object->cache->withdrawal_sem)) {

trylock is often a sign that something is mucked up.  A comment describing
why it is needed is always appropriate.


> +			if (object->cache->ops->grab_object(object)) {
> +				/* ask the cache to honour the operation */
> +				ret = object->cache->ops->pin_object(object);
> +
> +				object->cache->ops->put_object(object);
> +			}
> +
> +			up_read(&object->cache->withdrawal_sem);
> +		}
> +	}
> +
> +out:
> +	up_write(&cookie->sem);
> +	_leave(" = %d", ret);
> +	return ret;
> +
> +} /* end __fscache_pin_cookie() */
> +
> +EXPORT_SYMBOL(__fscache_pin_cookie);
> +
> +/*****************************************************************************/
> +/*
> + * unpin an object into the cache
> + */
> +void __fscache_unpin_cookie(struct fscache_cookie *cookie)
> +{
> +	struct fscache_object *object;
> +	int ret;
> +
> +	_enter("%p", cookie);
> +
> +	if (hlist_empty(&cookie->backing_objects)) {
> +		_leave(" [no obj]");
> +		return;
> +	}
> +
> +	/* not supposed to use this for indexes */
> +	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
> +
> +	/* prevent the file from being uncached whilst we access it and exclude
> +	 * read and write attempts on pages
> +	 */
> +	down_write(&cookie->sem);
> +
> +	ret = -ENOBUFS;
> +	if (!hlist_empty(&cookie->backing_objects)) {
> +		/* get and unpin the backing object */
> +		object = hlist_entry(cookie->backing_objects.first,
> +				     struct fscache_object, cookie_link);
> +
> +		if (test_bit(FSCACHE_IOERROR, &object->cache->flags))
> +			goto out;
> +
> +		if (!object->cache->ops->unpin_object)
> +			goto out;
> +
> +		/* prevent the cache from being withdrawn */
> +		if (down_read_trylock(&object->cache->withdrawal_sem)) {

Ditto.

> +			if (object->cache->ops->grab_object(object)) {
> +				/* ask the cache to honour the operation */
> +				object->cache->ops->unpin_object(object);
> +
> +				object->cache->ops->put_object(object);
> +			}
> +
> +			up_read(&object->cache->withdrawal_sem);
> +		}
> +	}
> +
> +out:
> +	up_write(&cookie->sem);
> +	_leave("");
> +
> +} /* end __fscache_unpin_cookie() */
> +
>
>...
>
> +/*
> + * debug tracing
> + */
> +#define dbgprintk(FMT,...) \
> +	printk("[%-6.6s] "FMT"\n",current->comm ,##__VA_ARGS__)
> +#define _dbprintk(FMT,...) do { } while(0)
> +
> +#define kenter(FMT,...)	dbgprintk("==> %s("FMT")",__FUNCTION__ ,##__VA_ARGS__)
> +#define kleave(FMT,...)	dbgprintk("<== %s()"FMT"",__FUNCTION__ ,##__VA_ARGS__)
> +#define kdebug(FMT,...)	dbgprintk(FMT ,##__VA_ARGS__)
> +
> +#define kjournal(FMT,...) _dbprintk(FMT ,##__VA_ARGS__)
> +
> +#define dbgfree(ADDR)  _dbprintk("%p:%d: FREEING %p",__FILE__,__LINE__,ADDR)

That's your fourth implementation of kenter().  Maybe we
need <linux/dhowells.h>?

> --- /dev/null
> +++ b/fs/fscache/fsdef.c
> @@ -0,0 +1,113 @@
> +/* fsdef.c: filesystem index definition
> + *
> + * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include "fscache-int.h"
> +
> +static uint16_t fscache_fsdef_netfs_get_key(const void *cookie_netfs_data,
> +					    void *buffer, uint16_t bufmax);
> +
> +static uint16_t fscache_fsdef_netfs_get_aux(const void *cookie_netfs_data,
> +					    void *buffer, uint16_t bufmax);

u16 would be preferred.

> new file mode 100644
> index 0000000..613c3b1
> --- /dev/null
> +++ b/fs/fscache/main.c
> @@ -0,0 +1,150 @@
> +/* main.c: general filesystem caching manager
> + *
> + * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/completion.h>
> +#include <linux/slab.h>
> +#include "fscache-int.h"
> +
> +int fscache_debug = 0;

unneeded initialisation

> +/*****************************************************************************/
> +/*
> + * initialise the fs caching module
> + */
> +static int fscache_init(void)

__init?

> +/*****************************************************************************/
> +/*
> + * release the ktype
> + */
> +static void fscache_ktype_release(struct kobject *kobject)
> +{
> +} /* end fscache_ktype_release() */

Don't empty kobject release() functions upset Greg?


> +#if 0
> +void __cyg_profile_func_enter (void *this_fn, void *call_site)
> +__attribute__((no_instrument_function));
> +
> +void __cyg_profile_func_enter (void *this_fn, void *call_site)
> +{
> +       asm volatile("  movl    %%esp,%%edi     \n"
> +                    "  andl    %0,%%edi        \n"
> +                    "  addl    %1,%%edi        \n"
> +                    "  movl    %%esp,%%ecx     \n"
> +                    "  subl    %%edi,%%ecx     \n"
> +                    "  shrl    $2,%%ecx        \n"
> +                    "  movl    $0xedededed,%%eax     \n"
> +                    "  rep stosl               \n"
> +                    :
> +                    : "i"(~(THREAD_SIZE-1)), "i"(sizeof(struct thread_info))
> +                    : "eax", "ecx", "edi", "memory", "cc"
> +                    );
> +}
> +
> +void __cyg_profile_func_exit(void *this_fn, void *call_site)
> +__attribute__((no_instrument_function));
> +
> +void __cyg_profile_func_exit(void *this_fn, void *call_site)
> +{
> +       asm volatile("  movl    %%esp,%%edi     \n"
> +                    "  andl    %0,%%edi        \n"
> +                    "  addl    %1,%%edi        \n"
> +                    "  movl    %%esp,%%ecx     \n"
> +                    "  subl    %%edi,%%ecx     \n"
> +                    "  shrl    $2,%%ecx        \n"
> +                    "  movl    $0xdadadada,%%eax     \n"
> +                    "  rep stosl               \n"
> +                    :
> +                    : "i"(~(THREAD_SIZE-1)), "i"(sizeof(struct thread_info))
> +                    : "eax", "ecx", "edi", "memory", "cc"
> +                    );
> +}
> +#endif

Removeable?

> diff --git a/fs/fscache/page.c b/fs/fscache/page.c
> new file mode 100644
> index 0000000..b197be7
> --- /dev/null
> +++ b/fs/fscache/page.c
> @@ -0,0 +1,548 @@
> +/* page.c: general filesystem cache cookie management
> + *
> + * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/fscache-cache.h>
> +#include <linux/buffer_head.h>
> +#include <linux/pagevec.h>
> +#include "fscache-int.h"
> +
> +/*****************************************************************************/
> +/*
> + * set the data file size on an object in the cache
> + */
> +int __fscache_set_i_size(struct fscache_cookie *cookie, loff_t i_size)
> +{
> +	struct fscache_object *object;
> +	int ret;
> +
> +	_enter("%p,%llu,", cookie, i_size);
> +
> +	if (hlist_empty(&cookie->backing_objects)) {
> +		_leave(" = -ENOBUFS");
> +		return -ENOBUFS;
> +	}
> +
> +	/* not supposed to use this for indexes */
> +	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
> +
> +	/* prevent the file from being uncached whilst we access it and exclude
> +	 * read and write attempts on pages
> +	 */
> +	down_write(&cookie->sem);
> +
> +	ret = -ENOBUFS;
> +	if (!hlist_empty(&cookie->backing_objects)) {
> +		/* get and pin the backing object */
> +		object = hlist_entry(cookie->backing_objects.first,
> +				     struct fscache_object, cookie_link);
> +
> +		if (test_bit(FSCACHE_IOERROR, &object->cache->flags))
> +			goto out;
> +
> +		/* prevent the cache from being withdrawn */
> +		if (object->cache->ops->set_i_size &&
> +		    down_read_trylock(&object->cache->withdrawal_sem)

another trylock.

> +		    ) {
> +			if (object->cache->ops->grab_object(object)) {
> +				/* ask the cache to honour the operation */
> +				ret = object->cache->ops->set_i_size(object,
> +								     i_size);
> +
> +				object->cache->ops->put_object(object);
> +			}
> +
> +			up_read(&object->cache->withdrawal_sem);
> +		}
> +	}
> +
> +out:
> +	up_write(&cookie->sem);
> +	_leave(" = %d", ret);
> +	return ret;
> +
> +} /* end __fscache_set_i_size() */
> +
> +EXPORT_SYMBOL(__fscache_set_i_size);
> +
> +/*****************************************************************************/
> +/*
> + * reserve space for an object
> + */
> +int __fscache_reserve_space(struct fscache_cookie *cookie, loff_t size)
> +{
> +	struct fscache_object *object;
> +	int ret;
> +
> +	_enter("%p,%llu,", cookie, size);
> +
> +	if (hlist_empty(&cookie->backing_objects)) {
> +		_leave(" = -ENOBUFS");
> +		return -ENOBUFS;
> +	}
> +
> +	/* not supposed to use this for indexes */
> +	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
> +
> +	/* prevent the file from being uncached whilst we access it and exclude
> +	 * read and write attempts on pages
> +	 */
> +	down_write(&cookie->sem);
> +
> +	ret = -ENOBUFS;
> +	if (!hlist_empty(&cookie->backing_objects)) {
> +		/* get and pin the backing object */
> +		object = hlist_entry(cookie->backing_objects.first,
> +				     struct fscache_object, cookie_link);
> +
> +		if (test_bit(FSCACHE_IOERROR, &object->cache->flags))
> +			goto out;
> +
> +		if (!object->cache->ops->reserve_space) {
> +			ret = -EOPNOTSUPP;
> +			goto out;
> +		}
> +
> +		/* prevent the cache from being withdrawn */
> +		if (down_read_trylock(&object->cache->withdrawal_sem)) {

and another.

> +			if (object->cache->ops->grab_object(object)) {
> +				/* ask the cache to honour the operation */
> +				ret = object->cache->ops->reserve_space(object,
> +									size);
> +
> +				object->cache->ops->put_object(object);
> +			}
> +
> +			up_read(&object->cache->withdrawal_sem);
> +		}
> +	}
> +
> +out:
> +	up_write(&cookie->sem);
> +	_leave(" = %d", ret);
> +	return ret;
> +
> +} /* end __fscache_reserve_space() */
> +
>
> ...
>
> +		if (down_read_trylock(&object->cache->withdrawal_sem)) {
> +		if (down_read_trylock(&object->cache->withdrawal_sem)) {
> +		if (down_read_trylock(&object->cache->withdrawal_sem)) {
> +		if (down_read_trylock(&object->cache->withdrawal_sem)) {
> +		if (down_read_trylock(&object->cache->withdrawal_sem)) {
> +		if (down_read_trylock(&object->cache->withdrawal_sem)) {
> +		if (down_read_trylock(&object->cache->withdrawal_sem)) {

more.

> +
> +/* find the parent index object for a object */
> +static inline
> +struct fscache_object *fscache_find_parent_object(struct fscache_object *object)
> +{
> +	struct fscache_object *parent;
> +	struct fscache_cookie *cookie = object->cookie;
> +	struct fscache_cache *cache = object->cache;
> +	struct hlist_node *_p;
> +
> +	hlist_for_each_entry(parent, _p,
> +			     &cookie->parent->backing_objects,
> +			     cookie_link
> +			     ) {
> +		if (parent->cache == cache)
> +			return parent;
> +	}
> +
> +	return NULL;
> +}

Large?

> +#endif /* _LINUX_FSCACHE_CACHE_H */
> diff --git a/include/linux/fscache.h b/include/linux/fscache.h
> new file mode 100644
> index 0000000..8aa464b
> --- /dev/null
> +++ b/include/linux/fscache.h
> @@ -0,0 +1,484 @@
> +/* fscache.h: general filesystem caching interface
> + *
> + * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef _LINUX_FSCACHE_H
> +#define _LINUX_FSCACHE_H
> +
> +#include <linux/config.h>
> +#include <linux/fs.h>
> +#include <linux/list.h>
> +#include <linux/pagemap.h>
> +#include <linux/pagevec.h>
> +
> +#ifdef CONFIG_FSCACHE_MODULE
> +#define CONFIG_FSCACHE
> +#endif

Defining symbols which are owned by the Kconfig system isn't very nice.

> +
> +/*
> + * request a page be stored in the cache
> + * - this request may be ignored if no cache block is currently allocated, in
> + *   which case it:
> + *   - returns -ENOBUFS
> + * - if a cache block was already allocated:
> + *   - a BIO will be dispatched to write the page (end_io_func will be called
> + *     from the completion function)
> + *   - returns 0
> + */
> +#ifdef CONFIG_FSCACHE
> +extern int __fscache_write_page(struct fscache_cookie *cookie,
> +				struct page *page,
> +				fscache_rw_complete_t end_io_func,
> +				void *end_io_data,
> +				gfp_t gfp);

hm.  I tend to find it better for functions to be documented at the
definition site, not at the declaration site.  I don't expect people even
think to go looking in a header file to learn about the function which
they're presently looking at.


