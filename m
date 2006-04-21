Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWDUOQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWDUOQW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWDUOQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:16:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33218 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750732AbWDUOQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:16:20 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060420174622.6d7390d6.akpm@osdl.org> 
References: <20060420174622.6d7390d6.akpm@osdl.org>  <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> <20060420165937.9968.57149.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       sct@redhat.com, aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] FS-Cache: Generic filesystem caching facility 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 21 Apr 2006 15:15:49 +0100
Message-ID: <18005.1145628949@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Interesting.  Perhaps a comment in there?

Yep.  It might even be worth making the actual check in linux/slab.h.

> We already did an up_read().

Yep.  Also the initialisation was done on the wrong variable (tag not
xtag)... which only worked because list_for_each_entry() always leaves a valid
pointer in tag.

> We have kmem_cache_zalloc() now.

It's not in the NFS tree I've just pulled.  Of course, git may be being a
complete git again.  I blame the original author:-)

> This looks livelockable.

How so?  The bit at the top of the function makes sure that we can't get any
new objects.

> > +	cache->ops->unlock_object(object);
> 
> I assume ->lock_object() provides the locking for the hlist_add_head()?

Half of it...  Cookie lookup and withdrawal has to deal with the interaction
between two locks:

 (1) The cookie lock.  This is taken first when approached from the netfs side.

 (2) The object lock.  This is taken first when approached from the cache side.

The cookie lock is superior to the netfs lock, and fscache_withdraw_object()
has to do lock reordering when withdrawing a cache from the system.

fscache_lookup_object() - to which you refer - must be called with the cookie
already write-locked.

> > +	down_write(&cookie->sem);
> > +	down_read(&cookie->parent->sem);
> 
> That's a surprising locking order.  Normally things are parent-first.

But the operation starts from the child cookie.

The order I've defined is that if both a cookie and its parent already exist,
then you must get the lock on the child before the lock on the parent if you
want both.

Lookup is okay, since the new cookie doesn't exist to the rest of the system
until we've finished, and should we need to walk up the index tree
instantiating indices, the locking is in the right order to just do that.

> > +		/* prevent the cache from being withdrawn */
> > +		if (down_read_trylock(&object->cache->withdrawal_sem)) {
> 
> trylock is often a sign that something is mucked up.  A comment describing
> why it is needed is always appropriate.

In this case, it's not something mucked up.  The only thing that write-locks
cache->withdrawal_sem is the fscache_withdraw_cache(), and that then prevents
any further operations on that cache succeeding.

Obviously, before we withdraw the cache, down_read_trylock() will always
succeed, and after we withdraw the cache it will always fail; but not only
that, _whilst_ there's an operation in progress, the withdrawal will be made to
wait because that does down_write() *not* down_write_trylock().

I wonder if I should write some docs on the locking procedures used by
FS-Cache.

> That's your fourth implementation of kenter().  Maybe we
> need <linux/dhowells.h>?

:-)

Maybe I should move my debugging macros into include/linux, but then everyone
else would complain if their own versions weren't put in there, or would
complain if they were forced to use mine.

> u16 would be preferred.

As I recall, Linus said something like that uint16_t and co are fine in one's
own interfaces.  I did actually ask him about that.

u16 should die really, IMO.

> > +int fscache_debug = 0;
> 
> unneeded initialisation

Yep.

> > +static int fscache_init(void)
> 
> __init?

Yep.

> Don't empty kobject release() functions upset Greg?

I hope so... then he might improve his docs:-)

The function would seem to be mandatory, but there really isn't anything for it
to do, since the object is static:-/

> Removeable?

Yeah.  It's handy to have around for debugging, but it's very arch specific,
and can be added back later easily enough.

> Large?

Depends how you define "large".

It doesn't actually produce very much code.

> Defining symbols which are owned by the Kconfig system isn't very nice.

Kconfig is still broken:

	warthog>grep -r CONFIG_FSCACHE include/linux/autoconf.h 
	#define CONFIG_FSCACHE_MODULE 1
	warthog>

Modules that might depend on fscache need to know that it's there, and having
to double up every #if to detect both is stupid.

Would you suggest then:

	#if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
	#define FSCACHE_AVAILABLE 1
	#endif

> hm.  I tend to find it better for functions to be documented at the
> definition site, not at the declaration site.  I don't expect people even
> think to go looking in a header file to learn about the function which
> they're presently looking at.

Two points:

 (1) The function they'll be looking for isn't in a .c file.

 (2) They *should* be looking in Documentation/ where all the kernel's
     interface functions are of course documented.  They will find the
     documentation for the FS-Cache interfaces there.  I'll add obvious banners
     to the tops of the header files telling them where to look.  I can even
     add them to the .c files, I suppose.

     Now I admit that I haven't added docs for get_empty_filp(),
     dentry_open_kernel() and suchlike because there's nowhere to actually add
     them yet.

David
