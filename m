Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUGNI6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUGNI6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 04:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267328AbUGNI6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 04:58:55 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:15573 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267327AbUGNI6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 04:58:51 -0400
Date: Wed, 14 Jul 2004 14:27:58 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040714085758.GA4165@obelix.in.ibm.com>
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714070700.GA12579@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 12:07:00AM -0700, Greg KH wrote:
> On Wed, Jul 14, 2004 at 10:23:50AM +0530, Ravikiran G Thirumalai wrote:
> > 
> > The attatched patch provides infrastructure for refcounting of objects
> > in a rcu protected collection.
> 
> This is really close to the kref implementation.  Why not just use that
> instead?

Close, but not the same.  I just had a quick look at krefs.
Actually, this refrerence count infrastructure I am proposing is not for 
traditional refcounting.  This is for refcounting of elemnts of a list
or array (collection) which can be 'read' in a lock free manner.

For ex. With traditional refcounting, you can have 

1.                                  2.
add()                               search_and_reference()
{                                   {
    alloc_object                            read_lock(&list_lock);
    ...                                     search_for_element
    refcount_init(&el->rc)                  refcount_get(&el->rc);
    write_lock(&list_lock);                 ...
    add_element                             read_unlock(&list_lock);
    ...                                     ...
    write_unlock(&list_lock);       }
}

3.                                  4.
release_referenced()                delete()
{                                   {
    ...                             write_lock(&list_lock);
    if (refcount_put(&el->rc))      ...
            start_cleanup_object    ...
            free_object             delete_element
    ...                             write_unlock(&list_lock);
}                                   ...
                                    if (refcount_put(&el->rc))
                                            start_cleanup_object
                                            free_object
                                    }

add() puts the refcounted element into the system with the list_lock
taken for write, search_and_reference() takes the list_lock for read
and gets the refcount.  Now if the list was a read mostly kind, then
we could replace the list_lock rw lock with a spinlock,
serialise updates to the list with the spinlock taken (in the add())
and use rcu_read_lock() and rcu_read_unlock() on the reader side
(search_and_reference()) replacing the read_locks in 2. above. 

But, with rcu, search and reference could see stale elements, that is
elements which have been taken off the list from delete(). Using call_rcu
to free the object from release_referenced() (free_object in 3.) will defer 
freeing, so that &el memory location above is not freed 'til the reader 
comes out of rcu_read_lock protected code, _but_ the 
search_and_reference thread could potentially get a reference to a 
deleted list element.  Hence, under lockfree circumstances, just an 
atomic_inc to the refcount is not sufficient.  
We do:

	...
	c = atomic_read(&rc->count);
	while ( c && (old = cmpxchg(&rc->count.counter, c, c+1)) != c)
		c = old;
	return c;


which is abstracted out as refcount_get_rcu()

Hence, in the example above, search_and_reference would look like

search_and_reference()
{
    rcu_read_lock();
    search_for_element
    if (!refcount_get_rcu(&el->rc)) {
            rcu_read_unlock();
            return FAIL;
    }
    ...
    ...
    rcu_read_unlock();
}

Hope that clears things up.

> 
> Oh, and I think you need to use atomic_set() instead of initializing the
> atomic_t by hand.

I have used atomic_set for the case where arch has cmpxchg.  But for 
arches lacking cmpxchg, I need to use hashed spinlocks to implement 
the ref_count_get_rcu.
No point in having more atomic operations when I hold spinlocks.  Admittedly,
might be a bit yucky to assume atomic_t internals, but it is just one header
file :) <ducks>

Thanks,
Kiran
