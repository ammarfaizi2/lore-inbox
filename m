Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVCVRtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVCVRtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVCVRtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:49:19 -0500
Received: from digitalimplant.org ([64.62.235.95]:1208 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261473AbVCVRtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:49:08 -0500
Date: Tue, 22 Mar 2005 09:48:56 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, "" <greg@kroah.com>
Subject: Re: [6/9] [RFC] Steps to fixing the driver model locking
In-Reply-To: <20050322100952.GA15582@infradead.org>
Message-ID: <Pine.LNX.4.50.0503220903040.16361-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0503211245530.20647-100000@monsoon.he.net>
 <20050322100952.GA15582@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Mar 2005, Christoph Hellwig wrote:

> On Mon, Mar 21, 2005 at 12:48:47PM -0800, Patrick Mochel wrote:
> >
> > ChangeSet@1.2235, 2005-03-21 11:45:16-08:00, mochel@digitalimplant.org
> >   [klist] Add initial implementation of klist helpers.
>
> >   This klist interface provides a couple of structures that wrap around
> >   struct list_head to provide explicit list "head" (struct klist) and
> >   list "node" (struct klist_node) objects. For struct klist, a spinlock
> >   is included that protects access to the actual list itself.
>
> Not sure this is a good idea.  Usually you want a lock protect slightly
> more than just list operations, e.g. refcounting of objects in list,
> some short-term manipulations, etc.

The above statement could be a little more explicit. The klist is the sole
object in question. The spinlock protects the klist object itself,
including manipulation of the klist nodes and refcounting of the nodes on
the list. At some point, more fields could be added to struct klist which
may need protection.

That protection could be provided by the spinlock, but it's possible that
those fields may not need to be synchronized with manipulation of the list
or the refcounts, which may warrant a separate lock.

Note that some people (e.g. ex-PTX people that I've dealt with before)
believed that every field should have a separate lock. I definitely don't
follow that mantra, especially since we have refcounts to provide some of
the protection that their locks would. But, where it makes sense, we need
to localize the use, which is why the klist gets its own lock.

> >   struct
> >   klist_node provides a pointer to the klist that owns it and a kref
> >   reference count that indicates the number of current users of that node
> >   in the list.
> >
> >   The entire point is to provide an interface for iterating over a list
> >   that is safe and allows for modification of the list during the
> >   iteration (e.g. insertion and removal), including modification of the
> >   current node on the list.
> >
> >   It works using a 3rd object type - struct klist_iter - that is declared
> >   and initialized before an iteration. klist_next() is used to acquire the
> >   next element in the list. It returns NULL if there are no more items.
> >   This klist interface provides a couple of structures that wrap around
> >   struct list_head to provide explicit list "head" (struct klist) and
> >   list "node" (struct klist_node) objects. For struct klist, a spinlock
> >   is included that protects access to the actual list itself. struct
> >   klist_node provides a pointer to the klist that owns it and a kref
> >   reference count that indicates the number of current users of that node
> >   in the list.
>
> Yikes.  It's really not that hard to get traversal of a refcounted list
> right, and you're adding lots of obsfucation over that rather easy thing.
> The driver model and kfoo stuff already got us lots of layer of obsfucation,
> but we should really stop at some point where it makes the underlying
> operations much more complicated.

There is definitely some unnecessary obfuscation in the kobject, etc code.
I'd like to see a lot of that cleaned up, and this is one step along those
lines, even if may seem to only add more code ATM.

This patch solidifies the notion that list heads and list nodes are
autonomous objects, not just in relation to each other, but also to the
larger objects that contain them.  The refcounts added are to mediate
access to the greater object via 1 particular list that it's contained on.
They don't control the lifetime of the (greater) object itself per se, but
rather its visibility to a particular set.

It is possible to add the same functionality without encapsulating them in
these new object types (adding locks for each list head and refcounts for
each list node), but this a) saves many keystrokes, and b) makes the
resulting code a lot simpler by using an iterator.

> >   There are primitives for adding and removing nodes to/from a klist.
> >   When deleting, klist_del() will simply decrement the reference count.
> >   Only when the count goes to 0 is the node removed from the list.
>
> This sounds rather odd, and doesn't make much sense to me.  In all cases
> I've seen you want to disallow lookup imediately (list_del), which is
> completly separate from object lifetime rules.

The object in question is the list node, which has its own refcount. It's
lifetime is its existence on the list. Ending its lifetime is removing it
from the list, which one would only want to do when that list node is not
being accessed. In itself, it has nothing to do with the lifetime of the
greater object.


Thanks for the comments. I hope this helps,


	Pat
