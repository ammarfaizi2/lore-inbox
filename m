Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbUB1ECh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 23:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbUB1ECh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 23:02:37 -0500
Received: from netrider.rowland.org ([192.131.102.5]:18191 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S263113AbUB1ECe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 23:02:34 -0500
Date: Fri, 27 Feb 2004 23:02:34 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about (or bug in?) the kobject implementation
Message-ID: <Pine.LNX.4.44L0.0402272233330.4063-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Greg KH wrote:

> Seriously, once kobject_del() is called, you can't safely call
> kobject_get() anymore on that object.
> 
> If you can think of a way we can implement this in the code to prevent
> people from doing this, please send a patch.  We've been getting by
> without such a "safeguard" so far...

The problem is unsolvable.  Let me explain...

We're actually discussing two different questions here.

    A.	Is it okay to call kobject_add() after calling kobject_del() -- 
	this was my original question.

    B.	Can we prevent people from doing kobject_get() after the kobject's
	refcount has dropped to 0?

Your earlier response amounted to saying that A isn't good because it
might cause B to happen; once kobject_del() has returned it's possible
that the refcount is 0.  But this begs the real question.  Suppose we
_know_ that the refcount isn't 0, say because earlier we did an unmatched
kobject_get().  Under those circumstances should it be legal to call
kobject_add() after calling kobject_del()?  This is question A'.


Question B can be divided into two subcases.

    B1.	The code calling kobject_get() knows that the kobject hasn't been
	deallocated yet.  For example, it might be the cleanup routine 
	itself calling kobject_get().

Such a thing is legal in Java, but you probably don't want to sanction 
such pranks in the driver model.  So let's forget about B1.  Your big 
concern really seems to be:

    B2.	Everything else; the code calling kobject_get() doesn't know 
	whether the kobject has been deallocated.

This really is a programming error.  It means that kobject_get() has been 
passed a possibly stale pointer.  Ipso facto, the call to kobject_put() 
that decremented the refcount to 0 was made too early, while there were 
still active pointers to the kobject floating around.

It's impossible to prevent people from making programming errors or
dereferencing stale pointers.  It doesn't matter _what_ code you put in
kobject_get() -- it will crash when given a pointer to a kobject whose
cleanup routine has already run and deallocated the storage.

The best you can do is call people's attention to such errors and fail the
operation gracefully whenever possible (i.e., when it doesn't generate an
addressing error).  My personal choice would be to change kobject_get() as
follows:

struct kobject * kobject_get(struct kobject * kobj)
{
	if (kobj) {
		if (atomic_read(&kobj->refcount) == 0) {
			WARN_ON(1);
			return NULL;
		}
		atomic_inc(&kobj->refcount);
	}
	return kobj;
}

I think that's about the best you can do.

And what's the answer to A'?

Alan Stern

