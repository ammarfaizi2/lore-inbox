Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267402AbUGNPXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbUGNPXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 11:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUGNPXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 11:23:04 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:26809 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267402AbUGNPW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 11:22:58 -0400
Date: Wed, 14 Jul 2004 20:52:35 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040714152235.GA5956@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714082621.GA4291@in.ibm.com> <20040714142614.GA15742@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714142614.GA15742@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 07:26:14AM -0700, Greg KH wrote:
> On Wed, Jul 14, 2004 at 01:56:22PM +0530, Dipankar Sarma wrote:
> > Well, the kref has the same get/put race if used in a lock-free
> > look-up. When you do a kref_get() it is assumed that another
> > cpu will not see a 1-to-0 transition of the reference count.
> 
> You mean kref_put(), right?

No, I meant kref_get(). See below.

> > If that indeed happens, ->release() will get invoked more
> > than once for that object which is bad.
> 
> As kref_put() uses a atomic_t, how can that transistion happen twice?
> 
> What can happen is kref_get() and kref_put() can race if the last
> kref_put() happens at the same time that kref_get().  But that is solved
> by having the caller guarantee that this can not happen (see my 2004 OLS
> paper for more info about this.)

Yes, and how do the callers guarantee that ? Using a lock, right ?
What Kiran's patch does is to allow those callers to use lock-free
algorithms. Let's look at the race -

---------------------------------------------------------------
                                                                                
CPU #0                                 CPU #1
------                                 ------
                                                                                
                                 my_put() from a user who did my_lookup() ...
                                                                                
                                 [ ->count is 1 ]
                                                                                
In my_lookup() ...               atomic_dec_and_test(&m->count)
                                                                                
                                 [ ->count is 0 ]
m = my_get(my_list[i]);
                                                                                
[ ->count is 1 ]                 call_rcu(&m->head, free, m);
                                                                                
return m;
                                                                                
[This CPU can now context
 switch and allow RCU to
 proceed]
                                                                                
                                 free(m);
                                                                                
Somebody dereferences m and
invalid memory reference
---------------------------------------------------------------

This can happen if my_lookup() is lock-free.

> > The other issue is that there are many refcounted data structures
> > like dentry, dst_entry, file etc. that do not use kref.
> 
> At this time, sure.  But you could always change that :)
> (and yes, to do so, we can always shrink the size of struct kref if
> really needed...)

How are you going to shrink it ? You need the ->release() method
and that is a nice way for drivers to get rid of objects.

> 
> > If everybody were to use kref, we could possibly apply Kiran's
> > lock-free extensions to kref itself and be done with it.
> 
> Ok, sounds like a plan to me.  Having 2 refcount implementations in the
> kernel that work alike, yet a bit different, is not acceptable.  Please
> rework struct kref to do this.

And I suspect that Andrew thwak me for trying to increase dentry size :)
Anyway, the summary is this - Kiran is not trying to introduce
a new refcounting API. He is just adding lock-free support from
an existing refcounting mechanism that is used in VFS. If kref users need to do
lock-free lookup, sure we should add it to kref_xxx APIs also.

> > Until then, we need the lock-free refcounting support from non-kref
> > refcounting objects.
>
> We've lived without it until now somehow :)

Actually, we already use lock-free refcounting in route cache, dcache. In those
cases, we work around this race using a different algorithm.

Thanks
Dipankar
