Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVC1Tsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVC1Tsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVC1Tsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:48:35 -0500
Received: from ida.rowland.org ([192.131.102.52]:8196 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262052AbVC1TsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:48:07 -0500
Date: Mon, 28 Mar 2005 14:48:03 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@digitalimplant.org>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.50.0503280819480.28120-100000@monsoon.he.net>
Message-ID: <Pine.LNX.4.44L0.0503281417370.1185-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005, Patrick Mochel wrote:

> It's important when removing a containing object's knode from the list
> when that object is about to be freed. This happens during both device and
> driver unregistration. In most cases, the removal operation will return
> immediately. When it doesn't, it means another thread is using that
> particular knode, which means its imperative that the containing object
> not be freed.
> 
> Do you have suggestions about an alternative (with code)?

Here's something a little better than pseudocode but not as good as a 
patch... :-)

Consider adding to struct klist two new fields:

	int	k_offset_to_containers_kref;
	void	(*k_containers_kref_release)(struct kref *);

To fill the first field in correctly requires that klist creation use a
macro; the details are unimportant.  What is important is that during
klist_node_init you add:

	struct kref *containers_kref = (struct kref *) ((void *) n +
			k->k_offset_to_containers_kref);

	kref_get(containers_kref);

and in klist_release you add:

	struct kref *containers_kref = (struct kref *) ((void *) n +
			n->n_klist->k_offset_to_containers_kref);

	kref_put(containers_kref, n->n_klist->k_containers_kref_release);

(Actually this conflicts with my earlier suggestion about removing 
n->n_klist.  Oh well... nothing's perfect.)

In fact the kref_put() should take the place of the call to complete().  
This scheme assumes that the container object does contain a kref, but 
this is true for all the containers in the driver model.


> Good point. It's trivial to add an atomic flag (.n_attached) which is
> checked during an iteration. This can also be used for the
> klist_node_attached() function that I posted a few days ago (and you may
> have missed).

There's no need for the flag to be atomic, since it's only altered while 
the klist's lock is held.


> It's assumed that the controlling subsystem will handle lifetime-based
> reference counting for the containing objects. If you can point me to a
> potential usage where this assumption would get us into trouble, I'd be
> interested in trying to work arond this.

It's not that you get into trouble; it's that you're forced to wait for 
klist_node.n_removed when you shouldn't have to.  To put it another way, 
one of the big advantages of the refcounting approach is that it allows 
you to avoid blocking on deallocations -- the deallocation happens 
automatically when the last reference is dropped.  Your code loses this 
advantage; it's not the refcounting way.

If you replace the struct completion with the offset to the container's
kref and make the klist_node hold a reference to its container, as
described above, then this unpleasantness can go away.

Alan Stern

